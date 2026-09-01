#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/_common.sh"
custom_root="$(config_get_path "custom_root" || true)"
custom_root="${custom_root:-.sld/custom}"
root="$REPO_ROOT/$custom_root"
target="${1:-}"
status=0

base_skills=(
  track-create track-clarify slice-create slice-split slice-clarify
  slice-one-shot slice-increment slice-plan-tasks slice-implement slice-close track-check slice-check
  retro example track-roadmap-objectives track-roadmap-slices
  learning-consolidate
)

base_scripts=(
  core/timestamp.sh core/uuid.sh core/slugify.sh
  track/create-track.sh track/set-current-track.sh
  slice/create-slice.sh slice/set-current-slice.sh
  check/check-naming.sh check/check-required-files.sh
)

base_templates=(track.md.tpl slice.md.tpl example.md.tpl roadmap-objectives.md.tpl roadmap-slices.md.tpl)

check_one() {
  local dir="$1"
  [[ -f "$dir/manifest.md" ]] || { err "manifest.md ausente: $dir"; status=1; }
  [[ -f "$dir/config.yaml" ]] || { err "config.yaml ausente: $dir"; status=1; }
  [[ -d "$dir/scripts" && -d "$dir/skills" && -d "$dir/templates" && -d "$dir/state" ]] || { err "estrutura incompleta: $dir"; status=1; }
  [[ -x "$dir/scripts/run-base.sh" ]] || { err "run-base.sh ausente ou nao executavel: $dir"; status=1; }
  grep -q '^paths:' "$dir/config.yaml" || { err "paths ausente: $dir/config.yaml"; status=1; }
  local custom_name
  custom_name="$(basename "$dir")"

  for base_script in "${base_scripts[@]}"; do
    [[ -x "$dir/scripts/$base_script" ]] || { err "script custom ausente: $dir/scripts/$base_script"; status=1; }
  done

  for template in "${base_templates[@]}"; do
    [[ -f "$dir/templates/$template" ]] || { err "template herdado ausente: $dir/templates/$template"; status=1; }
  done

  for base_skill in "${base_skills[@]}"; do
    local base_slug
    base_slug="$base_skill"
    local custom_skill="$dir/skills/sld-$custom_name-$base_slug"
    local expected_name="sld-$custom_name-$base_slug"
    local expected_base="sld-$base_slug"
    [[ -f "$custom_skill/SKILL.md" ]] || { err "skill custom ausente: $custom_skill/SKILL.md"; status=1; continue; }
    grep -q "^name: $expected_name$" "$custom_skill/SKILL.md" || {
      err "nome de skill custom invalido: $custom_skill/SKILL.md"; status=1;
    }
    grep -q "^- extends: $expected_base$" "$custom_skill/SKILL.md" || {
      err "heranca ausente: $custom_skill/SKILL.md"; status=1;
    }
  done

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
