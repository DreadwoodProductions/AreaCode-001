local ClickService = {}

local PlayerDataService = require(script.Parent.PlayerDataService)

local COMBO_DURATION = 5 -- seconds
local COMBO_MULTIPLIER = 1.5

function ClickService:Click(player)
	local playerData = PlayerDataService:GetPlayerData(player)
	local currentTime = tick()

	-- Check for combo
	if playerData.lastClickTime and (currentTime - playerData.lastClickTime) <= COMBO_DURATION then
		playerData.clickCombo = (playerData.clickCombo or 1) + 1
		playerData.clicks = playerData.clicks + math.floor(playerData.clickCombo * COMBO_MULTIPLIER)
	else
		playerData.clickCombo = 1
		playerData.clicks = playerData.clicks + 1
	end

	playerData.lastClickTime = currentTime
	PlayerDataService:UpdatePlayerData(player, playerData)

	return playerData.clicks, playerData.clickCombo
end

return ClickService
