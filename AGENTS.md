# AGENTS.md (SLD)

## Objetivo

Padronizar como agentes de IA devem operar a metodologia SLD neste repositorio.

## Fonte de verdade

- Configuracao canonica: `.sld/config.yaml` para o fluxo base; uma customizacao
  pode fornecer seu proprio `config.yaml` explicitamente aos scripts.
- Em caso de conflito com exemplos textuais, `config.yaml` prevalece.
- Leitura obrigatoria: `.sld/manifest.md` deve ser lido antes de executar qualquer fluxo SLD.

## Convencoes

- Nome de track e slice: `<unix-timestamp-seconds>-name`.
- Nao inventar conteudo quando faltar contexto; registrar em `Open Questions`.

## Estrutura minima esperada

- `.sld/config.yaml` ou `config.yaml` da customizacao em execucao
- `.sld/scripts/`
- `.sld/skills/`
- `.sld/templates/`
- `<tracks-root>/` (definido no config do contexto)

## Fluxo base atual

```text
sld-track-create -> (ajustes livres) -> [sld-track-clarify, opcional]
-> (ajustes livres) -> sld-slice-create -> (ajustes livres)
-> [sld-slice-clarify, opcional] -> (ajustes livres)
-> sld-slice-plan-tasks -> (ajustes livres) -> sld-slice-implement
-> (ajustes livres) -> sld-slice-close -> checks -> proxima slice
```

Se o slice estiver grande demais, usar `sld-slice-split` antes de seguir para implementacao.
Quando houver planejamento de multiplas slices, manter e revisar
`roadmap-objectives.md` e `roadmap-slices.md` da track.

Para ajustes pequenos, `sld-slice-one-shot` combina criacao, planejamento e
implementacao. Para uma slice existente, `sld-slice-increment` permite
incrementos sem plano formal.

## Regras operacionais

- Antes de criar slice, confirmar `current-track` no state root do contexto.
- Ao executar uma customizacao, sempre passar o `config.yaml`, `state-root` e
  `templates-root` correspondentes; nao usar estado global por engano.
- Ao usar `sld-slice-implement`, garantir que houve `sld-slice-plan-tasks` na mesma slice. O `sld-slice-one-shot` e a unica skill que pode gerar esse plano internamente antes de implementar.
- Ao final de cada slice, rodar checks de track/slice e naming/arquivos obrigatorios.
- Se houver conflito com guidelines, conforme caminhos no config do
  contexto, pausar e pedir alinhamento.
- Implementacao durante contexto de track/slice so pode ocorrer via `sld-slice-implement` com tasks previamente planejadas, via `sld-slice-one-shot`, ou via `sld-slice-increment` sobre uma slice existente.
- Fora de `sld-slice-implement`, permitir implementacao somente por
  `sld-slice-one-shot` ou `sld-slice-increment`; as demais acoes ficam
  restritas a planejamento, clarificacao, check, documentacao e ajustes livres
  explicitamente permitidos no fluxo.
- Excecao: implementacao fora de `sld-slice-implement`, `sld-slice-one-shot`
  e `sld-slice-increment` somente com ordem e confirmacao explicita do
  desenvolvedor no prompt atual.

## Uso das skills com IA

- Referenciar skills por `SKILL.md` dentro de `.sld/skills/<skill-name>/`.
- O agente deve retornar:
  - caminho/identificador do artefato criado ou alterado;
  - resumo curto do que foi feito;
  - pendencias objetivas (se houver).
