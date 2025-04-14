return function(tab)
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Camera = workspace.CurrentCamera
    local LocalPlayer = Players.LocalPlayer
    local mouse = LocalPlayer:GetMouse()
    local UserInputService = game:GetService("UserInputService")

    local aimbotEnabled = false
    local aimbotFOV = 50
    local aimbotKey = Enum.KeyCode.F
    local target = nil

    local fovCircle = Drawing.new("Circle")
    fovCircle.Color = Color3.fromRGB(255, 255, 0)
    fovCircle.Thickness = 1
    fovCircle.Transparency = 0.5
    fovCircle.Visible = false

    local function updateFOV()
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        fovCircle.Radius = aimbotFOV
    end

    local function getClosestTarget()
        local closest = nil
        local shortest = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                if onScreen and dist < aimbotFOV and dist < shortest then
                    closest = p
                    shortest = dist
                end
            end
        end
        return closest
    end

    local function aimAt(target)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local pos = Camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position)
            local diff = Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)
            local moveTo = Vector2.new(mouse.X + diff.X * 0.1, mouse.Y + diff.Y * 0.1)
            mouse.Move:Fire(moveTo.X, moveTo.Y)
        end
    end

    local function toggle(state)
        aimbotEnabled = state
        fovCircle.Visible = state
    end

    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == aimbotKey then
            toggle(not aimbotEnabled)
        end
    end)

    tab:Toggle{Name = "Enable Aimbot", Callback = toggle}
    tab:Slider{
        Name = "Aimbot FOV Size",
        Min = 10,
        Max = 200,
        Default = 50,
        Callback = function(val)
            aimbotFOV = val
            updateFOV()
        end
    }

    RunService.RenderStepped:Connect(function()
        if aimbotEnabled then
            updateFOV()
            target = getClosestTarget()
            aimAt(target)
        end
    end)
end
