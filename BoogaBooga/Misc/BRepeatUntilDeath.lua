--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--//     Functions     //--
local function TeleportTo(vec, vel)
    local root = plyrs.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	root.CFrame = vec
	root.Velocity = vel
end

local function GetPos(plr) return plr.Character:FindFirstChild("HumanoidRootPart").CFrame end
local function GetVel(plr) return plr.Character:FindFirstChild("HumanoidRootPart").Velocity end
local function onCharacterAdded(character) rs.Events.EquipTool:FireServer(1) end

--//     Code     //--
local connection = plyrs.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

brk = false
if shared.Dispose then shared.Dispose() end
function shared.Dispose()
	brk = true
end

function AttackPlayer(target)
	local humanoid = plyrs[target].Character.Humanoid
	coroutine.wrap(function()
		while not brk do wait(0.05)
			local thread = coroutine.create(function()
				rs.Events.SwingTool:FireServer(rs.RelativeTime.Value, { plyrs[target].Character.HumanoidRootPart })
			end)
			coroutine.resume(thread)
		end
	end)()

	while humanoid.Health ~= 0 and not brk do task.wait()
		local pos = GetPos(plyrs[target])
		TeleportTo(pos + (-pos.LookVector * 4.6) + (pos.UpVector * 5.6), GetVel(plyrs[target]))
		rs.Events.SpawnFirst:FireServer()
	end
	connection:Disconnect()
end

return AttackPlayer
