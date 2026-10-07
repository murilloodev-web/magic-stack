-- tools/map.lua — the world board, drawn as pixel art in SVG.
--
-- The map is a board in the spirit of the game War: every territory is
-- painted in its owner's colour, and each owner has a pile of army pieces
-- with a number. It is drawn from data/worldgrid.lua (one letter per 2°
-- pixel) and data/territories.lua. Text is real SVG text, so the map has to
-- be inlined in the page (an <img> would lose the pixel font).
--
--   local map = dofile("tools/map.lua")
--   map.board(grid, territories, lang)        -- the full board
--   map.mini(grid, territories, opts)         -- a small version for the cover and banner

local M = {}

local CELL = 4
local INK, PAPER = "#0b0b14", "#f3e6d0"

local function esc(s)
  return (tostring(s):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

-- owners by letter, with the sea under "."
local function owners(t)
  local by = {}
  for _, e in ipairs(t.estemps) do by[e.code] = e end
  return by
end

local function cell_at(grid, lon, lat)
  local c = math.floor((lon - grid.lon0) / grid.step)
  local r = math.floor((grid.lat0 - lat) / grid.step)
  return c, r
end
M.cell_at = cell_at

-- a sprite is a list of strings; each letter is a colour from `pal`, "." is clear
local function sprite(rows, pal, x, y, px, out)
  px = px or 1
  for j, row in ipairs(rows) do
    local i = 1
    while i <= #row do
      local ch = row:sub(i, i)
      local k = i
      while k < #row and row:sub(k + 1, k + 1) == ch do k = k + 1 end
      if ch ~= "." then
        out[#out + 1] = string.format('<rect x="%g" y="%g" width="%g" height="%g" fill="%s"/>',
          x + (i - 1) * px, y + (j - 1) * px, (k - i + 1) * px, px, pal[ch])
      end
      i = k + 1
    end
  end
end
M.sprite = sprite

local PIECE = {   -- one War army piece, 8×7
  "..XXXX..",
  ".XLLLLX.",
  "XLLLLLLX",
  "XCCCCCDX",
  "XCCCCCDX",
  "XCCCCCDX",
  ".XXXXXX.",
}
local SKULL = {
  ".XXXXX.",
  "XWWWWWX",
  "XWXWXWX",
  "XWWWWWX",
  ".XWWWX.",
  "..XWX..",
  "...X...",
}
local ROCKET = {
  "..X..",
  ".XWX.",
  ".XWX.",
  ".XRX.",
  ".XWX.",
  "XXWXX",
  "X.O.X",
  "..O..",
}
local ROCK = {
  "..XXX..",
  ".XGGGX.",
  "XGgGGGX",
  "XGGGgGX",
  ".XGGGX.",
  "..XXX..",
}
local DIE = {
  "XXXXXXX",
  "XCCCCCX",
  "XCPCCCX",
  "XCCPCCX",
  "XCCCPCX",
  "XCCCCCX",
  "XXXXXXX",
}

local function piece(out, x, y, e, n)
  -- a small pile: three pieces, then the count
  local pal = { X = INK, L = e.light, C = e.color, D = e.dark }
  sprite(PIECE, pal, x, y + 3, 1, out)
  sprite(PIECE, pal, x + 7, y + 3, 1, out)
  sprite(PIECE, pal, x + 3.5, y - 1, 1, out)
  if n then out[#out + 1] = string.format('<text x="%g" y="%g" class="mp-n">%d</text>', x + 17, y + 9, n) end
end

-- The full board.
function M.board(grid, t, lang)
  local by = owners(t)
  local rows = grid.rows
  local R, C = #rows, grid.cols
  local W, H = C * CELL, R * CELL
  local PAD = 10
  local out = {}
  local function add(s) out[#out + 1] = s end
  local function at(r, c)
    if r < 1 or r > R then return "." end
    c = (c - 1) % C + 1
    return rows[r]:sub(c, c)
  end

  add(string.format('<svg class="board" viewBox="%d %d %d %d" role="img" aria-labelledby="board-title board-desc" shape-rendering="crispEdges" xmlns="http://www.w3.org/2000/svg">',
    -PAD, -PAD, W + PAD * 2, H + PAD * 2))
  add(string.format('<title id="board-title">%s</title>', lang == "en" and "The world board, 2126" or "O tabuleiro do mundo, 2126"))
  add(string.format('<desc id="board-desc">%s</desc>', lang == "en"
    and "World map in pixel art. Each colour is a corporate state (ESTEMP); the sea belongs to Thalassa Corp. Small numbered squares are the twenty REGESTs; a skull marks the flooded Djibouti Triangle and a rocket marks Alcântara."
    or "Mapa-múndi em pixel art. Cada cor é um Estado Empresarial (ESTEMP); o mar pertence à Thalassa Corp. Os quadradinhos numerados são os vinte REGESTs; uma caveira marca o Triângulo de Jibuti alagado e um foguete marca Alcântara."))
  -- the board's frame: a red printed board, like the box of a war game
  add(string.format('<rect x="%d" y="%d" width="%d" height="%d" fill="#5a1312"/>', -PAD, -PAD, W + PAD * 2, H + PAD * 2))
  add(string.format('<rect x="%d" y="%d" width="%d" height="%d" fill="none" stroke="#e0b23a" stroke-width="2"/>', -PAD + 3, -PAD + 3, W + PAD * 2 - 6, H + PAD * 2 - 6))
  -- the sea, dithered
  add(string.format('<defs><pattern id="mp-sea" width="4" height="4" patternUnits="userSpaceOnUse"><rect width="4" height="4" fill="%s"/><rect width="1" height="1" fill="%s"/><rect x="2" y="2" width="1" height="1" fill="%s"/></pattern></defs>',
    t.sea.water, t.sea.water2, t.sea.water2))
  add(string.format('<rect width="%d" height="%d" fill="url(#mp-sea)"/>', W, H))
  -- graticule every 30°
  for lon = -150, 150, 30 do
    add(string.format('<rect x="%g" y="0" width="1" height="%d" fill="%s"/>', (lon - grid.lon0) / grid.step * CELL, H, "#1d4262"))
  end
  for lat = 60, -60, -30 do
    local y = (grid.lat0 - lat) / grid.step * CELL
    if y > 0 and y < H then add(string.format('<rect x="0" y="%g" width="%d" height="1" fill="%s"/>', y, W, lat == 0 and "#2a5a80" or "#1d4262")) end
  end
  -- land, run-length per row
  for r = 1, R do
    local row = rows[r]
    local c = 1
    while c <= C do
      local ch = row:sub(c, c)
      local k = c
      while k < C and row:sub(k + 1, k + 1) == ch do k = k + 1 end
      if ch ~= "." then
        local e = assert(by[ch], "map: no owner for letter " .. ch)
        add(string.format('<rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>', (c - 1) * CELL, (r - 1) * CELL, (k - c + 1) * CELL, CELL, e.color))
      end
      c = k + 1
    end
  end
  -- relief: light on the north shore, shadow on the south shore, ink on borders
  for r = 1, R do
    for c = 1, C do
      local ch = at(r, c)
      if ch ~= "." then
        local e = by[ch]
        local x, y = (c - 1) * CELL, (r - 1) * CELL
        if at(r - 1, c) == "." then add(string.format('<rect x="%d" y="%d" width="%d" height="1" fill="%s"/>', x, y, CELL, e.light)) end
        if at(r + 1, c) == "." then add(string.format('<rect x="%d" y="%d" width="%d" height="1" fill="%s"/>', x, y + CELL - 1, CELL, e.dark)) end
        local right, down = at(r, c + 1), at(r + 1, c)
        if right ~= "." and right ~= ch and c < C then add(string.format('<rect x="%d" y="%d" width="1" height="%d" fill="%s"/>', x + CELL - 1, y, CELL, INK)) end
        if down ~= "." and down ~= ch then add(string.format('<rect x="%d" y="%d" width="%d" height="1" fill="%s"/>', x, y + CELL - 1, CELL, INK)) end
      end
    end
  end
  local function xy(lon, lat)
    return (lon - grid.lon0) / grid.step * CELL, (grid.lat0 - lat) / grid.step * CELL
  end
  -- the first asteroid: Alcântara launched the miners; a dotted trail to orbit
  for _, m in ipairs(t.marks) do
    if m.id == "alcantara" then
      local x, y = xy(m.lon, m.lat)
      for yy = y - 8, 14, -6 do add(string.format('<rect x="%g" y="%g" width="1" height="2" fill="%s"/>', x + 2, yy, PAPER)) end
      sprite(ROCK, { X = INK, G = "#8d8a80", g = "#5d5b53" }, x - 1, 4, 1, out)
      add(string.format('<text x="%g" y="%g" class="mp-s">%s</text>', x + 8, 10, lang == "en" and "To orbit · First Asteroid, 2046" or "Rumo à órbita · Primeiro Asteroide, 2046"))
    end
  end
  -- REGESTs: cream squares, numbered (the crowded European ones are
  -- numbered in the inset instead)
  local function regest_mark(g, x, y, numbered)
    x, y = math.floor(x) - 2, math.floor(y) - 2
    add(string.format('<g class="mp-regest"><title>%d · %s — %s</title>', g.n, esc(g.country[lang]), esc(g.place[lang])))
    add(string.format('<rect x="%d" y="%d" width="6" height="6" fill="%s"/><rect x="%d" y="%d" width="4" height="4" fill="%s"/><rect x="%d" y="%d" width="2" height="2" fill="#c8322e"/>',
      x, y, INK, x + 1, y + 1, PAPER, x + 2, y + 2))
    if numbered then
      local left = (g.dx or 0) < 0
      local tx, ty = left and (x - 1 + g.dx) or (x + 7 + (g.dx or 0)), y + 6 + (g.dy or 0)
      add(string.format('<text x="%d" y="%d" class="mp-r%s">%d</text>', tx, ty, left and " mp-r-left" or "", g.n))
    end
    add("</g>")
  end
  local ins = t.inset
  for _, g in ipairs(t.regests) do
    local x, y = xy(g.lon, g.lat)
    regest_mark(g, x, y, not (ins and g.inset))
  end
  -- the inset: a corner of the board at double scale
  if ins then
    local Z = CELL * ins.zoom
    local c0, r0 = cell_at(grid, ins.lon0, ins.lat0)
    local cw, rh = math.floor((ins.lon1 - ins.lon0) / grid.step), math.floor((ins.lat0 - ins.lat1) / grid.step)
    local ox, oy = ins.x, H - rh * Z - ins.y
    add(string.format('<rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>', ox - 3, oy - 12, cw * Z + 6, rh * Z + 15, INK))
    add(string.format('<rect x="%d" y="%d" width="%d" height="%d" fill="url(#mp-sea)"/>', ox, oy, cw * Z, rh * Z))
    for r = 1, rh do
      for c = 1, cw do
        local ch = at(r0 + r, c0 + c)
        if ch ~= "." then
          local e = by[ch]
          local x, y = ox + (c - 1) * Z, oy + (r - 1) * Z
          add(string.format('<rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>', x, y, Z, Z, e.color))
          if at(r0 + r - 1, c0 + c) == "." then add(string.format('<rect x="%d" y="%d" width="%d" height="1" fill="%s"/>', x, y, Z, e.light)) end
          if at(r0 + r + 1, c0 + c) == "." then add(string.format('<rect x="%d" y="%d" width="%d" height="2" fill="%s"/>', x, y + Z - 2, Z, e.dark)) end
          local right, down = at(r0 + r, c0 + c + 1), at(r0 + r + 1, c0 + c)
          if right ~= "." and right ~= ch and c < cw then add(string.format('<rect x="%d" y="%d" width="1" height="%d" fill="%s"/>', x + Z - 1, y, Z, INK)) end
          if down ~= "." and down ~= ch and r < rh then add(string.format('<rect x="%d" y="%d" width="%d" height="1" fill="%s"/>', x, y + Z - 1, Z, INK)) end
        end
      end
    end
    add(string.format('<text x="%d" y="%d" class="mp-s mp-inset">%s</text>', ox, oy - 4, esc(ins.label[lang])))
    for _, g in ipairs(t.regests) do
      if g.inset then
        local x = ox + (g.lon - (grid.lon0 + (c0 + 1) * grid.step) + grid.step) / grid.step * Z
        local y = oy + ((grid.lat0 - (r0 + 1) * grid.step) - g.lat + grid.step) / grid.step * Z
        regest_mark({ n = g.n, country = g.country, place = g.place, dx = g.idx, dy = g.idy }, x, y, true)
      end
    end
  end
  -- landmarks
  for _, m in ipairs(t.marks) do
    local x, y = xy(m.lon, m.lat)
    if m.icon == "skull" then
      sprite(SKULL, { X = INK, W = PAPER }, x - 3, y - 3, 1, out)
      add(string.format('<text x="%g" y="%g" class="mp-s">%s</text>', x + 6, y + 10, esc(m.label[lang])))
    elseif m.icon == "rocket" then
      sprite(ROCKET, { X = INK, W = PAPER, R = "#c8322e", O = "#e0b23a" }, x - 2, y - 4, 1, out)
      add(string.format('<text x="%g" y="%g" class="mp-s">%s</text>', x + 5, y + 9, esc(m.label[lang])))
    end
  end
  -- army piles and names
  for _, e in ipairs(t.estemps) do
    local x, y = xy(e.label.lon, e.label.lat)
    add(string.format('<text x="%g" y="%g" class="mp-name">%s</text>', x, y - 4, esc(e.name)))
    piece(out, x, y, e, e.armies)
  end
  for i, p in ipairs(t.sea.labels) do
    local x, y = xy(p.lon, p.lat)
    if i == 1 then add(string.format('<text x="%g" y="%g" class="mp-name">%s</text>', x, y - 4, esc(t.sea.name))) end
    piece(out, x, y, t.sea, i == 1 and t.sea.armies or nil)
  end
  -- dice in the corner: two red to attack, three yellow to defend
  local dx, dy = W - 70, H - 16
  for i = 0, 1 do sprite(DIE, { X = INK, C = "#c8322e", P = PAPER }, dx + i * 9, dy, 1, out) end
  for i = 0, 2 do sprite(DIE, { X = INK, C = "#e0b23a", P = INK }, dx + 22 + i * 9, dy, 1, out) end
  add(string.format('<text x="%d" y="%d" class="mp-title mp-r-left">%s</text>', W - 6, dy - 6, lang == "en" and "THE BOARD · 2126" or "O TABULEIRO · 2126"))
  add("</svg>")
  return table.concat(out, "\n")
end

-- A small map for the cover and the banner: every `k` grid pixels become one
-- dot of `px` pixels, painted in the owner's colour. Returns rects only.
function M.mini(grid, t, o)
  local by = owners(t)
  local k, px = o.k or 3, o.px or 1
  local out = {}
  local rows = grid.rows
  local r0, r1 = o.r0 or 1, o.r1 or #rows
  for r = r0, r1, k do
    local y = o.y + ((r - r0) // k) * px
    local c = 1
    local line = {}
    for cc = 1, grid.cols, k do
      -- the owner of most of the k×k block
      local count, best, bn = {}, ".", 0
      for dr = 0, k - 1 do
        local row = rows[r + dr]
        if row then
          for dc = 0, k - 1 do
            local ch = row:sub(cc + dc, cc + dc)
            if ch ~= "" then count[ch] = (count[ch] or 0) + 1 end
          end
        end
      end
      for ch, n in pairs(count) do if ch ~= "." and n * 3 >= k * k and n > bn then best, bn = ch, n end end
      line[#line + 1] = best
      c = c + 1
    end
    local i = 1
    while i <= #line do
      local ch = line[i]
      local j = i
      while j < #line and line[j + 1] == ch do j = j + 1 end
      if ch ~= "." then
        out[#out + 1] = string.format('<rect x="%g" y="%g" width="%g" height="%g" fill="%s"/>', o.x + (i - 1) * px, y, (j - i + 1) * px, px, by[ch].color)
      end
      i = j + 1
    end
  end
  return table.concat(out)
end

M.PIECE, M.DIE, M.SKULL, M.ROCKET = PIECE, DIE, SKULL, ROCKET
return M
