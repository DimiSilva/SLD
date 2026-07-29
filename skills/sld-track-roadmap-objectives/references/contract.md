# sld-track-roadmap-objectives

Cria ou atualiza o roadmap de objetivos macro da track ativa.

## Papel da skill

Definir os resultados que orientam a track, seus indicadores de progresso e
seu estado atual. Este documento deve permanecer independente de detalhes de
implementacao.

## Entradas

- `.sld/current-track`
- `track.md` da track ativa
- `roadmap-objectives.md` atual, se existir
- `learnings.md` da track, quando houver
- `.sld/manifest.md`
- `.sld/config.yaml`

## Saida esperada

- `status`: `created` | `updated` | `blocked`
- `roadmap_file`: caminho de `roadmap-objectives.md`
- `objectives`: lista de objetivos com `id`, descricao, indicadores, prioridade e status
- `open_questions`: perguntas objetivas, quando houver

## Regras

- objetivos devem expressar resultados ou capacidades desejadas em nivel macro;
- cada objetivo deve ter um identificador estavel no formato `O1`, `O2`, ...;
- registrar indicadores observaveis de progresso ou conclusao;
- usar `priority`: `high` | `medium` | `low`;
- usar `status`: `planned` | `active` | `achieved` | `paused` | `dropped`;
- nao incluir nomes de arquivos, tarefas ou passos de implementacao como objetivo;
- preservar objetivos existentes e seus IDs ao atualizar o documento;
- nao marcar um objetivo como `achieved` apenas porque uma slice foi concluida;
- quando faltar contexto critico, retornar `blocked` e registrar a pergunta.
