local ENCODING = {
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'J',
  'K',
  'M',
  'N',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'V',
  'W',
  'X',
  'Y',
  'Z',
}
local BASE = #ENCODING
local TIME_LEN = 10
local RANDOM_LEN = 16

local floor = math.floor
local random = math.random
local concat = table.concat

---@class er_lib.uuid
---@field sv_uuid string? uuid for server
local M = {}
M.__index = M
M.__call = function(self)
  return self:get()
end

function M.new()
  local self = setmetatable({
    sv_uuid = GetConvar('er:sv_uuid', ''),
  }, M)

  self:__init()
  return self
end

function M:__init()
  if not self.sv_uuid or self.sv_uuid == '' then
    print '^1[ERROR] er:sv_uuid not set, some scripts may not work as expected.^7'
    print(('Please add ^2`setr er:sv_uuid "%s"`^7 to your server cfg.'):format(self:get()))
    self.sv_uuid = nil
  end
end

---@return number
function M:__now_ms()
  ---@diagnostic disable-next-line: param-type-mismatch
  return os.time() * 1000
end

---@return string
function M:get()
  local t = self:__now_ms()
  local parts = {}
  for i = TIME_LEN, 1, -1 do
    local idx = t % BASE
    parts[i] = ENCODING[idx + 1]
    t = floor(t / BASE)
  end
  for i = TIME_LEN + 1, TIME_LEN + RANDOM_LEN do
    parts[i] = ENCODING[random(1, BASE)]
  end

  return concat(parts)
end

---@return string|nil
function M:get_server_uuid()
  return self.sv_uuid
end

lib.uuid = M.new()
return lib.uuid
