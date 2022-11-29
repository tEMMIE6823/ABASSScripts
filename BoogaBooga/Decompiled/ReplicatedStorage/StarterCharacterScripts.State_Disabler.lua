-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by mrk0#4119


-- \\  Variables  \\ --
local hum = script.Parent:WaitForChild("Humanoid");

-- \\  Code  \\ --
for i, v in next, {Swimming = false} do
	hum:SetStateEnabled(Enum.HumanoidStateType[i], v);
end;
