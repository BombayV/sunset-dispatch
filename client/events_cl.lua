ESX = nil
local blip = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(250)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	TriggerEvent('chat:addSuggestion', Config.stealVehCommand, 'Envia un msg a la policia de robo de vehiculo', {})
	TriggerEvent('chat:addSuggestion', '/entorno', 'Envia un msg de entorno', {
		{ name="mensaje", help="Descripcion de lo occurido" }
	})
	if ESX.PlayerData.job.name == 'police' then
		TriggerEvent('chat:addSuggestion', Config.openDispatch, Config.openDispatchDesc, {})
	end
end)

local function beginBlipRemoval(curBlip)
	local oldBlip = curBlip
	Wait(1000)
	RemoveBlip(oldBlip)
end

local currentCall = true

-- Events for waypoints
RegisterNetEvent('sunset:setNewWaypoint', function(x, y, z, job)
	currentCall = true
	local isWaypoint = false
	local ped = PlayerPedId()
	CreateThread(function()
		blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, Config[job].sprite)
		SetBlipScale(blip, Config[job].scale)
		SetBlipColour(blip, Config[job].color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(Config[job].text)
		EndTextCommandSetBlipName(blip)
		while currentCall do
			if IsControlJustReleased(1, 38) and not isWaypoint then
				exports['t-notify']:Persist({
					id = 'policePlayerCreation',
					step = 'end'
				})
				TriggerServerEvent('sunset:updateCall')
				TriggerServerEvent('sunset:getReceiverName', ped)
				SetNewWaypoint(x, y)
				RemoveBlip(blip)
				blip = nil
				isWaypoint = true
				currentCall = false
				break
			elseif IsControlJustReleased(1, 44) and not isWaypoint then
				exports['t-notify']:Persist({
					id = 'policePlayerCreation',
					step = 'end'
				})
				TriggerServerEvent('sunset:updateCall')
				RemoveBlip(blip)
				isWaypoint = true
				currentCall = false
				break
			end
			Wait(4)
		end
	end)
	if blip ~= nil then
		beginBlipRemoval(blip)
	end
end)

RegisterNetEvent('sunset:updateWaypoint', function()
	if currentCall then
		currentCall = false
		blip = nil
	end
end)

RegisterNetEvent('sunset:registerNewSlide', function(type, text, model, primary, x, y, title)
	SendNUIMessage({
		action = 'insertData',
		type = type,
		text = text,
		model = model,
		primary = primary,
		coordsX = x,
		coordsY = y,
		title = title
	})
end)

--Updating the jobs and info
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)