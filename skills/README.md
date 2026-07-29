# SLD Skills

As skills seguem o Agent Skills: cada skill fica em um diretorio proprio com
`SKILL.md`. O contrato detalhado de cada skill fica em seu proprio diretorio,
em `references/contract.md`, quando houver necessidade de separacao.

Skills base disponiveis (fluxo atual):

- sld-track-create
- sld-track-clarify
- sld-slice-create
- sld-slice-split
- sld-slice-clarify
- sld-slice-plan-tasks
- sld-slice-implement
- sld-slice-close
- sld-track-check
- sld-slice-check
- sld-retro
- sld-example
- sld-track-roadmap-objectives
- sld-track-roadmap-slices
- sld-learning-consolidate

Skills de customizacao:

- sld-custom-create
- sld-custom-check
- sld-custom-update
- sld-custom-skill-create

O nome no frontmatter usa a forma compativel com Agent Skills, enquanto as
pastas e o campo `name` usam identificadores com hífens, como
`sld-track-create`.

## Estrutura

```text
skills/
  sld-track-create/
    SKILL.md
  sld-slice-implement/
    SKILL.md
  sld-custom-create/
    SKILL.md
```

Skills customizadas devem viver em `.sld/custom/<nome>/skills/` e podem
adicionar skills, scripts, templates, manifestos e configuracao sem alterar a
camada base.

Os contratos base usam `.sld/config.yaml` e `.sld/current-track` como defaults.
Quando uma skill operar dentro de uma customizacao, deve usar os caminhos do
contexto informado pela skill/script adaptador: `config.yaml`, `state/` e
`templates/` da customizacao.
