-- Load the modified library from your GitHub
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/source.lua?token=GHSAT0AAAAAADCFPJM3VPIC4UWZ5PBSQJ7WZ74LS3A", true))()

-- Create the GUI
local GUI = Mercury:Create{
    Name = "exterium.cx",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Purple,
    Link = "https://github.com/yacrum/UiLib"
}

GUI:Notification{
    Title = "Welcome",
    Text = "Welcome to exterium.cx!",
    Duration = 5
}

-- Watermark
local watermark = Drawing.new("Text")
watermark.Text = "exterium.cx"
watermark.Size = 18
watermark.Color = Color3.fromRGB(255, 255, 255)
watermark.Position = Vector2.new(10, 10)
watermark.BackgroundTransparency = 0.5
watermark.BackgroundColor = Color3.fromRGB(50, 50, 50)
watermark.Visible = true

-- Tabs
local movementTab = GUI:Tab{Name = "Movement Features", Icon = "rbxassetid://8569322835"}
local visualsTab = GUI:Tab{Name = "Visuals", Icon = "rbxassetid://8569322835"}
local featuresTab = GUI:Tab{Name = "Features", Icon = "rbxassetid://8569322835"}
local aimbotTab = GUI:Tab{Name = "Aimbot", Icon = "rbxassetid://8569322835"}

-- Load each module
loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/movement.lua?token=GHSAT0AAAAAADCFPJM2UYJORUFVDJMRU6RCZ74LTFA"))(movementTab)
loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/features.lua?token=GHSAT0AAAAAADCFPJM3BGTR76SIFQOMFHJ6Z74LTEQ"))(featuresTab)
loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/visuals.lua?token=GHSAT0AAAAAADCFPJM27V4ATPTMZ6PYFENMZ74LTFQ"))(visualsTab)
loadstring(game:HttpGet("https://raw.githubusercontent.com/exterium-cx/exterium/refs/heads/main/aimbot.lua?token=GHSAT0AAAAAADCFPJM3CE5554IP3PKZOYVEZ74LTEA"))(aimbotTab)
