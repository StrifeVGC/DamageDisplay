CombatLogUtils = {}

local function CreateEventInfoTable(
    subEventInfo,
    spellId,
    amount,
    critical,
    action,
    sourceGUID,
    destName)

    if(spellId) then
        subEventInfo[CombatLogConstants.SubEventSpellIdKey] = spellId
    end
    subEventInfo[CombatLogConstants.SubEventAmountKey] = amount
    subEventInfo[CombatLogConstants.SubEventCriticalKey] = critical
    subEventInfo[CombatLogConstants.SubEventActionKey] = action
    subEventInfo[CombatLogConstants.SubEventSourceGUIDKey] = sourceGUID
    subEventInfo[CombatLogConstants.SubEventDestNameKey] = destName
    subEventInfo[CombatLogConstants.SubEventIsRelevantEventKey] = true
    return subEventInfo
end

local function FindSubEventTypeAndCreateSubEventTypeInfo()
    local _, subevent, _, sourceGUID, _, _, _, _, destName = CombatLogGetCurrentEventInfo()
	local spellId, amount, critical
    local subEventInfo = {
        IsRelevantEvent = false
    }
    if subevent == CombatLogConstants.SwingDamage then
		amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
        subEventInfo = CreateEventInfoTable(subEventInfo, nil, amount, critical, MELEE, sourceGUID, destName)
	elseif subevent == CombatLogConstants.SpellDamage then

		spellId, _, _, amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
        subEventInfo = CreateEventInfoTable(subEventInfo, spellId, amount, critical, C_Spell.GetSpellInfo(spellId)["name"],
        sourceGUID, destName)
	end

    return subEventInfo
end

function CombatLogUtils:GetSubEventInfo()
    return FindSubEventTypeAndCreateSubEventTypeInfo()
end

function CombatLogUtils:CheckIfEventIsRelevant()

end