-- Decompiled with the Synapse X Luau decompiler.
-- Fixed up by yeemi<3#9764

--//     Services     //--
local rns = game:GetService("RunService")
local rs = game:GetService("ReplicatedStorage")
local cs = game:GetService("CollectionService")
local uis = game:GetService("UserInputService")
local rsc = workspace:WaitForChild("Resources")

--//     Variables     //--
local gameModules = rs:WaitForChild("Modules")
local itemData = require(gameModules:WaitForChild("ItemData"))
local lp = game.Players.LocalPlayer

local pickupNametag = script.Parent.PickupBillboard
local originalTick = tick()

--//     Functions     //--
function AssessLineOfSight(input)
	local pramas = RaycastParams.new();
	pramas.FilterDescendantsInstances = { workspace.Terrain, workspace.Deployables };
	pramas.IgnoreWater = true;
	pramas.FilterType = Enum.RaycastFilterType.Whitelist;
	if workspace:Raycast(_G.root.Position, input.PrimaryPart.Position - _G.root.Position, pramas) then
		return
	end
	return true
end

function AssessProximity(input)
	if (_G.root.Position - (input:IsA("Model") and input.PrimaryPart or input:FindFirstDescendantWhichIsA("BasePart")).Position).magnitude <= 25 then else
		return
	end
	return true
end

function GetNearestItem(input)
	local item = nil
	local prevDis = math.huge
	local lastItem = nil
	while true do
		local tmpItem, index = next(input, lastItem)
		if not tmpItem then
			break
		end
		lastItem = tmpItem
		local distance = (_G.root.Position - tmpItem.PrimaryPart.Position).magnitude
		if distance < prevDis then
			item = tmpItem
			prevDis = distance
		end	
	end
	return item
end

function GetNearbyItems()
	local itemsTable = {}
	local pramas = OverlapParams.new()
	pramas.FilterDescendantsInstances = { workspace.Items }
	pramas.FilterType = Enum.RaycastFilterType.Whitelist
	local input = workspace:GetPartBoundsInRadius(_G.root.Position, 25, pramas)
	local lastItem = nil
	while true do
		local item, index = next(input, lastItem)
		if not item then
			break
		end
		lastItem = item
		local object = index:FindFirstAncestorWhichIsA("Model")
		if itemData[object.Name] then
			if AssessLineOfSight(object) then
				itemsTable[object] = true
			end
		end	
	end
	return itemsTable
end

function AppertainTags()
	if _G.alive then
		if not _G.root then
			pickupNametag.Adornee = nil
			pickupNametag.Enabled = false
			return
		end
	else
		pickupNametag.Adornee = nil
		pickupNametag.Enabled = false
		return
	end
	local item = GetNearestItem((GetNearbyItems()))
	if not item then
		pickupNametag.Adornee = nil
		pickupNametag.Enabled = false
		return
	end
	pickupNametag.Frame.ItemNameLabel.Text = item.Name or itemData[item.Name].alias
	pickupNametag.Adornee = item
	pickupNametag.Enabled = true
end

while true do
	AppertainTags()
	while true do
		rns.RenderStepped:wait()
		if originalTick - tick() >= 0.3 then
			break
		end	
	end
end
