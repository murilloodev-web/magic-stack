-- build.lua — turns the grimoire's Lua data into a static website.
--
--   lua build.lua                      validate + build into docs/ (standalone)
--   lua build.lua --check              validate only
--   lua build.lua --lang pt            build the Portuguese edition (translations in data/pt/)
--   lua build.lua --out DIR --manifest FILE --shelf URL --contribute URL --lang L --langs en,pt
--                                      how the Magic Stack root build.lua calls it
--
-- Validation stops the build on: unknown internal links, unknown or unused
-- citations, investigator sheets that break the CoC 7e rules, timeline
-- entries without sources, and unreachable or dead-end scenes.

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

local pages        = dofile("data/pages.lua")
local investigators= dofile("data/investigators.lua")
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
local i18n_errors = {}
local function missing(fmt, ...) i18n_errors[#i18n_errors + 1] = string.format(fmt, ...) end

if book.i18n and book.i18n[LANG] then
  for k, v in pairs(book.i18n[LANG]) do book[k] = v end
end
if LANG ~= BASE_LANG then
  local dir = "data/" .. LANG .. "/"
  local tp = dofile(dir .. "pages.lua")
  local known = {}
  for _, p in ipairs(pages) do
    known[p.id] = true
    local t = tp[p.id]
    if not t then missing("%spages.lua: no translation for page '%s'", dir, p.id)
    else
      if not t.title or not t.summary then missing("%spages.lua: '%s' needs title and summary", dir, p.id) end
      p.title, p.summary = t.title or p.title, t.summary or p.summary
      if p.body:sub(1, 1) ~= "@" then
        if not t.body then missing("%spages.lua: no body for page '%s'", dir, p.id) else p.body = t.body end
      end
    end
  end
  for id in pairs(tp) do if not known[id] then missing("%spages.lua: page '%s' does not exist in the original", dir, id) end end

  local ti = dofile(dir .. "investigators.lua")
  for _, inv in ipairs(investigators) do
    local t = ti[inv.id]
    if not t then missing("%sinvestigators.lua: no translation for '%s'", dir, inv.id)
    else
      for _, k in ipairs({ "role", "occupation", "quote", "motivation", "hook", "gear" }) do
        if t[k] then inv[k] = t[k] else missing("%sinvestigators.lua: '%s' has no %s", dir, inv.id, k) end
      end
      if not t.skills or #t.skills ~= #inv.skills then missing("%sinvestigators.lua: '%s' needs %d skill names", dir, inv.id, #inv.skills)
      else for i, name in ipairs(t.skills) do inv.skills[i] = { name, inv.skills[i][2] } end end
    end
  end

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
-- Registry: every addressable page, in reading order
---------------------------------------------------------------------------
local registry, order = {}, {}
local SECTION_ORDER = { "The Scenario", "Places", "The Mythos", "Factions",
                        "Investigators", "Endings", "Reference" }

local function register(p)
  if registry[p.id] then fail("duplicate page id '%s'", p.id) end
  registry[p.id] = p
end

for _, p in ipairs(pages) do register(p) end
for _, inv in ipairs(investigators) do
  register({
    id = inv.id, section = "Investigators", kind = "fiction",
    title = inv.name, summary = inv.role .. " — " .. inv.occupation,
    investigator = inv,
  })
end

for _, section in ipairs(SECTION_ORDER) do
  for _, p in ipairs(pages) do
    if p.section == section then order[#order + 1] = registry[p.id] end
  end
  if section == "Investigators" then
    for _, inv in ipairs(investigators) do order[#order + 1] = registry[inv.id] end
  end
end
for _, p in ipairs(pages) do
  local known = false
  for _, s in ipairs(SECTION_ORDER) do if s == p.section then known = true end end
  if not known then fail("page '%s' has unknown section '%s'", p.id, tostring(p.section)) end
end

---------------------------------------------------------------------------
-- Contributions: which form templates each page offers (see book.lua)
---------------------------------------------------------------------------
local function templates_for(p)
  if not book.open_contributions or not opts.contribute then return nil end
  local c = book.contrib or {}
  local t = (c.pages or {})[p.id]
  if t == false then return nil end
  t = t or (c.sections or {})[p.section]
  if t and #t > 0 then return t end
end
for id in pairs((book.contrib or {}).pages or {}) do
  if not registry[id] then fail("book.lua: contrib.pages names unknown page '%s'", id) end
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
  elseif t <= 124 then return T.inv.none, 0
  elseif t <= 164 then return "+1D4", 1
  else return "+1D6", 2 end
end

function coc.move(c)
  if c.DEX < c.SIZ and c.STR < c.SIZ then return 7 end
  if c.DEX > c.SIZ and c.STR > c.SIZ then return 9 end
  return 8
end

function coc.split(v) return v, v // 2, v // 5 end  -- regular / hard / extreme

for _, inv in ipairs(investigators) do
  local c = inv.characteristics
  for _, k in ipairs({ "STR", "CON", "SIZ", "DEX", "APP", "INT", "POW", "EDU" }) do
    local v = c[k]
    if type(v) ~= "number" or v < 15 or v > 90 then
      fail("%s: %s = %s is outside the 15–90 human range", inv.id, k, tostring(v))
    end
  end
  local derived = { HP = coc.hp(c), SAN = coc.san(c) }
  for k, v in pairs(inv.declared or {}) do
    if derived[k] ~= v then
      fail("%s: sheet says %s = %d but the rules give %d", inv.id, k, v, derived[k])
    end
  end
end

---------------------------------------------------------------------------
-- Scenario graph checks
---------------------------------------------------------------------------
local nodes = {}
for _, n in ipairs(flow.nodes) do
  if nodes[n.id] then fail("flow: duplicate scene '%s'", n.id) end
  nodes[n.id] = n
  if n.page and not registry[n.page] then fail("flow: scene '%s' points to unknown page '%s'", n.id, n.page) end
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
local backlinks = {}   -- target id -> { [source page id] = true }

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

-- inline markup; `from` is the page id doing the linking
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
    if not target then fail("page '%s' links to unknown page '%s'", from, id); return label ~= "" and label or id end
    if id ~= from then
      backlinks[id] = backlinks[id] or {}
      backlinks[id][from] = true
    end
    return string.format('<a class="xref" href="%s.html">%s</a>', id, label ~= "" and label or target.title)
  end)
  s = s:gsub("{{([%w%-]+)}}", function(id)
    local n = source_index[id]
    if not n then fail("page '%s' cites unknown source '%s'", from, id); return "" end
    source_used[id] = true
    if cited then cited[id] = true end
    return string.format('<sup class="cite"><a href="sources.html#src-%s" title="%s">[%d]</a></sup>',
      id, esc(sources[n].title), n)
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

local ACCENTS = { ["á"] = "a", ["à"] = "a", ["â"] = "a", ["ã"] = "a", ["ä"] = "a", ["é"] = "e", ["ê"] = "e", ["è"] = "e",
  ["í"] = "i", ["ó"] = "o", ["ô"] = "o", ["õ"] = "o", ["ö"] = "o", ["ú"] = "u", ["ü"] = "u", ["ç"] = "c", ["ñ"] = "n",
  ["Á"] = "a", ["À"] = "a", ["Â"] = "a", ["Ã"] = "a", ["É"] = "e", ["Ê"] = "e", ["Í"] = "i", ["Ó"] = "o", ["Ô"] = "o",
  ["Õ"] = "o", ["Ú"] = "u", ["Ç"] = "c" }
local function slug(s)
  s = s:gsub("[\195][\128-\191]", function(c) return ACCENTS[c] or "" end)
  return (s:lower():gsub("[^%w]+", "-"):gsub("^%-+", ""):gsub("%-+$", ""))
end

local function blocks(text, from, cited, toc)
  local out, para, list = {}, {}, {}
  local function flush()
    if #para > 0 then out[#out + 1] = "<p>" .. inline(table.concat(para, " "), from, cited) .. "</p>"; para = {} end
    if #list > 0 then
      local items = {}
      for _, li in ipairs(list) do items[#items + 1] = "<li>" .. inline(li, from, cited) .. "</li>" end
      out[#out + 1] = "<ul>" .. table.concat(items) .. "</ul>"; list = {}
    end
  end
  for line in (text .. "\n"):gmatch("(.-)\n") do
    line = line:gsub("^%s+", ""):gsub("%s+$", "")
    if line == "" then flush()
    elseif line:sub(1, 3) == "## " then
      flush()
      local h = line:sub(4)
      local plain = h:gsub("%*", ""):gsub("%b()", "")
      local anchor = slug(plain)
      local clean = plain:gsub("%s+$", "")
      if toc then toc[#toc + 1] = { anchor = anchor, text = clean } end
      local seg_link = ""
      if registry[from] and templates_for(registry[from]) then
        seg_link = string.format(' <a class="contrib-seg" href="%s" title="%s">%s</a>',
          contrib_url(from, anchor), esc(string.format(T.seg_title, clean)), T.seg_link)
      end
      out[#out + 1] = string.format('<h2 id="%s">%s%s</h2>', anchor, inline(h, from, cited), seg_link)
    elseif line:sub(1, 2) == "- " then
      if #para > 0 then local l = list; list = {}; flush(); list = l end
      list[#list + 1] = line:sub(3)
    elseif line:sub(1, 2) == "> " then
      flush(); out[#out + 1] = "<blockquote>" .. inline(line:sub(3), from, cited) .. "</blockquote>"
    else
      if #list > 0 then local p = para; para = {}; flush(); para = p end
      para[#para + 1] = line
    end
  end
  flush()
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

local function render_flow_svg()
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
      '<a href="#scene-%s"><rect x="%.0f" y="%.0f" width="%d" height="%d" rx="6" class="node%s"/>'
      .. '<text x="%.0f" y="%.0f" class="node-label">%s</text></a>',
      n.id, p.x - BW / 2, p.y, BW, BH, n.ending and " node-end" or "",
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
  local cards = {}
  for _, n in ipairs(flow.nodes) do
    local exits = {}
    for _, e in ipairs(n.next or {}) do
      exits[#exits + 1] = string.format('<li><a href="#scene-%s">%s</a> <span class="when">— %s</span></li>',
        e.to, esc(nodes[e.to].title), esc(e.when))
    end
    cards[#cards + 1] = string.format(
      '<section class="scene%s" id="scene-%s"><h3>%s</h3>%s%s<p class="scene-page">' .. T.read_more .. ' %s</p></section>',
      n.ending and " scene-end" or "", n.id, esc(n.title),
      n.text and ("<p>" .. inline(n.text, from, cited) .. "</p>") or "",
      #exits > 0 and ('<ul class="exits">' .. table.concat(exits) .. "</ul>") or "",
      inline("[[" .. n.page .. "]]", from, cited))
  end
  local reach_count = 0
  for _ in pairs(reachable) do reach_count = reach_count + 1 end
  return string.format('<p class="lede">' .. T.flow_lede .. '</p>',
      #flow.nodes, ending_count)
    .. render_flow_svg() .. table.concat(cards, "\n")
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

local function render_investigator(inv, from, cited)
  local c = inv.characteristics
  local chars = {}
  for _, k in ipairs({ "STR", "CON", "SIZ", "DEX", "APP", "INT", "POW", "EDU" }) do
    local r, h, x = coc.split(c[k])
    chars[#chars + 1] = string.format('<div class="stat"><span class="stat-k">%s</span><span class="stat-v">%d</span><span class="stat-hx">%d / %d</span></div>', T.inv.chars[k], r, h, x)
  end
  local db, build = coc.damage_bonus(c)
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
  return table.concat({
    string.format('<blockquote class="epigraph">“%s”</blockquote>', esc(inv.quote)),
    string.format('<p class="occupation">%s</p>', esc(inv.occupation)),
    '<h2 id="motivation">' .. T.inv.motivation .. '</h2><p>' .. inline(inv.motivation, from, cited) .. "</p>",
    '<h2 id="personal-hook">' .. T.inv.hook .. '</h2><p>' .. inline(inv.hook, from, cited) .. "</p>",
    '<h2 id="characteristics">' .. T.inv.characteristics .. '</h2><p class="hint">' .. T.inv.char_hint .. '</p>',
    '<div class="stats">' .. table.concat(chars) .. "</div>",
    '<div class="derived-row">' .. table.concat(der) .. "</div>",
    '<p class="hint">' .. T.inv.derived_hint .. '</p>',
    '<h2 id="key-skills">' .. T.inv.skills .. '</h2><div class="table-wrap"><table class="skills"><thead><tr><th>'
      .. table.concat(T.inv.skills_head, "</th><th>") .. '</th></tr></thead><tbody>'
      .. table.concat(skills) .. "</tbody></table></div>",
    '<h2 id="equipment">' .. T.inv.gear .. '</h2><p>' .. esc(inv.gear) .. "</p>",
    '<h2 id="threads">' .. T.inv.threads .. '</h2><ul class="pills"><li>' .. table.concat(rel, "</li><li>") .. "</li></ul>",
  }, "\n")
end

---------------------------------------------------------------------------
-- Layout
---------------------------------------------------------------------------
local function nav_html(current)
  local out = {}
  for _, section in ipairs(SECTION_ORDER) do
    local items = {}
    for _, p in ipairs(order) do
      if p.section == section then
        items[#items + 1] = string.format('<li><a href="%s.html"%s>%s</a></li>', p.id,
          p.id == current and ' aria-current="page"' or "", esc(p.title))
      end
    end
    out[#out + 1] = string.format('<h4>%s</h4><ul>%s</ul>', esc(T.sections[section] or section), table.concat(items))
  end
  return table.concat(out)
end

local FONTS = '<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
  .. '<link href="https://fonts.googleapis.com/css2?family=Pirata+One&family=Silkscreen:wght@400;700&family=EB+Garamond:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">'

-- The language switch: the same page in every edition, top right of the bar.
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

local function layout(p, title, content, current)
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
  // language switch: keep the reader at the same section (anchors differ per language)
  const hs=()=>[...document.querySelectorAll('.prose h2[id]')];
  document.querySelectorAll('[data-set-lang]').forEach(a=>a.addEventListener('click',e=>{
    try{localStorage.setItem('ms-lang',a.dataset.setLang)}catch(_){}
    const i=hs().findIndex(h=>'#'+h.id===decodeURIComponent(location.hash));
    if(i>=0){e.preventDefault();location.href=a.getAttribute('href')+'#s'+i}
  }));
  const m=location.hash.match(/^#s(\d+)$/);
  if(m){const k=+m[1],h=hs()[k];if(h){history.replaceState(null,'','#'+h.id);h.scrollIntoView()}}
</script>
</body>
</html>
]], T.html_lang, esc(title), esc(p and p.summary or book.blurb or ""),
    FONTS, T.skip,
    opts.shelf and string.format('<a class="shelf-link" href="%s" title="%s">%s</a>', opts.shelf, esc(T.shelf_title), T.shelf) or "",
    esc(SITE_TITLE), T.contents, lang_switch(current), esc(T.nav_label), nav_html(current), content,
    string.format(T.footer, esc(SITE_TITLE), esc(AUTHOR)))
end

local function render_page(p, idx)
  local cited, toc = {}, {}
  local body
  if p.investigator then body = render_investigator(p.investigator, p.id, cited)
  elseif p.body == "@timeline" then body = render_timeline(p.id, cited)
  elseif p.body == "@flow" then body = render_flow(p.id, cited)
  elseif p.body == "@sources" then body = render_sources()
  else
    body = blocks(p.body, p.id, cited, toc)
    body = body:gsub("<p>@contact</p>", function() return render_contact() end)
  end
  return { page = p, idx = idx, body = body, cited = cited, toc = toc }
end

local function finish_page(r)
  local p = r.page
  local parts = {
    string.format('<p class="crumb">%s</p>', esc(T.sections[p.section] or p.section)),
    string.format('<h1>%s</h1>', esc(p.title)),
    string.format('<p class="meta"><span class="tag tag-%s">%s</span> <span class="summary">%s</span></p>',
      p.kind, KIND_LABEL[p.kind], esc(p.summary or "")),
  }
  if #r.toc >= 3 then
    local t = {}
    for _, h in ipairs(r.toc) do t[#t + 1] = string.format('<li><a href="#%s">%s</a></li>', h.anchor, esc(h.text)) end
    parts[#parts + 1] = '<nav class="onpage" aria-label="' .. T.on_this_page .. '"><span>' .. T.on_this_page .. '</span><ul>' .. table.concat(t) .. "</ul></nav>"
  end
  parts[#parts + 1] = '<article class="prose">' .. r.body .. "</article>"

  local refs = {}
  for i, s in ipairs(sources) do
    if r.cited[s.id] then
      refs[#refs + 1] = string.format('<li><span class="src-n">[%d]</span> <a href="%s" rel="noopener" target="_blank">%s</a> <span class="src-pub">— %s</span></li>',
        i, esc(s.url), esc(s.title), esc(s.publisher))
    end
  end
  if #refs > 0 then
    parts[#parts + 1] = '<aside class="refs"><h2 id="references">' .. T.refs_here .. '</h2><ul>' .. table.concat(refs) .. "</ul></aside>"
  end

  local bl = {}
  for _, q in ipairs(order) do
    if backlinks[p.id] and backlinks[p.id][q.id] then
      bl[#bl + 1] = string.format('<li><a href="%s.html">%s</a></li>', q.id, esc(q.title))
    end
  end
  if #bl > 0 then
    parts[#parts + 1] = '<aside class="backlinks"><h2 id="referenced-from">' .. T.referenced_from .. '</h2><ul class="pills">' .. table.concat(bl) .. "</ul></aside>"
  end

  if templates_for(p) then
    parts[#parts + 1] = string.format('<aside class="contrib"><h2 id="contribute">%s</h2><p>%s</p><a class="btn" href="%s">%s</a></aside>',
      T.add_title, T.add_text, contrib_url(p.id), esc(string.format(T.add_btn, p.title)))
  end

  local prev, nxt = order[r.idx - 1], order[r.idx + 1]
  parts[#parts + 1] = string.format('<nav class="pager" aria-label="' .. (LANG == "pt" and "Navegação entre páginas" or "Page navigation") .. '">%s%s</nav>',
    prev and string.format('<a class="prev" href="%s.html"><span>' .. T.previous .. '</span>%s</a>', prev.id, esc(prev.title)) or "<span></span>",
    nxt and string.format('<a class="next" href="%s.html"><span>' .. T.next .. '</span>%s</a>', nxt.id, esc(nxt.title)) or "<span></span>")

  return layout(p, p.title .. " · " .. SITE_TITLE, table.concat(parts, "\n"), p.id)
end

local function render_index()
  local sections = {}
  for _, section in ipairs(SECTION_ORDER) do
    local cards = {}
    for _, p in ipairs(order) do
      if p.section == section then
        cards[#cards + 1] = string.format(
          '<a class="card" href="%s.html"><span class="tag tag-%s">%s</span><strong>%s</strong><span>%s</span></a>',
          p.id, p.kind, KIND_LABEL[p.kind], esc(p.title), esc(p.summary or ""))
      end
    end
    sections[#sections + 1] = string.format('<section class="toc-section"><h2 id="%s">%s</h2><div class="cards">%s</div></section>',
      slug(section), esc(T.sections[section] or section), table.concat(cards))
  end
  local content = table.concat({
    '<div class="cover">',
    '<img class="banner" src="banner.svg" width="192" height="72" alt="' .. esc(book.banner_alt or "") .. '">',
    '<p class="kicker">' .. esc(book.kicker or "") .. '</p>',
    '<h1 class="cover-title">' .. (book.cover_title or esc(book.title)) .. '</h1>',
    '<p class="cover-lede">' .. esc(book.blurb or "") .. '</p>',
    '<div class="cover-actions"><a class="btn" href="synopsis.html">' .. T.cover.open .. '</a>'
      .. '<a class="btn btn-ghost" href="scenario-flow.html">' .. T.cover.flow .. '</a></div>',
    '<p class="legend">' .. T.cover.legend .. '</p>',
    '</div>',
    table.concat(sections),
  }, "\n")
  return layout(nil, SITE_TITLE .. T.cover.title_suffix, content, "index")
end

---------------------------------------------------------------------------
-- Build
---------------------------------------------------------------------------
local rendered = {}
for i, p in ipairs(order) do rendered[i] = render_page(p, i) end
local index_html = render_index()

for _, s in ipairs(sources) do
  if not source_used[s.id] then fail("source '%s' is listed but never cited", s.id) end
end

if #errors > 0 then
  io.stderr:write("\nBuild failed — " .. #errors .. " problem(s):\n")
  for _, e in ipairs(errors) do io.stderr:write("  • " .. e .. "\n") end
  os.exit(1)
end

local reach_count = 0
for _ in pairs(reachable) do reach_count = reach_count + 1 end
print(string.format("✓ %d pages, %d sources, %d timeline entries", #order + 1, #sources, #timeline))
print(string.format("✓ scenario graph: %d/%d scenes reachable, %d endings, no dead ends", reach_count, #flow.nodes, ending_count))
print(string.format("✓ %d investigator sheets match CoC 7e derived-stat rules", #investigators))
print(string.format("✓ mist contact track: %d tiers cover 0–%d with no gaps", #contact.tiers, contact.max))

-- Manifest for the Magic Stack root build: pages, segments and forms.
if opts.manifest then
  local serialize = dofile(opts.lib .. "/serialize.lua")
  local list = {}
  for _, r in ipairs(rendered) do
    local p = r.page
    local segs = {}
    for _, h in ipairs(r.toc) do segs[#segs + 1] = { id = h.anchor, title = h.text } end
    list[#list + 1] = { id = p.id, title = p.title, section = p.section, kind = p.kind,
                        templates = templates_for(p) or {}, segments = segs }
  end
  local f = assert(io.open(opts.manifest, "w"))
  local section_names = {}
  for _, sec in ipairs(SECTION_ORDER) do section_names[sec] = T.sections[sec] or sec end
  f:write(serialize({ id = book.id, lang = LANG, title = book.title, pages = list, sections = SECTION_ORDER, section_names = section_names }))
  f:close()
  print("✓ wrote manifest " .. opts.manifest)
end

if CHECK_ONLY then return end

os.execute("mkdir -p " .. OUT)
local function write(name, s)
  local f = assert(io.open(OUT .. "/" .. name, "w")); f:write(s); f:close()
end
for _, r in ipairs(rendered) do write(r.page.id .. ".html", finish_page(r)) end
write("index.html", index_html)
local css = assert(io.open("assets/style.css")):read("a")
write("style.css", css)
write(".nojekyll", "")
write("banner.svg", dofile("tools/banner.lua").svg())
print("✓ wrote site to " .. OUT .. "/")

