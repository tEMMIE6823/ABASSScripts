--//     Services     //--
local ws = game:GetService("Workspace")
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")
local uis = game:GetService("UserInputService")

--//     Variables     //--
local items = ws.Items
local events = rs.Events

local PickupItem = events.PickupItem

local function getLP()
    return plyrs.LocalPlayer.Character
end

function pickupAllItems()
    for i,v in pairs(items:GetChildren()) do
        local mainPart = v:GetChildren()[1]
        if mainPart ~= nil then
            local magnitude = (getLP().HumanoidRootPart.Position - mainPart.Position).Magnitude
            if magnitude <= 24 then -- can be increased to 25 btw
                local thread = coroutine.create(function()
                    PickupItem:InvokeServer(v)
                end)
                coroutine.resume(thread)
            end
        end
    end
end

--//     Code     //--

getgenv().MassPickup = true
while getgenv().MassPickup do wait(0.25)    
    pickupAllItems()
end
