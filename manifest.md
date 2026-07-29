# SLD — Slice-Led Development

## 1. Visão geral

**SLD — Slice-Led Development** é uma metodologia de desenvolvimento pensada para fluxos de trabalho assistidos por IA, onde o progresso é conduzido por pequenos incrementos chamados **slices**.

Em vez de organizar o desenvolvimento em torno de uma especificacao fechada de entrega, o SLD organiza o trabalho em torno de **tracks evolutivas**. Cada track representa uma linha contínua de evolução do sistema, produto, arquitetura, experiência ou qualidade. Essa track é avançada por slices pequenos, validáveis e cumulativos.

A ideia central é:

> **Uma track da direcao. Um slice entrega avanco. Tasks organizam execucao. O aprendizado melhora o proximo slice.**

O SLD nasce da necessidade de adaptar práticas de Spec-Driven Development para um uso mais realista com agentes de IA. Em muitos fluxos assistidos por IA, o desenvolvedor já discute intenção, contexto técnico, restrições e possíveis caminhos antes de gerar qualquer documentação formal. Por isso, separar rigidamente “negócio” de “técnica” pode se tornar artificial e burocrático.

O SLD propõe um modelo mais incremental, evolutivo e orientado a aprendizado.

---

## 1.1 Regra normativa de precedencia

A partir desta revisao, o fluxo operacional oficial do SLD e:

```text
sld-track-create -> (ajustes livres) -> [sld-track-clarify, opcional]
-> (ajustes livres) -> sld-slice-create -> (ajustes livres)
-> [sld-slice-clarify, opcional] -> (ajustes livres)
-> sld-slice-plan-tasks -> (ajustes livres) -> sld-slice-implement
-> (ajustes livres) -> sld-slice-close -> checks
```

Em caso de conflito entre secoes, esta secao e o capitulo `## 6. Fluxo operacional atual` prevalecem.

## 2. Motivação

Fluxos tradicionais de desenvolvimento orientado por especificação geralmente seguem uma sequência parecida com:

```text
spec → clarify → plan → tasks → implement
```

Esse modelo funciona bem quando a entrega e relativamente bem delimitada e quando a especificação representa um contrato claro do que precisa ser construído.

No entanto, em fluxos reais com IA, alguns problemas aparecem:

* A especificação tende a ficar grande ou abstrata demais.
* O plano técnico muitas vezes já surge durante a conversa inicial com o agente.
* A separação entre negócio e técnica pode gerar perda de contexto.
* A implementação pode ficar grande demais para ser revisada com segurança.
* Aprendizados obtidos durante a implementação normalmente ficam perdidos no chat.
* Features, melhorias técnicas e objetivos de qualidade raramente são realmente “finalizados”.

O SLD tenta resolver esses problemas usando uma unidade menor e mais controlável: o **slice**.

---

## 3. Conceitos principais

### 3.1 Track

Uma **track** é uma trilha evolutiva contínua.

Ela representa um objetivo, tema ou área de evolução que pode receber múltiplos slices ao longo do tempo. Uma track não precisa ser uma entrega fechada. Ela pode representar uma melhoria contínua, uma frente técnica, uma iniciativa de produto ou uma área do sistema que será amadurecida progressivamente.

Exemplos de tracks:

```text
improve-agent-reliability
modernize-auth-flow
reduce-billing-complexity
improve-checkout-conversion
increase-observability-for-critical-jobs
improve-developer-experience
```

Uma track pode durar dias, semanas, meses ou permanecer aberta por tempo indeterminado.

A track deve conter:

* direção geral;
* contexto;
* estado atual;
* resultado desejado;
* princípios;
* restrições;
* invariantes;
* histórico de slices;
* aprendizados consolidados.

### 3.2 Slice

Um **slice** é um incremento pequeno, validável e cumulativo dentro de uma track.

Cada slice deve avançar a track de forma concreta, mas sem tentar resolver tudo de uma vez. Um slice deve ter uma intenção clara, escopo pequeno, critérios de aceite verificáveis e uma direção técnica suficiente para orientar a execução.

Um bom slice deve ser:

* pequeno;
* específico;
* revisável;
* validável;
* alinhado à track;
* limitado em escopo;
* capaz de gerar aprendizado.

Um slice ruim normalmente:

* mistura múltiplos objetivos;
* tenta resolver uma entrega inteira de uma vez;
* mistura entrega, reestruturacao e infraestrutura sem necessidade;
* exige muitas decisões abertas;
* não tem critério claro de validação;
* é grande demais para ser revisado com confiança.

### 3.3 Task

Uma **task** e a acao concreta da slice.

Tasks devem ser pequenas, ordenadas e verificaveis. Elas guiam execucao e revisao.

### 3.4 Learning

Um **learning** é um aprendizado extraído da execução de um slice.

Esse é um dos diferenciais centrais do SLD. O objetivo não é apenas entregar resultado concreto, mas também melhorar o próprio processo e o repositório para que os próximos slices sejam melhores.

Um learning pode virar:

* guideline;
* exemplo de implementação;
* checklist;
* atualização da track;
* melhoria em convenções do projeto;
* nova heurística para criação de slices.

---

## 4. Hierarquia do SLD

```text
Track
  └── Slice
        └── Task
```

Essa hierarquia define a escala de cada elemento:

* **Track**: direcao evolutiva.
* **Slice**: avanco pequeno e concreto.
* **Task**: acao executavel.

---

## 5. Estrutura base de diretórios

Estrutura base recomendada:

```text
.sld/
  manifest.md
  config.yaml
  templates/
    track.md.tpl
    slice.md.tpl
    example.md.tpl
    roadmap-objectives.md.tpl
    roadmap-slices.md.tpl
  skills/
    README.md
    sld-track-create/SKILL.md
    sld-slice-implement/SKILL.md
  scripts/
    README.md
    core/
    track/
    slice/
    check/
    lib/
  current-track

<tracks-root>/
  <track-name>/
    track.md
    learnings.md
    roadmap-objectives.md
    roadmap-slices.md
    .current-slice
    slices/
      <unix-timestamp-seconds>-<slice-name>/
        slice.md
```

### 5.0 `.sld/manifest.md`

Manifesto oficial da metodologia SLD no repositório.

Esse arquivo define conceitos, fluxo, estrutura, princípios, anti padrões e baseline operacional da metodologia.

### 5.0.1 `.sld/config.yaml` (obrigatorio)

Arquivo canonico de configuracao consumido pelos scripts do SLD.

Esse arquivo define variaveis de caminho e convencoes operacionais (ex.: `paths.tracks_root`).

Schema minimo esperado:

```yaml
version: 1
paths:
  tracks_root: tracks
  state_root: .sld
  templates_root: .sld/templates
naming:
  track_pattern: "<unix-timestamp-seconds>-name"
  slice_pattern: "<unix-timestamp-seconds>-name"
```

### 5.0.2 Fonte de verdade

Em caso de conflito entre exemplos textuais e configuracao, `config.yaml` prevalece.

Uma configuracao passada explicitamente ao script com `--config` prevalece
para aquela execucao. O contexto tambem pode definir `--state-root` e
`--templates-root`.

### 5.0.3 Obrigatorio vs opcional

Obrigatorio para operacao automatizada dos scripts:

* `.sld/config.yaml`
* `.sld/scripts/`
* `<tracks-root>/`

Opcional, mas recomendado:

* `.sld/skills/`
* `.sld/templates/`

### 5.1 Contexto e estado da execucao

Os scripts base usam `.sld/config.yaml` e `.sld/current-track` por padrao.
Eles aceitam `--config`, `--state-root` e `--templates-root`, permitindo que
uma customizacao execute a mesma implementacao com contexto isolado.

O arquivo `current-track` fica dentro do state root. O `.current-slice` fica
dentro da track apontada pelo contexto.

Exemplo:

```text
<state-root>/current-track -> <tracks-root>/1746442983-improve-agent-reliability
```

### 5.1.1 `.sld/scripts/` (obrigatorio para execucao automatizada)

Diretorio com scripts utilitarios usados por skills e fluxos operacionais.
Scripts base devem manter o comportamento padrao quando nenhum contexto for
informado e aceitar contexto explicito quando uma customizacao os chamar.

Novas pastas dentro de `.sld/scripts/` podem ser adicionadas livremente conforme necessidade do projeto.

### 5.2 `<tracks-root>/<track-name>/.current-slice`

Arquivo que aponta para o slice atualmente ativo dentro da track.

Exemplo:

```text
slices/1746443052-add-evaluation-baseline
```

### 5.2.1 Convencao de nome para tracks e slices

Tracks e slices devem ser nomeados no padrao:

```text
<unix-timestamp-seconds>-name
```

Exemplos:

```text
1746442983-improve-agent-reliability
1746443052-add-evaluation-baseline
```

### 5.3 `track.md`

Documento principal da track.

Ele deve representar o estado atual da direção evolutiva, não um histórico completo de tudo que já aconteceu.

### 5.4 `learnings.md`

Aprendizados consolidados da track.

### 5.4.1 `roadmap-objectives.md`

Roadmap dos objetivos macro que orientam a evolucao da track.

### 5.4.2 `roadmap-slices.md`

Roadmap tecnico das slices planejadas para contribuir com os objetivos da track.

### 5.5 `slice.md`

Documento principal do slice atual.

Na baseline atual, todas as informações do slice podem viver dentro de um único `slice.md`. Caso o arquivo cresça demais, podemos separar em arquivos específicos, como:

```text
implementation.md
refinement.md
learning.md
```

### 5.5.1 `contracts.md` (opcional por slice)

Quando a slice envolver contrato/dados relevantes, usar um unico arquivo `contracts.md` dentro da pasta da slice.

Conteudo sugerido:

* `Schemas`
* `Types`
* `Enums`
* `Mapping Rules`
* `Validation Rules` (quando aplicavel)

Nao criar `contracts.md` quando nao houver necessidade real de contrato/dados.

### 5.6 `.sld/templates/` (opcional)

Diretorio opcional com templates reutilizaveis para gerar artefatos da metodologia (`track`, `slice`, `example`, `roadmap-objectives`, `roadmap-slices`).

### 5.7 `.sld/skills/` (opcional)

Diretorio com as skills SLD no formato Agent Skills. Cada skill deve possuir
um diretorio proprio e um `SKILL.md` com `name` e `description`. Contratos
detalhados adicionais devem ficar em `references/` dentro da skill.

### 5.8 `.sld/custom/`

Diretorio reservado para subprojetos SLD do projeto consumidor. Seu conteudo
nao pertence a camada base e nao pode ser removido ou sobrescrito por
atualizacoes do SLD.

Cada customizacao deve possuir `manifest.md`, `config.yaml`, `scripts/`,
`skills/`, `templates/` e `state/`. A configuracao da customizacao e autonoma
para a execucao daquele subprojeto e deve declarar seus proprios `paths` e
`naming`.

Uma customizacao completa implementa toda a estrutura base do SLD. Para cada
skill base `sld-<area>-<operacao>`, deve existir uma skill especializada com o
nome `sld-<custom-name>-<area>-<operacao>`. Por exemplo:

```text
sld-slice-create
sld-prototype-slice-create
```

A skill especializada deve declarar explicitamente a skill base que herda,
preservar seu fluxo e registrar apenas as regras adicionais da customizacao.
Ela nao deve editar a skill base.

Os scripts dentro da customizacao devem espelhar os scripts operacionais base.
Por padrao, sao wrappers que delegam aos scripts base passando explicitamente
o `config.yaml`, `state/` e `templates/` da customizacao. Implementacoes
proprias podem substituir wrappers quando houver comportamento especializado.
Nao e necessario um arquivo global de customizacao ativa.

Estrutura gerada por `sld-custom-create`:

```text
.sld/custom/<custom-name>/
  manifest.md
  config.yaml
  state/
    current-track
  tracks/
  guidelines/
  examples/
  scripts/
    run-base.sh
    track/
    slice/
    check/
  skills/
    sld-<custom-name>-track-create/
      SKILL.md
    sld-<custom-name>-slice-create/
      SKILL.md
    ...todas as skills base especializadas...
  templates/
    track.md.tpl -> template base herdado
    slice.md.tpl -> template base herdado
```

Por padrao, os wrappers usam os templates da camada base quando a
customizacao ainda nao possui templates proprios. Ao existir um template no
diretorio da customizacao, ele passa a ser usado pelo wrapper.

### 5.9 Atualizacao da camada base

`.sld/scripts/core/update-sld.sh` atualiza a camada base a partir de uma fonte
local ou remota. A operacao deve preservar `.sld/config.yaml`, `.sld/custom/`
e artefatos de trabalho fora da camada base.

---

## 6. Fluxo operacional atual

O fluxo operacional oficial do SLD e:

```text
sld-track-create
  ↓
ajustes livres
  ↓
sld-track-clarify (opcional, quando necessario)
  ↓
sld-slice-create
  ↓
ajustes livres
  ↓
sld-slice-clarify (opcional, quando necessario)
  ↓
ajustes livres
  ↓
sld-slice-plan-tasks
  ↓
sld-slice-implement
  ↓
sld-slice-close
  ↓
checks
  ↓
proxima slice
```

Esse fluxo cria um loop evolutivo:

```text
track → slice → implement → refine → learn → update track → next slice
```

As etapas `sld-track-clarify` e `sld-slice-clarify` sao opcionais. Devem ser
usadas quando a complexidade da feature, a quantidade de decisoes abertas ou
a falta de clareza do operador justificar uma rodada explicita de
clarificacao. Os ajustes livres continuam permitidos entre as etapas e podem
ser suficientes quando o contexto ja estiver claro.

---

## 7. Skills base

A baseline atual do SLD opera com estes comandos centrais:

```text
sld-track-create
sld-track-clarify

sld-slice-create
sld-slice-split
sld-slice-clarify

sld-slice-plan-tasks
sld-slice-implement
sld-slice-close

sld-track-check
sld-slice-check
```

### 7.1 `sld-track-create`

Cria uma nova track evolutiva e marca essa track como a track atual.

Responsabilidades:

* criar a pasta da track;
* criar `track.md`;
* criar `learnings.md`;
* criar diretório `slices/`;
* atualizar `.sld/current-track`;
* registrar contexto, objetivo e direção desejada.

A track criada não precisa estar perfeita. Ela precisa ser boa o suficiente
para iniciar ajustes livres, uma clarificação opcional e a criação de slices.

### 7.2 `sld-track-clarify`

Detalha, amadurece e reduz ambiguidades da track atual.

Responsabilidades:

* melhorar o entendimento da direção da track;
* identificar lacunas;
* propor refinamentos no `track.md`;
* levantar perguntas quando necessário;
* registrar restrições, invariantes e não objetivos;
* separar direção durável de ideias operacionais prematuras.

Essa skill não tem como foco validar consistência formal. Seu papel principal é enriquecer e detalhar a track.

### 7.3 `sld-slice-create`

Cria o próximo slice da track atual e marca esse slice como o slice atual.

Responsabilidades:

* ler a track atual;
* considerar aprendizados anteriores;
* propor um incremento pequeno;
* criar a pasta do slice;
* criar `slice.md`;
* atualizar `.current-slice` da track;
* impedir slices grandes demais.

Essa skill deve ser restritiva com tamanho de slice.

Um slice deve ser rejeitado ou dividido quando:

* tiver mais de um comportamento principal;
* tocar areas demais do projeto;
* misturar entrega, reestruturacao e infraestrutura;
* depender de muitas decisões abertas;
* não tiver validação clara;
* não puder ser revisado em pouco tempo;
* tentar resolver a track inteira.

### 7.3.1 `sld-slice-split`

Propõe a divisao de uma slice grande em slices menores antes da implementacao.

Responsabilidades:

* avaliar se o slice atual esta grande demais;
* propor ate 2 slices menores;
* sugerir ordem de execucao;
* explicitar tradeoffs e riscos principais de cada proposta.

Essa skill nao cria slices automaticamente; ela prepara uma proposta para validacao do desenvolvedor.

### 7.4 `sld-slice-clarify`

Detalha, amadurece e reduz ambiguidades do slice atual.

Responsabilidades:

* melhorar intenção do slice;
* clarificar escopo;
* explicitar fora de escopo;
* refinar critérios de aceite;
* melhorar direção técnica;
* identificar dúvidas antes da implementação;
* preparar o slice para planejamento de tasks.

Essa skill ajuda a garantir que o slice está pronto para execução, mas sem substituir uma validação formal de consistência.

### 7.5 `sld-slice-plan-tasks`

Planeja as tasks da slice atual.

Responsabilidades:

* criar tasks pequenas e ordenadas;
* definir validação esperada;
* registrar riscos e pontos de atenção;
* evitar expandir escopo silenciosamente;
* tasks devem seguir formato unico de checklist (`- [ ] Tn — titulo`) com metadados em linhas indentadas.
* formato invalido, task em linha unica sem metadados ou checkbox duplicado deve bloquear o plano.

As tasks devem ter formato consistente e legivel para revisao rapida pelo desenvolvedor.

### 7.6 `sld-slice-implement`

Executa as tasks planejadas da slice atual.

Responsabilidades:

* executar apenas tasks planejadas;
* respeitar escopo do slice;
* atualizar o `slice.md` com resultados;
* registrar desvios, bloqueios e decisões;
* preparar o fechamento da slice.

`sld-slice-implement` não deve expandir o escopo do slice sem sinalizar. Se uma task revelar trabalho adicional significativo, isso deve preferencialmente virar outro slice.

Regra hard de execucao:

* implementacao em contexto de track/slice so pode ocorrer via `sld-slice-implement` com tasks previamente planejadas;
* fora de `sld-slice-implement`, o fluxo deve ficar restrito a planejamento, clarificacao, checks, documentacao e ajustes livres explicitamente permitidos no fluxo;
* excecoes so podem ocorrer com ordem e confirmacao explicita do desenvolvedor no prompt atual.

### 7.7 `sld-slice-close`

Fecha a slice ativa, registra aprendizado local, consolida aprendizados na track e atualiza artefatos de acompanhamento.

---

## 8. Ciclo da slice

Uma slice passa por quatro momentos operacionais:

* criacao e clarificacao;
* planejamento de tasks;
* implementacao das tasks planejadas;
* fechamento com aprendizado local.

### 8.1 Planejamento de tasks

Objetivo: transformar a intencao da slice em acoes pequenas, ordenadas e verificaveis.

Foco:

* menor conjunto coerente de mudancas;
* validacao objetiva por task;
* riscos praticos;
* arquivos afetados;
* limite claro de escopo.

### 8.2 Implementacao

Objetivo: executar apenas as tasks planejadas da slice.

Foco:

* entrega minima necessaria;
* comportamento esperado;
* validacoes essenciais;
* registro de evidencias;
* desvios explicitados.

### 8.3 Fechamento e learning

Objetivo: encerrar a slice, registrar aprendizado local e atualizar a track.

Foco:

* o que funcionou;
* o que nao funcionou;
* sugestao para proxima slice;
* itens executados fora do escopo original;
* aprendizados que merecem consolidacao futura.

Estruturas de direcionamento do projeto (guidelines, examples) devem ser tratadas com rigor: so levantar propostas quando houver relevancia alta e beneficio claro.
Pontos pouco relevantes devem permanecer como aprendizado da slice/track, sem gerar artefatos globais.

---

## 9. Template base de `track.md`

```md
# Track: <nome-da-track>

## Direction
Descreva a direção evolutiva desta track.

## Context
Explique o contexto que levou à criação da track.

## Constraints
Liste restrições técnicas, de produto, arquitetura, prazo ou operação.

## Non-goals
Liste o que esta track explicitamente não pretende resolver agora.

## Open Questions
Liste perguntas ainda em aberto.
```

---

## 10. Template base de `slice.md`

```md
# Slice <número>: <nome-do-slice>

## Intent
Descreva o avanço específico que este slice deve entregar.

## Track Alignment
Explique como este slice aproxima a track da direção desejada.

## Scope
Liste o que está dentro do slice.

## Out of Scope
Liste o que está explicitamente fora do slice.

## Acceptance Criteria
Liste critérios verificáveis para considerar o slice entregue.

## Risks and Assumptions
Liste riscos, hipóteses e dependências.

## Tasks
Status: not_planned

- (preencher em `sld-slice-plan-tasks`)

## Execution Result
Status: not_started

- (preencher em `sld-slice-implement`)

## Learning (local)

- what_worked:
- what_did_not_work:
- next_slice_hint:
- out_of_scope_notes:
```

---

## 11. Regras de tamanho de slice

A qualidade do SLD depende diretamente do tamanho dos slices.

Um slice deve ser pequeno o suficiente para que:

* o desenvolvedor consiga revisar com atenção;
* a IA consiga manter contexto sem se perder;
* os critérios de aceite sejam claros;
* a implementação seja validável;
* o refinamento seja objetivo;
* o aprendizado seja específico.

### Heurísticas para slice adequado

Um slice provavelmente está no tamanho certo quando:

* possui uma intenção principal;
* altera poucas areas do projeto;
* pode ser descrito em poucas frases;
* possui critérios de aceite simples;
* gera um avanço observável;
* não depende de muitas decisões em aberto.

### Sinais de slice grande demais

Um slice provavelmente está grande demais quando:

* contém “e também” repetidas vezes;
* mistura múltiplos objetivos;
* exige refatoração ampla antes de entregar valor;
* altera muitos módulos sem uma razão clara;
* não cabe em uma revisão curta;
* possui muitos critérios de aceite independentes;
* parece uma entrega inteira;
* tenta resolver problemas futuros demais.

Quando um slice estiver grande demais, ele deve ser dividido.

---

## 12. Clarify vs Consistency

No SLD, `clarify` e `consistency` são conceitos diferentes.

### Clarify

Clarify significa detalhar, amadurecer e reduzir ambiguidade.

Exemplos:

* melhorar descrição da track;
* tornar intenção do slice mais clara;
* transformar ideias soltas em direção concreta;
* fazer perguntas úteis;
* explicitar não objetivos;
* melhorar critérios de aceite.

### Consistency

Consistency significa validar alinhamento, detectar conflitos e sugerir ajustes.

Exemplos:

* verificar se o slice está alinhado à track;
* detectar escopo inflado;
* encontrar contradições;
* validar se as tasks respeitam o estado atual;
* verificar se aprendizados foram registrados;
* identificar se uma decisão deveria virar guideline.

Skills de consistência disponíveis:

```text
sld-track-check
sld-slice-check
```

---

## 13. Estados sugeridos

O SLD pode começar simples, mas é útil definir alguns estados esperados.

### Estados de track

```text
draft
clarified
active
paused
closed
```

### Estados de slice

```text
draft
clarified
implementation_planned
implementation_done
refinement_planned
refinement_done
learning_planned
learning_done
closed
```

Esses estados ajudam as skills a evitar ações fora de ordem.

Exemplos:

* não planejar refinement antes de implementation;
* não planejar learning antes de refinement;
* não criar próximo slice sem registrar aprendizado do slice atual, salvo exceção explícita;
* nao executar implementacao sem tasks planejadas; quando nao houver tasks relevantes, registrar justificativa objetiva.

---

## 14. Princípios do SLD

### 14.1 Slice antes de escopo grande

Sempre preferir pequenos avanços validáveis em vez de grandes planos.

### 14.2 Aprendizado como entrega

Cada slice deve buscar entregar avanço concreto e aprendizado.

### 14.3 Ajustes depois da implementacao

Não tentar prever todos os ajustes antes de existir entrega real.

### 14.4 Learning no fechamento

Não consolidar aprendizado antes de observar a execução da slice.

### 14.5 Track viva, não documento morto

A track deve representar a direção atual consolidada, não apenas um histórico bruto.

### 14.6 Escopo explícito

Todo slice deve deixar claro o que está dentro e o que está fora.

### 14.7 IA como parceira de evolução

A IA deve ajudar a propor, dividir, executar, refinar e aprender, mas o desenvolvedor valida direção, qualidade e decisões.

---

## 15. Antipadrões

### 15.1 Slice gigante

Um slice que tenta resolver uma entrega inteira ou uma refatoração ampla demais.

### 15.2 Track genérica demais

Uma track sem direção clara, como “melhorar o sistema”.

### 15.3 Aprendizado não registrado

Executar slices sem consolidar o que foi aprendido.

### 15.4 Refinamento prematuro

Planejar refinamento detalhado antes da implementação existir.

### 15.5 Learning prematuro

Gerar guidelines sem evidência suficiente da execução.

### 15.6 IA expandindo escopo silenciosamente

Permitir que o agente implemente mudanças fora do slice sem registrar ou pedir validação.

### 15.7 Track virando backlog infinito

Usar a track como lista de desejos sem priorização ou direção.

---

## 16. Exemplo de uso

### Criar uma track

```text
sld-track-create improve-agent-reliability
```

Resultado esperado:

```text
.sld/current-track
<tracks-root>/1746442983-improve-agent-reliability/track.md
<tracks-root>/1746442983-improve-agent-reliability/learnings.md
<tracks-root>/1746442983-improve-agent-reliability/slices/
```

### Clarificar a track

```text
sld-track-clarify
```

Resultado esperado:

* perguntas relevantes;
* melhorias no `track.md`;
* princípios e restrições mais claros;
* não objetivos explicitados.

### Criar um slice

```text
sld-slice-create add-evaluation-baseline
```

Resultado esperado:

```text
<tracks-root>/1746442983-improve-agent-reliability/slices/1746443052-add-evaluation-baseline/slice.md
<tracks-root>/1746442983-improve-agent-reliability/.current-slice
```

### Clarificar o slice

```text
sld-slice-clarify
```

Resultado esperado:

* intenção mais clara;
* escopo reduzido;
* critérios de aceite verificáveis;
* direção técnica suficiente.

### Planejar tasks

```text
sld-slice-plan-tasks
```

Resultado esperado:

* tasks pequenas;
* ordem sugerida;
* validações esperadas;
* riscos práticos.

### Implementar slice

```text
sld-slice-implement
```

Resultado esperado:

* tasks executadas;
* resultado registrado;
* pendências documentadas.

### Fechar slice

```text
sld-slice-close
```

Resultado esperado:

* aprendizado local registrado;
* learnings da track atualizados;
* registry de consolidacao atualizado;
* track atualizada se necessário.

---

## 17. Skills de consistência e evolução

Além das skills base, o SLD opera com as seguintes skills:

```text
sld-track-check
sld-slice-check
sld-retro
sld-example
sld-track-roadmap-objectives
sld-track-roadmap-slices
sld-learning-consolidate
```

### `sld-track-check`

Valida consistência da track.

### `sld-slice-check`

Valida consistência do slice atual.

### `sld-retro`

Faz retrospectiva de uma track ou conjunto de slices.

### `sld-example`

Transforma uma implementação boa em exemplo reutilizável.

### `sld-track-roadmap-objectives`

Cria ou atualiza o roadmap de objetivos macro da track ativa.

### `sld-track-roadmap-slices`

Cria ou atualiza o roadmap técnico de slices da track ativa, vinculando slices
planejadas aos objetivos correspondentes.

### `sld-learning-consolidate`

Consolida aprendizados locais de track/slices e propõe promoção para camadas mais altas do projeto quando houver ganho real.
Quando a promocao for de reforco operacional de agente, registrar em arquivo de orientacoes do agente definido pelo projeto.

---

## 18. Resumo

O SLD organiza o desenvolvimento em torno de evolução contínua.

Em vez de tentar transformar uma especificação grande em implementação, o método propõe trabalhar com tracks vivas e slices pequenos.

A unidade central de progresso não é a spec, nem o plano, nem a task.

A unidade central de progresso é o **slice**.

```text
Track → Slice → Task → Learning
```

O ciclo principal é:

```text
Create track → Clarify track → Create slice → Clarify slice → Plan tasks → Implement slice → Close slice → Next slice
```

O objetivo é que cada slice entregue três coisas:

1. avanco concreto no projeto;
2. melhoria na qualidade da implementação;
3. aprendizado reutilizável para os próximos slices.

Essa combinação cria um fluxo de desenvolvimento mais adequado para colaboração com IA: pequeno, iterativo, validável e evolutivo.

## 19. Registry de consolidacao de learning

Arquivo canonico de controle:

- `<tracks-root>/_learning-consolidation-log.md`

Objetivo:

- registrar quais learnings de slices fechadas ja foram revisados;
- evitar reprocessamento recorrente dos mesmos itens;
- manter rastreabilidade de promocao (`pending_review|promoted|kept_local|discarded`).
