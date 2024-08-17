-- core/events.lua

-- Ensure that DamageDisplayFrame is initialized
assert(DamageDisplayFrame, "DamageDisplayFrame is not initialized!")
local frame = DamageDisplayFrame.frame -- Access the frame from DamageDisplayFrame

local function OnEvent(self, event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, amount, overkill, _, _, _, critical = CombatLogGetCurrentEventInfo()

    if subevent == "SPELL_DAMAGE" or subevent == "SPELL_PERIODIC_DAMAGE" then
        local playerGUID = UnitGUID("player")
        local utils = DamageDisplayUtils
        local isPetOrGuardianOrMinion, entityType, entityName = utils.IsPlayerPetGuardianOrMinion(sourceGUID, sourceName)

        if sourceGUID == playerGUID or isPetOrGuardianOrMinion then
            if destGUID and destGUID ~= playerGUID and not (UnitGUID("pet") == destGUID) then
                local data = DamageDisplayData
                data.UpdateDamageData(spellID, amount, critical)
                data.HandleAggregation(spellID)
            end
        end
    end
end

-- Register the event handler
local function InitializeEvents()
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    frame:SetScript("OnEvent", OnEvent)
end

-- Ensure to initialize events after the frame is created
InitializeEvents()
