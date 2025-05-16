--[[
    https://github.com/overextended/er_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

function lib.getLocaleKey()
  return GetConvar('er:locale', 'en')
end
