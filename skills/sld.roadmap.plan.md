# sld.roadmap.plan

Planeja ou atualiza o roadmap de slices da track ativa.

## Papel da skill

Definir visao incremental da track com slices candidatas, prioridade e ordem sugerida.

## Entradas

- `.sld/current-track`
- `track.md` da track ativa
- `roadmap.md` atual (se existir)
- `.sld/manifest.md`
- `.sld/config.yaml`

## Saida esperada

- `status`: `planned` | `updated` | `blocked`
- `roadmap_file`
- `planned_slices` (lista priorizada)
- `next_recommended_slice`

## Regras

- roadmap e flexivel, nao contrato rigido;
- no maximo 8 slices planejadas por rodada;
- cada slice planejada deve ter:
  - `id` (ex.: `R1`)
  - `name` (conceitual, sem timestamp)
  - `intent`
  - `priority` (`high|medium|low`)
  - `status` (`planned|in_progress|done|dropped`)
  - `dependencies` (opcional)
- evitar escopo inflado e sobreposicao entre slices planejadas.
