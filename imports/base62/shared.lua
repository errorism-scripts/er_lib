local BASE62_DIGITS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

local M = {}
M.__index = M

function M.new()
  return setmetatable({}, M)
end

function M:compress(n)
  n = tonumber(n)
  if not n then error(('toBase62(): expected a numeric value, got %q'):format(tostring(n))) end

  if n < 0 or n ~= math.floor(n) then
    error(('toBase62(): expected a nonnegative integer, got %s'):format(tostring(n)))
  end

  if n == 0 then return '0' end

  local s = ''
  while n > 0 do
    local remainder = n % 62
    s = BASE62_DIGITS:sub(remainder + 1, remainder + 1) .. s
    n = math.floor(n / 62)
  end

  return s
end

function M:decompress(str)
  if type(str) ~= 'string' or #str == 0 then
    error(('fromBase62(): expected a nonempty string, got %q'):format(tostring(str)))
  end

  local result = 0
  for i = 1, #str do
    local ch = str:sub(i, i)
    local idx = BASE62_DIGITS:find(ch, 1, true)
    if not idx then error(('fromBase62(): invalid Base-62 character %q in %q'):format(ch, str)) end
    result = result * 62 + (idx - 1)
  end

  return result
end

lib.base62 = M.new()
