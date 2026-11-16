if game.PlaceId ~= 93233198656969 then
  pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "Wrong Game!",
      Text = "You exec this script in WRONG GAME, it should be FREE FIRE MAX...",
      Duration = 10,
    })
  end)

  return
end

local ui = loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/lamduck2005/RobloxScript/master/ui.lua", true
))()

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local runService = game:GetService("RunService")

local v1 = {
  Config = {
    KillAura = false,
    KillAuraRadius = 150,
    DrawAuraRange = false,
    ESPEnabled = false,
    ESPTracers = false,
    ESPColor = Color3.fromRGB(255, 50, 50),
  },
  Flags = { isKillAuraRunning = false },
}

local v2 = {}
local currentCamera = workspace.CurrentCamera

local auraRingOuter = Instance.new("CylinderHandleAdornment")
auraRingOuter.Name = "AuraRingOuter"
auraRingOuter.Height = 0.15
auraRingOuter.Color3 = Color3.fromRGB(0, 255, 100)
auraRingOuter.Transparency = 0.2
auraRingOuter.AlwaysOnTop = false
auraRingOuter.ZIndex = 2
auraRingOuter.Parent = game.CoreGui

local auraRingInner = Instance.new("CylinderHandleAdornment")
auraRingInner.Name = "AuraRingInner"
auraRingInner.Height = 0.01
auraRingInner.Color3 = Color3.fromRGB(0, 255, 100)
auraRingInner.Transparency = 0.9
auraRingInner.AlwaysOnTop = false
auraRingInner.ZIndex = 1
auraRingInner.Parent = game.CoreGui

local function f1()
  if v1.Flags.isKillAuraRunning then
    return
  end

  v1.Flags.isKillAuraRunning = true

  task.spawn(function()
    local weaponHit = game:GetService("ReplicatedStorage"):WaitForChild("Eventos"):WaitForChild("WeaponHit")

    while v1.Config.KillAura do
      local character = localPlayer.Character
      local tool = character and character:FindFirstChildOfClass("Tool")

      if tool then
        for index, value in ipairs(players:GetPlayers()) do
          if value ~= localPlayer and value.Character then
            local head = value.Character:FindFirstChild("Head")
            local humanoid = value.Character:FindFirstChild("Humanoid")
            local humanoidRootPart = value.Character:FindFirstChild("HumanoidRootPart")

            if humanoid and humanoid.Health > 0 and head and humanoidRootPart then
              if value.Team == nil or value.Team ~= localPlayer.Team then
                local magnitude = (character.HumanoidRootPart.Position
                  - humanoidRootPart.Position).Magnitude

                if magnitude <= v1.Config.KillAuraRadius then
                  pcall(function()
                    weaponHit:FireServer(tool, {
                      p = head.Position,
                      pid = 1,
                      part = head,
                      d = magnitude,
                      maxDist = 1000,
                      h = humanoid,
                      m = Enum.Material.Plastic,
                      n = Vector3.new(0, 1, 0),
                      t = tick(),
                      sid = math.random(1, 100),
                    })
                  end)
                end
              end
            end
          end
        end
      end

      task.wait(0.1)
    end

    v1.Flags.isKillAuraRunning = false
  end)
end

runService.RenderStepped:Connect(function()
  local character2 = localPlayer.Character
  local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

  if v1.Config.DrawAuraRange and humanoidRootPart2 then
    local cframe = CFrame.new(0, -humanoidRootPart2.Size.Y / 2 - 2.8, 0)
      * CFrame.Angles(math.rad(90), 0, 0)

    auraRingOuter.Adornee = humanoidRootPart2
    auraRingOuter.Radius = v1.Config.KillAuraRadius
    auraRingOuter.InnerRadius = v1.Config.KillAuraRadius - 1
    auraRingOuter.Visible = true
    auraRingOuter.CFrame = cframe

    auraRingInner.Adornee = humanoidRootPart2
    auraRingInner.Radius = v1.Config.KillAuraRadius - 1
    auraRingInner.InnerRadius = 0
    auraRingInner.Visible = true
    auraRingInner.CFrame = cframe
  else
    auraRingOuter.Visible = false
    auraRingInner.Visible = false
  end

  for index2, value2 in ipairs(players:GetPlayers()) do
    if value2 ~= localPlayer then
      local character3 = value2.Character
      local humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")
      local humanoid2 = character3 and character3:FindFirstChild("Humanoid")
      local v3 = humanoid2 and humanoid2.Health > 0 and humanoidRootPart3
      local v4 = value2.Team == nil or value2.Team ~= localPlayer.Team

      if not v2[value2] then
        v2[value2] = {}
      end

      if v1.Config.ESPEnabled and v3 and v4 then
        if not v2[value2].Highlight then
          local highlight = Instance.new("Highlight")
          highlight.FillColor = v1.Config.ESPColor
          highlight.OutlineColor = Color3.new(1, 1, 1)
          highlight.FillTransparency = 0.5
          highlight.OutlineTransparency = 0
          highlight.Parent = game.CoreGui

          v2[value2].Highlight = highlight
        end

        v2[value2].Highlight.Adornee = character3
        v2[value2].Highlight.Enabled = true
      elseif v2[value2].Highlight then
        v2[value2].Highlight.Enabled = false
      end

      if v1.Config.ESPTracers and v3 and v4 then
        if not v2[value2].Tracer then
          local line = Drawing.new("Line")
          line.Thickness = 1.5
          line.Color = v1.Config.ESPColor
          line.Transparency = 1
          line.ZIndex = 1

          v2[value2].Tracer = line
        end

        local v5, v6 = currentCamera:WorldToViewportPoint(humanoidRootPart3.Position)

        if v6 then
          v2[value2].Tracer.From = Vector2.new(currentCamera.ViewportSize.X / 2, 0)
          v2[value2].Tracer.To = Vector2.new(v5.X, v5.Y)
          v2[value2].Tracer.Visible = true
        else
          v2[value2].Tracer.Visible = false
        end
      elseif v2[value2].Tracer then
        v2[value2].Tracer.Visible = false
      end
    end
  end
end)

players.PlayerRemoving:Connect(function(player)
  if v2[player] then
    if v2[player].Highlight then
      v2[player].Highlight:Destroy()
    end

    if v2[player].Tracer then
      v2[player].Tracer:Remove()
    end

    v2[player] = nil
  end
end)

local window = ui:CreateWindow({ Title = "FREE FIRE MAX", Icon = "crosshair" })

local v7 = {}
v7.Combat = window:Tab({ Title = "Combat", Icon = "swords" })
v7.Visuals = window:Tab({ Title = "Visuals", Icon = "eye" })
v7.Combat:Section({ Title = "RAGE FEATURES" })

v7.Combat:Toggle({
  Title = "Enable Kill Aura",
  Desc = "Automatically shoots enemies within your radius (Hold a gun).",
  Value = v1.Config.KillAura,
  Callback = function(value3)
    v1.Config.KillAura = value3

    if value3 then
      f1()
    end
  end,
})

v7.Combat:Toggle({
  Title = "Show Kill Aura Radius",
  Desc = "Draws a 3D circle on the ground showing your deadly range.",
  Value = v1.Config.DrawAuraRange,
  Callback = function(value4) v1.Config.DrawAuraRange = value4 end,
})

v7.Combat:Slider({
  Title = "Kill Aura Radius",
  Step = 10,
  Value = { Min = 1, Max = 1000, Default = 150 },
  Callback = function(value5) v1.Config.KillAuraRadius = value5 end,
})

v7.Visuals:Section({ Title = "ESP (WALLHACK)" })

v7.Visuals:Toggle({
  Title = "Enable Chams ESP",
  Desc = "Highlights enemies through walls.",
  Value = v1.Config.ESPEnabled,
  Callback = function(value6) v1.Config.ESPEnabled = value6 end,
})

v7.Visuals:Toggle({
  Title = "Enable Tracers",
  Desc = "Draws a line from you to all enemies.",
  Value = v1.Config.ESPTracers,
  Callback = function(value7) v1.Config.ESPTracers = value7 end,
})

pcall(function() v7.Combat:Select() end)
