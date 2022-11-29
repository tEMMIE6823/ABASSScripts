--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Variables     //--
local lp = plyrs.LocalPlayer

local PlayerGui = lp.PlayerGui
local MainGui = PlayerGui.MainGui
local LeftPanel = MainGui.LeftPanel
local Navigation = MainGui.Panels.Topbar.Right.Navigation

local PanelTemplate = LeftPanel.ModeratorTools
local NavigationButtonTemplate = Navigation.Social

--//     Code     //--
local newTab = NavigationButtonTemplate:Clone()
newTab.Visible = true
newTab.Parent = Navigation

local newPanel = PanelTemplate:Clone()
newPanel.Parent = LeftPanel
for i,v in ipairs(newPanel:FindFirstChild("ScrollingFrame"):GetChildren()) do
	v:Destroy()
end
newPanel:FindFirstChild("Parchment").Container.TitleLabel.Text = "DemoWindow"

newTab.MouseButton1Click:Connect(function()
	newPanel.Visible = not newPanel.Visible -- toggle
end)
