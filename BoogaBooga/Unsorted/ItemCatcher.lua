local rs = game:GetService("ReplicatedStorage")

local chr = game.Players.LocalPlayer.Character

while wait() do
	for i,v in ipairs(game:GetService("Workspace").Items:GetChildren()) do
		if v.Parent == game:GetService("Workspace").Items and v.Name ~= "Peeper Popsicle" and v.Name ~= "Hide" and v.Name ~= "Stick" and v.Name ~= "Raw Fish" and v.Name ~= "Log" and v.Name ~= "Wood Coin" and v.Name ~= "Ice Cube" and v.Name ~= "Leaves" and v.Name ~= "Stone" and v.Name ~= "Raw Meat" and v.Name ~= "Egg" and v.Name ~= "Barley" then
			local s,r = pcall(function()
				chr:FindFirstChild("HumanoidRootPart").CFrame = v.CFrame * CFrame.new(Vector3.new(0,2,0))
				wait(0.1)
			end)
			
			if not s then
				pcall(function()
					chr:FindFirstChild("HumanoidRootPart").CFrame = v:GetChildren()[1].CFrame * CFrame.new(Vector3.new(0,2,0))
					wait(0.1)
				end)
			end
		end
	end
end
