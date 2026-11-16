local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "mj2yxT1rmvi" / (15992809 - "8TtSx" ^ 1077281) end) })[2]
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
          pcall(function() return "xldg4v" / (10758985 - "l6qsrA" ^ 14370231) end),
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

print("V1")

local airFlow = loadstring(isfile and isfile("Airflow.lua") and readfile("Airflow.lua")
  or game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoid/refs/heads/main/AirFlow"))()

local v12 = getgenv and getgenv() or _G

if type(v12.SoccerTouchFootballUnload) == "function" then
  pcall(v12.SoccerTouchFootballUnload)
end

local runService = game:GetService("RunService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
character:WaitForChild("Humanoid")
local v13 = {}

local function f1(p1)
  table.insert(v13, p1)
  return p1
end

local goalA = workspace.FootballField.Pitch.GoalA
local goalB = workspace.FootballField.Pitch.GoalB
local findFirstChild = workspace.FootballField:FindFirstChild("SoccerBall", true)

local function f2()
  if findFirstChild and findFirstChild.Parent then
    return findFirstChild
  end

  findFirstChild = workspace.FootballField:FindFirstChild("SoccerBall", true)
  return findFirstChild
end

f1(workspace.FootballField.DescendantAdded:Connect(function(descendant)
  if descendant.Name == "SoccerBall" then
    findFirstChild = descendant
  end
end))

local v14

local function f3()
  if not v14 then
    return nil
  end

  return v14:GetBoundingBox().Position
end

local function f4(adornee)
  local selectionBox = Instance.new("SelectionBox")
  selectionBox.LineThickness = 0.06
  selectionBox.SurfaceTransparency = 0.85
  selectionBox.Adornee = adornee
  selectionBox.Parent = workspace

  return selectionBox
end

local v15 = f4(goalA)
local v16 = f4(goalB)
local connect

local function f5()
  if connect then
    connect:Disconnect()
    connect = nil
  end
end

local function f6()
  local v17 = f2()
  local v18 = not v17 or not character or not character.Parent
  local v19

  if v18 then
    return
  else
    local position = v17.Position

    if v14 then
      v19 = position - (f3() - position).Unit * 6
    else
      v19 = position + Vector3.new(
        humanoidRootPart.Position.X - position.X, 0, humanoidRootPart.Position.Z - position.Z
      ).Unit * 6
    end

    humanoidRootPart.CFrame = CFrame.lookAt(
      Vector3.new(v19.X, position.Y, v19.Z), Vector3.new(position.X, position.Y, position.Z)
    )

    return
  end
end

local color = Color3.fromRGB(130, 80, 255)
local color2 = Color3.fromRGB(60, 60, 80)
local connect2

local function f7()
  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end
end

local function f8()
  if v14 == goalA then
    v15.Color3 = color
    v15.SurfaceColor3 = color
    v15.SurfaceTransparency = 0.55

    v16.Color3 = color2
    v16.SurfaceColor3 = color2
    v16.SurfaceTransparency = 0.88
  elseif v14 == goalB then
    v16.Color3 = color
    v16.SurfaceColor3 = color
    v16.SurfaceTransparency = 0.55

    v15.Color3 = color2
    v15.SurfaceColor3 = color2
    v15.SurfaceTransparency = 0.88
  else
    v15.Color3 = color2
    v15.SurfaceColor3 = color2
    v15.SurfaceTransparency = 0.88

    v16.Color3 = color2
    v16.SurfaceColor3 = color2
    v16.SurfaceTransparency = 0.88
  end
end

f8()

local snapRadius = 8
local v20 = false
local v21 = false

local function f9()
  if connect2 then
    return
  end

  connect2 = runService.Heartbeat:Connect(function()
    if not v21 or not character or not character.Parent then
      return
    elseif not v14 then
      return
    else
      local v22 = f3()
      local position2 = humanoidRootPart.Position
      humanoidRootPart.CFrame = CFrame.lookAt(position2, Vector3.new(v22.X, position2.Y, v22.Z))
      return
    end
  end)
end

local v23 = false
local connect3 = nil

local function f10()
  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end
end

connect = nil

local function f11()
  if connect then
    return
  end

  connect = runService.Heartbeat:Connect(function()
    if not v23 or not character or not character.Parent then
      return
    else
      local v24 = f2()

      if not v24 then
        return
      else
        local position3 = v24.Position
        local position4 = humanoidRootPart.Position

        humanoidRootPart.CFrame = CFrame.lookAt(position4, Vector3.new(
          position3.X, position4.Y, position3.Z
        ))

        return
      end
    end
  end)
end

connect2 = nil
local f12

local function f13()
  if connect3 then
    return
  end

  connect3 = runService.Heartbeat:Connect(function()
    if not v20 or not character or not character.Parent then
      return
    else
      local v25 = f2()

      if not v25 then
        return
      end

      if (humanoidRootPart.Position
          - Vector3.new(v25.Position.X, humanoidRootPart.Position.Y, v25.Position.Z)).Magnitude
        <= snapRadius then
        f12()
      end

      return
    end
  end)
end

function f12()
  local v26 = f2()

  if not v26 or not character or not character.Parent then
    return
  else
    local v27 = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 2
    v26.CFrame = CFrame.new(v27.X, humanoidRootPart.Position.Y, v27.Z)

    if v14 then
      local v28 = f3()
      local position5 = humanoidRootPart.Position
      humanoidRootPart.CFrame = CFrame.lookAt(position5, Vector3.new(v28.X, position5.Y, v28.Z))
    end

    return
  end
end

f1(localPlayer.CharacterAdded:Connect(function(character2)
  character = character2
  humanoidRootPart = character2:WaitForChild("HumanoidRootPart")
  character2:WaitForChild("Humanoid")
end))

if type(airFlow.SetTheme) == "function" then
  airFlow:SetTheme("Midnight")
end

if type(airFlow.MainCredit) == "function" then
  airFlow:MainCredit()
  airFlow:SetScriptName("Soccer-Touch-Football")
end

local window = airFlow:CreateWindow({
  Name = "Soccer Touch Football",
  Subtitle = "AKkiwi HUB",
  Icon = "volleyball",
  ToggleUIKeybind = "RightControl",
  Size = UDim2.fromOffset(560, 420),
  MinSize = Vector2.new(460, 320),
  KeepOnScreen = true,
  ConfigurationSaving = {
    Enabled = true,
    FolderName = "AKkiwiHub",
    FileName = "Soccer-Touch-Football",
    AutoLoad = true,
  },
  OpenButton = { Title = "Football", Icon = "volleyball" },
})

local function f14(title, content, p2)
  task.spawn(function()
    pcall(function()
      window:Notify({
        Title = title,
        Content = content,
        Type = p2,
        Duration = 2,
      })
    end)
  end)
end

local soccerTouchFootballButtons = Instance.new("ScreenGui")
soccerTouchFootballButtons.Name = "SoccerTouchFootballButtons"
soccerTouchFootballButtons.ResetOnSpawn = false
soccerTouchFootballButtons.DisplayOrder = 998
soccerTouchFootballButtons.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
soccerTouchFootballButtons.Parent = gethui and gethui() or game:GetService("CoreGui")

local function f15(text, position6, fn)
  local textButton = Instance.new("TextButton")
  textButton.Size = UDim2.fromOffset(58, 58)
  textButton.Position = position6
  textButton.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
  textButton.BackgroundTransparency = 0.1
  textButton.AutoButtonColor = true
  textButton.Text = text
  textButton.TextColor3 = Color3.fromRGB(235, 235, 245)
  textButton.TextSize = 14
  textButton.Font = Enum.Font.GothamBold
  textButton.Parent = soccerTouchFootballButtons

  local uiCorner = Instance.new("UICorner")
  uiCorner.CornerRadius = UDim.new(0, 12)
  uiCorner.Parent = textButton

  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = color
  uiStroke.Thickness = 1.5
  uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
  uiStroke.Parent = textButton

  local v29 = false
  local v30 = false
  local position7, v31, v32

  textButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
      or input.UserInputType == Enum.UserInputType.Touch then
      v29 = true
      v30 = false
      local position8 = textButton.Position
      position7 = input.Position
      v31 = position8
      v32 = input
    end
  end)

  f1(userInputService.InputChanged:Connect(function(input2)
    if not v29 then
      return
    end

    if input2.UserInputType ~= Enum.UserInputType.MouseMovement and input2 ~= v32 then
      return
    else
      local v33 = input2.Position - position7

      if v33.Magnitude > 6 then
        v30 = true
      end

      if v30 then
        textButton.Position = UDim2.new(
          v31.X.Scale, v31.X.Offset + v33.X, v31.Y.Scale, v31.Y.Offset + v33.Y
        )
      end

      return
    end
  end))

  f1(userInputService.InputEnded:Connect(function(input3)
    if not v29 then
      return
    end

    if input3.UserInputType == Enum.UserInputType.MouseButton1 or input3 == v32 then
      v29 = false

      if not v30 then
        fn()
      end
    end
  end))

  return textButton
end

f15([[
TP
Ball]], UDim2.new(0, 20, 0.5, -70), function()
  f6()
  f14("Teleport", "Teleported behind the ball!")
end)

f15([[
Ball
Feet]], UDim2.new(0, 20, 0.5, 0), function()
  f12()
  f14("Ball", "Ball at your feet!", "Success")
end)

local botTab = window:CreateTab({
  Name = "Bot",
  Desc = "Goal, ball snap and auto aim",
  Icon = "target",
})

botTab:CreateSection("Goal Selection")

botTab:CreateButton({
  Name = "Goal A",
  Icon = "goal",
  Style = "Primary",
  Callback = function()
    if v14 == goalA then
      v14 = nil
    else
      v14 = goalA
    end

    f8()
    f14("Goal", v14 == goalA and "Goal A selected" or "Selection cleared")
  end,
})

botTab:CreateButton({
  Name = "Goal B",
  Icon = "goal",
  Style = "Primary",
  Callback = function()
    if v14 == goalB then
      v14 = nil
    else
      v14 = goalB
    end

    f8()
    f14("Goal", v14 == goalB and "Goal B selected" or "Selection cleared")
  end,
})

botTab:CreateSection("Ball Snap")

botTab:CreateParagraph({
  Title = "⚠️ WARNING",
  Content = "Ball Snap locks the ball to your feet at all times. This is extremely powerful and very noticeable to other players. Use at your own risk.",
})

botTab:CreateSlider({
  Name = "Snap radius",
  Min = 2,
  Max = 20,
  Step = 1,
  Default = snapRadius,
  Suffix = " st",
  Flag = "STF_SnapRadius",
  Callback = function(value) snapRadius = value end,
})

botTab:CreateToggle({
  Name = "Ball Snap",
  Default = false,
  Flag = "STF_BallSnap",
  Callback = function(value2)
    v20 = value2

    if value2 then
      f13()
      f14("Ball Snap", "Snap enabled!", "Success")
    else
      f10()
      f14("Ball Snap", "Snap disabled.")
    end
  end,
})

botTab:CreateSection("Auto Aim")

botTab:CreateToggle({
  Name = "Auto aim ball",
  Default = false,
  Flag = "STF_AimBall",
  Callback = function(value3)
    v23 = value3

    if value3 then
      f11()
      f14("Aim Ball", "Enabled!", "Success")
    else
      f5()
      f14("Aim Ball", "Disabled.")
    end
  end,
})

botTab:CreateToggle({
  Name = "Auto aim goal",
  Default = false,
  Flag = "STF_AimGoal",
  Callback = function(value4)
    v21 = value4

    if value4 then
      f9()
      f14("Aim Goal", "Enabled!", "Success")
    else
      f7()
      f14("Aim Goal", "Disabled.")
    end
  end,
})

window:CreateTab({ Name = "Settings", Desc = "Configs", Icon = "settings" }):CreateConfigManager({
  Name = "Configs",
})

local v34 = false

local function f16()
  if v34 then
    return
  end

  v34 = true
  v20 = false
  v23 = false
  v21 = false
  f10()
  f5()
  f7()

  for index, value5 in ipairs(v13) do
    pcall(function() end)
  end

  pcall(function() v15:Destroy() end)
  pcall(function() v16:Destroy() end)
  pcall(function() soccerTouchFootballButtons:Destroy() end)
  pcall(function() window:Destroy() end)

  if v12.SoccerTouchFootballUnload == f16 then
    v12.SoccerTouchFootballUnload = nil
  end
end

v12.SoccerTouchFootballUnload = f16

if window.Gui then
  window.Gui.Destroying:Connect(f16)
end

if not window.AutoLoad then
  task.defer(function()
    local v35, v36 = pcall(function() return window:LoadConfig(nil, false) end)

    if not (v35 and v36) then
      pcall(function() window:SaveConfig() end)
      pcall(function() window:LoadConfig(nil, true) end)
    end
  end)
end
