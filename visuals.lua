return function(tab)
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Camera = workspace.CurrentCamera
    local LocalPlayer = Players.LocalPlayer

    local ESP_ENABLED = false
    local SHOW_BOXES = true
    local SHOW_SKELETON = false
    local SHOW_LINES = false
    local drawings = {}

    local skeletonPairs = {
        {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"},
        {"UpperTorso", "RightUpperArm"}, {"LowerTorso", "LeftUpperLeg"}, {"LowerTorso", "RightUpperLeg"},
        {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"}, {"RightUpperArm", "RightLowerArm"},
        {"RightLowerArm", "RightHand"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
        {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}
    }

    local BOX_COLOR = Color3.fromRGB(255, 0, 0)
    local SKELETON_COLOR = Color3.fromRGB(255, 255, 255)
    local LINE_COLOR = Color3.fromRGB(255, 255, 255)

    local function createESP(player)
        if drawings[player] then return end
        drawings[player] = {
            box = Drawing.new("Square"),
            snapline = Drawing.new("Line"),
            skeleton = {}
        }

        drawings[player].box.Thickness = 1
        drawings[player].box.Color = BOX_COLOR
        drawings[player].box.Transparency = 1
        drawings[player].box.Visible = false

        drawings[player].snapline.Thickness = 1
        drawings[player].snapline.Color = LINE_COLOR
        drawings[player].snapline.Transparency = 1
        drawings[player].snapline.Visible = false

        for _, _ in ipairs(skeletonPairs) do
            local line = Drawing.new("Line")
            line.Thickness = 1
            line.Color = SKELETON_COLOR
            line.Visible = false
            table.insert(drawings[player].skeleton, line)
        end
    end

    Players.PlayerRemoving:Connect(function(p)
        if drawings[p] then
            drawings[p].box:Remove()
            drawings[p].snapline:Remove()
            for _, l in ipairs(drawings[p].skeleton) do l:Remove() end
            drawings[p] = nil
        end
    end)

    RunService.RenderStepped:Connect(function()
        if not ESP_ENABLED then
            for _, obj in pairs(drawings) do
                obj.box.Visible = false
                obj.snapline.Visible = false
                for _, l in ipairs(obj.skeleton) do l.Visible = false end
            end
            return
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                createESP(player)
                local character = player.Character
                local parts = {}
                for _, partName in ipairs({
                    "Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm",
                    "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg",
                    "LeftLowerLeg", "RightLowerLeg", "LeftHand", "RightHand", "LeftFoot", "RightFoot"
                }) do
                    local part = character:FindFirstChild(partName)
                    if part then table.insert(parts, part) end
                end

                local screenPoints = {}
                for _, part in ipairs(parts) do
                    local point, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        table.insert(screenPoints, Vector2.new(point.X, point.Y))
                    end
                end

                if #screenPoints > 0 then
                    local minX, minY = math.huge, math.huge
                    local maxX, maxY = -math.huge, -math.huge
                    for _, point in ipairs(screenPoints) do
                        minX = math.min(minX, point.X)
                        minY = math.min(minY, point.Y)
                        maxX = math.max(maxX, point.X)
                        maxY = math.max(maxY, point.Y)
                    end

                    local box = drawings[player].box
                    box.Position = Vector2.new(minX, minY)
                    box.Size = Vector2.new(maxX - minX, maxY - minY)
                    box.Visible = SHOW_BOXES
                else
                    drawings[player].box.Visible = false
                end

                for i, pair in ipairs(skeletonPairs) do
                    local part1, part2 = character:FindFirstChild(pair[1]), character:FindFirstChild(pair[2])
                    local line = drawings[player].skeleton[i]
                    if part1 and part2 then
                        local p1, on1 = Camera:WorldToViewportPoint(part1.Position)
                        local p2, on2 = Camera:WorldToViewportPoint(part2.Position)
                        if on1 and on2 then
                            line.From = Vector2.new(p1.X, p1.Y)
                            line.To = Vector2.new(p2.X, p2.Y)
                            line.Visible = SHOW_SKELETON
                        else
                            line.Visible = false
                        end
                    else
                        line.Visible = false
                    end
                end

                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    local snapline = drawings[player].snapline
                    if onScreen then
                        snapline.From = Vector2.new(rootPos.X, rootPos.Y)
                        snapline.To = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        snapline.Visible = SHOW_LINES
                    else
                        snapline.Visible = false
                    end
                end
            end
        end
    end)

    tab:Toggle{Name = "Enable ESP", Callback = function(s) ESP_ENABLED = s end}
    tab:Toggle{Name = "Show Boxes", Callback = function(s) SHOW_BOXES = s end}
    tab:Toggle{Name = "Show Skeleton", Callback = function(s) SHOW_SKELETON = s end}
    tab:Toggle{Name = "Show Snaplines", Callback = function(s) SHOW_LINES = s end}
end
