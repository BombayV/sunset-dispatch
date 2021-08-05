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