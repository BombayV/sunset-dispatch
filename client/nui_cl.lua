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

RegisterCommand(Config.openDispatch, function()
    if not isOpen then
        if not IsEntityDead(PlayerPedId()) then
            isOpen = true
            SendNUIMessage({
                action = 'open'
            })
            SetNuiFocus(true, true)
        end
    end
end)

RegisterKeyMapping(Config.openDispatch, Config.openDispatchDesc, 'keyboard', Config.openDispatchKey)