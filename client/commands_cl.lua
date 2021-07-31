RegisterCommand(Config.stealVehCommand, function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false)
	if vehicle ~= 0 then
		local coords = GetEntityCoords(ped)
		local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
		local plate = GetVehicleNumberPlateText(vehicle)
		local street = getStreet(ped)
		local primary, secondary = GetVehicleColor(vehicle)
		primary = Config['ColorNames'][tostring(primary)]
		secondary = Config['ColorNames'][tostring(secondary)]
		TriggerServerEvent('sunset:setVehicleNoti', model, plate, street, primary, secondary, 'police')
		TriggerServerEvent('sunset:beginServerBlips', 'forzar')
		registerNewSlide('Se veria una persona robando un' .. model, model, coords.x, coords.y)
	else
		exports['t-notify']:Alert({
			style  =  'error',
			message  =  'No estas en un vehiculo'
		})
	end
end)