local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local hatchEggEvent = ReplicatedStorage:WaitForChild("HatchEggEvent")

local function onEggProximity(eggModel)
	local eggPrice = eggModel:GetAttribute("Price")
	local playerCurrency = player:GetAttribute("Currency")

	if playerCurrency >= eggPrice then
		hatchEggEvent:FireServer(eggModel)
	else
		print("Not enough currency to hatch this egg!")
	end
end

-- This function will be called when a new egg model is added to the workspace
local function setupEggProximity(eggModel)
	local proximityPrompt = Instance.new("ProximityPrompt")
	proximityPrompt.ObjectText = "Egg"
	proximityPrompt.ActionText = "Hatch"
	proximityPrompt.RequiresLineOfSight = false
	proximityPrompt.Parent = eggModel

	proximityPrompt.Triggered:Connect(function()
		onEggProximity(eggModel)
	end)
end

-- Set up proximity for existing eggs
for _, egg in ipairs(workspace.Eggs:GetChildren()) do
	setupEggProximity(egg)
end

-- Set up proximity for new eggs
workspace.Eggs.ChildAdded:Connect(setupEggProximity)

hatchEggEvent.OnClientEvent:Connect(function(success, result)
	if success then
		print("You hatched a " .. result.Name .. "!")
		-- Here you can add GUI updates or animations for successful hatching
	else
		print("Failed to hatch: " .. result)
	end
end)
