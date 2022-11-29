-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by yeemi<3#9764

--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local rns = game:GetService("RunService")
local cs = game:GetService("CollectionService")
local rsc = workspace:WaitForChild("Resources")
local uis = game:GetService("UserInputService")

--//     Variables     //--
local lp = game.Players.LocalPlayer
local mouse = lp:GetMouse()

local gameModules = rs:WaitForChild("Modules")
local itemData = require(gameModules:WaitForChild("ItemData"))

local originalTick = tick()
local pickupNametag = script.Parent.Parent.PickupBillboard

function AssessLineOfSight(input)
	local partPos = nil
	if input:IsA("BasePart") then
		partPos = input.Position
	elseif input:IsA("Model") then
		partPos = input.PrimaryPart.Position
	end
	local pramas = RaycastParams.new()
	pramas.FilterDescendantsInstances = { workspace.Terrain, workspace.Deployables }
	pramas.IgnoreWater = true
	pramas.FilterType = Enum.RaycastFilterType.Whitelist
	if not workspace:Raycast((_G.root.CFrame * CFrame.new(0, 1.5, 0)).Position, partPos - _G.root.Position, pramas) then

	else
		return
	end
	return true
end

function AssessProximity(input)
	local inputPos = nil
	if input:IsA("BasePart") then
		inputPos = input.Position
	elseif input:IsA("Model") then
		inputPos = input.PrimaryPart.Position
	end
	if not ((_G.root.Position - inputPos).magnitude <= 25) then
		return
	end
	return true
end

function GetNearestItem(input)
	local nearestItem = nil
	local closestDistance = math.huge
	
	while true do
		local nextItem, index = next(input, nil)
		if not nextItem then
			break
		end
		if uis.KeyboardEnabled then
			local plrPos = mouse.Hit.Position
		else
			plrPos = _G.root.Position
		end
		local itemPos = nil
		if nextItem:IsA("BasePart") then
			itemPos = nextItem.Position
		elseif nextItem:IsA("Model") then
			itemPos = nextItem.PrimaryPart.Position
		end
		local distance = (plrPos - itemPos).magnitude
		if distance < closestDistance then
			nearestItem = nextItem
			closestDistance = distance
		end	
	end
	return nearestItem
end

function GetNearbyItems()
	local items = {}
	
	local pramas = OverlapParams.new()
	pramas.FilterType = Enum.RaycastFilterType.Whitelist
	pramas.FilterDescendantsInstances = { workspace.Items, workspace.Resources, workspace.Deployables }
	
	if uis.KeyboardEnabled then
		local pos = mouse.Hit.Position
	else
		pos = _G.root.Position
	end
	
	local object = workspace:GetPartBoundsInRadius(pos, 25, pramas)
	while true do
		local tmpItem, index = next(object, nil)
		if not tmpItem then
			break
		end
		local canPickup = nil
		if index:GetAttribute("Pickup") then
			canPickup = index
		elseif index.Parent:IsA("Model") then
			if index.Parent:GetAttribute("Pickup") then
				canPickup = index.Parent
			end
		end
		if canPickup then
			items[canPickup] = true
		end	
	end
	return items
end

function AdornBillboard(input)
	if _G.alive then
		if _G.root then
			if input then
				if itemData[input.Name] then
					pickupNametag.Frame.ItemNameLabel.Text = input.Name or itemData[input.Name].alias
					pickupNametag.Adornee = input
					pickupNametag.Enabled = true
					return
				end
			else
				pickupNametag.Adornee = nil
				pickupNametag.Enabled = false
			end
		else
			pickupNametag.Adornee = nil
			pickupNametag.Enabled = false -- sleepy brb
		end
	else
		pickupNametag.Adornee = nil
		pickupNametag.Enabled = false
	end
end

--//     Code     //--
repeat task.wait() until _G.Data and _G.Data.userSettings -- wait

local proximityPrompt = {
	Proximity = {
		getItem = function()
			return GetNearestItem((GetNearbyItems()))
		end, 
		key = Enum.KeyCode.E
	}
}
local clickPramas = {}
local proximityPart = nil
function clickPramas.getItem()
	return proximityPart.Hover.getItem()
end
clickPramas.key = Enum.UserInputType.MouseButton1
proximityPrompt.Click = clickPramas
local hoverModule = {}
function hoverModule.getItem()
	if uis.TouchEnabled then
		return proximityPart.Proximity.getItem()
	end
	
	local mouseTarget = mouse.Target
	local tmpObj = mouseTarget
	
	if not _G.Data or not mouseTarget or not mouseTarget:IsDescendantOf(workspace.Items) and mouseTarget.Parent.Name ~= "Contents" and mouseTarget.Parent.Parent.Name ~= "Contents" then
		return
	end
	
	while not nil do -- soy sauce man should be using repeat **x** func until **x**
		local folder = tmpObj.Parent
		if folder == workspace.Items then
			break
		elseif folder.Name == "Contents" then
			break
		elseif folder == workspace then
			break
		elseif folder == nil then
			break
		end
		tmpObj = folder	
	end
	
	if tmpObj then
		local tmpObj2 = tmpObj
		if tmpObj:IsA("Model") then
			tmpObj2 = tmpObj.PrimaryPart
		end
		if (tmpObj2.Position - lp.Character.PrimaryPart.Position).magnitude > 25 then
			return
		end
	end
	return tmpObj
end
hoverModule.key = Enum.KeyCode.E
proximityPrompt.Hover = hoverModule
promptClone = proximityPrompt
local style = _G.Data.userSettings.pickupStyle and "Hover"
script.Parent.Parent.TogglePickupMode.Event:connect(function(input)
	style = input
end)
local proximityPart = nil
uis.InputBegan:Connect(function(input, handled)
	if handled then
		return
	end
	if input.KeyCode.Name ~= "Unknown" then
		local key = input.KeyCode
		if not key then
			key = false
			if input.UserInputType.Name ~= "Unknown" then
				key = input.UserInputType
			end
		end
	else
		key = false
		if input.UserInputType.Name ~= "Unknown" then
			key = input.UserInputType
		end
	end
	if proximityPart then
		if proximityPart:IsA("Model") then
			local distance = lp:DistanceFromCharacter(proximityPart.PrimaryPart.Position)
		else
			distance = lp:DistanceFromCharacter(proximityPart.Position)
		end
		if distance <= 25 and (promptClone[style].key == key or input.UserInputType == Enum.UserInputType.Touch) then
			proximityPart.Parent = nil
			local tmpPart = proximityPart:Clone()
			tmpPart.Parent = workspace.CurrentCamera
			bank.CollectPart(tmpPart)
			if not game.ReplicatedStorage.Events.PickupItem:InvokeServer(proximityPart) and proximityPart then
				proximityPart.Parent = proximityPart.Parent
			end
		end
	end
end)

local originalTick_2_ = originalTick

rns.RenderStepped:Connect(function()
	if style and promptClone[style] and (promptClone[style].scanRate and 0) <= tick() - originalTick_2_ then
		originalTick_2_ = tick()
		proximityPart = promptClone[style].getItem()
		AdornBillboard(proximityPart)
	end
	local pup_1_ = not uis.KeyboardEnabled or _G.Data.userSettings.pickupStyle == "Click"
	pickupNametag.Frame.ButtonIcon.TouchIcon.Visible = pup_1_
	local pup_2_ = uis.KeyboardEnabled and _G.Data.userSettings.pickupStyle ~= "Click"
	pickupNametag.Frame.ButtonIcon.HotkeyLabel.Visible = pup_2_
end)
