#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/_common.sh"

name_input="${1:-}"
[[ -n "$name_input" ]] || usage_error "uso: $(basename "$0") <name>"
custom_root="$(config_get_path "custom_root" || true)"
custom_root="${custom_root:-.sld/custom}"
name_slug="$(slugify "$name_input")"
[[ -n "$name_slug" ]] || usage_error "nome invalido para customizacao"
custom_dir="$REPO_ROOT/$custom_root/$name_slug"
[[ ! -e "$custom_dir" ]] || usage_error "customizacao ja existe: $custom_dir"

mkdir -p "$custom_dir"/{scripts/{track,slice,check},skills,templates,state,tracks,adrs,guidelines,examples}
cat > "$custom_dir/manifest.md" <<EOF
# SLD Custom: $name_slug

Esta customizacao estende a camada base do SLD sem modifica-la.

## Base

- Framework: .sld/manifest.md
- Configuracao base: .sld/config.yaml

## Regras

- Registrar aqui regras especificas desta customizacao.
- Skills especializadas devem apontar para a skill base que estendem.
- Nao alterar arquivos da camada base.
EOF

cat > "$custom_dir/config.yaml" <<EOF
version: 1
custom:
  name: $name_slug
  base_manifest: .sld/manifest.md
  base_config: .sld/config.yaml

paths:
  tracks_root: .sld/custom/$name_slug/tracks
  adrs_root: .sld/custom/$name_slug/adrs
  guidelines_root: .sld/custom/$name_slug/guidelines
  examples_root: .sld/custom/$name_slug/examples
  state_root: .sld/custom/$name_slug/state
  templates_root: .sld/templates

naming:
  track_pattern: "<unix-timestamp-seconds>-name"
  slice_pattern: "<unix-timestamp-seconds>-name"
EOF

cat > "$custom_dir/scripts/run-base.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CUSTOM_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$CUSTOM_DIR/../../.." && pwd)"
base_script="${1:-}"
[[ -n "$base_script" ]] || { echo "uso: run-base.sh <script> [args...]" >&2; exit 1; }
shift

exec "$REPO_ROOT/.sld/scripts/$base_script" \
  --config "$CUSTOM_DIR/config.yaml" \
  --state-root "$CUSTOM_DIR/state" \
  --templates-root "$(if [[ -f "$CUSTOM_DIR/templates/track.md.tpl" && -f "$CUSTOM_DIR/templates/slice.md.tpl" ]]; then printf '%s' "$CUSTOM_DIR/templates"; else printf '%s' "$REPO_ROOT/.sld/templates"; fi)" \
  "$@"
EOF
chmod +x "$custom_dir/scripts/run-base.sh"

create_wrapper() {
  local output="$1"
  local base_script="$2"
  cat > "$output" <<EOF
#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)"
exec "\$SCRIPT_DIR/../run-base.sh" "$base_script" "\$@"
EOF
  chmod +x "$output"
}

create_wrapper "$custom_dir/scripts/track/create-track.sh" "track/create-track.sh"
create_wrapper "$custom_dir/scripts/track/set-current-track.sh" "track/set-current-track.sh"
create_wrapper "$custom_dir/scripts/slice/create-slice.sh" "slice/create-slice.sh"
create_wrapper "$custom_dir/scripts/slice/set-current-slice.sh" "slice/set-current-slice.sh"
create_wrapper "$custom_dir/scripts/check/check-naming.sh" "check/check-naming.sh"
create_wrapper "$custom_dir/scripts/check/check-required-files.sh" "check/check-required-files.sh"

printf '%s\n' "$custom_dir"
