#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SLD_SCRIPTS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$SLD_SCRIPTS_DIR/../.." && pwd)"
SLD_CONFIG_YAML="$REPO_ROOT/.sld/config.yaml"

err() {
  echo "[erro] $*" >&2
}

info() {
  echo "[info] $*" >&2
}

usage_error() {
  err "$*"
  exit 1
}

unix_timestamp_seconds() {
  date +"%s"
}

slugify() {
  local input="${1:-}"
  input="$(printf '%s' "$input" | tr '[:upper:]' '[:lower:]')"
  input="$(printf '%s' "$input" | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g')"
  printf '%s' "$input"
}

is_valid_timestamped_name() {
  local value="${1:-}"
  [[ "$value" =~ ^[0-9]{10}-[a-z0-9]+(-[a-z0-9]+)*$ ]]
}

require_file() {
  local p="${1:-}"
  [[ -f "$p" ]] || usage_error "arquivo obrigatorio nao encontrado: $p"
}

require_dir() {
  local p="${1:-}"
  [[ -d "$p" ]] || usage_error "diretorio obrigatorio nao encontrado: $p"
}

config_get_path() {
  local key="${1:-}"
  [[ -n "$key" ]] || usage_error "chave obrigatoria em config_get_path"

  if [[ ! -f "$SLD_CONFIG_YAML" ]]; then
    return 1
  fi

  awk -v wanted="$key" '
    $0 ~ /^paths:[[:space:]]*$/ { in_paths=1; next }
    in_paths && $0 ~ /^[^[:space:]]/ { in_paths=0 }
    in_paths {
      gsub(/^[[:space:]]+/, "", $0)
      split($0, a, ":")
      k=a[1]
      sub(/:[[:space:]]*.*$/, "", k)
      if (k == wanted) {
        v=$0
        sub(/^[^:]+:[[:space:]]*/, "", v)
        gsub(/[[:space:]]+$/, "", v)
        print v
        exit
      }
    }
  ' "$SLD_CONFIG_YAML"
}

tracks_root_rel() {
  local from_config
  from_config="$(config_get_path "tracks_root" || true)"
  if [[ -n "$from_config" ]]; then
    printf '%s\n' "$from_config"
    return
  fi
  printf 'tracks\n'
}

render_template() {
  local template_file="${1:?template file obrigatorio}"
  local output_file="${2:?output file obrigatorio}"
  shift 2

  require_file "$template_file"

  local content
  content="$(cat "$template_file")"

  while (( "$#" )); do
    local key="$1"
    local value="$2"
    shift 2
    content="${content//\{\{$key\}\}/$value}"
  done

  printf '%s\n' "$content" > "$output_file"
}
