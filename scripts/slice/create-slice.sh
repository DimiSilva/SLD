#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"
parse_context_args "$@"
set -- "${SLD_POSITIONAL_ARGS[@]}"

name_input="${1:-}"
[[ -n "$name_input" ]] || usage_error "uso: $(basename "$0") <name>"

require_file "$SLD_STATE_ROOT/current-track"
current_track_ref="$(tr -d '\n' < "$SLD_STATE_ROOT/current-track")"
[[ -n "$current_track_ref" ]] || usage_error "arquivo current-track vazio em $SLD_STATE_ROOT"

track_dir="$REPO_ROOT/$current_track_ref"
require_dir "$track_dir"
require_dir "$track_dir/slices"

name_slug="$(slugify "$name_input")"
[[ -n "$name_slug" ]] || usage_error "nome invalido para slug"

slice_name="$(unix_timestamp_seconds)-$name_slug"
slice_rel="slices/$slice_name"
slice_dir="$track_dir/$slice_rel"

if [[ -e "$slice_dir" ]]; then
  usage_error "slice ja existe: $slice_name"
fi

mkdir -p "$slice_dir"
render_template \
  "$SLD_TEMPLATES_ROOT/slice.md.tpl" \
  "$slice_dir/slice.md" \
  SLICE_NAME "$slice_name"

printf '%s\n' "$slice_rel" > "$track_dir/.current-slice"

printf '%s\n' "$slice_name"
