-- Minimal JSON encoder (no decoder needed). Tables with a contiguous 1..n
-- integer sequence become arrays; everything else becomes an object with
-- keys sorted, so output is stable between builds.

local json = {}

local ESC = { ['"'] = '\\"', ['\\'] = '\\\\', ['\b'] = '\\b', ['\f'] = '\\f',
              ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t' }

local function str(s)
  return '"' .. s:gsub('[%c"\\]', function(c)
    return ESC[c] or string.format("\\u%04x", c:byte())
  end) .. '"'
end

local function is_array(t)
  local n = 0
  for _ in pairs(t) do n = n + 1 end
  for i = 1, n do if t[i] == nil then return false end end
  return true, n
end

local function enc(v, indent, depth)
  local t = type(v)
  if v == nil or v == json.null then return "null"
  elseif t == "boolean" then return tostring(v)
  elseif t == "number" then
    if v ~= v or v == math.huge or v == -math.huge then error("json: cannot encode " .. tostring(v)) end
    return math.type(v) == "integer" and tostring(v) or string.format("%.14g", v)
  elseif t == "string" then return str(v)
  elseif t == "table" then
    local pad = indent and ("\n" .. string.rep(indent, depth + 1)) or ""
    local close = indent and ("\n" .. string.rep(indent, depth)) or ""
    local sep = indent and ": " or ":"
    local arr, n = is_array(v)
    if arr and n > 0 then
      local out = {}
      for i = 1, n do out[i] = pad .. enc(v[i], indent, depth + 1) end
      return "[" .. table.concat(out, ",") .. close .. "]"
    end
    local keys = {}
    for k in pairs(v) do
      if type(k) ~= "string" then error("json: object keys must be strings, got " .. type(k)) end
      keys[#keys + 1] = k
    end
    if #keys == 0 then
      local mt = getmetatable(v)
      return (mt and mt.__json_array) and "[]" or "{}"
    end
    table.sort(keys)
    local out = {}
    for i, k in ipairs(keys) do out[i] = pad .. str(k) .. sep .. enc(v[k], indent, depth + 1) end
    return "{" .. table.concat(out, ",") .. close .. "}"
  else
    error("json: cannot encode a " .. t)
  end
end

json.null = setmetatable({}, { __tostring = function() return "null" end })

-- json.encode(value [, indent])  e.g. json.encode(t, "  ")
function json.encode(v, indent) return enc(v, indent, 0) end

-- Empty arrays: mark a table so it encodes as [] even when empty.
function json.array(t) return setmetatable(t or {}, { __json_array = true }) end

return json
