local locales, localesN = lib.getFilesInDirectory('locales', '%.json')

for i = 1, localesN do
  local key = locales[i]
  local value = key:gsub('%.json', '')
  local label = (json.decode(LoadResourceFile(lib.name, ('locales/%s'):format(key)) or '') or '').language or value
  locales[i] = { label = label, value = value }
end

table.sort(locales, function(a, b)
  return a.label < b.label
end)

GlobalState['er_lib:locales'] = locales

local floor = math.floor
local now = os.time()
local second = floor(GetGameTimer() / 1000)
local timestamp = tostring(now - second)
local wday = tostring(os.date('%w', now))
local result = lib.base62:compress(timestamp .. wday)
GlobalState['er_lib:time'] = result
