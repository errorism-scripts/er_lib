--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

if GetConvarInt('er:txAdminNotifications', GetConvarInt('ox:txAdminNotifications', 0)) == 0 then return end

if GetConvarInt('txAdmin-hideDefaultAnnouncement', 0) == 1 then
  AddEventHandler('txAdmin:events:announcement', function(eventData)
    TriggerClientEvent('er_lib:notify', -1, {
      id = 'txAdmin:announcement',
      title = locale('txadmin_announcement', eventData.author),
      description = eventData.message,
      duration = 5000,
    })
  end)
end

if GetConvarInt('txAdmin-hideDefaultDirectMessage', 0) == 1 then
  AddEventHandler('txAdmin:events:playerDirectMessage', function(eventData)
    TriggerClientEvent('er_lib:notify', eventData.target, {
      id = 'txAdmin:playerDirectMessage',
      title = locale('txadmin_dm', eventData.author),
      description = eventData.message,
      duration = 5000,
    })
  end)
end

if GetConvarInt('txAdmin-hideDefaultWarning', 0) == 1 then
  AddEventHandler('txAdmin:events:playerWarned', function(eventData)
    TriggerClientEvent('er_lib:alertDialog', eventData.target, {
      header = locale('txadmin_warn', eventData.author),
      content = locale('txadmin_warn_content', eventData.reason, eventData.actionId),
      centered = true,
    })
  end)
end

if GetConvarInt('txAdmin-hideDefaultScheduledRestartWarning', 0) == 1 then
  AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    TriggerClientEvent('er_lib:notify', -1, {
      id = 'txAdmin:scheduledRestart',
      title = locale 'txadmin_scheduledrestart',
      description = eventData.translatedMessage,
      duration = 5000,
    })
  end)
end
