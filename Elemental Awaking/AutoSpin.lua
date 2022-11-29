--//     Config     //--
local Config = {
	WantedSpells = {"Time", "Reality Collapse", "Celestial"}
}

--//     Services     //--
local rs = game:GetService("ReplicatedStorage")

--//     Services     //--
local Events = rs.Events

local Spin = Events.Spin

--//     Functions     //--
local function RollSpell()
	return Spin:InvokeServer(false)
end

--//     Code     //--
while task.wait() do
	local a, b = RollSpell()
	if table.find(Config.WantedSpells, a) then
		print ("Rolled wanted spell " .. a .. " rarity of " .. b)
		print ("Correctly got wanted spell :)")
		return
	elseif a == nil then
		print("Out of rolls")
		return
	end
	print ("Rolled spell " .. a .. " rarity of " .. b)
end
