--//     Services     //--
local plyrs = game:GetService("Players")

--//     Environment Variables     //--
local _RG = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.BubbleChat)._G

--//     Variables     //--
local lp = plyrs.LocalPlayer
local MainGui = lp.PlayerGui.MainGui
local EssenceBar = MainGui.Panels.Topbar.Middle.EssenceFrame.EssenceBar

--//     Functions     //--
local levelLabel = EssenceBar.LevelText
levelLabel.Position = UDim2.new(0.4,0,1,3)

local bloodfruitLabel = levelLabel:Clone()
bloodfruitLabel.Parent = EssenceBar
bloodfruitLabel.Position = UDim2.new(0.6,0,1,3)
bloodfruitLabel.TextColor3 = Color3.new(133 / 255, 1 / 255, 1 / 255)
bloodfruitLabel.Text = "0 blood"

local lowBloodBar = levelLabel:Clone()
lowBloodBar.Parent = EssenceBar
lowBloodBar.Visible = false
lowBloodBar.Position = UDim2.new(0.5,0,1,48)
lowBloodBar.Size = UDim2.new(1,0,1,0)
lowBloodBar.TextColor3 = Color3.new(250 / 255, 24 / 255, 24 / 255)
lowBloodBar.TextSize = 48
lowBloodBar.Text = "WARNING, LOW ON BLOOD!"

coroutine.wrap(function()
	while wait() do
		local count = 0
		for i,v in ipairs(_RG.Data.inventory) do
			if v.name == "Bloodfruit" then
				count = v.quantity
			end
		end
		if count ~= 0 then
			bloodfruitLabel.Text = tostring(count) .. " blood"
			lowBloodBar.Text = "WARNING, LOW ON BLOOD!"
		else
			bloodfruitLabel.Text = "bloodless"
			lowBloodBar.Text = "OUT OF BLOOD!"
		end
		if count <= 150 and not lowBloodBar.Visible then
			lowBloodBar.Visible = true
		elseif count >= 150 and lowBloodBar.Visible then
			lowBloodBar.Visible = false
		end
	end
end)()
