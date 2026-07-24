#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/_common.sh"

custom_name="${1:-}"
skill_name_input="${2:-}"
base_skill="${3:-}"
[[ -n "$custom_name" && -n "$skill_name_input" ]] || usage_error "uso: $(basename "$0") <custom> <skill> [base-skill]"
custom_root="$(config_get_path "custom_root" || true)"
custom_root="${custom_root:-.sld/custom}"
custom_slug="$(slugify "$custom_name")"
skill_slug="$(printf '%s' "$skill_name_input" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g')"
custom_dir="$REPO_ROOT/$custom_root/$custom_slug"
require_dir "$custom_dir"
skill_dir="$custom_dir/skills/sld-$custom_slug-$skill_slug"
[[ ! -e "$skill_dir" ]] || usage_error "skill ja existe: $skill_dir"
mkdir -p "$skill_dir"
base_ref="${base_skill:-none}"
if [[ "$base_ref" != "none" ]]; then
  base_ref="$(printf '%s' "$base_ref" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g')"
fi
skill_name="sld-$custom_slug-$skill_slug"

cat > "$skill_dir/SKILL.md" <<EOF
---
name: $skill_name
description: Custom SLD skill for $skill_name_input in the $custom_slug specialization.
---

# $skill_name

## Base skill

- extends: $base_ref
- base path: .sld/skills/$base_ref/SKILL.md

## Instructions

- Leia .sld/manifest.md e o manifesto desta customizacao.
- Preserve as regras da skill base quando extends nao for none.
- Registre aqui as regras adicionais ou o fluxo unico desta customizacao.
- Scripts devem usar explicitamente o config, state e templates da customizacao.
- Nao altere a camada base.
EOF
printf '%s\n' "$skill_dir/SKILL.md"
