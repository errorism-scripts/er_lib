local base = GlobalState['er_lib:time']
local decompressd = tostring(lib.base62:decompress(base))
local wday = tonumber(decompressd:sub(11, 11))

---@diagnostic disable-next-line: duplicate-set-field
function lib.weekday()
  return wday
end

return lib.weekday
