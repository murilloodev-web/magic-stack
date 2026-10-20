-- The book's chapters, in reading order. Each chapter is one page of the
-- site (<id>.html) and gathers the articles listed in `pages`, in order.
-- build.lua checks that every article sits in exactly one chapter.
-- `n` is the printed number ("I", "II"… or "A" for the appendices).

return {
  {
    id = "intro", n = "I",
    title = "Introdução para o Mestre",
    intro = [==[
A premissa, a estrutura da campanha e o que ainda está em aberto. Este livro está em construção: ele reúne as decisões já tomadas, e nada além delas.
]==],
    pages = { "premise", "structure", "opening-adventure", "open-threads" },
  },
  {
    id = "threat", n = "II",
    title = "A Ameaça Final",
    intro = [==[
O que está em jogo no fim da campanha: os illithids tentando tomar os planos infernais, e a party obrigada a defender o inferno.
]==],
    pages = { "final-threat", "tiamat" },
  },
  {
    id = "species", n = "III",
    title = "O FiendFlayer",
    intro = [==[
Uma criatura nova, nascida de um acidente: um infernal com características de mind flayer.
]==],
    pages = { "species", "nature", "appearance" },
  },
  {
    id = "morvane", n = "IV",
    title = "A Casa Morvane",
    epigraph = "O guerreiro que desafia a morte, pois a encontrou diversas vezes, mas sempre acha o caminho de volta.",
    intro = [==[
O vilão escondido da história: como um diabo foi parar dentro do corpo de uma criança morta, e o que um girino fez com ele ao longo dos anos.
]==],
    pages = { "house-morvane", "the-contract", "cael-life", "the-parasite", "the-release" },
  },
  {
    id = "knight", n = "V",
    title = "Rota do Cavaleiro",
    intro = [==[
O primeiro dos dois arcos de abertura. Sir Cael já é adulto, já é lord, e enfrenta hordas de Avernus há anos.
]==],
    pages = { "knight-route", "party-entry", "the-infection", "ending-sacrifice", "ending-defeat", "halvard-book", "knight-avernus" },
  },
  {
    id = "child", n = "VI",
    title = "Rota da Criança",
    intro = [==[
O segundo arco de abertura. Aqui o diabo ainda está preso num herdeiro que nunca cresceu, e são os jogadores que o libertam.
]==],
    pages = { "child-route", "child-avernus" },
  },
  {
    id = "alliances", n = "VII",
    title = "Contratos e Alianças",
    intro = [==[
Valem para as duas rotas. O objetivo de todos eles é parar o FiendFlayer.
]==],
    pages = { "infernal-lords", "githyanki" },
  },
  {
    id = "appendix", n = "A",
    title = "Apêndices",
    pages = { "official-lore", "corrections", "about" },
  },
}
