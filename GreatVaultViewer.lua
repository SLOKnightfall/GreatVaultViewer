--	///////////////////////////////////////////////////////////////////////////////////////////
--
--	Great Vault Viewer
--	Author: SLOKnightfall

--	Shows the Great Vault from the PvP tab, Mythic Keystone Tab, Keybind, LDB or Minimap icon
--
--	///////////////////////////////////////////////////////////////////////////////////////////

local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0")
local minimapIcon = LibStub("LibDBIcon-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

--Registers for LDB addons
local GreatVaultViewerLDB = LibStub("LibDataBroker-1.1"):NewDataObject(addonName, {
	type = "data source",
	text = "Great Vault Viewer",
	icon = "Interface/Challenges/ChallengeModeTab",
	iconCoords = {0.245605, 0.436035, 0.000976562, 0.336914},
	OnClick = function(self, button, down) 
		addon:ToggleVault()
	end,})


local options = {
	name = "GreatVaultViewer",
	handler = addon,
	type = 'group',
	childGroups = "tab",
	inline = true,
	args = {
		settings={
			name = "Options",
			type = "group",
			--inline = true,
			order = 0,
			args={
				showMiniMapIcon = {
					order = 1,
					name = L["Show Minimap Icon"] ,
					type = "toggle",
					set = function(info,val) GreatVaultViewerLDB:Toggle(val) end,
					get = function(info) return addon.db.profile.showMiniMapIcon end,
					width = 1.5,
				},
			},
		},	
	},
}

local defaults =  {
	profile = { 
		minimap = { hide = false, },
		showMiniMapIcon = true,
	},

}


function GreatVaultViewerLDB:Toggle(value)
		if value then
			minimapIcon:Show(addonName)
			addon.db.profile.minimap.hide = false;
			addon.db.profile.showMiniMapIcon = true;
		else
			minimapIcon:Hide(addonName)
			addon.db.profile.minimap.hide = true;
			addon.db.profile.showMiniMapIcon = false;
		end
end


function addon:OnInitialize()
	addon:RegisterEvent("ADDON_LOADED", "EventHandler" )

	self.db = LibStub("AceDB-3.0"):New("GreatVaultViewer_Options", defaults, true)
	--options.args.profiles  = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, addonName)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName,addonName)

	--GreatValutViewerMiniMap:Register("GreatValutViewerMiniMap", GreatVaultViewerLDB, addon.db.MMDB)
	minimapIcon:Register(addonName, GreatVaultViewerLDB, self.db.profile.minimap)
	
end


function addon:EventHandler(event, arg1 )
	if event == "ADDON_LOADED" and arg1 == "Blizzard_WeeklyRewards" then 
		tinsert(UISpecialFrames, WeeklyRewardsFrame:GetName())
	elseif event == "ADDON_LOADED" and arg1 == "Blizzard_PVPUI" then 
		PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:SetScript("OnMouseDown", function() addon:ToggleVault() end)
	elseif event == "ADDON_LOADED" and arg1 == "Blizzard_ChallengesUI" then 
		ChallengesFrame.WeeklyInfo.Child.WeeklyChest:SetScript("OnMouseDown", function() addon:ToggleVault() end)
	end

end


function addon:OnEnable()
	for i, p in pairs(GreatVaultViewerLDB)do
		print(i)
	end
end


function addon:ToggleVault()
	if UIParentLoadAddOn("Blizzard_WeeklyRewards") then
		if WeeklyRewardsFrame:IsShown() then
			WeeklyRewardsFrame:Hide()
		else
			WeeklyRewardsFrame:Show()
		end
	else 
		LoadAddOn("Blizzard_WeeklyRewards")
		WeeklyRewardsFrame:Show()
	end	
end



