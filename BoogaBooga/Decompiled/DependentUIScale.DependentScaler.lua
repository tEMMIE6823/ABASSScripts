-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by mrk0#4119

-- \\  Variables  \\ --
local globalUIScale = require(game.ReplicatedStorage.Modules:WaitForChild("Client_Function_Bank")).mainGui.GlobalUIScale;
local parent = script.Parent;

-- \\  Code  \\ --
globalUIScale:GetPropertyChangedSignal("Value"):connect(function()
	parent.Scale = globalUIScale.Value;
end);
