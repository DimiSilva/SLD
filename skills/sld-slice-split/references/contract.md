# sld.slice.split

Propõe a divisao de um slice grande em slices menores, mantendo escopo claro e sequencia executavel.

## Objetivo

- reduzir escopo inflado;
- melhorar revisabilidade e testabilidade;
- manter progresso incremental alinhado a track.

## Entradas obrigatorias

- `slice atual` (via `.current-slice` da track ativa);
- `motivo do split` (1-2 frases);
- `restricao principal` (se houver).

## Regras

- nao criar automaticamente novas slices;
- gerar apenas proposta de split para validacao do desenvolvedor;
- sugerir no maximo 2 slices por rodada;
- cada sugestao deve ter:
  - `name`
  - `intent`
  - `acceptance` (1-3 criterios)
  - `out_of_scope`
  - `ordem sugerida`.

## Gate de qualidade

A proposta deve:

- preservar alinhamento com a track;
- separar objetivos independentes;
- evitar sobreposicao entre slices propostas;
- manter cada slice revisavel em ciclo curto.

## Saida esperada (compacta)

- `split_needed`: `true|false`
- se `true`:
  - ate 2 slices propostas
  - ordem recomendada
  - risco principal por slice
- se `false`:
  - justificativa curta do por que manter slice unica.

