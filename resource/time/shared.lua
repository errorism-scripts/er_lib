---@class lib.time.date
---@field wday number
---@field yday number
---@field year number
---@field month number
---@field day number
---@field hour number
---@field min number
---@field sec number

local context = IsDuplicityVersion()

---@class lib.time
---@field on_connect lib.time.date
local Time = {}
Time.__index = Time

function Time.new()
  local self = setmetatable({}, Time)
  return self
end

function Time:get_on_connect()
  return self.on_connect
end

---@return lib.time.date
function Time:get_current()
  if context then
    return os.date '*t' --[[@as lib.time.date]]
  end

  local p = promise.new()
  RegisterRawNuiCallback('time_callback', function(data, cb)
    p:resolve(data)
    cb(true)
    UnregisterRawNuiCallback 'time_callback'
  end)

  return Citizen.Await(p)
end

function Time:is_weekend()
  local day = self:get_current().wday
  return day == 1 or day == 7
end

lib.time = Time.new()
