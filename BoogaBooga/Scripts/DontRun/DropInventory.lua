--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Environment     //--
local function getrgenv()
    return getsenv(plyrs.LocalPlayer.PlayerScripts.BubbleChat)._G
end

--//     Code     //--
for i,v in ipairs(getrgenv().Data.inventory) do
    if v ~= nil and v.name:lower():match("bag") then
        for i=1,v.quantity do
            local thread = coroutine.create(function()
                rs.Events.DropBagItem:FireServer(v.name)
            end)
            coroutine.resume(thread)
        end
    end
end
wait(.6)
for i,v in ipairs(getrgenv().Data.inventory) do
    for i=1,v.quantity do
        local thread = coroutine.create(function()
            rs.Events.DropBagItem:FireServer(v.name)
        end)
        coroutine.resume(thread)
    end
end
