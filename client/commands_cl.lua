RegisterCommand(Config.stealVehCommand, function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false)
	if vehicle ~= 0 then
		local coords = GetEntityCoords(ped)
		local model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
		local plate = GetVehicleNumberPlateText(vehicle)
		local street = getStreet(ped)
		local primary = GetVehicleColor(vehicle)
		primary = Config['ColorNames'][tostring(primary)]
		if model == 'NULL' then
			model = 'Sin nombre'
		end
		TriggerServerEvent('sunset:setVehicleNoti', model, plate, street, primary, 'police')
		TriggerServerEvent('sunset:updateDispatch', 'veh', 'Se veria una persona robando un ' .. model .. ' con la placa ' .. plate, model, primary, coords.x, coords.y)
	else
		exports['t-notify']:Alert({
			style  =  'error',
			message  =  'No estas en un vehiculo'
		})
	end
end)