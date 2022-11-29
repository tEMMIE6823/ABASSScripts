-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by mrk0#4119

-- \\  Services  \\ --
local mpService = game:GetService("MarketplaceService");

-- \\  Variables  \\ --
local parent = script.Parent;

-- \\  Functions  \\ --
function format_int(p1) -- ignored
	local v3, v4, v5, v6, v7 = tostring(p1):find("([-]?)(%d+)([.]?%d*)");
	return v5 .. v6:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. v7;
end;

-- \\  Code  \\ --
for i, v in next, {
	[965781381] = { coins = "600" }, 
	[965781447] = { coins = "1,500" }, 
	[965781496] = { coins = "3,000" }, 
	[965781557] = { coins = "9,000" }, 
	[965781615] = { coins = "30,000" }, 
	[965781647] = { coins = "150,000" }
} do
	local productInfo = mpService:GetProductInfo(i, Enum.InfoType.Product);
	local productFrameClone = parent.Templates.ProductFrame:Clone();
	productFrameClone.CurrencyFrame.CoinsText.Text = v.coins;
	productFrameClone.BuyFrame.BuyButton.RobuxText.Text = format_int(productInfo.PriceInRobux);
	productFrameClone.ProductId.Value = productInfo.ProductId;
	productFrameClone.LayoutOrder = productInfo.PriceInRobux;
	productFrameClone.BuyFrame.BuyButton.Activated:connect(function()
		if game.PlaceId == 4787629450 or game:GetService("RunService"):IsStudio() then
			mpService:PromptProductPurchase(game.Players.LocalPlayer, i);
		end;
	end);
	productFrameClone.Parent = parent.Parchment.Container.List;
	productFrameClone.Visible = true;
end;
