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
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getAccount('bank').money)
end)
