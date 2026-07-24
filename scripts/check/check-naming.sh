#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"
parse_context_args "$@"

status=0

tracks_root="$REPO_ROOT/$(tracks_root_rel)"
if [[ -d "$tracks_root" ]]; then
  while IFS= read -r track_path; do
    track_name="$(basename "$track_path")"
    if ! is_valid_timestamped_name "$track_name"; then
      err "track com nome invalido: $track_name"
      status=1
    fi

    if [[ -d "$track_path/slices" ]]; then
      while IFS= read -r slice_path; do
        slice_name="$(basename "$slice_path")"
        if ! is_valid_timestamped_name "$slice_name"; then
          err "slice com nome invalido: $track_name/$slice_name"
          status=1
        fi
      done < <(find "$track_path/slices" -mindepth 1 -maxdepth 1 -type d | sort)
    fi
  done < <(find "$tracks_root" -mindepth 1 -maxdepth 1 -type d | sort)
fi

if [[ "$status" -ne 0 ]]; then
  exit "$status"
fi

echo "ok"
