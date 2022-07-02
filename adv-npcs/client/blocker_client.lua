[function sendForbiddenMessage(message)
	TriggerEvent("chatMessage", "", {0, 0, 0}, "^1" .. message)
end

function DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end


-- CONFIG --

-- Blacklisted vehicle models
carblacklist = {
    "SHAMAL", -- They spawn on LSIA and try to take off
    "LUXOR", -- They spawn on LSIA and try to take off
    "LUXOR2", -- They spawn on LSIA and try to take off
    "JET", -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
    "LAZER", -- They spawn on Zancudo and try to take off
    "TITAN", -- They spawn on Zancudo and try to take off
    "BARRACKS", -- Regularily driving around the Zancudo airport surface
    "BARRACKS2", -- Regularily driving around the Zancudo airport surface
    "CRUSADER", -- Regularily driving around the Zancudo airport surface
    "RHINO", -- Regularily driving around the Zancudo airport surface
    "AIRTUG", -- Regularily spawns on the LSIA airport surface
    "RIPLEY", -- Regularily spawns on the LSIA airport surface
	"buzzard",
	"besra",
	"lazer",
	"cargobob",
	"cargobob2",
	"cargobob3",
	"cargobob4",
	"firetruk",
	"swift",
	"police1",
	"police2",
	"police3",
	"police4",
	"policeb",
	"polmav",
	"sheriff",
	"sheriff2",
	"ambulance",
	"lguard",
	"pranger",
	"policet",
	"riot",
	"riot2",
	"fbi",
	"fbi2",
	"pbus",
	"policeold1",
	"policeold2",
	"predator"
}

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

			x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			for _, blacklistedCar in pairs(carblacklist) do
				checkCar(GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70))
			end
		end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			DeleteEntity(car)
			sendForbiddenMessage("Enigma")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

    -- Other stuff normally here, stripped for the sake of only scenario stuff
    local SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
        "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes
    }
    local SCENARIO_GROUPS = {
        2017590552, -- LSIA planes
        2141866469, -- Sandy Shores planes
        1409640232, -- Grapeseed planes
        "ng_planes", -- Far up in the skies jets
    }
    local SUPPRESSED_MODELS = {
        "SHAMAL", -- They spawn on LSIA and try to take off
        "LUXOR", -- They spawn on LSIA and try to take off
        "LUXOR2", -- They spawn on LSIA and try to take off
        "JET", -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
        "LAZER", -- They spawn on Zancudo and try to take off
        "TITAN", -- They spawn on Zancudo and try to take off
        "BARRACKS", -- Regularily driving around the Zancudo airport surface
        "BARRACKS2", -- Regularily driving around the Zancudo airport surface
        "CRUSADER", -- Regularily driving around the Zancudo airport surface
        "RHINO", -- Regularily driving around the Zancudo airport surface
        "AIRTUG", -- Regularily spawns on the LSIA airport surface
        "RIPLEY", -- Regularily spawns on the LSIA airport surface
	"buzzard",
	"besra",
	"lazer",
	"cargobob",
	"cargobob2",
	"cargobob3",
	"cargobob4",
	"firetruk",
	"swift",
	"police1",
	"police2",
	"police3",
	"police4",
	"policeb",
	"polmav",
	"sheriff",
	"sheriff2",
	"ambulance",
	"lguard",
	"pranger",
	"policet",
	"riot",
	"riot2",
	"fbi",
	"fbi2",
	"pbus",
	"policeold1",
	"policeold2",
	"predator"
    }

    while true do
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        Wait(1000)
    end
end)


-- CONFIG --

-- Blacklisted ped models
pedblacklist = {
	"csb_prolsec",
	"csb_mweather",
	"cs_karen_daniels",
	"cs_hunter",
	"cs_casey",
	"cs_prolsec_02",
	"csb_avon",
	"csb_ramp_marine",
	"mp_m_fibsec_01",
	"s_f_y_cop_01",
	"s_f_y_ranger_01",
	"s_f_y_sheriff_01",
	"s_m_m_armoured_01",
	"s_m_m_armoured_02",
	"s_m_m_chemsec_01",
	"s_m_m_ciasec_01",
	"s_m_m_fibsec_01",
	"s_m_m_security_01",
	"s_m_y_blackops_01",
	"s_m_y_blackops_02",
	"s_m_y_blackops_03",
	"s_m_y_cop_01",
	"s_m_y_grip_01",
	"s_m_y_hwaycop_01",
	"s_m_y_marine_01",
	"s_m_y_marine_02",
	"s_m_y_marine_03",
	"s_m_y_ranger_01",
	"s_m_y_sheriff_01",
	"s_m_y_swat_01",
	"ig_casey",
	"ig_prolsec_02"
}

-- Defaults to this ped model if an error happened
defaultpedmodel = "a_m_y_skater_01"

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			playerModel = GetEntityModel(playerPed)

			if not prevPlayerModel then
				if isPedBlacklisted(prevPlayerModel) then
					SetPlayerModel(PlayerId(), GetHashKey(defaultpedmodel))
				else
					prevPlayerModel = playerModel
				end
			else
				if isPedBlacklisted(playerModel) then
					SetPlayerModel(PlayerId(), prevPlayerModel)
					sendForbiddenMessage("Enigma")
				end

				prevPlayerModel = playerModel
			end
		end
	end
end)

function isPedBlacklisted(model)
	for _, blacklistedPed in pairs(pedblacklist) do
		if model == GetHashKey(blacklistedPed) then
			return true
		end
	end

	return false
end


-- CONFIG --

-- Blacklisted weapons
weaponblacklist = {
	"WEAPON_MINIGUN",
	"WEAPON_STUNGUN"
}

-- Don't allow any weapons at all (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
					sendForbiddenMessage("This weapon is blacklisted!")
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) -- prevent crashing
		SetCreateRandomCops(false) -- disable random cops walking/driving around.
		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
	end
end)

