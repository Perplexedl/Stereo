local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/lamduck2005/RobloxScript/master/ui.lua"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local collectionService = game:GetService("CollectionService")
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local tweenService = game:GetService("TweenService")
local v1 = require(replicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
local stockValues = replicatedStorage:FindFirstChild("StockValues")

local v2 = {
  Config = {
    AutoHarvest = false,
    AutoSellAllFruits = false,
    AutoSteal = false,
    AutoTeleportHomeAtNight = false,
    AutoCollectDroppedItems = false,
    AutoBuySeed = false,
    TargetBuySeeds = {},
    AutoBuySeedByRarity = false,
    TargetBuyRarities = {},
    AutoBuyCrate = false,
    TargetBuyCrates = {},
    AutoBuyGear = false,
    TargetBuyGears = {},
    AutoPlant = false,
    TargetPlantSeeds = {},
    AutoPlantByRarity = false,
    TargetPlantRarities = {},
    AutoPlantPosition = "Player Position",
    AutoDeletePlant = false,
    TargetDeletePlantSeeds = {},
    TargetDeletePlantMutations = {},
    AutoDeleteFruit = false,
    TargetDeleteFruitSeeds = {},
    TargetDeleteFruitMutations = {},
    TargetMoveSeeds = {},
    MoveSavedPosition = nil,
    AutoWatering = false,
    TargetWateringSeeds = {},
    AutoExpandGarden = false,
    AutoTamePet = false,
    AutoTamePetByRarity = false,
    TargetTamePetNames = {},
    TargetTamePetRarities = {},
  },
  Flags = {
    IsAutoHarvestLoopRunning = false,
    IsAutoSellLoopRunning = false,
    IsAutoStealLoopRunning = false,
    IsAutoTeleportHomeLoopRunning = false,
    IsAutoCollectDroppedItemsLoopRunning = false,
    IsAutoBuySeedLoopRunning = false,
    IsAutoBuyCrateLoopRunning = false,
    IsAutoBuyGearLoopRunning = false,
    IsAutoPlantLoopRunning = false,
    IsAutoDeletePlantLoopRunning = false,
    IsAutoDeleteFruitLoopRunning = false,
    IsAutoWateringLoopRunning = false,
    IsAutoExpandGardenLoopRunning = false,
    IsAutoTamePetLoopRunning = false,
  },
  Data = {
    SeedShopNames = {},
    CrateShopNames = {},
    GearShopNames = {},
    SeedShopList = {},
    CrateShopList = {},
    GearShopList = {},
    SeedNames = {},
    SeedData = {},
    SeedRarityNames = {},
    SeedRarityMap = {},
    MutationNames = {},
    PetNames = {},
    PetRarityNames = {},
  },
  UIRefs = {},
}

if isfolder and not isfolder("GrowAGarden2") then
  pcall(function() makefolder("GrowAGarden2") end)
end

local function f1(p1, p2)
  for key, value in pairs(p2) do
    if type(value) == "table" then
      if next(value) == nil and p1[key] and type(p1[key]) == "table" then
      else
        if not p1[key] or type(p1[key]) ~= "table" then
          p1[key] = {}
        end

        f1(p1[key], value)
      end
    else
      p1[key] = value
    end
  end
end

local function f2(p3)
  if type(p3) ~= "table" then
    return
  end

  local v3 = {}

  for key2, value2 in pairs(p3) do
    if type(key2) == "string" and tonumber(key2) and tostring(tonumber(key2)) == key2 then
      v3[key2] = tonumber(key2)
    end

    if type(value2) == "table" then
      f2(value2)
    end
  end

  for key3, value3 in pairs(v3) do
    p3[value3] = p3[key3]
    p3[key3] = nil
  end
end

local function f3(p4)
  local v4 = {}

  for key4 in pairs(p4) do
    table.insert(v4, key4)
  end

  table.sort(v4)
  return v4
end

local function f4()
  if isfile and isfile("GrowAGarden2/Config.json") then
    local v5, v6 = pcall(function()
      return httpService:JSONDecode(readfile("GrowAGarden2/Config.json"))
    end)

    if v5 and v6 then
      f2(v6)
      pcall(function() f1(v2.Config, v6) end)
    end
  elseif writefile then
    pcall(function() writefile("GrowAGarden2/Config.json", httpService:JSONEncode(v2.Config)) end)
  end
end

local function f5()
  if writefile then
    pcall(function()
      writefile("GrowAGarden2/Config.json", (httpService:JSONEncode(v2.Config)))
    end)
  end
end

f4()
local tweenService2 = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local function f6()
  if #players:GetPlayers() <= 1 then
    localPlayer:Kick("\nRejoining...")
    task.wait()
    teleportService:Teleport(game.PlaceId, localPlayer)
  else
    teleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
  end
end

local function f7(p5)
  if not stockValues then
    return nil
  end

  local items = stockValues:FindFirstChild(p5) and stockValues[p5]:FindFirstChild("Items")

  if not items then
    return nil
  end

  local v7 = {}

  for v8, v9 in items:GetChildren() do
    local v10, v11 = pcall(function() return v9.Value end)
    table.insert(v7, { Name = v9.Name, Value = v10 and type(v11) == "number" and v11 or 0 })
  end

  table.sort(v7, function(p6, p7) return p6.Name < p7.Name end)
  return v7
end

local function f8()
  local seedShop = f7("SeedShop")
  v2.Data.SeedShopList = seedShop
  return seedShop
end

local function f9()
  local crateShop = f7("CrateShop")
  v2.Data.CrateShopList = crateShop
  return crateShop
end

local function f10()
  local gearShop = f7("GearShop")
  v2.Data.GearShopList = gearShop
  return gearShop
end

local function f11()
  if v2.Flags.IsAutoHarvestLoopRunning or not v2.Config.AutoHarvest then
    return
  end

  v2.Flags.IsAutoHarvestLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoHarvest do
      pcall(function()
        local plotId = localPlayer:GetAttribute("PlotId")

        local findFirstChild = plotId and workspace:FindFirstChild("Gardens")
          and workspace.Gardens:FindFirstChild("Plot" .. tostring(plotId))

        local prim = findFirstChild and findFirstChild:FindFirstChild("Visual")
          and findFirstChild.Visual:FindFirstChild("PRIM")

        local humanoidRootPart = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if prim and humanoidRootPart then
          if (humanoidRootPart.Position - prim.Position).Magnitude > 150 then
            ui:Notify({
              Title = "Harvest",
              Content = "Too far from your garden. Auto Harvest paused.",
              Duration = 4,
            })

            task.wait(8)
            return
          end
        end

        for v12, v13 in (collectionService:GetTagged("HarvestPrompt")) do
          if not v2.Config.AutoHarvest then
            break
          end

          if v13.Enabled and v13:IsDescendantOf(workspace) then
            local model = v13:FindFirstAncestorWhichIsA("Model")

            if model then
              local plantId = model:GetAttribute("PlantId")
              local fruitId = model:GetAttribute("FruitId")

              if plantId then
                v1.Garden.CollectFruit:Fire(plantId, fruitId or "")
              end
            end
          end
        end
      end)

      task.wait(0.01)
    end

    v2.Flags.IsAutoHarvestLoopRunning = false
  end)
end

local function f12()
  if v2.Flags.IsAutoSellLoopRunning or not v2.Config.AutoSellAllFruits then
    return
  end

  v2.Flags.IsAutoSellLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoSellAllFruits do
      pcall(function() v1.NPCS.SellAll:Fire() end)
      task.wait(2)
    end

    v2.Flags.IsAutoSellLoopRunning = false
  end)
end

local function f13()
  if v2.Flags.IsAutoStealLoopRunning or not v2.Config.AutoSteal then
    return
  end

  v2.Flags.IsAutoStealLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoSteal do
      pcall(function()
        local night = replicatedStorage:FindFirstChild("Night")

        if night and night.Value == true then
          for v14, v15 in (collectionService:GetTagged("StealPrompt")) do
            if not v2.Config.AutoSteal then
              break
            end

            if v15.Enabled and v15:IsDescendantOf(workspace) then
              local model2 = v15:FindFirstAncestorWhichIsA("Model")

              if model2 then
                local v16 = tonumber(model2:GetAttribute("UserId"))
                local plantId2 = model2:GetAttribute("PlantId")
                local fruitId2 = model2:GetAttribute("FruitId")

                if v16 and v16 ~= localPlayer.UserId and plantId2 then
                  local getPlayerByUserId = players:GetPlayerByUserId(v16)

                  if not (getPlayerByUserId
                    and getPlayerByUserId:GetAttribute("IsInOwnGarden") == true) then
                    v1.Steal.BeginSteal:Fire(v16, plantId2, fruitId2 or "")
                    task.wait(0.05)
                    v1.Steal.CompleteSteal:Fire()
                  end
                end
              end
            end
          end
        end
      end)

      task.wait(0.5)
    end

    v2.Flags.IsAutoStealLoopRunning = false
  end)
end

local function f14()
  if v2.Flags.IsAutoTeleportHomeLoopRunning or not v2.Config.AutoTeleportHomeAtNight then
    return
  end

  v2.Flags.IsAutoTeleportHomeLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoTeleportHomeAtNight do
      pcall(function()
        local night2 = replicatedStorage:FindFirstChild("Night")

        if night2 and night2.Value == true then
          local plotId2 = localPlayer:GetAttribute("PlotId")
          local gardens = workspace:FindFirstChild("Gardens")

          local findFirstChild2 = plotId2 and gardens
            and gardens:FindFirstChild("Plot" .. tostring(plotId2))

          local spawnPoint = findFirstChild2 and findFirstChild2:FindFirstChild("SpawnPoint")
          local character = localPlayer.Character

          if spawnPoint and character then
            character:PivotTo(spawnPoint.CFrame + Vector3.new(0, 3, 0))
          end
        end
      end)

      task.wait(3)
    end

    v2.Flags.IsAutoTeleportHomeLoopRunning = false
  end)
end

local function f15()
  local leaderstats = localPlayer:FindFirstChild("leaderstats")

  if not leaderstats then
    return 0
  end

  local sheckles = leaderstats:FindFirstChild("Sheckles")

  if not sheckles then
    return 0
  end

  return sheckles.Value
end

local function f16()
  if v2.Flags.IsAutoCollectDroppedItemsLoopRunning or not v2.Config.AutoCollectDroppedItems then
    return
  end

  v2.Flags.IsAutoCollectDroppedItemsLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoCollectDroppedItems do
      local v17 = false

      pcall(function()
        local droppedItems = workspace:FindFirstChild("DroppedItems")

        if not droppedItems then
          return
        end

        for v18, v19 in droppedItems:GetChildren() do
          local v20 = false

          repeat
            if not v2.Config.AutoCollectDroppedItems then
              break
            end

            local ownerRestricted = v19:GetAttribute("OwnerRestricted")
            local droppedBy = v19:GetAttribute("DroppedBy")

            if ownerRestricted == true and droppedBy ~= localPlayer.UserId then
              v20 = true
              break
            end

            local findFirstChildWhichIsA = v19:FindFirstChildWhichIsA("ProximityPrompt", true)

            if not findFirstChildWhichIsA or not findFirstChildWhichIsA.Enabled then
              v20 = true
              break
            end

            local position = v19:IsA("BasePart") and v19.Position
              or v19:IsA("Model") and v19:GetPivot().Position

            if not position then
              v20 = true
              break
            end

            local character2 = localPlayer.Character

            local humanoidRootPart2 = character2
              and character2:FindFirstChild("HumanoidRootPart")

            if not humanoidRootPart2 then
              v20 = true
              break
            end

            local v21 = os.clock() + 10

            while os.clock() < v21 do
              if not v2.Config.AutoCollectDroppedItems then
                break
              end

              if not v19 or not v19.Parent then
                break
              end

              if not (humanoidRootPart2 and humanoidRootPart2.Parent) then
                break
              end

              tweenService2:Create(humanoidRootPart2, tweenInfo, {
                CFrame = CFrame.new(position),
              }):Play()

              local holdDuration = findFirstChildWhichIsA.HoldDuration
              findFirstChildWhichIsA.HoldDuration = 0

              pcall(function()
                if fireproximityprompt then
                  fireproximityprompt(findFirstChildWhichIsA)
                end
              end)

              findFirstChildWhichIsA.HoldDuration = holdDuration

              if (humanoidRootPart2.Position - position).Magnitude > 3 then
                humanoidRootPart2.CFrame = CFrame.new(position)
              end

              task.wait(0.15)
            end

            v17 = true
            v20 = true
          until true

          if not v20 then
            break
          end
        end
      end)

      if not v17 then
        task.wait(1)
      end
    end

    v2.Flags.IsAutoCollectDroppedItemsLoopRunning = false
  end)
end

local function f17()
  if v2.Flags.IsAutoBuySeedLoopRunning then
    return
  end

  if not v2.Config.AutoBuySeed and not v2.Config.AutoBuySeedByRarity then
    return
  end

  v2.Flags.IsAutoBuySeedLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoBuySeed or v2.Config.AutoBuySeedByRarity do
      pcall(function()
        f8()
        local seedShopList = v2.Data.SeedShopList

        if not seedShopList or #seedShopList == 0 then
          return
        end

        for v22, v23 in seedShopList do
          local v24 = false

          if v2.Config.AutoBuySeed and v2.Config.TargetBuySeeds[v23.Name] then
            v24 = true
          end

          if v2.Config.AutoBuySeedByRarity then
            local v25 = v2.Data.SeedRarityMap[v23.Name]

            if v25 and v2.Config.TargetBuyRarities[v25] then
              v24 = true
            end
          end

          if v24 and v23.Value > 0 then
            for i = 1, v23.Value do
              v1.SeedShop.PurchaseSeed:Fire(v23.Name)
              task.wait(0.05)
            end
          end
        end
      end)

      task.wait(5)
    end

    v2.Flags.IsAutoBuySeedLoopRunning = false
  end)
end

local function f18()
  if v2.Flags.IsAutoBuyCrateLoopRunning or not v2.Config.AutoBuyCrate then
    return
  end

  v2.Flags.IsAutoBuyCrateLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoBuyCrate do
      pcall(function()
        f9()
        local crateShopList = v2.Data.CrateShopList

        if not crateShopList or #crateShopList == 0 then
          return
        end

        local targetBuyCrates = v2.Config.TargetBuyCrates

        if not targetBuyCrates or next(targetBuyCrates) == nil then
          return
        end

        for v26, v27 in crateShopList do
          if targetBuyCrates[v27.Name] and v27.Value > 0 then
            for j = 1, v27.Value do
              v1.CrateShop.PurchaseCrate:Fire(v27.Name)
              task.wait(0.05)
            end
          end
        end
      end)

      task.wait(10)
    end

    v2.Flags.IsAutoBuyCrateLoopRunning = false
  end)
end

local function f19()
  if v2.Flags.IsAutoBuyGearLoopRunning or not v2.Config.AutoBuyGear then
    return
  end

  v2.Flags.IsAutoBuyGearLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoBuyGear do
      pcall(function()
        f10()
        local gearShopList = v2.Data.GearShopList

        if not gearShopList or #gearShopList == 0 then
          return
        end

        local targetBuyGears = v2.Config.TargetBuyGears

        if not targetBuyGears or next(targetBuyGears) == nil then
          return
        end

        for v28, v29 in gearShopList do
          if targetBuyGears[v29.Name] and v29.Value > 0 then
            for k = 1, v29.Value do
              v1.GearShop.PurchaseGear:Fire(v29.Name)
              task.wait(0.05)
            end
          end
        end
      end)

      task.wait(10)
    end

    v2.Flags.IsAutoBuyGearLoopRunning = false
  end)
end

local function f20(p8)
  if not p8 then
    return false
  end

  if p8:IsDescendantOf(localPlayer.Character) then
    return true
  end

  local humanoid = localPlayer.Character
    and localPlayer.Character:FindFirstChildOfClass("Humanoid")

  if not humanoid then
    return false
  end

  humanoid:EquipTool(p8)
  task.wait(0.1)
  return p8:IsDescendantOf(localPlayer.Character)
end

local function f21(p9, p10)
  for v30, v31 in { localPlayer.Character, localPlayer:FindFirstChildOfClass("Backpack") } do
    local v32 = false

    repeat
      if not v31 then
        v32 = true
        break
      end

      for v33, v34 in v31:GetChildren() do
        local v35 = false

        repeat
          if not v34:IsA("Tool") then
            v35 = true
            break
          end

          local getAttribute = v34:GetAttribute(p9)

          if p10 ~= nil then
            if getAttribute == p10 then
              if p9 == "SeedTool" then
                local count = v34:GetAttribute("Count")

                if count == nil or count > 0 then
                  return v34
                end
              else
                return v34
              end
            end
          elseif getAttribute ~= nil then
            return v34
          end

          v35 = true
        until true

        if not v35 then
          break
        end
      end

      v32 = true
    until true

    if not v32 then
      break
    end
  end

  return nil
end

local function f22()
  local humanoidRootPart3 = localPlayer.Character
    and localPlayer.Character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart3 then
    return nil
  end

  return Vector3.new(
    humanoidRootPart3.Position.X, humanoidRootPart3.Position.Y - 3, humanoidRootPart3.Position.Z
  )
end

local function f23()
  local plotId3 = localPlayer:GetAttribute("PlotId")

  local findFirstChild3 = plotId3 and workspace:FindFirstChild("Gardens")
    and workspace.Gardens:FindFirstChild("Plot" .. tostring(plotId3))

  if not findFirstChild3 then
    return nil
  end

  local v36 = {}

  for v37, v38 in collectionService:GetTagged("PlantArea") do
    if v38:IsDescendantOf(findFirstChild3) then
      table.insert(v36, v38)
    end
  end

  if #v36 == 0 then
    return nil
  end

  local v39 = v36[math.random(1, #v36)]

  if v39:IsA("BasePart") then
    local size = v39.Size
    local v40 = (math.random() - 0.5) * size.X
    local v41 = (math.random() - 0.5) * size.Z
    return (v39.CFrame * CFrame.new(v40, size.Y / 2, v41)).Position
  end

  if v39.PrimaryPart then
    local size2 = v39.PrimaryPart.Size
    local v42 = (math.random() - 0.5) * size2.X
    local v43 = (math.random() - 0.5) * size2.Z
    return (v39.PrimaryPart.CFrame * CFrame.new(v42, size2.Y / 2, v43)).Position
  end

  return nil
end

local function f24()
  if v2.Flags.IsAutoPlantLoopRunning then
    return
  end

  if not v2.Config.AutoPlant and not v2.Config.AutoPlantByRarity then
    return
  end

  v2.Flags.IsAutoPlantLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoPlant or v2.Config.AutoPlantByRarity do
      pcall(function()
        local v44 = {}

        if v2.Config.AutoPlant then
          for key5 in pairs(v2.Config.TargetPlantSeeds) do
            table.insert(v44, key5)
          end
        end

        if v2.Config.AutoPlantByRarity then
          for v45, v46 in v2.Data.SeedData do
            if v2.Config.TargetPlantRarities[v46.Rarity] then
              table.insert(v44, v46.SeedName)
            end
          end
        end

        local v47 = v2.Config.AutoPlantPosition == "Random Position" and f23 or f22
        local v48 = {}

        for v49, v50 in v44 do
          local v51 = false

          repeat
            if v48[v50] then
              v51 = true
              break
            end

            v48[v50] = true
            local v52 = f21("SeedTool", v50)

            if not v52 then
              v51 = true
              break
            end

            local v53 = v47()

            if not v53 then
              v51 = true
              break
            end

            v1.Plant.PlantSeed:Fire(v53, v50, v52)
            v51 = true
          until true

          if not v51 then
            break
          end
        end
      end)

      task.wait(0.1)
    end

    v2.Flags.IsAutoPlantLoopRunning = false
  end)
end

local function f25()
  local v54 = {}

  for v55, v56 in replicatedStorage:WaitForChild("SharedModules"):WaitForChild("MutationData"):GetChildren() do
    if v56:IsA("ModuleScript") and v56.Name ~= "init" then
      table.insert(v54, v56.Name)
    end
  end

  table.sort(v54)
  return v54
end

local function f26()
  local v57 = {}

  local petModules = replicatedStorage:FindFirstChild("SharedModules")
    and replicatedStorage.SharedModules:FindFirstChild("PetModules")

  if not petModules then
    return v57
  end

  for v58, v59 in petModules:GetChildren() do
    if v59:IsA("ModuleScript") and v59.Name ~= "init" then
      table.insert(v57, v59.Name)
    end
  end

  table.sort(v57)
  return v57
end

local function f27()
  local plotId4 = localPlayer:GetAttribute("PlotId")

  local findFirstChild4 = plotId4 and workspace:FindFirstChild("Gardens")
    and workspace.Gardens:FindFirstChild("Plot" .. tostring(plotId4))

  if not findFirstChild4 then
    return {}
  end

  local plants = findFirstChild4:FindFirstChild("Plants")

  if not plants then
    return {}
  end

  local v60 = {}

  for v61, v62 in plants:GetChildren() do
    local v63, v64 = pcall(function() return v62:GetPivot().Position end)

    local v65 = {
      Model = v62,
      Position = v63 and v64 or nil,
      Age = v62:GetAttribute("Age"),
      LastGenerated = v62:GetAttribute("LastGenerated"),
      MaxAge = v62:GetAttribute("MaxAge"),
      PlantedAt = v62:GetAttribute("PlantedAt"),
      PlantGrowthReady = v62:GetAttribute("PlantGrowthReady"),
      PlantId = v62:GetAttribute("PlantId"),
      SeedName = v62:GetAttribute("SeedName"),
      UserId = v62:GetAttribute("UserId"),
      Decaying = v62:GetAttribute("Decaying"),
      GrowRateMulti = v62:GetAttribute("GrowRateMulti"),
      IgnoreFruitDistance = v62:GetAttribute("IgnoreFruitDistance"),
      MaxFruits = v62:GetAttribute("MaxFruits"),
      PlantType = v62:GetAttribute("PlantType"),
      Mutation = v62:GetAttribute("Mutation"),
      Fruits = {},
    }

    local fruits = v62:FindFirstChild("Fruits")

    if fruits then
      for v66, v67 in fruits:GetChildren() do
        v65.Fruits[v67.Name] = {
          Model = v67,
          Age = v67:GetAttribute("Age"),
          CorePartName = v67:GetAttribute("CorePartName"),
          FruitId = v67:GetAttribute("FruitId"),
          GrowRateMulti = v67:GetAttribute("GrowRateMulti"),
          LastGenerated = v67:GetAttribute("LastGenerated"),
          MaxAge = v67:GetAttribute("MaxAge"),
          PlantId = v67:GetAttribute("PlantId"),
          SizeMulti = v67:GetAttribute("SizeMulti"),
          SkipRotation = v67:GetAttribute("SkipRotation"),
          UserId = v67:GetAttribute("UserId"),
          Mutation = v67:GetAttribute("Mutation"),
        }
      end
    end

    v60[v62.Name] = v65
  end

  return v60
end

local function f28(p11, p12, p13)
  local corePartName = p11.CorePartName or p12.SeedName

  if not p13.Seeds[corePartName] then
    return false
  end

  if next(p13.Mutations) then
    return p13.Mutations[p11.Mutation or ""]
  end

  return p11.Mutation == nil
end

local function f29(p14, p15)
  if not p15.Seeds[p14.SeedName] then
    return false
  end

  if next(p15.Mutations) then
    return p15.Mutations[p14.Mutation or ""]
  end

  return p14.Mutation == nil
end

local function f30()
  if v2.Flags.IsAutoDeletePlantLoopRunning then
    return
  end

  if not v2.Config.AutoDeletePlant then
    return
  end

  v2.Flags.IsAutoDeletePlantLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoDeletePlant do
      pcall(function()
        local v68 = f21("Shovel", nil)

        if not v68 then
          return
        end

        if not f20(v68) then
          return
        end

        local shovel = v68:GetAttribute("Shovel")

        local v69 = {
          Seeds = v2.Config.TargetDeletePlantSeeds,
          Mutations = v2.Config.TargetDeletePlantMutations,
        }

        for v70, v71 in (f27()) do
          if not v2.Config.AutoDeletePlant then
            break
          end

          if f29(v71, v69) then
            v1.Shovel.UseShovel:Fire(v70, "", shovel, v68)
            task.wait(0.01)
          end
        end
      end)

      task.wait(0.3)
    end

    v2.Flags.IsAutoDeletePlantLoopRunning = false
  end)
end

local function f31()
  if v2.Flags.IsAutoDeleteFruitLoopRunning then
    return
  end

  if not v2.Config.AutoDeleteFruit then
    return
  end

  v2.Flags.IsAutoDeleteFruitLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoDeleteFruit do
      pcall(function()
        local v72 = f21("Shovel", nil)

        if not v72 then
          return
        end

        if not f20(v72) then
          return
        end

        local shovel2 = v72:GetAttribute("Shovel")

        local v73 = {
          Seeds = v2.Config.TargetDeleteFruitSeeds,
          Mutations = v2.Config.TargetDeleteFruitMutations,
        }

        for v74, v75 in (f27()) do
          if not v2.Config.AutoDeleteFruit then
            break
          end

          for v76, v77 in v75.Fruits do
            if not v2.Config.AutoDeleteFruit then
              break
            end

            if f28(v77, v75, v73) then
              v1.Shovel.UseShovel:Fire(v74, v76, shovel2, v72)
              task.wait(0.01)
            end
          end
        end
      end)

      task.wait(0.3)
    end

    v2.Flags.IsAutoDeleteFruitLoopRunning = false
  end)
end

local function f32()
  if v2.Flags.IsAutoWateringLoopRunning or not v2.Config.AutoWatering then
    return
  end

  v2.Flags.IsAutoWateringLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoWatering do
      pcall(function()
        local v78 = f21("WateringCan", nil)

        if not v78 then
          return
        end

        if not f20(v78) then
          return
        end

        local wateringCan = v78:GetAttribute("WateringCan")

        if not wateringCan then
          return
        end

        local targetWateringSeeds = v2.Config.TargetWateringSeeds

        if not targetWateringSeeds or next(targetWateringSeeds) == nil then
          return
        end

        for v79, v80 in (f27()) do
          local v81 = false

          repeat
            if not v2.Config.AutoWatering then
              break
            end

            if not targetWateringSeeds[v80.SeedName] then
              v81 = true
              break
            end

            local position2 = v80.Position

            if position2 then
              v1.WateringCan.UseWateringCan:Fire(Vector3.new(
                position2.X, position2.Y - 0.3, position2.Z
              ), wateringCan, v78)

              task.wait(0.15)
            end

            v81 = true
          until true

          if not v81 then
            break
          end
        end
      end)

      task.wait(1)
    end

    v2.Flags.IsAutoWateringLoopRunning = false
  end)
end

local function f33()
  if v2.Flags.IsAutoExpandGardenLoopRunning or not v2.Config.AutoExpandGarden then
    return
  end

  v2.Flags.IsAutoExpandGardenLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoExpandGarden do
      pcall(function() v1.Actions.ExpandGarden:Fire() end)
      task.wait(10)
    end

    v2.Flags.IsAutoExpandGardenLoopRunning = false
  end)
end

local function f34()
  if not v2.Config.AutoTamePet and not v2.Config.AutoTamePetByRarity then
    return
  end

  if v2.Flags.IsAutoTamePetLoopRunning then
    if v2.Config.AutoTamePet or v2.Config.AutoTamePetByRarity then
      return
    end

    v2.Flags.IsAutoTamePetLoopRunning = false
  end

  v2.Flags.IsAutoTamePetLoopRunning = true

  task.spawn(function()
    while v2.Config.AutoTamePet or v2.Config.AutoTamePetByRarity do
      local v82 = false

      pcall(function()
        local map = workspace:FindFirstChild("Map")
        local wildPetRef = map and map:FindFirstChild("WildPetRef")
        local wildPetSpawns = map and map:FindFirstChild("WildPetSpawns")

        if not wildPetRef then
          return
        end

        local autoTamePet = v2.Config.AutoTamePet
        local autoTamePetByRarity = v2.Config.AutoTamePetByRarity
        local targetTamePetNames = v2.Config.TargetTamePetNames
        local targetTamePetRarities = v2.Config.TargetTamePetRarities
        local v83 = autoTamePet and targetTamePetNames and next(targetTamePetNames) ~= nil

        local v84 = autoTamePetByRarity and targetTamePetRarities
          and next(targetTamePetRarities) ~= nil

        if not v83 and not v84 then
          return
        end

        for v85, v86 in wildPetRef:GetChildren() do
          local v87 = false

          repeat
            if not v2.Config.AutoTamePet and not v2.Config.AutoTamePetByRarity then
              break
            end

            if not v86:IsA("BasePart") then
              v87 = true
              break
            end

            local ownerUserId = v86:GetAttribute("OwnerUserId")

            if ownerUserId ~= nil and ownerUserId ~= 0 then
              v87 = true
              break
            end

            local petName = v86:GetAttribute("PetName")
            local rarity = v86:GetAttribute("Rarity")

            if autoTamePet and not targetTamePetNames[petName] then
              v87 = true
              break
            end

            if autoTamePetByRarity and not targetTamePetRarities[rarity] then
              v87 = true
              break
            end

            local price = v86:GetAttribute("Price")

            if price and f15() < price then
              v87 = true
              break
            end

            local character3 = localPlayer.Character

            local humanoidRootPart4 = character3
              and character3:FindFirstChild("HumanoidRootPart")

            if not humanoidRootPart4 then
              v87 = true
              break
            end

            local v88 = os.clock() + 20

            while os.clock() < v88 do
              if not v2.Config.AutoTamePet and not v2.Config.AutoTamePetByRarity then
                break
              end

              if not v86 or not v86.Parent then
                break
              end

              local ownerUserId2 = v86:GetAttribute("OwnerUserId")

              if ownerUserId2 == localPlayer.UserId then
                break
              end

              if ownerUserId2 ~= nil and ownerUserId2 ~= 0 then
                break
              end

              if not (humanoidRootPart4 and humanoidRootPart4.Parent) then
                break
              end

              tweenService2:Create(humanoidRootPart4, tweenInfo, {
                CFrame = CFrame.new(v86.Position),
              }):Play()

              if wildPetSpawns then
                local findFirstChild5 = wildPetSpawns:FindFirstChild("WildPet_" .. petName .. "_"
                  .. v86.Name)

                if findFirstChild5 then
                  local primaryPart = findFirstChild5.PrimaryPart
                    or findFirstChild5:FindFirstChildWhichIsA("BasePart")

                  if primaryPart then
                    local buyPrompt = primaryPart:FindFirstChild("BuyPrompt")

                    if buyPrompt and buyPrompt:IsA("ProximityPrompt") then
                      buyPrompt.HoldDuration = 0
                      fireproximityprompt(buyPrompt)
                    end
                  end
                end
              end

              v1.Pets.WildPetTame:Fire(v86)

              if (humanoidRootPart4.Position - v86.Position).Magnitude > 3 then
                humanoidRootPart4.CFrame = CFrame.new(v86.Position)
              end

              task.wait(0.15)
            end

            v82 = true
            v87 = true
          until true

          if not v87 then
            break
          end
        end
      end)

      if not v82 then
        task.wait(0.5)
      end
    end

    v2.Flags.IsAutoTamePetLoopRunning = false
  end)
end

local function f35()
  local humanoidRootPart5 = localPlayer.Character
    and localPlayer.Character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart5 then
    return false
  end

  v2.Config.MoveSavedPosition = humanoidRootPart5.Position
  return true
end

local function f36(p16)
  local v89 = f21("Trowel", nil)

  if not v89 then
    return
  end

  if not f20(v89) then
    return
  end

  local v90 = f27()
  local v91 = { Seeds = v2.Config.TargetMoveSeeds, Mutations = {} }

  if not v91.Seeds or next(v91.Seeds) == nil then
    return
  end

  for v92, v93 in v90 do
    if f29(v93, v91) then
      v1.Trowel.MovePlant:Fire(v92, p16, 0)
      task.wait(0.05)
    end
  end
end

local function f37()
  if not v2.Config.MoveSavedPosition then
    return
  end

  f36(v2.Config.MoveSavedPosition)
end

local function f38()
  local humanoidRootPart6 = localPlayer.Character
    and localPlayer.Character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart6 then
    return
  end

  f36(humanoidRootPart6.Position)
end

local function f39(p17, p18)
  if not stockValues then
    return
  end

  local items2 = stockValues:FindFirstChild(p17) and stockValues[p17]:FindFirstChild("Items")

  if not items2 then
    return
  end

  local v94 = {}

  for v95, v96 in items2:GetChildren() do
    table.insert(v94, v96.Name)
  end

  table.sort(v94)
  v2.Data[p18] = v94
end

local function f40()
  local v97, v98 = pcall(function()
    return require(replicatedStorage:WaitForChild("SharedModules"):WaitForChild("SeedData"))
  end)

  if not v97 or not v98 then
    return
  end

  local v99 = {}
  local v100 = {}
  local v101 = {}

  for v102, v103 in v98 do
    local v104 = { SeedName = v103.SeedName }

    if v103.Rarity ~= nil then
      v104.Rarity = v103.Rarity
      v101[v103.SeedName] = v103.Rarity
    end

    if v103.PurchasePrice ~= nil then
      v104.PurchasePrice = v103.PurchasePrice
    end

    if v103.RestockShop ~= nil then
      v104.RestockShop = v103.RestockShop
    end

    if v103.RestockChance ~= nil then
      v104.RestockChance = v103.RestockChance
    end

    if v103.IsSingleHarvest ~= nil then
      v104.IsSingleHarvest = v103.IsSingleHarvest
    end

    if v103.PrimeTime ~= nil then
      v104.PrimeTime = v103.PrimeTime
    end

    if v103.MutationSeed then
      v104.MutationSeed = true
    end

    table.insert(v99, v104)
    table.insert(v100, v103.SeedName)
  end

  table.sort(v100)

  v2.Data.SeedData = v99
  v2.Data.SeedNames = v100
  v2.Data.SeedRarityMap = v101

  local v105 = {}

  for v106, v107 in v99 do
    if v107.Rarity and not v105[v107.Rarity] then
      v105[v107.Rarity] = true
      table.insert(v2.Data.SeedRarityNames, v107.Rarity)
    end
  end
end

f39("SeedShop", "SeedShopNames")
f39("CrateShop", "CrateShopNames")
f39("GearShop", "GearShopNames")

v2.Data.MutationNames = f25()
v2.Data.PetNames = f26()
v2.Data.PetRarityNames = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic" }

f40()
local window = ui:CreateWindow({ Title = "Grow A Garden 2", Icon = "wheat" })
ui:SetAFKInfo("sheckles", function() return "Sheckles", f15() end)

local v108 = {
  TabFarming = window:Tab({ Title = "Farm", Icon = "lucide:wheat" }),
  TabPet = window:Tab({ Title = "Pet", Icon = "lucide:dog" }),
  TabShop = window:Tab({ Title = "Shop", Icon = "lucide:shopping-cart" }),
  TabGarden = window:Tab({ Title = "Garden", Icon = "lucide:tree-palm" }),
  TabConfig = window:Tab({ Title = "Config", Icon = "lucide:settings" }),
}

v2.UIRefs.ToggleAutoHarvest = v108.TabFarming:Toggle({
  Title = "Auto Harvest",
  Desc = "Auto collects ALL ready crops.",
  Value = v2.Config.AutoHarvest,
  Callback = function(value4)
    v2.Config.AutoHarvest = value4

    if value4 then
      f11()
    end
  end,
})

v2.UIRefs.ToggleAutoSellAllFruits = v108.TabFarming:Toggle({
  Title = "Auto Sell All Fruits",
  Value = v2.Config.AutoSellAllFruits,
  Callback = function(value5)
    v2.Config.AutoSellAllFruits = value5

    if value5 then
      f12()
    end
  end,
})

v2.UIRefs.ToggleAutoCollectDroppedItems = v108.TabFarming:Toggle({
  Title = "[TEST] Auto Collect Dropped Seed",
  Value = v2.Config.AutoCollectDroppedItems,
  Callback = function(value6)
    v2.Config.AutoCollectDroppedItems = value6

    if value6 then
      f16()
    end
  end,
})

local section = v108.TabPet:Section({ Title = "[TEST] Auto Tame", Opened = true })

v2.UIRefs.DropdownTamePetName = section:Dropdown({
  Title = "Target Pet Names",
  Values = v2.Data.PetNames,
  Value = f3(v2.Config.TargetTamePetNames),
  Multi = true,
  AllowNone = true,
  Callback = function(value7)
    v2.Config.TargetTamePetNames = {}

    if type(value7) == "table" then
      for key6, value8 in pairs(value7) do
        v2.Config.TargetTamePetNames[value8] = true
      end
    else
      v2.Config.TargetTamePetNames[value7] = true
    end
  end,
})

v2.UIRefs.ToggleAutoTamePet = section:Toggle({
  Title = "Auto Tame Pet",
  Value = v2.Config.AutoTamePet,
  Callback = function(value9)
    v2.Config.AutoTamePet = value9

    if value9 then
      v2.Config.AutoTamePetByRarity = false
      pcall(function() v2.UIRefs.ToggleAutoTamePetByRarity:Set(false) end)
      f34()
    end
  end,
})

section:Divider()

v2.UIRefs.DropdownTamePetRarity = section:Dropdown({
  Title = "Target Rarities",
  Values = v2.Data.PetRarityNames,
  Value = f3(v2.Config.TargetTamePetRarities),
  Multi = true,
  AllowNone = true,
  Callback = function(value10)
    v2.Config.TargetTamePetRarities = {}

    if type(value10) == "table" then
      for key7, value11 in pairs(value10) do
        v2.Config.TargetTamePetRarities[value11] = true
      end
    else
      v2.Config.TargetTamePetRarities[value10] = true
    end
  end,
})

v2.UIRefs.ToggleAutoTamePetByRarity = section:Toggle({
  Title = "Auto Tame By Rarity",
  Value = v2.Config.AutoTamePetByRarity,
  Callback = function(value12)
    v2.Config.AutoTamePetByRarity = value12

    if value12 then
      v2.Config.AutoTamePet = false
      pcall(function() v2.UIRefs.ToggleAutoTamePet:Set(false) end)
      f34()
    end
  end,
})

local gardenExpansionSection = v108.TabShop:Section({ Title = "Garden Expansion", Opened = true })

v2.UIRefs.ToggleAutoExpandGarden = gardenExpansionSection:Toggle({
  Title = "Auto Expand Garden",
  Value = v2.Config.AutoExpandGarden,
  Callback = function(value13)
    v2.Config.AutoExpandGarden = value13

    if value13 then
      f33()
    end
  end,
})

local seedShopSection = v108.TabShop:Section({ Title = "Seed Shop", Opened = true })

v2.UIRefs.DropdownSelectSeed = seedShopSection:Dropdown({
  Title = "Target Seeds",
  Values = v2.Data.SeedNames,
  Value = f3(v2.Config.TargetBuySeeds),
  Multi = true,
  AllowNone = true,
  Callback = function(value14)
    v2.Config.TargetBuySeeds = {}

    if type(value14) == "table" then
      for key8, value15 in pairs(value14) do
        v2.Config.TargetBuySeeds[value15] = true
      end
    else
      v2.Config.TargetBuySeeds[value14] = true
    end
  end,
})

v2.UIRefs.ToggleAutoBuySeed = seedShopSection:Toggle({
  Title = "Auto Buy Seed",
  Value = v2.Config.AutoBuySeed,
  Callback = function(value16)
    v2.Config.AutoBuySeed = value16

    if value16 then
      v2.Config.AutoBuySeedByRarity = false
      pcall(function() v2.UIRefs.ToggleAutoBuySeedByRarity:Set(false) end)
      f17()
    end
  end,
})

seedShopSection:Divider()

v2.UIRefs.DropdownBuySeedRarity = seedShopSection:Dropdown({
  Title = "Target Rarities",
  Values = v2.Data.SeedRarityNames,
  Value = f3(v2.Config.TargetBuyRarities),
  Multi = true,
  AllowNone = true,
  Callback = function(value17)
    v2.Config.TargetBuyRarities = {}

    if type(value17) == "table" then
      for key9, value18 in pairs(value17) do
        v2.Config.TargetBuyRarities[value18] = true
      end
    else
      v2.Config.TargetBuyRarities[value17] = true
    end
  end,
})

v2.UIRefs.ToggleAutoBuySeedByRarity = seedShopSection:Toggle({
  Title = "Auto Buy By Rarity",
  Value = v2.Config.AutoBuySeedByRarity,
  Callback = function(value19)
    v2.Config.AutoBuySeedByRarity = value19

    if value19 then
      v2.Config.AutoBuySeed = false
      pcall(function() v2.UIRefs.ToggleAutoBuySeed:Set(false) end)
      f17()
    end
  end,
})

local section2 = v108.TabShop:Section({ Title = "Crate Shop (Prop)", Opened = true })

v2.UIRefs.DropdownSelectCrate = section2:Dropdown({
  Title = "Target Crates",
  Values = v2.Data.CrateShopNames,
  Value = f3(v2.Config.TargetBuyCrates),
  Multi = true,
  AllowNone = true,
  Callback = function(value20)
    v2.Config.TargetBuyCrates = {}

    if type(value20) == "table" then
      for key10, value21 in pairs(value20) do
        v2.Config.TargetBuyCrates[value21] = true
      end
    else
      v2.Config.TargetBuyCrates[value20] = true
    end
  end,
})

v2.UIRefs.ToggleAutoBuyCrate = section2:Toggle({
  Title = "Auto Buy Crate",
  Value = v2.Config.AutoBuyCrate,
  Callback = function(value22)
    v2.Config.AutoBuyCrate = value22

    if value22 then
      f18()
    end
  end,
})

local gearShopSection = v108.TabShop:Section({ Title = "Gear Shop", Opened = true })

v2.UIRefs.DropdownSelectGear = gearShopSection:Dropdown({
  Title = "Target Gears",
  Values = v2.Data.GearShopNames,
  Value = f3(v2.Config.TargetBuyGears),
  Multi = true,
  AllowNone = true,
  Callback = function(value23)
    v2.Config.TargetBuyGears = {}

    if type(value23) == "table" then
      for key11, value24 in pairs(value23) do
        v2.Config.TargetBuyGears[value24] = true
      end
    else
      v2.Config.TargetBuyGears[value23] = true
    end
  end,
})

v2.UIRefs.ToggleAutoBuyGear = gearShopSection:Toggle({
  Title = "Auto Buy Gear",
  Value = v2.Config.AutoBuyGear,
  Callback = function(value25)
    v2.Config.AutoBuyGear = value25

    if value25 then
      f19()
    end
  end,
})

local autoPlantSection = v108.TabGarden:Section({ Title = "Auto Plant", Opened = true })

autoPlantSection:Paragraph({
  Title = "<font color='#FFB74D'><b>Tip</b></font>",
  Desc = "<font color='#FF6B6B'>Recommended to use with fly (Infinity Yield) when using Player Position</font>",
})

v2.UIRefs.DropdownPlantPosition = autoPlantSection:Dropdown({
  Title = "Plant Position",
  Values = { "Player Position", "Random Position" },
  Value = v2.Config.AutoPlantPosition,
  Multi = false,
  Callback = function(value26)
    v2.Config.AutoPlantPosition = type(value26) == "table" and value26[1] or value26
  end,
})

v108.TabGarden:Divider()

v2.UIRefs.DropdownPlantSeeds = autoPlantSection:Dropdown({
  Title = "Target Seeds",
  Values = v2.Data.SeedNames,
  Value = f3(v2.Config.TargetPlantSeeds),
  Multi = true,
  AllowNone = true,
  Callback = function(value27)
    v2.Config.TargetPlantSeeds = {}

    if type(value27) == "table" then
      for key12, value28 in pairs(value27) do
        v2.Config.TargetPlantSeeds[value28] = true
      end
    else
      v2.Config.TargetPlantSeeds[value27] = true
    end
  end,
})

v2.UIRefs.ToggleAutoPlant = autoPlantSection:Toggle({
  Title = "Auto Plant",
  Value = v2.Config.AutoPlant,
  Callback = function(value29)
    v2.Config.AutoPlant = value29

    if value29 then
      v2.Config.AutoPlantByRarity = false
      pcall(function() v2.UIRefs.ToggleAutoPlantByRarity:Set(false) end)
      f24()
    end
  end,
})

autoPlantSection:Divider()

v2.UIRefs.DropdownPlantRarity = autoPlantSection:Dropdown({
  Title = "Target Rarities",
  Values = v2.Data.SeedRarityNames,
  Value = f3(v2.Config.TargetPlantRarities),
  Multi = true,
  AllowNone = true,
  Callback = function(value30)
    v2.Config.TargetPlantRarities = {}

    if type(value30) == "table" then
      for key13, value31 in pairs(value30) do
        v2.Config.TargetPlantRarities[value31] = true
      end
    else
      v2.Config.TargetPlantRarities[value30] = true
    end
  end,
})

v2.UIRefs.ToggleAutoPlantByRarity = autoPlantSection:Toggle({
  Title = "Auto Plant By Rarity",
  Value = v2.Config.AutoPlantByRarity,
  Callback = function(value32)
    v2.Config.AutoPlantByRarity = value32

    if value32 then
      v2.Config.AutoPlant = false
      pcall(function() v2.UIRefs.ToggleAutoPlant:Set(false) end)
      f24()
    end
  end,
})

local wateringCanSection = v108.TabGarden:Section({ Title = "Watering Can", Opened = true })

v2.UIRefs.DropdownWateringSeeds = wateringCanSection:Dropdown({
  Title = "Target Seeds",
  Values = v2.Data.SeedNames,
  Value = f3(v2.Config.TargetWateringSeeds),
  Multi = true,
  AllowNone = true,
  Callback = function(value33)
    v2.Config.TargetWateringSeeds = {}

    if type(value33) == "table" then
      for key14, value34 in pairs(value33) do
        v2.Config.TargetWateringSeeds[value34] = true
      end
    else
      v2.Config.TargetWateringSeeds[value33] = true
    end
  end,
})

v2.UIRefs.ToggleAutoWatering = wateringCanSection:Toggle({
  Title = "Auto Watering",
  Value = v2.Config.AutoWatering,
  Callback = function(value35)
    v2.Config.AutoWatering = value35

    if value35 then
      f32()
    end
  end,
})

local deletePlantSection = v108.TabGarden:Section({ Title = "Delete Plant", Opened = true })

v2.UIRefs.DropdownDeletePlantSeeds = deletePlantSection:Dropdown({
  Title = "Target Seeds",
  Values = v2.Data.SeedNames,
  Value = f3(v2.Config.TargetDeletePlantSeeds),
  Multi = true,
  AllowNone = true,
  Callback = function(value36)
    v2.Config.TargetDeletePlantSeeds = {}

    if type(value36) == "table" then
      for key15, value37 in pairs(value36) do
        v2.Config.TargetDeletePlantSeeds[value37] = true
      end
    else
      v2.Config.TargetDeletePlantSeeds[value36] = true
    end
  end,
})

v2.UIRefs.DropdownDeletePlantMutations = deletePlantSection:Dropdown({
  Title = "Target Mutations",
  Values = v2.Data.MutationNames,
  Value = f3(v2.Config.TargetDeletePlantMutations),
  Multi = true,
  AllowNone = true,
  Callback = function(value38)
    v2.Config.TargetDeletePlantMutations = {}

    if type(value38) == "table" then
      for key16, value39 in pairs(value38) do
        v2.Config.TargetDeletePlantMutations[value39] = true
      end
    else
      v2.Config.TargetDeletePlantMutations[value38] = true
    end
  end,
})

v2.UIRefs.ToggleAutoDeletePlant = deletePlantSection:Toggle({
  Title = "Auto Delete Plant",
  Value = v2.Config.AutoDeletePlant,
  Callback = function(value40)
    v2.Config.AutoDeletePlant = value40

    if value40 then
      f30()
    end
  end,
})

local deleteFruitSection = v108.TabGarden:Section({ Title = "Delete Fruit", Opened = true })

v2.UIRefs.DropdownDeleteFruitSeeds = deleteFruitSection:Dropdown({
  Title = "Target Seeds",
  Values = v2.Data.SeedNames,
  Value = f3(v2.Config.TargetDeleteFruitSeeds),
  Multi = true,
  AllowNone = true,
  Callback = function(value41)
    v2.Config.TargetDeleteFruitSeeds = {}

    if type(value41) == "table" then
      for key17, value42 in pairs(value41) do
        v2.Config.TargetDeleteFruitSeeds[value42] = true
      end
    else
      v2.Config.TargetDeleteFruitSeeds[value41] = true
    end
  end,
})

v2.UIRefs.DropdownDeleteFruitMutations = deleteFruitSection:Dropdown({
  Title = "Target Mutations",
  Values = v2.Data.MutationNames,
  Value = f3(v2.Config.TargetDeleteFruitMutations),
  Multi = true,
  AllowNone = true,
  Callback = function(value43)
    v2.Config.TargetDeleteFruitMutations = {}

    if type(value43) == "table" then
      for key18, value44 in pairs(value43) do
        v2.Config.TargetDeleteFruitMutations[value44] = true
      end
    else
      v2.Config.TargetDeleteFruitMutations[value43] = true
    end
  end,
})

v2.UIRefs.ToggleAutoDeleteFruit = deleteFruitSection:Toggle({
  Title = "Auto Delete Fruit",
  Value = v2.Config.AutoDeleteFruit,
  Callback = function(value45)
    v2.Config.AutoDeleteFruit = value45

    if value45 then
      f31()
    end
  end,
})

local section3 = v108.TabGarden:Section({ Title = "Move Plant (Trowel)", Opened = true })

v2.UIRefs.DropdownMoveSeeds = section3:Dropdown({
  Title = "Target Seeds",
  Values = v2.Data.SeedNames,
  Value = f3(v2.Config.TargetMoveSeeds),
  Multi = true,
  AllowNone = true,
  Callback = function(value46)
    v2.Config.TargetMoveSeeds = {}

    if type(value46) == "table" then
      for key19, value47 in pairs(value46) do
        v2.Config.TargetMoveSeeds[value47] = true
      end
    else
      v2.Config.TargetMoveSeeds[value46] = true
    end
  end,
})

v2.UIRefs.ParagraphMovePosition = section3:Paragraph({
  Title = "Saved Position",
  Desc = "Not set",
})

section3:Button({
  Title = "Set Position (Current Pos)",
  Callback = function()
    if f35() then
      local moveSavedPosition = v2.Config.MoveSavedPosition

      v2.UIRefs.ParagraphMovePosition:SetDesc(string.format(
        "%.1f, %.1f, %.1f", moveSavedPosition.X, moveSavedPosition.Y, moveSavedPosition.Z
      ))

      ui:Notify({ Title = "Move", Content = "Position saved!", Duration = 2 })
    else
      ui:Notify({ Title = "Move", Content = "No character found!", Duration = 2 })
    end
  end,
})

section3:Divider()

section3:Button({
  Title = "Move All Selected → Saved Position",
  Callback = function()
    if not v2.Config.MoveSavedPosition then
      ui:Notify({ Title = "Move", Content = "No saved position! Set one first.", Duration = 2 })
      return
    end

    f37()
    ui:Notify({ Title = "Move", Content = "Moved to saved position!", Duration = 2 })
  end,
})

section3:Button({
  Title = "Move All Selected → Current Position",
  Callback = function()
    f38()
    ui:Notify({ Title = "Move", Content = "Moved to current position!", Duration = 2 })
  end,
})

v108.TabConfig:Button({
  Title = "Save Current Config",
  Callback = function()
    window:Dialog({
      Title = "Confirm Save",
      Content = "Are you sure you want to save the current configuration?",
      Buttons = {
        {
          Title = "Confirm",
          Callback = function()
            f5()

            ui:Notify({
              Title = "Success",
              Content = "Configuration saved to device!",
              Duration = 3,
            })
          end,
        },
        { Title = "Cancel" },
      },
    })
  end,
})

v108.TabConfig:Button({
  Title = "Delete & Reset Config",
  Callback = function()
    window:Dialog({
      Title = "Confirm Reset",
      Content = "Are you sure you want to delete your CURRENT config and rejoin?",
      Buttons = {
        {
          Title = "Confirm",
          Callback = function()
            pcall(function()
              if isfile and delfile and isfile("GrowAGarden2/Config.json") then
                delfile("GrowAGarden2/Config.json")
              end
            end)

            ui:Notify({
              Title = "Success",
              Content = "Config deleted! Rejoining...",
              Duration = 3,
            })

            task.wait(3)
            f6()
          end,
        },
        { Title = "Cancel" },
      },
    })
  end,
})

if v2.Config.AutoHarvest then
  f11()
end

if v2.Config.AutoSellAllFruits then
  f12()
end

if v2.Config.AutoSteal then
  f13()
end

if v2.Config.AutoTeleportHomeAtNight then
  f14()
end

if v2.Config.AutoCollectDroppedItems then
  f16()
end

if v2.Config.AutoBuySeed or v2.Config.AutoBuySeedByRarity then
  f17()
end

if v2.Config.AutoBuyCrate then
  f18()
end

if v2.Config.AutoBuyGear then
  f19()
end

if v2.Config.AutoPlant or v2.Config.AutoPlantByRarity then
  f24()
end

if v2.Config.AutoExpandGarden then
  f33()
end

if v2.Config.AutoTamePet or v2.Config.AutoTamePetByRarity then
  f34()
end

if v2.Config.AutoDeletePlant then
  f30()
end

if v2.Config.AutoDeleteFruit then
  f31()
end

if v2.Config.MoveSavedPosition then
  local moveSavedPosition2 = v2.Config.MoveSavedPosition

  if v2.UIRefs.ParagraphMovePosition then
    pcall(function()
      v2.UIRefs.ParagraphMovePosition:SetDesc(string.format(
        "%.1f, %.1f, %.1f", moveSavedPosition2.X, moveSavedPosition2.Y, moveSavedPosition2.Z
      ))
    end)
  end
end

v108.TabFarming:Select()

ui:Notify(({
  { Title = "Warning", Content = "ONLY using script on clone account!!!", Duration = 15 },
  {
    Title = "Discord Community",
    Content = "Click your User Info in the UI to get our Discord link!",
    Duration = 15,
  },
  { Title = "Join Us", Content = "https://discord.gg/N3uxkAHYtM", Duration = 15 },
})[math.random(1, 3)])
