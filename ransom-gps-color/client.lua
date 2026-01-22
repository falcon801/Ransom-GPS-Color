-- © 2026 Ransom / Falcon801
-- Ransom-GPS-Color | All Rights Reserved

local C = Config
if C.Enabled == false then return end

local IDX = C.WaypointHudIndex or 142
local COL = C.RouteColour or { r = 255, g = 56, b = 56, a = 255 }
local REAPPLY = C.ReapplyInterval or 10000
local BURSTS = C.InitialBursts or { 0, 500, 2000 }

local function apply()
    ReplaceHudColourWithRgba(IDX, COL.r or 255, COL.g or 56, COL.b or 56, COL.a or 255)
end

CreateThread(function()
    for _, delay in ipairs(BURSTS) do
        Wait(delay); apply()
    end
    while true do
        Wait(REAPPLY)
        local r,g,b,a = GetHudColour(IDX)
        if r ~= (COL.r or 255) or g ~= (COL.g or 56) or b ~= (COL.b or 56) or a ~= (COL.a or 255) then
            apply()
        end
    end
end)

AddEventHandler('onClientResourceStart', function(res)
    if res == GetCurrentResourceName() then
        CreateThread(function() Wait(0); apply() end)
    end
end)

