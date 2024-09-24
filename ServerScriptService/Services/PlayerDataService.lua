local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local PlayerData = DataStoreService:GetDataStore("PlayerData")

local PlayerDataService = {}

local updateInventoryEvent = Instance.new("RemoteEvent")
updateInventoryEvent.Name = "UpdateInventoryEvent"
updateInventoryEvent.Parent = ReplicatedStorage

local function CreateDefaultData()
	return {
		Currency = 0,
		Pets = {}
	}
end

function PlayerDataService.InitializePlayer(player)
	local data
	local success, err = pcall(function()
		data = PlayerData:GetAsync(player.UserId)
	end)

	if not success or not data then
		data = CreateDefaultData()
	end

	player:SetAttribute("DataLoaded", true)
	player:SetAttribute("Currency", data.Currency)
	player:SetAttribute("PetsData", HttpService:JSONEncode(data.Pets))
	PlayerDataService.UpdateInventoryDisplay(player)
end

function PlayerDataService.GetPlayerData(player)
	while not player:GetAttribute("DataLoaded") do
		wait()
	end
	return {
		Currency = player:GetAttribute("Currency"),
		Pets = HttpService:JSONDecode(player:GetAttribute("PetsData") or "[]")
	}
end

function PlayerDataService.UpdatePlayerData(player, data)
	player:SetAttribute("Currency", data.Currency)
	player:SetAttribute("PetsData", HttpService:JSONEncode(data.Pets))
	PlayerDataService.UpdateInventoryDisplay(player)
end

function PlayerDataService.SavePlayerData(player)
	local data = PlayerDataService.GetPlayerData(player)
	local success, err = pcall(function()
		PlayerData:SetAsync(player.UserId, data)
	end)
	if not success then
		warn("Failed to save data for " .. player.Name .. ": " .. err)
	end
end

function PlayerDataService.UpdateInventoryDisplay(player)
	local data = PlayerDataService.GetPlayerData(player)
	updateInventoryEvent:FireClient(player, data.Pets)
end

return PlayerDataService
