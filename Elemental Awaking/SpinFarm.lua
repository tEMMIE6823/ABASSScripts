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
local function RollSpell()
	return Spin:InvokeServer(false)
end

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
				wait(0.2)
				CastCurrentSpell()
			end
		end
		pcall(function()
			repeat wait()
				CastAllSpells()
			until tonumber(plyrs.LocalPlayer.PlayerGui.Main.StatsGUI.Level.Level.Text) >= 2
		end)
		game.Players.LocalPlayer.Character:BreakJoints()
		
		local spellrolled, rarity = RollSpell()
		if table.find(Config.WantedSpells, spellrolled) then
			print ("Rolled wanted spell " .. spellrolled .. " rarity of " .. rarity)
			print ("Correctly got wanted spell :)")
			Dispose()
			return
		end
		print ("Rolled spell " .. spellrolled .. " rarity of " .. rarity)
	end
end
