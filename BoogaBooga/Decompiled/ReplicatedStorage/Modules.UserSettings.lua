-- Decompiled with the Synapse X Luau decompiler.

return { {
		name = "muteMusic", 
		default = false, 
		interactType = "Switch", 
		description = "Mute radios and game music"
	}, {
		name = "muteInvitations", 
		default = false, 
		interactType = "Switch", 
		description = "Mute tribe invitations"
	}, {
		name = "streamerMode", 
		default = false, 
		interactType = "Switch", 
		description = "Streamer Mode"
	}, {
		name = "camLock", 
		default = false, 
		interactType = "Switch", 
		description = "Camera lock"
	}, {
		name = "eatHotkey", 
		default = false, 
		interactType = "Switch", 
		description = "Enable Q to eat from inventory"
	}, {
		name = "panelTranslucency", 
		default = false, 
		interactType = "Switch", 
		description = "Toggle user interface translucency"
	}, {
		name = "pickupStyle", 
		default = "Hover", 
		interactType = "Dropdown", 
		description = "Pickup Style", 
		possible = { "Proximity", "Click", "Hover" }
	}, {
		name = "uiPanelScale", 
		default = "Large", 
		interactType = "Dropdown", 
		description = "Size of user interface", 
		possible = { "Small", "Medium", "Large" }
	} };
