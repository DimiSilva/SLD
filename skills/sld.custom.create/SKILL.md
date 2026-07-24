---
name: sld-custom-create
description: Create a new SLD customization subproject under .sld/custom with its own manifest, config, scripts, skills, and templates.
---

# sld.custom.create

Leia `.sld/manifest.md` e `.sld/config.yaml`. Execute:

```bash
.sld/scripts/custom/create-custom.sh "<name>"
```

Crie somente uma customizacao namespaced em `.sld/custom/<name>`. A estrutura
deve incluir `config.yaml`, `state/`, `scripts/`, `skills/`, `templates/` e os
diretorios de artefatos definidos no config. Nao altere a camada base. Retorne
caminho, resumo e pendencias.
