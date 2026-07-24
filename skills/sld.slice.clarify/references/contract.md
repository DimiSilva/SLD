# sld.slice.clarify

Revisa criticamente o slice atual para identificar inconsistencias, ambiguidades e lacunas (tecnicas e de negocio), levantando perguntas objetivas ao desenvolvedor.

## Objetivo

- detectar inconsistencias no slice atual;
- identificar lacunas relevantes de negocio, produto, operacao e tecnica;
- questionar o desenvolvedor com contexto e impacto;
- sugerir opcoes de decisao para cada questao levantada.

## Entradas

- `.sld/current-track`
- `.current-slice` da track ativa
- `slice.md` do slice atual
- `track.md` da track ativa (para checagem de alinhamento)
- `.sld/manifest.md`
- `.sld/config.yaml`
- `paths.adrs_root` e `paths.guidelines_root` em `.sld/config.yaml` (quando aplicavel)

## Metodo

1. ler o slice atual e validar coerencia entre:
   - `Intent`
   - `Track Alignment`
   - `Scope`
   - `Out of Scope`
   - `Acceptance Criteria`
   - `Risks and Assumptions`
2. checar alinhamento com a track ativa.
3. identificar lacunas que impactam decisao ou execucao.
4. priorizar achados por impacto:
   - escopo
   - seguranca/compliance
   - negocio/operacao
   - UX
   - tecnico
5. levantar no maximo 2 perguntas criticas por rodada.

## Tipos de lacuna que devem ser checados

- objetivo do slice ambiguo ou com multiplos focos;
- fronteira de escopo fraca (`Scope` vs `Out of Scope`);
- criterios de aceite nao verificaveis;
- regras de negocio ausentes ou ambiguas;
- comportamento em erro/timeout/falha parcial nao definido;
- riscos/dependencias sem tratamento;
- conflito com ADRs/guidelines;
- desalinhamento com `Direction`/`Constraints` da track.

## Regra obrigatoria de resposta

Para cada questao levantada, a skill deve trazer opcoes de solucao.

Formato obrigatorio por questao (compacto):

- `Pergunta`: decisao necessaria.
- `Por que importa`: risco/impacto em 1 linha.
- `Opcoes`: A | B | C (1 frase cada).
- `Recomendacao`: opcao sugerida (A, B ou C) em 1 linha.
- Cada questao deve ser apresentada como topico numerado (`1.`, `2.`) para facilitar resposta do usuario.

Divisoria obrigatoria entre questoes:

- Inserir uma linha `---` entre uma questao e outra.
- Nao usar `---` antes da primeira questao nem apos a ultima.

## Regra de concisao (obrigatoria)

- sem introducao teorica;
- sem repetir contexto completo da track/slice;
- sem explicacoes longas;
- resposta total com no maximo 12 linhas;
- se nao houver bloqueador critico, responder:
  - `Sem bloqueadores criticos.`
  - `Melhoria opcional: ...`

## Regras de seguranca da decisao

- nao inventar resposta quando a lacuna for critica;
- usar suposicoes apenas para detalhes de baixo impacto;
- se houver conflito com ADR/guideline, pausar e pedir alinhamento explicito;
- nao expandir escopo silenciosamente.

## Saida esperada

- lista objetiva de inconsistencias/lacunas encontradas;
- ate 2 perguntas criticas no formato compacto;
- status final:
  - `clarification_needed`, quando houver decisoes abertas relevantes;
  - `no_blocking_inconsistencies`, quando nao houver bloqueadores criticos.
