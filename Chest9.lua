function FarmChestAndHopServer(bO)
    pcall(function()
        if not bO then
            bO = 10
        end

        -- Kiểm tra nếu đã farm xong
        local function IsFarmChestComplete()
            -- Thay thế logic này tùy thuộc vào cách kiểm tra chest của game
            local chestCount = game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats") and 
                               game:GetService("Players").LocalPlayer.leaderstats:FindFirstChild("Chests")
            if chestCount then
                return chestCount.Value >= 10 -- Số lượng tùy thuộc vào điều kiện của bạn
            end
            return false
        end

        -- Vòng lặp farm
        while not IsFarmChestComplete() do
            print("Đang farm chest...")  -- Debug
            task.wait(1)
        end

        -- Thông báo đã farm xong
        game.StarterGui:SetCore("SendNotification", {
            Title = "Auto Chest",
            Text = "Đã Lụm Hết Gương",
            Duration = 2
        })

        -- Gọi nhảy server
        print("Farm xong, chuẩn bị nhảy server...")
        HopServer(bO)
    end)
end

function HopServer(bO)
    pcall(function()
        if not bO then
            bO = 10
        end

        -- Chờ trước khi nhảy server
        local ticklon = tick()
        repeat task.wait() until tick() - ticklon >= 1

        local function Hop()
            -- Kiểm tra nếu không đang combat
            if not CheckInComBat() then
                for r = 1, math.huge do
                    local ChooseRegion = "Singapore"
                    local ServerBrowser = game:GetService("ReplicatedStorage"):FindFirstChild("__ServerBrowser")
                    if not ServerBrowser then
                        warn("Không tìm thấy __ServerBrowser!")  -- Debug
                        return false
                    end

                    -- Gọi ServerBrowser để lấy danh sách server
                    local bP = ServerBrowser:InvokeServer(r)
                    if not bP then
                        warn("Lỗi khi lấy danh sách server!")  -- Debug
                        return false
                    end

                    for k, v in pairs(bP) do
                        if k ~= game.JobId and v["Count"] < bO then
                            -- Thông báo trước khi nhảy server
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "Auto Chest",
                                Text = "Đang Đổi Server",
                                Duration = 3
                            })
                            print("Nhảy server thành công!")  -- Debug
                            ServerBrowser:InvokeServer("teleport", k)
                            return true
                        end
                    end
                end
            end
            return false
        end

        -- Cài đặt khi teleport fail
        if not getgenv().Loaded then
            local function HandleTeleportError(v)
                if v.Name == "ErrorPrompt" then
                    v:GetPropertyChangedSignal("Visible"):Connect(function()
                        if v.Visible and v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                            print("Lỗi teleport, thử lại...")
                            HopServer()
                        end
                    end)
                end
            end

            for _, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
                HandleTeleportError(v)
            end

            game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(HandleTeleportError)
            getgenv().Loaded = true
        end

        -- Vòng lặp thực hiện nhảy server
        while task.wait(0.1) do
            if Hop() then break end
        end
    end)
end

function CheckInComBat()
    -- Kiểm tra nếu đang combat
    return false -- Tùy chỉnh logic của bạn
end

-- Bắt đầu
FarmChestAndHopServer(9) -- Số lượng người chơi tối đa trong server mục tiêu