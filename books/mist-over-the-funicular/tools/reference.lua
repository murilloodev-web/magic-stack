-- Exports the whole book as one Markdown file: the source material for
-- redesigning it (Claude Design, illustrators, translators).
--
--   cd books/mist-over-the-funicular && lua tools/reference.lua > REFERENCE.md

local book          = dofile("book.lua")
local pages         = dofile("data/pages.lua")
local investigators = dofile("data/investigators.lua")
local sources       = dofile("data/sources.lua")
local timeline      = dofile("data/timeline.lua")
local flow          = dofile("data/flow.lua")
local contact       = dofile("data/contact.lua")

local SECTION_ORDER = { "The Scenario", "Places", "The Mythos", "Factions", "Investigators", "Endings", "Reference" }
local KIND = { history = "History (documented, cited)", fiction = "Fiction (invented)", mixed = "History + Fiction" }

local titles = {}
for _, p in ipairs(pages) do titles[p.id] = p.title end
for _, i in ipairs(investigators) do titles[i.id] = i.name end
local src_n = {}
for i, s in ipairs(sources) do src_n[s.id] = i end

-- turn the grimoire markup into plain Markdown
local function md(s)
  s = s:gsub("([Tt]he )%[%[([%w%-]+)%]%]", function(article, id)
    local t = titles[id]
    if t and t:match("^The ") then return article .. t:sub(5) end
  end)
  s = s:gsub("%[%[([^%]|]+)|([^%]]+)%]%]", "%2"):gsub("%[%[([^%]]+)%]%]", function(id) return titles[id] or id end)
  s = s:gsub("{{([%w%-]+)}}", function(id) return "[" .. (src_n[id] or "?") .. "]" end)
  s = s:gsub("\n[ \t]+", "\n"):gsub("^%s+", ""):gsub("%s+$", "")
  return (s:gsub("\n## ", "\n#### "):gsub("^## ", "#### "))
end

local out = {}
local function w(...) for _, x in ipairs({ ... }) do out[#out + 1] = x end end

w("# " .. book.title .. " — reference text", "",
  "*" .. book.system .. " · " .. book.subtitle .. " · by " .. book.author .. "*", "",
  "> " .. book.blurb, "",
  "This file is generated from the book's Lua data (`lua tools/reference.lua`). It holds every word of the book, its structure and its data, as source material for redesigning it. Do not edit it by hand; edit `data/` and regenerate it.", "",
  "**Labels.** Every page is tagged as History (documented and cited), Fiction (invented for play) or History + Fiction (fiction built on a documented fact). Citations appear as [n] and point to the Sources list at the end.", "")

w("## Structure", "")
for _, sec in ipairs(SECTION_ORDER) do
  local items = {}
  if sec == "Investigators" then
    for _, i in ipairs(investigators) do items[#items + 1] = i.name end
  else
    for _, p in ipairs(pages) do if p.section == sec then items[#items + 1] = p.title end end
  end
  w("- **" .. sec .. "**: " .. table.concat(items, " · "))
end
w("")

for _, sec in ipairs(SECTION_ORDER) do
  w("---", "", "## " .. sec, "")
  if sec == "Investigators" then
    for _, i in ipairs(investigators) do
      local c = i.characteristics
      w("### " .. i.name .. " — " .. i.role, "",
        "*" .. i.occupation .. "*", "",
        "> “" .. i.quote .. "”", "",
        "**Motivation.** " .. md(i.motivation), "",
        "**Personal hook.** " .. md(i.hook), "",
        string.format("**Characteristics.** STR %d · CON %d · SIZ %d · DEX %d · APP %d · INT %d · POW %d · EDU %d · HP %d · SAN %d",
          c.STR, c.CON, c.SIZ, c.DEX, c.APP, c.INT, c.POW, c.EDU, (c.CON + c.SIZ) // 10, c.POW), "")
      local sk = {}
      for _, s in ipairs(i.skills) do sk[#sk + 1] = s[1] .. " " .. s[2] .. "%" end
      w("**Key skills.** " .. table.concat(sk, " · "), "", "**Equipment (1974).** " .. i.gear, "")
    end
  else
    for _, p in ipairs(pages) do
      if p.section == sec then
        w("### " .. p.title, "", "*" .. KIND[p.kind] .. " — " .. (p.summary or "") .. "*", "")
        if p.body == "@timeline" then
          for _, t in ipairs(timeline) do
            w(string.format("- **%s** (%s) %s%s", t.year, t.kind, md(t.text), t.source and (" [" .. src_n[t.source] .. "]") or ""))
          end
          w("")
        elseif p.body == "@flow" then
          w("Scenes (start: `" .. flow.start .. "`). Each exit says what opens it.", "")
          local ft = {}
          for _, n in ipairs(flow.nodes) do ft[n.id] = n.title end
          for _, n in ipairs(flow.nodes) do
            w("- **" .. n.title .. "**" .. (n.ending and " *(ending)*" or "") .. (n.text and (" — " .. md(n.text)) or ""))
            for _, e in ipairs(n.next or {}) do w("  - → " .. ft[e.to] .. ": " .. e.when) end
          end
          w("")
        elseif p.body == "@sources" then
          for i, s in ipairs(sources) do
            w(string.format("%d. **%s** — %s. <%s>  \n   %s", i, s.title, s.publisher, s.url, s.note))
          end
          w("")
        else
          local body = md(p.body)
          if body:find("@contact") then
            local rows = { "| Contact | Tier | Effect |", "|---|---|---|" }
            for _, t in ipairs(contact.tiers) do
              rows[#rows + 1] = string.format("| %s | %s | %s |", t.from == t.to and t.from or (t.from .. "–" .. t.to), t.name, t.effect)
            end
            body = body:gsub("@contact", function() return table.concat(rows, "\n") end)
          end
          w(body, "")
        end
      end
    end
  end
end

io.write(table.concat(out, "\n"), "\n")
