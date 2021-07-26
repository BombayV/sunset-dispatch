-- Functions
function beginBlipRemoval(curBlip)
	local oldBlip = curBlip
	Wait(1000)
	RemoveBlip(oldBlip)
end

function getStreet(ped)
	local coords = GetEntityCoords(ped)
	local stHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	if stHash ~= nil then
		local stName = GetStreetNameFromHashKey(stHash)
		return stName
	else
		return 'Sin nombre'
	end
end

function endCurrentCall(id)
	exports['t-notify']:Persist({
		id = id,
		step = 'end'
	})
end