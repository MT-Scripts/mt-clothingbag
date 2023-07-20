local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('mt-clothingbag:client:openBag', function()
    QBCore.Functions.Progressbar('name_here', 'PUTTING BAG ON FLOOR...', 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'random@domestic',
        anim = 'pickup_low',
        flags = 16,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerEvent('mt-clothingbag:client:spawnBag')
    end)
end)

RegisterNetEvent('mt-clothingbag:client:spawnBag', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = `prop_big_bag_01`
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    local obj = CreateObject(model, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(obj)
    SetEntityAsMissionEntity(obj)

    Wait(500)

    TriggerEvent('mt-clothingbag:client:openBag2', obj)
end)

RegisterNetEvent('mt-clothingbag:client:openBag2', function(obj)
    QBCore.Functions.Progressbar('name_here', 'OPENING BAG...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',
        flags = 16,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerEvent('mt-clothingbag:client:progressDespawnBag', obj)
    end)
end)

RegisterNetEvent('mt-clothing:client:openMenu', function()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('mt-clothingbag:client:progressDespawnBag', function(obj)
    QBCore.Functions.Progressbar('taking_cloth', 'TAKING CLOTHES FROM BAG...', 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'random@domestic',
        anim = 'pickup_low',
        flags = 16,
    }, {}, {}, function()

        Wait(500)

        QBCore.Functions.Progressbar('picking_bag', 'PICKING UP BAG...', 2000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'random@domestic',
            anim = 'pickup_low',
            flags = 16,
        }, {}, {}, function()
            TriggerEvent('mt-clothingbag:client:despawnBag', obj)
        end)
    end)
end)

RegisterNetEvent('mt-clothingbag:client:despawnBag', function(obj)
    DeleteObject(obj)
    TriggerServerEvent('mt-clothingbag:server:removeBag')
    TriggerEvent('mt-clothing:client:openMenu')
end)
