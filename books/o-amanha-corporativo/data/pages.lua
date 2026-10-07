-- Os artigos do livro, em português (a língua original; a tradução fica em data/en/).
--
-- Marcação que o build.lua entende:
--   [[id]] ou [[id|rótulo]]   link interno (conferido no build)
--   {{fonte}}                 citação numerada de data/sources.lua
--   **negrito**  *itálico*    ## Subtítulo   - item   > citação
--   "| a | b |"               tabela
--   ::: read / gm / real / ad / rule  … :::   caixas (leia em voz alta, nota do Mestre,
--                             no mundo real, mensagem do patrocinador, regra pé no chão)
--   @npc:<id>                 ficha de um personagem do Mestre (data/npcs.lua)
--   @board @estemps @regests @implants @localmap   o mapa e as tabelas geradas
--
-- kind: "history" = fato documentado, "fiction" = inventado, "mixed" = ficção sobre fato real.
-- O capítulo de cada artigo é definido em data/chapters.lua.

return {

  ---------------------------------------------------------------- I. INTRODUÇÃO
  {
    id = "about-book", kind = "fiction",
    title = "O que é este livro",
    summary = "Um mundo inteiro em 2126 e o começo de uma aventura, para Cyberpunk RED.",
    body = [==[
*O Amanhã Corporativo* é um cenário de cyberpunk de futuro próximo para **Cyberpunk RED**. Ele se passa em **2126**, cem anos depois de hoje, num planeta dividido entre os **ESTEMPs** (Estados Empresariais), corporações tão grandes que viraram países soberanos, e os **REGESTs** (Regimes Estatais), o que sobrou dos governos tradicionais.

O livro tem duas partes:

- **O mundo** (capítulos II a VIII): a [[timeline|linha do tempo]] de 2026 a 2126, o [[board|mapa do mundo]], cada ESTEMP e cada REGEST, a vida de quem trabalha para uma corporação, o tabu da colher, a resistência e as regras.
- **O começo de uma aventura** (capítulos IX e X): quatro personagens prontos e [[adventure-overview|Auditoria no Descoberto]], uma abertura de campanha na represa que abastece Brasília. Ela não tem final escrito: termina em duas cenas em aberto, para cada mesa seguir do seu jeito.

## O que você precisa
- O livro básico de Cyberpunk RED, da R. Talsorian Games. Aqui está só o que muda (capítulo VIII).
- De três a cinco jogadores e uma pessoa para mestrar.
- Disposição para histórias em que ninguém vence de forma limpa.
]==],
  },
  {
    id = "tone", kind = "fiction",
    title = "O tom: cyberpunk pé no chão",
    summary = "Burocracia letal, escassez e perda de soberania, sem neon mágico.",
    body = [==[
Aqui o cyberpunk é **pé no chão**. Não existem download de consciência, cidades flutuantes nem realidade virtual imersiva. A tecnologia é industrial, burocrática e voltada para duas coisas: otimizar lucro e controlar gente.

Os implantes existem, mas são caros, burocráticos e cobram um preço do corpo. Quase sempre **pertencem legalmente à empresa que pagou por eles**: a pessoa carrega o braço, a empresa tem a escritura (veja [[ownership]]).

O perigo do mundo não está num hacker místico, e sim num formulário. Ninguém aqui é morto por uma inteligência artificial rebelde; as pessoas são realocadas, bloqueadas, demitidas, e às vezes demitidas segundos antes de morrer (veja [[great-dismissal]]).

## Três palavras para a mesa
- **Cinza.** O mundo não é escuro e brilhante: é cinza, de relatório e de concreto.
- **Escassez.** Água, remédio, comida de verdade e tempo livre são luxos.
- **Prestação.** Tudo foi vendido aos poucos: a soberania, o corpo, a esperança.
]==],
  },
  {
    id = "how-to-use", kind = "fiction",
    title = "Como usar este livro",
    summary = "Por onde começar a ler, o que mostrar aos jogadores e como combinar os limites da mesa.",
    body = [==[
Para jogar logo, leia [[tone]], [[board]], [[collaborator]], [[spoon-origin]] e [[antifaca]], e depois a aventura inteira, do [[adventure-overview|panorama]] até [[what-next]]. O resto do livro é material de consulta.

## O que os jogadores podem ler
Os capítulos I a IX são conhecimento comum dentro do mundo: qualquer colaborador sabe o que é a quarentena, qualquer pessoa já viu uma propaganda do [[colony-dream|Sonho das Colônias]]. As caixas **Nota do Mestre** e o capítulo X são só para quem mestra.

## Combine os limites antes
O cenário trata de assassinato em massa tratado como procedimento, de trabalho forçado, de pessoas descartadas e de vitórias que custam inocentes (veja [[grey-morality]]). Antes da primeira sessão, conversem sobre o que fica fora da mesa e o que pode acontecer só fora de cena. Ferramentas simples, como Linhas e Véus ou um cartão X, resolvem a maior parte dos casos.

::: gm
A sátira funciona melhor quando ninguém na mesa ri dela. Os personagens do mundo levam a sério a etiqueta sem colher, as metas e o Sonho das Colônias. O absurdo fica por conta dos jogadores perceberem.
:::
]==],
  },
  {
    id = "fact-and-fiction", kind = "mixed",
    title = "Fato e ficção",
    summary = "Os lugares e precedentes reais em que o cenário se apoia.",
    body = [==[
O futuro é inventado, mas o chão dele é real. Cada fato do mundo de hoje usado no livro tem uma citação numerada; o resto está marcado como *Ficção*.

## O que é real
- **Empresas já tiveram exército e território.** A Companhia Britânica das Índias Orientais manteve exércitos próprios e governou grande parte do subcontinente indiano {{east-india}}. Os ESTEMPs não inventaram nada.
- **O Triângulo de Afar fica abaixo do nível do mar.** O Lago Assal, em Jibuti, está 155 metros abaixo do nível do mar e é o ponto mais baixo da África {{lake-assal}}. Na ficção, isso permitiu [[great-dismissal|afundar a região]] abrindo um canal.
- **Alcântara é uma das melhores bases de lançamento do mundo**, porque fica mais perto da linha do Equador do que qualquer outra {{alcantara}}. Na ficção, é o prêmio da [[first-corporate-war]].
- **A represa do Descoberto já quase secou.** O Distrito Federal viveu cerca de um ano e meio de racionamento de água entre 2017 e 2018 {{df-rationing}}, com o Descoberto no menor nível da história {{descoberto-record}}. A aventura parte daí.
- **O Aquífero Ogallala está sendo esvaziado** pela irrigação desde a metade do século XX {{ogallala}}. **Jacarta afunda**, e a Indonésia decidiu mudar a capital de lugar {{jakarta}}. **A França tem uma faixa de interior quase vazia** {{empty-diagonal}}. Esses lugares viraram REGESTs (veja [[regests]]).
- **A mineração de asteroides** é estudada há décadas como fonte de metais fora da Terra {{asteroid-mining}}.

## O que é inventado
Tudo o que acontece depois de 2026: as corporações, as guerras, as pessoas, a colher. Nenhuma empresa ou pessoa real é descrita aqui.
]==],
  },

  ---------------------------------------------------------------- II. HISTÓRIA
  {
    id = "timeline", kind = "mixed",
    title = "Linha do tempo",
    summary = "De um precedente do século XVII ao presente da campanha, em 2126.",
    body = "@timeline",
  },
  {
    id = "first-asteroid", kind = "mixed",
    title = "O Primeiro Asteroide",
    summary = "2046: a primeira riqueza que nenhum governo controlava.",
    body = [==[
Em 2046, robôs da **[[omniterra|OmniTerra]]** lançados de Alcântara trouxeram para a órbita da Terra um asteroide metálico e começaram a minerá-lo com lucro. Ninguém morava no espaço, e ninguém mora até hoje; mas pela primeira vez uma empresa tinha uma fonte de riqueza fora do alcance de qualquer governo. A ideia era antiga {{asteroid-mining}}; o que mudou foi quem pagou por ela.

## A Inversão
Nos vinte anos seguintes, as empresas com operação espacial passaram a ter mais caixa do que os países que as hospedavam. Primeiro elas financiaram os governos, depois compraram a dívida deles, depois compraram os governos. Os historiadores corporativos chamam esse período de **Inversão**; os REGESTs chamam de **Penhora**.

## Por que a Terra ainda importa
O espaço tem metal, mas não tem gente. Viver lá em cima continua caro e difícil. As refinarias, as bases de lançamento, a água, a comida e, principalmente, a mão de obra continuam aqui embaixo. Por isso as corporações ainda brigam por território, e por isso o [[colony-dream|Sonho das Colônias]] é uma promessa tão útil.
]==],
  },
  {
    id = "first-corporate-war", kind = "mixed",
    title = "A Primeira Guerra Corporativa",
    summary = "2068–2074: uma briga por espionagem que terminou com o Brasil inteiro vendido.",
    body = [==[
A primeira guerra entre empresas não teve ideologia. Ela começou com um roubo e foi escalando, uma retaliação de cada vez.

## Como começou
1. **A espionagem.** A **Halcyon Orbital**, a segunda mineradora a chegar aos asteroides, chegou rápido demais. Em 2068 a OmniTerra descobriu que ela tinha roubado o sistema de captura orbital usado no [[first-asteroid|Primeiro Asteroide]].
2. **A sanção.** A OmniTerra anunciou: *quem trabalha com a Halcyon não trabalha comigo*. Fornecedores, bancos e clientes tiveram de escolher um lado, e o mercado se rachou em dois blocos. Esse racha é o esboço do mundo dividido em ESTEMPs.
3. **As sabotagens.** Cargas desviadas, sistemas derrubados, acidentes em obras.
4. **O avanço.** Para minerar o espaço é preciso lançar foguetes, e os melhores lugares ficam perto do Equador {{alcantara}}. A Halcyon comprou terras em segredo em volta de **Alcântara**, no Maranhão, e sabotou lançamentos da OmniTerra.
5. **A escalada.** Quando isso foi descoberto, as seguranças privadas das duas se enfrentaram no Norte do Brasil. Cada resposta foi maior que a anterior.

## Como terminou
Em 2074 a Halcyon quebrou, e a OmniTerra comprou os destroços, Alcântara incluída. O Brasil, endividado e sem forças para negar, passou a ser território da OmniTerra. Só o Distrito Federal ficou de fora, porque não tinha nada que interessasse (veja [[brasilia]]).

A [[kuro-tech|Kuro-Tech]] vendeu armas para os dois lados durante toda a guerra. Os "armamentos de pacificação" pelos quais ela é conhecida nasceram ali.

## O que a guerra deixou
- A **[[quarantine|Quarentena Corporativa]]**: depois da guerra, contratar alguém do outro lado passou a significar importar um espião.
- A ideia de que uma empresa pode ter exército, fronteira e inimigo, como um país.
]==],
  },
  {
    id = "corruption-gold-rush", kind = "fiction",
    title = "A Corrida do Ouro da Corrupção",
    summary = "2080–2100: quando o funcionalismo público vendeu o que ainda restava.",
    body = [==[
Quando ficou claro que os Estados iam encolher, quem trabalhava neles fez as contas. Entre 2080 e 2100, ministros, juízes, fiscais e diretores de estatais usaram o caos para vender acordos, licenças, terras e dados às corporações, e em troca ganharam lugar dentro delas.

Muitos executivos de alto escalão de hoje descendem desses funcionários. É por isso que a burocracia dos ESTEMPs tem cara de repartição pública: ela foi montada por gente que vinha de uma.

## O que isso deixou
- **Os REGESTs ficaram com o pior.** O que dava lucro foi vendido; o que ficou foi o que ninguém quis comprar (veja [[regests]]).
- **A corrupção virou cultura de empresa.** Nos ESTEMPs, regras valem para todo mundo, menos para quem é importante o bastante (veja [[pyramid]]).
- **Arquivos esquecidos.** Contratos dessa época, como o que dá a Brasília a sua água (veja [[brasilia]]), ainda estão em vigor porque ninguém se deu ao trabalho de cancelá-los.
]==],
  },
  {
    id = "great-dismissal", kind = "mixed",
    title = "A Grande Demissão do Triângulo de Jibuti",
    summary = "2111: o maior trauma do século, com um nome de procedimento.",
    body = [==[
O Triângulo de Afar, na entrada do Mar Vermelho, é uma das regiões mais baixas do planeta: o Lago Assal fica 155 metros abaixo do nível do mar {{lake-assal}}. Ao lado dele passa o estreito de Bab-el-Mandeb, uma das rotas marítimas mais importantes do mundo {{bab-el-mandeb}}. Em 2111, as duas coisas se encontraram.

## O gatilho
A região era território de colaboradores da [[great-rift|Great Rift Holdings]], com portos operados pela [[thalassa|Thalassa Corp]]. Depois de um colapso estrutural nos portos, a Thalassa calculou que era mais barato **afundar a região** do que reconstruí-la. Ela abriu um canal e deixou o mar entrar na depressão. A conta tinha uma vantagem extra: terra alagada vira mar, e o mar é dela.

## A cascata
Para proteger os próprios mercados da crise, as duas vizinhas responderam. A [[petro-vanguard|Petro-Vanguard]] envenenou a costa do outro lado do estreito; a Great Rift terraplanou e envenenou o lado continental. Milhões de pessoas morreram, registradas como "dano colateral aceitável".

## O nome
Segundos antes da inundação, todos os moradores receberam uma notificação de desligamento. Tecnicamente, foram **demitidos** antes de morrer, e por isso nenhum ESTEMP responde por homicídio. A região alagada aparece nos mapas corporativos como **Golfo da Demissão**.

::: gm
Provas do que aconteceu em Jibuti (as planilhas que compararam o custo de reconstruir com o custo de afundar) são o maior prêmio que a [[antifaca|AntiFaCa]] poderia conseguir. É o tipo de coisa que um executivo-astro carrega na cabeça (veja [[hooks]]).
:::
]==],
  },

  ---------------------------------------------------------------- III. O TABULEIRO
  {
    id = "board", kind = "fiction",
    title = "O mapa do mundo",
    summary = "O tabuleiro em 2126: quem é dono de cada pedaço, e quantas peças tem.",
    body = [==[
@board

Cinco conglomerados dominam o planeta e funcionam como monarquias de acionistas. Em volta deles, Estados Empresariais menores fecham os espaços que sobraram. O mar inteiro é de uma única empresa.

@estemps

As peças no mapa são uma piada com fundo de verdade: elas mostram, mais ou menos, quanta segurança privada cada ESTEMP mantém em seu território. As fronteiras entre ESTEMPs não são guerras abertas; são tratados comerciais, pedágios, quarentenas e, de vez em quando, uma sabotagem.
]==],
  },
  {
    id = "omniterra", kind = "fiction",
    title = "OmniTerra",
    summary = "As Américas: logística, extração, agricultura sintética e o espaço.",
    body = [==[
**Território:** as Américas, do Alasca à Terra do Fogo, mais a Groenlândia. **Sede:** Chicago. **Base espacial:** Alcântara.

A OmniTerra é a maior empresa do mundo e a primeira a virar país. Ela move cargas, arranca minério, planta comida sintética em escala continental e, desde o [[first-asteroid|Primeiro Asteroide]], minera o espaço.

## Como é viver lá
É famosa pela rigidez na [[relocation|realocação]] de mão de obra: ninguém tem carreira fixa, e um contador pode amanhecer como operador de colheitadeira a três mil quilômetros de casa. Em compensação, a propaganda é a mais otimista do planeta.

## O pecado
Começou a [[first-corporate-war]] e mente sobre as colônias. O slogan dela, *Trabalhe pelo Sonho das Colônias*, promete um paraíso no espaço que não existe e não vai existir (veja [[colony-dream]]).

::: ad
OmniTerra. Daqui, até as estrelas. Juntos.
:::
]==],
  },
  {
    id = "kuro-tech", kind = "fiction",
    title = "Kuro-Tech",
    summary = "Ásia-Pacífico: cabos, chips, biotecnologia utilitária e armas de pacificação.",
    body = [==[
**Território:** Ásia Oriental, Sudeste Asiático e Oceania. **Sede:** Osaka.

A Kuro-Tech fabrica o chão da tecnologia: cabos, chips, implantes industriais, biotecnologia de uso prático. Nada é bonito, tudo funciona. Ela também fabrica **armamentos de pacificação interna**: bastões, munição de contenção, gás, veículos antimotim.

## Segurança como serviço
A Kuro-Tech aluga seguranças para outras corporações. Um ESTEMP que não quer manter uma tropa contrata uma unidade Kuro-Tech por trimestre, com uniforme cinza e a logomarca preta no ombro. Eles aparecem em [[adventure-overview|Auditoria no Descoberto]].

## O pecado
Vendeu armas para os dois lados da [[first-corporate-war]] e lucrou com cada morte. Até hoje, toda guerra entre empresas é um bom trimestre para a Kuro-Tech.
]==],
  },
  {
    id = "aegis-med", kind = "fiction",
    title = "Aegis-Med",
    summary = "Europa e África mediterrânea: remédios, seguros de vida e a ilusão de bem-estar.",
    body = [==[
**Território:** Europa e a costa mediterrânea da África. **Sede:** Basileia.

A Aegis-Med é um império farmacêutico e de seguros. Ela vende a sensação de estar cuidado: planos de saúde corporativos, aplicativos de humor, campanhas de bem-estar e, para quem pode pagar, longevidade.

## O pecado: a Tolerina
Quase todo implante do mundo precisa de um remédio antirrejeição para não ser atacado pelo corpo. A Aegis-Med tem a patente do mais usado, a **Tolerina**, e vende para todas as outras corporações. O preço é calibrado para caber no salário de um colaborador. Quem é demitido perde o plano de saúde, e com ele a Tolerina (veja [[ownership]]).

::: ad
Aegis-Med. Porque você merece se sentir bem. Consulte as condições do seu plano.
:::
]==],
  },
  {
    id = "petro-vanguard", kind = "fiction",
    title = "Petro-Vanguard",
    summary = "Oriente Médio e Ásia Central: combustíveis sintéticos e contenção de crises.",
    body = [==[
**Território:** Oriente Médio, Anatólia, Cáucaso e Ásia Central. **Sede:** Doha.

A Petro-Vanguard controla os combustíveis sintéticos que ainda movem navios, aviões e foguetes. É pioneira nas políticas mais duras de **contenção de crises**: quando algo dá errado num território, ela isola, cerca e espera.

## O pecado
Participou da [[great-dismissal|Grande Demissão]] envenenando a costa árabe do estreito de Bab-el-Mandeb. Os manuais de contenção dela são usados por outras ESTEMPs até hoje.
]==],
  },
  {
    id = "thalassa", kind = "fiction",
    title = "Thalassa Corp",
    summary = "Os oceanos: rotas, pesca automatizada e dessalinização. Cada centímetro de mar novo é dela.",
    body = [==[
**Território:** todas as águas internacionais do planeta. **Sede:** uma plataforma no Atlântico Norte, que muda de lugar.

A Thalassa é dona das rotas marítimas, das plataformas de pesca automatizada e das usinas de dessalinização. Num mundo com sede, isso faz dela a fornecedora de água de metade das costas do planeta.

## A regra do mar
Pelo direito corporativo, a água salgada é da Thalassa. Quando o mar sobe, o território dela cresce. As peças vermelhas dela estão em todos os oceanos do [[board|mapa]].

## O pecado
Afundou o Triângulo de Jibuti em 2111 (veja [[great-dismissal]]). Nos Países Baixos, os pólderes que restam ao REGEST holandês vivem com medo de serem os próximos.
]==],
  },
  {
    id = "severa", kind = "fiction",
    title = "Severa Combine",
    summary = "Rússia e o Ártico: o degelo como negócio.",
    body = [==[
**Território:** a Rússia e o litoral ártico. **Sede:** Murmansk.

A Severa vive do degelo: rotas marítimas abertas no Ártico, minérios que o permafrost escondia, gás. Ela disputa com a [[thalassa|Thalassa]] uma pergunta jurídica sem resposta: **o gelo que derrete é terra ou é mar?**

## O pecado
Usa trabalho de demitidos em quarentena nas minas do norte, com contratos que eles assinam porque não há outro lugar que os aceite.
]==],
  },
  {
    id = "monsoon", kind = "fiction",
    title = "Monsoon Workforce Solutions",
    summary = "Sul da Ásia: o maior mercado legal de aluguel de gente.",
    body = [==[
**Território:** o subcontinente indiano. **Sede:** Mumbai.

A Monsoon não fabrica nada: ela **aluga colaboradores**. Turnos de atendimento, contabilidade, triagem de dados, enfermagem, obras: qualquer ESTEMP pode contratar um lote de trabalhadores da Monsoon por trimestre.

## A brecha
A [[quarantine|quarentena]] impede que um demitido seja contratado por outra corporação. Mas um trabalhador cedido pela Monsoon nunca é contratado por ninguém: ele continua sendo da Monsoon. É a brecha mais usada do mundo, e a Monsoon cobra por ela.
]==],
  },
  {
    id = "great-rift", kind = "fiction",
    title = "Great Rift Holdings",
    summary = "África Oriental, Central e Austral: geotermia, cobalto e lítio.",
    body = [==[
**Território:** do Chifre da África ao Cabo, incluindo a bacia do Congo. **Sede:** Nairóbi.

A Great Rift vende energia geotérmica do Vale do Rift e os minérios das baterias do mundo: cobalto, lítio, cobre.

## O pecado
Na [[great-dismissal|Grande Demissão]], terraplanou e envenenou o lado continental do Triângulo de Afar para conter a crise. Os moradores eram colaboradores dela.
]==],
  },
  {
    id = "sahel-solar", kind = "fiction",
    title = "Sahel Solar Trust",
    summary = "África Ocidental e o Saara: o sol vendido por cabo para a Europa.",
    body = [==[
**Território:** o Saara e a África Ocidental. **Sede:** Dakar.

A Sahel Solar cobre o deserto de painéis e vende a energia por cabos submarinos para a [[aegis-med|Aegis-Med]]. É a ESTEMP mais nova e a que mais cresce.

## O pecado
Os painéis precisam de água para ser limpos, e a água do Sahel é pouca. Poços inteiros foram cercados, e rotas de pastoreio de séculos agora terminam numa cerca com a logomarca do sol.
]==],
  },

  ---------------------------------------------------------------- IV. OS REGESTs
  {
    id = "regests", kind = "mixed",
    title = "Os vinte REGESTs",
    summary = "O que sobrou de cada um dos vinte maiores países, e por quê.",
    body = [==[
Os REGESTs são os restos dos governos democráticos. Sobrevivem penhorando o que resta da sua soberania às corporações. Oferecem uma "liberdade econômica e pessoal" precária, no meio da miséria, da falta de infraestrutura e de uma segurança pública falida.

## A regra
**O REGEST fica com o que nenhuma corporação quis comprar.** Não há formato fixo: cada país ficou com a parte de si que não dava lucro. Para os vinte maiores países de 2026, foi isto:

@regests

Alguns desses lugares já estão em crise hoje: o Aquífero Ogallala vem sendo esvaziado pela irrigação {{ogallala}}, Jacarta afunda {{jakarta}} e a França tem uma faixa de interior quase vazia {{empty-diagonal}}. O cenário só deixou a tendência continuar.

## Por que ainda existem
Porque é útil que existam. Um REGEST é o lugar para onde os demitidos vão, o mercado onde as corporações vendem o que sobra, e a prova de que a alternativa às empresas é pior.
]==],
  },
  {
    id = "brasilia", kind = "mixed",
    title = "O REGEST de Brasília",
    summary = "Uma capital sem país, que depende da água de uma represa que não é mais dela.",
    body = [==[
Do Brasil, sobrou o **Distrito Federal**. Quando a OmniTerra comprou o país depois da [[first-corporate-war]], o DF ficou de fora: era sede de governo, longe do litoral, sem porto nem indústria pesada. Ninguém quis comprá-lo.

Brasília ainda tem ministérios, um Congresso, embaixadas de outros REGESTs e quatro milhões de pessoas. Tem também um problema: **a água**.

## A Venda da Faixa
O Distrito Federal sempre dependeu da represa do Descoberto, na divisa com Goiás. Já em 2017 e 2018 ela quase secou, e a cidade passou cerca de um ano e meio sob racionamento {{df-rationing}} {{descoberto-record}}. Em 2097, endividado, o REGEST vendeu à OmniTerra a faixa de terra da represa. Em troca, ganhou o **Contrato Humanitário de 2097**, que garante a Brasília uma cota de água pela Adutora Velha.

A cota foi diminuindo a cada renovação. Hoje a maior parte do Descoberto vai para o **Núcleo Planalto**, um data center da OmniTerra que processa a telemetria da frota de mineração espacial. A cidade vive em racionamento permanente.

## Como é Brasília em 2126
- O Plano Piloto continua de pé, com os prédios públicos rachados e os gramados secos.
- As cidades em volta (Taguatinga, Ceilândia, Samambaia) vivem de caminhão-pipa.
- O Posto 4, na divisa com a OmniTerra, é a fronteira mais movimentada do Centro-Oeste.

Brasília é o cenário da aventura de abertura, [[adventure-overview|Auditoria no Descoberto]].
]==],
  },
  {
    id = "regest-life", kind = "fiction",
    title = "A vida num REGEST",
    summary = "Liberdade, miséria e o comércio que só os nômades fazem.",
    body = [==[
Num REGEST ninguém é realocado nem demitido, porque quase ninguém é contratado. Há eleições, imprensa que pode falar mal de uma corporação, igrejas, sindicatos e colheres nas gavetas. Não há água encanada todos os dias, remédio, emprego nem polícia que venha quando chamada.

## O que entra e o que sai
As leis dos ESTEMPs não protegem quem está fora deles. Por isso transportar carga para dentro de um REGEST é arriscado, e quem faz isso cobra caro. Os [[nomads|nômades]] dominam esse comércio.

## Quem vive lá
- **Os que sempre viveram.** Famílias que nunca trabalharam para uma corporação.
- **Os demitidos.** Bloqueados pela [[quarantine|quarentena]], é para cá que eles vêm.
- **Os que voltaram.** Gente que largou um ESTEMP de propósito. São poucos, e as corporações adoram mostrá-los nos noticiários, magros e arrependidos.
]==],
  },

  ---------------------------------------------------------------- V. A VIDA DO COLABORADOR
  {
    id = "collaborator", kind = "fiction",
    title = "Adeus, patriotas",
    summary = "Dentro de um ESTEMP, ninguém luta por bandeira: luta por meta.",
    body = [==[
Dentro de um ESTEMP, os cidadãos não são cidadãos: são **colaboradores**. Não lutam por bandeiras, e sim por metas. Recebem 24 horas por dia propagandas que pedem engajamento total com a marca que paga o sustento deles.

## Um dia comum
- Acordar no alojamento da empresa, com o painel de metas do dia já aceso na parede.
- Café em sachê de sucção, porque colher não pega bem (veja [[spoonless-etiquette]]).
- Turno. Pausa obrigatória para o vídeo motivacional.
- Turno.
- À noite, o placar da equipe, as notificações de realocação e a campanha do [[colony-dream|Sonho das Colônias]].

## O chip
Todo colaborador tem um **Chip Biométrico Corporativo** implantado na contratação. Ele abre portas, paga contas, registra horários e serve de passaporte. Quando a pessoa é demitida, o chip é bloqueado, e com ele a vida inteira (veja [[quarantine]] e [[implants]]).
]==],
  },
  {
    id = "relocation", kind = "fiction",
    title = "A Realocação Flexível",
    summary = "O neofeudalismo: você não tem carreira, você é um recurso alocável.",
    body = [==[
Não existe carreira fixa. Você é um **recurso alocável**. Se o setor de calçados estagnar, amanhã o publicitário pode estar limpando dutos de esgoto, em outra cidade, com outro alojamento.

Recusar a realocação significa demissão sumária.

## Como funciona
- A notificação chega pelo chip, com prazo de 72 horas.
- A família pode ou não ir junto, conforme o "pacote de mobilidade" do cargo.
- O histórico profissional não conta. A realocação segue a necessidade da empresa naquele trimestre.

::: gm
A realocação é a forma mais comum de uma corporação se livrar de alguém sem demiti-lo. Um colaborador incômodo pode ser mandado para uma mina no Ártico da [[severa|Severa]] sem que ninguém precise assinar nada de feio.
:::
]==],
  },
  {
    id = "quarantine", kind = "fiction",
    title = "A Quarentena Corporativa",
    summary = "Demitido, você fica dez anos sem poder trabalhar para ninguém.",
    body = [==[
Oficialmente se chama **Lei do Bloqueio de Capital Humano**. Quando um colaborador é demitido, o registro biométrico e fiscal dele é bloqueado, e ele fica proibido de ser contratado por qualquer outra megacorporação por pelo menos **dez anos**. O objetivo declarado é impedir a espionagem industrial.

## Lei de quem?
Não existe um tratado assinado. A quarentena nasceu como uma cláusula de contrato da OmniTerra logo depois da [[first-corporate-war]], quando contratar alguém do outro lado passou a significar importar um espião. As outras empresas copiaram. Hoje é uma **prática de mercado**: algumas empresas aplicam por mais tempo, outras por menos, mas todas aplicam, e quem não aplica fica malvisto.

## Na prática
O demitido vira um pária. Sem chip, não abre porta, não paga conta, não compra remédio. É empurrado para a miséria dos [[regest-life|REGESTs]] ou para o nomadismo. As únicas saídas legais são a brecha da [[monsoon|Monsoon]] e as minas da Severa.
]==],
  },
  {
    id = "pyramid", kind = "fiction",
    title = "A pirâmide",
    summary = "Ninguém escapa da realocação, a não ser quem é importante o bastante.",
    body = [==[
Em tese, as regras valem para todo mundo. Na prática, quanto mais alto o cargo, mais privilégios, e a sociedade empresarial é corrupta até o osso. Um diretor pode estar na lista de realocação e simplesmente não ir.

| Camada | Quem é | O que ganha |
|---|---|---|
| Acionistas | as famílias que mandam | soberania |
| Executivos-astro | os rostos da marca | imunidade de fato |
| Gerência | quem aplica as regras | exceções às regras |
| Colaboradores | quase todo mundo | metas e alojamento |
| Terceirizados | cedidos pela Monsoon ou pela Kuro-Tech | um contrato por trimestre |
| Demitidos | quem caiu | a [[quarantine|quarentena]] |

Os **executivos-astro** merecem nota: são executivos tratados como celebridades, com fãs, campanhas e escândalos. Sequestrar um deles é um dos [[hooks|ganchos]] clássicos da AntiFaCa.
]==],
  },
  {
    id = "colony-dream", kind = "fiction",
    title = "O Sonho das Colônias",
    summary = "A propaganda-assinatura da OmniTerra: um paraíso no espaço que não existe.",
    body = [==[
O espaço, hoje, serve só para mineração. Ninguém mora lá, e as colônias não existem. Mesmo assim, desde 2120 a [[omniterra|OmniTerra]] repete uma campanha:

::: ad
**Trabalhe pelo Sonho das Colônias.** Se todos cooperarem, um dia todos nós vamos embora daqui. Juntos, para um lugar melhor.
:::

A campanha funciona porque é **coletiva e vaga**. Ninguém ganha uma vaga individual, nunca há uma data, e qualquer queixa vira "você está atrasando a ida de todo mundo". Ela faz par com a campanha da colher: uma ridiculariza quem discorda, a outra promete o paraíso a quem obedece.

É mentira. Não existe projeto de colônia em andamento, nem orçamento para isso. A OmniTerra sabe; a maioria dos colaboradores desconfia; quase ninguém diz em voz alta.
]==],
  },

  ---------------------------------------------------------------- VI. A CULTURA SEM COLHER
  {
    id = "spoon-origin", kind = "fiction",
    title = "Como nasceu o apelido",
    summary = "A mídia zombou, a resistência adotou, a sociedade transformou em tabu.",
    body = [==[
A resistência se chama **AntiFaCa**, sigla de Anti-Fasci-Capitalistas. A mídia das corporações viu ali uma piada pronta: se eles são contra a faca, são colheres. Inofensivos, infantis, inúteis perto das facas afiadas das corporações.

## O ciclo
1. **A chacota.** Charges, comerciais e programas de humor passaram a chamar os rebeldes de "colheres".
2. **A adoção.** A resistência abraçou o termo. Uma colher é fácil de ter, fácil de mostrar e fácil de reconhecer em qualquer cozinha do mundo. Surgiram os códigos: "pedir uma sopa" é perguntar se alguém é da resistência.
3. **A campanha.** As assessorias de imprensa dobraram a aposta. Em comerciais, holovídeos de rua e redes internas, a colher passou a significar fraqueza, estagnação mental e subversão.
4. **O tabu.** A população que não está na guerra começou a evitar colheres para não parecer simpática à resistência. Ninguém proibiu por lei; as pessoas abandonaram a colher por vontade própria.

::: ad
Quem usa colher está aceitando a sopa fria do fracasso estatal. Quem usa faca corta o próprio destino rumo ao sucesso.
:::

"Comedor de sopa" virou xingamento entre executivos e na classe média corporativa, usado contra qualquer funcionário com baixo rendimento ou ideias reformistas.
]==],
  },
  {
    id = "spoonless-etiquette", kind = "fiction",
    title = "A Revolução dos Utensílios",
    summary = "Sopa em barra, creme em sachê e talheres com logomarca gravada a laser.",
    body = [==[
Para provar lealdade aos [[capi-fascists|Capi-Fascistas]] e não ser investigada por simpatia à resistência, a classe média-alta criou uma etiqueta nova, sem nenhum utensílio que lembre uma colher.

## A comida
A indústria alimentícia reformulou tudo o que pedia colher. Sopas e caldos viraram **barras sólidas**; sobremesas cremosas viraram **sachês de sucção rápida** ou **cápsulas mastigáveis**. Na alta cúpula, sopa se toma de canudinho.

## Os talheres
Facas e garfos de corte preciso, modulares, com a logomarca da empresa gravada a laser, viraram acessório de moda obrigatório. Os "talheres multifuncionais patenteados" de cada ESTEMP evitam qualquer superfície côncava.

## O jantar de negócios
Jantares de negócios viraram rituais de lealdade. Os convidados competem para ver quem usa os talheres mais caros, mais afiados e mais tecnológicos, exibindo o seu "amor ao corte corporativo". A aventura tem um jantar assim: [[scene-dinner]].
]==],
  },
  {
    id = "moral-panic", kind = "fiction",
    title = "O pânico moral",
    summary = "Ninguém foi proibido. Todos foram convencidos.",
    body = [==[
O mais assustador da cultura sem colher não é uma proibição, porque não há proibição. É que as pessoas foram **convencidas** a largar a colher, e têm orgulho disso.

As pessoas olham com medo e nojo para qualquer objeto côncavo. Se alguém encontra uma colher antiga esquecida no fundo de uma gaveta numa zona residencial corporativa, o reflexo não é guardá-la, e sim **denunciá-la à segurança patrimonial** por "apologia ao terrorismo subversivo".

## Crime ou não?
A lei não fala de colheres. Mas a segurança patrimonial de cada empresa pode enquadrar o portador em "conduta incompatível com a cultura corporativa", e isso basta para uma investigação, uma realocação ou uma demissão. É uma zona cinzenta, e a zona cinzenta é a ferramenta.

## O retrato
Cidadãos muito escolarizados para produzir lucro e completamente infantilizados, incapazes de perceber que mudaram os hábitos alimentares e a própria dignidade por causa de um meme inventado por uma assessoria de imprensa. Transformaram um utensílio de cozinha num campo de batalha ideológico e sentem orgulho da própria submissão.
]==],
  },
  {
    id = "capi-fascists", kind = "fiction",
    title = "Os Capi-Fascistas",
    summary = "A classe média-alta que trocou o nacionalismo pelo amor à marca.",
    body = [==[
Os **Capi-Fascistas** são a classe média-alta corporativa que desenvolveu um amor cego e fervoroso pela empresa que lhes paga. Trocaram o fascismo nacionalista pelo corporativismo de marca: no lugar da bandeira, a logomarca; no lugar do hino, o jingle.

São eles que denunciam colheres, que choram nas convenções anuais e que tatuam o número de matrícula. Não são vilões de quadrinho: são vizinhos, chefes e parentes. Muitos personagens jogadores vão ter um Capi-Fascista na família.

::: gm
Um Capi-Fascista quase nunca é um inimigo em combate. Ele é a pessoa que vê demais e liga para a segurança patrimonial. Use-os como pressão, não como alvo.
:::
]==],
  },

  ---------------------------------------------------------------- VII. A ANTIFACA
  {
    id = "antifaca", kind = "fiction",
    title = "A AntiFaCa",
    summary = "Uma rede de células sem centro, que sabe que não vai derrubar o sistema.",
    body = [==[
A AntiFaCa (Anti-Fasci-Capitalistas) não tem quartel-general, líder nem programa único. É uma rede de **células** que se reconhecem por códigos e cooperam quando convém. O símbolo é a colher; a senha é "pedir uma sopa".

## O que ela quer
Não derrubar o sistema global de uma vez, o que é impossível. A AntiFaCa ataca os flancos: expõe podridões, arranca recursos das corporações e passa para os REGESTs, e provoca efeitos dominó.

## Como se organiza
- **Células nômades**, que vivem nas brechas do mundo (veja [[nomads]]).
- **Células infiltradas**, que vivem dentro dos ESTEMPs (veja [[infiltration]]).
- **Contatos nos REGESTs**: hospitais, sindicatos, jornais e igrejas que recebem o que a rede consegue tirar.

## As divergências
Nem toda célula concorda com as outras. Há quem aceite matar inocentes por uma vitória grande e quem se recuse; há quem queira negociar com uma ESTEMP contra outra. Essas brigas internas são uma boa fonte de histórias.
]==],
  },
  {
    id = "nomads", kind = "fiction",
    title = "Os nômades",
    summary = "Frete para onde a lei não protege ninguém.",
    body = [==[
Os rebeldes nômades vivem de **frete e transporte comercial para os REGESTs**. Como as leis dos ESTEMPs não protegem quem está fora deles, levar carga para um REGEST é perigoso, e quem faz isso tem uma mercadoria valiosa: a disposição de ir.

Os comboios carregam remédio, peças, comida, água, gente e, escondidas no meio, as coisas que a resistência precisa mover. Muitos nômades são demitidos em quarentena; outros nunca tiveram chip.

Na aventura de abertura, [[lia]] dirige o caminhão-pipa que cruza o Posto 4 entre a estação e Brasília.
]==],
  },
  {
    id = "infiltration", kind = "fiction",
    title = "Infiltração profunda",
    summary = "As células mais perigosas estão dentro das empresas, e vivem com medo do auditor.",
    body = [==[
As células mais perigosas da resistência não se escondem em cavernas: estão dentro dos próprios ESTEMPs. Subdivisões inteiras, como uma usina isolada de tratamento de água, podem ser formadas só por infiltrados.

Elas vivem sob a tensão constante de serem descobertas. O maior inimigo de uma célula infiltrada não é um soldado: é um **auditor**, alguém que confere planilhas, conta peças e faz perguntas educadas.

É exatamente essa a situação da aventura de abertura: [[adventure-overview|Auditoria no Descoberto]].
]==],
  },
  {
    id = "grey-morality", kind = "fiction",
    title = "A moralidade cinza",
    summary = "As vitórias nunca são limpas.",
    body = [==[
Para forçar uma megacorporação a ceder um recurso vital (por exemplo, a água limpa de um data center) a um REGEST sem estourar uma guerra aberta, os personagens vão precisar de chantagem pesada, mentiras, sabotagens calculadas e, às vezes, sacrificar inocentes ou trair aliados.

O cenário não pede que os jogadores façam isso. Pede que a escolha exista e pese. Uma vitória da AntiFaCa quase sempre custa alguma coisa a alguém que não pediu para entrar na história.

::: gm
Quando uma escolha difícil aparecer, mostre quem paga o preço com nome e rosto. Uma consequência abstrata ("a produção cai 3%") não pesa; o turno inteiro de um colaborador realocado para o Ártico, sim.
:::
]==],
  },
  {
    id = "hooks", kind = "fiction",
    title = "Ganchos de partida",
    summary = "Três começos de campanha, além da aventura deste livro.",
    body = [==[
## O Foda-se Coletivo
Todos os funcionários de uma subdivisão são demitidos injustamente de uma vez. Proibidos pela [[quarantine|quarentena]] de trabalhar em qualquer outro lugar, eles não têm nada a perder e decidem tocar fogo no sistema que os jogou fora.

## O Sequestro Encomendado
Uma célula precisa capturar um executivo-astro para arrancar dele senhas ou provas sobre [[great-dismissal|Jibuti]]. O executivo tem fãs, seguranças da [[kuro-tech|Kuro-Tech]] e um implante de memória que pode ser a prova, ou a armadilha.

## A Fuga Resgatada
Os personagens sobreviveram a uma tentativa de fuga frustrada de um ESTEMP e foram acolhidos por uma célula nômade. Agora devem um favor, e não sabem a quem.

## Auditoria no Descoberto
A aventura deste livro: [[adventure-overview]].
]==],
  },

  ---------------------------------------------------------------- VIII. REGRAS
  {
    id = "grounded-rules", kind = "fiction",
    title = "O que muda nas regras",
    summary = "Cyberpunk RED sem rede imersiva e sem cromo mirabolante.",
    body = [==[
Use as regras de Cyberpunk RED como estão, com estas mudanças.

::: rule
**Sem NET imersiva.** Não existem Arquiteturas da NET, cyberdecks nem programas de ataque. Sistemas digitais existem, mas só se invadem com acesso físico a um terminal ou a um cabo, usando Eletrônica/Segurança Técnica. O papel Netrunner é substituído pelo [[roles|Operador de Sistemas]].
:::

::: rule
**Implantes de catálogo.** Só existem os implantes do [[implants|catálogo pé no chão]]. A Perda de Humanidade de cada um é **fixa** (não se rola), para que a ficha possa ser conferida.
:::

::: rule
**Todo implante tem um dono.** Cada implante tem um titular, quase sempre a empresa que pagou por ele. Veja [[ownership]] para o Rastro do Ativo, o Recolhimento e a Tolerina.
:::

::: rule
**Criação de personagem.** Use o Pacote Completo: 62 pontos de atributo, de 2 a 8 cada, e 86 pontos de perícia, com níveis de 1 a 6 na criação.
:::

## Moeda
O dinheiro é o **crédito corporativo** (¢), emitido pelas ESTEMPs e aceito, com desconto, nos REGESTs. Use os preços de Cyberpunk RED como se fossem créditos.
]==],
  },
  {
    id = "roles", kind = "fiction",
    title = "Os papéis",
    summary = "Os papéis de Cyberpunk RED neste mundo, e os três que mudam de nome.",
    body = [==[
| Papel | Neste mundo |
|---|---|
| Solo | Segurança terceirizada, ex-soldado de guerra corporativa, guarda-costas |
| Tech | Manutenção industrial, operador de comportas, mecânico de comboio |
| Medtech | Enfermeiro de plano de saúde, paramédico demitido, contrabandista de Tolerina |
| Mídia | Jornalista de REGEST, roteirista de propaganda arrependido |
| Executivo | Gerente de subdivisão, auditor, executivo-astro em queda |
| Fixer | Atravessador de fronteira, vendedor de chips clonados |
| Nômade | Motorista de comboio para os REGESTs |
| **Segurança Patrimonial** (era Lawman) | O vigia da empresa, que denuncia colheres |
| **Agitador** (era Rockerboy) | Quem faz a contrapropaganda: pichador, músico, pregador de rua |
| **Operador de Sistemas** (era Netrunner) | Quem invade sistemas com as mãos no terminal |

::: rule
**Operador de Sistemas.** Usa as regras do Tech para a Habilidade de Papel, mas aplicada a sistemas digitais: com acesso físico, ele pode ler registros, apagar trilhas e abrir portas. Sem acesso físico, não faz nada.
:::

::: rule
**Agitador.** Usa a Habilidade de Papel do Rockerboy, trocando o show pela campanha: um muro pintado, uma rádio pirata, um culto de rua.
:::
]==],
  },
  {
    id = "implants", kind = "fiction",
    title = "O catálogo pé no chão",
    summary = "Os implantes que existem em 2126, com Perda de Humanidade fixa.",
    body = [==[
Estes são os implantes que existem. Não há lâminas retráteis, olhos de câmera de cinema nem reflexos sobre-humanos: a tecnologia é industrial e serve ao trabalho.

@implants

## Humanidade
A Humanidade começa em **EMP × 10** e perde o valor fixo de cada implante. A EMP atual é a Humanidade dividida por 10, arredondada para baixo. O build confere essa conta em todas as fichas do livro.
]==],
  },
  {
    id = "ownership", kind = "fiction",
    title = "O implante é seu, a posse é da empresa",
    summary = "Rastro do Ativo, Recolhimento e Tolerina: o preço de ter cromo.",
    body = [==[
Quase todo implante é financiado pela empresa empregadora, e o contrato diz que ele continua sendo **propriedade da empresa** enquanto houver saldo devedor. O saldo nunca acaba.

::: rule
**Rastro do Ativo.** Todo implante com titular corporativo transmite o número de patrimônio para os leitores das portarias e postos de fronteira. Mascarar o sinal por uma cena exige um teste de Eletrônica/Segurança Técnica contra DV 15. Falhar marca a pessoa como "ativo fora de lugar".
:::

::: rule
**Recolhimento.** Quando alguém é demitido, a empresa pode recolher os implantes que são dela. Na prática isso quase nunca acontece numa clínica: acontece quando a pessoa é encontrada. Um personagem demitido com cromo corporativo é, para todos os efeitos, um patrimônio extraviado.
:::

::: rule
**Tolerina.** Implantes marcados no catálogo exigem uma dose de Tolerina por semana, vendida pela [[aegis-med|Aegis-Med]] pelos planos de saúde corporativos. Sem a dose, o implante dá −2 em todas as ações que dependem dele, e depois de um mês para de funcionar. No mercado clandestino, uma dose custa 100¢ e pode ser falsa.
:::

## Clínicas de beira de estrada
Nos REGESTs existem clínicas que removem chips, trocam números de patrimônio e instalam implantes recolhidos de outras pessoas. Ninguém pergunta de onde veio o braço.
]==],
  },

  ---------------------------------------------------------------- IX. PERSONAGENS
  {
    id = "characters-intro", kind = "fiction",
    title = "A Célula Concha",
    summary = "Os quatro personagens prontos e a célula a que eles pertencem.",
    body = [==[
A **Célula Concha** é a célula da [[antifaca|AntiFaCa]] que tomou a Estação Descoberto-7 sem disparar um tiro. Em três anos, a supervisora Zuleide Batista trocou, uma vaga de cada vez, todos os 41 funcionários da estação por gente da resistência. Desde então, a estação manda escondido para Brasília mais água do que o contrato permite.

Os personagens prontos são quatro membros da célula:

| Personagem | Papel | Na estação |
|---|---|---|
| [[marta]] | Tech | Operadora das comportas, com um braço que é da empresa |
| [[davi]] | Medtech | O enfermeiro, que vive com um chip clonado |
| [[rui]] | Solo | O chefe da vigilância, que viu Jibuti |
| [[lia]] | Nômade | A motorista do caminhão-pipa que cruza a divisa |

## Usando os seus próprios personagens
Qualquer personagem serve, desde que seja da célula ou trabalhe com ela. Um bom começo é perguntar a cada jogador: o que a empresa tem de você (um braço, um nome, uma família) que ela pode tomar de volta?
]==],
  },

  ---------------------------------------------------------------- X. AVENTURA
  {
    id = "adventure-overview", kind = "mixed",
    title = "Panorama para o Mestre",
    summary = "O que está acontecendo de verdade na Estação Descoberto-7.",
    body = [==[
A **Estação Descoberto-7** trata a água do Lago do Descoberto, na divisa entre o território da OmniTerra e o [[brasilia|REGEST de Brasília]]. A represa existe e já quase secou uma vez {{descoberto-record}}; a estação, a vila e o data center são ficção.

@localmap

## A situação
- **92%** da água tratada vai pela Adutora Planalto para o **Núcleo Planalto**, o data center da OmniTerra.
- **6%** vão para Brasília pela Adutora Velha, como manda o Contrato Humanitário de 2097.
- Há três anos, a [[characters-intro|Célula Concha]] adultera o **Medidor 14** e manda mais **9%** para Brasília. Na cidade, essa água vai para os hospitais.

## O que a auditora veio fazer
A auditora [[adventure-npcs|Celeste Prado-Vasconcelos]] não veio atrás da fraude. Ela veio **preparar o fim do contrato**: em 30 dias a Adutora Velha será fechada para a Expansão Planalto II, e os funcionários da estação serão realocados para Alcântara, ou demitidos. A auditoria é o inventário de tudo o que a empresa vai mover: canos, bombas, gente e implantes.

O problema é que, se ela olhar com atenção, vai encontrar o Medidor 14.

::: rule
**Suspeita (0 a 6).** O Mestre marca a Suspeita da auditora durante a visita. Cada erro dos personagens (um registro que não bate, uma colher à vista, uma resposta nervosa) soma 1; um erro grave soma 2. Em 3, Celeste pede para ver o Medidor 14 pessoalmente. Em 6, ela chama a segurança e manda isolar a estação.
:::

## Como a aventura termina
Não termina. As cenas [[scene-news]] e [[scene-valve]] ficam **em aberto**. Em [[what-next]] há caminhos para a mesa seguir.
]==],
  },
  {
    id = "scenario-flow", kind = "fiction",
    title = "Fluxo da aventura",
    summary = "As cenas, a ordem frouxa entre elas e as duas que ficam em aberto.",
    body = "@flow",
  },
  {
    id = "scene-night-shift", kind = "fiction",
    title = "1. O Turno da Noite",
    summary = "Duas mensagens na mesma madrugada: o hospital está sem água e a auditoria chega às oito.",
    body = [==[
::: read
São três da manhã na Estação Descoberto-7. O lago lá fora não tem luz nenhuma; a única coisa acesa é o painel de metas na parede da sala de controle, que hoje mostra 104% em verde. O café acabou. Em algum lugar da tubulação, a Adutora Velha faz o barulho de sempre, como alguém respirando fundo.
:::

Os personagens estão no turno da noite. Duas mensagens chegam com meia hora de diferença.

## A primeira: o comunicado
Pelo terminal da supervisão chega um comunicado da OmniTerra: uma **Auditoria de Rotina de Ativos Hídricos** às 08h00 (veja [[aviso-auditoria]]). Não diz quem vem nem por quê.

## A segunda: o hospital
[[lia|Lia]] recebe no rádio do caminhão uma mensagem do Hospital de Base de Brasília, em código: as caixas d'água do hospital têm reserva para um dia (veja [[mensagem-hospital]]).

## O que fazer
Os personagens podem acordar a supervisora, [[adventure-npcs|Zuleide Batista]], que vai convocar a célula para preparar a estação. E precisam decidir: mandam a água extra para o hospital hoje, com a auditoria chegando, ou esperam?

::: gm
Se mandarem a água hoje, o Medidor 14 vai mostrar um desvio maior no registro da manhã: comece a auditoria com Suspeita 1. Se não mandarem, o hospital entra em colapso no fim do dia, e Lia vai saber.
:::
]==],
  },
  {
    id = "scene-cleanup", kind = "fiction",
    title = "2. A Faxina",
    summary = "Cinco horas para esconder três anos de resistência.",
    body = [==[
Zuleide reúne a célula no refeitório e distribui as tarefas. São cinco horas para que a estação pareça uma estação comum.

| Tarefa | Teste | Se falhar |
|---|---|---|
| Recolher as colheres de todos os alojamentos e da cozinha | Percepção DV 13 | Fica uma colher em algum lugar: Suspeita +1 quando for encontrada |
| Ajustar os registros do Medidor 14 para os últimos 90 dias | Burocracia DV 15 | Os registros não batem com a vazão do lago |
| Ensaiar as respostas com os 41 funcionários | Persuasão DV 13 | Alguém vai gaguejar na entrevista |
| Apagar as mensagens do rádio de Lia | Eletrônica/Segurança Técnica DV 13 | A mensagem do hospital continua lá |

::: read
Dona Zuleide abre o armário da cozinha e tira, uma por uma, quarenta e uma colheres de aço. Põe todas num saco de lixo, dá um nó e fica olhando para o saco um tempo. — Onde a gente esconde isso? — pergunta alguém. Ela não responde de imediato.
:::

::: gm
Onde esconder as colheres é uma boa decisão para os jogadores. No fundo do tanque de decantação, dentro de um cano, enterradas na beira do lago, ou levadas no caminhão de Lia para Brasília. Cada escolha tem um risco diferente na cena [[scene-auditor]].
:::
]==],
  },
  {
    id = "scene-auditor", kind = "fiction",
    title = "3. A Auditora",
    summary = "Celeste chega às oito em ponto, com quatro seguranças da Kuro-Tech.",
    body = [==[
::: read
O carro chega às oito em ponto, branco, com a logomarca azul da OmniTerra na porta. Atrás dele vem uma van cinza da Kuro-Tech. Desce primeiro uma mulher de trinta e poucos anos, de terninho, com uma pasta debaixo do braço e um talher de prata preso no bolso do paletó, como uma caneta. — Bom dia. Celeste Prado-Vasconcelos, Conformidade. Vocês têm café?
:::

[[adventure-npcs|Celeste]] é educada, rápida e atenta. Ela tem um implante de **Memória de Conformidade**: tudo o que ela vê fica gravado como prova jurídica (veja [[implants]]). Os quatro seguranças da Kuro-Tech, comandados pelo **Sargento Takeda**, ficam no pátio.

## O roteiro da auditora
1. Visita às instalações, com um personagem como guia.
2. Conferência do inventário: bombas, tanques, medidores e **os implantes dos funcionários**, um por um.
3. Entrevistas curtas com cada setor.
4. À noite, um jantar com a supervisão (veja [[scene-dinner]]).

Na pasta dela está a [[carta-objetivo|carta-objetivo]] da OmniTerra para o trimestre. Um personagem atento (Percepção DV 15) consegue ler o título de relance.

::: gm
O inventário de implantes é o ponto mais perigoso para [[davi|Davi]], cujo chip é clonado, e para [[marta|Marta]], cujo braço é da OmniTerra. Celeste anota tudo. O Sargento Takeda reconhece [[rui|Rui]] de longe, mas não diz nada ainda.
:::
]==],
  },
  {
    id = "scene-meter", kind = "fiction",
    title = "4. O Medidor 14",
    summary = "A auditora quer ver a calibração do único medidor que não pode ser visto.",
    body = [==[
Cedo ou tarde (no máximo quando a Suspeita chegar a 3), Celeste pede para acompanhar a **calibração do Medidor 14**, o medidor da Adutora Velha.

::: read
O Medidor 14 fica numa casa de bombas de tijolo, mais velha que todo o resto da estação. Celeste para na porta, olha a placa de patrimônio com a data de 2097 e sorri, como quem encontra um móvel antigo numa casa nova. — Este aqui é o que vai para Brasília, não é?
:::

## Como enganá-la
- **Trocar a leitura na hora**: Tecnologia Básica DV 15, feito por quem está no painel enquanto alguém distrai a auditora.
- **Distrair**: Persuasão ou Conversação DV 13 contra a atenção dela. Se falhar, ela olha para o painel no momento errado.
- **Desligar a Memória de Conformidade** por alguns minutos: Eletrônica/Segurança Técnica DV 17, com acesso físico ao implante. É um crime grave se descoberto.
- **Contar a verdade a ela**: só funciona se os personagens já souberem o segredo de Celeste (veja [[scene-dinner]]).

::: gm
Se a fraude for descoberta, Celeste não grita: ela anota, agradece e manda Takeda isolar a casa de bombas. Isso leva direto à cena [[scene-valve]].
:::
]==],
  },
  {
    id = "scene-dinner", kind = "fiction",
    title = "5. Jantar de Faca",
    summary = "Um jantar de conformidade, com sopa em barra e uma colher que não deveria estar ali.",
    body = [==[
Celeste convida a supervisão para um **jantar de conformidade** no refeitório da estação, com o cardápio que ela trouxe (veja [[cardapio]]). É um ritual de lealdade: cada um usa os próprios talheres corporativos, e todos observam todos.

::: read
A sopa vem em barra, num pratinho de porcelana, com a logomarca da OmniTerra em relevo. Celeste corta a sua em quadrados perfeitos com uma faca de prata e come devagar. Lá fora, alguém da Kuro-Tech ri alto de alguma coisa. Ela levanta os olhos do prato. — Vocês aqui ainda comem como gente do interior?
:::

## Testes de etiqueta
Cada personagem à mesa faz um teste de Etiqueta (ou Atuação, para disfarçar) DV 13. Uma falha soma 1 à Suspeita: alguém segurou o garfo como se fosse uma colher.

## O segredo de Celeste
Celeste nasceu em Taguatinga, no REGEST de Brasília, e entrou na OmniTerra aos dezenove anos com um contrato da Monsoon. A família dela ainda mora lá. No bolso interno do paletó, ela carrega **uma colher pequena de alumínio, da avó**.

Um personagem pode perceber (Percepção DV 17) ou provocar a revelação (Persuasão ou Interrogatório DV 17, com uma boa abordagem). Se o segredo vier à tona, Celeste vira uma aliada possível, assustada e cara.

::: gm
Celeste conta o plano real (o fim do contrato em 30 dias) a quem conquistar a confiança dela. Se ninguém conseguir, ela anuncia de qualquer forma na manhã seguinte: vá para [[scene-news]].
:::
]==],
  },
  {
    id = "scene-news", kind = "fiction",
    title = "6. A Notícia",
    summary = "O contrato com Brasília termina em 30 dias, e a estação vai ser esvaziada.",
    body = [==[
::: read
Celeste reúne os 41 funcionários no pátio às sete da manhã. Fala sem microfone, com a voz de quem já fez isso muitas vezes. — Tenho uma boa notícia. Daqui a trinta dias a Estação Descoberto-7 passa a fazer parte da Expansão Planalto II. A Adutora Velha será desativada. Vocês serão realocados para Alcântara, com pacote de mobilidade, como parte do esforço pelo Sonho das Colônias. Alguma pergunta?
:::

Ninguém pergunta nada. Em trinta dias, Brasília perde 6% da sua água por contrato e os 9% que a célula mandava por fora. Os funcionários vão para Alcântara, ou, os que tiverem algo a esconder, para a quarentena.

## Em aberto
A aventura escrita para aqui. A célula tem trinta dias e muitas opções, e nenhuma é limpa. Veja [[what-next]].
]==],
  },
  {
    id = "scene-valve", kind = "fiction",
    title = "7. A Válvula",
    summary = "A fraude foi descoberta, ou a célula decidiu agir antes. A estação está cercada.",
    body = [==[
Esta cena acontece se a Suspeita chegar a 6, se a fraude do Medidor 14 for descoberta ou se a célula decidir abrir toda a Adutora Velha de uma vez, com a auditora ainda lá dentro.

::: read
O Sargento Takeda fecha o portão da estação e põe dois homens na casa de bombas. Do pátio dá para ver o painel de metas pela janela da sala de controle: ainda verde, ainda 104%. Celeste está ao telefone, de costas para todo mundo, falando baixo.
:::

A estação tem 41 pessoas da resistência, quatro seguranças da Kuro-Tech armados, uma auditora com uma gravação que pode condenar todo mundo e uma válvula que pode mandar para Brasília, por algumas horas, toda a água do Descoberto.

@npc:takeda
@npc:guard

## Em aberto
O que acontece depois é da mesa. A Kuro-Tech manda reforços em quatro horas; a OmniTerra trata a estação como "ativo comprometido". Veja [[what-next]].
]==],
  },
  {
    id = "adventure-npcs", kind = "fiction",
    title = "Personagens do Mestre",
    summary = "A auditora, a supervisora e quem mais está na estação.",
    body = [==[
## Celeste Prado-Vasconcelos
Auditora sênior de Conformidade da OmniTerra, 34 anos. Educada, rápida, cansada. Nasceu em Taguatinga e entrou na empresa como terceirizada da Monsoon; subiu sendo a melhor em fazer o que mandam. Carrega uma colher da avó no bolso do paletó e uma gravação de tudo o que vê dentro da cabeça.

**O que ela quer:** fechar a auditoria sem problemas e não pensar na família em Taguatinga.

@npc:celeste

## Dona Zuleide Batista
Supervisora da Estação Descoberto-7 e líder da Célula Concha, 58 anos. Engenheira hidráulica, avó de cinco netos que moram em Ceilândia. Trocou os 41 funcionários um por um, em três anos, sem que ninguém percebesse. Não acredita em grandes vitórias; acredita em litros.

@npc:zuleide

## Sargento Edson Takeda
Comandante da unidade terceirizada da Kuro-Tech. Ele e [[rui|Rui]] trabalharam juntos como seguranças contratados da Great Rift em 2111, do lado continental de Jibuti. Takeda nunca falou sobre isso com ninguém. A ficha dele está em [[scene-valve]].
]==],
  },
  {
    id = "what-next", kind = "fiction",
    title = "Para onde a história pode ir",
    summary = "Caminhos para os trinta dias seguintes, sem final escrito.",
    body = [==[
A aventura não tem final. Estes são caminhos que a célula pode tentar, cada um com o seu preço.

- **Vazar a gravação.** Se Celeste virar aliada, a Memória de Conformidade dela tem tudo: o plano da Expansão Planalto II, as ordens, os números. Um jornal do REGEST publicaria. A OmniTerra saberia exatamente de onde veio.
- **Sabotar o Núcleo Planalto.** Sem água para resfriar, o data center para. Isso para também a telemetria da frota espacial, e a OmniTerra responde como respondeu à Halcyon.
- **Negociar com outra ESTEMP.** A [[thalassa|Thalassa]] vende água dessalinizada e adoraria um contrato em Brasília. Trocar uma corporação por outra é uma vitória?
- **Sequestrar a auditora.** Ela vale muito para a OmniTerra, e sabe muito.
- **Esvaziar a estação.** Levar os 41 para Brasília antes da realocação, com chips, braços e tudo, e virar uma célula nômade.
- **Abrir a válvula.** Mandar toda a água de uma vez, por algumas horas. Enche as caixas dos hospitais e entrega a célula inteira.

## Fios soltos
- O que Takeda vai fazer com o que sabe sobre Rui.
- Quem dentro da AntiFaCa vai querer usar a estação para algo maior, e mais sangrento.
- O que Lia vai descobrir sobre o hospital quando a água parar.
]==],
  },

  ---------------------------------------------------------------- APÊNDICES
  {
    id = "handouts", kind = "fiction",
    title = "Handouts",
    summary = "Documentos para entregar aos jogadores.",
    body = "@handouts",
  },
  {
    id = "sources", kind = "history",
    title = "Fontes",
    summary = "As referências do mundo real usadas no livro.",
    body = "@sources",
  },
  {
    id = "about", kind = "fiction",
    title = "Sobre este livro",
    summary = "Créditos, licença e como contribuir.",
    body = [==[
*O Amanhã Corporativo* é um livro do Magic Stack, escrito por Murillo França M. da Silva. O conteúdo está sob a licença **CC BY-NC-SA 4.0**.

## Cyberpunk RED
Cyberpunk e Cyberpunk RED são marcas da R. Talsorian Games. Este é um material de fã, não oficial e gratuito, publicado conforme a política de conteúdo caseiro da R. Talsorian. Para jogar, use o livro básico de Cyberpunk RED.

## O mapa
O tabuleiro é gerado a partir dos contornos dos países do Natural Earth, de domínio público, rasterizados em pixels de dois graus. A divisão entre as ESTEMPs é ficção.

## Contribua
Este mundo está aberto. Corporações menores, REGESTs, ganchos, personagens e cenas novas podem ser propostos pelo botão **Contribuir** de cada artigo. Toda contribuição passa pela revisão do autor e recebe crédito conforme o termo de contribuição.
]==],
  },
}
