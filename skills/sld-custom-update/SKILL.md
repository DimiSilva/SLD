---
name: sld-custom-update
description: Update the managed SLD base from a local source or remote repository while preserving .sld/custom and the effective project config.
---

# sld.custom.update

Execute `.sld/scripts/core/update-sld.sh`, informando
`SLD_SOURCE_DIR`, `SLD_GITHUB_REPO` ou `SLD_ARCHIVE_URL` quando
necessario. Nunca remova nem reescreva `.sld/custom` ou
`.sld/config.yaml`. A atualizacao nao substitui scripts, skills, templates,
config ou state de nenhuma customizacao.
