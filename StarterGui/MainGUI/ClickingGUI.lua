local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local MainGUI = playerGui:WaitForChild("MainGUI")

local ClickButton = MainGUI.Click.Click.ClickButton
local CurrencyDisplay = MainGUI.Clicks.Clicks.Click.CurrencyDisplay

local clickEvent = ReplicatedStorage:WaitForChild("ClickEvent")

local updateStatsEvent = ReplicatedStorage:WaitForChild("UpdateStatsEvent")

local function updateDisplays(currency)
	CurrencyDisplay.Text = "Currency: " .. currency
end

local function onButtonClick()
	clickEvent:FireServer()
end

ClickButton.MouseButton1Click:Connect(onButtonClick)

updateStatsEvent.OnClientEvent:Connect(updateDisplays)

local initialCurrency = player:GetAttribute("Currency") or 0
updateDisplays(initialCurrency)
