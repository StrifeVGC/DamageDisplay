DamageDisplayMixin = {}

local playerGUID = UnitGUID("player")
local unitPets = {}
local currentPetGUID = UnitGUID("pet")
local currentPetName = UnitName("pet")

function DamageDisplayMixin:OnLoad()
    print("loaded properly")
    self:SetFontObject(GameFontNormal)
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:SetMovable(true)
    self:EnableMouse(true)
    self:SetUserPlaced(true) -- Allows the frame to be moved by the user
    self:RegisterForDrag("LeftButton") -- Register the left mouse button for dragging
end

function DamageDisplayMixin:OnCombatLogEvent(self, event) 
    local _, subevent, _, sourceGUID, _, _, _, _, _ = CombatLogGetCurrentEventInfo()
    local processedText = nil
    if(sourceGUID == currentPetGUID) then
        processedText = OutgoingDamageService:CreateOutgoingDamageText(currentPetName, true)
        if(processedText) then
            DamageDisplayScrollingFrame.DamageDisplayScrollingText:AddMessage(processedText, 1, 1, 1)
        end
    elseif (sourceGUID == playerGUID) then
        processedText = OutgoingDamageService:CreateOutgoingDamageText(nil, false)
        if(processedText) then
            DamageDisplayScrollingFrame.DamageDisplayScrollingText:AddMessage(processedText, 1, 1, 1)
        end
    end
end