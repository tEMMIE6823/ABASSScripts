--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Functions     //--
local function getLP()
    return plyrs.LocalPlayer.Character
end

--//     Code     //--
for i,v in pairs(workspace.Deployables:GetChildren()) do
    coroutine.wrap(function()
        pcall(function()
            local magnitude = (getLP().HumanoidRootPart.Position - v:FindFirstChild("Part").Position).Magnitude
            if magnitude <= 256 then
                if v.Name == "Plant Box" then
                    rs.Events.InteractStructure:FireServer(v, "Bloodfruit")
                end
            end
        end)
    end)()
end
