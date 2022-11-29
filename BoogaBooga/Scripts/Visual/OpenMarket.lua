--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local plyrs = game:GetService("Players")

--//     Booga Utils     //--
local bank = require(rs.Modules["Client_Function_Bank"])

--//     Code     //--
local maingui = plyrs.LocalPlayer.PlayerGui.MainGui
local topbaricons = maingui.Panels.Topbar.Right.Navigation

bank.OpenGui()
bank.ClearMouseBoundStructure()

maingui.LeftPanel.Market.Visible = true
maingui.RightPanel.Market.Visible = true
