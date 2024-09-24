local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local GuiScaler = require(ReplicatedStorage:WaitForChild("GuiScaler"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local MainGUI = playerGui:WaitForChild("MainGUI")
local petInventory = MainGUI.HiddenFrames.PetInventory
local inventoryFrame = petInventory.Main.InventoryFrame
local inventoryButton = MainGUI.CoreElements.Frame.Pets.MainButton
local closeInventoryButton = petInventory.Close.MainButton.MainButton

local updateInventoryEvent = ReplicatedStorage:WaitForChild("UpdateInventoryEvent")

local animationDuration = 0.5
local easeStyle = Enum.EasingStyle.Quart
local easeDirection = Enum.EasingDirection.Out

local onScreenPosition = UDim2.new(0.5, 0, 0.5, 0)
local offScreenPosition = UDim2.new(0.5, 0, 1.5, 0)

local function updateInventoryDisplay(pets)
	if not pets then pets = {} end
	for _, child in ipairs(inventoryFrame:GetChildren()) do
		if child:IsA("TextLabel") and child.Name ~= "UIListLayout" then
			child:Destroy()
		end
	end
	for _, pet in ipairs(pets) do
		local petLabel = Instance.new("TextLabel")
		petLabel.Text = pet.Name .. " (Power: " .. pet.Power .. ")"
		petLabel.Size = UDim2.new(1, 0, 0, 30)
		petLabel.Parent = inventoryFrame
	end
	GuiScaler.scaleAllGuis(MainGUI)
end

local function animatePetInventory(show)
	if show and petInventory.Position == onScreenPosition then return end
	local targetPosition = show and onScreenPosition or offScreenPosition
	petInventory.Visible = true
	local tween = TweenService:Create(petInventory, TweenInfo.new(animationDuration, easeStyle, easeDirection), {Position = targetPosition})
	tween:Play()
	if not show then
		tween.Completed:Connect(function()
			petInventory.Visible = false
		end)
	end
end

local function openInventory()
	animatePetInventory(true)
end

local function closeInventory()
	animatePetInventory(false)
end

inventoryButton.MouseButton1Click:Connect(openInventory)
closeInventoryButton.MouseButton1Click:Connect(closeInventory)
closeInventoryButton.Activated:Connect(closeInventory)

updateInventoryEvent.OnClientEvent:Connect(updateInventoryDisplay)

local initialPets = player:GetAttribute("Pets") or {}
updateInventoryDisplay(initialPets)

petInventory.Position = offScreenPosition
petInventory.Visible = false
petInventory.AnchorPoint = Vector2.new(0.5, 0.5)

-- Set up auto-scaling for all GUI elements
GuiScaler.setupAutoScaling(MainGUI)
