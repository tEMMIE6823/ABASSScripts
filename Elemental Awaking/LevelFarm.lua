--//     Config     //--
local Config = {
	WantedSpells = {"Time", "Reality Collapse", "Celestial"}
}

--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local vu = game:GetService("VirtualUser")
local plyrs = game:GetService("Players")

--//     Services     //--
local Events = rs.Events

local Spin = Events.Spin
local Spawn = Events.Spawn2

--//     Functions     //--
local function CastCurrentSpell()
	vu:CaptureController()
	vu:ClickButton1(Vector2.new(100, 100))
end

local function UnequipSpells()
	for i,v in ipairs(plyrs.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = plyrs.LocalPlayer.Backpack
		end
	end
end

local function GetSpells()
	local spells = {}
	UnequipSpells()
	for i,v in ipairs(plyrs.LocalPlayer.Backpack:GetChildren()) do
		table.insert(spells, v)
	end
	return spells
end

local function EquipSpell(index)
	UnequipSpells()
	local spells = GetSpells()
	spells[index].Parent = plyrs.LocalPlayer.Character
end

brk = false
if Dispose then Dispose() end
function _G.Dispose()
	brk = true
end

--//     Code     //--
while task.wait() and not brk do
	if Spawn:InvokeServer() then
		local function CastAllSpells()
			for i=1,#GetSpells() do
				EquipSpell(i)
				wait()
				CastCurrentSpell()
			end
		end
		
		pcall(function()
			while task.wait() do
				local mana = string.split(plyrs.LocalPlayer.PlayerGui.Main.StatsGUI.MagicEnergyGUI.ME.Text, "/")
				CastAllSpells()
				if tonumber(mana[1]) <= tonumber(mana[2] / 3) then
					game.Players.LocalPlayer.Character:BreakJoints()
					wait(6)
				end
			end
		end)
	end
end
