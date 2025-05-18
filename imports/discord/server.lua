---@class ERDiscord.webhook.payload
---@field webhook number
---@field playerId number
---@field targetId number
---@field title string
---@field message ...

---@class ERDiscord.identifiers
---@field steam? string
---@field discord? string
---@field xbl? string
---@field live? string
---@field license? string
---@field license2? string
---@field fivem? string
---@field ip? string

---@class ERDiscord
lib.discord = {}

local LOG_INDEX = cache.resource .. '_logs'

---@generic T
---@param fn fun(key): unknown
---@param key string
---@param default? T
---@return T
local function safeGetKvp(fn, key, default)
  local ok, result = pcall(fn, key)

  if not ok then return DeleteResourceKvp(key) end

  return result or default
end

---@type table<string, ERDiscord.webhook.payload >
local queue = safeGetKvp(GetResourceKvpString, LOG_INDEX, {})

---@type table<number, ERDiscord.identifiers>
local playersIdentifier = {}

---@param playerId any
---@return ERDiscord.identifiers
local function genaratePlayerDD(playerId)
  local _data = {
    ['username'] = GetPlayerName(playerId),
  }
  for i = 0, GetNumPlayerIdentifiers(playerId) - 1 do
    local identifier = GetPlayerIdentifier(source, i)
    local prefix = string.sub(identifier, 1, string.find(identifier, ':') - 1)
    _data[prefix] = string.gsub(identifier, prefix .. ':', '')
  end

  playersIdentifier[playerId] = _data

  return _data
end

AddEventHandler('playerDropped', function(_)
  local playerId = source
  playersIdentifier[playerId] = nil
end)

---@param payload ERDiscord.webhook.payload
function lib.discord.webhook(payload)
  local playerId = payload.playerId
  local playerIdentifier = playersIdentifier[playerId] or genaratePlayerDD(playerId)
end

local function backupWebhook()
  SetResourceKvp(LOG_INDEX, json.encode(queue))
end

AddEventHandler('onResourceStop', function(resource)
  if resource == cache.resource then backupWebhook() end
end)

return lib.discord
