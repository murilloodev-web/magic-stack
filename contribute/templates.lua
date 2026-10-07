-- Contribution form templates shared by every book on the shelf.
--
-- A template is one form. Each field has an id, a type and bilingual text:
--   type     text | textarea | select | number | url
--            heading (not a field: a titled block that groups the fields after it)
--   label    { en = "...", pt = "..." }
--   help     optional { en, pt } shown under the label
--   required true/false (default false)
--   max      max characters (text/url default 140, textarea default 4000)
--   min/max  for number fields
--   options  for select: { { "value", en = "...", pt = "..." }, ... }
--
-- `draft` tells the Worker how to turn an accepted submission into a Lua
-- snippet ready to paste into the book's data/ files:
--   shape = "page"         new entry for data/pages.lua (section = the page the reader came from)
--   shape = "segment"      a new "## heading" block to append to the page the reader came from
--   shape = "investigator" new entry for data/investigators.lua
--   shape = "timeline"     new entry for data/timeline.lua
--   shape = "scene"        new node for data/flow.lua
--   shape = "source"       new entry for data/sources.lua
--   shape = "book"         a starting book.lua and page outline for a brand-new book (book-idea)
-- Every field named in `draft` must exist; build.lua checks it.
--
-- A book can add a template or replace one with the same id in
-- books/<id>/contrib.lua. Every form also gets a final optional
-- "notes for the author" field automatically.

local function L(en, pt) return { en = en, pt = pt } end

local ROLE_OPTIONS = {
  { "ally",       en = "Ally / informant",        pt = "Aliado / informante" },
  { "antagonist", en = "Antagonist",              pt = "Antagonista" },
  { "cultist",    en = "Cultist / faction member", pt = "Cultista / membro de facção" },
  { "bystander",  en = "Bystander / local",       pt = "Morador / figurante" },
  { "victim",     en = "Victim",                  pt = "Vítima" },
  { "other",      en = "Other",                   pt = "Outro" },
}

local FACT_OPTIONS = {
  { "fiction", en = "Invented for the story", pt = "Inventado para a história" },
  { "history", en = "Documented history (cite a source)", pt = "História documentada (cite a fonte)" },
  { "mixed",   en = "Fiction built on a real fact", pt = "Ficção sobre um fato real" },
}

return {

  ---------------------------------------------------------------- generic
  {
    id = "idea",
    title = L("Idea, expansion or correction", "Ideia, expansão ou correção"),
    intro = L("Add to what you just read: a new detail, a plot thread, a clearer explanation or a historical correction.",
              "Acrescente algo ao que você acabou de ler: um detalhe novo, um fio de enredo, uma explicação mais clara ou uma correção histórica."),
    fields = {
      { id = "kind", type = "select", required = true,
        label = L("What kind of contribution is it?", "Que tipo de contribuição é?"),
        options = {
          { "expand",     en = "Expands this part",          pt = "Expande esta parte" },
          { "plot",       en = "New plot thread or twist",   pt = "Novo fio de enredo ou reviravolta" },
          { "clarity",    en = "Makes it clearer to run",    pt = "Deixa mais fácil de mestrar" },
          { "correction", en = "Historical or factual fix",  pt = "Correção histórica ou factual" },
        } },
      { id = "heading", type = "text", required = true, max = 80,
        label = L("Short title for your addition", "Título curto para sua contribuição"),
        help = L("It becomes the heading of the new block.", "Vira o título do novo bloco.") },
      { id = "text", type = "textarea", required = true, max = 6000,
        label = L("Your text", "Seu texto"),
        help = L("Write it the way you would like to read it in the book.", "Escreva como você gostaria de ler no livro.") },
      { id = "fit", type = "textarea", max = 1000,
        label = L("Where and how does it fit?", "Onde e como isso se encaixa?"),
        help = L("Which scene, character or clue does it touch? What changes for the Keeper?",
                 "Que cena, personagem ou pista isso toca? O que muda para quem mestra?") },
      { id = "source", type = "url",
        label = L("Source (for historical claims)", "Fonte (para afirmações históricas)") },
    },
    draft = { shape = "segment", heading = "heading", body = { "text", "fit" } },
  },

  ---------------------------------------------------------------- places
  {
    id = "place",
    title = L("New place, or more about this one", "Novo local, ou mais sobre este"),
    intro = L("Describe a location the investigators can visit: what they find there, what it hides and how it connects to the rest.",
              "Descreva um local que os investigadores podem visitar: o que encontram, o que ele esconde e como se liga ao resto."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Name of the place", "Nome do local") },
      { id = "type", type = "select", required = true, label = L("Type", "Tipo"),
        options = {
          { "building",  en = "Building or house",      pt = "Construção ou casa" },
          { "nature",    en = "Natural site",           pt = "Local natural" },
          { "under",     en = "Tunnel or underground",  pt = "Túnel ou subterrâneo" },
          { "railway",   en = "Railway structure",      pt = "Estrutura ferroviária" },
          { "vehicle",   en = "Vehicle",                pt = "Veículo" },
          { "other",     en = "Other",                  pt = "Outro" },
        } },
      { id = "fact", type = "select", required = true, label = L("Is it real?", "É real?"), options = FACT_OPTIONS },
      { id = "summary", type = "text", required = true, max = 160,
        label = L("One-line hook", "Gancho em uma linha"),
        help = L("Shown under the title, like the other pages.", "Aparece abaixo do título, como nas outras páginas.") },
      { id = "senses", type = "textarea", required = true, max = 3000,
        label = L("What the investigators see, hear and smell", "O que os investigadores veem, ouvem e cheiram") },
      { id = "history", type = "textarea", max = 3000, label = L("Its history", "A história do lugar") },
      { id = "hidden", type = "textarea", required = true, max = 3000,
        label = L("What is hidden here (clues, dangers, rolls)", "O que está escondido aqui (pistas, perigos, testes)") },
      { id = "links", type = "textarea", max = 1000,
        label = L("Connections to existing pages", "Ligações com páginas existentes"),
        help = L("Name the characters, places or endings it touches.", "Cite os personagens, locais ou finais que ele toca.") },
      { id = "source", type = "url", label = L("Source (if real)", "Fonte (se for real)") },
    },
    draft = { shape = "page", title = "name", summary = "summary", kind = "fact",
              body = { "senses", "history", "hidden", "links" } },
  },

  ---------------------------------------------------------------- characters
  {
    id = "npc",
    title = L("New character", "Novo personagem"),
    intro = L("Create a non-player character who lives in this story: what they want, what they know and what they hide.",
              "Crie um personagem do mestre que vive nesta história: o que quer, o que sabe e o que esconde."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Name", "Nome") },
      { id = "role", type = "select", required = true, label = L("Role in the story", "Papel na história"), options = ROLE_OPTIONS },
      { id = "occupation", type = "text", required = true, max = 120,
        label = L("Age and occupation (in the story's period)", "Idade e ocupação (na época da história)") },
      { id = "summary", type = "text", required = true, max = 160, label = L("One-line hook", "Gancho em uma linha") },
      { id = "look", type = "textarea", required = true, max = 2000,
        label = L("Appearance and manner", "Aparência e jeito") },
      { id = "wants", type = "textarea", required = true, max = 2000, label = L("What they want", "O que deseja") },
      { id = "knows", type = "textarea", required = true, max = 2000,
        label = L("What they know (clues they can give)", "O que sabe (pistas que pode dar)") },
      { id = "secret", type = "textarea", max = 2000, label = L("Their secret", "O segredo") },
      { id = "links", type = "textarea", max = 1000,
        label = L("Ties to existing characters, places or factions", "Laços com personagens, locais ou facções existentes") },
      { id = "stats", type = "textarea", max = 1500,
        label = L("Game statistics (optional)", "Estatísticas de jogo (opcional)"),
        help = L("For Call of Cthulhu: characteristics and key skills, e.g. STR 50, CON 60 … / Spot Hidden 60%.",
                 "Para Call of Cthulhu: características e perícias principais, ex.: FOR 50, CON 60 … / Encontrar 60%.") },
    },
    draft = { shape = "page", title = "name", summary = "summary",
              body = { "occupation", "look", "wants", "knows", "secret", "links", "stats" } },
  },

  {
    id = "investigator",
    title = L("New pre-generated investigator", "Novo investigador pronto"),
    intro = L("Propose a ready-to-play investigator with a personal reason to be in this story.",
              "Proponha um investigador pronto para jogar, com um motivo pessoal para estar nesta história."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Name", "Nome") },
      { id = "role", type = "text", required = true, max = 60,
        label = L("Archetype (e.g. The Bureaucrat)", "Arquétipo (ex.: O Burocrata)") },
      { id = "occupation", type = "text", required = true, max = 120, label = L("Occupation", "Ocupação") },
      { id = "quote", type = "text", required = true, max = 240, label = L("A line they would say", "Uma frase dele(a)") },
      { id = "motivation", type = "textarea", required = true, max = 2000,
        label = L("Why they come to this story", "Por que entra nesta história") },
      { id = "hook", type = "textarea", required = true, max = 2000,
        label = L("Personal hook (a tie to the mystery)", "Gancho pessoal (ligação com o mistério)") },
      { id = "characteristics", type = "textarea", max = 400,
        label = L("Characteristics", "Características"),
        help = L("STR, CON, SIZ, DEX, APP, INT, POW, EDU between 15 and 90. The build checks HP and Sanity for you.",
                 "FOR, CON, TAM, DES, APA, INT, POD, EDU entre 15 e 90. O build confere PV e Sanidade.") },
      { id = "skills", type = "textarea", max = 1000, label = L("Key skills with values", "Perícias principais com valores") },
      { id = "gear", type = "textarea", max = 800, label = L("Equipment (period-accurate)", "Equipamento (fiel à época)") },
    },
    draft = { shape = "investigator", name = "name", role = "role", occupation = "occupation",
              quote = "quote", motivation = "motivation", hook = "hook",
              characteristics = "characteristics", skills = "skills", gear = "gear" },
  },

  ---------------------------------------------------------------- mythos
  {
    id = "mythos",
    title = L("Mythos element", "Elemento do Mythos"),
    intro = L("Add something uncanny: a ritual, an artefact, a manifestation, a forbidden text.",
              "Acrescente algo sobrenatural: um ritual, um artefato, uma manifestação, um texto proibido."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Name", "Nome") },
      { id = "type", type = "select", required = true, label = L("Type", "Tipo"),
        options = {
          { "ritual",     en = "Ritual or custom",   pt = "Ritual ou costume" },
          { "artefact",   en = "Artefact",           pt = "Artefato" },
          { "phenomenon", en = "Phenomenon",         pt = "Fenômeno" },
          { "tome",       en = "Tome or document",   pt = "Tomo ou documento" },
          { "creature",   en = "Creature or servant", pt = "Criatura ou servo" },
        } },
      { id = "summary", type = "text", required = true, max = 160, label = L("One-line hook", "Gancho em uma linha") },
      { id = "what", type = "textarea", required = true, max = 3000, label = L("What it is", "O que é") },
      { id = "play", type = "textarea", required = true, max = 3000,
        label = L("How it shows up in play", "Como aparece em jogo") },
      { id = "rules", type = "textarea", max = 1500,
        label = L("Rules effects (Sanity, Mist Contact, rolls)", "Efeitos de regra (Sanidade, Contato com a Névoa, testes)") },
      { id = "clues", type = "textarea", max = 1500,
        label = L("How investigators find out about it", "Como os investigadores descobrem") },
    },
    draft = { shape = "page", title = "name", summary = "summary", body = { "what", "play", "rules", "clues" } },
  },

  {
    id = "rule",
    title = L("Rule or mechanic", "Regra ou mecânica"),
    intro = L("Suggest a rule that makes this story's threat playable at the table.",
              "Sugira uma regra que torne a ameaça desta história jogável na mesa."),
    fields = {
      { id = "heading", type = "text", required = true, max = 80, label = L("Name of the rule", "Nome da regra") },
      { id = "trigger", type = "textarea", required = true, max = 1500, label = L("When it applies", "Quando se aplica") },
      { id = "mechanic", type = "textarea", required = true, max = 2500,
        label = L("How it works (numbers, rolls, effects)", "Como funciona (números, testes, efeitos)") },
      { id = "example", type = "textarea", max = 2000, label = L("Example of play", "Exemplo de jogo") },
    },
    draft = { shape = "segment", heading = "heading", body = { "trigger", "mechanic", "example" } },
  },

  ---------------------------------------------------------------- factions
  {
    id = "faction",
    title = L("Faction, or more about this one", "Facção, ou mais sobre esta"),
    intro = L("Describe a group with its own goals inside the story.", "Descreva um grupo com objetivos próprios dentro da história."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Name", "Nome") },
      { id = "summary", type = "text", required = true, max = 160, label = L("One-line hook", "Gancho em uma linha") },
      { id = "purpose", type = "textarea", required = true, max = 2000, label = L("What they want", "O que querem") },
      { id = "members", type = "textarea", max = 2000, label = L("Notable members", "Membros notáveis") },
      { id = "methods", type = "textarea", required = true, max = 2000,
        label = L("Methods and resources", "Métodos e recursos") },
      { id = "investigators", type = "textarea", max = 1500,
        label = L("What they want from the investigators", "O que querem dos investigadores") },
    },
    draft = { shape = "page", title = "name", summary = "summary",
              body = { "purpose", "members", "methods", "investigators" } },
  },

  ---------------------------------------------------------------- endings
  {
    id = "ending",
    title = L("Ending: a variation or a new one", "Final: uma variação ou um novo"),
    intro = L("Propose how the story can end: what the investigators must do, what it costs and what is left of the place.",
              "Proponha como a história pode terminar: o que os investigadores precisam fazer, quanto custa e o que sobra do lugar."),
    fields = {
      { id = "name", type = "text", required = true, max = 80, label = L("Title of the ending", "Título do final") },
      { id = "relation", type = "select", required = true,
        label = L("How does it relate to the existing endings?", "Como se relaciona com os finais existentes?"),
        options = {
          { "variant", en = "A variation of the ending I am reading", pt = "Uma variação do final que estou lendo" },
          { "new",     en = "A completely new ending",               pt = "Um final completamente novo" },
          { "epilogue", en = "An epilogue that follows it",          pt = "Um epílogo que vem depois" },
        } },
      { id = "summary", type = "text", required = true, max = 160, label = L("One-line hook", "Gancho em uma linha") },
      { id = "trigger", type = "textarea", required = true, max = 2000,
        label = L("What the investigators must do to reach it", "O que os investigadores precisam fazer para chegar aqui") },
      { id = "climax", type = "textarea", required = true, max = 4000,
        label = L("The final scene", "A cena final") },
      { id = "cost", type = "textarea", required = true, max = 1500,
        label = L("The cost (Sanity, Contact, lives)", "O custo (Sanidade, Contato, vidas)") },
      { id = "aftermath", type = "textarea", required = true, max = 2500,
        label = L("What happens to the place and the people afterwards", "O que acontece com o lugar e as pessoas depois") },
    },
    draft = { shape = "page", title = "name", summary = "summary", body = { "trigger", "climax", "cost", "aftermath" } },
  },

  ---------------------------------------------------------------- structure
  {
    id = "scene",
    title = L("New scene in the scenario flow", "Nova cena no fluxo do cenário"),
    intro = L("Add a scene to the investigation graph. Say where it comes from and where it leads, so no path dead-ends.",
              "Acrescente uma cena ao grafo da investigação. Diga de onde ela vem e para onde leva, para nenhum caminho ficar sem saída."),
    fields = {
      { id = "title", type = "text", required = true, max = 80, label = L("Scene title", "Título da cena") },
      { id = "where", type = "text", required = true, max = 120, label = L("Where it happens", "Onde acontece") },
      { id = "what", type = "textarea", required = true, max = 3000, label = L("What happens", "O que acontece") },
      { id = "from", type = "textarea", required = true, max = 800,
        label = L("Which scene(s) lead here, and on what condition", "Que cena(s) levam até aqui, e sob qual condição") },
      { id = "exits", type = "textarea", required = true, max = 800,
        label = L("Where it leads (scenes or endings), and on what condition", "Para onde leva (cenas ou finais), e sob qual condição") },
      { id = "clues", type = "textarea", max = 1500, label = L("Clues found here", "Pistas encontradas aqui") },
    },
    draft = { shape = "scene", title = "title", text = "what", from = "from", exits = "exits", body = { "where", "clues" } },
  },

  {
    id = "timeline-event",
    title = L("Timeline event", "Evento na linha do tempo"),
    intro = L("Add a dated event. Real history needs a source; invented events must not pretend to be real.",
              "Acrescente um evento datado. História real precisa de fonte; eventos inventados não podem fingir que são reais."),
    fields = {
      { id = "year", type = "text", required = true, max = 20, label = L("Year or date", "Ano ou data") },
      { id = "kind", type = "select", required = true, label = L("Is it real?", "É real?"),
        options = { FACT_OPTIONS[1], FACT_OPTIONS[2] } },
      { id = "text", type = "textarea", required = true, max = 1200, label = L("What happened", "O que aconteceu") },
      { id = "source", type = "url", label = L("Source (required if real)", "Fonte (obrigatória se for real)") },
    },
    draft = { shape = "timeline", year = "year", kind = "kind", text = "text", source = "source" },
  },

  {
    id = "source",
    title = L("Suggest a historical source", "Sugerir uma fonte histórica"),
    intro = L("Point to a reliable reference that supports or corrects the history in this book.",
              "Indique uma referência confiável que sustente ou corrija a história deste livro."),
    fields = {
      { id = "title", type = "text", required = true, max = 160, label = L("Title", "Título") },
      { id = "publisher", type = "text", required = true, max = 120, label = L("Publisher or author", "Editora ou autor") },
      { id = "url", type = "url", required = true, label = L("Link", "Link") },
      { id = "note", type = "textarea", required = true, max = 1000,
        label = L("What it supports or corrects", "O que ela sustenta ou corrige") },
    },
    draft = { shape = "source", title = "title", publisher = "publisher", url = "url", note = "note" },
  },

  ---------------------------------------------------------------- new books
  -- Opened from "Sua história aqui" (propor-livro.html), not from a page:
  -- a whole book idea for the shelf's author to develop.
  {
    id = "book-idea",
    title = L("Idea for a new book", "Ideia para um livro novo"),
    intro = L("Tell us the story you would like to see on the shelf. Fill in what you have; the author develops the book from it, and you are credited according to the terms.",
              "Conte a história que você gostaria de ver na estante. Preencha o que tiver; o autor desenvolve o livro a partir disso, e você recebe crédito conforme o termo."),
    fields = {
      { type = "heading", label = L("The idea", "A ideia") },
      { id = "title", type = "text", required = true, max = 100, label = L("Working title", "Título provisório") },
      { id = "system", type = "select", required = true, label = L("System", "Sistema"),
        options = {
          { "coc7",     en = "Call of Cthulhu 7e",   pt = "Call of Cthulhu 7e" },
          { "t20",      en = "Tormenta20",           pt = "Tormenta20" },
          { "dnd5",     en = "D&D 5e",               pt = "D&D 5e" },
          { "od2",      en = "Old Dragon 2e",        pt = "Old Dragon 2e" },
          { "op",       en = "Ordem Paranormal",     pt = "Ordem Paranormal" },
          { "sw",       en = "Savage Worlds",        pt = "Savage Worlds" },
          { "gurps",    en = "GURPS",                pt = "GURPS" },
          { "agnostic", en = "System-neutral",       pt = "Sem sistema definido" },
          { "other",    en = "Other (say which below)", pt = "Outro (diga qual abaixo)" },
        } },
      { id = "system_other", type = "text", max = 80, label = L("Which other system?", "Qual outro sistema?") },
      { id = "genre", type = "select", required = true, label = L("Genre", "Gênero"),
        options = {
          { "horror",      en = "Horror",                   pt = "Horror" },
          { "mystery",     en = "Mystery / investigation",  pt = "Mistério / investigação" },
          { "fantasy",     en = "Fantasy",                  pt = "Fantasia" },
          { "dark-fantasy", en = "Dark fantasy",            pt = "Fantasia sombria" },
          { "scifi",       en = "Science fiction",          pt = "Ficção científica" },
          { "historical",  en = "Historical",               pt = "Histórico" },
          { "adventure",   en = "Adventure",                pt = "Aventura" },
          { "other",       en = "Other",                    pt = "Outro" },
        } },
      { id = "pitch", type = "text", required = true, max = 200,
        label = L("The story in one line", "A história em uma linha"),
        help = L("The hook a player would hear first.", "O gancho que um jogador ouviria primeiro.") },
      { id = "premise", type = "textarea", required = true, max = 4000,
        label = L("Premise", "Premissa"),
        help = L("What is going on, who is involved, and why the players get pulled in.", "O que está acontecendo, quem está envolvido e por que os jogadores são puxados para dentro.") },

      { type = "heading", label = L("Setting", "Cenário") },
      { id = "place", type = "text", required = true, max = 120, label = L("Where it happens", "Onde acontece") },
      { id = "period", type = "text", required = true, max = 80, label = L("When it happens", "Quando acontece") },
      { id = "fact", type = "select", required = true, label = L("Is the setting real?", "O cenário é real?"), options = FACT_OPTIONS },
      { id = "tone", type = "textarea", max = 1500, label = L("Tone and atmosphere", "Tom e atmosfera"),
        help = L("What it should feel like at the table: sounds, smells, weather, mood.", "Como deve parecer na mesa: sons, cheiros, clima, sensação.") },
      { id = "references", type = "textarea", max = 1500, label = L("References and sources", "Referências e fontes"),
        help = L("Real history, books, films or games that inspired it. Links are welcome.", "História real, livros, filmes ou jogos que inspiraram. Links são bem-vindos.") },

      { type = "heading", label = L("The mystery", "O mistério") },
      { id = "threat", type = "textarea", required = true, max = 3000, label = L("The threat or antagonist", "A ameaça ou o antagonista") },
      { id = "truth", type = "textarea", required = true, max = 3000,
        label = L("The hidden truth", "A verdade escondida"),
        help = L("What is really going on, which the players discover by the end.", "O que de fato está acontecendo, e que os jogadores descobrem até o fim.") },
      { id = "hooks", type = "textarea", max = 2000, label = L("Why the characters get involved", "Por que os personagens se envolvem") },

      { type = "heading", label = L("Elements", "Elementos") },
      { id = "places", type = "textarea", max = 3000, label = L("Places", "Locais"),
        help = L("One per line: name — what it is and what is hidden there.", "Um por linha: nome — o que é e o que se esconde lá.") },
      { id = "characters", type = "textarea", max = 3000, label = L("Characters", "Personagens"),
        help = L("One per line: name — who they are and what they want.", "Um por linha: nome — quem é e o que quer.") },
      { id = "factions", type = "textarea", max = 2000, label = L("Factions and groups", "Facções e grupos"),
        help = L("One per line: name — what they want.", "Um por linha: nome — o que querem.") },
      { id = "supernatural", type = "textarea", max = 2000, label = L("Supernatural, magic or technology", "Sobrenatural, magia ou tecnologia"),
        help = L("Creatures, artefacts, rituals, rules of the world.", "Criaturas, artefatos, rituais, regras do mundo.") },
      { id = "clues", type = "textarea", max = 2000, label = L("Clues and handouts", "Pistas e documentos para os jogadores") },

      { type = "heading", label = L("Structure", "Estrutura") },
      { id = "opening", type = "textarea", max = 2000, label = L("Opening scene", "Cena de abertura") },
      { id = "scenes", type = "textarea", max = 3000, label = L("Key scenes", "Cenas-chave"),
        help = L("One per line, in a rough order.", "Uma por linha, numa ordem aproximada.") },
      { id = "endings", type = "textarea", required = true, max = 3000, label = L("Possible endings", "Finais possíveis") },
      { id = "pcs", type = "textarea", max = 2000, label = L("Ideas for player characters", "Ideias de personagens para os jogadores") },
      { id = "length", type = "select", label = L("Length", "Duração"),
        options = {
          { "one-shot", en = "One-shot (one session)", pt = "One-shot (uma sessão)" },
          { "short",    en = "2–3 sessions",           pt = "2–3 sessões" },
          { "mini",     en = "Short campaign",         pt = "Campanha curta" },
          { "long",     en = "Long campaign",          pt = "Campanha longa" },
        } },
      { id = "players", type = "text", max = 40, label = L("Group size", "Tamanho do grupo") },
      { id = "warnings", type = "textarea", max = 1000, label = L("Sensitive themes", "Temas sensíveis"),
        help = L("Content the table should agree on before playing.", "Conteúdos que a mesa deve combinar antes de jogar.") },

      { type = "heading", label = L("Working together", "Parceria") },
      { id = "role", type = "select", required = true, label = L("How would you like to take part?", "Como você quer participar?"),
        options = {
          { "idea",    en = "Just the idea: the author develops it",      pt = "Só a ideia: o autor desenvolve" },
          { "cowrite", en = "I would like to co-write it",                pt = "Quero escrever junto" },
          { "material", en = "I have material ready to send",             pt = "Tenho material pronto para enviar" },
        } },
      { id = "material", type = "url", label = L("Link to your material (optional)", "Link para o seu material (opcional)") },
      { id = "why", type = "textarea", max = 1500, label = L("Why this story?", "Por que esta história?") },
    },
    draft = { shape = "book", title = "title", system = "system", genre = "genre", pitch = "pitch", premise = "premise",
              place = "place", period = "period", fact = "fact",
              places = "places", characters = "characters", factions = "factions", endings = "endings" },
  },
}
