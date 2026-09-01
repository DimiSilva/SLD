# sld-slice-implement

Executa as tasks planejadas da slice ativa e registra resultado/evidencias.

## Papel da skill

- executar apenas tasks planejadas da slice;
- atualizar checklist e resultado no `slice.md`;
- registrar bloqueios, desvios e proximos passos.

## Entradas

- `.sld/current-track`
- `.current-slice` da track ativa
- `slice.md` da slice ativa
- plano de tasks ja registrado na slice
- `.sld/config.yaml`
- `.sld/manifest.md`

## Regras

- exigir tasks planejadas e validas antes de iniciar qualquer implementacao;
- nao executar quando `Tasks` estiver `not_planned` ou `not_applicable`;
- executar tasks em ordem, salvo justificativa explicita;
- marcar `- [x]` quando `done`;
- manter `- [ ]` quando `partial`/`blocked`;
- nao inventar evidencias;
- se surgir escopo extra grande, parar e propor split.

## Registro obrigatorio por task

- `task_id`
- `result`: `done` | `partial` | `blocked`
- `evidence`
- `notes` (opcional)

## Saida esperada

- `status`: `done` | `partial` | `blocked`
- `completed_tasks`
- `pending_tasks`
- `next_action`: `ajustes_livres` ou `sld-slice-close`

## Criterio de aprovacao

- `done` quando todas as tasks planejadas forem concluidas com validacao minima;
- `partial` quando houver pendencias nao criticas;
- `blocked` quando impedimento critico inviabilizar continuidade.

Para uma slice sem plano, usar `sld-slice-increment` ou `sld-slice-one-shot`.
