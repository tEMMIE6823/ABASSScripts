-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by mrk0#4119

-- \\  Services  \\ --
local mpService = game:GetService("MarketplaceService");
local rs = game:GetService("ReplicatedStorage");

-- \\  Variables  \\ --
local parent = script.Parent;
local productFrame = parent:WaitForChild("ProductFrame");

-- \\  Functions  \\ --
local function pfVisibility()
	productFrame.Visible = false;
end;

-- \\  Code  \\ --
productFrame.Close.Activated:connect(pfVisibility);
local lp = game.Players.LocalPlayer;
local productIDValue = parent.ProductID.Value;
productFrame.BuyButton.Activated:connect(function()
	mpService:PromptProductPurchase(lp, productIDValue);
	wait(1);
	pfVisibility();
end);
