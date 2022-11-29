--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Booga Utils     //--
local bank = require(rs.Modules["Client_Function_Bank"])
local colors = require(rs.Modules["ColorData"])

local _RG = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.BubbleChat)._G

bank.CreateNotification("Loading...", colors.essenceYellow)

--//     Variables     //--
local lp = plyrs.LocalPlayer

local PlayerGui = lp.PlayerGui
local MainGui = PlayerGui.MainGui
local LeftPanel = MainGui.LeftPanel
local Navigation = MainGui.Panels.Topbar.Right.Navigation

local PanelTemplate = LeftPanel.ModeratorTools
local NavigationButtonTemplate = Navigation.Social

local Data = {
	MaxStats = false
}

--//     HTTP Data     //--
local originalTick = tick()
local pickupData = game:HttpGet("https://pastebin.com/raw/EwKpakWj", true)
local playerauraData = game:HttpGet("https://pastebin.com/raw/FRzweWW6", true)
local createfarmData = game:HttpGet("https://pastebin.com/raw/b7GvFBfZ", true)
local openMarketData = game:HttpGet("https://pastebin.com/raw/yUYyjGcK", true)
local startupTime = tick() - originalTick

--//     Initial window setup     //--
local newTab = NavigationButtonTemplate:Clone()
newTab.Visible = true
newTab.Parent = Navigation

local buttonTemplate

local newPanel = PanelTemplate:Clone()
newPanel.Parent = LeftPanel
for i,v in ipairs(newPanel:FindFirstChild("ScrollingFrame"):GetChildren()) do
	if v.Name ~= "UIListLayout" then
		if #v:GetChildren() == 1 then
			buttonTemplate = v:Clone()
		end
		v:Destroy()
	end
end
newPanel:FindFirstChild("ScrollingFrame").Transparency = 1

local title = "ABAS Booga Panel"

newPanel:FindFirstChild("Parchment").Container.TitleLabel.Text = title

newTab.MouseButton1Click:Connect(function()
	if newPanel.Visible then
		newPanel.Visible = false
	else
		bank.OpenGui()
		bank.ClearMouseBoundStructure()
		newPanel.Visible = true
	end
end)

--//     Library     //--
local lib = {}

function lib.AddButton(text, onclick, boolean)
	if boolean ~= nil and not boolean then return end
	local newButton = buttonTemplate:Clone()
	newButton.Parent = newPanel:FindFirstChild("ScrollingFrame")
	newButton.BackgroundTransparency = 1
	newButton:WaitForChild("ImageLabel").BackgroundTransparency = 1
	
	local invisBtn = Instance.new("TextButton", newButton)
	invisBtn.Text = text
	invisBtn.TextSize = 24
	invisBtn.AutoButtonColor = false -- colour**
	invisBtn.BackgroundTransparency = 1
	invisBtn.Size = UDim2.new(1,0,1,0)
	invisBtn.MouseButton1Click:Connect(onclick)
end

lib.AddButton("Eject menu", function()
	newTab:Destroy() -- nagivation bar icon
	newPanel:Destroy() -- actual menu
	bank.CreateNotification("Ejected ABAS Booga Panel!", colors.badRed)
end)

lib.AddButton("Pickup Script", function()
	if getgenv().MassPickup then
		bank.CreateNotification("Ejected Pickup Script!", colors.badRed)
		getgenv().MassPickup = false
	else
		bank.CreateNotification("Injected Pickup Script!", colors.goodGreen)
		loadstring(pickupData)()
	end
end)

lib.AddButton("Playeraura Script", function()
	if getgenv().__k then
		bank.CreateNotification("Ejected Playeraura Script!", colors.badRed)
		getgenv().__k = false
	else
		bank.CreateNotification("Injected Playeraura Script!", colors.goodGreen)
		loadstring(playerauraData)()
	end
end)

lib.AddButton("CreateFarm Script", function()
	loadstring(createfarmData)()
	bank.CreateNotification("Placed plantboxes", colors.goodGreen)
end)

lib.AddButton("OpenMarket (Trademenu)", function()
	loadstring(openMarketData)()
	bank.CreateNotification("Loaded market", colors.goodGreen)
end)

lib.AddButton("Unlock All", function()
	if Data.MaxStats then
		bank.CreateNotification("Stats already maxed!", colors.badRed)
	else
		Data.MaxStats = true
		bank.CreateNotification("Maxed out stats", colors.goodGreen)
		bank.CreateNotification("You might need to click on a category to update the GUI", colors.goodGreen)
		spawn(function()
			while task.wait() do
				_RG.Data.level = 1000
			end
		end)
	end
end)

bank.CreateNotification("Loaded ABAS Booga Panel in " .. startupTime .. "s", colors.goodGreen)
