--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Variables     //--
local ViewportGui

local lp = plyrs.LocalPlayer

local PlayerGui = lp.PlayerGui
local SecondaryGui = PlayerGui.SecondaryGui
local ActionsPanel = SecondaryGui.PlayerList.List.ActionPanel

--//     Code     //--
function viewPlayer(plr, distance, viewtype)
	local viewportFrame = Instance.new("ViewportFrame")
	viewportFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
	viewportFrame.Position = UDim2.new(0, 15, 0, 15)
	viewportFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	viewportFrame.BorderColor3 = Color3.new(0.6, 0.5, 0.4)
	viewportFrame.BorderSizePixel = 2
	viewportFrame.BackgroundTransparency = 1
	if ViewportGui then ViewportGui:Destroy() end
	if viewtype == "Stop" then return end
	ViewportGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	viewportFrame.Parent = ViewportGui

	local clonedPlr = game.Players[plr].Character:Clone()
	clonedPlr.Parent = viewportFrame

	local mcf = clonedPlr.HumanoidRootPart.CFrame
	local center
	if viewtype == "Front" then
		center = mcf.Position + mcf.LookVector*distance
	elseif viewtype == "Back" then
		center = mcf.Position + (-mcf.LookVector)*distance
	end
	local lookingAt = mcf.Position

	local viewportCamera = Instance.new("Camera")
	viewportFrame.CurrentCamera = viewportCamera
	viewportCamera.Parent = viewportFrame
	viewportCamera.CameraType = Enum.CameraType.Scriptable
	viewportCamera.Parent = viewportFrame
	viewportCamera.CFrame = CFrame.lookAt(center, lookingAt)
end

local spectateFrontBtn = ActionsPanel.InfoButton:Clone()
spectateFrontBtn.Parent = ActionsPanel
spectateFrontBtn.Visible = true
spectateFrontBtn.Text = "View Front"

spectateFrontBtn.MouseButton1Down:Connect(function()
	viewPlayer(ActionsPanel.TargetPlayerName.Value, 7, "Front")
end)

local spectateBackBtn = ActionsPanel.InfoButton:Clone()
spectateBackBtn.Parent = ActionsPanel
spectateBackBtn.Visible = true
spectateBackBtn.Text = "View Back"

spectateBackBtn.MouseButton1Down:Connect(function()
	viewPlayer(ActionsPanel.TargetPlayerName.Value, 7, "Back")
end)

local spectateStop = ActionsPanel.InfoButton:Clone()
spectateStop.Parent = ActionsPanel
spectateStop.Visible = true
spectateStop.Text = "Stop View"

spectateStop.MouseButton1Down:Connect(function()
	viewPlayer(nil, nil, "Stop")
end)
