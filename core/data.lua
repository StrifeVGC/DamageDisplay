-- core/data.lua
DamageDisplayData = {} -- Global table for data functions

local damageData = {}
local aggregationTimers = {}

local function UpdateDamageData(spellID, amount, isCritical)
    if not damageData[spellID] then
        damageData[spellID] = {
            totalDamage = 0,
            hitCount = 0,
            critCount = 0
        }
    end

    local data = damageData[spellID]
    data.totalDamage = data.totalDamage + amount
    data.hitCount = data.hitCount + 1
    if isCritical then
        data.critCount = data.critCount + 1
    end
end

local function GetAggregatedDamageMessage(spellID)
    local data = damageData[spellID]
    if not data then
        return nil
    end
    local spellName = C_Spell.GetSpellInfo(spellID).name
    local icon = DamageDisplayUtils.GetSpellIcon(spellID)
    local totalDamage = data.totalDamage
    local hitCount = data.hitCount
    local critCount = data.critCount
    return string.format("|T%s:16|t %s %d (x %d, y %d)", icon, spellName or "Unknown", totalDamage, hitCount, critCount)
end

local function HandleAggregation(spellID)
    if aggregationTimers[spellID] then
        return
    end

    aggregationTimers[spellID] = true
    C_Timer.After(1, function()
        local damageText = GetAggregatedDamageMessage(spellID)
        if damageText then
            DamageDisplayFrame.AddMessage(damageText)
        end

        damageData[spellID] = nil
        aggregationTimers[spellID] = nil
    end)
end

DamageDisplayData.UpdateDamageData = UpdateDamageData
DamageDisplayData.GetAggregatedDamageMessage = GetAggregatedDamageMessage
DamageDisplayData.HandleAggregation = HandleAggregation
