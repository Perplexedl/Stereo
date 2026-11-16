local rayfield = loadstring(game:HttpGet("http://10.0.2.2:5500/rayfield"))()

local window = rayfield:CreateWindow({
  Name = "[Lamduck - OP] Neo Tennis",
  LoadingTitle = "Neo Tennis super OP script",
  LoadingSubtitle = "Free to you by Lamduck",
  ConfigurationSaving = { Enabled = false },
  Theme = "DarkBlue",
})

local localPlayer = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local hitBallRF = replicatedStorage:WaitForChild("Remotes"):WaitForChild("HitBallRF")
local serveRF = replicatedStorage:WaitForChild("Remotes"):WaitForChild("ServeRF")
local settingsRE = replicatedStorage:WaitForChild("Remotes"):WaitForChild("SettingsRE")
local dailyRewardRE = replicatedStorage:WaitForChild("Remotes"):WaitForChild("DailyRewardRE")
local battlePassRF = replicatedStorage:WaitForChild("Remotes"):WaitForChild("BattlePassRF")

_G.AutoParry = false
_G.ParryDistance = 30
_G.HitBallType = "Random"
_G.EnableESP = false
_G.DrawParryRange = false
_G.AutoServe = false
_G.ServePower = 100
_G.ServeRotate = -1
_G.ServeDelay = 4
_G.IsServing = false
_G.AutoDailyReward = false
_G.AutoBattlePass = false
_G.Wallhack = false
_G.WalkSpeed = 16
_G.JumpPower = 50

local function f1()
  local character = localPlayer.Character
  local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart then
    return nil
  end

  local v1 = nil
  local huge = math.huge

  for key, value in pairs(workspace:GetChildren()) do
    if string.find(string.lower(value.Name), "court") then
      local ball = value:FindFirstChild("Ball")

      if ball then
        local clientBall = ball:FindFirstChild("ClientBall") or ball

        if clientBall and clientBall:IsA("BasePart") then
          local magnitude = (humanoidRootPart.Position - clientBall.Position).Magnitude

          if magnitude < huge then
            huge = magnitude
            v1 = clientBall
          end
        end
      end
    end
  end

  if v1 and huge < 500 then
    return v1
  end

  return nil
end

local function f2(p1, p2)
  local hitBallType = _G.HitBallType

  if hitBallType == "Random" then
    local v2 = { 1, 3, 4, 7 }
    hitBallType = v2[math.random(1, #v2)]
  end

  pcall(function()
    hitBallRF:InvokeServer({
      CamPos = workspace.CurrentCamera.CFrame.Position,
      HitPos = p1.Position,
      HitBallType = hitBallType,
      ClientTick = tick(),
      CamDir = p2.CFrame.LookVector,
      AttackMoveSpeed = Vector3.zero,
    })
  end)
end

local ballTracer3D = Instance.new("CylinderHandleAdornment")
ballTracer3D.Name = "BallTracer3D"
ballTracer3D.Radius = 0.1
ballTracer3D.Color3 = Color3.fromRGB(255, 50, 50)
ballTracer3D.Transparency = 0
ballTracer3D.AlwaysOnTop = false
ballTracer3D.ZIndex = 0
ballTracer3D.Parent = game.CoreGui

local ball3DVisualizer = Instance.new("SphereHandleAdornment")
ball3DVisualizer.Name = "Ball3DVisualizer"
ball3DVisualizer.Color3 = Color3.fromRGB(255, 100, 100)
ball3DVisualizer.Transparency = 0.6
ball3DVisualizer.AlwaysOnTop = false
ball3DVisualizer.ZIndex = 0
ball3DVisualizer.Parent = game.CoreGui

local parryRangeInner = Instance.new("CylinderHandleAdornment")
parryRangeInner.Name = "ParryRangeInner"
parryRangeInner.Height = 0.05
parryRangeInner.Color3 = Color3.fromRGB(0, 255, 127)
parryRangeInner.Transparency = 0.85
parryRangeInner.AlwaysOnTop = false
parryRangeInner.ZIndex = 0
parryRangeInner.Parent = game.CoreGui

local parryRangeOuter = Instance.new("CylinderHandleAdornment")
parryRangeOuter.Name = "ParryRangeOuter"
parryRangeOuter.Height = 0.05
parryRangeOuter.Color3 = Color3.fromRGB(0, 255, 127)
parryRangeOuter.Transparency = 0.3
parryRangeOuter.AlwaysOnTop = false
parryRangeOuter.ZIndex = 1
parryRangeOuter.Parent = game.CoreGui

runService.RenderStepped:Connect(function()
  local character2 = localPlayer.Character
  local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
  local v3 = f1()

  if humanoidRootPart2 and _G.DrawParryRange then
    parryRangeInner.Adornee = humanoidRootPart2
    parryRangeInner.Radius = _G.ParryDistance
    parryRangeInner.InnerRadius = 0
    parryRangeInner.Visible = true

    parryRangeInner.CFrame = CFrame.new(0, -humanoidRootPart2.Size.Y / 2 - 1.5, 0)
      * CFrame.Angles(math.rad(90), 0, 0)

    parryRangeOuter.Adornee = humanoidRootPart2
    parryRangeOuter.Radius = _G.ParryDistance
    parryRangeOuter.InnerRadius = _G.ParryDistance - 0.5
    parryRangeOuter.Visible = true

    parryRangeOuter.CFrame = CFrame.new(0, -humanoidRootPart2.Size.Y / 2 - 1.5, 0)
      * CFrame.Angles(math.rad(90), 0, 0)
  else
    parryRangeInner.Visible = false
    parryRangeOuter.Visible = false
  end

  if _G.EnableESP and v3 and humanoidRootPart2 then
    local magnitude2 = (humanoidRootPart2.Position - v3.Position).Magnitude

    if magnitude2 <= 300 then
      local cframe = CFrame.lookAt(humanoidRootPart2.Position, v3.Position)

      ballTracer3D.Adornee = humanoidRootPart2
      ballTracer3D.Height = magnitude2

      ballTracer3D.CFrame = humanoidRootPart2.CFrame:ToObjectSpace(cframe * CFrame.new(
        0, 0, -magnitude2 / 2
      ))

      ballTracer3D.Visible = true

      ball3DVisualizer.Adornee = v3
      ball3DVisualizer.Radius = 5
      ball3DVisualizer.Visible = true
    else
      ballTracer3D.Visible = false
      ball3DVisualizer.Visible = false
    end
  else
    ballTracer3D.Visible = false
    ball3DVisualizer.Visible = false
  end
end)

task.spawn(function()
  while task.wait(0.01) do
    local character3 = localPlayer.Character
    local humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")

    if _G.AutoParry and humanoidRootPart3 and not _G.IsServing then
      local v4 = f1()

      if v4 then
        if (humanoidRootPart3.Position - v4.Position).Magnitude < _G.ParryDistance then
          f2(v4, humanoidRootPart3)
          task.wait(0.3)
        end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    if _G.AutoServe then
      local character4 = localPlayer.Character
      local humanoidRootPart4 = character4 and character4:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart4 then
        _G.IsServing = true

        pcall(function()
          serveRF:InvokeServer({ Power = _G.ServePower, RotateType = _G.ServeRotate })
        end)

        task.wait(0.4)
        local v5 = f1()

        if v5 then
          pcall(function()
            hitBallRF:InvokeServer({
              CamPos = workspace.CurrentCamera.CFrame.Position,
              HitPos = v5.Position,
              HitBallType = 7,
              ClientTick = tick(),
              CamDir = humanoidRootPart4.CFrame.LookVector,
              ExtendParams = { Power = _G.ServePower, RotateType = _G.ServeRotate },
              AttackMoveSpeed = Vector3.zero,
            })
          end)
        end

        task.wait(0.1)
        _G.IsServing = false
        task.wait(_G.ServeDelay)
      end
    end
  end
end)

task.spawn(function()
  while task.wait(10) do
    if _G.AutoDailyReward then
      for i = 1, 7 do
        pcall(function() dailyRewardRE:FireServer("GetDailyReward", i) end)
        task.wait(0.2)
      end
    end
  end
end)

task.spawn(function()
  while task.wait(10) do
    if _G.AutoBattlePass then
      for j = 1, 30 do
        pcall(function() battlePassRF:InvokeServer("TakeReward", "BPR" .. tostring(j), true) end)
        task.wait(0.1)
      end
    end
  end
end)

task.spawn(function()
  runService.Stepped:Connect(function()
    if _G.Wallhack then
      local character5 = localPlayer.Character

      if character5 then
        for key2, value2 in pairs(character5:GetDescendants()) do
          if value2:IsA("BasePart") and value2.CanCollide then
            value2.CanCollide = false
          end
        end
      end
    end
  end)

  while task.wait(0.1) do
    local character6 = localPlayer.Character
    local humanoid = character6 and character6:FindFirstChild("Humanoid")

    if humanoid then
      if _G.WalkSpeed ~= 16 then
        humanoid.WalkSpeed = _G.WalkSpeed
      end

      if _G.JumpPower ~= 50 then
        humanoid.JumpPower = _G.JumpPower
        humanoid.UseJumpPower = true
      end
    end
  end
end)

local mainTab = window:CreateTab("Main", 4483362458)
local rewardsTab = window:CreateTab("Rewards", 4483362458)
local playerTab = window:CreateTab("Player", 4483362458)
mainTab:CreateSection("AUTO PARRY SYSTEM")

local toggle = mainTab:CreateToggle({
  Name = "Enable Auto Parry",
  CurrentValue = false,
  Flag = "AutoParryToggle",
  Callback = function(value3) _G.AutoParry = value3 end,
})

local parryDirectionDropdown = mainTab:CreateDropdown({
  Name = "Parry Direction",
  Options = {
    "Random", "1 (Normal Hit)", "3 (Curve Left -> Right)", "4 (Curve Right -> Left)",
    "7 (Smash Hit)",
  },
  CurrentOption = { "Random" },
  MultipleOptions = false,
  Flag = "DropdownHitType",
  Callback = function(value4)
    local v6 = type(value4) == "table" and value4[1] or value4

    if v6 == "Random" then
      _G.HitBallType = "Random"
    else
      local v7 = string.match(v6, "%d+")

      if v7 then
        _G.HitBallType = tonumber(v7)
      end
    end
  end,
})

local slider = mainTab:CreateSlider({
  Name = "Auto Parry Distance",
  Range = { 5, 200 },
  Increment = 1,
  Suffix = " studs",
  CurrentValue = 30,
  Flag = "ParryDistanceSlider",
  Callback = function(value5) _G.ParryDistance = value5 end,
})

local toggle2 = mainTab:CreateToggle({
  Name = "Draw Parry Range Visualizer",
  CurrentValue = false,
  Flag = "DrawRangeToggle",
  Callback = function(value6) _G.DrawParryRange = value6 end,
})

local toggle3 = mainTab:CreateToggle({
  Name = "Enable ESP (Line & Ball Visual)",
  CurrentValue = false,
  Flag = "BallESPToggle",
  Callback = function(value7) _G.EnableESP = value7 end,
})

local manualParryGui = nil

local toggle4 = mainTab:CreateToggle({
  Name = "Show Manual Parry Button (Floating)",
  CurrentValue = false,
  Flag = "FloatingBtnToggle",
  Callback = function(value8)
    if value8 then
      if not manualParryGui then
        manualParryGui = Instance.new("ScreenGui")
        manualParryGui.Name = "ManualParryGui"
        manualParryGui.Parent = game.CoreGui

        local textButton = Instance.new("TextButton")
        textButton.Size = UDim2.new(0, 70, 0, 70)
        textButton.Position = UDim2.new(0.5, -35, 0.5, -35)
        textButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        textButton.Text = "PARRY"
        textButton.Font = Enum.Font.GothamBold
        textButton.TextSize = 16
        textButton.Active = true
        textButton.Draggable = true
        textButton.Parent = manualParryGui

        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0.5, 0)
        uiCorner.Parent = textButton

        textButton.MouseButton1Click:Connect(function()
          local character7 = localPlayer.Character
          local humanoidRootPart5 = character7 and character7:FindFirstChild("HumanoidRootPart")
          local v8 = f1()

          if humanoidRootPart5 and v8 then
            f2(v8, humanoidRootPart5)
          end
        end)
      end

      manualParryGui.Enabled = true
    elseif manualParryGui then
      manualParryGui.Enabled = false
    end
  end,
})

mainTab:CreateSection("AUTO SERVE SYSTEM")

local toggle5 = mainTab:CreateToggle({
  Name = "Enable Auto Serve",
  CurrentValue = false,
  Flag = "AutoServeToggle",
  Callback = function(value9)
    _G.AutoServe = value9

    if value9 then
      pcall(function() settingsRE:FireServer("AutoServeEnable", false) end)
    end
  end,
})

local servePowerSlider = mainTab:CreateSlider({
  Name = "Serve Power",
  Range = { 60, 100 },
  Increment = 1,
  Suffix = "",
  CurrentValue = 100,
  Flag = "ServePowerSlider",
  Callback = function(value10) _G.ServePower = value10 end,
})

local dropdown = mainTab:CreateDropdown({
  Name = "Serve RotateType",
  Options = { "-1 (Normal)", "1 (Curve)" },
  CurrentOption = { "-1 (Normal)" },
  MultipleOptions = false,
  Flag = "ServeRotateDropdown",
  Callback = function(value11)
    local v9 = type(value11) == "table" and value11[1] or value11
    local v10 = string.match(v9, "^(-?%d+)")

    if v10 then
      _G.ServeRotate = tonumber(v10)
    end
  end,
})

rewardsTab:CreateSection("AUTO CLAIM")

local toggle6 = rewardsTab:CreateToggle({
  Name = "Auto Claim Daily Reward",
  CurrentValue = false,
  Flag = "AutoDailyToggle",
  Callback = function(value12) _G.AutoDailyReward = value12 end,
})

local toggle7 = rewardsTab:CreateToggle({
  Name = "Auto Claim Battle Pass",
  CurrentValue = false,
  Flag = "AutoBPToggle",
  Callback = function(value13) _G.AutoBattlePass = value13 end,
})

playerTab:CreateSection("CHARACTER MODS")

local wallhackNoclipToggle = playerTab:CreateToggle({
  Name = "Wallhack (Noclip)",
  CurrentValue = false,
  Flag = "WallhackToggle",
  Callback = function(value14) _G.Wallhack = value14 end,
})

local walkSpeedSlider = playerTab:CreateSlider({
  Name = "WalkSpeed",
  Range = { 16, 200 },
  Increment = 1,
  Suffix = "",
  CurrentValue = 16,
  Flag = "WalkSpeedSlider",
  Callback = function(value15) _G.WalkSpeed = value15 end,
})

local jumpPowerSlider = playerTab:CreateSlider({
  Name = "JumpPower",
  Range = { 50, 300 },
  Increment = 1,
  Suffix = "",
  CurrentValue = 50,
  Flag = "JumpPowerSlider",
  Callback = function(value16) _G.JumpPower = value16 end,
})

local otherTab = window:CreateTab("Other", 4483362458)
local httpService = game:GetService("HttpService")

local function f3()
  writefile("neotennis_config.json", httpService:JSONEncode({
    AutoParry = toggle.CurrentValue,
    HitBallType = parryDirectionDropdown.CurrentOption[1],
    ParryDistance = slider.CurrentValue,
    DrawParryRange = toggle2.CurrentValue,
    EnableESP = toggle3.CurrentValue,
    FloatingBtn = toggle4.CurrentValue,
    AutoServe = toggle5.CurrentValue,
    ServePower = servePowerSlider.CurrentValue,
    ServeRotate = dropdown.CurrentOption[1],
    AutoDaily = toggle6.CurrentValue,
    AutoBP = toggle7.CurrentValue,
    Wallhack = wallhackNoclipToggle.CurrentValue,
    WalkSpeed = walkSpeedSlider.CurrentValue,
    JumpPower = jumpPowerSlider.CurrentValue,
  }))
end

otherTab:CreateSection("INFO & COMMUNITY")

otherTab:CreateParagraph({
  Title = "About Script",
  Content = "<font color='rgb(0, 255, 127)'><b>• Script created by Lamduck.</b></font>\n<font color='rgb(255, 106, 255)'>• Join the community below to chat, give feedback, request features, or request games.</font>",
})

otherTab:CreateButton({
  Name = "Join Discord Server",
  Interact = "[Copy Link]",
  Callback = function()
    if setclipboard then
      setclipboard("https://discord.gg/kn2uCJpBk2")
      rayfield:Notify({ Title = "Discord", Content = "Link copied to clipboard!", Duration = 3 })
    else
      rayfield:Notify({
        Title = "Error",
        Content = "Your executor does not support clipboard.",
        Duration = 3,
      })
    end
  end,
})

otherTab:CreateButton({
  Name = "Join Telegram Group",
  Interact = "[Copy Link]",
  Callback = function()
    if setclipboard then
      setclipboard("https://t.me/lamduckchat")
      rayfield:Notify({ Title = "Telegram", Content = "Link copied to clipboard!", Duration = 3 })
    else
      rayfield:Notify({
        Title = "Error",
        Content = "Your executor does not support clipboard.",
        Duration = 3,
      })
    end
  end,
})

otherTab:CreateSection("CONFIGURATION")

local v11 = false

local button

button = otherTab:CreateButton({
  Name = "Save Current Config",
  Interact = "[Save]",
  Callback = function()
    if not v11 then
      v11 = true
      button:Set("ARE YOU SURE? CLICK AGAIN!")

      task.delay(3, function()
        if v11 then
          v11 = false
          button:Set("Save Current Config")
        end
      end)

      return
    end

    v11 = false
    button:Set("Save Current Config")
    f3()

    rayfield:Notify({
      Title = "Success",
      Content = "Configuration saved to device!",
      Duration = 3,
    })
  end,
})

local v12 = false

local button2

button2 = otherTab:CreateButton({
  Name = "Delete & Reset Config",
  Interact = "[Reset]",
  Callback = function()
    if not v12 then
      v12 = true
      button2:Set("ARE YOU SURE? CLICK AGAIN!")

      task.delay(3, function()
        if v12 then
          v12 = false
          button2:Set("Delete & Reset Config")
        end
      end)

      return
    end

    v12 = false
    button2:Set("Delete & Reset Config")

    if isfile("neotennis_config.json") then
      delfile("neotennis_config.json")
    end

    toggle:Set(false)
    parryDirectionDropdown:Set({ "Random" })
    slider:Set(30)
    toggle2:Set(false)
    toggle3:Set(false)
    toggle4:Set(false)
    toggle5:Set(false)
    servePowerSlider:Set(100)
    dropdown:Set({ "-1 (Normal)" })
    toggle6:Set(false)
    toggle7:Set(false)
    wallhackNoclipToggle:Set(false)
    walkSpeedSlider:Set(16)
    jumpPowerSlider:Set(50)

    rayfield:Notify({
      Title = "Success",
      Content = "All previous configs deleted!",
      Duration = 3,
    })
  end,
})

if isfile("neotennis_config.json") then
  local v13, v14 = pcall(function()
    return httpService:JSONDecode(readfile("neotennis_config.json"))
  end)

  if v13 and v14 then
    if v14.AutoParry ~= nil then
      toggle:Set(v14.AutoParry)
    end

    if v14.HitBallType ~= nil then
      parryDirectionDropdown:Set({ v14.HitBallType })
    end

    if v14.ParryDistance ~= nil then
      slider:Set(v14.ParryDistance)
    end

    if v14.DrawParryRange ~= nil then
      toggle2:Set(v14.DrawParryRange)
    end

    if v14.EnableESP ~= nil then
      toggle3:Set(v14.EnableESP)
    end

    if v14.FloatingBtn ~= nil then
      toggle4:Set(v14.FloatingBtn)
    end

    if v14.AutoServe ~= nil then
      toggle5:Set(v14.AutoServe)
    end

    if v14.ServePower ~= nil then
      servePowerSlider:Set(v14.ServePower)
    end

    if v14.ServeRotate ~= nil then
      dropdown:Set({ v14.ServeRotate })
    end

    if v14.AutoDaily ~= nil then
      toggle6:Set(v14.AutoDaily)
    end

    if v14.AutoBP ~= nil then
      toggle7:Set(v14.AutoBP)
    end

    if v14.Wallhack ~= nil then
      wallhackNoclipToggle:Set(v14.Wallhack)
    end

    if v14.WalkSpeed ~= nil then
      walkSpeedSlider:Set(v14.WalkSpeed)
    end

    if v14.JumpPower ~= nil then
      jumpPowerSlider:Set(v14.JumpPower)
    end

    rayfield:Notify({
      Title = "System",
      Content = "Previous config loaded successfully!",
      Duration = 4,
    })
  end
end
