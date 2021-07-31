local isOpen = false

CreateThread(function()
    while isOpen do
        DisableControlAction(0, 322, true)
    end
end)

RegisterNUICallback('close', function(_, cb)
    if isOpen then
        isOpen = false
        SetNuiFocus(false, false)
    end
    cb({})
end)

RegisterNUICallback('setCoords', function(data, cb)
    if isOpen then
        SetNewWaypoint(tonumber(data.x), tonumber(data.y))
        exports['t-notify']:Alert({
            style = 'success', 
            message = 'Se ha marcado la localizacion a la llamada #' .. data.id
        })
    end
    cb({})
end)

RegisterCommand(Config.openDispatch, function()
    if not isOpen then
        if not IsEntityDead(PlayerPedId()) then
            if ESX.PlayerData.job.name == "police" then
                isOpen = true
                SendNUIMessage({
                    action = 'open'
                })
                SetNuiFocus(true, true)
            else
                exports['t-notify']:Alert({
                    style = 'error', 
                    message = 'No eres policia'
                })
            end
        end
    end
end)

RegisterKeyMapping(Config.openDispatch, Config.openDispatchDesc, 'keyboard', Config.openDispatchKey)