local E = unpack(ElvUI)

local NP = E:GetModule("NamePlates")
local module = mMT.Modules.QuestIcons

local function SetQuestIcons(_, nameplate)
	local plateDB = NP:PlateDB(nameplate)
	local db = E.Retail and plateDB.questIcon

	if db and db.enable and not nameplate.isBattlePet and (nameplate.frameType == "FRIENDLY_NPC" or nameplate.frameType == "ENEMY_NPC") then
		for _, object in ipairs(NP.QuestIcons.iconTypes) do
			local icon = nameplate.QuestIcons[object]

			if object ~= "Item" then
				icon:SetTexture(mMT.Media.DockIcons[E.db.mMT.questicons.texture[object]])
			end

			if E.db.mMT.questicons.hidetext then
				icon.Text:Hide()
			end
		end
	end
end

function module:Initialize()
	if not module.hooked then
		hooksecurefunc(NP, "Update_QuestIcons", SetQuestIcons)
		module.loaded = true
		module.hooked = true
		module.needReloadUI = true
	end
end
