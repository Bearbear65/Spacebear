
--- Utilities for Spacebear
-- Created by Olsken on 6/6/2020

local util = {}

--- Converts hex to rgb
function util.hex(hex)
  assert(type(hex) == "string")
  assert(hex:match("^#?%x%x%x%x%x%x$"))

  local rgb = {}
  hex = hex:match("^.") == "#" and hex:sub(2) or hex
  for value in hex:gmatch("..") do
    rgb[#rgb + 1] = tonumber(value, "16")
  end
  return rgb[1], rgb[2], rgb[3]
end

function util.function_table(t, fname, ...)
  assert(type(t) == "table")
  assert(type(fname) == "string")

  if t[fname] then
    return t[fname](...)
  end
end

function util.quick_copy(t)
  return {table.unpack(t)}
end

return util
