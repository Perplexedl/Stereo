local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local collectionService = game:GetService("CollectionService")
local localPlayer = players.LocalPlayer
local knit

pcall(function()
  knit = replicatedStorage:FindFirstChild("Packages")
      and replicatedStorage.Packages:FindFirstChild("knit")
      and require(replicatedStorage.Packages.knit)
    or replicatedStorage:FindFirstChild("Folder")
      and replicatedStorage.Folder:FindFirstChild("knit")
      and require(replicatedStorage.Folder.knit)
end)

local v5 = {
  IsAutoClickRunning = false,
  IsAutoPickupLootRunning = false,
  IsAutoRebirthRunning = false,
  IsSellingLoot = false,
  IsAutoUpgradeRunning = false,
  IsAutoBuyAuraRunning = false,
  IsAutoBuyCutterRunning = false,
  IsAutoClaimSunQuestsRunning = false,
  IsAutoRollSunGachaRunning = false,
  IsAutoBuySunRewardsRunning = false,
  IsAutoTpBestWorldRunning = false,
  IsAutoCollectMuseumCashRunning = false,
  IsAutoBuyMuseumFloorsRunning = false,
  IsPlacingBestLoot = false,
}

local v6 = {
  Shop = nil,
  Auras = nil,
  Upgrades = nil,
  UpgradeNames = nil,
  Worlds = nil,
  WorldNames = nil,
  WorldMap = nil,
  SunRewards = nil,
  SunRewardNames = nil,
  SunRewardMap = nil,
  Museum = nil,
}

local v7 = {}
local v8 = {}

local function f1()
  if v6.Upgrades and #v6.Upgrades > 0 then
    return v6.Upgrades, v6.UpgradeNames
  end

  local v9, v10 = pcall(function()
    local configs = replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Configs")

    if configs and configs:FindFirstChild("Shop") then
      return require(configs.Shop)
    end

    local folder = replicatedStorage:FindFirstChild("Folder")
      and replicatedStorage.Folder:FindFirstChild("Folder")

    if folder and folder:FindFirstChild("Shop") then
      return require(folder.Shop)
    end

    return nil
  end)

  if v9 and type(v10) == "table" then
    v6.Shop = v10
  end

  local v11 = {
    { Key = "WalkspeedUpgrades", Name = "Walk Speed", Remote = "SpeedButtonClicked" },
    { Key = "BackpackUpgrades", Name = "Carry", Remote = "CarryButtonClicked" },
    { Key = "AttackSpeedUpgrades", Name = "Attack Speed", Remote = "AttackSpeedButtonClicked" },
    { Key = "AttackRangeUpgrades", Name = "Attack Range", Remote = "AttackRangeButtonClicked" },
    { Key = "CraftChanceUpgrades", Name = "Craft Chance", Remote = "CraftChanceButtonClicked" },
    {
      Key = "LootPickupRadiusUpgrades",
      Name = "Loot Pickup Radius",
      Remote = "LootPickupRadiusButtonClicked",
    },
  }

  local products = v6.Shop and v6.Shop.Products or nil
  local v12 = {}
  local v13 = {}

  for index, value in ipairs(v11) do
    if products == nil or typeof(products) == "table" and products[value.Key] ~= nil then
      table.insert(v12, value)
      table.insert(v13, value.Name)
    end
  end

  v6.Upgrades = v12
  v6.UpgradeNames = v13

  return v12, v13
end

local function f2()
  if v6.Auras then
    return v6.Auras
  end

  pcall(function()
    local configs2 = replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Configs")

    if configs2 and configs2:FindFirstChild("Auras") then
      v6.Auras = require(configs2.Auras)
      return
    end

    local folder2 = replicatedStorage:FindFirstChild("Folder")
      and replicatedStorage.Folder:FindFirstChild("Folder")

    if folder2 and folder2:FindFirstChild("Auras") then
      v6.Auras = require(folder2.Auras)
    end
  end)

  return v6.Auras
end

local function f3()
  local auras = v6.Auras or f2()

  if auras and type(auras.Order) == "table" then
    return auras.Order
  end

  return {
    "InfernoAura", "TempestAura", "BlueAura", "GreenAura", "RedAura", "PurpleAura",
    "MythicAura", "GodlyAura", "DivineAura", "CelestialAura", "EternalAura", "TranscendentAura",
    "AscendantAura", "PrimordialAura", "ExaltedAura", "GenesisAura",
  }
end

local function f4()
  if v6.Worlds and v6.WorldNames and #v6.WorldNames > 0 then
    return v6.Worlds, v6.WorldNames, v6.WorldMap
  end

  pcall(function()
    local configs3 = replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Configs")

    if configs3 and configs3:FindFirstChild("Worlds") then
      v6.Worlds = require(configs3.Worlds)
      return
    end

    local folder3 = replicatedStorage:FindFirstChild("Folder")
      and replicatedStorage.Folder:FindFirstChild("Folder")

    if folder3 and folder3:FindFirstChild("Worlds") then
      v6.Worlds = require(folder3.Worlds)
    end
  end)

  local v14 = {}
  local v15 = {}
  local worlds = v6.Worlds

  if worlds and type(worlds.Order) == "table" and type(worlds.Worlds) == "table" then
    for index2, value2 in ipairs(worlds.Order) do
      local v16 = worlds.Worlds[value2]
      local displayName = v16 and v16.DisplayName or "World " .. tostring(value2)
      table.insert(v14, displayName)
      v15[displayName] = value2
    end
  end

  if #v14 == 0 then
    for i = 1, 5 do
      local v17 = "World " .. tostring(i)
      table.insert(v14, v17)
      v15[v17] = i
    end
  end

  v6.WorldNames = v14
  v6.WorldMap = v15

  return v6.Worlds, v14, v15
end

local function f5()
  if v6.SunRewards and #v6.SunRewards > 0 then
    return v6.SunRewards, v6.SunRewardNames, v6.SunRewardMap
  end

  local v18, v19 = pcall(function()
    local configs4 = replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Configs")

    if configs4 and configs4:FindFirstChild("QuestRewards") then
      return require(configs4.QuestRewards)
    end

    local folder4 = replicatedStorage:FindFirstChild("Folder")
      and replicatedStorage.Folder:FindFirstChild("Folder")

    if folder4 and folder4:FindFirstChild("QuestRewards") then
      return require(folder4.QuestRewards)
    end

    return nil
  end)

  local v20 = {}
  local v21 = {}
  local v22 = {}

  if v18 and type(v19) == "table" and type(v19.Definitions) == "table" then
    for index3, value3 in ipairs(v19.SunOrder or {
      "Sunspire", "Dawnheart", "RebirthSkip", "SunStrengthPotion", "SunMoneyPotion",
      "SunGuaranteedCraft", "SunOPPotion",
    }) do
      local v23 = v19.Definitions[value3]

      if v23 then
        local displayName2 = v23.DisplayName or value3

        table.insert(v20, {
          Id = value3,
          DisplayName = displayName2,
          Price = v23.Price or 0,
          Limit = v23.PurchaseLimit or 1,
        })

        table.insert(v21, displayName2)

        v22[displayName2] = value3
      end
    end
  end

  if #v20 == 0 then
    for index4, value4 in ipairs({
      {
        Id = "Sunspire",
        DisplayName = "Sunspire",
        Price = 5000,
        Limit = 1,
      },
      {
        Id = "Dawnheart",
        DisplayName = "Dawnheart",
        Price = 1800,
        Limit = 1,
      },
      {
        Id = "RebirthSkip",
        DisplayName = "Skip Rebirth",
        Price = 1000,
        Limit = 3,
      },
      {
        Id = "SunStrengthPotion",
        DisplayName = "Strength Potion",
        Price = 30,
        Limit = 40,
      },
      {
        Id = "SunMoneyPotion",
        DisplayName = "Money Potion",
        Price = 30,
        Limit = 40,
      },
      {
        Id = "SunGuaranteedCraft",
        DisplayName = "100% Craft Chance",
        Price = 500,
        Limit = 5,
      },
      {
        Id = "SunOPPotion",
        DisplayName = "OP Potion",
        Price = 80,
        Limit = 20,
      },
    }) do
      table.insert(v20, value4)
      table.insert(v21, value4.DisplayName)
      v22[value4.DisplayName] = value4.Id
    end
  end

  v6.SunRewards = v20
  v6.SunRewardNames = v21
  v6.SunRewardMap = v22

  return v20, v21, v22
end

local function f6()
  if v6.Museum then
    return v6.Museum
  end

  local v24, v25 = pcall(function()
    local configs5 = replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Configs")

    if configs5 and configs5:FindFirstChild("Museum") then
      return require(configs5.Museum)
    end

    local folder5 = replicatedStorage:FindFirstChild("Folder")
      and replicatedStorage.Folder:FindFirstChild("Folder")

    if folder5 and folder5:FindFirstChild("Museum") then
      return require(folder5.Museum)
    end

    return nil
  end)

  if v24 and type(v25) == "table" then
    v6.Museum = v25
    return v25
  end

  local v26 = {
    RequiredLevel = 100,
    FloorUpgradePrices = { [2] = 15000000000000000000, [3] = 2.5e+27 },
    MuseumSizeMultipliers = {
      Normal = 1,
      Big = 3,
      Huge = 9,
      Giant = 27,
    },
  }

  v6.Museum = v26
  return v26
end

f1()
f2()
f4()
f5()
f6()

local function f7(p1, p2)
  local v27 = p1 .. "_" .. p2

  if v8[v27] then
    return v8[v27]
  end

  for index5, value5 in ipairs(replicatedStorage:GetDescendants()) do
    if (value5:IsA("RemoteEvent") or value5:IsA("RemoteFunction")) and value5.Name == p2 then
      local parent = value5.Parent

      if parent and (parent.Name == p1 or parent.Parent and parent.Parent.Name == p1) then
        v8[v27] = value5
        return value5
      end
    end
  end

  for index6, value6 in ipairs(replicatedStorage:GetDescendants()) do
    if (value6:IsA("RemoteEvent") or value6:IsA("RemoteFunction")) and value6.Name == p2 then
      v8[v27] = value6
      return value6
    end
  end

  if knit then
    local v28, v29 = pcall(function() return knit.GetService(p1) end)

    if v28 and v29 and v29[p2] then
      v8[v27] = v29[p2]
      return v29[p2]
    end
  end

  return nil
end

local function f8(p3, p4, ...)
  local v30 = f7(p3, p4)

  if not v30 then
    return
  end

  if typeof(v30) == "Instance" then
    if v30:IsA("RemoteEvent") then
      pcall(function(...) v30:FireServer(...) end, ...)
      return
    elseif v30:IsA("RemoteFunction") then
      pcall(function(...) v30:InvokeServer(...) end, ...)
      return
    end
  end

  pcall(function(...)
    if typeof(v30) == "table" and typeof(v30.Fire) == "function" then
      v30:Fire(...)
    elseif typeof(v30) == "function" then
      v30(...)
    end
  end, ...)
end

local function f9(p5, p6, ...)
  local v31 = f7(p5, p6)

  if typeof(v31) == "Instance" and v31:IsA("RemoteFunction") then
    local v32, v33 = pcall(function(...) return v31:InvokeServer(...) end, ...)

    if v32 then
      return v33
    end
  end

  if typeof(v31) == "function" then
    local v34, v35 = pcall(function(...) return v31(...) end, ...)

    if v34 then
      if typeof(v35) == "table" and typeof(v35.expect) == "function" then
        local v36, v37 = pcall(function() return v35:expect() end)

        if v36 then
          return v37
        end
      end

      return v35
    end
  elseif typeof(v31) == "table" then
    if typeof(v31.Call) == "function" then
      local v38, v39 = pcall(function(...) return v31:Call(...) end, ...)

      if v38 then
        return v39
      end
    elseif typeof(v31.Invoke) == "function" then
      local v40, v41 = pcall(function(...) return v31:Invoke(...) end, ...)

      if v40 then
        return v41
      end
    end
  end

  if knit then
    local v42, v43 = pcall(function() return knit.GetService(p5) end)

    if v42 and v43 and typeof(v43[p6]) == "function" then
      local v44, v45 = pcall(function(...) return v43[p6](v43, ...) end, ...)

      if v44 then
        if typeof(v45) == "table" and typeof(v45.expect) == "function" then
          local v46, v47 = pcall(function() return v45:expect() end)

          if v46 then
            return v47
          end
        end

        return v45
      end
    end
  end

  return nil
end

local function f10()
  local v48 = f9("DataService", "GetData", "Money")

  if typeof(v48) == "number" then
    return v48
  end

  local leaderstats = localPlayer:FindFirstChild("leaderstats")

  local money = leaderstats
    and (leaderstats:FindFirstChild("Money") or leaderstats:FindFirstChild("Coins")
      or leaderstats:FindFirstChild("Cash"))

  if money and typeof(money.Value) == "number" then
    return money.Value
  end

  return 0
end

local function f11(p7, p8)
  if type(p7) ~= "table" then
    return false
  end

  if p7[p8] == true then
    return true
  end

  for key, value7 in pairs(p7) do
    if value7 == p8 or key == p8 then
      return true
    end
  end

  return false
end

local function f12(p9)
  if type(p9) ~= "table" then
    return false
  end

  for key2, value8 in pairs(p9) do
    if value8 == true or type(value8) == "string" then
      return true
    end
  end

  return false
end

local function f13()
  if v5.IsAutoClickRunning
    or not (v1.Options.Toggle_Farm_AutoClick and v1.Options.Toggle_Farm_AutoClick.Value) then
    return
  end

  v5.IsAutoClickRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoClick
      and v1.Options.Toggle_Farm_AutoClick.Value do
      f8("StrengthService", "ClickRequested")
      task.wait(0.04)
    end

    v5.IsAutoClickRunning = false
  end)
end

local function f14()
  local v49 = f9("RebirtService", "GetState")

  if type(v49) == "table" and v49.CanRebirth == true then
    return true
  end

  return false
end

local v50 = game:GetService("Workspace")

local function f15(p10)
  if not p10 then
    return nil
  end

  local findFirstChildWhichIsA = p10:FindFirstChildWhichIsA("ProximityPrompt", true)

  if findFirstChildWhichIsA and findFirstChildWhichIsA.Parent then
    local parent2 = findFirstChildWhichIsA.Parent

    if parent2:IsA("Attachment") then
      return CFrame.new(parent2.WorldPosition)
    elseif parent2:IsA("BasePart") then
      return parent2.CFrame
    end
  end

  if p10:IsA("BasePart") then
    return p10.CFrame
  elseif p10:IsA("Model") then
    if p10.PrimaryPart then
      return p10.PrimaryPart.CFrame
    end

    local findFirstChildWhichIsA2 = p10:FindFirstChildWhichIsA("BasePart", true)

    if findFirstChildWhichIsA2 then
      return findFirstChildWhichIsA2.CFrame
    end
  end

  return nil
end

local function f16(p11)
  if not p11 then
    return nil
  end

  local autoPickupHover = p11:FindFirstChild("AutoPickupHover")

  if not autoPickupHover then
    autoPickupHover = Instance.new("BodyVelocity")
    autoPickupHover.Name = "AutoPickupHover"
    autoPickupHover.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
    autoPickupHover.Velocity = Vector3.zero
    autoPickupHover.Parent = p11
  end

  return autoPickupHover
end

local function f17()
  local character = localPlayer.Character
  local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart then
    local autoPickupHover2 = humanoidRootPart:FindFirstChild("AutoPickupHover")

    if autoPickupHover2 then
      autoPickupHover2:Destroy()
    end
  end
end

local function f18()
  return tonumber((localPlayer:GetAttribute("CurrentWorld"))) or 1
end

local function f19()
  local zones = v50:FindFirstChild("Zones")

  if zones then
    return zones:FindFirstChild("W" .. tostring(f18()))
  end

  return nil
end

local function f20(p12)
  v5.IsSellingLoot = true
  f9("BaseTeleportService", "TeleportToSpawn")
  task.wait(0.25)
  f9("LootInventoryService", "ResetBackpackLoadAtBase")
  task.wait(0.15)

  if v1.Options.Toggle_Farm_AutoSellLoot and v1.Options.Toggle_Farm_AutoSellLoot.Value then
    f9("DataService", "SellAllBackpackLoot")
    task.wait(0.15)
  end

  if p12 then
    local character2 = localPlayer.Character
    local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart2 and humanoidRootPart2.Parent then
      humanoidRootPart2.CFrame = p12
      pcall(function() humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero end)
    end
  end

  v5.IsSellingLoot = false
end

local function f21(p13)
  if not p13 or not p13.Parent then
    return false
  end

  local findFirstChildWhichIsA3 = p13:FindFirstChildWhichIsA("ProximityPrompt", true)

  if not findFirstChildWhichIsA3 or not findFirstChildWhichIsA3.Enabled then
    return false
  end

  local v51 = f19()

  if v51 and not p13:IsDescendantOf(v51) then
    return false
  end

  local v52 = f15(p13)
  local character3 = localPlayer.Character
  local humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart3 or not v52 then
    return false
  end

  f16(humanoidRootPart3)
  local v53 = v52.Position.Y + 2.8
  local cframe = CFrame.new(v52.Position.X, v53, v52.Position.Z)

  if (humanoidRootPart3.Position - cframe.Position).Magnitude > 45 then
    f9("BaseTeleportService", "TeleportToSpawn")
    task.wait(0.15)
    humanoidRootPart3.CFrame = cframe
  else
    humanoidRootPart3.CFrame = cframe
  end

  pcall(function() humanoidRootPart3.AssemblyLinearVelocity = Vector3.zero end)
  task.wait(0.1)

  local v54 = (findFirstChildWhichIsA3.HoldDuration and findFirstChildWhichIsA3.HoldDuration > 0
        and findFirstChildWhichIsA3.HoldDuration
      or 0.5)
    + 0.3

  pcall(function()
    findFirstChildWhichIsA3:InputHoldBegin()
    task.wait(v54)
    findFirstChildWhichIsA3:InputHoldEnd()
  end)

  if typeof(fireproximityprompt) == "function" and p13.Parent ~= nil then
    pcall(function() fireproximityprompt(findFirstChildWhichIsA3) end)
  end

  task.wait(0.4)
  return p13.Parent == nil
end

local function f22(p14)
  if not p14 then
    return 0
  end

  return tonumber((p14:match("Zone_(%d+)"))) or 0
end

local function f23(p15)
  local parent3 = p15

  while parent3 and parent3 ~= v50 do
    local v55 = f22(parent3.Name)

    if v55 > 0 then
      return v55
    end

    parent3 = parent3.Parent
  end

  return 0
end

local function f24()
  local v56 = {}
  local zones2 = f19() or v50:FindFirstChild("Zones")

  if zones2 then
    for index7, value9 in ipairs(zones2:GetChildren()) do
      local v57 = f22(value9.Name)

      if v57 > 0 then
        table.insert(v56, { Instance = value9, Index = v57 })
      else
        for index8, value10 in ipairs(value9:GetChildren()) do
          local v58 = f22(value10.Name)

          if v58 > 0 then
            table.insert(v56, { Instance = value10, Index = v58 })
          end
        end
      end
    end
  end

  table.sort(v56, function(p16, p17) return p16.Index > p17.Index end)
  return v56
end

local function f25()
  local v59, v60 = pcall(function()
    local value11 = localPlayer:FindFirstChild("PlayerGui")
      and localPlayer.PlayerGui:FindFirstChild("MainScreenGui")
      and localPlayer.PlayerGui.MainScreenGui:FindFirstChild("Currencies")
      and localPlayer.PlayerGui.MainScreenGui.Currencies:FindFirstChild("Backpack")
      and localPlayer.PlayerGui.MainScreenGui.Currencies.Backpack:FindFirstChild("Value")

    if value11 and value11:IsA("TextLabel") then
      local v61, v62 = value11.Text:match("(%d+)%s*/%s*(%d+)")

      if v61 and v62 then
        return tonumber(v61) >= tonumber(v62)
      end
    end

    return false
  end)

  return v59 and v60 == true
end

local function f26()
  return not v1.Unloaded and v1.Options.Toggle_Farm_AutoPickupLoot
    and v1.Options.Toggle_Farm_AutoPickupLoot.Value == true
end

local function f27()
  if v5.IsAutoPickupLootRunning or not f26() then
    return
  end

  v5.IsAutoPickupLootRunning = true

  task.spawn(function()
    local v63 = {}

    local connect

    connect = runService.Stepped:Connect(function()
      if not f26() then
        if connect then
          connect:Disconnect()
          connect = nil
        end

        return
      end

      local character4 = localPlayer.Character

      if character4 then
        for index9, value12 in ipairs(character4:GetDescendants()) do
          if value12:IsA("BasePart") then
            value12.CanCollide = false
          end
        end
      end
    end)

    while f26() do
      if f25() then
        local character5 = localPlayer.Character
        local humanoidRootPart4 = character5 and character5:FindFirstChild("HumanoidRootPart")
        f20(humanoidRootPart4 and humanoidRootPart4.CFrame)
        task.wait(0.5)
      elseif v5.IsSellingLoot then
        task.wait(0.3)
      else
        pcall(function()
          local v64 = {}
          local spawnedLoot = collectionService:GetTagged("SpawnedLoot")
          local character6 = localPlayer.Character
          local humanoidRootPart5 = character6 and character6:FindFirstChild("HumanoidRootPart")
          local position = humanoidRootPart5 and humanoidRootPart5.Position or Vector3.zero
          local v65 = f19()

          if spawnedLoot and #spawnedLoot > 0 then
            for index10, value13 in ipairs(spawnedLoot) do
              local v66 = false

              repeat
                if value13 and value13.Parent then
                  if v65 and not value13:IsDescendantOf(v65) then
                    v66 = true
                    break
                  end

                  local findFirstChildWhichIsA4 = value13:FindFirstChildWhichIsA(
                    "ProximityPrompt", true
                  )

                  local findFirstChildWhichIsA5 = value13:FindFirstChildWhichIsA(
                    "BasePart", true
                  )

                  if findFirstChildWhichIsA4 and findFirstChildWhichIsA4.Enabled
                    and findFirstChildWhichIsA5 then
                    local v67 = f23(value13)
                    local v68 = v63[v67]

                    if not v68 or os.clock() > v68 then
                      local magnitude = (findFirstChildWhichIsA5.Position - position).Magnitude
                      local price = tonumber(value13:GetAttribute("LootSellPrice")) or 0

                      table.insert(v64, {
                        Item = value13,
                        ZoneIndex = v67,
                        Distance = magnitude,
                        Price = price,
                      })
                    end
                  end
                end

                v66 = true
              until true

              if not v66 then
                break
              end
            end
          end

          if #v64 == 0 then
            for index11, value14 in ipairs((f24())) do
              local v69 = v63[value14.Index]

              if not v69 or os.clock() > v69 then
                local spawnZone = value14.Instance:FindFirstChild("SpawnZone")

                if spawnZone then
                  for index12, value15 in ipairs(spawnZone:GetChildren()) do
                    local findFirstChildWhichIsA6 = value15:FindFirstChildWhichIsA(
                      "ProximityPrompt", true
                    )

                    local findFirstChildWhichIsA7 = value15:FindFirstChildWhichIsA(
                      "BasePart", true
                    )

                    if findFirstChildWhichIsA6 and findFirstChildWhichIsA6.Enabled
                      and findFirstChildWhichIsA7 then
                      local magnitude2 = (findFirstChildWhichIsA7.Position - position).Magnitude
                      local price2 = tonumber(value15:GetAttribute("LootSellPrice")) or 0

                      table.insert(v64, {
                        Item = value15,
                        ZoneIndex = value14.Index,
                        Distance = magnitude2,
                        Price = price2,
                      })
                    end
                  end

                  if #v64 > 0 then
                    break
                  end
                end
              end
            end
          end

          local v70 = nil
          local v71 = {}

          for index13, value16 in ipairs(v64) do
            if value16.Distance <= 45 then
              table.insert(v71, value16)
            end
          end

          if #v71 > 0 then
            table.sort(v71, function(p18, p19)
              if p18.Price ~= p19.Price then
                return p18.Price > p19.Price
              end

              return p18.Distance < p19.Distance
            end)

            v70 = v71[1]
          else
            table.sort(v64, function(p20, p21)
              if p20.Price ~= p21.Price then
                return p20.Price > p21.Price
              end

              return p20.Distance < p21.Distance
            end)

            v70 = v64[1]
          end

          if v70 and v70.Item and v70.Item.Parent then
            if not f21(v70.Item) and v70.ZoneIndex > 0 then
              v63[v70.ZoneIndex] = os.clock() + 25
            end
          end
        end)

        task.wait(0.1)
      end
    end

    if connect then
      connect:Disconnect()
      connect = nil
    end

    f17()
    v5.IsAutoPickupLootRunning = false
  end)
end

local function f28()
  if v5.IsAutoRebirthRunning
    or not (v1.Options.Toggle_Farm_AutoRebirth and v1.Options.Toggle_Farm_AutoRebirth.Value) then
    return
  end

  v5.IsAutoRebirthRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoRebirth
      and v1.Options.Toggle_Farm_AutoRebirth.Value do
      if f14() then
        f8("RebirtService", "RebirthButtonClicked")
        task.wait(2)
      end

      task.wait(2)
    end

    v5.IsAutoRebirthRunning = false
  end)
end

local function f29()
  if v5.IsAutoUpgradeRunning
    or not (v1.Options.Toggle_Shop_AutoUpgradeStats and v1.Options.Toggle_Shop_AutoUpgradeStats.Value) then
    return
  end

  v5.IsAutoUpgradeRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoUpgradeStats
      and v1.Options.Toggle_Shop_AutoUpgradeStats.Value do
      pcall(function()
        local value17 = v1.Options.Dropdown_Shop_SelectUpgrades
            and v1.Options.Dropdown_Shop_SelectUpgrades.Value
          or {}

        local v72 = f12(value17)

        for index14, value18 in ipairs(v6.Upgrades or f1()) do
          if not (v1.Options.Toggle_Shop_AutoUpgradeStats
            and v1.Options.Toggle_Shop_AutoUpgradeStats.Value) then
            break
          end

          if not v72 or f11(value17, value18.Name) then
            f8("UpgradesService", value18.Remote)
            task.wait(0.2)
          end
        end
      end)

      task.wait(5)
    end

    v5.IsAutoUpgradeRunning = false
  end)
end

local function f30()
  if v5.IsAutoBuyAuraRunning
    or not (v1.Options.Toggle_Shop_AutoBuyAura and v1.Options.Toggle_Shop_AutoBuyAura.Value) then
    return
  end

  v5.IsAutoBuyAuraRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoBuyAura
      and v1.Options.Toggle_Shop_AutoBuyAura.Value do
      pcall(function()
        local auras2 = v6.Auras or f2()
        local v73 = f3()

        if not auras2 or type(auras2.Items) ~= "table" or not v73 then
          return
        end

        local v74 = f9("AuraService", "GetState")
        local items = type(v74) == "table" and type(v74.Items) == "table" and v74.Items or {}
        local v75 = f10()
        local v76 = tonumber(localPlayer:GetAttribute("HighestVisitedWorld")) or 1
        local requiredWorldByAuraId = auras2.RequiredWorldByAuraId or {}
        local v77 = 0
        local v78 = nil
        local v79 = false
        local v80 = 0
        local v81 = nil

        for index15, value19 in ipairs(v73) do
          local v82 = items[value19]
          local v83 = type(v82) == "table" and v82.Owned == true
          local v84 = type(v82) == "table" and v82.Equipped == true
          local v85 = auras2.Items[value19]

          if v83 then
            v77 = index15
            v78 = value19
            v79 = v84
          elseif v85 and not v85.EventOnly then
            local v86 = tonumber(v85.Price) or 0
            local v87 = tonumber(requiredWorldByAuraId[value19]) or 1

            if v86 > 0 and v75 >= v86 and v76 >= v87 then
              v80 = index15
              v81 = value19
            end
          end
        end

        if v81 and v80 > v77 then
          f8("AuraService", "BuyOrToggleAura", v81)
        elseif v78 and not v79 then
          f8("AuraService", "BuyOrToggleAura", v78)
        end
      end)

      task.wait(5)
    end

    v5.IsAutoBuyAuraRunning = false
  end)
end

local function f31()
  if v5.IsAutoBuyCutterRunning
    or not (v1.Options.Toggle_Shop_AutoBuyCutter and v1.Options.Toggle_Shop_AutoBuyCutter.Value) then
    return
  end

  v5.IsAutoBuyCutterRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoBuyCutter
      and v1.Options.Toggle_Shop_AutoBuyCutter.Value do
      pcall(function()
        local v88 = f10()
        local v89 = f9("CuttersShopService", "GetShopState")

        if type(v89) ~= "table" or type(v89.CuttersData) ~= "table" then
          return
        end

        local v90 = tonumber(localPlayer:GetAttribute("HighestVisitedWorld")) or 1
        local ownedCutters = type(v89.OwnedCutters) == "table" and v89.OwnedCutters or {}
        local currentCutter = typeof(v89.CurrentCutter) == "string" and v89.CurrentCutter or ""
        local v91 = {}

        for key3, value20 in pairs(v89.CuttersData) do
          if type(value20) == "table" then
            table.insert(v91, {
              Name = key3,
              Info = value20,
              Order = tonumber(value20.ShopOrder) or math.huge,
              Price = tonumber(value20.Price) or 0,
            })
          end
        end

        table.sort(v91, function(p22, p23)
          if p22.Order ~= p23.Order then
            return p22.Order < p23.Order
          end

          if p22.Price ~= p23.Price then
            return p22.Price < p23.Price
          end

          return tostring(p22.Name) < tostring(p23.Name)
        end)

        local v92 = 0
        local name = nil
        local v93 = 0
        local name2 = nil

        for index16, value21 in ipairs(v91) do
          if ownedCutters[value21.Name] == true then
            v92 = index16
            name = value21.Name
          elseif not value21.Info.HiddenUntilOwned then
            local price3 = value21.Price
            local v94 = tonumber(value21.Info.RequiredWorld) or 1

            if price3 > 0 and v88 >= price3 and v90 >= v94 then
              v93 = index16
              name2 = value21.Name
            end
          end
        end

        if name2 and v93 > v92 then
          f8("CuttersShopService", "BuyCutter", name2)
        elseif name and currentCutter ~= name then
          f8("CuttersShopService", "BuyCutter", name)
        end
      end)

      task.wait(5)
    end

    v5.IsAutoBuyCutterRunning = false
  end)
end

local function f32()
  local sunTokens = localPlayer:GetAttribute("SunTokens")

  if typeof(sunTokens) == "number" then
    return sunTokens
  end

  local v95 = f9("DataService", "GetData", "SunTokens")

  if typeof(v95) == "number" then
    return v95
  end

  local v96 = f9("SunQuestRewardsService", "GetState")

  if type(v96) == "table" and typeof(v96.Tokens) == "number" then
    return v96.Tokens
  end

  return 0
end

local function f33()
  local sunTickets = localPlayer:GetAttribute("SunTickets")

  if typeof(sunTickets) == "number" then
    return sunTickets
  end

  local v97 = f9("DataService", "GetData", "SunTickets")

  if typeof(v97) == "number" then
    return v97
  end

  local v98 = f9("SunLuckyGachaService", "GetState")

  if type(v98) == "table" and typeof(v98.Tickets) == "number" then
    return v98.Tickets
  end

  return 0
end

local function f34()
  if v5.IsAutoClaimSunQuestsRunning
    or not (v1.Options.Toggle_SunQuest_AutoClaimQuests
      and v1.Options.Toggle_SunQuest_AutoClaimQuests.Value) then
    return
  end

  v5.IsAutoClaimSunQuestsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_SunQuest_AutoClaimQuests
      and v1.Options.Toggle_SunQuest_AutoClaimQuests.Value do
      pcall(function()
        local v99 = f9("QuestProgressService", "GetState")

        if type(v99) == "table" and type(v99.Categories) == "table" then
          for key4, value22 in pairs(v99.Categories) do
            if type(value22) == "table" and type(value22.Items) == "table" then
              for key5, value23 in pairs(value22.Items) do
                if type(value23) == "table" and value23.Complete == true
                  and value23.Claimed ~= true and value23.Id then
                  f9("QuestProgressService", "ClaimQuest", value23.Id)
                  task.wait(0.2)
                end
              end
            end
          end
        end
      end)

      task.wait(2)
    end

    v5.IsAutoClaimSunQuestsRunning = false
  end)
end

local function f35()
  if v5.IsAutoRollSunGachaRunning
    or not (v1.Options.Toggle_SunQuest_AutoRollGacha
      and v1.Options.Toggle_SunQuest_AutoRollGacha.Value) then
    return
  end

  v5.IsAutoRollSunGachaRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_SunQuest_AutoRollGacha
      and v1.Options.Toggle_SunQuest_AutoRollGacha.Value do
      local v100 = false

      pcall(function()
        if f33() > 0 then
          local v101 = f9("SunLuckyGachaService", "RollWithTicket")

          if type(v101) == "table" and type(v101.Batch) == "table" and v101.Batch.BatchId then
            f9("SunLuckyGachaService", "AcknowledgeBatch", v101.Batch.BatchId)
          end

          v100 = true
        end
      end)

      if v100 then
        task.wait(0.5)
      else
        task.wait(2)
      end
    end

    v5.IsAutoRollSunGachaRunning = false
  end)
end

local function f36()
  if v5.IsAutoBuySunRewardsRunning
    or not (v1.Options.Toggle_SunQuest_AutoBuyRewards
      and v1.Options.Toggle_SunQuest_AutoBuyRewards.Value) then
    return
  end

  v5.IsAutoBuySunRewardsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_SunQuest_AutoBuyRewards
      and v1.Options.Toggle_SunQuest_AutoBuyRewards.Value do
      pcall(function()
        local value24 = v1.Options.Dropdown_SunQuest_SelectRewards
          and v1.Options.Dropdown_SunQuest_SelectRewards.Value

        if not f12(value24) then
          return
        end

        local sunRewards = v6.SunRewards or f5()
        local v102 = f9("SunQuestRewardsService", "GetState")

        local tokens = type(v102) == "table" and typeof(v102.Tokens) == "number" and v102.Tokens
          or f32()

        local purchased = type(v102) == "table" and type(v102.Purchased) == "table"
            and v102.Purchased
          or {}

        for index17, value25 in ipairs(sunRewards) do
          if f11(value24, value25.DisplayName) or f11(value24, value25.Id) then
            local v103 = tonumber(purchased[value25.Id]) or 0

            if v103 < value25.Limit and tokens >= value25.Price then
              if f9("SunQuestRewardsService", "Purchase", value25.Id) then
                tokens = tokens - value25.Price
                purchased[value25.Id] = v103 + 1
                task.wait(0.3)
              end
            end
          end
        end
      end)

      task.wait(3)
    end

    v5.IsAutoBuySunRewardsRunning = false
  end)
end

local function f37()
  if v5.IsAutoTpBestWorldRunning
    or not (v1.Options.Toggle_Teleport_AutoTpBestWorld
      and v1.Options.Toggle_Teleport_AutoTpBestWorld.Value) then
    return
  end

  v5.IsAutoTpBestWorldRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Teleport_AutoTpBestWorld
      and v1.Options.Toggle_Teleport_AutoTpBestWorld.Value do
      pcall(function()
        local v104 = tonumber(localPlayer:GetAttribute("CurrentWorld"))
        local v105 = tonumber(localPlayer:GetAttribute("HighestUnlockedWorld"))

        if not v104 or not v105 then
          local v106 = f9("WorldService", "GetState")

          if type(v106) == "table" then
            v104 = v104 or tonumber(v106.CurrentWorld)
            v105 = v105 or tonumber(v106.HighestUnlockedWorld)
          end
        end

        v104 = v104 or 1
        v105 = v105 or 1

        if v104 < v105 then
          f9("WorldService", "TeleportToWorld", v105)
        end
      end)

      task.wait(3)
    end

    v5.IsAutoTpBestWorldRunning = false
  end)
end

local function f38()
  local v107, v108 = pcall(function() return f9("DataService", "GetData", "Museum") end)

  if v107 and type(v108) == "table" then
    return v108
  end

  return nil
end

local function f39()
  if localPlayer:GetAttribute("InMuseum") == true then
    return true
  end

  if (tonumber(localPlayer:GetAttribute("StrengthLevel")) or 1) < 100 then
    v1:Notify({ Title = "Museum", Content = "Requires Strength Level 100", Duration = 3 })
    return false
  end

  local character7 = localPlayer.Character
  local humanoidRootPart6 = character7 and character7:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart6 then
    return false
  end

  if (tonumber(localPlayer:GetAttribute("CurrentWorld")) or 1) ~= 2 then
    f9("WorldService", "TeleportToWorld", 2)
    task.wait(1.5)
  end

  humanoidRootPart6 = localPlayer.Character
    and localPlayer.Character:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart6 then
    humanoidRootPart6.CFrame = CFrame.new(-1011.98, 48.01, 1707.82)
    task.wait(1.5)
  end

  return localPlayer:GetAttribute("InMuseum") == true
end

local function f40()
  if v5.IsAutoCollectMuseumCashRunning
    or not (v1.Options.Toggle_Museum_AutoCollectCash
      and v1.Options.Toggle_Museum_AutoCollectCash.Value) then
    return
  end

  v5.IsAutoCollectMuseumCashRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Museum_AutoCollectCash
      and v1.Options.Toggle_Museum_AutoCollectCash.Value do
      pcall(function()
        local v109 = f38()

        if (v109 and tonumber(v109.StoredCash) or 0) > 0 then
          if localPlayer:GetAttribute("InMuseum") == true then
            local museumPlotIndex = localPlayer:GetAttribute("MuseumPlotIndex")
            local v110 = nil

            for index18, value26 in ipairs(workspace:GetDescendants()) do
              if value26:IsA("BasePart") and value26:GetAttribute("MuseumMoneyZone") == true
                and value26:GetAttribute("MuseumPlotIndex") == museumPlotIndex then
                v110 = value26
                break
              end
            end

            if v110 then
              local character8 = localPlayer.Character

              local humanoidRootPart7 = character8
                and character8:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart7 then
                if typeof(firetouchinterest) == "function" then
                  firetouchinterest(humanoidRootPart7, v110, 0)
                  task.wait(0.05)
                  firetouchinterest(humanoidRootPart7, v110, 1)
                else
                  local cframe2 = humanoidRootPart7.CFrame
                  humanoidRootPart7.CFrame = v110.CFrame + Vector3.new(0, 3, 0)
                  task.wait(0.3)
                  humanoidRootPart7.CFrame = cframe2
                end
              end
            end
          end
        end
      end)

      task.wait(3)
    end

    v5.IsAutoCollectMuseumCashRunning = false
  end)
end

local function f41()
  if v5.IsAutoBuyMuseumFloorsRunning
    or not (v1.Options.Toggle_Museum_AutoBuyFloors and v1.Options.Toggle_Museum_AutoBuyFloors.Value) then
    return
  end

  v5.IsAutoBuyMuseumFloorsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Museum_AutoBuyFloors
      and v1.Options.Toggle_Museum_AutoBuyFloors.Value do
      pcall(function()
        local v111 = f38()
        local v112 = v111 and tonumber(v111.UnlockedFloorCount) or 1

        local floorUpgradePrices = (v6.Museum or f6()).FloorUpgradePrices
          or { [2] = 15000000000000000000, [3] = 2.5e+27 }

        local v113 = f10()
        local v114 = floorUpgradePrices[v112 + 1]

        if v114 and v113 >= v114 then
          f9("MuseumService", "PurchaseFloor", (localPlayer:GetAttribute("MuseumPlotIndex")))
        end
      end)

      task.wait(5)
    end

    v5.IsAutoBuyMuseumFloorsRunning = false
  end)
end

local function f42()
  if v5.IsPlacingBestLoot then
    return
  end

  if localPlayer:GetAttribute("InMuseum") ~= true then
    v1:Notify({ Title = "Museum", Content = "Enter the museum first", Duration = 3 })
    return
  end

  local museumPlotIndex2 = localPlayer:GetAttribute("MuseumPlotIndex")

  if not museumPlotIndex2 or museumPlotIndex2 <= 0 then
    v1:Notify({ Title = "Museum", Content = "Plot not found", Duration = 3 })
    return
  end

  local character9 = localPlayer.Character
  local humanoidRootPart8 = character9 and character9:FindFirstChild("HumanoidRootPart")
  local humanoid = character9 and character9:FindFirstChildOfClass("Humanoid")

  if not humanoidRootPart8 or not humanoid then
    return
  end

  local v115 = {}

  for index19, value27 in ipairs(workspace:GetDescendants()) do
    if value27.Name == "Stand" and value27:GetAttribute("MuseumPlotIndex") == museumPlotIndex2 then
      local findFirstChildWhichIsA8 = value27:FindFirstChildWhichIsA("ProximityPrompt", true)

      if findFirstChildWhichIsA8
        and not (findFirstChildWhichIsA8
            and findFirstChildWhichIsA8:GetAttribute("MuseumStandOccupied") == true
          or value27:GetAttribute("MuseumStandOccupied") == true
          or value27:GetAttribute("MuseumLootId") ~= nil
            and value27:GetAttribute("MuseumLootId") ~= "") then
        table.insert(v115, { Stand = value27, Prompt = findFirstChildWhichIsA8 })
      end
    end
  end

  if #v115 == 0 then
    v1:Notify({ Title = "Museum", Content = "No empty stands found", Duration = 3 })
    return
  end

  local v116 = {
    Giant = 4,
    Huge = 3,
    Big = 2,
    Normal = 1,
  }

  local v117 = {
    Eternal = 10,
    Celestial = 9,
    Transcendent = 8,
    Mythic = 7,
    Legendary = 6,
    Epic = 5,
    Rare = 4,
    Uncommon = 3,
    Common = 2,
  }

  local v118 = {}

  local function f43(p24)
    if not p24 then
      return
    end

    for index20, value28 in ipairs(p24:GetChildren()) do
      if value28:IsA("Tool") and value28:GetAttribute("ItemType") == "Loot" then
        local v119 = tostring(value28:GetAttribute("LootSize") or "Normal")
        local v120 = tostring(value28:GetAttribute("LootRarity") or "Common")

        table.insert(v118, {
          Tool = value28,
          Key = value28:GetAttribute("InventoryKey"),
          SizeScore = v116[v119] or 1,
          RarityScore = v117[v120] or 1,
        })
      end
    end
  end

  f43(localPlayer:FindFirstChildOfClass("Backpack"))
  f43(localPlayer:FindFirstChild("_HiddenLootTools"))

  if #v118 == 0 then
    v1:Notify({ Title = "Museum", Content = "No loot available to place", Duration = 3 })
    return
  end

  table.sort(v118, function(p25, p26)
    if p25.SizeScore ~= p26.SizeScore then
      return p25.SizeScore > p26.SizeScore
    end

    return p25.RarityScore > p26.RarityScore
  end)

  v5.IsPlacingBestLoot = true

  task.spawn(function()
    local cframe3 = humanoidRootPart8.CFrame
    local v121 = math.min(#v115, #v118)

    for j = 1, v121 do
      local v122 = v115[j]
      local v123 = v118[j]

      if v122 and v123 and v122.Prompt then
        humanoidRootPart8.CFrame = v122.Stand:GetPivot() + Vector3.new(0, 3, 2)

        if v123.Key then
          f9("LootInventoryService", "EquipLoot", v123.Key)
        end

        humanoid:EquipTool(v123.Tool)
        task.wait(0.15)

        if typeof(fireproximityprompt) == "function" then
          fireproximityprompt(v122.Prompt)
        else
          v122.Prompt:InputHoldBegin()
          task.wait(0.6)
          v122.Prompt:InputHoldEnd()
        end

        task.wait(0.15)
      end
    end

    humanoidRootPart8.CFrame = cframe3

    v1:Notify({
      Title = "Museum",
      Content = "Placed " .. tostring(v121) .. " items on stands",
      Duration = 3,
    })

    v5.IsPlacingBestLoot = false
  end)
end

local function f44()
  if v5.IsPlacingBestLoot then
    return
  end

  if localPlayer:GetAttribute("InMuseum") ~= true then
    v1:Notify({ Title = "Museum", Content = "Enter the museum first", Duration = 3 })
    return
  end

  local museumPlotIndex3 = localPlayer:GetAttribute("MuseumPlotIndex")

  if not museumPlotIndex3 or museumPlotIndex3 <= 0 then
    v1:Notify({ Title = "Museum", Content = "Plot not found", Duration = 3 })
    return
  end

  local character10 = localPlayer.Character
  local humanoidRootPart9 = character10 and character10:FindFirstChild("HumanoidRootPart")
  local humanoid2 = character10 and character10:FindFirstChildOfClass("Humanoid")

  if not humanoidRootPart9 or not humanoid2 then
    return
  end

  local v124 = {}

  for index21, value29 in ipairs(workspace:GetDescendants()) do
    if value29.Name == "Stand" and value29:GetAttribute("MuseumPlotIndex") == museumPlotIndex3 then
      local findFirstChildWhichIsA9 = value29:FindFirstChildWhichIsA("ProximityPrompt", true)

      if findFirstChildWhichIsA9
        and (findFirstChildWhichIsA9
            and findFirstChildWhichIsA9:GetAttribute("MuseumStandOccupied") == true
          or value29:GetAttribute("MuseumStandOccupied") == true
          or value29:GetAttribute("MuseumLootId") ~= nil
            and value29:GetAttribute("MuseumLootId") ~= "") then
        table.insert(v124, { Stand = value29, Prompt = findFirstChildWhichIsA9 })
      end
    end
  end

  if #v124 == 0 then
    v1:Notify({ Title = "Museum", Content = "No items on stands to remove", Duration = 3 })
    return
  end

  v5.IsPlacingBestLoot = true

  task.spawn(function()
    f9("LootInventoryService", "UnequipLoot")
    humanoid2:UnequipTools()
    task.wait(0.2)
    local cframe4 = humanoidRootPart9.CFrame
    local v125 = #v124

    for k = 1, v125 do
      local v126 = v124[k]

      if v126 and v126.Prompt then
        humanoidRootPart9.CFrame = v126.Stand:GetPivot() + Vector3.new(0, 3, 2)
        task.wait(0.15)

        if typeof(fireproximityprompt) == "function" then
          fireproximityprompt(v126.Prompt)
        else
          v126.Prompt:InputHoldBegin()
          task.wait(0.6)
          v126.Prompt:InputHoldEnd()
        end

        task.wait(0.15)
      end
    end

    humanoidRootPart9.CFrame = cframe4

    v1:Notify({
      Title = "Museum",
      Content = "Removed " .. tostring(v125) .. " items from stands",
      Duration = 3,
    })

    v5.IsPlacingBestLoot = false
  end)
end

local window = v1:CreateWindow({ Title = "Cut Grass Adventure", SubTitle = "by Lamduck" })

local v127 = {
  Farm = window:AddTab({ Title = "Farm", Icon = "sprout" }),
  Shop = window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
  SunQuest = window:AddTab({ Title = "Sun Quest", Icon = "sun" }),
  Museum = window:AddTab({ Title = "Museum", Icon = "landmark" }),
  Teleport = window:AddTab({ Title = "Teleport", Icon = "globe" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

v127.Farm:AddToggle("Toggle_Farm_AutoClick", {
  Title = "Auto Click Strength",
  Default = false,
  Callback = function(value30)
    if value30 then
      f13()
    end
  end,
})

v127.Farm:AddToggle("Toggle_Farm_AutoPickupLoot", {
  Title = "Auto Pickup Loot (World)",
  Description = "Collects loot in current world",
  Default = false,
  Callback = function(value31)
    if value31 then
      f27()
    end
  end,
})

v127.Farm:AddToggle("Toggle_Farm_AutoSellLoot", {
  Title = "Auto Sell Loot",
  Description = "Only work when enable Auto Pickup Loot",
  Default = false,
})

v127.Farm:AddToggle("Toggle_Farm_AutoRebirth", {
  Title = "Auto Rebirth",
  Default = false,
  Callback = function(value32)
    if value32 then
      f28()
    end
  end,
})

v127.Shop:AddSection("Upgrades")

v127.Shop:AddDropdown("Dropdown_Shop_SelectUpgrades", {
  Title = "Select Upgrades",
  Values = v6.UpgradeNames or {},
  Multi = true,
  Searchable = true,
  Default = v6.UpgradeNames or {},
})

v127.Shop:AddToggle("Toggle_Shop_AutoUpgradeStats", {
  Title = "Auto Upgrade Selected Stats",
  Default = false,
  Callback = function(value33)
    if value33 then
      f29()
    end
  end,
})

v127.Shop:AddSection("Equipment")

v127.Shop:AddToggle("Toggle_Shop_AutoBuyAura", {
  Title = "Auto Buy & Equip Best Aura",
  Default = false,
  Callback = function(value34)
    if value34 then
      f30()
    end
  end,
})

v127.Shop:AddToggle("Toggle_Shop_AutoBuyCutter", {
  Title = "Auto Buy & Equip Best Cutter",
  Default = false,
  Callback = function(value35)
    if value35 then
      f31()
    end
  end,
})

v127.SunQuest:AddSection("Quests")

v127.SunQuest:AddToggle("Toggle_SunQuest_AutoClaimQuests", {
  Title = "Auto Claim Completed Quests",
  Description = "Automatically claims finished sun quests",
  Default = false,
  Callback = function(value36)
    if value36 then
      f34()
    end
  end,
})

v127.SunQuest:AddSection("Lucky Gacha")

v127.SunQuest:AddToggle("Toggle_SunQuest_AutoRollGacha", {
  Title = "Auto Roll Sun Lucky Gacha",
  Description = "Automatically rolls gacha when tickets are available",
  Default = false,
  Callback = function(value37)
    if value37 then
      f35()
    end
  end,
})

v127.SunQuest:AddButton({
  Title = "Roll Gacha (1 Ticket)",
  Callback = function()
    pcall(function()
      local v128 = f9("SunLuckyGachaService", "RollWithTicket")

      if type(v128) == "table" and type(v128.Batch) == "table" and v128.Batch.BatchId then
        f9("SunLuckyGachaService", "AcknowledgeBatch", v128.Batch.BatchId)
      end
    end)
  end,
})

v127.SunQuest:AddSection("Rewards Shop")

v127.SunQuest:AddDropdown("Dropdown_SunQuest_SelectRewards", {
  Title = "Select Rewards to Buy",
  Values = v6.SunRewardNames,
  Multi = true,
  Searchable = true,
})

v127.SunQuest:AddToggle("Toggle_SunQuest_AutoBuyRewards", {
  Title = "Auto Buy Selected Rewards",
  Description = "Purchases chosen rewards when tokens are sufficient",
  Default = false,
  Callback = function(value38)
    if value38 then
      f36()
    end
  end,
})

v127.Museum:AddSection("Navigation")

v127.Museum:AddButton({
  Title = "Enter Museum",
  Description = "Teleports to the museum entrance in World 2",
  Callback = function() pcall(function() f39() end) end,
})

v127.Museum:AddButton({
  Title = "Teleport To My Plot",
  Description = "Teleports directly to your plot in museum",
  Callback = function()
    pcall(function()
      if localPlayer:GetAttribute("InMuseum") == true then
        f9("MuseumService", "TeleportToAssignedPlot")
      else
        v1:Notify({ Title = "Museum", Content = "Enter the museum first", Duration = 3 })
      end
    end)
  end,
})

v127.Museum:AddButton({
  Title = "Exit Museum",
  Description = "Returns to your origin world",
  Callback = function() pcall(function() f9("MuseumService", "TeleportToOriginWorld") end) end,
})

v127.Museum:AddSection("Income & Upgrades")

v127.Museum:AddToggle("Toggle_Museum_AutoCollectCash", {
  Title = "Auto Collect Stored Cash",
  Description = "Collects accumulated cash when inside the museum",
  Default = false,
  Callback = function(value39)
    if value39 then
      f40()
    end
  end,
})

v127.Museum:AddToggle("Toggle_Museum_AutoBuyFloors", {
  Title = "Auto Buy Museum Floors",
  Description = "Purchases Floor 2 (15 Qi) and Floor 3 (2.5 Oc) when affordable",
  Default = false,
  Callback = function(value40)
    if value40 then
      f41()
    end
  end,
})

v127.Museum:AddSection("Display Stands")

v127.Museum:AddButton({
  Title = "Place Best Loot",
  Description = "Teleports to empty stands and places highest tier loot once",
  Callback = function() f42() end,
})

v127.Museum:AddButton({
  Title = "Remove All Loot",
  Description = "Teleports to occupied stands and removes all loot back to backpack",
  Callback = function() f44() end,
})

v127.Teleport:AddSection("World Teleport")

v127.Teleport:AddToggle("Toggle_Teleport_AutoTpBestWorld", {
  Title = "Auto Teleport Highest World",
  Description = "Automatically teleports to the highest unlocked world",
  Default = false,
  Callback = function(value41)
    if value41 then
      f37()
    end
  end,
})

v127.Teleport:AddButton({
  Title = "Open Game Worlds Menu",
  Description = "Opens the official worlds teleport menu",
  Callback = function()
    pcall(function()
      local utility = replicatedStorage:FindFirstChild("Shared")
        and replicatedStorage.Shared:FindFirstChild("Utility")

      local windowCoordinator = utility and utility:FindFirstChild("WindowCoordinator")
        and require(utility.WindowCoordinator)

      if windowCoordinator and typeof(windowCoordinator.Open) == "function" then
        windowCoordinator:Open("Worlds")
        return
      end

      local playerGui = localPlayer:FindFirstChild("PlayerGui")
      local worldsGUI = playerGui and playerGui:FindFirstChild("WorldsGUI")
      local worlds2 = worldsGUI and worldsGUI:FindFirstChild("Worlds")

      if worlds2 then
        worlds2.Visible = true
      end
    end)
  end,
})

v127.Teleport:AddDropdown("Dropdown_Teleport_SelectWorld", {
  Title = "Select World",
  Values = v6.WorldNames,
  Default = v6.WorldNames and v6.WorldNames[1] or "World 1",
})

v127.Teleport:AddButton({
  Title = "Teleport To Selected World",
  Callback = function()
    local value42 = v1.Options.Dropdown_Teleport_SelectWorld
      and v1.Options.Dropdown_Teleport_SelectWorld.Value

    local worldMap = v6.WorldMap and v6.WorldMap[value42] or 1
    pcall(function() f9("WorldService", "TeleportToWorld", worldMap) end)
  end,
})

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/CutGrassAdventure")
v4:SetFolder("Lamduck/CutGrassAdventure")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v127.Settings)
v3:BuildInterfaceSection(v127.Settings)
v2:BuildConfigSection(v127.Settings)

v1.OnUnload:Once(function()
  for index22, value43 in ipairs(v7) do
    if typeof(value43) == "RBXScriptConnection" and value43.Connected then
      value43:Disconnect()
    end
  end

  table.clear(v7)
end)

v2:LoadAutoloadConfig()
window:SelectTab(1)
