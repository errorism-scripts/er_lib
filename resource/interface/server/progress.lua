--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

local maxProps = GetConvarInt('er:progressPropLimit', GetConvarInt('ox:progressPropLimit', 2))

---@param props ProgressPropProps | ProgressPropProps[] | nil
RegisterNetEvent('er_lib:progressProps', function(props)
    if type(props) == 'table' then
        props = #props > maxProps and { table.unpack(props, 1, maxProps) } or props
    else
        props = nil
    end

    Player(source).state:set('lib:progressProps', props, true)
end)
