# sld-adr

Formaliza uma decisao tecnica recorrente/relevante em ADR usando o template oficial do SLD.

## Papel da skill

Atuar como mecanismo de consolidacao de decisao tecnica global, evitando que decisoes fiquem dispersas em track/slice/chat.

Nao e papel desta skill:

- criar ADR para detalhe local de implementacao sem impacto transversal;
- substituir `sld-track-clarify` para discussoes de negocio/UX;
- produzir ADR vaga sem tradeoff ou plano de adocao.

## Fonte de template

- Template oficial: `.sld/templates/adr.md.tpl`
- Destino: `paths.adrs_root` em `.sld/config.yaml`

## Quando usar

Criar ADR quando houver pelo menos um dos sinais:

- decisao afeta mais de uma track/slice/modulo;
- decisao altera padrao tecnico de referencia;
- decisao envolve tradeoff estrutural relevante;
- ha risco de inconsistencia futura sem regra unica.

## Entradas

- contexto tecnico objetivo da decisao;
- decisao proposta;
- alternativas A/B/C consideradas;
- consequencias e riscos;
- origem (`track`/`slice`/incidente) e plano de adocao.

## Regras obrigatorias

- ADR deve ser especifica, testavel e acionavel;
- registrar tradeoffs (nao apenas beneficios);
- incluir plano de adocao claro;
- se houver conflito com ADR vigente, marcar explicitamente como supersedencia/proposta;
- nao aprovar automaticamente: quando houver alto impacto, solicitar validacao do desenvolvedor.

## Processo recomendado

1. validar se a decisao realmente exige ADR;
2. sintetizar contexto e tradeoffs;
3. preencher `.sld/templates/adr.md.tpl`;
4. gerar arquivo em `paths.adrs_root` em `.sld/config.yaml` seguindo padrao do repositorio;
5. retornar resumo curto da decisao e impactos.

## Saida esperada (compacta)

- `status`: `proposed` | `not_needed` | `conflict_needs_alignment`
- quando `proposed`:
  - `adr_file`
  - `decision_summary` (ate 3 bullets)
  - `adoption_next_steps` (ate 3 itens)
- quando `conflict_needs_alignment`:
  - `conflicting_adr`
  - `alignment_question`

## Criterio de aprovacao

- `proposed` quando decisao estiver completa, consistente e com plano de adocao;
- `not_needed` quando o tema for local e sem impacto transversal;
- `conflict_needs_alignment` quando houver conflito com ADR existente sem decisao explicita.
