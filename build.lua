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

-- Shelf — provisional and functional. The interactive shelf-and-table
-- version is being designed separately (see DESIGN-BRIEF.md).
do
  local spines = {}
  for _, b in ipairs(books) do
    spines[#spines + 1] = string.format([[
<li class="book" style="--spine:%s;--spine-accent:%s;--spine-label:%s">
  <a href="%s/index.html">
    <span class="spine" aria-hidden="true"><span class="spine-title">%s</span></span>
    <span class="book-info">
      <strong>%s</strong>
      <span class="book-meta">%s · %s</span>
      <span class="book-blurb">%s</span>
      <span class="book-by">by %s</span>
    </span>
  </a>
</li>]], b.spine.base, b.spine.accent, b.spine.label, b.id, esc(b.title), esc(b.title),
      esc(b.system), esc(b.subtitle or b.genre or ""), esc(b.blurb or ""), esc(b.author))
  end
  local body = table.concat({
    '<section class="shelf-hero">',
    string.format('<h1>%s</h1><p class="lede">%s</p>', esc(site.title), esc(site.tagline)),
    '</section>',
    '<section class="shelf" aria-label="Books"><ul class="books">', table.concat(spines, "\n"), '</ul></section>',
    '<section class="how"><h2>Add to the stories</h2>',
    '<p>Every page of every book has a <strong>Contribute</strong> button. It opens a short form for that part of the story: a character, a place, a scene, an ending, a source. ',
    'The author reviews each one, and accepted contributions are credited in the book. ',
    '<a href="terms.html">How credit and consent work</a>.</p></section>',
  }, "\n")
  write("index.html", shell(site.title .. " — a shelf of RPG stories", site.tagline, body))
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
