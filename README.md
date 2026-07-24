# SLD - Slice-Led Development

SLD e um framework de trabalho com IA orientado por tracks e slices. Ele foi desenhado para projetos de qualquer natureza, nao apenas software: uma track define uma direcao evolutiva, um slice entrega um avanco pequeno e verificavel, e tasks organizam a execucao.

## Instalar em um projeto

Na raiz do projeto consumidor:

```bash
/caminho/para/sld/install.sh
```

Depois que este repositorio estiver publicado no GitHub, tambem e possivel instalar remoto:

```bash
curl -fsSL https://raw.githubusercontent.com/<owner>/<repo>/main/install.sh | bash -s -- <owner>/<repo>
```

Ou usando variavel de ambiente:

```bash
curl -fsSL https://raw.githubusercontent.com/<owner>/<repo>/main/install.sh | SLD_GITHUB_REPO=<owner>/<repo> bash
```

Isso cria ou atualiza:

```text
.sld/
  manifest.md
  config.yaml
  current-track
  scripts/
  skills/
  templates/
  custom/
    <custom-name>/
      config.yaml
      state/
      scripts/
      skills/
      templates/
```

Por padrao, os artefatos de trabalho ficam em `docs/tracks`, `docs/adrs`, `docs/guidelines` e `docs/examples`, conforme `.sld/config.yaml`.

## Opcoes

```bash
SLD_TARGET_DIR=/repo/consumidor /caminho/para/sld/install.sh
curl -fsSL https://raw.githubusercontent.com/owner/repo/main/install.sh | SLD_GITHUB_REPO=owner/repo bash
SLD_INSTALL_AGENTS=1 /caminho/para/sld/install.sh
SLD_FORCE=1 /caminho/para/sld/install.sh
SLD_FORCE_CONFIG=1 /caminho/para/sld/install.sh
SLD_TRACKS_ROOT=work/tracks /caminho/para/sld/install.sh
```

- `SLD_TARGET_DIR`: projeto onde o framework sera instalado. Padrao: diretorio atual.
- `SLD_GITHUB_REPO`: repositorio `owner/repo` usado quando o instalador roda via `curl | bash`.
- `SLD_REF`: branch/ref para instalacao remota. Padrao: `main`.
- `SLD_ARCHIVE_URL`: URL completa para um `.tar.gz`; sobrescreve `SLD_GITHUB_REPO` e `SLD_REF`.
- `SLD_INSTALL_AGENTS=1`: copia `AGENTS.md` para a raiz do projeto se nao existir.
- `SLD_FORCE=1`: permite sobrescrever `AGENTS.md` quando `SLD_INSTALL_AGENTS=1`.
- `SLD_FORCE_CONFIG=1`: permite sobrescrever `.sld/config.yaml`; sem isso, configuracao existente e preservada.
- `SLD_TRACKS_ROOT`, `SLD_ADRS_ROOT`, `SLD_GUIDELINES_ROOT`, `SLD_EXAMPLES_ROOT`: customizam caminhos iniciais no `config.yaml`.
- `SLD_CUSTOM_ROOT`: caminho das customizações SLD. Padrão: `.sld/custom`.

## Fluxo atual

```text
sld.track.create -> (ajustes livres) -> [sld.track.clarify, opcional]
-> (ajustes livres) -> sld.slice.create -> (ajustes livres)
-> [sld.slice.clarify, opcional] -> (ajustes livres)
-> sld.slice.plan-tasks -> (ajustes livres) -> sld.slice.implement
-> (ajustes livres) -> sld.slice.close -> checks -> proxima slice
```

As skills de clarify sao opcionais e dependem da complexidade da feature e da
clareza do operador. Os ajustes livres podem ser usados entre as etapas.

## Scripts principais

Depois de instalado:

```bash
.sld/scripts/track/create-track.sh "improve-workflow"
.sld/scripts/slice/create-slice.sh "first-small-step"
.sld/scripts/check/check-naming.sh
.sld/scripts/check/check-required-files.sh
```

## Nota de distribuicao

Este repositorio guarda o pacote fonte na raiz. Em projetos consumidores, o pacote deve viver dentro de `.sld/`. Os scripts assumem essa estrutura instalada.

## Customizações

`.sld/` possui uma camada base gerenciada e uma área de customizações preservada.
Uma customização pode definir skills próprias, especializar uma skill base,
adicionar scripts ou criar templates. Ela deve referenciar explicitamente a
skill base que estende; o SLD não faz merge implícito de skills.

Use as skills `sld.custom.create`, `sld.custom.check`,
`sld.custom.skill.create` e `sld.custom.update` para manter a estrutura.

O atualizador substitui apenas `manifest.md`, `scripts/`, `skills/` e `templates/`.
Ele preserva `config.yaml` e todo o conteúdo de `custom/`.

Scripts base aceitam `--config`, `--state-root` e `--templates-root`. Os
scripts de uma customização devem passar esses três valores ao delegar para a
base. Dessa forma, cada customização mantém seu próprio `current-track`,
tracks, slices e templates, sem precisar de um custom ativo global.
