-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by yeemi<3#9764

--//     Tables     //--
local ObjectMap = {}

--//     Variables     //--
local itemData = require(game:GetService("ReplicatedStorage").Modules.ItemData)

--//     Functions     //--
function ToggleVolume(p1)
	if _G.Data then
		p1.Volume = _G.Data.userSettings.muteMusic and 1 or 0
	end
end

function ToggleMute(p2)
	local lastSound = nil
	while true do
		local sound, v5 = next(ObjectMap, lastSound)
		if not sound then
			break
		end
		lastSound = sound
		ToggleVolume(sound)	
	end
end

function TagSoundObject(input)
	ObjectMap[input] = true
	ToggleVolume(input)
end

function ScanItemForMusic(p4)
	local caughtItem = itemData[p4.Name]
	if caughtItem then
		if caughtItem.musicalObject then
			local itemSound = p4:FindFirstChildWhichIsA("Sound", true)
			if itemSound then
				TagSoundObject(itemSound)
			end
		end
	end
end

--//     Code     //--
local __i,v = workspace.Deployables:GetChildren()
while true do
	local lastObj, item = next(__i, v)
	if not lastObj then
		break
	end
	v = lastObj
	ScanItemForMusic(item)
end

workspace.Deployables.ChildAdded:Connect(function(item)
	wait(1)
	ScanItemForMusic(item)
end)

workspace.Characters.ChildAdded:connect(function(__newChild)
	__newChild.ChildAdded:connect(function(child)
		if child.Name == "Radio Pack" then
			local sound = child:FindFirstChildWhichIsA("Sound", true)
			if sound then
				TagSoundObject(sound)
			end
		end
	end)
end)

script.MuteToggle.Event:Connect(function()
	ToggleMute()
end)
