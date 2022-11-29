-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by yeemi<3#9764

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Text = "Loading"
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.FontSize = Enum.FontSize.Size14
textLabel.Parent = screenGui

script.Parent:RemoveDefaultLoadingScreen()

local timer = 0
while tick() - tick() < 6 do
	textLabel.Text = "Loading " .. string.rep(".", timer)
	timer = (timer + 1) % 4
	wait(0.3)
end
screenGui.Parent = nil
