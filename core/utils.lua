-- core/utils.lua
DamageDisplayUtils = {} -- Global table for utility functions

local function GetSpellIcon(spellID)
    local spellIcon = C_Spell.GetSpellInfo(spellID)["iconID"]
    if spellIcon and spellIcon ~= "" then
        return spellIcon
    end
    return "Interface/Icons/INV_Misc_QuestionMark" -- Default icon
end

local function IsPlayerPetGuardianOrMinion(sourceGUID, sourceName)
    if UnitGUID("pet") == sourceGUID then
        return true, "Pet", "Pet"
    end
    
    local knownEntities = {
        ["Felguard"] = "Felguard",
        ["Imp"] = "Imp",
        ["Voidwalker"] = "Voidwalker",
        ["Succubus"] = "Succubus",
    }
    
    if knownEntities[sourceName] then
        return true, knownEntities[sourceName], sourceName
    end

    return false, nil, nil
end

DamageDisplayUtils.GetSpellIcon = GetSpellIcon
DamageDisplayUtils.IsPlayerPetGuardianOrMinion = IsPlayerPetGuardianOrMinion
