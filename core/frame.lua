-- core/frame.lua

-- Create and configure the frame
local frame = CreateFrame("Frame", "MyDamageFrame", UIParent, "BackdropTemplate")

local function InitializeFrame()
    frame:SetSize(400, 200)
    frame:SetPoint("CENTER", UIParent, "CENTER")
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0, 0, 0, 1)
    frame.texts = {}
    frame.maxLines = 10  -- Maximum number of lines to display
    frame:Show() -- Ensure the frame is visible
end

local function AddMessage(text)
    if type(text) ~= "string" then return end
    -- Shift existing lines up
    for i = frame.maxLines, 2, -1 do
        if frame.texts[i-1] then
            if not frame.texts[i] then
                frame.texts[i] = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                frame.texts[i]:SetPoint("BOTTOMLEFT", frame.texts[i-1], "TOPLEFT", 0, 2)
            end
            frame.texts[i]:SetText(frame.texts[i-1]:GetText())
        end
    end

    -- Add new line at the bottom
    if not frame.texts[1] then
        frame.texts[1] = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        frame.texts[1]:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)
    end
    frame.texts[1]:SetText(text)
end

-- Expose functions and frame for other modules
DamageDisplayFrame = {
    Initialize = InitializeFrame,
    AddMessage = AddMessage,
    frame = frame
}
