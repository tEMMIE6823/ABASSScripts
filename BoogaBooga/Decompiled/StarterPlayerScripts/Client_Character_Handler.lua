-- Decompiled with the Synapse X Luau decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
_G.localPlayer = game.Players.LocalPlayer;
_G.alive = nil;
_G.cam = nil;
_G.char = nil;
_G.root = nil;
_G.hum = nil;
_G.mouse = game.Players.LocalPlayer:GetMouse();
local u1 = require(l__ReplicatedStorage__2.Modules.Client_Function_Bank);
local l__TweenService__2 = game:GetService("TweenService");
local l__PlayerGui__3 = _G.localPlayer.PlayerGui;
local u4 = require(l__ReplicatedStorage__2.Modules.ColorData);
local u5 = nil;
function SetupCharacter(p1)
	_G.char = p1;
	_G.root = p1:WaitForChild("HumanoidRootPart");
	_G.hum = p1:WaitForChild("Humanoid");
	_G.cam = workspace.CurrentCamera;
	_G.cam.FieldOfView = 65;
	local l__next__3 = next;
	local v4 = game.ReplicatedStorage.StarterCharacterScripts:GetChildren();
	local v5 = nil;
	while true do
		local v6, v7 = l__next__3(v4, v5);
		if v6 then

		else
			break;
		end;
		v5 = v6;
		if v7.ClassName == "LocalScript" then
			local v8 = v7:Clone();
			v8.Disabled = true;
			v8.Parent = _G.char;
			v8.Disabled = false;
		end;	
	end;
	if _G.Data.hasSpawned == false then
		_G.hideOthers = true;
		u1.ToggleOtherCharacters(false);
		game.Lighting.Bloom.Intensity = 0.6;
		l__TweenService__2:Create(game.Lighting.Bloom, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Intensity = 0
		}):Play();
		_G.cam.CameraType = Enum.CameraType.Scriptable;
		lockTorsoOrientation = false;
		l__PlayerGui__3.SpawnGui.Enabled = true;
		u1.mainGui.Enabled = false;
		_G.cam.CFrame = l__ReplicatedStorage__2.SpawnCamCF.Value;
		return;
	end;
	if _G.Data.hasSpawned == true then
		_G.cam.CameraType = Enum.CameraType.Custom;
		lockTorsoOrientation = true;
		l__PlayerGui__3.SpawnGui.Enabled = false;
		u1.mainGui.Enabled = true;
		_G.hideOthers = false;
		u1.ToggleOtherCharacters(true);
	end;
	if not _G.Data.hasSpawned then
		u1.FadeTrack(l__ReplicatedStorage__2.Sounds.Music.BeautyMusic, 50, 30);
		spawn(function()
			wait(4);
			u1.MakeToast({
				title = "YOU:", 
				message = "...Where am I?", 
				color = u4.brownUI, 
				image = "", 
				duration = 6
			});
			wait(6);
			if not _G.Data.hasSpawned then
				u1.MakeToast({
					title = "YOU:", 
					message = "I should make a raft...", 
					color = u4.brownUI, 
					image = "", 
					duration = 8
				});
				wait(4);
			end;
			if not _G.Data.hasSpawned then
				u1.CreateNotification("Press C to open your bag!", u4.badRed, 4);
			end;
			wait(14);
			if not _G.Data.hasSpawned then
				u1.CreateNotification(_G.localPlayer.Name .. "! Press C to open your bag!", u4.badRed, 6);
			end;
		end);
	else
		u1.FadeTrack(l__ReplicatedStorage__2.Sounds.Music.BeautyMusic, 30, 0);
	end;
	_G.cam.CameraType = Enum.CameraType.Custom;
	_G.hum.HealthChanged:connect(function()
		u1.UpdateStats();
	end);
	_G.hum.StateChanged:connect(function()
		if _G.hum:GetState() == Enum.HumanoidStateType.Seated then

		else
			lockTorsoOrientation = true;
			return;
		end;
		_G.char.Head:FindFirstChild("Running"):Stop();
		lockTorsoOrientation = false;
	end);
	_G.hum.Died:connect(function()
		lockTorsoOrientation = false;
		if u5 then
			u5:Disconnect();
			u5 = nil;
		end;
		_G.alive = false;
	end);
	_G.hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, false);
	_G.hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false);
	_G.hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false);
	_G.anims = {};
	coroutine.wrap(function()
		local l__next__9 = next;
		local v10, v11 = l__ReplicatedStorage__2.Animations:GetChildren();
		while true do
			local v12, v13 = l__next__9(v10, v11);
			if v12 then

			else
				break;
			end;
			v11 = v12;
			_G.anims[v13.Name] = _G.hum:LoadAnimation((v13:Clone()));
			wait();		
		end;
	end)();
	_G.alive = true;
	return true;
end;
function InterpretMouseTarget()

end;
function OrientCharacter()
	_G.hum.AutoRotate = not _G.Data.userSettings.camLock;
	if _G.char then
		if _G.root then
			if _G.cam then
				local v14 = true;
				local l__SeatPart__15 = _G.hum.SeatPart;
				if l__SeatPart__15 then
					if l__SeatPart__15:FindFirstChild("LookEvent") then
						v14 = false;
						local v16, v17 = u1.MiddleScreenRay();
						l__SeatPart__15.LookEvent:FireServer(v17);
					end;
				end;
				local v18 = _G.hum:GetState();
				if _G.Data.userSettings.camLock then
					if v18 ~= Enum.HumanoidStateType.Swimming then
						if not _G.hum.Sit then
							if lockTorsoOrientation then
								if v14 then
									local v19, v20, v21 = _G.cam.CFrame:ToEulerAnglesYXZ();
									_G.root.CFrame = CFrame.new(_G.root.Position) * CFrame.Angles(0, v20, 0);
								end;
							end;
						end;
					end;
				end;
			end;
			if u1.rainPart then
				u1.rainPart.CFrame = _G.root.CFrame * CFrame.new(0, 100, 0);
			end;
			if 30 < Vector3.new(_G.root.Velocity.X, 0, _G.root.Velocity.Z).magnitude then
				_G.root.Velocity = Vector3.new(0, 0, 0);
			end;
			local v22, v23, v24, v25 = workspace:FindPartOnRayWithIgnoreList(Ray.new(_G.root.Position + Vector3.new(0, 5, 0), Vector3.new(0, -15, 0)), { _G.char, _G.mouse.TargetFilter });
			if v25 == Enum.Material.Water then
				_G.hum.WalkSpeed = u1.currentWalkSpeed / 2;
			else
				_G.hum.WalkSpeed = u1.currentWalkSpeed;
			end;
		end;
	end;
	if not _G.Data.hasSpawned then
		_G.hum.WalkSpeed = 0;
		_G.hum.JumpPower = 0;
	end;
	if _G.char then
		if _G.cam then

		else
			_G.mouse.Icon = "";
			u1.selectionBox.Adornee = nil;
			return;
		end;
	else
		_G.mouse.Icon = "";
		u1.selectionBox.Adornee = nil;
		return;
	end;
	if _G.mouse.Target then

	else
		_G.mouse.Icon = "";
		u1.selectionBox.Adornee = nil;
		return;
	end;
	if not _G.mouse.Target:FindFirstChild("Draggable") then
		if not _G.mouse.Target.Parent:FindFirstChild("Draggable") then
			if not u1.dragObject then
				if not _G.mouse.Target:FindFirstChild("DoorButton") then
					if _G.mouse:FindFirstChild("OpenGuiPanel") then
						if u1.ObjectWithinStuds(_G.mouse.Target, 25, _G.root.Position) then
							_G.mouse.Icon = "http://www.roblox.com/asset/?id=455570287";
							return;
						end;
					end;
				elseif u1.ObjectWithinStuds(_G.mouse.Target, 25, _G.root.Position) then
					_G.mouse.Icon = "http://www.roblox.com/asset/?id=455570287";
					return;
				end;
			elseif u1.ObjectWithinStuds(_G.mouse.Target, 25, _G.root.Position) then
				_G.mouse.Icon = "http://www.roblox.com/asset/?id=455570287";
				return;
			end;
		elseif u1.ObjectWithinStuds(_G.mouse.Target, 25, _G.root.Position) then
			_G.mouse.Icon = "http://www.roblox.com/asset/?id=455570287";
			return;
		end;
	elseif u1.ObjectWithinStuds(_G.mouse.Target, 25, _G.root.Position) then
		_G.mouse.Icon = "http://www.roblox.com/asset/?id=455570287";
		return;
	end;
	if _G.mouse.Target.Parent:FindFirstChild("Interactable") then
		if _G.mouse.Target.Parent:FindFirstChild("InteractPart") then
			u1.selectionBox.Adornee = _G.mouse.Target.Parent.InteractPart;
			return;
		else
			u1.selectionBox.Adornee = _G.mouse.Target.Parent;
			return;
		end;
	end;
	if not _G.mouse.Target:GetAttribute("EntityHealth") then
		if not _G.mouse.Target.Parent:GetAttribute("EntityHealth") then
			if _G.mouse.Target.Parent:FindFirstChild("Humanoid") then
				if _G.Data.equipped then
					if not ((_G.mouse.Target.Position - _G.root.Position).magnitude <= 25) then
						if u1.activateHeld then
							_G.mouse.Icon = "rbxassetid://117431027";
							return;
						end;
					else
						_G.mouse.Icon = "rbxassetid://117431027";
						return;
					end;
				elseif u1.activateHeld then
					_G.mouse.Icon = "rbxassetid://117431027";
					return;
				end;
			elseif u1.activateHeld then
				_G.mouse.Icon = "rbxassetid://117431027";
				return;
			end;
		elseif _G.Data.equipped then
			if not ((_G.mouse.Target.Position - _G.root.Position).magnitude <= 25) then
				if u1.activateHeld then
					_G.mouse.Icon = "rbxassetid://117431027";
					return;
				end;
			else
				_G.mouse.Icon = "rbxassetid://117431027";
				return;
			end;
		elseif u1.activateHeld then
			_G.mouse.Icon = "rbxassetid://117431027";
			return;
		end;
	elseif _G.Data.equipped then
		if not ((_G.mouse.Target.Position - _G.root.Position).magnitude <= 25) then
			if u1.activateHeld then
				_G.mouse.Icon = "rbxassetid://117431027";
				return;
			end;
		else
			_G.mouse.Icon = "rbxassetid://117431027";
			return;
		end;
	elseif u1.activateHeld then
		_G.mouse.Icon = "rbxassetid://117431027";
		return;
	end;
	_G.mouse.Icon = "";
	u1.selectionBox.Adornee = nil;
end;
local l__RunService__6 = game:GetService("RunService");
function CharacterAddedToWorkspace(p2)
	if game.Players:FindFirstChild(p2.Name) == game.Players.LocalPlayer then
		SetupCharacter(p2);
		u5 = l__RunService__6.RenderStepped:Connect(function()
			if _G.Data then
				OrientCharacter();
				InterpretMouseTarget();
			end;
		end);
	end;
end;
local l__Characters__26 = workspace:WaitForChild("Characters");
local v27 = l__Characters__26:FindFirstChild(_G.localPlayer.Name);
if v27 then
	while true do
		if not _G.Data then
			wait();
		end;
		if _G.Data then
			break;
		end;	
	end;
	CharacterAddedToWorkspace(v27);
end;
l__Characters__26.ChildAdded:connect(function(p3)
	CharacterAddedToWorkspace(p3);
end);
