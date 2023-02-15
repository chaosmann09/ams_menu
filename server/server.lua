ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('ams_menu:getJob', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    cb(xPlayer.getJob().label, xPlayer.getJob().grade_label)

end)

ESX.RegisterServerCallback('ams_menu:getMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    cb(xPlayer.getMoney())
end)

ESX.RegisterServerCallback('ams_menu:getBank', function(source, cb)
    local players = GetPlayers()
    local data = {}
    for k, playerid in pairs(players) do 
        local xPlayer = ESX.GetPlayerFromId(playerid)
        data[#data+1] = {
            name     = xPlayer.get('bank'), 
        }
    end
    cb(data)
end)
