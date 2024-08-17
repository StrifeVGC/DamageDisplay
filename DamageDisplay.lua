-- DamageDisplay.lua

-- Ensure core modules are loaded
local frame = DamageDisplayFrame

-- Initialize the frame and events
if frame then
    frame.Initialize()
else
    print("Error: DamageDisplayFrame is not loaded.")
end