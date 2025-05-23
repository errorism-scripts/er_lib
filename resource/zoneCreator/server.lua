--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

local function formatNumber(num)
  return tostring(num):gsub(',', '.')
end

local parse = {
  poly = function(data)
    local points = {}
    for i = 1, #data.points do
      points[#points + 1] = ('\t\tvec3(%s, %s, %s),\n'):format(data.points[i].x, data.points[i].y, data.zCoord)
    end

    local pattern
    if data.format == 'function' then
      pattern = {
        'local poly = lib.zones.poly({\n',
        ('\tname = "%s",\n'):format(data.name),
        '\tpoints = {\n',
        ('%s\t},\n'):format(table.concat(points)),
        ('\tthickness = %s,\n'):format(data.height),
        '})\n',
      }
    elseif data.format == 'array' then
      pattern = {
        '{\n',
        ('\tname = "%s",\n'):format(data.name),
        '\tpoints = {\n',
        ('%s\t},\n'):format(table.concat(points)),
        ('\tthickness = %s,\n'):format(data.height),
        '},\n',
      }
    elseif data.format == 'target' then
      pattern = {
        'exports.ox_target:addPolyZone({\n',
        ('\tname = "%s",\n'):format(data.name),
        '\tpoints = {\n',
        ('%s\t},\n'):format(table.concat(points)),
        ('\tthickness = %s,\n'):format(data.height),
        '})\n',
      }
    end

    return table.concat(pattern)
  end,
  box = function(data)
    local pattern
    if data.format == 'function' then
      pattern = {
        'local box = lib.zones.box({\n',
        ('\tname = "%s",\n'):format(data.name),
        ('\tcoords = vec3(%s, %s, %s),\n'):format(
          formatNumber(data.xCoord),
          formatNumber(data.yCoord),
          formatNumber(data.zCoord)
        ),
        ('\tsize = vec3(%s, %s, %s),\n'):format(
          formatNumber(data.width),
          formatNumber(data.length),
          formatNumber(data.height)
        ),
        ('\trotation = %s,\n'):format(formatNumber(data.heading)),
        '})\n',
      }
    elseif data.format == 'array' then
      pattern = {
        '{\n',
        ('\tname = "%s",\n'):format(data.name),
        ('\tcoords = vec3(%s, %s, %s),\n'):format(
          formatNumber(data.xCoord),
          formatNumber(data.yCoord),
          formatNumber(data.zCoord)
        ),
        ('\tsize = vec3(%s, %s, %s),\n'):format(
          formatNumber(data.width),
          formatNumber(data.length),
          formatNumber(data.height)
        ),
        ('\trotation = %s,\n'):format(formatNumber(data.heading)),
        '},\n',
      }
    elseif data.format == 'target' then
      pattern = {
        'exports.ox_target:addBoxZone({\n',
        ('\tname = "%s",\n'):format(data.name),
        ('\tcoords = vec3(%s, %s, %s),\n'):format(data.xCoord, data.yCoord, data.zCoord),
        ('\tsize = vec3(%s, %s, %s),\n'):format(data.width, data.length, data.height),
        ('\trotation = %s,\n'):format(data.heading),
        '})\n',
      }
    end

    return table.concat(pattern)
  end,
  sphere = function(data)
    local pattern
    if data.format == 'function' then
      pattern = {
        'local sphere = lib.zones.sphere({\n',
        ('\tname = "%s",\n'):format(data.name),
        ('\tcoords = vec3(%s, %s, %s),\n'):format(data.xCoord, data.yCoord, data.zCoord),
        ('\tradius = %s,\n'):format(data.height),
        '})\n',
      }
    elseif data.format == 'array' then
      pattern = {
        '{\n',
        ('\tname = "%s",\n'):format(data.name),
        ('\tcoords = vec3(%s, %s, %s),\n'):format(data.xCoord, data.yCoord, data.zCoord),
        ('\tradius = %s,\n'):format(data.height),
        '},\n',
      }
    elseif data.format == 'target' then
      pattern = {
        'exports.ox_target:addSphereZone({\n',
        ('\tname = "%s",\n'):format(data.name),
        ('\tcoords = vec3(%s, %s, %s),\n'):format(data.xCoord, data.yCoord, data.zCoord),
        ('\tradius = %s,\n'):format(data.height),
        '})\n',
      }
    end

    return table.concat(pattern)
  end,
}

RegisterNetEvent('er_lib:saveZone', function(data)
  if not source or not IsPlayerAceAllowed(source, 'command') then return end
  local output = (LoadResourceFile(cache.resource, 'created_zones.lua') or '') .. parse[data.zoneType](data)
  SaveResourceFile(cache.resource, 'created_zones.lua', output, -1)
end)
