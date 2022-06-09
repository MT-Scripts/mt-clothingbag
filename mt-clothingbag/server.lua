local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("mala_roupas", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-clothingbag:client:PousarMala', source)
    end
end)

RegisterNetEvent('mt-clothingbag:server:RemoverMala', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    Player.Functions.RemoveItem('mala_roupas', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['mala_roupas'], "remove")
end)