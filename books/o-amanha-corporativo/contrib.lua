-- Contribution forms that only this book offers (they add to the shared
-- ones in contribute/templates.lua). See book.lua for which part of the
-- book opens which form.

local function L(en, pt) return { en = en, pt = pt } end

return {
  {
    id = "estemp",
    title = L("A corporate state (ESTEMP)", "Um Estado Empresarial (ESTEMP)"),
    intro = L("Propose a corporation big enough to be a country, or more about one on the board. Every ESTEMP has a sin; none of them is the main villain.",
              "Proponha uma corporação grande o bastante para ser um país, ou mais sobre uma do tabuleiro. Todo ESTEMP tem um pecado; nenhum é o vilão principal."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Name", "Nome") },
      { id = "summary", type = "text", required = true, max = 160, label = L("One line: territory and business", "Uma linha: território e negócio") },
      { id = "territory", type = "textarea", required = true, max = 1500, label = L("Territory and headquarters", "Território e sede") },
      { id = "business", type = "textarea", required = true, max = 2000, label = L("What it sells and how people live there", "O que vende e como se vive lá") },
      { id = "sin", type = "textarea", required = true, max = 2000, label = L("Its sin", "O pecado") },
      { id = "slogan", type = "text", max = 160, label = L("Slogan (optional)", "Slogan (opcional)") },
    },
    draft = { shape = "page", title = "name", summary = "summary", body = { "territory", "business", "sin", "slogan" } },
  },
  {
    id = "regest",
    title = L("A REGEST", "Um REGEST"),
    intro = L("What is left of a country? The rule: the REGEST keeps the part no corporation wanted to buy.",
              "O que sobrou de um país? A regra: o REGEST fica com a parte que nenhuma corporação quis comprar."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Country and the place that is left", "País e o lugar que sobrou") },
      { id = "summary", type = "text", required = true, max = 160, label = L("One-line hook", "Gancho em uma linha") },
      { id = "why", type = "textarea", required = true, max = 2000, label = L("Why nobody bought it", "Por que ninguém comprou") },
      { id = "life", type = "textarea", required = true, max = 2500, label = L("How people live there", "Como se vive lá") },
      { id = "hooks", type = "textarea", max = 2000, label = L("Adventure hooks", "Ganchos de aventura") },
      { id = "source", type = "url", label = L("Source, if it builds on a real fact", "Fonte, se partir de um fato real") },
    },
    draft = { shape = "page", title = "name", summary = "summary", body = { "why", "life", "hooks", "source" } },
  },
  {
    id = "runner",
    title = L("Pre-generated character (Cyberpunk RED)", "Personagem pronto (Cyberpunk RED)"),
    intro = L("A ready-to-play character for this world, with something the company can take back from them.",
              "Um personagem pronto para este mundo, com algo que a empresa pode tomar de volta."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Name and handle", "Nome e apelido") },
      { id = "role", type = "select", required = true, label = L("Role", "Papel"), options = {
          { "solo", en = "Solo", pt = "Solo" }, { "tech", en = "Tech", pt = "Tech" }, { "medtech", en = "Medtech", pt = "Medtech" },
          { "nomad", en = "Nomad", pt = "Nômade" }, { "media", en = "Media", pt = "Mídia" }, { "exec", en = "Exec", pt = "Executivo" },
          { "fixer", en = "Fixer", pt = "Fixer" }, { "security", en = "Corporate Security", pt = "Segurança Patrimonial" },
          { "agitator", en = "Agitator", pt = "Agitador" }, { "operator", en = "Systems Operator", pt = "Operador de Sistemas" } } },
      { id = "summary", type = "text", required = true, max = 160, label = L("Occupation, in one line", "Ocupação, em uma linha") },
      { id = "origin", type = "textarea", required = true, max = 2000, label = L("Where they come from", "De onde vem") },
      { id = "stake", type = "textarea", required = true, max = 1500,
        label = L("What the company can take back (an arm, a name, a family…)", "O que a empresa pode tomar de volta (um braço, um nome, uma família…)") },
      { id = "stats", type = "textarea", max = 600, label = L("Stats", "Atributos"),
        help = L("INT, REF, DEX, TECH, COOL, WILL, LUCK, MOVE, BODY, EMP, 2 to 8, adding up to 62. The build checks the rest.",
                 "INT, REF, DES, TEC, FRI, VON, SOR, MOV, COR, EMP, de 2 a 8, somando 62. O build confere o resto.") },
      { id = "skills", type = "textarea", max = 1200, label = L("Key skills and levels", "Perícias principais e níveis") },
      { id = "implants", type = "textarea", max = 800, label = L("Implants from the grounded catalogue, and who owns them", "Implantes do catálogo pé no chão, e de quem são") },
    },
    draft = { shape = "page", title = "name", summary = "summary", body = { "origin", "stake", "stats", "skills", "implants" } },
  },
  {
    id = "implant",
    title = L("A grounded implant", "Um implante pé no chão"),
    intro = L("Industrial, bureaucratic, owned by someone. No retractable blades.",
              "Industrial, burocrático, com dono. Nada de lâminas retráteis."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Name", "Nome") },
      { id = "summary", type = "text", required = true, max = 160, label = L("What it is for, in one line", "Para que serve, em uma linha") },
      { id = "effect", type = "textarea", required = true, max = 1500, label = L("Rules effect", "Efeito em regra") },
      { id = "humanity", type = "number", required = true, min = 0, max = 14, label = L("Fixed Humanity Loss", "Perda de Humanidade fixa") },
      { id = "owner", type = "textarea", required = true, max = 1000, label = L("Who usually owns it, and does it need Tolerin?", "Quem costuma ser o dono, e exige Tolerina?") },
    },
    draft = { shape = "page", title = "name", summary = "summary", body = { "effect", "humanity", "owner" } },
  },
}
