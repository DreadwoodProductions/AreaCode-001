local ServerStorage = game:GetService("ServerStorage")
local PetConfig = require(ServerStorage.Modules.PetConfig)
local PlayerDataService = require(script.Parent.PlayerDataService)

local PetService = {}

function PetService.AddPetToPlayer(player, petData)
	local playerData = PlayerDataService.GetPlayerData(player)
	table.insert(playerData.Pets, petData)
	PlayerDataService.UpdatePlayerData(player, playerData)
end

function PetService.CalculateTotalPetPower(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	local totalPower = 0
	for _, pet in ipairs(playerData.Pets) do
		totalPower = totalPower + pet.Power
	end
	return totalPower
end

return PetService
