---
name: sld-custom-skill-create
description: Create a namespaced custom SLD skill that specializes a base skill or defines a unique workflow inside a customization subproject.
---

# sld.custom.skill.create

Use:

```bash
.sld/scripts/custom/create-custom-skill.sh <custom-name> <skill-name> [base-skill]
```

Com `base-skill`, declare explicitamente qual skill base esta sendo
especializada e liste as regras adicionais. Sem ele, crie uma skill unica.
Scripts chamados por essa skill devem passar explicitamente o config, state e
templates da customizacao. Nunca edite a skill base.
