-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by yeemi<3#9764

--//     Services     //--
local cs = game:GetService("CollectionService")
local rsc = workspace:WaitForChild("Resources")
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local rns = game:GetService("RunService")

--//     Variables     //--
local gameModules = rs:WaitForChild("Modules")
local itemData = require(gameModules:WaitForChild("ItemData"))

local pickupNametag = script.Parent.PickupBillboard
local lp = game.Players.LocalPlayer

--//     Functions     //--
function AdornBillboard(input)
	if input then
		if not itemData[input.Name] then
			return
		end
	else
		pickupNametag.Adornee = nil
		return
	end
	pickupNametag.Frame.ItemNameLabel.Text = input.Name or itemData[input.Name].alias
	pickupNametag.Adornee = input
	pickupNametag.Enabled = true
end

--//     Code     //--
rns.RenderStepped:connect(function()
	if not uis.TouchEnabled then
		local mouseTarget = lp:GetMouse().Target
		if _G.Data then
			if mouseTarget and mouseTarget:IsDescendantOf(workspace.Items) then
				local object = mouseTarget
				local output = nil
				while not output do
					local folder = object.Parent
					if folder == workspace.Items then
						output = object
						break
					elseif folder == workspace then
						break
					elseif folder == nil then
						break
					end
					object = folder				
				end
				AdornBillboard(output)
			else
				AdornBillboard()
			end
		end
	end
end)
