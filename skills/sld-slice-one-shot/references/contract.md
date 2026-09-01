# sld-slice-one-shot

Cria, planeja e implementa uma slice pequena em uma unica operacao orientada
ao resultado.

## Papel da skill

- evitar que o desenvolvedor precise conduzir separadamente create, plan e implement;
- manter a mesma disciplina de escopo e evidencia do fluxo padrao;
- deixar a slice pronta para `sld-slice-close`.

## Entradas obrigatorias

- `name`: nome curto da slice, quando uma nova slice for necessaria;
- `intent`: objetivo da slice em 1-2 frases;
- `acceptance`: 2-4 criterios verificaveis.

## Pre-condicoes

1. A track atual existe e e valida.
2. O pedido descreve um ajuste pequeno, com um comportamento principal.
3. O escopo nao envolve decisoes criticas em aberto, migracao ampla ou
   mudanca de contrato que exija revisao previa.

Se houver uma slice ativa existente, reutiliza-la somente quando o pedido
identificar explicitamente essa slice. Caso contrario, criar uma nova slice;
nao reaproveitar uma slice ativa nao relacionada silenciosamente.

## Workflow

1. Ler o manifesto, o config e a track ativa.
2. Criar a slice usando `sld-slice-create` quando nao houver alvo explicito.
3. Preencher `Intent`, `Track Alignment`, `Scope`, `Out of Scope`,
   `Acceptance Criteria` e `Risks and Assumptions`.
4. Gerar dentro da mesma operacao um plano compacto no formato oficial de
   tasks. Nao exigir uma chamada separada de `sld-slice-plan-tasks`.
5. Executar as tasks conforme o contrato de `sld-slice-implement`.
6. Registrar evidencias, desvios e resultado no `slice.md`.

O plano interno deve conter somente o trabalho necessario para o ajuste. Nao
inventar tasks para preencher quantidade.

## Saida esperada

- `slice_name`
- `slice_path`
- `created`: `true` | `false`
- `status`: `done` | `partial` | `blocked`
- `completed_tasks`
- `pending_tasks`
- `next_action`: `sld-slice-close`, `ajustes_livres` ou `sld-slice-split`

## Criterio de aprovacao

- `done` quando o plano interno for executado e os criterios de aceite forem
  validados;
- `partial` quando houver pendencias nao criticas registradas;
- `blocked` quando faltar contexto critico ou houver impedimento tecnico.
