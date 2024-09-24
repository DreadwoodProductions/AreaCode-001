local GuiScaler = {}

local MIN_SCREEN_SIZE = Vector2.new(1024, 600)
local MAX_SCREEN_SIZE = Vector2.new(1920, 1080)

function GuiScaler:ScaleGui(gui)
	local viewportSize = workspace.CurrentCamera.ViewportSize
	local scaleFactor = math.clamp(
		math.min(viewportSize.X / MIN_SCREEN_SIZE.X, viewportSize.Y / MIN_SCREEN_SIZE.Y),
		0.5,
		2
	)

	gui.Size = UDim2.new(gui.Size.X.Scale, gui.Size.X.Offset * scaleFactor, gui.Size.Y.Scale, gui.Size.Y.Offset * scaleFactor)

	for _, child in ipairs(gui:GetDescendants()) do
		if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
			child.TextSize = child.TextSize * scaleFactor
		end
	end
end

return GuiScaler
