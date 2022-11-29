--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local plyrs = game:GetService("Players")

--//     Functions     //--
local function getLP()
    return plyrs.LocalPlayer.Character
end

--//     Code     //--
getgenv().__k = true
while getgenv().__k do wait(0.32)
    local thread = coroutine.create(function()
        for i,v in pairs(ws.Characters:GetChildren()) do
            local magnitude = (getLP().HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
            if magnitude <= 24 then
                rs.Events.SwingTool:FireServer(rs.RelativeTime.Value, { v.HumanoidRootPart })
            end
        end
    end)
    coroutine.resume(thread)
end
