# FiendFlayer

A **Dungeons & Dragons 5e** campaign for the Magic Stack, in progress. A devil trapped as the "engine" of a dead child's body, a mind flayer tadpole that cannot finish its ceremorphosis, and the creature that comes out of both: a fiend with mind flayer traits. Written in Portuguese (`data/`), translated into English (`data/en/`).

The book holds only what has been decided so far: the premise, the villain, the two opening arcs (the knight and the child) with their endings, the alliances and the official lore it builds on. What is still open is listed in the chapter I article *O Que Ainda Está em Aberto*.

## What the build checks
- The campaign map (`data/flow.lua`): every stage is reachable from the opening adventure and every path reaches an **open** stage (no ending is written yet); arrows always go down the diagram.
- Every article sits in exactly one chapter, every link points to an article that exists, every box is a known box (`::: gm`, `::: lore`, `::: open`).
- The concept sheet exists and is shown (`@concept`).
- Missing translations, as in the other books.

There are no stat blocks yet, so there is no rules check.

## Files
```
book.lua                 shelf card and which forms each chapter offers
build.lua                validator and site generator
ui.lua                   interface text (tags, boxes, campaign map), PT/EN
data/                    the book in Portuguese; data/en/ the English edition
assets/style.css         ruby-and-purple theme (from the Mist's 16-bit dark fantasy theme)
assets/concept-sheet.jpg the FiendFlayer concept sheet
tools/art.lua            the pixel art: the summoning circle, the fiend and the knight in an open field
tools/banner.lua         the cover banner (build.lua writes banner.svg)
tools/cover.lua          writes cover.html (run: lua tools/cover.lua > cover.html)
```

Dungeons & Dragons and the Forgotten Realms are trademarks of Wizards of the Coast; this is unofficial fan content.
