local rs = game:GetService("ReplicatedStorage")

local _RG = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.BubbleChat)._G
local itemData = require(rs.Modules.ItemData)

local function AnimateTool()
	local useType = itemData[_RG.Data.toolbar[_RG.Data.equipped].name].useType
	_RG.anims[useType]:Play()
end

local function getWorkspaceBasepartsWithin(dis)
	local tmpTable = {}
	--print("getting parts")
	for i,v in ipairs(game.Workspace:GetDescendants()) do
		if v ~= nil and v:IsA("BasePart") and not v:IsDescendantOf(_RG.char) then
			local distance = (_RG.root.Position - v.Position).Magnitude
			if distance <= dis then
				table.insert(tmpTable,v)
			end
		end
	end
	--print("parts listed")
	return tmpTable
end

local parts = getWorkspaceBasepartsWithin(48)
local partsThread = coroutine.create(function() -- optimization
	while true do
		if not getgenv().WorkspaceAura then return end
		wait(5)
		parts = getWorkspaceBasepartsWithin(48)
	end
end)
coroutine.resume(partsThread)

getgenv().WorkspaceAura = true
local thread = coroutine.create(function()
	while true do wait(.18) -- slash weapon every second
		if not getgenv().WorkspaceAura then return end
		local useType = itemData[_RG.Data.toolbar[_RG.Data.equipped].name].useType or "Unknown"
		if useType == "Slash" then
			if parts ~= {} then
				rs.Events.SwingTool:FireServer(rs.RelativeTime.Value, parts)
				--AnimateTool()
			end
		end
	end
end)
coroutine.resume(thread)
