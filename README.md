# SLD - Slice-Led Development

SLD é um framework de trabalho com IA orientado por tracks e slices. Ele foi
desenhado para projetos de qualquer natureza, não apenas software: uma track
define uma direção evolutiva, um slice entrega um avanço pequeno e verificável,
e tasks organizam a execução.

## Instalar em um projeto

Na raiz do projeto consumidor:

```bash
/caminho/para/sld/install.sh
```

Para instalar em uma pasta específica:

```bash
SLD_TARGET_DIR=/caminho/para/projeto \
  /caminho/para/sld/install.sh
```

O framework será instalado em `/caminho/para/projeto/.sld`.

Também é possível instalar diretamente do repositório oficial no GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/DimiSilva/SLD/trunk/install.sh \
  | bash -s -- DimiSilva/SLD
```

Ou usando a variável de ambiente:

```bash
curl -fsSL https://raw.githubusercontent.com/DimiSilva/SLD/trunk/install.sh \
  | SLD_GITHUB_REPO=DimiSilva/SLD bash
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

Por padrão, os artefatos de trabalho ficam em `docs/tracks`,
`docs/guidelines` e `docs/examples`, conforme `.sld/config.yaml`.

## Atualizar a instalação

Depois da instalação, use o atualizador para aplicar uma versão mais recente
da camada base:

```bash
.sld/scripts/core/update-sld.sh
```

Para atualizar usando uma cópia local deste repositório:

```bash
SLD_SOURCE_DIR=/caminho/para/sld \
  .sld/scripts/core/update-sld.sh
```

Para atualizar diretamente do repositório oficial:

```bash
SLD_GITHUB_REPO=DimiSilva/SLD \
  .sld/scripts/core/update-sld.sh
```

Também é possível atualizar via `curl`, como na instalação. Executado na raiz
do projeto consumidor:

```bash
curl -fsSL https://raw.githubusercontent.com/DimiSilva/SLD/trunk/scripts/core/update-sld.sh \
  | bash -s -- DimiSilva/SLD
```

Para informar explicitamente o projeto consumidor:

```bash
curl -fsSL https://raw.githubusercontent.com/DimiSilva/SLD/trunk/scripts/core/update-sld.sh \
  | SLD_TARGET_DIR=/caminho/para/projeto SLD_GITHUB_REPO=DimiSilva/SLD bash
```

Sem `SLD_TARGET_DIR`, tanto a instalação quanto a atualização usam o
diretório atual como raiz do projeto consumidor.

`SLD_TARGET_DIR` normalmente é a raiz do projeto. O atualizador também aceita
diretamente o caminho da instalação, como `./ai/frameworks/.sld`.

Também é possível informar uma referência específica ou um arquivo
compactado:

```bash
SLD_GITHUB_REPO=DimiSilva/SLD SLD_REF=<branch-ou-tag> \
  .sld/scripts/core/update-sld.sh

SLD_ARCHIVE_URL=https://example.com/sld-tar-gz \
  .sld/scripts/core/update-sld.sh
```

A atualização substitui somente `manifest.md`, `scripts/`, `skills/` e
`templates/`. Ela preserva `.sld/config.yaml`, `.sld/custom/` e os artefatos
de trabalho do projeto.

## Opções

```bash
SLD_TARGET_DIR=/repo/consumidor /caminho/para/sld/install.sh
curl -fsSL https://raw.githubusercontent.com/DimiSilva/SLD/trunk/install.sh \
  | SLD_GITHUB_REPO=DimiSilva/SLD bash
SLD_INSTALL_AGENTS=1 /caminho/para/sld/install.sh
SLD_FORCE=1 /caminho/para/sld/install.sh
SLD_FORCE_CONFIG=1 /caminho/para/sld/install.sh
SLD_TRACKS_ROOT=work/tracks /caminho/para/sld/install.sh
```

- `SLD_TARGET_DIR`: projeto onde o framework será instalado. Padrão: diretório atual.
- `SLD_GITHUB_REPO`: repositório GitHub usado pelo instalador ou atualizador remoto. Padrão recomendado: `DimiSilva/SLD`.
- `SLD_REF`: branch ou referência para instalação remota. Padrão: `trunk`.
- `SLD_ARCHIVE_URL`: URL completa para um `.tar.gz`; sobrescreve `SLD_GITHUB_REPO` e `SLD_REF`.
- `SLD_INSTALL_AGENTS=1`: copia `AGENTS.md` para a raiz do projeto se não existir.
- `SLD_FORCE=1`: permite sobrescrever `AGENTS.md` quando `SLD_INSTALL_AGENTS=1`.
- `SLD_FORCE_CONFIG=1`: permite sobrescrever `.sld/config.yaml`; sem isso, a configuração existente é preservada.
- `SLD_TRACKS_ROOT`, `SLD_GUIDELINES_ROOT`, `SLD_EXAMPLES_ROOT`: personalizam os caminhos iniciais no `config.yaml`.
- `SLD_CUSTOM_ROOT`: caminho das customizações SLD. Padrão: `.sld/custom`.

## Fluxo atual

```text
sld-track-create -> (ajustes livres) -> [sld-track-clarify, opcional]
-> (ajustes livres) -> sld-slice-create -> (ajustes livres)
-> [sld-slice-clarify, opcional] -> (ajustes livres)
-> sld-slice-plan-tasks -> (ajustes livres) -> sld-slice-implement
-> (ajustes livres) -> sld-slice-close -> checks -> próxima slice
```

As skills de clarify são opcionais e dependem da complexidade da feature e da
clareza do operador. Os ajustes livres podem ser usados entre as etapas.

## Scripts principais

Depois da instalação:

```bash
.sld/scripts/track/create-track.sh "improve-workflow"
.sld/scripts/slice/create-slice.sh "first-small-step"
.sld/scripts/check/check-naming.sh
.sld/scripts/check/check-required-files.sh
```

Ao criar uma track, `roadmap-objectives.md` e `roadmap-slices.md` tambem sao
gerados, mas nascem vazios. Objetivos ou slices iniciais so entram quando
forem especificados explicitamente no pedido de criacao.

## Nota de distribuição

Este repositório guarda o pacote-fonte na raiz. Em projetos consumidores, o
pacote deve viver dentro de `.sld/`. Os scripts assumem essa estrutura
instalada.

## Customizações

`.sld/` possui uma camada base gerenciada e uma área de customizações
preservada. Uma customização pode definir skills próprias, especializar uma
skill base, adicionar scripts ou criar templates. Ela deve referenciar
explicitamente a skill base que estende; o SLD não faz merge implícito de
skills.

Uma customização completa implementa toda a estrutura base. Suas skills mantêm
o domínio da operação e adicionam o nome da customização:

```text
sld-slice-create
sld-prototype-slice-create
```

O comando `sld-custom-create` gera todas as skills base especializadas,
wrappers dos scripts operacionais e templates herdados. A customização pode
substituir qualquer wrapper ou template quando precisar de comportamento
próprio.

Use as skills `sld-custom-create`, `sld-custom-check`,
`sld-custom-skill-create` e `sld-custom-update` para manter a estrutura.

O atualizador substitui apenas `manifest.md`, `scripts/`, `skills/` e
`templates/`. Ele preserva `config.yaml` e todo o conteúdo de `custom/`.

Scripts base aceitam `--config`, `--state-root` e `--templates-root`. Os
wrappers de uma customização passam esses três valores ao delegar para a base.
Dessa forma, cada customização mantém seu próprio `current-track`, tracks,
slices e templates, sem precisar de uma customização ativa global.
