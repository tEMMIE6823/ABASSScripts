--//     Services     //--
local plyrs = game:GetService("Players")

--//     Variables     //--
local lp = plyrs.LocalPlayer

local chra = lp.Character
local hand = chra:FindFirstChild("RightHand")

--//     Code     //--
setsimulationradius(1/0) -- network stuff

local bodySex = Instance.new("BodyPosition", chra:FindFirstChild("Sword").Handle)
spawn(function()
    while true do wait()
        bodySex.Position = lp:GetMouse().Hit.p
    end
end)
hand:Destroy()
