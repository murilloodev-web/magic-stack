-- build.lua — turns the book's Lua data into a static website laid out like
-- an RPG book: a cover with the contents, then one page per chapter.
--
--   lua build.lua                      validate + build into docs/ (standalone)
--   lua build.lua --check              validate only
--   lua build.lua --lang pt            build the Portuguese edition (translations in data/pt/)
--   lua build.lua --out DIR --manifest FILE --shelf URL --contribute URL --lang L --langs en,pt
--                                      how the Magic Stack root build.lua calls it
--
-- Validation stops the build on: unknown internal links, unknown or unused
-- citations, character sheets that break the CoC 7e rules, timeline entries
-- without sources, unreachable or dead-end scenes, articles that are in no
-- chapter (or in two), and missing translations.

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

local chapters     = dofile("data/chapters.lua")
local pages        = dofile("data/pages.lua")
local investigators= dofile("data/investigators.lua")
local npcs         = dofile("data/npcs.lua")
local handouts     = dofile("data/handouts.lua")
local sources      = dofile("data/sources.lua")
local timeline     = dofile("data/timeline.lua")
local flow         = dofile("data/flow.lua")
local contact      = dofile("data/contact.lua")

---------------------------------------------------------------------------
-- Language: the story is written in book.lang; other editions overlay the
-- translations in data/<lang>/ and the build fails if any text is missing.
---------------------------------------------------------------------------
local LIB = opts.lib or "../../lib"
local BASE_LANG = book.lang or "en"
local LANG = opts.lang or BASE_LANG
local LANGS = {}
for l in (opts.langs or LANG):gmatch("[^,]+") do LANGS[#LANGS + 1] = l end
local T = assert(dofile(LIB .. "/book_strings.lua")[LANG], "no interface text for language " .. LANG)
local B = T.book
local i18n_errors = {}
local function missing(fmt, ...) i18n_errors[#i18n_errors + 1] = string.format(fmt, ...) end

if book.i18n and book.i18n[LANG] then
  for k, v in pairs(book.i18n[LANG]) do book[k] = v end
end
if LANG ~= BASE_LANG then
  local dir = "data/" .. LANG .. "/"
  local function by_id(file, list, what, apply)
    local tr = dofile(dir .. file)
    local known = {}
    for _, x in ipairs(list) do
      known[x.id] = true
      if not tr[x.id] then missing("%s%s: no translation for %s '%s'", dir, file, what, x.id) else apply(x, tr[x.id]) end
    end
    for id in pairs(tr) do if not known[id] then missing("%s%s: '%s' does not exist in the original", dir, file, id) end end
  end

  by_id("chapters.lua", chapters, "chapter", function(c, t)
    for _, k in ipairs({ "title", "epigraph", "intro" }) do
      if c[k] then if t[k] then c[k] = t[k] else missing("%schapters.lua: '%s' has no %s", dir, c.id, k) end end
    end
  end)

  by_id("pages.lua", pages, "page", function(p, t)
    if not t.title or not t.summary then missing("%spages.lua: '%s' needs title and summary", dir, p.id) end
    p.title, p.summary = t.title or p.title, t.summary or p.summary
    if p.body:sub(1, 1) ~= "@" then
      if not t.body then missing("%spages.lua: no body for page '%s'", dir, p.id) else p.body = t.body end
    end
  end)

  by_id("investigators.lua", investigators, "investigator", function(inv, t)
    for _, k in ipairs({ "role", "occupation", "quote", "motivation", "hook", "gear" }) do
      if t[k] then inv[k] = t[k] else missing("%sinvestigators.lua: '%s' has no %s", dir, inv.id, k) end
    end
    if not t.skills or #t.skills ~= #inv.skills then missing("%sinvestigators.lua: '%s' needs %d skill names", dir, inv.id, #inv.skills)
    else for i, name in ipairs(t.skills) do inv.skills[i] = { name, inv.skills[i][2] } end end
  end)

  by_id("npcs.lua", npcs, "character", function(n, t)
    for _, k in ipairs({ "name", "label", "armor", "notes", "spells" }) do
      if n[k] then if t[k] then n[k] = t[k] else missing("%snpcs.lua: '%s' has no %s", dir, n.id, k) end end
    end
    if not t.skills or #t.skills ~= #n.skills then missing("%snpcs.lua: '%s' needs %d skill names", dir, n.id, #n.skills)
    else for i, name in ipairs(t.skills) do n.skills[i] = { name, n.skills[i][2] } end end
    if not t.attacks or #t.attacks ~= #n.attacks then missing("%snpcs.lua: '%s' needs %d attacks", dir, n.id, #n.attacks)
    else for i, a in ipairs(t.attacks) do n.attacks[i] = { a[1], n.attacks[i][2], a[2] } end end
  end)

  by_id("handouts.lua", handouts, "handout", function(h, t)
    if not t.title or not t.text then missing("%shandouts.lua: '%s' needs title and text", dir, h.id) end
    h.title, h.text = t.title or h.title, t.text or h.text
  end)

  local tt = dofile(dir .. "timeline.lua")
  if #tt ~= #timeline then missing("%stimeline.lua: %d entries, the original has %d", dir, #tt, #timeline)
  else for i, t in ipairs(tt) do timeline[i].year, timeline[i].text = t.year or timeline[i].year, t.text end end

  local tf = dofile(dir .. "flow.lua")
  for _, n in ipairs(flow.nodes) do
    local t = tf[n.id]
    if not t then missing("%sflow.lua: no translation for scene '%s'", dir, n.id)
    else
      n.title = t.title or n.title
      if n.text then if t.text then n.text = t.text else missing("%sflow.lua: scene '%s' has no text", dir, n.id) end end
      if n.next and #n.next > 0 then
        if not t.when or #t.when ~= #n.next then missing("%sflow.lua: scene '%s' needs %d exit conditions", dir, n.id, #n.next)
        else for i, e in ipairs(n.next) do e.when = t.when[i] end end
      end
    end
  end

  local tc = dofile(dir .. "contact.lua")
  if #tc ~= #contact.tiers then missing("%scontact.lua: %d tiers, the original has %d", dir, #tc, #contact.tiers)
  else for i, t in ipairs(tc) do contact.tiers[i].name, contact.tiers[i].effect = t.name, t.effect end end

  local ts = dofile(dir .. "sources.lua")
  for _, src in ipairs(sources) do
    if ts[src.id] then src.note = ts[src.id] else missing("%ssources.lua: no note for source '%s'", dir, src.id) end
  end
end

local SITE_TITLE = book.title
local AUTHOR     = book.author

---------------------------------------------------------------------------
-- Error collection
---------------------------------------------------------------------------
local errors = i18n_errors
local function fail(fmt, ...) errors[#errors + 1] = string.format(fmt, ...) end

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
  register(p)
end
for _, inv in ipairs(investigators) do
  register({
    id = inv.id, kind = "fiction",
    title = inv.name, summary = inv.role .. " — " .. inv.occupation,
    investigator = inv,
  })
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

-- handouts live in the article that shows them (body "@handouts")
local handout_home
for _, p in ipairs(pages) do if p.body == "@handouts" then handout_home = p end end
for i, h in ipairs(handouts) do
  h.n = i
  if not handout_home then fail("handouts exist but no article has body \"@handouts\""); break end
  register({ id = h.id, kind = "fiction", title = string.format(B.handout, i) .. ": " .. h.title,
    summary = h.title, handout = h, file = handout_home.file, chapter = handout_home.chapter })
end
for _, h in ipairs(handouts) do
  if not registry[h.found] or registry[h.found].handout then fail("handout '%s' is found in unknown article '%s'", h.id, tostring(h.found)) end
end
local sources_home
for _, p in ipairs(pages) do if p.body == "@sources" then sources_home = p end end

---------------------------------------------------------------------------
-- Contributions: which form templates each article offers (see book.lua)
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
-- Call of Cthulhu 7e rules
---------------------------------------------------------------------------
local coc = {}

function coc.hp(c)  return (c.CON + c.SIZ) // 10 end
function coc.mp(c)  return c.POW // 5 end
function coc.san(c) return c.POW end

function coc.damage_bonus(c)
  local t = c.STR + c.SIZ
  if t <= 64  then return "−2", -2
  elseif t <= 84  then return "−1", -1
  elseif t <= 124 then return "0", 0
  elseif t <= 164 then return "+1D4", 1
  else return "+1D6", 2 end
end

function coc.move(c, age)
  local m = 8
  if c.DEX < c.SIZ and c.STR < c.SIZ then m = 7 elseif c.DEX > c.SIZ and c.STR > c.SIZ then m = 9 end
  if age and age >= 40 then m = m - math.min(5, (age - 30) // 10) end
  return m
end

function coc.split(v) return v, v // 2, v // 5 end  -- regular / hard / extreme

local CHARS = { "STR", "CON", "SIZ", "DEX", "APP", "INT", "POW", "EDU" }
for _, inv in ipairs(investigators) do
  local c = inv.characteristics
  for _, k in ipairs(CHARS) do
    local v = c[k]
    if type(v) ~= "number" or v < 15 or v > 90 then
      fail("%s: %s = %s is outside the 15–90 human range", inv.id, k, tostring(v))
    end
  end
  local derived = { HP = coc.hp(c), SAN = coc.san(c) }
  for k, v in pairs(inv.declared or {}) do
    if derived[k] ~= v then fail("%s: sheet says %s = %d but the rules give %d", inv.id, k, v, derived[k]) end
  end
end

local npc_by_id, npc_shown = {}, {}
for _, n in ipairs(npcs) do
  npc_by_id[n.id] = n
  local c = n.characteristics
  for _, k in ipairs(CHARS) do
    if type(c[k]) ~= "number" or c[k] < 15 or c[k] > 90 then fail("npc %s: %s = %s is outside the 15–90 human range", n.id, k, tostring(c[k])) end
  end
  local db, build = coc.damage_bonus(c)
  n.derived = { HP = coc.hp(c), MP = coc.mp(c), Move = coc.move(c, n.age), DB = db, Build = build }
  for k, v in pairs(n.declared or {}) do
    if n.derived[k] ~= v then fail("npc %s: sheet says %s = %s but the rules give %s", n.id, k, tostring(v), tostring(n.derived[k])) end
  end
end

---------------------------------------------------------------------------
-- Scenario graph checks
---------------------------------------------------------------------------
local nodes, node_of_page = {}, {}
for _, n in ipairs(flow.nodes) do
  if nodes[n.id] then fail("flow: duplicate scene '%s'", n.id) end
  nodes[n.id] = n
  if n.page and not registry[n.page] then fail("flow: scene '%s' points to unknown article '%s'", n.id, n.page) end
  if n.page and not n.ending then node_of_page[n.page] = n end
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

local forward, backward = {}, {}
for _, n in ipairs(flow.nodes) do forward[n.id], backward[n.id] = {}, {} end
for _, n in ipairs(flow.nodes) do
  if not n.ending and (not n.next or #n.next == 0) then
    fail("flow: scene '%s' is a dead end (no exits and not an ending)", n.id)
  end
  for _, e in ipairs(n.next or {}) do
    if not nodes[e.to] then fail("flow: '%s' exits to unknown scene '%s'", n.id, e.to)
    else
      table.insert(forward[n.id], e.to)
      table.insert(backward[e.to], n.id)
    end
  end
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

local reachable = reach(flow.start, function(id) return forward[id] or {} end)
local can_finish = {}
for _, n in ipairs(flow.nodes) do
  if n.ending then
    for id in pairs(reach(n.id, function(x) return backward[x] or {} end)) do can_finish[id] = true end
  end
end
local ending_count = 0
for _, n in ipairs(flow.nodes) do
  if n.ending then ending_count = ending_count + 1 end
  if not reachable[n.id] then fail("flow: scene '%s' can never be reached", n.id) end
  if not can_finish[n.id] then fail("flow: from scene '%s' no ending can be reached", n.id) end
end

---------------------------------------------------------------------------
-- Mist Contact track: tiers must cover 0..max exactly once
---------------------------------------------------------------------------
do
  local expect = 0
  for _, t in ipairs(contact.tiers) do
    if t.from ~= expect then fail("contact: tier '%s' starts at %d, expected %d (gap or overlap)", t.name, t.from, expect) end
    if t.to < t.from then fail("contact: tier '%s' ends before it starts", t.name) end
    expect = t.to + 1
  end
  if expect - 1 ~= contact.max then fail("contact: tiers stop at %d but max is %d", expect - 1, contact.max) end
end

---------------------------------------------------------------------------
-- Timeline checks
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
local backlinks = {}   -- target id -> { [source article id] = true }

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

-- where an article lives, seen from article `from`: "#id" on the same page
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

-- inline markup; `from` is the article doing the linking
local function inline(s, from, cited)
  s = esc(s)
  -- "the [[castelinho]]" should read "the Castelinho", not "the The Castelinho";
  -- likewise "no [[winter-festival]]" reads "no Festival de Inverno" in Portuguese
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
    -- scene titles carry their number ("1. Arrival"); drop it inside a sentence
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
  s = s:gsub("%(History → Fiction%)", '<span class="tag tag-mixed">History → Fiction</span>')
  s = s:gsub("%(História → Ficção%)", '<span class="tag tag-mixed">História → Ficção</span>')
  s = s:gsub("%(Fiction%)", '<span class="tag tag-fiction">Fiction</span>')
  s = s:gsub("%(Ficção%)", '<span class="tag tag-fiction">Ficção</span>')
  s = s:gsub("%(History%)", '<span class="tag tag-history">History</span>')
  s = s:gsub("%(História%)", '<span class="tag tag-history">História</span>')
  return s
end

local render_npc   -- defined below; @npc:<id> lines call it

-- block markup. opts.br keeps line breaks inside paragraphs (handouts);
-- opts.toc collects the article's "## " headings; their anchors are
-- "<article>--<n>", the same in every language.
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
      if not B.boxes[box] then fail("'%s': unknown box '::: %s' (read, keeper, history)", from, box) end
      out[#out + 1] = string.format('<aside class="box box-%s"><p class="box-label">%s</p>', box, B.boxes[box] or box)
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
      local clean = h:gsub("%*", ""):gsub("%b()", ""):gsub("%s+$", "")
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
-- Special bodies
---------------------------------------------------------------------------
local KIND_LABEL = T.kinds

local function render_timeline(from, cited)
  local rows = {}
  for _, t in ipairs(timeline) do
    local cite = t.source and (" " .. inline("{{" .. t.source .. "}}", from, cited)) or ""
    rows[#rows + 1] = string.format(
      '<li class="tl tl-%s"><span class="tl-year">%s</span><span class="tag tag-%s">%s</span><p>%s%s</p></li>',
      t.kind, esc(t.year), t.kind, KIND_LABEL[t.kind], inline(t.text, from, cited), cite)
  end
  return '<p class="lede">' .. T.timeline_lede .. '</p>'
    .. '<ol class="timeline">' .. table.concat(rows, "\n") .. "</ol>"
end

local function render_flow_svg(from)
  -- lay scenes out in rows by BFS depth from the start scene
  local rows, maxdepth = {}, 0
  for _, n in ipairs(flow.nodes) do
    local d = depth[n.id] or 0
    rows[d] = rows[d] or {}
    table.insert(rows[d], n)
    if d > maxdepth then maxdepth = d end
  end
  local W, BW, BH, RH, TOP = 800, 186, 46, 104, 20
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
      if a and b then
        if math.abs(a.y - b.y) < 1 then
          local dir = b.x > a.x and 1 or -1
          edges[#edges + 1] = string.format(
            '<path d="M%.0f %.0f L%.0f %.0f" class="edge" marker-end="url(#arrow)"><title>%s</title></path>',
            a.x + dir * BW / 2, a.y + BH / 2, b.x - dir * (BW / 2 + 4), b.y + BH / 2, esc(e.when))
        else
          local y1, y2 = a.y + BH, b.y - 4
          local my = (y1 + y2) / 2
          edges[#edges + 1] = string.format(
            '<path d="M%.0f %.0f C%.0f %.0f %.0f %.0f %.0f %.0f" class="edge" marker-end="url(#arrow)"><title>%s</title></path>',
            a.x, y1, a.x, my, b.x, my, b.x, y2, esc(e.when))
        end
      end
    end
    local p = pos[n.id]
    local label = n.title:gsub(" — .*", "")
    boxes[#boxes + 1] = string.format(
      '<a href="%s"><rect x="%.0f" y="%.0f" width="%d" height="%d" rx="6" class="node%s"/>'
      .. '<text x="%.0f" y="%.0f" class="node-label">%s</text></a>',
      href(n.page, from), p.x - BW / 2, p.y, BW, BH, n.ending and " node-end" or "",
      p.x, p.y + BH / 2 + 5, esc(n.ending and (n.title:match("^(.-)%s+—") or label) or label))
  end
  return string.format(
    '<figure class="flow"><svg viewBox="0 0 %d %d" role="img" aria-label="' .. T.flow_aria .. '">'
    .. '<defs><marker id="arrow" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">'
    .. '<path d="M0 0 L10 5 L0 10 z" class="arrowhead"/></marker></defs>%s%s</svg>'
    .. '<figcaption>' .. T.flow_caption .. '</figcaption></figure>',
    W, H, table.concat(edges), table.concat(boxes))
end

local function render_flow(from, cited)
  local items = {}
  for _, n in ipairs(flow.nodes) do
    if not n.ending then
      local p = registry[n.page]
      items[#items + 1] = string.format('<li><a href="%s">%s</a><span>%s</span></li>', href(n.page, from), esc(p.title), esc(p.summary or ""))
    end
  end
  return string.format('<p class="lede">' .. T.flow_lede .. '</p>', #flow.nodes - ending_count, ending_count)
    .. render_flow_svg(from)
    .. '<h3 id="' .. from .. '--scenes">' .. B.scenes .. '</h3><ol class="scene-list">' .. table.concat(items) .. "</ol>"
end

-- "Where this scene leads", from the scenario graph
local function render_exits(n, from, cited)
  local exits = {}
  for _, e in ipairs(n.next or {}) do
    local to = nodes[e.to]
    exits[#exits + 1] = string.format('<li><a href="%s">%s</a> <span class="when">— %s</span></li>',
      href(to.page, from), esc((registry[to.page].title:gsub("^%d+%. ", ""))), inline(e.when, from, cited))
  end
  return '<aside class="box box-exits"><p class="box-label">' .. B.exits .. '</p><ul class="exits">' .. table.concat(exits) .. "</ul></aside>"
end

local function render_contact()
  local rows = {}
  for _, t in ipairs(contact.tiers) do
    local range = t.from == t.to and tostring(t.from) or (t.from .. "–" .. t.to)
    local pips = {}
    for i = 1, contact.max do
      pips[#pips + 1] = string.format('<i class="pip%s"></i>', (i >= t.from and i <= t.to) and " on" or "")
    end
    rows[#rows + 1] = string.format(
      '<tr><td class="c-range">%s</td><td><strong>%s</strong><span class="pips" aria-hidden="true">%s</span><p>%s</p></td></tr>',
      range, esc(t.name), table.concat(pips), esc(t.effect))
  end
  return '<div class="table-wrap"><table class="contact"><thead><tr><th>' .. T.contact_head[1] .. '</th><th>' .. T.contact_head[2] .. '</th></tr></thead><tbody>'
    .. table.concat(rows) .. "</tbody></table></div>"
end

local function render_sources()
  local items = {}
  for i, s in ipairs(sources) do
    items[#items + 1] = string.format(
      '<li id="src-%s"><span class="src-n">[%d]</span><div><a href="%s" rel="noopener" target="_blank">%s</a>'
      .. '<span class="src-pub">%s</span><p>%s</p></div></li>',
      s.id, i, esc(s.url), esc(s.title), esc(s.publisher), esc(s.note))
  end
  return '<p class="lede">' .. T.sources_lede .. '</p>'
    .. '<ol class="sources">' .. table.concat(items, "\n") .. "</ol>"
end

local function render_handouts(from, cited)
  local out = {}
  for _, h in ipairs(handouts) do
    out[#out + 1] = string.format(
      '<figure class="handout handout-%s" id="%s"><figcaption><span class="handout-n">%s</span> %s <span class="handout-found">%s %s</span></figcaption><div class="handout-paper">%s</div></figure>',
      h.style, h.id, string.format(B.handout, h.n), esc(h.title), B.found_in,
      inline("[[" .. h.found .. "]]", from, cited), blocks(h.text, h.id, cited, { br = true }))
  end
  return table.concat(out, "\n")
end

function render_npc(n, from, cited)
  local c = n.characteristics
  local chars = {}
  for _, k in ipairs(CHARS) do
    chars[#chars + 1] = string.format('<div class="stat"><span class="stat-k">%s</span><span class="stat-v">%d</span></div>', T.inv.chars[k], c[k])
  end
  local der = {}
  for _, k in ipairs({ "HP", "MP", "Move", "DB", "Build" }) do
    der[#der + 1] = string.format('<span><b>%s</b> %s</span>', B.npc.derived[k], tostring(n.derived[k]))
  end
  der[#der + 1] = string.format('<span><b>%s</b> %s</span>', B.npc.sanity, tostring(n.sanity))
  der[#der + 1] = string.format('<span class="npc-contact"><b>%s</b> %s</span>', B.npc.contact, tostring(n.contact))
  local atk = {}
  for _, a in ipairs(n.attacks) do
    atk[#atk + 1] = string.format('<li><strong>%s</strong> %d%% (%d/%d), %s</li>', esc(a[1]), a[2], a[2] // 2, a[2] // 5, inline(a[3], from, cited))
  end
  atk[#atk + 1] = string.format('<li><strong>%s</strong> %d%% (%d/%d)</li>', B.npc.dodge, n.dodge, n.dodge // 2, n.dodge // 5)
  local sk = {}
  for _, s in ipairs(n.skills) do sk[#sk + 1] = esc(s[1]) .. " " .. s[2] .. "%" end
  return table.concat({
    string.format('<section class="statblock" id="npc-%s">', n.id),
    string.format('<header><h4>%s</h4><p>%s</p></header>', esc(n.name), esc(n.label)),
    '<div class="sb-chars">' .. table.concat(chars) .. '</div>',
    '<p class="sb-derived">' .. table.concat(der) .. '</p>',
    string.format('<p class="sb-h">%s <span>%s</span></p><ul class="sb-attacks">%s</ul>', B.npc.attacks, B.npc.attacks_hint, table.concat(atk)),
    string.format('<p><b class="sb-k">%s</b> %s.</p>', B.npc.skills, table.concat(sk, ", ")),
    string.format('<p><b class="sb-k">%s</b> %s</p>', B.npc.armor, esc(n.armor)),
    n.spells and string.format('<p><b class="sb-k">%s</b> %s</p>', B.npc.spells, inline(n.spells, from, cited)) or "",
    n.notes and string.format('<p><b class="sb-k">%s</b> %s</p>', B.npc.notes, inline(n.notes, from, cited)) or "",
    '</section>',
  })
end

local function render_investigator(inv, from, cited)
  local c = inv.characteristics
  local chars = {}
  for _, k in ipairs(CHARS) do
    local r, h, x = coc.split(c[k])
    chars[#chars + 1] = string.format('<div class="stat"><span class="stat-k">%s</span><span class="stat-v">%d</span><span class="stat-hx">%d / %d</span></div>', T.inv.chars[k], r, h, x)
  end
  local db, build = coc.damage_bonus(c)
  if db == "0" then db = T.inv.none end
  local derived = {
    { T.inv.derived[1], coc.hp(c) }, { T.inv.derived[2], coc.san(c) }, { T.inv.derived[3], coc.mp(c) },
    { T.inv.derived[4], coc.move(c) }, { T.inv.derived[5], db }, { T.inv.derived[6], build },
  }
  local der = {}
  for _, d in ipairs(derived) do
    der[#der + 1] = string.format('<div class="derived"><span>%s</span><strong>%s</strong></div>', d[1], tostring(d[2]))
  end
  local skills = {}
  for _, s in ipairs(inv.skills) do
    local r, h, x = coc.split(s[2])
    skills[#skills + 1] = string.format('<tr><td>%s</td><td>%d%%</td><td>%d</td><td>%d</td></tr>', esc(s[1]), r, h, x)
  end
  local rel = {}
  for _, id in ipairs(inv.links or {}) do rel[#rel + 1] = inline("[[" .. id .. "]]", from, cited) end
  local function h3(n, text) return string.format('<h3 id="%s--%s">%s</h3>', from, n, text) end
  return table.concat({
    string.format('<blockquote class="epigraph">“%s”</blockquote>', esc(inv.quote)),
    string.format('<p class="occupation">%s</p>', esc(inv.occupation)),
    h3("motivation", T.inv.motivation) .. '<p>' .. inline(inv.motivation, from, cited) .. "</p>",
    h3("hook", T.inv.hook) .. '<p>' .. inline(inv.hook, from, cited) .. "</p>",
    '<div class="sheet">',
    h3("characteristics", T.inv.characteristics) .. '<p class="hint">' .. T.inv.char_hint .. '</p>',
    '<div class="stats">' .. table.concat(chars) .. "</div>",
    '<div class="derived-row">' .. table.concat(der) .. "</div>",
    '<p class="hint">' .. T.inv.derived_hint .. '</p>',
    h3("skills", T.inv.skills) .. '<div class="table-wrap"><table class="skills"><thead><tr><th>'
      .. table.concat(T.inv.skills_head, "</th><th>") .. '</th></tr></thead><tbody>'
      .. table.concat(skills) .. "</tbody></table></div>",
    h3("gear", T.inv.gear) .. '<p>' .. esc(inv.gear) .. "</p>",
    '</div>',
    h3("threads", T.inv.threads) .. '<ul class="pills"><li>' .. table.concat(rel, "</li><li>") .. "</li></ul>",
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
      for _, id in ipairs(ch.pages) do
        items[#items + 1] = string.format('<li><a href="#%s">%s</a></li>', id, esc(registry[id].title))
      end
    end
    out[#out + 1] = string.format('<div class="nav-ch%s"><a href="%s"%s><span class="nav-n">%s</span>%s</a>%s</div>',
      here and " is-here" or "", ch.file, here and ' aria-current="page"' or "", esc(ch.n), esc(ch.title),
      #items > 0 and ("<ul>" .. table.concat(items) .. "</ul>") or "")
  end
  return table.concat(out)
end

local FONTS = '<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
  .. '<link href="https://fonts.googleapis.com/css2?family=Pirata+One&family=Silkscreen:wght@400;700&family=EB+Garamond:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">'

-- The language switch: the same page in every edition, top right of the bar.
-- Anchors are article ids, the same in every language, so the hash is kept.
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
  // language switch: same chapter, same place on the page
  document.querySelectorAll('[data-set-lang]').forEach(a=>a.addEventListener('click',e=>{
    try{localStorage.setItem('ms-lang',a.dataset.setLang)}catch(_){}
    let h=location.hash;
    if(!h){const s=[...document.querySelectorAll('.article[id]')].filter(x=>x.getBoundingClientRect().top<120).pop();if(s)h='#'+s.id}
    if(h){e.preventDefault();location.href=a.getAttribute('href')+h}
  }));
  // highlight the article being read in the chapter's contents
  const links=[...n.querySelectorAll('.nav-ch.is-here li a')];
  if(links.length&&'IntersectionObserver'in window){
    const io=new IntersectionObserver(es=>es.forEach(x=>{if(x.isIntersecting){links.forEach(l=>l.classList.toggle('on',l.getAttribute('href')==='#'+x.target.id))}}),{rootMargin:'-20%% 0px -70%% 0px'});
    document.querySelectorAll('.article[id]').forEach(s=>io.observe(s));
  }
</script>
</body>
</html>
]], T.html_lang, esc(title), esc(desc or book.blurb or ""),
    FONTS, T.skip,
    opts.shelf and string.format('<a class="shelf-link" href="%s" title="%s">%s</a>', opts.shelf, esc(T.shelf_title), T.shelf) or "",
    esc(SITE_TITLE), T.contents, lang_switch(current), esc(T.nav_label), nav_html(current), content,
    string.format(T.footer, esc(SITE_TITLE), esc(AUTHOR)))
end

-- one article: its body plus what was cited and its sub-headings
local function render_article(p)
  local cited, toc = {}, {}
  local body
  if p.investigator then body = render_investigator(p.investigator, p.id, cited)
  elseif p.body == "@timeline" then body = render_timeline(p.id, cited)
  elseif p.body == "@flow" then body = render_flow(p.id, cited)
  elseif p.body == "@sources" then body = render_sources()
  elseif p.body == "@handouts" then body = render_handouts(p.id, cited)
  else
    body = blocks(p.body, p.id, cited, { toc = toc })
    body = body:gsub("<p>@contact</p>", function() return render_contact() end)
  end
  if node_of_page[p.id] then body = body .. "\n" .. render_exits(node_of_page[p.id], p.id, cited) end
  return { page = p, body = body, cited = cited, toc = toc }
end

local function finish_article(r)
  local p = r.page
  local parts = {
    string.format('<section class="article article-%s" id="%s">', p.kind, p.id),
    string.format('<header class="article-head"><h2>%s</h2><p class="meta"><span class="tag tag-%s">%s</span> <span class="summary">%s</span></p></header>',
      esc(p.title), p.kind, KIND_LABEL[p.kind], esc(p.summary or "")),
    '<div class="prose">' .. r.body .. "</div>",
  }
  local foot = {}
  local bl = {}
  for _, q in ipairs(order) do
    if backlinks[p.id] and backlinks[p.id][q.id] and q.file ~= p.file then
      bl[#bl + 1] = string.format('<a href="%s">%s</a>', href(q.id, p.id), esc((q.title:gsub("^%d+%. ", ""))))
    end
  end
  if #bl > 0 then foot[#foot + 1] = '<p class="see-also"><span>' .. B.see_also .. '</span> ' .. table.concat(bl, " · ") .. "</p>" end
  if templates_for(p) then
    foot[#foot + 1] = string.format('<a class="contrib-article" href="%s">%s</a>', contrib_url(p.id), B.contribute_article)
  end
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
    for _, id in ipairs(ch.pages) do
      items[#items + 1] = string.format('<li><a href="%s#%s">%s</a></li>', ch.file, id, esc(registry[id].title))
    end
    toc[#toc + 1] = string.format('<li class="toc-ch"><a class="toc-ch-title" href="%s"><span class="toc-n">%s</span>%s</a><ul>%s</ul></li>',
      ch.file, esc(ch.n), esc(ch.title), table.concat(items))
  end
  local glance = {}
  for _, r in ipairs(B.glance.rows) do glance[#glance + 1] = string.format("<dt>%s</dt><dd>%s</dd>", r[1], r[2]) end
  local first_scene = registry[flow.nodes[1].page]
  local content = table.concat({
    '<div class="cover">',
    '<img class="banner" src="banner.svg" width="192" height="72" alt="' .. esc(book.banner_alt or "") .. '">',
    '<p class="kicker">' .. esc(book.kicker or "") .. '</p>',
    '<h1 class="cover-title">' .. (book.cover_title or esc(book.title)) .. '</h1>',
    '<p class="cover-by">' .. esc(AUTHOR) .. '</p>',
    '<p class="cover-lede">' .. esc(book.blurb or "") .. '</p>',
    '<div class="cover-actions"><a class="btn" href="' .. chapters[1].file .. '">' .. B.start .. '</a>'
      .. '<a class="btn btn-ghost" href="' .. first_scene.file .. '">' .. B.play .. '</a></div>',
    '</div>',
    '<div class="front">',
    '<aside class="glance"><h2 id="glance">' .. B.glance.title .. '</h2><dl>' .. table.concat(glance) .. '</dl>'
      .. '<p class="legend">' .. T.cover.legend .. '</p></aside>',
    '<nav class="toc" aria-label="' .. esc(B.contents) .. '"><h2 id="contents">' .. B.contents .. '</h2><ol>' .. table.concat(toc) .. '</ol></nav>',
    '</div>',
  }, "\n")
  return layout(SITE_TITLE .. T.cover.title_suffix, book.blurb, content, "index")
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
print(string.format("✓ scenario graph: %d/%d scenes reachable, %d endings, no dead ends", reach_count, #flow.nodes, ending_count))
print(string.format("✓ %d investigator sheets and %d Keeper characters match CoC 7e derived-stat rules", #investigators, #npcs))
print(string.format("✓ mist contact track: %d tiers cover 0–%d with no gaps", #contact.tiers, contact.max))

-- Manifest for the Magic Stack root build: articles, chapters, segments and forms.
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
local css = assert(io.open("assets/style.css")):read("a")
write("style.css", css)
write(".nojekyll", "")
write("banner.svg", dofile("tools/banner.lua").svg())
print("✓ wrote site to " .. OUT .. "/")
