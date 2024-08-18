TextCreationUtils = {}

-- text for pet/guardian/minion releted damage
local petDamageText = "%s %s %s - %s"
local petDamageMeleeText = "%s %s - %s"

-- text for player related damage
local playerDamageText = "%s %s %s"
local playerDamageMeleeText = "%s %s"

local function CreateIconText(spellId)
    local texture = C_Spell.GetSpellTexture(spellId)  -- Get the texture file path for the spell
    size = size or 16  -- Default size if none is provided
    local iconString =  string.format("|T%s:%d|t", texture, size)
    return iconString
end

function TextCreationUtils:CreateOutgoingDamageText(
    action,
    spellId,
    isPet,
    unitName,
    damageAmount)
        
        if(action ~= MELEE) then
            local icon = CreateIconText(spellId)
            if(isPet)then
                return(petDamageText:format(icon, damageAmount, action, unitName))
            end
            return playerDamageText:format(icon, damageAmount, action)
        else
            if(isPet)then
                return(petDamageMeleeText:format(damageAmount, action, unitName))
            end
            return playerDamageMeleeText:format(damageAmount, action)
        end
end