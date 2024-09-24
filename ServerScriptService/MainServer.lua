local PlayerDataService = require(script.Parent.PlayerDataService)

local function setupLeaderstats(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local clicks = Instance.new("IntValue")
	clicks.Name = "Clicks"
	clicks.Parent = leaderstats

	local eggsHatched = Instance.new("IntValue")
	eggsHatched.Name = "Eggs Hatched"
	eggsHatched.Parent = leaderstats

	local rarePets = Instance.new("IntValue")
	rarePets.Name = "Rare Pets"
	rarePets.Parent = leaderstats

	local playerData = PlayerDataService:GetPlayerData(player)
	clicks.Value = playerData.clicks
	eggsHatched.Value = playerData.eggsHatched or 0
	rarePets.Value = playerData.rarePets or 0
end

game.Players.PlayerAdded:Connect(setupLeaderstats)
