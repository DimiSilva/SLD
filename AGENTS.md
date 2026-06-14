# AGENTS.md (SLD)

## Objetivo

Padronizar como agentes de IA devem operar a metodologia SLD neste repositorio.

## Fonte de verdade

- Configuracao canonica: `.sld/config.yaml`.
- Em caso de conflito com exemplos textuais, `config.yaml` prevalece.
- Leitura obrigatoria: `.sld/manifest.md` deve ser lido antes de executar qualquer fluxo SLD.

## Convencoes

- Nome de track e slice: `<unix-timestamp-seconds>-name`.
- Nao inventar conteudo quando faltar contexto; registrar em `Open Questions`.

## Estrutura minima esperada

- `.sld/config.yaml`
- `.sld/scripts/`
- `.sld/skills/`
- `.sld/templates/`
- `<tracks-root>/` (definido em `config.yaml`)

## Fluxo base atual

```text
sld.track.create -> sld.track.clarify -> sld.slice.create -> sld.slice.clarify
-> sld.slice.plan-tasks -> sld.slice.implement -> ajustes livres
-> sld.slice.close -> checks -> proxima slice
```

Se o slice estiver grande demais, usar `sld.slice.split` antes de seguir para implementacao.
Quando houver planejamento de multiplas slices, manter e revisar `roadmap.md` da track.

## Regras operacionais

- Antes de criar slice, confirmar track atual em `.sld/current-track`.
- Antes de `sld.slice.implement`, garantir que houve `sld.slice.plan-tasks` na mesma slice.
- Ao final de cada slice, rodar checks de track/slice e naming/arquivos obrigatorios.
- Se houver conflito com ADRs ou guidelines, conforme caminhos em `.sld/config.yaml`, pausar e pedir alinhamento.
- Implementacao durante contexto de track/slice so pode ocorrer via `sld.slice.implement` com tasks previamente planejadas.
- Fora de `sld.slice.implement`, permitir apenas planejamento, clarificacao, check, documentacao e ajustes livres explicitamente permitidos no fluxo.
- Excecao: implementacao fora de `sld.slice.implement` somente com ordem e confirmacao explicita do desenvolvedor no prompt atual.

## Uso das skills com IA

- Referenciar skills por arquivo em `.sld/skills/*.md` (ex.: `@.sld/skills/sld.track.create.md`).
- O agente deve retornar:
  - caminho/identificador do artefato criado ou alterado;
  - resumo curto do que foi feito;
  - pendencias objetivas (se houver).
