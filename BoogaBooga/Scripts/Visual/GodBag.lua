--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Variables     //--
local bag = rs.Armor["God Bag"]

--//     Code     //--
for i,v in ipairs(plyrs.LocalPlayer.Character:GetChildren()) do
    if v.Name:match("Bag") then
        v:Destroy()
    end
end

local newBag = bag:Clone()
newBag:FindFirstChild("Handle").AccessoryWeld.Part1 = plyrs.LocalPlayer.Character.UpperTorso
newBag.Parent = plyrs.LocalPlayer.Character
