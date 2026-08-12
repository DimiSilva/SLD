---
name: sld-track-create
description: Create a new SLD track with a timestamped name and initial direction, optionally seeding explicitly provided objectives and slices. Use when starting a new SLD evolution track.
---

# sld-track-create

Siga o contrato completo em `references/contract.md`.

Antes de executar, leia o manifesto e o config do contexto. No fluxo base,
use `.sld/config.yaml` e `.sld/current-track`; em uma customizacao, use o
wrapper da customizacao ou passe `--config`, `--state-root` e
`--templates-root` explicitamente. Retorne caminho, resumo e pendencias.

Por padrao, a nova track deve nascer com `roadmap-objectives.md` e
`roadmap-slices.md` sem registros. So inclua objetivos ou slices iniciais
quando eles forem especificados explicitamente no pedido do usuario; nao
converta a direcao geral da track em itens de roadmap por inferencia.
