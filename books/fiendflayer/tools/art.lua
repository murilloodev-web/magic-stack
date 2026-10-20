-- tools/art.lua — the FiendFlayer pixel art, shared by the banner (on the
-- book's cover page) and the cover on the Magic Stack table: an open field
-- at night, seen almost from above, with a summoning circle burning in the
-- grass, a fiend standing in it and a knight watching from a distance.
--
--   local art = dofile("tools/art.lua")
--   art.svg(art.field(W, H, { cx = ..., cy = ..., r = ..., knight = { x, y } }))
--
-- Everything is deterministic: the same call always draws the same picture.

local art = {}

art.C = {
  outline = "#0d0a08",
  grass = { "#1b2615", "#212e19", "#28371d", "#2f4021", "#384b27" },
  tuft = "#46592f",
  dirt = "#2e2418", dirt2 = "#3a2e1e",
  rock = "#4a4a52", rock_lo = "#2a2a30",
  canopy = "#111a0e", canopy2 = "#18240f", canopy_hi = "#24341a",
  scorch = "#1a0f0c", scorch2 = "#2a1410", ember_floor = "#4a1a14", ember_floor2 = "#6a2418",
  glow = { "#3a1a20", "#4a1e2c", "#3a1838" },
  ring = "#d23a2a", ring_hi = "#f2a845", ring_lo = "#8e1b20",
  sigil = "#a75ce8", sigil_lo = "#6b2fa0",
  flame = "#ffd27a",
  shadow = "#0a0d08",
  -- the knight
  steel = "#a8aab4", steel_hi = "#d8dae2", steel_lo = "#5e606c", cape = "#8e1b2a", cape_lo = "#5e1018",
  -- the fiend
  skin = "#b0222f", skin_hi = "#d23a44", horn = "#2e1218", wing = "#8a2232", wing_lo = "#5e1624",
  purple = "#8a3fc4", aura = "#a8361c",
}
local C = art.C

-- a tiny deterministic hash, so "random" pixels stay put between builds
local function noise(x, y, seed)
  local n = (x * 374761393 + y * 668265263 + (seed or 0) * 2246822519) % 4294967296
  n = ((n ~ (n >> 13)) * 1274126177) % 4294967296
  return (n ~ (n >> 16)) % 1000 / 1000
end
art.noise = noise

local function canvas(W, H)
  local g = { W = W, H = H }
  for y = 0, H - 1 do g[y] = {} end
  function g.set(x, y, c) x, y = math.floor(x + .5), math.floor(y + .5); if x >= 0 and x < W and y >= 0 and y < H then g[y][x] = c end end
  return g
end

-- a sprite is a list of strings; each letter is a key in `pal`, "." is clear.
-- With `ring`, every clear pixel touching the sprite gets that colour, so a
-- figure a few pixels tall still reads against busy ground.
local function sprite(g, rows, pal, x0, y0, ring)
  local function on(i, j) local r = rows[j]; return r and i >= 1 and i <= #r and r:sub(i, i) ~= "." end
  if ring then
    for j = 0, #rows + 1 do
      for i = 0, #rows[1] + 1 do
        if not on(i, j) and (on(i - 1, j) or on(i + 1, j) or on(i, j - 1) or on(i, j + 1)) then
          g.set(x0 + i - 1, y0 + j - 1, ring)
        end
      end
    end
  end
  for j, row in ipairs(rows) do
    for i = 1, #row do
      local ch = row:sub(i, i)
      if ch ~= "." then g.set(x0 + i - 1, y0 + j - 1, pal[ch]) end
    end
  end
end

-- the sprite's shadow, cast down and to the right (the moon is high)
local function shadow(g, rows, x0, y0, dx, dy)
  for j, row in ipairs(rows) do
    for i = 1, #row do
      if row:sub(i, i) ~= "." then g.set(x0 + i - 1 + dx, y0 + j - 1 + dy, C.shadow) end
    end
  end
end

---------------------------------------------------------------------------
-- The field: grass in slow patches, a dirt track, stones
---------------------------------------------------------------------------
local function field(g, o)
  local W, H = g.W, g.H
  for y = 0, H - 1 do
    for x = 0, W - 1 do
      local patch = (noise(x // 3, y // 3, 1) + noise(x // 7, y // 5, 2) + noise(x // 13, y // 9, 9)) / 3
      local i = 2 + math.floor(patch * 3)
      local fine = noise(x, y, 3)
      local grain = o.calm and .03 or .07   -- calm: fewer single pixels, a smaller file
      if fine > 1 - grain then i = i + 1 elseif fine < grain then i = i - 1 end
      g[y][x] = C.grass[math.max(1, math.min(i, #C.grass))]
      if noise(x, y, 4) > .985 then g[y][x] = C.tuft end
    end
  end
  -- a dirt track crossing the field, passing near the circle
  for x = 0, W - 1 do
    local cy = o.track + math.sin(x * .045 + .8) * H * .14
    for y = math.floor(cy - 2), math.floor(cy + 2) do
      local d = math.abs(y - cy)
      if d < 1.2 then g.set(x, y, noise(x, y, 5) > .3 and C.dirt or C.dirt2)
      elseif d < 2.2 and noise(x, y, 6) > .5 then g.set(x, y, C.dirt) end
    end
  end
  for k = 1, math.floor(W * H / 700) do
    local x, y = math.floor(noise(k, 1, 7) * W), math.floor(noise(k, 2, 7) * H)
    g.set(x, y, C.rock); g.set(x + 1, y, C.rock_lo); g.set(x, y + 1, C.rock_lo)
  end
end

-- round tree crowns seen from above, with their shadows
local function trees(g, list)
  for _, t in ipairs(list) do
    local tx, ty, r = t[1], t[2], t[3]
    for y = -r, r do for x = -r, r do
      if x * x + y * y <= r * r then g.set(tx + x + 2, ty + y + 2, C.shadow) end
    end end
    for y = -r, r do for x = -r, r do
      local d = x * x + y * y
      if d <= r * r then
        local n = noise(tx + x, ty + y, 8)
        local c = C.canopy
        if x + y < -r * .4 and n > .3 then c = C.canopy_hi elseif n > .55 then c = C.canopy2 end
        if d > (r - 1) * (r - 1) and n > .6 then c = C.outline end
        g.set(tx + x, ty + y, c)
      end
    end end
  end
end

---------------------------------------------------------------------------
-- The summoning circle: scorched grass, a glow, two rings, a star, candles
---------------------------------------------------------------------------
local function ritual(g, o)
  local cx, cy, r = o.cx, o.cy, o.r
  local k = o.tilt or .78          -- almost from above: the circle is only slightly squashed
  local function at(t, rr) return cx + math.cos(t) * rr, cy + math.sin(t) * rr * k end
  -- the light it throws on the grass, fading out; scorched earth inside
  for y = math.floor(cy - r * 2), math.ceil(cy + r * 2) do
    for x = math.floor(cx - r * 2.2), math.ceil(cx + r * 2.2) do
      local d = math.sqrt(((x - cx) / r) ^ 2 + ((y - cy) / (r * k)) ^ 2)
      if d > 1 and d < 2.1 and noise(x, y, 12) > (d - 1) * .9 then
        g.set(x, y, C.glow[1 + math.floor(noise(x, y, 13) * 3)])
      elseif d <= 1 then
        local n = noise(x, y, 14)
        if d < .45 and n > d * 1.6 then g.set(x, y, n > .8 and C.ember_floor2 or C.ember_floor)
        else g.set(x, y, n > .35 and C.scorch or C.scorch2) end
      end
    end
  end
  -- outer ring, broken inner ring, sigil ring
  local steps = math.floor(r * 8)
  for s = 0, steps do
    local t = s / steps * 2 * math.pi
    local x, y = at(t, r)
    g.set(x, y, noise(s, 1, 15) > .25 and C.ring or C.ring_hi)
    x, y = at(t, r - 1)
    if noise(s, 2, 15) > .55 then g.set(x, y, C.ring_lo) end
  end
  -- the five-pointed star
  local pts = {}
  for i = 0, 4 do pts[i] = { at(-math.pi / 2 + i * 2 * math.pi / 5, r - 1.5) } end
  for i = 0, 4 do
    local a, b = pts[i], pts[(i + 2) % 5]
    local n = math.floor(math.max(math.abs(b[1] - a[1]), math.abs(b[2] - a[2])))
    for s = 0, n do
      g.set(a[1] + (b[1] - a[1]) * s / n, a[2] + (b[2] - a[2]) * s / n, s % 5 == 2 and C.sigil or C.sigil_lo)
    end
  end
  -- candles just outside the star's points
  for i = 0, 4 do
    local x, y = at(-math.pi / 2 + i * 2 * math.pi / 5, r + 1.6)
    g.set(x, y, C.flame); g.set(x, y + 1, C.ring_hi)
  end
end

---------------------------------------------------------------------------
-- The figures, tiny and far away
---------------------------------------------------------------------------
local KNIGHT = {
  "....s....",
  "....s....",
  "...KsK...",
  "..KhhhK..",
  ".KSHhHSK.",
  ".KSAAASK.",
  "..KAAAK..",
  "..CCCCC..",
  ".CCcCcCC.",
  "..CcCcC..",
  "...K.K...",
}
local KNIGHT_PAL = { K = C.outline, h = C.steel_hi, H = C.steel, S = C.steel_lo, A = C.steel, s = C.steel_hi,
                     C = C.cape, c = C.cape_lo }

local FIEND = {
  ".....h...h.....",
  ".....hKKKh.....",
  "......KrK......",
  "...W.KRPRK.W...",
  "..WWKKRRRKKWW..",
  ".WwWKRRRRRKWwW.",
  "WWw.KRKRKRK.wWW",
  "Ww..KRKRKRK..wW",
  "W...KRRRRRK...W",
  "w....KRRRK....w",
  ".....KRKRK.....",
  "....KRK.KRK....",
}
local FIEND_PAL = { K = C.outline, h = C.horn, R = C.skin, r = C.skin_hi, P = C.purple, W = C.wing, w = C.wing_lo }

local function figures(g, o)
  local fx, fy = math.floor(o.cx - #FIEND[1] / 2 + .5), math.floor(o.cy - #FIEND / 2)
  shadow(g, FIEND, fx, fy, 2, 2)
  sprite(g, FIEND, FIEND_PAL, fx, fy, C.aura)   -- lit from below by the circle
  local kx, ky = o.knight[1], o.knight[2]
  shadow(g, KNIGHT, kx, ky, 2, 1)
  sprite(g, KNIGHT, KNIGHT_PAL, kx, ky, C.outline)
end

-- o: cx, cy, r (the circle), tilt, knight = { x, y }, track (y of the dirt
--    road), trees = { { x, y, r }, ... }
function art.field(W, H, o)
  local g = canvas(W, H)
  field(g, o)
  ritual(g, o)
  trees(g, o.trees or {})
  figures(g, o)
  return g
end

-- the grid as an SVG: one stroked <path> per colour, one segment per
-- horizontal run, which keeps the file small enough to inline on the shelf
function art.svg(g, attrs)
  local runs, colours = {}, {}
  for y = 0, g.H - 1 do
    local x = 0
    while x < g.W do
      local c = g[y][x]
      local x2 = x
      while x2 + 1 < g.W and g[y][x2 + 1] == c do x2 = x2 + 1 end
      if c then
        if not runs[c] then runs[c] = {}; colours[#colours + 1] = c end
        local r = runs[c]
        r[#r + 1] = string.format("M%d %d.5h%d", x, y, x2 - x + 1)
      end
      x = x2 + 1
    end
  end
  local out = { string.format('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %d %d" width="%d" height="%d" shape-rendering="crispEdges"%s>',
    g.W, g.H, g.W, g.H, attrs or "") }
  for _, c in ipairs(colours) do
    out[#out + 1] = string.format('<path stroke="%s" d="%s"/>', c, table.concat(runs[c]))
  end
  out[#out + 1] = "</svg>"
  return table.concat(out)
end

return art
