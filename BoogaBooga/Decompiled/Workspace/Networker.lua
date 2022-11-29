-- Decompiled with the Synapse X Luau decompiler.
-- Might clean this up if it becomes useful (At anypoint in time)

local v1 = {};
local u1 = require(script.Events);
local u2 = {
	Event = {}, 
	Function = {}
};
function v1.bind(p1, p2)
	if u1[p1] then
		u2[u1[p1]][p1] = p2;
	end;
end;
local l__RunService__3 = game:GetService("RunService");
local l__Event__4 = script:FindFirstChild("Event");
local l__Function__5 = script:FindFirstChild("Function");
function v1.fire(p3, p4, ...)
	if u1[p3] then
		local v2 = nil;
		v2 = u1[p3];
		if l__RunService__3:IsServer() then
			if v2 == "Event" then
				l__Event__4:FireClient(p4, p3, ...);
				return;
			elseif v2 == "Function" then
				return l__Function__5:InvokeClient(p4, p3, ...);
			else
				return;
			end;
		else
			if v2 == "Event" then
				l__Event__4:FireServer(p3, p4, ...);
				return;
			end;
			if v2 ~= "Function" then
				return;
			end;
		end;
	else
		return;
	end;
	return l__Function__5:InvokeServer(p3, p4, ...);
end;
if l__RunService__3:IsServer() then
	local u6 = {
		remotes = {}, 
		players = {}
	};
	l__Event__4.OnServerEvent:Connect(function(p5, p6, ...)
		if (u6.remotes[p6] and 0.1) < tick() - (u6.players[p5] and 0) then
			u6.players[p5] = tick();
			u2.Event[p6](p5, ...);
		end;
	end);
	function l__Function__5.OnServerInvoke(p7, p8, ...)
		return u2.Function[p8](p7, ...);
	end;
	return v1;
end;
l__Event__4.OnClientEvent:Connect(function(p9, ...)
	u2.Event[p9](...);
end);
function l__Function__5.OnClientInvoke(p10, ...)
	return u2.Function[p10](...);
end;
return v1;
