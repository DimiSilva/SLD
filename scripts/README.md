# SLD Scripts

Diretorio de scripts utilitarios para apoiar execucao das skills e operacoes do SLD.

Os scripts leem `.sld/config.yaml` por padrao para resolver caminhos
configuraveis. Tambem aceitam `--config`, `--state-root` e
`--templates-root`, permitindo que uma customizacao execute a mesma base com
contexto proprio.

## Estrutura inicial

```text
.sld/scripts/
  README.md
  core/
  track/
  slice/
  check/
  lib/
```

Novas pastas podem ser adicionadas livremente conforme necessidade do projeto.

## Convencao de nomes

Tracks e slices devem ser criados com o padrao:

```text
<unix-timestamp-seconds>-name
```

Exemplos:

```text
1746442983-improve-agent-reliability
1746443052-add-evaluation-baseline
```

## Scripts disponiveis

- `core/timestamp.sh`: imprime unix timestamp em segundos.
- `core/uuid.sh`: gera UUID.
- `core/slugify.sh <texto>`: converte texto em slug.
- `track/create-track.sh <name>`: cria track e define como atual.
- `track/set-current-track.sh <track-name>`: define track atual.
- `slice/create-slice.sh <name>`: cria slice na track atual e define como atual.
- `slice/set-current-slice.sh <slice-name>`: define slice atual na track ativa.
- `check/check-naming.sh`: valida naming de track/slice.
- `check/check-required-files.sh`: valida arquivos obrigatorios.
- `core/update-sld.sh`: atualiza a camada base preservando config e customizações.
- `custom/create-custom.sh <name>`: cria um subprojeto SLD customizado.
- `custom/check-custom.sh [<name>]`: valida customizações.
- `custom/create-custom-skill.sh <custom> <skill> [base]`: cria skill customizada.

Contexto explicito:

```bash
.sld/scripts/track/create-track.sh \
  --config .sld/custom/prototype/config.yaml \
  --state-root .sld/custom/prototype/state \
  --templates-root .sld/custom/prototype/templates \
  "add-prototype-track"
```
