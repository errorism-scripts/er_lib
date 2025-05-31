local wday = lib.weekday()
---@diagnostic disable-next-line: duplicate-set-field
function lib.isWeekend()
  return wday == 0 or wday == 6
end
