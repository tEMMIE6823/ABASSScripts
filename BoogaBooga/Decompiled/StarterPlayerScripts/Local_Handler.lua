-- Decompiled with the Synapse X Luau decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__StarterGui__4 = game:GetService("StarterGui");
local l__Debris__5 = game:GetService("Debris");
local l__TweenService__6 = game:GetService("TweenService");
local l__MarketplaceService__7 = game:GetService("MarketplaceService");
local l__ContentProvider__8 = game:GetService("ContentProvider");
local l__ContextActionService__9 = game:GetService("ContextActionService");
local l__TeleportService__10 = game:GetService("TeleportService");
local l__LocalPlayer__11 = game.Players.LocalPlayer;
local v12 = require(l__ReplicatedStorage__2.Modules.Client_Function_Bank);
_G.reprimanded = false;
game:GetService("Lighting").Bloom.Intensity = 0.6;
l__StarterGui__4:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
l__StarterGui__4:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
l__StarterGui__4:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
local v13 = Instance.new("BindableEvent");
v13.Event:connect(function()
	if game.Players.LocalPlayer.Character.Head:FindFirstChild("LogNotice") then
		v12.CreateNotification("You can't reset in combat", Color3.fromRGB(255, 0, 0), 4);
		return;
	end;
	game.Players.LocalPlayer.Character:BreakJoints();
end);
coroutine.wrap(function()
	wait();
	l__StarterGui__4:SetCore("ResetButtonCallback", v13);
end)();
local v14 = require(l__ReplicatedStorage__2.Modules.ColorData);
local v15 = require(l__ReplicatedStorage__2.Modules.ItemData);
local v16 = require(l__ReplicatedStorage__2.Modules.LevelData);
local v17 = require(l__ReplicatedStorage__2.Modules.CosmeticData);
local v18 = require(l__ReplicatedStorage__2.Modules.AmbientData);
local v19 = {};
for v20, v21 in next, v15 do
	if v21.image then
		v19[#v19 + 1] = v21.image;
	end;
end;
coroutine.wrap(function()
	l__ContentProvider__8:PreloadAsync(v19);
end)();
local l__LocalPlayer__22 = game.Players.LocalPlayer;
local l__mouse__23 = l__LocalPlayer__22:GetMouse();
local v24 = Vector3.new(25, 17, -25);
_G.hideOthers = true;
local v25 = Instance.new("Part");
v25.Transparency = 1;
v25.CanCollide = false;
v25.Anchored = true;
v25.Touched:connect(function()

end);
_G.anims = {};
ping = 0;
game:GetService("ContentProvider"):PreloadAsync(game.ReplicatedStorage.Animations:GetChildren());
local l__PlayerGui__26 = l__LocalPlayer__22:WaitForChild("PlayerGui");
l__PlayerGui__26:SetTopbarTransparency(1);
local l__SpawnGui__27 = l__PlayerGui__26:WaitForChild("SpawnGui");
l__LocalPlayer__22:WaitForChild("Backpack").ChildAdded:connect(function()
	l__LocalPlayer__22:Kick();
end);
bodyColorList = {
	LeftUpperLeg = true, 
	LeftLowerLeg = true, 
	LeftFoot = true, 
	RightUpperLeg = true, 
	RightLowerLeg = true, 
	RightFoot = true, 
	UpperTorso = true, 
	LowerTorso = true
};
skinColorList = {
	LeftUpperArm = true, 
	LeftLowerArm = true, 
	LeftHand = true, 
	RightUpperArm = true, 
	RightLowerArm = true, 
	RightHand = true, 
	Head = true
};
local l__next__28 = next;
local v29, v30 = v12.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection:GetChildren();
while true do
	local v31, v32 = l__next__28(v29, v30);
	if not v31 then
		break;
	end;
	v30 = v31;
	if v32:IsA("ImageButton") then
		v32.InputBegan:connect(function(p1, p2)
			if v12.InteractInput(p1, p2) and _G.Data.armor[v32.Name] and _G.Data.armor[v32.Name] ~= "none" then
				l__ReplicatedStorage__2.Events.UnequipArmor:FireServer(v32.Name);
			end;
		end);
	end;
end;
v12.secondaryGui.PlayerList.List.ActionPanel.KickButton.InputBegan:connect(function(p3, p4)
	if v12.InteractInput(p3, p4) then
		local l__Value__33 = v12.secondaryGui.PlayerList.List.ActionPanel.TargetPlayerName.Value;
		if l__Value__33 then
			local v34 = game.Players:FindFirstChild(l__Value__33);
			if v34 then
				l__ReplicatedStorage__2.Events.TribeKick:FireServer(v34);
				v12.secondaryGui.PlayerList.List.ActionPanel.Visible = false;
			end;
		end;
	end;
end);
v12.secondaryGui.PlayerList.List.ActionPanel.ModKick.Activated:connect(function()
	l__ReplicatedStorage__2.Events.ModAction:FireServer(game.Players:FindFirstChild(v12.secondaryGui.PlayerList.List.ActionPanel.TargetPlayerName.Value), "kick");
end);
v12.secondaryGui.PlayerList.List.ActionPanel.ModSuspension.Activated:connect(function()
	l__ReplicatedStorage__2.Events.ModAction:FireServer(game.Players:FindFirstChild(v12.secondaryGui.PlayerList.List.ActionPanel.TargetPlayerName.Value), "suspension");
end);
v12.secondaryGui.PlayerList.List.ActionPanel.CancelButton.InputBegan:connect(function(p5, p6)
	if v12.InteractInput(p5, p6) then
		v12.secondaryGui.PlayerList.List.ActionPanel.Visible = false;
	end;
end);
v12.secondaryGui.PlayerList.List.ActionPanel.InviteButton.InputBegan:connect(function(p7, p8)
	if v12.InteractInput(p7, p8) then
		l__ReplicatedStorage__2.Events.TribeInvite:FireServer(game.Players:FindFirstChild(v12.secondaryGui.PlayerList.List.ActionPanel.TargetPlayerName.Value));
		v12.secondaryGui.PlayerList.List.ActionPanel.Visible = false;
	end;
end);
v12.mainGui.Mobile.StructureButton.InputBegan:connect(function(p9, p10)
	if v12.InteractInput(p9, p10) then
		PlaceStructureFunction();
	end;
end);
local l__next__35 = next;
local v36, v37 = v12.mainGui.LeftPanel.Craft.Selection:GetChildren();
while true do
	local v38, v39 = l__next__35(v36, v37);
	if not v38 then
		break;
	end;
	v37 = v38;
	if v39:IsA("ImageButton") then
		v39.InputBegan:connect(function(p11, p12)
			if v12.InteractInput(p11, p12) then
				v39.ActiveImage.Visible = true;
				local l__next__40 = next;
				local v41, v42 = v12.mainGui.LeftPanel.Craft.Selection:GetChildren();
				while true do
					local v43, v44 = l__next__40(v41, v42);
					if not v43 then
						break;
					end;
					v42 = v43;
					if v44:IsA("ImageButton") and v44 ~= v39 then
						v44.ActiveImage.Visible = false;
					end;				
				end;
				v12.DrawCraftMenu(v39.Category.Value);
			end;
		end);
	end;
end;
v12.mainGui.LeftPanel.Craft.SearchBar.Changed:connect(function(p13)
	if p13 == "Text" then
		if v12.mainGui.LeftPanel.Craft.SearchBar.Text == "" then
			v12.DrawCraftMenu("all");
			return;
		end;
		local l__next__45 = next;
		local v46, v47 = v12.mainGui.LeftPanel.Craft.Selection:GetChildren();
		while true do
			local v48, v49 = l__next__45(v46, v47);
			if not v48 then
				break;
			end;
			v47 = v48;
			if v49:IsA("ImageButton") then
				v49.BackgroundColor3 = v14.ironGrey;
			end;		
		end;
		v12.DrawCraftMenu("all", v12.mainGui.LeftPanel.Craft.SearchBar.Text);
	end;
end);
local l__next__50 = next;
local v51, v52 = v12.mainGui.RightPanel.Inventory.Selection:GetChildren();
while true do
	local v53, v54 = l__next__50(v51, v52);
	if not v53 then
		break;
	end;
	v52 = v53;
	if v54:IsA("ImageButton") then
		v54.InputBegan:connect(function(p14, p15)
			if v12.InteractInput(p14, p15) then
				v54.ActiveImage.Visible = true;
				local l__next__55 = next;
				local v56, v57 = v12.mainGui.RightPanel.Inventory.Selection:GetChildren();
				while true do
					local v58, v59 = l__next__55(v56, v57);
					if not v58 then
						break;
					end;
					v57 = v58;
					if v59:IsA("ImageButton") and v59 ~= v54 then
						v59.ActiveImage.Visible = false;
					end;				
				end;
				v12.DrawInventory(v54.Category.Value);
				v12.lastInventoryCategory = v54.Category.Value;
			end;
		end);
	end;
end;
v12.mainGui.RightPanel.Inventory.RedoAvatarButton.InputBegan:connect(function(p16, p17)
	if v12.InteractInput(p16, p17) then
		l__ReplicatedStorage__2.Events.RedoAvatar:FireServer();
	end;
end);
local l__next__60 = next;
local v61, v62 = v12.mainGui.LeftPanel.Shop.Parchment.Container.Lists.ChestList:GetChildren();
while true do
	local v63, v64 = l__next__60(v61, v62);
	if not v63 then
		break;
	end;
	v62 = v63;
	if v64:IsA("Frame") then
		v64.OpenButton.InputBegan:connect(function(p18, p19)
			if v12.InteractInput(p18, p19) then
				if v64.OpenButton.Text == "OPEN" then
					l__ReplicatedStorage__2.Events.ChestDrop:FireServer(v64.Name);
					return;
				end;
			else
				return;
			end;
			v12.CreateNotification("You have 0 " .. v64.Name .. "s", Color3.fromRGB(255, 255, 255), 3);
		end);
		v64.BuyButton.InputBegan:connect(function(p20, p21)
			if v12.InteractInput(p20, p21) then
				l__ReplicatedStorage__2.Events.PurchaseChest:FireServer(v64.Name);
			end;
		end);
	end;
end;
local l__next__65 = next;
local v66, v67 = v12.mainGui.LeftPanel.Shop.Parchment.Container.Selection:GetChildren();
while true do
	local v68, v69 = l__next__65(v66, v67);
	if not v68 then
		break;
	end;
	v67 = v68;
	if v69:IsA("ImageButton") then
		v69.InputBegan:connect(function(p22, p23)
			if v12.InteractInput(p22, p23) then
				local l__next__70 = next;
				local v71, v72 = v12.mainGui.LeftPanel.Shop.Parchment.Container.Lists:GetChildren();
				while true do
					local v73, v74 = l__next__70(v71, v72);
					if not v73 then
						break;
					end;
					v72 = v73;
					if v74:IsA("Frame") or v74:IsA("ScrollingFrame") then
						if v74 ~= v69.Pointer.Value then
							v74.Visible = false;
						else
							v74.Visible = true;
						end;
					end;				
				end;
				local l__next__75 = next;
				local v76, v77 = v12.mainGui.LeftPanel.Shop.Parchment.Container.Selection:GetChildren();
				while true do
					local v78, v79 = l__next__75(v76, v77);
					if not v78 then
						break;
					end;
					v77 = v78;
					if v79:IsA("ImageButton") then
						if v79 ~= v69 then
							v79.BackgroundColor3 = v14.ironGrey;
						else
							v79.BackgroundColor3 = v14.goodGreen;
						end;
					end;				
				end;
			end;
		end);
	end;
end;
v12.mainGui.LeftPanel.Market.SubmitButton.InputBegan:connect(function(p24, p25)
	if v12.InteractInput(p24, p25) then
		local l__Value__80 = v12.mainGui.LeftPanel.Market.Selected.Value;
		local l__Value__81 = v12.mainGui.LeftPanel.Market.SelectedQuantity.Value;
		local l__Value__82 = v12.mainGui.LeftPanel.Market.GoldQuantity.Value;
		if l__Value__80 and l__Value__81 >= 1 and l__Value__82 >= 1 then
			l__ReplicatedStorage__2.Events.SubmitTrade:FireServer(l__Value__80, l__Value__81, l__Value__82);
			return;
		end;
		v12.CreateNotification("Complete the form!", v14.badRed, 3);
	end;
end);
v12.mainGui.LeftPanel.Market.SearchBar.Changed:connect(function()
	if #v12.mainGui.LeftPanel.Market.SearchBar.Text then
		local l__next__83 = next;
		local v84, v85 = v12.mainGui.LeftPanel.Market.Lists.AllList:GetChildren();
		while true do
			local v86, v87 = l__next__83(v84, v85);
			if not v86 then
				break;
			end;
			v85 = v86;
			if v87:IsA("Frame") then
				if not v87.Name:lower():match(v12.mainGui.LeftPanel.Market.SearchBar.Text:lower()) then
					v87.Visible = false;
				else
					v87.Visible = true;
				end;
			end;		
		end;
	end;
end);
v12.mainGui.LeftPanel.Market.GoldTextBox.Changed:connect(function()
	local l__Text__88 = v12.mainGui.LeftPanel.Market.GoldTextBox.Text;
	if l__Text__88 then
		local v89 = "";
		for v90 = 1, #l__Text__88 do
			local v91 = string.sub(l__Text__88, v90, v90);
			if tonumber(v91) then
				v89 = v89 .. v91;
			end;
		end;
		v12.mainGui.LeftPanel.Market.GoldQuantity.Value = tonumber(v89);
	end;
end);
v12.mainGui.LeftPanel.Market.HowManyTextBox.Changed:connect(function()
	local l__Text__92 = v12.mainGui.LeftPanel.Market.HowManyTextBox.Text;
	if l__Text__92 then
		local v93 = "";
		for v94 = 1, #l__Text__92 do
			local v95 = string.sub(l__Text__92, v94, v94);
			if tonumber(v95) then
				v93 = v93 .. v95;
			end;
		end;
		v12.mainGui.LeftPanel.Market.SelectedQuantity.Value = tonumber(v93);
	end;
end);
workspace.Characters.ChildAdded:connect(function(p26)
	if game.Players:FindFirstChild(p26.Name) ~= l__LocalPlayer__22 then
		if _G.hideOthers then
			wait(0.3333333333333333);
			v12.PhaseCharacter(p26, false);
		end;
		if _G.Data.userSettings.streamerMode then
			v12.SetStreamerModeOnNametag(p26);
		end;
	end;
end);
l__RunService__1.Heartbeat:Connect(function(p27)
	if l__UserInputService__3:IsKeyDown(Enum.KeyCode.R) then
		local v96 = 1;
	else
		v96 = l__UserInputService__3:IsKeyDown(Enum.KeyCode.Q) or -1;
	end;
	if v96 then
		if v12.mouseBoundStructure or v12.dragObject then
			v12.buildingRotation = v12.buildingRotation - 360 * v96 * p27;
		end;
		if v12.dragObject then
			v12.dragObject.CFrame = CFrame.new(v12.dragObject.CFrame.p) * CFrame.Angles(0, v12.buildingRotation, 0);
			v12.dragObject.Velocity = Vector3.new(0, 0, 0);
		end;
	end;
end);
local u1 = {};
local l__CombatStopwatch__2 = v12.mainGui.Panels.Toolbar.Stats.PlayerStats.CombatStopwatch;
l__RunService__1.RenderStepped:connect(function(p28)
	for v97, v98 in next, u1 do
		if os.time() - u1[v97].age > 10 then
			u1[v97].object:Destroy();
			table.remove(u1, v97);
		else
			local v99 = nil;
			local l__position__100 = u1[v97].position;
			u1[v97].velocity = v98.velocity + v98.acceleration * p28;
			u1[v97].position = v98.position + v98.velocity * p28;
			v99 = u1[v97].position - l__position__100;
			if u1[v97].object:IsA("Model") then
				u1[v97].object:SetPrimaryPartCFrame(CFrame.new(u1[v97].position, u1[v97].position + v99));
			else
				u1[v97].object.CFrame = CFrame.new(u1[v97].position, u1[v97].position + v99);
			end;
			local v101, v102, v103, v104 = workspace:FindPartOnRay(Ray.new(l__position__100, u1[v97].position - l__position__100), u1[v97].object);
			if not (not v101) and v101.Transparency < 1 or v101 == workspace.Terrain and not v104 == Enum.Material.Water then
				if u1[v97].owned then
					l__ReplicatedStorage__2.Events.ProjectileImpact:FireServer(v101, v102, u1[v97].guid, (l__LocalPlayer__22.Character.PrimaryPart.Position - v102).magnitude);
					local v105 = nil;
					local v106 = v101;
					while true do
						if v106:GetAttribute("EntityHealth") then
							v105 = true;
							break;
						end;
						v106 = v106.Parent;
						if v105 then
							break;
						end;
						if not v106:IsDescendantOf(workspace) then
							break;
						end;					
					end;
					local l__next__107 = next;
					local v108, v109 = game.Players:GetPlayers();
					while true do
						local v110, v111 = l__next__107(v108, v109);
						if not v110 then
							break;
						end;
						v109 = v110;
						if v111 ~= game.Players.LocalPlayer and v111.Character and v101:IsDescendantOf(v111.Character) then
							v105 = true;
						end;					
					end;
					if v105 then
						v12.CreateSound(l__ReplicatedStorage__2.Sounds.Quicks.HitMarker, l__PlayerGui__26);
					end;
				end;
				l__Debris__5:AddItem(u1[v97].object, 2);
				u1[v97].object.Transparency = 1;
				table.remove(u1, v97);
			end;
		end;
	end;
	if not (l__ReplicatedStorage__2.RelativeTime.Value - _G.Data.lastCombat < 10) or _G.Data.lastCombat == 0 then
		l__CombatStopwatch__2.Visible = false;
		return;
	end;
	l__CombatStopwatch__2.Visible = true;
	l__CombatStopwatch__2.Pivot.Rotation = math.round(l__ReplicatedStorage__2.RelativeTime.Value - _G.Data.lastCombat) / 10 * 360;
	l__CombatStopwatch__2.Countdown.Text = 10 - math.round(l__ReplicatedStorage__2.RelativeTime.Value - _G.Data.lastCombat);
end);
l__ReplicatedStorage__2.Events.CreateProjectile.OnClientEvent:connect(function(p29)
	MakeProjectile(p29.toolName, p29.originCF, p29.drawStrength, p29.owner);
end);
function MakeProjectile(p30, p31, p32, p33)
	local v112 = l__ReplicatedStorage__2.Projectiles:FindFirstChild(v15[p30].projectileName):Clone();
	local v113 = game:GetService("HttpService"):GenerateGUID();
	v112.CFrame = p31;
	local v114 = {
		origin = p31.p, 
		position = p31.p, 
		velocity = p31.lookVector * math.clamp(v15[p30].velocityMagnitude * p32, 100, 500), 
		acceleration = Vector3.new(0, -156.2, 0), 
		age = os.time(), 
		toolName = p30, 
		object = v112, 
		guid = v113
	};
	if 50 < (l__mouse__23.hit.p - _G.root.Position).magnitude then
		v114.velocity = v114.velocity + Vector3.new(0, 15, 0);
	end;
	v114.owned = p33 and false;
	u1[#u1 + 1] = v114;
	v112.Parent = workspace;
	if p33 then
		l__ReplicatedStorage__2.Events.CreateProjectile:FireServer({
			originCF = p31, 
			drawStrength = p32, 
			toolName = p30, 
			guid = v113
		});
	end;
end;
local l__next__115 = next;
local v116, v117 = l__SpawnGui__27.Customization.Appearance.HairFrame:GetChildren();
while true do
	local v118, v119 = l__next__115(v116, v117);
	if not v118 then
		break;
	end;
	v117 = v118;
	if v119:IsA("ImageButton") then
		v119.InputBegan:connect(function(p34, p35)
			if v12.InteractInput(p34, p35) then
				_G.Data.appearance.hair = v119.Name;
				l__ReplicatedStorage__2.Events.CosmeticChange:FireServer("hair", v119.Name);
			end;
		end);
	end;
end;
l__SpawnGui__27.TestServer.TextButton.Activated:connect(function(p36, p37)
	game.ReplicatedStorage.Events.TeleportToTestServer:FireServer();
end);
local l__next__120 = next;
local v121, v122 = l__SpawnGui__27.Customization.Appearance.GenderFrame:GetChildren();
while true do
	local v123, v124 = l__next__120(v121, v122);
	if not v123 then
		break;
	end;
	v122 = v123;
	if v124:IsA("GuiButton") then
		v124.Activated:connect(function()
			print("asking server to change gender please");
			l__ReplicatedStorage__2.Events.CosmeticChange:FireServer("gender", v124.GenderValue.Value);
		end);
	end;
end;
local l__next__125 = next;
local v126, v127 = l__SpawnGui__27.Customization.Appearance.SkinFrame:GetChildren();
while true do
	local v128, v129 = l__next__125(v126, v127);
	if not v128 then
		break;
	end;
	v127 = v128;
	if v129:IsA("ImageButton") then
		v129.InputBegan:connect(function(p38, p39)
			if v12.InteractInput(p38, p39) then
				_G.Data.appearance.skin = v129.Name;
				l__ReplicatedStorage__2.Events.CosmeticChange:FireServer("skin", v129.Name);
			end;
		end);
	end;
end;
local l__next__130 = next;
local v131, v132 = l__SpawnGui__27.Customization.Appearance.FaceFrame:GetChildren();
while true do
	local v133, v134 = l__next__130(v131, v132);
	if not v133 then
		break;
	end;
	v132 = v133;
	if v134:IsA("ImageButton") then
		v134.InputBegan:connect(function(p40, p41)
			if v12.InteractInput(p40, p41) then
				_G.Data.appearance.face = v134.Name;
				l__ReplicatedStorage__2.Events.CosmeticChange:FireServer("face", v134.Name);
			end;
		end);
	end;
end;
l__SpawnGui__27.PlayButton.Activated:connect(function(p42, p43)
	_G.Data.hasSpawned = true;
	_G.cam.CameraType = Enum.CameraType.Custom;
	_G.hideOthers = false;
	v12.ToggleOtherCharacters(true);
	l__ReplicatedStorage__2.Events.SpawnFirst:FireServer();
end);
local l__next__135 = next;
local v136, v137 = v12.GetNavigationButtons();
while true do
	local v138, v139 = l__next__135(v136, v137);
	if not v138 then
		break;
	end;
	v137 = v138;
	v139.Activated:connect(function()
		v12.OpenGui(v139);
	end);
end;
local l__next__140 = next;
local v141, v142 = v12.mainGui.Panels.Toolbar.List:GetChildren();
while true do
	local v143, v144 = l__next__140(v141, v142);
	if not v143 then
		break;
	end;
	v142 = v143;
	if v144:IsA("ImageButton") then
		v144.DragBegin:connect(function(p44)
			ghost = v144.ItemIcon:Clone();
			ghost.ZIndex = 999;
			ghost.Size = UDim2.new(0, v144.AbsoluteSize.X, 0, v144.AbsoluteSize.Y);
			ghost.AnchorPoint = Vector2.new(0.5, 0.5);
			ghost.Parent = v12.mainGui.TempEffects;
			while ghost do
				l__RunService__1.RenderStepped:wait();
				ghost.Position = UDim2.new(0, l__mouse__23.X, 0, l__mouse__23.Y);			
			end;
		end);
		v144.DragStopped:connect(function(p45, p46)
			if ghost then
				ghost:Destroy();
			end;
			local v145 = nil;
			local l__next__146 = next;
			local v147, v148 = v12.mainGui.Panels.Toolbar.List:GetChildren();
			while true do
				local v149, v150 = l__next__146(v147, v148);
				if not v149 then
					break;
				end;
				v148 = v149;
				if v150:IsA("ImageButton") and v150.AbsolutePosition.X <= p45 and p45 <= v150.AbsolutePosition.X + v150.AbsoluteSize.X and v150.AbsolutePosition.Y <= p46 and p46 <= v150.AbsolutePosition.Y + v150.AbsoluteSize.Y then
					v145 = v150;
					break;
				end;			
			end;
			if v145 == v144 then
				l__ReplicatedStorage__2.Events.EquipTool:FireServer(tonumber(v144.Name));
				_G.Data.equipped = tonumber(v144.Name);
				v12.mainGui.Subordinates.Notifications.ToolbarHeader.Visible = true;
				v12.mainGui.Subordinates.Notifications.ToolbarHeader.TextLabel.Text = string.upper(_G.Data.toolbar[_G.Data.equipped].name);
				l__ReplicatedStorage__2.Sounds.Quicks.ToolSwitch:Play();
				return;
			end;
			if v145 and v145 ~= v144 then
				l__ReplicatedStorage__2.Events.ToolSwap:FireServer(tonumber(v144.Name), tonumber(v145.Name));
				return;
			end;
			l__ReplicatedStorage__2.Sounds.Quicks.Click1:Play();
			if l__mouse__23.X < _G.cam.ViewportSize.X * 0.75 and l__mouse__23.Y < _G.cam.ViewportSize.Y * 0.9 then
				l__ReplicatedStorage__2.Events.DropBagItem:FireServer(tonumber(v144.Name));
				return;
			end;
			if not (_G.cam.ViewportSize.X * 0.75 < l__mouse__23.X) or not (l__mouse__23.Y < _G.cam.ViewportSize.Y * 0.9) then
				return;
			end;
			if v12.mainGui.RightPanel.Inventory.Visible then
				l__ReplicatedStorage__2.Events.Retool:FireServer(tonumber(v144.Name));
				return;
			end;
			l__ReplicatedStorage__2.Events.DropBagItem:FireServer(tonumber(v144.Name));
		end);
		v144.InputBegan:connect(function(p47, p48)
			if p48 then
				return;
			end;
			if p47.UserInputType == Enum.UserInputType.MouseButton2 and v12.GetDictionaryLength(_G.Data.toolbar[tonumber(v144.Name)]) > 0 then
				l__ReplicatedStorage__2.Events.Retool:FireServer(tonumber(v144.Name));
			end;
		end);
	end;
end;
function lerp(p49, p50, p51)
	return p49 * (1 - p51) + p50 * p51;
end;
function ScanArray(p52, p53)
	local l__next__151 = next;
	local v152 = nil;
	while true do
		local v153, v154 = l__next__151(p52, v152);
		if v153 then

		else
			break;
		end;
		v152 = v153;
		if v154 == p53 then
			return false;
		end;	
	end;
	return true;
end;
function PartsAlongRay(p54)
	local v155 = {};
	while true do
		local v156, v157 = workspace:FindPartOnRayWithIgnoreList(p54, v155);
		if v156 ~= workspace.Terrain then
			v155[#v155 + 1] = v156;
		end;
		if v156 then

		else
			break;
		end;
		if v156 ~= workspace.Terrain then

		else
			break;
		end;	
	end;
	return v155;
end;
local v158 = coroutine.wrap(function()
	local u3 = tick();
	l__ReplicatedStorage__2.Events.Pinger.OnClientInvoke = function()
		u3 = tick();
		return tick() - u3;
	end;
	while wait(1) do
		local v159 = l__ReplicatedStorage__2.Events.Pinger:InvokeServer();
		ping = math.clamp(l__ReplicatedStorage__2.RelativeTime.Value - l__ReplicatedStorage__2.RelativeTime.Value, 0, 0.3);	
	end;
end);
local u4 = nil;
function DragFunction()
	if not u4 then
		u4 = Instance.new("BodyPosition");
		u4.Parent = v12.dragObject;
		u4.P = 25000;
		u4.D = 1500;
		u4.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
		u4.AncestryChanged:connect(function()
			if u4 then
				if not u4.Parent then
					u4 = nil;
				end;
			else
				u4 = nil;
			end;
		end);
	end;
	if v12.dragObject then
		if u4 then
			if v12.dragObject.Parent then
				if v12.dragObject.Parent:IsA("Model") then
					if v12.dragObject.Parent ~= workspace then
						l__mouse__23.TargetFilter = v12.dragObject.Parent;
					else
						l__mouse__23.TargetFilter = v12.dragObject;
					end;
				else
					l__mouse__23.TargetFilter = v12.dragObject;
				end;
			else
				l__mouse__23.TargetFilter = v12.dragObject;
			end;
			if not v12.dragObject:FindFirstChild("Draggable") then
				if v12.dragObject.Parent then
					if v12.dragObject.Parent:FindFirstChild("Draggable") then
						local v160 = Ray.new(_G.root.Position, (l__mouse__23.Hit.p - _G.root.Position).unit * math.clamp((_G.root.Position - l__mouse__23.Hit.p).magnitude, 3, 30));
						local v161, v162 = workspace:FindPartOnRayWithIgnoreList(v160, PartsAlongRay(v160));
						u4.Position = v162 + Vector3.new(0, v12.dragObject.Size.Y / 2, 0);
					end;
				end;
			else
				v160 = Ray.new(_G.root.Position, (l__mouse__23.Hit.p - _G.root.Position).unit * math.clamp((_G.root.Position - l__mouse__23.Hit.p).magnitude, 3, 30));
				v161, v162 = workspace:FindPartOnRayWithIgnoreList(v160, PartsAlongRay(v160));
				u4.Position = v162 + Vector3.new(0, v12.dragObject.Size.Y / 2, 0);
			end;
		end;
	end;
end;
local u5 = false;
local u6 = 0;
function SwingTool()
	if _G.Data.equipped then
		if u5 then
			u5 = false;
			return;
		end;
		if v15[_G.Data.toolbar[_G.Data.equipped].name].speed <= l__ReplicatedStorage__2.RelativeTime.Value - _G.Data.toolbar[_G.Data.equipped].lastSwing then
			_G.Data.toolbar[_G.Data.equipped].lastSwing = l__ReplicatedStorage__2.RelativeTime.Value;
			local l__name__163 = _G.Data.toolbar[_G.Data.equipped].name;
			local v164 = v15[_G.Data.toolbar[_G.Data.equipped].name];
			if v164.toolType == "ranged" then

			else
				local v165, v166, v167 = CFrame.lookAt(_G.root.Position, l__mouse__23.Hit.Position):ToEulerAnglesYXZ();
				v25.Size = Vector3.new(6, 11, 5);
				v25.CFrame = CFrame.new(_G.root.Position) * CFrame.Angles(0, v166, 0) * CFrame.new(0, -2, -v25.Size.Z / 2);
				v25.Parent = _G.char;
				v25.Parent = nil;
				local v168 = {};
				local l__next__169 = next;
				local v170 = v25:GetTouchingParts();
				local v171 = nil;
				while true do
					local v172, v173 = l__next__169(v170, v171);
					if v172 then

					else
						break;
					end;
					v171 = v172;
					if not v173:IsDescendantOf(_G.char) then
						if v173 == workspace.Terrain then

						else
							v168[#v168 + 1] = v173;
						end;
					end;				
				end;
				if v15[_G.Data.toolbar[_G.Data.equipped].name].useType == "Slash" then
					l__ReplicatedStorage__2.Events.SwingTool:FireServer(l__ReplicatedStorage__2.RelativeTime.Value, v168);
					_G.anims[v15[_G.Data.toolbar[_G.Data.equipped].name].useType]:Play();
					return;
				elseif v15[_G.Data.toolbar[_G.Data.equipped].name].useType == "Horn" then
					_G.anims[v15[_G.Data.toolbar[_G.Data.equipped].name].useType]:Play();
					l__ReplicatedStorage__2.Events.MusicTool:FireServer(l__ReplicatedStorage__2.RelativeTime.Value);
					return;
				elseif v15[_G.Data.toolbar[_G.Data.equipped].name].useType == "Target" then
					local v174 = _G.cam:ScreenPointToRay(l__mouse__23.X, l__mouse__23.Y);
					l__ReplicatedStorage__2.Events.TargetTool:FireServer(l__ReplicatedStorage__2.RelativeTime.Value, v12.FirstPartOnRay(Ray.new(v174.Origin, v174.Direction * 2000), _G.cam));
					return;
				else
					if v15[_G.Data.toolbar[_G.Data.equipped].name].useType == "Rod" then
						local v175 = _G.cam:ScreenPointToRay(l__mouse__23.X, l__mouse__23.Y);
						l__ReplicatedStorage__2.Events.RodSwing:FireServer(l__ReplicatedStorage__2.RelativeTime.Value, (Ray.new(v175.Origin, v175.Direction * 2000)));
					end;
					return;
				end;
			end;
			if not v12.HasItem(v164.projectileName) then
				v12.CreateNotification("No ammo!", v14.badRed, 2);
				return;
			end;
			v12.activateHeld = true;
			local l__next__176 = next;
			local v177, v178 = _G.char:WaitForChild(l__name__163):GetChildren();
			while true do
				local v179, v180 = l__next__176(v177, v178);
				if v179 then

				else
					break;
				end;
				v178 = v179;
				if v180.Name == "Draw" then
					v180.Transparency = 0;
				elseif v180.Name == "Rest" then
					v180.Transparency = 1;
				end;			
			end;
			if v164.pullSound then
				v12.CreateSound(l__ReplicatedStorage__2.Sounds.ToolSounds[l__name__163].Pullback, _G.root);
			end;
			u6 = 0;
			if l__UserInputService__3.MouseEnabled then
				if v15[l__name__163].drawAnim then
					_G.anims[v15[l__name__163].drawAnim]:Play(v15[l__name__163].drawAnim.drawAnimLength);
				end;
				v12.mainGui.PowerMeter.Visible = true;
				game:GetService("RunService"):BindToRenderStep("BindPowerMeter", 1, function()
					u6 = math.clamp(u6 + 0.025, 0, v15[l__name__163].drawLength);
					_G.cam.FieldOfView = 65 - u6 * 2;
					_G.hum.WalkSpeed = v12.currentWalkSpeed - u6 * 10;
					v12.mainGui.PowerMeter.Position = UDim2.new(0, l__mouse__23.X, 0, l__mouse__23.Y) + UDim2.new(0, -30, 0, 0);
					v12.mainGui.PowerMeter.Slider.Size = UDim2.new(1, 0, u6 / v15[l__name__163].drawLength, 0);
				end);
				while true do
					if v12.activateHeld then

					else
						break;
					end;
					if l__RunService__1.RenderStepped:wait() then

					else
						break;
					end;				
				end;
				game:GetService("RunService"):UnbindFromRenderStep("BindPowerMeter");
				v12.mainGui.PowerMeter.Visible = false;
			elseif l__UserInputService__3.TouchEnabled then
				if v15[l__name__163].drawAnim then
					_G.anims[v15[l__name__163].drawAnim]:Play(v15[l__name__163].drawAnim, 0);
					_G.anims[v15[l__name__163].drawAnim]:Stop(v15[l__name__163].drawAnim, 3);
				end;
				v12.activateHeld = false;
				u6 = v15[l__name__163].drawLength;
			end;
			_G.Data.toolbar[_G.Data.equipped].lastSwing = l__ReplicatedStorage__2.RelativeTime.Value;
			v12.CreateSound(l__ReplicatedStorage__2.Sounds.ToolSounds[l__name__163].Fire, _G.root);
			local v181, v182 = v12.CursorRay();
			MakeProjectile(l__name__163, CFrame.new((_G.root.CFrame * CFrame.new(1.4, -0.4, -3)).p, v182), u6 / v15[l__name__163].drawLength, true);
			u6 = 0;
			_G.cam.FieldOfView = 65;
			local l__next__183 = next;
			local v184, v185 = _G.char:WaitForChild(l__name__163):GetChildren();
			while true do
				local v186, v187 = l__next__183(v184, v185);
				if v186 then

				else
					break;
				end;
				v185 = v186;
				if v187.Name == "Draw" then
					v187.Transparency = 1;
				elseif v187.Name == "Rest" then
					v187.Transparency = 0;
				end;			
			end;
			if v15[l__name__163].drawAnim then
				_G.anims[v15[l__name__163].drawAnim]:Stop(v15[l__name__163].drawAnimSlow);
			end;
			if v164.postFireSound then
				v12.CreateSound(l__ReplicatedStorage__2.Sounds.ToolSounds[l__name__163].PostFire, _G.root);
				return;
			end;
		end;
	end;
end;
l__UserInputService__3.TouchEnded:connect(function(p55, p56)
	if not p56 then
		SwingTool();
	end;
	if not v12.draggingIcon then
		return;
	end;
	if l__mouse__23.X < _G.cam.ViewportSize.X * 0.75 then
		l__ReplicatedStorage__2.Events.DropBagItem:FireServer(v12.draggingIcon.Name);
		v12.draggingIcon:Destroy();
		v12.draggingIcon = nil;
		return;
	end;
	local v188 = nil;
	for v189, v190 in next, v12.mainGui.RightPanel.Inventory.List:GetChildren() do
		if v190:IsA("ImageLabel") and v190.AbsolutePosition.X <= l__mouse__23.X and l__mouse__23.X <= v190.AbsolutePosition.X + v190.AbsoluteSize.X and v190.AbsolutePosition.Y <= l__mouse__23.Y and l__mouse__23.Y <= v190.AbsolutePosition.Y + v190.AbsoluteSize.Y then
			v188 = v190;
			break;
		end;
	end;
	if v188 and v188.Name == v12.draggingIcon.Name then
		if v15[v12.draggingIcon.name].nourishment then
			v12.CreateSound(l__ReplicatedStorage__2.Sounds.Quicks.Eat, l__LocalPlayer__22.PlayerGui, true);
		end;
		l__ReplicatedStorage__2.Events.UseBagItem:FireServer(v12.draggingIcon.Name);
	end;
	v12.draggingIcon:Destroy();
	v12.draggingIcon = nil;
end);
function PlaceStructureFunction()
	if v12.mouseBoundStructure then
		if l__UserInputService__3.MouseEnabled then

		else
			if l__UserInputService__3.TouchEnabled then
				l__ReplicatedStorage__2.Events.PlaceStructure:FireServer(v12.mouseBoundStructure.Name, v12.mouseBoundStructure.PrimaryPart.CFrame, v12.buildingRotation);
				v12.ClearMouseBoundStructure();
				v12.OpenGui(v12.mainGui.Panels.Card.Bag);
			end;
			return;
		end;
	else
		return;
	end;
	l__ReplicatedStorage__2.Events.PlaceStructure:FireServer(v12.mouseBoundStructure.Name, v12.mouseBoundStructure.PrimaryPart.CFrame, v12.buildingRotation);
	v12.ClearMouseBoundStructure();
	v12.OpenGui(v12.mainGui.Panels.Card.Bag);
end;
l__UserInputService__3.TouchMoved:connect(function(p57, p58)
	if not p58 then
		u5 = true;
	end;
end);
local u7 = {
	eat = Enum.KeyCode.E, 
	toggleBag = Enum.KeyCode.C, 
	toggleTribe = Enum.KeyCode.T, 
	toggleChangelog = Enum.KeyCode.X, 
	toggleShop = Enum.KeyCode.Z, 
	toggleMojo = Enum.KeyCode.K, 
	toggleMailbox = Enum.KeyCode.M, 
	eatFromInventory = Enum.KeyCode.Q
};
local u8 = false;
local u9 = false;
l__UserInputService__3.InputBegan:connect(function(p59, p60)
	if p60 then
		return;
	end;
	local l__KeyCode__191 = p59.KeyCode;
	if p59.UserInputType == Enum.UserInputType.MouseWheel then
		return;
	end;
	if p59.UserInputType == Enum.UserInputType.Gamepad1 then
		if p59.KeyCode == Enum.KeyCode.ButtonA then
			return;
		end;
	elseif p59.UserInputType == Enum.UserInputType.Keyboard then
		local v192 = p59.KeyCode.Value - 48;
		if v192 >= 1 and v192 <= 6 then
			if v192 == _G.Data.equipped or v12.GetDictionaryLength(_G.Data.toolbar[v192]) == 0 then
				for v193, v194 in next, _G.anims do
					v194:Stop();
				end;
				_G.Data.equipped = nil;
			elseif v192 ~= _G.Data.equipped and v12.GetDictionaryLength(_G.Data.toolbar[v192]) > 0 then
				_G.Data.equipped = v192;
				v12.mainGui.Subordinates.Notifications.ToolbarHeader.Visible = true;
				v12.mainGui.Subordinates.Notifications.ToolbarHeader.TextLabel.Text = string.upper(_G.Data.toolbar[_G.Data.equipped].name);
				l__ReplicatedStorage__2.Sounds.Quicks.ToolSwitch:Play();
			end;
			l__ReplicatedStorage__2.Events.EquipTool:FireServer(v192);
			v12.SortToolbar();
			return;
		end;
		if l__KeyCode__191 == u7.toggleBag then
			v12.OpenGui(v12.mainGui.Panels.Card.Bag);
			v12.ClearMouseBoundStructure();
			return;
		end;
		if l__KeyCode__191 == u7.toggleTribe then
			v12.OpenGui(v12.mainGui.Panels.Card.Tribe);
			v12.DrawTribeGui();
			v12.ClearMouseBoundStructure();
			return;
		end;
		if l__KeyCode__191 == u7.toggleShop then
			v12.OpenGui(v12.mainGui.Panels.Card.Shop);
			return;
		end;
		if l__KeyCode__191 == u7.toggleMojo then
			v12.OpenGui(v12.mainGui.Panels.Card.Mojo);
			return;
		end;
		if l__KeyCode__191 == u7.eatFromInventory and _G.Data.userSettings.eatHotkey == true then
			for v195, v196 in next, _G.Data.inventory do
				local l__name__197 = v196.name;
				local v198 = v15[l__name__197];
				if v198.nourishment and v198.nourishment.food > 0 and v198.nourishment.health >= 0 then
					v12.CreateNotification("Ate " .. l__name__197, v14.goodGreen, 2);
					l__ReplicatedStorage__2.Events.UseBagItem:FireServer(l__name__197);
					return;
				end;
			end;
			return;
		end;
	elseif p59.UserInputType == Enum.UserInputType.MouseButton1 or p59.UserInputType == Enum.UserInputType.Touch then
		local v199 = nil;
		local v200 = nil;
		local v201 = nil;
		if not _G.cam then
			return;
		end;
		local v202, v203 = v12.CursorRay(workspace.Terrain);
		if v202 and v202:FindFirstChild("Clicker") then
			v202.Clicker:FireServer();
			return;
		end;
		local v204 = nil;
		if p59.UserInputType == Enum.UserInputType.MouseButton1 then
			v204 = "mouse";
		elseif p59.UserInputType == Enum.UserInputType.Touch then
			v204 = "touch";
		end;
		if v12.mouseBoundStructure then
			if v204 == "mouse" then
				PlaceStructureFunction();
				if l__UserInputService__3:IsKeyDown(Enum.KeyCode.LeftShift) then
					u8 = true;
					return;
				else
					v12.ClearMouseBoundStructure();
					v12.OpenGui(v12.mainGui.Panels.Card.Bag);
					v12.ClearMouseBoundStructure();
					return;
				end;
			else
				return;
			end;
		end;
		if l__mouse__23.Target then
			if l__mouse__23.Target.Parent:FindFirstChild("Interactable") and v12.ObjectWithinStuds(l__mouse__23.Target, 25, _G.root.Position) then
				local v205 = nil;
				local v206 = nil;
				local v207 = nil;
				local v208 = nil;
				local v209 = nil;
				local v210 = nil;
				local v211 = nil;
				local v212 = nil;
				local v213 = nil;
				local v214 = nil;
				local v215 = nil;
				local v216 = nil;
				local v217 = nil;
				local v218 = nil;
				local v219 = nil;
				local v220 = nil;
				local v221 = nil;
				local v222 = nil;
				local v223 = nil;
				local v224 = nil;
				local v225 = nil;
				local v226 = nil;
				local v227 = nil;
				local v228 = nil;
				local v229 = nil;
				local v230 = nil;
				local v231 = nil;
				local v232 = nil;
				local v233 = nil;
				local v234 = nil;
				local v235 = nil;
				local v236 = nil;
				local v237 = nil;
				local v238 = nil;
				local v239 = nil;
				local v240 = nil;
				local v241 = nil;
				local v242 = nil;
				local v243 = nil;
				local v244 = nil;
				local v245 = nil;
				local v246 = nil;
				local v247 = nil;
				local v248 = nil;
				local v249 = nil;
				local v250 = nil;
				if v12.selectionTarget then
					if v12.selectionTarget == l__mouse__23.Target.Parent then
						if l__PlayerGui__26:FindFirstChild(v12.selectionTarget.Name) then
							l__PlayerGui__26:FindFirstChild(v12.selectionTarget.Name):Destroy();
							v12.selectionTarget = nil;
						end;
						return;
					else
						if l__PlayerGui__26:FindFirstChild(v12.selectionTarget.Name) then
							l__PlayerGui__26:FindFirstChild(v12.selectionTarget.Name):Destroy();
							v12.selectionTarget = nil;
						end;
						v212 = v12;
						v205 = l__mouse__23;
						v206 = "Target";
						v207 = v205;
						v208 = v206;
						v209 = v207[v208];
						local v251 = "Parent";
						v210 = v209;
						v211 = v251;
						v213 = v210[v211];
						local v252 = "selectionTarget";
						v214 = v212;
						v215 = v252;
						v216 = v213;
						v214[v215] = v216;
						local v253 = v12;
						local v254 = "CreateSound";
						v217 = v253;
						v218 = v254;
						local v255 = v217[v218];
						v219 = l__ReplicatedStorage__2;
						local v256 = "Sounds";
						v220 = v219;
						v221 = v256;
						local v257 = v220[v221];
						local v258 = "Quicks";
						v222 = v257;
						v223 = v258;
						local v259 = v222[v223];
						local v260 = "ToggleUI";
						v224 = v259;
						v225 = v260;
						local v261 = v224[v225];
						local v262 = l__LocalPlayer__22;
						local v263 = "PlayerGui";
						v226 = v262;
						v227 = v263;
						local v264 = v226[v227];
						v228 = v255;
						v229 = v261;
						v230 = v264;
						v228(v229, v230);
						local v265 = l__ReplicatedStorage__2;
						local v266 = "Guis";
						v231 = v265;
						v232 = v266;
						local v267 = v231[v232];
						v233 = l__mouse__23;
						local v268 = "Target";
						v234 = v233;
						v235 = v268;
						local v269 = v234[v235];
						local v270 = "Parent";
						v236 = v269;
						v237 = v270;
						local v271 = v236[v237];
						local v272 = "Name";
						v238 = v271;
						v239 = v272;
						local v273 = v238[v239];
						local v274 = "FindFirstChild";
						v240 = v267;
						local v275 = v240;
						v241 = v267;
						v242 = v274;
						local v276 = v241[v242];
						v243 = v276;
						v244 = v275;
						v245 = v273;
						local v277 = v243(v244, v245);
						v246 = v277;
						if v246 then
							v277 = v277:Clone();
						end;
						v247 = v277;
						if v247 then
							v277.Parent = l__PlayerGui__26;
							v277.Adornee = l__mouse__23.Target.Parent.PrimaryPart;
							v277.Frame.List.Exit.MouseButton1Down:connect(function()
								v12.selectionTarget = nil;
								v277:Destroy();
							end);
						end;
						local v278 = v12;
						local v279 = "UpdateBillboards";
						v248 = v278;
						v249 = v279;
						local v280 = v248[v249];
						v250 = v280;
						v250();
						return;
					end;
				else
					v212 = v12;
					v205 = l__mouse__23;
					v206 = "Target";
					v207 = v205;
					v208 = v206;
					v209 = v207[v208];
					v251 = "Parent";
					v210 = v209;
					v211 = v251;
					v213 = v210[v211];
					v252 = "selectionTarget";
					v214 = v212;
					v215 = v252;
					v216 = v213;
					v214[v215] = v216;
					v253 = v12;
					v254 = "CreateSound";
					v217 = v253;
					v218 = v254;
					v255 = v217[v218];
					v219 = l__ReplicatedStorage__2;
					v256 = "Sounds";
					v220 = v219;
					v221 = v256;
					v257 = v220[v221];
					v258 = "Quicks";
					v222 = v257;
					v223 = v258;
					v259 = v222[v223];
					v260 = "ToggleUI";
					v224 = v259;
					v225 = v260;
					v261 = v224[v225];
					v262 = l__LocalPlayer__22;
					v263 = "PlayerGui";
					v226 = v262;
					v227 = v263;
					v264 = v226[v227];
					v228 = v255;
					v229 = v261;
					v230 = v264;
					v228(v229, v230);
					v265 = l__ReplicatedStorage__2;
					v266 = "Guis";
					v231 = v265;
					v232 = v266;
					v267 = v231[v232];
					v233 = l__mouse__23;
					v268 = "Target";
					v234 = v233;
					v235 = v268;
					v269 = v234[v235];
					v270 = "Parent";
					v236 = v269;
					v237 = v270;
					v271 = v236[v237];
					v272 = "Name";
					v238 = v271;
					v239 = v272;
					v273 = v238[v239];
					v274 = "FindFirstChild";
					v240 = v267;
					v275 = v240;
					v241 = v267;
					v242 = v274;
					v276 = v241[v242];
					v243 = v276;
					v244 = v275;
					v245 = v273;
					v277 = v243(v244, v245);
					v246 = v277;
					if v246 then
						v277 = v277:Clone();
					end;
					v247 = v277;
					if v247 then
						v277.Parent = l__PlayerGui__26;
						v277.Adornee = l__mouse__23.Target.Parent.PrimaryPart;
						v277.Frame.List.Exit.MouseButton1Down:connect(function()
							v12.selectionTarget = nil;
							v277:Destroy();
						end);
					end;
					v278 = v12;
					v279 = "UpdateBillboards";
					v248 = v278;
					v249 = v279;
					v280 = v248[v249];
					v250 = v280;
					v250();
					return;
				end;
			end;
			if not l__mouse__23.Target:FindFirstChild("Draggable") then
				if l__mouse__23.Target.Parent:FindFirstChild("Draggable") and v12.ObjectWithinStuds(l__mouse__23.Target, 25, _G.root.Position) and v204 == "mouse" and v204 == "mouse" and _G.Data.userSettings.pickupStyle ~= "Click" then
					v12.dragObject = l__mouse__23.Target;
					if l__mouse__23.Target:FindFirstChild("Draggable") then
						v12.RestorePhysicality(v12.dragObject);
						l__ReplicatedStorage__2.Events.ForceInteract:FireServer(v12.dragObject);
					elseif l__mouse__23.Target.Parent:FindFirstChild("Draggable") then
						v12.RestorePhysicality(v12.dragObject);
						l__ReplicatedStorage__2.Events.ForceInteract:FireServer(v12.dragObject.Parent);
					end;
					l__ReplicatedStorage__2.Sounds.Quicks.Click3:Play();
					l__RunService__1:BindToRenderStep("Dragger", Enum.RenderPriority.Camera.Value - 1, DragFunction);
					return;
				end;
			elseif v12.ObjectWithinStuds(l__mouse__23.Target, 25, _G.root.Position) and v204 == "mouse" and v204 == "mouse" and _G.Data.userSettings.pickupStyle ~= "Click" then
				v12.dragObject = l__mouse__23.Target;
				if l__mouse__23.Target:FindFirstChild("Draggable") then
					v12.RestorePhysicality(v12.dragObject);
					l__ReplicatedStorage__2.Events.ForceInteract:FireServer(v12.dragObject);
				elseif l__mouse__23.Target.Parent:FindFirstChild("Draggable") then
					v12.RestorePhysicality(v12.dragObject);
					l__ReplicatedStorage__2.Events.ForceInteract:FireServer(v12.dragObject.Parent);
				end;
				l__ReplicatedStorage__2.Sounds.Quicks.Click3:Play();
				l__RunService__1:BindToRenderStep("Dragger", Enum.RenderPriority.Camera.Value - 1, DragFunction);
				return;
			end;
		end;
		if l__mouse__23.Target and (l__mouse__23.Target:FindFirstChild("DoorButton") and v12.ObjectWithinStuds(l__mouse__23.Target, 25, _G.root.Position)) then
			l__ReplicatedStorage__2.Events.ToggleDoor:FireServer(l__mouse__23.Target.Parent);
			return;
		end;
		if l__mouse__23.Target then
			if l__mouse__23.Target:FindFirstChild("OpenGuiPanel") and v12.ObjectWithinStuds(l__mouse__23.Target, 25, _G.root.Position) then
				v12.OpenGui(v12.mainGui.Panels.Card[l__mouse__23.Target.OpenGuiPanel.Value]);
				return;
			end;
			v199 = "mouse";
			v200 = v204;
			v201 = v199;
			if v200 == v201 then
				SwingTool();
				return;
			end;
		else
			v199 = "mouse";
			v200 = v204;
			v201 = v199;
			if v200 == v201 then
				SwingTool();
				return;
			end;
		end;
	elseif p59.UserInputType == Enum.UserInputType.MouseButton2 then
		u9 = true;
	end;
end);
local u10 = 17;
local u11 = 0;
l__UserInputService__3.InputChanged:connect(function(p61, p62)
	if p62 then
		return;
	end;
	if p61.UserInputType == Enum.UserInputType.MouseWheel then
		u10 = math.clamp(u10 + -p61.Position.Z * 6, 12, 80);
		return;
	end;
	if p61.UserInputType == Enum.UserInputType.MouseMovement and u9 then
		u11 = u11 + p61.Delta.X;
	end;
end);
l__UserInputService__3.InputEnded:connect(function(p63, p64)
	if p63.UserInputType == Enum.UserInputType.MouseButton1 then
		v12.activateHeld = false;
		if v12.dragObject then
			v12.dragObject.CanCollide = true;
			v12.dragObject = nil;
			if u4 then
				u4:Destroy();
				u4 = nil;
			end;
			l__mouse__23.TargetFilter = _G.char;
			l__RunService__1:UnbindFromRenderStep("Dragger");
			l__ReplicatedStorage__2.Events.ForceInteract:FireServer();
			return;
		end;
	else
		if p63.UserInputType == Enum.UserInputType.MouseButton2 then
			u9 = false;
			return;
		end;
		if p63.KeyCode == Enum.KeyCode.LeftShift and v12.mouseBoundStructure and (not v12.HasItem(v12.mouseBoundStructure.Name) or u8) then
			u8 = false;
			v12.ClearMouseBoundStructure();
			v12.OpenGui(v12.mainGui.Panels.Card.Bag);
		end;
	end;
end);
local u12 = 0;
l__ReplicatedStorage__2.Events.TargetAcquire.OnClientEvent:connect(function(p65, p66, p67, p68)
	v12.targetGui.Container.Health.Background.Slider.Size = UDim2.new(p68, 0, 1, 0);
	v12.targetGui.Container.Health.HealthLabel.Text = math.ceil(p67);
	if v15[p66] then
		v12.targetGui.Container.Title.Text = v15[p66].alias and p66;
	else
		v12.targetGui.Container.Title.Text = p66;
	end;
	v12.targetGui.Enabled = true;
	v12.targetGui.Adornee = p65;
	if p67 == 0 then
		u12 = l__ReplicatedStorage__2.RelativeTime.Value - math.clamp(2, 1, math.huge);
	else
		u12 = l__ReplicatedStorage__2.RelativeTime.Value;
	end;
	while wait() do
		if l__ReplicatedStorage__2.RelativeTime.Value - u12 >= 2 then
			v12.targetGui.Enabled = false;
			v12.targetGui.Adornee = nil;
			return;
		end;	
	end;
end);
l__ReplicatedStorage__2.Events.ShowAd.OnClientEvent:connect(function()
	local l__Ad__281 = v12.mainGui.Ad;
end);
l__ReplicatedStorage__2.Events.Notify.OnClientEvent:connect(v12.CreateNotification);
l__ReplicatedStorage__2.Events.PromptClient.OnClientInvoke = function(p69)
	return v12.Prompt(p69);
end;
l__ReplicatedStorage__2.Events.AskForDeviceType.OnClientInvoke = function()
	if l__UserInputService__3.MouseEnabled then
		return "pc";
	end;
	if l__UserInputService__3.TouchEnabled then
		return "mobile";
	end;
	if not l__UserInputService__3.GamepadEnabled then
		return;
	end;
	return "gamepad";
end;
local u13 = nil;
local u14 = l__ReplicatedStorage__2.Sounds.Nature.Nature;
local u15 = l__ReplicatedStorage__2.RelativeTime.Value;
local u16 = "";
function CrossfadeTracks(p70, p71)
	if p71 then
		return;
	end;
	u13 = true;
	p70.Volume = 0;
	p70:Play();
	local v282 = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
	l__TweenService__6:Create(u14, v282, {
		Volume = 0
	}):Play();
	local v283 = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
	l__TweenService__6:Create(p70, v282, {
		Volume = p70.MaxVolume.Value
	}):Play();
	if p70.Name == "AncientDespair" then
		local v284 = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
		l__TweenService__6:Create(game.Lighting.Bloom, v282, {
			Intensity = 0.8
		}):Play();
	else
		local v285 = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
		l__TweenService__6:Create(game.Lighting.Bloom, v282, {
			Intensity = 0
		}):Play();
	end;
	wait(6);
	if 60 < l__ReplicatedStorage__2.RelativeTime.Value - u15 then
		if u16 ~= p70 then
			u15 = l__ReplicatedStorage__2.RelativeTime.Value;
			u16 = p70.Name;
			if p70.Name == "Wind" then
				v12.MakeToast({
					title = "YOU:", 
					message = "It's cold up here...", 
					color = v14.brownUI, 
					image = "", 
					duration = 5
				});
			elseif p70.Name == "Cave" then
				v12.MakeToast({
					title = "YOU:", 
					message = "Maybe there are resources down here...", 
					color = v14.brownUI, 
					image = "", 
					duration = 6
				});
			elseif p70.Name == "AncientDespair" then
				v12.MakeToast({
					title = "YOU:", 
					message = "This place is ancient...", 
					color = v14.brownUI, 
					image = "", 
					duration = 6
				});
			end;
		end;
	end;
	u14:Stop();
	u14 = p70;
	u13 = nil;
end;
local u17 = "nature";
coroutine.wrap(function()
	while wait(1) and not u13 and _G.char do
		local v286 = "nature";
		local v287, v288, v289, v290 = workspace:FindPartOnRay(Ray.new(_G.root.Position, Vector3.new(0, 35, 0)), _G.root);
		if _G.root.Position.Y < -15 and v287 and v287 == workspace.Terrain and v290 ~= Enum.Material.Air then
			v286 = "cave";
		end;
		if _G.root.Position.Y < -170 then
			v286 = "deep";
		end;
		if _G.root.Position.Y > 100 then
			v286 = "wind";
		end;
		if v286 ~= u17 then
			local v291 = nil;
			if v286 == "cave" then
				v291 = l__ReplicatedStorage__2.Sounds.Nature.Cave;
			elseif v286 == "nature" then
				v291 = l__ReplicatedStorage__2.Sounds.Nature.Nature;
			elseif v286 == "deep" then
				v291 = l__ReplicatedStorage__2.Sounds.Nature.AncientDespair;
			elseif v286 == "wind" then
				v291 = l__ReplicatedStorage__2.Sounds.Nature.Wind;
			end;
			u17 = v286;
			CrossfadeTracks(v291);
		end;	
	end;
end)();
l__ReplicatedStorage__2.Events.Toast.OnClientEvent:connect(function(p72, p73, p74, p75)
	v12.MakeToast(p72, p73, p74, p75);
end);
l__ReplicatedStorage__2.Events.UpdateAllPlayerList.OnClientEvent:connect(v12.UpdatePlayerList);
workspace.Totems.ChildAdded:connect(function(p76)
	local v292, v293 = v12.IsInTribe();
	while true do
		wait();
		if p76:FindFirstChild("TribeColor") and p76.TribeColor.Value then
			break;
		end;	
	end;
	if v293 and v293.color == p76.TribeColor.Value then
		local v294 = l__ReplicatedStorage__2.Guis.TotemLocator:Clone();
		v294.ImageLabel.ImageColor3 = v14.TribeColors[v293.color];
		v294.Parent = l__PlayerGui__26;
		v294.Adornee = p76.Board;
		wait(1);
		p76.AncestryChanged:connect(function()
			v294:Destroy();
		end);
	end;
end);
l__ReplicatedStorage__2.Events.UpdateTradeData.OnClientEvent:connect(function(p77)
	v12.UpdateTrades(p77);
end);
function PlaySoundAtPosition(p78, p79)
	local v295 = l__ReplicatedStorage__2.Sounds:FindFirstChild(p78, true);
	local v296 = nil;
	if v295:IsA("Sound") then
		v296 = v295:Clone();
	elseif v295:IsA("Folder") then
		local v297 = {};
		local l__next__298 = next;
		local v299 = nil;
		while true do
			local v300, v301 = l__next__298(v295, v299);
			if v300 then

			else
				break;
			end;
			v299 = v300;
			if v301:IsA("Sound") then
				table.insert(v297, v301);
			end;		
		end;
		v296 = v297[math.random(1, #v297)]:Clone();
	end;
	local v302 = Instance.new("Part");
	v302.Transparency = 1;
	v302.Size = Vector3.new(0, 0, 0);
	v302.Anchored = true;
	v302.CanCollide = false;
	v302.Material = Enum.Material.SmoothPlastic;
	v302.Color = Color3.new(1, 1, 1);
	v302.CFrame = CFrame.new(p79);
	v296.Parent = v302;
	v302.Parent = workspace.Effects;
	v296:Play();
	game:GetService("Debris"):AddItem(v302, v296.TimeLength);
end;
l__ReplicatedStorage__2.Events.PlaySoundAtPosition.OnClientEvent:connect(PlaySoundAtPosition);
l__ReplicatedStorage__2.Events.Weather.OnClientEvent:connect(function(p80, p81)
	if p80 == "Rain" then
		v12.MakeItRain(p81);
		return;
	end;
	if p80 == "Shine" then
		v12.SunnyDays(p81);
		return;
	end;
	if p80 == "Doom" then
		v12.DoomWeather(p81);
	end;
end);
l__ReplicatedStorage__2.Events.ReprimandClient.OnClientEvent:connect(function(p82)
	_G.reprimanded = p82;
end);
l__ReplicatedStorage__2.Events.ToggleAnimation.OnClientEvent:connect(function(p83, p84)
	while not _G.anims or not _G.anims[p83] do
		wait();
		if _G.anims and _G.anims[p83] then
			break;
		end;	
	end;
	if p84 == true then
		_G.anims[p83]:Play();
		return;
	end;
	if p84 == false then
		_G.anims[p83]:Stop();
	end;
end);
