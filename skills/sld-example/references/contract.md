# sld-example

Formaliza um exemplo reutilizavel a partir de uma implementacao bem-sucedida.

## Papel da skill

Atuar como mecanismo de reaproveitamento pratico: transformar um padrao que funcionou em referencia clara para futuras slices.

Nao e papel desta skill:

- criar guideline global (isso pertence ao escopo da customização);
- registrar exemplo sem evidencia de uso real;
- produzir exemplo generico sem limite de aplicacao.

## Quando usar

Criar exemplo quando houver pelo menos um dos sinais:

- padrao aplicado com sucesso em uma ou mais slices;
- solucao recorrente com risco de reimplementacao inconsistente;
- ganho claro de qualidade/manutencao ao reaplicar o padrao.

## Entradas

- origem: `track` e `slice` de referencia;
- contexto do problema resolvido;
- arquivos/trechos relevantes da implementacao;
- limites e condicoes de aplicacao.

## Regras obrigatorias

- exemplo deve ser especifico e acionavel;
- incluir evidencia de origem (onde foi aplicado);
- incluir quando usar e quando nao usar;
- incluir tradeoffs e riscos;
- evitar copy/paste cego: descrever adaptacoes necessarias.

## Processo recomendado

1. validar se o caso realmente merece exemplo reutilizavel;
2. sintetizar padrao em linguagem objetiva;
3. preencher template `.sld/templates/example.md.tpl`;
4. gerar arquivo em `paths.examples_root` em `.sld/config.yaml`;
5. retornar resumo curto de adocao.

## Saida esperada (compacta)

- `status`: `created` | `not_needed`
- quando `created`:
  - `example_file`
  - `pattern_summary` (ate 3 bullets)
  - `when_to_use`
  - `when_not_to_use`
  - `adoption_steps` (ate 3 itens)
- quando `not_needed`:
  - `reason`

## Criterio de aprovacao

- `created` quando houver evidencia, contexto, aplicacao e limites claros;
- `not_needed` quando o caso for pontual/local sem valor de reuso.
