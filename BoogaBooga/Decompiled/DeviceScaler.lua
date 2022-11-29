-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by mrk0#4119

-- \\  Variables  \\ --
local parent = script.Parent
local resolutions = {
	inflated = {
		x = { min = 2560, max = 10000000000 }, 
		y = { min = 1440, max = 10000000000 }, 
		ratio = nil
	}, 
	desktop = {
		x = { min = 1024, max = 1920 }, 
		y = { min = 768, max = 1080 }, 
		ratio = nil
	}, 
	portrait = {
		x = { min = 1920, max = 1024 }, 
		y = { min = 1080, max = 768 }, 
		ratio = nil
	}
}
local lp = game.Players.LocalPlayer
local aboveParent = parent.Parent
local u3 = nil
local u4 = nil

-- \\  Functions  \\ --
local function sizeReturner()
	return aboveParent.AbsoluteSize.X, aboveParent.AbsoluteSize.Y
end
local function sizePicker(p1, p2)
	if p2 < p1 then
		return "landscape", p1 / p2
	end
	if p1 == p2 then
		return "square", p1 / p2
	end
	if not (p1 < p2) then
		return
	end
	return "portrait", p1 / p2
end
local function v3()
	local v4, v5 = sizeReturner()
	u3 = v4
	u4 = v5
	local v6 = sizePicker(u3, u4)
end

-- \\  Code  \\ --
v3()
aboveParent:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
	v3()
end)
