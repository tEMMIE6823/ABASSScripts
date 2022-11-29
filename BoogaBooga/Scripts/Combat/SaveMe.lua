--//     Services     //--
local uis = game:GetService("UserInputService")
local plyrs = game:GetService("Players")

workspace.FallenPartsDestroyHeight = 0/0

--//     Code     //--
local pos = nil
uis.InputBegan:Connect(function(k, e)
	--if e then return end
	if uis:IsKeyDown(Enum.KeyCode.LeftControl) or uis:IsKeyDown(Enum.KeyCode.RightControl) then
		if k.KeyCode == Enum.KeyCode.Q then -- control & q are being held together
			if pos == nil then
				pos = plyrs.LocalPlayer.Character.HumanoidRootPart.CFrame
				plyrs.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, -1000000, 0))
			else
				plyrs.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
				plyrs.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
				pos = nil
			end
		end
	end
end)
