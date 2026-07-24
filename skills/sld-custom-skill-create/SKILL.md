---
name: sld-custom-skill-create
description: Create a namespaced custom SLD skill that specializes a base skill or defines a unique workflow inside a customization subproject.
---

# sld-custom-skill-create

Use:

```bash
.sld/scripts/custom/create-custom-skill.sh <custom-name> <skill-name> [base-skill]
```

O nome deve preservar a estrutura da skill base usando hífens: `sld-<custom-name>-<base>`.
Por exemplo, uma especializacao de `sld-slice-create` em `prototype` deve se
chamar `sld-prototype-slice-create`. Declare explicitamente qual skill base
esta sendo especializada e liste as regras adicionais. Scripts chamados por
essa skill devem passar explicitamente o config, state e templates da
customizacao. Nunca edite a skill base.
