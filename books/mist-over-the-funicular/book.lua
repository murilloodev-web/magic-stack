-- Book card for the Magic Stack shelf, plus which contribution forms each
-- part of the book offers. Form templates live in contribute/templates.lua;
-- a book can add or replace templates in its own contrib.lua.

return {
  id       = "mist-over-the-funicular",
  title    = "The Mist over the Funicular",
  subtitle = "Paranapiacaba, Brazil · May–July 1974",
  system   = "Call of Cthulhu 7e",
  genre    = "Investigative horror",
  author   = "Murillo França M. da Silva",
  lang     = "en",           -- the language the story was written in (data/); others live in data/<lang>/
  status   = "complete",     -- complete | in-progress | draft
  blurb    = "In 1974 the government begins closing a century-old mountain railway to save money. Nobody told it what the railway was really carrying.",
  -- shelf card and the open-book spread
  period   = "May–July 1974",
  place    = "Paranapiacaba, Brazil",
  kicker   = "A Call of Cthulhu 7th Edition scenario · Paranapiacaba, Brazil · May–July 1974",
  cover_title = "The Mist over<br>the Funicular",
  banner_alt = "Pixel-art dusk over the Serra do Mar: a tank wagon climbs the funicular toward the Castelinho while fog rises from the valley.",
  -- the book in other languages: these fields replace the ones above, and the
  -- story itself is translated in data/<lang>/ (the build checks nothing is missing)
  i18n = {
    pt = {
      title    = "A Névoa sobre o Funicular",
      subtitle = "Paranapiacaba, Brasil · Maio–julho de 1974",
      genre    = "Horror investigativo",
      blurb    = "Em 1974, o governo começa a fechar uma ferrovia centenária na serra para economizar dinheiro. Ninguém contou a ele o que essa ferrovia de fato carregava.",
      period   = "Maio–julho de 1974",
      place    = "Paranapiacaba, SP",
      kicker   = "Um cenário de Call of Cthulhu 7ª Edição · Paranapiacaba, Brasil · Maio–julho de 1974",
      cover_title = "A Névoa sobre<br>o Funicular",
      banner_alt = "Entardecer em pixel art sobre a Serra do Mar: um vagão-tanque sobe o funicular rumo ao Castelinho enquanto o nevoeiro sobe do vale.",
    },
  },
  labels   = true,           -- the book tags every page History / Fiction / History + Fiction
  -- spine on the shelf (pixels at 1×) and the cover on the table
  spine    = { color = "#2e2550", light = "#3b3860", band = "#8e8aae", ink = "#dfe7d9",
               w = 44, h = 184, emblem = true },
  cover    = "cover.html",   -- hand-made cover art; books without one get a generic cover
  contrib_page = "synopsis", -- where "Contribuir" on the table card leads
  open_contributions = true,

  -- Which forms the "Contribute" buttons open. An article gets the templates
  -- of its chapter (data/chapters.lua) unless `pages` overrides it; `false`
  -- means no contributions. With more than one template the reader picks one.
  contrib = {
    chapters = {
      intro         = { "idea" },
      setting       = { "place", "npc" },
      mythos        = { "mythos", "npc" },
      investigators = { "investigator" },
      investigation = { "scene", "npc", "handout" },
      npcs          = { "npc", "faction" },
      endings       = { "ending" },
      appendix      = { "source" },
    },
    pages = {
      ["timeline"]           = { "timeline-event" },
      ["scenario-flow"]      = { "scene" },
      ["running"]            = { "rule", "idea" },
      ["mist-contact"]       = { "rule" },
      ["the-fugitive"]       = { "npc", "mythos" },
      ["company-of-shadows"] = { "faction", "npc" },
      ["handouts"]           = { "handout" },
      ["about"]              = false,
    },
  },
}
