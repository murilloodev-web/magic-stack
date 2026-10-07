-- build.lua — O Amanhã Corporativo: turns the book's Lua data into a static
-- website laid out like an RPG sourcebook (a cover with the contents, then
-- one page per chapter), in the same way as the other books on the shelf.
--
--   lua build.lua                      validate + build into docs/ (standalone)
--   lua build.lua --check              validate only
--   lua build.lua --lang en            build the English edition (translations in data/en/)
--   lua build.lua --out DIR --manifest FILE --shelf URL --contribute URL --lang L --langs pt,en
--                                      how the Magic Stack root build.lua calls it
--
-- The story is written in Portuguese (data/); the English edition overlays
-- data/en/. Validation stops the build on: unknown internal links or
-- citations, unused sources, character sheets that break the Cyberpunk RED
-- rules this book uses (chapter VIII), implants that do not exist, scenes
-- that cannot be reached or that lead nowhere, map letters with no owner,
-- articles in no chapter (or two), and missing translations.

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

local chapters    = dofile("data/chapters.lua")
local pages       = dofile("data/pages.lua")
local runners     = dofile("data/runners.lua")
local npcs        = dofile("data/npcs.lua")
local implants    = dofile("data/implants.lua")
local handouts    = dofile("data/handouts.lua")
local sources     = dofile("data/sources.lua")
local timeline    = dofile("data/timeline.lua")
local flow        = dofile("data/flow.lua")
local territories = dofile("data/territories.lua")
local worldgrid   = dofile("data/worldgrid.lua")

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

if book.i18n and book.i18n[LANG] then
  for k, v in pairs(book.i18n[LANG]) do book[k] = v end
end

-- every language must have every interface string this book uses
for _, l in ipairs(LANGS) do
  local u = dofile("ui.lua")[l]
  if not u then fail("ui.lua: no interface text for '%s'", l) end
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
  local function copy(obj, t, keys, where)
    for _, k in ipairs(keys) do
      if obj[k] then if t[k] then obj[k] = t[k] else fail("%s has no %s", where, k) end end
    end
  end
  local function names(obj, t, key, where)
    -- lists of { name, ... }: the translation gives the names in order
    if not obj[key] then return end
    if not t[key] or #t[key] ~= #obj[key] then fail("%s needs %d %s", where, #obj[key], key); return end
    for i, n in ipairs(t[key]) do obj[key][i][1] = type(n) == "table" and n[1] or n
      if type(n) == "table" and n[2] then obj[key][i].note = n[2] end end
  end

  by_id("chapters.lua", chapters, "chapter", function(c, t) copy(c, t, { "title", "epigraph", "intro" }, dir .. "chapters.lua: '" .. c.id .. "'") end)
  by_id("pages.lua", pages, "page", function(p, t)
    if not t.title or not t.summary then fail("%spages.lua: '%s' needs title and summary", dir, p.id) end
    p.title, p.summary = t.title or p.title, t.summary or p.summary
    if p.body:sub(1, 1) ~= "@" then
      if not t.body then fail("%spages.lua: no body for page '%s'", dir, p.id) else p.body = t.body end
    end
  end)
  by_id("runners.lua", runners, "character", function(r, t)
    local w = dir .. "runners.lua: '" .. r.id .. "'"
    copy(r, t, { "occupation", "origin", "quote", "motivation", "hook", "gear" }, w)
    names(r, t, "skills", w); names(r, t, "weapons", w)
  end)
  by_id("npcs.lua", npcs, "character", function(n, t)
    local w = dir .. "npcs.lua: '" .. n.id .. "'"
    copy(n, t, { "name", "label", "notes" }, w)
    names(n, t, "skills", w); names(n, t, "weapons", w)
  end)
  by_id("implants.lua", implants, "implant", function(im, t) copy(im, t, { "name", "text" }, dir .. "implants.lua: '" .. im.id .. "'") end)
  by_id("handouts.lua", handouts, "handout", function(h, t)
    if not t.title or not t.text then fail("%shandouts.lua: '%s' needs title and text", dir, h.id) end
    h.title, h.text = t.title or h.title, t.text or h.text
  end)
  local tt = dofile(dir .. "timeline.lua")
  if #tt ~= #timeline then fail("%stimeline.lua: %d entries, the original has %d", dir, #tt, #timeline)
  else for i, t in ipairs(tt) do timeline[i].year, timeline[i].text = t.year or timeline[i].year, t.text end end
  local tf = dofile(dir .. "flow.lua")
  for _, n in ipairs(flow.nodes) do
    local t = tf[n.id]
    if not t then fail("%sflow.lua: no translation for scene '%s'", dir, n.id)
    else
      n.title = t.title or n.title
      if n.next and #n.next > 0 then
        if not t.when or #t.when ~= #n.next then fail("%sflow.lua: scene '%s' needs %d exit conditions", dir, n.id, #n.next)
        else for i, e in ipairs(n.next) do e.when = t.when[i] end end
      end
    end
  end
  local ts = dofile(dir .. "sources.lua")
  for _, src in ipairs(sources) do
    if ts[src.id] then src.note = ts[src.id] else fail("%ssources.lua: no note for source '%s'", dir, src.id) end
  end
end

local SITE_TITLE = book.title
local AUTHOR     = book.author

---------------------------------------------------------------------------
-- Registry: every addressable article, which chapter it is in, in order
---------------------------------------------------------------------------
local registry, order = {}, {}
local function register(p)
  if registry[p.id] then fail("duplicate id '%s'", p.id) end
  registry[p.id] = p
end
for _, p in ipairs(pages) do
  if p.section then fail("page '%s': chapters are set in data/chapters.lua, remove its section", p.id) end
  if not ({ history = true, fiction = true, mixed = true })[p.kind] then fail("page '%s': kind must be history, fiction or mixed", p.id) end
  register(p)
end
for _, r in ipairs(runners) do
  register({ id = r.id, kind = "fiction", title = r.name, summary = (U.roles[r.role] or r.role) .. " — " .. r.occupation, runner = r })
  if not U.roles[r.role] then fail("character '%s': unknown role '%s'", r.id, tostring(r.role)) end
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

local handout_home, sources_home
for _, p in ipairs(pages) do
  if p.body == "@handouts" then handout_home = p end
  if p.body == "@sources" then sources_home = p end
end
for i, h in ipairs(handouts) do
  h.n = i
  if not handout_home then fail("handouts exist but no article has body \"@handouts\""); break end
  register({ id = h.id, kind = "fiction", title = string.format(B.handout, i) .. ": " .. h.title,
    summary = h.title, handout = h, file = handout_home.file, chapter = handout_home.chapter })
end
for _, h in ipairs(handouts) do
  if not registry[h.found] or registry[h.found].handout then fail("handout '%s' is found in unknown article '%s'", h.id, tostring(h.found)) end
end

---------------------------------------------------------------------------
-- Contributions (see book.lua)
---------------------------------------------------------------------------
local function templates_for(p)
  if p.handout or not book.open_contributions or not opts.contribute then return nil end
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
local function url_part(s) return (s:gsub("[^%w%-_.~]", function(c) return string.format("%%%02X", c:byte()) end)) end
local function contrib_url(page_id, seg)
  return string.format("%s?book=%s&amp;page=%s%s&amp;lang=%s", opts.contribute, url_part(book.id), url_part(page_id),
    seg and ("&amp;seg=" .. url_part(seg)) or "", LANG)
end

local source_index, source_used = {}, {}
for i, s in ipairs(sources) do
  if source_index[s.id] then fail("duplicate source id '%s'", s.id) end
  source_index[s.id] = i
end

---------------------------------------------------------------------------
-- Cyberpunk RED, grounded (chapter VIII)
---------------------------------------------------------------------------
local red = {}
local STATS = { "INT", "REF", "DEX", "TECH", "COOL", "WILL", "LUCK", "MOVE", "BODY", "EMP" }
local IS_STAT = {}
for _, k in ipairs(STATS) do IS_STAT[k] = true end

function red.hp(s) return 10 + 5 * math.ceil((s.BODY + s.WILL) / 2) end
function red.sw(s) return math.ceil(red.hp(s) / 2) end
function red.ds(s) return s.BODY end

local implant_by_id = {}
for _, im in ipairs(implants) do
  if implant_by_id[im.id] then fail("implants: duplicate id '%s'", im.id) end
  implant_by_id[im.id] = im
  if type(im.hl) ~= "number" or im.hl < 0 or im.hl > 14 then fail("implant '%s': fixed Humanity Loss must be 0–14", im.id) end
  if not U.owner[im.owner] then fail("implant '%s': unknown default owner '%s'", im.id, tostring(im.owner)) end
end

-- Humanity starts at EMP × 10 and loses each implant's fixed cost;
-- current EMP is Humanity ÷ 10, rounded down.
local function humanity(s, list, who)
  local h = s.EMP * 10
  for _, it in ipairs(list or {}) do
    local im = implant_by_id[it[1]]
    if not im then fail("%s: unknown implant '%s'", who, tostring(it[1]))
    else
      h = h - im.hl
      if it.owner and not U.owner[it.owner] then fail("%s: implant '%s' has unknown owner '%s'", who, it[1], it.owner) end
    end
  end
  return h, h // 10
end

local function check_stats(s, who, lo, hi)
  for _, k in ipairs(STATS) do
    local v = s[k]
    if type(v) ~= "number" or v < lo or v > hi then fail("%s: %s = %s is outside %d–%d", who, k, tostring(v), lo, hi) end
  end
  for k in pairs(s) do if not IS_STAT[k] then fail("%s: unknown stat '%s'", who, k) end end
end

for _, r in ipairs(runners) do
  local who = "character " .. r.id
  check_stats(r.stats, who, 2, 8)
  local sum = 0
  for _, k in ipairs(STATS) do sum = sum + (r.stats[k] or 0) end
  if sum ~= 62 then fail("%s: stats add up to %d, the Complete Package is 62", who, sum) end
  local spent = 0
  for _, sk in ipairs(r.skills) do
    local name, stat, lvl = sk[1], sk[2], sk[3]
    if not IS_STAT[stat] then fail("%s: skill '%s' uses unknown stat '%s'", who, name, tostring(stat)) end
    if type(lvl) ~= "number" or lvl < 1 or lvl > 6 then fail("%s: skill '%s' is level %s; at creation levels go 1–6", who, name, tostring(lvl)) end
    spent = spent + (sk.x2 and 2 or 1) * (lvl or 0)
  end
  if spent > 86 then fail("%s: %d skill points, the Complete Package gives 86", who, spent) end
  r.derived = { HP = red.hp(r.stats), SW = red.sw(r.stats), DS = red.ds(r.stats) }
  r.derived.HUM, r.derived.EMPNOW = humanity(r.stats, r.implants, who)
  for k, v in pairs(r.declared or {}) do
    if r.derived[k] ~= v then fail("%s: sheet says %s = %s but the rules give %s", who, k, tostring(v), tostring(r.derived[k])) end
  end
end

local npc_by_id, npc_shown = {}, {}
for _, n in ipairs(npcs) do
  npc_by_id[n.id] = n
  local who = "npc " .. n.id
  check_stats(n.stats, who, 2, 10)
  n.derived = { HP = red.hp(n.stats), SW = red.sw(n.stats), DS = red.ds(n.stats) }
  n.derived.HUM = humanity(n.stats, n.implants, who)
  for k, v in pairs(n.declared or {}) do
    if n.derived[k] ~= v then fail("%s: sheet says %s = %s but the rules give %s", who, k, tostring(v), tostring(n.derived[k])) end
  end
end

---------------------------------------------------------------------------
-- The opening adventure: every scene reachable, every path reaches an open
-- scene (or an ending, if one is ever written)
---------------------------------------------------------------------------
local nodes, node_of_page = {}, {}
for _, n in ipairs(flow.nodes) do
  if nodes[n.id] then fail("flow: duplicate scene '%s'", n.id) end
  nodes[n.id] = n
  if not registry[n.page] then fail("flow: scene '%s' points to unknown article '%s'", n.id, tostring(n.page)) end
  node_of_page[n.page] = n
end
local forward, backward = {}, {}
for _, n in ipairs(flow.nodes) do forward[n.id], backward[n.id] = {}, {} end
for _, n in ipairs(flow.nodes) do
  if not n.open and not n.ending and (not n.next or #n.next == 0) then
    fail("flow: scene '%s' is a dead end (no exits, not open, not an ending)", n.id)
  end
  for _, e in ipairs(n.next or {}) do
    if not nodes[e.to] then fail("flow: '%s' exits to unknown scene '%s'", n.id, e.to)
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
local depth = {}
do
  local queue = { flow.start }; depth[flow.start] = 0
  while #queue > 0 do
    local id = table.remove(queue, 1)
    for _, to in ipairs(forward[id] or {}) do
      if depth[to] == nil then depth[to] = depth[id] + 1; queue[#queue + 1] = to end
    end
  end
end
if not nodes[flow.start] then fail("flow: start scene '%s' does not exist", tostring(flow.start)) end
local reachable = reach(flow.start, function(id) return forward[id] or {} end)
local can_land = {}
local open_count = 0
for _, n in ipairs(flow.nodes) do
  if n.open or n.ending then
    open_count = open_count + 1
    for id in pairs(reach(n.id, function(x) return backward[x] or {} end)) do can_land[id] = true end
  end
end
for _, n in ipairs(flow.nodes) do
  if not reachable[n.id] then fail("flow: scene '%s' can never be reached", n.id) end
  if not can_land[n.id] then fail("flow: from scene '%s' no open scene can be reached", n.id) end
end

---------------------------------------------------------------------------
-- The board
---------------------------------------------------------------------------
local owner_of = {}
for _, e in ipairs(territories.estemps) do
  if owner_of[e.code] then fail("territories: letter '%s' used twice", e.code) end
  owner_of[e.code] = e
  for _, k in ipairs({ "color", "light", "dark" }) do
    if not tostring(e[k]):match("^#%x%x%x%x%x%x$") then fail("territories: %s.%s must be #rrggbb", e.id, k) end
  end
end
do
  local cells = {}
  for r, row in ipairs(worldgrid.rows) do
    if #row ~= worldgrid.cols then fail("worldgrid: row %d has %d pixels, expected %d", r, #row, worldgrid.cols) end
    for ch in row:gmatch(".") do
      if ch ~= "." and not owner_of[ch] then fail("worldgrid: letter '%s' has no owner in data/territories.lua", ch) end
      cells[ch] = (cells[ch] or 0) + 1
    end
  end
  for code, e in pairs(owner_of) do if not cells[code] then fail("territories: %s owns no pixel of the map", e.id) end end
  territories.cells = cells
end
local lat_min = worldgrid.lat0 - #worldgrid.rows * worldgrid.step
local function on_map(lon, lat) return lon >= worldgrid.lon0 and lon < worldgrid.lon0 + worldgrid.cols * worldgrid.step and lat <= worldgrid.lat0 and lat > lat_min end
for i, g in ipairs(territories.regests) do
  if g.n ~= i then fail("territories: REGEST #%d is numbered %s", i, tostring(g.n)) end
  if not on_map(g.lon, g.lat) then fail("territories: REGEST '%s' is off the map", g.id) end
  for _, l in ipairs(LANGS) do
    if not (g.country[l] and g.place[l]) then fail("territories: REGEST '%s' has no '%s' text", g.id, l) end
  end
end
for _, m in ipairs(territories.marks) do
  if not on_map(m.lon, m.lat) then fail("territories: landmark '%s' is off the map", m.id) end
  if not registry[m.page] then fail("territories: landmark '%s' points to unknown article '%s'", m.id, tostring(m.page)) end
end
local all_owners = {}
for _, e in ipairs(territories.estemps) do all_owners[#all_owners + 1] = e end
all_owners[#all_owners + 1] = territories.sea
for _, e in ipairs(all_owners) do
  if not registry[e.page] then fail("territories: %s points to unknown article '%s'", e.id, tostring(e.page)) end
  for _, l in ipairs(LANGS) do if not e.region[l] then fail("territories: %s has no '%s' region", e.id, l) end end
end

---------------------------------------------------------------------------
-- Timeline
---------------------------------------------------------------------------
for i, t in ipairs(timeline) do
  if t.kind == "history" and not t.source then fail("timeline #%d (%s) is history but has no source", i, t.year) end
  if t.kind == "fiction" and t.source then fail("timeline #%d (%s) is fiction but cites a source", i, t.year) end
  if t.source then
    if not source_index[t.source] then fail("timeline #%d cites unknown source '%s'", i, t.source)
    else source_used[t.source] = true end
  end
end

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
local function src_href(id, from)
  local f = registry[from]
  local file = sources_home and sources_home.file or ""
  return (f and f.file == file and "" or file) .. "#src-" .. id
end

local function inline(s, from, cited)
  s = esc(s)
  -- "a [[aegis-med]]" must not read "a A Aegis-Med": drop the title's own article
  s = s:gsub("(%f[%a][%a\195\128-\195\191]+ )%[%[([%w%-]+)%]%]", function(word, id)
    local t = registry[id] and registry[id].title
    if not t then return nil end
    local w = word:lower():gsub("%s+$", "")
    local lead, rest = t:match("^(%S+) (.+)$")
    if not lead then return nil end
    local ARTICLES = { the = true, o = true, a = true, os = true, as = true }
    local BEFORE = { the = true, o = true, a = true, os = true, as = true, no = true, na = true, nos = true, nas = true,
      ["do"] = true, da = true, dos = true, das = true, ao = true, aos = true, ["\195\160"] = true, ["\195\160s"] = true,
      pelo = true, pela = true, pelos = true, pelas = true, num = true, numa = true }
    if ARTICLES[lead:lower()] and BEFORE[w] then return word .. "[[" .. id .. "|" .. rest .. "]]" end
  end)
  s = s:gsub("%[%[([^%]|]+)|?([^%]]*)%]%]", function(id, label)
    local target = registry[id]
    if not target then fail("'%s' links to unknown article '%s'", from, id); return label ~= "" and label or id end
    if id ~= from and not target.handout then
      backlinks[id] = backlinks[id] or {}
      backlinks[id][from] = true
    end
    local text = label ~= "" and label or target.title:gsub("^%d+%. ", "")
    return string.format('<a class="xref%s" href="%s">%s</a>', target.handout and " xref-handout" or "", href(id, from), text)
  end)
  s = s:gsub("{{([%w%-]+)}}", function(id)
    local n = source_index[id]
    if not n then fail("'%s' cites unknown source '%s'", from, id); return "" end
    source_used[id] = true
    if cited then cited[id] = true end
    return string.format('<sup class="cite"><a href="%s" title="%s">[%d]</a></sup>', src_href(id, from), esc(sources[n].title), n)
  end)
  s = s:gsub("%*%*(.-)%*%*", "<strong>%1</strong>")
  s = s:gsub("%*(.-)%*", "<em>%1</em>")
  return s
end

local FONTS, FONTS_LINK
local special = {}   -- line directives (@board, @regests…), filled in below
local render_npc

local function blocks(text, from, cited, o)
  o = o or {}
  local out, para, list, rows = {}, {}, {}, {}
  local nh = 0
  local function flush()
    if #para > 0 then out[#out + 1] = "<p>" .. inline(table.concat(para, o.br and "\1" or " "), from, cited):gsub("\1", "<br>") .. "</p>"; para = {} end
    if #list > 0 then
      local items = {}
      for _, li in ipairs(list) do items[#items + 1] = "<li>" .. inline(li, from, cited) .. "</li>" end
      out[#out + 1] = "<ul>" .. table.concat(items) .. "</ul>"; list = {}
    end
    if #rows > 0 then
      local html = { '<div class="table-wrap"><table class="book-table">' }
      for i, r in ipairs(rows) do
        local cells, tag = {}, i == 1 and "th" or "td"
        for _, c in ipairs(r) do cells[#cells + 1] = string.format("<%s>%s</%s>", tag, inline(c, from, cited), tag) end
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
    elseif line:match("^@npc:") then
      flush()
      local id = line:match("^@npc:([%w%-]+)$")
      if not npc_by_id[id] then fail("'%s' shows unknown character '%s'", from, tostring(id))
      else out[#out + 1] = render_npc(npc_by_id[id], from, cited); npc_shown[id] = true end
    elseif line:match("^@%a+$") and special[line:sub(2)] then
      flush(); out[#out + 1] = special[line:sub(2)](from, cited)
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
      out[#out + 1] = string.format('<h3 id="%s">%s%s</h3>', anchor, inline(h, from, cited), seg_link)
    elseif line:sub(1, 2) == "- " then
      if #para > 0 or #rows > 0 then local l = list; list = {}; flush(); list = l end
      list[#list + 1] = line:sub(3)
    elseif line:sub(1, 2) == "> " then
      flush(); out[#out + 1] = "<blockquote>" .. inline(line:sub(3), from, cited) .. "</blockquote>"
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
local KIND_LABEL = T.kinds
local map = dofile("tools/map.lua")

special.board = function(from)
  return '<figure class="board-fig"><div class="board-scroll">' .. map.board(worldgrid, territories, LANG)
    .. '</div><figcaption>' .. U.map_caption .. ' <a class="map-full" href="mapa.html">' .. U.map_full .. '</a></figcaption></figure>'
end

-- the board alone, as wide as the screen
local function render_map_page()
  return string.format([[<!doctype html>
<html lang="%s"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>%s · %s</title>%s<link rel="stylesheet" href="style.css"></head>
<body class="map-page"><header class="topbar"><div class="topbar-left"><a class="brand" href="board.html#board"><span class="sigil" aria-hidden="true"></span> %s</a></div></header>
<main class="map-main"><div class="board-scroll">%s</div><p class="map-legend">%s</p></main></body></html>
]], T.html_lang, esc(U.map_title), esc(SITE_TITLE), FONTS_LINK, U.map_back, map.board(worldgrid, territories, LANG), U.map_caption)
end

special.estemps = function(from, cited)
  local rows = {}
  local total = 0
  for _, n in pairs(territories.cells) do total = total + n end
  for _, e in ipairs(all_owners) do
    local share = e == territories.sea and U.sea_region or e.region[LANG]
    rows[#rows + 1] = string.format('<tr><td><span class="swatch" style="--c:%s"></span>%s<span class="tier">%s</span></td><td>%s</td><td class="num">%d</td></tr>',
      e.color, inline("[[" .. e.page .. "|" .. e.name .. "]]", from, cited), U.tiers[e.tier], esc(share), e.armies)
  end
  return '<div class="table-wrap"><table class="book-table estemps"><thead><tr><th>' .. table.concat(U.estemps_head, "</th><th>")
    .. '</th></tr></thead><tbody>' .. table.concat(rows) .. "</tbody></table></div>"
end

special.regests = function(from, cited)
  local rows = {}
  for _, g in ipairs(territories.regests) do
    rows[#rows + 1] = string.format('<tr id="regest-%s"><td class="num">%d</td><td>%s</td><td>%s</td></tr>',
      g.id, g.n, esc(g.country[LANG]), esc(g.place[LANG]))
  end
  return '<div class="table-wrap"><table class="book-table regests"><thead><tr><th>' .. table.concat(U.regests_head, "</th><th>")
    .. '</th></tr></thead><tbody>' .. table.concat(rows) .. "</tbody></table></div>"
end

special.implants = function(from, cited)
  local rows = {}
  for _, im in ipairs(implants) do
    rows[#rows + 1] = string.format('<tr id="implant-%s"><td><strong>%s</strong></td><td class="num">%d</td><td class="num">%s</td><td>%s</td><td>%s</td><td>%s</td></tr>',
      im.id, esc(im.name), im.hl, esc(im.cost), esc(U.owner[im.owner]), im.tolerin and U.yes or U.no, inline(im.text, from, cited))
  end
  return '<div class="table-wrap"><table class="book-table implants"><thead><tr><th>' .. table.concat(U.implants_head, "</th><th>")
    .. '</th></tr></thead><tbody>' .. table.concat(rows) .. "</tbody></table></div>"
end

special.localmap = function()
  return '<figure class="board-fig local-fig"><div class="board-scroll">' .. dofile("tools/localmap.lua")(LANG)
    .. '</div><figcaption>' .. U.localmap_caption .. '</figcaption></figure>'
end

local function render_timeline(from, cited)
  local rows = {}
  for _, t in ipairs(timeline) do
    local cite = t.source and (" " .. inline("{{" .. t.source .. "}}", from, cited)) or ""
    rows[#rows + 1] = string.format(
      '<li class="tl tl-%s"><span class="tl-year">%s</span><span class="tag tag-%s">%s</span><p>%s%s</p></li>',
      t.kind, esc(t.year), t.kind, KIND_LABEL[t.kind], inline(t.text, from, cited), cite)
  end
  return '<p class="lede">' .. T.timeline_lede .. '</p><ol class="timeline">' .. table.concat(rows, "\n") .. "</ol>"
end

local function render_flow_svg(from)
  local rows, maxdepth = {}, 0
  for _, n in ipairs(flow.nodes) do
    local d = depth[n.id] or 0
    rows[d] = rows[d] or {}
    table.insert(rows[d], n)
    if d > maxdepth then maxdepth = d end
  end
  local W, BW, BH, RH, TOP = 800, 200, 46, 100, 20
  local pos = {}
  for d = 0, maxdepth do
    local r = rows[d] or {}
    local gap = W / (#r + 1)
    for i, n in ipairs(r) do pos[n.id] = { x = gap * i, y = TOP + d * RH } end
  end
  local H = TOP + maxdepth * RH + BH + 20
  local edges, boxes = {}, {}
  for _, n in ipairs(flow.nodes) do
    for _, e in ipairs(n.next or {}) do
      local a, b = pos[n.id], pos[e.to]
      if math.abs(a.y - b.y) < 1 then
        local dir = b.x > a.x and 1 or -1
        edges[#edges + 1] = string.format('<path d="M%.0f %.0f L%.0f %.0f" class="edge" marker-end="url(#arrow)"><title>%s</title></path>',
          a.x + dir * BW / 2, a.y + BH / 2, b.x - dir * (BW / 2 + 4), b.y + BH / 2, esc(e.when))
      else
        local y1, y2 = a.y + BH, b.y - 4
        local my = (y1 + y2) / 2
        edges[#edges + 1] = string.format('<path d="M%.0f %.0f C%.0f %.0f %.0f %.0f %.0f %.0f" class="edge" marker-end="url(#arrow)"><title>%s</title></path>',
          a.x, y1, a.x, my, b.x, my, b.x, y2, esc(e.when))
      end
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
    .. '<h3 id="' .. from .. '--scenes">' .. B.scenes .. '</h3><ol class="scene-list">' .. table.concat(items) .. "</ol>"
end

local function render_exits(n, from, cited)
  if not n.next or #n.next == 0 then
    return '<aside class="box box-open"><p class="box-label">' .. U.open_scene .. '</p><p>'
      .. (LANG == "en" and "This is where the written adventure stops. What happens next belongs to your table."
          or "Aqui termina a aventura escrita. O que acontece depois é da mesa de vocês.") .. "</p></aside>"
  end
  local exits = {}
  for _, e in ipairs(n.next) do
    local to = nodes[e.to]
    exits[#exits + 1] = string.format('<li><a href="%s">%s</a> <span class="when">— %s</span></li>',
      href(to.page, from), esc((registry[to.page].title:gsub("^%d+%. ", ""))), inline(e.when, from, cited))
  end
  return '<aside class="box box-exits"><p class="box-label">' .. B.exits .. '</p><ul class="exits">' .. table.concat(exits) .. "</ul></aside>"
end

local function render_sources()
  local items = {}
  for i, s in ipairs(sources) do
    items[#items + 1] = string.format('<li id="src-%s"><span class="src-n">[%d]</span><div><a href="%s" rel="noopener" target="_blank">%s</a><span class="src-pub">%s</span><p>%s</p></div></li>',
      s.id, i, esc(s.url), esc(s.title), esc(s.publisher), esc(s.note))
  end
  return '<p class="lede">' .. T.sources_lede .. '</p><ol class="sources">' .. table.concat(items, "\n") .. "</ol>"
end

local function render_handouts(from, cited)
  local out = {}
  for _, h in ipairs(handouts) do
    out[#out + 1] = string.format('<figure class="handout handout-%s" id="%s"><figcaption><span class="handout-n">%s</span> %s <span class="handout-found">%s %s</span></figcaption><div class="handout-paper">%s</div></figure>',
      h.style, h.id, string.format(B.handout, h.n), esc(h.title), B.found_in,
      inline("[[" .. h.found .. "]]", from, cited), blocks(h.text, h.id, cited, { br = true }))
  end
  return table.concat(out, "\n")
end

local function stat_grid(s)
  local cells = {}
  for _, k in ipairs(STATS) do
    cells[#cells + 1] = string.format('<div class="stat" title="%s"><span class="stat-k">%s</span><span class="stat-v">%d</span></div>', U.stat_names[k], U.stats[k], s[k])
  end
  return '<div class="stats stats-red">' .. table.concat(cells) .. "</div>"
end

local function implant_rows(list, from, cited)
  local rows = {}
  for _, it in ipairs(list or {}) do
    local im = implant_by_id[it[1]]
    if im then
      rows[#rows + 1] = string.format('<tr><td><a href="%s#implant-%s">%s</a></td><td>%s</td><td class="num">−%d</td></tr>',
        href("implants", from), im.id, esc(im.name), esc(U.owner[it.owner or im.owner]), im.hl)
    end
  end
  return rows
end

function render_npc(n, from, cited)
  local d = n.derived
  local der = {
    string.format('<span><b>%s</b> %d</span>', U.npc.hp, d.HP), string.format('<span><b>%s</b> %d</span>', U.npc.sw, d.SW),
    string.format('<span><b>%s</b> %d</span>', U.npc.ds, d.DS),
    string.format('<span><b>%s</b> %s %d · %s %d</span>', U.npc.armor, U.npc.head, n.armor.head, U.npc.body, n.armor.body),
  }
  local wp = {}
  for _, w in ipairs(n.weapons or {}) do
    wp[#wp + 1] = string.format('<li><strong>%s</strong> %s · %s %d%s</li>', esc(w[1]), esc(w[2]), U.rof, w[3], w.note and (" — " .. inline(w.note, from, cited)) or "")
  end
  local sk = {}
  for _, s in ipairs(n.skills or {}) do sk[#sk + 1] = esc(s[1]) .. " " .. s[2] end
  local im = {}
  for _, it in ipairs(n.implants or {}) do
    local x = implant_by_id[it[1]]
    if x then im[#im + 1] = string.format('<a href="%s#implant-%s">%s</a> (%s)', href("implants", from), x.id, esc(x.name), esc(U.owner[it.owner or x.owner])) end
  end
  return table.concat({
    string.format('<section class="statblock" id="npc-%s">', n.id),
    string.format('<header><h4>%s</h4><p>%s</p></header>', esc(n.name), esc(n.label)),
    '<div class="sb-chars">' .. stat_grid(n.stats) .. '</div>',
    '<p class="sb-derived">' .. table.concat(der) .. '</p>',
    #wp > 0 and string.format('<p class="sb-h">%s</p><ul class="sb-attacks">%s</ul>', U.npc.weapons, table.concat(wp)) or "",
    #sk > 0 and string.format('<p><b class="sb-k">%s</b> %s.</p>', U.npc.skills, table.concat(sk, ", ")) or "",
    #im > 0 and string.format('<p><b class="sb-k">%s</b> %s.</p>', U.npc.implants, table.concat(im, ", ")) or "",
    n.notes and string.format('<p><b class="sb-k">%s</b> %s</p>', U.npc.notes, inline(n.notes, from, cited)) or "",
    '</section>',
  })
end

local function render_runner(r, from, cited)
  local d = r.derived
  local function h3(n, text) return string.format('<h3 id="%s--%s">%s</h3>', from, n, text) end
  local der = {}
  for _, k in ipairs({ "HP", "SW", "DS", "HUM" }) do
    der[#der + 1] = string.format('<div class="derived"><span>%s</span><strong>%s</strong></div>', U.derived[k], tostring(d[k]))
  end
  der[#der + 1] = string.format('<div class="derived"><span>%s</span><strong>%d</strong></div>', U.derived.EMPNOW, d.EMPNOW)
  local skills = {}
  for _, s in ipairs(r.skills) do
    skills[#skills + 1] = string.format('<tr><td>%s</td><td>%s</td><td class="num">%d</td><td class="num"><strong>%d</strong></td></tr>',
      esc(s[1]), U.stats[s[2]] or s[2], s[3], (r.stats[s[2]] or 0) + s[3])
  end
  local imp = implant_rows(r.implants, from, cited)
  local wp = {}
  for _, w in ipairs(r.weapons or {}) do
    wp[#wp + 1] = string.format('<tr><td>%s</td><td>%s</td><td class="num">%d</td><td>%s</td></tr>', esc(w[1]), esc(w[2]), w[3], w.note and inline(w.note, from, cited) or "")
  end
  local rel = {}
  for _, id in ipairs(r.links or {}) do rel[#rel + 1] = inline("[[" .. id .. "]]", from, cited) end
  local function tbl(head, rows, cls) return '<div class="table-wrap"><table class="skills' .. (cls and (" " .. cls) or "") .. '"><thead><tr><th>' .. table.concat(head, "</th><th>") .. '</th></tr></thead><tbody>' .. table.concat(rows) .. "</tbody></table></div>" end
  return table.concat({
    string.format('<blockquote class="epigraph">“%s”</blockquote>', esc(r.quote)),
    h3("origin", U.sheet.origin) .. '<p>' .. inline(r.origin, from, cited) .. "</p>",
    h3("motivation", U.sheet.motivation) .. '<p>' .. inline(r.motivation, from, cited) .. "</p>",
    h3("hook", U.sheet.hook) .. '<p>' .. inline(r.hook, from, cited) .. "</p>",
    '<div class="sheet">',
    h3("stats", U.sheet.stats) .. '<p class="hint">' .. U.sheet.stats_hint .. '</p>',
    stat_grid(r.stats),
    '<div class="derived-row">' .. table.concat(der) .. "</div>",
    '<p class="hint">' .. U.sheet.derived_hint .. '</p>',
    h3("skills", U.sheet.skills) .. tbl(U.sheet.skills_head, skills),
    h3("implants", U.sheet.implants) .. (#imp > 0 and tbl(U.sheet.implants_head, imp) or ('<p>' .. U.sheet.no_implants .. '</p>')),
    h3("weapons", U.sheet.weapons) .. tbl(U.sheet.weapons_head, wp, "weapons"),
    string.format('<p><b class="sb-k">%s</b> %s %d · %s %d</p>', U.sheet.armor, U.sheet.head, r.armor.head, U.sheet.body, r.armor.body),
    h3("gear", U.sheet.gear) .. '<p>' .. esc(r.gear) .. "</p>",
    '</div>',
    #rel > 0 and (h3("threads", U.sheet.threads) .. '<ul class="pills"><li>' .. table.concat(rel, "</li><li>") .. "</li></ul>") or "",
  }, "\n")
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

FONTS = '<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
  .. '<link href="https://fonts.googleapis.com/css2?family=Pixelify+Sans:wght@500;700&family=Silkscreen:wght@400;700&family=IBM+Plex+Sans:ital,wght@0,400;0,600;1,400&family=IBM+Plex+Mono:wght@400;600&display=swap" rel="stylesheet">'

FONTS_LINK = FONTS
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
  local cited, toc = {}, {}
  local body
  if p.runner then body = render_runner(p.runner, p.id, cited)
  elseif p.body == "@timeline" then body = render_timeline(p.id, cited)
  elseif p.body == "@flow" then body = render_flow(p.id)
  elseif p.body == "@sources" then body = render_sources()
  elseif p.body == "@handouts" then body = render_handouts(p.id, cited)
  else body = blocks(p.body, p.id, cited, { toc = toc }) end
  if node_of_page[p.id] then body = body .. "\n" .. render_exits(node_of_page[p.id], p.id, cited) end
  return { page = p, body = body, cited = cited, toc = toc }
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
      bl[#bl + 1] = string.format('<a href="%s">%s</a>', href(q.id, p.id), esc((q.title:gsub("^%d+%. ", ""))))
    end
  end
  if #bl > 0 then foot[#foot + 1] = '<p class="see-also"><span>' .. B.see_also .. '</span> ' .. table.concat(bl, " · ") .. "</p>" end
  if templates_for(p) then foot[#foot + 1] = string.format('<a class="contrib-article" href="%s">%s</a>', contrib_url(p.id), B.contribute_article) end
  if #foot > 0 then parts[#parts + 1] = '<footer class="article-foot">' .. table.concat(foot) .. "</footer>" end
  parts[#parts + 1] = "</section>"
  return table.concat(parts, "\n")
end

local function render_chapter(ch, rendered)
  local cited = {}
  local arts, mini = {}, {}
  for _, id in ipairs(ch.pages) do
    local r = rendered[id]
    for k in pairs(r.cited) do cited[k] = true end
    arts[#arts + 1] = finish_article(r)
    mini[#mini + 1] = string.format('<li><a href="#%s">%s</a></li>', id, esc(registry[id].title))
  end
  local head = {
    '<header class="chapter-head">',
    string.format('<p class="chapter-n">%s</p>', esc(ch.label)),
    string.format('<h1>%s</h1>', esc(ch.title)),
    ch.epigraph and ('<p class="chapter-epigraph">' .. inline(ch.epigraph, ch.pages[1], cited) .. "</p>") or "",
    ch.intro and ('<div class="chapter-intro">' .. blocks(ch.intro, ch.pages[1], cited) .. "</div>") or "",
    #mini > 1 and ('<nav class="chapter-toc" aria-label="' .. B.in_chapter .. '"><span>' .. B.in_chapter .. '</span><ol>' .. table.concat(mini) .. "</ol></nav>") or "",
    '</header>',
  }
  local refs = {}
  for i, s in ipairs(sources) do
    if cited[s.id] and ch ~= (sources_home and sources_home.chapter) then
      refs[#refs + 1] = string.format('<li><span class="src-n">[%d]</span> <a href="%s" rel="noopener" target="_blank">%s</a> <span class="src-pub">— %s</span></li>',
        i, esc(s.url), esc(s.title), esc(s.publisher))
    end
  end
  local tail = {}
  if #refs > 0 then tail[#tail + 1] = '<aside class="refs"><h2 id="' .. ch.id .. '--refs">' .. B.refs_chapter .. '</h2><ul>' .. table.concat(refs) .. "</ul></aside>" end
  local prev, nxt = chapters[ch.index - 1], chapters[ch.index + 1]
  tail[#tail + 1] = string.format('<nav class="pager" aria-label="%s">%s%s</nav>', LANG == "pt" and "Navegação entre capítulos" or "Chapter navigation",
    prev and string.format('<a class="prev" href="%s"><span>%s</span>%s</a>', prev.file, esc(prev.label), esc(prev.title))
      or string.format('<a class="prev" href="index.html"><span>%s</span>%s</a>', T.previous, esc(B.contents)),
    nxt and string.format('<a class="next" href="%s"><span>%s</span>%s</a>', nxt.file, esc(nxt.label), esc(nxt.title)) or "<span></span>")
  return layout(ch.title .. " · " .. SITE_TITLE, ch.label .. " — " .. ch.title,
    table.concat(head, "\n") .. table.concat(arts, "\n") .. table.concat(tail, "\n"), ch.id)
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
  local first_scene = registry[nodes[flow.start].page]
  local content = table.concat({
    '<div class="cover">',
    '<img class="banner" src="banner.svg" width="192" height="72" alt="' .. esc(book.banner_alt or "") .. '">',
    '<p class="kicker">' .. esc(book.kicker or "") .. '</p>',
    '<h1 class="cover-title">' .. (book.cover_title or esc(book.title)) .. '</h1>',
    '<p class="cover-by">' .. esc(AUTHOR) .. '</p>',
    '<p class="cover-lede">' .. esc(book.blurb or "") .. '</p>',
    '<div class="cover-actions"><a class="btn" href="' .. chapters[1].file .. '">' .. U.start .. '</a>'
      .. '<a class="btn btn-ghost" href="' .. first_scene.file .. '">' .. U.play .. '</a></div>',
    '</div>',
    '<div class="front">',
    '<aside class="glance"><h2 id="glance">' .. B.glance.title .. '</h2><dl>' .. table.concat(glance) .. '</dl>'
      .. '<p class="legend">' .. T.cover.legend .. '</p></aside>',
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

for _, s in ipairs(sources) do
  if not source_used[s.id] then fail("source '%s' is listed but never cited", s.id) end
end
for _, n in ipairs(npcs) do
  if not npc_shown[n.id] then fail("character '%s' is never shown (add @npc:%s to an article)", n.id, n.id) end
end

if #errors > 0 then
  io.stderr:write("\nBuild failed — " .. #errors .. " problem(s):\n")
  for _, e in ipairs(errors) do io.stderr:write("  • " .. e .. "\n") end
  os.exit(1)
end

local reach_count = 0
for _ in pairs(reachable) do reach_count = reach_count + 1 end
print(string.format("✓ %d chapters, %d articles, %d handouts, %d sources, %d timeline entries", #chapters, #order, #handouts, #sources, #timeline))
print(string.format("✓ opening adventure: %d/%d scenes reachable, %d open, no dead ends", reach_count, #flow.nodes, open_count))
print(string.format("✓ %d characters and %d NPCs match the Cyberpunk RED rules in chapter VIII (%d implants)", #runners, #npcs, #implants))
print(string.format("✓ board: %d ESTEMPs + the sea, %d REGESTs, every pixel owned", #territories.estemps, #territories.regests))

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
local function write(name, s)
  local f = assert(io.open(OUT .. "/" .. name, "w")); f:write(s); f:close()
end
for _, ch in ipairs(chapters) do write(ch.file, chapter_html[ch.id]) end
write("index.html", index_html)
write("mapa.html", render_map_page())
write("style.css", assert(io.open("assets/style.css")):read("a"))
write(".nojekyll", "")
write("banner.svg", dofile("tools/banner.lua")(worldgrid, territories))
print("✓ wrote site to " .. OUT .. "/")
