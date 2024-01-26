RegisterServerEvent("Ramoune:parachutebuy")
AddEventHandler("Ramoune:parachutebuy", function(price)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeMoney(price)

    
    xPlayer.addInventoryItem('parachute', 1)

end)    