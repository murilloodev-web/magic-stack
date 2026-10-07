-- Magic Stack — root build.
--
--   lua build.lua           validate every book + forms, then build docs/
--   lua build.lua --check   validate only
--
-- What it does:
--   1. runs each book's own build.lua (which validates that book) into docs/<book>/
--   2. loads the contribution templates and checks them against every book
--   3. writes the shelf (docs/index.html), the form (docs/contribute.html),
--      the terms (docs/terms.html) and docs/forms.json, which both the form
--      and the Cloudflare Worker read, so the rules live in one place.

local CHECK_ONLY = arg[1] == "--check"
local LUA = arg[-1] or "lua"
local OUT = "docs"
local BUILD = "build"   -- scratch folder for book manifests (git-ignored)

local json      = dofile("lib/json.lua")
local site      = dofile("site.lua")
local library   = dofile("library.lua")
local strings   = dofile("contribute/strings.lua")
local base_tpls = dofile("contribute/templates.lua")

local errors = {}
local function fail(fmt, ...) errors[#errors + 1] = string.format(fmt, ...) end
local function file_exists(p) local f = io.open(p) if f then f:close() return true end end
local function read(p) local f = assert(io.open(p)); local s = f:read("a"); f:close(); return s end
local function sh_quote(s) return "'" .. s:gsub("'", "'\\''") .. "'" end

---------------------------------------------------------------------------
-- 1. Books
---------------------------------------------------------------------------
if not CHECK_ONLY then os.execute("rm -rf " .. OUT) end   -- start clean, so removed pages do not linger
os.execute("mkdir -p " .. BUILD .. (CHECK_ONLY and "" or (" " .. OUT)))

local LANGS = site.langs
local books, manifests = {}, {}
for _, id in ipairs(library) do
  local dir = "books/" .. id
  if not file_exists(dir .. "/book.lua") then fail("library: book '%s' has no %s/book.lua", id, dir)
  else
    local book = dofile(dir .. "/book.lua")
    if book.id ~= id then fail("%s/book.lua: id is '%s', expected '%s'", dir, tostring(book.id), id) end
    books[#books + 1] = book
    manifests[id] = {}
    -- every book is built once per site language: docs/<book>/<lang>/
    for _, lang in ipairs(LANGS) do
      print("── " .. book.title .. " [" .. lang .. "]")
      local mf = BUILD .. "/" .. id .. "." .. lang .. ".manifest.lua"
      local cmd = string.format("cd %s && %s build.lua %s--lang %s --langs %s --out %s --manifest %s --lib %s --shelf %s --contribute %s",
        sh_quote(dir), sh_quote(LUA), CHECK_ONLY and "--check " or "", lang, table.concat(LANGS, ","),
        sh_quote("../../" .. OUT .. "/" .. id .. "/" .. lang), sh_quote("../../" .. mf),
        sh_quote("../../lib"), sh_quote("../../index.html"), sh_quote("../../contribute.html"))
      local ok = os.execute(cmd)
      if not ok then fail("book '%s' failed its own build in '%s' (see above)", id, lang)
      else manifests[id][lang] = dofile(mf) end
    end
  end
end

---------------------------------------------------------------------------
-- 2. Contribution templates
---------------------------------------------------------------------------
local FIELD_TYPES = { text = true, textarea = true, select = true, number = true, url = true }
local DEFAULT_MAX = { text = 140, url = 500, textarea = 4000 }
local SHAPES = { page = true, segment = true, investigator = true, timeline = true, scene = true, source = true, book = true }
local IDEA_TEMPLATE = "book-idea"   -- the "new book idea" form opened from propor-livro.html

local function check_text(t, where)
  if type(t) ~= "table" then fail("%s: missing text", where); return end
  for _, l in ipairs(LANGS) do
    if type(t[l]) ~= "string" or t[l] == "" then fail("%s: missing '%s' text", where, l) end
  end
end

for k, v in pairs(strings) do check_text(v, "strings." .. k) end

local function prepare_templates(list, where)
  local out, seen = {}, {}
  for _, t in ipairs(list) do
    local w = where .. " template '" .. tostring(t.id) .. "'"
    if seen[t.id] then fail("%s: duplicate id", w) end
    seen[t.id] = true
    check_text(t.title, w .. " title"); check_text(t.intro, w .. " intro")
    local fids = {}
    local nh = 0
    for _, f in ipairs(t.fields or {}) do
      if f.type == "heading" then nh = nh + 1; f.id = "_h" .. nh end
      local fw = w .. " field '" .. tostring(f.id) .. "'"
      if f.type ~= "heading" and (not f.id or not f.id:match("^[%a][%w_]*$")) then fail("%s: bad field id", fw) end
      if fids[f.id] then fail("%s: duplicate field id", fw) end
      fids[f.id] = true
      if not FIELD_TYPES[f.type] and f.type ~= "heading" then fail("%s: unknown type '%s'", fw, tostring(f.type)) end
      check_text(f.label, fw .. " label")
      if f.help then check_text(f.help, fw .. " help") end
      if f.type == "select" then
        if not f.options or #f.options < 2 then fail("%s: a select needs at least 2 options", fw) end
        for _, o in ipairs(f.options or {}) do
          if type(o[1]) ~= "string" then fail("%s: option without a value", fw) end
          check_text({ en = o.en, pt = o.pt }, fw .. " option '" .. tostring(o[1]) .. "'")
        end
      end
      if f.type ~= "number" and f.type ~= "select" and f.type ~= "heading" then f.max = f.max or DEFAULT_MAX[f.type] end
    end
    if fids.notes then fail("%s: 'notes' is added automatically, do not declare it", w) end
    local d = t.draft
    if not d or not SHAPES[d.shape] then fail("%s: draft.shape must be one of page/segment/investigator/timeline/scene/source", w)
    else
      for key, ref in pairs(d) do
        if key ~= "shape" then
          local refs = type(ref) == "table" and ref or { ref }
          for _, r in ipairs(refs) do
            if not fids[r] then fail("%s: draft.%s points to unknown field '%s'", w, key, tostring(r)) end
          end
        end
      end
    end
    -- every form ends with an optional note for the reviewer
    t.fields[#t.fields + 1] = { id = "notes", type = "textarea", max = 2000,
      label = { en = strings.notes_label.en, pt = strings.notes_label.pt } }
    -- options become { value, label = {en, pt} } for JSON
    for _, f in ipairs(t.fields) do
      if f.options then
        local opts = {}
        for i, o in ipairs(f.options) do opts[i] = { value = o[1], label = { en = o.en, pt = o.pt } } end
        f.options = opts
      end
    end
    out[t.id] = t
  end
  return out
end

local templates = prepare_templates(base_tpls, "contribute/templates.lua")
if not templates[IDEA_TEMPLATE] then fail("contribute/templates.lua: the '%s' template (new book ideas) is missing", IDEA_TEMPLATE) end

local books_json = {}
local function per_lang(f) local t = {}; for _, l in ipairs(LANGS) do t[l] = f(l) end; return t end
for _, book in ipairs(books) do
  local ms = manifests[book.id]
  local m = ms and ms[LANGS[1]]
  local complete = m and true
  for _, l in ipairs(LANGS) do if not (ms and ms[l]) then complete = false end end
  if complete then
    -- a book may add or replace templates in its own contrib.lua
    local tpls = templates
    local extra = "books/" .. book.id .. "/contrib.lua"
    if file_exists(extra) then
      tpls = setmetatable(prepare_templates(dofile(extra), extra), { __index = templates })
    end
    local pages, used, page_order = {}, {}, {}
    for i, p in ipairs(m.pages) do
      page_order[#page_order + 1] = p.id
      for _, tid in ipairs(p.templates) do
        if not tpls[tid] then fail("book '%s': page '%s' offers unknown form template '%s'", book.id, p.id, tid) end
        used[tid] = tpls[tid]
      end
      pages[p.id] = {
        title = per_lang(function(l) return ms[l].pages[i].title end),
        section = p.section, kind = p.kind,
        templates = #p.templates > 0 and p.templates or json.array(),
        segments = per_lang(function(l) local sg = ms[l].pages[i].segments; return #sg > 0 and sg or json.array() end),
      }
    end
    local own = {}
    for tid, t in pairs(used) do if rawget(tpls, tid) and tpls ~= templates then own[tid] = t end end
    books_json[book.id] = {
      title = per_lang(function(l) return ms[l].title end), system = book.system, author = book.author,
      lang = book.lang, open = book.open_contributions and true or false,
      pages = pages, sections = m.sections, order = page_order,   -- reading order (JSON objects are sorted by key)
      templates = next(own) and own or nil,   -- book-specific templates override shared ones
    }
  end
end

---------------------------------------------------------------------------
-- Stop here if anything is wrong
---------------------------------------------------------------------------
if #errors > 0 then
  io.stderr:write("\nMagic Stack build failed — " .. #errors .. " problem(s):\n")
  for _, e in ipairs(errors) do io.stderr:write("  • " .. e .. "\n") end
  os.exit(1)
end

local n_tpl = 0
for _ in pairs(templates) do n_tpl = n_tpl + 1 end
print("── Magic Stack")
print(string.format("✓ %d book(s) on the shelf", #books))
print(string.format("✓ %d contribution form templates, all fields and drafts consistent", n_tpl))
if CHECK_ONLY then return end

---------------------------------------------------------------------------
-- 3. Site
---------------------------------------------------------------------------
local function esc(s)
  return (tostring(s):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end
local function write(name, s)
  local f = assert(io.open(OUT .. "/" .. name, "w")); f:write(s); f:close()
end

-- forms.json: the single source of truth for the form and the Worker
local forms = {
  version = 1,
  site = {
    title = site.title, owner = site.owner, worker_url = site.worker_url,
    turnstile_sitekey = site.turnstile_sitekey, terms_version = site.terms_version,
    terms_url = "terms.html", default_lang = site.default_lang, langs = site.langs,
  },
  strings = strings,
  templates = templates,
  books = books_json,
  idea = { template = IDEA_TEMPLATE },   -- contribute.html?idea=1
}
write("forms.json", json.encode(forms, " "))

local FONTS = '<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
  .. '<link href="https://fonts.googleapis.com/css2?family=Pirata+One&family=Silkscreen:wght@400;700&family=EB+Garamond:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">'
local LANG_HEAD = read("shelf/lang-head.html")
local LANG_SWITCH = '<div class="ms-langs" role="group" aria-label="Idioma / Language">'
  .. '<button type="button" data-set-lang="pt" lang="pt" title="Português">PT</button>'
  .. '<button type="button" data-set-lang="en" lang="en" title="English">EN</button></div>'
-- bilingual inline text: both spans are in the page, CSS shows the active one
local function L2(pt, en) return '<span data-l="pt">' .. pt .. '</span><span data-l="en">' .. en .. '</span>' end

-- title = { pt = ..., en = ... }
local function shell(title, desc, body, extra_head)
  return string.format([[<!doctype html>
<html lang="pt-BR" data-title-pt="%s" data-title-en="%s">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>%s</title>
<meta name="description" content="%s">
%s
%s
<link rel="stylesheet" href="stack.css">
%s
</head>
<body>
<a class="skip" href="#main">%s</a>
<header class="topbar"><a class="brand" href="index.html"><span class="sigil" aria-hidden="true"></span> %s</a>%s</header>
<main id="main">%s</main>
<footer class="foot"><p>%s · %s · <a href="terms.html">%s</a> · <a href="%s">%s</a></p></footer>
</body>
</html>
]], esc(title.pt), esc(title.en), esc(title.pt), esc(desc), LANG_HEAD, FONTS, extra_head or "",
    L2("Pular para o conteúdo", "Skip to content"), esc(site.title), LANG_SWITCH, body,
    esc(site.title), L2("histórias de " .. esc(site.owner) .. " e colaboradores", "stories by " .. esc(site.owner) .. " and contributors"),
    L2("Termo de contribuição", "Contribution terms"), esc(site.repo_url), L2("Código no GitHub", "Source on GitHub"))
end

-- Shelf and table (index.html). Ported from the Claude Design file
-- "Estante e Mesa v2": build.lua writes the spines and the book data,
-- shelf/shelf.paint.js + shelf/shelf.app.js run the room in the browser.
do
  local STATUS = { complete = "completo", ["in-progress"] = "andamento", draft = "rascunho" }
  local shelf_books = {}
  local spines = {}
  for _, b in ipairs(books) do
    local ms, sp = manifests[b.id], b.spine or {}
    local function field(l, k) local t = b.i18n and b.i18n[l]; return (t and t[k]) or b[k] end
    -- table of contents per language: each section with its page titles
    local function toc_for(l)
      local m, toc, by_section = ms[l], {}, {}
      for _, p in ipairs(m.pages) do
        by_section[p.section] = by_section[p.section] or {}
        table.insert(by_section[p.section], p.title)
      end
      for _, sec in ipairs(m.sections) do
        if by_section[sec] then toc[#toc + 1] = { s = m.section_names[sec] or sec, p = table.concat(by_section[sec], " · ") } end
      end
      return toc
    end
    -- where "Contribuir" leads: the book's chosen page, else the first page that takes contributions
    local cpage = b.contrib_page
    if not cpage then for _, p in ipairs(ms[LANGS[1]].pages) do if #p.templates > 0 then cpage = p.id; break end end end
    local cover_src = b.cover and read("books/" .. b.id .. "/" .. b.cover):gsub("<!%-%-.-%-%->%s*", "")
    local credits_file = "books/" .. b.id .. "/credits.lua"
    local contributors = file_exists(credits_file) and #dofile(credits_file) or 0
    local status = STATUS[b.status]
    if not status then fail("%s: status must be complete, in-progress or draft", b.id) end
    for _, k in ipairs({ "color", "light", "band", "ink" }) do
      if not (sp[k] or ""):match("^#%x%x%x%x%x%x$") then fail("%s: spine.%s must be a #rrggbb colour", b.id, k) end
    end
    local entry = {
      id = b.id, system = b.system, status = status, author = b.author, contributors = contributors,
      title = per_lang(function(l) return field(l, "title") end),
      period = per_lang(function(l) return field(l, "period") or "—" end),
      place = per_lang(function(l) return field(l, "place") or "—" end),
      kicker = per_lang(function(l) return field(l, "kicker") or b.system end),
      synopsis = per_lang(function(l) return field(l, "blurb") or "" end),
      toc = per_lang(toc_for),
      coverHtml = cover_src and per_lang(function(l)
        return (cover_src:gsub("{{AUTHOR}}", function() return esc(b.author:upper()) end)
          :gsub("{{TITLE}}", function() return esc(field(l, "title")) end)
          :gsub("{{SYSTEM}}", function() return esc(b.system:upper()) end))
      end) or nil,
      href = per_lang(function(l) return b.id .. "/" .. l .. "/index.html" end),
      contribHref = per_lang(function(l)
        return cpage and ("contribute.html?book=" .. b.id .. "&page=" .. cpage .. "&lang=" .. l) or (b.id .. "/" .. l .. "/index.html")
      end),
      color = sp.color, light = sp.light, band = sp.band, ink = sp.ink,
      w = sp.w or 40, h = sp.h or 170, emblem = sp.emblem or false, labels = b.labels or false, magic = b.magic,
    }
    shelf_books[#shelf_books + 1] = entry
    local titles = {}
    for _, l in ipairs(LANGS) do titles[#titles + 1] = string.format('<span data-l="%s">%s</span>', l, esc(entry.title[l])) end
    spines[#spines + 1] = string.format([[
            <li class="ms-book" data-id="%s" style="width:%dpx; height:%dpx;">
              <a class="ms-spine" href="%s/" draggable="false" aria-label="%s, %s" style="--c:%s; --ink:%s; --light:%s; --band:%s;">
                <span aria-hidden="true" class="ms-sp-line top"></span><span aria-hidden="true" class="ms-sp-line bot"></span>
                <span aria-hidden="true" class="ms-sp-band top"></span><span aria-hidden="true" class="ms-sp-band bot"></span>
                <span aria-hidden="true" class="ms-sp-title">%s</span>%s
              </a>%s
            </li>]],
      b.id, entry.w, entry.h, b.id, esc(entry.title[LANGS[1]]), esc(b.system),
      sp.color, sp.ink, sp.light, sp.band, table.concat(titles),
      entry.emblem and '\n                <span aria-hidden="true" class="ms-sp-emblem"></span>' or "",
      status == "andamento" and '\n              <span aria-hidden="true" class="ms-ribbon"></span>'
        or status == "rascunho" and '\n              <span aria-hidden="true" class="ms-draft1"></span><span aria-hidden="true" class="ms-draft2"></span>' or "")

    -- docs/<book>/index.html: send readers to their language
    write(b.id .. "/index.html", string.format([[<!doctype html>
<html lang="pt-BR"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>%s</title>
%s
<script>location.replace(window.msLang() + '/index.html' + location.hash);</script>
</head><body style="background:#11111d;color:#e9e3d2;font-family:Georgia,serif;padding:24px">
<p><a href="pt/index.html" style="color:#f3b04a">%s (Português)</a> · <a href="en/index.html" style="color:#f3b04a">%s (English)</a></p>
</body></html>
]], esc(entry.title[LANGS[1]]), LANG_HEAD, esc(entry.title.pt or ""), esc(entry.title.en or "")))
  end
  spines[#spines + 1] = [[
            <li class="ms-empty" style="height:168px;">
              <a href="propor-livro.html" aria-label="Sua história aqui / Your story here"><span><span data-l="pt">Sua história aqui</span><span data-l="en">Your story here</span></span></a>
            </li>]]
  if #errors > 0 then
    io.stderr:write("\nShelf failed:\n")
    for _, e in ipairs(errors) do io.stderr:write("  • " .. e .. "\n") end
    os.exit(1)
  end
  local data = json.encode({ books = shelf_books, circle = site.shelf_circle or "system", fog = site.shelf_fog ~= false })
    :gsub("</", "<\\/")
  local html = read("shelf/shelf.html")
  local fills = { TITLE = esc(site.title .. " — uma estante de histórias de RPG"), TITLE_EN = esc(site.title .. " — a shelf of RPG stories"),
    TAGLINE = esc(site.tagline), LANGHEAD = LANG_HEAD, LANGSWITCH = LANG_SWITCH,
    SITE = esc(site.title), REPO = esc(site.repo_url), SPINES = table.concat(spines, "\n"), DATA = data }
  html = html:gsub("{{([%u_]+)}}", function(k) return fills[k] end)
  write("index.html", html)
  write("shelf.css", read("shelf/shelf.css"))
  write("shelf.js", "// Magic Stack shelf — generated by build.lua from shelf/shelf.paint.js and shelf/shelf.app.js\n"
    .. "(function () {\n'use strict';\n" .. read("shelf/shelf.paint.js") .. "\n" .. read("shelf/shelf.app.js") .. "\n})();\n")

  -- "Sua história aqui": three ways in — a new book idea (form), add to a
  -- book on the shelf (form), or a complete book (pull request on GitHub)
  local repo = esc(site.repo_url)
  local body = [[
<div class="propose">
<h1><span data-l="pt">Sua história aqui</span><span data-l="en">Your story here</span></h1>
<p class="lede"><span data-l="pt">O Magic Stack é uma estante aberta. Escolha como você quer participar. As duas primeiras formas são formulários simples e não precisam de conta no GitHub.</span><span data-l="en">Magic Stack is an open shelf. Choose how you would like to take part. The first two ways are simple forms and need no GitHub account.</span></p>

<div class="paths">
  <section class="path">
    <p class="path-k"><span data-l="pt">SEM GITHUB · FORMULÁRIO</span><span data-l="en">NO GITHUB · FORM</span></p>
    <h2><span data-l="pt">Enviar a ideia de um livro</span><span data-l="en">Send an idea for a book</span></h2>
    <p><span data-l="pt">Você conta a história que gostaria de ver na estante, em blocos: a ideia, o cenário, o mistério, os locais, os personagens, as cenas e os finais. Preencha o que tiver. O autor desenvolve o livro inteiro a partir disso, e você recebe crédito conforme o termo.</span><span data-l="en">You describe the story you would like to see on the shelf, in parts: the idea, the setting, the mystery, the places, the characters, the scenes and the endings. Fill in what you have. The author develops the whole book from it, and you are credited according to the terms.</span></p>
    <a class="btn" href="contribute.html?idea=1"><span data-l="pt">Enviar uma ideia</span><span data-l="en">Send an idea</span></a>
  </section>

  <section class="path">
    <p class="path-k"><span data-l="pt">SEM GITHUB · FORMULÁRIO</span><span data-l="en">NO GITHUB · FORM</span></p>
    <h2><span data-l="pt">Contribuir com um livro da estante</span><span data-l="en">Add to a book on the shelf</span></h2>
    <p><span data-l="pt">Um personagem, um local, uma cena, um final, uma correção: escolha o livro e a parte dele, e o formulário certo abre. Você também encontra o botão <strong>Contribuir</strong> em cada página dos livros.</span><span data-l="en">A character, a place, a scene, an ending, a correction: pick the book and the part of it, and the right form opens. You will also find a <strong>Contribute</strong> button on every page of the books.</span></p>
    <div class="picker" id="picker">
      <label for="pk-book"><span data-l="pt">Livro</span><span data-l="en">Book</span></label>
      <select id="pk-book"></select>
      <label for="pk-page"><span data-l="pt">Parte</span><span data-l="en">Part</span></label>
      <select id="pk-page"></select>
      <a class="btn" id="pk-go" href="#"><span data-l="pt">Abrir o formulário</span><span data-l="en">Open the form</span></a>
    </div>
  </section>

  <section class="path">
    <p class="path-k"><span data-l="pt">GITHUB · PULL REQUEST</span><span data-l="en">GITHUB · PULL REQUEST</span></p>
    <h2><span data-l="pt">Enviar um livro completo</span><span data-l="en">Send a complete book</span></h2>
    <div data-l="pt">
      <p>Se você já escreveu o livro e se sente à vontade com código, ele entra por um <em>pull request</em>. Cada livro é uma pasta em <code>books/</code>, com a história escrita como dados em Lua, como em <a href="mist-over-the-funicular/pt/index.html">A Névoa sobre o Funicular</a>.</p>
      <ul>
        <li>Copie a pasta do Mist, troque o conteúdo pelo seu, acrescente o livro em <code>library.lua</code> e rode <code>lua build.lua</code>. O build avisa o que estiver faltando ou inconsistente.</li>
        <li>O livro precisa existir em português e em inglês: o texto original fica em <code>data/</code> e a tradução em <code>data/&lt;idioma&gt;/</code>. O build confere se nada ficou sem tradução.</li>
        <li>Qualquer sistema serve: Call of Cthulhu, Tormenta20, D&amp;D, Old Dragon, Ordem Paranormal ou o seu.</li>
        <li>Todo livro passa pela revisão do autor da estante antes de entrar, e segue o mesmo <a href="terms.html">Termo de Contribuição</a>.</li>
      </ul>
      <p><a class="btn btn-ghost" href="]] .. repo .. [[">Ver o código no GitHub</a></p>
    </div>
    <div data-l="en">
      <p>If you have already written the book and are comfortable with code, it comes in through a <em>pull request</em>. Each book is a folder in <code>books/</code>, with the story written as Lua data, like <a href="mist-over-the-funicular/en/index.html">The Mist over the Funicular</a>.</p>
      <ul>
        <li>Copy the Mist folder, replace the content with yours, add the book to <code>library.lua</code> and run <code>lua build.lua</code>. The build tells you what is missing or inconsistent.</li>
        <li>The book has to exist in Portuguese and in English: the original text lives in <code>data/</code> and the translation in <code>data/&lt;language&gt;/</code>. The build checks that nothing is left untranslated.</li>
        <li>Any system works: Call of Cthulhu, Tormenta20, D&amp;D, Old Dragon, Ordem Paranormal or your own.</li>
        <li>Every book is reviewed by the shelf's author before it goes in, and follows the same <a href="terms.html">Contribution Terms</a>.</li>
      </ul>
      <p><a class="btn btn-ghost" href="]] .. repo .. [[">See the code on GitHub</a></p>
    </div>
  </section>
</div>
<p class="propose-back"><a href="index.html"><span data-l="pt">← Voltar à estante</span><span data-l="en">← Back to the shelf</span></a></p>
</div>
<script src="propose.js" defer></script>]]
  write("propor-livro.html", shell({ pt = "Sua história aqui · " .. site.title, en = "Your story here · " .. site.title },
    "Envie a ideia de um livro, contribua com um livro da estante ou envie um livro completo.", body))
  write("propose.js", read("contribute/propose.js"))
end

-- Contribution form page (rendered client-side from forms.json)
do
  local head = ""
  if site.turnstile_sitekey ~= "" then
    head = '<script src="https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit" async defer></script>'
  end
  local body = [[
<div id="app" class="form-app" aria-live="polite">
  <noscript><p><span data-l="pt">O formulário de contribuição precisa de JavaScript.</span><span data-l="en">The contribution form needs JavaScript.</span></p></noscript>
  <p class="loading"><span data-l="pt">Carregando o formulário…</span><span data-l="en">Loading the form…</span></p>
</div>
<script src="contribute.js" defer></script>]]
  write("contribute.html", shell({ pt = "Contribuir · " .. site.title, en = "Contribute · " .. site.title },
    "Envie uma contribuição para uma história do Magic Stack.", body, head))
  write("contribute.js", read("contribute/form.js"))
end

-- Terms page, Portuguese (governing) and English
do
  local function md(src)
    src = src:gsub("{{version}}", site.terms_version):gsub("{{date}}", site.terms_date)
             :gsub("{{owner}}", site.owner)
             :gsub("{{contact}}", site.contact ~= "" and site.contact or "(a ser definido / to be announced)")
    local out, para, list, tbl = {}, {}, {}, {}
    local function inline(s)
      s = esc(s)
      s = s:gsub("%*%*(.-)%*%*", "<strong>%1</strong>"):gsub("%*(.-)%*", "<em>%1</em>")
      return s
    end
    local function flush()
      if #para > 0 then out[#out + 1] = "<p>" .. inline(table.concat(para, " ")) .. "</p>"; para = {} end
      if #list > 0 then
        local li = {}
        for _, x in ipairs(list) do li[#li + 1] = "<li>" .. inline(x) .. "</li>" end
        out[#out + 1] = "<ul>" .. table.concat(li) .. "</ul>"; list = {}
      end
      if #tbl > 0 then
        local rows = {}
        for i, cells in ipairs(tbl) do
          local tag = i == 1 and "th" or "td"
          local cs = {}
          for _, c in ipairs(cells) do cs[#cs + 1] = "<" .. tag .. ">" .. inline(c) .. "</" .. tag .. ">" end
          rows[#rows + 1] = "<tr>" .. table.concat(cs) .. "</tr>"
        end
        out[#out + 1] = '<div class="table-wrap"><table><thead>' .. rows[1] .. "</thead><tbody>"
          .. table.concat(rows, "", 2) .. "</tbody></table></div>"
        tbl = {}
      end
    end
    for line in (src .. "\n"):gmatch("(.-)\n") do
      line = line:gsub("%s+$", "")
      if line == "" then flush()
      elseif line:match("^# ") then flush(); out[#out + 1] = "<h1>" .. inline(line:sub(3)) .. "</h1>"
      elseif line:match("^## ") then flush(); out[#out + 1] = "<h2>" .. inline(line:sub(4)) .. "</h2>"
      elseif line:match("^%- ") then list[#list + 1] = line:sub(3)
      elseif line:match("^|") then
        if not line:match("^|[%s%-:|]+|$") then
          local cells = {}
          for c in line:sub(2, -2):gmatch("[^|]+") do cells[#cells + 1] = c:gsub("^%s+", ""):gsub("%s+$", "") end
          tbl[#tbl + 1] = cells
        end
      else para[#para + 1] = line end
    end
    flush()
    return table.concat(out, "\n")
  end
  local body = table.concat({
    '<div class="terms">',
    '<article id="pt" lang="pt" data-l="pt" class="prose">', md(read("contribute/TERMOS.pt.md")), '</article>',
    '<article id="en" lang="en" data-l="en" class="prose">', md(read("contribute/TERMS.en.md")), '</article>',
    '</div>',
  }, "\n")
  write("terms.html", shell({ pt = "Termo de Contribuição · " .. site.title, en = "Contribution Terms · " .. site.title },
    "Como funcionam as contribuições, os créditos e o consentimento no Magic Stack.", body))
end

write("stack.css", read("contribute/stack.css"))
write(".nojekyll", "")
print("✓ wrote shelf, contribute form, terms and forms.json to " .. OUT .. "/")
