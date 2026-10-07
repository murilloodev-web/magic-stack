-- tools/banner.lua — the 192×72 pixel banner at the top of the book's cover
-- page: the whole board at one pixel per grid cell, on a red game box, with
-- a few army piles, the dice and the skull over Djibouti.
--
--   dofile("tools/banner.lua")(worldgrid, territories) --> SVG string

local map = dofile("tools/map.lua")

return function(grid, t)
  local out = {}
  local function add(s) out[#out + 1] = s end
  local W, H = 192, 72
  local X0, Y0 = 6, 3
  add(string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %d %d" width="%d" height="%d" shape-rendering="crispEdges">', W, H, W, H))
  add(string.format('<rect width="%d" height="%d" fill="#5a1312"/>', W, H))
  add(string.format('<rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>', X0, Y0, grid.cols, #grid.rows, t.sea.water))
  -- dithered sea
  for y = Y0, Y0 + #grid.rows - 1, 2 do
    for x = X0 + (y % 4 == 1 and 0 or 1), X0 + grid.cols - 1, 4 do
      add(string.format('<rect x="%d" y="%d" width="1" height="1" fill="%s"/>', x, y, t.sea.water2))
    end
  end
  add(map.mini(grid, t, { k = 1, px = 1, x = X0, y = Y0 }))
  local by = {}
  for _, e in ipairs(t.estemps) do by[e.id] = e end
  local function pile(e, lon, lat)
    local c, r = map.cell_at(grid, lon, lat)
    map.sprite(map.PIECE, { X = "#0b0b14", L = e.light, C = e.color, D = e.dark }, X0 + c - 4, Y0 + r - 3, 1, out)
  end
  pile(by["omniterra"], -100, 45)
  pile(by["kuro-tech"], 108, 33)
  pile(by["aegis-med"], 20, 30)
  pile(by["petro-vanguard"], 50, 34)
  pile(t.sea, -140, 10)
  pile(t.sea, 75, -30)
  for _, m in ipairs(t.marks) do
    if m.icon == "skull" then
      local c, r = map.cell_at(grid, m.lon, m.lat)
      map.sprite(map.SKULL, { X = "#0b0b14", W = "#f3e6d0" }, X0 + c - 3, Y0 + r - 3, 1, out)
    end
  end
  for i = 0, 1 do map.sprite(map.DIE, { X = "#0b0b14", C = "#c8322e", P = "#f3e6d0" }, X0 + 6 + i * 9, Y0 + #grid.rows - 12, 1, out) end
  for i = 0, 2 do map.sprite(map.DIE, { X = "#0b0b14", C = "#e0b23a", P = "#0b0b14" }, X0 + 26 + i * 9, Y0 + #grid.rows - 12, 1, out) end
  add(string.format('<rect x="1" y="1" width="%d" height="%d" fill="none" stroke="#e0b23a" stroke-width="1"/>', W - 2, H - 2))
  add("</svg>")
  return table.concat(out, "\n")
end
