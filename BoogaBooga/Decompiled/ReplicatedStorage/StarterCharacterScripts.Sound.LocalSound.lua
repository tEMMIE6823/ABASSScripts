-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	Died = 0, 
	Running = 1, 
	Swimming = 2, 
	Climbing = 3, 
	Jumping = 4, 
	GettingUp = 5, 
	FreeFalling = 6, 
	FallingDown = 7, 
	Landing = 8, 
	Splash = 9
};
local v2 = {};
local l__Parent__3 = script.Parent.Parent;
local l__Head__4 = l__Parent__3:WaitForChild("Head");
local l__Humanoid__5 = l__Parent__3:WaitForChild("Humanoid");
v2[v1.Died] = l__Head__4:WaitForChild("Died");
v2[v1.Running] = l__Head__4:WaitForChild("Running");
v2[v1.Swimming] = l__Head__4:WaitForChild("Swimming");
v2[v1.Climbing] = l__Head__4:WaitForChild("Climbing");
v2[v1.Jumping] = l__Head__4:WaitForChild("Jumping");
v2[v1.GettingUp] = l__Head__4:WaitForChild("GettingUp");
v2[v1.FreeFalling] = l__Head__4:WaitForChild("FreeFalling");
v2[v1.Landing] = l__Head__4:WaitForChild("Landing");
v2[v1.Splash] = l__Head__4:WaitForChild("Splash");
local v6 = {
	YForLineGivenXAndTwoPts = function(p1, p2, p3, p4, p5)
		local v7 = (p3 - p5) / (p2 - p4);
		return v7 * p1 + (p3 - v7 * p2);
	end, 
	Clamp = function(p6, p7, p8)
		return math.min(p8, math.max(p7, p6));
	end, 
	HorizontalVelocityMagnitude = function(p9)
		return (p9.Velocity + Vector3.new(0, -p9.Velocity.Y, 0)).magnitude;
	end, 
	VerticalVelocityMagnitude = function(p10)
		return math.abs(p10.Velocity.Y);
	end, 
	SoundIsV2 = function(p11)
		return p11.IsLoaded;
	end
};
local u1 = nil;
function v6.Play(p12)
	if u1.SoundIsV2(p12) then
		if p12.TimePosition ~= 0 then
			p12.TimePosition = 0;
		end;
		if p12.IsPlaying then
			return;
		end;
	else
		p12:Play();
		return;
	end;
	p12.Playing = true;
end;
function v6.Pause(p13)
	if u1.SoundIsV2(p13) then
		if not p13.IsPlaying then
			return;
		end;
	else
		p13:Pause();
		return;
	end;
	p13.Playing = false;
end;
function v6.Resume(p14)
	if u1.SoundIsV2(p14) then
		if p14.IsPlaying then
			return;
		end;
	else
		p14:Resume();
		return;
	end;
	p14.Playing = true;
end;
function v6.Stop(p15)
	if u1.SoundIsV2(p15) then
		if p15.IsPlaying then
			p15.Playing = false;
		end;
		if p15.TimePosition == 0 then
			return;
		end;
	else
		p15:Stop();
		return;
	end;
	p15.TimePosition = 0;
end;
u1 = v6;
function verifyAndSetLoopedForSound(p16, p17)
	if p16.Looped ~= p17 then
		p16.Looped = p17;
	end;
end;
local u2 = {};
function setSoundInActiveLooped(p18)
	local v8 = #u2;
	local v9 = 1 - 1;
	while true do
		if u2[v9] == p18 then
			return;
		end;
		if 0 <= 1 then
			if v9 < v8 then

			else
				break;
			end;
		elseif v8 < v9 then

		else
			break;
		end;
		v9 = v9 + 1;	
	end;
	table.insert(u2, p18);
end;
function stopActiveLoopedSoundsExcept(p19)
	local v10 = #u2 - -1;
	while true do
		if u2[v10] ~= p19 then
			u1.Pause(u2[v10]);
			table.remove(u2, v10);
		end;
		if 0 <= -1 then
			if v10 < 1 then

			else
				break;
			end;
		elseif 1 < v10 then

		else
			break;
		end;
		v10 = v10 + -1;	
	end;
end;
local v11 = {};
v11[Enum.HumanoidStateType.Dead] = function()
	stopActiveLoopedSoundsExcept();
	local v12 = v2[v1.Died];
	verifyAndSetLoopedForSound(v12, false);
	u1.Play(v12);
end;
v11[Enum.HumanoidStateType.RunningNoPhysics] = function()
	stateUpdated(Enum.HumanoidStateType.Running);
end;
local u3 = nil;
v11[Enum.HumanoidStateType.Running] = function()
	local v13, v14, v15, v16 = workspace:FindPartOnRay(Ray.new(l__Head__4.Position, Vector3.new(0, -15, 0)), l__Head__4.Parent);
	if v16 == Enum.Material.Water then
		local v17 = v2[v1.Swimming];
		if u3 ~= Enum.HumanoidStateType.Swimming then
			u3 = Enum.HumanoidStateType.Swimming;
			local v18 = v2[v1.Splash];
			v18.Volume = 0.1;
			u1.Play(v18);
		end;
	else
		if u3 == Enum.HumanoidStateType.Swimming then
			local v19 = v2[v1.Splash];
			v19.Volume = 0.1;
			u1.Play(v19);
		end;
		v17 = v2[v1.Running];
		u3 = Enum.HumanoidStateType.Running;
	end;
	verifyAndSetLoopedForSound(v17, true);
	stopActiveLoopedSoundsExcept(v17);
	if not (u1.HorizontalVelocityMagnitude(l__Head__4) > 0.5) then
		stopActiveLoopedSoundsExcept();
		return;
	end;
	if not v17.IsPlaying then
		u1.Resume(v17);
	end;
	setSoundInActiveLooped(v17);
end;
v11[Enum.HumanoidStateType.Swimming] = function()
	if u3 ~= Enum.HumanoidStateType.Swimming and u1.VerticalVelocityMagnitude(l__Head__4) > 0.1 then
		local v20 = v2[v1.Splash];
		v20.Volume = u1.Clamp(u1.YForLineGivenXAndTwoPts(u1.VerticalVelocityMagnitude(l__Head__4), 100, 0.28, 350, 1), 0, 1);
		u1.Play(v20);
	end;
	local v21 = v2[v1.Swimming];
	verifyAndSetLoopedForSound(v21, true);
	stopActiveLoopedSoundsExcept(v21);
	if not v21.IsPlaying then
		u1.Resume(v21);
	end;
	setSoundInActiveLooped(v21);
end;
v11[Enum.HumanoidStateType.Climbing] = function()
	local v22 = v2[v1.Climbing];
	verifyAndSetLoopedForSound(v22, true);
	if u1.VerticalVelocityMagnitude(l__Head__4) > 0.1 then
		if not v22.IsPlaying then
			u1.Resume(v22);
		end;
		stopActiveLoopedSoundsExcept(v22);
	else
		stopActiveLoopedSoundsExcept();
	end;
	setSoundInActiveLooped(v22);
end;
v11[Enum.HumanoidStateType.Jumping] = function()
	if u3 == Enum.HumanoidStateType.Jumping then
		return;
	end;
	local v23, v24, v25, v26 = workspace:FindPartOnRay(Ray.new(l__Head__4.Position, Vector3.new(0, -15, 0)), l__Head__4.Parent);
	local v27 = v2[v1.Splash];
	if v26 and v26 == Enum.Material.Water then
		v27.Volume = 0.1;
		u1.Play(v27);
	end;
	stopActiveLoopedSoundsExcept();
	local v28 = v2[v1.Jumping];
	verifyAndSetLoopedForSound(v28, false);
	u1.Play(v28);
end;
v11[Enum.HumanoidStateType.GettingUp] = function()
	stopActiveLoopedSoundsExcept();
	local v29 = v2[v1.GettingUp];
	verifyAndSetLoopedForSound(v29, false);
	u1.Play(v29);
end;
v11[Enum.HumanoidStateType.Freefall] = function()
	if u3 == Enum.HumanoidStateType.Freefall then
		return;
	end;
	local v30 = v2[v1.FreeFalling];
	if v30.Volume ~= 0 then
		v30.Volume = 0;
	end;
	stopActiveLoopedSoundsExcept();
end;
v11[Enum.HumanoidStateType.FallingDown] = function()
	stopActiveLoopedSoundsExcept();
end;
v11[Enum.HumanoidStateType.Landed] = function()
	stopActiveLoopedSoundsExcept();
	if u1.VerticalVelocityMagnitude(l__Head__4) > 75 then
		local v31 = v2[v1.Landing];
		v31.Volume = u1.Clamp(u1.YForLineGivenXAndTwoPts(u1.VerticalVelocityMagnitude(l__Head__4), 50, 0, 100, 1), 0, 1);
		u1.Play(v31);
	end;
end;
function stateUpdated(p20)
	if v11[p20] ~= nil then
		v11[p20]();
	end;
	local v32, v33, v34, v35 = workspace:FindPartOnRay(Ray.new(l__Head__4.Position, Vector3.new(0, -15, 0)), l__Head__4.Parent);
	if v35 then
		if v35 == Enum.Material.Water then
			return;
		end;
	end;
	u3 = p20;
end;
function onHeartbeat(p21)
	local v36 = v2[v1.FreeFalling];
	if u3 == Enum.HumanoidStateType.Freefall then
		if l__Head__4.Velocity.Y < 0 then
			if 75 < u1.VerticalVelocityMagnitude(l__Head__4) then
				if not v36.IsPlaying then
					u1.Resume(v36);
				end;
				if v36.Volume < 1 then
					v36.Volume = u1.Clamp(v36.Volume + 0.01 * (p21 / 0.016666666666666666), 0, 1);
				end;
			elseif v36.Volume ~= 0 then
				v36.Volume = 0;
			end;
		elseif v36.Volume ~= 0 then
			v36.Volume = 0;
		end;
	elseif v36.IsPlaying then
		u1.Pause(v36);
	end;
	local v37 = v2[v1.Running];
	if u3 == Enum.HumanoidStateType.Running then
		if v37.IsPlaying then
			if u1.HorizontalVelocityMagnitude(l__Head__4) < 0.5 then
				u1.Pause(v37);
			end;
		end;
	end;
end;
l__Humanoid__5.Died:connect(function()
	stateUpdated(Enum.HumanoidStateType.Dead);
end);
l__Humanoid__5.Running:connect(function()
	stateUpdated(Enum.HumanoidStateType.Running);
end);
l__Humanoid__5.Swimming:connect(function()
	stateUpdated(Enum.HumanoidStateType.Swimming);
end);
l__Humanoid__5.Climbing:connect(function()
	stateUpdated(Enum.HumanoidStateType.Climbing);
end);
l__Humanoid__5.Jumping:connect(function()
	stateUpdated(Enum.HumanoidStateType.Jumping);
end);
l__Humanoid__5.GettingUp:connect(function()
	stateUpdated(Enum.HumanoidStateType.GettingUp);
end);
l__Humanoid__5.FreeFalling:connect(function()
	stateUpdated(Enum.HumanoidStateType.Freefall);
end);
l__Humanoid__5.FallingDown:connect(function()
	stateUpdated(Enum.HumanoidStateType.FallingDown);
end);
l__Humanoid__5.StateChanged:connect(function(p22, p23)
	stateUpdated(p23);
end);
game:GetService("RunService").Heartbeat:connect(onHeartbeat);
