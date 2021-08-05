inCall = false

RegisterCommand(Config.policeCommand, function(source, args)
    local source <const> = source
    TriggerClientEvent('t-notify:client:Custom', source, {
        style  =  'info',
        duration  =  3000,
        title  =  'Mensaje Enviado',
        message  =  'Le acaba de llegar un mensaje a la policia',
        sound  =  true
    })
    local xPlayers = ESX.GetPlayers()
    GlobalState.callNumber = GlobalState.callNumber + 1
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            local coords = GetEntityCoords(GetPlayerPed(source))
            local targetCoords = GetEntityCoords(GetPlayerPed(xPlayers[i]))
            local message = 'Sin mensaje'
            local distance = #(coords - targetCoords)
            if args[1] ~= nil then
                message = table.concat(args, " ", 1)
            end
            TriggerClientEvent('sunset:registerNewSlide', xPlayers[i], "player", tostring(message), 'none', 'none', coords.x, coords.y, GlobalState.callNumber)
            if not inCall then
                inCall = true
                TriggerClientEvent('t-notify:client:Persist', xPlayers[i], {
                    id = 'policePlayerCreation',
                    step = 'start',
                    options = {
                        style = 'info',
                        title = 'Entorno LSPD | Index: ' .. GlobalState.callNumber,
                        message = '**~g~Mensaje~g~:**' .. message .. '\n **~r~Distancia~r~:** ' .. math.floor(distance) ..  'm\nPresiona [E] para aceptar\n Presiona [Q] para cancelar',
                        sound = true
                    }
                })
                TriggerClientEvent('sunset:setNewWaypoint', xPlayers[i], coords.x, coords.y, coords.z, 'police')
                return
            elseif inCall then
                TriggerClientEvent('sunset:updateWaypoint', xPlayers[i])
                TriggerClientEvent('t-notify:client:Persist', xPlayers[i], {
                    id = 'policePlayerCreation',
                    step = 'update',
                    options = {
                        style = 'info',
                        title = 'Entorno LSPD | Index: ' .. GlobalState.callNumber,
                        message = '**~g~Mensaje~g~:**' .. message .. '\n **~r~Distancia~r~:** ' .. math.floor(distance) ..  'm\nPresiona [E] para aceptar\n Presiona [Q] para cancelar',
                        sound = true
                    }
                })
                TriggerClientEvent('sunset:setNewWaypoint', xPlayers[i], coords.x, coords.y, coords.z, 'police')
            end
        end
    end
end)