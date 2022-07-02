DispatchServices = {
    PoliceAutomobile = 0,
    PoliceAutomobileWaitPulledOver = 0,
    PoliceAutomobileWaitCruising = 0,
    PoliceRoadBlock = 0,
    PoliceRiders = 0,
    PoliceVehicleRequest = 0,
    PoliceHelicopter = 0,
    PoliceBoat = 0,
    SwatAutomobile = 0,
    SwatHelicopter = 0,
    ArmyVehicle = 0,
    FireDepartment = 0,
    AmbulanceDepartment = 0,
    Gangs = 15,
    BikerBackup = 15,
}
updateDataEvent = GetCurrentResourceName() .. ':updateData'
requestDataEvent = GetCurrentResourceName() .. ':requestData'
function tprint (tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
		formatting = string.rep("  ", indent) .. k .. ": "
		if type(v) == "table" then
		print(formatting)
		tprint(v, indent+1)
		elseif type(v) == 'boolean' then
		print(formatting .. tostring(v))      
		else
		print(formatting .. v)
		end
	end
end
function stringSplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
function sortedKeys(query, sortFunction)
    local keys, len = {}, 0
    for k,_ in pairs(query) do
        len = len + 1
        keys[len] = k
    end
    table.sort(keys, sortFunction)
    return keys
end