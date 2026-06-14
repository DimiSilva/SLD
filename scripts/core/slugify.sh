#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/_common.sh
source "$SCRIPT_DIR/../lib/_common.sh"

input="${1:-}"
[[ -n "$input" ]] || usage_error "uso: $(basename "$0") <texto>"

slugify "$input"
