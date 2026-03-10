local API = exports.tp_libs:getAPI()

local DoorsList = {}
local LoadedDoorsList = false

-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

local function GetTableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

local LoadExistingDoorlockLocations = function ()

	for _, result in ipairs(Config.DoorsList) do
		DoorsList[_] = {}
		DoorsList[_] = result
	end

	LoadedDoorsList = true
end

-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end

	LoadExistingDoorlockLocations()

end)


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    DoorsList = nil
end)

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterServerEvent("tp_doorlocks:server:requestDoorlocks")
AddEventHandler("tp_doorlocks:server:requestDoorlocks", function()
	local _source = source

	while not LoadedDoorsList do
		Wait(1000)
	end

	if GetTableLength(DoorsList) <= 0 then
		return
	end

	local job = API.getJob(_source)

	TriggerClientEvent("tp_doorlocks:client:loadDoorsList", _source, DoorsList, job)
end)

RegisterServerEvent('tp_doorlocks:server:updateState')
AddEventHandler('tp_doorlocks:server:updateState', function(doorID, state)

	if type(doorID) ~= 'number' then
		return
	end

	TriggerClientEvent('tp_doorlocks:client:setState', -1, doorID, state)
end)
