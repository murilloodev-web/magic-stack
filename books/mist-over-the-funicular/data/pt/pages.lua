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
Trate a névoa como um relógio e como uma tentação. A cada cena desperdiçada ela engrossa; cada respiração funda dá uma pista verdadeira, por um preço. Descreva a névoa se fechando em vez de anunciar regras.
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
A ordem está assustada e dividida. Sem os vagões-tanque, a névoa fica mais alta na cabeça deles a cada noite. Alguns querem arrastar a criatura até a nova linha de cremalheira; outros planejam um sacrifício grande o bastante para ganhar tempo. Todos querem ver os auditores da RFFSA longe dali. Eles são liderados pelo [[chief-engineer|engenheiro-chefe]].
]==],
  },
  ["chief-engineer"] = {
    title = "O Engenheiro-Chefe",
    summary = "Grão-Mestre do culto, morador do Castelinho, guardião dos telégrafos.",
    body = [==[
Quem ocupa o cargo de engenheiro-chefe e mora no [[castelinho|Castelinho]] é, por direito ritual, Grão-Mestre da [[company-of-shadows|Companhia das Sombras]]. Todos os nomeados desde o século 19 foram recrutados, de um jeito ou de outro. O cargo passa adiante quando um engenheiro-chefe enfim "se afoga".

O atual engenheiro-chefe usa os telégrafos e os livros de registro da ferrovia para organizar sacrifícios e esconder o enorme consumo de água do mar e de ferro. É cortês, cansado e tem muito medo. Está em [[mist-contact|Contato]] 8, chupa pastilhas de sal o tempo todo e ouve a criatura a cada minuto acordado. Sabe melhor do que ninguém o que acontece quando a água acaba.

## Como interpretá-lo
No começo, ele não quer os investigadores mortos. Quer que eles *entendam*, e depois ajudem. Ofereça a eles um acordo antes de oferecer uma faca. Se um investigador estiver Tocado pela Maré, ele vai falar com ele nos sinais silenciosos do culto, e o investigador vai entender.
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

Se os investigadores desperdiçarem cenas demais, a névoa chega ao estágio de julho antes que eles cheguem à [[grota-funda]]. A criatura não desperta; ela simplesmente *se espalha*. O culto é encontrado afogado num túnel seco. Os investigadores acordam em Santos sem lembrança da última semana, e com um gosto de sal que não passa.

O mesmo final vale para qualquer investigador que chegue a [[mist-contact|Contato]] 10: ele simplesmente não está lá quando os outros acordam.

Este final existe para que o [[the-mist|relógio da névoa]] de fato importe.
]==],
  },

  ---------------------------------------------------------------- REFERÊNCIA
  ["sources"] = {
    title = "Fontes",
    summary = "Todas as referências do mundo real citadas neste grimório.",
  },
  ["about"] = {
    title = "Sobre este Grimório",
    summary = "Quem escreveu, como foi construído e como usar.",
    body = [==[
*A Névoa sobre o Funicular* é um cenário de investigação original para [[sources|Call of Cthulhu 7ª Edição]] {{coc7}}, escrito por **Murillo França M. da Silva**, mestre de jogo há mais de dez anos (D&D, Tormenta e outros).

## Como foi construído
O grimório inteiro é feito de dados simples em **Lua**: páginas, investigadores, fontes, uma linha do tempo e um grafo do cenário. Um pequeno script de build em Lua transforma tudo isso neste site. Na hora do build, o script:
- confere se cada link interno e cada citação apontam para algo que existe;
- recalcula os atributos derivados de cada investigador (PV, PM, Sanidade, Movimento, Bônus de Dano, Corpo) pelas regras de Call of Cthulhu 7e e falha se a ficha discordar;
- percorre o grafo do [[scenario-flow]] e falha se alguma cena for inalcançável ou se algum caminho acabar antes de um final;
- gera os links de volta ("Citada em") mostrados no fim de cada página.

Trate o grimório como prática de conteúdo e de programação ao mesmo tempo: narrativa escrita como dados, depois conferida por código.

## Contexto político
O cenário se passa durante a ditadura militar brasileira {{dictatorship-wiki}}. A censura, uma ferrovia estatal e uma militante no trem dão à mesa uma pressão real sem precisar de um vilão fardado.
]==],
  },
}
