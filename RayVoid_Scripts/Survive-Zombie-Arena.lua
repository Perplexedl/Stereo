local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "mdBRI1AGgAnT" / (7361761 - "fwasM4fM" ^ 6463174) end) })[2]
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
          pcall(function() return "BTQ" / (14019500 - "uaXpBJ5sqRfbVo" ^ 4578956) end),
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
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local stats = game:GetService("Stats")
local virtualUser = game:GetService("VirtualUser")
local localPlayer = players.LocalPlayer

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:MainCredit()
rayVoid:SetScriptName("Survive-Zombie-Arena")

local window = rayVoid:CreateWindow({
  Name = "Survive Zombie Arena | AKkiwi HUB",
  LoadingTitle = "Survive Zombie Arena Script",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "Survive Zombie Arena" },
})

local mainTab = window:CreateTab("Main", "shield")
local shopTab = window:CreateTab("Shop", "banknote")
local rollTab = window:CreateTab("Roll", "dices")
local miscTab = window:CreateTab("Misc", "settings")
local range = 60
local zaCount = 8
local v12 = false
local v13 = false
local v14 = false
local v15 = false
local v16 = false
local v17 = false
local v18 = false
local v19 = false
local v20 = false
local v21 = false
local v22 = false
local v23 = false

local cframe = CFrame.new(
  -221.61351, 41.3945541, -283.593719, 0.998308182, -0.000439744443, 0.0581427775,
  8.71979555e-9, 0.99997139, 0.00756281661, -0.0581444427, -0.00755002117, 0.998279631
)

local function f1()
  local character = localPlayer.Character

  if not character then
    return nil, nil
  else
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then
      return nil, character
    end

    return humanoidRootPart, character
  end
end

local v24 = 0
local v25 = {}

local function f2(p1, p2)
  local v26 = p1 .. "/" .. p2
  local v27 = v25[v26]

  if v27 and v27.Parent then
    return v27
  else
    local v28, v29 = pcall(function()
      return replicatedStorage:WaitForChild("Remotes", 5):WaitForChild(p1, 5):WaitForChild(
        p2, 5
      )
    end)

    if v28 and v29 then
      v25[v26] = v29
      return v29
    end

    warn("[ZombieArena] remote introuvable : " .. v26)
    return nil
  end
end

local v30 = 0
local v31 = {}
local v32 = 0

local function f3(p3)
  if p3 - v32 < 2 then
    return
  end

  v32 = p3

  for key, value in pairs(v31) do
    if p3 - value > 3 then
      v31[key] = nil
    end
  end
end

local function f4()
  local v33 = os.clock()

  if v33 - v24 >= 1 then
    v24 = v33
    v30 = 0
  end

  if v30 >= 60 then
    return false
  end

  v30 = v30 + 1
  return true
end

local function f5()
  local v34, v35 = f1()

  if not v35 then
    return nil
  end

  for index, value2 in ipairs(v35:GetChildren()) do
    if value2:IsA("Tool") then
      return value2.Name
    end
  end

  return nil
end

local function f6()
  task.spawn(function()
    pcall(function()
      local v36 = f2("DataRemotes", "SetSetting")

      if v36 then
        v36:FireServer("PerformanceMode", true)
      end
    end)
  end)
end

local function f7(p4, p5)
  local v37 = f1()

  if not v37 then
    return {}
  else
    local zombiesLocal = workspace:FindFirstChild("Zombies_Local")

    if not zombiesLocal then
      return {}
    else
      local v38 = os.clock()
      f3(v38)
      local position = v37.Position
      local v39 = {}

      for index2, value3 in ipairs(zombiesLocal:GetChildren()) do
        local humanoidRootPart2 = value3:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart2 then
          local v40 = tonumber(value3.Name:match("%d+"))

          if v40 then
            local v41 = v31[v40]

            if not v41 or v38 - v41 >= 0.4 then
              local magnitude = (humanoidRootPart2.Position - position).Magnitude

              if magnitude <= p5 then
                table.insert(v39, {
                  id = v40,
                  pos = humanoidRootPart2.Position,
                  dist = magnitude,
                })
              end
            end
          end
        end
      end

      table.sort(v39, function(p6, p7) return p6.dist < p7.dist end)

      while #v39 > p4 do
        table.remove(v39)
      end

      return v39
    end
  end
end

pcall(function()
  localPlayer.Idled:Connect(function()
    virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
  end)
end)

mainTab:CreateSection("Kill Aura")

mainTab:CreateToggle({
  Name = "Auto Kill (Gun)",
  CurrentValue = false,
  Flag = "ZA_AutoGun",
  Callback = function(value4)
    v12 = value4

    if not value4 or v13 then
      return
    end

    v13 = true
    f6()

    task.spawn(function()
      while v12 do
        local v42 = f2("NetRemotes", "GunFire")
        local v43 = f2("GunRemotes", "GunHit")
        local v44 = f5()
        local v45 = f1()

        if v42 and v43 and v44 and v45 then
          local position2 = v45.Position
          local v46 = f7(zaCount, range)
          local v47 = os.clock()

          for index3, value5 in ipairs(v46) do
            local v48 = value5

            if f4() and f4() then
              v31[v48.id] = v47

              local unit = v48.pos - position2
              unit = unit.Magnitude > 0 and unit.Unit or Vector3.new(0, 0, 1)

              pcall(function()
                v42:FireServer(v44, position2, unit)
                v43:FireServer(v44, v48.id, v48.pos)
              end)
            end
          end
        end

        task.wait(0.2)
      end

      v13 = false
    end)
  end,
})

mainTab:CreateSlider({
  Name = "Range",
  Range = { 20, 500 },
  Increment = 10,
  Suffix = " studs",
  CurrentValue = 60,
  Flag = "ZA_Range",
  Callback = function(value6) range = value6 end,
})

mainTab:CreateSlider({
  Name = "Cibles par cycle",
  Range = { 1, 25 },
  Increment = 1,
  Suffix = " zombies",
  CurrentValue = 8,
  Flag = "ZA_Count",
  Callback = function(value7) zaCount = value7 end,
})

mainTab:CreateSection("Position")

local v49, toggle

local toggle2 = mainTab:CreateToggle({
  Name = "Safe Zone (position actuelle)",
  CurrentValue = false,
  Flag = "ZA_SafeZone",
  Callback = function(value8)
    v14 = value8
    local v50

    if value8 then
      if v16 and toggle then
        pcall(function() toggle:Set(false) end)
      end

      local v51 = f1()

      if not v51 then
        v14 = false
        warn("[ZombieArena] Safe Zone : pas de HRP")
        return
      end

      v49 = v51.CFrame + Vector3.new(0, 20, 0)
      v50 = not value8

      if v50 or v15 then
        return
      end

      v15 = true

      task.spawn(function()
        while v14 do
          local v52 = f1()

          if v52 and v49 then
            v52.AssemblyLinearVelocity = Vector3.zero
            v52.AssemblyAngularVelocity = Vector3.zero
            v52.CFrame = v49
          end

          task.wait()
        end

        v15 = false
      end)

      return
    end

    v50 = not value8

    if v50 or v15 then
      return
    end

    v15 = true

    task.spawn(function()
      while v14 do
        local v53 = f1()

        if v53 and v49 then
          v53.AssemblyLinearVelocity = Vector3.zero
          v53.AssemblyAngularVelocity = Vector3.zero
          v53.CFrame = v49
        end

        task.wait()
      end

      v15 = false
    end)
  end,
})

toggle = mainTab:CreateToggle({
  Name = "AFK Spot (position fixe)",
  CurrentValue = false,
  Flag = "ZA_AfkSpot",
  Callback = function(value9)
    v16 = value9

    if value9 and v14 and toggle2 then
      pcall(function() toggle2:Set(false) end)
    end

    if not value9 or v17 then
      return
    end

    v17 = true

    task.spawn(function()
      while v16 do
        local v54 = f1()

        if v54 then
          v54.AssemblyLinearVelocity = Vector3.zero
          v54.AssemblyAngularVelocity = Vector3.zero
          v54.CFrame = cframe
        end

        task.wait()
      end

      v17 = false
    end)
  end,
})

shopTab:CreateSection("Upgrades")

shopTab:CreateToggle({
  Name = "Auto Upgrade Health",
  CurrentValue = false,
  Flag = "ZA_UpgradeHp",
  Callback = function(value10)
    local v55 = not value10
    v18 = value10

    if v55 or v19 then
      return
    end

    v19 = true

    task.spawn(function()
      while v18 do
        local v56 = f2("UpgradeRemotes", "PurchaseHealthUpgrade")

        if v56 and f4() then
          pcall(function() v56:FireServer() end)
        end

        task.wait(0.5)
      end

      v19 = false
    end)
  end,
})

shopTab:CreateToggle({
  Name = "Auto Upgrade Weapon",
  CurrentValue = false,
  Flag = "ZA_UpgradeWp",
  Callback = function(value11)
    v20 = value11

    if not value11 or v21 then
      return
    end

    v21 = true

    task.spawn(function()
      while v20 do
        local v57 = f2("UpgradeRemotes", "PurchaseWeaponUpgrade")

        if v57 and f4() then
          pcall(function() v57:FireServer() end)
        end

        task.wait(1)
      end

      v21 = false
    end)
  end,
})

rollTab:CreateSection("Crates")

rollTab:CreateToggle({
  Name = "Roll Bloodmoon Crate",
  CurrentValue = false,
  Flag = "ZA_RollBloodmoon",
  Callback = function(value12)
    v22 = value12

    if not value12 or v23 then
      return
    end

    v23 = true

    task.spawn(function()
      while v22 do
        local v58 = f2("EventRemotes", "BloodmoonRequestSpin")

        if v58 then
          pcall(function() v58:InvokeServer() end)
        end

        task.wait(0.5)
      end

      v23 = false
    end)
  end,
})

miscTab:CreateSection("Performance")

local function f8(p8)
  return p8:IsA("ParticleEmitter") or p8:IsA("Trail") or p8:IsA("Smoke") or p8:IsA("Fire")
    or p8:IsA("Sparkles") or p8:IsA("Beam")
end

local connect

miscTab:CreateToggle({
  Name = "FPS Boost",
  CurrentValue = false,
  Flag = "ZA_FpsBoost",
  Callback = function(value13)
    local terrain

    if value13 then
      pcall(function()
        lighting.GlobalShadows = false
        lighting.FogEnd = 9000000000
        lighting.FogStart = 9000000000
        lighting.Brightness = 1.5
        lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        lighting.ClockTime = 14
      end)

      terrain = workspace:FindFirstChildOfClass("Terrain")

      if terrain then
        pcall(function()
          terrain.WaterWaveSize = 0
          terrain.WaterWaveSpeed = 0
          terrain.WaterReflectance = 0
          terrain.WaterTransparency = 1
        end)
      end

      task.spawn(function()
        for index4, value14 in ipairs(workspace:GetDescendants()) do
          local v59 = value14

          if v59:IsA("BasePart") then
            v59.CastShadow = false
          elseif f8(v59) then
            pcall(function() v59:Destroy() end)
          elseif v59:IsA("Decal") then
            v59.Transparency = 1
          end
        end

        for index5, value15 in ipairs(lighting:GetChildren()) do
          if value15:IsA("PostEffect") then
            value15.Enabled = false
          end
        end
      end)

      if connect then
        connect:Disconnect()
      end

      connect = workspace.DescendantAdded:Connect(function(descendant)
        if f8(descendant) then
          pcall(function() descendant:Destroy() end)
        elseif descendant:IsA("BasePart") then
          descendant.CastShadow = false
        end
      end)
    elseif connect then
      connect:Disconnect()
      connect = nil
    end
  end,
})

miscTab:CreateSection("Stats")

local label = miscTab:CreateLabel("FPS: -- | Ping: -- ms")

task.spawn(function()
  local v60 = 0
  local v61 = os.clock()
  local v62 = 0

  runService.RenderStepped:Connect(function()
    v60 = v60 + 1
    local v63 = os.clock()

    if v63 - v61 >= 1 then
      v62 = math.floor(v60 / (v63 - v61))
      v60 = 0
      v61 = v63
    end
  end)

  while true do
    local v64 = 0

    pcall(function()
      local dataPing = stats.Network.ServerStatsItem["Data Ping"]
      v64 = math.floor(dataPing:GetValue())
    end)

    pcall(function()
      label:Set("FPS: " .. v62 .. " | Ping: " .. v64 .. " ms | Remotes/s: " .. v30)
    end)

    task.wait(2)
  end
end)

rayVoid:Notify({ Title = "Survive Zombie Arena", Content = "Script charge.", Duration = 4 })
