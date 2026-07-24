#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/_common.sh"
custom_root="$(config_get_path "custom_root" || true)"
custom_root="${custom_root:-.sld/custom}"
root="$REPO_ROOT/$custom_root"
target="${1:-}"
status=0

check_one() {
  local dir="$1"
  [[ -f "$dir/manifest.md" ]] || { err "manifest.md ausente: $dir"; status=1; }
  [[ -f "$dir/config.yaml" ]] || { err "config.yaml ausente: $dir"; status=1; }
  [[ -d "$dir/scripts" && -d "$dir/skills" && -d "$dir/templates" && -d "$dir/state" ]] || { err "estrutura incompleta: $dir"; status=1; }
  [[ -x "$dir/scripts/run-base.sh" ]] || { err "run-base.sh ausente ou nao executavel: $dir"; status=1; }
  grep -q '^paths:' "$dir/config.yaml" || { err "paths ausente: $dir/config.yaml"; status=1; }
  while IFS= read -r skill_md; do
    grep -q '^name:' "$skill_md" || { err "name ausente: $skill_md"; status=1; }
    grep -q '^description:' "$skill_md" || { err "description ausente: $skill_md"; status=1; }
  done < <(find "$dir/skills" -type f -name 'SKILL.md' | sort)
}

if [[ -n "$target" ]]; then
  check_one "$root/$(slugify "$target")"
elif [[ -d "$root" ]]; then
  while IFS= read -r custom_dir; do check_one "$custom_dir"; done < <(find "$root" -mindepth 1 -maxdepth 1 -type d | sort)
fi
[[ "$status" -eq 0 ]] || exit "$status"
echo "ok"
