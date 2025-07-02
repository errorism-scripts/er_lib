local DEFAULT_DURATION = 3000

local hold_time = {}
---@param padIndex number
---@param control number
---@param duration? number
lib.isKeyHold = function(padIndex, control, duration)
  duration = duration or DEFAULT_DURATION
  if IsControlJustPressed(padIndex, control) then hold_time[control] = GetGameTimer() end

  local start_time = hold_time[control]
  if start_time then
    local elapsed = GetGameTimer() - start_time
    if elapsed >= duration then
      hold_time[control] = nil
      return true
    end
  end

  if IsControlJustReleased(padIndex, control) then hold_time[control] = nil end

  return false
end

return lib.isKeyHold
