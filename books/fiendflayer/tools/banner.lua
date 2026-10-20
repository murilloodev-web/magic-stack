-- tools/banner.lua — the banner on the book's cover page (192×72 pixels):
-- an open field at night, seen almost from above, with a summoning circle,
-- a fiend standing in it and a knight watching from a distance.
-- build.lua writes it to banner.svg.

local art = dofile("tools/art.lua")
return function()
  return art.svg(art.field(192, 72, {
    cx = 82, cy = 34, r = 19, knight = { 132, 38 }, track = 56,
    trees = { { 8, 10, 6 }, { 20, 4, 4 }, { 176, 14, 7 }, { 186, 30, 5 }, { 160, 62, 5 }, { 30, 64, 4 } },
  }))
end
