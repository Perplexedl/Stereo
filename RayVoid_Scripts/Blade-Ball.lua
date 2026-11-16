local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "ziRZOjfKtNI" / (6074042 - "QYmD" ^ 10935118) end) })[2]
local v4 = tonumber(gmatch(tostring(v3), ":(%d*):")())

for i = 1, v2 do
  local v5 = i
  local v6 = math.random(1, 100)
  local v7 = random(0, 255)
  local v8 = random(1, v6)
  local v9 = random(1, 2) == 1
  local gsub = v3:gsub(":(%d*):", ":" .. tostring(random(0, 10000)) .. ":")

  local v10 = {
    pcall(function()
      if random(1, 2) == 1 or v5 == v2 then
        tonumber(gmatch(tostring(({
          pcall(function() return "mHLiAAKPyIQ" / (5504680 - "6di75AmwOkfEa" ^ 9307933) end),
        })[2]), ":(%d*):")())
      end

      if v9 then
        error(gsub, 0)
      end

      local v11 = {}

      for j = 1, v6 do
        v11[j] = random(0, 255)
      end

      v11[v8] = v7
      return v1(v11)
    end),
  }
end

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local virtualInputManager = game:GetService("VirtualInputManager")
local userInputService = game:GetService("UserInputService")
local v12 = game
local v13

local function f1()
  return tick() < v13
end

v12:GetService("TweenService")
local localPlayer = players.LocalPlayer
local v14 = game

local function f2()
  local v15, v16 = pcall(function() return localPlayer:GetNetworkPing() end)
  return v15 and v16 and v16 > 0 and v16 or 0.06
end

local rayVoid = loadstring(v14:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:ShowCredit()
rayVoid:SetScriptName("BladeBall Hub V2")

local function f3(p1)
  return p1:GetAttribute("target")
end

local window = rayVoid:CreateWindow({
  Name = "Blade Ball Hub V2 (flat cooldown)",
  ConfigurationSaving = { Enabled = true, FileName = "BladeBallHubV2" },
})

local v17 = false
local v18 = true
local v19 = true
local v20 = false
local v21 = false
local macroCPS = 150
local v22 = false

local function f4()
  if v21 then
    return
  end

  v21 = true

  task.spawn(function()
    while v20 and v21 do
      virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
      task.wait(0.003)
      virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
      task.wait(1 / macroCPS)
    end

    v21 = false
  end)
end

local count = 0
local count2 = 0
local v23 = false
local v24 = 0.3
local v25 = false
local v26 = 0
local v27 = 0

local function f5(p2)
  local magnitude = 0
  pcall(function() magnitude = p2.zoomies.VectorVelocity.Magnitude end)

  if magnitude == 0 then
    pcall(function() magnitude = p2.Velocity.Magnitude end)
  end

  if magnitude > 1 then
    v26 = magnitude
    v27 = tick()
    return magnitude
  end

  if tick() - v27 < 0.1 then
    return v26
  end

  return 0
end

local v28 = {}
local v29 = 0
local v30 = false
local v31, f6

local function f7()
  if v31 and v31.Parent then
    return v31
  end

  v31 = f6()
  return v31
end

function f6()
  local balls = workspace:FindFirstChild("Balls")

  if not balls then
    return nil
  end

  for index, value in ipairs(balls:GetChildren()) do
    if value:GetAttribute("realBall") then
      return value
    end
  end
end

local function f8()
  v25 = false
end

local function f9(p3)
  return f3(p3) == localPlayer.Name
end

local v32 = nil

local function f10(p4)
  if v32 == p4 then
    return
  end

  v32 = p4

  p4:GetAttributeChangedSignal("ParryTime"):Connect(function()
    local parryTime = p4:GetAttribute("ParryTime")

    if type(parryTime) == "number" and parryTime > 0 then
      v13 = tick() + parryTime
    end
  end)
end

local function f11(p5)
  if not p5 then
    return
  end

  table.insert(v28, p5.Position)

  if #v28 > 10 then
    table.remove(v28, 1)
  end

  if #v28 < 3 then
    v30 = false
    v29 = 0
    return
  else
    local v33 = v28[#v28 - 1]
    local v34 = v33 - v28[#v28 - 2]
    local v35 = v28[#v28] - v33

    if v34.Magnitude < 0.1 or v35.Magnitude < 0.1 then
      v30 = false
      v29 = 0
      return
    else
      local dot = v34.Unit:Dot(v35.Unit)
      local v36 = math.clamp(dot, -1, 1)
      v29 = math.deg(math.acos(v36))
      v30 = v29 > 10
      return
    end
  end
end

v13 = 0

local function f12()
  v20 = false
  v21 = false
end

local f13

local function f14(p6)
  local v37 = f13()

  if not v37 then
    return 9999
  end

  return (v37.Position - p6.Position).Magnitude
end

function f13()
  local character = localPlayer.Character
  return character and character:FindFirstChild("HumanoidRootPart")
end

local waitForChild = nil

pcall(function()
  waitForChild = game:GetService("ReplicatedStorage").Remotes:WaitForChild("ParryAttempt", 5)
end)

local function f15()
  if waitForChild then
    pcall(function() waitForChild:FireServer() end)
  end

  virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)

  task.defer(function()
    task.wait(0.03)
    virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
  end)
end

local function f16(p7)
  local v38 = f5(p7)
  local v39 = f14(p7)
  local v40 = f2()
  local v41 = v18 and v30
  local v42

  if v41 then
    if v29 > 40 then
      v42 = 0.18
    elseif v29 > 25 then
      v42 = 0.25
    else
      v42 = 0.32
    end
  elseif v39 < 6 then
    v42 = 0.9
  elseif v39 < 12 then
    v42 = 0.72
  elseif v38 > 350 then
    v42 = 0.44
  elseif v38 > 250 then
    v42 = 0.5
  elseif v38 > 150 then
    v42 = 0.55
  elseif v38 > 80 then
    v42 = 0.6
  else
    v42 = 0.65
  end

  return v42 + v40
end

local function f17()
  if v25 then
    return
  end

  v25 = true

  task.spawn(function()
    while v25 do
      f15()
      task.wait(0.016)
    end
  end)
end

local function f18(p8, p9)
  local v43 = p9 and p9 <= 10
  local vector

  if v43 then
    return true
  else
    local v44 = f13()

    if not v44 then
      return false
    end

    vector = Vector3.new(0, 0, 0)
    pcall(function() vector = p8.zoomies.VectorVelocity end)

    if vector.Magnitude < 1 then
      return false
    end

    return vector.Unit:Dot((v44.Position - p8.Position).Unit) > 0.55
  end
end

local connect, connect2, connect3

local function f19()
  if connect3 then
    pcall(function() connect3:Disconnect() end)
  end

  if connect2 then
    pcall(function() connect2:Disconnect() end)
  end

  if connect then
    pcall(function() connect:Disconnect() end)
  end

  connect3 = nil
  connect2 = nil
  connect = nil
  v22 = false

  if v25 then
    f8()
  end
end

local attachment = nil
local highlight, billboardGui, textLabel, part, beam, attachment2

local function f20()
  pcall(function()
    if highlight then
      highlight:Destroy()
    end
  end)

  pcall(function()
    if billboardGui then
      billboardGui:Destroy()
    end
  end)

  pcall(function()
    if part then
      part:Destroy()
    end
  end)

  pcall(function()
    if attachment2 then
      attachment2:Destroy()
    end
  end)

  highlight = nil
  billboardGui = nil
  textLabel = nil
  part = nil
  beam = nil
  attachment2 = nil
  attachment = nil
end

local f21
local connect4

local function f22()
  f21()

  connect4 = runService.RenderStepped:Connect(function()
    if not v19 then
      if highlight then
        f20()
      end

      return
    else
      local v45 = f6()

      if not v45 then
        if highlight then
          f20()
        end

        return
      else
        local v46 = f13()
        local v47 = f9(v45)

        local color = v47
        color = v47 and Color3.fromRGB(255, 50, 50)

        local color2 = color
        color2 = color or Color3.fromRGB(0, 255, 70)

        local v48 = not highlight
        local v49 = color2

        if v48 or highlight.Parent ~= v45 then
          pcall(function()
            if highlight then
              highlight:Destroy()
            end
          end)

          highlight = Instance.new("Highlight")
          highlight.Adornee = v45
          highlight.FillTransparency = 0.3
          highlight.OutlineTransparency = 0
          highlight.Parent = v45
        end

        highlight.FillColor = v49
        highlight.OutlineColor = v49

        if not billboardGui or billboardGui.Parent ~= v45 then
          pcall(function()
            if billboardGui then
              billboardGui:Destroy()
            end
          end)

          billboardGui = Instance.new("BillboardGui")
          billboardGui.Adornee = v45
          billboardGui.Size = UDim2.new(0, 110, 0, 26)
          billboardGui.StudsOffset = Vector3.new(0, 3, 0)
          billboardGui.AlwaysOnTop = true
          billboardGui.Parent = v45

          textLabel = Instance.new("TextLabel")
          textLabel.Size = UDim2.new(1, 0, 1, 0)
          textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
          textLabel.BackgroundTransparency = 0.45
          textLabel.Font = Enum.Font.GothamBold
          textLabel.TextSize = 12
          textLabel.Text = ""
          textLabel.Parent = billboardGui

          Instance.new("UICorner", textLabel).CornerRadius = UDim.new(0, 5)
        end

        if v46 and textLabel then
          textLabel.Text = string.format("%.0fs  %.0fspd", f14(v45), f5(v45))
          textLabel.TextColor3 = v49
        end

        if v46 then
          if not part or part.Parent ~= workspace then
            pcall(function()
              if part then
                part:Destroy()
              end
            end)

            pcall(function()
              if attachment2 then
                attachment2:Destroy()
              end
            end)

            part = Instance.new("Part")
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 1
            part.Size = Vector3.new(0.1, 0.1, 0.1)
            part.Parent = workspace

            attachment2 = Instance.new("Attachment")
            attachment2.Parent = v46

            attachment = Instance.new("Attachment")
            attachment.Parent = part

            beam = Instance.new("Beam")
            beam.Attachment0 = attachment2
            beam.Attachment1 = attachment
            beam.Width0 = 0.12
            beam.Width1 = 0.12
            beam.FaceCamera = true
            beam.Transparency = NumberSequence.new(0.45)
            beam.Parent = part
          end

          part.Position = v45.Position
          beam.Color = ColorSequence.new(v49)

          if attachment2.Parent ~= v46 then
            pcall(function() attachment2:Destroy() end)

            attachment2 = Instance.new("Attachment")
            attachment2.Parent = v46

            beam.Attachment0 = attachment2
          end
        end

        return
      end
    end
  end)
end

function f21()
  f20()

  pcall(function()
    if connect4 then
      connect4:Disconnect()
    end
  end)

  connect4 = nil
end

local function f23()
  if connect3 then
    pcall(function() connect3:Disconnect() end)
  end

  if connect2 then
    pcall(function() connect2:Disconnect() end)
  end

  if connect then
    pcall(function() connect:Disconnect() end)
  end

  v22 = false
  v31 = nil
  v23 = false

  if localPlayer.Character then
    f10(localPlayer.Character)
  end

  localPlayer.CharacterAdded:Connect(f10)

  local function f24(p10)
    if connect then
      connect:Disconnect()
      connect = nil
    end

    v31 = p10

    connect = p10:GetAttributeChangedSignal("target"):Connect(function()
      v22 = false
      v28 = {}
      v30 = false
      v29 = 0

      if v25 then
        f8()
      end
    end)
  end

  connect3 = workspace.Balls.ChildAdded:Connect(function()
    task.wait(0.05)
    local v50 = f6()

    if v50 then
      f24(v50)
    end
  end)

  local v51 = f6()

  if v51 then
    f24(v51)
  end

  connect2 = runService.PreSimulation:Connect(function()
    if not v17 then
      return
    else
      local v52 = f7()

      if not v52 then
        return
      elseif not f13() then
        return
      else
        f11(v52)
        local character2 = localPlayer.Character
        local v53 = character2

        if character2 then
          local v54 = workspace
          v53 = character2.Parent == v54:FindFirstChild("Alive")
        end

        if not v53 then
          v23 = false

          if v25 then
            f8()
          end

          return
        else
          local v55 = f9(v52)
          local v56 = f14(v52)
          local v57 = f5(v52)
          local v58 = v57 > 1 and v56 / v57 or -1
          local v59 = v55 and f16(v52) or -1
          local v60 = v55 and f18(v52, v56) or false

          if v23 and not v55 then
            v22 = false
            count2 = count2 + 1
            v28 = {}
            v30 = false
            v29 = 0

            if v25 then
              f8()
            end
          end

          v23 = v55

          if not v55 then
            if v25 then
              f8()
            end

            return
          end

          if v57 < 5 then
            v22 = false

            if v25 then
              f8()
            end

            return
          end

          if v56 <= 5 then
            if not v25 then
              f17()
            end

            if not v22 and not f1() then
              f15()
              v22 = true
              count = count + 1
              task.delay(0.1, function() v22 = false end)
            end
          elseif v58 >= 0 and v58 <= 0.35 and v56 <= 45 then
            if not v25 then
              f17()
            end

            if not v22 and not f1() and v60 then
              if v58 <= v59 then
                f15()
                v22 = true
                count = count + 1
                task.delay(0.18, function() v22 = false end)
              end
            end
          else
            if v25 then
              f8()
            end

            if not v22 and not f1() and v60 and v58 >= 0 and v58 <= v59 then
              f15()
              task.delay(0.04, f15)
              v22 = true
              count = count + 1
              task.delay(v24, function() v22 = false end)
            end
          end

          return
        end
      end
    end
  end)
end

local parryTab = window:CreateTab("Parry", "sword")
local visualsTab = window:CreateTab("Visuals", "eye")
local statusTab = window:CreateTab("Status", "activity")

parryTab:CreateSection("Smart Parry")

parryTab:CreateToggle({
  Name = "Smart Parry",
  CurrentValue = v17,
  Flag = "smartParry",
  Callback = function(value2)
    v17 = value2

    if value2 then
      f23()
    else
      f19()
    end
  end,
})

parryTab:CreateKeybind({
  Name = "Smart Parry Toggle Key",
  CurrentKeybind = "F5",
  HoldToInteract = false,
  Flag = "smartParryKey",
  Callback = function()
    v17 = not v17

    parryTab:Notify({
      Title = "Smart Parry",
      Content = v17 and "Enabled" or "Disabled",
      Duration = 2,
    })

    if v17 then
      f23()
    else
      f19()
    end
  end,
})

parryTab:CreateParagraph({
  Title = "Modes",
  Content = "< 5 studs = PANIC (spam parry)  |  time-to-impact < 0.35s & < 45 studs = CLOSE (clash + parry)  |  else = FAR (threshold parry)",
})

parryTab:CreateSection("Anti-Curve")

parryTab:CreateToggle({
  Name = "Anti-Curve",
  CurrentValue = v18,
  Flag = "antiCurve",
  Callback = function(value3) v18 = value3 end,
})

parryTab:CreateKeybind({
  Name = "Anti-Curve Toggle Key",
  CurrentKeybind = "F6",
  HoldToInteract = false,
  Flag = "antiCurveKey",
  Callback = function()
    v18 = not v18

    rayVoid:Notify({
      Title = "Anti-Curve",
      Content = v18 and "Enabled" or "Disabled",
      Duration = 2,
    })
  end,
})

parryTab:CreateParagraph({
  Title = "Anti-Curve Info",
  Content = "Automatically detects curving trajectories and lowers the threshold to parry earlier.",
})

parryTab:CreateSection("FAR Cooldown")

parryTab:CreateSlider({
  Name = "Max cooldown after a FAR shot",
  Range = { 0, 300 },
  Increment = 10,
  Suffix = " ms",
  CurrentValue = v24 * 1000,
  Flag = "farCooldownMs",
  Callback = function(value4) v24 = value4 / 1000 end,
})

parryTab:CreateParagraph({
  Title = "Info",
  Content = "The real cooldown after a FAR shot is now dynamic: half the time-to-impact at the moment of firing (speed + distance combined), capped by this slider. Slow/far ball = cooldown near the cap. Fast/close ball = cooldown crushed down so it can retry fast. IsGameBusy() still applies on top either way.",
})

parryTab:CreateSection("Hold Macro")

parryTab:CreateSlider({
  Name = "Macro CPS",
  Range = { 50, 300 },
  Increment = 10,
  Suffix = " CPS",
  CurrentValue = macroCPS,
  Flag = "macroCps",
  Callback = function(value5) macroCPS = value5 end,
})

parryTab:CreateKeybind({
  Name = "Macro Hold Key",
  CurrentKeybind = "E",
  HoldToInteract = true,
  Flag = "macroKey",
  Callback = function() end,
})

parryTab:CreateParagraph({
  Title = "Macro",
  Content = "Hold the assigned key to spam clicks at the configured CPS rate.",
})

visualsTab:CreateSection("Ball ESP")

visualsTab:CreateToggle({
  Name = "Ball ESP",
  CurrentValue = v19,
  Flag = "ballEsp",
  Callback = function(value6)
    v19 = value6

    if not value6 then
      f21()
    else
      f22()
    end
  end,
})

visualsTab:CreateKeybind({
  Name = "Ball ESP Toggle Key",
  CurrentKeybind = "F8",
  HoldToInteract = false,
  Flag = "ballEspKey",
  Callback = function()
    v19 = not v19

    rayVoid:Notify({
      Title = "Ball ESP",
      Content = v19 and "Enabled" or "Disabled",
      Duration = 2,
    })

    if not v19 then
      f21()
    else
      f22()
    end
  end,
})

visualsTab:CreateParagraph({
  Title = "ESP Info",
  Content = "Red = the ball is targeting you  |  Green = the ball is targeting someone else. Shows distance, speed, and a beam to the ball.",
})

statusTab:CreateSection("Live Status")
local label = statusTab:CreateLabel("Waiting for a ball...", "activity")
local label2 = statusTab:CreateLabel("", "zap")
local label3 = statusTab:CreateLabel("", "shield")
local label4 = statusTab:CreateLabel("", "settings")
local label5 = statusTab:CreateLabel("", "eye")
local label6 = statusTab:CreateLabel("", "wifi")

userInputService.InputBegan:Connect(function(input, p11)
  if p11 then
    return
  end

  if input.KeyCode == Enum.KeyCode.E then
    v20 = true
    f4()
  end
end)

userInputService.InputEnded:Connect(function(input2)
  if input2.KeyCode == Enum.KeyCode.E then
    f12()
  end
end)

runService.Heartbeat:Connect(function()
  local v61 = f7()

  if not v61 then
    label:Set("Smart Parry: " .. (v17 and "ON — waiting for a ball..." or "OFF"))
    label2:Set("")
    label3:Set("")
    label4:Set("")
    label5:Set("")
    label6:Set(string.format("Ping: %.0fms", f2() * 1000))
    return
  else
    local v62 = f5(v61)
    local v63 = f14(v61)
    local v64 = f9(v61)
    local v65 = v63 <= 5 and "PANIC" or v63 <= 45 and "CLOSE" or "FAR"

    if v64 then
      local v66 = v62 > 0 and v63 / v62 or 0

      label:Set(string.format(
        "🎯 TARGETING YOU  [%s]  |  %.1f studs  |  %.0f spd  |  tth: %.2f", v65, v63, v62, v66
      ))
    else
      label:Set(string.format("👁 Active  |  spd: %.0f  |  target: %s", v62, tostring(f3(v61))))
    end

    local v67 = count > 0 and count2 / count * 100 or 0

    label2:Set(string.format(
      "Parry: %s  |  Attempts: %d  |  Success: %d (%.0f%%)  |  Clash: %s", v22 and "CD" or "OK",
      count, count2, v67, v25 and "SPAM" or "OFF"
    ))

    if v18 and v30 then
      label3:Set(string.format(
        "⚠️ CURVE DETECTED  |  Angle: %.1f°  |  Threshold: %.2f", v29, f16(v61)
      ))
    else
      label3:Set(string.format("Curve: %.1f°  |  Threshold: %.2f", v29, f16(v61)))
    end

    label4:Set(string.format("Macro: %s  |  CPS: %d", v21 and "ACTIVE" or "OFF", macroCPS))

    label5:Set(string.format(
      "ESP: %s  |  Anti-Curve: %s  |  Smart Parry: %s", v19 and "ON" or "OFF",
      v18 and "ON" or "OFF", v17 and "ON" or "OFF"
    ))

    label6:Set(string.format(
      "Ping: %.0fms  |  Game busy: %s", f2() * 1000, f1() and "YES" or "no"
    ))

    return
  end
end)

f22()

rayVoid:LoadConfiguration()

rayVoid:Notify({
  Title = "Blade Ball Hub",
  Message = "V2 loaded — flat 0.3s cooldown, no closing-speed timing",
  Type = "success",
  Duration = 4,
})
