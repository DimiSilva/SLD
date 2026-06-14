# SLD - Slice-Led Development

SLD e um framework de trabalho com IA orientado por tracks e slices. Ele foi desenhado para projetos de qualquer natureza, nao apenas software: uma track define uma direcao evolutiva, um slice entrega um avanco pequeno e verificavel, e tasks organizam a execucao.

## Instalar em um projeto

Na raiz do projeto consumidor:

```bash
/caminho/para/sld/install.sh
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
```

Por padrao, os artefatos de trabalho ficam em `docs/tracks`, `docs/adrs`, `docs/guidelines` e `docs/examples`, conforme `.sld/config.yaml`.

## Opcoes

```bash
SLD_TARGET_DIR=/repo/consumidor /caminho/para/sld/install.sh
SLD_INSTALL_AGENTS=1 /caminho/para/sld/install.sh
SLD_FORCE=1 /caminho/para/sld/install.sh
SLD_FORCE_CONFIG=1 /caminho/para/sld/install.sh
SLD_TRACKS_ROOT=work/tracks /caminho/para/sld/install.sh
```

- `SLD_TARGET_DIR`: projeto onde o framework sera instalado. Padrao: diretorio atual.
- `SLD_INSTALL_AGENTS=1`: copia `AGENTS.md` para a raiz do projeto se nao existir.
- `SLD_FORCE=1`: permite sobrescrever `AGENTS.md` quando `SLD_INSTALL_AGENTS=1`.
- `SLD_FORCE_CONFIG=1`: permite sobrescrever `.sld/config.yaml`; sem isso, configuracao existente e preservada.
- `SLD_TRACKS_ROOT`, `SLD_ADRS_ROOT`, `SLD_GUIDELINES_ROOT`, `SLD_EXAMPLES_ROOT`: customizam caminhos iniciais no `config.yaml`.

## Fluxo atual

```text
sld.track.create -> sld.track.clarify -> sld.slice.create -> sld.slice.clarify
-> sld.slice.plan-tasks -> sld.slice.implement -> ajustes livres
-> sld.slice.close -> checks -> proxima slice
```

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
