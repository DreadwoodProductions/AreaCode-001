local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local EggConfig = require(ServerStorage.Modules.EggConfig)
local PetConfig = require(ServerStorage.Modules.PetConfig)
local PlayerDataService = require(script.Parent.PlayerDataService)
local PetService = require(script.Parent.PetService)

local EggService = {}

local hatchEggEvent = Instance.new("RemoteEvent")
hatchEggEvent.Name = "HatchEggEvent"
hatchEggEvent.Parent = ReplicatedStorage

function EggService.HatchEgg(player, eggModel)
	local playerData = PlayerDataService.GetPlayerData(player)
	local eggPrice = eggModel:GetAttribute("Price")

	if not eggPrice or playerData.Currency < eggPrice then
		return false, "Insufficient funds or invalid egg"
	end

	playerData.Currency = playerData.Currency - eggPrice
	local pet = EggService.GetRandomPet(eggModel.Name)
	PetService.AddPetToPlayer(player, pet)

	PlayerDataService.UpdatePlayerData(player, playerData)
	return true, pet
end

function EggService.GetRandomPet(eggType)
	-- Implementation remains the same as before
end

function EggService.CreateEggModel(eggType, position)
	local eggModel = Instance.new("Part")
	eggModel.Name = eggType
	eggModel.Position = position
	eggModel.Anchored = true
	eggModel.CanCollide = false
	eggModel:SetAttribute("Price", EggConfig.Eggs[eggType].Cost)
	eggModel.Parent = workspace.Eggs
end

hatchEggEvent.OnServerEvent:Connect(function(player, eggModel)
	local success, result = EggService.HatchEgg(player, eggModel)
	hatchEggEvent:FireClient(player, success, result)
end)

return EggService
