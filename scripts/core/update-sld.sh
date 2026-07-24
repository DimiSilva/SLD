#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${SLD_TARGET_DIR:-$(pwd)}"
SLD_DIR="$TARGET_DIR/.sld"
SOURCE_DIR="${SLD_SOURCE_DIR:-}"
TEMP_DIR=""
cleanup() { [[ -z "$TEMP_DIR" || ! -d "$TEMP_DIR" ]] || rm -rf "$TEMP_DIR"; }
trap cleanup EXIT
has_source_tree() { [[ -f "$SOURCE_DIR/manifest.md" && -d "$SOURCE_DIR/scripts" && -d "$SOURCE_DIR/skills" && -d "$SOURCE_DIR/templates" ]]; }

if [[ -z "$SOURCE_DIR" ]]; then SOURCE_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"; fi
if ! has_source_tree; then
  repo="${SLD_GITHUB_REPO:-}"
  ref="${SLD_REF:-main}"
  archive_url="${SLD_ARCHIVE_URL:-}"
  [[ -n "$archive_url" || -n "$repo" ]] || { echo "[erro] informe SLD_SOURCE_DIR, SLD_GITHUB_REPO ou SLD_ARCHIVE_URL" >&2; exit 1; }
  archive_url="${archive_url:-https://github.com/$repo/archive/$ref.tar.gz}"
  TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/sld-update.XXXXXX")"
  archive_file="$TEMP_DIR/source.tar.gz"
  if command -v curl >/dev/null 2>&1; then curl -fsSL "$archive_url" -o "$archive_file"; else wget -qO "$archive_file" "$archive_url"; fi
  tar -xzf "$archive_file" -C "$TEMP_DIR"
  SOURCE_DIR="$(find "$TEMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
fi

mkdir -p "$SLD_DIR"
cp "$SOURCE_DIR/manifest.md" "$SLD_DIR/manifest.md"
rm -rf "$SLD_DIR/scripts" "$SLD_DIR/skills" "$SLD_DIR/templates"
cp -R "$SOURCE_DIR/scripts" "$SLD_DIR/scripts"
cp -R "$SOURCE_DIR/skills" "$SLD_DIR/skills"
cp -R "$SOURCE_DIR/templates" "$SLD_DIR/templates"
find "$SLD_DIR/scripts" -type f -name '*.sh' -exec chmod +x {} +
echo "SLD base updated; config.yaml and customizations preserved."
