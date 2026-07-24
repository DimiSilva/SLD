# sld-slice-create

Cria um novo slice na track atual com nome no padrao `<unix-timestamp-seconds>-name`, define como slice atual e prepara base para execucao.

## Objetivo

- criar um incremento pequeno, validavel e cumulativo;
- registrar intencao e criterios de aceite do slice;
- preparar base para planejamento de tasks.

## Entradas obrigatorias

- `name`: nome curto do slice (slugavel, em ingles).
- `intent`: objetivo do slice em 1-2 frases.
- `acceptance`: 2-4 criterios verificaveis.

## Regras de sizing (gate)

O slice deve:

- ter um comportamento principal;
- afetar poucas areas do projeto;
- ter aceite objetivo e verificavel;
- caber em revisao curta.

Se o slice estiver grande, dividir antes de seguir.

## Workflow recomendado apos create

```text
sld-slice-create -> (ajustes livres) -> [sld-slice-clarify, opcional]
-> (ajustes livres) -> sld-slice-plan-tasks -> (ajustes livres)
-> sld-slice-implement -> (ajustes livres) -> sld-slice-close
```

Use `sld-slice-clarify` quando a complexidade do slice, as decisoes abertas ou
a falta de clareza do operador justificarem uma rodada explicita de
clarificacao.

## Execucao padrao

1. ler `.sld/current-track`.
2. executar:

```bash
.sld/scripts/slice/create-slice.sh "<name>"
```

3. abrir `slice.md` criado.
4. preencher no minimo:
   - `Intent`
   - `Track Alignment`
   - `Scope`
   - `Out of Scope`
   - `Acceptance Criteria`
   - `Risks and Assumptions`

## Validacoes obrigatorias

- nome no padrao `<unix-timestamp-seconds>-name`;
- `.current-slice` atualizado na track atual;
- `slice.md` existente;
- criterios de aceite objetivos e testaveis.

## Saida esperada do agente (compacta)

- `slice_name`
- `slice_path`
- resumo em ate 4 bullets
- `status`:
  - `ready_for_task_planning`, quando o slice estiver pronto para `sld-slice-plan-tasks`;
  - `needs_split`, quando o slice estiver grande demais.
