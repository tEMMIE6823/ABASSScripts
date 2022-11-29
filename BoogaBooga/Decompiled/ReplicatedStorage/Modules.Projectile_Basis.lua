-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by mrk0#4119

local clientArrowData = {
	position = Vector3.new(-6, 130.5, -15), 
	velocity = Vector3.new(0, 100, 300), 
	acceleration = Vector3.new(0, -196.2, 0), 
	object = workspace:WaitForChild("Arrow")
};
wait(1);
game:GetService("RunService").RenderStepped:Connect(function(input)
	clientArrowData.velocity = clientArrowData.velocity + clientArrowData.acceleration * input;
	clientArrowData.position = clientArrowData.position + clientArrowData.velocity * input;
	clientArrowData.object.CFrame = CFrame.new(clientArrowData.position, clientArrowData.position + (clientArrowData.position - clientArrowData.position));
end);

