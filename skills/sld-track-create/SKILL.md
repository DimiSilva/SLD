---
name: sld-track-create
description: Create a new SLD track with a timestamped name and initial direction. Use when starting a new SLD evolution track.
---

# sld.track.create

Siga o contrato completo em `references/contract.md`.

Antes de executar, leia o manifesto e o config do contexto. No fluxo base,
use `.sld/config.yaml` e `.sld/current-track`; em uma customizacao, use o
wrapper da customizacao ou passe `--config`, `--state-root` e
`--templates-root` explicitamente. Retorne caminho, resumo e pendencias.
