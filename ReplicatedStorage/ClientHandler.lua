local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local AddClicksRemote = ReplicatedStorage:WaitForChild("AddClicks")
local player = Players.LocalPlayer

AddClicksRemote.OnClientEvent:Connect(function(amount)
	local currentClicks = player:GetAttribute("Clicks") or 0
	local newClicks = currentClicks + amount
	player:SetAttribute("Clicks", newClicks)

	-- Update the UI to show the new click count
	-- Replace this with your actual UI update logic
	print("Clicks updated: " .. newClicks)
end)
