# sld-slice-check

Check tecnico de consistencia do slice ativo.

## Papel da skill

Atuar como guarda tecnico do slice: validar se estrutura, planejamento e direcao tecnica estao consistentes com a track, regras do SLD e padroes do repositorio.

Nao e papel desta skill:

- discutir estrategia de negocio;
- abrir debate amplo de UX;
- redefinir objetivo funcional da track.

Esses pontos pertencem ao `sld-slice-clarify`.

## Objetivo

- verificar conformidade tecnica do slice atual;
- detectar inconsistencias internas do slice;
- validar consistencia track x slice;
- retornar `pass` ou `fail` com correcoes diretas.

## Entradas

- `.sld/current-track`
- `.current-slice` da track ativa
- `slice.md` do slice ativo
- `track.md` da track ativa
- `.sld/config.yaml`
- `.sld/manifest.md`
- `paths.guidelines_root` em `.sld/config.yaml`

## Validacoes obrigatorias

1. Ponteiros e estrutura
- `.sld/current-track` existe e aponta para diretorio valido.
- `.current-slice` existe e aponta para diretorio valido.
- `slice.md` existe.
- naming da slice segue `<unix-timestamp-seconds>-name`.

2. Contrato minimo do slice
- `slice.md` contem secoes obrigatorias:
  - `Intent`
  - `Track Alignment`
  - `Scope`
  - `Out of Scope`
  - `Acceptance Criteria`
  - `Risks and Assumptions`

3. Consistencia interna do slice
- `Scope` nao contradiz `Out of Scope`.
- `Acceptance Criteria` deve ser verificavel e objetiva.
- `Risks and Assumptions` deve registrar riscos/dependencias relevantes quando houver.

4. Consistencia track x slice
- `Track Alignment` deve apontar para `Direction` da track ativa.
- escopo do slice nao deve violar `Constraints` e `Non-goals` da track.

5. Tasks e disciplina de execucao
- secao `Tasks` deve existir no `slice.md`.
- quando houver execucao registrada, deve haver tasks planejadas antes (`sld-slice-plan-tasks` -> `sld-slice-implement`).
- nao deve haver evidencia de execucao fora das tasks planejadas sem justificativa explicita.
- quando houver task de contrato/tipagem/dados no plano, `contracts.md` deve existir na pasta da slice e estar coerente com o escopo.

6. Governanca tecnica
- nenhum desvio explicito de guideline sem registro e alinhamento.
- nenhum sinal de escopo tecnico inflado sem proposta de split.

## Regras de execucao

- deterministico e objetivo (sem opiniao subjetiva);
- foco em conformidade tecnica, consistencia e governanca;
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
- `fail` quando houver qualquer violacao estrutural/governanca ou inconsistencia tecnica relevante.
