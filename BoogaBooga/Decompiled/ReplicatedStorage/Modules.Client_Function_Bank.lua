-- Decompiled with the Synapse X Luau decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__PlayerGui__3 = l__LocalPlayer__2.PlayerGui;
function MakeSelectionBox()
	local v4 = Instance.new("SelectionBox");
	v4.Parent = workspace;
	v4.Color3 = Color3.fromRGB(170, 255, 0);
	return v4;
end;
function format_int(p1)
	local v5, v6, v7, v8, v9 = tostring(p1):find("([-]?)(%d+)([.]?%d*)");
	return v7 .. v8:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. v9;
end;
function GetSpawnLocations()
	local v10 = {};
	local l__next__11 = next;
	local v12, v13 = workspace:WaitForChild("SpawnParts"):GetChildren();
	while true do
		local v14, v15 = l__next__11(v12, v13);
		if v14 then

		else
			break;
		end;
		v13 = v14;
		v10[#v10 + 1] = CFrame.new(v15.CFrame.p);	
	end;
	return v10;
end;
local v16 = {
	mainGui = l__PlayerGui__3:WaitForChild("MainGui"), 
	secondaryGui = l__PlayerGui__3:WaitForChild("SecondaryGui"), 
	targetGui = l__PlayerGui__3:WaitForChild("TargetGui"), 
	spawnGui = l__PlayerGui__3:WaitForChild("SpawnGui"), 
	spawnLocations = GetSpawnLocations(), 
	currentWalkSpeed = 16, 
	selectionBox = MakeSelectionBox(), 
	ghost = nil, 
	activateHeld = true, 
	dragObject = nil, 
	draggingIcon = nil, 
	lastInventoryCategory = "all", 
	currentPrompts = {}, 
	camFocus = nil, 
	busyTags = {}, 
	noteSerializer = 1, 
	maxNotifications = 4, 
	camOffsetMin = nil, 
	camOffsetMax = nil, 
	rayIgnore = {}, 
	lastToast = 0, 
	toastWait = 0, 
	currentToast = 1, 
	lastCraftCategory = "all", 
	lastCraftSearch = nil, 
	mouseBoundStructure = nil, 
	selectionTarget = nil, 
	buildingRotation = 0, 
	char = nil, 
	hum = nil, 
	root = nil, 
	ObjectWithinStuds = function(p2, p3, p4)
		if (p4 - p2.Position).magnitude <= p3 then
			return true;
		end;
		return false;
	end
};
function v16.ToggleUserSettings(p5, p6)
	l__ReplicatedStorage__1.Sounds.Bank:FindFirstChild("Click Knocker"):Play();
	l__ReplicatedStorage__1.Events.ToggleUserSetting:FireServer(p5, p6);
end;
local u1 = nil;
function v16.SetPanelTranslucency()
	local l__next__17 = next;
	local v18, v19 = u1.mainGui:GetDescendants();
	while true do
		local v20, v21 = l__next__17(v18, v19);
		if not v20 then
			break;
		end;
		v19 = v20;
		if v21:GetAttribute("Translucency") then
			if _G.Data.userSettings.panelTranslucency == true then
				local v22 = 0.8;
			else
				v22 = 0;
			end;
			if v21:IsA("ImageLabel") then
				v21.ImageTransparency = v22;
			elseif v21:IsA("Frame") then
				v21.BackgroundTransparency = v22;
			end;
		end;	
	end;
end;
function v16.SetUIScale()
	u1.mainGui.GlobalUIScale.Value = ({
		Small = 0.5, 
		Medium = 0.75, 
		Large = 1
	})[_G.Data.userSettings.uiPanelScale];
end;
function v16.GetStreamerName(p7)
	return "Player_" .. tostring(math.round(p7.UserId * 37 / 2));
end;
function v16.SetStreamerModeOnNametag(p8)
	local v23 = nil;
	local l__NameGui__24 = p8.HumanoidRootPart:WaitForChild("NameGui", 25);
	v23 = game.Players:GetPlayerFromCharacter(p8);
	if l__NameGui__24 then
		if not _G.Data.userSettings.streamerMode then
			l__NameGui__24.TextLabel.Text = v23.Name;
			return;
		end;
	else
		return;
	end;
	l__NameGui__24.TextLabel.Text = u1.GetStreamerName(v23);
end;
function v16.ToggleStreamerMode()
	u1.secondaryGui.Enabled = not _G.Data.userSettings.streamerMode;
	for v25, v26 in pairs(workspace.Characters:GetChildren()) do
		u1.SetStreamerModeOnNametag(v26);
	end;
end;
local u2 = require(l__ReplicatedStorage__1.Modules.UserSettings);
function v16.DrawUserSettings()
	for v27, v28 in pairs(u1.mainGui.LeftPanel.UserSettings.Backdrop.List:GetChildren()) do
		if v28:IsA("GuiBase") then
			v28:Destroy();
		end;
	end;
	local v29, v30, v31 = pairs(u2);
	while true do
		local v32, v33 = v29(v30, v31);
		if not v32 then
			break;
		end;
		local l__name__34 = v33.name;
		local v35 = u1.mainGui.LeftPanel.UserSettings.Templates.Template:Clone();
		local u3 = _G.Data.userSettings[l__name__34] ~= nil and _G.Data.userSettings[l__name__34] or v33.default;
		local u4 = v35.ButtonFrame[v33.interactType];
		local function v36()
			if v33.interactType == "Switch" then
				u4.ImageColor3 = u3 and Color3.fromRGB(170, 255, 0) or Color3.fromRGB(255, 0, 0);
			elseif v33.interactType == "Dropdown" then
				u4.Current.Text = u3;
			end;
			v35.Description.Text = v33.description;
		end;
		for v37, v38 in pairs(v35.ButtonFrame:GetChildren()) do
			if v38 ~= u4 and v38.Name ~= "UIAspectRatioConstraint" then
				v38:Destroy();
			end;
		end;
		if v33.interactType == "Switch" then
			u4.Activated:Connect(function()
				u3 = not u3;
				v36();
				u1.ToggleUserSettings(l__name__34, u3);
			end);
		elseif v33.interactType == "Dropdown" then
			local u5 = nil;
			u4.Dropdown.Activated:Connect(function()
				u5 = not u5;
				u4.Possible.Visible = u5;
				for v39, v40 in pairs(u4.Possible:GetChildren()) do
					if v40:IsA("GuiBase") then
						v40:Destroy();
					end;
				end;
				if u5 then
					for v41, v42 in pairs(v33.possible) do
						local v43 = u1.mainGui.LeftPanel.UserSettings.Templates.DropdownTemplate:Clone();
						v43.Text = v42;
						v43.LayoutOrder = v41;
						v43.Parent = u4.Possible;
						v43.Visible = true;
						v43.Activated:Connect(function()
							u3 = v42;
							v36();
							u1.ToggleUserSettings(l__name__34, u3);
						end);
					end;
				end;
			end);
		end;
		v36();
		v35.Parent = u1.mainGui.LeftPanel.UserSettings.Backdrop.List;
		v35.LayoutOrder = v32 and 1;
		v35.Visible = true;	
	end;
	u1.SetUIScale();
	u1.SetPanelTranslucency();
	u1.ToggleStreamerMode();
end;
local u6 = require(l__ReplicatedStorage__1.Modules.ItemData);
local u7 = require(l__ReplicatedStorage__1.Modules.ColorData);
function v16.DrawCraftMenu(p9, p10)
	local l__next__44 = next;
	local v45, v46 = u1.mainGui.LeftPanel.Craft.List:GetChildren();
	while true do
		local v47, v48 = l__next__44(v45, v46);
		if not v47 then
			break;
		end;
		v46 = v47;
		if v48:IsA("ImageLabel") then
			v48:Destroy();
		end;	
	end;
	local l__next__49 = next;
	local v50 = nil;
	while true do
		local v51, v52 = l__next__49(u6, v50);
		if not v51 then
			break;
		end;
		local v53 = true;
		if not v52.recipe then
			v53 = false;
		end;
		if p9 and p9 ~= "all" and v52.itemType ~= p9 then
			v53 = false;
		end;
		if p10 and not v51:lower():match(p10:lower()) then
			v53 = false;
		end;
		if v53 then
			if v52.craftLevel <= _G.Data.level then
				local v54 = u1.mainGui.LeftPanel.Craft.Templates.ItemFrame:Clone();
				v54.ItemIconBackdrop.ItemIcon.Image = v52.image;
				v54.NameLabel.Text = v51;
				v54.Name = v51;
				local v55 = true;
				local v56 = 0;
				for v57, v58 in next, v52.recipe do
					v56 = v56 + 1;
					local v59 = u1.mainGui.LeftPanel.Craft.Templates.IngredientFrame:Clone();
					v59.ItemIcon.Image = u6[v57].image;
					v59.QuantityImage.QuantityText.Text = v58;
					v59:SetAttribute("MouseHoverText", v57);
					v59.Name = v57;
					local v60 = u1.HasItem(v57);
					if v60 then
						if _G.Data.inventory[v60].quantity and not (v58 <= _G.Data.inventory[v60].quantity) then
							v59.ImageColor3 = u7.badRed;
							v59.ImageTransparency = 0.5;
							v55 = false;
						end;
					else
						v59.ImageColor3 = u7.badRed;
						v59.ImageTransparency = 0.5;
						v55 = false;
					end;
					v59.Parent = v54.IngredientsList;
					v59.Visible = true;
				end;
				if v55 then
					v54.CraftButton.CanCraftImage.Visible = true;
					v54.CraftButton.NoCraftImage.Visible = false;
				else
					v54.CraftButton.CanCraftImage.Visible = false;
					v54.CraftButton.NoCraftImage.Visible = true;
				end;
				v54.CraftButton.InputBegan:connect(function(p11, p12)
					if u1.InteractInput(p11, p12) and u1.CanCraftItem(v51) then
						l__ReplicatedStorage__1.Sounds.Quicks.Click1:Play();
						if not v52.deployable then
							l__ReplicatedStorage__1.Events.CraftItem:FireServer(v51);
							return;
						end;
					else
						return;
					end;
					u1.OpenGui();
					if u1.dragObject then
						u1.dragObject = nil;
					end;
					u1.BindMouseStructure(l__ReplicatedStorage__1.Deployables:FindFirstChild(v51):Clone());
				end);
				v54.LayoutOrder = v52.craftLevel;
				v54.Parent = u1.mainGui.LeftPanel.Craft.List;
				v54.Visible = true;
			else
				local v61 = u1.mainGui.LeftPanel.Craft.Templates.LockedFrame:Clone();
				v61.NameLabel.Text = "locked [" .. v52.craftLevel .. "]";
				v61.SecretTitle.Text = v51;
				v61.ItemIconBackdrop.ItemIcon.Image = v52.image;
				v61.LayoutOrder = 200 + v52.craftLevel;
				v61.Parent = u1.mainGui.LeftPanel.Craft.List;
				v61.Visible = true;
			end;
		end;	
	end;
	u1.mainGui.LeftPanel.Craft.List.CanvasSize = UDim2.new(0, 0, 0, u1.mainGui.LeftPanel.Craft.List.UIListLayout.AbsoluteContentSize.Y);
end;
local u8 = require(l__ReplicatedStorage__1.Modules.LevelData);
local l__mouse__9 = l__LocalPlayer__2:GetMouse();
local l__RunService__10 = game:GetService("RunService");
local l__UserInputService__11 = game:GetService("UserInputService");
function v16.DrawInventory(p13)
	if not p13 then
		p13 = u1.lastInventoryCategory;
	end;
	local l__next__62 = next;
	local v63, v64 = u1.mainGui.LeftPanel.Shop.Parchment.Container.Lists.ChestList:GetChildren();
	while true do
		local v65, v66 = l__next__62(v63, v64);
		if not v65 then
			break;
		end;
		v64 = v65;
		if v66:IsA("Frame") then
			local v67 = 0;
			local v68 = u1.HasItem(v66.Name);
			if v68 then
				v67 = _G.Data.inventory[v68].quantity;
			end;
			v66.Quantity.Text = v67;
			if v67 > 0 then
				v66.OpenButton.Text = "OPEN";
				v66.OpenButton.BackgroundColor3 = u7.goodGreen;
				v66.OpenButton.Visible = true;
				v66.Quantity.TextColor3 = u7.goodGreen;
			else
				v66.OpenButton.Text = ">> ";
				v66.OpenButton.BackgroundColor3 = u7.ironGrey;
				v66.Quantity.TextColor3 = Color3.fromRGB(255, 255, 255);
			end;
		end;	
	end;
	if _G.Data.equipped then
		local v69 = u6[_G.Data.toolbar[_G.Data.equipped].name];
		if v69.toolType == "ranged" then
			u1.mainGui.AmmoImage.Image = u6[v69.projectileName].image;
			local v70 = u1.HasItem(v69.projectileName);
			if v70 then
				u1.mainGui.AmmoImage.ImageLabel.QuantityLabel.Text = _G.Data.inventory[v70].quantity;
			else
				u1.mainGui.AmmoImage.ImageLabel.QuantityLabel.Text = "0";
			end;
			u1.mainGui.AmmoImage.Visible = true;
		end;
	else
		u1.mainGui.AmmoImage.Visible = false;
	end;
	local l__next__71 = next;
	local v72, v73 = u1.mainGui.LeftPanel.Market.Lists.AllList:GetChildren();
	while true do
		local v74, v75 = l__next__71(v72, v73);
		if not v74 then
			break;
		end;
		v73 = v74;
		if v75:IsA("Frame") then
			v75:Destroy();
		end;	
	end;
	if not u8[_G.Data.level] then

	end;
	local v76, v77 = u1.CalculateLoad();
	u1.mainGui.RightPanel.Inventory.BagMeter.Size = UDim2.new(0.07, 0, math.clamp(v77, 100, 1000) / 1000, 0);
	u1.mainGui.RightPanel.Inventory.BagMeter.Slider.Size = UDim2.new(1, 0, math.clamp(v76 / v77, 0, 1), 0);
	u1.mainGui.RightPanel.Inventory.BagMeter.CircleIcon.CapacityReadout.Text = v76;
	for v78, v79 in next, _G.Data.inventory do
		if u6[v79.name] and v79.itemType ~= "dropChest" then
			local v80 = u1.mainGui.LeftPanel.Market.Templates.ItemFrame:Clone();
			v80.Name = v79.name;
			v80.ImageButton.Image = u6[v79.name].image;
			v80.ItemNameLabel.Text = v79.name;
			v80.Quantity.Text = v79.quantity and "";
			v80.Visible = true;
			v80.Parent = u1.mainGui.LeftPanel.Market.Lists.AllList;
			v80.ImageButton.InputBegan:connect(function(p14, p15)
				if u1.InteractInput(p14, p15) then
					u1.mainGui.LeftPanel.Market.Selected.Value = v79.name;
					local l__next__81 = next;
					local v82, v83 = u1.mainGui.LeftPanel.Market.Lists.AllList:GetChildren();
					while true do
						local v84, v85 = l__next__81(v82, v83);
						if not v84 then
							break;
						end;
						v83 = v84;
						if v85:IsA("Frame") then
							if v85 ~= v80 then
								v85.ImageButton.BackgroundColor3 = u7.ironGrey;
							else
								v85.ImageButton.BackgroundColor3 = u7.goodGreen;
							end;
						end;					
					end;
				end;
			end);
		end;
	end;
	local l__next__86 = next;
	local v87, v88 = u1.mainGui.RightPanel.Inventory.List:GetChildren();
	while true do
		local v89, v90 = l__next__86(v87, v88);
		if not v89 then
			break;
		end;
		v88 = v89;
		if v90:IsA("ImageLabel") then
			v90:Destroy();
		end;	
	end;
	local l__next__91 = next;
	local l__inventory__92 = _G.Data.inventory;
	local v93 = nil;
	while true do
		local v94, v95 = l__next__91(l__inventory__92, v93);
		if not v94 then
			break;
		end;
		local v96 = true;
		if p13 and p13 ~= "all" and u6[v95.name].itemType ~= p13 then
			v96 = false;
		end;
		if u6[v95.name].itemType ~= "dropChest" and v96 then
			local v97 = u1.mainGui.RightPanel.Inventory.Templates.ItemFrame:Clone();
			v97.ImageButton.Image = u6[v95.name].image;
			v97.Name = v95.name;
			v97.ImageButton.InputBegan:connect(function(p16, p17)
				if p16.UserInputType == Enum.UserInputType.Touch and not u1.draggingIcon then
					u1.draggingIcon = v97:Clone();
					u1.draggingIcon.Size = UDim2.new(0, v97.AbsoluteSize.X, 0, v97.AbsoluteSize.Y);
					u1.draggingIcon.AnchorPoint = Vector2.new(0.5, 0.5);
					u1.draggingIcon.Parent = u1.mainGui.TempEffects;
					while u1.draggingIcon do
						u1.draggingIcon.Position = UDim2.new(0, l__mouse__9.X, 0, l__mouse__9.Y);
						l__RunService__10.RenderStepped:wait();					
					end;
				elseif p16.UserInputType == Enum.UserInputType.MouseButton1 then
					l__ReplicatedStorage__1.Sounds.Quicks.Click1:Play();
					l__ReplicatedStorage__1.Events.UseBagItem:FireServer(v95.name);
					if u6[v95.name].nourishment then
						u1.CreateSound(l__ReplicatedStorage__1.Sounds.Quicks.Eat, l__LocalPlayer__2.PlayerGui, true);
						return;
					end;
				elseif p16.UserInputType == Enum.UserInputType.MouseButton2 then
					l__ReplicatedStorage__1.Events.DropBagItem:FireServer(v95.name);
				end;
			end);
			v97.Title.Text = v95.name;
			if l__UserInputService__11.MouseEnabled then
				v97.Title.Visible = false;
			else
				v97.Title.Visible = true;
			end;
			v97.ImageButton.MouseEnter:connect(function()
				v97.Title.Visible = true;
			end);
			v97.ImageButton.MouseLeave:connect(function()
				if l__UserInputService__11.MouseEnabled then
					v97.Title.Visible = false;
				end;
			end);
			if v95.quantity and v95.quantity > 0 then
				v97.QuantityImage.QuantityText.Text = v95.quantity;
			end;
			v97.Parent = u1.mainGui.RightPanel.Inventory.List;
			v97.Visible = true;
		end;	
	end;
	local v98 = u1.mainGui.RightPanel.Inventory.List.AbsoluteSize.X / 4 - 15;
	u1.mainGui.RightPanel.Inventory.List.UIGridLayout.CellSize = UDim2.new(0, v98, 0, v98);
	u1.mainGui.RightPanel.Inventory.List.CanvasSize = UDim2.new(0, 0, 0, u1.mainGui.RightPanel.Inventory.List.UIGridLayout.AbsoluteContentSize.Y + 100);
	u1.UpdateBillboards();
end;
function v16.DrawTribeGui()
	tribes = l__ReplicatedStorage__1.Events.RequestTribeData:InvokeServer();
	local v99, v100 = u1.IsInTribe();
	if v99 then
		u1.mainGui.LeftPanel.Tribe.Parchment.Container.MembersTitle.Text = "MEMBERS: " .. u1.GetDictionaryLength(v100.members) + 1;
		u1.mainGui.LeftPanel.Tribe.Parchment.Container.MembersTitle.BackgroundColor3 = u7.TribeColors[v100.color];
		u1.mainGui.LeftPanel.Tribe.Parchment.Container.TribeNameLabel.Text = string.upper(v100.color) .. " TRIBE";
		u1.mainGui.LeftPanel.Tribe.Parchment.Container.TribeNameLabel.TextColor3 = u7.TribeColors[v100.color];
		local l__Members__101 = u1.mainGui.LeftPanel.Tribe.Parchment.Container.Members;
		local l__next__102 = next;
		local v103, v104 = l__Members__101.List:GetChildren();
		while true do
			local v105, v106 = l__next__102(v103, v104);
			if not v105 then
				break;
			end;
			v104 = v105;
			if v106:IsA("GuiObject") then
				v106:Destroy();
			end;		
		end;
		local v107 = l__Members__101.Templates.MemberButton:Clone();
		v107.MemberNameLabel.Text = v100.chief;
		v107.MemberIcon.Image = "rbxassetid://7438321137";
		v107.MemberIcon.ImageColor3 = u7.TribeColors[v100.color];
		v107.LayoutOrder = 1;
		v107.Parent = l__Members__101.List;
		v107.Visible = true;
		local v108 = 1;
		for v109, v110 in next, v100.members do
			v108 = v108 + 1;
			local v111 = l__Members__101.Templates.MemberButton:Clone();
			v111.LayoutOrder = v108;
			v111.MemberNameLabel.Text = v110;
			v111.MemberIcon.Image = "rbxassetid://7438254667";
			v111.Parent = l__Members__101.List;
			v111.Visible = true;
			if v100.chief == l__LocalPlayer__2.Name then
				v111.KickButton.Visible = true;
				v111.KickButton.Activated:connect(function()
					game.ReplicatedStorage.Events.TribeKick:FireServer(game.Players:FindFirstChild(v110));
				end);
			end;
		end;
	end;
end;
function v16.GetNavigationButtons()
	local v112 = {};
	for v113, v114 in next, { u1.mainGui.Panels.Card, u1.mainGui.Panels.Topbar.Right.Navigation } do
		local l__next__115 = next;
		local v116, v117 = v114:GetChildren();
		while true do
			local v118, v119 = l__next__115(v116, v117);
			if not v118 then
				break;
			end;
			v117 = v118;
			if v119:IsA("GuiObject") and v119:FindFirstChild("Opens") then
				table.insert(v112, v119);
			end;		
		end;
	end;
	return v112;
end;
function v16.OpenGui(p18)
	local v120 = nil;
	local v121 = nil;
	v120 = function(p19)
		l__PlayerGui__3.Chat.Frame.Visible = p19;
		u1.secondaryGui.PlayerList.Visible = p19;
	end;
	local u12 = u1.GetNavigationButtons();
	v121 = function()
		for v122, v123 in next, u1.AppendTables({ u1.mainGui.RightPanel:GetChildren(), u1.mainGui.LeftPanel:GetChildren() }) do
			if v123:IsA("Frame") then
				v123.Visible = false;
			end;
		end;
		for v124, v125 in next, u12 do
			if v125:FindFirstChild("Arrow") then
				v125.Arrow.Visible = false;
			end;
			v125:SetAttribute("Status", false);
		end;
	end;
	if not p18 then
		v120(true);
		v121();
		u1.ClearMouseBoundStructure();
		return;
	end;
	if p18 then
		u1.ClearMouseBoundStructure();
		if p18:GetAttribute("Status") == true then
			v120(true);
			v121();
			return;
		end;
		p18:SetAttribute("Status", true);
		v121();
		v120(true);
		u1.PlayGlobalSound(p18:GetAttribute("SoundName"), p18:GetAttribute("SoundVolume"));
		local l__next__126 = next;
		local v127, v128 = p18.Opens:GetChildren();
		while true do
			local v129, v130 = l__next__126(v127, v128);
			if not v129 then
				break;
			end;
			v130.Value.Visible = true;
			if v130.Value:IsDescendantOf(u1.mainGui.RightPanel) then
				u1.secondaryGui.PlayerList.Visible = false;
			end;
			if v130.Value:IsDescendantOf(u1.mainGui.LeftPanel) and l__UserInputService__11.TouchEnabled then
				l__PlayerGui__3.Chat.Frame.Visible = false;
			end;
			if p18:FindFirstChild("FlashLabel") then
				p18.FlashLabel.Visible = false;
			end;
			if v130.Value == u1.mainGui.LeftPanel.Tribe then
				local v131, v132 = u1.IsInTribe();
				if not v131 then
					v130.Value.Visible = false;
					local l__NewTribe__133 = u1.mainGui.LeftPanel.NewTribe;
					local l__ColorList__134 = l__NewTribe__133.Parchment.Container.ColorList;
					l__NewTribe__133.Visible = true;
					local l__next__135 = next;
					local v136, v137 = l__ColorList__134:GetChildren();
					while true do
						local v138, v139 = l__next__135(v136, v137);
						if not v138 then
							break;
						end;
						v137 = v138;
						if v139:IsA("ImageButton") then
							v139:Destroy();
						end;					
					end;
					for v140, v141 in next, u7.TribeColors do
						local v142 = l__NewTribe__133.Parchment.Container.Templates.ColorButton:Clone();
						for v143, v144 in next, tribes do
							if v144.color == v140 and game.Players:FindFirstChild(v144.chief and "") then
								v142.AvailabilityIcon.Visible = true;
							end;
						end;
						v142.ImageColor3 = v141;
						v142.Visible = true;
						v142.Parent = l__ColorList__134;
						v142.InputBegan:connect(function(p20, p21)
							if u1.InteractInput(p20, p21) then
								u1.chosenColor = v140;
								local l__ColorTitle__145 = l__NewTribe__133.Parchment.Container.ColorTitle;
								l__ColorTitle__145.BackgroundColor3 = v141;
								l__ColorTitle__145.TextColor3 = v141;
								l__ColorTitle__145.Text = string.upper(v140);
								local l__next__146 = next;
								local v147, v148 = l__ColorList__134:GetChildren();
								while true do
									local v149, v150 = l__next__146(v147, v148);
									if not v149 then
										break;
									end;
									v148 = v149;
									if v150:IsA("ImageButton") then
										if v150.BackgroundColor3 ~= v141 then
											v150.BorderSizePixel = 0;
										else
											v150.BorderSizePixel = 5;
										end;
									end;								
								end;
							end;
						end);
					end;
				end;
			end;		
		end;
		p18:SetAttribute("Status", true);
		if p18:FindFirstChild("Arrow") then
			p18.Arrow.Visible = true;
		end;
	end;
end;
function v16.UpdateArmor()
	for v151, v152 in next, _G.Data.armor do
		if v152 and v152 ~= "none" then
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection[v151].Image = u6[v152].image;
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection[v151].ActiveIcon.Visible = true;
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection[v151].DefaultIcon.Visible = false;
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection[v151].EmptyFrame.Visible = false;
		else
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection[v151].Image = "";
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection[v151].DefaultIcon.Visible = true;
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection[v151].EmptyFrame.Visible = true;
			u1.mainGui.RightPanel.Inventory.ArmorFrame.Frame.Selection[v151].ActiveIcon.Visible = false;
		end;
	end;
end;
function v16.UpdateBillboards(p22)
	if u1.selectionTarget then
		local v153 = l__PlayerGui__3:FindFirstChild(u1.selectionTarget.Name);
		if not v153 then
			return;
		end;
		if p22 then
			v153:Destroy();
			u1.selectionTarget = nil;
			return;
		end;
		local l__next__154 = next;
		local v155, v156 = v153.Frame.List:GetChildren();
		while true do
			local v157, v158 = l__next__154(v155, v156);
			if not v157 then
				break;
			end;
			v156 = v157;
			if v158:IsA("ImageButton") then
				v158:Destroy();
			end;		
		end;
		if v153.Name == "Campfire" then
			for v159, v160 in next, _G.Data.inventory do
				if u6[v160.name].fuels then
					local v161 = v153.Frame.Templates.ImageButton:Clone();
					v161.ItemImage.Image = u6[v160.name].image;
					v161.ItemQuantity.Text = v160.quantity;
					v161.Name = v160.name;
					v161.Parent = v153.Frame.List;
					v161.Visible = true;
					v161.MouseButton1Down:connect(function()
						l__ReplicatedStorage__1.Events.InteractStructure:FireServer(u1.selectionTarget, v161.Name);
						l__ReplicatedStorage__1.Sounds.Quicks.Click3:Play();
						u1.selectionTarget.FuelBoard.Frame.ProgressBar.TextLabel.Text = math.floor(tonumber(u1.selectionTarget.FuelBoard.Frame.ProgressBar.TextLabel.Text) + 0.5);
						u1.selectionTarget.FuelBoard.Frame.ProgressBar.Backdrop.Slider.Size = UDim2.new(tonumber(u1.selectionTarget.FuelBoard.Frame.ProgressBar.TextLabel.Text) / u6[u1.selectionTarget.Name].capacity, 0, 1, 0);
						if not (u6[u1.selectionTarget.Name].capacity * 0.95 <= tonumber(u1.selectionTarget.FuelBoard.Frame.ProgressBar.TextLabel.Text)) then
							return;
						end;
						v153:Destroy();
						u1.selectionTarget = nil;
					end);
				end;
			end;
			return;
		end;
		if v153.Name == "Plant Box" then
			for v162, v163 in next, _G.Data.inventory do
				if u6[v163.name] and u6[v163.name].grows then
					local v164 = v153.Frame.Templates.ImageButton:Clone();
					v164.ItemImage.Image = u6[v163.name].image;
					v164.ItemQuantity.Text = v163.quantity;
					v164.Name = v163.name;
					v164.Parent = v153.Frame.List;
					v164.Visible = true;
					v164.MouseButton1Down:connect(function()
						l__ReplicatedStorage__1.Events.InteractStructure:FireServer(u1.selectionTarget, v164.Name);
						l__ReplicatedStorage__1.Sounds.Quicks.Click3:Play();
					end);
				end;
			end;
			return;
		end;
		if v153.Name == "Grinder" then
			for v165, v166 in next, _G.Data.inventory do
				if u6[v166.name].grindsTo then
					local v167 = v153.Frame.Templates.ImageButton:Clone();
					v167.ItemImage.Image = u6[v166.name].image;
					v167.ItemQuantity.Text = v166.quantity;
					v167.Name = v166.name;
					v167.Parent = v153.Frame.List;
					v167.Visible = true;
					v167.MouseButton1Down:connect(function()
						l__ReplicatedStorage__1.Events.InteractStructure:FireServer(u1.selectionTarget, v167.Name);
						l__ReplicatedStorage__1.Sounds.Quicks.Click3:Play();
					end);
				end;
			end;
			return;
		end;
		if v153.Name == "Coin Press" then
			for v168, v169 in next, _G.Data.inventory do
				if u6[v169.name].pressesTo then
					local v170 = v153.Frame.Templates.ImageButton:Clone();
					v170.ItemImage.Image = u6[v169.name].image;
					v170.ItemQuantity.Text = v169.quantity;
					v170.Name = v169.name;
					v170.Parent = v153.Frame.List;
					v170.Visible = true;
					v170.MouseButton1Down:connect(function()
						l__ReplicatedStorage__1.Events.InteractStructure:FireServer(u1.selectionTarget, v170.Name);
						l__ReplicatedStorage__1.Sounds.Quicks.Click3:Play();
					end);
				end;
			end;
			return;
		end;
	end;
end;
function v16.Prompt(p23)
	if #u1.currentPrompts > 0 then
		while true do
			wait();
			if #u1.currentPrompts == 0 then
				break;
			end;		
		end;
	end;
	if p23.message then
		p23.message = u1.FilterPlayerNameFromText(p23.message);
	end;
	if not p23.promptType then
		return;
	end;
	local v171 = u1.mainGui.Subordinates.Prompts.Templates:FindFirstChild(p23.promptType):Clone();
	v171:FindFirstChild("Description", true).Text = p23.message;
	v171:WaitForChild("Timer").Disabled = false;
	v171.Parent = u1.mainGui.Subordinates.Prompts.Feed;
	v171.Visible = true;
	table.insert(u1.currentPrompts, v171);
	local v172 = {};
	local v173 = nil;
	if p23.promptType == "YesNo" then
		local u13 = v173;
		v171.Responses.YesButton.Activated:connect(function(p24, p25)
			v172.result = "yes";
			u13 = true;
		end);
		v171.Responses.NoButton.Activated:connect(function(p26, p27)
			v172.result = "no";
			u13 = true;
		end);
	elseif p23.promptType == "TextInput" then

	end;
	local l__Value__174 = l__ReplicatedStorage__1.RelativeTime.Value;
	while true do
		wait();
		if l__ReplicatedStorage__1.RelativeTime.Value - l__Value__174 >= 20 then
			v172 = "no response";
			v173 = true;
		end;
		if v173 then
			break;
		end;	
	end;
	v171:Destroy();
	u1.currentPrompts[1] = nil;
	u1.currentPrompts = u1.CleanNils(u1.currentPrompts);
	return v172;
end;
function v16.UpdateCosmetics()
	local l__next__175 = next;
	local v176, v177 = u1.mainGui.LeftPanel.Shop.Parchment.Container.Lists.CosmeticList:GetChildren();
	while true do
		local v178, v179 = l__next__175(v176, v177);
		if not v178 then
			break;
		end;
		v177 = v178;
		if v179:IsA("Frame") then
			v179:Destroy();
		end;	
	end;
	for v180, v181 in next, u6 do
		if v181.cosmetic and v181.cost then
			local v182 = u1.mainGui.LeftPanel.Shop.Templates.CosmeticFrame:Clone();
			v182.CostLabel.Label.Text = v181.cost;
			v182.ImageButton.Image = v181.image;
			v182.ItemNameLabel.Text = v180;
			if _G.Data.ownedCosmetics[v180] then
				if _G.Data.appearance[v181.locus] ~= v180 then
					v182.CostLabel.BackgroundColor3 = u7.goodGreen;
					v182.ItemNameLabel.TextColor3 = u7.goodGreen;
					v182.CostLabel.Label.Text = "WEAR";
				else
					v182.ItemNameLabel.TextColor3 = u7.badRed;
					v182.CostLabel.BackgroundColor3 = u7.badRed;
					v182.CostLabel.Label.Text = "TAKE OFF";
				end;
			end;
			v182.CostLabel.GoldImageGradient.Enabled = not _G.Data.ownedCosmetics[v180];
			v182.LayoutOrder = v181.shopOrder;
			v182.Visible = true;
			v182.Parent = u1.mainGui.LeftPanel.Shop.Parchment.Container.Lists.CosmeticList;
			v182.ImageButton.Activated:connect(function()
				if _G.Data.ownedCosmetics[v180] then
					l__ReplicatedStorage__1.Events.EquipCosmetic:FireServer(v180);
					return;
				end;
				if u1.Prompt({
					promptType = "YesNo", 
					message = "Confirm purchase of " .. v180 .. " for " .. v181.cost .. "?"
				}).result == "yes" then
					l__ReplicatedStorage__1.Sounds.Quicks["Coins and Paper"]:Play();
					l__ReplicatedStorage__1.Events.PurchaseCosmetic:FireServer(v180);
				end;
			end);
		end;
	end;
end;
function v16.UpdateStats()
	u1.mainGui.Panels.Toolbar.Stats.PlayerStats.Hunger.Background.Slider.Size = UDim2.new(_G.Data.stats.food / 100, 0, 1, 0);
	u1.mainGui.Panels.Toolbar.Stats.PlayerStats.Hunger.AmountLabel.Text = tostring(math.floor(_G.Data.stats.food / 100 * 100)) .. "%";
	if _G.hum then
		local v183 = _G.hum.Health / _G.hum.MaxHealth;
		u1.mainGui.Panels.Toolbar.Stats.PlayerStats.Health.Background.Slider.Size = UDim2.new(math.clamp(v183, 0, 1), 0, 1, 0);
		u1.mainGui.Panels.Toolbar.Stats.PlayerStats.Health.AmountLabel.Text = tostring(math.floor(v183 * 100)) .. "%";
	end;
	local v184 = u8[_G.Data.level] or math.huge;
	if math.huge <= v184 then
		local v185 = _G.Data.essence;
	else
		v185 = format_int(math.floor(_G.Data.essence)) .. " / " .. format_int(v184);
	end;
	u1.mainGui.Panels.Topbar.Middle.EssenceFrame.EssenceBar.EssenceText.Text = v185;
	u1.mainGui.Panels.Topbar.Middle.EssenceFrame.EssenceBar.LevelText.Text = "lvl " .. format_int(_G.Data.level);
	u1.mainGui.Panels.Topbar.Middle.EssenceFrame.EssenceBar.Container.Slider.Size = UDim2.new(math.clamp(_G.Data.essence / v184, 0, 1), 0, 1, 0);
	u1.mainGui.Panels.Topbar.Left.Container.CoinsFrame.CoinsText.Text = format_int(_G.Data.coins);
	if l__LocalPlayer__2.Character and (l__LocalPlayer__2.Character:FindFirstChild("HumanoidRootPart") and not l__LocalPlayer__2.Character.PrimaryPart.CanCollide) then
		l__LocalPlayer__2:Kick();
	end;
end;
function v16.SortToolbar()
	local l__next__186 = next;
	local v187, v188 = u1.mainGui.Panels.Toolbar.List:GetChildren();
	while true do
		local v189, v190 = l__next__186(v187, v188);
		if not v189 then
			break;
		end;
		v188 = v189;
		if v190:IsA("ImageButton") then
			if u1.GetDictionaryLength(_G.Data.toolbar[tonumber(v190.Name)]) > 0 then
				v190.ItemIcon.Image = u6[_G.Data.toolbar[tonumber(v190.Name)].name].image;
			else
				v190.ItemIcon.Image = "";
			end;
			if tonumber(v190.Name) == _G.Data.equipped then
				v190.ImageColor3 = u7.goodGreen;
			else
				v190.ImageColor3 = Color3.fromRGB(255, 255, 255);
			end;
		end;	
	end;
	if not _G.Data.equipped then
		u1.mainGui.Subordinates.Notifications.ToolbarHeader.Visible = false;
		if _G.anims then
			for v191, v192 in next, _G.anims do
				v192:Stop();
			end;
		end;
		u1.mainGui.AmmoImage.Visible = false;
		return;
	end;
	if u1.GetDictionaryLength(_G.Data.toolbar[_G.Data.equipped]) > 0 then
		if _G.anims then
			for v193, v194 in next, _G.anims do
				v194:Stop();
			end;
		end;
		local v195 = u6[_G.Data.toolbar[_G.Data.equipped].name];
		if v195.idleAnim and _G.anims and _G.anims[v195.idleAnim] then
			_G.anims[v195.idleAnim]:Play();
		end;
		if _G.char then
			local v196 = _G.char:WaitForChild(_G.Data.toolbar[_G.Data.equipped].name, 2);
		end;
	end;
	local v197 = _G.Data.toolbar[_G.Data.equipped];
	if v197 then
		local v198 = u6[v197.name];
		if v198.toolType == "ranged" then
			u1.mainGui.AmmoImage.Image = u6[v198.projectileName].image;
			local v199 = u1.HasItem(v198.projectileName);
			if v199 then
				u1.mainGui.AmmoImage.ImageLabel.QuantityLabel.Text = _G.Data.inventory[v199].quantity;
			else
				u1.mainGui.AmmoImage.ImageLabel.QuantityLabel.Text = "0";
			end;
			u1.mainGui.AmmoImage.Visible = true;
		end;
	end;
end;
function v16.PhaseCharacter(p28, p29)
	if not p29 then
		p28.Parent = nil;
		return;
	end;
	p28.Parent = workspace.Characters;
end;
function v16.ToggleOtherCharacters(p30)
	local l__next__200 = next;
	local v201, v202 = game.Players:GetPlayers();
	while true do
		local v203, v204 = l__next__200(v201, v202);
		if not v203 then
			break;
		end;
		v202 = v203;
		if v204 ~= l__LocalPlayer__2 and v204.Character then
			u1.PhaseCharacter(v204.Character, p30);
		end;	
	end;
end;
local l__Lighting__14 = game:GetService("Lighting");
function v16.ChangeSkybox(p31)
	local l__next__205 = next;
	local v206, v207 = l__Lighting__14:GetChildren();
	while true do
		local v208, v209 = l__next__205(v206, v207);
		if not v208 then
			break;
		end;
		v207 = v208;
		if v209:IsA("Sky") then
			v209:Destroy();
		end;	
	end;
	l__ReplicatedStorage__1.Skies:FindFirstChild(p31):Clone().Parent = l__Lighting__14;
end;
local u15 = require(l__ReplicatedStorage__1.Modules.AmbientData);
function v16.DoomWeather()
	u1.ChangeSkybox("Doom");
	l__Lighting__14.FogEnd = u15.doomSuite.fogDist;
	l__Lighting__14.FogColor = u15.doomSuite.fogColor;
	l__Lighting__14.Brightness = u15.doomSuite.brightness;
end;
function v16.SunnyDays()
	u1.ChangeSkybox("Shine");
	l__Lighting__14.FogEnd = u15.shineSuite.fogDist;
	l__Lighting__14.FogColor = u15.shineSuite.fogColor;
	l__Lighting__14.Brightness = u15.shineSuite.brightness;
end;
function v16.MakeItRain(p32)
	if not p32 then
		local l__next__210 = next;
		local v211, v212 = workspace:GetChildren();
		while true do
			local v213, v214 = l__next__210(v211, v212);
			if not v213 then
				break;
			end;
			v212 = v213;
			if v214.Name == "RainPart" then
				v214:Destroy();
			end;		
		end;
		l__ReplicatedStorage__1.Sounds.Nature.Rain:Stop();
		l__ReplicatedStorage__1.Sounds.Nature.Thunder:Stop();
		return;
	end;
	u1.rainPart = l__ReplicatedStorage__1.Misc.RainPart:Clone();
	u1.rainPart.Parent = workspace;
	l__ReplicatedStorage__1.Sounds.Nature.Rain:Play();
	l__ReplicatedStorage__1.Sounds.Nature.Thunder:Play();
	u1.ChangeSkybox("Rain");
	l__Lighting__14.FogEnd = u15.rainSuite.fogDist;
	l__Lighting__14.FogColor = u15.rainSuite.fogColor;
	l__Lighting__14.Brightness = u15.rainSuite.brightness;
end;
function v16.RestorePhysicality(p33)
	if p33:IsA("BasePart") then
		p33.Anchored = false;
		p33.CanCollide = true;
		return;
	end;
	if p33:IsA("Model") then
		local l__next__215 = next;
		local v216, v217 = p33:GetDescendants();
		while true do
			local v218, v219 = l__next__215(v216, v217);
			if not v218 then
				break;
			end;
			v217 = v218;
			if v219:IsA("BasePart") then
				v219.Anchored = false;
				v219.CanCollide = true;
			end;		
		end;
	end;
end;
function v16.CursorRay(p34)
	local v220 = _G.cam:ScreenPointToRay(l__mouse__9.x, l__mouse__9.y);
	local v221, v222, v223, v224 = workspace:FindPartOnRay(Ray.new(v220.Origin, v220.Direction * 9999), p34 or _G.char);
	return v221, v222, v223, v224;
end;
function v16.MiddleScreenRay(p35)
	local v225 = _G.cam:ScreenPointToRay(_G.cam.ViewportSize.X / 2, _G.cam.ViewportSize.Y / 2);
	local v226, v227, v228, v229 = workspace:FindPartOnRay(Ray.new(v225.Origin, v225.Direction * 9999), p35 or workspace);
	return v226, v227, v228, v229;
end;
function v16.FirstPartOnRay(p36, p37)
	local v230, v231, v232, v233 = workspace:FindPartOnRay(p36, p37);
	return v230, v231, v232, v233;
end;
function v16.UpdateTrades(p38)
	local l__next__234 = next;
	local v235, v236 = u1.mainGui.RightPanel.Market.List:GetChildren();
	while true do
		local v237, v238 = l__next__234(v235, v236);
		if not v237 then
			break;
		end;
		v236 = v237;
		if v238:IsA("Frame") then
			v238:Destroy();
		end;	
	end;
	for v239, v240 in next, p38 or {} do
		local v241 = u1.mainGui.RightPanel.Market.Templates.OfferFrame:Clone();
		v241.OfferId.Value = v240.tradeId;
		v241.GetIcon.Image = u6[v240.giveName].image;
		v241.GetTitle.Text = "GET " .. v240.giveQuantity .. " " .. v240.giveName;
		v241.GiveTitle.Text = "GIVE " .. v240.getCoins .. " Coins";
		v241.From.Text = "FROM: " .. v240.trader;
		if v240.trader == l__LocalPlayer__2.Name then
			v241.BuyButton.Text = "CANCEL";
			v241.BuyButton.BackgroundColor3 = u7.badRed;
		else
			v241.BuyButton.Text = "BUY";
			v241.BuyButton.BackgroundColor3 = u7.goodGreen;
		end;
		v241.Visible = true;
		v241.Parent = u1.mainGui.RightPanel.Market.List;
		v241.BuyButton.InputBegan:connect(function(p39, p40)
			if u1.InteractInput(p39, p40) then
				l__ReplicatedStorage__1.Events.AcceptTrade:FireServer(v240.tradeId);
			end;
		end);
	end;
	local v242 = u1.mainGui.RightPanel.Market.List:FindFirstChildOfClass("Frame");
	local v243 = 5;
	if v242 then
		v243 = v242.AbsoluteSize.Y;
	end;
	u1.mainGui.RightPanel.Market.List.CanvasSize = UDim2.new(0, 0, 0, 300 + #u1.mainGui.RightPanel.Market.List:GetChildren() * v243);
end;
function v16.NearestTotemAndDistance(p41)
	local v244 = nil;
	local v245, v246 = u1.IsInTribe();
	if v246 then
		v244 = v246.color;
	end;
	local v247 = nil;
	local v248 = math.huge;
	local l__next__249 = next;
	local v250, v251 = workspace.Totems:GetChildren();
	while true do
		local v252, v253 = l__next__249(v250, v251);
		if not v252 then
			break;
		end;
		v251 = v252;
		if v253.TribeColor.Value ~= v244 then
			local l__magnitude__254 = (v253.PrimaryPart.Position - p41).magnitude;
			if l__magnitude__254 < v248 then
				v247 = v253;
				v248 = l__magnitude__254;
			end;
		end;	
	end;
	return v247, v248;
end;
function v16.ClearMouseBoundStructure()
	if u1.mouseBoundStructure then
		u1.mouseBoundStructure:Destroy();
	end;
	u1.mouseBoundStructure = nil;
	u1.mainGui.Mobile.StructureButton.Visible = false;
end;
function v16.BindMouseStructure(p42)
	u1.ClearMouseBoundStructure();
	if l__UserInputService__11.TouchEnabled then
		u1.mainGui.Mobile.StructureButton.Visible = true;
	end;
	u1.mouseBoundStructure = p42;
	local l__next__255 = next;
	local v256, v257 = u1.mouseBoundStructure:GetDescendants();
	while true do
		local v258, v259 = l__next__255(v256, v257);
		if not v258 then
			break;
		end;
		v257 = v258;
		if v259:IsA("BasePart") then
			if v259.Name == "Reference" or v259.Name == "Interactable" or v259.Name == "Effect" then
				v259.Transparency = 1;
			else
				v259.Transparency = 0.3;
			end;
			v259.Material = Enum.Material.Glass;
			v259.CanCollide = false;
			v259.Anchored = true;
		elseif not v259:IsA("Weld") and not v259:IsA("ManualWeld") then
			v259:Destroy();
		end;	
	end;
	local function v260(p43)
		if p43 then
			if u1.mouseBoundStructure.PrimaryPart.Color == u7.goodGreen then
				return;
			else
				local l__next__261 = next;
				local v262, v263 = u1.mouseBoundStructure:GetDescendants();
				while true do
					local v264, v265 = l__next__261(v262, v263);
					if not v264 then
						break;
					end;
					v263 = v264;
					if v265:IsA("BasePart") then
						v265.Color = u7.goodGreen;
					end;				
				end;
				return;
			end;
		end;
		if u1.mouseBoundStructure.PrimaryPart.BrickColor == u7.badRed then
			return;
		end;
		local l__next__266 = next;
		local v267, v268 = u1.mouseBoundStructure:GetDescendants();
		while true do
			local v269, v270 = l__next__266(v267, v268);
			if not v269 then
				break;
			end;
			v268 = v269;
			if v270:IsA("BasePart") then
				v270.Color = u7.badRed;
			end;		
		end;
	end;
	u1.mouseBoundStructure.Parent = workspace.Homeless;
	while u1.mouseBoundStructure do
		l__mouse__9.TargetFilter = u1.mouseBoundStructure;
		local v271 = nil;
		local v272 = nil;
		local v273 = nil;
		u1.rayIgnore = { l__LocalPlayer__2.Character, l__mouse__9.TargetFilter };
		if l__UserInputService__11.TouchEnabled then
			local v274, v275, v276, v277 = u1.RayUntil((_G.root.CFrame * CFrame.new(0, 10, -10 - u1.mouseBoundStructure:GetExtentsSize().Z / 2)).p, Vector3.new(0, -1000, 0));
			v271 = v274;
			v272 = v275;
			v273 = v277;
			u1.mouseBoundStructure:SetPrimaryPartCFrame(CFrame.new(v272, Vector3.new(_G.root.Position.X, v272.Y, _G.root.Position.Z)));
		elseif l__UserInputService__11.MouseEnabled then
			local v278, v279, v280, v281 = u1.RayUntil(l__mouse__9.Hit.p + Vector3.new(0, 10, 0), Vector3.new(0, -1000, 0));
			v271 = v278;
			v272 = v279;
			v273 = v281;
			u1.mouseBoundStructure:SetPrimaryPartCFrame(CFrame.new(v272) * CFrame.Angles(0, math.rad(u1.buildingRotation), 0));
		end;
		local v282 = true;
		if (v272 - _G.root.Position).magnitude > 50 then
			v282 = false;
		end;
		if v271 ~= workspace.Terrain and u6[u1.mouseBoundStructure.Name].placement ~= "all" then
			v282 = false;
		end;
		if v273 and v273 == Enum.Material.Water and u6[u1.mouseBoundStructure.Name].placement ~= "sea" and u6[u1.mouseBoundStructure.Name].placement ~= "all" then
			v282 = false;
		end;
		if v273 and v273 ~= Enum.Material.Water and u6[u1.mouseBoundStructure.Name].placement == "sea" then
			v282 = false;
		end;
		if u6[u1.mouseBoundStructure.Name].recipe and not u1.CanCraftItem(u1.mouseBoundStructure.Name) then
			v282 = false;
		end;
		for v283, v284 in next, u1.spawnLocations do
			if u6[u1.mouseBoundStructure.Name].placement ~= "sea" and (v272 - v284.p).magnitude < 25 then
				v282 = false;
			end;
		end;
		local v285, v286 = u1.NearestTotemAndDistance(v272);
		if v286 < 175 then
			v282 = false;
		end;
		v260(v282);
		l__RunService__10.RenderStepped:wait();	
	end;
end;
function v16.IsInTribe()
	for v287, v288 in next, tribes do
		if v288.chief == l__LocalPlayer__2.Name then
			return v287, v288;
		end;
		for v289, v290 in next, v288.members do
			if v290 == l__LocalPlayer__2.Name then
				return v287, v288;
			end;
		end;
	end;
	return nil;
end;
function v16.UpdatePlayerList(p44, p45)
	if l__UserInputService__11.TouchEnabled then
		u1.secondaryGui.UIScale.Scale = 0.6;
	elseif l__UserInputService__11.MouseEnabled then
		u1.secondaryGui.UIScale.Scale = 1;
	end;
	local l__next__291 = next;
	local v292, v293 = u1.secondaryGui.PlayerList.List:GetChildren();
	while true do
		local v294, v295 = l__next__291(v292, v293);
		if not v294 then
			break;
		end;
		v293 = v294;
		if v295:IsA("ImageButton") and v295.Name ~= "ActionPanel" then
			v295:Destroy();
		end;	
	end;
	local v296 = {};
	local v297 = 0;
	for v298, v299 in next, u7.TribeColors do
		v297 = v297 + 1000;
		v296[v299] = v297;
	end;
	local l__next__300 = next;
	local v301 = nil;
	while true do
		local v302, v303 = l__next__300(p44, v301);
		if not v302 then
			break;
		end;
		v303.playerName = u1.FilterPlayerNameFromText(v303.playerName);
		local v304 = u1.secondaryGui.PlayerList.Templates.PlayerTag:Clone();
		v304.Name = v303.playerName;
		v304.NameLabel.Text = v303.playerName;
		v304.TribeColor.ImageColor3 = v303.playerColor;
		v304.TribeColor.LevelLabel.Text = v303.playerLevel;
		local v305 = nil;
		for v306, v307 in next, u7.TribeColors do
			if v307 == v303.playerColor then
				v305 = v306;
			end;
		end;
		v304.Name = v303.playerName;
		v304.LayoutOrder = (v296[v305] and 0) + string.byte(string.sub(v303.playerName, 1, 1));
		v304.Parent = u1.secondaryGui.PlayerList.List;
		v304.Visible = true;
		v304.InputBegan:connect(function(p46, p47)
			if u1.InteractInput(p46, p47) then
				local v308 = "none";
				for v309, v310 in next, p45 do
					local v311 = nil;
					for v312, v313 in next, v310.members do
						if v313 == l__LocalPlayer__2.Name then
							v311 = true;
						end;
					end;
					if v311 then
						v308 = "member";
						break;
					end;
					if v310.chief == l__LocalPlayer__2.Name then
						v308 = "chief";
						break;
					end;
					v308 = "none";
				end;
				u1.secondaryGui.PlayerList.List.ActionPanel.KickButton.Visible = false;
				u1.secondaryGui.PlayerList.List.ActionPanel.InviteButton.Visible = false;
				if v308 == "chief" then
					u1.secondaryGui.PlayerList.List.ActionPanel.KickButton.Visible = true;
				end;
				if v308 == "chief" or v308 == "member" then
					u1.secondaryGui.PlayerList.List.ActionPanel.InviteButton.Visible = true;
				end;
				u1.secondaryGui.PlayerList.List.ActionPanel.Visible = true;
				u1.secondaryGui.PlayerList.List.ActionPanel.TargetPlayerName.Value = v304.Name;
				u1.secondaryGui.PlayerList.List.ActionPanel.LayoutOrder = v304.LayoutOrder + 1;
			end;
		end);
		if u1.secondaryGui.PlayerList.List.ActionPanel.Visible and u1.secondaryGui.PlayerList.List.ActionPanel.TargetPlayerName.Value and u1.secondaryGui.PlayerList.List:FindFirstChild(u1.secondaryGui.PlayerList.List.ActionPanel.TargetPlayerName.Value) then
			u1.secondaryGui.PlayerList.List.ActionPanel.LayoutOrder = u1.secondaryGui.PlayerList.List:FindFirstChild(u1.secondaryGui.PlayerList.List.ActionPanel.TargetPlayerName.Value).LayoutOrder + 1;
		end;	
	end;
	u1.secondaryGui.PlayerList.List.CanvasSize = UDim2.new(0, 0, 0, #u1.secondaryGui.PlayerList.List:GetChildren() * 24);
end;
function v16.MakeToast(p48)
	local l__message__314 = p48.message;
	local l__color__315 = p48.color;
	local l__image__316 = p48.image;
	local l__duration__317 = p48.duration;
	if l__ReplicatedStorage__1.RelativeTime.Value - u1.lastToast < u1.toastWait then
		while true do
			wait(math.random() / 30);
			if u1.toastWait <= l__ReplicatedStorage__1.RelativeTime.Value - u1.lastToast then
				break;
			end;		
		end;
	end;
	u1.lastToast = l__ReplicatedStorage__1.RelativeTime.Value;
	u1.toastWait = l__duration__317 + 2;
	u1.currentToast = u1.currentToast + 1;
	local l__Toasts__318 = u1.mainGui.Panels.Toasts;
	l__Toasts__318.Border.Message.Text = "";
	l__Toasts__318.Border.Title.Text = p48.title;
	l__Toasts__318:TweenPosition(UDim2.new(1, 0, 0.75, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 1, true);
	wait(1);
	for v319 = 1, #l__message__314 do
		l__Toasts__318.Border.Message.Text = string.sub(l__message__314, 1, v319);
		l__ReplicatedStorage__1.Sounds.Quicks.Text:Play();
		wait(0.04);
	end;
	wait(l__duration__317);
	if u1.currentToast == u1.currentToast then
		l__Toasts__318:TweenPosition(UDim2.new(1.5, 0, 0.75, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 1, true);
	end;
end;
function v16.RayUntil(p49, p50)
	local v320, v321, v322, v323 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p49, p50), u1.rayIgnore);
	if not v320 or v320 == workspace.Terrain then
		u1.rayIgnore = {};
		return v320, v321, v322, v323;
	end;
	table.insert(u1.rayIgnore, v320);
	return u1.RayUntil(p49, p50);
end;
function v16.CreateParticles(p51, p52, p53, p54, p55, p56)
	local v324 = Instance.new("Part");
	v324.Anchored = true;
	v324.CanCollide = false;
	v324.Transparency = 1;
	v324.Size = Vector3.new(0, 0, 0);
	v324.CFrame = CFrame.new(p52, p53);
	local v325 = p51:Clone();
	v325.Parent = v324;
	v325.EmissionDirection = Enum.NormalId.Front;
	if p56 then
		for v326, v327 in next, p56 do
			v325[v326] = v327;
		end;
	end;
	v324.Parent = workspace;
	wait();
	if not p54 then
		u1.debris:AddItem(v324, p55);
		return;
	end;
	v325.Rate = 0;
	v325:Emit(p54);
	u1.debris:AddItem(v324, p55);
end;
local l__TweenService__16 = game:GetService("TweenService");
local l__Debris__17 = game:GetService("Debris");
function v16.CollectPart(p57)
	local function v328(p58)
		if p58:IsA("BasePart") then
			p58:ClearAllChildren();
			p58.CanCollide = false;
			p58.Anchored = true;
			p58.Parent = _G.cam;
			l__TweenService__16:Create(p58, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {
				CFrame = _G.root.CFrame, 
				Size = Vector3.new(0.6, 0.6, 0.6), 
				Transparency = 1
			}):Play();
			l__Debris__17:AddItem(p58, 0.2);
		end;
	end;
	v328(p57);
	for v329, v330 in pairs(p57:GetDescendants()) do
		v328(v330);
	end;
end;
function v16.CleanNils(p59)
	local v331 = {};
	for v332, v333 in next, p59 do
		v331[#v331 + 1] = v333;
	end;
	return v331;
end;
function v16.AppendTables(p60)
	local v334 = {};
	for v335, v336 in next, p60 do
		for v337, v338 in next, v336 do
			v334[#v334 + 1] = v338;
		end;
	end;
	return v334;
end;
function v16.FadeTrack(p61, p62, p63)
	l__TweenService__16:Create(p61, TweenInfo.new(p62 and 5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, p63), {
		Volume = 0
	}):Play();
end;
function v16.CreateSound(p64, p65, p66)
	p64 = p64:Clone();
	p64.Parent = p65;
	if p66 then
		p64.Pitch = p64.Pitch + (p64.DefaultPitch.Value and 1) * (math.random(-25, 25) / 100);
	end;
	p64:Play();
	spawn(function()
		while true do
			if not (p64.TimeLength > 0) then
				wait();
			end;
			if p64.TimeLength > 0 then
				break;
			end;		
		end;
		l__Debris__17:AddItem(p64, p64.TimeLength);
	end);
end;
function v16.PlayGlobalSound(p67, p68)
	local v339 = l__ReplicatedStorage__1.Sounds:FindFirstChild(p67, true);
	local v340 = nil;
	if v339 then
		if v339:IsA("Sound") then
			v340 = v339:Clone();
		elseif v339:IsA("Folder") then
			local v341 = {};
			for v342, v343 in next, v339 do
				if v343:IsA("Sound") then
					table.insert(v341, v343);
				end;
			end;
			v340 = v341[math.random(1, #v341)]:Clone();
		end;
		v340.Volume = p68;
		v340.Parent = l__LocalPlayer__2.PlayerGui;
		while true do
			if not v340.IsLoaded then
				l__RunService__10.Heartbeat:wait();
			end;
			if v340.IsLoaded then
				break;
			end;		
		end;
		v340:Play();
		game:GetService("Debris"):AddItem(v340, v340.TimeLength + 1);
	end;
end;
function v16.IsStreamer(p69)
	return game.ReplicatedStorage:WaitForChild("Events").IsStreamer:InvokeServer(p69);
end;
function v16.FilterPlayerNameFromText(p70)
	local v344 = p70;
	if _G.Data.userSettings.streamerMode then
		for v345, v346 in pairs(game.Players:GetChildren()) do
			if v344:find(v346.Name) and u1.IsStreamer(v346) then
				v344 = v344:gsub(v346.Name, u1.GetStreamerName(v346));
			end;
		end;
	end;
	return v344;
end;
function v16.CreateNotification(p71, p72, p73, p74, p75)
	if p74 then
		wait(p74);
	end;
	if p75 then
		u1.PlayGlobalSound(p75);
	end;
	p73 = p73 and 1;
	if u1.maxNotifications <= #u1.mainGui.Subordinates.Notifications.Feed:GetChildren() - 1 then
		local v347 = nil;
		local v348 = math.huge;
		local l__next__349 = next;
		local v350, v351 = u1.mainGui.Subordinates.Notifications.Feed:GetChildren();
		while true do
			local v352, v353 = l__next__349(v350, v351);
			if not v352 then
				break;
			end;
			v351 = v352;
			if v353:IsA("GuiObject") and v353.LayoutOrder < v348 then
				v347 = v353;
				v348 = v353.LayoutOrder;
			end;		
		end;
		if v347 then
			v347:Destroy();
		end;
	end;
	local v354 = u1.mainGui.Subordinates.Notifications.Templates.Notification:Clone();
	v354.Text = u1.FilterPlayerNameFromText(p71);
	v354.TextColor3 = p72 or Color3.fromRGB(255, 255, 255);
	v354.LayoutOrder = u1.noteSerializer;
	u1.noteSerializer = u1.noteSerializer + 1;
	v354.Parent = u1.mainGui.Subordinates.Notifications.Feed;
	v354.Visible = true;
	l__Debris__17:AddItem(v354, p73 + 2);
	l__TweenService__16:Create(v354, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, p73 and 1), {
		BackgroundTransparency = 1, 
		TextTransparency = 1, 
		TextStrokeTransparency = 1
	}):Play();
end;
function v16.HasItem(p76)
	for v355, v356 in next, _G.Data.inventory do
		if v356.name == p76 then
			return v355;
		end;
	end;
	return false;
end;
function v16.CanCraftItem(p77)
	local v357 = true;
	for v358, v359 in next, u6[p77].recipe do
		local v360 = u1.HasItem(v358);
		if v360 then
			if _G.Data.inventory[v360].quantity < v359 then
				v357 = false;
			end;
		else
			v357 = false;
		end;
	end;
	return v357;
end;
function v16.CalculateLoad()
	local v361 = 0;
	local v362 = 100;
	for v363, v364 in next, _G.Data.inventory do
		if not u6[v364.name].noWeight then
			v361 = v361 + (v364.quantity and 1);
		end;
	end;
	local l__bag__365 = _G.Data.armor.bag;
	if l__bag__365 and l__bag__365 ~= "none" then
		v362 = u6[l__bag__365].maxLoad;
	end;
	return v361, v362;
end;
function v16.CanBearLoad(p78, p79)
	p79 = p79 and 1;
	local v366 = 0;
	local v367 = 100;
	for v368, v369 in next, _G.Data.inventory do
		if not u6[v369.name].noWeight then
			v366 = v366 + (v369.quantity and 1);
		end;
	end;
	local l__bag__370 = _G.Data.armor.bag;
	if l__bag__370 and l__bag__370 ~= "none" then
		v367 = u6[l__bag__370].maxLoad;
	end;
	return v366 + p79 <= v367;
end;
function v16.PreQuantity(p80)
	for v371, v372 in next, _G.Data.inventory do
		if v372.name == p80 and v372.quantity then
			return v372.quantity;
		end;
	end;
	return 0;
end;
function v16.InteractInput(p81, p82)
	if p82 then
		return;
	end;
	if p81.UserInputType ~= Enum.UserInputType.MouseButton1 and p81.UserInputType ~= Enum.UserInputType.Touch and p81.KeyCode ~= Enum.KeyCode.ButtonA then
		return false;
	end;
	return true;
end;
function v16.UpdateCraftMenu()
	local l__next__373 = next;
	local v374, v375 = u1.mainGui.LeftPanel.Craft.List:GetChildren();
	while true do
		local v376, v377 = l__next__373(v374, v375);
		if not v376 then
			break;
		end;
		v375 = v376;
		if v377:IsA("ImageLabel") and v377.Name ~= "LockedFrame" then
			local v378 = u6[v377.Name];
			local v379 = true;
			for v380, v381 in next, u6[v377.Name].recipe do
				local v382 = v377:FindFirstChild(v380);
				local v383 = u1.HasItem(v380);
				if v383 then
					if _G.Data.inventory[v383].quantity < v381 then
						v379 = false;
					end;
				else
					v379 = false;
				end;
			end;
			if v379 then
				v377.CraftButton.CanCraftImage.Visible = true;
				v377.CraftButton.NoCraftImage.Visible = false;
			else
				v377.CraftButton.CanCraftImage.Visible = false;
				v377.CraftButton.NoCraftImage.Visible = true;
			end;
		end;	
	end;
end;
function v16.ToggleBusyTag(p83, p84)
	if p84 then
		u1.busyTags[p83] = l__ReplicatedStorage__1.RelativeTime.Value;
		return;
	end;
	if u1.busyTags[p83] then
		u1.busyTags[p83] = nil;
	end;
end;
function v16.ClearBetweenPoints(p85, p86, p87)
	local v384, v385, v386, v387 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p85, p86 - p85), p87);
	if v384 then
		return false;
	end;
	return true;
end;
function v16.GetDictionaryLength(p88)
	local v388 = 0;
	for v389, v390 in next, p88 do
		v388 = v388 + 1;
	end;
	return v388;
end;
u1 = v16;
return nil;
