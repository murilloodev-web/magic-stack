-- build.lua — FiendFlayer: turns the book's Lua data into a static website
-- laid out like an RPG sourcebook (a cover with the contents, then one page
-- per chapter), in the same way as the other books on the shelf.
--
--   lua build.lua                      validate + build into docs/ (standalone)
--   lua build.lua --check              validate only
--   lua build.lua --lang en            build the English edition (translations in data/en/)
--   lua build.lua --out DIR --manifest FILE --shelf URL --contribute URL --lang L --langs pt,en
--                                      how the Magic Stack root build.lua calls it
--
-- The campaign is written in Portuguese (data/); the English edition
-- overlays data/en/. Validation stops the build on: unknown internal links,
-- unknown boxes or directives, campaign stages that cannot be reached or
-- that lead nowhere, articles in no chapter (or two), a missing concept
-- sheet, and missing translations.
--
-- There are no game statistics in this book yet, so unlike the other books
-- it checks no character sheets.

local opts = { out = "docs" }
do
  local i = 1
  while arg and arg[i] do
    local a = arg[i]
    if a == "--check" then opts.check = true; i = i + 1
    elseif a:match("^%-%-") then opts[a:sub(3)] = arg[i + 1]; i = i + 2
    else error("unknown argument " .. a) end
  end
end
local CHECK_ONLY = opts.check
local OUT = opts.out
local book = dofile("book.lua")

local chapters = dofile("data/chapters.lua")
local pages    = dofile("data/pages.lua")
local flow     = dofile("data/flow.lua")

local CONCEPT = "assets/concept-sheet.jpg"   -- the FiendFlayer concept sheet (@concept)

---------------------------------------------------------------------------
-- Language
---------------------------------------------------------------------------
local LIB = opts.lib or "../../lib"
local BASE_LANG = book.lang or "pt"
local LANG = opts.lang or BASE_LANG
local LANGS = {}
for l in (opts.langs or LANG):gmatch("[^,]+") do LANGS[#LANGS + 1] = l end
local T = assert(dofile(LIB .. "/book_strings.lua")[LANG], "no interface text for language " .. LANG)
local B = T.book
local U = assert(dofile("ui.lua")[LANG], "ui.lua has no text for language " .. LANG)
local errors = {}
local function fail(fmt, ...) errors[#errors + 1] = string.format(fmt, ...) end
local function file_exists(p) local f = io.open(p) if f then f:close() return true end end

if book.i18n and book.i18n[LANG] then
  for k, v in pairs(book.i18n[LANG]) do book[k] = v end
end

-- every language must have every interface string this book uses
do
  local base = dofile("ui.lua")[BASE_LANG]
  for _, l in ipairs(LANGS) do
    local u = dofile("ui.lua")[l]
    if not u then fail("ui.lua: no interface text for '%s'", l)
    else for k in pairs(base) do if u[k] == nil then fail("ui.lua: '%s' has no '%s'", l, k) end end end
  end
end

if LANG ~= BASE_LANG then
  local dir = "data/" .. LANG .. "/"
  local function by_id(file, list, what, apply)
    local tr = dofile(dir .. file)
    local known = {}
    for _, x in ipairs(list) do
      known[x.id] = true
      if not tr[x.id] then fail("%s%s: no translation for %s '%s'", dir, file, what, x.id) else apply(x, tr[x.id]) end
    end
    for id in pairs(tr) do if not known[id] then fail("%s%s: '%s' does not exist in the original", dir, file, id) end end
  end
  by_id("chapters.lua", chapters, "chapter", function(c, t)
    for _, k in ipairs({ "title", "epigraph", "intro" }) do
      if c[k] then if t[k] then c[k] = t[k] else fail("%schapters.lua: '%s' has no %s", dir, c.id, k) end end
    end
  end)
  by_id("pages.lua", pages, "page", function(p, t)
    if not t.title or not t.summary then fail("%spages.lua: '%s' needs title and summary", dir, p.id) end
    p.title, p.summary = t.title or p.title, t.summary or p.summary
    if p.body:sub(1, 1) ~= "@" then
      if not t.body then fail("%spages.lua: no body for page '%s'", dir, p.id) else p.body = t.body end
    end
  end)
  local tf = dofile(dir .. "flow.lua")
  for _, n in ipairs(flow.nodes) do
    local t = tf[n.id]
    if not t then fail("%sflow.lua: no translation for stage '%s'", dir, n.id)
    else
      n.title = t.title or n.title
      if n.next and #n.next > 0 then
        if not t.when or #t.when ~= #n.next then fail("%sflow.lua: stage '%s' needs %d exit conditions", dir, n.id, #n.next)
        else for i, e in ipairs(n.next) do e.when = t.when[i] end end
      end
    end
  end
end

local SITE_TITLE = book.title
local AUTHOR     = book.author

---------------------------------------------------------------------------
-- Registry: every addressable article, which chapter it is in, in order
---------------------------------------------------------------------------
local registry, order = {}, {}
for _, p in ipairs(pages) do
  if registry[p.id] then fail("duplicate id '%s'", p.id) end
  if not ({ history = true, fiction = true, mixed = true })[p.kind] then fail("page '%s': kind must be history, fiction or mixed", p.id) end
  registry[p.id] = p
end

local chapter_by_id, chapter_of = {}, {}
for ci, ch in ipairs(chapters) do
  ch.index, ch.file = ci, ch.id .. ".html"
  chapter_by_id[ch.id] = ch
  ch.label = ch.n == "A" and B.appendix or string.format(B.chapter, ch.n)
  for _, id in ipairs(ch.pages) do
    if not registry[id] then fail("chapter '%s' lists unknown article '%s'", ch.id, id)
    elseif chapter_of[id] then fail("article '%s' is in two chapters (%s and %s)", id, chapter_of[id].id, ch.id)
    else
      chapter_of[id] = ch
      local p = registry[id]
      p.chapter, p.section, p.file = ch, ch.id, ch.file
      order[#order + 1] = p
    end
  end
end
for id in pairs(registry) do
  if not chapter_of[id] then fail("article '%s' is not in any chapter (see data/chapters.lua)", id) end
end

---------------------------------------------------------------------------
-- Contributions (see book.lua)
---------------------------------------------------------------------------
local function templates_for(p)
  if not book.open_contributions or not opts.contribute then return nil end
  local c = book.contrib or {}
  local t = (c.pages or {})[p.id]
  if t == false then return nil end
  t = t or (c.chapters or {})[p.section]
  if t and #t > 0 then return t end
end
for id in pairs((book.contrib or {}).pages or {}) do
  if not registry[id] then fail("book.lua: contrib.pages names unknown article '%s'", id) end
end
for id in pairs((book.contrib or {}).chapters or {}) do
  if not chapter_by_id[id] then fail("book.lua: contrib.chapters names unknown chapter '%s'", id) end
end
if book.contrib_page and not registry[book.contrib_page] then fail("book.lua: contrib_page '%s' is not an article", book.contrib_page) end
local function url_part(s) return (s:gsub("[^%w%-_.~]", function(c) return string.format("%%%02X", c:byte()) end)) end
local function contrib_url(page_id, seg)
  return string.format("%s?book=%s&amp;page=%s%s&amp;lang=%s", opts.contribute, url_part(book.id), url_part(page_id),
    seg and ("&amp;seg=" .. url_part(seg)) or "", LANG)
end

---------------------------------------------------------------------------
-- The campaign: every stage reachable, every path reaches an open stage
---------------------------------------------------------------------------
local nodes, node_of_page = {}, {}
for _, n in ipairs(flow.nodes) do
  if nodes[n.id] then fail("flow: duplicate stage '%s'", n.id) end
  nodes[n.id] = n
  if not registry[n.page] then fail("flow: stage '%s' points to unknown article '%s'", n.id, tostring(n.page))
  elseif node_of_page[n.page] then fail("flow: article '%s' is used by two stages", n.page) end
  node_of_page[n.page] = n
end
local forward, backward = {}, {}
for _, n in ipairs(flow.nodes) do forward[n.id], backward[n.id] = {}, {} end
for _, n in ipairs(flow.nodes) do
  if not n.open and not n.ending and (not n.next or #n.next == 0) then
    fail("flow: stage '%s' is a dead end (no exits, not open, not an ending)", n.id)
  end
  for _, e in ipairs(n.next or {}) do
    if not nodes[e.to] then fail("flow: '%s' exits to unknown stage '%s'", n.id, e.to)
    else table.insert(forward[n.id], e.to); table.insert(backward[e.to], n.id) end
  end
end
local function reach(from, edges_of)
  local seen, queue = { [from] = true }, { from }
  while #queue > 0 do
    local id = table.remove(queue, 1)
    for _, to in ipairs(edges_of(id)) do
      if not seen[to] then seen[to] = true; queue[#queue + 1] = to end
    end
  end
  return seen
end
if not nodes[flow.start] then fail("flow: start stage '%s' does not exist", tostring(flow.start)) end
local reachable = reach(flow.start, function(id) return forward[id] or {} end)
local can_land, open_count = {}, 0
for _, n in ipairs(flow.nodes) do
  if n.open or n.ending then
    open_count = open_count + 1
    for id in pairs(reach(n.id, function(x) return backward[x] or {} end)) do can_land[id] = true end
  end
end
for _, n in ipairs(flow.nodes) do
  if not reachable[n.id] then fail("flow: stage '%s' can never be reached", n.id) end
  if not can_land[n.id] then fail("flow: from stage '%s' no open stage can be reached", n.id) end
  if type(n.row) ~= "number" or type(n.x) ~= "number" or n.x < 0 or n.x > 1 then
    fail("flow: stage '%s' needs a row and an x between 0 and 1 for the diagram", n.id)
  end
  for _, e in ipairs(n.next or {}) do
    if nodes[e.to] and type(nodes[e.to].row) == "number" and type(n.row) == "number" and nodes[e.to].row <= n.row then
      fail("flow: '%s' → '%s' must go down the diagram (row %s → %s)", n.id, e.to, n.row, nodes[e.to].row)
    end
  end
end

if not file_exists(CONCEPT) then fail("the concept sheet %s is missing", CONCEPT) end

---------------------------------------------------------------------------
-- Markup
---------------------------------------------------------------------------
local backlinks = {}
local function esc(s)
  return (tostring(s):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end
local function href(id, from)
  local t, f = registry[id], registry[from]
  if f and t.file == f.file then return "#" .. id end
  return t.file .. "#" .. id
end

local function inline(s, from)
  s = esc(s)
  s = s:gsub("%[%[([^%]|]+)|?([^%]]*)%]%]", function(id, label)
    local target = registry[id]
    if not target then fail("'%s' links to unknown article '%s'", from, id); return label ~= "" and label or id end
    if id ~= from then
      backlinks[id] = backlinks[id] or {}
      backlinks[id][from] = true
    end
    local text = label ~= "" and label or target.title
    return string.format('<a class="xref" href="%s">%s</a>', href(id, from), text)
  end)
  s = s:gsub("%*%*(.-)%*%*", "<strong>%1</strong>")
  s = s:gsub("%*(.-)%*", "<em>%1</em>")
  return s
end

local special = {}   -- line directives (@concept…), filled in below

local function blocks(text, from, o)
  o = o or {}
  local out, para, list, rows = {}, {}, {}, {}
  local nh = 0
  local function flush()
    if #para > 0 then out[#out + 1] = "<p>" .. inline(table.concat(para, " "), from) .. "</p>"; para = {} end
    if #list > 0 then
      local items = {}
      for _, li in ipairs(list) do items[#items + 1] = "<li>" .. inline(li, from) .. "</li>" end
      out[#out + 1] = "<ul>" .. table.concat(items) .. "</ul>"; list = {}
    end
    if #rows > 0 then
      local html = { '<div class="table-wrap"><table class="book-table">' }
      for i, r in ipairs(rows) do
        local cells, tag = {}, i == 1 and "th" or "td"
        for _, c in ipairs(r) do cells[#cells + 1] = string.format("<%s>%s</%s>", tag, inline(c, from), tag) end
        html[#html + 1] = (i == 1 and "<thead>" or (i == 2 and "<tbody>" or "")) .. "<tr>" .. table.concat(cells) .. "</tr>" .. (i == 1 and "</thead>" or "")
      end
      html[#html + 1] = (#rows > 1 and "</tbody>" or "") .. "</table></div>"
      out[#out + 1] = table.concat(html); rows = {}
    end
  end
  local box_open = false
  for line in (text .. "\n"):gmatch("(.-)\n") do
    line = line:gsub("^%s+", ""):gsub("%s+$", "")
    local box = line:match("^:::%s*(%a+)$")
    if box then
      flush()
      if box_open then fail("'%s': box '%s' opened inside another box", from, box) end
      if not U.boxes[box] then fail("'%s': unknown box '::: %s'", from, box) end
      out[#out + 1] = string.format('<aside class="box box-%s"><p class="box-label">%s</p>', box, U.boxes[box] or box)
      box_open = true
    elseif line == ":::" then
      flush()
      if not box_open then fail("'%s': ':::' closes a box that was never opened", from) end
      out[#out + 1] = "</aside>"; box_open = false
    elseif line:match("^@%a+$") and special[line:sub(2)] then
      flush(); out[#out + 1] = special[line:sub(2)](from)
    elseif line:sub(1, 1) == "@" then
      fail("'%s': unknown directive '%s'", from, line)
    elseif line:sub(1, 1) == "|" then
      if #para > 0 or #list > 0 then flush() end
      if not line:match("^|[%s%-:|]+|$") then
        local r = {}
        for cell in line:sub(2):gmatch("([^|]*)|") do r[#r + 1] = cell:gsub("^%s+", ""):gsub("%s+$", "") end
        rows[#rows + 1] = r
      end
    elseif line == "" then flush()
    elseif line:sub(1, 3) == "## " then
      flush()
      nh = nh + 1
      local h = line:sub(4)
      local clean = h:gsub("%*", ""):gsub("%s+$", "")
      local anchor = from .. "--" .. nh
      if o.toc then o.toc[#o.toc + 1] = { anchor = anchor, text = clean } end
      local seg_link = ""
      if registry[from] and templates_for(registry[from]) then
        seg_link = string.format(' <a class="contrib-seg" href="%s" title="%s">%s</a>',
          contrib_url(from, anchor), esc(string.format(T.seg_title, clean)), T.seg_link)
      end
      out[#out + 1] = string.format('<h3 id="%s">%s%s</h3>', anchor, inline(h, from), seg_link)
    elseif line:sub(1, 2) == "- " then
      if #para > 0 or #rows > 0 then local l = list; list = {}; flush(); list = l end
      list[#list + 1] = line:sub(3)
    elseif line:sub(1, 2) == "> " then
      flush(); out[#out + 1] = "<blockquote>" .. inline(line:sub(3), from) .. "</blockquote>"
    else
      if #list > 0 or #rows > 0 then local p = para; para = {}; flush(); para = p end
      para[#para + 1] = line
    end
  end
  flush()
  if box_open then fail("'%s': a box is never closed with ':::'", from) end
  return table.concat(out, "\n")
end

---------------------------------------------------------------------------
-- Special content
---------------------------------------------------------------------------
local KIND_LABEL = U.kinds
local concept_shown = false

special.concept = function()
  concept_shown = true
  return string.format('<figure class="concept"><a href="concept-sheet.jpg" target="_blank" rel="noopener">'
    .. '<img src="concept-sheet.jpg" width="1067" height="1120" loading="lazy" alt="%s"></a><figcaption>%s</figcaption></figure>',
    esc(U.concept_alt), U.concept_caption)
end

local function render_flow_svg(from)
  local maxrow = 0
  for _, n in ipairs(flow.nodes) do if n.row > maxrow then maxrow = n.row end end
  local W, BW, BH, RH, TOP = 800, 200, 46, 96, 20
  local pos = {}
  for _, n in ipairs(flow.nodes) do pos[n.id] = { x = n.x * W, y = TOP + n.row * RH } end
  local H = TOP + maxrow * RH + BH + 20
  local edges, boxes = {}, {}
  for _, n in ipairs(flow.nodes) do
    for _, e in ipairs(n.next or {}) do
      local a, b = pos[n.id], pos[e.to]
      local y1, y2 = a.y + BH, b.y - 4
      local my = (y1 + y2) / 2
      if nodes[e.to].row - n.row > 1 then my = b.y - RH / 2 end   -- long edges bend just above their target
      edges[#edges + 1] = string.format('<path d="M%.0f %.0f C%.0f %.0f %.0f %.0f %.0f %.0f" class="edge" marker-end="url(#arrow)"><title>%s</title></path>',
        a.x, y1, a.x, my, b.x, my, b.x, y2, esc(e.when))
    end
    local p = pos[n.id]
    boxes[#boxes + 1] = string.format('<a href="%s"><rect x="%.0f" y="%.0f" width="%d" height="%d" class="node%s"/><text x="%.0f" y="%.0f" class="node-label">%s</text></a>',
      href(n.page, from), p.x - BW / 2, p.y, BW, BH, (n.open or n.ending) and " node-end" or "", p.x, p.y + BH / 2 + 5, esc(n.title))
  end
  return string.format('<figure class="flow"><svg viewBox="0 0 %d %d" role="img" aria-label="%s">'
    .. '<defs><marker id="arrow" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">'
    .. '<path d="M0 0 L10 5 L0 10 z" class="arrowhead"/></marker></defs>%s%s</svg><figcaption>%s</figcaption></figure>',
    W, H, T.flow_aria, table.concat(edges), table.concat(boxes), U.flow_caption)
end

local function render_flow(from)
  local items = {}
  for _, n in ipairs(flow.nodes) do
    local p = registry[n.page]
    items[#items + 1] = string.format('<li><a href="%s">%s</a>%s<span>%s</span></li>', href(n.page, from), esc(p.title),
      n.open and (' <span class="tag tag-open">' .. U.open_scene .. '</span>') or "", esc(p.summary or ""))
  end
  return string.format('<p class="lede">' .. U.flow_lede .. '</p>', #flow.nodes)
    .. render_flow_svg(from)
    .. '<h3 id="' .. from .. '--stages">' .. U.scenes .. '</h3><ol class="scene-list">' .. table.concat(items) .. "</ol>"
end

local function render_exits(n, from)
  if not n.next or #n.next == 0 then
    return '<aside class="box box-open"><p class="box-label">' .. U.open_scene .. '</p><p>' .. U.open_text .. "</p></aside>"
  end
  local exits = {}
  for _, e in ipairs(n.next) do
    local to = nodes[e.to]
    exits[#exits + 1] = string.format('<li><a href="%s">%s</a> <span class="when">— %s</span></li>',
      href(to.page, from), esc(registry[to.page].title), inline(e.when, from))
  end
  return '<aside class="box box-exits"><p class="box-label">' .. U.exits .. '</p><ul class="exits">' .. table.concat(exits) .. "</ul></aside>"
end

---------------------------------------------------------------------------
-- Layout
---------------------------------------------------------------------------
local function nav_html(current)
  local out = { string.format('<a class="nav-cover" href="index.html"%s>%s</a>', current == "index" and ' aria-current="page"' or "", esc(B.contents)) }
  for _, ch in ipairs(chapters) do
    local here = ch.id == current
    local items = {}
    if here then
      for _, id in ipairs(ch.pages) do items[#items + 1] = string.format('<li><a href="#%s">%s</a></li>', id, esc(registry[id].title)) end
    end
    out[#out + 1] = string.format('<div class="nav-ch%s"><a href="%s"%s><span class="nav-n">%s</span>%s</a>%s</div>',
      here and " is-here" or "", ch.file, here and ' aria-current="page"' or "", esc(ch.n), esc(ch.title),
      #items > 0 and ("<ul>" .. table.concat(items) .. "</ul>") or "")
  end
  return table.concat(out)
end

local FONTS = '<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
  .. '<link href="https://fonts.googleapis.com/css2?family=Pirata+One&family=Silkscreen:wght@400;700&family=EB+Garamond:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">'

local LANG_NAMES = { en = { "EN", "English" }, pt = { "PT", "Português" } }
local function lang_switch(current)
  if #LANGS < 2 then return "" end
  local file = (current or "index") .. ".html"
  local links = {}
  for _, l in ipairs(LANGS) do
    local n = LANG_NAMES[l] or { l:upper(), l }
    links[#links + 1] = string.format('<a href="../%s/%s" hreflang="%s" lang="%s" data-set-lang="%s" title="%s"%s>%s</a>',
      l, file, l, l, l, n[2], l == LANG and ' aria-current="true"' or "", n[1])
  end
  return '<nav class="lang-switch" aria-label="' .. T.language .. '">' .. table.concat(links) .. "</nav>"
end

local function layout(title, desc, content, current)
  return string.format([[<!doctype html>
<html lang="%s">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>%s</title>
<meta name="description" content="%s">
%s
<link rel="stylesheet" href="style.css">
</head>
<body>
<a class="skip" href="#main">%s</a>
<header class="topbar">
  <div class="topbar-left">%s<a class="brand" href="index.html"><span class="sigil" aria-hidden="true"></span> %s</a></div>
  <div class="topbar-right">
    <button class="menu" aria-expanded="false" aria-controls="nav">%s</button>
    %s
  </div>
</header>
<div class="shell">
  <nav id="nav" class="nav" aria-label="%s">%s</nav>
  <main id="main">%s</main>
</div>
<footer class="foot">
  <p>%s</p>
</footer>
<script>
  const b=document.querySelector('.menu'),n=document.getElementById('nav');
  b.addEventListener('click',()=>{const o=n.classList.toggle('open');b.setAttribute('aria-expanded',o)});
  n.querySelectorAll('a[href^="#"]').forEach(a=>a.addEventListener('click',()=>{n.classList.remove('open');b.setAttribute('aria-expanded',false)}));
  document.querySelectorAll('[data-set-lang]').forEach(a=>a.addEventListener('click',e=>{
    try{localStorage.setItem('ms-lang',a.dataset.setLang)}catch(_){}
    let h=location.hash;
    if(!h){const s=[...document.querySelectorAll('.article[id]')].filter(x=>x.getBoundingClientRect().top<120).pop();if(s)h='#'+s.id}
    if(h){e.preventDefault();location.href=a.getAttribute('href')+h}
  }));
  const links=[...n.querySelectorAll('.nav-ch.is-here li a')];
  if(links.length&&'IntersectionObserver'in window){
    const io=new IntersectionObserver(es=>es.forEach(x=>{if(x.isIntersecting){links.forEach(l=>l.classList.toggle('on',l.getAttribute('href')==='#'+x.target.id))}}),{rootMargin:'-20%% 0px -70%% 0px'});
    document.querySelectorAll('.article[id]').forEach(s=>io.observe(s));
  }
</script>
</body>
</html>
]], T.html_lang, esc(title), esc(desc or book.blurb or ""), FONTS, T.skip,
    opts.shelf and string.format('<a class="shelf-link" href="%s" title="%s">%s</a>', opts.shelf, esc(T.shelf_title), T.shelf) or "",
    esc(SITE_TITLE), T.contents, lang_switch(current), esc(T.nav_label), nav_html(current), content,
    string.format(U.footer, esc(SITE_TITLE), esc(AUTHOR)))
end

local function render_article(p)
  local toc = {}
  local body
  if p.body == "@flow" then body = render_flow(p.id)
  else body = blocks(p.body, p.id, { toc = toc }) end
  if node_of_page[p.id] then body = body .. "\n" .. render_exits(node_of_page[p.id], p.id) end
  return { page = p, body = body, toc = toc }
end

local function finish_article(r)
  local p = r.page
  local open = node_of_page[p.id] and node_of_page[p.id].open
  local parts = {
    string.format('<section class="article article-%s" id="%s">', p.kind, p.id),
    string.format('<header class="article-head"><h2>%s</h2><p class="meta"><span class="tag tag-%s">%s</span>%s <span class="summary">%s</span></p></header>',
      esc(p.title), p.kind, KIND_LABEL[p.kind], open and (' <span class="tag tag-open">' .. U.open_scene .. '</span>') or "", esc(p.summary or "")),
    '<div class="prose">' .. r.body .. "</div>",
  }
  local foot, bl = {}, {}
  for _, q in ipairs(order) do
    if backlinks[p.id] and backlinks[p.id][q.id] and q.file ~= p.file then
      bl[#bl + 1] = string.format('<a href="%s">%s</a>', href(q.id, p.id), esc(q.title))
    end
  end
  if #bl > 0 then foot[#foot + 1] = '<p class="see-also"><span>' .. B.see_also .. '</span> ' .. table.concat(bl, " · ") .. "</p>" end
  if templates_for(p) then foot[#foot + 1] = string.format('<a class="contrib-article" href="%s">%s</a>', contrib_url(p.id), B.contribute_article) end
  if #foot > 0 then parts[#parts + 1] = '<footer class="article-foot">' .. table.concat(foot) .. "</footer>" end
  parts[#parts + 1] = "</section>"
  return table.concat(parts, "\n")
end

local function render_chapter(ch, rendered)
  local arts, mini = {}, {}
  for _, id in ipairs(ch.pages) do
    arts[#arts + 1] = finish_article(rendered[id])
    mini[#mini + 1] = string.format('<li><a href="#%s">%s</a></li>', id, esc(registry[id].title))
  end
  local head = {
    '<header class="chapter-head">',
    string.format('<p class="chapter-n">%s</p>', esc(ch.label)),
    string.format('<h1>%s</h1>', esc(ch.title)),
    ch.epigraph and ('<p class="chapter-epigraph">' .. inline(ch.epigraph, ch.pages[1]) .. "</p>") or "",
    ch.intro and ('<div class="chapter-intro">' .. blocks(ch.intro, ch.pages[1]) .. "</div>") or "",
    #mini > 1 and ('<nav class="chapter-toc" aria-label="' .. B.in_chapter .. '"><span>' .. B.in_chapter .. '</span><ol>' .. table.concat(mini) .. "</ol></nav>") or "",
    '</header>',
  }
  local prev, nxt = chapters[ch.index - 1], chapters[ch.index + 1]
  local pager = string.format('<nav class="pager" aria-label="%s">%s%s</nav>', U.pager,
    prev and string.format('<a class="prev" href="%s"><span>%s</span>%s</a>', prev.file, esc(prev.label), esc(prev.title))
      or string.format('<a class="prev" href="index.html"><span>%s</span>%s</a>', T.previous, esc(B.contents)),
    nxt and string.format('<a class="next" href="%s"><span>%s</span>%s</a>', nxt.file, esc(nxt.label), esc(nxt.title)) or "<span></span>")
  return layout(ch.title .. " · " .. SITE_TITLE, ch.label .. " — " .. ch.title,
    table.concat(head, "\n") .. table.concat(arts, "\n") .. pager, ch.id)
end

local function render_index()
  local toc = {}
  for _, ch in ipairs(chapters) do
    local items = {}
    for _, id in ipairs(ch.pages) do items[#items + 1] = string.format('<li><a href="%s#%s">%s</a></li>', ch.file, id, esc(registry[id].title)) end
    toc[#toc + 1] = string.format('<li class="toc-ch"><a class="toc-ch-title" href="%s"><span class="toc-n">%s</span>%s</a><ul>%s</ul></li>',
      ch.file, esc(ch.n), esc(ch.title), table.concat(items))
  end
  local glance = {}
  for _, r in ipairs(U.glance) do glance[#glance + 1] = string.format("<dt>%s</dt><dd>%s</dd>", r[1], r[2]) end
  local map_page = registry.structure
  local content = table.concat({
    '<div class="cover">',
    '<img class="banner" src="banner.svg" width="192" height="72" alt="' .. esc(book.banner_alt or "") .. '">',
    '<p class="kicker">' .. esc(book.kicker or "") .. '</p>',
    '<h1 class="cover-title">' .. (book.cover_title or esc(book.title)) .. '</h1>',
    '<p class="cover-by">' .. esc(AUTHOR) .. '</p>',
    '<p class="cover-lede">' .. esc(book.blurb or "") .. '</p>',
    '<div class="cover-actions"><a class="btn" href="' .. chapters[1].file .. '">' .. U.start .. '</a>'
      .. (map_page and ('<a class="btn btn-ghost" href="' .. map_page.file .. '#structure">' .. U.play .. '</a>') or "") .. '</div>',
    '</div>',
    '<div class="front">',
    '<aside class="glance"><h2 id="glance">' .. B.glance.title .. '</h2><dl>' .. table.concat(glance) .. '</dl>'
      .. '<p class="legend">' .. U.legend .. '</p></aside>',
    '<nav class="toc" aria-label="' .. esc(B.contents) .. '"><h2 id="contents">' .. B.contents .. '</h2><ol>' .. table.concat(toc) .. '</ol></nav>',
    '</div>',
  }, "\n")
  return layout(SITE_TITLE .. U.title_suffix, book.blurb, content, "index")
end

---------------------------------------------------------------------------
-- Build
---------------------------------------------------------------------------
local rendered = {}
for _, p in ipairs(order) do rendered[p.id] = render_article(p) end
local chapter_html = {}
for _, ch in ipairs(chapters) do chapter_html[ch.id] = render_chapter(ch, rendered) end
local index_html = render_index()
if not concept_shown then fail("the concept sheet is never shown (add @concept to an article)") end

if #errors > 0 then
  io.stderr:write("\nBuild failed — " .. #errors .. " problem(s):\n")
  for _, e in ipairs(errors) do io.stderr:write("  • " .. e .. "\n") end
  os.exit(1)
end

local reach_count = 0
for _ in pairs(reachable) do reach_count = reach_count + 1 end
print(string.format("✓ %d chapters, %d articles", #chapters, #order))
print(string.format("✓ campaign map: %d/%d stages reachable, %d open, no dead ends", reach_count, #flow.nodes, open_count))

if opts.manifest then
  local serialize = dofile(opts.lib .. "/serialize.lua")
  local list = {}
  for _, p in ipairs(order) do
    local r = rendered[p.id]
    local segs = {}
    for _, h in ipairs(r.toc) do segs[#segs + 1] = { id = h.anchor, title = h.text } end
    list[#list + 1] = { id = p.id, title = p.title, section = p.section, file = p.file, kind = p.kind,
                        templates = templates_for(p) or {}, segments = segs }
  end
  local f = assert(io.open(opts.manifest, "w"))
  local ids, names = {}, {}
  for _, ch in ipairs(chapters) do ids[#ids + 1] = ch.id; names[ch.id] = (ch.n == "A" and "" or ch.n .. ". ") .. ch.title end
  f:write(serialize({ id = book.id, lang = LANG, title = book.title, pages = list, sections = ids, section_names = names }))
  f:close()
  print("✓ wrote manifest " .. opts.manifest)
end

if CHECK_ONLY then return end

os.execute("mkdir -p " .. OUT)
local function write(name, s, mode)
  local f = assert(io.open(OUT .. "/" .. name, mode or "w")); f:write(s); f:close()
end
local function read(p, mode) local f = assert(io.open(p, mode or "r")); local s = f:read("a"); f:close(); return s end
for _, ch in ipairs(chapters) do write(ch.file, chapter_html[ch.id]) end
write("index.html", index_html)
write("style.css", read("assets/style.css"))
write("concept-sheet.jpg", read(CONCEPT, "rb"), "wb")
write(".nojekyll", "")
write("banner.svg", dofile("tools/banner.lua")())
print("✓ wrote site to " .. OUT .. "/")
