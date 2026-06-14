#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd 2>/dev/null || pwd)"
TARGET_DIR="${SLD_TARGET_DIR:-$(pwd)}"
SLD_DIR="$TARGET_DIR/.sld"
TEMP_DIR=""

tracks_root="${SLD_TRACKS_ROOT:-docs/tracks}"
adrs_root="${SLD_ADRS_ROOT:-docs/adrs}"
guidelines_root="${SLD_GUIDELINES_ROOT:-docs/guidelines}"
examples_root="${SLD_EXAMPLES_ROOT:-docs/examples}"

cleanup() {
  if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
  fi
}
trap cleanup EXIT

usage() {
  cat <<'USAGE'
Usage:
  install.sh
  install.sh <owner/repo>

Environment:
  SLD_TARGET_DIR=<path>       Target project root. Defaults to current directory.
  SLD_GITHUB_REPO=owner/repo   GitHub repository used when running via curl | bash.
  SLD_REF=<ref>                Git ref to download for remote install. Defaults to main.
  SLD_ARCHIVE_URL=<url>        Full tar.gz archive URL. Overrides SLD_GITHUB_REPO/SLD_REF.
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

if [[ -n "${1:-}" && "${1:-}" != -* ]]; then
  SLD_GITHUB_REPO="${SLD_GITHUB_REPO:-$1}"
  shift
fi

has_source_tree() {
  [[ -f "$SOURCE_DIR/manifest.md" && -d "$SOURCE_DIR/scripts" && -d "$SOURCE_DIR/skills" && -d "$SOURCE_DIR/templates" ]]
}

download_remote_source() {
  local archive_url="${SLD_ARCHIVE_URL:-}"
  local ref="${SLD_REF:-main}"

  if [[ -z "$archive_url" ]]; then
    if [[ -z "${SLD_GITHUB_REPO:-}" ]]; then
      cat >&2 <<'EOF'
[erro] fonte local nao encontrada.

Para instalacao remota, informe o repositorio:
  curl -fsSL https://raw.githubusercontent.com/<owner>/<repo>/main/install.sh | SLD_GITHUB_REPO=<owner>/<repo> bash

Ou passe o repo como argumento:
  curl -fsSL https://raw.githubusercontent.com/<owner>/<repo>/main/install.sh | bash -s -- <owner>/<repo>
EOF
      exit 1
    fi
    archive_url="https://github.com/${SLD_GITHUB_REPO}/archive/${ref}.tar.gz"
  fi

  command -v tar >/dev/null 2>&1 || {
    echo "[erro] comando obrigatorio ausente: tar" >&2
    exit 1
  }

  TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/sld-install.XXXXXX")"
  local archive_file="$TEMP_DIR/source.tar.gz"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$archive_url" -o "$archive_file"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$archive_file" "$archive_url"
  else
    echo "[erro] instalacao remota exige curl ou wget" >&2
    exit 1
  fi

  tar -xzf "$archive_file" -C "$TEMP_DIR"
  SOURCE_DIR="$(find "$TEMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"

  if ! has_source_tree; then
    echo "[erro] pacote remoto invalido: manifest/scripts/skills/templates nao encontrados" >&2
    exit 1
  fi
}

if ! has_source_tree; then
  download_remote_source
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
