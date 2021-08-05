ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
GlobalState.callNumber = 0

RegisterNetEvent('sunset:setVehicleNoti', function(model, plate, street, primary, job)
    local source <const> = source
    local xPlayers = ESX.GetPlayers()
    GlobalState.callNumber = GlobalState.callNumber + 1
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == job then
            local coords = GetEntityCoords(GetPlayerPed(source))
            local targetCoords = GetEntityCoords(GetPlayerPed(xPlayers[i]))
            local distance = #(coords - targetCoords)
            if primary == nil then
                primary = 'No se encontro el color'
            end
            if model == 'NULL' then
                model = 'Sin nombre'
            end
            if not inCall then
                inCall = true
                TriggerClientEvent('t-notify:client:Persist', xPlayers[i], {
                    id = 'policePlayerCreation',
                    step = 'start',
                    options = {
                        style = 'info',
                        title  =  'Robo de Vehiculo | Index: ' .. GlobalState.callNumber,
                        message  =  '**~g~Modelo~g~: **' .. model .. '\n**~g~Placa~g~: **' .. plate .. '\n**~g~Calle~g~: **' .. street .. '\n**~g~Color Primario~g~: **' .. primary .. '\n **~r~Distancia~r~:** ' .. math.floor(distance) ..  'm\nPresiona [E] para aceptar\n Presiona [Q] para cancelar',
                        sound  =  true
                    }
                })
                TriggerClientEvent('sunset:setNewWaypoint', xPlayers[i], coords.x, coords.y, coords.z, 'forzar')
                return
            elseif inCall then
                TriggerClientEvent('sunset:updateWaypoint', xPlayers[i])
                TriggerClientEvent('t-notify:client:Persist', xPlayers[i], {
                    id = 'policePlayerCreation',
                    step = 'update',
                    options = {
                        style = 'info',
                        title  =  'Robo de Vehiculo | Index: ' .. GlobalState.callNumber,
                        message  =  '**~g~Modelo~g~: **' .. model .. '\n**~g~Placa~g~: **' .. plate .. '\n**~g~Calle~g~: **' .. street .. '\n**~g~Color Primario~g~: **' .. primary .. '\n **~r~Distancia~r~:** ' .. math.floor(distance) ..  'm\nPresiona [E] para aceptar\n Presiona [Q] para cancelar',
                        sound  =  true
                    }
                })
                TriggerClientEvent('sunset:setNewWaypoint', xPlayers[i], coords.x, coords.y, coords.z, 'forzar')
            end
        end
    end
end)

RegisterNetEvent('sunset:beginServerBlips', function(job)
    local actualJob = nil
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if job == 'forzar' then
            actualJob = 'police'
        end
        if xPlayer.job.name == actualJob then
            local coords = GetEntityCoords(GetPlayerPed(source))
            local targetCoords = GetEntityCoords(GetPlayerPed(xPlayers[i]))
            TriggerClientEvent('sunset:setNewWaypoint', xPlayers[i], coords.x, coords.y, coords.z, job)
        end
    end
end)

RegisterNetEvent('sunset:getReceiverName', function()
    local source <const> = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('t-notify:client:Custom', xPlayers[i], {
                style  =  'success',
                duration  =  3000,
                title  =  'LSPD Respuesta',
                message  =  'El oficial ' .. name.. ' ha atendido la llamada #' .. GlobalState.callNumber,
                sound  =  true
            })
        end
    end
end)

RegisterNetEvent('sunset:updateCall', function()
    if inCall then
        inCall = false
    end
end)

RegisterNetEvent('sunset:updateDispatch', function(type, text, model, primary, x, y)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('sunset:registerNewSlide', xPlayers[i], type, text, model, primary, x, y, GlobalState.callNumber)
        end
    end
end)