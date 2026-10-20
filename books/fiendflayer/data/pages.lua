-- FiendFlayer — the book's articles, in Portuguese (the original).
-- The English edition lives in data/en/pages.lua.
--
-- kind: "history" = lore oficial de D&D · "fiction" = criação desta campanha
--       · "mixed" = criação construída sobre o lore oficial
-- body markup: ## subtítulo · - lista · | tabela | · [[id]] ou [[id|texto]] link
--              · **negrito** · *itálico* · ::: gm / ::: lore / ::: open … ::: caixas
--              · @flow (página inteira) · @concept (o concept sheet)

return {
  ---------------------------------------------------------------------------
  -- I. Introdução para o Mestre
  ---------------------------------------------------------------------------
  {
    id = "premise", kind = "mixed",
    title = "Premissa",
    summary = "Uma regra do lore oficial, quebrada por acidente.",
    body = [==[
::: lore
Mind flayers não podem ser criados a partir de seres abissais ou criaturas infernais, e nenhuma criatura de Avernus é convertida em mind flayer.
:::

A campanha parte justamente da quebra dessa regra.

Os tieflings são a ponte entre essência infernal e corpo mortal. No personagem central desta história, todos acreditam que os traços infernais são um despertar tiefling. Não são: [[house-morvane|Sir Cael Morvane]] carrega um diabo preso dentro do corpo, e um girino de mind flayer que nunca conseguiu terminar o trabalho.

O resultado é o [[species|FiendFlayer]], o vilão escondido da história.

## Estrutura da campanha
- Uma pequena [[opening-adventure|aventura inicial]], já definida.
- Um arco de abertura, deixado em aberto como primeira parte da campanha: a [[knight-route|rota do cavaleiro]] ou a [[child-route|rota da criança]].
- O prelúdio do grande problema.
- O contato com Avernus.
- A [[final-threat|ameaça final]]: os illithids tentando tomar os planos infernais.
]==],
  },
  {
    id = "structure", kind = "fiction",
    title = "Mapa da Campanha",
    summary = "As etapas, da aventura inicial à ameaça final.",
    body = "@flow",
  },
  {
    id = "opening-adventure", kind = "fiction",
    title = "Aventura Inicial",
    summary = "Uma pequena aventura de abertura, já definida.",
    body = [==[
A campanha começa com uma pequena aventura inicial. Ela já está definida, mas ainda não foi escrita neste livro.

Depois dela, a mesa segue por um dos dois arcos de abertura. Os dois levam ao mesmo lugar: o diabo preso é libertado, volta para Avernus transformado e dá início à ameaça de verdade.
]==],
  },
  {
    id = "open-threads", kind = "fiction",
    title = "O Que Ainda Está em Aberto",
    summary = "Decisões que ainda não foram tomadas e partes que ainda não foram escritas.",
    body = [==[
Este livro está em andamento. Ele traz só o que já foi decidido; o resto fica marcado aqui, para não ser confundido com conteúdo pronto.

- **A aventura inicial** está definida, mas ainda não está escrita neste livro.
- **Qual arco de abertura** a mesa vai jogar fica em aberto: cavaleiro ou criança.
- **O nome do diabo preso** ainda não foi definido.
- **O prelúdio do grande problema** e **a ameaça final** ainda não têm cenas escritas.
- **A libertação de Tiamat** pelos githyanki pode virar um subplot.
- **O discurso do Final 2**: talvez um pequeno discurso de liberdade e ódio.
- **O desenho à mão** do personagem ainda não está pronto.
- **Fichas de jogo** (blocos de estatística) ainda não existem para nenhuma criatura ou personagem.
]==],
  },

  ---------------------------------------------------------------------------
  -- II. A Ameaça Final
  ---------------------------------------------------------------------------
  {
    id = "final-threat", kind = "fiction",
    title = "Uma Espécie Invasora",
    summary = "Os mind flayers estudam como tomar os planos infernais.",
    body = [==[
Os mind flayers fazem estudos para tentar tomar os planos infernais. O tema é o de uma espécie invasora.

Apesar de o imaginário dos illithids ser o Plano Astral, eles estão em Avernus por causa da compatibilidade. Esse novo tipo de ameaça vai se tornar um problema para Avernus.

## O dilema final
Para impedir os illithids, a party precisa se aliar a vilões e, de certa forma, defender o inferno.

## Alianças possíveis
- [[tiamat|Tiamat]], o dragão de cinco cabeças.
- Outros seres infernais (veja [[infernal-lords|os lordes infernais]]).
- Os [[githyanki]], que não podem deixar Tiamat cair nas mãos do FiendFlayer.
]==],
  },
  {
    id = "tiamat", kind = "mixed",
    title = "Tiamat em Avernus",
    summary = "O lore de base adotado pela campanha.",
    body = [==[
Tiamat está presa em Avernus, proibida de vir ao plano material pela força dos outros deuses.

Quem a prende são os deuses. Asmodeus tira proveito disso com um acordo, e ela atua como guardiã de Avernus.

::: lore
Em *Tyranny of Dragons*, a saída de Tiamat depende de um grande ritual feito do lado de fora.

Gith fez um pacto com Tiamat, e por isso os githyanki montam dragões vermelhos. Tiamat é aliada dos githyanki, não patrona; quem a cultua é o Culto do Dragão.
:::
]==],
  },

  ---------------------------------------------------------------------------
  -- III. O FiendFlayer
  ---------------------------------------------------------------------------
  {
    id = "species", kind = "mixed",
    title = "A Espécie",
    summary = "Um infernal com características de mind flayer, e não um mind flayer.",
    body = [==[
**FiendFlayer**, escrito junto. Os nomes *soulflayer* e *hellflayer* foram descartados por já terem várias referências na cultura pop.

A referência são as variantes em que os illithids transformaram dragões e beholders: a criatura ganha a camada illithid sem perder a essência original.

Aqui, a natureza infernal substitui a natureza illithid. Em vez de virar um mind flayer normal, ele vira um infernal com características de mind flayer. A transformação não é uma ceremorfose: é uma transformação nova, de fiend nessa criatura nova.

## Um acidente
O personagem é o resultado de um acidente. Uma vez que a natureza infernal for 100% superada através desse acidente, os illithids poderão assimilar qualquer fiend. Por isso o nome é amplo.

## Uma facção nova
O FiendFlayer pode convencer outros diabos a segui-lo, criando uma facção nova dentro dos Infernos, já que ele também foi um oprimido.

::: lore
Variantes illithid oficiais: o mindwitness (beholder), o brainstealer dragon e o elder brain dragon, o urophion (roper) e o mozgriken (gnomo das profundezas, sustentado por um ritual de energia negativa).

No beholder, a fusão não acontece por girino: ele é levado ao poço de salmoura de um cérebro ancião e vira um mindwitness. O brainstealer dragon resulta de ceremorfose; o elder brain dragon surge quando o cérebro ancião se prende ao dragão, o que não é ceremorfose.
:::
]==],
  },
  {
    id = "nature", kind = "fiction",
    title = "Natureza e Alimentação",
    summary = "Almas, como um mind flayer faz com cérebros.",
    body = [==[
Além de pactos, ele precisa consumir almas, como um mind flayer faz com cérebros.

Ele pode consumir carne e cérebros, o que dá vantagens físicas e psíquicas. Mas isso também fortalece o parasita, que sofreu a transformação infernal junto com ele.

Por enquanto, ele é único.

::: gm
Se o parasita ficar mais forte, ele pode se tornar outra coisa, que talvez obedeça ao império illithid. Aí Avernus pode correr perigo.
:::

::: lore
No lore, diabos precisam de contrato para tomar almas. O sequestro de corpos vivos não esbarra nessa regra.
:::
]==],
  },
  {
    id = "appearance", kind = "fiction",
    title = "Aparência",
    summary = "Vermelho rubro, com o roxo avançando para o peito.",
    body = [==[
- Vermelho rubro.
- Roxo nas pontas, extremidades e dobras, quase como um contorno do corpo.
- Manchas progressivas do mesmo roxo, partindo em direção ao centro do peito, como se estivessem avançando.
- A cabeça se tornou bulbosa entre os chifres.
- Ao abrir a boca, os tentáculos saem de dentro da garganta.

Ele continua vaidoso e não tem a aparência alienígena de um mind flayer. Normalmente, mantém as feições de cambion.

::: lore
No lore, cambion é o filho de um fiend com um mortal. "Feições de cambion" funciona como descrição visual, mas o personagem não é um cambion de origem.
:::

## Concept art
@concept

O concept sheet tem 7 painéis: corpo inteiro de frente e de costas, busto frontal, cabeça de perfil, rosto de boca fechada, rosto de boca aberta com tentáculos e estudo das mãos.

Existe também um desenho à mão, com estudos de cabeça e posição dos chifres, um busto em vermelho com roxo e uma cabeça com tentáculos. Ele ainda não está pronto, e as ideias descritas aqui valem mais do que o desenho.
]==],
  },

  ---------------------------------------------------------------------------
  -- IV. A Casa Morvane
  ---------------------------------------------------------------------------
  {
    id = "house-morvane", kind = "fiction",
    title = "Sir Cael Morvane",
    summary = "O 1º Tiefling da Casa Morvane, e o vilão escondido da história.",
    body = [==[
## Os nomes
- **Casa Morvane.** O "mor" remete à morte, o que combina com o epíteto do guerreiro que sempre volta dela.
- **Lord Halvard Morvane**, o pai. Um nome sóbrio e antigo, de um nobre que pareceria respeitável até alguém achar [[halvard-book|o livro dele]].
- **Sir Cael Morvane**, o cavaleiro. Um nome curto e heroico, fácil de lembrar na mesa.
- **O diabo preso**: nome ainda não definido.

## Os epítetos
- "O guerreiro que desafia a morte, pois a encontrou diversas vezes, mas sempre acha o caminho de volta."
- "O 1º Tiefling da Casa Morvane."

## Papel na história
Sir Cael é o vilão escondido da história, e não sabe disso.
]==],
  },
  {
    id = "the-contract", kind = "fiction",
    title = "O Contrato e a Prisão",
    summary = "Um pai, um filho morto e um diabo transformado em motor.",
    body = [==[
Lord Halvard tem o filho morto. Ele faz um contrato com um diabo importante: o diabo daria vitalidade sobre-humana à criança, tornando-se a fonte de vida dela, e em troca seria o próximo herdeiro.

Enquanto o diabo trabalhava, o lord conseguiu prendê-lo dentro da criança.

O que o lord fez foi transformar o diabo num motor para a criança. Por consequência, o diabo assumiu o papel de "alma" daquele corpo por muitos anos.

O diabo se tornou um passageiro: vê e sente tudo, mas não tem nenhuma ação, nem sequer um sussurro na mente da criança.

## O ritual
Foi um feitiço próprio do pai, um ritual de alto nível envolvendo sacrifícios, feito para reunir a combinação correta de fatores. Ele está registrado no [[halvard-book|livro de Lord Halvard]].

::: lore
*Planar Binding* e *Magic Circle* prendem fiends, e *Nondetection* bloqueia rastreamento. Prender um diabo como motor de um corpo não existe oficialmente, o que combina com um ritual próprio de Lord Halvard.
:::
]==],
  },
  {
    id = "cael-life", kind = "fiction",
    title = "A Vida de Sir Cael",
    summary = "Um despertar tiefling que não é um despertar tiefling.",
    body = [==[
A criança cresce com mente própria, sem saber do ocorrido. O diabo fica tecnicamente adormecido.

O corpo começa a ter aspecto infernal, e todos acreditam ser um caso de despertar tiefling na linhagem.

Ele vira lord, herda as terras e se torna um bravo cavaleiro por muitos e muitos anos. Tem uma vida longeva de forma mágica, além das outras características sobre-humanas.

O pai já morreu há anos, assim como o resto da família.

::: lore
Tieflings são humanoides com sangue de fiend. Em Forgotten Realms, um pacto dos Treze de Toril ligou os tieflings a Asmodeus. Há linhagens ligadas a outros arquiduques, como Zariel, Mephistopheles e Glasya.
:::
]==],
  },
  {
    id = "the-parasite", kind = "mixed",
    title = "O Parasita",
    summary = "Uma ceremorfose que não consegue terminar.",
    body = [==[
Durante esse tempo preso, ele é infectado por um girino (veja [[the-infection|a infecção]]), que se desenvolve a ponto de não poder mais ser removido.

A ceremorfose segue o processo normal, sem nada a mais, mas é impedida de concluir e avançar porque a essência infernal vaza. A natureza infernal está oculta dele mesmo.

## O que o parasita faz com a alma
Em ceremorfoses normais, o parasita toma conta do corpo, mas a longo prazo também afeta a alma da pessoa, mudando sua personalidade, mesmo fora do hivemind. Por fora não aparece, mas o hospedeiro é afetado por dentro, aos poucos.

No caso dele, os anos do parasita afetando a "alma" da criança afetaram a própria essência do diabo.

::: lore
No 5e, a ceremorfose completa leva cerca de uma semana. Em não humanoides, ela geralmente falha e mata hospedeiro e larva. Já aconteceu de a ceremorfose parar no meio, deixando um corpo humano com cérebro, personalidade e trato digestivo de illithid.
:::
]==],
  },
  {
    id = "the-release", kind = "fiction",
    title = "A Libertação e a Transformação",
    summary = "O excesso de energia de Avernus abre a prisão.",
    body = [==[
A condição de libertação é o excesso de energia de Avernus. Existem dois meios:

- estar em Avernus ([[ending-sacrifice|Final 1]]);
- ser morto por um infernal de alto escalão ([[ending-defeat|Final 2]]).

Ao ser liberto, ele manifesta uma versão alterada de si mesmo, por causa do efeito do parasita na essência.

A transformação é diferente da ceremorfose, porque a aparência dos diabos é definida por poder e hierarquia.

::: lore
Diabos mortos fora dos Infernos retornam para lá.
:::
]==],
  },

  ---------------------------------------------------------------------------
  -- V. Rota do Cavaleiro
  ---------------------------------------------------------------------------
  {
    id = "knight-route", kind = "fiction",
    title = "O Feudo e as Hordas",
    summary = "Legiões de caça atrás de um diabo que não conseguem encontrar.",
    body = [==[
O feudo da Casa Morvane está sendo assolado por hordas de Avernus, e Sir Cael as enfrenta há anos. Independentemente de quem as compõe, são legiões de caça.

::: gm
Na verdade, as hordas estão atrás de um diabo importante que sumiu há diversos anos: exatamente o que está preso no cavaleiro. Como o diabo está magicamente preso ao cavaleiro, as hordas não conseguem rastreá-lo.
:::
]==],
  },
  {
    id = "party-entry", kind = "fiction",
    title = "A Entrada da Party",
    summary = "Um lord em menor número contrata aventureiros.",
    body = [==[
Depois de anos de guerra e em menor número, o lord começa a contratar aventureiros para melhorar suas defesas. Ele assume uma posição de frente na guerra e precisa de reforço.
]==],
  },
  {
    id = "the-infection", kind = "fiction",
    title = "A Infecção",
    summary = "A aventura em que todos se transformaram, menos ele.",
    body = [==[
Sir Cael contraiu o girino numa das aventuras da época em que era conhecido pelos seus epítetos.

Nessa aventura, todos os seus companheiros foram transformados. Ele, apesar de infectado, se manteve igual.

Ao acordar, matou todos os companheiros transformados, por piedade.
]==],
  },
  {
    id = "ending-sacrifice", kind = "fiction",
    title = "Final 1: O Sacrifício em Avernus",
    summary = "Ele fica tempo demais em Avernus.",
    body = [==[
O cavaleiro "se sacrifica", segurando um chefe de horda em Avernus.

Por ficar tempo demais em Avernus, ele se transforma na frente dos jogadores.

No último momento como cavaleiro, ele empurra os jogadores psionicamente de volta pelo portal aberto.
]==],
  },
  {
    id = "ending-defeat", kind = "fiction",
    title = "Final 2: A Derrota no Plano Material",
    summary = "A primeira vez que alguém o vence.",
    body = [==[
O cavaleiro é derrotado, pela primeira vez, por um infernal de alto escalão. Ele se transforma no plano material.

Ele comanda o infernal que o matou e volta para Avernus ignorando os jogadores, depois de talvez um pequeno discurso de liberdade e ódio.
]==],
  },
  {
    id = "halvard-book", kind = "fiction",
    title = "O Livro de Lord Halvard",
    summary = "O feitiço do pai, e o plano inteiro.",
    body = [==[
Nos dois finais, os jogadores podem aprender mais sobre o cavaleiro e encontrar o livro mágico do pai.

O livro contém o feitiço próprio dele e o plano usado para chamar o diabo, fazer o contrato e aprisioná-lo no corpo do filho morto (veja [[the-contract|o contrato e a prisão]]).
]==],
  },
  {
    id = "knight-avernus", kind = "fiction",
    title = "Contato com Avernus: os Sequestros",
    summary = "O FiendFlayer leva gente para Avernus.",
    body = [==[
O FiendFlayer, já dominando forças de Avernus, sequestra pessoas e as leva para lá.

Os sequestrados viram escravos que fortalecem o movimento dele, e também servem de alimento: consumir almas e cérebros lá é importante para a criatura (veja [[nature|natureza e alimentação]]).
]==],
  },

  ---------------------------------------------------------------------------
  -- VI. Rota da Criança
  ---------------------------------------------------------------------------
  {
    id = "child-route", kind = "fiction",
    title = "O Herdeiro Criança",
    summary = "Herdou o título há 10 anos e continua sendo uma criança.",
    body = [==[
Os jogadores investigam a mando de alguém de posto hierárquico maior.

O motivo: o herdeiro das terras vizinhas herdou o título há 10 anos, mas continua sendo uma criança.

## O que os jogadores podem fazer
- Matar a criança.
- Fazer um exorcismo.
- Quebrar o feitiço do pai.

::: gm
Qualquer um dos três liberta o diabo da prisão e o manda direto para Avernus, dando início à ameaça de verdade.
:::
]==],
  },
  {
    id = "child-avernus", kind = "fiction",
    title = "Contato com Avernus: os Heróis Coletados",
    summary = "Avernus recruta mortais para retardar a criatura nova.",
    body = [==[
Os próprios habitantes de Avernus coletam heróis, por vontade própria, contratos ou sequestros, para tentar retardar o avanço da criatura nova.

::: lore
Em *Descent into Avernus*, a cidade de Elturel é arrastada para Avernus por um contrato com Zariel. Na Guerra Sangrenta, os Infernos usam mercenários mortais e almas como recursos descartáveis.
:::
]==],
  },

  ---------------------------------------------------------------------------
  -- VII. Contratos e Alianças
  ---------------------------------------------------------------------------
  {
    id = "infernal-lords", kind = "fiction",
    title = "Os Lordes Infernais",
    summary = "Contratam mortais para não arriscar a si mesmos.",
    body = [==[
O objetivo dos contratos é parar o FiendFlayer.

Os lordes contratam mortais porque os infernais não querem se envolver com ele, já que podem ser controlados psionicamente.

Não é que os mortais sejam mais resistentes. Os lordes simplesmente não estão dispostos a arriscar a si mesmos nem as suas tropas.

::: lore
Mortais não são naturalmente resistentes a psiônicos.
:::
]==],
  },
  {
    id = "githyanki", kind = "mixed",
    title = "Os Githyanki",
    summary = "Não podem deixar o FiendFlayer dominar Tiamat.",
    body = [==[
Pode haver um githyanki na party, ou um aliado githyanki que procura os personagens.

Ele alerta: o FiendFlayer está indo atrás de [[tiamat|Tiamat]], aliada dos githyanki, e eles não podem deixar que ele a domine.

Eles não conseguem libertá-la agora, o que pode virar um subplot. Mas não podem deixar essa espécie invasora tomar o controle de Avernus, e de Tiamat junto.

::: lore
Os gith foram escravos dos illithids. Gith liderou a revolta, e o império caiu. Os githyanki seguiram Gith, vivem no Plano Astral, em Tu'narath, e são governados pela rainha-lich Vlaakith. Os githzerai seguiram Zerthimon e vivem no Limbo. As duas raças se odeiam, mas caçam illithids.
:::
]==],
  },

  ---------------------------------------------------------------------------
  -- A. Apêndices
  ---------------------------------------------------------------------------
  {
    id = "official-lore", kind = "history",
    title = "Lore Oficial de Referência",
    summary = "O que a campanha pega emprestado do lore oficial de D&D.",
    body = [==[
- **Origem dos illithids:** vêm de um futuro distante, onde o universo está morrendo. Voltaram no tempo e montaram um império que atravessava mundos e planos, sustentado por escravidão psíquica.
- **Os gith:** foram escravos dos illithids. Gith liderou a revolta, e o império caiu. Depois, os rebeldes se dividiram: os githyanki seguiram Gith, vivem no Plano Astral, em Tu'narath, e são governados pela rainha-lich Vlaakith. Os githzerai seguiram Zerthimon e vivem no Limbo. As duas raças se odeiam, mas caçam illithids.
- **Pacto com Tiamat:** Gith fez um pacto com Tiamat, por isso os githyanki montam dragões vermelhos.
- **Outros escravos dos illithids:** os duergar são o caso mais conhecido depois dos gith.
- **Libertação de Tiamat:** em *Tyranny of Dragons*, a saída dela depende de um grande ritual feito do lado de fora.
- **Variantes illithid oficiais:** mindwitness (beholder), brainstealer dragon e elder brain dragon, urophion (roper), mozgriken (gnomo das profundezas, sustentado por um ritual de energia negativa).
- **Ceremorfose em não humanoides:** geralmente falha e mata hospedeiro e larva.
- **Falha parcial:** já aconteceu de a ceremorfose parar no meio, deixando um corpo humano com cérebro, personalidade e trato digestivo de illithid.
- **Tempo da ceremorfose:** no 5e, a transformação completa leva cerca de uma semana.
- **Tieflings:** humanoides com sangue de fiend. Em Forgotten Realms, um pacto dos Treze de Toril ligou os tieflings a Asmodeus. Há linhagens ligadas a outros arquiduques, como Zariel, Mephistopheles e Glasya.
- **Mortais levados a Avernus:** em *Descent into Avernus*, a cidade de Elturel é arrastada para lá por um contrato com Zariel.
- **Mortais na Guerra Sangrenta:** os Infernos usam mercenários mortais e almas como recursos descartáveis.
- **Diabos mortos fora dos Infernos** retornam para lá.
- **Magias de prisão e ocultação:** *Planar Binding* e *Magic Circle* prendem fiends, e *Nondetection* bloqueia rastreamento. Prender um diabo como motor de um corpo não existe oficialmente, o que combina com o ritual próprio de Lord Halvard.
]==],
  },
  {
    id = "corrections", kind = "history",
    title = "Notas de Correção",
    summary = "Termos do lore que é fácil trocar.",
    body = [==[
- **Demônio x diabo:** demônios são do Abismo, e diabos são dos Nove Infernos, ligados a contratos e hierarquia. O personagem é um diabo.
- **Cambion:** no lore, é o filho de um fiend com um mortal. "Feições de cambion" funciona como descrição visual, mas o personagem não é um cambion de origem.
- **Beholders:** no lore oficial, a fusão não acontece por girino. O beholder é levado ao poço de salmoura de um cérebro ancião e vira um mindwitness.
- **Dragões:** o brainstealer dragon resulta de ceremorfose. Já o elder brain dragon surge quando o cérebro ancião se prende ao dragão, o que não é ceremorfose.
- **Tiamat e os githyanki:** ela é aliada, não patrona. Quem cultua Tiamat no lore é o Culto do Dragão.
- **Diabos e almas:** no lore, diabos precisam de contrato para tomar almas. O sequestro de corpos vivos não esbarra nessa regra.
- **Mortais e psiônica:** mortais não são naturalmente resistentes a psiônicos. O motivo dos lordes é não arriscar a si mesmos nem as suas tropas.
]==],
  },
  {
    id = "about", kind = "fiction",
    title = "Sobre Este Livro",
    summary = "Autoria, estado do livro e marcas.",
    body = [==[
*FiendFlayer* é uma campanha original para Dungeons & Dragons 5e, de Murillo França M. da Silva. O livro foi escrito em português e traduzido para o inglês.

O livro está em andamento: ele reúne a premissa, o vilão e os dois arcos de abertura. O que ainda falta está listado em [[open-threads|o que ainda está em aberto]].

## As etiquetas
Cada artigo leva uma etiqueta: **Lore oficial** para o que vem dos livros de D&D, **Criação** para o que foi inventado para esta campanha e **Lore + Criação** para a criação construída em cima do lore. A campanha usa só o lore dos livros como referência.

## Marcas
Dungeons & Dragons, Forgotten Realms e os nomes de criaturas, planos e personagens do lore oficial pertencem à Wizards of the Coast. Este é um material de fã, não oficial e sem fins comerciais.
]==],
  },
}
