-- Writes a plain Lua value (tables, strings, numbers, booleans) as Lua source
-- that `dofile` can read back. Used for build manifests.
local function ser(v, ind)
  local t = type(v)
  if t == "string" then return string.format("%q", v)
  elseif t == "number" or t == "boolean" or t == "nil" then return tostring(v)
  elseif t ~= "table" then error("serialize: cannot write a " .. t) end
  local pad, out = ind .. "  ", {}
  local n = #v
  for i = 1, n do out[#out + 1] = pad .. ser(v[i], pad) end
  local keys = {}
  for k in pairs(v) do
    if not (math.type(k) == "integer" and k >= 1 and k <= n) then keys[#keys + 1] = k end
  end
  table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
  for _, k in ipairs(keys) do
    local key = (type(k) == "string" and k:match("^[%a_][%w_]*$")) and k or ("[" .. ser(k, pad) .. "]")
    out[#out + 1] = pad .. key .. " = " .. ser(v[k], pad)
  end
  if #out == 0 then return "{}" end
  return "{\n" .. table.concat(out, ",\n") .. "\n" .. ind .. "}"
end
return function(v) return "return " .. ser(v, "") .. "\n" end
