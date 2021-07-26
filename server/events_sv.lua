ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local timeout = false

RegisterNetEvent('sunset:setVehicleNoti', function(model, plate, street, primary, secondary, job)
    local source <const> = source
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == job then
            local coords = GetEntityCoords(GetPlayerPed(source))
            local targetCoords = GetEntityCoords(GetPlayerPed(xPlayers[i]))
            local distance = #(coords - targetCoords)
            TriggerClientEvent('t-notify:client:Custom', xPlayers[i], {
                style  =  'info',
                duration  =  10000,
                title  =  'Robo de Vehiculo',
                message  =  '**~g~Modelo~g~: **' .. model .. '\n**~g~Placa~g~: **' .. plate .. '\n**~g~Calle~g~: **' .. street .. '\n**~g~Color Primario~g~: **' .. primary .. '\n**~g~Color Secundario~g~: **' .. secondary.. '\n **~r~Distancia~r~:** ' .. math.floor(distance) ..  'm\nPresiona [E] para aceptar',
                sound  =  true
            })
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
            print(actualJob)
            local coords = GetEntityCoords(GetPlayerPed(source))
            local targetCoords = GetEntityCoords(GetPlayerPed(xPlayers[i]))
            local distance = #(coords - targetCoords)
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
                message  =  'El oficial ' .. name.. ' ha atendido la llamada!',
                sound  =  true
            })
        end
    end
end)

function randomId()
    math.randomseed(os.time())
    return string.gsub("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx", "[xy]", function(c)
        return string.format("%x", (c == "x") and math.random(0, 0xf) or math.random(8, 0xb))
    end)
end