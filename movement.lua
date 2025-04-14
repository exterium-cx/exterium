return function(tab)
    local player = game.Players.LocalPlayer
    local flyEnabled = false

    function toggleFly(state)
        flyEnabled = state
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.Humanoid.PlatformStand = state
            repeat
                wait()
                character.HumanoidRootPart.Velocity = Vector3.new(0, flyEnabled and 30 or 0, 0)
            until not flyEnabled
            character.Humanoid.PlatformStand = false
        end
    end

    tab:Toggle{
        Name = "Enable Fly",
        Callback = toggleFly
    }
end
