# sld.retro

Executa retrospectiva de processo da track atual.

## Objetivo

Identificar melhorias no modo de execucao do SLD (nao no conteudo funcional da feature).

## Escopo

- foco: processo, coordenacao, qualidade de planejamento/execucao;
- fora de escopo: redefinir arquitetura/negocio da track.

## Entradas

- `.sld/current-track`
- `track.md`
- `learnings.md`
- slices recentes da track (ultimas 2-3)
- conversa com o agente no periodo analisado (prompts, respostas, desvios e bloqueios)

## Metodo

1. revisar ultimas slices e steps executadas;
2. revisar a conversa com o agente para identificar:
   - falhas de interpretacao do SLD;
   - pontos de ambiguidade de skill/template;
   - comandos mal especificados ou mal executados;
   - loops, retrabalho e perda de contexto;
3. identificar padroes de atrito e retrabalho;
4. consolidar no maximo 5 achados relevantes;
5. priorizar por impacto em:
   - previsibilidade
   - qualidade
   - velocidade
   - reducao de erro da IA.

## Formato obrigatorio de saida

- `status`: `completed`
- `wins` (ate 3)
- `issues` (ate 5), cada item com:
  - `issue`
  - `evidence`
  - `root_cause`
  - `action`
- `apply_now` (ate 3 acoes de maior impacto)
- `owner_suggestion` (quem deveria puxar cada acao: `dev`, `agente`, `ambos`)

## Regras

- resposta curta e acionavel;
- sem teoria;
- sem recomendacoes genericas;
- toda acao deve ser verificavel na proxima slice.
