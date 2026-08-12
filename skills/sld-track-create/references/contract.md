# sld-track-create

Cria uma nova track SLD com nome no padrao `<unix-timestamp-seconds>-name`, define a track atual e inicia o contexto base para evolucao.

## Objetivo

- transformar a intencao do usuario em uma track executavel;
- criar estrutura minima da track;
- registrar direcao inicial com escopo claro.

## Entrada obrigatoria

- `name`: nome curto da track (2-4 palavras, em ingles, slugavel).
- `descricao`: intencao principal da track em linguagem natural (prompt do usuario).

## Entrada recomendada

- `context`: problema atual.
- `constraints`: limites tecnicos, operacionais ou de negocio.
- `non_goals`: o que nao sera tratado agora.

## Entrada opcional

- `objectives`: objetivos macro iniciais, quando ja definidos pelo usuario.
- `slices`: slices iniciais, quando ja definidas pelo usuario.

### Objetivos e slices iniciais (opcionais)

- por padrao, criar `roadmap-objectives.md` e `roadmap-slices.md` com as listas
  vazias;
- incluir registros iniciais somente quando objetivos e/ou slices forem
  especificados explicitamente no prompt;
- nao inventar objetivos ou slices a partir da descricao geral da track;
- quando houver slices especificadas, preservar apenas as informacoes
  fornecidas e registrar lacunas em `Open Questions` ou nas notas do roadmap.

## Regras de decisao

- usar o prompt do usuario como fonte primaria.
- fazer suposicoes razoaveis quando houver lacunas pequenas.
- abrir no maximo 3 perguntas de clarificacao apenas para ambiguidades criticas.
- priorizar clarificacoes por impacto: escopo > seguranca/compliance > UX > detalhe tecnico.
- se houver conflito com guidelines nos caminhos configurados em `.sld/config.yaml`, pausar e pedir alinhamento antes de continuar.

## Execucao padrao

1. gerar slug curto e significativo a partir de `name`.
2. executar:

```bash
.sld/scripts/track/create-track.sh "<name>"
```

3. ler o `track.md` criado.
4. preencher/ajustar secoes base com conteudo inicial:
   - `Direction`
   - `Context`
   - `Constraints`
   - `Non-goals`
   - `Open Questions`
5. se o prompt especificar objetivos e/ou slices iniciais, registrar esses
   itens nos roadmaps correspondentes; caso contrario, manter as listas
   vazias.
6. confirmar que `.sld/current-track` aponta para a nova track.

## Workflow recomendado apos create

```text
sld-track-create -> (ajustes livres) -> [sld-track-clarify, opcional]
-> (ajustes livres) -> sld-slice-create
```

Use `sld-track-clarify` quando houver ambiguidades relevantes, complexidade
alta ou quando o operador ainda nao tiver clareza suficiente. Caso contrario,
os ajustes livres podem ser suficientes.

## Validacoes obrigatorias

- nome final da track no padrao `<unix-timestamp-seconds>-name`;
- diretorio da track criado em `<tracks-root>/`;
- arquivos obrigatorios existentes:
  - `track.md`
  - `learnings.md`
  - `roadmap-objectives.md`
  - `roadmap-slices.md`
  - `slices/`
- `.sld/current-track` atualizado com o caminho correto.
- roadmaps sem registros ficticios quando nenhum objetivo ou slice inicial foi
  especificado.

## Checklist de prontidao da track

- direcao da track esta clara e testavel em slices;
- escopo inicial esta delimitado (com non-goals);
- restricoes principais estao registradas;
- perguntas em aberto estao explicitas;
- nao ha conflito conhecido com guideline.

## Saida esperada do agente

- `track_name` criado;
- `track_path` completo;
- resumo em 3-5 bullets do que foi registrado;
- lista curta de pendencias/duvidas (se houver);
- recomendacao de proximo comando (`sld-track-clarify` ou `sld-slice-create`).
