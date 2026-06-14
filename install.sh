#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${SLD_TARGET_DIR:-$(pwd)}"
SLD_DIR="$TARGET_DIR/.sld"

tracks_root="${SLD_TRACKS_ROOT:-docs/tracks}"
adrs_root="${SLD_ADRS_ROOT:-docs/adrs}"
guidelines_root="${SLD_GUIDELINES_ROOT:-docs/guidelines}"
examples_root="${SLD_EXAMPLES_ROOT:-docs/examples}"

usage() {
  cat <<'USAGE'
Usage:
  install.sh

Environment:
  SLD_TARGET_DIR=<path>       Target project root. Defaults to current directory.
  SLD_INSTALL_AGENTS=1        Copy AGENTS.md to target root if absent.
  SLD_FORCE=1                 Overwrite AGENTS.md when SLD_INSTALL_AGENTS=1.
  SLD_FORCE_CONFIG=1          Overwrite .sld/config.yaml.
  SLD_TRACKS_ROOT=<path>      Default: docs/tracks.
  SLD_ADRS_ROOT=<path>        Default: docs/adrs.
  SLD_GUIDELINES_ROOT=<path>  Default: docs/guidelines.
  SLD_EXAMPLES_ROOT=<path>    Default: docs/examples.
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

require_source() {
  local path="$1"
  [[ -e "$SOURCE_DIR/$path" ]] || {
    echo "[erro] fonte ausente: $SOURCE_DIR/$path" >&2
    exit 1
  }
}

copy_tree() {
  local from="$1"
  local to="$2"
  rm -rf "$to"
  mkdir -p "$(dirname "$to")"
  cp -R "$from" "$to"
}

require_source "manifest.md"
require_source "scripts"
require_source "skills"
require_source "templates"

mkdir -p "$SLD_DIR"
cp "$SOURCE_DIR/manifest.md" "$SLD_DIR/manifest.md"
copy_tree "$SOURCE_DIR/scripts" "$SLD_DIR/scripts"
copy_tree "$SOURCE_DIR/skills" "$SLD_DIR/skills"
copy_tree "$SOURCE_DIR/templates" "$SLD_DIR/templates"

if [[ ! -e "$SLD_DIR/config.yaml" || "${SLD_FORCE_CONFIG:-0}" == "1" ]]; then
  cat > "$SLD_DIR/config.yaml" <<EOF
version: 1

paths:
  tracks_root: $tracks_root
  adrs_root: $adrs_root
  guidelines_root: $guidelines_root
  examples_root: $examples_root

naming:
  track_pattern: "<unix-timestamp-seconds>-name"
  slice_pattern: "<unix-timestamp-seconds>-name"
EOF
else
  echo "[info] .sld/config.yaml ja existe; mantendo configuracao atual. Use SLD_FORCE_CONFIG=1 para sobrescrever." >&2
fi

touch "$SLD_DIR/current-track"

if [[ -f "$SLD_DIR/config.yaml" ]]; then
  tracks_root="$(awk '/^paths:[[:space:]]*$/{p=1; next} p && /^[^[:space:]]/{p=0} p && /^[[:space:]]+tracks_root:/{sub(/^[^:]+:[[:space:]]*/, ""); print; exit}' "$SLD_DIR/config.yaml")"
  adrs_root="$(awk '/^paths:[[:space:]]*$/{p=1; next} p && /^[^[:space:]]/{p=0} p && /^[[:space:]]+adrs_root:/{sub(/^[^:]+:[[:space:]]*/, ""); print; exit}' "$SLD_DIR/config.yaml")"
  guidelines_root="$(awk '/^paths:[[:space:]]*$/{p=1; next} p && /^[^[:space:]]/{p=0} p && /^[[:space:]]+guidelines_root:/{sub(/^[^:]+:[[:space:]]*/, ""); print; exit}' "$SLD_DIR/config.yaml")"
  examples_root="$(awk '/^paths:[[:space:]]*$/{p=1; next} p && /^[^[:space:]]/{p=0} p && /^[[:space:]]+examples_root:/{sub(/^[^:]+:[[:space:]]*/, ""); print; exit}' "$SLD_DIR/config.yaml")"
fi

mkdir -p "$TARGET_DIR/${tracks_root:-docs/tracks}" "$TARGET_DIR/${adrs_root:-docs/adrs}" "$TARGET_DIR/${guidelines_root:-docs/guidelines}" "$TARGET_DIR/${examples_root:-docs/examples}"

if [[ "${SLD_INSTALL_AGENTS:-0}" == "1" ]]; then
  require_source "AGENTS.md"
  if [[ -e "$TARGET_DIR/AGENTS.md" && "${SLD_FORCE:-0}" != "1" ]]; then
    echo "[info] AGENTS.md ja existe; mantendo arquivo atual. Use SLD_FORCE=1 para sobrescrever." >&2
  else
    cp "$SOURCE_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md"
  fi
fi

find "$SLD_DIR/scripts" -type f -name '*.sh' -exec chmod +x {} +

cat <<EOF
SLD installed:
  framework: $SLD_DIR
  tracks:    $TARGET_DIR/$tracks_root
  adrs:      $TARGET_DIR/$adrs_root
  guidelines:$TARGET_DIR/$guidelines_root
  examples:  $TARGET_DIR/$examples_root
EOF
