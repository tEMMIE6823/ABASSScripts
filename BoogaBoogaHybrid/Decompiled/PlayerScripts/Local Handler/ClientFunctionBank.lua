-- Decompiled with the Synapse X Luau decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__ContentProvider__3 = game:GetService("ContentProvider");
local l__ContextActionService__4 = game:GetService("ContextActionService");
local l__TeleportService__5 = game:GetService("TeleportService");
local l__Modules__6 = l__ReplicatedStorage__1:WaitForChild("Modules");
local v7 = require(l__Modules__6.DefaultData);
local v8 = require(l__Modules__6.CosmeticData);
local v9 = require(l__Modules__6.Settings);
local v10 = require(l__Modules__6.MapPalettes);
local v11 = require(l__Modules__6.ShopData);
_G.rayIgnore = {};
_G.rank = math.max(game.ReplicatedStorage.Events.GetRank:InvokeServer());
local v12 = {
	currentInventoryItem = nil, 
	currentInventoryMaxQuantity = 0, 
	currentInventoryQuantity = 0, 
	projectiles = {}, 
	weld = function(p1, p2, p3)
		local v13 = Instance.new("Weld", p1);
		v13.Part0 = p1;
		v13.Part1 = p2;
		return v13;
	end
};
local u1 = nil;
function v12.updateVar(p4, p5)
	u1[p4] = p5;
end;
local l__TweenService__2 = game:GetService("TweenService");
local u3 = require(l__Modules__6.GameUtil);
local u4 = require(l__Modules__6.SoundModule);
local l__LocalPlayer__5 = game.Players.LocalPlayer;
function v12.SetupCharacter(p6)
	u1.char = p6;
	u1.root = p6:WaitForChild("HumanoidRootPart");
	u1.head = p6:WaitForChild("Head");
	u1.hum = p6:WaitForChild("Humanoid");
	u1.cam = workspace.CurrentCamera;
	while true do
		task.wait();
		if u1.mainGui then
			break;
		end;	
	end;
	coroutine.wrap(function()
		game.Lighting:WaitForChild("Bloom").Intensity = 1;
		game.Lighting:WaitForChild("Bloom").Size = 100;
		game.Lighting:WaitForChild("Bloom").Threshold = 0.4;
		l__TweenService__2:Create(game.Lighting:WaitForChild("Bloom"), TweenInfo.new(20, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Intensity = 1, 
			Size = 56, 
			Threshold = 3.344
		}):Play();
		if game.Lighting:FindFirstChild("DepthOfField") then
			game.Lighting.DepthOfField.FarIntensity = 1;
			for v14 = 1, 0, -0.01 do
				game.Lighting.DepthOfField.FarIntensity = v14;
				wait(0.001);
			end;
		end;
	end);
	if not _G.data.spawnData.played then
		l__ReplicatedStorage__1.Sounds.Music["LoadingMusic_" .. u3.GetWorld()]:Play();
		u1.hideOthers = true;
		u1.ToggleOtherCharacters(false);
		u1.cam.CameraType = Enum.CameraType.Scriptable;
		u1.lockTorsoOrientation = false;
		u1.playerGui.SpawnGui.Enabled = true;
		u1.mainGui.Enabled = false;
		u1.cam.CFrame = l__ReplicatedStorage__1.SpawnCamCF.Value;
		return;
	end;
	u1.cam.CameraType = Enum.CameraType.Custom;
	u1.lockTorsoOrientation = true;
	u1.playerGui.SpawnGui.Enabled = false;
	u1.mainGui.Enabled = true;
	while true do
		if not u1.char.Parent then
			wait();
		end;
		if u1.char.Parent == workspace then
			break;
		end;	
	end;
	u1.cam.CameraType = Enum.CameraType.Custom;
	u1.hum.HealthChanged:connect(function()
		u1.UpdateStats();
	end);
	u1.hum.StateChanged:connect(function()
		if u1.hum:GetState() ~= Enum.HumanoidStateType.Seated then
			u1.lockTorsoOrientation = true;
			return;
		end;
		u1.char.Head:FindFirstChild("Running"):Stop();
		u4.PlaySoundByName("Wood Sit");
		u1.lockTorsoOrientation = false;
	end);
	u1.hum.Died:connect(function()
		u1.lockTorsoOrientation = false;
		l__ReplicatedStorage__1.Events.ChangeEnvironment:FireServer(u3.GetWorld());
	end);
	u1.hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false);
	u1.hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false);
	u1.camFocus = u1.root;
	u1.moveAllowed = true;
	u1.charActive = true;
	u1.anims = {};
	local u6 = coroutine.wrap(function()
		local l__next__15 = next;
		local v16, v17 = l__ReplicatedStorage__1.Animations:GetChildren();
		while true do
			local v18, v19 = l__next__15(v16, v17);
			if not v18 then
				break;
			end;
			v17 = v18;
			u1.anims[v19.Name] = u1.hum.Animator:LoadAnimation((v19:Clone()));
			wait();		
		end;
	end);
	coroutine.wrap(function()
		while true do
			wait();
			if u1.hum:IsDescendantOf(workspace) then
				break;
			end;		
		end;
		u6();
	end)();
	p6.DescendantAdded:connect(function(p7)
		if p7:IsA("Tool") or p7:IsA("HopperBin") then
			l__LocalPlayer__5:Kick();
		end;
	end);
end;
if _G.data then
	local v20 = _G.data.userSettings and _G.data.userSettings.guiType or "Hybrid";
else
	v20 = "Hybrid";
end;
v12.currentGuiStyle = v20;
v12.projectiles = {};
v12.bodyColorList = {
	LeftUpperLeg = true, 
	LeftLowerLeg = true, 
	LeftFoot = true, 
	RightUpperLeg = true, 
	RightLowerLeg = true, 
	RightFoot = true, 
	UpperTorso = true, 
	LowerTorso = true
};
v12.skinColorList = {
	LeftUpperArm = true, 
	LeftLowerArm = true, 
	LeftHand = true, 
	RightUpperArm = true, 
	RightLowerArm = true, 
	RightHand = true, 
	Head = true
};
v12.mouse = require(l__Modules__6.Mouse);
v12.char = nil;
v12.root = nil;
v12.hum = nil;
v12.head = nil;
v12.currentTrack = l__ReplicatedStorage__1.Sounds.Nature.Nature;
v12.ambienceEvent = nil;
v12.tweeningSound = nil;
v12.lastRemark = l__ReplicatedStorage__1.Constants.RelativeTime.Value;
v12.lastRemarkTrackName = "";
v12.currentWalkSpeed = 16;
v12.charActive = false;
v12.moveAllowed = false;
v12.cam = nil;
v12.camFocus = nil;
v12.camOffsetMin = nil;
v12.camOffsetMax = nil;
v12.camRot = 0;
v12.zoomLevel = 17;
v12.camOffset = Vector3.new(25, 17, -25);
v12.dragObject = nil;
v12.mouseBoundStructure = nil;
v12.buildingRotation = 0;
v12.selectionTarget = nil;
v12.hasShifted = false;
v12.redrawInventory = false;
v12.inCave = nil;
v12.hideOthers = false;
v12.bodyRotSpeed = 0.2125;
v12.LMBDown = false;
v12.RMBDown = false;
v12.timeDepressed = 0;
v12.drawBack = 0;
v12.fPressed = nil;
v12.fWhenPressed = 0;
v12.hoveringInventoryItem = nil;
v12.whenHover = 0;
v12.drawn = nil;
v12.ignoreLastSwing = false;
v12.draggingIcon = nil;
v12.lastToast = 0;
v12.toastWait = 0;
v12.currentToast = 1;
v12.lastCraftCategory = "all";
v12.lastCraftSearch = nil;
v12.lockTorsoOrientation = true;
v12.lastInventoryCategory = "all";
v12.lastTargetHit = 0;
v12.precipPart = nil;
v12.currentWorld = u3.GetWorld();
v12.collisionDetect = (function()
	local v21 = Instance.new("Part");
	v21.Transparency = 1;
	v21.CanCollide = false;
	v21.Anchored = true;
	v21.Touched:connect(function()

	end);
	return v21;
end)();
v12.playerGui = (function()
	local l__PlayerGui__22 = l__LocalPlayer__5:WaitForChild("PlayerGui");
	l__PlayerGui__22:SetTopbarTransparency(1);
	return l__PlayerGui__22;
end)();
v12.anims = {};
v12.ping = 0;
v12.mainGui = nil;
v12.starterGui = game:GetService("StarterGui");
v12.cards = nil;
v12.maxNotifications = 5;
v12.noteSerializer = 0;
v12.targetSlider = nil;
v12.chestList = nil;
v12.draggerBodyPos = false;
v12.secondaryGui = l__LocalPlayer__5:WaitForChild("PlayerGui"):WaitForChild("SecondaryGui");
v12.currentWeather = "Shine";
v12.hotkeyBank = {};
v12.hotkeySettingName = {
	pickup = { "PickupHotkey", Enum.KeyCode.F }, 
	eat = { "EatHotkey", Enum.KeyCode.E }, 
	toggleBag = { "BagHotkey", Enum.KeyCode.C }, 
	toggleTribe = { "TribeHotkey", Enum.KeyCode.T }, 
	toggleShop = { "ShopHotkey", Enum.KeyCode.Z }, 
	toggleMojo = { "MojoHotkey", Enum.KeyCode.K }, 
	toggleSettings = { "SettingsHotkey", Enum.KeyCode.X }, 
	toggleCrates = { "CratesHotkey", Enum.KeyCode.M }, 
	toggleQuests = { "QuestsHotkey", Enum.KeyCode.Q }, 
	fireSpell = { "SpellHotkey", Enum.KeyCode.V }
};
function v12.getKeycode(p8, p9)
	local v23 = nil;
	local u7 = nil;
	local v24, v25 = pcall(function()
		u7 = Enum.KeyCode[p8];
	end);
	if v25 then
		u7 = p9;
	end;
	for v26, v27 in pairs(u1.hotkeyBank) do
		if u7 == v27 and p9.Name ~= v27.Name then
			v23 = u1.hotkeySettingName[v26][1];
		end;
	end;
	return v25 and p9 or u7, v23;
end;
function v12.setHotkeys()
	for v28, v29 in pairs(u1.hotkeySettingName) do
		local v30, v31 = shared.getKeycode(_G.data.userSettings[v29[1]], v29[2]);
		u1.hotkeyBank[v28] = v30;
	end;
end;
function v12.PhaseThing(p10, p11)
	if p11 then
		p10.Parent = workspace;
		return;
	end;
	p10.Parent = l__ReplicatedStorage__1;
end;
function v12.ToggleOtherCharacters(p12)
	local l__next__32 = next;
	local v33, v34 = game.Players:GetPlayers();
	while true do
		local v35, v36 = l__next__32(v33, v34);
		if not v35 then
			break;
		end;
		v34 = v35;
		if v36 ~= l__LocalPlayer__5 and v36.Character then
			u1.PhaseThing(v36.Character, p12);
		end;	
	end;
end;
function v12.isTargetBillboard()
	return _G.data.userSettings.targetbarBillboard;
end;
local u8 = {
	line = nil, 
	target = nil
};
function v12.drawLineSuite()
	if u8.line and u8.target then
		local v37 = u1.cam:WorldToScreenPoint(u8.target.Position);
		local v38 = Vector2.new(v37.X, v37.Y + 20);
		local v39 = Vector2.new(u1.mouse.X, u1.mouse.Y + 40);
		local v40 = v38 - v39;
		u8.line.Size = UDim2.fromOffset(math.sqrt(v40.X ^ 2 + v40.Y ^ 2), 2);
		u8.line.Rotation = u1.getRotation(v38, v39);
		u8.line.Position = UDim2.fromOffset(v39.X, v39.Y):Lerp(UDim2.fromOffset(v38.X, v38.Y), 0.5);
	end;
end;
local u9 = require(l__Modules__6.ItemData);
function v12.drawShopHat(p13, p14)
	if not u8.line or not u8.line.Parent or not u8.line.Parent.Parent then
		u8.line = Instance.new("Frame");
		u8.line.BorderSizePixel = 0;
		u8.line.AnchorPoint = Vector2.new(0.5, 0.5);
		u8.line.Parent = u1.ShopGUI;
	end;
	u8.target = p14.PrimaryPart;
	local l__Frame__41 = u1.mainGui.RightPanel.PhysicalShop.Frame;
	l__Frame__41.HatLabel.HatCost.Text = u9[p13].cost and "Not For Sale";
	l__Frame__41.HatLabel.HatName.Text = p13;
	if u9[p13].cost then
		l__Frame__41.PurchaseButton.Visible = true;
		return;
	end;
	l__Frame__41.PurchaseButton.Visible = false;
end;
function v12.makePhyicalHats(p15)
	local v42 = {};
	local v43 = 3;
	if p15.Name == "FullShop" then
		v43 = 11;
		for v44, v45 in pairs(u9) do
			if v45.cosmetic then
				v42[#v42 + 1] = {
					name = v44, 
					cost = v45.cost and 1000000, 
					shopOrder = v45.shopOrder
				};
			end;
		end;
		table.sort(v42, function(p16, p17)
			local v46 = not p16.cost ~= p17.cost;
			return not v46 and p16.cost < p17.cost or (v46 or p16.shopOrder < p17.shopOrder);
		end);
	else
		v42 = { {
				name = "Am Shelly"
			}, {
				name = "Am Golden Shelly"
			}, {
				name = "Am Spirit Shelly"
			}, {
				name = "Am Odd Shelly"
			} };
	end;
	for v47, v48 in pairs(v42) do
		local l__name__49 = v48.name;
		local v50 = u9[l__name__49];
		local v51 = v47 % (v43 + 1);
		local v52 = math.floor((v47 - v51) / v43) + 1;
		print(v51, v52, v48.name);
		local v53 = p15:FindFirstChild("Row" .. tostring(v52));
		if v53 then
			local v54 = l__ReplicatedStorage__1.Cosmetics.hat[l__name__49]:Clone();
			local v55 = Instance.new("Model");
			v54.Parent = v55;
			v54.Handle.Anchored = true;
			v55.PrimaryPart = v54.Handle;
			v55:SetPrimaryPartCFrame(v53.CFrame * CFrame.new(Vector3.new(-v53.Size.X / 2)):Lerp(CFrame.new(Vector3.new(v53.Size.X / 2)), v51 / v43) * CFrame.new(0, 2, 0));
			v55.Parent = workspace.Shop.Hats;
			local v56 = Instance.new("ImageButton");
			v56.Size = UDim2.fromOffset(100, 100);
			v56.AnchorPoint = Vector2.new(0.5, 0.5);
			v56.BackgroundTransparency = 1;
			local v57 = Instance.new("ObjectValue");
			v57.Value = v55;
			v57.Name = "HoverObject";
			v57.Parent = v56;
			v56.Parent = u1.ShopGUI.List;
			v56.Activated:connect(function()
				u1.drawShopHat(l__name__49, v55);
			end);
		end;
	end;
end;
function v12.clampToScreenDims(p18, p19, p20, p21)
	if not u1.cam then
		warn("no cam");
		return UDim2.fromOffset(p18, p19);
	end;
	return UDim2.fromOffset(math.clamp(p18, 6, u1.cam.ViewportSize.X - p20 - 6), math.clamp(p19, 6, u1.cam.ViewportSize.Y - p21 - 6));
end;
local u10 = nil;
function v12.drawAboutFrame(p22)
	local l__AboutFrame__58 = u1.mainGui.Panels:FindFirstChild("AboutFrame");
	if l__AboutFrame__58 then
		local u11 = 0;
		u10 = function(p23)
			local v59 = l__AboutFrame__58.Templates.Tag:Clone();
			v59.Text = p23;
			v59.LayoutOrder = u11;
			v59.Parent = l__AboutFrame__58;
			v59.Visible = true;
			u11 = u11 + 1;
		end;
		local v60 = u9[p22];
		for v61, v62 in pairs(l__AboutFrame__58:GetChildren()) do
			if v62.Name == "Tag" then
				v62:Destroy();
			end;
		end;
		l__AboutFrame__58.Header.Text = p22;
		u10("Bag weight: " .. tostring(v60.load and 0));
		if v60.speed then
			u10(tostring(math.round(1 / v60.speed * 10) / 10) .. " swings/second");
		end;
		for v63, v64 in pairs(v60.nourishment or {}) do
			u10(tostring(v64) .. " " .. v63);
		end;
		for v65, v66 in pairs(v60.damages or {}) do
			u10(tostring(v66) .. " to " .. v65);
		end;
		for v67, v68 in pairs(v60.tags or {}) do
			u10(v68);
		end;
	end;
end;
function v12.isInVoidBubble(p24)
	for v69, v70 in pairs(workspace.VorpalFrags:GetChildren()) do
		if v70 and v70.Parent then
			local v71 = u1.HasTribe(p24);
			local v72 = u1.HasTribe(v70.Owner.Value);
			local v73 = true;
			if v71 == v72 then
				v73 = not v71 or not v72;
			end;
			return (v70.Position - p24.Character.HumanoidRootPart.Position).Magnitude <= (v70:FindFirstChild("Radius") and v70.Radius.Value or u9["Vorpal Frag"].radius), v70.Owner.Value == p24, not v73;
		end;
	end;
end;
local u12 = require(l__Modules__6.ColorData);
function v12.CrossfadeTracks(p25, p26)
	if p26 then
		return;
	end;
	u1.tweeningSound = true;
	p25.Volume = 0;
	p25:Play();
	local v74 = TweenInfo.new(13, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
	l__TweenService__2:Create(u1.currentTrack, v74, {
		Volume = 0
	}):Play();
	local v75 = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
	l__TweenService__2:Create(p25, v74, {
		Volume = p25:FindFirstChild("MaxVolume") and p25.MaxVolume.Value or 0
	}):Play();
	if p25.Name == "AncientDespair" then

	end;
	wait(6);
	if l__ReplicatedStorage__1.Constants.RelativeTime.Value - u1.lastRemark > 360 and u1.lastRemarkTrackName ~= p25 then
		u1.lastRemark = l__ReplicatedStorage__1.Constants.RelativeTime.Value;
		u1.lastRemarkTrackName = p25.Name;
		if p25.Name == "Wind" then
			u1.MakeToast({
				title = "YOU:", 
				message = "It's cold up here...", 
				color = u12.brownUI, 
				image = "", 
				duration = 5
			});
		elseif p25.Name == "Cave" then
			u1.MakeToast({
				title = "YOU:", 
				message = "Maybe there are resources down here...", 
				color = u12.brownUI, 
				image = "", 
				duration = 6
			});
		elseif p25.Name == "AncientDespair" then
			u1.MakeToast({
				title = "YOU:", 
				message = "This place is ancient...", 
				color = u12.brownUI, 
				image = "", 
				duration = 6
			});
		end;
	end;
	u1.currentTrack:Stop();
	u1.currentTrack = p25;
	u1.tweeningSound = nil;
end;
local l__UserInputService__13 = game:GetService("UserInputService");
function v12.PlaceStructureFunction()
	if u1.mouseBoundStructure then
		if not l__UserInputService__13.MouseEnabled then
			if l__UserInputService__13.TouchEnabled then
				l__ReplicatedStorage__1.Events.PlaceStructure:FireServer(u1.mouseBoundStructure.Name, u1.mouseBoundStructure.PrimaryPart.CFrame, u1.buildingRotation, u1.placeStructureFromBag);
				u1.ClearMouseBoundStructure();
				u1.OpenGui(u1.cards.Bag, true);
			end;
			return;
		end;
	else
		return;
	end;
	l__ReplicatedStorage__1.Events.PlaceStructure:FireServer(u1.mouseBoundStructure.Name, u1.mouseBoundStructure.PrimaryPart.CFrame, u1.buildingRotation, u1.placeStructureFromBag);
	u1.ClearMouseBoundStructure();
	u1.OpenGui(u1.cards.Bag, true);
end;
function v12.addedTotem(p27)
	local v76, v77 = u1.HasTribe(l__LocalPlayer__5);
	if v76 and v77 and p27.TribeColor.Value == v76 then
		local v78 = l__ReplicatedStorage__1.Guis.TribeLocator:Clone();
		v78.ImageLabel.ImageColor3 = v77.color;
		v78.Parent = u1;
		v78.Adornee = p27:WaitForChild("Board");
		wait(1);
		p27.AncestryChanged:connect(function()
			v78:Destroy();
		end);
	end;
end;
function v12.ObjectWithinStuds(p28, p29)
	if (u1.root.Position - p28.Position).magnitude <= p29 then
		return true;
	end;
	return false;
end;
function v12.FadeTrack(p30, p31, p32)
	l__TweenService__2:Create(p30, TweenInfo.new(p31 and 5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, p32 and 0), {
		Volume = 0
	}):Play();
end;
function v12.PartsAlongRay(p33)
	local v79 = {};
	while true do
		local v80, v81 = workspace:FindPartOnRayWithIgnoreList(p33, v79);
		if v80 ~= workspace.Terrain then
			v79[#v79 + 1] = v80;
		end;
		if not v80 then
			break;
		end;
		if v80 == workspace.Terrain then
			break;
		end;	
	end;
	return v79;
end;
local l__Debris__14 = game:GetService("Debris");
function v12.DamageEffect(p34)
	local v82, v83 = pcall(coroutine.wrap(function()
		local v84 = p34:Clone();
		local v85 = TweenInfo.new(0.5, Enum.EasingStyle.Quad);
		v84.Parent = workspace.Homeless;
		for v86, v87 in pairs(v84:GetDescendants()) do
			if v87:IsA("BasePart") then
				v87.Anchored = true;
				v87.CanCollide = false;
				v87.Color = Color3.new(1, 1, 1);
				v87.Material = Enum.Material.Neon;
				v87.Transparency = math.max(0, v87.Transparency - 0.5);
				v87.CanQuery = false;
				l__TweenService__2:Create(v87, v85, {
					Transparency = 2, 
					Size = v87.Size + Vector3.new(2, 2, 2)
				}):Play();
			else
				v87:Destroy();
			end;
		end;
		l__Debris__14:AddItem(v84, 0.5);
	end));
	if v83 then
		warn(v83);
	end;
end;
v12.models = {};
v12.curated = {};
local l__RunService__15 = game:GetService("RunService");
function v12.SwingTool()
	if _G.data.equipped then
		if u1.ignoreLastSwing then
			u1.ignoreLastSwing = false;
			return;
		end;
		if (u9[_G.data.toolbar[_G.data.equipped].name].speed and 1) - 0.05 <= l__ReplicatedStorage__1.Constants.RelativeTime.Value - _G.data.lastSwing then
			_G.data.lastSwing = l__ReplicatedStorage__1.Constants.RelativeTime.Value;
			local l__name__88 = _G.data.toolbar[_G.data.equipped].name;
			local v89 = u9[_G.data.toolbar[_G.data.equipped].name];
			if v89.toolType == "ranged" then
				if not u1.HasItem(v89.ammoItem) then
					u1.CreateNotification("No ammo!", u12.badRed, 2);
					return;
				end;
				local l__next__90 = next;
				local v91, v92 = u1.char:WaitForChild(l__name__88):GetChildren();
				while true do
					local v93, v94 = l__next__90(v91, v92);
					if not v93 then
						break;
					end;
					v92 = v93;
					if v94.Name == "Draw" then
						v94.Transparency = 0;
					elseif v94.Name == "Rest" then
						v94.Transparency = 1;
					end;				
				end;
				if v89.pullSound then
					u1.CreateSound(l__ReplicatedStorage__1.Sounds.BowSounds[v89.soundClass].Pullback, u1.root);
				end;
				u1.drawBack = 0;
				if l__UserInputService__13.MouseEnabled then
					if u9[l__name__88].drawAnim then
						u1.anims[u9[l__name__88].drawAnim]:Play(u9[l__name__88].drawAnim.drawAnimLength);
					end;
					local l__BowPower__16 = u1.mainGui.Panels.BowPower;
					local u17 = nil;
					u17 = l__RunService__15.Heartbeat:connect(function(p35)
						if not u1.LMBDown then
							u17:Disconnect();
							return;
						end;
						u1.drawBack = math.clamp(u1.drawBack + p35, 0, u9[l__name__88].drawLength);
						u1.cam.FieldOfView = 70 - u1.drawBack * 2;
						u1.hum.WalkSpeed = u1.currentWalkSpeed - u1.drawBack * 10;
						l__BowPower__16.Visible = true;
						l__BowPower__16.Position = UDim2.fromOffset(u1.mouse.X, u1.mouse.Y + 30);
						l__BowPower__16.Slider.Size = UDim2.new(u1.drawBack / u9[l__name__88].drawLength, 0, 1, 0);
					end);
					while u1.LMBDown do
						l__RunService__15.Heartbeat:Wait();					
					end;
					l__BowPower__16.Visible = false;
				elseif l__UserInputService__13.TouchEnabled then
					if u9[l__name__88].drawAnim then
						u1.anims[u9[l__name__88].drawAnim]:Play(u9[l__name__88].drawAnim, 0);
						u1.anims[u9[l__name__88].drawAnim]:Stop(u9[l__name__88].drawAnim, 3);
					end;
					u1.LMBDown = false;
					u1.drawBack = u9[l__name__88].drawLength;
				end;
				_G.data.lastSwing = l__ReplicatedStorage__1.Constants.RelativeTime.Value;
				u1.CreateSound(l__ReplicatedStorage__1.Sounds.BowSounds[v89.soundClass].Fire, u1.root);
				local v95, v96 = u1.CursorRay();
				u1.ShootProjectile();
				u1.hum.WalkSpeed = u1.currentWalkSpeed;
				u1.drawBack = 0;
				u1.cam.FieldOfView = 70;
				local l__next__97 = next;
				local v98, v99 = u1.char:WaitForChild(l__name__88):GetChildren();
				while true do
					local v100, v101 = l__next__97(v98, v99);
					if not v100 then
						break;
					end;
					v99 = v100;
					if v101.Name == "Draw" then
						v101.Transparency = 1;
					elseif v101.Name == "Rest" then
						v101.Transparency = 0;
					end;				
				end;
				if u9[l__name__88].drawAnim then
					u1.anims[u9[l__name__88].drawAnim]:Stop(u9[l__name__88].drawAnimSlow);
				end;
				if v89.postFireSound then
					u1.CreateSound(l__ReplicatedStorage__1.Sounds.BowSounds[v89.soundClass].PostFire, u1.root);
					return;
				end;
			else
				local v102, v103, v104 = u1.cam.CFrame:ToEulerAnglesYXZ();
				u1.collisionDetect.Size = Vector3.new(7, 13, 8);
				u1.collisionDetect.CFrame = CFrame.new(u1.char.PrimaryPart.Position) * CFrame.Angles(v102, v103, 0) * CFrame.new(0, 0, -u1.collisionDetect.Size.Z / 2 + 1);
				u1.collisionDetect.Parent = u1.char;
				u1.collisionDetect.Parent = nil;
				u1.models = {};
				for v105, v106 in next, u1.collisionDetect:GetTouchingParts() do
					if not v106:IsDescendantOf(u1.char) and v106 ~= workspace.Terrain and v106.Parent:FindFirstChild("Health") then
						u1.models[v106.Parent] = true;
					end;
				end;
				u1.curated = {};
				for v107, v108 in pairs(u1.models) do
					u1.curated[#u1.curated + 1] = v107.PrimaryPart;
				end;
				if u9[_G.data.toolbar[_G.data.equipped].name].useType == "Slash" then
					l__ReplicatedStorage__1.Events.SwingTool:FireServer(u1.curated);
					u1.anims.Slash:Play();
					return;
				elseif u9[_G.data.toolbar[_G.data.equipped].name].useType == "Horn" then
					u1.anims.Horn:Play();
					l__ReplicatedStorage__1.Events.MusicTool:FireServer(l__ReplicatedStorage__1.Constants.RelativeTime.Value);
					return;
				elseif u9[_G.data.toolbar[_G.data.equipped].name].useType == "Target" then
					local v109 = u1.cam:ScreenPointToRay(u1.mouse.X, u1.mouse.Y);
					l__ReplicatedStorage__1.Events.TargetTool:FireServer(l__ReplicatedStorage__1.Constants.RelativeTime.Value, u1.FirstPartOnRay(Ray.new(v109.Origin, v109.Direction * 2000), u1.char));
					return;
				elseif u9[_G.data.toolbar[_G.data.equipped].name].useType == "Farming" then
					l__ReplicatedStorage__1.Events.PlantFruit:FireServer(u1.mouse.Hit.Position, u1.currentPlant);
					u1.anims.Slash:Play();
					return;
				else
					if u9[_G.data.toolbar[_G.data.equipped].name].useType == "Rod" then
						local v110 = u1.cam:ScreenPointToRay(u1.mouse.X, u1.mouse.Y);
						local v111 = Ray.new(v110.Origin, v110.Direction * 2000);
						u1.anims.RodCast:Play();
						l__ReplicatedStorage__1.Events.RodSwing:FireServer(l__ReplicatedStorage__1.Constants.RelativeTime.Value, v111);
					end;
					return;
				end;
			end;
		end;
	end;
end;
function v12.UpdateRodString(p36, p37, p38)
	local v112 = l__ReplicatedStorage__1.Misc.FishingLine:Clone();
	v112.Parent = l__LocalPlayer__5.Character:FindFirstChild(_G.data.toolbar[_G.data.equipped].name);
	local u18 = nil;
	u18 = l__RunService__15.RenderStepped:connect(function()
		if p38 < tick() then
			u18:Disconnect();
			u18 = nil;
			v112:Destroy();
			return;
		end;
		local l__Magnitude__113 = (p36.Position - p37).Magnitude;
		v112.Size = Vector3.new(0.2, 0.2, l__Magnitude__113);
		v112.CFrame = CFrame.lookAt(p36.Position, p37) * CFrame.new(0, 0, -l__Magnitude__113 / 2);
	end);
end;
function v12.setGuiType(p39)
	u1.currentGuiStyle = p39;
	u1.updateGui();
end;
function v12.updateGui()
	local v114 = l__ReplicatedStorage__1:WaitForChild("Misc"):WaitForChild("GuiHandle"):Clone();
	for v115, v116 in pairs(script.Parent:GetChildren()) do
		if v116.Name == "GuiHandle" then
			v116.Disabled = true;
			v116:Destroy();
		end;
	end;
	v114.Parent = script.Parent;
	v114.Disabled = false;
end;
function v12.formatKeyText(p40)
	if u1.currentGuiStyle ~= "Old" and u1.currentGuiStyle ~= "Daves" then
		return p40;
	end;
	return "[ " .. p40 .. " ]";
end;
local u19 = require(l__Modules__6.KeyImages);
function v12.updateHotkeys()
	u1.mainGui.Panels.AetherTutorial.LevelUpFrame.Tutorial.Text = "Press [ " .. u1.hotkeyBank.fireSpell.Name .. " ] to use your Aether Boost!";
	u1.mainGui.Panels.VoodooTutorial.LevelUpFrame.Tutorial.Text = "Press [ " .. u1.hotkeyBank.fireSpell.Name .. " ] to use your Voodoo Spell!";
	u1.mainGui.Panels.MouseFrame.Pickup.KeyImage.Image = u19[u1.hotkeyBank.pickup.Name];
	u1.mainGui.Panels.MouseFrame.Consume.KeyImage.Image = u19[u1.hotkeyBank.eat.Name];
	u1.mainGui.Panels.Stats.IconStats.SpellImage.KeyImage.Image = u19[u1.hotkeyBank.fireSpell.Name];
	local l__currentGuiStyle__117 = u1.currentGuiStyle;
	for v118, v119 in pairs(u1.cards:GetChildren()) do
		if u1.hotkeyBank["toggle" .. v119.Name] then
			if _G.data.userSettings.hotkeyLables then
				v119.KeyImage.Image = u19[u1.hotkeyBank["toggle" .. v119.Name].Name];
				v119.KeyImage.Visible = true;
			else
				v119.KeyImage.Visible = false;
			end;
		end;
	end;
end;
function v12.tweenCam(p41, p42)
	u1.cam.CameraType = Enum.CameraType.Scriptable;
	u1.cam.CFrame = p41.From.CFrame;
	local l__Magnitude__120 = (p41.From.Position - p41.To.Position).Magnitude;
	l__TweenService__2:Create(u1.cam, TweenInfo.new(l__Magnitude__120 / 5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		CFrame = p41.To.CFrame
	}):Play();
	if p42 then
		if p42.resetCamera then
			delay(l__Magnitude__120 / 5, function()
				u1.cam.CameraType = Enum.CameraType.Custom;
			end);
		end;
		if p42.yield then
			task.wait(l__Magnitude__120 / 5);
		end;
	end;
end;
function v12.meteorHit()
	monitoring = nil;
end;
local u20 = require(l__Modules__6.CameraShake);
function v12.clientRemoveOverhealEvent(p43)
	monitoring = true;
	u1.mainGui.Enabled = false;
	u1.secondaryGui.Enabled = false;
	local l__CutScene__121 = workspace:WaitForChild("CutScene");
	local v122 = l__ReplicatedStorage__1.Misc:WaitForChild("CutSceneGui"):Clone();
	v122.Parent = u1.playerGui;
	local v123 = require(v122.Runner);
	v123:Init(p43);
	v123:Blink();
	u1.tweenCam(l__CutScene__121[p43 .. "-CutScene"], {});
	task.wait(12);
	v123:Stop();
	v123:Blink();
	u20.size = 0.1;
	local u21 = nil;
	u21 = l__RunService__15.RenderStepped:connect(function()
		if u1.monitoring then
			u1.cam.CameraType = Enum.CameraType.Scriptable;
			u20.size = workspace.Meteor.RotationSpeed.Value * 2 / 1132.5;
			if not (u20.size > 0.01) then
				return;
			end;
		else
			u1.cam.CameraType = Enum.CameraType.Custom;
			u1.mainGui.Enabled = true;
			u1.secondaryGui.Enabled = true;
			u1.CreateNotification("The Meteor Has Hit", Color3.fromRGB(0, 126, 255), 10);
			u21:Disconnect();
			u21 = nil;
			return;
		end;
		u1.cam.CFrame = CFrame.lookAt(l__CutScene__121.SunIslandAnchorPoint.Position, workspace.Meteor.Root.Position) * CFrame.new(math.random(u20.size * 100) / 100, math.random(u20.size * 100) / 100, 0);
	end);
	while true do
		task.wait();
		if not u1.monitoring then
			break;
		end;	
	end;
	task.wait(1);
	v123:Blink();
	u1.tweenCam(l__CutScene__121.Sunfruit, {
		yields = true
	});
	v123:Blink();
	task.wait(10);
	for v124, v125 in pairs(l__CutScene__121.Sunfruit.Bush:GetChildren()) do
		coroutine.wrap(function()
			if v125.Name == "Sunfruit" then
				local v126 = v125:Clone();
				v126.Name = "_Visual";
				v126.Parent = u1.cam;
				v126.Material = Enum.Material.ForceField;
				local l__Size__127 = v126.Size;
				l__TweenService__2:Create(v126, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					Size = l__Size__127 + Vector3.new(1.5, 1.5, 1.5)
				}):Play();
				task.wait(0.15);
				local v128 = l__ReplicatedStorage__1.Guis.Overheal:Clone();
				v128.Parent = v125;
				l__TweenService__2:Create(v128, TweenInfo.new(1), {
					StudsOffset = Vector3.new(math.random(-1, 1), 3, 0)
				}):Play();
				l__TweenService__2:Create(v128.Overheal, TweenInfo.new(1), {
					TextTransparency = 1, 
					TextStrokeTransparency = 1
				}):Play();
				l__TweenService__2:Create(v128.Health, TweenInfo.new(1), {
					TextTransparency = 1, 
					TextStrokeTransparency = 1
				}):Play();
				l__TweenService__2:Create(v126, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = l__Size__127
				}):Play();
			end;
		end)();
	end;
	task.wait(2);
	u1.MakeToast({
		title = "Unknown:", 
		message = "All food has been infused with the power of the Strange Meteor and removed overheal", 
		color = u12.essenceYellow, 
		image = "", 
		duration = 10
	});
	task.wait(5);
	u1.cam.CameraType = Enum.CameraType.Custom;
	u1.mainGui.Enabled = true;
	u1.secondaryGui.Enabled = true;
end;
local u22 = require(l__Modules__6.ParticleClass);
function v12.event()
	coroutine.wrap(u4.PlaySoundByName)("Events", workspace);
	u1.monitoring = true;
	u1.mainGui.Enabled = false;
	u1.secondaryGui.Enabled = false;
	local l__CutScene__129 = workspace:WaitForChild("CutScene");
	local v130 = l__ReplicatedStorage__1.Misc:WaitForChild("CutSceneGui"):Clone();
	v130.Parent = u1.playerGui;
	local v131 = require(v130.Runner);
	v131:Blink();
	u1.tweenCam(l__CutScene__129.Meteor2, {
		yield = false
	});
	task.wait(14.7);
	u22.new(workspace.CutScene.MeteorExplosionEmitter.Position, 0, 5, 12, 90, Color3.fromRGB(140, 225, 255), true, 2, true):emit(100);
	task.wait(6);
	v131:Blink();
	u1.cam.CameraType = Enum.CameraType.Custom;
	u1.mainGui.Enabled = true;
	u1.secondaryGui.Enabled = true;
end;
function v12.bindHealthAura(p44)
	local v132 = l__ReplicatedStorage__1.Misc.HealingAura:Clone();
	v132.Parent = p44.Character;
	local u23 = tick() + u9["Life Charge"].duration;
	local u24 = 0;
	local u25 = 0;
	local u26 = nil;
	u26 = l__RunService__15.RenderStepped:connect(function(p45)
		if u23 - tick() > 0 then
			v132.CFrame = CFrame.new(p44.Character.PrimaryPart.Position - Vector3.new(0, 2, 0)) * CFrame.Angles(0, math.rad(u24), 0);
			u24 = u24 + 1;
			if u9["Life Charge"].duration / u9["Life Charge"].pulseCount < tick() - u25 then
				u25 = tick();
				u24 = u24 + 5;
				v132.ParticleEmitter:Emit(20);
			end;
			if not (u24 > 360) then
				return;
			end;
		else
			u26:Disconnect();
			v132:Destroy();
			u26 = nil;
			return;
		end;
		u24 = 1;
	end);
end;
function v12.CleanPlayerListUI()
	local l__next__133 = next;
	local v134, v135 = u1.secondaryGui.PlayerList.List:GetChildren();
	while true do
		local v136, v137 = l__next__133(v134, v135);
		if not v136 then
			break;
		end;
		v135 = v136;
		if v137:IsA("GuiObject") and not game.Players:FindFirstChild(v137.Name) then
			v137:Destroy();
		end;	
	end;
end;
function v12.lerp(p46, p47, p48)
	return p46 * (1 - p48) + p47 * p48;
end;
function v12.DragFunction()
	if not u1.draggerBodyPos then
		u1.draggerBodyPos = Instance.new("BodyPosition");
		u1.draggerBodyPos.Parent = u1.dragObject;
		u1.draggerBodyPos.P = 25000;
		u1.draggerBodyPos.D = 1500;
		u1.draggerBodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
		u1.draggerBodyPos.AncestryChanged:connect(function()
			if not u1.draggerBodyPos or not u1.draggerBodyPos.Parent then
				u1.draggerBodyPos = nil;
			end;
		end);
	end;
	if u1.dragObject and u1.draggerBodyPos then
		if u1.dragObject.Parent and (u1.dragObject.Parent:IsA("Model") and u1.dragObject.Parent ~= workspace) then
			u1.mouse.TargetFilter = u1.dragObject.Parent;
		else
			u1.mouse.TargetFilter = u1.dragObject;
		end;
		if u1.dragObject:FindFirstChild("Draggable") or u1.dragObject.Parent and u1.dragObject.Parent:FindFirstChild("Draggable") then
			local v138 = Ray.new(u1.root.Position, (u1.mouse.Hit.Position - u1.root.Position).unit * math.clamp((u1.root.Position - u1.mouse.Hit.Position).magnitude, 3, 30));
			local v139, v140 = workspace:FindPartOnRayWithIgnoreList(v138, u1.PartsAlongRay(v138));
			u1.draggerBodyPos.Position = v140 + Vector3.new(0, u1.dragObject.Size.Y / 2, 0);
		end;
	end;
end;
function v12.DrawPlayerList(p49, p50)
	local l__next__141 = next;
	local v142, v143 = u1.secondaryGui.PlayerList.List:GetChildren();
	while true do
		local v144, v145 = l__next__141(v142, v143);
		if not v144 then
			break;
		end;
		v143 = v144;
		if v145:IsA("GuiObject") then
			v145:Destroy();
		end;	
	end;
	local l__next__146 = next;
	local v147 = nil;
	while true do
		local v148, v149 = l__next__146(p49, v147);
		if not v148 then
			break;
		end;
		local v150 = false;
		local l__next__151 = next;
		local v152, v153 = u1.secondaryGui.PlayerList.List:GetChildren();
		while true do
			local v154, v155 = l__next__151(v152, v153);
			if not v154 then
				break;
			end;
			v153 = v154;
			if v155:IsA("GuiObject") and v155.Name == v149.name then
				v150 = true;
			end;		
		end;
		if not v150 then
			local v156 = u1.secondaryGui.PlayerList.Templates.PlayerFrame:Clone();
			if p50[v149.name] then
				v156.Body.NameLabel.Text = p50[v149.name].name;
			else
				v156.Body.NameLabel.Text = v149.name;
			end;
			v156.Square.LevelLabel.Text = v149.level and 1;
			if v149.tribe then
				v156.Square.BackgroundColor3 = u12.TribeColors[v149.tribe];
			else
				v156.Square.BackgroundColor3 = u12.brownUI;
			end;
			v156.Name = v149.name;
			v156.Visible = true;
			v156.Parent = u1.secondaryGui.PlayerList.List;
			v156.InfoButton.Activated:connect(function()
				u1.UpdatePlayerInfoCard(l__ReplicatedStorage__1.Events.RequestDeepPlayerInfo:InvokeServer(game.Players:FindFirstChild(v149.name)));
			end);
		end;	
	end;
end;
function v12.RemovePlayerCard(p51)
	local l__next__157 = next;
	local v158, v159 = u1.secondaryGui.PlayerList.List:GetChildren();
	while true do
		local v160, v161 = l__next__157(v158, v159);
		if not v160 then
			break;
		end;
		v159 = v160;
		if v161:IsA("GuiObject") and v161.Name == p51 then
			v161:Destroy();
		end;	
	end;
end;
function v12.PromptNotification(p52, p53)
	local v162 = u1.HasTribe(l__LocalPlayer__5);
	if p52 == "player select" then
		local v163 = u1.mainGui.Subordinates.Prompts.Templates:FindFirstChild("PlayerSelect"):Clone();
		local l__next__164 = next;
		local v165, v166 = game.Players:GetPlayers();
		while true do
			local v167, v168 = l__next__164(v165, v166);
			if not v167 then
				break;
			end;
			v166 = v167;
			local v169 = v163.Templates.PlayerFrame:Clone();
			v169.TextLabel.Text = v168.Name;
			local v170 = u1.HasTribe(v168);
			if v170 then
				v169.ColorFrame.BackgroundColor3 = u12.TribeColors[v170];
				v169.BackgroundColor3 = Color3.fromRGB(100, 0, 0);
			else
				v169.ColorFrame.BackgroundColor3 = u12.brownUI;
			end;
			v169.Activated:connect(function()
				v163.Response.Value = v169.TextLabel.Text;
			end);
			v169.Visible = true;
			v169.Parent = v163.List;		
		end;
		v163.Parent = u1.mainGui.Subordinates.Prompts.Standby;
		v163.Visible = true;
		v163.Response:GetPropertyChangedSignal("Value"):Wait();
		spawn(function()
			v163:Destroy();
		end);
		return v163.Response.Value;
	end;
	if p52 == "yes no" then
		local v171 = u1.mainGui.Subordinates.Prompts.Templates.YesNo:Clone();
		v171.Prompt.Text = p53.message and "";
		v171.Prompt.TextColor3 = p53.color or Color3.fromRGB(255, 255, 255);
		v171.ChoiceFrame.NoButton.Activated:connect(function()
			v171.Response.Value = "no";
		end);
		v171.ChoiceFrame.YesButton.Activated:connect(function()
			v171.Response.Value = "yes";
		end);
		v171.Visible = true;
		v171.Parent = u1.mainGui.Subordinates.Prompts.Standby;
		v171.Response:GetPropertyChangedSignal("Value"):Wait();
		v171:Destroy();
		return v171.Response.Value == "yes";
	end;
	if p52 == "center notice" then
		return;
	end;
	if p52 == "event notice" then
		return;
	end;
	if p52 ~= "input" then
		return;
	end;
	local v172 = u1.mainGui.Subordinates.Prompts.Templates:FindFirstChild("Input"):Clone();
	v172.Image.Image = p53.image and "";
	v172.Title.Text = p53.title and "Enter Input";
	v172.InputBox.PlaceholderText = p53.placeholderText and "Input Here";
	v172.Cancel.Activated:connect(function()
		v172.Response.Value = true;
	end);
	local u27 = nil;
	v172.Confirm.Activated:connect(function()
		u27 = v172.InputBox.Text;
		v172.Response.Value = true;
	end);
	v172.Parent = u1.mainGui.Subordinates.Prompts.Standby;
	v172.Visible = true;
	v172.Response:GetPropertyChangedSignal("Value"):Wait();
	coroutine.wrap(function()
		v172:Destroy();
	end)();
	return nil;
end;
function v12.MouseRayIgnoreList(p54)
	local v173 = u1.cam:ScreenPointToRay(u1.mouse.X, u1.mouse.Y);
	local v174, v175, v176, v177 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v173.Origin, v173.Direction * 1000), p54);
	return v174, v175, v176, v177;
end;
local v178 = {
	LoadAmbience = function(p55)
		for v179, v180 in pairs(p55) do
			l__TweenService__2:Create(v179, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v180):Play();
		end;
	end
};
local l__Lighting__28 = game:GetService("Lighting");
function v178.ChangeSkybox(p56)
	local l__next__181 = next;
	local v182, v183 = l__Lighting__28:GetChildren();
	while true do
		local v184, v185 = l__next__181(v182, v183);
		if not v184 then
			break;
		end;
		v183 = v184;
		if v185:IsA("Sky") then
			v185:Destroy();
		end;	
	end;
	l__ReplicatedStorage__1.Skies[u1.currentWorld == "Overworld" and "Overworld-" .. l__ReplicatedStorage__1.Constants.Season.Value or u1.currentWorld]:FindFirstChild(p56):Clone().Parent = l__Lighting__28;
end;
local u29 = require(l__Modules__6.AmbientData);
function v178.Cave(p57)
	if u29[u1.currentWorld].cave then
		if u1.inCave and not p57 then
			u1.ambience[u1.currentWeather](true);
		end;
		u1.inCave = p57;
		if p57 then
			u1.ambience.ChangeSkybox("Shine");
			u1.ambience.LoadAmbience(u29[u1.currentWorld].cave);
		end;
	end;
end;
function v178.Doom()
	u1.ambience.ChangeSkybox("Doom");
	u1.ambience.LoadAmbience(u29[u1.currentWorld].doom);
end;
function v178.Night()
	u1.ambience.ChangeSkybox("Shine");
	u1.ambience.LoadAmbience(u29[u1.currentWorld].night);
end;
function v178.Shine()
	u1.ambience.ChangeSkybox("Shine");
	u1.ambience.LoadAmbience(u29[u1.currentWorld].shine);
end;
function v178.Rain(p58)
	if not p58 then
		local l__next__186 = next;
		local v187, v188 = workspace:GetChildren();
		while true do
			local v189, v190 = l__next__186(v187, v188);
			if not v189 then
				break;
			end;
			v188 = v189;
			if v190.Name == "PrecipitationPart" then
				v190:Destroy();
			end;		
		end;
		l__ReplicatedStorage__1.Sounds.Nature.Rain:Stop();
		l__ReplicatedStorage__1.Sounds.Nature.Thunder:Stop();
		return;
	end;
	precipPart = l__ReplicatedStorage__1.Misc.PrecipitationPart:Clone();
	precipPart.Parent = workspace;
	precipPart.Rain.Enabled = true;
	l__ReplicatedStorage__1.Sounds.Nature.Rain:Play();
	l__ReplicatedStorage__1.Sounds.Nature.Thunder:Play();
	u1.ambience.ChangeSkybox("Rain");
	u1.ambience.LoadAmbience(u29[u1.currentWorld].rain);
end;
function v178.Snow(p59)
	if p59 then
		precipPart = l__ReplicatedStorage__1.Misc.PrecipitationPart:Clone();
		precipPart.Parent = workspace;
		precipPart.Snow.Enabled = true;
		coroutine.wrap(function()
			while task.wait() do
				if precipPart and u1.root and u1.char then
					local v191, v192 = u1.cam.CFrame:ToEulerAnglesYXZ();
					precipPart.CFrame = CFrame.new(u1.root.Position + Vector3.new(0, 50, 0)) * CFrame.Angles(0, v192, 0);
					local v193, v194, v195, v196 = workspace:FindPartOnRay(Ray.new(u1.root.Position, Vector3.new(0, 45, 0)), u1.char);
					if v193 then
						precipPart.Parent = nil;
					else
						precipPart.Parent = workspace;
					end;
				end;			
			end;
		end)();
		return;
	end;
	local l__next__197 = next;
	local v198, v199 = workspace:GetChildren();
	while true do
		local v200, v201 = l__next__197(v198, v199);
		if not v200 then
			break;
		end;
		v199 = v200;
		if v201.Name == "PrecipitationPart" then
			v201:Destroy();
		end;	
	end;
end;
v12.ambience = v178;
function v12.RestorePhysicality(p60)
	if p60:IsA("BasePart") then
		p60.Anchored = false;
		p60.CanCollide = true;
		return;
	end;
	if p60:IsA("Model") then
		local l__next__202 = next;
		local v203, v204 = p60:GetDescendants();
		while true do
			local v205, v206 = l__next__202(v203, v204);
			if not v205 then
				break;
			end;
			v204 = v205;
			if v206:IsA("BasePart") then
				v206.Anchored = false;
				v206.CanCollide = true;
			end;		
		end;
	end;
end;
function v12.CursorRay(p61)
	local v207 = u1.cam:ScreenPointToRay(u1.mouse.x, u1.mouse.y);
	local v208, v209, v210, v211 = workspace:FindPartOnRay(Ray.new(v207.Origin, v207.Direction * 250), p61 or u1.char);
	return v208, v209, v210, v211;
end;
function v12.MiddleScreenRay(p62)
	local v212 = u1.cam:ScreenPointToRay(u1.cam.ViewportSize.X / 2, u1.cam.ViewportSize.Y / 2);
	local v213, v214, v215, v216 = workspace:FindPartOnRay(Ray.new(v212.Origin, v212.Direction * 9999), p62 or workspace);
	return v213, v214, v215, v216;
end;
function v12.FirstPartOnRay(p63, p64)
	local v217, v218, v219, v220 = workspace:FindPartOnRay(p63, p64);
	return v217, v218, v219, v220;
end;
function v12.UpdateCosmetics()
	if not u1.mainGui then
		coroutine.wrap(function()
			while true do
				task.wait();
				if u1.mainGui then
					break;
				end;			
			end;
			u1.UpdateCosmetics();
		end)();
		return;
	end;
	local l__next__221 = next;
	local v222, v223 = u1.mainGui.LeftPanel.Shop.Lists.CosmeticList:GetChildren();
	while true do
		local v224, v225 = l__next__221(v222, v223);
		if not v224 then
			break;
		end;
		v223 = v224;
		if v225:IsA("Frame") then
			v225:Destroy();
		end;	
	end;
	for v226, v227 in next, u9 do
		if v227.cosmetic and (v227.cost or _G.data.ownedCosmetics[v226]) then
			local v228 = u1.mainGui.LeftPanel.Shop.Templates.CosmeticFrame:Clone();
			v228.Purchase.Text = v227.cost and "Event Item";
			v228.ImageButton.Image = u3.getImage(v226);
			v228.ItemNameLabel.Text = v226;
			if _G.data.ownedCosmetics[v226] then
				if _G.data.appearance[v227.locus] ~= v226 then
					v228.Purchase.BackgroundColor3 = u12.goodGreen;
					v228.ItemNameLabel.TextColor3 = u12.goodGreen;
					v228.Purchase.Text = "WEAR";
				else
					v228.ItemNameLabel.TextColor3 = u12.badRed;
					v228.Purchase.BackgroundColor3 = u12.badRed;
					v228.Purchase.Text = "TAKE OFF";
				end;
			end;
			v228.LayoutOrder = v227.shopOrder;
			v228.Visible = true;
			v228.Parent = u1.mainGui.LeftPanel.Shop.Lists.CosmeticList;
			v228.ImageButton.Activated:connect(function()
				if not _G.data.ownedCosmetics[v226] then
					u1.promptPurchase(v226);
					return;
				end;
				l__ReplicatedStorage__1.Events.EquipCosmetic:FireServer(v226);
			end);
		end;
	end;
	local v229 = u1.mainGui.LeftPanel.Shop.Lists.CosmeticList:FindFirstChildOfClass("Frame");
	if v229 then
		local v230 = v229.AbsoluteSize.Y + 20;
	else
		v230 = 5;
	end;
	u1.mainGui.LeftPanel.Shop.Lists.CosmeticList.CanvasSize = UDim2.new(0, 0, 0, #u1.mainGui.LeftPanel.Shop.Lists.CosmeticList:GetChildren() * v230);
end;
function v12.NearestTotemAndDistance(p65)
	local v231 = nil;
	local v232, v233 = u1.HasTribe(l__LocalPlayer__5);
	if v233 then
		v231 = v233.name;
	end;
	local v234 = nil;
	local v235 = math.huge;
	local l__next__236 = next;
	local v237, v238 = workspace.Totems:GetChildren();
	while true do
		local v239, v240 = l__next__236(v237, v238);
		if not v239 then
			break;
		end;
		v238 = v239;
		if v240.TribeColor.Value ~= v231 then
			local l__magnitude__241 = (v240.PrimaryPart.Position - p65).magnitude;
			if l__magnitude__241 < v235 then
				v234 = v240;
				v235 = l__magnitude__241;
			end;
		end;	
	end;
	return v234, v235;
end;
function v12.ClearMouseBoundStructure()
	if u1.mouseBoundStructure then
		u1.mouseBoundStructure:Destroy();
	end;
	u1.mouseBoundStructure = nil;
	u1.mainGui.Mobile.StructureButton.Visible = false;
end;
function v12.BindMouseStructure(p66)
	u1.ClearMouseBoundStructure();
	if l__UserInputService__13.TouchEnabled then
		u1.mainGui.Mobile.StructureButton.Visible = true;
	end;
	u1.mouseBoundStructure = p66;
	local l__next__242 = next;
	local v243, v244 = u1.mouseBoundStructure:GetDescendants();
	while true do
		local v245, v246 = l__next__242(v243, v244);
		if not v245 then
			break;
		end;
		v244 = v245;
		if v246:IsA("BasePart") then
			if v246.Name == "Reference" or v246.Name == "Interactable" or v246.Name == "Effect" or v246.Name == "Portal" or v246.Name == "Hitbox" then
				v246.Transparency = 1;
			else
				v246.Transparency = 0.3;
			end;
			v246.CanCollide = false;
			v246.Anchored = true;
		elseif not v246:IsA("Weld") and not v246:IsA("ManualWeld") and not v246:IsA("Model") then
			v246:Destroy();
		end;	
	end;
	local function v247(p67)
		if p67 then
			if u1.mouseBoundStructure.PrimaryPart.Color == u12.goodGreen then
				return;
			else
				local l__next__248 = next;
				local v249, v250 = u1.mouseBoundStructure:GetDescendants();
				while true do
					local v251, v252 = l__next__248(v249, v250);
					if not v251 then
						break;
					end;
					v250 = v251;
					if v252:IsA("BasePart") then
						v252.Color = u12.goodGreen;
					end;				
				end;
				return;
			end;
		end;
		if u1.mouseBoundStructure.PrimaryPart.BrickColor == u12.badRed then
			return;
		end;
		local l__next__253 = next;
		local v254, v255 = u1.mouseBoundStructure:GetDescendants();
		while true do
			local v256, v257 = l__next__253(v254, v255);
			if not v256 then
				break;
			end;
			v255 = v256;
			if v257:IsA("BasePart") then
				v257.Color = u12.badRed;
			end;		
		end;
	end;
	u1.mouseBoundStructure.Parent = u1.char;
	while u1.mouseBoundStructure do
		u1.mouse.TargetFilter = u1.mouseBoundStructure;
		local v258 = nil;
		local v259 = nil;
		local v260 = nil;
		if l__UserInputService__13.TouchEnabled then
			local v261, v262, v263, v264 = u1.RayUntil((u1.root.CFrame * CFrame.new(0, 10, -10 - u1.mouseBoundStructure:GetExtentsSize().Z / 2)).p, Vector3.new(0, -1000, 0));
			v258 = v261;
			v259 = v262;
			v260 = v264;
			u1.mouseBoundStructure:SetPrimaryPartCFrame(CFrame.new(v259, Vector3.new(u1.root.Position.X, v259.Y, u1.root.Position.Z)));
		elseif l__UserInputService__13.MouseEnabled then
			local v265, v266, v267, v268 = u1.RayUntil(u1.mouse.Hit.Position + Vector3.new(0, 10, 0), Vector3.new(0, -1000, 0));
			v258 = v265;
			v259 = v266;
			v260 = v268;
			u1.mouseBoundStructure:SetPrimaryPartCFrame(CFrame.new(v259) * CFrame.Angles(0, math.rad(u1.buildingRotation), 0));
		end;
		local v269 = true;
		local v270, v271, v272 = pairs(workspace.Deployables:GetChildren());
		while true do
			local v273, v274 = v270(v271, v272);
			if not v273 then
				break;
			end;
			local v275 = v274:FindFirstChild("Reference") or v274:FindFirstChild("MainPart");
			if v275 then
				local l__magnitude__276 = (v275.Position - v259).magnitude;
				if u1.mouseBoundStructure.Name == "Chest" then
					if l__magnitude__276 <= 2 then
						v269 = false;
					end;
				else
					if v275.Name == "MainPart" then
						local v277 = 15;
					else
						v277 = 6;
					end;
					if l__magnitude__276 <= v277 then
						v269 = false;
					end;
				end;
			end;		
		end;
		local l__next__278 = next;
		local v279, v280 = game.Players:GetPlayers();
		while true do
			local v281, v282 = l__next__278(v279, v280);
			if not v281 then
				break;
			end;
			v280 = v281;
			if v282.Character and v282.Character.PrimaryPart and v282 ~= l__LocalPlayer__5 then
				if u1.mouseBoundStructure.Name == "Iron Turret" then
					local v283 = 23;
				else
					v283 = 8;
				end;
				if (v259 - v282.Character.PrimaryPart.Position).magnitude < v283 then
					v269 = false;
				end;
			end;		
		end;
		if (v259 - u1.root.Position).magnitude > 50 then
			v269 = false;
		end;
		if v258 ~= workspace.Terrain and u9[u1.mouseBoundStructure.Name].placement ~= "all" then
			v269 = false;
		end;
		if v260 and v260 == Enum.Material.Water and u9[u1.mouseBoundStructure.Name].placement ~= "sea" and u9[u1.mouseBoundStructure.Name].placement ~= "all" then
			v269 = false;
		end;
		if v260 and v260 ~= Enum.Material.Water and u9[u1.mouseBoundStructure.Name].placement == "sea" then
			v269 = false;
		end;
		if not u1.placeStructureFromBag and not (not u3.getRecipe(u1.mouseBoundStructure.Name).recipe) and not u1.CanCraftItem(u1.mouseBoundStructure.Name) or u1.placeStructureFromBag and not u1.HasItem(u1.mouseBoundStructure.Name) then
			v269 = false;
		end;
		local v284, v285 = u1.NearestTotemAndDistance(v259);
		if v285 < 175 then
			v269 = false;
		end;
		v247(v269);
		l__RunService__15.RenderStepped:Wait();	
	end;
end;
local u30 = require(l__Modules__6.PatchNotes);
function v12.DrawPatchNotes()
	local l__List__286 = u1.mainGui.LeftPanel.PatchNotes.List;
	local l__next__287 = next;
	local v288, v289 = l__List__286:GetChildren();
	while true do
		local v290, v291 = l__next__287(v288, v289);
		if not v290 then
			break;
		end;
		v289 = v290;
		if v291:IsA("Frame") then
			v291:Destroy();
		end;	
	end;
	for v292, v293 in pairs(u30) do
		local v294 = u1.mainGui.LeftPanel.PatchNotes.Template:Clone();
		v294.About.Text = v293.title;
		v294.Date.Text = v293.date;
		v294.Text.Text = v293.text;
		v294.LayoutOrder = v292;
		v294.Parent = l__List__286;
		v294.Visible = true;
		v294.Visible = false;
		v294.Visible = true;
	end;
	l__List__286.AutomaticCanvasSize = Enum.AutomaticSize.Y;
	l__List__286.Visible = false;
	l__List__286.Visible = true;
	l__List__286.Size = l__List__286.Size - UDim2.new(0, 0, 0, 1);
end;
function v12.HasTribe(p68)
	if not p68 then
		return;
	end;
	for v295, v296 in next, _G.tribeData or {} do
		if v296.chief == p68.Name then
			return v295, v296;
		end;
		if v296.members[p68.Name] then
			return v295, v296;
		end;
	end;
end;
function v12.UpdatePlayerList()
	local l__next__297 = next;
	local v298, v299 = u1.secondaryGui.PlayerList.List:GetChildren();
	while true do
		local v300, v301 = l__next__297(v298, v299);
		if not v300 then
			break;
		end;
		v299 = v300;
		if v301:IsA("GuiObject") then
			local v302 = game.Players:FindFirstChild(v301.Name);
			if v302 then
				local v303 = u1.HasTribe(v302);
				if v303 then
					v301.Square.BackgroundColor3 = u12.TribeColors[v303];
					v301.LayoutOrder = u12.TribeOffsets[v303] + string.byte(string.lower(string.sub(v302.Name, 1, 1)));
				else
					v301.Square.BackgroundColor3 = u12.brownUI;
					v301.LayoutOrder = 1000 + string.byte(string.lower(string.sub(v302.Name, 1, 1)));
				end;
			end;
		end;	
	end;
	u1.secondaryGui.PlayerList.List.CanvasSize = UDim2.new(0, 0, 0, (u1.secondaryGui.PlayerList.Templates.PlayerFrame.AbsoluteSize.Y + u1.secondaryGui.PlayerList.List.UIListLayout.Padding.Offset) * #u1.secondaryGui.PlayerList.List:GetChildren());
end;
function v12.UpdateArmor()
	if not u1.mainGui then
		coroutine.wrap(function()
			while true do
				task.wait();
				if u1.mainGui then
					break;
				end;			
			end;
			u1.UpdateArmor();
		end)();
		return;
	end;
	local v304 = 0;
	for v305, v306 in next, _G.data.armor do
		if v306 and v306 ~= "none" then
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Selection[v305].Image = u3.getImage(v306);
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Selection[v305].DefaultIcon.Visible = false;
			v304 = v304 + (u9[v306].defense and 0);
		else
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Selection[v305].Image = "";
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Selection[v305].DefaultIcon.Visible = true;
		end;
	end;
	u1.mainGui.Panels.Stats.IconStats.ArmorImage.ImageLabel.TextLabel.Text = v304;
	if v304 > 0 then
		u1.mainGui.Panels.Stats.IconStats.ArmorImage.Visible = true;
		return;
	end;
	u1.mainGui.Panels.Stats.IconStats.ArmorImage.Visible = false;
end;
local l__Bank__31 = l__ReplicatedStorage__1.Sounds.Bank;
function v12.MakeToast(p69)
	local l__message__307 = p69.message;
	local l__color__308 = p69.color;
	local l__duration__309 = p69.duration;
	if l__ReplicatedStorage__1.Constants.RelativeTime.Value - u1.lastToast < u1.toastWait then
		while true do
			task.wait(math.random() / 30);
			if u1.toastWait <= l__ReplicatedStorage__1.Constants.RelativeTime.Value - u1.lastToast then
				break;
			end;		
		end;
	end;
	u1.lastToast = l__ReplicatedStorage__1.Constants.RelativeTime.Value;
	u1.toastWait = l__duration__309 + 2;
	u1.currentToast = u1.currentToast + 1;
	local l__Toasts__310 = u1.mainGui.Panels.Toasts;
	l__Toasts__310.Message.Text = "";
	l__Toasts__310.Title.Text = p69.title;
	l__Toasts__310.ImageLabel.Image = p69.image;
	l__Toasts__310.ImageLabel.BackgroundColor3 = l__color__308;
	l__Toasts__310.Message.TextColor3 = l__color__308;
	l__Toasts__310:TweenPosition(UDim2.new(1, 0, 0.75, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 1, true);
	task.wait(1);
	for v311 = 1, #l__message__307 do
		l__Toasts__310.Message.Text = string.sub(l__message__307, 1, v311);
		l__Bank__31.Text:Play();
		task.wait(0.04);
	end;
	task.wait(l__duration__309);
	if u1.currentToast == u1.currentToast then
		l__Toasts__310:TweenPosition(UDim2.new(1.5, 0, 0.75, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 1, true);
	end;
end;
function v12.RayUntil(p70, p71)
	local v312, v313, v314, v315 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p70, p71), _G.rayIgnore);
	if not v312 or v312 == workspace.Terrain then
		_G.rayIgnore = {};
		return v312, v313, v314, v315;
	end;
	table.insert(_G.rayIgnore, v312);
	return u1.RayUntil(p70, p71);
end;
function v12.CreateParticles(p72, p73, p74, p75, p76, p77)
	local v316 = Instance.new("Part");
	v316.Anchored = true;
	v316.CanCollide = false;
	v316.Transparency = 1;
	v316.Size = Vector3.new(0, 0, 0);
	v316.CFrame = CFrame.new(p73, p74);
	local v317 = p72:Clone();
	v317.Parent = v316;
	v317.EmissionDirection = Enum.NormalId.Front;
	if p77 then
		for v318, v319 in next, p77 do
			v317[v318] = v319;
		end;
	end;
	v316.Parent = workspace;
	task.wait();
	if not p75 then
		l__Debris__14:AddItem(v316, p76);
		return;
	end;
	v317.Rate = 0;
	v317:Emit(p75);
	l__Debris__14:AddItem(v316, p76);
end;
function v12.CollectPart(p78)
	if not p78:IsA("BasePart") then
		for v320, v321 in pairs(p78:GetChildren()) do
			if v321:IsA("BasePart") then
				u1.CollectPart(v321);
			else
				v321:Destroy();
			end;
		end;
		return;
	end;
	p78:ClearAllChildren();
	p78.CanCollide = false;
	p78.Anchored = true;
	p78.Parent = u1.cam;
	l__TweenService__2:Create(p78, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {
		CFrame = u1.root.CFrame, 
		Size = Vector3.new(0.6, 0.6, 0.6), 
		Transparency = 1
	}):Play();
	l__Debris__14:AddItem(p78, 0.2);
end;
function v12.CleanNils(p79)
	local v322 = {};
	for v323, v324 in next, p79 do
		v322[#v322 + 1] = v324;
	end;
	return v322;
end;
local u32 = require(l__Modules__6.Nicknames);
function v12.UpdatePlayerInfoCard(p80)
	local l__PlayerInfo__325 = u1.mainGui.Panels.PlayerInfo;
	local v326 = p80.player.Name;
	local v327 = u32:getImage(p80.player.UserId);
	if _G.nicknames[v326] then
		v326 = _G.nicknames[v326].name;
		v327 = u32:getImage(_G.nicknames[v326].id);
	end;
	l__PlayerInfo__325.PlayerImage.Image = v327;
	l__PlayerInfo__325.Title.Text = v326;
	l__PlayerInfo__325.InfoFrame.Deaths.Text = "Deaths: " .. tostring(p80.actualData.Deaths);
	l__PlayerInfo__325.InfoFrame.Kills.Text = "Kills: " .. tostring(p80.actualData.Kills);
	l__PlayerInfo__325.InfoFrame.Level.Text = "Level: " .. tostring(p80.actualData.level);
	l__PlayerInfo__325.InfoFrame.Robux.Text = "Robux Spent: " .. tostring(p80.actualData.totalRobuxSpent);
	l__PlayerInfo__325.InfoFrame.TimePlayed.Text = "Time Played: " .. tostring(math.floor(p80.actualData.TimePlayed / 86400 * 100) / 100) .. " days";
	l__PlayerInfo__325.InfoFrame.Rebirths.Text = "Rebirths: " .. tostring(p80.actualData.rebirths);
	l__PlayerInfo__325.InfoFrame.Spell.Text = "Spell: " .. tostring(p80.actualData.spell and "none");
	l__PlayerInfo__325.InfoFrame.Ratio.Text = "K/D r: " .. tostring(math.floor(p80.actualData.Kills / (p80.actualData.Deaths + 1) * 100) / 100);
	l__PlayerInfo__325.InfoFrame.killstreak.Text = "Killstreak: " .. tostring(p80.actualData.Streak);
	local v328 = u1.HasTribe(p80.player);
	if v328 then
		l__PlayerInfo__325.InfoFrame.Tribe.Text = "Tribe: " .. v328;
		l__PlayerInfo__325.InfoFrame.Tribe.Visible = true;
	else
		l__PlayerInfo__325.InfoFrame.Tribe.Visible = false;
	end;
	l__PlayerInfo__325.Visible = true;
end;
function v12.DrawTribeGui()
	local v329 = u1.HasTribe(l__LocalPlayer__5);
	if v329 then
		u1.mainGui.LeftPanel.Tribe.CreateTribe.Visible = false;
		u1.mainGui.LeftPanel.Tribe.TribeManager.Visible = true;
		local l__next__330 = next;
		local v331, v332 = u1.mainGui.LeftPanel.Tribe.TribeManager.MemberList:GetChildren();
		while true do
			local v333, v334 = l__next__330(v331, v332);
			if not v333 then
				break;
			end;
			v332 = v333;
			if v334:IsA("GuiObject") then
				v334:Destroy();
			end;		
		end;
		if _G.nicknames[_G.tribeData[v329].chief] then
			local v335 = _G.nicknames[_G.tribeData[v329].chief].name;
		else
			v335 = _G.tribeData[v329].chief;
		end;
		local v336 = u1.mainGui.LeftPanel.Tribe.TribeManager.Templates.MemberButton:Clone();
		v336.Text = v335;
		v336.TextColor3 = u12.TribeColors[v329];
		v336.Visible = true;
		v336.Parent = u1.mainGui.LeftPanel.Tribe.TribeManager.MemberList;
		v336.Activated:connect(function()
			u1.UpdatePlayerInfoCard(l__ReplicatedStorage__1.Events.RequestDeepPlayerInfo:InvokeServer(game.Players:FindFirstChild(_G.tribeData[v329].chief)));
		end);
		for v337, v338 in next, _G.tribeData[v329].members do
			if _G.nicknames[v337] then
				local v339 = _G.nicknames[v337].name;
			else
				v339 = v337;
			end;
			local v340 = u1.mainGui.LeftPanel.Tribe.TribeManager.Templates.MemberButton:Clone();
			v340.Text = v339;
			v340.Activated:connect(function()
				u1.UpdatePlayerInfoCard(l__ReplicatedStorage__1.Events.RequestDeepPlayerInfo:InvokeServer(game.Players:FindFirstChild(v337)));
			end);
			v340.Visible = true;
			v340.Parent = u1.mainGui.LeftPanel.Tribe.TribeManager.MemberList;
		end;
		u1.mainGui.LeftPanel.Tribe.TribeManager.ColorLabel.Text = string.upper(v329) .. " TRIBE";
		u1.mainGui.LeftPanel.Tribe.TribeManager.ColorLabel.TextColor3 = u12.TribeColors[v329];
		u1.mainGui.LeftPanel.Tribe.TribeManager.ColorIcon.BackgroundColor3 = u12.TribeColors[v329];
	else
		u1.mainGui.LeftPanel.Tribe.CreateTribe.Visible = true;
		u1.mainGui.LeftPanel.Tribe.TribeManager.Visible = false;
	end;
	local l__next__341 = next;
	local v342, v343 = u1.mainGui.LeftPanel.Tribe.CreateTribe.ColorList:GetChildren();
	while true do
		local v344, v345 = l__next__341(v342, v343);
		if not v344 then
			break;
		end;
		v343 = v344;
		if v345:IsA("GuiObject") then
			local v346 = _G.tribeData[v345.Name] and _G.tribeData[v345.Name].chief;
			v345.TextLabel.Visible = v346;
			v345.TextLabel.Active = v346;
		end;	
	end;
end;
function v12.CreateSound(p81, p82, p83)
	p81 = p81:Clone();
	p81.Parent = p82;
	if p83 then
		p81.Pitch = p81.Pitch + (p81.DefaultPitch.Value and 1) * (math.random(-25, 25) / 100);
	end;
	p81:Play();
	spawn(function()
		while true do
			if not (p81.TimeLength > 0) then
				task.wait();
			end;
			if p81.TimeLength > 0 then
				break;
			end;		
		end;
		l__Debris__14:AddItem(p81, p81.TimeLength);
	end);
end;
function v12.CreateNotification(p84, p85, p86, p87)
	task.wait(p87 and 0);
	p86 = p86 and 1;
	if u1.maxNotifications <= #u1.mainGui.Subordinates.Prompts:GetChildren() - 2 then
		local v347 = nil;
		local v348 = math.huge;
		local l__next__349 = next;
		local v350, v351 = u1.mainGui.Subordinates.Prompts:GetChildren();
		while true do
			local v352, v353 = l__next__349(v350, v351);
			if not v352 then
				break;
			end;
			v351 = v352;
			if v353:IsA("TextLabel") and v353.LayoutOrder < v348 then
				v347 = v353;
				v348 = v353.LayoutOrder;
			end;		
		end;
		if v347 then
			v347:Destroy();
		end;
	end;
	local v354 = u1.mainGui.Subordinates.Prompts.Templates.TextLabel:Clone();
	v354.Text = p84;
	v354.TextColor3 = p85 or Color3.fromRGB(0, 0, 0);
	v354.LayoutOrder = u1.noteSerializer;
	u1.noteSerializer = u1.noteSerializer + 1;
	if #u1.mainGui.Subordinates.Prompts.Feed:GetChildren() > 4 then
		u1.mainGui.Subordinates.Prompts.Feed:FindFirstChildOfClass(v354.ClassName):Destroy();
	end;
	v354.Parent = u1.mainGui.Subordinates.Prompts.Feed;
	v354.Visible = true;
	l__Debris__14:AddItem(v354, p86 + 2);
	l__TweenService__2:Create(v354, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, p86 and 1), {
		BackgroundTransparency = 1, 
		TextStrokeTransparency = 1, 
		TextTransparency = 1
	}):Play();
end;
function v12.UpdateBillboards(p88)
	if u1.selectionTarget then
		local v355 = u1.playerGui:FindFirstChild(u1.selectionTarget.Name);
		if not v355 then
			return;
		end;
		if p88 then
			v355:Destroy();
			u1.selectionTarget = nil;
			return;
		end;
		local l__next__356 = next;
		local v357, v358 = v355.Frame.List:GetChildren();
		while true do
			local v359, v360 = l__next__356(v357, v358);
			if not v359 then
				break;
			end;
			v358 = v359;
			if v360:IsA("ImageButton") then
				v360:Destroy();
			end;		
		end;
		if v355.Name == "Campfire" then
			for v361, v362 in next, _G.data.inventory do
				if u9[v362.name].fuels then
					local v363 = v355.Frame.Templates.ImageButton:Clone();
					v363.Image = u3.getImage(v362.name);
					v363.TextLabel.Text = v362.quantity;
					v363.Name = v362.name;
					v363.Parent = v355.Frame.List;
					v363.Visible = true;
					v363.MouseButton1Down:connect(function()
						l__ReplicatedStorage__1.Events.InteractStructure:FireServer(u1.selectionTarget, v363.Name);
						l__Bank__31.Click3:Play();
						u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text = math.floor(tonumber(u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text) + 0.5);
						u1.selectionTarget.Board.Billboard.Backdrop.Slider.Size = UDim2.new(tonumber(u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text) / u9[u1.selectionTarget.Name].capacity, 0, 1, 0);
						u1.selectionTarget.Board.Billboard.Backdrop.Slider.BackgroundColor3 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(170, 255, 0), u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text / 100);
						if not (u9[u1.selectionTarget.Name].capacity * 0.95 <= tonumber(u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text)) then
							return;
						end;
						v355:Destroy();
						u1.selectionTarget = nil;
					end);
				end;
			end;
			return;
		end;
		if v355.Name == "Forge" then
			for v364, v365 in next, _G.data.inventory do
				if u9[v365.name].fuels then
					local v366 = v355.Frame.Templates.ImageButton:Clone();
					v366.Image = u3.getImage(v365.name);
					v366.TextLabel.Text = v365.quantity;
					v366.Name = v365.name;
					v366.Parent = v355.Frame.List;
					v366.Visible = true;
					v366.MouseButton1Down:connect(function()
						l__ReplicatedStorage__1.Events.InteractStructure:FireServer(u1.selectionTarget, v366.Name);
						l__Bank__31.Click3:Play();
						u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text = math.floor(tonumber(u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text) + 0.5);
						u1.selectionTarget.Board.Billboard.Backdrop.Slider.Size = UDim2.new(tonumber(u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text) / u9[u1.selectionTarget.Name].capacity, 0, 1, 0);
						u1.selectionTarget.Board.Billboard.Backdrop.Slider.BackgroundColor3 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(170, 255, 0), u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text / 100);
						if not (u9[u1.selectionTarget.Name].capacity * 0.95 <= tonumber(u1.selectionTarget.Board.Billboard.Backdrop.TextLabel.Text)) then
							return;
						end;
						v355:Destroy();
						u1.selectionTarget = nil;
					end);
				end;
			end;
			return;
		end;
		if v355.Name == "Grinder" then
			for v367, v368 in next, _G.data.inventory do
				if u9[v368.name].grindsTo then
					local v369 = v355.Frame.Templates.ImageButton:Clone();
					v369.Image = u3.getImage(v368.name);
					v369.TextLabel.Text = v368.quantity;
					v369.Name = v368.name;
					v369.Parent = v355.Frame.List;
					v369.Visible = true;
					v369.MouseButton1Down:connect(function()
						l__ReplicatedStorage__1.Events.InteractStructure:FireServer(u1.selectionTarget, v369.Name);
						l__Bank__31.Click3:Play();
					end);
				end;
			end;
			return;
		end;
		if v355.Name == "Coin Press" then
			for v370, v371 in next, _G.data.inventory do
				if u9[v371.name].pressesTo then
					local v372 = v355.Frame.Templates.ImageButton:Clone();
					v372.Image = u3.getImage(v371.name);
					v372.TextLabel.Text = v371.quantity;
					v372.Name = v371.name;
					v372.Parent = v355.Frame.List;
					v372.Visible = true;
					v372.MouseButton1Down:connect(function()
						l__ReplicatedStorage__1.Events.InteractStructure:FireServer(u1.selectionTarget, v372.Name);
						l__Bank__31.Click3:Play();
					end);
				end;
			end;
			return;
		end;
	end;
end;
v12.StatLabelNames = { "Slider", "NumberLabel", "OverhealSlider", "OverchargeSlider" };
function v12.getStatLabels(p89)
	local v373 = {};
	for v374, v375 in pairs(p89:GetDescendants()) do
		if table.find(u1.StatLabelNames, v375.Name) then
			v373[v375.Name] = v375;
		end;
	end;
	return v373;
end;
local u33 = require(l__Modules__6.LevelData);
function v12.UpdateStats()
	if not u1.mainGui then
		coroutine.wrap(function()
			while true do
				task.wait();
				if u1.mainGui then
					break;
				end;			
			end;
			u1.UpdateStats();
		end)();
		return;
	end;
	local v376 = u1.getStatLabels(u1.mainGui.Panels.Stats.List.Food);
	local v377 = u1.getStatLabels(u1.mainGui.Panels.Stats.List.Health);
	local v378 = u1.getStatLabels(u1.mainGui.Panels.Stats.List.Mana);
	local v379 = u1.getStatLabels(u1.mainGui.Panels.Stats.List.Voodoo);
	local l__Health__380 = u1.hum.Health;
	local l__food__381 = _G.data.stats.food;
	local l__mana__382 = _G.data.stats.mana;
	local l__voodoo__383 = _G.data.stats.voodoo;
	local l__MaxHealth__384 = u1.hum.MaxHealth;
	v376.Slider.Size = UDim2.new(l__food__381 / 100, 0, 1, 0);
	v376.NumberLabel.Text = math.round(l__food__381);
	v377.Slider.Size = UDim2.new(math.clamp(l__Health__380 / l__MaxHealth__384, 0, 1), 0, 1, 0);
	v377.NumberLabel.Text = math.round(l__Health__380);
	v377.OverhealSlider.Size = UDim2.new(math.clamp((l__Health__380 + _G.data.stats.overHeal) / l__MaxHealth__384, 0, 1), 0, 1, 0);
	v378.Slider.Size = UDim2.new(math.clamp(l__mana__382 / 100, 0, 1), 0, 1, 0);
	v378.NumberLabel.Text = math.round(l__mana__382);
	v379.Slider.Size = UDim2.new(math.clamp(l__voodoo__383 / 100, 0, 1), 0, 1, 0);
	v379.OverchargeSlider.Size = UDim2.new(math.clamp((l__voodoo__383 + _G.data.stats.overcharge) / 100, 0, 1), 0, 1, 0);
	v379.NumberLabel.Text = math.round(l__voodoo__383);
	if _G.data.spell then
		u1.mainGui.Panels.Stats.IconStats.SpellImage.ImageButton.Image = u3.getImage(_G.data.spell);
		u1.mainGui.Panels.Stats.IconStats.SpellImage.Visible = true;
		local l__spellType__385 = u9[_G.data.spell].spellType;
		if u1.currentGuiStyle == "Bubble" then
			if l__spellType__385 == "Void" then
				local v386 = _G.data.stats.voodoo;
				if not v386 then
					v386 = false;
					if l__spellType__385 == "Aether" then
						v386 = _G.data.stats.mana;
					end;
				end;
			else
				v386 = false;
				if l__spellType__385 == "Aether" then
					v386 = _G.data.stats.mana;
				end;
			end;
			u1.mainGui.Panels.Stats.IconStats.SpellImage.Slider.Size = UDim2.fromScale(1, 1 - math.clamp(v386 / u9[_G.data.spell].spellCost, 0, 1));
		end;
		if l__spellType__385 == "Void" then
			u1.mainGui.Panels.Stats.IconStats.SpellImage.ImageColor3 = Color3.new(0, 0, 0);
			u1.mainGui.Panels.Stats.IconStats.SpellImage.BackgroundColor3 = Color3.new(0, 0, 0);
			u1.mainGui.Panels.Stats.IconStats.SpellImage.ImageButton.ImageColor3 = Color3.fromRGB(158, 0, 84);
			u1.mainGui.Panels.Stats.List.Mana.Visible = false;
			u1.mainGui.Panels.Stats.List.Voodoo.Visible = true;
		elseif l__spellType__385 == "Aether" then
			u1.mainGui.Panels.Stats.IconStats.SpellImage.ImageColor3 = Color3.new(1, 1, 1);
			u1.mainGui.Panels.Stats.IconStats.SpellImage.BackgroundColor3 = Color3.new(1, 1, 1);
			u1.mainGui.Panels.Stats.IconStats.SpellImage.ImageButton.ImageColor3 = Color3.fromRGB(255, 255, 111);
			u1.mainGui.Panels.Stats.List.Voodoo.Visible = false;
			u1.mainGui.Panels.Stats.List.Mana.Visible = true;
		end;
	else
		u1.mainGui.Panels.Stats.List.Voodoo.Visible = false;
		u1.mainGui.Panels.Stats.List.Mana.Visible = false;
		u1.mainGui.Panels.Stats.IconStats.SpellImage.Visible = false;
	end;
	local v387 = u33[_G.data.level] and 150;
	u1.mainGui.Panels.Topbar.RightCard.EssenceBar.Slider.Size = UDim2.new(_G.data.essence / v387, 0, 1, 0);
	u1.mainGui.Panels.Topbar.RightCard.Counters.EssenceStat.TextLabel.Text = tostring(_G.data.essence) .. "/" .. tostring(v387);
	u1.mainGui.Panels.Topbar.RightCard.EssenceBar.TextLabel.Text = "lvl " .. _G.data.level;
	u1.mainGui.Panels.Topbar.RightCard.Counters.CoinsStat.TextLabel.Text = _G.data.coins;
	u1.mainGui.Panels.Topbar.RightCard.Counters.MojoStat.TextLabel.Text = _G.data.mojo;
	u1.mainGui.LeftPanel.Mojo.Tip.Visible = false;
	u1.mainGui.LeftPanel.Mojo.RebirthButton.Visible = false;
	if l__LocalPlayer__5.Character and (l__LocalPlayer__5.Character:FindFirstChild("HumanoidRootPart") and not l__LocalPlayer__5.Character.PrimaryPart.CanCollide) then
		l__LocalPlayer__5:Kick();
	end;
end;
function v12.HasItem(p90)
	for v388, v389 in next, _G.data.inventory do
		if v389.name == p90 then
			return v388;
		end;
	end;
	return false;
end;
function v12.HasMojoRecipe(p91)
	return _G.data.mojoItems[p91];
end;
function v12.CanCraftItem(p92)
	local v390 = u9[p92];
	for v391, v392 in next, u3.getRecipe(p92).recipe do
		local v393 = u1.HasItem(v391);
		if not v393 then
			return;
		end;
		if _G.data.inventory[v393].quantity < v392 then
			return;
		end;
	end;
	return true;
end;
function v12.CalculateLoad()
	local v394 = 0;
	local v395 = 100;
	if _G.data.armor.bag and _G.data.armor.bag ~= "none" then
		v395 = u9[_G.data.armor.bag].maxLoad;
	end;
	for v396, v397 in next, _G.data.inventory do
		if v397.quantity and u9[v397.name] then
			local v398 = 1;
			if v397.name == "Essence" or v397.maxLoad then
				v398 = 0;
			end;
			v394 = v394 + v397.quantity * (u9[v397.name].load and v398);
		end;
	end;
	return v394, v395;
end;
local u34 = require(l__Modules__6.FunctionLibrary);
function v12.toggleGuis(p93)
	for v399, v400 in next, u34.CombineArrays({ u1.mainGui.RightPanel:GetChildren(), u1.mainGui.LeftPanel:GetChildren() }) do
		if v400:IsA("Frame") then
			if p93 then
				local v401 = true;
			else
				v401 = false;
			end;
			v400.Visible = v401;
		end;
	end;
end;
function v12.DrawTribeMenu()
	local v402, v403 = u1.HasTribe(l__LocalPlayer__5);
	if not v402 then
		u1.mainGui.LeftPanel.Tribe.CreateTribe.Visible = true;
		local l__next__404 = next;
		local v405, v406 = u1.mainGui.LeftPanel.Tribe.CreateTribe.ColorList:GetChildren();
		while true do
			local v407, v408 = l__next__404(v405, v406);
			if not v407 then
				break;
			end;
			v406 = v407;
			if v408:IsA("ImageButton") then
				v408:Destroy();
			end;		
		end;
		for v409, v410 in next, u12.TribeColors do
			local v411 = u1.mainGui.LeftPanel.Tribe.CreateTribe.Templates.ColorButton:Clone();
			v411.BackgroundColor3 = v410;
			v411.Visible = true;
			v411.Parent = u1.mainGui.LeftPanel.Tribe.CreateTribe.ColorList;
			v411.Activated:connect(function()
				u1.mainGui.LeftPanel.Tribe.CreateTribe.SelectedColor.Value = v409;
				u1.mainGui.LeftPanel.Tribe.CreateTribe.ColorLabel.BackgroundColor3 = v410;
				u1.mainGui.LeftPanel.Tribe.CreateTribe.ColorLabel.TextColor3 = v410;
				u1.mainGui.LeftPanel.Tribe.CreateTribe.ColorLabel.Text = string.upper(v409 .. " Tribe");
			end);
		end;
		local l__next__412 = next;
		local v413, v414 = u1.mainGui.LeftPanel.Tribe.CreateTribe.ColorList:GetChildren();
		while true do
			local v415, v416 = l__next__412(v413, v414);
			if not v415 then
				break;
			end;
			v414 = v415;
			if v416:IsA("GuiObject") then
				local v417 = _G.tribeData[v416.Name] and _G.tribeData[v416.Name].chief;
				v416.TextLabel.Visible = v417;
				v416.TextLabel.Active = v417;
			end;		
		end;
	end;
end;
function v12.OpenGui(p94, p95)
	u1.ClearMouseBoundStructure();
	local l__next__418 = next;
	local v419, v420 = u1.cards:GetChildren();
	while true do
		local v421, v422 = l__next__418(v419, v420);
		if not v421 then
			break;
		end;
		v420 = v421;
		if v422 ~= p94 and (v422:IsA("ImageButton") or v422:IsA("Frame")) then
			v422.Status.Value = false;
			u1.ClearMouseBoundStructure();
		end;	
	end;
	if p94 then
		p94.Status.Value = p95 ~= nil and p95 or not p94.Status.Value;
		u1.toggleGuis();
		u1.secondaryGui.PlayerList.Visible = true;
		u1.playerGui.Chat.Frame.Visible = true;
		if p94.Status.Value then
			local l__next__423 = next;
			local v424, v425 = p94.Opens:GetChildren();
			while true do
				local v426, v427 = l__next__423(v424, v425);
				if not v426 then
					break;
				end;
				v427.Value.Visible = true;
				if v427.Value:IsDescendantOf(u1.mainGui.RightPanel) then
					u1.secondaryGui.PlayerList.Visible = false;
				end;
				if v427.Value:IsDescendantOf(u1.mainGui.LeftPanel) and l__UserInputService__13.TouchEnabled then
					u1.playerGui.Chat.Frame.Visible = false;
				end;
				if v427.Value == u1.mainGui.LeftPanel.Tribe then
					u1.DrawTribeMenu();
				end;			
			end;
		end;
	end;
	local l__next__428 = next;
	local v429, v430 = u1.cards:GetChildren();
	while true do
		local v431, v432 = l__next__428(v429, v430);
		if not v431 then
			break;
		end;
		v430 = v431;
		if v432:IsA("ImageButton") or v432:IsA("Frame") then
			if u1.currentGuiStyle == "Bubble" then
				if v432.Status.Value then
					v432.UICorner.CornerRadius = UDim.new(0.25, 0);
					v432.UIStroke.Color = Color3.fromRGB(255, 183, 0);
					v432.UIStroke.Thickness = 4;
				else
					v432.UICorner.CornerRadius = UDim.new(1, 0);
					v432.UIStroke.Color = Color3.new(0, 0, 0);
					v432.UIStroke.Thickness = 2;
				end;
			elseif u1.currentGuiStyle == "Old" then
				if not v432.Status.Value then
					v432.BackgroundColor3 = u12.CardDefaultColors[v432.Name] or u12.ironGrey;
				else
					v432.BackgroundColor3 = u12.goodGreen;
				end;
			elseif u1.currentGuiStyle == "Daves" then
				if not v432.Status.Value then
					v432.ImageButton.BackgroundColor3 = u12.CardDefaultColors[v432.Name] or u12.ironGrey;
				else
					v432.ImageButton.BackgroundColor3 = u12.goodGreen;
				end;
			elseif u1.currentGuiStyle == "Hybrid" then
				if not v432.Status.Value then
					v432.ImageColor3 = u12.HybridCardColors[v432.Name] or u12.ironGrey;
				else
					v432.ImageColor3 = u12.goodGreen;
				end;
			end;
		end;	
	end;
end;
function v12.PreQuantity(p96)
	for v433, v434 in next, _G.data.inventory do
		if v434.name == p96 and v434.quantity then
			return v434.quantity;
		end;
	end;
	return 0;
end;
function v12.InteractInput(p97, p98)
	if p98 then
		return;
	end;
	if p97.UserInputType ~= Enum.UserInputType.MouseButton1 and p97.UserInputType ~= Enum.UserInputType.Touch and p97.KeyCode ~= Enum.KeyCode.ButtonA then
		return false;
	end;
	return true;
end;
function v12.promptPurchase(p99, p100)
	if u1.mainGui.Panels:FindFirstChild("PurchaseFrame") then
		u1.mainGui.Panels.PurchaseFrame:Destroy();
	end;
	local v435 = u1.mainGui.Panels.PurchaseConfirm:Clone();
	v435.Name = "PurchaseFrame";
	local l__Backdrop__436 = v435.Backdrop;
	local v437 = u9[p99];
	if not (not p100) and not (not u1.HasMojoRecipe(p99)) or not p100 and _G.data.ownedCosmetics[p99] then
		if p100 and u9[p99].upgradable and u9[p99].maxUpgrade <= _G.data.mojoItems[p99].level then
			u1.CreateNotification(p99 .. "'s level is maxed out", u12.essenceYellow, 2);
			l__Backdrop__436.Visible = false;
			return;
		end;
		if not (not p100) and not u9[p99].upgradable or not p100 then
			u1.CreateNotification("You already own this", u12.essenceYellow, 2);
			l__Backdrop__436.Visible = false;
			return;
		end;
	end;
	l__Backdrop__436.ItemDescription.Text = v437.description and "";
	l__Backdrop__436.LastSelected.Value = p99;
	l__Backdrop__436.ItemNameLabel.Text = string.upper(p99);
	l__Backdrop__436.ImageLabel.Image = u3.getImage(p99);
	if v437.cosmeticMojo then
		local l__ItemDescription__438 = l__Backdrop__436.ItemDescription;
		l__ItemDescription__438.Text = l__ItemDescription__438.Text .. " (cosmetic)";
	end;
	if p100 and u1.HasMojoRecipe(p99) and u9[p99].upgradable then
		l__Backdrop__436.ItemDescription.Text = "Upgrade " .. p99 .. " to level " .. tostring(_G.data.mojoItems[p99].level + 1);
	end;
	local v439 = p100 and v437.mojoCost or v437.cost;
	local v440 = (p100 and u1.HasMojoRecipe(p99) or not p100 and _G.data.ownedCosmetics[p99]) and (p100 and v437.upgradeCost) or v439;
	if v440 then
		if v440 ~= 1 then
			if p100 then
				local v441 = " mojo points";
			else
				v441 = " coins";
			end;
			l__Backdrop__436.Cost.Text = v439 .. v441;
		else
			if p100 then
				local v442 = " mojo point";
			else
				v442 = " coin";
			end;
			l__Backdrop__436.Cost.Text = v439 .. v442;
		end;
		l__Backdrop__436.ConfirmButton.Visible = true;
	else
		l__Backdrop__436.Cost.Text = "Not For Sale";
		l__Backdrop__436.ConfirmButton.Visible = false;
	end;
	l__Backdrop__436.ExitButton.Activated:connect(function()
		v435:Destroy();
	end);
	l__Backdrop__436.ConfirmButton.Activated:connect(function()
		l__ReplicatedStorage__1.Events.PurchaseItem:FireServer(p99);
		v435:Destroy();
	end);
	v435.Parent = u1.mainGui.Panels;
	v435.Visible = true;
end;
function v12.DrawMojoMenu()
	if not u1.mainGui then
		coroutine.wrap(function()
			while true do
				task.wait();
				if u1.mainGui then
					break;
				end;			
			end;
			u1.DrawMojoMenu();
		end)();
		return;
	end;
	for v443, v444 in pairs(u1.mainGui.LeftPanel.Mojo.Lists.MojoList:GetChildren()) do
		if v444:IsA("Frame") then
			v444:Destroy();
		end;
	end;
	for v445, v446 in pairs(u9) do
		if v446.mojoCost then
			local v447 = u1.mainGui.LeftPanel.Mojo.Templates.Template:Clone();
			v447.Name = v445;
			v447.ItemNameLabel.Text = v445;
			v447.ImageButton.Image = u3.getImage(v445);
			v447.LayoutOrder = v446.mojoCost;
			local v448 = u9[v445];
			if v448 then
				if v448.toggleable then
					v447.TextButton.Activated:connect(function()
						l__ReplicatedStorage__1.Events.ToggleMojo:FireServer(v445);
					end);
				end;
				v447.ImageButton.Activated:connect(function()
					u1.promptPurchase(v445, true);
				end);
			end;
			if _G.data.mojoItems[v445] then
				v447.TextButton.BackgroundColor3 = u12.goodGreen;
				v447.TextButton.Text = "owned";
				v447.ItemNameLabel.TextColor3 = u12.goodGreen;
				if v448.toggleable then
					if _G.data.disabledMojo[v445] then
						v447.TextButton.BackgroundColor3 = u12.goodGreen;
						v447.TextButton.Text = "TURN ON";
					else
						v447.TextButton.BackgroundColor3 = u12.badRed;
						v447.TextButton.Text = "TURN OFF";
					end;
				end;
			end;
			v447.Parent = u1.mainGui.LeftPanel.Mojo.Lists.MojoList;
			v447.Visible = true;
		end;
	end;
	u1.mainGui.LeftPanel.Mojo.Lists.MojoList.CanvasSize = UDim2.new(0, 0, 0, u1.mainGui.LeftPanel.Mojo.Lists.MojoList.UIGridLayout.AbsoluteContentSize.Y);
end;
function v12.UpdateCraftMenu()
	local l__next__449 = next;
	local v450, v451 = u1.mainGui.LeftPanel.Craft.List:GetChildren();
	while true do
		local v452, v453 = l__next__449(v450, v451);
		if not v452 then
			break;
		end;
		v451 = v452;
		if v453:IsA("ImageLabel") and v453.Name ~= "LockedFrame" then
			local v454 = u9[v453.Name];
			local v455 = true;
			local l__next__456 = next;
			local v457 = u3.getRecipe(v453.Name);
			local v458 = nil;
			while true do
				local v459 = nil;
				local v460, v461 = l__next__456(v457, v458);
				if not v460 then
					break;
				end;
				v458 = v460;
				v459 = v453:FindFirstChild(v460);
				local v462 = u1.HasItem(v460);
				if v462 then
					if _G.data.inventory[v462].quantity < v461 then
						v455 = false;
						v459.Title.TextColor3 = u12.badRed;
					else
						v459.Title.TextColor3 = Color3.fromRGB(255, 255, 255);
					end;
				else
					v455 = false;
					v459.Title.TextColor3 = u12.badRed;
				end;			
			end;
			v453.CraftButton.CanCraftImage.Visible = v455;
			v453.CraftButton.NoCraftImage.Visible = not v455;
		end;	
	end;
end;
function v12.DrawQuestInfoMenu(p101)
	local l__Quests__463 = u1.mainGui.RightPanel.Quests;
	local l__Current__464 = l__Quests__463.Current;
	local l__Queue__465 = l__Quests__463.Queue;
	local l__Info__466 = l__Quests__463.Info;
	local l__Template__467 = l__Info__466.Template;
	local l__reward__468 = p101.reward;
	l__Info__466.QuestName.Text = p101.name;
	l__Info__466.QuestDescription.Text = p101.description;
	l__Info__466.SliderFrame.Slider.Size = UDim2.fromScale(p101.quantity.has / p101.quantity.needs, 1);
	if l__reward__468.coins then
		l__Info__466.RewardList.Coins.Label.Text = tostring(l__reward__468.coins);
		l__Info__466.RewardList.Coins.Visible = true;
	else
		l__Info__466.RewardList.Coins.Visible = false;
	end;
	if l__reward__468.essence then
		l__Info__466.RewardList.Essence.Label.Text = tostring(l__reward__468.essence);
		l__Info__466.RewardList.Essence.Visible = true;
	else
		l__Info__466.RewardList.Essence.Visible = false;
	end;
	if l__reward__468.items then
		local l__next__469 = next;
		local v470, v471 = l__Info__466.RewardList.Items.List:GetChildren();
		while true do
			local v472, v473 = l__next__469(v470, v471);
			if not v472 then
				break;
			end;
			v471 = v472;
			if v473:IsA("Frame") then
				v473:Destroy();
			end;		
		end;
		for v474, v475 in pairs(l__reward__468.items) do
			local v476 = l__Template__467:Clone();
			v476.ImageButton.Image = u3.getImage(v474);
			v476.QuantityLabel.Text = v475 > 1 and tostring(v475) or "";
			v476.Parent = l__Info__466.RewardList.Items.List;
			v476.Visible = true;
		end;
		l__Info__466.RewardList.Items.Visible = true;
	else
		l__Info__466.RewardList.Items.Visible = false;
	end;
	if not l__reward__468.cosmetics then
		l__Info__466.RewardList.Cosmetics.Visible = false;
		return;
	end;
	local l__next__477 = next;
	local v478, v479 = l__Info__466.RewardList.Cosmetics.List:GetChildren();
	while true do
		local v480, v481 = l__next__477(v478, v479);
		if not v480 then
			break;
		end;
		v479 = v480;
		if v481:IsA("Frame") then
			v481:Destroy();
		end;	
	end;
	for v482, v483 in pairs(l__reward__468.cosmetics) do
		local v484 = l__Template__467:Clone();
		v484.ImageButton.Image = u3.getImage(v483);
		v484.QuantityLabel.Text = "";
		v484.Parent = l__Info__466.RewardList.Cosmetics.List;
		v484.Visible = true;
	end;
	l__Info__466.RewardList.Cosmetics.Visible = true;
end;
function v12.DrawQuestsMenu()
	local l__Quests__485 = u1.mainGui.RightPanel.Quests;
	local l__Current__486 = l__Quests__485.Current;
	local l__Queue__487 = l__Quests__485.Queue;
	local l__Info__488 = l__Quests__485.Info;
	local l__next__489 = next;
	local v490, v491 = l__Current__486.List:GetChildren();
	while true do
		local v492, v493 = l__next__489(v490, v491);
		if not v492 then
			break;
		end;
		v491 = v492;
		if v493:IsA("ImageButton") then
			v493:Destroy();
		end;	
	end;
	local l__next__494 = next;
	local v495, v496 = l__Queue__487.List:GetChildren();
	while true do
		local v497, v498 = l__next__494(v495, v496);
		if not v497 then
			break;
		end;
		v496 = v497;
		if v498:IsA("Frame") then
			v498:Destroy();
		end;	
	end;
	l__Current__486.Quantity.Text = tostring(#_G.data.quests) .. "/9";
	for v499, v500 in pairs(_G.data.quests) do
		local v501 = l__Current__486.Template:Clone();
		v501.QuestName.Text = v500.name;
		v501.QuestDescription.Text = v500.description;
		v501.SliderFrame.Slider.Size = UDim2.fromScale(v500.quantity.has / v500.quantity.needs, 1);
		v501.Activated:connect(function()
			l__Current__486.Visible = false;
			l__Queue__487.Visible = false;
			l__Info__488.Visible = true;
			u1.currentViewingQuestIndex = v499;
			u1.DrawQuestInfoMenu(v500);
		end);
		v501.Parent = l__Current__486.List;
		v501.Visible = true;
	end;
	local v502, v503, v504 = pairs(_G.data.questQueue);
	while true do
		local v505, v506 = v502(v503, v504);
		if not v505 then
			break;
		end;
		local v507 = l__Queue__487.Template:Clone();
		v507.QuestName.Text = v506.name;
		v507.QuestDescription.Text = v506.description;
		local l__reward__508 = v506.reward;
		if l__reward__508.coins then
			v507.RewardList.Coins.Label.Text = tostring(l__reward__508.coins);
		else
			v507.RewardList.Coins:Destroy();
		end;
		if l__reward__508.essence then
			v507.RewardList.Essence.Label.Text = tostring(l__reward__508.essence);
		else
			v507.RewardList.Essence:Destroy();
		end;
		if l__reward__508.items then
			for v509, v510 in pairs(l__reward__508.items) do
				local v511 = v507.Template:Clone();
				v511.ImageButton.Image = u3.getImage(v509);
				v511.QuantityLabel.Text = v510 > 1 and tostring(v510) or "";
				v511.Parent = v507.RewardList.Items.List;
				v511.Visible = true;
			end;
		else
			v507.RewardList.Items:Destroy();
		end;
		if l__reward__508.cosmetics then
			for v512, v513 in pairs(l__reward__508.cosmetics) do
				local v514 = v507.Template:Clone();
				v514.ImageButton.Image = u3.getImage(v513);
				v514.QuantityLabel.Text = "";
				v514.Parent = v507.RewardList.Cosmetics.List;
				v514.Visible = true;
			end;
		else
			v507.RewardList.Cosmetics:Destroy();
		end;
		v507.Yes.Activated:connect(function()
			if #_G.data.quests >= 9 then
				u1.CreateNotification("You have the max quests outbound", u12.badRed, 1.5);
				return;
			end;
			l__ReplicatedStorage__1.Events.ClaimQuest:FireServer(v505);
		end);
		v507.No.Activated:connect(function()
			l__ReplicatedStorage__1.Events.DeclineQuest:FireServer(v505);
		end);
		v507.Parent = l__Queue__487.List;
		v507.Visible = true;	
	end;
end;
function v12.DrawCraftMenu()
	local l__craftCategory__515 = u1.craftCategory;
	local l__craftPhrase__516 = u1.craftPhrase;
	local l__next__517 = next;
	local v518, v519 = u1.mainGui.LeftPanel.Craft.List:GetChildren();
	while true do
		local v520, v521 = l__next__517(v518, v519);
		if not v520 then
			break;
		end;
		v519 = v520;
		if v521:IsA("ImageLabel") or v521:IsA("Frame") then
			v521:Destroy();
		end;	
	end;
	local l__next__522 = next;
	local v523 = nil;
	while true do
		local v524, v525 = l__next__522(u9, v523);
		if not v524 then
			break;
		end;
		local v526 = true;
		if not u3.getRecipe(v524).recipe then
			v526 = false;
		end;
		if l__craftCategory__515 and l__craftCategory__515 ~= "all" and v525.itemType ~= l__craftCategory__515 then
			v526 = false;
		end;
		if l__craftPhrase__516 and not v524:lower():match(l__craftPhrase__516:lower()) then
			v526 = false;
		end;
		if v526 then
			if u1.currentGuiStyle == "Classic" then
				local v527 = true;
				if (v525.craftLevel and 0) <= _G.data.level and (not (not v525.mojoRecipe) and not (not u1.HasMojoRecipe(v524)) or not v525.mojoRecipe) then
					local v528 = u1.mainGui.LeftPanel.Craft.Templates.ItemFrame:Clone();
					v528.ItemIconBackdrop.ItemIcon.Image = u3.getImage(v524);
					v528.NameLabel.Text = v524;
					v528.Name = v524;
					local v529 = 0;
					for v530, v531 in next, u3.getRecipe(v524).recipe do
						v529 = v529 + 1;
						local v532 = v528:FindFirstChild("Ingredient" .. v529);
						v532.ItemIcon.Image = u3.getImage(v530);
						v532.Title.Text = v531 .. " " .. v530;
						v532.Name = v530;
						v532.Visible = true;
						local v533 = u1.HasItem(v530);
						if v533 then
							if _G.data.inventory[v533].quantity and not (v531 <= _G.data.inventory[v533].quantity) then
								v532.ItemIcon.BackgroundColor3 = u12.badRed;
								v532.Title.TextColor3 = u12.badRed;
								v527 = false;
							end;
						else
							v532.ItemIcon.BackgroundColor3 = u12.badRed;
							v532.Title.TextColor3 = u12.badRed;
							v527 = false;
						end;
					end;
					if v527 then
						v528.CraftButton.CanCraftImage.Visible = true;
						v528.CraftButton.NoCraftImage.Visible = false;
					else
						v528.CraftButton.CanCraftImage.Visible = false;
						v528.CraftButton.NoCraftImage.Visible = true;
					end;
					v528.CraftButton.Activated:connect(function()
						if u1.CanCraftItem(v524) then
							l__Bank__31.Click1:Play();
							if not v525.deployable then
								l__ReplicatedStorage__1.Events.CraftItem:FireServer(v524);
								return;
							end;
						else
							return;
						end;
						u1.OpenGui(u1.cards.Bag, false);
						if u1.dragObject then
							u1.dragObject = nil;
						end;
						u1.placeStructureFromBag = false;
						u1.BindMouseStructure(l__ReplicatedStorage__1.Deployables:FindFirstChild(v524):Clone());
					end);
					v528.LayoutOrder = v525.craftLevel and 997;
					v528.Parent = u1.mainGui.LeftPanel.Craft.List;
					v528.Visible = true;
				else
					local v534 = u1.mainGui.LeftPanel.Craft.Templates.LockedFrame:Clone();
					v534.SecretTitle.Text = v524;
					v534.ItemIconBackdrop.ItemIcon.Image = u3.getImage(v524);
					v534.Parent = u1.mainGui.LeftPanel.Craft.List;
					v534.Visible = true;
					if not v525.mojoRecipe then
						v534.LockedLabel.Text = "locked [" .. (v525.craftLevel and 997) .. "]";
						v534.LayoutOrder = 200 + (v525.craftLevel and 997);
					else
						v534.LockedLabel.Text = "locked [MOJO]";
						v534.LayoutOrder = 998;
					end;
				end;
			else
				local v535 = true;
				if (v525.craftLevel and 0) <= _G.data.level and (not (not v525.mojoRecipe) and not (not u1.HasMojoRecipe(v524)) or not v525.mojoRecipe) then
					local v536 = u1.mainGui.LeftPanel.Craft.Templates.ItemFrame:Clone();
					v536.ImageLabel.Image = u3.getImage(v524);
					v536.Title.Text = v524;
					v536.Name = v524;
					local v537 = 0;
					local l__next__538 = next;
					local l__recipe__539 = u3.getRecipe(v524).recipe;
					local v540 = nil;
					while true do
						local v541, v542 = l__next__538(l__recipe__539, v540);
						if not v541 then
							break;
						end;
						local v543 = u1.mainGui.LeftPanel.Craft.Templates.Ingredient:Clone();
						if v542 ~= 1 then
							local v544 = "S";
						else
							v544 = "";
						end;
						v543.IngredientName.Text = tostring(v542) .. " " .. v541:upper() .. v544;
						local v545 = u1.HasItem(v541);
						if v545 then
							if _G.data.inventory[v545].quantity then
								if v542 <= _G.data.inventory[v545].quantity then
									v543.IngredientName.BackgroundColor3 = u12.black;
								else
									v543.IngredientName.BackgroundColor3 = u12.badRed;
									v535 = false;
								end;
							else
								v543.IngredientName.BackgroundColor3 = u12.black;
							end;
						else
							v543.IngredientName.BackgroundColor3 = u12.badRed;
							v535 = false;
						end;
						v543.ImageLabel.Image = u3.getImage(v541);
						v543.Parent = v536.IngredientsList;
						v543.Visible = true;
						v537 = v537 + 1;					
					end;
					v536.IngredientsList.UIAspectRatioConstraint.AspectRatio = v537;
					if v535 then
						v536.CraftButton.Text = ">";
						v536.CraftButton.BackgroundColor3 = u12.goodBlue;
					end;
					v536.CraftButton.Activated:connect(function()
						if u1.CanCraftItem(v524) then
							l__Bank__31.Click1:Play();
							if not v525.deployable then
								l__ReplicatedStorage__1.Events.CraftItem:FireServer(v524);
								return;
							end;
						else
							return;
						end;
						u1.OpenGui(u1.cards.Bag, false);
						if u1.dragObject then
							u1.dragObject = nil;
						end;
						u1.placeStructureFromBag = false;
						u1.BindMouseStructure(l__ReplicatedStorage__1.Deployables:FindFirstChild(v524):Clone());
					end);
					v536.LayoutOrder = v525.craftLevel and 997;
					v536.Parent = u1.mainGui.LeftPanel.Craft.List;
					v536.Visible = true;
				else
					local v546 = u1.mainGui.LeftPanel.Craft.Templates.LockedFrame:Clone();
					v546.SecretTitle.Text = v524;
					v546.ImageLabel.Image = u3.getImage(v524);
					v546.Parent = u1.mainGui.LeftPanel.Craft.List;
					v546.Visible = true;
					if not v525.mojoRecipe then
						v546.LockedLabel.Text = "locked [" .. (v525.craftLevel and 997) .. "]";
						v546.LayoutOrder = 200 + (v525.craftLevel and 997);
					else
						v546.LockedLabel.Text = "locked [MOJO]";
						v546.LayoutOrder = 998;
					end;
				end;
			end;
		end;	
	end;
	local v547 = u1.mainGui.LeftPanel.Craft.List:FindFirstChildOfClass("ImageLabel") or u1.mainGui.LeftPanel.Craft.List:FindFirstChildOfClass("Frame");
	if v547 then
		local v548 = v547.AbsoluteSize.Y + 15;
	else
		v548 = 5;
	end;
	u1.mainGui.LeftPanel.Craft.List.CanvasSize = UDim2.new(0, 0, 0, #u1.mainGui.LeftPanel.Craft.List:GetChildren() * v548);
end;
function v12.DrawSelectedChest()
	local l__DetailsFrame__549 = u1.mainGui.LeftPanel.Shop.Lists.ChestList.DetailsFrame;
	local l__Value__550 = l__DetailsFrame__549.SelectedChest.Value;
	if l__Value__550 ~= "" then
		local v551 = u1.HasItem(l__Value__550);
		local v552 = u9[l__Value__550];
		local v553 = 0;
		if v551 then
			v553 = _G.data.inventory[v551].quantity;
		end;
		local v554 = _G.rank >= 253;
		local v555 = true;
		if not ((v552.cost or math.huge) <= _G.data.coins) then
			v555 = v554;
		end;
		l__DetailsFrame__549.Chest.Image = u3.getImage(l__Value__550);
		if v555 then
			local v556 = "BUY";
		else
			v556 = "Not Enough";
		end;
		l__DetailsFrame__549.BuyButton.Text = v556;
		l__DetailsFrame__549.BuyButton.BackgroundColor3 = v555 and u12.essenceYellow or u12.grey200;
		if v553 > 0 then
			local v557 = "OPEN";
		else
			v557 = ">>";
		end;
		l__DetailsFrame__549.OpenButton.Text = v557;
		l__DetailsFrame__549.OpenButton.BackgroundColor3 = v553 > 0 and u12.goodGreen or u12.grey200;
		if v552.cost then
			local v558 = tostring(v552.cost) .. " \194\162";
			if not v558 then
				if v554 then
					v558 = "free";
				else
					v558 = "Not for sale";
				end;
			end;
		elseif v554 then
			v558 = "free";
		else
			v558 = "Not for sale";
		end;
		l__DetailsFrame__549.Cost.Text = v558;
		l__DetailsFrame__549.Chest.Quantity.Text = v553;
		l__DetailsFrame__549.Chest.Title.Text = l__Value__550;
		l__DetailsFrame__549.Chest.Title.TextColor3 = u1.chestList.List:FindFirstChild(l__Value__550) and u1.chestList.List[l__Value__550].BackgroundColor3 or u12.grey200;
		if not v552.cost and not v554 then
			l__DetailsFrame__549.BuyButton.Visible = false;
		else
			l__DetailsFrame__549.BuyButton.Visible = true;
		end;
		l__DetailsFrame__549.Visible = true;
	end;
end;
function v12.DrawChestList()
	local v559 = u1.chestList and u1.chestList:FindFirstChild("DetailsFrame");
	if not v559 then
		return;
	end;
	local l__Value__560 = v559.SelectedChest.Value;
	local l__next__561 = next;
	local v562, v563 = u1.chestList.List:GetChildren();
	while true do
		local v564, v565 = l__next__561(v562, v563);
		if not v564 then
			break;
		end;
		v563 = v564;
		if v565:IsA("ImageButton") then
			if v565.Name == l__Value__560 then
				v565.BackgroundTransparency = 0;
			else
				v565.BackgroundTransparency = 0.4;
			end;
			v565.LayoutOrder = u9[v565.Name].cost and 1000000;
		end;	
	end;
	u1.DrawSelectedChest();
end;
function v12.colorFarmFrame()
	for v566, v567 in pairs(u1.mainGui.Panels.Toolbar.FarmFrame.List:GetChildren()) do
		if v567:IsA("GuiBase") then
			if v567.Name == u1.currentPlant then
				v567.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
				v567.BorderSizePixel = 2;
			else
				v567.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
				v567.BorderSizePixel = 0;
			end;
		end;
	end;
end;
function v12.drawItemInfo()
	local l__Inventory__568 = u1.mainGui.RightPanel.Inventory;
	local l__currentInventoryItem__569 = u1.currentInventoryItem;
	local v570 = u9[l__currentInventoryItem__569];
	local v571 = l__currentInventoryItem__569 and u1.HasItem(l__currentInventoryItem__569);
	if not v571 then
		l__Inventory__568.InteractionFrame.SliderFrame.Visible = false;
		l__Inventory__568.InteractionFrame.ItemImage.NameLabel.Text = "";
		l__Inventory__568.InteractionFrame.ItemImage.ItemQuantity.Text = "";
		l__Inventory__568.InteractionFrame.ItemImage.Image = "";
		l__Inventory__568.InteractionFrame.ActionBar.Visible = false;
		u1.currentInventoryMaxQuantity = 0;
		return;
	end;
	local v572 = v571 and _G.data.inventory[v571].quantity or 1;
	l__Inventory__568.InteractionFrame.SliderFrame.Visible = true;
	l__Inventory__568.InteractionFrame.ItemImage.NameLabel.Text = l__currentInventoryItem__569;
	l__Inventory__568.InteractionFrame.ItemImage.ItemQuantity.Text = v572;
	l__Inventory__568.InteractionFrame.ItemImage.Image = u3.getImage(l__currentInventoryItem__569);
	l__Inventory__568.InteractionFrame.ActionBar.Consume.Visible = not (not v570.nourishment);
	l__Inventory__568.InteractionFrame.ActionBar.Drop.Visible = not v570.noDrop and not v570.mojoCost;
	local v573 = true;
	if v570.itemType ~= "armor" then
		v573 = v570.itemType == "tool";
	end;
	l__Inventory__568.InteractionFrame.ActionBar.Equip.Visible = v573;
	local v574 = true;
	if v570.itemType ~= "building" then
		v574 = true;
		if v570.itemType ~= "boat" then
			v574 = v570.itemType == "dropChest";
		end;
	end;
	l__Inventory__568.InteractionFrame.ActionBar.Use.Visible = v574;
	l__Inventory__568.InteractionFrame.ActionBar.Visible = true;
	u1.currentInventoryMaxQuantity = v572;
end;
function v12.DisplayReward(p102, p103)
	local l__RewardItem__575 = u1.mainGui.Panels.RewardItem;
	l__RewardItem__575.ItemImage.Image = u3.getImage(p102);
	l__RewardItem__575.ItemImage.ItemName.Text = p102;
	l__RewardItem__575.ItemImage.ItemQuantity.Text = p103;
	l__RewardItem__575.Visible = true;
end;
function v12.DrawInventory(p104)
	if not u1.mainGui then
		coroutine.wrap(function()
			while true do
				task.wait();
				if u1.mainGui then
					break;
				end;			
			end;
			u1.DrawInventory(p104);
		end)();
		return;
	end;
	if not p104 then
		p104 = u1.lastInventoryCategory;
	end;
	local v576, v577 = u1.CalculateLoad();
	u1.mainGui.RightPanel.Inventory.BagMeter.Slider.Size = UDim2.new(1, 0, math.clamp(v576 / v577, 0, 1), 0);
	if u1.currentGuiStyle == "Classic" then
		local l__next__578 = next;
		local v579, v580 = u1.mainGui.LeftPanel.Shop.Lists.ChestList:GetChildren();
		while true do
			local v581, v582 = l__next__578(v579, v580);
			if not v581 then
				break;
			end;
			v580 = v581;
			if v582:IsA("Frame") then
				local v583 = 0;
				local v584 = u1.HasItem(v582.Name);
				if v584 then
					v583 = _G.data.inventory[v584].quantity;
				end;
				v582.Quantity.Text = v583;
				if v583 > 0 then
					v582.OpenButton.Text = "OPEN";
					v582.OpenButton.BackgroundColor3 = u12.goodGreen;
					v582.OpenButton.Visible = true;
					v582.Quantity.TextColor3 = u12.goodGreen;
				else
					v582.OpenButton.Text = ">> ";
					v582.OpenButton.BackgroundColor3 = u12.ironGrey;
					v582.Quantity.TextColor3 = Color3.fromRGB(255, 255, 255);
				end;
			end;		
		end;
	else
		u1.DrawChestList();
	end;
	if _G.data.equipped then
		local v585 = u9[_G.data.toolbar[_G.data.equipped].name];
		if v585.toolType == "ranged" then
			u1.mainGui.Panels.Stats.IconStats.AmmoImage.Image = u3.getImage(v585.ammoItem);
			local v586 = u1.HasItem(v585.ammoItem);
			if v586 then
				u1.mainGui.Panels.Stats.IconStats.AmmoImage.ImageLabel.QuantityLabel.Text = _G.data.inventory[v586].quantity;
			else
				u1.mainGui.Panels.Stats.IconStats.AmmoImage.ImageLabel.QuantityLabel.Text = "0";
			end;
			u1.mainGui.Panels.Stats.IconStats.AmmoImage.Visible = true;
		end;
	else
		u1.mainGui.Panels.Stats.IconStats.AmmoImage.Visible = false;
	end;
	local l__next__587 = next;
	local v588, v589 = u1.mainGui.Panels.Toolbar.FarmFrame.List:GetChildren();
	while true do
		local v590, v591 = l__next__587(v588, v589);
		if not v590 then
			break;
		end;
		v589 = v590;
		if v591:IsA("GuiBase") then
			v591:Destroy();
		end;	
	end;
	for v592, v593 in next, _G.data.inventory do
		if v593.name and u9[v593.name] and u9[v593.name].grows then
			local v594 = u1.mainGui.Panels.Toolbar.FarmFrame.Templates.ImageButton:Clone();
			v594.Image = u3.getImage(v593.name);
			v594.TextLabel.Text = v593.quantity and 0;
			v594.Name = v593.name;
			v594.Activated:connect(function()
				u1.currentPlant = v593.name;
				u1.colorFarmFrame();
			end);
			v594.Parent = u1.mainGui.Panels.Toolbar.FarmFrame.List;
			v594.Visible = true;
		end;
	end;
	u1.colorFarmFrame();
	if not (not u1.mainGui.RightPanel.Inventory.Visible) or not (not u1.mainGui.LeftPanel.Shop.Visible) or u1.mainGui.LeftPanel:FindFirstChild("Crates") and u1.mainGui.LeftPanel.Crates.Visible then
		local l__next__595 = next;
		local v596, v597 = u1.mainGui.RightPanel.Inventory.List:GetChildren();
		while true do
			local v598, v599 = l__next__595(v596, v597);
			if not v598 then
				break;
			end;
			v597 = v598;
			if v599:IsA("GuiBase") then
				v599:Destroy();
			end;		
		end;
		local v600 = nil;
		if u1.currentGuiStyle == "Hybrid" or u1.currentGuiStyle == "Bubble" or u1.currentGuiStyle == "Daves" then
			v600 = u1.mainGui.LeftPanel.Crates;
			local l__next__601 = next;
			local v602, v603 = v600.ChestList:GetChildren();
			while true do
				local v604, v605 = l__next__601(v602, v603);
				if not v604 then
					break;
				end;
				v603 = v604;
				if v605:IsA("ImageButton") then
					v605:Destroy();
				end;			
			end;
		end;
		if u1.currentInventoryItem then
			u1.drawItemInfo();
		end;
		for v606, v607 in next, _G.data.inventory do
			if v607 and v607.name and v607.name ~= "none" then
				local v608 = true;
				if p104 and p104 ~= "all" and u9[v607.name].itemType ~= p104 then
					v608 = false;
				end;
				if v608 then
					local v609 = u1.mainGui.RightPanel.Inventory.Templates.ItemFrame:Clone();
					v609.ImageButton.Image = u3.getImage(v607.name);
					v609.Name = v606;
					v609.ImageButton.InputBegan:Connect(function(p105)
						local l__mouse__610 = u1.mouse;
						if p105.UserInputType == Enum.UserInputType.Touch then
							u1.currentInventoryItem = v607.name;
							u1.currentInventoryMaxQuantity = v607.quantity and 1;
							u1.drawItemInfo();
							return;
						end;
						if p105.UserInputType == Enum.UserInputType.MouseButton2 then
							game.ReplicatedStorage.Events.DropBagItem:FireServer(v607.name);
							return;
						end;
						if p105.UserInputType == Enum.UserInputType.MouseButton1 then
							if u9[v607.name].itemType == "food" and tick() - u1.timeDepressed <= 1 / (_G.data.userSettings.clickEatSpeed and 4) then
								game.ReplicatedStorage.Events.Consume:FireServer(v607.name);
								u1.CreateSound(l__Bank__31.Eat, u1.playerGui, true);
								return;
							end;
							u1.GPLMBDown = true;
							local l__X__611 = l__mouse__610.X;
							local l__Y__612 = l__mouse__610.Y;
							while true do
								l__RunService__15.RenderStepped:Wait();
								if not u1.GPLMBDown then
									if u1.currentInventoryItem ~= v607.name then
										u1.currentInventoryItem = v607.name;
										u1.currentInventoryMaxQuantity = v607.quantity and 1;
									else
										u1.currentInventoryItem = nil;
									end;
									u1.drawItemInfo();
									return;
								end;
								if l__X__611 ~= l__mouse__610.X then
									break;
								end;
								if l__Y__612 ~= l__mouse__610.Y then
									break;
								end;							
							end;
							if not u1.draggingIcon then
								u1.draggingIcon = v609:Clone();
								u1.draggingIcon.Size = UDim2.new(0, v609.AbsoluteSize.X, 0, v609.AbsoluteSize.Y);
								u1.draggingIcon.AnchorPoint = Vector2.new(0.5, 0.5);
								u1.draggingIcon.Parent = u1.mainGui.TempEffects;
								while u1.draggingIcon and u1.GPLMBDown do
									u1.draggingIcon.Position = UDim2.new(0, l__mouse__610.X, 0, l__mouse__610.Y);
									l__RunService__15.RenderStepped:Wait();								
								end;
								local v613 = nil;
								for v614, v615 in next, u1.mainGui.RightPanel.Inventory.List:GetChildren() do
									if v615:IsA("GuiBase") and v615.AbsolutePosition.X <= l__mouse__610.X and l__mouse__610.X <= v615.AbsolutePosition.X + v615.AbsoluteSize.X and v615.AbsolutePosition.Y <= l__mouse__610.Y and l__mouse__610.Y <= v615.AbsolutePosition.Y + v615.AbsoluteSize.Y then
										v613 = v615;
										break;
									end;
								end;
								if v613 then
									if v613 == v609 then
										u1.currentInventoryItem = v607.name;
										u1.currentInventoryMaxQuantity = v607.quantity and 1;
										u1.drawItemInfo();
									else
										l__ReplicatedStorage__1.Events.SwapItem:FireServer(v606, (tonumber(v613.Name)));
										l__Bank__31.ToolSwitch:Play();
									end;
								else
									game.ReplicatedStorage.Events.DropBagItem:FireServer(v607.name, v607.quantity and 1);
								end;
								u1.draggingIcon:Destroy();
								u1.draggingIcon = nil;
							end;
						end;
					end);
					if u1.currentGuiStyle == "Classic" then
						local v616 = "Title";
					else
						v616 = "ItemNameLabel";
					end;
					v609[v616].Text = v607.name;
					if l__UserInputService__13.MouseEnabled then
						v609[v616].Visible = false;
					else
						v609[v616].Visible = true;
					end;
					v609.ImageButton.MouseEnter:connect(function()
						v609[v616].Visible = true;
						u1.hoveringInventoryItem = v607.name;
						u1.whenHover = tick();
					end);
					v609.ImageButton.MouseLeave:connect(function()
						if l__UserInputService__13.MouseEnabled then
							v609[v616].Visible = false;
						end;
						u1.hoveringInventoryItem = nil;
						u1.whenHover = tick();
					end);
					if v607.quantity and v607.quantity > 1 then
						(u1.currentGuiStyle == "Classic" and v609.QuantityImage.QuantityText or v609.Quantity).Text = v607.quantity;
					end;
					v609.Parent = u1.mainGui.RightPanel.Inventory.List;
					v609.Visible = true;
				end;
				if u1.currentGuiStyle == "Hybrid" or u1.currentGuiStyle == "Bubble" or u1.currentGuiStyle == "Daves" then
					if u9[v607.name].itemType == "crate" then
						local v617 = v600.Template:Clone();
						v617.Parent = v600.ChestList;
						v617.Visible = true;
						v617.Activated:connect(function()
							v600.DetailsFrame.SelectedIndex.Value = v606;
							u1.DrawCrateDetails(v606);
						end);
					end;
					v600.DetailsFrame.Visible = false;
				end;
			end;
		end;
	else
		u1.redrawInventory = true;
	end;
	u1.UpdateBillboards();
end;
function v12.DrawCrateDetails(p106)
	local l__Crates__618 = u1.mainGui.LeftPanel.Crates;
	l__Crates__618.Temp:ClearAllChildren();
	local v619 = l__Crates__618.DetailsFrame:Clone();
	v619.Chest.Image = u3.getImage("Crate");
	for v620, v621 in pairs(_G.data.inventory[p106].contents) do
		local v622 = v619.Template:Clone();
		v622.Quantity.Text = v621;
		v622.Image = u3.getImage(v620);
		v622.Parent = v619.Contents;
		v622.Visible = true;
	end;
	v619.OpenButton.Activated:connect(function()
		l__ReplicatedStorage__1.Events.CrateDrop:FireServer(p106);
		v619:Destroy();
	end);
	v619.Parent = l__Crates__618.Temp;
	v619.Visible = true;
end;
function v12.ClearBetweenPoints(p107, p108, p109)
	local v623, v624, v625, v626 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p107, p108 - p107), p109);
	if v623 then
		return false;
	end;
	return true;
end;
function v12.GetDictionaryLength(p110)
	local v627 = 0;
	for v628, v629 in next, p110 do
		v627 = v627 + 1;
	end;
	return v627;
end;
function v12.SortToolbar()
	if not u1.mainGui then
		coroutine.wrap(function()
			while true do
				task.wait();
				if u1.mainGui then
					break;
				end;			
			end;
			u1.SortToolbar();
		end)();
		return;
	end;
	u1.mainGui.Panels.Toolbar.FarmFrame.Visible = false;
	u1.colorFarmFrame();
	local l__next__630 = next;
	local v631, v632 = u1.mainGui.Panels.Toolbar.List:GetChildren();
	while true do
		local v633, v634 = l__next__630(v631, v632);
		if not v633 then
			break;
		end;
		v632 = v633;
		if v634:IsA("ImageButton") then
			if u1.GetDictionaryLength(_G.data.toolbar[tonumber(v634.Name)]) > 0 and _G.data.toolbar[tonumber(v634.Name)].name ~= "none" then
				v634.Image = u3.getImage(_G.data.toolbar[tonumber(v634.Name)].name);
			else
				v634.Image = "";
			end;
			if u1.currentGuiStyle == "Daves" then
				if tonumber(v634.Name) == _G.data.equipped then
					v634.BackgroundColor3 = u12.goodGreen;
				else
					v634.BackgroundColor3 = u12.ironGrey;
				end;
			elseif tonumber(v634.Name) == _G.data.equipped then
				v634.ActiveIcon.Visible = true;
				v634.InactiveIcon.Visible = false;
			else
				v634.ActiveIcon.Visible = false;
				v634.InactiveIcon.Visible = true;
			end;
		end;	
	end;
	if not _G.data.equipped then
		if u1.mainGui.Panels.Toolbar:FindFirstChild("Title") then
			u1.mainGui.Panels.Toolbar.Title.Visible = false;
		end;
		for v635, v636 in next, u1.anims do
			v636:Stop();
		end;
		u1.mainGui.Panels.Stats.IconStats.AmmoImage.Visible = false;
		return;
	end;
	if u1.GetDictionaryLength(_G.data.toolbar[_G.data.equipped]) > 0 then
		for v637, v638 in next, u1.anims do
			v638:Stop();
		end;
		if u9[_G.data.toolbar[_G.data.equipped].name].idleAnim then
			u1.anims[u9[_G.data.toolbar[_G.data.equipped].name].idleAnim]:Play();
		end;
		local v639 = u1.char:WaitForChild(_G.data.toolbar[_G.data.equipped].name, 2);
		if v639 then
			local l__next__640 = next;
			local v641, v642 = v639:GetChildren();
			while true do
				local v643, v644 = l__next__640(v641, v642);
				if not v643 then
					break;
				end;
				v642 = v643;
				if v644.Name == "Draw" then
					v644.Transparency = 1;
				elseif v644.Name == "Rest" then
					v644.Transparency = 0;
				end;			
			end;
		end;
	end;
	local v645 = _G.data.toolbar[_G.data.equipped];
	if u1.mainGui.Panels.Toolbar:FindFirstChild("Title") then
		u1.mainGui.Panels.Toolbar.Title.Visible = true;
		u1.mainGui.Panels.Toolbar.Title.Text = v645.name:upper();
	end;
	if v645 then
		local v646 = u9[v645.name];
		u1.mainGui.Panels.Toolbar.FarmFrame.Visible = v646.useType == "Farming";
		if v646.toolType == "ranged" then
			u1.mainGui.Panels.Stats.IconStats.AmmoImage.ImageLabel.Image = u3.getImage(v646.ammoItem);
			local v647 = u1.HasItem(v646.ammoItem);
			u1.mainGui.Panels.Stats.IconStats.AmmoImage.ImageLabel.QuantityLabel.Text = v647 and _G.data.inventory[v647].quantity or 0;
			u1.mainGui.Panels.Stats.IconStats.AmmoImage.Visible = true;
		end;
	end;
end;
function v12.yoinkItem()
	if u1.mouse.Target then
		if not u1.mouse.Target:FindFirstChild("Pickup") then
			if u1.mouse.Target.Parent:FindFirstChild("Pickup") and (u1.mouse.Target.Position - u1.root.Position).magnitude <= 25 and l__LocalPlayer__5.Character and l__LocalPlayer__5.Character.Humanoid and l__LocalPlayer__5.Character.Humanoid.Health > 0 then
				if l__UserInputService__13.TouchEnabled then
					u1.ignoreLastSwing = true;
				end;
				local v648 = nil;
				if u1.mouse.Target:FindFirstChild("Pickup") then
					v648 = u1.mouse.Target;
				elseif u1.mouse.Target.Parent:FindFirstChild("Pickup") then
					v648 = u1.mouse.Target.Parent;
				end;
				if u3.CanBearLoad(v648.Name, v648.Pickup.Value) then
					local v649 = l__Bank__31[u9[v648.Name].pickupSound and "Pickup"]:Clone();
					local u35 = v649;
					v649.Ended:Connect(function()
						u35:Destroy();
						u35 = nil;
					end);
					u35.Parent = l__LocalPlayer__5.PlayerGui;
					u35:Play();
					u1.CollectPart((v648:Clone()));
					v648.Parent = l__ReplicatedStorage__1;
					if not l__ReplicatedStorage__1.Events.Pickup:InvokeServer(v648) and true and v648 and v648.Parent then
						v648.Parent = v648.Parent;
					end;
					return;
				else
					u1.CreateNotification("BAG FULL", u12.badRed, 1.3);
					local l__Slider__36 = u1.mainGui.RightPanel.Inventory.BagMeter.Slider;
					local u37 = Color3.fromRGB(198, 131, 79);
					spawn(function()
						for v650 = 1, 6 do
							if v650 % 2 == 1 then
								l__Slider__36.BackgroundColor3 = u12.badRed;
							else
								l__Slider__36.BackgroundColor3 = u37;
							end;
							task.wait(0.1);
						end;
					end);
				end;
			end;
		elseif (u1.mouse.Target.Position - u1.root.Position).magnitude <= 25 and l__LocalPlayer__5.Character and l__LocalPlayer__5.Character.Humanoid and l__LocalPlayer__5.Character.Humanoid.Health > 0 then
			if l__UserInputService__13.TouchEnabled then
				u1.ignoreLastSwing = true;
			end;
			v648 = nil;
			if u1.mouse.Target:FindFirstChild("Pickup") then
				v648 = u1.mouse.Target;
			elseif u1.mouse.Target.Parent:FindFirstChild("Pickup") then
				v648 = u1.mouse.Target.Parent;
			end;
			if u3.CanBearLoad(v648.Name, v648.Pickup.Value) then
				v649 = l__Bank__31[u9[v648.Name].pickupSound and "Pickup"]:Clone();
				u35 = v649;
				v649.Ended:Connect(function()
					u35:Destroy();
					u35 = nil;
				end);
				u35.Parent = l__LocalPlayer__5.PlayerGui;
				u35:Play();
				u1.CollectPart((v648:Clone()));
				v648.Parent = l__ReplicatedStorage__1;
				if not l__ReplicatedStorage__1.Events.Pickup:InvokeServer(v648) and true and v648 and v648.Parent then
					v648.Parent = v648.Parent;
				end;
				return;
			else
				u1.CreateNotification("BAG FULL", u12.badRed, 1.3);
				l__Slider__36 = u1.mainGui.RightPanel.Inventory.BagMeter.Slider;
				u37 = Color3.fromRGB(198, 131, 79);
				spawn(function()
					for v650 = 1, 6 do
						if v650 % 2 == 1 then
							l__Slider__36.BackgroundColor3 = u12.badRed;
						else
							l__Slider__36.BackgroundColor3 = u37;
						end;
						task.wait(0.1);
					end;
				end);
			end;
		end;
	end;
end;
function v12.ShootProjectile()
	if _G.data.equipped then
		local l__data__651 = _G.data;
		local v652 = l__data__651.toolbar[l__data__651.equipped];
		local l__name__653 = v652.name;
		if u9[v652.name].toolType == "ranged" then
			l__ReplicatedStorage__1.Events.FireWeapon:FireServer(u1.mouse.Hit);
		end;
	end;
end;
function v12.MakeProjectile(p111, p112, p113, p114)
	local v654 = l__ReplicatedStorage__1.Projectiles:FindFirstChild(u9[p111].ammoItem):Clone();
	v654.CFrame = p112;
	local v655 = {
		origin = p112.p, 
		position = p112.p, 
		drawStrength = p113, 
		velocity = p112.lookVector * math.clamp(u9[p111].velocityMagnitude * p113, 100, 500), 
		acceleration = Vector3.new(0, -156.2, 0), 
		age = tick(), 
		toolFrom = p111, 
		object = v654
	};
	if (u1.mouse.Hit.Position - u1.root.Position).magnitude > 50 then
		v655.velocity = v655.velocity + Vector3.new(0, 15, 0);
	end;
	v655.owned = p114 and false;
	u1.projectiles[#u1.projectiles + 1] = v655;
	v654.Parent = workspace;
	if p114 then
		l__ReplicatedStorage__1.Events.CreateProjectile:FireServer({
			originCF = p112, 
			drawStrength = p113, 
			toolName = p111
		});
	end;
end;
u1 = v12;
local v656 = l__ReplicatedStorage__1.Events.RequestData:InvokeServer();
if v656 then
	local v657 = v656.userSettings and v656.userSettings.guiType or "Hybrid";
else
	v657 = "Hybrid";
end;
u1.setGuiType(v657);
for v658, v659 in pairs(u1) do
	shared[v658] = v659;
end;
return nil;
