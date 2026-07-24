#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"
parse_context_args "$@"

status=0

tracks_root="$REPO_ROOT/$(tracks_root_rel)"
if [[ ! -d "$tracks_root" ]]; then
  err "diretorio de tracks nao encontrado: $tracks_root"
  exit 1
fi

while IFS= read -r track_path; do
  for required in track.md learnings.md; do
    if [[ ! -f "$track_path/$required" ]]; then
      err "arquivo ausente em $(basename "$track_path"): $required"
      status=1
    fi
  done

  if [[ -d "$track_path/slices" ]]; then
    while IFS= read -r slice_path; do
      if [[ ! -f "$slice_path/slice.md" ]]; then
        err "arquivo ausente em $(basename "$track_path")/$(basename "$slice_path"): slice.md"
        status=1
      fi
    done < <(find "$track_path/slices" -mindepth 1 -maxdepth 1 -type d | sort)
  fi
done < <(find "$tracks_root" -mindepth 1 -maxdepth 1 -type d | sort)

if [[ "$status" -ne 0 ]]; then
  exit "$status"
fi

echo "ok"
