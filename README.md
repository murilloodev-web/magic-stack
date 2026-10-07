# Magic Stack

*A shelf of tabletop RPG stories you can read, play and add to.*

**Read it online:** https://murilloodev-web.github.io/magic-stack/

Each book is a playable story, written as plain Lua data and built into a static website. Every page of every book has a **Contribute** button: readers send characters, places, scenes, endings or corrections through a form, without needing GitHub, and each contribution waits in a private queue for the author's review.

## On the shelf

| Book | System | Status |
|---|---|---|
| [The Mist over the Funicular](books/mist-over-the-funicular/) | Call of Cthulhu 7e | complete |

## How it fits together

```
library.lua                 the shelf: which books, in which order
site.lua                    site settings (Worker address, Turnstile key, terms version)
books/<id>/
  book.lua                  title, system, spine and cover, and which form each page offers
  cover.html                optional hand-made cover for the table
  build.lua                 the book's own validator and site generator
  data/                     the story, as Lua data
  REFERENCE.md              the whole book as one Markdown file (generated)
shelf/
  shelf.html, shelf.css      the shelf-and-table home page (from the Claude Design "Estante e Mesa")
  shelf.paint.js            the room's pixel art, painted on a canvas
  shelf.app.js              drag a book to the table, open it, move the props
contribute/
  templates.lua             the contribution forms (fields, EN/PT text, Lua draft shape)
  strings.lua               form interface text, EN/PT
  form.js, stack.css        the form page and the terms page
  TERMOS.pt.md, TERMS.en.md contribution and consent terms
worker/                     Cloudflare Worker: form → private GitHub issue
build.lua                   builds every book, the shelf, the form, the terms and forms.json
DESIGN-BRIEF.md             the design brief used in Claude Design
```

`lua build.lua` refuses to build if a book is inconsistent (broken links, uncited sources, character sheets that break the rules, scenes with no way out) or if a form template is broken (missing translations, drafts pointing to fields that do not exist, pages offering forms that do not exist).

```
$ lua build.lua
── The Mist over the Funicular
✓ 27 pages, 14 sources, 19 timeline entries
✓ scenario graph: 10/10 scenes reachable, 3 endings, no dead ends
✓ 3 investigator sheets match CoC 7e derived-stat rules
✓ mist contact track: 7 tiers cover 0–10 with no gaps
── Magic Stack
✓ 1 book(s) on the shelf
✓ 11 contribution form templates, all fields and drafts consistent
✓ wrote shelf, contribute form, terms and forms.json to docs/
```

Every push to `main` runs the build and the Worker tests in GitHub Actions and publishes `docs/` to GitHub Pages. It needs Lua 5.4; the Worker tests need Node 22.

## Contributions

```
reader on a page → "Contribute" → form for that page and section
      → Cloudflare Worker (anti-spam, validation against forms.json)
      → issue in the private repo magic-stack-contribuicoes, with a Lua draft
      → author reviews, sets the credit level, pastes into data/, commits
```

- **Context contributions** (a character, a scene, an ending, a correction) go through the form. See [contribute/TERMOS.pt.md](contribute/TERMOS.pt.md) for consent and the three credit levels.
- **New pages or new books** go through a pull request: copy the shape of `books/mist-over-the-funicular/`, add the book to `library.lua`, and run `lua build.lua`.
- To change the questions a page asks, edit `contribute/templates.lua`, or add a `contrib.lua` inside a book to override a template for that book only.

Setting up the Worker: [worker/README.md](worker/README.md).

## Licence

Story content is published under **CC BY-NC-SA 4.0**. Contributions follow the [Contribution Terms](contribute/TERMOS.pt.md).
*Call of Cthulhu* is a trademark of Chaosium Inc.; the books here are unofficial fan works.
