ESX = nil
local blip = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(250)
	end
end)

local function beginBlipRemoval(curBlip)
	local oldBlip = curBlip
	Wait(1000)
	RemoveBlip(oldBlip)
end

-- Events for waypoints
RegisterNetEvent('sunset:setNewWaypoint', function(x, y, z, job)
	local currentCall = true
	local isWaypoint = false
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
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
				endCurrentCall('policePlayerCreation')
				TriggerServerEvent('sunset:getReceiverName', ped)
				SetNewWaypoint(x, y)
				RemoveBlip(blip)
				blip = nil
				isWaypoint = true
				currentCall = false
				break
			elseif IsControlJustReleased(1, 44) and not isWaypoint then
				endCurrentCall('policePlayerCreation')
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

RegisterNetEvent('sunset:registerNewSlide')
AddEventHandler('sunset:registerNewSlide', function(text, model, x, y)
	SendNuiMessage({
		action = 'insertData',
		text = text,
		model = model,
		coordsX = x,
		coordsY = y
	})
end)