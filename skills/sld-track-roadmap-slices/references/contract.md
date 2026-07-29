# sld-track-roadmap-slices

Cria ou atualiza o roadmap tecnico de slices da track ativa.

## Papel da skill

Transformar os objetivos da track em incrementos tecnicos planejaveis,
priorizados e executaveis. Este documento nao substitui o `slice.md` nem o
planejamento de tasks de uma slice.

## Entradas

- `.sld/current-track`
- `track.md` da track ativa
- `roadmap-objectives.md` da track, quando existir
- `roadmap-slices.md` atual, se existir
- diretorio `slices/` da track, quando houver
- `.sld/manifest.md`
- `.sld/config.yaml`

## Saida esperada

- `status`: `created` | `updated` | `blocked`
- `roadmap_file`: caminho de `roadmap-slices.md`
- `planned_slices`: lista priorizada com `id`, `name`, `objective_ids`, intent, prioridade, status e dependencias
- `next_recommended_slice`: proxima slice recomendada, quando houver
- `open_questions`: perguntas objetivas, quando houver

## Regras

- cada item deve ter um identificador estavel no formato `S1`, `S2`, ...;
- `name` deve ser conceitual e nao deve simular o timestamp da slice real;
- `objective_ids` deve referenciar IDs existentes em `roadmap-objectives.md`, quando houver objetivos aplicaveis;
- uma slice pode contribuir para mais de um objetivo;
- usar `priority`: `high` | `medium` | `low`;
- usar `status`: `planned` | `in_progress` | `done` | `dropped`;
- registrar dependencias entre slices quando a ordem importar;
- considerar slices reais em `slices/` sem inventar execucao ou alterar seus estados silenciosamente;
- evitar sobreposicao e escopo grande demais; propor `sld-slice-split` quando necessario;
- manter o roadmap flexivel: o `slice.md` e o planejamento de tasks são a fonte de detalhes da execucao;
- quando faltar contexto critico, retornar `blocked` e registrar a pergunta.
