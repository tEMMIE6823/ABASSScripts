local ws = game:GetService("Workspace")
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

local events = rs.Events
local PickupItem = events.PickupItem

local root = plyrs.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

getgenv().autoblood = true
while getgenv().autoblood do wait(0.1)
	for i,v in ipairs(ws.Items:GetChildren()) do -- int pairs
		local thread = coroutine.create(function()
			if v.Name == "Bloodfruit" then
				local magnitude = (root.Position - v:FindFirstChild("Item").Position).Magnitude
				if magnitude <= 24 then
					PickupItem:InvokeServer(v)
				end
			elseif v.Name == "Bloodfruit Bush" then
				local magnitude = (root.Position - v:FindFirstChild("Leaves").Position).Magnitude
				if magnitude <= 24 then
					PickupItem:InvokeServer(v)
				end
			end
		end)
		coroutine.resume(thread)
	end
end
