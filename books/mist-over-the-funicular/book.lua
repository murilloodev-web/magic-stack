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
  lang     = "en",
  status   = "complete",     -- complete | in-progress | draft
  blurb    = "In 1974 the government begins closing a century-old mountain railway to save money. Nobody told it what the railway was really carrying.",
  -- shelf card and the open-book spread
  period   = "Maio–julho de 1974",
  place    = "Paranapiacaba, SP",
  kicker   = "A Call of Cthulhu 7th Edition scenario · Paranapiacaba, Brazil · May–July 1974",
  labels   = true,           -- the book tags every page History / Fiction / History + Fiction
  -- spine on the shelf (pixels at 1×) and the cover on the table
  spine    = { color = "#2e2550", light = "#3b3860", band = "#8e8aae", ink = "#dfe7d9",
               w = 44, h = 184, emblem = true },
  cover    = "cover.html",   -- hand-made cover art; books without one get a generic cover
  contrib_page = "synopsis", -- where "Contribuir" on the table card leads
  open_contributions = true,

  -- Which forms the "Contribute" buttons open. A page gets the templates of
  -- its section unless `pages` overrides it; `false` means no contributions.
  -- When a page offers more than one template the reader picks one.
  contrib = {
    sections = {
      ["The Scenario"]  = { "idea" },
      ["Places"]        = { "place", "npc" },
      ["The Mythos"]    = { "mythos", "npc" },
      ["Factions"]      = { "faction", "npc" },
      ["Investigators"] = { "investigator" },
      ["Endings"]       = { "ending" },
      ["Reference"]     = { "source" },
    },
    pages = {
      ["timeline"]      = { "timeline-event" },
      ["scenario-flow"] = { "scene" },
      ["mist-contact"]  = { "rule" },
      ["the-fugitive"]  = { "npc", "mythos" },
      ["about"]         = false,
    },
  },
}
