#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"

track_name="${1:-}"
[[ -n "$track_name" ]] || usage_error "uso: $(basename "$0") <track-name>"

tracks_root="$(tracks_root_rel)"
track_dir="$REPO_ROOT/$tracks_root/$track_name"
require_dir "$track_dir"
require_file "$track_dir/track.md"

printf '%s/%s\n' "$tracks_root" "$track_name" > "$REPO_ROOT/.sld/current-track"
printf '%s\n' "$track_name"
