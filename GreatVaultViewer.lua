--  ///////////////////////////////////////////////////////////////////////////////////////////
--
--   Great Vault Viewer
--  Author: SLOKnightfall

--  

--

--  ///////////////////////////////////////////////////////////////////////////////////////////

local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0")

function addon:OnInitialize()
	addon:RegisterEvent("ADDON_LOADED", "EventHandler" )
end


function addon:EventHandler(event, arg1 )
	if event == "ADDON_LOADED" and arg1 == "Blizzard_WeeklyRewards" then 
		tinsert(UISpecialFrames, WeeklyRewardsFrame:GetName())
	elseif event == "ADDON_LOADED" and arg1 == "Blizzard_PVPUI" then 
		PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:SetScript("OnMouseDown", function() addon:ToggleVault() end)
	end

end


function addon:OnEnable()
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