# sld-slice-close

Fecha a slice ativa de forma controlada, sem etapa de classificacao de cumprimento.

## Papel da skill

- encerrar formalmente a slice ativa;
- registrar learning local da slice no fechamento;
- consolidar learnings da slice na track;
- registrar explicitamente execucoes fora do escopo planejado;
- atualizar artefatos da track para refletir estado final da slice.

## Entradas

- `.sld/current-track`
- `.current-slice` da track ativa
- `slice.md` do slice ativo
- `track.md`, `learnings.md` e `roadmap.md` (se existir)
- `.sld/config.yaml`
- `.sld/manifest.md`

## Pre-condicoes

1. track e slice ativos existem e sao validos.
2. usuario solicita o fechamento da slice.

## Learning no fechamento (obrigatorio)

No `slice.md`, registrar um bloco `Learning (local)` com:

- `what_worked`
- `what_did_not_work`
- `next_slice_hint`
- `out_of_scope_notes` (tarefas/ajustes executados fora do escopo original da slice)

No `learnings.md` da track, adicionar entrada resumida da slice fechada.
Se houver itens fora de escopo, incluir resumo desses itens e impacto.

## Registry de consolidacao (obrigatorio)

Atualizar `<tracks-root>/_learning-consolidation-log.md` com uma linha por slice fechada:

- `track`
- `slice`
- `closed_at`
- `consolidation_status` (`pending_review` por padrao)
- `last_reviewed_at` (vazio inicialmente)

## Saida esperada

- `slice_name`
- `slice_path`
- `updated_files`
- `status`: `done`

## Criterio de aprovacao

- `done` quando houver atualizacao de `slice.md`, `track.md`, `learnings.md` e registry de consolidacao.
