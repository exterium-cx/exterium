return function(tab)
    local autofarmEnabled = false
    local vim = game:GetService("VirtualInputManager")

    tab:Toggle{
        Name = "Enable AutoFarm (Simulated Click)",
        Callback = function(state)
            autofarmEnabled = state

            task.spawn(function()
                while autofarmEnabled do
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    task.wait(0.1)
                end
            end)
        end
    }
end
