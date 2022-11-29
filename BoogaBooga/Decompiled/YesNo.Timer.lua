-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by mrk0#4119

-- \\  Variables  \\ --
local parent = script.Parent;

-- \\  Code  \\ --
game:GetService("Debris"):AddItem(parent, 20);
for i = 19, 0, -1 do
	parent.Background.Timer.TextLabel.Text = tostring(math.floor(i));
	wait(1);
end;
