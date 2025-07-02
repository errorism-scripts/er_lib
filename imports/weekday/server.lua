---@diagnostic disable-next-line: duplicate-set-field
function lib.weekday()
  return os.date('%w', os.time())
end

return lib.weekday
