-- tools/art.lua — the FiendFlayer pixel art, shared by the banner (on the
-- book's cover page) and the cover on the Magic Stack table.
--
--   local art = dofile("tools/art.lua")
--   art.svg(art.scene(W, H, { cx = ..., top = ... }))
--
-- Everything is deterministic: the same call always draws the same picture.

local art = {}

art.C = {
  outline = "#12070b",
  sky = { "#22070d", "#3a0b14", "#5a1018", "#842019", "#b23a1c", "#d8611f" },
  ember = "#f2a845", spark = "#ffd27a",
  rock = "#1c090e", rock2 = "#2a0f15",
  ground = "#14070b", lava = "#e8642f", lava2 = "#f2a845", lava3 = "#9e2a18",
  red = "#b0222f", red_hi = "#d23a44", red_lo = "#741522",
  purple = "#8a3fc4", purple_lo = "#5f2493", tentacle = "#a75ce8", tentacle_hi = "#c98cf2",
  horn = "#2e1218", horn_hi = "#55303a", eye = "#f2a845", mouth = "#2a0610",
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
  function g.get(x, y) if x >= 0 and x < W and y >= 0 and y < H then return g[y][x] end end
  return g
end

---------------------------------------------------------------------------
-- Avernus: dithered sky, embers, jagged rock, a river of fire
---------------------------------------------------------------------------
local function landscape(g, o)
  local W, H = g.W, g.H
  local horizon = math.floor(H * .66)
  for y = 0, H - 1 do
    local t = math.min(y / horizon, 1) * (#C.sky - 1)
    local i = math.floor(t)
    local f = t - i
    for x = 0, W - 1 do
      -- 2×2 ordered dither between neighbouring bands
      local thr = o.flat and .5 or ({ [0] = { [0] = .2, .7 }, { [0] = .95, .45 } })[y % 2][x % 2]
      g[y][x] = C.sky[math.min(i + (f > thr and 2 or 1), #C.sky)]
    end
  end
  -- far ridge, then near ridge
  for x = 0, W - 1 do
    local far = horizon - 6 - math.floor(4 * math.abs(math.sin(x * .11)) + 3 * noise(x, 1, 7) + 2 * math.sin(x * .031))
    for y = far, H - 1 do g.set(x, y, C.rock2) end
    local near = horizon - 1 - math.floor(3 * math.abs(math.sin(x * .23 + 1.7)) + 3 * noise(x, 2, 9))
    for y = near, H - 1 do g.set(x, y, C.rock) end
  end
  -- the ground and a river of fire winding across it
  local gy = horizon + 4
  for y = gy, H - 1 do for x = 0, W - 1 do g.set(x, y, C.ground) end end
  for x = 0, W - 1 do
    local cy = gy + (H - gy) * .5 + math.sin(x * .07) * (H - gy) * .28
    local w = 1.6 + math.sin(x * .19) * .8
    for y = math.floor(cy - w - 1), math.floor(cy + w + 1) do
      local d = math.abs(y - cy)
      if d <= w then g.set(x, y, d < w * .45 and C.lava2 or C.lava)
      elseif d <= w + 1 and noise(x, y, 3) > .4 then g.set(x, y, C.lava3) end
    end
  end
  -- embers drifting up
  for y = 0, horizon - 2 do
    for x = 0, W - 1 do
      local n = noise(x, y, 11)
      if n > .996 then g[y][x] = C.spark elseif n > .99 then g[y][x] = C.ember end
    end
  end
end

---------------------------------------------------------------------------
-- The FiendFlayer: horns, a bulbous skull, ruby skin with purple creeping
-- in from the edges, tentacles out of the mouth
---------------------------------------------------------------------------
local function figure(g, o)
  local cx, top = o.cx, o.top
  local mask = {}
  local function put(x, y, c)
    x, y = math.floor(x + .5), math.floor(y + .5)
    if x >= 0 and x < g.W and y >= 0 and y < g.H then g[y][x] = c; mask[y * 10000 + x] = true end
  end
  local function ellipse(ex, ey, rx, ry, c)
    for y = math.floor(ey - ry), math.ceil(ey + ry) do
      for x = math.floor(ex - rx), math.ceil(ex + rx) do
        if ((x - ex) / rx) ^ 2 + ((y - ey) / ry) ^ 2 <= 1 then put(x, y, c(x, y)) end
      end
    end
  end
  -- skin: ruby, with purple patches that grow denser toward the extremities
  local body_cx, body_cy = cx, top + 46
  local function skin(x, y)
    local dx, dy = (x - body_cx) / 30, (y - body_cy) / 34
    local edge = math.sqrt(dx * dx + dy * dy)
    -- patches are 2×2 cells, so they read as spots and not as static
    local n = noise(x // 2, y // 2, 5)
    if n < (edge - .62) * 1.6 then return noise(x // 2, y // 2, 4) < .4 and C.purple_lo or C.purple end
    if x <= cx - 6 then return C.red_lo end
    if x >= cx + 3 and x <= cx + 5 and y < top + 36 then return C.red_hi end
    return C.red
  end
  -- shoulders and chest, cut by the bottom edge
  ellipse(cx, top + 62, 31, 15, skin)
  for y = top + 40, top + 54 do for x = cx - 6, cx + 6 do put(x, y, skin(x, y)) end end
  -- pointed ears
  for i = 0, 6 do
    for s = -1, 1, 2 do
      for j = 0, math.max(0, 3 - math.floor(i / 2)) do put(cx + s * (9 + i), top + 27 - math.floor(i / 2) + j, C.purple) end
    end
  end
  -- face, then the bulbous skull above it, wider than the face
  ellipse(cx, top + 30, 9.5, 12, skin)
  ellipse(cx, top + 15, 12, 10, skin)
  -- horns: thick at the root, curling out and up
  for s = -1, 1, 2 do
    local pts = { { 8, 15 }, { 12, 12 }, { 16, 9 }, { 19, 5 }, { 20, 1 }, { 18, -3 }, { 15, -5 } }
    for k = 1, #pts - 1 do
      local a, b = pts[k], pts[k + 1]
      local steps = 8
      for t = 0, steps do
        local x = a[1] + (b[1] - a[1]) * t / steps
        local y = a[2] + (b[2] - a[2]) * t / steps
        local r = 2.6 - k * .36
        for yy = -math.ceil(r), math.ceil(r) do
          for xx = -math.ceil(r), math.ceil(r) do
            if xx * xx + yy * yy <= r * r then
              put(cx + s * (x + xx), top + y + yy, (s * xx > 0 or yy < 0) and C.horn_hi or C.horn)
            end
          end
        end
      end
    end
  end
  -- eyes: half-closed, glowing
  for x = cx - 7, cx + 7 do if math.abs(x - cx) > 1 then put(x, top + 26, C.red_lo) end end
  for _, ex in ipairs({ cx - 6, cx - 5, cx - 4, cx + 4, cx + 5, cx + 6 }) do put(ex, top + 27, C.eye) end
  for _, ex in ipairs({ cx - 5, cx + 5 }) do put(ex, top + 28, C.outline) end
  -- nose and cheekbones
  put(cx, top + 31, C.red_lo); put(cx, top + 32, C.red_lo); put(cx - 1, top + 33, C.red_lo)
  -- the open mouth, and tentacles pouring out of the throat
  for y = top + 35, top + 37 do for x = cx - 3, cx + 3 do put(x, y, C.mouth) end end
  local tentacles = {
    { -3, 26, 0.0 }, { 0, 32, 1.6 }, { 3, 27, 3.1 }, { -6, 18, 4.4 }, { 6, 19, 5.3 },
  }
  for _, t in ipairs(tentacles) do
    local x0, len, phase = t[1], t[2], t[3]
    for i = 0, len do
      local y = top + 37 + i
      local x = cx + x0 * (.5 + i * .06) + math.sin(i * .34 + phase) * (1 + i * .08)
      local w = i < len * .6 and 1 or 0
      put(x - w - 1, y, C.outline); put(x + w + 1, y, C.outline)
      for d = -w, w do put(x + d, y, d == -w and C.tentacle_hi or (d == w and C.purple_lo or C.tentacle)) end
      if i % 3 == 1 and w == 1 then put(x, y, C.tentacle_hi) end
    end
    put(cx + x0 * (.5 + len * .06) + math.sin(len * .34 + phase) * (1 + len * .08), top + 38 + len, C.outline)
  end
  -- outline every pixel of the figure that touches the background
  local edge = {}
  for key in pairs(mask) do
    local y, x = key // 10000, key % 10000
    for _, d in ipairs({ { 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 } }) do
      local nx, ny = x + d[1], y + d[2]
      if not mask[ny * 10000 + nx] and nx >= 0 and nx < g.W and ny >= 0 and ny < g.H then edge[ny * 10000 + nx] = true end
    end
  end
  for key in pairs(edge) do g[key // 10000][key % 10000] = C.outline end
end

function art.scene(W, H, o)
  local g = canvas(W, H)
  landscape(g, o)
  figure(g, o)
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
