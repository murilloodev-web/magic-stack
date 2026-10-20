-- tools/banner.lua — the banner on the book's cover page (192×72 pixels):
-- Avernus at dusk, and the FiendFlayer rising out of the river of fire.
-- build.lua writes it to banner.svg.

local art = dofile("tools/art.lua")
return function()
  return art.svg(art.scene(192, 72, { cx = 132, top = 10 }))
end
