--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Variables     //--
local PlaceStructure = rs.Events.PlaceStructure
local lp = plyrs.LocalPlayer
local root = lp.Character:FindFirstChild("HumanoidRootPart")
local p = root.Position

--//     Code     //--
for x=0,4 do
	for z=0,4 do
		PlaceStructure:FireServer("Plant Box", CFrame.new(Vector3.new(p.X + (x * 8), p.Y - 4, p.Z + (z * 8))), 0)
	end
end
