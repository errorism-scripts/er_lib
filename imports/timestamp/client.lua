local base = GlobalState['er_lib:time']
local decompressd = tostring(lib.base62:decompress(base))
local base_timestamp = tonumber(decompressd:sub(1, 10))
local floor = math.floor

function lib.timestamp()
  local second = floor(GetGameTimer() / 1000)
  return base_timestamp + second
end
