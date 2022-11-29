-- Needs to be polished later. Due to O2U not having a decompiler, this script is entirely based on GUI elements making it usable on nearly every executor. 
-- Legends of speed autoplay/autofarm script
-- This script will play the game for you, collecting orbs and hoops, automatically joining and winning races instantly. Due to this, it's rather blatant, so make sure to use it in small servers only.

-- \\  Services  \\ --
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local vu = game:GetService("VirtualUser")
local plyrs = game:GetService("Players")

-- \\  Variables  \\ --
local lp = plyrs.LocalPlayer
local head = lp.Character.Head

-- \\  Code  \\ --
repeat wait() until game:IsLoaded() -- AntiAFK
    lp.Idled:connect(function()
    vu:ClickButton2(Vector2.new())
end)

getgenv().__autoplay = true -- Set this to false to disable the AutoFarm script
while __autoplay == true do
    local thread = coroutine.create(function()
        for i, v in pairs(ws.orbFolder.City:GetDescendants()) do
            if v.Name == "TouchInterest" and v.Parent then
                firetouchinterest(head, v.Parent, 0)
                firetouchinterest(head, v.Parent, 1)
            end
        end
        task.wait()
        for i, v in pairs(ws.Hoops:GetDescendants()) do
            if v.Name == "TouchInterest" and v.Parent then
                firetouchinterest(head, v.Parent, 0)
                firetouchinterest(head, v.Parent, 1)
            end
        end
        task.wait()
        if lp.PlayerGui.gameGui.statsFrame.levelLabel.maxLabel.Visible == true then
            rs.rEvents.rebirthEvent:FireServer("rebirthRequest")
        end
        if lp.PlayerGui.gameGui.raceJoinLabel.Visible == true then
            local hrp = lp.Character.HumanoidRootPart
            rs.rEvents.raceEvent:FireServer("joinRace")
            repeat wait() until lp.PlayerGui.gameGui.countdownLabels.goLabel.Visible == true
            wait(.15)
            hrp.CFrame = ws.raceMaps.Grassland.finishPart.CFrame
            task.wait()
            hrp.CFrame = ws.raceMaps.Desert.finishPart.CFrame
            task.wait()
            hrp.CFrame = ws.raceMaps.Magma.finishPart.CFrame
            task.wait()
            hrp.CFrame = ws.racesLeaderboard.leaderboardPart.CFrame
        end
    end)
    coroutine.resume(thread)
    task.wait()
end
