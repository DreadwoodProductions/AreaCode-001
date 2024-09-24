local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local hatchEggEvent = ReplicatedStorage:WaitForChild("HatchEggEvent")
local clickEvent = ReplicatedStorage:WaitForChild("ClickEvent")

local function onHatchEgg(success, result)
	if success then
		print("Hatched a " .. result.Name .. "!")
	else
		print("Failed to hatch egg: " .. result)
	end
end

hatchEggEvent.OnClientEvent:Connect(onHatchEgg)
