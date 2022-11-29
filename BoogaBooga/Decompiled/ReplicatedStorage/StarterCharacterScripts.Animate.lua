-- Decompiled with the Synapse X Luau decompiler.

local l__Parent__1 = script.Parent;
local l__Humanoid__2 = l__Parent__1:WaitForChild("Humanoid");
local v3, v4 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop");
end);
local v5, v6 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserPlayEmoteByIdAnimTrackReturn");
end);
local v7, v8 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserAnimateScriptEmoteHook");
end);
local l__ScaleDampeningPercent__9 = script:FindFirstChild("ScaleDampeningPercent");
math.randomseed(tick());
function findExistingAnimationInSet(p1, p2)
	if p1 ~= nil then
		if p2 == nil then
			return 0;
		end;
	else
		return 0;
	end;
	local l__count__10 = p1.count;
	local v11 = 1 - 1;
	while true do
		if p1[v11].anim.AnimationId == p2.AnimationId then
			return v11;
		end;
		if 0 <= 1 then
			if v11 < l__count__10 then

			else
				break;
			end;
		elseif l__count__10 < v11 then

		else
			break;
		end;
		v11 = v11 + 1;	
	end;
	return 0;
end;
local u1 = {};
local u2 = {};
function configureAnimationSet(p3, p4)
	if u1[p3] ~= nil then
		local v12, v13, v14 = pairs(u1[p3].connections);
		while true do
			local v15, v16 = v12(v13, v14);
			if v15 then

			else
				break;
			end;
			v14 = v15;
			v16:disconnect();		
		end;
	end;
	u1[p3] = {};
	u1[p3].count = 0;
	u1[p3].totalWeight = 0;
	u1[p3].connections = {};
	local u3 = true;
	local v17, v18 = pcall(function()
		u3 = game:GetService("StarterPlayer").AllowCustomAnimations;
	end);
	if not v17 then
		u3 = true;
	end;
	local v19 = script:FindFirstChild(p3);
	if u3 then
		if v19 ~= nil then
			table.insert(u1[p3].connections, v19.ChildAdded:connect(function(p5)
				configureAnimationSet(p3, p4);
			end));
			table.insert(u1[p3].connections, v19.ChildRemoved:connect(function(p6)
				configureAnimationSet(p3, p4);
			end));
			local v20, v21, v22 = pairs(v19:GetChildren());
			while true do
				local v23, v24 = v20(v21, v22);
				if v23 then

				else
					break;
				end;
				v22 = v23;
				if v24:IsA("Animation") then
					local v25 = 1;
					local l__Weight__26 = v24:FindFirstChild("Weight");
					if l__Weight__26 ~= nil then
						v25 = l__Weight__26.Value;
					end;
					u1[p3].count = u1[p3].count + 1;
					local l__count__27 = u1[p3].count;
					u1[p3][l__count__27] = {};
					u1[p3][l__count__27].anim = v24;
					u1[p3][l__count__27].weight = v25;
					u1[p3].totalWeight = u1[p3].totalWeight + u1[p3][l__count__27].weight;
					table.insert(u1[p3].connections, v24.Changed:connect(function(p7)
						configureAnimationSet(p3, p4);
					end));
					table.insert(u1[p3].connections, v24.ChildAdded:connect(function(p8)
						configureAnimationSet(p3, p4);
					end));
					table.insert(u1[p3].connections, v24.ChildRemoved:connect(function(p9)
						configureAnimationSet(p3, p4);
					end));
				end;			
			end;
		end;
	end;
	if u1[p3].count <= 0 then
		local v28, v29, v30 = pairs(p4);
		while true do
			local v31, v32 = v28(v29, v30);
			if v31 then

			else
				break;
			end;
			v30 = v31;
			u1[p3][v31] = {};
			u1[p3][v31].anim = Instance.new("Animation");
			u1[p3][v31].anim.Name = p3;
			u1[p3][v31].anim.AnimationId = v32.id;
			u1[p3][v31].weight = v32.weight;
			u1[p3].count = u1[p3].count + 1;
			u1[p3].totalWeight = u1[p3].totalWeight + v32.weight;		
		end;
	end;
	local v33, v34, v35 = pairs(u1);
	while true do
		local v36, v37 = v33(v34, v35);
		if v36 then

		else
			break;
		end;
		local l__count__38 = v37.count;
		local v39 = 1 - 1;
		while true do
			if u2[v37[v39].anim.AnimationId] == nil then
				l__Humanoid__2:LoadAnimation(v37[v39].anim);
				u2[v37[v39].anim.AnimationId] = true;
			end;
			if 0 <= 1 then
				if v39 < l__count__38 then

				else
					break;
				end;
			elseif l__count__38 < v39 then

			else
				break;
			end;
			v39 = v39 + 1;		
		end;	
	end;
end;
function configureAnimationSetOld(p10, p11)
	if u1[p10] ~= nil then
		local v40, v41, v42 = pairs(u1[p10].connections);
		while true do
			local v43, v44 = v40(v41, v42);
			if v43 then

			else
				break;
			end;
			v42 = v43;
			v44:disconnect();		
		end;
	end;
	u1[p10] = {};
	u1[p10].count = 0;
	u1[p10].totalWeight = 0;
	u1[p10].connections = {};
	local u4 = true;
	local v45, v46 = pcall(function()
		u4 = game:GetService("StarterPlayer").AllowCustomAnimations;
	end);
	if not v45 then
		u4 = true;
	end;
	local v47 = script:FindFirstChild(p10);
	if u4 then
		if v47 ~= nil then
			table.insert(u1[p10].connections, v47.ChildAdded:connect(function(p12)
				configureAnimationSet(p10, p11);
			end));
			table.insert(u1[p10].connections, v47.ChildRemoved:connect(function(p13)
				configureAnimationSet(p10, p11);
			end));
			local v48 = 1;
			local v49, v50, v51 = pairs(v47:GetChildren());
			while true do
				local v52, v53 = v49(v50, v51);
				if v52 then

				else
					break;
				end;
				v51 = v52;
				if v53:IsA("Animation") then
					table.insert(u1[p10].connections, v53.Changed:connect(function(p14)
						configureAnimationSet(p10, p11);
					end));
					u1[p10][v48] = {};
					u1[p10][v48].anim = v53;
					local l__Weight__54 = v53:FindFirstChild("Weight");
					if l__Weight__54 == nil then
						u1[p10][v48].weight = 1;
					else
						u1[p10][v48].weight = l__Weight__54.Value;
					end;
					u1[p10].count = u1[p10].count + 1;
					u1[p10].totalWeight = u1[p10].totalWeight + u1[p10][v48].weight;
					v48 = v48 + 1;
				end;			
			end;
		end;
	end;
	if u1[p10].count <= 0 then
		local v55, v56, v57 = pairs(p11);
		while true do
			local v58, v59 = v55(v56, v57);
			if v58 then

			else
				break;
			end;
			v57 = v58;
			u1[p10][v58] = {};
			u1[p10][v58].anim = Instance.new("Animation");
			u1[p10][v58].anim.Name = p10;
			u1[p10][v58].anim.AnimationId = v59.id;
			u1[p10][v58].weight = v59.weight;
			u1[p10].count = u1[p10].count + 1;
			u1[p10].totalWeight = u1[p10].totalWeight + v59.weight;		
		end;
	end;
	local v60, v61, v62 = pairs(u1);
	while true do
		local v63, v64 = v60(v61, v62);
		if v63 then

		else
			break;
		end;
		local l__count__65 = v64.count;
		local v66 = 1 - 1;
		while true do
			l__Humanoid__2:LoadAnimation(v64[v66].anim);
			if 0 <= 1 then
				if v66 < l__count__65 then

				else
					break;
				end;
			elseif l__count__65 < v66 then

			else
				break;
			end;
			v66 = v66 + 1;		
		end;	
	end;
end;
local u5 = {
	idle = { {
			id = "http://www.roblox.com/asset/?id=507766666", 
			weight = 1
		}, {
			id = "http://www.roblox.com/asset/?id=507766951", 
			weight = 1
		}, {
			id = "http://www.roblox.com/asset/?id=507766388", 
			weight = 9
		} }, 
	walk = { {
			id = "http://www.roblox.com/asset/?id=507777826", 
			weight = 10
		} }, 
	run = { {
			id = "http://www.roblox.com/asset/?id=507767714", 
			weight = 10
		} }, 
	swim = { {
			id = "http://www.roblox.com/asset/?id=507784897", 
			weight = 10
		} }, 
	swimidle = { {
			id = "http://www.roblox.com/asset/?id=507785072", 
			weight = 10
		} }, 
	jump = { {
			id = "http://www.roblox.com/asset/?id=507765000", 
			weight = 10
		} }, 
	fall = { {
			id = "http://www.roblox.com/asset/?id=507767968", 
			weight = 10
		} }, 
	climb = { {
			id = "http://www.roblox.com/asset/?id=507765644", 
			weight = 10
		} }, 
	sit = { {
			id = "http://www.roblox.com/asset/?id=2506281703", 
			weight = 10
		} }, 
	toolnone = { {
			id = "http://www.roblox.com/asset/?id=507768375", 
			weight = 10
		} }, 
	toolslash = { {
			id = "http://www.roblox.com/asset/?id=522635514", 
			weight = 10
		} }, 
	toollunge = { {
			id = "http://www.roblox.com/asset/?id=522638767", 
			weight = 10
		} }, 
	wave = { {
			id = "http://www.roblox.com/asset/?id=507770239", 
			weight = 10
		} }, 
	point = { {
			id = "http://www.roblox.com/asset/?id=507770453", 
			weight = 10
		} }, 
	dance = { {
			id = "http://www.roblox.com/asset/?id=507771019", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507771955", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507772104", 
			weight = 10
		} }, 
	dance2 = { {
			id = "http://www.roblox.com/asset/?id=507776043", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507776720", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507776879", 
			weight = 10
		} }, 
	dance3 = { {
			id = "http://www.roblox.com/asset/?id=507777268", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507777451", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507777623", 
			weight = 10
		} }, 
	laugh = { {
			id = "http://www.roblox.com/asset/?id=507770818", 
			weight = 10
		} }, 
	cheer = { {
			id = "http://www.roblox.com/asset/?id=507770677", 
			weight = 10
		} }
};
function scriptChildModified(p15)
	local v67 = u5[p15.Name];
	if v67 ~= nil then
		configureAnimationSet(p15.Name, v67);
	end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
for v68, v69 in pairs(u5) do
	configureAnimationSet(v68, v69);
end;
local u6 = "";
local u7 = {
	wave = false, 
	point = false, 
	dance = true, 
	dance2 = true, 
	dance3 = true, 
	laugh = false, 
	cheer = false
};
local u8 = v7 or v8;
local u9 = false;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
function stopAllAnimations()
	local v70 = u6;
	if u7[v70] ~= nil then
		if u7[v70] == false then
			v70 = "idle";
		end;
	end;
	if u8 then
		if u9 then
			v70 = "idle";
			u9 = false;
		end;
	end;
	u6 = "";
	u10 = nil;
	if u11 ~= nil then
		u11:disconnect();
	end;
	if u12 ~= nil then
		u12:Stop();
		u12:Destroy();
		u12 = nil;
	end;
	if u13 ~= nil then
		u13:disconnect();
	end;
	if u14 ~= nil then
		u14:Stop();
		u14:Destroy();
		u14 = nil;
	end;
	return v70;
end;
local u15 = l__ScaleDampeningPercent__9;
function getHeightScale()
	if l__Humanoid__2 then

	else
		return 1;
	end;
	if not l__Humanoid__2.AutomaticScalingEnabled then
		return 1;
	end;
	local v71 = l__Humanoid__2.HipHeight / 2;
	if u15 == nil then
		u15 = script:FindFirstChild("ScaleDampeningPercent");
	end;
	if u15 ~= nil then
		v71 = 1 + (l__Humanoid__2.HipHeight - 2) * u15.Value / 2;
	end;
	return v71;
end;
local u16 = 1;
function setRunSpeed(p16)
	local v72 = p16 * 1.25 / getHeightScale();
	if v72 ~= u16 then
		if v72 < 0.33 then
			u12:AdjustWeight(1);
			u14:AdjustWeight(0.0001);
		elseif v72 < 0.66 then
			local v73 = (v72 - 0.33) / 0.33;
			u12:AdjustWeight(1 - v73 + 0.0001);
			u14:AdjustWeight(v73 + 0.0001);
		else
			u12:AdjustWeight(0.0001);
			u14:AdjustWeight(1);
		end;
		u16 = v72;
		u14:AdjustSpeed(v72);
		u12:AdjustSpeed(v72);
	end;
end;
function setAnimationSpeed(p17)
	if u6 == "walk" then
		setRunSpeed(p17);
		return;
	end;
	if p17 ~= u16 then
		u16 = p17;
		u12:AdjustSpeed(u16);
	end;
end;
local u17 = v3 or v4;
function keyFrameReachedFunc(p18)
	if p18 == "End" then
		if u6 == "walk" then
			if u17 == true then

			else
				u14.TimePosition = 0;
				u12.TimePosition = 0;
				return;
			end;
			if u14.Looped ~= true then
				u14.TimePosition = 0;
			end;
			if u12.Looped ~= true then
				u12.TimePosition = 0;
				return;
			end;
		else
			local v74 = u6;
			if u7[v74] ~= nil then
				if u7[v74] == false then
					v74 = "idle";
				end;
			end;
			if u8 then
				if u9 then
					if u12.Looped then
						return;
					end;
					v74 = "idle";
					u9 = false;
				end;
			end;
			playAnimation(v74, 0.15, l__Humanoid__2);
			setAnimationSpeed(u16);
		end;
	end;
end;
function rollAnimation(p19)
	local v75 = math.random(1, u1[p19].totalWeight);
	local v76 = 1;
	while true do
		if u1[p19][v76].weight < v75 then

		else
			break;
		end;
		v75 = v75 - u1[p19][v76].weight;
		v76 = v76 + 1;	
	end;
	return v76;
end;
local function u18(p20, p21, p22, p23)
	if p20 ~= u10 then
		if u12 ~= nil then
			u12:Stop(p22);
			u12:Destroy();
		end;
		if u14 ~= nil then
			u14:Stop(p22);
			u14:Destroy();
			if u17 == true then
				u14 = nil;
			end;
		end;
		u16 = 1;
		u12 = p23:LoadAnimation(p20);
		u12.Priority = Enum.AnimationPriority.Core;
		u12:Play(p22);
		u6 = p21;
		u10 = p20;
		if u11 ~= nil then
			u11:disconnect();
		end;
		u11 = u12.KeyframeReached:connect(keyFrameReachedFunc);
		if p21 == "walk" then
			u14 = p23:LoadAnimation(u1.run[rollAnimation("run")].anim);
			u14.Priority = Enum.AnimationPriority.Core;
			u14:Play(p22);
			if u13 ~= nil then
				u13:disconnect();
			end;
			u13 = u14.KeyframeReached:connect(keyFrameReachedFunc);
		end;
	end;
end;
function playAnimation(p24, p25, p26)
	u18(u1[p24][rollAnimation(p24)].anim, p24, p25, p26);
	u9 = false;
end;
function playEmote(p27, p28, p29)
	u18(p27, p27.Name, p28, p29);
	u9 = true;
end;
local u19 = "";
function toolKeyFrameReachedFunc(p30)
	if p30 == "End" then
		playToolAnimation(u19, 0, l__Humanoid__2);
	end;
end;
local u20 = nil;
local u21 = nil;
local u22 = nil;
function playToolAnimation(p31, p32, p33, p34)
	local l__anim__77 = u1[p31][rollAnimation(p31)].anim;
	if u20 ~= l__anim__77 then
		if u21 ~= nil then
			u21:Stop();
			u21:Destroy();
			p32 = 0;
		end;
		u21 = p33:LoadAnimation(l__anim__77);
		if p34 then
			u21.Priority = p34;
		end;
		u21:Play(p32);
		u19 = p31;
		u20 = l__anim__77;
		u22 = u21.KeyframeReached:connect(toolKeyFrameReachedFunc);
	end;
end;
function stopToolAnimations()
	if u22 ~= nil then
		u22:disconnect();
	end;
	u19 = "";
	u20 = nil;
	if u21 ~= nil then
		u21:Stop();
		u21:Destroy();
		u21 = nil;
	end;
	return u19;
end;
local u23 = "Standing";
function onRunning(p35)
	if 0.75 < p35 then
		playAnimation("walk", 0.2, l__Humanoid__2);
		setAnimationSpeed(p35 / 16);
		u23 = "Running";
		return;
	end;
	if u7[u6] == nil then
		if not u9 then
			playAnimation("idle", 0.2, l__Humanoid__2);
			u23 = "Standing";
		end;
	end;
end;
function onDied()
	u23 = "Dead";
end;
local u24 = 0;
function onJumping()
	playAnimation("jump", 0.1, l__Humanoid__2);
	u24 = 0.31;
	u23 = "Jumping";
end;
function onClimbing(p36)
	playAnimation("climb", 0.1, l__Humanoid__2);
	setAnimationSpeed(p36 / 5);
	u23 = "Climbing";
end;
function onGettingUp()
	u23 = "GettingUp";
end;
function onFreeFall()
	if u24 <= 0 then
		playAnimation("fall", 0.2, l__Humanoid__2);
	end;
	u23 = "FreeFall";
end;
function onFallingDown()
	u23 = "FallingDown";
end;
function onSeated()
	u23 = "Seated";
end;
function onPlatformStanding()
	u23 = "PlatformStanding";
end;
function onSwimming(p37)
	if 1 < p37 then

	else
		playAnimation("swimidle", 0.4, l__Humanoid__2);
		u23 = "Standing";
		return;
	end;
	playAnimation("swim", 0.4, l__Humanoid__2);
	setAnimationSpeed(p37 / 10);
	u23 = "Swimming";
end;
local u25 = "None";
function animateTool()
	if u25 == "None" then
		playToolAnimation("toolnone", 0.1, l__Humanoid__2, Enum.AnimationPriority.Idle);
		return;
	end;
	if u25 == "Slash" then
		playToolAnimation("toolslash", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
		return;
	end;
	if u25 == "Lunge" then

	else
		return;
	end;
	playToolAnimation("toollunge", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
end;
function getToolAnim(p38)
	local v78, v79, v80 = ipairs(p38:GetChildren());
	while true do
		local v81, v82 = v78(v79, v80);
		if v81 then

		else
			break;
		end;
		v80 = v81;
		if v82.Name == "toolanim" then
			if v82.className == "StringValue" then
				return v82;
			end;
		end;	
	end;
	return nil;
end;
local u26 = 0;
local u27 = 0;
function stepAnimate(p39)
	u26 = p39;
	if 0 < u24 then
		u24 = u24 - (p39 - u26);
	end;
	if u23 == "FreeFall" then
		if u24 <= 0 then
			playAnimation("fall", 0.2, l__Humanoid__2);
		else
			if u23 == "Seated" then
				playAnimation("sit", 0.5, l__Humanoid__2);
				return;
			end;
			if u23 == "Running" then
				playAnimation("walk", 0.2, l__Humanoid__2);
			elseif u23 ~= "Dead" then
				if u23 ~= "GettingUp" then
					if u23 ~= "FallingDown" then
						if u23 ~= "Seated" then
							if u23 == "PlatformStanding" then
								stopAllAnimations();
							end;
						else
							stopAllAnimations();
						end;
					else
						stopAllAnimations();
					end;
				else
					stopAllAnimations();
				end;
			else
				stopAllAnimations();
			end;
		end;
	else
		if u23 == "Seated" then
			playAnimation("sit", 0.5, l__Humanoid__2);
			return;
		end;
		if u23 == "Running" then
			playAnimation("walk", 0.2, l__Humanoid__2);
		elseif u23 ~= "Dead" then
			if u23 ~= "GettingUp" then
				if u23 ~= "FallingDown" then
					if u23 ~= "Seated" then
						if u23 == "PlatformStanding" then
							stopAllAnimations();
						end;
					else
						stopAllAnimations();
					end;
				else
					stopAllAnimations();
				end;
			else
				stopAllAnimations();
			end;
		else
			stopAllAnimations();
		end;
	end;
	local v83 = l__Parent__1:FindFirstChildOfClass("Tool");
	if v83 then
		if v83:FindFirstChild("Handle") then

		else
			stopToolAnimations();
			u25 = "None";
			u20 = nil;
			u27 = 0;
			return;
		end;
	else
		stopToolAnimations();
		u25 = "None";
		u20 = nil;
		u27 = 0;
		return;
	end;
	local v84 = getToolAnim(v83);
	if v84 then
		u25 = v84.Value;
		v84.Parent = nil;
		u27 = p39 + 0.3;
	end;
	if u27 < p39 then
		u27 = 0;
		u25 = "None";
	end;
	animateTool();
end;
l__Humanoid__2.Died:connect(onDied);
l__Humanoid__2.Running:connect(onRunning);
l__Humanoid__2.Jumping:connect(onJumping);
l__Humanoid__2.Climbing:connect(onClimbing);
l__Humanoid__2.GettingUp:connect(onGettingUp);
l__Humanoid__2.FreeFalling:connect(onFreeFall);
l__Humanoid__2.FallingDown:connect(onFallingDown);
l__Humanoid__2.Seated:connect(onSeated);
l__Humanoid__2.PlatformStanding:connect(onPlatformStanding);
l__Humanoid__2.Swimming:connect(onSwimming);
game:GetService("Players").LocalPlayer.Chatted:connect(function(p40)
	local v85 = "";
	if string.sub(p40, 1, 3) == "/e " then
		v85 = string.sub(p40, 4);
	elseif string.sub(p40, 1, 7) == "/emote " then
		v85 = string.sub(p40, 8);
	end;
	if u23 == "Standing" and u7[v85] ~= nil then
		playAnimation(v85, 0.1, l__Humanoid__2);
	end;
end);
if u8 then
	local u28 = v5 or v6;
	script:WaitForChild("PlayEmote").OnInvoke = function(p41)
		if u23 ~= "Standing" then
			return;
		end;
		if u7[p41] ~= nil then
			playAnimation(p41, 0.1, l__Humanoid__2);
			if u28 then
				return true, u12;
			else
				return true;
			end;
		end;
		if typeof(p41) ~= "Instance" or not p41:IsA("Animation") then
			return false;
		end;
		playEmote(p41, 0.1, l__Humanoid__2);
		if u28 then
			return true, u12;
		end;
		return true;
	end;
end;
playAnimation("idle", 0.1, l__Humanoid__2);
u23 = "Standing";
while l__Parent__1.Parent ~= nil do
	local v86, v87 = wait(0.1);
	stepAnimate(v87);
end;
