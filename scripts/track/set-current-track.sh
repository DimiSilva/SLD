#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"
parse_context_args "$@"
set -- "${SLD_POSITIONAL_ARGS[@]}"

track_name="${1:-}"
[[ -n "$track_name" ]] || usage_error "uso: $(basename "$0") <track-name>"

tracks_root="$(tracks_root_rel)"
track_dir="$REPO_ROOT/$tracks_root/$track_name"
require_dir "$track_dir"
require_file "$track_dir/track.md"

mkdir -p "$SLD_STATE_ROOT"
printf '%s/%s\n' "$tracks_root" "$track_name" > "$SLD_STATE_ROOT/current-track"
printf '%s\n' "$track_name"
