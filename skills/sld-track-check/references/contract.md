# sld-track-check

Check tecnico de consistencia da track ativa.

## Papel da skill

Atuar como guarda tecnico: validar se o que esta planejado/executado esta consistente com estrutura, regras, padroes e direcao tecnica do repositorio.

Nao e papel desta skill:

- discutir estrategia de negocio;
- explorar UX de alto nivel;
- abrir discussao ampla de produto.

Esses pontos pertencem ao `sld-track-clarify`.

## Objetivo

- verificar conformidade tecnica da track ativa;
- detectar desvios de estrutura e governanca;
- apontar inconsistencias entre track e slices;
- retornar `pass` ou `fail` com correcoes diretas.

## Entradas

- `.sld/current-track`
- `track.md`, `learnings.md` da track ativa
- diretorio `slices/` da track ativa
- `slice.md` dos slices existentes (quando houver)
- `.sld/config.yaml`
- `.sld/manifest.md`
- `paths.adrs_root` em `.sld/config.yaml`
- `paths.guidelines_root` em `.sld/config.yaml`

## Validacoes obrigatorias

1. Estrutura e ponteiros
- `.sld/current-track` existe e aponta para diretorio valido.
- `track.md`, `learnings.md`, `slices/` existem.
- naming da track e slices segue `<unix-timestamp-seconds>-name`.

2. Contrato minimo da track
- `track.md` contem secoes obrigatorias:
  - `Direction`
  - `Context`
  - `Constraints`
  - `Non-goals`
  - `Open Questions`

3. Consistencia track x slices
- cada slice existente deve manter alinhamento claro com a `Direction` da track;
- `Out of Scope` do slice nao deve contradizer `Constraints`/`Non-goals` da track;
- se houver multiplas slices, nao deve haver sobreposicao de escopo sem justificativa.

4. Governanca tecnica
- nenhum desvio explicito de ADR/guideline sem registro e alinhamento;
- plano tecnico da track nao deve propor caminho que viole padroes de desenvolvimento ativos do repositorio.

5. Direcao tecnica e manutencao
- evidencias de planejamento devem ser tecnicamente testaveis;
- riscos tecnicos relevantes devem estar explicitados em track/slices.

## Regras de execucao

- deterministico e objetivo (sem opiniao subjetiva);
- foco em conformidade tecnica e direcao de engenharia;
- nao alterar arquivos automaticamente;
- cada finding deve apontar acao direta de correcao.

## Saida esperada (compacta)

- `status`: `pass` | `fail`
- `findings`: ate 7 itens, cada um com:
  - `severity`: `high` | `medium` | `low`
  - `issue`: problema objetivo
  - `evidence`: arquivo/secao
  - `fix`: acao direta
- `wrong_direction`: `true|false` (quando houver sinais claros de desvio tecnico)
- `fix_now`: ate 3 acoes prioritarias

## Criterio de aprovacao

- `pass` quando nao houver violacao obrigatoria;
- `fail` quando houver qualquer violacao estrutural/governanca ou desvio tecnico relevante.
