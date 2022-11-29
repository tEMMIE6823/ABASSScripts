--Decompiled with the Synapse X Luau decompiler.
-- Fixed up by mrk0#4119


-- \\  Services  \\ --
local rs = game:GetService("ReplicatedStorage");

-- \\  Variables  \\ --
local lp = game.Players.LocalPlayer;
local proximalGui = lp:WaitForChild("PlayerGui"):WaitForChild("ProximalGui");
local u1 = nil;
local clientFunctionBank = require(rs.Modules.Client_Function_Bank);

-- \\  Functions  \\ --
function SetData(p1)
	_G.Data = p1;
	if not u1 then
		u1 = true;
		clientFunctionBank.SortToolbar();
		clientFunctionBank.DrawInventory();
		clientFunctionBank.DrawCraftMenu();
		clientFunctionBank.UpdateCosmetics();
		clientFunctionBank.DrawTribeGui();
		clientFunctionBank.OpenGui();
		clientFunctionBank.UpdateStats();
		clientFunctionBank.DrawUserSettings();
	end;
	lp.PlayerScripts.Client_Sound_Handler.MuteToggle:Fire();
	lp.PlayerGui.ProximalGui.TogglePickupMode:Fire(_G.Data.userSettings.pickupStyle);
end;

function GetData()
	SetData((rs.Events.RequestData:InvokeServer()));
end;

-- \\  Code  \\ --
rs.Events.UpdateData.OnClientEvent:connect(function(p2, ...)
	SetData(p2);
	if ... then
		local name, before = ...;
		while true do
			local v7, v8 = next(name, before);
			if not v7 then
				break;
			end;
			before = v7;
			clientFunctionBank[v8[1]](table.unpack(v8[2] or {}));		
		end;
	end;
end);

function GetData()
	SetData((rs.Events.RequestData:InvokeServer()));
end;
GetData();
