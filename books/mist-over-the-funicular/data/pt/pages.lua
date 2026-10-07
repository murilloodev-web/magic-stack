-- Tradução em português (Brasil) de data/pages.lua.
--
-- Cada página do original precisa de uma entrada aqui, com o mesmo id; o
-- build falha se faltar alguma. Seção, tipo (kind) e corpos especiais
-- (@timeline, @flow, @sources) vêm do original; aqui ficam só os textos.
-- A marcação é a mesma: [[id]] ou [[id|rótulo]], {{fonte}}, **negrito**,
-- *itálico*, ## Título, - item, > citação, e as etiquetas (Ficção),
-- (História) e (História → Ficção).

return {

  ---------------------------------------------------------------- O CENÁRIO
  ["synopsis"] = {
    title = "Sinopse",
    summary = "O que o governo pensa que está fechando, e o que está de fato libertando.",
    body = [==[
Em 1974, a rede ferroviária federal inaugura uma moderna linha de cremalheira descendo a Serra do Mar e começa a desativar o velho funicular a cabo que, desde 1867, levava o café do planalto ao porto de Santos {{spr-wiki}} {{funicular-wiki}}. No papel, é uma modernização para cortar custos.

O que nenhum ministério em Brasília sabe é que o funicular nunca foi só uma ferrovia. Todo trem que subia do litoral puxava um vagão a mais do que o horário admitia: um vagão-tanque lacrado de água do mar, grossa de limalha de ferro e pedra britada, destinado [[fourth-landing|ao Quarto Patamar]] e aos túneis sob [[grota-funda|a Grota Funda]]. A água do mar mantém sonolenta uma criatura marinha pré-humana. O ferro e a pedra alimentam seu corpo de [[amethyst-heart|ametista]], que cresceu por um século até ficar grande demais para algum dia deixar a montanha.

A criatura foi capturada aqui em 1866, trazida do sul por [[the-fugitive|um homem que ela havia tomado]], a poucos quilômetros do mar para o qual fugia. Desde então, ela só tem um jeito de alcançar alguém: [[the-mist|a névoa]]. Todos que a respiram a escutam, um pouco mais a cada noite.

À medida que o funicular desacelera, os vagões-tanque param de chegar. A névoa fica fria, pesada e insistente. A [[company-of-shadows|Companhia das Sombras]], cujos membros a respiram há gerações, está perdendo o controle, e três forasteiros que subiram a serra por motivos muito diferentes começam a ouvir os próprios nomes no nevoeiro.

## O dilema no fundo do túnel
Os investigadores precisam escolher entre dois finais ruins: [[ending-sea|arrancar o coração da criatura e devolvê-lo ao oceano]], ou [[ending-shatter|estilhaçá-lo com dinamite da ferrovia]] e prender a névoa à vila para sempre. Não existe vitória limpa. Esse é o ponto.
]==],
  },
  ["fact-and-fiction"] = {
    title = "Fato e Ficção",
    summary = "Onde termina a história e começa o Mythos, e as liberdades que este cenário toma.",
    body = [==[
Este cenário é construído sobre lugares reais e máquinas reais. Toda afirmação histórica do grimório traz uma citação numerada; tudo o que está marcado como *Ficção* é inventado. A [[timeline]] mostra os dois lado a lado.

## Liberdades tomadas de propósito
- **A Serra Nova como a linha que morre.** Na história real, o funicular mais antigo, o da Serra Velha, parou em 1970 e seu leito virou a linha de cremalheira de 1974; o funicular da Serra Nova continuou funcionando até o começo dos anos 1980 {{funicular-wiki}} {{museu-funicular}}. O cenário coloca a "ameaça de fechamento" na Serra Nova, que é onde as [[locobreques]] de fato trabalhavam.
- **O vagão-tanque nunca existiu.** A pesada tração a cabo foi construída para o café, para a carga e para uma subida de 796 m {{unesco}}, não para água do mar.
- **A ametista não é nativa da Serra do Mar.** Os grandes geodos de ametista do Brasil se formam nas rochas vulcânicas do extremo sul {{amethyst-wiki}} {{amethyst-usp}}. Na ficção, é exatamente isso que torna a pedra errada: [[the-fugitive|alguém a trouxe até aqui]].
- **A ametista é mesmo quartzo colorido por ferro.** Seu violeta vem de impurezas de ferro no cristal, ativadas por radiação {{amethyst-wiki}}. A ficção leva isso ao pé da letra: a Companhia fez crescer o corpo da criatura alimentando-a com sílica e ferro tirados da própria ferrovia.
- **O Festival de Inverno é mais antigo que o registro.** Oficialmente, o Festival de Inverno de Paranapiacaba começou em julho de 2001 {{festival-origins}}. No cenário, ele acontece todo inverno desde o século 19 como um rito privado da vila, da [[company-of-shadows|Companhia das Sombras]]. 2001 é só o ano em que os de fora foram convidados pela primeira vez: veja [[winter-festival|o Festival de Inverno]].

## Respeito por um lugar vivo
Paranapiacaba é uma vila real, habitada e tombada como patrimônio {{unesco}}. O culto e seus crimes são ficção e não pretendem descrever nenhuma pessoa, família ou instituição real.
]==],
  },
  ["timeline"] = {
    title = "Linha do Tempo",
    summary = "De 1859 a 2001, com a história documentada e a ficção do cenário lado a lado.",
  },
  ["scenario-flow"] = {
    title = "Fluxo do Cenário",
    summary = "A estrutura ramificada da investigação, da chegada aos três finais.",
  },

  ---------------------------------------------------------------- LOCAIS
  ["paranapiacaba"] = {
    title = "Paranapiacaba",
    summary = "A vila ferroviária britânica no alto da Serra do Mar, e o nevoeiro em que ela vive.",
    body = [==[
Em tupi, *Paranapiacaba* quer dizer "lugar de onde se vê o mar" {{paranapiacaba-wiki}}. É um nome cruel: na maior parte dos dias, o mar fica invisível atrás do nevoeiro.

A São Paulo Railway chamava o lugar de **Alto da Serra** e ergueu ali uma vila da companhia. Ela começou como acampamento dos operários da construção e cresceu até virar uma cidade planejada de casas de pinho-de-riga sobre bases de alvenaria, com o bairro planejado da Vila Martin Smith traçado ao lado {{vitruvius}}. Cerca de 450 construções abrigavam umas 1.100 pessoas {{unesco}}.

## O nevoeiro
Um nevoeiro denso cobre a vila ao entardecer, alimentado pela mata, pela altitude e pelo Atlântico ali perto {{unesco}} {{paranapiacaba-wiki}}. Os moradores dizem que os jogadores de futebol daqui aprenderam a jogar de ouvido. Neste cenário, o nevoeiro é algo mais: veja [[the-mist]].

## Em 1974
Os investigadores encontram uma vila já em declínio. A ferrovia que a construiu está se modernizando sem ela, e a velha ordem britânica sobrevive só nas casas e no [[castelinho|Castelinho]].
]==],
  },
  ["castelinho"] = {
    title = "O Castelinho",
    summary = "A casa vitoriana do engenheiro-chefe, erguida acima do pátio para ele vigiar cada movimento.",
    body = [==[
O "Castelinho" foi construído pelos britânicos em 1897 como residência do engenheiro-chefe da ferrovia. Fica num terreno elevado para que seu morador pudesse vigiar o pátio ferroviário, o relógio da estação e as casas dos operários a qualquer hora {{castelinho-folha}}. É uma casa vitoriana de dois andares e 507 m², com 33 janelas e seis lareiras, coberta com telhas de Marselha. Hoje é um museu {{museu-castelo}}.

## No cenário *(Ficção)*
Quem ocupa o cargo de engenheiro-chefe é, por direito ritual, Grão-Mestre da [[company-of-shadows|Companhia das Sombras]]. As janelas panorâmicas servem para mais do que vigiar operários: daqui o [[chief-engineer|engenheiro-chefe]] lê a densidade [[the-mist|da névoa]] como se fosse um barômetro.

## O que os investigadores podem encontrar aqui
- Registros de telégrafo em que os números de "água de lastro" não batem com nenhum manifesto de carga.
- Um escritório trancado com correspondência do século 19 em inglês e um esboço geológico de um geodo de ametista.
- Um instrumento parecido com um barômetro, com um ponteiro de cristal violeta que aponta morro abaixo, na direção da [[grota-funda]].
- O caderno manchado de água de Bento Arruda, de 1866 (veja [[the-fugitive]]).
]==],
  },
  ["funicular"] = {
    title = "O Funicular",
    summary = "Duas ferrovias a cabo que puxavam trens por uma parede de mata de 800 metros.",
    body = [==[
A São Paulo Railway foi inaugurada em 16 de fevereiro de 1867, ligando o porto de Santos ao planalto do café através da Serra do Mar, uma subida que locomotivas comuns não conseguiam fazer {{spr-wiki}}.

## Serra Velha (1867–1970)
O primeiro sistema subia em **quatro planos inclinados**, com uma máquina a vapor fixa em cada patamar puxando os vagões por cabo. Ele conseguia levantar cerca de 60 toneladas por viagem {{funicular-wiki}}.

## Serra Nova (1900–anos 1980)
O segundo sistema dobrou a capacidade com **cinco planos inclinados e cinco patamares** e um "cabo sem fim" correndo sem parar ao longo da linha {{funicular-wiki}}. Os trens eram conduzidos por [[locobreques]] que se agarravam ao cabo em movimento. Ele funcionou comercialmente até 1983 {{museu-funicular}}.

## 1974: a cremalheira
Com a ferrovia nacionalizada em 1946 {{spr-wiki}}, a rede federal substituiu o velho leito da Serra Velha por uma linha de cremalheira e aderência do sistema Abt em 1974, construída pela Marubeni com locomotivas elétricas {{spr-wiki}} {{funicular-wiki}}. Daí em diante, os dias do funicular estavam contados.

## No cenário *(Ficção)*
Todo trem que subia de Santos levava um vagão a mais, fora da lista: veja [[company-car]]. A cremalheira não consegue levá-lo, e a Serra Nova está sendo desativada. É assim que a história começa.
]==],
  },
  ["locobreques"] = {
    title = "As Locobreques",
    summary = "As \"locomotivas-freio\" britânicas que se agarravam a um cabo de aço em movimento.",
    body = [==[
A *locobreque* é uma pequena locomotiva a vapor com uma garra que prende o cabo de aço que corre entre os trilhos {{locobreque-wiki}}. Vinte delas foram construídas na Grã-Bretanha por volta de 1900–1901 pela Kerr, Stewart & Co. e pela Robert Stephenson & Co., e serviram à Serra Nova de 1901 a 1976, empurrando e freando os trens pelos seus cinco planos inclinados {{locobreque-wiki}}.

A locobreque nº 14, construída em 1902, foi a última a ser acesa, em 22 de outubro de 1994, para entusiastas ferroviários em visita. Ela está preservada no Museu do Funicular {{museu-funicular}}.

## No cenário *(Ficção)*
Os maquinistas antigos dizem que as locobreques "puxavam mais pesado na subida do que a balança dizia". Uma locobreque com a caldeira acesa também é o único jeito de mover a [[amethyst-heart|ametista]] no [[ending-sea]].
]==],
  },
  ["fourth-landing"] = {
    title = "O Quarto Patamar",
    summary = "Uma casa de máquinas no meio da Serra Nova, e o dreno embaixo dela.",
    body = [==[
Cada um dos cinco patamares da Serra Nova abrigava uma máquina a vapor fixa que movia o cabo do plano logo abaixo {{funicular-wiki}}.

## No cenário *(Ficção)*
Sob a casa de máquinas do Quarto Patamar, um bueiro de tijolos se afasta da linha e entra na rocha. A cada parada, o [[company-car|Vagão da Companhia]] abria uma válvula e despejava ali sua água do mar, seu ferro e sua pedra britada. Ao lado da máquina de cada patamar ficava uma caçamba onde se varria a limalha dos cabos gastos. O bueiro termina nos túneis sob a [[grota-funda]].

O pai de Eduardo Fonseca ajudou a montar essas máquinas. Foi aqui que começou a loucura dele: veja [[dudu]].
]==],
  },
  ["grota-funda"] = {
    title = "Grota Funda",
    summary = "Um desfiladeiro de 60 metros de profundidade, um viaduto famoso e algo dormindo embaixo dele.",
    body = [==[
A Grota Funda é um desfiladeiro com cerca de 60 m de profundidade e 200 m de largura. O viaduto que leva a ferrovia por cima dela está entre os grandes feitos de engenharia da São Paulo Railway {{unesco}}.

## No cenário *(Ficção)*
Sob o desfiladeiro, túneis abandonados da construção dão numa câmara alagada que já não é feita de pedra: paredes, chão e teto são de cristal violeta, o Corpo do [[amethyst-heart]], que cresceu por um século em volta da Semente no seu centro. Em julho de 1974, as poças de água do mar estão secando e o sal em volta do altar está rachando. Os membros desesperados do [[company-of-shadows|culto]] descem baldes de salmoura à mão.

É aqui que o cenário termina: [[ending-sea]] ou [[ending-shatter]].
]==],
  },

  ---------------------------------------------------------------- O MYTHOS
  ["the-mist"] = {
    title = "A Névoa",
    summary = "A voz da criatura: respire-a e você entra em contato com a coisa sob a montanha.",
    body = [==[
A entidade tem duas metades. Seu **corpo** é uma massa de cristal violeta crescida dentro da rocha sob a [[grota-funda]] (veja [[amethyst-heart]]). Sua **voz** é a névoa. Ela não pode se mover, então fala, e fala do único jeito que pode: pelo ar que as pessoas respiram.

O nevoeiro real de [[paranapiacaba]] {{unesco}} lhe dá o disfarce perfeito.

## Respirar é escutar
Cada fôlego de névoa é um momento de contato com a criatura. Os moradores a respiram de leve há um século e não ouvem mais que um murmúrio, abafado pelo sal que jogam nos bueiros no [[winter-festival]]. O [[company-of-shadows|culto]] a respira de propósito, e seus membros estão em contato profundo. Os investigadores ficam expostos desde a primeira noite na vila.

Este é o coração do horror do cenário: os jogadores estão **sendo infectados o tempo todo**. Quanto mais fundo vão, mais entendem, e mais são entendidos. Regras: [[mist-contact]].

## O que a névoa quer
Ela quer voltar para o mar, como quase voltou em 1866 (veja [[the-fugitive]]). Tudo o que ela sussurra aponta para lá: mostra às pessoas o caminho da Grota Funda, pede que abram os bueiros, que "tragam o mar para cima" ou que "me levem lá para baixo".

## A secagem
À medida que o [[company-car|Vagão da Companhia]] deixa de chegar, a criatura desidrata e fica frenética, e sua voz fica mais alta:
- **Maio:** mais espessa que o normal; o metal enferruja de um dia para o outro; os cães se recusam a sair.
- **Junho:** fria o bastante para embaçar o interior de cômodos fechados. Vozes chamam as pessoas pelo nome.
- **Julho:** tóxica e implacável. Testes de Contato a cada hora ao ar livre depois do entardecer, e a exposição custa 1D2 PV por hora.

## Usando na mesa
Trate a névoa como um relógio e como uma tentação. A cada cena desperdiçada ela engrossa (veja o Relógio da Névoa em [[running]]); cada respiração funda dá uma pista verdadeira, por um preço. Descreva a névoa se fechando em vez de anunciar regras.
]==],
  },
  ["mist-contact"] = {
    title = "Contato com a Névoa",
    summary = "Regras para a infecção lenta de todos que respiram a névoa, investigadores e cultistas.",
    body = [==[
Respirar [[the-mist|a névoa]] coloca a pessoa em contato com a entidade. O Contato vai de 0 a 10 e é acompanhado para cada investigador e cada PdM importante.

## Ganhando Contato
- **Exposição.** A cada cena ao ar livre depois do entardecer, ou em qualquer cena nos túneis: teste de POD. Em caso de falha, ganhe 1 de Contato (1D3 em julho).
- **Respirar fundo.** Um investigador pode escolher respirar a névoa de propósito: ganha 1D2 de Contato e recebe do Guardião uma pista verdadeira, em forma de visão.
- **Toque.** Tocar o corpo de cristal ou a Semente do [[amethyst-heart]]: ganhe 2 de Contato.
- **Carregar a Semente.** Ganhe 1 de Contato a cada hora. Foi assim que [[the-fugitive]] foi tomado.

## Perdendo Contato
- **Sal.** Uma pitada de sal na língua antes de entrar na névoa dá um dado de bônus no teste de POD. Esse é o segredo mais antigo do culto, e o motivo de se jogar sal nos bueiros no [[winter-festival]].
- **O litoral.** Uma noite inteira abaixo da Serra, perto do mar em Santos, remove 1D3 de Contato.
- Contato 9 ou mais nunca pode ser reduzido.

## A escala
@contact

## Quem está onde
- Moradores: 1–2, mantidos baixos pelo sal e pelo hábito.
- Cultistas comuns da [[company-of-shadows|Companhia]]: 5–7, estabilizados com salmoura e sal.
- O [[chief-engineer|engenheiro-chefe]]: 8, e se segurando com dificuldade.
- O pai de [[dudu|Eduardo]] chegou a 10 nos anos 1950. O irmão de [[lenita|Lenita]] está em 9, em algum lugar dos túneis.

## Nota para o Guardião
O Contato é uma maldição e um dom. As visões são pistas verdadeiras, e o Chamado sempre aponta o caminho certo. Deixe os jogadores *escolherem* respirar.
]==],
  },
  ["the-fugitive"] = {
    title = "O Fugitivo",
    summary = "O homem que levou a criatura até a beira do mar em 1866, e por que ela nunca chegou.",
    body = [==[
Em 1866, enquanto a São Paulo Railway ainda abria caminho serra acima {{spr-wiki}}, um homem chegou do interior ao acampamento da obra no Alto da Serra. Estava faminto, descalço, e trazia nas costas um geodo do tamanho da cabeça de uma criança, enrolado em sacos molhados. Disse que se chamava **Bento Arruda**, garimpeiro da terra das ametistas no extremo sul {{amethyst-wiki}}, e que andava havia meses.

Disse que estava fugindo. Nunca disse de quê.

## A verdade
Bento não fugia com a pedra. **A pedra é que fugia, e ele era as pernas dela.** Ela havia enchido os pulmões dele de névoa numa caverna alagada no sul e o guiado para o leste, sempre para o leste, rumo ao mar de que tinha sido separada. O Alto da Serra era a última crista antes do litoral: Paranapiacaba, "o lugar de onde se vê o mar" {{paranapiacaba-wiki}}. Ela enfim podia ver o oceano.

Nunca chegou a ele.

## A captura
Os engenheiros britânicos perceberam que o nevoeiro seguia Bento, que as turmas que trabalhavam perto dele nunca se cansavam e que acordavam com soluções para problemas de engenharia que não tinham conseguido resolver. Tomaram dele a pedra. Naquela noite, Bento tentou levá-la serra abaixo no escuro. Foi encontrado ao amanhecer, ao pé do primeiro plano inclinado, **afogado em terra seca, com os pulmões cheios de água do mar.**

## Por que a alimentaram
Os engenheiros entenderam algo depressa: uma pedra que pode ser carregada sempre vai encontrar novas pernas. Então garantiram que ninguém jamais pudesse carregá-la de novo. Começaram a alimentá-la, com água do mar para mantê-la sonolenta e com ferro e pedra para fazê-la crescer, até que seu corpo encheu os túneis sob a [[grota-funda]] e se fundiu à montanha. Veja [[amethyst-heart]] e [[company-car]].

Aqueles engenheiros se tornaram a primeira [[company-of-shadows|Companhia das Sombras]].

## O que os investigadores podem encontrar
- No escritório do [[castelinho|Castelinho]]: o caderno manchado de água de Bento. As anotações ficam mais curtas à medida que ele se aproxima do litoral. A última linha diz: *"Daqui se vê o mar."*
- No livro de registros do acampamento de 1866: um sepultamento com causa da morte dada como "afogamento", numa montanha 800 m acima do mar.
]==],
  },
  ["amethyst-heart"] = {
    title = "O Coração de Ametista",
    summary = "Uma semente de cristal trazida em 1866, alimentada por um século até seu corpo virar parte da montanha.",
    body = [==[
A criatura tem um coração e um corpo, e eles já não têm o mesmo tamanho.

## A Semente
O geodo original que [[the-fugitive|Bento Arruda]] carregou serra acima em 1866: mais ou menos do tamanho da cabeça de uma criança, cristal violeta por dentro e, por fora, uma superfície de formas enroladas e cheias de barbatanas que nenhuma mão humana esculpiu. Este é o verdadeiro núcleo da criatura.

## O Corpo
Por mais de um século, a [[company-of-shadows|Companhia]] alimentou a Semente, e ela cresceu. Hoje, uma catedral de cristal violeta enche a câmara sob a [[grota-funda]], com veios que correm fundo na rocha da Serra. Pesa centenas de toneladas e faz parte da montanha. **Nunca poderá ser movida.** Era essa a ideia desde o início. A Semente continua no centro, selada dentro do cristal.

## Por que ametista, e o que ela come *(História → Ficção)*
A ametista é quartzo, ou seja, sílica, colorida de violeta por impurezas de ferro ativadas por radiação {{amethyst-wiki}}. Os geodos gigantes do Brasil se formam nas rochas vulcânicas do extremo sul, não no granito da Serra do Mar {{amethyst-usp}}.

A ficção leva isso ao pé da letra. A Companhia alimenta a criatura exatamente com aquilo de que a ametista é feita:
- **Sílica**: brita de granito do leito da ferrovia.
- **Ferro**: limalha dos cabos de aço gastos, das sapatas de freio e dos aros das rodas do funicular, varrida em cada patamar.
- **Água do mar**: o meio em que os cristais crescem, e o sedativo que mantém a criatura sonolenta.

A radiação, a própria criatura fornece. A ferrovia literalmente construiu o corpo dela. Veja [[company-car]].

## Notas de jogo
- Tocar o Corpo ou a Semente: SAN 1/1D6, +2 de [[mist-contact|Contato]] e uma visão do fundo do oceano.
- Soltar a Semente leva uma hora com ferramentas da ferrovia e um teste bem-sucedido de Ciência (Geologia) ou Consertos Mecânicos. O barulho atrai o culto.
- A Semente solta pesa uns 20 kg e pode ser carregada, mas quem a carrega ganha 1 de Contato a cada hora, que foi como Bento morreu.
- A dinamite industrial do almoxarifado da ferrovia pode estilhaçar a Semente: veja [[ending-shatter]].
]==],
  },
  ["winter-festival"] = {
    title = "O Festival de Inverno",
    summary = "Um festival turístico desde 2001. Um rito secreto por mais de um século antes disso.",
    body = [==[
## O registro público *(História)*
O Festival de Inverno de Paranapiacaba teve sua primeira edição pública em julho de 2001: modesta, espalhada por dois fins de semana e visitada por cerca de 11 mil pessoas {{festival-origins}}. Hoje é um dos eventos mais conhecidos da vila.

## O que a vila sabe *(Ficção)*
O festival não começou em 2001. **Esse foi o ano em que o resto de São Paulo ficou sabendo dele.**

Desde que o primeiro [[company-car|Vagão da Companhia]] subiu a serra, a [[company-of-shadows|Companhia das Sombras]] faz um festival todo inverno, nas noites mais frias, quando [[the-mist|a névoa]] está mais espessa. Para as famílias ferroviárias era simplesmente *o Festival*: fogueiras no nevoeiro, música, bebidas quentes e ninguém de fora. Nunca foi anunciado, nunca saiu em jornal, e forasteiros que chegavam durante ele eram educadamente colocados no próximo trem de descida.

Por baixo da celebração está o rito:
- Joga-se sal nos bueiros da vila. Isso mantém raso o [[mist-contact|contato]] dos moradores por mais um ano.
- O bueiro de tijolos do [[fourth-landing]] é "alimentado" à mão com salmoura e limalha de ferro.
- Os nomes dos mortos e desaparecidos do ano são lidos em voz alta no [[castelinho|Castelinho]] pelo [[chief-engineer|engenheiro-chefe]].
- À meia-noite todos os lampiões se apagam, e a vila escuta o nevoeiro respirar.

## Em 1974
Com as viagens do vagão-tanque cortadas, o festival de 1974 é desesperado. O rito é maior, mais barulhento e menos cuidadoso, e pela primeira vez há gente de fora na vila para vê-lo. Os investigadores chegam enquanto ele é preparado.

## Em 2001 *(Ficção)*
Depois dos acontecimentos de 1974, o que restou da Companhia já não conseguia manter o festival em segredo, então fez o contrário: abriu-o ao público. Hoje os turistas dançam no mesmo nevoeiro, e ninguém pergunta por que os moradores ainda jogam sal nos bueiros.
]==],
  },
  ["company-car"] = {
    title = "O Vagão da Companhia",
    summary = "O vagão-tanque fora da lista, com água do mar, ferro e pedra, que subiu em todo trem por um século.",
    body = [==[
Todo trem que subia de Santos ao planalto era obrigado a levar um vagão a mais: um vagão-tanque modificado, registrado nos livros como "lastro", ou nem registrado.

## A carga
O tanque levava toneladas de água do mar e, nela, uma lama de **granito britado e limalha de ferro**: o pó da própria ferrovia, recolhido dos cabos gastos, das sapatas de freio e das rodas em cada patamar. No [[fourth-landing]], o vagão despejava sua carga no subsolo, rumo à [[grota-funda]].

A água do mar mantinha a criatura sonolenta. O ferro e a pedra alimentavam o corpo de cristal que a mantém acorrentada à montanha. Veja [[amethyst-heart]].

## O segredo mecânico
Na ficção, o peso morto deste vagão é o motivo escondido para a ferrovia precisar de máquinas fixas tão potentes, de cabos de aço e de [[locobreques]]. O motivo real eram a carga e uma subida de 796 m {{unesco}}, o que torna a mentira fácil de acreditar.

## Pistas
- Manchas de ferrugem em forma de linhas de maré dentro de um vagão-tanque abandonado no pátio.
- Barris lacrados com a etiqueta "LIMALHA — 4º PATAMAR" empilhados atrás do galpão das máquinas.
- Contas mostrando custos de "água de lastro" que nenhum auditor jamais questionou (veja [[dudu]]).
- A última carta de um operário desaparecido sobre "algo vivo no fundo do tanque" (veja [[lenita]]).
]==],
  },

  ---------------------------------------------------------------- FACÇÕES
  ["company-of-shadows"] = {
    title = "A Companhia das Sombras",
    summary = "A ordem secreta dos antigos acionistas britânicos, e as famílias locais que a servem.",
    body = [==[
Uma ordem secreta fundada pelos engenheiros britânicos que capturaram a pedra de [[the-fugitive|Bento Arruda]] em 1866, à qual depois se juntaram os acionistas da ferrovia e um punhado de famílias locais. Eles servem à entidade em troca de prosperidade e dos segredos de engenharia e de alquimia que ela sussurra. A ferrovia impossível foi seu primeiro milagre.

Depois da nacionalização em 1946 {{spr-wiki}}, os acionistas perderam a ferrovia, mas mantiveram o culto. Seus membros continuaram como engenheiros, mestres de obra e escriturários, e mantiveram o [[company-car|Vagão da Companhia]] rodando sob uma nova bandeira.

## Infectados pela devoção
Todo membro da Companhia respira a névoa de propósito, e todos estão em [[mist-contact|Contato]] profundo. Eles evitam se afogar nela com sal na língua e salmoura no chá. Seus sinais silenciosos com as mãos foram aprendidos com a criatura, não uns com os outros.

Todo inverno desde 1868, a Companhia esconde seu rito dentro de uma celebração particular da vila, que o público só descobriu em 2001: veja [[winter-festival]].

## Em 1974
A ordem está assustada e dividida. Sem os vagões-tanque, a névoa fica mais alta na cabeça deles a cada noite. Alguns querem arrastar a criatura até a nova linha de cremalheira; outros planejam um sacrifício grande o bastante para ganhar tempo. Todos querem ver os auditores da RFFSA longe dali. Eles são liderados pelo [[chief-engineer|engenheiro-chefe]]. Os membros ativos estão em [[cultists]].
]==],
  },
  ["chief-engineer"] = {
    title = "O Engenheiro-Chefe",
    summary = "Grão-Mestre do culto, morador do Castelinho, guardião dos telégrafos.",
    body = [==[
Quem ocupa o cargo de engenheiro-chefe e mora no [[castelinho|Castelinho]] é, por direito ritual, Grão-Mestre da [[company-of-shadows|Companhia das Sombras]]. Todos os nomeados desde o século 19 foram recrutados, de um jeito ou de outro. O cargo passa adiante quando um engenheiro-chefe enfim "se afoga".

O atual engenheiro-chefe, **Henrique Ashworth**, nasceu em São Paulo numa família que veio com a São Paulo Railway, e ocupa o cargo desde 1958. Ele usa os telégrafos e os livros de registro da ferrovia para organizar sacrifícios e esconder o enorme consumo de água do mar e de ferro. É cortês, cansado e tem muito medo. Está em [[mist-contact|Contato]] 8, chupa pastilhas de sal o tempo todo e ouve a criatura a cada minuto acordado. Sabe melhor do que ninguém o que acontece quando a água acaba.

## Como interpretá-lo
No começo, ele não quer os investigadores mortos. Quer que eles *entendam*, e depois ajudem. Ofereça a eles um acordo antes de oferecer uma faca. Se um investigador estiver Tocado pela Maré, ele vai falar com ele nos sinais silenciosos do culto, e o investigador vai entender. O jantar e o acordo dele estão em [[scene-castelinho]].

@npc:ashworth
]==],
  },

  ---------------------------------------------------------------- FINAIS
  ["ending-sea"] = {
    title = "Final A — De Volta ao Mar",
    summary = "Soltar a Semente e levá-la até o oceano para onde ela fugia.",
    body = [==[
**Ação.** Os investigadores soltam a Semente do Corpo de cristal do [[amethyst-heart]] e a levam até o mar em Santos, no último trem do funicular puxado por uma [[locobreques|locobreque]] a vapor, ou pelos velhos bueiros de drenagem. A cada hora, quem a carrega ganha 1 de [[mist-contact|Contato]], e a criatura canta o caminho todo. Alguém precisa fazer a viagem que Bento Arruda nunca terminou.

**Consequência.** Sem a Semente, o Corpo de cristal sob a montanha se apaga, e a névoa mortal se levanta de [[paranapiacaba|Paranapiacaba]]. Mas o horror volta ao seu elemento. Acontecimentos estranhos, naufrágios misteriosos e avistamentos de um redemoinho voltam ao litoral paulista.

**Para a mesa.** Um final agridoce que prepara uma continuação no litoral. Os investigadores sobreviventes perdem 1D6 de SAN cada um ao ver o mar "respirar", e o Contato deles nunca volta de todo a zero.
]==],
  },
  ["ending-shatter"] = {
    title = "Final B — Estilhaçar a Pedra",
    summary = "Quebrar a ametista com dinamite da ferrovia, e pagar por isso com a vila.",
    body = [==[
**Ação.** Os investigadores estilhaçam a Semente no centro do [[amethyst-heart]] com dinamite industrial do almoxarifado da ferrovia.

**Consequência.** A entidade é "morta", mas um século de energia guardada no seu Corpo de cristal é liberado de uma vez numa explosão pneumática. [[the-mist|A névoa]] se assenta na vila para sempre, agora sem voz e sem fim, deixando Paranapiacaba para sempre dentro de um nevoeiro fora do tempo, enlouquecida e isolada do resto do Brasil.

**Para a mesa.** Uma vitória de Pirro. O litoral está a salvo; a vila está perdida. Todos na câmara fazem um teste de CON ou perdem 2D6 PV, e um teste de SAN ou perdem 1D10. Todos com Contato 7 ou mais ouvem o último grito da criatura e perdem mais 1D6 de SAN.
]==],
  },
  ["ending-lost"] = {
    title = "Final C — A Névoa Guarda os Seus",
    summary = "Estado de falha opcional: o tempo dos investigadores acaba.",
    body = [==[
*Final opcional, para mesas que gostam de riscos de verdade.*

Se o [[running|Relógio da Névoa]] encher antes de os investigadores chegarem à [[grota-funda]], a névoa vence. A criatura não desperta; ela simplesmente *se espalha*. O culto é encontrado afogado num túnel seco. Os investigadores acordam em Santos sem lembrança da última semana, e com um gosto de sal que não passa.

O mesmo final vale para qualquer investigador que chegue a [[mist-contact|Contato]] 10: ele simplesmente não está lá quando os outros acordam.

Este final existe para que o [[running|Relógio da Névoa]] de fato importe.
]==],
  },

  ---------------------------------------------------------------- REFERÊNCIA
  ["sources"] = {
    title = "Fontes",
    summary = "Todas as referências do mundo real citadas neste livro.",
  },
  ["about"] = {
    title = "Sobre este Livro",
    summary = "Quem escreveu, como foi construído e como usar.",
    body = [==[
*A Névoa sobre o Funicular* é um cenário de investigação original para [[sources|Call of Cthulhu 7ª Edição]] {{coc7}}, escrito por **Murillo França M. da Silva**, mestre de jogo há mais de dez anos (D&D, Tormenta e outros).

## Como foi construído
O livro inteiro é feito de dados simples em **Lua**: capítulos, artigos, investigadores, personagens do Guardião, handouts, fontes, uma linha do tempo e um grafo do cenário. Um pequeno script de build em Lua transforma tudo isso neste site. Na hora do build, o script:
- confere se cada link interno e cada citação apontam para algo que existe;
- recalcula os atributos derivados (PV, PM, Sanidade, Movimento, Bônus de Dano, Corpo) de cada investigador e personagem do Guardião pelas regras de Call of Cthulhu 7e e falha se uma ficha discordar;
- confere se cada artigo, investigador e handout está em exatamente um capítulo;
- percorre o grafo do [[scenario-flow]] e falha se alguma cena for inalcançável ou se algum caminho acabar antes de um final;
- gera os links de volta ("Citada em") mostrados no fim de cada página.

Trate o livro como prática de conteúdo e de programação ao mesmo tempo: narrativa escrita como dados, depois conferida por código.

## Contribuindo
Todo artigo termina com um jeito de enviar as suas ideias: um personagem, uma pista, uma cena, uma correção. As contribuições são revisadas pelo autor, e as aceitas recebem crédito no livro.
]==],
  },

  ---------------------------------------------------------------- CONDUZINDO
  ["running"] = {
    title = "Conduzindo o Cenário",
    summary = "O tom, o Relógio da Névoa, um plano para três sessões e como manter a mesa segura.",
    body = [==[
*A Névoa sobre o Funicular* é uma investigação de tensão lenta para **três investigadores**, jogada em **duas ou três sessões** de umas quatro horas. Funciona como aventura de uma sessão se você cortar [[scene-tunnel|o Túnel]] e começar com os investigadores já juntos [[scene-festival|no Festival]].

## O tom
Frio, úmido e triste, mais do que sangrento. O horror é que os investigadores estão sendo mudados pelo ar que respiram, e que as duas saídas custam algo de verdade. Mantenha humanas as pessoas da vila: a maioria está com medo, não é má, e joga sal nos bueiros porque os avós jogavam.

## O Relógio da Névoa
A névoa é o cronômetro do cenário. Mantenha uma trilha de **10 marcas** onde os jogadores possam ver, e marque uma:
- a cada noite que passa;
- a cada cena que os investigadores passam sem se aproximar da [[grota-funda|Grota Funda]] (repetir uma busca, discutir no quarto, descer de volta para Santos).

| Marcas | Estágio | O que muda |
|---|---|---|
| 1–5 | Junho | Testes de Contato a cada cena ao ar livre depois do anoitecer. O nevoeiro embaça o lado de dentro dos quartos fechados e chama as pessoas pelo nome. |
| 6–9 | Julho | Testes de Contato **a cada hora** ao ar livre depois do anoitecer, com 1D3 de Contato numa falha; a exposição custa 1D2 PV por hora. |
| 10 | — | A névoa toma a vila: [[ending-lost]]. |

::: keeper
Nunca anuncie as regras do relógio como ameaça. Descreva: o orvalho do lado de dentro das janelas, os cachorros que não saem, a dona da pensão salgando os travesseiros. Os jogadores vão entender.
:::

## Um plano para três sessões
- **Sessão 1.** [[scene-arrival]], depois uma ou duas entre [[scene-yard|o Pátio]], [[scene-festival|o Festival]] e [[scene-tunnel|o Túnel]]. Termine no convite do engenheiro-chefe para jantar.
- **Sessão 2.** [[scene-castelinho|O Jantar no Castelinho]] e o escritório, depois a subida a pé ou de locobreque até [[scene-landing|o Quarto Patamar]]. Termine na boca do bueiro.
- **Sessão 3.** [[scene-grota|Sob a Grota Funda]], a escolha e um dos finais.

## Segurança na mesa
O cenário toca em afogamento, num irmão desaparecido e numa vila real, habitada. Combinem limites e véus antes de começar. Se alguém na mesa perdeu um parente, a trama de Lenita pode terminar com Tonico encontrado vivo, veja [[tonico]].

## O pano de fundo político
O cenário se passa durante o governo militar no Brasil {{dictatorship-wiki}}. Censura, uma ferrovia estatal e uma ativista no trem dão pressão real à mesa sem precisar de um vilão fardado: um policial na estação que recolhe os panfletos de Lenita, um editor que não publica as fotos de Arthur, um auditor que responde a Brasília.
]==],
  },

  ---------------------------------------------------------------- INVESTIGADORES
  ["investigators-intro"] = {
    title = "Reunindo o Grupo",
    summary = "Como os três investigadores se encontram, e como usar os seus no lugar deles.",
    body = [==[
Os três investigadores prontos chegam na mesma noite de inverno, por três motivos diferentes, e acabam debaixo do mesmo teto: a **Pensão da Dona Ercília**, a única da vila que aceita forasteiros durante o [[winter-festival|festival]].

- **Eduardo "Dudu" Fonseca** sobe no último trem de Santos com uma pasta de relatórios de custos da RFFSA.
- **Helena "Lenita" Castro** está no mesmo trem, na terceira classe, com uma caixa de panfletos e a carta do irmão (veja [[h-letter]]).
- **Arthur Mendes** sobe a estrada velha num Fusca emprestado e chega enquanto os outros carregam as malas para dentro.

Dona Ercília serve o jantar para os três juntos, porque só existe uma mesa. Deixe os jogadores apresentarem seus investigadores ali. Antes de dormirem, ela põe uma pitada de sal em cada travesseiro e não diz por quê.

## Cada um segura um fio
| Investigador | Puxa para | O que está em jogo |
|---|---|---|
| [[dudu]] | o dinheiro: o [[company-car]] e [[scene-yard|o Pátio]] | a loucura do pai no [[fourth-landing]] |
| [[lenita]] | as pessoas: [[scene-festival|o Festival]] e o culto | o irmão, [[tonico]], desaparecido nos túneis |
| [[arthur]] | a imagem: [[scene-tunnel|o Túnel]] e o [[castelinho]] | o negativo que a antiga diretoria tomou dele |

## Usando investigadores próprios
Qualquer investigador dos anos 1970 serve. Dê a cada jogador um dos três fios acima como motivo para estar na serra: alguém conferindo as contas, alguém procurando um parente desaparecido que trabalhava nos vagões-tanque, alguém que um dia viu algo numa fotografia da Serra. Acompanhe o Contato de cada um desde a primeira noite.

::: keeper
Escreva o **Contato** de cada investigador num cartão na frente dele, começando em 0. É o número mais importante deste cenário, e deve estar à vista.
:::
]==],
  },

  ---------------------------------------------------------------- A INVESTIGAÇÃO
  ["scene-arrival"] = {
    title = "1. Chegada ao Alto da Serra",
    summary = "Uma noite de inverno, o último trem, uma vila preparando um festival de que ninguém de fora ouviu falar.",
    body = [==[
::: read
O trem sai de Santos com o dia claro e entra na nuvem. Em algum ponto da subida as janelas ficam brancas e não voltam mais. Quando vocês descem no Alto da Serra, o relógio da estação marca seis e dez, mas a luz já foi embora; o nevoeiro é tão grosso que os lampiões da plataforma são só manchas laranja.

A vila está ocupada. Homens empilham lenha na praça. Mulheres carregam bandejas cobertas com panos. Ninguém olha para vocês por muito tempo. Sob os sapatos, nos degraus da estação, alguma coisa estala como areia. É sal.
:::

## O que há aqui
A **estação** do Alto da Serra e sua torre do relógio britânica, a praça em frente e as ladeiras de casas de madeira descendo até o pátio. A vila prepara o [[winter-festival|Festival de Inverno]], para o qual nenhum forasteiro foi convidado em cem anos. Um policial na estação anota o nome de todo mundo que desce do trem. Os investigadores se hospedam na **Pensão da Dona Ercília** (veja [[investigators-intro]]).

## Pistas
- **Encontrar.** Linhas de sal em todas as soleiras, inclusive na da pensão. Recentes, não antigas.
- **Psicologia** nos moradores: eles não são hostis. Têm medo *pelos* forasteiros.
- **Persuasão ou Charme** com Dona Ercília: "Vocês deviam ter vindo no mês que vem. Ou nunca. O festival é nosso." Ela não diz nada sobre o sal.
- **Escutar**, do lado de fora depois de escurecer: alguém no nevoeiro chama um investigador pelo primeiro nome. Não há ninguém.

## A primeira noite
É o primeiro teste de **Contato** do cenário: cada investigador que sai depois do anoitecer testa POD (veja [[mist-contact]]). No quarto, Lenita relê a carta do irmão ([[h-letter]]).

::: keeper
Não explique a névoa. Descreva que ela está mais fria do que devia, que tem um cheiro leve de praia, que o orvalho na janela está do lado de *dentro*.
:::
]==],
  },
  ["scene-yard"] = {
    title = "2. O Pátio Ferroviário",
    summary = "A auditoria de Dudu: livros-caixa cheios de \"água de lastro\" e um vagão-tanque com marcas de maré por dentro.",
    body = [==[
::: read
O pátio é um campo de ferro molhado. Fileiras de vagões esperam sob o nevoeiro, as rodas cobertas de gotas. Depois delas, a rotunda solta vapor, e atrás dela, meio afundado no mato, há um vagão-tanque sem número na lateral. A escotilha está aberta. Tem cheiro de mar.
:::

## O que há aqui
O escritório do pátio, onde Dudu tem hora marcada com o escriturário da seção; a rotunda; o **vagão-tanque** abandonado do [[company-car]]; uma pilha de barris lacrados atrás do galpão. O capataz, **Moacir**, um [[cultists|cultista]], vigia os investigadores a manhã toda e não faz questão de esconder.

## Pistas
- **Contabilidade (Dudu).** A linha "água de lastro" custou à ferrovia mais do que o carvão, todos os anos desde 1946. Nenhum auditor jamais a questionou. A ordem da RFFSA suspendendo o serviço está pregada acima da mesa do escriturário: [[h-memo]].
- **Encontrar.** Dentro do tanque: manchas de ferrugem em anéis, como marcas de maré num píer. Atrás do galpão: barris pintados com **"LIMALHA — 4º PATAMAR"**.
- **Ciência (Geologia)** no sedimento do fundo do tanque: granito britado, limalha de ferro e um pó violeta que só pode ser ametista. Ametista não pertence a esta serra {{amethyst-usp}}.
- **Consertos Mecânicos.** Canos de drenagem saem do desvio do tanque e sobem a serra, ao longo do plano inclinado, rumo ao [[fourth-landing]].

::: history
A ferrovia de fato dependia de máquinas fixas pesadas e cabos de aço para vencer os 796 m da Serra {{unesco}}. O vagão-tanque é invenção do cenário.
:::

## Complicações
Se os investigadores ficarem por ali à noite, Moacir e dois cultistas passam salmoura dos barris para baldes e sobem a serra carregando à mão. Segui-los leva ao [[scene-landing|Quarto Patamar]].
]==],
  },
  ["scene-festival"] = {
    title = "3. O Festival de Inverno",
    summary = "Fogueiras no nevoeiro, sal nos bueiros, nomes lidos em voz alta e um velho maquinista que se lembra.",
    body = [==[
::: read
Ao anoitecer a praça está cheia. Fogueiras ardem em tambores de ferro e o nevoeiro transforma a luz delas em grandes globos macios. Alguém toca sanfona. Tem quentão em canecas de lata, doce de gengibre e cachaça. Crianças correm entre as pernas dos adultos jogando punhados de uma coisa branca nos bueiros, e os adultos deixam.
:::

## O que há aqui
A festa particular das famílias ferroviárias, na véspera do rito (veja [[winter-festival]]). A maioria dos moradores é calorosa com os forasteiros quando eles têm uma caneca na mão. **Seu Ditinho** ([[old-railwayman]]), que dirigiu locobreques por cinquenta anos, está sentado na fogueira maior e conversa com quem quiser ouvir.

## Pistas
- **Persuasão ou Charme** com Seu Ditinho: "As máquinas puxavam mais pesado na subida do que a balança dizia. Sempre um vagão a mais. Um vagão que nunca estava no horário."
- **História (Folclore Local) (Lenita).** Não existe registro deste festival em lugar nenhum: nem nos jornais, nem nos boletins da própria ferrovia.
- **Encontrar.** Os bueiros não estão sendo limpos. Estão sendo **salgados**.
- **Escutar**, à meia-noite: todos os lampiões da vila se apagam ao mesmo tempo, e no silêncio o nevoeiro *respira*. Todos os presentes fazem um teste de Contato.

## Os nomes
No fim da noite, o engenheiro-chefe lê, nos degraus do [[castelinho]], os nomes dos mortos e desaparecidos do ano. Um deles é **Antônio Castro**. Lenita perde 0/1D3 SAN.

## Desdobramentos
O engenheiro-chefe repara nos forasteiros. Antes de a noite acabar, um menino leva um cartão dobrado até a pensão: um convite para jantar no Castelinho, amanhã, para "os senhores da RFFSA e da imprensa, e a moça de Santos".
]==],
  },
  ["scene-tunnel"] = {
    title = "4. O Túnel",
    summary = "A velha foto de Arthur, refeita: a névoa tem rostos, e alguém observa do alto do morro.",
    body = [==[
::: read
A boca do túnel está exatamente como na cópia: um arco preto na mata, meio quilômetro serra abaixo, com o cabo entrando nele entre os trilhos. A névoa sai lá de dentro como o bafo numa manhã fria. Está tudo muito quieto. Então, em algum lugar sob os seus pés, vocês ouvem água.
:::

## O que há aqui
Um túnel desativado no plano inclinado da Serra Nova, uma longa descida abaixo da vila. Chegar lá exige andar pela linha (um teste de **Escalar** no trecho íngreme; uma falha custa 1D6 PV numa queda). A névoa aqui é densa mesmo de dia.

## Pistas
- **Arte/Ofício (Fotografia) (Arthur).** Uma foto nova do túnel, revelada à noite no banheiro da pensão, mostra os mesmos rostos da antiga, e mais um: um rapaz de boné de ferroviário. SAN 0/1D4. Lenita reconhece o irmão.
- **Encontrar.** Pegadas nos dormentes, molhadas de água do mar, entrando e saindo. Um boné de ferroviário com uma crosta de sal por dentro e *A. CASTRO* escrito a tinta na faixa.
- **Escutar.** Água corre sob a rocha, serra abaixo, rumo à [[grota-funda|Grota Funda]].
- **Encontrar**, olhando de volta para o alto do morro: o brilho de um binóculo nas janelas do [[castelinho]].

## Complicações
Cada hora passada aqui é um teste de Contato, de dia ou de noite. Um investigador que respira fundo de propósito (veja [[mist-contact]]) vê por um instante o interior da montanha: luz violeta, e algo muito grande, dormindo.
]==],
  },
  ["scene-castelinho"] = {
    title = "5. O Jantar no Castelinho",
    summary = "O engenheiro-chefe oferece um acordo; o escritório dele guarda um século de segredos.",
    body = [==[
::: read
O Castelinho fica acima da vila como um comandante na ponte de um navio. Todas as suas trinta e três janelas estão acesas. Lá dentro, pela primeira vez desde que vocês chegaram, está quente: seis lareiras, todas acesas. O engenheiro-chefe recebe vocês na porta em pessoa. É um homem alto e cansado de uns sessenta anos, educado do velho jeito britânico, e tem um cheiro leve de sal.
:::

## O que há aqui
A casa do engenheiro-chefe (veja [[castelinho]]) e **Henrique Ashworth** ([[chief-engineer]]). O jantar é rosbife com batatas cozidas, servido por uma governanta calada. Na parede da sala de jantar há um instrumento parecido com um barômetro, com um ponteiro de cristal violeta que aponta serra abaixo.

## O acordo
Ashworth quer que os investigadores entendam, e depois que ajudem. Ele oferece a cada um aquilo que veio buscar:
- a **Dudu**, mais um ano de "água de lastro" aprovado na auditoria, e a verdade sobre o pai;
- a **Arthur**, o negativo, devolvido naquela noite;
- a **Lenita**, o lugar onde está o irmão.

Em troca, pede que eles partam no primeiro trem depois do festival e não digam nada. **Psicologia:** ele está apavorado, e diz a verdade sobre o negativo e sobre o irmão.

## O escritório
O escritório está trancado (**Chaveiro**, ou **Furtividade** para tirar a chave do avental da governanta). Lá estão:
- o registro do telégrafo: [[h-telegrams]];
- o caderno de Bento Arruda: [[h-notebook]];
- o registro do acampamento de 1866: [[h-register]];
- a cópia confiscada de Arthur, com a etiqueta da diretoria: [[h-photo]], e o negativo num envelope;
- um esboço geológico de um geodo, em inglês, assinado por um engenheiro em 1867.

Ler tudo leva uma hora e um teste de **Usar Bibliotecas**; custa 1D3 SAN e dá +2% em Mitos de Cthulhu.

::: keeper
Se algum investigador estiver com Contato 7 ou mais, Ashworth fala com ele nos sinais de mão silenciosos do culto durante o jantar, e ele entende. Use isso: é a coisa mais assustadora da cena.
:::

## Desdobramentos
Se aceitarem o acordo, Ashworth os leva pessoalmente até [[scene-grota|a câmara]] na noite seguinte, para "mostrar por quê". Se recusarem ou forem pegos no escritório, ele os deixa ir, e o culto começa a vigiar a pensão.
]==],
  },
  ["scene-landing"] = {
    title = "6. O Quarto Patamar",
    summary = "Uma casa de máquinas no meio da serra, uma caixa de limalha de ferro e um bueiro que engole o mar.",
    body = [==[
::: read
A casa de máquinas do Quarto Patamar é um salão de tijolos construído em volta de um tambor de enrolar cabo do tamanho de um carrossel. A máquina está fria. No chão, ao lado dela, uma caixa de madeira transborda de pó de ferro cinzento, varrido dos cabos. No canto, uma tampa redonda de ferro no piso, com um volante de válvula. Está molhada nas bordas, e está quente.
:::

## O que há aqui
O quarto dos cinco patamares da Serra Nova (veja [[fourth-landing]]). Para chegar, uma longa subida a pé pelo plano inclinado, ou uma viagem de [[locobreques|locobreque]] se Seu Ditinho for convencido a acender a caldeira. De noite há de dois a quatro [[cultists|cultistas]] aqui, despejando salmoura e limalha pela tampa, à mão.

## Pistas
- **Consertos Mecânicos.** A válvula abre o **bueiro**, um túnel de tijolos onde mal cabe uma pessoa rastejando, descendo para dentro da rocha.
- **Ciência (Geologia).** As paredes de rocha do bueiro passam de granito cinza a um violeta fraco quanto mais fundo vão.
- **Encontrar.** No depósito: uma caixa de **dinamite da ferrovia**, usada para limpar desmoronamentos, com estopim e espoletas. Faz diferença no [[ending-shatter]].
- **Dudu**, se estiver presente: uma placa no tambor traz o nome do pai entre os ajustadores que o montaram.

## O bueiro
Rastejar pelo bueiro até a [[grota-funda|Grota Funda]] leva uns quarenta minutos no escuro e na água. Cada investigador faz um teste de **CON** ou perde 1 PV com o frio, e um teste de Contato pelos túneis.

::: keeper
Se os cultistas virem os investigadores, não gritam: fazem sinais uns para os outros e vêm em silêncio. Dois ou mais juntos ganham um dado de bônus para agarrar. Eles querem os intrusos dentro do bueiro, não mortos.
:::
]==],
  },
  ["scene-grota"] = {
    title = "7. Sob a Grota Funda",
    summary = "A câmara de cristal violeta, a Semente no centro e a escolha.",
    body = [==[
::: read
O bueiro se abre num espaço tão grande que as lanternas não alcançam o outro lado. Toda superfície é cristal: violeta, brilhando de leve, crescido em grandes colunas nervuradas do chão ao teto, como o interior de uma catedral feita de geodo. Poças de água do mar secaram em anéis brancos no chão. No meio da câmara, selada dentro de uma coluna de cristal, uma coisa do tamanho da cabeça de uma criança pulsa devagar, cheia de luz.

E a névoa, que seguiu vocês até aqui embaixo, começa a cantar.
:::

**SAN 1/1D6** ao entrar na câmara. Todos fazem um teste de Contato na hora.

## O que há aqui
O Corpo do [[amethyst-heart|Coração de Ametista]], e a **Semente** no centro. Cultistas descem baldes de salmoura do bueiro, desesperados, enquanto a criatura grita na cabeça de todos eles. Entre eles está **Tonico Castro** ([[tonico]]), com Contato 9, que fala com a voz da criatura. Se Ashworth estiver aqui, ele implora para os investigadores ajudarem a mantê-la dormindo.

## O que pode ser feito
- **Arrancar a Semente:** uma hora de trabalho com ferramentas da ferrovia e um teste bem-sucedido de **Ciência (Geologia)** ou **Consertos Mecânicos**. O barulho atrai mais 1D3 cultistas a cada quinze minutos. Tocar a Semente custa SAN 1/1D6 e +2 de Contato. Depois: [[ending-sea]].
- **Estilhaçá-la:** a dinamite do [[scene-landing|Quarto Patamar]], encostada na coluna. Acender leva uma rodada e coragem: um teste de POD se quem acende estiver com Contato 5 ou mais. Depois: [[ending-shatter]].
- **Ajudar o culto:** os investigadores podem carregar salmoura junto. Isso compra mais um ano, ao preço do silêncio deles, e o Relógio da Névoa volta a 0. No próximo inverno tudo recomeça.

Se o Relógio da Névoa encher antes de os investigadores chegarem aqui, o cenário termina no [[ending-lost]].

::: keeper
É o momento para o qual o cenário inteiro foi construído. Deixe os jogadores discutirem. Deixe Tonico falar com Lenita numa voz que é quase a dele. Não apresse a escolha; a névoa já está fazendo isso.
:::
]==],
  },

  ---------------------------------------------------------------- PERSONAGENS
  ["cultists"] = {
    title = "Os Cultistas",
    summary = "Capatazes, escriturários e guarda-freios de dia; carregadores de salmoura nos túneis à noite.",
    body = [==[
Os membros ativos da [[company-of-shadows|Companhia das Sombras]] são gente da ferrovia: o capataz do pátio, **Moacir**, o escriturário da seção, alguns guarda-freios e suas esposas. Não são monstros. Respiram a névoa de propósito há anos, ouvem a criatura toda noite e têm pavor do que acontece se ela acordar.

## Como agem
- De dia, vigiam, mandam relatórios ao [[castelinho]] pelo telégrafo e fazem questão de que os investigadores percebam que estão sendo vigiados.
- De noite, carregam salmoura e limalha até o [[fourth-landing]] à mão, e não deixam ninguém impedir.
- Numa luta, não dizem nada. Fazem sinais com as mãos, uma língua que a criatura ensinou a eles.

@npc:cultist
]==],
  },
  ["tonico"] = {
    title = "Tonico Castro",
    summary = "O irmão de Lenita, dezenove anos, uma Voz da Salmoura nos túneis.",
    body = [==[
Antônio Castro limpava os [[company-car|vagões-tanque da companhia]] em Santos até a criatura começar a chamá-lo pelo nome. O culto o trouxe para a serra para "ajudar no festival": na verdade, Ashworth esperava que uma voz nova a acalmasse. Aconteceu o contrário. Tonico desceu pelo bueiro em 16 de junho ([[h-telegrams]]) e não voltou.

Ele está com **Contato 9**. Quando a névoa está densa, a criatura fala por ele, e sabe tudo o que ele sabe sobre a irmã.

## Interpretando Tonico
Ele não é vilão, e também não é bem uma vítima. Carrega salmoura com os cultistas, cantarola a canção da criatura e fala do mar como *casa*. Quando Lenita chegar até ele, dê a ele um momento de si mesmo: um apelido de infância, uma piada, o nome dela dito do jeito certo. Depois deixe a névoa tomar a voz de volta.

@npc:tonico
]==],
  },
  ["old-railwayman"] = {
    title = "Seu Ditinho",
    summary = "Um maquinista de locobreque aposentado que se lembra do vagão que nunca estava no horário.",
    body = [==[
Benedito Ramos dirigiu [[locobreques]] na Serra Nova por cinquenta anos e passou os últimos dez na fogueira maior de todo festival, conversando. Todo mundo o chama de **Seu Ditinho**. Ele não está no culto, e sempre desconfiou dele; mantém o Contato baixo com sal nos bolsos e uma teimosia que a vila inteira respeita.

## O que ele sabe
- As máquinas "puxavam mais pesado na subida do que a balança dizia. Sempre um vagão a mais."
- O vagão a mais parava no Quarto Patamar toda noite e voltava leve.
- O pai de Eduardo Fonseca era um homem bom, e "o que fizeram com ele foi pecado".

## O que ele pode fazer
Ele sabe acender a caldeira de uma locobreque e conduzi-la, se os investigadores acharem uma que ainda funcione, o que faz diferença para levar a Semente serra abaixo no [[ending-sea]]. Ele não entra nos túneis.

::: history
A locobreque nº 14, construída em 1902, foi a última a ser acesa, em 1994, e sobrevive no Museu do Funicular {{museu-funicular}}. Seu Ditinho é ficção; a máquina que ele dirigia era real.
:::

@npc:ditinho
]==],
  },

  ---------------------------------------------------------------- DESFECHOS
  ["aftermath"] = {
    title = "Consequências e Recompensas",
    summary = "Recompensas de Sanidade, o que o Contato deixa para trás e para onde a história pode ir.",
    body = [==[
## Recompensas de Sanidade
| Desfecho | Recompensa |
|---|---|
| A Semente chega ao mar ([[ending-sea]]) | +1D10 SAN para cada sobrevivente |
| Tonico volta para casa com Lenita | +1D6 SAN para Lenita |
| A Semente é destruída ([[ending-shatter]]) | +1D6 SAN para cada sobrevivente |
| Dudu descobre o que aconteceu com o pai | +1D4 SAN para Dudu |
| Arthur recupera o negativo | +1D4 SAN para Arthur |
| Os investigadores ajudam o culto | Nenhuma recompensa. Cada um mantém seu Contato, e ele nunca mais cai abaixo de 3. |

## O que o Contato deixa
O Contato cai 1 a cada mês passado longe da Serra, mas nunca abaixo de 1: todo investigador que respirou a névoa vai ouvir o próprio nome num nevoeiro pelo resto da vida. Quem terminou com 7 ou mais mantém a vontade de sal e ainda entende os sinais silenciosos.

## A história segue
O funicular da Serra Nova funcionou comercialmente até 1983 {{museu-funicular}}, e o Festival de Inverno de Paranapiacaba abriu ao público em 2001 {{festival-origins}}. Na ficção, as duas datas são consequência do que os investigadores fizeram: veja [[winter-festival]].

## Ganchos para continuar
- **A Maré de Santos** (depois do [[ending-sea]]): naufrágios na costa, um redemoinho visto da praia à noite e um pescador que diz que o mar está cantando.
- **O Nevoeiro que Ficou** (depois do [[ending-shatter]]): anos depois, alguém tenta chegar de carro a uma vila que os mapas dizem que existe.
- **O Próximo Inverno** (se eles ajudaram o culto): Ashworth morreu, e o cargo de engenheiro-chefe é oferecido a Dudu.
]==],
  },

  ---------------------------------------------------------------- APÊNDICES
  ["handouts"] = {
    title = "Handouts dos Jogadores",
    summary = "Cartas, registros e documentos que os investigadores podem encontrar, prontos para imprimir ou mostrar na tela.",
  },
}
