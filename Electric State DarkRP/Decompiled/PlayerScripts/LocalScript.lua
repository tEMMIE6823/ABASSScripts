-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__TweenService__3 = game:GetService("TweenService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Client__5 = l__LocalPlayer__1:WaitForChild("PlayerGui"):WaitForChild("Client");
local l__CarEvent__6 = l__ReplicatedStorage__2:WaitForChild("Events"):WaitForChild("CarEvent");
local v7 = require(l__ReplicatedStorage__2.Modules.NOT);
local u1 = require(l__ReplicatedStorage__2.Modules.VC);
l__ReplicatedStorage__2:WaitForChild("Events"):WaitForChild("BikeEvent").OnClientEvent:connect(function(p1)
	u1.Initiate(true, p1);
end);
local u2 = require(l__ReplicatedStorage__2.Modules.VC2);
l__CarEvent__6.OnClientEvent:connect(function(p2)
	u2.Initiate(true, p2);
end);
local v8 = require(l__ReplicatedStorage__2.Modules.SO);
local v9 = require(l__ReplicatedStorage__2.Modules.EP);
local v10 = require(l__ReplicatedStorage__2.Modules.AUD);
local v11 = require(l__ReplicatedStorage__2.Modules.CAT);
local v12 = require(l__ReplicatedStorage__2.Modules.RG);
local v13 = require(l__ReplicatedStorage__2.Modules.CAM);
local v14 = require(l__ReplicatedStorage__2.Modules.MS);
local v15 = require(l__ReplicatedStorage__2.Modules.WE);
local v16 = require(l__ReplicatedStorage__2.Modules.AtomOasis.STAT);
local v17 = require(l__ReplicatedStorage__2.Modules.AtomOasis.BD);
local v18 = require(l__ReplicatedStorage__2.Modules.TS["MEL-SHO"].ISL);
local v19 = require(l__ReplicatedStorage__2.Modules.TS["MEL-FD"].MB);
local v20 = require(l__ReplicatedStorage__2.Modules.TS["MEL-ML"].GEN);
local v21 = require(l__ReplicatedStorage__2.Modules.TS["MEL-GHO"].GHO);
local v22 = require(l__ReplicatedStorage__2.Modules.TS["MEL-OWL"].Owl);
local u3 = require(l__ReplicatedStorage__2.Modules.INV);
local u4 = require(l__ReplicatedStorage__2.Modules.BM);
local u5 = require(l__ReplicatedStorage__2.Modules.CHR);
local u6 = require(l__ReplicatedStorage__2.Modules.FLY);
local u7 = require(l__ReplicatedStorage__2.Modules.INT);
local u8 = require(l__ReplicatedStorage__2.Modules.MNU);
local u9 = require(l__ReplicatedStorage__2.Modules.WHL);
l__UserInputService__4.InputBegan:connect(function(p3)
	if l__UserInputService__4:GetFocusedTextBox() == nil then
		if l__LocalPlayer__1.Character:FindFirstChild("Guitar") then
			return;
		end;
		if p3.KeyCode == Enum.KeyCode.B then
			if l__Client__5.Inventory.Visible then
				u3.ToggleInventory();
			end;
			if l__Client__5.Menu.Visible then
				l__Client__5.Menu.ConfirmBox.Visible = false;
				l__Client__5.Menu.BuildingBuddies.Visible = false;
				l__Client__5.Menu.Visible = false;
			end;
			u4.EnterBuildMode();
			return;
		end;
		if p3.KeyCode == Enum.KeyCode.LeftAlt then
			u5.SetWalkState(1);
			return;
		end;
		if p3.KeyCode == Enum.KeyCode.LeftShift then
			u5.SetWalkState(2);
			return;
		end;
		if p3.KeyCode == Enum.KeyCode.R then
			if l__LocalPlayer__1.PlayerGui.Building.Enabled then
				if l__Client__5.Advice.Edit.Visible then
					u4.SwitchEdit();
					return;
				else
					u4.toggleRotating(true);
					return;
				end;
			end;
		elseif p3.KeyCode == Enum.KeyCode.Y then
			if l__LocalPlayer__1.Character.Util:FindFirstChild("Jetpack") then
				u6.ToggleJetpack();
				return;
			end;
			if l__LocalPlayer__1.Character.Util:FindFirstChild("OwlMask") then
				OwlModule.TransformInto();
				return;
			end;
		else
			if p3.KeyCode == Enum.KeyCode.E then
				if l__LocalPlayer__1.PlayerGui.Building.Enabled then
					u4.ToggleSurfaceAttach();
					return;
				else
					u7.Interact();
					return;
				end;
			end;
			if p3.KeyCode == Enum.KeyCode.U then
				u7.RPT();
				return;
			end;
			if p3.KeyCode == Enum.KeyCode.H then
				u3.DropTool();
				return;
			end;
			if p3.KeyCode == Enum.KeyCode.V then
				u7.Store();
				return;
			end;
			if p3.KeyCode == Enum.KeyCode.G then
				if l__LocalPlayer__1.PlayerGui.Building.Enabled then
					u4.EnterBuildMode();
				end;
				u3.ToggleInventory();
				return;
			end;
			if p3.KeyCode == Enum.KeyCode.F then
				if l__LocalPlayer__1.PlayerGui.Building.Enabled == true then
					if l__Client__5.Advice.Edit.Visible then
						u4.ResetOrientation();
						return;
					else
						u4.toggleHeight(true);
						return;
					end;
				else
					u7.PickUp();
					return;
				end;
			end;
			if p3.KeyCode == Enum.KeyCode.X then
				if l__LocalPlayer__1.PlayerGui.Building.Enabled == true then
					u4.DestroyObj();
					return;
				end;
			else
				if p3.KeyCode == Enum.KeyCode.C then
					u8.Flag();
					return;
				end;
				if p3.KeyCode == Enum.KeyCode.J then
					if l__LocalPlayer__1.PlayerGui.Building.Enabled == true then
						u4.switchLocalOrGlobal();
						return;
					end;
				else
					if p3.KeyCode == Enum.KeyCode.Q then
						_G.ML();
						return;
					end;
					if p3.KeyCode == Enum.KeyCode.N then
						u9.ToggleWheel();
						return;
					end;
					if p3.KeyCode == Enum.KeyCode.Z then
						if l__LocalPlayer__1.PlayerGui.Building then
							u4.Inc();
							return;
						end;
					elseif p3.KeyCode == Enum.KeyCode.T then
						if l__LocalPlayer__1.PlayerGui.Building.Enabled then
							u4.EnterBuildMode();
						end;
						u8.ToggleMenu();
						return;
					elseif p3.UserInputType == Enum.UserInputType.MouseButton1 then
						u9.UseWheel();
					end;
				end;
			end;
		end;
	end;
end);
l__UserInputService__4.InputEnded:connect(function(p4)
	if l__UserInputService__4:GetFocusedTextBox() == nil then
		if p4.KeyCode == Enum.KeyCode.R then
			u4.toggleRotating(false);
			return;
		end;
		if p4.KeyCode == Enum.KeyCode.LeftShift then
			u5.SetWalkState(1);
			return;
		end;
		if p4.KeyCode ~= Enum.KeyCode.F then
			if p4.KeyCode == Enum.KeyCode.E then
				u7.InteractEnded();
			end;
			return;
		end;
	else
		return;
	end;
	u4.toggleHeight(false);
end);
local l__HM__10 = l__ReplicatedStorage__2:WaitForChild("Samples"):WaitForChild("HM");
local l__TweenService__11 = game:GetService("TweenService");
function HitMarker(p5, p6)
	local v23 = l__HM__10:Clone();
	v23.CFrame = CFrame.new(p5.Parent.PrimaryPart.Position);
	v23.Parent = l__LocalPlayer__1.PlayerGui;
	local v24 = p5.Parent:GetAttribute("Armor");
	if v24 then
		if 0 < v24 then
			v23.BillboardGui.TextLabel.TextColor3 = Color3.new(0.772549, 0.835294, 1):Lerp(Color3.new(0.34902, 0.384314, 0.882353), v24 / 100);
			p6 = math.floor(p6 - p6 * (v24 / 100));
			if p6 <= 0 then
				p6 = 1;
			end;
		end;
	end;
	v23.BillboardGui.TextLabel.Text = p6;
	v23.BillboardGui.TextLabel:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.2, true);
	spawn(function()
		wait(0.2);
		l__TweenService__11:Create(v23.BillboardGui.TextLabel, TweenInfo.new(0.8), {
			TextTransparency = 1, 
			TextStrokeTransparency = 1, 
			Position = UDim2.new(math.random(-50, 50) / 100, 0, 0.3, 0), 
			Rotation = math.random(-35, 35)
		}):Play();
		game.Debris:AddItem(v23, 1);
	end);
end;
game.ReplicatedStorage.Events:WaitForChild("HitMarkerEvent").OnClientEvent:Connect(HitMarker);
local function v25(p7)
	p7:WaitForChild("Humanoid").Died:Connect(function()
		v12(p7);
	end);
	v16.CharacterAdded();
end;
for v26, v27 in pairs(game.Players:GetChildren()) do
	v27.CharacterAdded:Connect(v25);
	if v27.Character and v27.Character:FindFirstChild("Humanoid") then
		v25(v27.Character);
	end;
end;
game.Players.PlayerAdded:Connect(function(p8)
	p8.CharacterAdded:Connect(v25);
end);
local u12 = 0;
local u13 = { game.Workspace.Terrain, game.Workspace.Map.Infestructure, game.Workspace.WorldEvent };
local u14 = 0;
local l__FlagWinds__28 = l__Client__5:WaitForChild("SFX"):WaitForChild("FlagWinds");
l__FlagWinds__28.Volume = 0;
l__FlagWinds__28:Play();
local u15 = 0;
function _G.RC(p9)
	u15 = p9;
end;
local u16 = tick();
local u17 = 0;
local function u18(p10, p11, p12)
	return p10 + (p11 - p10) * p12;
end;
local function u19(p13)
	return math.clamp((p13 - 32) / 43, 0, 1);
end;
local l__CurrentCamera__20 = game.Workspace.CurrentCamera;
function WindSpeeds()
	u17 = u18(u17, u19(u5:ChrVelocity().Magnitude), 0.1);
	l__FlagWinds__28.Volume = u17;
	l__FlagWinds__28.PlaybackSpeed = u17;
	local v29 = l__FlagWinds__28.Volume + u15;
	u15 = math.clamp(u15 - 0.05, 0, 3);
	l__CurrentCamera__20.CoordinateFrame = l__CurrentCamera__20.CoordinateFrame * CFrame.fromEulerAnglesXYZ(math.sin(tick() * 10) * 0.001 * v29, math.sin(tick() * 20) * 0.001 * v29, 0);
	l__CurrentCamera__20.FieldOfView = 65 + l__FlagWinds__28.Volume * 20;
end;
local function u21()
	if tick() - u12 >= 1 then
		u12 = tick();
		if l__LocalPlayer__1.Character.PrimaryPart then
			local v30, v31 = game.Workspace:FindPartOnRayWithWhitelist(Ray.new(l__LocalPlayer__1.Character.PrimaryPart.Position, Vector3.new(0, -256, 0)), u13);
			if v31.Y < 72 then
				u14 = u14 + 1;
			else
				u14 = 0;
			end;
		end;
		if u14 >= 6 and l__LocalPlayer__1.Character:FindFirstChild("Humanoid") then
			l__LocalPlayer__1.Character.Humanoid:Destroy();
		end;
	end;
end;
local function u22()
	if tick() - u16 > 0.1 then
		u16 = tick();
		v10.CheckArea();
		u4.CheckKillzones();
		u3.updateCooldownWindow();
	end;
end;
game:GetService("RunService"):BindToRenderStep("RenderUpdate_Wind", 0, WindSpeeds);
game:GetService("RunService").Heartbeat:Connect(function(p14)
	v8.UpdateSound();
	u5:UpdateCharacter();
	u5:Update(p14);
	v9.UpdateProjectiles(p14);
	u8.updateHotspot();
	u7.updateItemHeldNotNil();
	u21();
	u2.updateOtherCarWheels();
	v18.Update();
	u22();
end);
local u23 = l__TweenService__3:Create(game.Lighting.Combat, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
	Intensity = 0
});
function _G.Combat()
	if l__LocalPlayer__1.Flagged.Value and os.time() - l__LocalPlayer__1.Flagged.FlagTick.Value >= 120 then
		game.Lighting.Combat.Intensity = 0.2;
		u23:Play();
	end;
end;
game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(1);
local v32 = { "Money Printers print 3x their value, then destroy themselves.", "The prop limit to building is 150 props.", "Money Printers are illegal are are to be seeked out by Soldiers and Government roles.", "T > Actions gives all the basic actions used for Building, PVP, and Customization.", "T > Shop is used to purchase Ammo, Printers, and role assigned shipments.", "Build with friends by making them your building buddy! T > Actions > Building", "Watch out for Thieves they can lockpick and steal things like shipments and your dignity.", "Find a Gun Dealer to buy yourself some weapons.", "Hire a Guard to protect your Shop!", "Hire a Bounty Hunter to get rid of those unwanted players.", "Soldiers, use your Baton to destroy Printers.", "Soldiers earn 33% of the earnings left to print in printers.", "Bounty Hunters can set their own cost in T > Actions", "The earlier a Soldier finds a printer the more money they will get!", "The Mayor can host lotteries and other social events of their choosing.", "Build a secure shop to prevent losing your shipments as a merchant.", "Merchants should open shops to sell to other players.", "Use /ad to Advertise across the server.", "Store your items before you leave! Drop them with H and Store them with V.", "If your Karma drops below 0 you cant kill passive players anymore.", "The giant sphere that appears after you die goes away. Called NLR or New Life Rule.", "Chef's and Bartenders sell Bloxy cola to other players using T > Shop." };
local l__TextLabel__24 = l__LocalPlayer__1.PlayerGui:WaitForChild("TopBar"):WaitForChild("Frame"):WaitForChild("TextLabel");
local u25 = math.random(1, #v32);
spawn(function()
	while true do
		l__TextLabel__24.Text = v32[u25];
		u25 = u25 + 1;
		if #v32 < u25 then
			u25 = 1;
		end;
		wait(10);	
	end;
end);
game.StarterGui:SetCore("ChatMakeSystemMessage", {
	Text = "Proximity chat enabled, type /ad to advertize to the server.", 
	Font = Enum.Font.SourceSansBold, 
	Color = BrickColor.new("Bright yellow").Color
});
game.StarterGui:SetCore("ChatMakeSystemMessage", {
	Text = "Proximity chat enabled; you can only hear players within 60 studs.", 
	Font = Enum.Font.SourceSansBold, 
	Color = BrickColor.new("Bright blue").Color
});
pcall(function()
	game:GetService("Chat"):RegisterChatCallback(Enum.ChatCallbackType.OnCreatingChatWindow, function()
		return {
			BubbleChatEnabled = true
		};
	end);
end);
local l__Buildings__33 = game.Workspace:WaitForChild("Buildings");
local u26 = l__Buildings__33:GetChildren();
function updateLOD()
	local v34, v35, v36 = pairs(u26);
	while true do
		local v37, v38 = v34(v35, v36);
		if v37 then

		else
			break;
		end;
		v36 = v37;
		if game.Players:FindFirstChild(v38.Name) ~= nil then
			if 350 <= l__LocalPlayer__1:DistanceFromCharacter(v38.Node.PrimaryPart.Position) then
				v38.Parent = nil;
			elseif v38.Parent ~= l__Buildings__33 then
				v38.Parent = l__Buildings__33;
			end;
		else
			table.remove(u26, v38);
		end;	
	end;
end;
function _G.ToggleHotbar(p15)
	if not p15 then
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
		return;
	end;
	if u7.GetInteractingWith() ~= nil then
		return;
	end;
	if l__LocalPlayer__1.Character.Humanoid.Sit then
		return;
	end;
	if l__LocalPlayer__1.PlayerGui.Building.Enabled then
		return;
	end;
	if l__LocalPlayer__1.Character:FindFirstChild("Head") and l__LocalPlayer__1.Character.Head.Transparency >= 66 then
		return;
	end;
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
end;
