#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"

name_input="${1:-}"
[[ -n "$name_input" ]] || usage_error "uso: $(basename "$0") <name>"

name_slug="$(slugify "$name_input")"
[[ -n "$name_slug" ]] || usage_error "nome invalido para slug"

track_name="$(unix_timestamp_seconds)-$name_slug"
tracks_root="$(tracks_root_rel)"
track_dir="$REPO_ROOT/$tracks_root/$track_name"

if [[ -e "$track_dir" ]]; then
  usage_error "track ja existe: $track_name"
fi

mkdir -p "$track_dir/slices"
: > "$track_dir/learnings.md"

render_template \
  "$REPO_ROOT/.sld/templates/track.md.tpl" \
  "$track_dir/track.md" \
  TRACK_NAME "$track_name"

printf '%s/%s\n' "$tracks_root" "$track_name" > "$REPO_ROOT/.sld/current-track"

printf '%s\n' "$track_name"
