function FarmChestAndHopServer(bO)
    pcall(function()
        if not bO then
            bO = 10
        end

        -- Điều kiện kiểm tra hoàn thành farm chest (thay thế bằng logic thực tế của bạn)
        local function IsFarmChestComplete()
            -- Ví dụ: Kiểm tra nếu số chest đã farm đạt mức tối đa
            return (game:GetService("Players").LocalPlayer.leaderstats.Chests.Value >= 10)  -- Thay đổi tùy game
        end

        -- Vòng lặp farm chest
        while not IsFarmChestComplete() do
            task.wait(1)  -- Thời gian chờ giữa các lần kiểm tra
            print("Đang farm chest...")  -- Debug: Thông báo trạng thái
        end

        -- Thông báo farm hoàn tất
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Auto Chest",
                Text = "Đã Lụm Hết Gương",
                Duration = 2
            }
        )

        print("Hoàn thành farm chest. Đang nhảy server...")  -- Debug: Thông báo hoàn thành
        HopServer(bO)  -- Gọi hàm HopServer
    end)
end

function HopServer(bO)
    pcall(function()
        if not bO then
            bO = 10
        end

        local ticklon = tick()
        repeat
            task.wait()
        until tick() - ticklon >= 1

        local function Hop()
            if not CheckInComBat() then
                for r = 1, math.huge do
                    if ChooseRegion == nil or ChooseRegion == "" then
                        ChooseRegion = "Singapore"
                    else
                        game:GetService("Players").LocalPlayer.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text = ChooseRegion
                    end

                    local bP = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(r)
                    for k, v in pairs(bP) do
                        if k ~= game.JobId and v["Count"] < bO then
                            -- Thông báo khi bắt đầu nhảy server
                            game.StarterGui:SetCore(
                                "SendNotification",
                                {
                                    Title = "Auto Chest",
                                    Text = "Đang Đổi Server",
                                    Duration = 3
                                }
                            )
                            print("Nhảy server thành công!")  -- Debug: Thông báo trạng thái
                            game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", k)
                            return true  -- Nhảy server thành công
                        end
                    end
                end
            end
            return false
        end

        if not getgenv().Loaded then
            local function bQ(v)
                if v.Name == "ErrorPrompt" then
                    if v.Visible then
                        if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                            HopServer()
                            v.Visible = false
                        end
                    end
                    v:GetPropertyChangedSignal("Visible"):Connect(
                        function()
                            if v.Visible then
                                if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                                    HopServer()
                                    v.Visible = false
                                end
                            end
                        end
                    )
                end
            end

            for k, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
                bQ(v)
            end
            game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
            getgenv().Loaded = true
        end

        while task.wait(0.1) do
            if Hop() then
                break
            end
        end
    end)
end

function CheckInComBat()
    -- Kiểm tra xem người chơi có đang trong trạng thái combat không
    -- Thay thế bằng logic thực tế của bạn
    return false
end

-- Khởi chạy farm chest và nhảy server
FarmChestAndHopServer(10)  -- 10 là số người chơi tối đa trong server mục tiêu