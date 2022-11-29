local humanoid = game.Players.LocalPlayer.Character.Humanoid

getgenv()._hi = true
while _hi do wait()
	if humanoid.Health <= 50 then
		function _w()
			wait(0.1)
			game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("Bloodfruit")
		end
		repeat _w() until humanoid.Health == 100
	end
end
