# sld-slice-increment

Executa um pequeno incremento sobre uma slice existente, sem planejamento
formal de tasks.

## Papel da skill

- permitir evolucao incremental de uma slice;
- manter cada implementacao pequena, revisavel e verificavel;
- registrar o historico dos incrementos ate o cumprimento do objetivo.

## Entradas obrigatorias

- `.sld/current-track`;
- `.current-slice` da track ativa;
- `slice.md` da slice atual;
- um objetivo de incremento fornecido pelo desenvolvedor, ou uma proposta
  objetiva para validacao antes de implementar;
- `.sld/config.yaml` e `.sld/manifest.md`.

## Pre-condicoes

1. A track e a slice atuais existem e sao validas.
2. `Intent`, `Scope`, `Out of Scope` e `Acceptance Criteria` estao preenchidos.
3. A slice ainda nao iniciou o fluxo planejado. Se houver tasks planejadas,
   usar `sld-slice-implement`.

## Regras

- nao executar `sld-slice-plan-tasks`;
- executar exatamente um incremento por chamada;
- manter o incremento dentro do escopo atual;
- nao adicionar automaticamente o proximo incremento;
- se surgir trabalho independente ou escopo relevante, parar e propor split;
- reavaliar os criterios de aceite depois de cada incremento.

Se o objetivo do incremento nao estiver claro, retornar uma proposta curta e
aguardar validacao; nao inventar uma implementacao.

## Registro obrigatorio

Adicionar uma entrada em `Increment Log` com:

- `increment_id`: `I1`, `I2`, ...;
- `intent`;
- `scope`;
- `files`;
- `validation`;
- `result`: `done` | `partial` | `blocked`;
- `notes` (opcional);
- `next_step`.

## Saida esperada

- `slice_name`;
- `increment_id`;
- `status`: `done` | `partial` | `blocked`;
- `acceptance_status`: `met` | `in_progress` | `not_met`;
- `next_action`: `sld-slice-increment`, `sld-slice-close` ou `sld-slice-split`.

## Criterio de aprovacao

- `done` quando o incremento for validado e registrado;
- `partial` quando houver resultado parcial ou pendencia nao critica;
- `blocked` quando um impedimento impedir o incremento atual.
