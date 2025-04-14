local loadModule = function(url)
    return loadstring(game:HttpGet(url, true))()
end

-- Load menu
local GUI = loadModule("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/source.lua?token=GHSAT0AAAAAADCFPJM3EEV5KIQPCPH2MQIGZ74LWLQ")()

-- Create tabs
local movementTab = GUI:Tab{Name = "Movement Features", Icon = "rbxassetid://8569322835"}
local visualsTab = GUI:Tab{Name = "Visuals", Icon = "rbxassetid://8569322835"}
local featuresTab = GUI:Tab{Name = "Features", Icon = "rbxassetid://8569322835"}
local aimbotTab = GUI:Tab{Name = "Aimbot", Icon = "rbxassetid://8569322835"}

-- Load each module
loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/movement.lua?token=GHSAT0AAAAAADCFPJM2UYJORUFVDJMRU6RCZ74LTFA"))(movementTab)
loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/features.lua?token=GHSAT0AAAAAADCFPJM3BGTR76SIFQOMFHJ6Z74LTEQ"))(featuresTab)
loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/visuals.lua?token=GHSAT0AAAAAADCFPJM27V4ATPTMZ6PYFENMZ74LTFQ"))(visualsTab)
loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/aimbot.lua?token=GHSAT0AAAAAADCFPJM3CE5554IP3PKZOYVEZ74LTEA"))(aimbotTab)
