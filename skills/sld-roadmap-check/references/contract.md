# sld-roadmap-check

Valida consistencia tecnica e estrutural do roadmap da track ativa.

## Papel da skill

Atuar como guarda tecnico do roadmap, apontando conflitos de ordem, dependencia, escopo e alinhamento com a track.

## Entradas

- `.sld/current-track`
- `track.md`
- `roadmap.md`
- `.sld/manifest.md`
- `paths.adrs_root` em `.sld/config.yaml`
- `paths.guidelines_root` em `.sld/config.yaml`

## Validacoes obrigatorias

- `roadmap.md` existe e esta legivel;
- itens possuem `id`, `name`, `intent`, `priority`, `status`;
- nao ha dependencia circular evidente;
- nao ha sobreposicao de escopo sem justificativa;
- slices planejadas mantem alinhamento com `Direction` e `Constraints` da track.

## Saida esperada

- `status`: `pass` | `fail`
- `findings` (ate 7)
- `fix_now` (ate 3)
