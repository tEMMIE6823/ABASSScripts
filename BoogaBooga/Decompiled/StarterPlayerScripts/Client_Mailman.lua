-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by yeemi<3#9764

--//     Services     //--
local rs = game:GetService("ReplicatedStorage")

--//     Variables     //--
local lp = game.Players.LocalPlayer

local gameModules = rs:WaitForChild("Modules")
local bank = require(gameModules:WaitForChild("Client_Function_Bank"))

--//     Functions     //--
local function clearOlderMessages() -- please dont attempt to reference this
	for i,v in next, bank.mainGui.LeftPanel.Mailbox.List:GetChildren() do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
end

--//     Code     //--
rs:WaitForChild("Events"):WaitForChild("GotMail").OnClientEvent:connect(function(messages, notifyUser)
	clearOlderMessages()
	for i,v in next, messages do
		local message = bank.mainGui.LeftPanel.Mailbox.Templates.MessageFrame:Clone()
		message.Icon.Image = v.icon
		message.Icon.DateLabel.Text = os.date("%x", tonumber(v.date))
		message.Icon.SenderLabel.Text = v.sender
		message.TitleHolder.TitleLabel.Text = v.title
		message.MessageHolder.MessageLabel.Text = v.message
		message.LayoutOrder = math.floor(v.date) * -1
		message.Parent = bank.mainGui.LeftPanel.Mailbox.List
		message.Visible = true
	end
	if notifyUser then
		bank.mainGui.Panels.Topbar.Right.Navigation.Mailbox.Visible = true
		bank.CreateNotification("You have mail! Check the Mailbox.", Color3.fromRGB(255, 255, 255), 10, nil, "Page Turn")
	end
end)
