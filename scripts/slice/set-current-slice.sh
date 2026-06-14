#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"

slice_name="${1:-}"
[[ -n "$slice_name" ]] || usage_error "uso: $(basename "$0") <slice-name>"

require_file "$REPO_ROOT/.sld/current-track"
current_track_ref="$(tr -d '\n' < "$REPO_ROOT/.sld/current-track")"
[[ -n "$current_track_ref" ]] || usage_error "arquivo .sld/current-track vazio"

track_dir="$REPO_ROOT/$current_track_ref"
require_dir "$track_dir"

slice_rel="slices/$slice_name"
slice_dir="$track_dir/$slice_rel"
require_dir "$slice_dir"
require_file "$slice_dir/slice.md"

printf '%s\n' "$slice_rel" > "$track_dir/.current-slice"
printf '%s\n' "$slice_name"
