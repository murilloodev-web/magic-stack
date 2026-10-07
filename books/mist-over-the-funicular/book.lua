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
  -- spine colours for the provisional shelf (Claude Design will replace the shelf)
  spine    = { base = "#2e2550", accent = "#9b6bd6", label = "#dfe7d9" },
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
