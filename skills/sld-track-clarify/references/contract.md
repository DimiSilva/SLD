# sld-track-clarify

Revisa criticamente a track atual para identificar inconsistencias, ambiguidades e lacunas (tecnicas e de negocio), levantando perguntas objetivas ao desenvolvedor.

## Objetivo

- detectar inconsistencias na track atual;
- identificar lacunas relevantes de negocio, produto, operacao e tecnica;
- questionar o desenvolvedor com contexto e impacto;
- sugerir opcoes de decisao para cada questao levantada.

## Entradas

- `.sld/current-track`
- `track.md` da track ativa
- `.sld/manifest.md`
- `.sld/config.yaml`
- `
## Metodo

1. ler a track atual e validar coerencia entre:
   - `Direction`
   - `Context`
   - `Constraints`
   - `Non-goals`
   - `Open Questions`
2. identificar lacunas que impactam decisao ou execucao.
3. priorizar achados por impacto:
   - escopo
   - seguranca/compliance
   - negocio/operacao
   - UX
   - tecnico
4. levantar no maximo 2 perguntas criticas por rodada.

## Tipos de lacuna que devem ser checados

- regras de negocio ausentes ou ambiguas;
- limites operacionais nao definidos;
- comportamento em erro/timeout/falha parcial;
- criterios de sucesso nao objetivos;
- conflitos com guidelines;
- escopo inflado ou mal delimitado.

Exemplos de perguntas esperadas:

- Qual o limite de tentativas para X?
- O que deve acontecer quando X falhar?
- Qual fallback deve ser aplicado se Y ficar indisponivel?

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
- sem repetir contexto completo da track;
- sem explicacoes longas;
- resposta total com no maximo 12 linhas;
- se nao houver bloqueador critico, responder:
  - `Sem bloqueadores criticos.`
  - `Melhoria opcional: ...`

## Regras de seguranca da decisao

- nao inventar resposta quando a lacuna for critica;
- usar suposicoes apenas para detalhes de baixo impacto;
- se houver conflito com guideline, pausar e pedir alinhamento explicito;
- nao expandir escopo silenciosamente.

## Saida esperada

- lista objetiva de inconsistencias/lacunas encontradas;
- ate 2 perguntas criticas no formato compacto;
- status final:
  - `clarification_needed`, quando houver decisoes abertas relevantes;
  - `no_blocking_inconsistencies`, quando nao houver bloqueadores criticos.

