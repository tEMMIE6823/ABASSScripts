--//     Services     //--
local plyrs = game:GetService("Players")

--//     Variables     //--
local lp = plyrs.LocalPlayer

local chra = lp.Character
local sword = chra:FindFirstChild("Sword") or lp.Backpack:FindFirstChild("Sword")

--//     Code     //--
while wait() do
	local pos = chra.HumanoidRootPart.Position
	local pos2 = lp:GetMouse().Hit.p
	sword.GripPos = Vector3.new(pos.X, pos.Y, pos.Z) + Vector3.new(pos2.X, 0, pos2.Z)
	sword.Parent = lp.Backpack
	sword.Parent = chra
end
