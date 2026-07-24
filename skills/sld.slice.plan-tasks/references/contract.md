# sld.slice.plan-tasks

Planeja tasks tecnicas da slice ativa de forma atomica, ordenada e verificavel.

## Papel da skill

- transformar objetivo da slice em plano executavel;
- limitar escopo e evitar task guarda-chuva;
- preparar base para `sld.slice.implement`.

## Entradas

- `.sld/current-track`
- `.current-slice` da track ativa
- `slice.md` da slice ativa
- `track.md` da track ativa
- `.sld/config.yaml`
- `.sld/manifest.md`
- `paths.adrs_root` e `paths.guidelines_root` em `.sld/config.yaml`

## Regras

- gerar 5-8 tasks por rodada;
- manter 1 objetivo principal da slice;
- cada task com validacao clara;
- nao expandir escopo silenciosamente;
- se estourar escopo, propor split da slice.

## Formato obrigatorio da task

```md
- [ ] T1 — <titulo curto e objetivo>
  - work_type: documentation | implementation | analysis | validation
  - change_type: none | edit_file | new_file | remove_file
  - files:
    - <arquivo-1>
  - change_summary: <resumo objetivo da mudanca>
  - validation: <como validar>
  - risk: <opcional>
```

## Saida esperada

- `status`: `planned` | `blocked`
- `slice_name`
- `tasks` (lista ordenada)
- `done_definition`
- `next_action`: `sld.slice.implement`

## Criterio de aprovacao

- `planned` quando o plano estiver objetivo e verificavel;
- `blocked` quando faltar contexto critico ou houver conflito com guideline/ADR.
