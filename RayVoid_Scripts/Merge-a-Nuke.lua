local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "sStwCoOSQOtc" / (5143197 - "hwdsNlqd5" ^ 13426586) end) })[2]
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
          pcall(function() return "pIpIYzsuo7Yb1i" / (2857560 - "l11wfgYptzQS3f" ^ 1736758) end),
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
local localPlayer = players.LocalPlayer

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:ShowCredit()
rayVoid:SetScriptName("Merge a nuke")

local nukeMergerWindow = rayVoid:CreateWindow({
  Name = "Nuke Merger",
  LoadingTitle = "Nuke Merger",
  LoadingSubtitle = "by Akkiwi",
  ConfigurationSaving = { Enabled = false },
  KeySystem = false,
})

local nukeRemotes = replicatedStorage:WaitForChild("NukeRemotes")
local pickUp = nukeRemotes:WaitForChild("PickUp")
local drop = nukeRemotes:WaitForChild("Drop")
local reMergeMergeRequest = replicatedStorage:WaitForChild("Packages"):WaitForChild("Remotes"):WaitForChild("Networking"):WaitForChild("RE/Merge/MergeRequest")
local purchaseUpgrade = nukeRemotes:WaitForChild("PurchaseUpgrade")
local requestLockBase = nukeRemotes:WaitForChild("RequestLockBase")
local holdStarted = nukeRemotes:WaitForChild("HoldStarted")
local holdEnded = nukeRemotes:WaitForChild("HoldEnded")
local reLaunchLaunchConfirm = replicatedStorage:WaitForChild("Packages"):WaitForChild("Remotes"):WaitForChild("Networking"):WaitForChild("RE/Launch/LaunchConfirm")
local v12 = false
local v13

holdStarted.OnClientEvent:Connect(function(p1)
  v12 = true
  v13 = p1
end)

local function f1()
  local bases = workspace:FindFirstChild("Bases")

  if not bases then
    return nil
  end

  for index, value in ipairs(bases:GetChildren()) do
    local nukes = value:FindFirstChild("Nukes")

    if nukes then
      for index2, value2 in ipairs(nukes:GetChildren()) do
        if value2:GetAttribute("OwnerUserId") == localPlayer.UserId then
          local model = value:FindFirstChild("Model")

          if model then
            local v14, v15 = pcall(function() return model:GetPivot() end)

            if v14 then
              return v15.Position
            end
          end
        end
      end
    end
  end

  return nil
end

holdEnded.OnClientEvent:Connect(function()
  v12 = false
  v13 = nil
end)

local function f2()
  local bases2 = workspace:FindFirstChild("Bases")

  if not bases2 then
    return nil
  end

  for index3, value3 in ipairs(bases2:GetChildren()) do
    local nukes2 = value3:FindFirstChild("Nukes")

    if nukes2 then
      for index4, value4 in ipairs(nukes2:GetChildren()) do
        if value4:GetAttribute("OwnerUserId") == localPlayer.UserId then
          return nukes2
        end
      end
    end
  end

  return nil
end

local function f3()
  local character = localPlayer.Character
  return character and character:FindFirstChildOfClass("Humanoid")
end

local function f4()
  local character2 = localPlayer.Character
  return character2 and character2:FindFirstChild("HumanoidRootPart")
end

local function f5(p2)
  local v16, v17 = pcall(function() return p2:GetPivot() end)
  return v16 and v17.Position or nil
end

local function f6()
  local v18 = f4()

  if not v18 then
    return
  end

  drop:FireServer(v18.CFrame)
  task.wait(0.85)
end

local function f7(p3)
  local v19 = {}

  for index5, value5 in ipairs(p3:GetChildren()) do
    local state = value5:GetAttribute("State")

    if value5:IsA("Model") and (state == "floor" or state == "based") then
      table.insert(v19, value5)
    end
  end

  return v19
end

local automationTab = nukeMergerWindow:CreateTab("Automation", 4483362458)
automationTab:CreateSection("Auto Merge")

local v20 = false

local function f8()
  if v12 then
    f6()
  end

  while v20 do
    task.wait(0.15)
    local v21 = f4()
    local v22 = v21 and f2()

    if v21 and v22 then
      local v23 = {}

      for index6, value6 in ipairs((f7(v22))) do
        local tier = value6:GetAttribute("Tier")

        if tier then
          if not v23[tier] then
            v23[tier] = { count = 0, nukes = {} }
          end

          v23[tier].count = v23[tier].count + 1
          table.insert(v23[tier].nukes, value6)
        end
      end

      if v12 and v13 then
        if not v23[v13] then
          v23[v13] = { count = 0, nukes = {} }
        end

        v23[v13].count = v23[v13].count + 1
      end

      local v24 = nil

      for key, value7 in pairs(v23) do
        if value7.count >= 2 and (not v24 or key > v24) then
          v24 = key
        end
      end

      if v12 then
        if v24 and v13 == v24 then
          local v25 = v23[v24].nukes[1]

          local v26 = v25
          v26 = v25 and f5(v25)

          if v26 then
            local v27 = v21.Position.X - v26.X
            local v28 = v21.Position.Z - v26.Z

            if math.sqrt(v27 * v27 + v28 * v28) <= 6 then
              reMergeMergeRequest:FireServer(v25)
              task.wait(0.1)
            else
              v21.CFrame = CFrame.new(v26 + Vector3.new(0, 3, 0))
              task.wait(0.1)
            end
          end
        elseif v24 then
          f6()
        end
      elseif v24 then
        local v29 = v23[v24].nukes[1]
        local v30 = f5(v29)

        if v30 then
          if (v21.Position - v30).Magnitude <= 6 then
            pickUp:FireServer(v29)
            task.wait(0.3)
          else
            v21.CFrame = CFrame.new(v30 + Vector3.new(0, 3, 0))
            task.wait(0.1)
          end
        end
      end
    end
  end
end

local v31

automationTab:CreateToggle({
  Name = "Auto Merge",
  CurrentValue = false,
  Flag = "AutoMerge",
  Callback = function(value8)
    v20 = value8

    if value8 then
      v31 = task.spawn(f8)

      rayVoid:Notify({
        Title = "Auto Merge",
        Content = "Enabled",
        Duration = 2,
        Image = 4483362458,
      })
    else
      v20 = false

      if v31 then
        task.cancel(v31)
        v31 = nil
      end

      if v12 then
        f6()
      end

      rayVoid:Notify({
        Title = "Auto Merge",
        Content = "Disabled",
        Duration = 2,
        Image = 4483362458,
      })
    end
  end,
})

automationTab:CreateSlider({
  Name = "Walk Speed",
  Range = { 16, 100 },
  Increment = 1,
  Suffix = "studs/s",
  CurrentValue = 16,
  Flag = "WalkSpeed",
  Callback = function(value9)
    local v32 = f3()

    if v32 then
      v32.WalkSpeed = value9
    end
  end,
})

automationTab:CreateSection("Auto Launch")

local function f9()
  local v33 = {}
  local bases3 = workspace:FindFirstChild("Bases")

  if not bases3 then
    return v33
  end

  for index7, value10 in ipairs(bases3:GetChildren()) do
    local nukes3 = value10:FindFirstChild("Nukes")

    if nukes3 then
      local v34 = false

      for index8, value11 in ipairs(nukes3:GetChildren()) do
        if value11:GetAttribute("OwnerUserId") then
          v34 = true
          break
        end
      end

      if v34 then
        local v35 = false

        for index9, value12 in ipairs(nukes3:GetChildren()) do
          if value12:GetAttribute("OwnerUserId") == localPlayer.UserId then
            v35 = true
            break
          end
        end

        if not v35 then
          local locked = value10:FindFirstChild("Locked")

          if not locked or locked.Transparency == 1 then
            local model2 = value10:FindFirstChild("Model")

            if model2 then
              local v36, v37 = pcall(function() return model2:GetPivot() end)

              if v36 then
                table.insert(v33, v37.Position)
              end
            end
          end
        end
      end
    end
  end

  return v33
end

local v38 = false

local function f10()
  local v39 = f2()

  if not v39 then
    return nil, nil
  else
    local v40 = os.time()
    local v41 = {}

    for index10, value13 in ipairs(v39:GetChildren()) do
      local state2 = value13:GetAttribute("State")

      if value13:IsA("Model") and (state2 == "floor" or state2 == "based") then
        if v40 >= (value13:GetAttribute("CdUntil") or 0) then
          local tier2 = value13:GetAttribute("Tier")

          if tier2 then
            table.insert(v41, { nuke = value13, tier = tier2 })
          end
        end
      end
    end

    if #v41 == 0 then
      return nil, nil
    end

    table.sort(v41, function(p4, p5) return p4.tier > p5.tier end)
    return v41[1] and v41[1].nuke or nil, v41[2] and v41[2].nuke or nil
  end
end

local f11

local function f12()
  while v38 do
    task.wait(0.15)
    f11()
    local v42 = f9()

    if #v42 > 0 then
      local v43 = v42[1]
      local v44, v45 = f10()

      if v44 then
        if f4() then
          f11()
          local v46 = f4()

          if v46 then
            local v47 = f5(v44)

            if v47 then
              v46.CFrame = CFrame.new(v47 + Vector3.new(0, 3, 0))
            end

            task.wait(0.1)

            if not v12 then
              pickUp:FireServer(v44)
              task.wait(0.4)
            end

            reLaunchLaunchConfirm:FireServer(v43)
            task.wait(0.2)
            local v48 = f4()

            if v48 then
              drop:FireServer(v48.CFrame)
            end

            task.wait(5)
          end

          if v38 and v45 and v45.Parent then
            if f4() then
              f11()
              local v49 = f4()

              if v49 then
                local v50 = f5(v45)

                if v50 then
                  v49.CFrame = CFrame.new(v50 + Vector3.new(0, 3, 0))
                end

                task.wait(0.1)

                if not v12 then
                  pickUp:FireServer(v45)
                  task.wait(0.4)
                end

                reLaunchLaunchConfirm:FireServer(v43)
                task.wait(0.2)
                local v51 = f4()

                if v51 then
                  drop:FireServer(v51.CFrame)
                end

                task.wait(5)
              end
            end
          end
        end
      else
        task.wait(0.5)
      end
    else
      task.wait(1)
    end
  end
end

function f11()
  if v12 then
    local v52 = f4()

    if v52 then
      drop:FireServer(v52.CFrame)
    end

    task.wait(0.1)

    if v12 then
      local v53 = f4()

      if v53 then
        drop:FireServer(v53.CFrame)
      end
    end

    task.wait(0.1)
  end
end

local v54

automationTab:CreateToggle({
  Name = "Auto Launch",
  CurrentValue = false,
  Flag = "AutoLaunch",
  Callback = function(value14)
    v38 = value14

    if value14 then
      v54 = task.spawn(f12)

      rayVoid:Notify({
        Title = "Auto Launch",
        Content = "Enabled",
        Duration = 2,
        Image = 4483362458,
      })
    else
      v38 = false

      if v54 then
        task.cancel(v54)
        v54 = nil
      end

      rayVoid:Notify({
        Title = "Auto Launch",
        Content = "Disabled",
        Duration = 2,
        Image = 4483362458,
      })
    end
  end,
})

automationTab:CreateSection("Auto Lock")

local v55 = 50

local function f13(p6, p7, p8)
  local v56 = p7.X - p6.X
  local v57 = p7.Z - p6.Z
  local v58 = math.sqrt(v56 * v56 + v57 * v57)

  if v58 < 0.001 then
    return false
  else
    local v59 = v56 / v58
    local v60 = v57 / v58
    local v61 = p8.X - p6.X
    local v62 = p8.Z - p6.Z
    local v63 = v61 * v59 + v62 * v60
    return math.abs(v61 * v60 - v62 * v59) <= v55 and v63 > 0
  end
end

local v64 = 71.5
local v65 = 73.25

local function f14(p9)
  return math.abs(p9.X - 412.5) <= v64 and math.abs(p9.Z - 135) <= v65
end

local v66 = false
local f15

local function f16(p10)
  task.wait(0.1)

  if not p10.Parent then
    return
  elseif p10:GetAttribute("LauncherUserId") == localPlayer.UserId then
    return
  else
    local v67 = nil

    while p10.Parent and v66 do
      task.wait(0.2)

      if p10.Parent then
        local v68 = f5(p10)

        if v68 then
          if f14(v68) then
            v67 = nil
          elseif not v67 then
            v67 = v68
          else
            local v69 = f1()

            if v69 then
              if f13(v67, v68, v69) then
                if f15() then
                  requestLockBase:FireServer()

                  rayVoid:Notify({
                    Title = "Auto Lock",
                    Content = "Incoming nuke detected — Base locked!",
                    Duration = 4,
                    Image = 4483362458,
                  })
                else
                  rayVoid:Notify({
                    Title = "Auto Lock",
                    Content = "Incoming nuke — Lock on cooldown!",
                    Duration = 4,
                    Image = 4483362458,
                  })
                end
              end
            end

            break
          end
        end
      end
    end

    return
  end
end

function f15()
  local v70, v71 = pcall(function()
    return localPlayer.PlayerGui.ScreenGui.Top.LockBase.TextLabel
  end)

  if not v70 or not v71 then
    return false
  end

  return v71.Text == "Lock Base"
end

local connect

automationTab:CreateToggle({
  Name = "Auto Lock on Attack (Maybe not working)",
  CurrentValue = false,
  Flag = "AutoLock",
  Callback = function(value15)
    v66 = value15

    if value15 then
      connect = workspace.ChildAdded:Connect(function(child)
        if child.Name:match("^LaunchedNuke") then
          task.spawn(f16, child)
        end
      end)

      for index11, value16 in ipairs(workspace:GetChildren()) do
        if value16.Name:match("^LaunchedNuke") then
          task.spawn(f16, value16)
        end
      end

      rayVoid:Notify({
        Title = "Auto Lock",
        Content = "Enabled",
        Duration = 2,
        Image = 4483362458,
      })
    else
      v66 = false

      if connect then
        connect:Disconnect()
        connect = nil
      end

      rayVoid:Notify({
        Title = "Auto Lock",
        Content = "Disabled",
        Duration = 2,
        Image = 4483362458,
      })
    end
  end,
})

local autoUpgradeTab = nukeMergerWindow:CreateTab("Auto Upgrade", 4483362458)
autoUpgradeTab:CreateSection("Upgrades")

local f17

local function f18(p11)
  local v72, v73 = pcall(function()
    return localPlayer.PlayerGui.ScreenGui.Frames.UpgradesFrame.Content.Container[p11].BuyOptions.Upgrade.Price
  end)

  if not v72 or not v73 then
    return math.huge
  end

  return f17(v73.Text)
end

function f17(p12)
  if not p12 then
    return 0
  else
    local v74, v75 = p12:match("([%d%.]+)%s*([A-Za-z]*)")

    if not v74 then
      return 0
    else
      local v76 = tonumber(v74)
      local upper = v75:upper()

      return (v76 or 0) * (({
        K = 1000,
        M = 1000000,
        B = 1000000000,
        T = 1000000000000,
        QA = 1000000000000000,
        QI = 1000000000000000000,
        SX = 1e+21,
        SP = 1e+24,
      })[upper] or 1)
    end
  end
end

local function f19()
  local v77, v78 = pcall(function()
    return localPlayer.PlayerGui:WaitForChild("CashVFX"):WaitForChild("BottomLeft"):WaitForChild("Cash"):WaitForChild("CashText")
  end)

  if not v77 or not v78 then
    return 0
  end

  return f17((v78.Text:gsub("Cash: ", "")))
end

local v79 = {}

for index12, value17 in ipairs({
  { name = "Auto Upgrade Tier", remote = "TIER", key = "Tier" },
  { name = "Auto Upgrade Max", remote = "MAX", key = "Max" },
  { name = "Auto Upgrade LockBase", remote = "LOCKBASE", key = "LockBase" },
}) do
  local v80 = value17
  local remote = v80.remote

  autoUpgradeTab:CreateToggle({
    Name = v80.name,
    CurrentValue = false,
    Flag = remote,
    Callback = function(value18)
      if value18 then
        v79[remote] = true

        task.spawn(function()
          while v79[remote] do
            task.wait(1)

            if f19() >= f18(v80.key) then
              purchaseUpgrade:FireServer(v80.remote)
            end
          end
        end)

        rayVoid:Notify({
          Title = v80.name,
          Content = "Enabled",
          Duration = 2,
          Image = 4483362458,
        })
      else
        v79[remote] = nil

        rayVoid:Notify({
          Title = v80.name,
          Content = "Disabled",
          Duration = 2,
          Image = 4483362458,
        })
      end
    end,
  })
end
