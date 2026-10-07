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
os.execute("mkdir -p " .. BUILD .. (CHECK_ONLY and "" or (" " .. OUT)))

local books, manifests = {}, {}
for _, id in ipairs(library) do
  local dir = "books/" .. id
  if not file_exists(dir .. "/book.lua") then fail("library: book '%s' has no %s/book.lua", id, dir)
  else
    local book = dofile(dir .. "/book.lua")
    if book.id ~= id then fail("%s/book.lua: id is '%s', expected '%s'", dir, tostring(book.id), id) end
    books[#books + 1] = book
    print("── " .. book.title)
    local cmd = string.format("cd %s && %s build.lua %s--out %s --manifest %s --lib %s --shelf %s --contribute %s",
      sh_quote(dir), sh_quote(LUA), CHECK_ONLY and "--check " or "",
      sh_quote("../../" .. OUT .. "/" .. id), sh_quote("../../" .. BUILD .. "/" .. id .. ".manifest.lua"),
      sh_quote("../../lib"), sh_quote("../index.html"), sh_quote("../contribute.html"))
    local ok = os.execute(cmd)
    if not ok then fail("book '%s' failed its own build (see above)", id)
    else manifests[id] = dofile(BUILD .. "/" .. id .. ".manifest.lua") end
  end
end

---------------------------------------------------------------------------
-- 2. Contribution templates
---------------------------------------------------------------------------
local FIELD_TYPES = { text = true, textarea = true, select = true, number = true, url = true }
local DEFAULT_MAX = { text = 140, url = 500, textarea = 4000 }
local SHAPES = { page = true, segment = true, investigator = true, timeline = true, scene = true, source = true }
local LANGS = site.langs

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
    for _, f in ipairs(t.fields or {}) do
      local fw = w .. " field '" .. tostring(f.id) .. "'"
      if not f.id or not f.id:match("^[%a][%w_]*$") then fail("%s: bad field id", fw) end
      if fids[f.id] then fail("%s: duplicate field id", fw) end
      fids[f.id] = true
      if not FIELD_TYPES[f.type] then fail("%s: unknown type '%s'", fw, tostring(f.type)) end
      check_text(f.label, fw .. " label")
      if f.help then check_text(f.help, fw .. " help") end
      if f.type == "select" then
        if not f.options or #f.options < 2 then fail("%s: a select needs at least 2 options", fw) end
        for _, o in ipairs(f.options or {}) do
          if type(o[1]) ~= "string" then fail("%s: option without a value", fw) end
          check_text({ en = o.en, pt = o.pt }, fw .. " option '" .. tostring(o[1]) .. "'")
        end
      end
      if f.type ~= "number" and f.type ~= "select" then f.max = f.max or DEFAULT_MAX[f.type] end
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

local books_json = {}
for _, book in ipairs(books) do
  local m = manifests[book.id]
  if m then
    -- a book may add or replace templates in its own contrib.lua
    local tpls = templates
    local extra = "books/" .. book.id .. "/contrib.lua"
    if file_exists(extra) then
      tpls = setmetatable(prepare_templates(dofile(extra), extra), { __index = templates })
    end
    local pages, used = {}, {}
    for _, p in ipairs(m.pages) do
      for _, tid in ipairs(p.templates) do
        if not tpls[tid] then fail("book '%s': page '%s' offers unknown form template '%s'", book.id, p.id, tid) end
        used[tid] = tpls[tid]
      end
      pages[p.id] = { title = p.title, section = p.section, kind = p.kind,
                      templates = #p.templates > 0 and p.templates or json.array(),
                      segments = #p.segments > 0 and p.segments or json.array() }
    end
    local own = {}
    for tid, t in pairs(used) do if rawget(tpls, tid) and tpls ~= templates then own[tid] = t end end
    books_json[book.id] = {
      title = book.title, subtitle = book.subtitle, system = book.system, author = book.author,
      lang = book.lang, open = book.open_contributions and true or false,
      pages = pages, sections = m.sections,
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
}
write("forms.json", json.encode(forms, " "))

local FONTS = '<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
  .. '<link href="https://fonts.googleapis.com/css2?family=Pirata+One&family=Silkscreen:wght@400;700&family=EB+Garamond:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">'

local function shell(title, desc, body, extra_head)
  return string.format([[<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>%s</title>
<meta name="description" content="%s">
%s
<link rel="stylesheet" href="stack.css">
%s
</head>
<body>
<a class="skip" href="#main">Skip to content</a>
<header class="topbar"><a class="brand" href="index.html"><span class="sigil" aria-hidden="true"></span> %s</a></header>
<main id="main">%s</main>
<footer class="foot"><p>%s · stories by %s and contributors · <a href="terms.html">Contribution terms</a> · <a href="%s">Source on GitHub</a></p></footer>
</body>
</html>
]], esc(title), esc(desc), FONTS, extra_head or "", esc(site.title), body,
    esc(site.title), esc(site.owner), esc(site.repo_url))
end

-- Shelf and table (index.html). Ported from the Claude Design file
-- "Estante e Mesa v2": build.lua writes the spines and the book data,
-- shelf/shelf.paint.js + shelf/shelf.app.js run the room in the browser.
do
  local STATUS = { complete = "completo", ["in-progress"] = "andamento", draft = "rascunho" }
  local STATUS_PT = { completo = "completo", andamento = "em andamento", rascunho = "rascunho" }
  local shelf_books = {}
  local spines = {}
  for _, b in ipairs(books) do
    local m, sp = manifests[b.id], b.spine or {}
    -- table of contents: each section with its page titles
    local toc, by_section = {}, {}
    for _, p in ipairs(m.pages) do
      by_section[p.section] = by_section[p.section] or {}
      table.insert(by_section[p.section], p.title)
    end
    for _, sec in ipairs(m.sections) do
      if by_section[sec] then toc[#toc + 1] = { s = sec, p = table.concat(by_section[sec], " · ") } end
    end
    -- where "Contribuir" leads: the book's chosen page, else the first page that takes contributions
    local cpage = b.contrib_page
    if not cpage then for _, p in ipairs(m.pages) do if #p.templates > 0 then cpage = p.id; break end end end
    local cover
    if b.cover then
      cover = read("books/" .. b.id .. "/" .. b.cover):gsub("<!%-%-.-%-%->%s*", "")
        :gsub("{{AUTHOR}}", function() return esc(b.author:upper()) end)
    end
    local credits_file = "books/" .. b.id .. "/credits.lua"
    local contributors = file_exists(credits_file) and #dofile(credits_file) or 0
    local status = STATUS[b.status]
    if not status then fail("%s: status must be complete, in-progress or draft", b.id) end
    for _, k in ipairs({ "color", "light", "band", "ink" }) do
      if not (sp[k] or ""):match("^#%x%x%x%x%x%x$") then fail("%s: spine.%s must be a #rrggbb colour", b.id, k) end
    end
    local entry = {
      id = b.id, title = b.title, system = b.system, status = status,
      period = b.period or "—", place = b.place or "—", author = b.author,
      kicker = b.kicker or b.system, synopsis = b.blurb or "", contributors = contributors,
      color = sp.color, light = sp.light, band = sp.band, ink = sp.ink,
      w = sp.w or 40, h = sp.h or 170, emblem = sp.emblem or false, labels = b.labels or false,
      magic = b.magic, toc = toc, coverHtml = cover,
      href = b.id .. "/index.html",
      contribHref = cpage and ("contribute.html?book=" .. b.id .. "&page=" .. cpage) or (b.id .. "/index.html"),
    }
    shelf_books[#shelf_books + 1] = entry
    spines[#spines + 1] = string.format([[
            <li class="ms-book" data-id="%s" style="width:%dpx; height:%dpx;">
              <a class="ms-spine" href="%s" draggable="false" aria-label="%s, %s, %s" style="--c:%s; --ink:%s; --light:%s; --band:%s;">
                <span aria-hidden="true" class="ms-sp-line top"></span><span aria-hidden="true" class="ms-sp-line bot"></span>
                <span aria-hidden="true" class="ms-sp-band top"></span><span aria-hidden="true" class="ms-sp-band bot"></span>
                <span aria-hidden="true" class="ms-sp-title"><span>%s</span></span>%s
              </a>%s
            </li>]],
      b.id, entry.w, entry.h, entry.href, esc(b.title), esc(b.system), STATUS_PT[status] or "",
      sp.color, sp.ink, sp.light, sp.band, esc(b.title),
      entry.emblem and '\n                <span aria-hidden="true" class="ms-sp-emblem"></span>' or "",
      status == "andamento" and '\n              <span aria-hidden="true" class="ms-ribbon"></span>'
        or status == "rascunho" and '\n              <span aria-hidden="true" class="ms-draft1"></span><span aria-hidden="true" class="ms-draft2"></span>' or "")
  end
  spines[#spines + 1] = [[
            <li class="ms-empty" style="height:168px;">
              <a href="propor-livro.html" aria-label="Sua história aqui: como propor um livro novo"><span>Sua história aqui</span></a>
            </li>]]
  if #errors > 0 then
    io.stderr:write("\nShelf failed:\n")
    for _, e in ipairs(errors) do io.stderr:write("  • " .. e .. "\n") end
    os.exit(1)
  end
  local data = json.encode({ books = shelf_books, circle = site.shelf_circle or "system", fog = site.shelf_fog ~= false })
    :gsub("</", "<\\/")
  local html = read("shelf/shelf.html")
  local fills = { TITLE = esc(site.title .. " — uma estante de histórias de RPG"), TAGLINE = esc(site.tagline),
    SITE = esc(site.title), REPO = esc(site.repo_url), SPINES = table.concat(spines, "\n"), DATA = data }
  html = html:gsub("{{(%u+)}}", function(k) return fills[k] end)
  write("index.html", html)
  write("shelf.css", read("shelf/shelf.css"))
  write("shelf.js", "// Magic Stack shelf — generated by build.lua from shelf/shelf.paint.js and shelf/shelf.app.js\n"
    .. "(function () {\n'use strict';\n" .. read("shelf/shelf.paint.js") .. "\n" .. read("shelf/shelf.app.js") .. "\n})();\n")

  -- "Sua história aqui": how to propose a new book
  local body = [[
<div class="terms prose">
<h1>Propor um livro</h1>
<p class="lede">O Magic Stack é uma estante aberta. Além de contribuir com as histórias que já estão nela, você pode propor um livro inteiro seu.</p>
<h2>Como funciona</h2>
<ul>
<li><strong>Livros e páginas novas</strong> entram por um <em>pull request</em> no GitHub. Cada livro é uma pasta em <code>books/</code>, com a história escrita como dados em Lua, como em <a href="mist-over-the-funicular/index.html">The Mist over the Funicular</a>.</li>
<li>Copie a pasta do Mist, troque o conteúdo pelo seu, acrescente o livro em <code>library.lua</code> e rode <code>lua build.lua</code>. O build avisa o que estiver faltando ou inconsistente.</li>
<li>Qualquer sistema serve: Call of Cthulhu, Tormenta20, D&amp;D, Old Dragon, Ordem Paranormal ou o seu.</li>
<li>Todo livro proposto passa pela revisão do autor da estante antes de entrar, e segue o mesmo <a href="terms.html">Termo de Contribuição</a>.</li>
</ul>
<h2>Sem GitHub?</h2>
<p>Comece contribuindo com uma história existente: cada página tem um botão <strong>Contribuir</strong> que abre um formulário simples. Se quiser propor um livro inteiro e não usa GitHub, escreva para o contato do <a href="terms.html">termo</a>.</p>
<p><a href="]] .. esc(site.repo_url) .. [[">Ver o código no GitHub</a> · <a href="index.html">← Voltar à estante</a></p>
</div>]]
  write("propor-livro.html", shell("Propor um livro · " .. site.title, "Como propor um livro novo para a estante do Magic Stack.", body))
end

-- Contribution form page (rendered client-side from forms.json)
do
  local head = ""
  if site.turnstile_sitekey ~= "" then
    head = '<script src="https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit" async defer></script>'
  end
  local body = [[
<div id="app" class="form-app" aria-live="polite">
  <noscript><p>The contribution form needs JavaScript.</p></noscript>
  <p class="loading">Loading the form…</p>
</div>
<script src="contribute.js" defer></script>]]
  write("contribute.html", shell("Contribute · " .. site.title, "Send a contribution to a Magic Stack story.", body, head))
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
    '<p class="lang-switch"><a href="#pt" lang="pt">Português</a> · <a href="#en" lang="en">English</a></p>',
    '<article id="pt" lang="pt" class="prose">', md(read("contribute/TERMOS.pt.md")), '</article>',
    '<hr>',
    '<article id="en" lang="en" class="prose">', md(read("contribute/TERMS.en.md")), '</article>',
    '</div>',
  }, "\n")
  write("terms.html", shell("Termo de Contribuição · " .. site.title, "How contributions, credit and consent work on Magic Stack.", body))
end

write("stack.css", read("contribute/stack.css"))
write(".nojekyll", "")
print("✓ wrote shelf, contribute form, terms and forms.json to " .. OUT .. "/")
