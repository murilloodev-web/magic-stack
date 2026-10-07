-- tools/localmap.lua — the opening adventure's local map: the Descoberto
-- reservoir on the border between OmniTerra and the Brasília REGEST, drawn
-- as a pixel schematic (not to scale). Returns an inline SVG for a language.
--
--   dofile("tools/localmap.lua")("pt") --> SVG string

local INK, PAPER = "#0b0b14", "#f3e6d0"
local L = {
  pt = {
    title = "A REPRESA DO DESCOBERTO · 2126",
    omni = "TERRITÓRIO OMNITERRA", df = "REGEST DE BRASÍLIA",
    lake = "Lago do Descoberto", dam = "Barragem", plant = "Estação Descoberto-7",
    town = "Vila Operária Águas Lindas", core = "Núcleo Planalto (data center)",
    old = "Adutora Velha (1979)", new = "Adutora Planalto", border = "Divisa · Posto 4",
    city = "Taguatinga → Plano Piloto", desc = "Mapa esquemático da represa do Descoberto. À esquerda, território da OmniTerra com a vila operária; no centro, o lago e a barragem com a Estação Descoberto-7; uma adutora nova leva a água ao data center ao norte, e a adutora velha cruza a divisa rumo a Brasília, à direita.",
  },
  en = {
    title = "THE DESCOBERTO RESERVOIR · 2126",
    omni = "OMNITERRA TERRITORY", df = "BRASÍLIA REGEST",
    lake = "Lake Descoberto", dam = "Dam", plant = "Descoberto-7 Station",
    town = "Águas Lindas works village", core = "Planalto Core (data centre)",
    old = "Old Main (1979)", new = "Planalto Main", border = "Border · Post 4",
    city = "Taguatinga → Plano Piloto", desc = "Schematic map of the Descoberto reservoir. On the left, OmniTerra territory with the works village; in the middle, the lake and the dam with the Descoberto-7 Station; a new main carries the water to the data centre in the north, and the old main crosses the border toward Brasília, on the right.",
  },
}

local function esc(s) return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")) end

return function(lang)
  local t = assert(L[lang], "localmap: no text for " .. lang)
  local C, COLS, ROWS = 4, 72, 40
  local W, H = COLS * C, ROWS * C
  local out = {}
  local function add(s) out[#out + 1] = s end
  local function rect(x, y, w, h, fill) add(string.format('<rect x="%g" y="%g" width="%g" height="%g" fill="%s"/>', x, y, w, h, fill)) end

  -- ground: which cells are lake, which side of the border
  local function border_x(r) return 46 + math.floor(2 * math.sin(r / 5)) end
  local function lake(c, r)
    -- two lobes, the dam closes the south-east end
    local a = ((c - 24) / 13) ^ 2 + ((r - 15) / 7) ^ 2
    local b = ((c - 36) / 7) ^ 2 + ((r - 21) / 5) ^ 2
    local n = ((c - 17) / 5) ^ 2 + ((r - 9) / 4) ^ 2
    return a <= 1 or b <= 1 or n <= 1
  end

  add(string.format('<svg class="board local" viewBox="-8 -8 %d %d" role="img" aria-labelledby="lm-t lm-d" shape-rendering="crispEdges" xmlns="http://www.w3.org/2000/svg">', W + 16, H + 16))
  add(string.format('<title id="lm-t">%s</title><desc id="lm-d">%s</desc>', esc(t.title), esc(t.desc)))
  rect(-8, -8, W + 16, H + 16, "#5a1312")
  add(string.format('<rect x="-5" y="-5" width="%d" height="%d" fill="none" stroke="#e0b23a" stroke-width="2"/>', W + 10, H + 10))
  for r = 0, ROWS - 1 do
    local bx = border_x(r)
    for c = 0, COLS - 1 do
      local fill
      if lake(c, r) then fill = ((c + r) % 3 == 0) and "#2a5a80" or "#1d4262"
      elseif c < bx then fill = ((c * 7 + r * 3) % 11 == 0) and "#4f6f45" or "#3f5e38"   -- company cerrado, irrigated
      else fill = ((c * 5 + r * 7) % 9 == 0) and "#a68b5b" or "#b99d6b" end              -- the REGEST, dry
      rect(c * C, r * C, C, C, fill)
    end
  end
  -- the border, dashed
  for r = 0, ROWS - 1, 2 do rect(border_x(r) * C, r * C, 2, C, "#c8322e") end
  -- dam (south-east end of the lake) and the station below it
  rect(38 * C, 25 * C, 8 * C, C, "#8d8a80"); rect(38 * C, 26 * C, 8 * C, 1, INK)
  rect(36 * C, 28 * C, 9 * C, 5 * C, INK); rect(36 * C + 1, 28 * C + 1, 9 * C - 2, 5 * C - 2, "#d9d3c4")
  for i = 0, 3 do rect(37 * C + i * 8, 29 * C, 5, 5, "#3b6fc4") end           -- settling tanks
  rect(41 * C, 31 * C, 3 * C, 2 * C - 1, "#5d5d72")                            -- pump hall
  -- the new main: north-west to the data centre
  local px, py = 37 * C, 28 * C
  local path = { { 37, 28 }, { 37, 33 }, { 30, 33 }, { 30, 36 }, { 6, 36 }, { 6, 5 } }
  for i = 1, #path - 1 do
    local a, b = path[i], path[i + 1]
    local x0, y0, x1, y1 = math.min(a[1], b[1]), math.min(a[2], b[2]), math.max(a[1], b[1]), math.max(a[2], b[2])
    rect(x0 * C, y0 * C, (x1 - x0) * C + 3, (y1 - y0) * C + 3, "#6a98e0")
  end
  -- the data centre: a long grey block with blinking cells
  rect(2 * C, 1 * C, 12 * C, 4 * C, INK); rect(2 * C + 1, C + 1, 12 * C - 2, 4 * C - 2, "#5d5d72")
  for i = 0, 10 do rect(3 * C + i * 4, 2 * C + (i % 2) * 4, 2, 2, i % 3 == 0 and "#e0b23a" or "#6ccac0") end
  -- the old main: thin, east across the border
  for c = 45, COLS - 1 do rect(c * C, 30 * C + 1, C, 2, "#9fb7c9") end
  for c = 45, COLS - 1, 3 do rect(c * C + 1, 30 * C, 2, 1, INK) end
  -- the checkpoint on the border, on the road
  for c = 30, COLS - 1 do rect(c * C, 34 * C, C, 2, "#4a4a52") end
  local cx = border_x(34) * C - 4
  rect(cx, 32 * C, 10, 8, INK); rect(cx + 1, 32 * C + 1, 8, 6, "#e0b23a"); rect(cx + 3, 32 * C + 3, 4, 2, INK)
  -- the works village west of the lake
  for i = 0, 5 do
    local hx, hy = (4 + (i % 3) * 3) * C, (20 + (i // 3) * 3) * C
    rect(hx, hy, 8, 6, INK); rect(hx + 1, hy + 2, 6, 3, "#d9d3c4"); rect(hx + 1, hy + 1, 6, 1, "#c8322e")
  end
  -- labels
  local function text(x, y, s, cls) add(string.format('<text x="%g" y="%g" class="%s">%s</text>', x, y, cls or "mp-s", esc(s))) end
  text(4, H - 6, t.omni, "mp-name")
  text(W - 4, H - 6, t.df, "mp-name mp-r-left")
  text(18 * C, 15 * C, t.lake)
  text(38 * C, 24 * C - 2, t.dam)
  text(36 * C, 27 * C - 2, t.plant, "mp-r")
  text(3 * C, 19 * C - 2, t.town)
  text(15 * C, 3 * C + 2, t.core)
  text(7 * C + 2, 12 * C, t.new)
  text(W - 4, 29 * C - 2, t.old, "mp-s mp-r-left")
  text(cx + 12, 35 * C + 6, t.border)
  text(W - 4, 33 * C - 2, t.city, "mp-s mp-r-left")
  text(W - 4, 6, t.title, "mp-title mp-r-left")
  add("</svg>")
  return table.concat(out, "\n")
end
