#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"
parse_context_args "$@"
set -- "${SLD_POSITIONAL_ARGS[@]}"

slice_name="${1:-}"
[[ -n "$slice_name" ]] || usage_error "uso: $(basename "$0") <slice-name>"

require_file "$SLD_STATE_ROOT/current-track"
current_track_ref="$(tr -d '\n' < "$SLD_STATE_ROOT/current-track")"
[[ -n "$current_track_ref" ]] || usage_error "arquivo current-track vazio em $SLD_STATE_ROOT"

track_dir="$REPO_ROOT/$current_track_ref"
require_dir "$track_dir"

slice_rel="slices/$slice_name"
slice_dir="$track_dir/$slice_rel"
require_dir "$slice_dir"
require_file "$slice_dir/slice.md"

printf '%s\n' "$slice_rel" > "$track_dir/.current-slice"
printf '%s\n' "$slice_name"
