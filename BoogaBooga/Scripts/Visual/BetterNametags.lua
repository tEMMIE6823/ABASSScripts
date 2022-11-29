--//     Services     //--
local plyrs = game:GetService("Players")
shared.boogaNametags = true

--//     Functions     //--
local function ReplaceNametag(character)
	local healthui = character:FindFirstChild("HealthGui")
	local nameui = character:FindFirstChild("NameGui")
	
	repeat wait() until nameui and nameui.TextLabel and nameui.TextLabel:IsA("TextLabel") and nameui.TextLabel.Text ~= nil
	-- ?????
	
	if plyrs:GetPlayerFromCharacter(character).Name ~= nameui.TextLabel.Text then
		nameui.TextLabel.Text = plyrs:GetPlayerFromCharacter(character).Name -- stream tag removed
	end
	
	healthui.Size = UDim2.new(3.5,0,.5,0)
	healthui.ExtentsOffset = Vector3.new(0,1.2,0)
	nameui.ExtentsOffset = Vector3.new(0,1.2,0)
	
	local healthSlider = healthui:FindFirstChild("Slider")
	local healthSliderBackground = healthSlider:Clone()
	healthSliderBackground.ImageTransparency = 0.7
	healthSliderBackground.Parent = healthui
	healthSliderBackground.Size = UDim2.new(1,0,1,0)
	local healthAmount = nameui.TextLabel:Clone()
	healthAmount.Parent = healthui
	healthAmount.Text = "100%"
	healthAmount.Position = UDim2.new(0,0,0,0)
	healthAmount.Size = UDim2.new(1,0,1,0)
	healthAmount.TextColor3 = Color3.new(255,255,255)
	
	coroutine.wrap(function()
		while wait() do
			local hum = character:FindFirstChild("Humanoid")
			
			if character.Head:FindFirstChild("LogNotice") then
				character.Head:FindFirstChild("LogNotice").Enabled = false
				nameui.TextLabel.Text = "*" .. ((plyrs:GetPlayerFromCharacter(character) and plyrs:GetPlayerFromCharacter(character).Name) or "Unknown")
			else
				nameui.TextLabel.Text = ((plyrs:GetPlayerFromCharacter(character) and plyrs:GetPlayerFromCharacter(character).Name) or "Unknown")
			end
			healthAmount.Text = math.floor(hum.Health) .. "%"
			
			local healthbarColor = Color3.fromHSV((hum.Health/130)*.3, 1, 1) 
			healthSlider.ImageColor3 = healthbarColor
			healthSliderBackground.ImageColor3 = healthbarColor
		end
	end)()
end

--//     Code     //--
local function hook(plr)
	plr.CharacterAdded:Connect(function(character)
		wait()
		ReplaceNametag(character)
	end)
end
plyrs.PlayerAdded:Connect(function(player)
	wait()
	hook(player)
end)
for i,v in ipairs(plyrs:GetPlayers()) do
	spawn(function()
		hook(v)
		ReplaceNametag(v.Character)
	end)
end
