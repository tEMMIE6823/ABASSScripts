local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

game:GetService("ReplicatedStorage").Events.PlaceStructure:FireServer(
    "Stone Wall",
    CFrame.new(pos.Position) * CFrame.Angles(math.rad(90), 0, 0),
    -3537.6009510084987
)
