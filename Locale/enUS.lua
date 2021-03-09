local addonName, addon = ...
local L = _G.LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true, true)

if not L then return end

L["Show Minimap Icon"] = true
GREATVAULTVIEWER_BINDING_TOGGLE = "Toggle Great Vault"
GREATVAULTVIEWER = "Great Vault Viewer"