-- The book's chapters, in reading order. Each chapter is one page of the
-- site (<id>.html) and gathers the articles listed in `pages`, in order.
-- build.lua checks that every article, character and handout sits in
-- exactly one chapter. `n` is the printed number ("I", "II"… or "A").

return {
  {
    id = "intro", n = "I",
    title = "Introdução",
    epigraph = "O mundo não acabou num apocalipse nuclear repentino. Ele foi comprado à prestação.",
    intro = [==[
Este capítulo apresenta o cenário, o tom e a forma de usar o livro. Ele é para todo mundo na mesa, e não só para quem mestra.
]==],
    pages = { "about-book", "tone", "how-to-use", "fact-and-fiction" },
  },
  {
    id = "history", n = "II",
    title = "Cem Anos de Prestações",
    epigraph = "Ninguém declarou o fim das democracias. Elas foram ficando sem caixa.",
    intro = [==[
De 2026 a 2126, em ordem: como as corporações passaram a ter mais dinheiro que os países, como uma briga por espionagem virou a primeira guerra entre empresas, e como um massacre ganhou o nome de demissão.
]==],
    pages = { "timeline", "first-asteroid", "first-corporate-war", "corruption-gold-rush", "great-dismissal" },
  },
  {
    id = "board", n = "III",
    title = "O Tabuleiro",
    epigraph = "Cada cor do mapa tem um dono, e o mar também.",
    intro = [==[
O mapa do mundo em 2126 e os Estados Empresariais que o dividem: as cinco grandes e as menores que fecham os espaços. Cada ESTEMP tem o seu próprio pecado. Nenhuma delas é a vilã principal, porque todas são vilãs.
]==],
    pages = { "board", "omniterra", "kuro-tech", "aegis-med", "petro-vanguard", "thalassa",
              "severa", "monsoon", "great-rift", "sahel-solar" },
  },
  {
    id = "regests", n = "IV",
    title = "Os REGESTs",
    epigraph = "O REGEST fica com o que nenhuma corporação quis comprar.",
    intro = [==[
Os restos dos governos tradicionais: vinte países que ainda existem no papel, cada um encolhido até a parte de si que não dava lucro. Há liberdade ali, e quase mais nada.
]==],
    pages = { "regests", "brasilia", "regest-life" },
  },
  {
    id = "collaborator", n = "V",
    title = "A Vida do Colaborador",
    epigraph = "Adeus, patriotas. Olá, colaboradores.",
    intro = [==[
Como se vive dentro de um ESTEMP: por metas, sob propaganda, sujeito à realocação, com medo da demissão e da quarentena que vem depois dela.
]==],
    pages = { "collaborator", "relocation", "quarantine", "pyramid", "colony-dream" },
  },
  {
    id = "spoon", n = "VI",
    title = "A Cultura Sem Colher",
    epigraph = "“Quem usa colher está aceitando a sopa fria do fracasso estatal.” — campanha publicitária, 2114",
    intro = [==[
Como um apelido de jornal virou um tabu social, e por que a elite dos ESTEMPs toma sopa de canudinho.
]==],
    pages = { "spoon-origin", "spoonless-etiquette", "moral-panic", "capi-fascists" },
  },
  {
    id = "resistance", n = "VII",
    title = "A AntiFaCa",
    epigraph = "— Vai uma sopa? — Se tiver colher.",
    intro = [==[
A resistência não vai derrubar o sistema, e sabe disso. Ela ataca os flancos, expõe podridões e arranca recursos das garras das corporações. Este capítulo explica como ela se organiza e dá os ganchos para começar uma campanha.
]==],
    pages = { "antifaca", "nomads", "infiltration", "grey-morality", "hooks" },
  },
  {
    id = "rules", n = "VIII",
    title = "Cyberpunk RED Pé no Chão",
    epigraph = "O implante é seu. A posse é da empresa.",
    intro = [==[
Este livro usa as regras de Cyberpunk RED, com ajustes para um mundo sem rede imersiva e sem cromo mirabolante. Você precisa do livro básico de Cyberpunk RED para jogar: aqui está só o que muda.
]==],
    pages = { "grounded-rules", "roles", "implants", "ownership" },
  },
  {
    id = "characters", n = "IX",
    title = "Os Personagens",
    epigraph = "Quarenta e uma pessoas trabalham na Estação Descoberto-7. Todas pedem sopa.",
    intro = [==[
Quatro personagens prontos para a aventura de abertura, todos membros da célula da AntiFaCa que tomou a estação. As fichas seguem o Pacote Completo de Cyberpunk RED, e o build confere cada número.
]==],
    pages = { "characters-intro", "marta", "davi", "rui", "lia" },
  },
  {
    id = "adventure", n = "X",
    title = "Aventura: Auditoria no Descoberto",
    epigraph = "Auditoria de Rotina de Ativos Hídricos. Chegada prevista: 08h00. Favor providenciar café.",
    intro = [==[
O começo de uma campanha, sem final escrito. Uma auditora da OmniTerra chega a uma estação de tratamento de água em que todos os funcionários são da resistência, e que manda escondido para Brasília a água que a cidade não tem. As cenas seguem uma ordem frouxa; as duas últimas ficam em aberto, porque é ali que a história de vocês começa.
]==],
    pages = { "adventure-overview", "scenario-flow", "scene-night-shift", "scene-cleanup", "scene-auditor",
              "scene-meter", "scene-dinner", "scene-news", "scene-valve", "adventure-npcs", "what-next" },
  },
  {
    id = "appendix", n = "A",
    title = "Apêndices",
    pages = { "handouts", "sources", "about" },
  },
}
