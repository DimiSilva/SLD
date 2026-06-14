# sld.learning.consolidate

Consolida aprendizados locais (tracks/slices fechadas) e promove apenas o que tem evidencia real.

## Papel da skill

- ler learnings locais de slices fechadas;
- evitar promover ruido;
- registrar o que ja foi analisado para nao reprocessar sempre.

## Entradas

- escopo de consolidacao:
  - padrao: todas as tracks em `<tracks-root>/`
  - excecao: track especifica quando informada explicitamente
- `track.md` e `learnings.md` de cada track
- `slice.md` das slices fechadas
- `<tracks-root>/_learning-consolidation-log.md` (registry obrigatorio)
- `.sld/manifest.md`
- `.sld/config.yaml`
- `paths.adrs_root` em `.sld/config.yaml`
- `paths.guidelines_root` em `.sld/config.yaml`
- `paths.examples_root` em `.sld/config.yaml`
- `docs/agent-reinforcements.md`

## Regras obrigatorias

- nao promover aprendizado sem evidencia objetiva;
- priorizar no maximo 3 promocoes por rodada;
- evitar duplicar regra ja existente;
- marcar no registry os learnings ja revisados (`last_reviewed_at` e status final).

## Registry de consolidacao

Arquivo: `<tracks-root>/_learning-consolidation-log.md`

Status sugeridos por slice:
- `pending_review`
- `promoted`
- `kept_local`
- `discarded`

## Saida esperada

- `status`: `consolidated` | `nothing_to_promote` | `blocked`
- `scope`: `all_tracks` | `single_track`
- `tracks_analyzed`
- `promote_now` (ate 3 itens):
  - `learning_ref`
  - `destination`
  - `evidence`
  - `expected_gain`
  - `suggested_action`
- `keep_local`
- `registry_updates` (itens atualizados no log)

## Criterio de aprovacao

- `consolidated` quando houver ao menos 1 promocao relevante com evidencia;
- `nothing_to_promote` quando tudo for local/pouco relevante;
- `blocked` quando faltarem fontes minimas.
