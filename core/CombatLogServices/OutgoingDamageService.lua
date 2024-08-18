OutgoingDamageService = {}

function OutgoingDamageService:CreateOutgoingDamageText(unitName, isPet)
    local subEventInfo = CombatLogUtils:GetSubEventInfo()

    if(subEventInfo and subEventInfo[CombatLogConstants.SubEventIsRelevantEventKey]) then
        return TextCreationUtils:CreateOutgoingDamageText(
        subEventInfo[CombatLogConstants.SubEventActionKey],
        subEventInfo[CombatLogConstants.SubEventSpellIdKey],
        isPet,
        unitName,
        subEventInfo[CombatLogConstants.SubEventAmountKey])
    end
end