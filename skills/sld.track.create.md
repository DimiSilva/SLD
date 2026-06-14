# sld.track.create

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
- `constraints`: limites tecnicos/produto.
- `non_goals`: o que nao sera tratado agora.

## Regras de decisao

- usar o prompt do usuario como fonte primaria.
- fazer suposicoes razoaveis quando houver lacunas pequenas.
- abrir no maximo 3 perguntas de clarificacao apenas para ambiguidades criticas.
- priorizar clarificacoes por impacto: escopo > seguranca/compliance > UX > detalhe tecnico.
- se houver conflito com ADRs ou guidelines nos caminhos configurados em `.sld/config.yaml`, pausar e pedir alinhamento antes de continuar.

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
5. confirmar que `.sld/current-track` aponta para a nova track.

## Workflow obrigatorio apos create

```text
sld.track.create -> sld.track.clarify -> sld.slice.create
```

Nao pular `sld.track.clarify` quando ainda houver ambiguidades relevantes.

## Validacoes obrigatorias

- nome final da track no padrao `<unix-timestamp-seconds>-name`;
- diretorio da track criado em `<tracks-root>/`;
- arquivos obrigatorios existentes:
  - `track.md`
  - `learnings.md`
  - `slices/`
- `.sld/current-track` atualizado com o caminho correto.

## Checklist de prontidao da track

- direcao da track esta clara e testavel em slices;
- escopo inicial esta delimitado (com non-goals);
- restricoes principais estao registradas;
- perguntas em aberto estao explicitas;
- nao ha conflito conhecido com ADR/guideline.

## Saida esperada do agente

- `track_name` criado;
- `track_path` completo;
- resumo em 3-5 bullets do que foi registrado;
- lista curta de pendencias/duvidas (se houver);
- recomendacao de proximo comando (`sld.track.clarify` ou `sld.slice.create`).
