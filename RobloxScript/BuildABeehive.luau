local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")
local starterGui = game:GetService("StarterGui")
local honeySystem = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("HoneySystem")

local v5 = {
  Flags = {
    IsExtractHoneyLoopRunning = false,
    IsSellHoneyLoopRunning = false,
    IsDepositEventHoneyLoopRunning = false,
    IsClaimEventQuestLoopRunning = false,
    IsExchangeLotteryLoopRunning = false,
    IsBuyFlowersLoopRunning = false,
    IsBuyItemsLoopRunning = false,
    IsSpawnBeeLoopRunning = false,
    IsAutoPlantSeedLoopRunning = false,
    IsUseGrowthPotionLoopRunning = false,
    IsAutoPickupFlowersLoopRunning = false,
    IsAutoRemoveFlowersLoopRunning = false,
    IsCollectSeasonPassLoopRunning = false,
    IsSpinSeasonLotteryLoopRunning = false,
    IsSpinBloomingLotteryLoopRunning = false,
    IsAutoFriendRequestEnabled = false,
    IsAutoGiftLoopRunning = false,
    IsAutoPlaceFlowerLoopRunning = false,
    IsAutoFarmBambooCoinRunning = false,
    IsAutoClaimBambooQuestsRunning = false,
    IsSpinBambooWheelLoopRunning = false,
    IsAutoHoldTrainToolLoopRunning = false,
    IsAutoRebirthBambooLoopRunning = false,
    IsAutoSpinGloryWheelRunning = false,
    IsAutoClaimGloryStageRunning = false,
    IsAutoExchangeGloryCrystalRunning = false,
    IsAutoLikeLoopRunning = false,
    IsAutoFreeRefreshEventQuestsRunning = false,
    IsAutoClaimOnlineEventPackRunning = false,
    IsAutoClaimPlaytimeRewardRunning = false,
    IsAutoClaimDailyLoginRunning = false,
    IsAutoClaimDailyLootRunning = false,
    IsAutoClaimFreeLoopPackRunning = false,
    IsAutoClaimOfflineRewardRunning = false,
    IsAutoClaimHoneyJarRunning = false,
    IsAutoUpgradePlotLoopRunning = false,
    IsAutoBuyQueenBeeTreeLoopRunning = false,
    IsAutoFeedTreeFertilizerLoopRunning = false,
    IsAutoPlantTreeFlowersLoopRunning = false,
    IsAutoRemoveTreeFlowersLoopRunning = false,
    IsUpgradingTreeFlowers = false,
  },
  Data = {
    FlowerRegistry = {},
    FlowerNames = {},
    FlowerNamesWithPrice = {},
    ItemRegistry = {},
    ItemNames = {},
    ItemNamesWithPrice = {},
    MutationNames = {},
    GloryExchangeOptions = {},
    GloryExchangeOptionToId = {},
    GloryExchangeIdToData = {},
    OnlineRewards = {},
  },
  Cache = {
    PlayerPlot = nil,
    EventRemote = nil,
    OriginalWarn = nil,
    MyFlowersConn = nil,
    PlotsConn = nil,
    OriginalWorldWarn = nil,
    OriginalClassWarn = nil,
    FriendRequestPlayerAddedConn = nil,
    TrainDoubleConn = nil,
    GloryWheelConn = nil,
    GloryWheelState = nil,
    LootResultConn = nil,
    PlaytimeRewardGuiConn = nil,
  },
}

local addParagraph = nil
local addParagraph2 = nil
local addParagraph3 = nil

local v6 = {
  K = 1000,
  M = 1000000,
  B = 1000000000,
  T = 1000000000000,
  QA = 1000000000000000,
  QD = 1000000000000000,
  QI = 1000000000000000000,
  QN = 1000000000000000000,
  SX = 1e+21,
  SP = 1e+24,
  OC = 1e+27,
  O = 1e+27,
  NO = 1e+30,
  N = 1e+30,
  DE = 1e+33,
  D = 1e+33,
  UN = 1e+36,
  UD = 1e+36,
  DD = 1e+39,
  TD = 1e+42,
  QAD = 1e+45,
  QID = 1e+48,
  SXD = 1e+51,
  SPD = 1e+54,
  OCD = 1e+57,
  NOD = 1e+60,
  VG = 1e+63,
}

local v7 = {}

for key, value in pairs(v6) do
  v7[value] = key
end

local v8 = {
  50000000, 100000000, 500000000, 1000000000, 2000000000, 5000000000, 10000000000, 10000000000,
  10000000000, 10000000000, 10000000000, 10000000000,
}

local function f1(title, p1, p2)
  if not pcall(function()
    starterGui:SetCore("SendNotification", {
      Title = title,
      Text = p1,
      Icon = "rbxthumb://type=Asset&id=81215685023875&w=150&h=150",
      Duration = p2 or 4,
    })
  end) then
    task.defer(function()
      pcall(function() v1:Notify({ Title = title, Content = p1, Duration = p2 or 4 }) end)
    end)
  end
end

local function f2()
  if v5.Cache.PlayerPlot and v5.Cache.PlayerPlot.Parent then
    return v5.Cache.PlayerPlot
  end

  v5.Cache.PlayerPlot = nil
  local plots = workspace:FindFirstChild("Plots")

  if plots then
    for index, value2 in ipairs(plots:GetChildren()) do
      local owner = value2:FindFirstChild("Owner")

      if owner and tostring(owner.Value) == localPlayer.Name then
        v5.Cache.PlayerPlot = value2
        return value2
      end
    end
  end

  local v9, v10 = pcall(function()
    return require(replicatedStorage:WaitForChild("Framework"))
  end)

  if v9 and v10 and v10.Modules and v10.Modules.PlotsUtil then
    local v11, v12 = pcall(function() return v10.Modules.PlotsUtil:GetPlayerPlot(localPlayer) end)

    if v11 and v12 then
      v5.Cache.PlayerPlot = v12
      return v12
    end
  end

  return nil
end

local function f3(p3)
  if type(p3) == "number" then
    return p3
  end

  if type(p3) ~= "string" or p3 == "" then
    return 0
  end

  local gsub = string.upper(p3):gsub("[%$%,%s]", "")
  local v13, v14 = string.match(gsub, "^([%d%.]+)(%a*)$")

  if not v13 then
    return 0
  end

  local v15 = v6[v14] or 1
  return (tonumber(v13) or 0) * v15
end

local function f4(p4)
  if not p4 or p4 == 0 then
    return "0"
  end

  if p4 < 1000 then
    return tostring(math.floor(p4))
  end

  local v16 = 10 ^ (math.floor(math.log10(p4) / 3) * 3)
  local v17 = v7[v16]

  if v17 then
    local v18 = p4 / v16

    local v19 = v18 == math.floor(v18) and string.format("%.0f", v18)
      or string.format("%.1f", v18)

    return string.format("%s%s", v19, v17)
  end

  return tostring(math.floor(p4))
end

local function f5()
  local v20 = { "Normal" }
  local assets = game.ReplicatedStorage:FindFirstChild("Assets")
  local mutations = assets and assets:FindFirstChild("Mutations")

  if mutations then
    for index2, value3 in ipairs(mutations:GetChildren()) do
      table.insert(v20, value3.Name)
    end
  end

  return v20
end

local function f6()
  local v21, v22 = pcall(function()
    return require(replicatedStorage:WaitForChild("Framework"))
  end)

  if v21 and v22 and v22.Modules and v22.Modules.DataUtil then
    local v23, v24 = pcall(function() return v22.Modules.DataUtil:GetPlayerData(localPlayer) end)

    if v23 and v24 and v24.Currency and v24.Currency.Currency1 then
      return tonumber(v24.Currency.Currency1) or 0
    end
  end

  local playerGui = localPlayer:FindFirstChild("PlayerGui")

  local amountLabel = playerGui and playerGui:FindFirstChild("HUD")
    and playerGui.HUD:FindFirstChild("Currency")
    and playerGui.HUD.Currency:FindFirstChild("AmountLabel")

  if amountLabel and amountLabel.Text then
    return f3(amountLabel.Text)
  end

  local leaderstats = localPlayer:FindFirstChild("leaderstats")
  local coins = leaderstats and leaderstats:FindFirstChild("Coins")
  return coins and f3(coins.Value) or 0
end

local function f7(p5)
  return f6() >= p5
end

local function f8()
  local v25, v26 = pcall(function()
    return require(replicatedStorage:WaitForChild("Framework"))
  end)

  if v25 and v26 and v26.Modules and v26.Modules.DataUtil then
    local getPlayerData = v26.Modules.DataUtil:GetPlayerData(localPlayer)

    if getPlayerData and getPlayerData.PlotExtend and getPlayerData.PlotExtend.Level then
      return tonumber(getPlayerData.PlotExtend.Level) or 0
    end
  end

  local v27 = f2()

  if v27 then
    local plotExtendLevel = v27:GetAttribute("PlotExtendLevel")

    if plotExtendLevel then
      return tonumber(plotExtendLevel) or 0
    end
  end

  return 0
end

local function f9()
  local v28 = f2()
  local flowerTrees = v28 and v28:FindFirstChild("FlowerTrees")
  local tree1 = flowerTrees and flowerTrees:FindFirstChild("Tree1")

  if tree1 then
    local treeConfiguration = tree1:FindFirstChild("TreeConfiguration")

    local treeLevel = treeConfiguration and treeConfiguration:GetAttribute("TreeLevel")
      or tree1:GetAttribute("TreeLevel")

    if treeLevel and tonumber(treeLevel) and tonumber(treeLevel) >= 1 then
      return true
    end

    local flowerSlots = tree1:FindFirstChild("FlowerSlots")

    if flowerSlots and #flowerSlots:GetChildren() > 0 then
      return true
    end
  end

  local v29, v30 = pcall(function()
    return require(replicatedStorage:WaitForChild("Framework"))
  end)

  if v29 and v30 and v30.Modules and v30.Modules.DataUtil then
    local v31, v32 = pcall(function() return v30.Modules.DataUtil:GetPlayerData(localPlayer) end)

    if v31 and v32 and v32.FlowerTrees and v32.FlowerTrees.Placed
      and v32.FlowerTrees.Placed.Tree1 then
      return true
    end
  end

  return false
end

local function f10()
  local v33, v34 = pcall(function()
    return require(replicatedStorage:WaitForChild("Configs"):WaitForChild("ResFlowers"))
  end)

  local v35 = {}
  local v36 = {}
  local v37 = {}

  if v33 and type(v34) == "table" then
    for key2, value4 in pairs(v34) do
      if type(value4) == "table" and value4.DisplayName then
        v35[key2] = {
          Id = key2,
          Name = value4.DisplayName,
          Price = tonumber(value4.Price) or 0,
          Index = tonumber(value4.Index) or 99,
        }

        table.insert(v36, key2)

        if tonumber(value4.Price) and tonumber(value4.Price) > 0 then
          table.insert(v37, key2)
        end
      end
    end

    table.sort(v36)
    table.sort(v37, function(p6, p7) return (v35[p6].Index or 99) < (v35[p7].Index or 99) end)
  else
    local findFirstChild = localPlayer:FindFirstChild("FlowerShopScript", true)

    if findFirstChild then
      for index3, value5 in ipairs(findFirstChild:GetChildren()) do
        if value5:IsA("IntValue") or value5:IsA("NumberValue") then
          local name = value5.Name

          v35[name] = {
            Id = name,
            Name = name,
            Price = 0,
            Index = 99,
          }

          table.insert(v36, name)
          table.insert(v37, name)
        end
      end
    end
  end

  return v35, v36, v37
end

local function f11()
  local v38, v39 = pcall(function()
    return require(replicatedStorage:WaitForChild("Configs"):WaitForChild("ResTreeToolShop"))
  end)

  local v40 = {}
  local v41 = {}
  local v42 = {}

  if v38 and type(v39) == "table" then
    for key3, value6 in pairs(v39) do
      if type(value6) == "table" and value6.DisplayName then
        v40[key3] = {
          Id = key3,
          Name = value6.DisplayName,
          Price = tonumber(value6.Price) or 0,
          Index = tonumber(value6.Index) or 99,
        }

        table.insert(v41, key3)

        if tonumber(value6.Price) and tonumber(value6.Price) > 0 then
          table.insert(v42, key3)
        end
      end
    end

    table.sort(v41)
    table.sort(v42, function(p8, p9) return (v40[p8].Index or 99) < (v40[p9].Index or 99) end)
  else
    local findFirstChild2 = localPlayer:FindFirstChild("ToolShopScript", true)

    if findFirstChild2 then
      for index4, value7 in ipairs(findFirstChild2:GetChildren()) do
        if value7:IsA("IntValue") or value7:IsA("NumberValue") then
          local name2 = value7.Name

          v40[name2] = {
            Id = name2,
            Name = name2,
            Price = 0,
            Index = 99,
          }

          table.insert(v41, name2)
          table.insert(v42, name2)
        end
      end
    end
  end

  return v40, v41, v42
end

local function f12()
  local v43 = nil

  if v5.Cache.GloryWheelState and v5.Cache.GloryWheelState.Currency ~= nil then
    v43 = tonumber(v5.Cache.GloryWheelState.Currency)
  end

  if v43 == nil then
    pcall(function()
      local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

      local findFirstChild3 = playerGui2 and playerGui2:FindFirstChild("ScreenGloryShop", true) and playerGui2.ScreenGloryShop:FindFirstChild("Dialog", true) and playerGui2.ScreenGloryShop.Dialog:FindFirstChild("Wheel", true) and playerGui2.ScreenGloryShop.Dialog.Wheel:FindFirstChild(
        "Count", true
      ) and playerGui2.ScreenGloryShop.Dialog.Wheel.Count:FindFirstChild(
        "Count", true
      )

      if findFirstChild3 and findFirstChild3:IsA("TextLabel") and findFirstChild3.Text ~= "" then
        v43 = f3(findFirstChild3.Text)
      end
    end)
  end

  local v44 = v43 or 0
  print(string.format("[Glory] Current Currency: %s", tostring(v44)))
  return v44
end

local function f13()
  local v45 = nil

  if v5.Cache.GloryWheelState and v5.Cache.GloryWheelState.Crystal ~= nil then
    v45 = tonumber(v5.Cache.GloryWheelState.Crystal)
  end

  if v45 == nil then
    pcall(function()
      local playerGui3 = localPlayer:FindFirstChild("PlayerGui")

      local findFirstChild4 = playerGui3 and playerGui3:FindFirstChild("ScreenGloryShop", true) and playerGui3.ScreenGloryShop:FindFirstChild("Dialog", true) and playerGui3.ScreenGloryShop.Dialog:FindFirstChild("Store", true) and playerGui3.ScreenGloryShop.Dialog.Store:FindFirstChild(
        "Count", true
      ) and playerGui3.ScreenGloryShop.Dialog.Store.Count:FindFirstChild(
        "Count", true
      )

      if findFirstChild4 and findFirstChild4:IsA("TextLabel") and findFirstChild4.Text ~= "" then
        v45 = f3(findFirstChild4.Text)
      end
    end)
  end

  local v46 = v45 or 0
  print(string.format("[Glory] Current Crystal: %s", tostring(v46)))
  return v46
end

local function f14()
  local v47, v48 = pcall(function()
    return require(replicatedStorage:WaitForChild("Configs"):WaitForChild("ResGloryExchange"))
  end)

  local v49, v50 = pcall(function()
    return require(replicatedStorage:WaitForChild("Configs"):WaitForChild("ResFlowers"))
  end)

  local v51 = {}
  local v52 = {}
  local v53 = {}

  local v54 = {
    { Id = "GloryEx1", ItemId = "Lily", CrystalReq = 1 },
    { Id = "GloryEx2", ItemId = "ButterflyPinkRose", CrystalReq = 1 },
    { Id = "GloryEx3", ItemId = "EveningGlowFlower", CrystalReq = 2 },
    { Id = "GloryEx4", ItemId = "ForgetMeNot", CrystalReq = 2 },
  }

  local v55 = {}

  if v47 and type(v48) == "table" and v48.__index then
    for index5, value8 in ipairs(v48.__index) do
      if v48[value8] then
        table.insert(v55, v48[value8])
      end
    end
  else
    print("[GloryExchange] Config not found or invalid, using fallback exchange list")
    v55 = v54
  end

  for index6, value9 in ipairs(v55) do
    local itemId = value9.ItemId

    if v49 and type(v50) == "table" and v50[value9.ItemId] and v50[value9.ItemId].DisplayName then
      itemId = v50[value9.ItemId].DisplayName
    end

    local v56 = itemId
    table.insert(v51, v56)
    v52[v56] = value9.Id

    v53[value9.Id] = {
      Id = value9.Id,
      ItemId = value9.ItemId,
      CrystalReq = tonumber(value9.CrystalReq) or 1,
      Label = v56,
    }
  end

  return v51, v52, v53
end

local function f15()
  local v57, v58 = pcall(function()
    return require(replicatedStorage:WaitForChild("Configs"):WaitForChild("ResOnlineRewards"))
  end)

  local v59 = {}

  if v57 and type(v58) == "table" and v58.__index then
    local total = 0

    for index7, value10 in ipairs(v58.__index) do
      local v60 = v58[value10]

      if v60 then
        total = total + (tonumber(v60.Duration) or 0)
        table.insert(v59, { Id = value10, RequiredDuration = total })
      end
    end
  end

  return v59
end

local flowerRegistry, flowerNames, flowerNamesWithPrice = f10()
local itemRegistry, itemNames, itemNamesWithPrice = f11()
local gloryExchangeOptions, gloryExchangeOptionToId, gloryExchangeIdToData = f14()

v5.Data.FlowerRegistry = flowerRegistry
v5.Data.FlowerNames = flowerNames
v5.Data.FlowerNamesWithPrice = flowerNamesWithPrice
v5.Data.ItemRegistry = itemRegistry
v5.Data.ItemNames = itemNames
v5.Data.ItemNamesWithPrice = itemNamesWithPrice
v5.Data.MutationNames = f5()
v5.Data.GloryExchangeOptions = gloryExchangeOptions
v5.Data.GloryExchangeOptionToId = gloryExchangeOptionToId
v5.Data.GloryExchangeIdToData = gloryExchangeIdToData
v5.Data.OnlineRewards = f15()

pcall(function()
  local gloryWheelRemote = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GloryWheel"):WaitForChild("GloryWheelRemote")

  if not v5.Cache.GloryWheelConn then
    v5.Cache.GloryWheelConn = gloryWheelRemote.OnClientEvent:Connect(function(p10)
      if type(p10) == "table" and p10.state then
        v5.Cache.GloryWheelState = p10.state
      end
    end)
  end

  gloryWheelRemote:FireServer({ event = "getState" })
end)

local function f16()
  local v61 = {}

  for index8, value11 in ipairs(replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GameEvent"):GetChildren()) do
    if value11:IsA("ModuleScript") and value11.Name:find("EventUtil")
      and value11.Name ~= "GameEventUtil" then
      local v62, v63 = pcall(function() return require(value11) end)

      if v62 and type(v63) == "table" and type(v63.IsEventActive) == "function" then
        local isEventActive = false
        pcall(function() isEventActive = v63:IsEventActive() end)

        if isEventActive then
          local remoteEvent = value11:FindFirstChild("RemoteEvent")

          if remoteEvent then
            table.insert(v61, { Module = v63, Remote = remoteEvent, Name = value11.Name })
          end
        end
      end
    end
  end

  return v61
end

local function f17()
  local v64 = {}

  for index9, value12 in ipairs(replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GameEvent"):GetChildren()) do
    if value12:IsA("ModuleScript") and value12.Name:find("OnlinePackUtil") then
      local v65, v66 = pcall(function() return require(value12) end)

      if v65 and type(v66) == "table" and type(v66.IsEventActive) == "function" then
        local isEventActive2 = false
        pcall(function() isEventActive2 = v66:IsEventActive() end)

        if isEventActive2 then
          local onlinePackRE = value12:FindFirstChild("OnlinePackRE")
            or value12:FindFirstChild("RemoteEvent")

          if onlinePackRE then
            table.insert(v64, { Module = v66, Remote = onlinePackRE, Name = value12.Name })
          end
        end
      end
    end
  end

  return v64
end

local function f18()
  local v67 = f2()

  if not v67 then
    return {}
  end

  local v68 = {}

  for index10, value13 in ipairs(game:GetService("CollectionService"):GetTagged("FlowerPlot")) do
    if value13:IsDescendantOf(v67) and value13:IsA("BasePart") and value13.Position.Y > -50 then
      table.insert(v68, value13)
    end
  end

  return v68
end

local function f19(p11, p12)
  if p11 <= 0 then
    return {}
  end

  local character = localPlayer.Character
  local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart then
    return {}
  end

  if p12 == "Current Pos" then
    local v69 = {}
    local v70 = humanoidRootPart.CFrame * CFrame.new(0, -3, 0)

    for i = 1, p11 do
      table.insert(v69, v70)
    end

    return v69
  end

  local v71 = f2()

  if not v71 then
    return {}
  end

  local v72 = f18()

  if #v72 == 0 then
    return {}
  end

  local flowers = v71:FindFirstChild("Flowers")
  local v73 = {}

  if flowers then
    for index11, value14 in ipairs(flowers:GetChildren()) do
      pcall(function()
        if value14:IsA("Model") then
          table.insert(v73, value14:GetPivot().Position)
        elseif value14:IsA("BasePart") then
          table.insert(v73, value14.Position)
        end
      end)
    end
  end

  local v74 = {}

  for j = 1, p11 do
    local v75 = nil

    for k = 1, 100 do
      local v76 = v72[math.random(1, #v72)]

      if v76 and v76:IsA("BasePart") then
        local size = v76.Size
        local v77 = math.max(0.1, size.X - 4)
        local v78 = math.max(0.1, size.Z - 4)
        local v79 = (math.random() - 0.5) * v77
        local v80 = (math.random() - 0.5) * v78
        local v81 = size.Y / 2
        local v82 = v76.CFrame * CFrame.new(v79, v81, v80)
        local position = v82.Position
        local v83 = false

        for index12, value15 in ipairs(v73) do
          local v84 = position.X - value15.X
          local v85 = position.Z - value15.Z

          if v84 * v84 + v85 * v85 < 0.64 then
            v83 = true
            break
          end
        end

        if not v83 then
          v75 = v82
          table.insert(v73, position)
          break
        end
      end
    end

    if not v75 then
      local v86 = v72[math.random(1, #v72)]

      if v86 and v86:IsA("BasePart") then
        local size2 = v86.Size
        local v87 = math.max(0.1, size2.X - 4)
        local v88 = math.max(0.1, size2.Z - 4)
        local v89 = (math.random() - 0.5) * v87
        local v90 = (math.random() - 0.5) * v88
        local v91 = size2.Y / 2
        v75 = v86.CFrame * CFrame.new(v89, v91, v90)
        table.insert(v73, v75.Position)
      end
    end

    if v75 then
      table.insert(v74, v75)
    end
  end

  return v74
end

local function f20(p13)
  if type(p13) ~= "table" then
    return {}
  end

  local v92 = false

  for key4, value16 in pairs(p13) do
    if value16 == true then
      v92 = true
      break
    end
  end

  if not v92 then
    return {}
  end

  local v93 = {}

  for index13, value17 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value17 then
      for index14, value18 in ipairs(value17:GetChildren()) do
        if value18:IsA("Tool") and value18:GetAttribute("IsSeed") then
          if p13[value18:GetAttribute("FlowerId")] == true then
            table.insert(v93, value18)
          end
        end
      end
    end
  end

  return v93
end

local function f21()
  local count = 0

  for index15, value19 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value19 then
      for index16, value20 in ipairs(value19:GetChildren()) do
        if value20:IsA("Tool") and value20:GetAttribute("IsFlower") then
          count = count + 1
        end
      end
    end
  end

  return count
end

local function f22()
  for index17, value21 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value21 then
      for index18, value22 in ipairs(value21:GetChildren()) do
        if value22:IsA("Tool") and value22:GetAttribute("FertilizerId")
          and value22:GetAttribute("FeedType") == "Tree" then
          return true
        end
      end
    end
  end

  return false
end

local function f23(p14, p15)
  if type(p14) ~= "table" or type(p15) ~= "table" then
    return {}
  end

  local v94 = false

  for key5, value23 in pairs(p14) do
    if value23 == true then
      v94 = true
      break
    end
  end

  if not v94 then
    return {}
  end

  local v95 = false

  for key6, value24 in pairs(p15) do
    if value24 == true then
      v95 = true
      break
    end
  end

  if not v95 then
    return {}
  end

  local v96 = {}

  for index19, value25 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value25 then
      for index20, value26 in ipairs(value25:GetChildren()) do
        if value26:IsA("Tool") and value26:GetAttribute("IsFlower") then
          local flowerId = value26:GetAttribute("FlowerId")
          local modelAltId = value26:GetAttribute("ModelAltId") or "Normal"

          if p14[flowerId] == true and p15[modelAltId] == true then
            table.insert(v96, value26)
          end
        end
      end
    end
  end

  return v96
end

local function f24(p16, p17)
  local v97 = f2()

  if not v97 then
    return {}
  end

  local flowers2 = v97:FindFirstChild("Flowers")

  if not flowers2 then
    return {}
  end

  if type(p16) ~= "table" or type(p17) ~= "table" then
    return {}
  end

  local v98 = false

  for key7, value27 in pairs(p16) do
    if value27 == true then
      v98 = true
      break
    end
  end

  if not v98 then
    return {}
  end

  local v99 = false

  for key8, value28 in pairs(p17) do
    if value28 == true then
      v99 = true
      break
    end
  end

  if not v99 then
    return {}
  end

  local v100 = {}

  for index21, value29 in ipairs(flowers2:GetChildren()) do
    local hitbox = value29.Name == "Hitbox" and value29 or value29:FindFirstChild("Hitbox")

    if hitbox and hitbox:IsA("BasePart") then
      local flowerId2 = hitbox:GetAttribute("FlowerId")
      local modelAltId2 = hitbox:GetAttribute("ModelAltId") or "Normal"

      if p16[flowerId2] == true and p17[modelAltId2] == true then
        table.insert(v100, hitbox)
      end
    end
  end

  return v100
end

local function f25(p18)
  if p18 and p18 ~= localPlayer then
    pcall(function() localPlayer:RequestFriendship(p18) end)
  end
end

local function f26(p19, p20)
  local v101 = {}
  local character2 = localPlayer.Character
  local backpack = localPlayer:FindFirstChild("Backpack")

  local function f27(p21)
    if not p21 then
      return
    end

    for index22, value30 in ipairs(p21:GetChildren()) do
      if value30:IsA("Tool") then
        local uniqueId = value30:GetAttribute("UniqueId")
        local flowerId3 = value30:GetAttribute("FlowerId")
        local fertilizerId = value30:GetAttribute("FertilizerId")

        if uniqueId and flowerId3 and p19[flowerId3] == true then
          table.insert(v101, { type = "Flower", uniqueId = uniqueId })
        elseif fertilizerId and p20[fertilizerId] == true then
          table.insert(v101, { type = "Fertilizer", uniqueId = fertilizerId })
        end
      end
    end
  end

  f27(backpack)
  f27(character2)

  return v101
end

local function f28()
  local v102 = {}

  for index23, value31 in ipairs(game:GetService("Players"):GetPlayers()) do
    if value31 ~= localPlayer then
      table.insert(v102, value31.Name)
    end
  end

  if v1.Options.Dropdown_GiftTargetPlayer then
    v1.Options.Dropdown_GiftTargetPlayer:SetValues(v102)
  end

  if v1.Options.Dropdown_TargetLikePlayers then
    v1.Options.Dropdown_TargetLikePlayers:SetValues(v102)
  end
end

local function f29()
  if v5.Flags.IsExtractHoneyLoopRunning then
    return
  end

  if not v1.Options.Toggle_Garden_FarmAutoExtractHoney.Value then
    return
  end

  v5.Flags.IsExtractHoneyLoopRunning = true

  task.spawn(function()
    local remoteEvent2 = honeySystem:WaitForChild("HiveUtil"):WaitForChild("RemoteEvent")
    local remoteEvent3 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("FlowerTreeSystem"):WaitForChild("FlowerTreeUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_Garden_FarmAutoExtractHoney.Value do
      pcall(function()
        local v103 = f2()

        if not v103 then
          return
        end

        local hives = v103:FindFirstChild("Hives")

        if hives then
          local getChildren = hives:GetChildren()

          if #getChildren > 0 then
            remoteEvent2:FireServer("ExtractHoney", getChildren)
          end
        end

        task.spawn(function()
          pcall(function() remoteEvent3:FireServer("GetTreeHoney", "Tree1") end)
        end)

        task.spawn(function()
          pcall(function() remoteEvent3:FireServer("GetTreeHoney", "Tree2") end)
        end)
      end)

      task.wait(5)
    end

    v5.Flags.IsExtractHoneyLoopRunning = false
  end)
end

local function f30()
  if v5.Flags.IsSellHoneyLoopRunning then
    return
  end

  if not (v1.Options.Toggle_Garden_FarmAutoSellAllHoney.Value
    or v1.Options.Toggle_Garden_FarmAutoSellNormalHoney.Value) then
    return
  end

  v5.Flags.IsSellHoneyLoopRunning = true

  task.spawn(function()
    local remoteEvent4 = honeySystem:WaitForChild("HoneyUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded
      and (v1.Options.Toggle_Garden_FarmAutoSellAllHoney.Value
        or v1.Options.Toggle_Garden_FarmAutoSellNormalHoney.Value) do
      pcall(function()
        if v1.Options.Toggle_Garden_FarmAutoSellNormalHoney.Value then
          remoteEvent4:FireServer("SellHoney", "Honey")
        else
          remoteEvent4:FireServer("SellHoney")
        end
      end)

      task.wait(5)
    end

    v5.Flags.IsSellHoneyLoopRunning = false
  end)
end

local function f31()
  task.spawn(function()
    while not v1.Unloaded do
      if addParagraph2 then
        pcall(function()
          local v104 = f2()

          if not v104 then
            addParagraph2:SetValue("Plot unavailable")
            return
          end

          local flowers3 = v104:FindFirstChild("Flowers")

          if not flowers3 then
            addParagraph2:SetValue("No flowers folder found")
            return
          end

          local v105 = {}

          for index24, value32 in ipairs(flowers3:GetChildren()) do
            local flowerId4 = value32:GetAttribute("FlowerId")

            if flowerId4 then
              local modelAltId3 = value32:GetAttribute("ModelAltId") or "Normal"

              if not v105[flowerId4] then
                v105[flowerId4] = {}
              end

              v105[flowerId4][modelAltId3] = (v105[flowerId4][modelAltId3] or 0) + 1
            end
          end

          local text = ""
          local v106 = false
          local v107 = {}

          for key9, value33 in pairs(v105) do
            table.insert(v107, key9)
          end

          table.sort(v107)

          for index25, value34 in ipairs(v107) do
            local v108 = v105[value34]

            local name3 = v5.Data.FlowerRegistry[value34]
                and v5.Data.FlowerRegistry[value34].Name
              or value34

            local v109 = {}

            for key10, value35 in pairs(v108) do
              table.insert(v109, key10)
            end

            table.sort(v109)

            for index26, value36 in ipairs(v109) do
              local v110 = v108[value36]
              local v111 = ""

              if value36 ~= "Normal" then
                local v112 = "#FFFFFF"

                if value36 == "Gold" then
                  v112 = "#FFD700"
                elseif value36 == "Rainbow" then
                  v112 = "#FF00FF"
                elseif value36 == "Giant" then
                  v112 = "#00FFFF"
                end

                v111 = string.format(" <b><font color=\"%s\">(%s)</font></b>", v112, value36)
              end

              text = text .. string.format([[
- <b><font color="#00FFFF">%dx</font></b>   %s%s
]], v110, name3, v111)

              v106 = true
            end
          end

          if not v106 then
            addParagraph2:SetValue("Your garden is empty!")
          else
            addParagraph2:SetValue(text)
          end
        end)
      end

      task.wait(5)
    end
  end)
end

local function f32()
  task.spawn(function()
    while not v1.Unloaded do
      if addParagraph3 then
        pcall(function()
          if not f9() then
            addParagraph3:SetValue([[
<b><font color="#FF5252">[Queen Bee Tree Not Owned]</font></b>
Please go to <b>Shop -> GENERAL</b> and enable <b>Auto Buy Queen Bee Tree (Tree 1)</b> to unlock!]])

            return
          end

          local v113 = f2()

          if not v113 then
            addParagraph3:SetValue("Plot unavailable")
            return
          end

          local flowerTrees2 = v113:FindFirstChild("FlowerTrees")

          if not flowerTrees2 then
            addParagraph3:SetValue("No flower trees found")
            return
          end

          local getChildren2 = flowerTrees2:GetChildren()

          if #getChildren2 == 0 then
            addParagraph3:SetValue("No flower trees placed")
            return
          end

          table.sort(getChildren2, function(p22, p23) return p22.Name < p23.Name end)
          local v114 = {}

          for index27, value37 in ipairs(getChildren2) do
            local v115 = false

            repeat
              local treeConfiguration2 = value37:FindFirstChild("TreeConfiguration")

              if not (treeConfiguration2 and treeConfiguration2:GetAttribute("TreeLevel")
                  and tonumber(treeConfiguration2:GetAttribute("TreeLevel")) >= 1
                or value37:GetAttribute("TreeLevel")
                  and tonumber(value37:GetAttribute("TreeLevel")) >= 1) then
                table.insert(v114, string.format(
                  "<b><font color=\"#888888\">%s</font></b> ΓÇö <font color=\"#FF5252\">[Not Purchased]</font>",
                  value37.Name
                ))

                v115 = true
                break
              end

              local treeLevel2 = value37:GetAttribute("TreeLevel")
                or treeConfiguration2 and treeConfiguration2:GetAttribute("TreeLevel") or 1

              local treeExp = value37:GetAttribute("TreeExp")
                or treeConfiguration2 and treeConfiguration2:GetAttribute("TreeExp") or 0

              local honeyCount = value37:GetAttribute("HoneyCount")
                or treeConfiguration2 and treeConfiguration2:GetAttribute("HoneyCount") or 0

              local v116 = string.format(
                "<b><font color=\"#FFD700\">%s</font></b> ΓÇö Lv. %d (%s EXP) | Honey: %s",
                value37.Name, treeLevel2, f4(treeExp), f4(honeyCount)
              )

              table.insert(v114, v116)
              local flowerSlots2 = value37:FindFirstChild("FlowerSlots")

              for m = 1, treeLevel2 do
                local findFirstChild5 = flowerSlots2
                  and flowerSlots2:FindFirstChild("Slot_" .. m)

                local flowerId5 = findFirstChild5 and findFirstChild5:GetAttribute("FlowerId")

                if flowerId5 then
                  local name4 = v5.Data.FlowerRegistry[flowerId5]
                      and v5.Data.FlowerRegistry[flowerId5].Name
                    or flowerId5

                  local level = findFirstChild5:GetAttribute("Level") or 1
                  local exp = findFirstChild5:GetAttribute("Exp") or 0
                  local mutations2 = findFirstChild5:FindFirstChild("Mutations")
                  local v117 = {}

                  if mutations2 then
                    for index28, value38 in ipairs(mutations2:GetChildren()) do
                      table.insert(v117, value38.Name)
                    end
                  end

                  local v118 = ""

                  if #v117 > 0 then
                    local v119 = {}

                    for index29, value39 in ipairs(v117) do
                      local v120 = "#FFFFFF"

                      if value39 == "Gold" then
                        v120 = "#FFD700"
                      elseif value39 == "Rainbow" then
                        v120 = "#FF00FF"
                      elseif value39 == "Giant" then
                        v120 = "#00FFFF"
                      end

                      table.insert(v119, string.format(
                        "<b><font color=\"%s\">[%s]</font></b>", v120, value39
                      ))
                    end

                    v118 = " " .. table.concat(v119, " ")
                  end

                  table.insert(v114, string.format(
                    "  Slot %d: <b><font color=\"#00FFFF\">%s</font></b>%s (Lv. %d | %d EXP)",
                    m, name4, v118, level, exp
                  ))
                else
                  table.insert(v114, string.format(
                    "  Slot %d: <b><font color=\"#888888\">[Empty]</font></b>", m
                  ))
                end
              end

              v115 = true
            until true

            if not v115 then
              break
            end
          end

          if #v114 == 0 then
            addParagraph3:SetValue("No trees data")
          else
            addParagraph3:SetValue(table.concat(v114, "\n"))
          end
        end)
      end

      task.wait(5)
    end
  end)
end

local function f33()
  if v5.Flags.IsDepositEventHoneyLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoDepositEventHoney.Value then
    return
  end

  v5.Flags.IsDepositEventHoneyLoopRunning = true

  task.spawn(function()
    local remoteEvent5 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GameEvent"):WaitForChild("GameEventUtil"):WaitForChild("RemoteEvent")
    local dataUtil = require(replicatedStorage:WaitForChild("Framework")).Modules.DataUtil

    while not v1.Unloaded and v1.Options.Toggle_AutoDepositEventHoney.Value do
      pcall(function()
        local getPlayerData2 = dataUtil:GetPlayerData(localPlayer)

        local owned = getPlayerData2 and getPlayerData2.Honeys and getPlayerData2.Honeys.Owned
          or {}

        local v121 = {
          LightningHoney = "DepositLightningHoney",
          HalloweenHoney = "DepositHalloweenHoney",
          ChristmasHoney = "DepositChristmasHoney",
        }

        local gameEventConfig = replicatedStorage.Configs:FindFirstChild("GameEventConfig")

        if gameEventConfig then
          local v122, v123 = pcall(function() return require(gameEventConfig) end)

          if v122 and v123 and v123.HoneyName and v123.DepositCommand then
            v121[v123.HoneyName] = v123.DepositCommand
          end
        end

        for key11, value40 in pairs(v121) do
          if not v1.Options.Toggle_AutoDepositEventHoney.Value then
            break
          end

          if (owned[key11] or 0) > 0 then
            pcall(function() remoteEvent5:FireServer(value40) end)
            task.wait(0.5)
          end
        end
      end)

      task.wait(5)
    end

    v5.Flags.IsDepositEventHoneyLoopRunning = false
  end)
end

local function f34()
  if v5.Flags.IsClaimEventQuestLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoClaimEventQuest.Value then
    return
  end

  v5.Flags.IsClaimEventQuestLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_AutoClaimEventQuest.Value do
      pcall(function()
        for index30, value41 in ipairs((f16())) do
          if not v1.Options.Toggle_AutoClaimEventQuest.Value then
            break
          end

          local module = value41.Module
          local remote = value41.Remote

          for n = 1, 10 do
            if not v1.Options.Toggle_AutoClaimEventQuest.Value then
              break
            end

            local v124 = "Quest_" .. n
            local v125 = true

            if type(module.CanClaimQuestReward) == "function" then
              local v126, v127 = pcall(function()
                return module:CanClaimQuestReward(localPlayer, v124)
              end)

              if v126 and v127 == false then
                v125 = false
              end
            end

            local v128 = false

            if type(module.CkeckQuestCompleted) == "function" then
              local v129, v130 = pcall(function()
                return module:CkeckQuestCompleted(localPlayer, v124)
              end)

              if v129 and v130 == true then
                v128 = true
              end
            end

            if v125 and v128 then
              pcall(function() remote:FireServer("ClaimQuestReward", v124) end)
              task.wait(0.5)
            end
          end
        end
      end)

      task.wait(5)
    end

    v5.Flags.IsClaimEventQuestLoopRunning = false
  end)
end

local function f35()
  if v5.Flags.IsAutoFreeRefreshEventQuestsRunning then
    return
  end

  if not v1.Options.Toggle_AutoFreeRefreshEventQuests.Value then
    return
  end

  v5.Flags.IsAutoFreeRefreshEventQuestsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_AutoFreeRefreshEventQuests.Value do
      pcall(function()
        for index31, value42 in ipairs((f16())) do
          if not v1.Options.Toggle_AutoFreeRefreshEventQuests.Value then
            break
          end

          local module2 = value42.Module
          local remote2 = value42.Remote
          local v131 = false

          if type(module2.CheckAllQuestsCompleted) == "function" then
            local v132, v133 = pcall(function()
              return module2:CheckAllQuestsCompleted(localPlayer)
            end)

            if v132 and v133 == true then
              v131 = true
            end
          end

          local v134 = 0

          if type(module2.GetFreeRefreshCount) == "function" then
            local v135, v136 = pcall(function()
              return module2:GetFreeRefreshCount(localPlayer)
            end)

            if v135 and type(v136) == "number" then
              v134 = v136
            end
          end

          if v131 and v134 > 0 then
            pcall(function() remote2:FireServer("FreeRefreshDailyQuests") end)
            task.wait(1)
          end
        end
      end)

      task.wait(10)
    end

    v5.Flags.IsAutoFreeRefreshEventQuestsRunning = false
  end)
end

local function f36()
  if v5.Flags.IsAutoClaimOnlineEventPackRunning then
    return
  end

  if not v1.Options.Toggle_AutoClaimOnlineEventPack.Value then
    return
  end

  v5.Flags.IsAutoClaimOnlineEventPackRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_AutoClaimOnlineEventPack.Value do
      pcall(function()
        for index32, value43 in ipairs((f17())) do
          if not v1.Options.Toggle_AutoClaimOnlineEventPack.Value then
            break
          end

          local module3 = value43.Module
          local remote3 = value43.Remote
          local v137 = false

          if type(module3.GetPlayerOnlineData) == "function" then
            local v138, v139 = pcall(function()
              return module3:GetPlayerOnlineData(localPlayer)
            end)

            if v138 and type(v139) == "table" and v139.RewardPackCount
              and v139.RewardPackCount > 0 then
              v137 = true
            end
          end

          if v137 then
            pcall(function() remote3:FireServer("ClaimOnlineReward") end)
            task.wait(1)
          end
        end
      end)

      task.wait(15)
    end

    v5.Flags.IsAutoClaimOnlineEventPackRunning = false
  end)
end

local function f37()
  if v5.Flags.IsExchangeLotteryLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoExchangeLotteryTicket.Value then
    return
  end

  v5.Flags.IsExchangeLotteryLoopRunning = true

  task.spawn(function()
    local remoteEvent6 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GameEvent"):WaitForChild("GameEventUtil"):WaitForChild("RemoteEvent")
    local dataUtil2 = require(replicatedStorage:WaitForChild("Framework")).Modules.DataUtil

    while not v1.Unloaded and v1.Options.Toggle_AutoExchangeLotteryTicket.Value do
      pcall(function()
        local getPlayerData3 = dataUtil2:GetPlayerData(localPlayer)

        local lotteryTicket2Exchange = getPlayerData3 and getPlayerData3.Events
          and getPlayerData3.Events.LotteryTicket2Exchange

        local count2 = lotteryTicket2Exchange and lotteryTicket2Exchange.Count or 0

        local currency1 = getPlayerData3 and getPlayerData3.Currencies
            and getPlayerData3.Currencies.Currency1
          or 0

        if count2 < 5 and currency1 >= 10000000 then
          pcall(function() remoteEvent6:FireServer("ExchangeLotteryTicket2") end)
          task.wait(0.5)
        end
      end)

      task.wait(30)
    end

    v5.Flags.IsExchangeLotteryLoopRunning = false
  end)
end

local function f38()
  if v5.Flags.IsAutoFarmBambooCoinRunning then
    return
  end

  if not v1.Options.Toggle_AutoFarmBambooCoin.Value then
    return
  end

  v5.Flags.IsAutoFarmBambooCoinRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_AutoFarmBambooCoin.Value do
      pcall(function()
        local climbJumpArea = workspace:FindFirstChild("ClimbJumpArea")

        local topArea = climbJumpArea and climbJumpArea:FindFirstChild("TopPlatform")
          and climbJumpArea.TopPlatform:FindFirstChild("TopArea")

        local character3 = localPlayer.Character
        local humanoidRootPart2 = character3 and character3:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart2 and topArea then
          humanoidRootPart2.CFrame = topArea.CFrame + Vector3.new(0, 50, 0)
          task.wait(0.3)

          if v1.Options.Toggle_AutoFarmBambooCoin.Value and humanoidRootPart2 then
            local cframe = topArea.CFrame * CFrame.new(topArea.Size.X * 0.5 + 10, 10, 0)

            local create = tweenService:Create(
              humanoidRootPart2, TweenInfo.new(0.8, Enum.EasingStyle.Linear),
              { CFrame = cframe }
            )

            create:Play()
            create.Completed:Wait()
          end
        end
      end)

      task.wait(65)
    end

    v5.Flags.IsAutoFarmBambooCoinRunning = false
  end)
end

local function f39()
  if v5.Flags.IsAutoClaimBambooQuestsRunning then
    return
  end

  if not v1.Options.Toggle_AutoClaimBambooQuests.Value then
    return
  end

  v5.Flags.IsAutoClaimBambooQuestsRunning = true

  task.spawn(function()
    local remoteEvent7 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("ClimbJump"):WaitForChild("ClimbJumpUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoClaimBambooQuests.Value do
      pcall(function()
        remoteEvent7:FireServer("CJReach", "L4")
        remoteEvent7:FireServer("CJReach", "L6")

        for index33, value44 in ipairs({ "CJ_T1", "CJ_T2", "CJ_T3", "CJ_T4" }) do
          if not v1.Options.Toggle_AutoClaimBambooQuests.Value then
            break
          end

          remoteEvent7:FireServer("QuestClaim", value44)
          task.wait(0.2)
        end

        for index34, value45 in ipairs({ "L1", "L2", "L3", "L4", "L5", "L6" }) do
          if not v1.Options.Toggle_AutoClaimBambooQuests.Value then
            break
          end

          remoteEvent7:FireServer("CJClaim", value45)
          task.wait(0.2)
        end
      end)

      task.wait(15)
    end

    v5.Flags.IsAutoClaimBambooQuestsRunning = false
  end)
end

local function f40()
  if v5.Flags.IsSpinBambooWheelLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoSpinBambooWheel.Value then
    return
  end

  v5.Flags.IsSpinBambooWheelLoopRunning = true

  task.spawn(function()
    local remoteEvent8 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("ClimbJump"):WaitForChild("ClimbJumpUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoSpinBambooWheel.Value do
      pcall(function()
        remoteEvent8:FireServer("CJSpin", tonumber(v1.Options.Dropdown_BambooSpinAmount
              and v1.Options.Dropdown_BambooSpinAmount.Value
            or "1")
          or 1)
      end)

      task.wait(10)
    end

    v5.Flags.IsSpinBambooWheelLoopRunning = false
  end)
end

local function f41()
  if v5.Flags.IsAutoHoldTrainToolLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoHoldTrainTool.Value then
    return
  end

  v5.Flags.IsAutoHoldTrainToolLoopRunning = true

  task.spawn(function()
    local remoteEvent9 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("ClimbJump"):WaitForChild("ClimbJumpUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoHoldTrainTool.Value do
      pcall(function() remoteEvent9:FireServer("CJUseTrainTool") end)
      task.wait(5)
    end

    v5.Flags.IsAutoHoldTrainToolLoopRunning = false
  end)
end

local function f42()
  if v5.Flags.IsAutoRebirthBambooLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoRebirthBamboo.Value then
    return
  end

  v5.Flags.IsAutoRebirthBambooLoopRunning = true

  task.spawn(function()
    local remoteEvent10 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("ClimbJump"):WaitForChild("ClimbJumpUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoRebirthBamboo.Value do
      pcall(function()
        local rebirth = localPlayer:GetAttribute("Rebirth") or 0
        local cjStr = localPlayer:GetAttribute("CJStr") or 0
        local v140 = require(replicatedStorage:WaitForChild("Configs"):WaitForChild("ResClimbJumpRebirth"))
        local v141 = v140 and v140[rebirth + 1]

        if v141 and cjStr >= (v141.ReqSTR or math.huge) then
          remoteEvent10:FireServer("CJRebirth")
        end
      end)

      task.wait(5)
    end

    v5.Flags.IsAutoRebirthBambooLoopRunning = false
  end)
end

local function f43()
  if v5.Flags.IsAutoSpinGloryWheelRunning then
    return
  end

  if not v1.Options.Toggle_AutoSpinGloryWheel.Value then
    return
  end

  v5.Flags.IsAutoSpinGloryWheelRunning = true

  task.spawn(function()
    local gloryWheelRemote2 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GloryWheel"):WaitForChild("GloryWheelRemote")

    while not v1.Unloaded and v1.Options.Toggle_AutoSpinGloryWheel.Value do
      pcall(function()
        local v142 = tonumber(v1.Options.Dropdown_GlorySpinAmount
              and v1.Options.Dropdown_GlorySpinAmount.Value
            or "1")
          or 1

        if v142 ~= 10 then
          v142 = 1
        end

        local v143 = v142 == 10 and 1600 or 160

        if f12() >= v143 then
          gloryWheelRemote2:FireServer({ event = "draw", count = v142 })
        end
      end)

      task.wait(2)
    end

    v5.Flags.IsAutoSpinGloryWheelRunning = false
  end)
end

local function f44()
  if v5.Flags.IsAutoClaimGloryStageRunning then
    return
  end

  if not v1.Options.Toggle_AutoClaimGloryStage.Value then
    return
  end

  v5.Flags.IsAutoClaimGloryStageRunning = true

  task.spawn(function()
    local gloryWheelRemote3 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GloryWheel"):WaitForChild("GloryWheelRemote")

    if not v5.Cache.GloryWheelConn then
      v5.Cache.GloryWheelConn = gloryWheelRemote3.OnClientEvent:Connect(function(p24)
        if type(p24) == "table" and p24.state then
          v5.Cache.GloryWheelState = p24.state
        end
      end)
    end

    while not v1.Unloaded and v1.Options.Toggle_AutoClaimGloryStage.Value do
      pcall(function()
        gloryWheelRemote3:FireServer({ event = "getState" })
        task.wait(0.5)

        local v144 = {
          { Id = "Spin30", SpinReq = 30, TreasureIndex = 1 },
          { Id = "Spin80", SpinReq = 80, TreasureIndex = 2 },
          { Id = "Spin120", SpinReq = 120, TreasureIndex = 3 },
          { Id = "Spin200", SpinReq = 200, TreasureIndex = 4 },
        }

        local gloryWheelState = v5.Cache.GloryWheelState
        local progress = gloryWheelState and gloryWheelState.Progress
        local v145 = progress and tonumber(progress.StageSpinCount)
        local claimedStageIds = progress and progress.ClaimedStageIds
        local findFirstChild6 = nil

        pcall(function()
          local playerGui4 = localPlayer:FindFirstChild("PlayerGui")

          findFirstChild6 = playerGui4 and playerGui4:FindFirstChild("ScreenGloryShop", true) and playerGui4.ScreenGloryShop:FindFirstChild("Dialog", true) and playerGui4.ScreenGloryShop.Dialog:FindFirstChild("Wheel", true) and playerGui4.ScreenGloryShop.Dialog.Wheel:FindFirstChild(
            "StageRewards", true
          ) and playerGui4.ScreenGloryShop.Dialog.Wheel.StageRewards:FindFirstChild(
            "Frame", true
          )
        end)

        for index35, value46 in ipairs(v144) do
          if not v1.Options.Toggle_AutoClaimGloryStage.Value then
            break
          end

          local v146 = false

          if v145 ~= nil and claimedStageIds ~= nil then
            if not claimedStageIds[value46.Id] and v145 >= value46.SpinReq then
              v146 = true
            end
          elseif findFirstChild6 then
            local findFirstChild7 = findFirstChild6:FindFirstChild("Treasure"
              .. tostring(value46.TreasureIndex))

            local claim = findFirstChild7 and findFirstChild7:FindFirstChild("Claim")

            if claim and claim.Visible then
              v146 = true
            end
          end

          if v146 then
            gloryWheelRemote3:FireServer({ event = "claimStage", id = value46.Id })
            task.wait(0.5)
          end
        end
      end)

      task.wait(15)
    end

    v5.Flags.IsAutoClaimGloryStageRunning = false
  end)
end

local function f45()
  if v5.Flags.IsAutoExchangeGloryCrystalRunning then
    return
  end

  if not v1.Options.Toggle_AutoExchangeGloryCrystal.Value then
    return
  end

  v5.Flags.IsAutoExchangeGloryCrystalRunning = true

  task.spawn(function()
    local gloryWheelRemote4 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GloryWheel"):WaitForChild("GloryWheelRemote")

    while not v1.Unloaded and v1.Options.Toggle_AutoExchangeGloryCrystal.Value do
      pcall(function()
        local value47 = v1.Options.Dropdown_GloryExchangeFlower
          and v1.Options.Dropdown_GloryExchangeFlower.Value

        if type(value47) == "table" then
          for key12, value48 in pairs(value47) do
            if not v1.Options.Toggle_AutoExchangeGloryCrystal.Value then
              break
            end

            local v147 = value48 == true and key12 or value48

            if type(v147) == "string" and v147 ~= "" then
              local gloryExchangeOptionToId2 = v5.Data.GloryExchangeOptionToId
                and v5.Data.GloryExchangeOptionToId[v147]

              local gloryExchangeIdToData2 = gloryExchangeOptionToId2
                and v5.Data.GloryExchangeIdToData
                and v5.Data.GloryExchangeIdToData[gloryExchangeOptionToId2]

              if gloryExchangeOptionToId2 and gloryExchangeIdToData2 then
                local crystalReq = gloryExchangeIdToData2.CrystalReq or 1

                if f13() >= crystalReq then
                  gloryWheelRemote4:FireServer({
                    event = "exchange",
                    id = gloryExchangeOptionToId2,
                  })

                  task.wait(0.5)
                end
              end
            end
          end
        elseif type(value47) == "string" and value47 ~= "" then
          local gloryExchangeOptionToId3 = v5.Data.GloryExchangeOptionToId
            and v5.Data.GloryExchangeOptionToId[value47]

          local gloryExchangeIdToData3 = gloryExchangeOptionToId3
            and v5.Data.GloryExchangeIdToData
            and v5.Data.GloryExchangeIdToData[gloryExchangeOptionToId3]

          if gloryExchangeOptionToId3 and gloryExchangeIdToData3 then
            local crystalReq2 = gloryExchangeIdToData3.CrystalReq or 1

            if f13() >= crystalReq2 then
              gloryWheelRemote4:FireServer({ event = "exchange", id = gloryExchangeOptionToId3 })
            end
          end
        end
      end)

      task.wait(3)
    end

    v5.Flags.IsAutoExchangeGloryCrystalRunning = false
  end)
end

local function f46()
  task.spawn(function()
    while task.wait(2) do
      if v1.Unloaded then
        break
      end

      if addParagraph then
        local text2 = ""
        local findFirstChild8 = localPlayer:FindFirstChild("FlowerShopScript", true)

        if findFirstChild8 then
          text2 = text2 .. [[
=== FLOWERS ===
]]

          local v148 = false

          for index36, value49 in ipairs(v5.Data.FlowerNamesWithPrice) do
            local v149 = v5.Data.FlowerRegistry[value49]
            local findFirstChild9 = findFirstChild8:FindFirstChild(value49)
            local value50 = findFirstChild9 and findFirstChild9.Value or 0

            if value50 > 0 then
              local price = v149.Price or 0
              local v150 = price > 0 and " ($" .. f4(price) .. ")" or ""

              text2 = text2 .. string.format([[
- <b><font color="#00FF88">%dx</font></b>   %s   <font color="#FFD700">%s</font>
]], value50, v149.Name, v150)

              v148 = true
            end
          end

          if not v148 then
            text2 = text2 .. [[
- All flowers are out of stock!
]]
          end
        else
          text2 = text2 .. [[
- Flower shop data unavailable
]]
        end

        local findFirstChild10 = localPlayer:FindFirstChild("ToolShopScript", true)

        if findFirstChild10 then
          text2 = text2 .. "\n=== ITEMS & FERTILIZERS ===\n"
          local v151 = false

          for index37, value51 in ipairs(v5.Data.ItemNamesWithPrice) do
            local v152 = v5.Data.ItemRegistry[value51]
            local findFirstChild11 = findFirstChild10:FindFirstChild(value51)
            local value52 = findFirstChild11 and findFirstChild11.Value or 0

            if value52 > 0 then
              local price2 = v152.Price or 0
              local v153 = price2 > 0 and " ($" .. f4(price2) .. ")" or ""

              text2 = text2 .. string.format([[
- <b><font color="#00FF88">%dx</font></b>   %s   <font color="#FFD700">%s</font>
]], value52, v152.Name, v153)

              v151 = true
            end
          end

          if not v151 then
            text2 = text2 .. [[
- All items are out of stock!
]]
          end
        else
          text2 = text2 .. "\n=== ITEMS ===\n- Item shop data unavailable"
        end

        pcall(function() addParagraph:SetValue(text2) end)
      end
    end
  end)
end

local function f47()
  if v5.Flags.IsBuyFlowersLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoBuySelectedFlowers.Value then
    return
  end

  v5.Flags.IsBuyFlowersLoopRunning = true

  task.spawn(function()
    local remoteEvent11 = honeySystem:WaitForChild("FlowerUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoBuySelectedFlowers.Value do
      pcall(function()
        local findFirstChild12 = localPlayer:FindFirstChild("FlowerShopScript", true)

        if not findFirstChild12 then
          return
        end

        local v154 = {}
        local value53 = v1.Options.Dropdown_TargetFlowers.Value

        if type(value53) == "table" then
          for key13, value54 in pairs(value53) do
            if value54 == true then
              table.insert(v154, key13)
            end
          end
        end

        for index38, value55 in ipairs(v154) do
          if not v1.Options.Toggle_AutoBuySelectedFlowers.Value then
            break
          end

          local findFirstChild13 = findFirstChild12:FindFirstChild(value55)

          if (findFirstChild13 and tonumber(findFirstChild13.Value) or 0) > 0 then
            if f7(v5.Data.FlowerRegistry[value55] and v5.Data.FlowerRegistry[value55].Price or 0) then
              pcall(function() remoteEvent11:FireServer("BuyFlower", value55) end)
              task.wait(0.2)
            end
          end
        end
      end)

      task.wait(0.5)
    end

    v5.Flags.IsBuyFlowersLoopRunning = false
  end)
end

local function f48()
  if v5.Flags.IsBuyItemsLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoBuySelectedItems.Value then
    return
  end

  v5.Flags.IsBuyItemsLoopRunning = true

  task.spawn(function()
    local remoteEvent12 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("FlowerTreeSystem"):WaitForChild("TreeToolUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoBuySelectedItems.Value do
      pcall(function()
        local findFirstChild14 = localPlayer:FindFirstChild("ToolShopScript", true)

        if not findFirstChild14 then
          return
        end

        local v155 = {}
        local value56 = v1.Options.Dropdown_TargetItems.Value

        if type(value56) == "table" then
          for key14, value57 in pairs(value56) do
            if value57 == true then
              table.insert(v155, key14)
            end
          end
        end

        for index39, value58 in ipairs(v155) do
          if not v1.Options.Toggle_AutoBuySelectedItems.Value then
            break
          end

          local findFirstChild15 = findFirstChild14:FindFirstChild(value58)

          if (findFirstChild15 and tonumber(findFirstChild15.Value) or 0) > 0 then
            if f7(v5.Data.ItemRegistry[value58] and v5.Data.ItemRegistry[value58].Price or 0) then
              pcall(function() remoteEvent12:FireServer("BuyTreeFertilizer", value58) end)
              task.wait(0.2)
            end
          end
        end
      end)

      task.wait(0.5)
    end

    v5.Flags.IsBuyItemsLoopRunning = false
  end)
end

local function f49()
  if v5.Flags.IsAutoUpgradePlotLoopRunning then
    return
  end

  if not v1.Options.Toggle_Shop_AutoUpgradePlot.Value then
    return
  end

  v5.Flags.IsAutoUpgradePlotLoopRunning = true

  task.spawn(function()
    local remoteEvent13 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("PlotExtend"):WaitForChild("PlotExtendUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoUpgradePlot.Value do
      pcall(function()
        local v156 = f8()

        if v156 < #v8 then
          local v157 = v8[v156 + 1]

          if v157 and f7(v157) then
            remoteEvent13:FireServer("PurchaseExtend")
            task.wait(1)
          end
        end
      end)

      task.wait(3)
    end

    v5.Flags.IsAutoUpgradePlotLoopRunning = false
  end)
end

local function f50()
  if v5.Flags.IsAutoBuyQueenBeeTreeLoopRunning then
    return
  end

  if not v1.Options.Toggle_Shop_AutoBuyQueenBeeTree.Value then
    return
  end

  v5.Flags.IsAutoBuyQueenBeeTreeLoopRunning = true

  task.spawn(function()
    local remoteEvent14 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("FlowerTreeSystem"):WaitForChild("FlowerTreeUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoBuyQueenBeeTree.Value do
      pcall(function()
        if not f9() and f7(10000) then
          remoteEvent14:FireServer("BuyFlowerTree", "Tree1")
          task.wait(1)
        end
      end)

      task.wait(3)
    end

    v5.Flags.IsAutoBuyQueenBeeTreeLoopRunning = false
  end)
end

local function f51()
  if v5.Flags.IsAutoClaimOfflineRewardRunning then
    return
  end

  if not v1.Options.Toggle_Reward_AutoClaimOfflineReward.Value then
    return
  end

  v5.Flags.IsAutoClaimOfflineRewardRunning = true

  task.spawn(function()
    local remoteEvent15 = honeySystem:WaitForChild("HoneyUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimOfflineReward.Value do
      pcall(function() remoteEvent15:FireServer("GetOfflineReward") end)
      task.wait(15)
    end

    v5.Flags.IsAutoClaimOfflineRewardRunning = false
  end)
end

local function f52()
  if v5.Flags.IsAutoClaimHoneyJarRunning then
    return
  end

  if not v1.Options.Toggle_Reward_AutoClaimHoneyJar.Value then
    return
  end

  v5.Flags.IsAutoClaimHoneyJarRunning = true

  task.spawn(function()
    local remoteEvent16 = honeySystem:WaitForChild("HoneyUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimHoneyJar.Value do
      pcall(function() remoteEvent16:FireServer("RequestHoneyJar") end)
      task.wait(15)
    end

    v5.Flags.IsAutoClaimHoneyJarRunning = false
  end)
end

local function f53()
  if v5.Flags.IsSpawnBeeLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoSpawnBee.Value then
    return
  end

  v5.Flags.IsSpawnBeeLoopRunning = true

  task.spawn(function()
    local remoteEvent17 = honeySystem:WaitForChild("FlowerUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoSpawnBee.Value do
      pcall(function()
        local v158 = f2()

        if not v158 then
          return
        end

        local flowers4 = v158:FindFirstChild("Flowers")

        if not flowers4 then
          return
        end

        local v159 = {}

        for index40, value59 in ipairs(flowers4:GetChildren()) do
          local uniqueId2 = value59:GetAttribute("UniqueId")
          local beeId = value59:GetAttribute("BeeId")
          local growEndTime = value59:GetAttribute("GrowEndTime")
          local v160 = not growEndTime or workspace:GetServerTimeNow() >= growEndTime

          if uniqueId2 and (beeId == nil or beeId == 0 or beeId == "") and v160 then
            table.insert(v159, uniqueId2)
          end
        end

        for index41, value60 in ipairs(v159) do
          if not v1.Options.Toggle_AutoSpawnBee.Value then
            break
          end

          pcall(function() remoteEvent17:FireServer("SpawnFlowerBee", value60) end)
          task.wait(0.1)
        end
      end)

      task.wait(5)
    end

    v5.Flags.IsSpawnBeeLoopRunning = false
  end)
end

local function f54()
  if v5.Flags.IsAutoPlantSeedLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoPlantSeed.Value then
    return
  end

  v5.Flags.IsAutoPlantSeedLoopRunning = true

  task.spawn(function()
    local remoteFunction = honeySystem:WaitForChild("FlowerUtil"):WaitForChild("RemoteFunction")

    while not v1.Unloaded and v1.Options.Toggle_AutoPlantSeed.Value do
      local v161 = false

      repeat
        local character4 = localPlayer.Character

        if not character4 or not character4:FindFirstChild("HumanoidRootPart") then
          task.wait(1)
          v161 = true
          break
        end

        local v162 = f20(v1.Options.Dropdown_TargetPlantSeeds
          and v1.Options.Dropdown_TargetPlantSeeds.Value)

        if #v162 == 0 then
          task.wait(10)
          v161 = true
          break
        end

        pcall(function()
          local value61 = v1.Options.Dropdown_AutoPlantSeedPosMode
              and v1.Options.Dropdown_AutoPlantSeedPosMode.Value
            or "Random Pos"

          local v163 = f19(#v162, value61)

          for index42, value62 in ipairs(v162) do
            if not v1.Options.Toggle_AutoPlantSeed.Value then
              break
            end

            local flowerId6 = value62:GetAttribute("FlowerId")
            local v164 = v163[index42]

            if flowerId6 and v164 then
              pcall(function() remoteFunction:InvokeServer("PlaceFlower", flowerId6, v164) end)
              task.wait(0.08)
            end
          end
        end)

        task.wait(0.1)
        v161 = true
      until true

      if not v161 then
        break
      end
    end

    v5.Flags.IsAutoPlantSeedLoopRunning = false
  end)
end

local function f55()
  if v5.Flags.IsAutoPlaceFlowerLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoPlaceFlower.Value then
    return
  end

  v5.Flags.IsAutoPlaceFlowerLoopRunning = true

  task.spawn(function()
    local remoteFunction2 = honeySystem:WaitForChild("FlowerUtil"):WaitForChild("RemoteFunction")

    while not v1.Unloaded and v1.Options.Toggle_AutoPlaceFlower.Value do
      local v165 = false

      repeat
        local character5 = localPlayer.Character

        if not character5 or not character5:FindFirstChild("HumanoidRootPart") then
          task.wait(1)
          v165 = true
          break
        end

        local v166 = f23(v1.Options.Dropdown_TargetPlaceFlowers
          and v1.Options.Dropdown_TargetPlaceFlowers.Value, v1.Options.Dropdown_TargetPlaceMutations
          and v1.Options.Dropdown_TargetPlaceMutations.Value)

        if #v166 == 0 then
          task.wait(10)
          v165 = true
          break
        end

        pcall(function()
          local value63 = v1.Options.Dropdown_AutoPlaceFlowerPosMode
              and v1.Options.Dropdown_AutoPlaceFlowerPosMode.Value
            or "Random Pos"

          local v167 = f19(#v166, value63)

          for index43, value64 in ipairs(v166) do
            if not v1.Options.Toggle_AutoPlaceFlower.Value then
              break
            end

            local uniqueId3 = value64:GetAttribute("UniqueId")
            local v168 = v167[index43]

            if uniqueId3 and v168 then
              pcall(function() remoteFunction2:InvokeServer("MoveFlower", uniqueId3, v168) end)
              task.wait(0.08)
            end
          end
        end)

        task.wait(0.1)
        v165 = true
      until true

      if not v165 then
        break
      end
    end

    v5.Flags.IsAutoPlaceFlowerLoopRunning = false
  end)
end

local function f56()
  if v5.Flags.IsUseGrowthPotionLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoUseGrowthPotion.Value then
    return
  end

  v5.Flags.IsUseGrowthPotionLoopRunning = true

  task.spawn(function()
    local remoteEvent18 = honeySystem:WaitForChild("FlowerUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoUseGrowthPotion.Value do
      pcall(function()
        local flowerItemUtil = Framework.Modules.FlowerItemUtil

        if not flowerItemUtil then
          return
        end

        if flowerItemUtil:GetItemCount(localPlayer, "FlowerGrowthPotion") <= 0 then
          task.wait(2)
          return
        end

        local v169 = f2()

        if not v169 then
          return
        end

        local flowers5 = v169:FindFirstChild("Flowers")

        if not flowers5 then
          return
        end

        for index44, value65 in ipairs(flowers5:GetChildren()) do
          if not v1.Options.Toggle_AutoUseGrowthPotion.Value then
            break
          end

          local uniqueId4 = value65:GetAttribute("UniqueId")
          local growEndTime2 = value65:GetAttribute("GrowEndTime")

          if uniqueId4 and growEndTime2 and workspace:GetServerTimeNow() < growEndTime2 then
            pcall(function()
              remoteEvent18:FireServer("UseFlowerItem", uniqueId4, "FlowerGrowthPotion")
            end)

            task.wait(0.2)
          end
        end
      end)

      task.wait(2)
    end

    v5.Flags.IsUseGrowthPotionLoopRunning = false
  end)
end

local function f57()
  if v5.Flags.IsUpgradingTreeFlowers then
    f1("Queen Bee", "An upgrade task is already running!", 3)
    return
  end

  local value66 = v1.Options.Dropdown_Garden_TreeUpgradeMode
      and v1.Options.Dropdown_Garden_TreeUpgradeMode.Value
    or "None"

  v5.Flags.IsUpgradingTreeFlowers = true
  f1("Queen Bee", string.format("Starting upgrade with mode: %s...", value66), 3)

  task.spawn(function()
    pcall(function()
      local v170 = require(replicatedStorage:WaitForChild("Framework"))
      local flowerUtil = v170.Modules.FlowerUtil
      local remoteEvent19 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("FlowerTreeSystem"):WaitForChild("FlowerTreeUtil"):WaitForChild("RemoteEvent")
      local id = "FairyElixirI"
      local v171 = nil

      if value66 == "Golden" then
        id = "FairyElixirII"
        v171 = "Gold"
      elseif value66 == "Giant" then
        id = "FairyElixirIII"
        v171 = "Giant"
      elseif value66 == "Rainbow" then
        id = "FairyElixirIV"
        v171 = "Rainbow"
      end

      local getPlayerPlot = f2()

      if not getPlayerPlot and v170.Modules.PlotsUtil then
        pcall(function() getPlayerPlot = v170.Modules.PlotsUtil:GetPlayerPlot(localPlayer) end)
      end

      if not getPlayerPlot then
        return
      end

      local flowerTrees3 = getPlayerPlot:FindFirstChild("FlowerTrees")

      if not flowerTrees3 then
        return
      end

      local getChildren3 = flowerTrees3:GetChildren()
      table.sort(getChildren3, function(p25, p26) return p25.Name < p26.Name end)

      for index45, value67 in ipairs(getChildren3) do
        local v172 = false

        repeat
          local treeConfiguration3 = value67:FindFirstChild("TreeConfiguration")

          local treeLevel3 = treeConfiguration3 and treeConfiguration3:GetAttribute("TreeLevel")
            or value67:GetAttribute("TreeLevel")

          treeLevel3 = treeLevel3 and tonumber(treeLevel3)

          if not treeLevel3 or treeLevel3 < 1 then
            v172 = true
            break
          end

          local flowerSlots3 = value67:FindFirstChild("FlowerSlots")

          if not flowerSlots3 then
            v172 = true
            break
          end

          for index46, value68 in ipairs(flowerSlots3:GetChildren()) do
            local v173 = false

            repeat
              if v1.Unloaded then
                break
              end

              local flowerId7 = value68:GetAttribute("FlowerId")

              if flowerId7 == nil then
                v173 = true
                break
              end

              local count3 = 0

              while not v1.Unloaded and count3 < 35 do
                count3 = count3 + 1
                local level2 = value68:GetAttribute("Level") or 1
                local exp2 = value68:GetAttribute("Exp") or 0
                local mutations3 = value68:FindFirstChild("Mutations")
                local v174 = {}

                if mutations3 then
                  for index47, value69 in ipairs(mutations3:GetChildren()) do
                    table.insert(v174, value69.Name)
                  end
                end

                local v175 = {}

                for index48, value70 in ipairs(v174) do
                  v175[value70] = {}
                end

                local v176 = 300

                pcall(function()
                  local getTreeFlowerExpList = flowerUtil:GetTreeFlowerExpList(flowerId7, v175)

                  if type(getTreeFlowerExpList) == "table" and #getTreeFlowerExpList > 0 then
                    v176 = getTreeFlowerExpList[#getTreeFlowerExpList]
                  end
                end)

                local v177 = true

                if v171 then
                  v177 = mutations3 ~= nil and mutations3:FindFirstChild(v171) ~= nil
                end

                if level2 >= 3 and exp2 >= v176 and v177 then
                  break
                end

                remoteEvent19:FireServer("FeedTreeFlower", value67.Name, value68.Name, {
                  IsFertilizer = true,
                  Id = id,
                })

                task.wait(0.05)
              end

              v173 = true
            until true

            if not v173 then
              break
            end
          end

          v172 = true
        until true

        if not v172 then
          break
        end
      end
    end)

    v5.Flags.IsUpgradingTreeFlowers = false
    f1("Queen Bee", "All flowers upgraded successfully!", 4)
  end)
end

local function f58()
  if v5.Flags.IsAutoFeedTreeFertilizerLoopRunning then
    return
  end

  if not (v1.Options.Toggle_Garden_AutoFeedTreeFertilizer
    and v1.Options.Toggle_Garden_AutoFeedTreeFertilizer.Value) then
    return
  end

  v5.Flags.IsAutoFeedTreeFertilizerLoopRunning = true

  task.spawn(function()
    local remoteEvent20 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("FlowerTreeSystem"):WaitForChild("FlowerTreeUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_Garden_AutoFeedTreeFertilizer
      and v1.Options.Toggle_Garden_AutoFeedTreeFertilizer.Value do
      pcall(function()
        if not f22() then
          return
        end

        local v178 = f2()

        if not v178 then
          return
        end

        local flowerTrees4 = v178:FindFirstChild("FlowerTrees")

        if not flowerTrees4 then
          return
        end

        local getChildren4 = flowerTrees4:GetChildren()
        table.sort(getChildren4, function(p27, p28) return p27.Name < p28.Name end)

        for index49, value71 in ipairs(getChildren4) do
          local v179 = false

          repeat
            if not (v1.Options.Toggle_Garden_AutoFeedTreeFertilizer
              and v1.Options.Toggle_Garden_AutoFeedTreeFertilizer.Value) then
              break
            end

            local treeConfiguration4 = value71:FindFirstChild("TreeConfiguration")

            local treeLevel4 = treeConfiguration4
                and treeConfiguration4:GetAttribute("TreeLevel")
              or value71:GetAttribute("TreeLevel")

            treeLevel4 = treeLevel4 and tonumber(treeLevel4)

            if not treeLevel4 or treeLevel4 < 1 then
              v179 = true
              break
            end

            if treeLevel4 < 24 then
              pcall(function() remoteEvent20:FireServer("FeedTreeFertilizer", value71.Name) end)
              task.wait(0.5)
            end

            v179 = true
          until true

          if not v179 then
            break
          end
        end
      end)

      task.wait(4)
    end

    v5.Flags.IsAutoFeedTreeFertilizerLoopRunning = false
  end)
end

local function f59()
  if v5.Flags.IsAutoPlantTreeFlowersLoopRunning then
    return
  end

  if not (v1.Options.Toggle_QueenBee_AutoPlantFlowers
    and v1.Options.Toggle_QueenBee_AutoPlantFlowers.Value) then
    return
  end

  v5.Flags.IsAutoPlantTreeFlowersLoopRunning = true

  task.spawn(function()
    local remoteEvent21 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("FlowerTreeSystem"):WaitForChild("FlowerTreeUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_QueenBee_AutoPlantFlowers
      and v1.Options.Toggle_QueenBee_AutoPlantFlowers.Value do
      pcall(function()
        local v180 = f23(v1.Options.Dropdown_QueenBee_TargetFlowers
          and v1.Options.Dropdown_QueenBee_TargetFlowers.Value, v1.Options.Dropdown_QueenBee_TargetMutations
          and v1.Options.Dropdown_QueenBee_TargetMutations.Value)

        if #v180 == 0 then
          return
        end

        local v181 = f2()

        if not v181 then
          return
        end

        local flowerTrees5 = v181:FindFirstChild("FlowerTrees")

        if not flowerTrees5 then
          return
        end

        local getChildren5 = flowerTrees5:GetChildren()
        table.sort(getChildren5, function(p29, p30) return p29.Name < p30.Name end)

        for index50, value72 in ipairs(getChildren5) do
          local v182 = false

          repeat
            if not (v1.Options.Toggle_QueenBee_AutoPlantFlowers
              and v1.Options.Toggle_QueenBee_AutoPlantFlowers.Value) then
              break
            end

            if #v180 == 0 then
              break
            end

            local treeConfiguration5 = value72:FindFirstChild("TreeConfiguration")

            local treeLevel5 = treeConfiguration5
                and treeConfiguration5:GetAttribute("TreeLevel")
              or value72:GetAttribute("TreeLevel")

            treeLevel5 = treeLevel5 and tonumber(treeLevel5)

            if not treeLevel5 or treeLevel5 < 1 then
              v182 = true
              break
            end

            local flowerSlots4 = value72:FindFirstChild("FlowerSlots")

            for i6 = 1, treeLevel5 do
              if not (v1.Options.Toggle_QueenBee_AutoPlantFlowers
                and v1.Options.Toggle_QueenBee_AutoPlantFlowers.Value) then
                break
              end

              if #v180 == 0 then
                break
              end

              local v183 = "Slot_" .. i6
              local findFirstChild16 = flowerSlots4 and flowerSlots4:FindFirstChild(v183)

              if not (findFirstChild16 and findFirstChild16:GetAttribute("FlowerId") ~= nil) then
                local v184 = table.remove(v180, 1)

                if v184 and v184.Parent then
                  local uniqueId5 = v184:GetAttribute("UniqueId")

                  if uniqueId5 then
                    pcall(function()
                      remoteEvent21:FireServer(
                        "GiveFlowerToTree", value72.Name, v183, uniqueId5
                      )
                    end)

                    task.wait(0.25)
                  end
                end
              end
            end

            v182 = true
          until true

          if not v182 then
            break
          end
        end
      end)

      task.wait(3)
    end

    v5.Flags.IsAutoPlantTreeFlowersLoopRunning = false
  end)
end

local function f60()
  if v5.Flags.IsAutoRemoveTreeFlowersLoopRunning then
    return
  end

  if not (v1.Options.Toggle_QueenBee_AutoRemoveFlowers
    and v1.Options.Toggle_QueenBee_AutoRemoveFlowers.Value) then
    return
  end

  v5.Flags.IsAutoRemoveTreeFlowersLoopRunning = true

  task.spawn(function()
    local remoteEvent22 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("FlowerTreeSystem"):WaitForChild("FlowerTreeUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_QueenBee_AutoRemoveFlowers
      and v1.Options.Toggle_QueenBee_AutoRemoveFlowers.Value do
      pcall(function()
        local value73 = v1.Options.Dropdown_QueenBee_TargetFlowers
          and v1.Options.Dropdown_QueenBee_TargetFlowers.Value

        local value74 = v1.Options.Dropdown_QueenBee_TargetMutations
          and v1.Options.Dropdown_QueenBee_TargetMutations.Value

        if type(value73) ~= "table" or type(value74) ~= "table" then
          return
        end

        local v185 = false

        for key15, value75 in pairs(value73) do
          if value75 == true then
            v185 = true
            break
          end
        end

        if not v185 then
          return
        end

        local v186 = false

        for key16, value76 in pairs(value74) do
          if value76 == true then
            v186 = true
            break
          end
        end

        if not v186 then
          return
        end

        local v187 = f2()

        if not v187 then
          return
        end

        local flowerTrees6 = v187:FindFirstChild("FlowerTrees")

        if not flowerTrees6 then
          return
        end

        local getChildren6 = flowerTrees6:GetChildren()
        table.sort(getChildren6, function(p31, p32) return p31.Name < p32.Name end)

        for index51, value77 in ipairs(getChildren6) do
          local v188 = false

          repeat
            if not (v1.Options.Toggle_QueenBee_AutoRemoveFlowers
              and v1.Options.Toggle_QueenBee_AutoRemoveFlowers.Value) then
              break
            end

            local treeConfiguration6 = value77:FindFirstChild("TreeConfiguration")

            local treeLevel6 = treeConfiguration6
                and treeConfiguration6:GetAttribute("TreeLevel")
              or value77:GetAttribute("TreeLevel")

            treeLevel6 = treeLevel6 and tonumber(treeLevel6)

            if not treeLevel6 or treeLevel6 < 1 then
              v188 = true
              break
            end

            local flowerSlots5 = value77:FindFirstChild("FlowerSlots")

            if not flowerSlots5 then
              v188 = true
              break
            end

            for index52, value78 in ipairs(flowerSlots5:GetChildren()) do
              local v189 = false

              repeat
                if not (v1.Options.Toggle_QueenBee_AutoRemoveFlowers
                  and v1.Options.Toggle_QueenBee_AutoRemoveFlowers.Value) then
                  break
                end

                local flowerId8 = value78:GetAttribute("FlowerId")

                if not flowerId8 or value73[flowerId8] ~= true then
                  v189 = true
                  break
                end

                local mutations4 = value78:FindFirstChild("Mutations")
                local v190 = false

                if mutations4 and #mutations4:GetChildren() > 0 then
                  for index53, value79 in ipairs(mutations4:GetChildren()) do
                    if value74[value79.Name] == true then
                      v190 = true
                      break
                    end
                  end
                elseif value74.Normal == true then
                  v190 = true
                end

                if v190 then
                  pcall(function()
                    remoteEvent22:FireServer("RemoveTreeFlower", value77.Name, value78.Name)
                  end)

                  task.wait(0.25)
                end

                v189 = true
              until true

              if not v189 then
                break
              end
            end

            v188 = true
          until true

          if not v188 then
            break
          end
        end
      end)

      task.wait(3)
    end

    v5.Flags.IsAutoRemoveTreeFlowersLoopRunning = false
  end)
end

local function f61()
  if v5.Flags.IsAutoPickupFlowersLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoPickupSelectedFlowers.Value then
    return
  end

  v5.Flags.IsAutoPickupFlowersLoopRunning = true

  task.spawn(function()
    local remoteFunction3 = honeySystem:WaitForChild("FlowerUtil"):WaitForChild("RemoteFunction")

    while not v1.Unloaded and v1.Options.Toggle_AutoPickupSelectedFlowers.Value do
      local v191 = false

      repeat
        if f21() >= 60 then
          task.wait(10)
          v191 = true
          break
        end

        local v192 = f24(v1.Options.Dropdown_TargetRemovePickupFlowers
          and v1.Options.Dropdown_TargetRemovePickupFlowers.Value, v1.Options.Dropdown_TargetRemovePickupMutations
          and v1.Options.Dropdown_TargetRemovePickupMutations.Value)

        if #v192 == 0 then
          task.wait(10)
          v191 = true
          break
        end

        for index54, value80 in ipairs(v192) do
          if not v1.Options.Toggle_AutoPickupSelectedFlowers.Value then
            break
          end

          if f21() >= 60 then
            break
          end

          local growEndTime3 = value80:GetAttribute("GrowEndTime")

          if not growEndTime3 or workspace:GetServerTimeNow() >= growEndTime3 then
            pcall(function() remoteFunction3:InvokeServer("TakeGrownFlower", value80) end)
            task.wait(0.05)
          end
        end

        task.wait(0.1)
        v191 = true
      until true

      if not v191 then
        break
      end
    end

    v5.Flags.IsAutoPickupFlowersLoopRunning = false
  end)
end

local function f62()
  if v5.Flags.IsAutoRemoveFlowersLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoRemoveSelectedFlowers.Value then
    return
  end

  v5.Flags.IsAutoRemoveFlowersLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_AutoRemoveSelectedFlowers.Value do
      local v193 = false

      repeat
        local v194 = f24(v1.Options.Dropdown_TargetRemovePickupFlowers
          and v1.Options.Dropdown_TargetRemovePickupFlowers.Value, v1.Options.Dropdown_TargetRemovePickupMutations
          and v1.Options.Dropdown_TargetRemovePickupMutations.Value)

        if #v194 == 0 then
          task.wait(10)
          v193 = true
          break
        end

        local character6 = localPlayer.Character

        local deleteTOOL = character6 and character6:FindFirstChild("[DELETE TOOL]")
          or localPlayer.Backpack:FindFirstChild("[DELETE TOOL]")

        if deleteTOOL then
          local remoteEvent23 = deleteTOOL:FindFirstChild("RemoteEvent")

          if remoteEvent23 then
            for index55, value81 in ipairs(v194) do
              if not v1.Options.Toggle_AutoRemoveSelectedFlowers.Value then
                break
              end

              pcall(function() remoteEvent23:FireServer("Remove", value81) end)
              task.wait(0.05)
            end
          end
        end

        task.wait(0.1)
        v193 = true
      until true

      if not v193 then
        break
      end
    end

    v5.Flags.IsAutoRemoveFlowersLoopRunning = false
  end)
end

local function f63()
  if v5.Flags.IsCollectSeasonPassLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoCollectSeasonPass.Value then
    return
  end

  v5.Flags.IsCollectSeasonPassLoopRunning = true

  task.spawn(function()
    local remoteEvent24 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("SeasonSystem"):WaitForChild("SeasonUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoCollectSeasonPass.Value do
      pcall(function()
        for i7 = 1, 50 do
          if not v1.Options.Toggle_AutoCollectSeasonPass.Value then
            break
          end

          remoteEvent24:FireServer("Claim", i7)
          remoteEvent24:FireServer("ClaimAdv", i7)

          task.wait(0.1)
        end
      end)

      task.wait(15)
    end

    v5.Flags.IsCollectSeasonPassLoopRunning = false
  end)
end

local function f64()
  if v5.Flags.IsSpinSeasonLotteryLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoSpinSeasonLottery.Value then
    return
  end

  v5.Flags.IsSpinSeasonLotteryLoopRunning = true

  task.spawn(function()
    local lootRE = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("LotterySystem"):WaitForChild("LootServiceUtil"):WaitForChild("LootRE")

    while not v1.Unloaded and v1.Options.Toggle_AutoSpinSeasonLottery.Value do
      pcall(function()
        lootRE:FireServer(
          "TrySeasonLottery", tonumber(v1.Options.Dropdown_SpinAmount.Value) or 1
        )
      end)

      task.wait(1.5)
    end

    v5.Flags.IsSpinSeasonLotteryLoopRunning = false
  end)
end

local function f65()
  if v5.Flags.IsSpinBloomingLotteryLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoSpinBloomingLottery.Value then
    return
  end

  v5.Flags.IsSpinBloomingLotteryLoopRunning = true

  task.spawn(function()
    local lootRE2 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("LotterySystem"):WaitForChild("LootServiceUtil"):WaitForChild("LootRE")

    while not v1.Unloaded and v1.Options.Toggle_AutoSpinBloomingLottery.Value do
      pcall(function()
        lootRE2:FireServer(
          "TrySeasonLottery2", tonumber(v1.Options.Dropdown_SpinAmount.Value) or 1
        )
      end)

      task.wait(1.5)
    end

    v5.Flags.IsSpinBloomingLotteryLoopRunning = false
  end)
end

local function f66()
  local v195, v196 = pcall(function()
    return require(replicatedStorage:WaitForChild("Framework"))
  end)

  if not v195 or not v196 or not v196.Modules or not v196.Modules.DataUtil then
    return nil
  end

  local getPlayerData4 = v196.Modules.DataUtil:GetPlayerData(localPlayer)
  return getPlayerData4 and getPlayerData4.DailyOnlineGift
end

local function f67()
  if v5.Flags.IsAutoClaimPlaytimeRewardRunning then
    return
  end

  if not v1.Options.Toggle_Reward_AutoClaimPlaytimeRewards.Value then
    return
  end

  v5.Flags.IsAutoClaimPlaytimeRewardRunning = true

  task.spawn(function()
    local dailyOnlineGiftRE = replicatedStorage:WaitForChild("Remotes"):WaitForChild("DailyOnlineGiftRE")

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimPlaytimeRewards.Value do
      pcall(function()
        local v197 = f66()

        if v197 then
          local v198 = tonumber(v197.Elapsed) or 0
          local claimed = v197.Claimed or {}

          for index56, value82 in ipairs(v5.Data.OnlineRewards) do
            local v199 = false

            repeat
              if not v1.Options.Toggle_Reward_AutoClaimPlaytimeRewards.Value then
                break
              end

              if claimed[tostring(value82.Id)] then
                v199 = true
                break
              end

              if v198 < value82.RequiredDuration then
                v199 = true
                break
              end

              dailyOnlineGiftRE:FireServer("Online", value82.Id)
              task.wait(0.5)
              v199 = true
            until true

            if not v199 then
              break
            end
          end
        end
      end)

      task.wait(5)
    end

    v5.Flags.IsAutoClaimPlaytimeRewardRunning = false
  end)
end

local function f68()
  if v5.Flags.IsAutoClaimDailyLoginRunning then
    return
  end

  if not v1.Options.Toggle_Reward_AutoClaimDailyLogin.Value then
    return
  end

  v5.Flags.IsAutoClaimDailyLoginRunning = true

  task.spawn(function()
    local dailyOnlineGiftRE2 = replicatedStorage:WaitForChild("Remotes"):WaitForChild("DailyOnlineGiftRE")

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimDailyLogin.Value do
      pcall(function()
        local v200 = f66()

        if v200 and not v200.LoginClaimed then
          dailyOnlineGiftRE2:FireServer("Login", nil)
        end
      end)

      task.wait(10)
    end

    v5.Flags.IsAutoClaimDailyLoginRunning = false
  end)
end

local function f69()
  if v5.Flags.IsAutoClaimDailyLootRunning then
    return
  end

  if not v1.Options.Toggle_Reward_AutoClaimDailyLoot.Value then
    return
  end

  v5.Flags.IsAutoClaimDailyLootRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimDailyLoot.Value do
      pcall(function()
        local features = replicatedStorage:FindFirstChild("Framework")
          and replicatedStorage.Framework:FindFirstChild("Features")

        local daySystem = features and features:FindFirstChild("DaySystem")
        local dailyLootUtil = daySystem and daySystem:FindFirstChild("DailyLootUtil")
        local remoteEvent25 = dailyLootUtil and dailyLootUtil:FindFirstChild("RemoteEvent")

        if remoteEvent25 then
          remoteEvent25:FireServer("ClaimReward")
        end
      end)

      task.wait(10)
    end

    v5.Flags.IsAutoClaimDailyLootRunning = false
  end)
end

local function f70()
  if v5.Flags.IsAutoClaimFreeLoopPackRunning then
    return
  end

  if not v1.Options.Toggle_Reward_AutoClaimFreeLoopPack.Value then
    return
  end

  v5.Flags.IsAutoClaimFreeLoopPackRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimFreeLoopPack.Value do
      pcall(function()
        local features2 = replicatedStorage:FindFirstChild("Framework")
          and replicatedStorage.Framework:FindFirstChild("Features")

        local loopPack = features2 and features2:FindFirstChild("LoopPack")
        local loopPackRE = loopPack and loopPack:FindFirstChild("LoopPackRE")

        if loopPackRE then
          local v201, v202 = pcall(function()
            return require(replicatedStorage:WaitForChild("Framework"))
          end)

          local getPlayerData5 = v201 and v202 and v202.Modules and v202.Modules.DataUtil
            and v202.Modules.DataUtil:GetPlayerData(localPlayer)

          local v203, v204 = pcall(function()
            return require(replicatedStorage:WaitForChild("Configs"):WaitForChild("ResLoopPack"))
          end)

          if getPlayerData5 and v203 and v204 then
            local time = replicatedStorage:FindFirstChild("Time")
            local date = time and time:GetAttribute("Date")
            local loopPackFlag = getPlayerData5.LoopPackFlag or {}
            local foreverPDate = loopPackFlag.ForeverPDate
            local foreverPIndex = loopPackFlag.ForeverPIndex
            local v205 = 1

            if foreverPDate and foreverPIndex and foreverPDate == date then
              v205 = foreverPIndex + 1
            end

            local v206 = v204[v205]

            if v206 and v206.IsFree then
              loopPackRE:FireServer("ForeverPack", v205)
            end
          end
        end
      end)

      task.wait(10)
    end

    v5.Flags.IsAutoClaimFreeLoopPackRunning = false
  end)
end

local function f71()
  local playerGui5 = localPlayer:FindFirstChild("PlayerGui")
    or localPlayer:WaitForChild("PlayerGui", 10)

  if not playerGui5 then
    return
  end

  task.spawn(function()
    local lootResultShow = playerGui5:FindFirstChild("LootResultShow")
      or playerGui5:WaitForChild("LootResultShow", 10)

    local lootResult = lootResultShow
      and (lootResultShow:FindFirstChild("LootResult")
        or lootResultShow:WaitForChild("LootResult", 5))

    if lootResult and not v5.Cache.LootResultConn then
      v5.Cache.LootResultConn = lootResult:GetPropertyChangedSignal("Visible"):Connect(function()
        local isAutoClaimPlaytimeRewardRunning = v5.Flags.IsAutoClaimPlaytimeRewardRunning
          or v5.Flags.IsAutoClaimDailyLoginRunning

        if lootResult.Visible and isAutoClaimPlaytimeRewardRunning then
          task.delay(3, function()
            local isAutoClaimPlaytimeRewardRunning2 = v5.Flags.IsAutoClaimPlaytimeRewardRunning
              or v5.Flags.IsAutoClaimDailyLoginRunning

            if not v1.Unloaded and lootResult and lootResult.Visible
              and isAutoClaimPlaytimeRewardRunning2 then
              lootResult.Visible = false
              local lootRollStage = lootResult:FindFirstChild("LootRollStage")

              if lootRollStage then
                lootRollStage.Visible = false
              end

              local more = lootResult:FindFirstChild("More")

              if more then
                more.Visible = false
              end

              local few = lootResult:FindFirstChild("Few")

              if few then
                few.Visible = false
              end
            end
          end)
        end
      end)
    end
  end)

  task.spawn(function()
    local screenPlaytimeRewards = playerGui5:FindFirstChild("ScreenPlaytimeRewards")
      or playerGui5:WaitForChild("ScreenPlaytimeRewards", 10)

    if screenPlaytimeRewards and not v5.Cache.PlaytimeRewardGuiConn then
      v5.Cache.PlaytimeRewardGuiConn = screenPlaytimeRewards:GetPropertyChangedSignal("Enabled"):Connect(function()
        local isAutoClaimPlaytimeRewardRunning3 = v5.Flags.IsAutoClaimPlaytimeRewardRunning
          or v5.Flags.IsAutoClaimDailyLoginRunning

        if screenPlaytimeRewards.Enabled and isAutoClaimPlaytimeRewardRunning3 then
          task.delay(3, function()
            local isAutoClaimPlaytimeRewardRunning4 = v5.Flags.IsAutoClaimPlaytimeRewardRunning
              or v5.Flags.IsAutoClaimDailyLoginRunning

            if not v1.Unloaded and screenPlaytimeRewards and screenPlaytimeRewards.Enabled
              and isAutoClaimPlaytimeRewardRunning4 then
              screenPlaytimeRewards.Enabled = false
              local window = screenPlaytimeRewards:FindFirstChild("Window")

              if window then
                window.Visible = false
              end
            end
          end)
        end
      end)
    end
  end)
end

local function f72(p33)
  local playerGui6 = localPlayer:FindFirstChild("PlayerGui")

  if playerGui6 then
    local notifications = playerGui6:FindFirstChild("Notifications")

    if notifications then
      notifications.Enabled = not p33
    end
  end

  if v5.Cache.OriginalWorldWarn then
    local originalWorldWarn = v5.Cache.OriginalWorldWarn

    if typeof(originalWorldWarn) == "RBXScriptConnection" then
      originalWorldWarn:Disconnect()
    end

    v5.Cache.OriginalWorldWarn = nil
  end

  if p33 then
    v5.Cache.OriginalWorldWarn = workspace.Terrain.ChildAdded:Connect(function(child)
      if child:IsA("Attachment") then
        task.wait()
        child:Destroy()
      end
    end)
  end

  pcall(function()
    local guiWarnings = game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Systems"):WaitForChild("GUILib"):WaitForChild("Client"):WaitForChild("Classes"):WaitForChild("GUIWarnings")
    local errorSound = guiWarnings:FindFirstChild("ErrorSound")
    local notificationSound = guiWarnings:FindFirstChild("NotificationSound")

    if errorSound then
      errorSound.Volume = p33 and 0 or 0.3
    end

    if notificationSound then
      notificationSound.Volume = p33 and 0 or 0.3
    end
  end)
end

local function f73(p34)
  local playerGui7 = localPlayer:FindFirstChild("PlayerGui")

  if playerGui7 then
    local hud = playerGui7:FindFirstChild("HUD")

    if hud then
      local right = hud:FindFirstChild("Right")
      local buffFrame = hud:FindFirstChild("BuffFrame")
      local buttonFrame = hud:FindFirstChild("ButtonFrame")

      if right then
        right.Visible = not p34
      end

      if buffFrame then
        buffFrame.Visible = not p34
      end

      if buttonFrame then
        buttonFrame.Visible = not p34
      end
    end

    local robuxBackground = playerGui7:FindFirstChild("RobuxBackground")

    if robuxBackground then
      local frame = robuxBackground:FindFirstChild("Frame")

      if frame then
        frame.Visible = not p34
      end
    end
  end
end

local function f74(p35)
  local hiddenPlots = game.Lighting:FindFirstChild("HiddenPlots")

  if not p35 then
    if hiddenPlots then
      local plots2 = workspace:FindFirstChild("Plots")

      if plots2 then
        for index57, value83 in ipairs(hiddenPlots:GetChildren()) do
          value83.Parent = plots2
        end
      end
    end

    return
  end

  if not hiddenPlots then
    hiddenPlots = Instance.new("Folder")
    hiddenPlots.Name = "HiddenPlots"
    hiddenPlots.Parent = game.Lighting
  end

  local plots3 = workspace:FindFirstChild("Plots")

  if plots3 then
    for index58, value84 in ipairs(plots3:GetChildren()) do
      local owner2 = value84:FindFirstChild("Owner")

      if owner2 and tostring(owner2.Value) ~= localPlayer.Name and tostring(owner2.Value) ~= "" then
        value84.Parent = hiddenPlots
      end
    end
  end
end

local function f75(p36)
  f74(p36)

  if v5.Cache.PlotsConn then
    v5.Cache.PlotsConn:Disconnect()
    v5.Cache.PlotsConn = nil
  end

  if p36 then
    local plots4 = workspace:FindFirstChild("Plots")

    if plots4 then
      v5.Cache.PlotsConn = plots4.ChildAdded:Connect(function(child2)
        task.wait(1)
        local owner3 = child2:FindFirstChild("Owner")

        if owner3 and tostring(owner3.Value) ~= localPlayer.Name
          and tostring(owner3.Value) ~= "" then
          child2.Parent = game.Lighting:FindFirstChild("HiddenPlots")
        end
      end)
    end
  end
end

local function f76(p37, p38)
  for index59, value85 in ipairs(p37:GetDescendants()) do
    if value85:IsA("BasePart") or value85:IsA("Decal") or value85:IsA("Texture") then
      if not value85:GetAttribute("OriginalTransparency") then
        value85:SetAttribute("OriginalTransparency", value85.Transparency)
      end

      value85.Transparency = p38 and 1 or value85:GetAttribute("OriginalTransparency")
    elseif value85:IsA("ParticleEmitter") or value85:IsA("Trail") or value85:IsA("Fire")
      or value85:IsA("Smoke") or value85:IsA("Sparkles") then
      if p38 then
        value85.Enabled = false
      else
        value85.Enabled = true
      end
    end
  end
end

local function f77(p39)
  if v5.Cache.MyFlowersConn then
    v5.Cache.MyFlowersConn:Disconnect()
    v5.Cache.MyFlowersConn = nil
  end

  local v207 = f2()
  local flowers6 = v207 and v207:FindFirstChild("Flowers")

  if flowers6 then
    for index60, value86 in ipairs(flowers6:GetChildren()) do
      f76(value86, p39)
    end

    if p39 then
      v5.Cache.MyFlowersConn = flowers6.ChildAdded:Connect(function(child3) f76(child3, true) end)
    end
  end
end

local function f78(p40)
  if v5.Cache.TrainDoubleConn then
    v5.Cache.TrainDoubleConn:Disconnect()
    v5.Cache.TrainDoubleConn = nil
  end

  if p40 then
    local remoteEvent26 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("ClimbJump"):WaitForChild("ClimbJumpUtil"):WaitForChild("RemoteEvent")

    v5.Cache.TrainDoubleConn = remoteEvent26.OnClientEvent:Connect(function(p41, p42)
      if p41 == "CJTrainFeedback" and typeof(p42) == "table" and p42.isDoubleOffer
        and p42.doubleSalt then
        remoteEvent26:FireServer("CJTrainDouble", p42.doubleSalt)
      end
    end)
  end
end

local function f79(p43)
  v5.Flags.IsAutoFriendRequestEnabled = p43

  if p43 then
    for index61, value87 in ipairs(game:GetService("Players"):GetPlayers()) do
      f25(value87)
      task.wait(1)
    end

    if not v5.Cache.FriendRequestPlayerAddedConn then
      v5.Cache.FriendRequestPlayerAddedConn = game:GetService("Players").PlayerAdded:Connect(function(player)
        if v5.Flags.IsAutoFriendRequestEnabled then
          task.wait(2)
          f25(player)
        end
      end)
    end
  elseif v5.Cache.FriendRequestPlayerAddedConn then
    v5.Cache.FriendRequestPlayerAddedConn:Disconnect()
    v5.Cache.FriendRequestPlayerAddedConn = nil
  end
end

local function f80()
  if v5.Flags.IsAutoGiftLoopRunning then
    return
  end

  if not v1.Options.Toggle_AutoGift.Value then
    return
  end

  v5.Flags.IsAutoGiftLoopRunning = true

  task.spawn(function()
    local remoteEvent27 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("GiftSystem"):WaitForChild("GiftUtil"):WaitForChild("RemoteEvent")

    while not v1.Unloaded and v1.Options.Toggle_AutoGift.Value do
      local value88 = v1.Options.Dropdown_GiftTargetPlayer.Value
      local findFirstChild17 = game:GetService("Players"):FindFirstChild(value88 or "")

      local value89 = v1.Options.Dropdown_GiftFlowers and v1.Options.Dropdown_GiftFlowers.Value
        or {}

      local value90 = v1.Options.Dropdown_GiftFertilizers
          and v1.Options.Dropdown_GiftFertilizers.Value
        or {}

      local v208 = false

      for key17, value91 in pairs(value89) do
        if value91 == true then
          v208 = true
          break
        end
      end

      if not v208 then
        for key18, value92 in pairs(value90) do
          if value92 == true then
            v208 = true
            break
          end
        end
      end

      if findFirstChild17 and findFirstChild17.Character and v208 then
        local v209 = f26(value89, value90)

        if #v209 > 0 then
          local humanoidRootPart3 = localPlayer.Character
            and localPlayer.Character:FindFirstChild("HumanoidRootPart")

          local humanoidRootPart4 = findFirstChild17.Character:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart3 and humanoidRootPart4 then
            if (humanoidRootPart3.Position - humanoidRootPart4.Position).Magnitude > 30 then
              local cframe2 = humanoidRootPart3.CFrame
              humanoidRootPart3.CFrame = humanoidRootPart4.CFrame * CFrame.new(0, 0, 3)
              task.wait(0.5)
              local v210 = v209[1]

              pcall(function()
                remoteEvent27:FireServer("GiveGift", findFirstChild17, v210.type, v210.uniqueId)
              end)

              task.wait(0.2)
              humanoidRootPart3.CFrame = cframe2
            else
              local v211 = v209[1]

              pcall(function()
                remoteEvent27:FireServer("GiveGift", findFirstChild17, v211.type, v211.uniqueId)
              end)

              task.wait(0.2)
            end
          else
            task.wait(1)
          end
        else
          task.wait(1)
        end
      else
        task.wait(2)
      end
    end

    v5.Flags.IsAutoGiftLoopRunning = false
  end)
end

local function f81()
  if v5.Flags.IsAutoLikeLoopRunning then
    return
  end

  local value93 = v1.Options.Toggle_AutoLikeSelectedPlayers
    and v1.Options.Toggle_AutoLikeSelectedPlayers.Value

  local value94 = v1.Options.Toggle_AutoLikeAllPlayers
    and v1.Options.Toggle_AutoLikeAllPlayers.Value

  if not value93 and not value94 then
    return
  end

  v5.Flags.IsAutoLikeLoopRunning = true

  task.spawn(function()
    local leaderboardRE = replicatedStorage:WaitForChild("Remotes"):WaitForChild("LeaderboardRE")

    while not v1.Unloaded do
      local value95 = v1.Options.Toggle_AutoLikeSelectedPlayers
        and v1.Options.Toggle_AutoLikeSelectedPlayers.Value

      local value96 = v1.Options.Toggle_AutoLikeAllPlayers
        and v1.Options.Toggle_AutoLikeAllPlayers.Value

      if not value95 and not value96 then
        break
      end

      local v212 = {}

      if value96 then
        for index62, value97 in ipairs(game:GetService("Players"):GetPlayers()) do
          if value97 ~= localPlayer then
            table.insert(v212, value97)
          end
        end
      elseif value95 then
        local value98 = v1.Options.Dropdown_TargetLikePlayers
            and v1.Options.Dropdown_TargetLikePlayers.Value
          or {}

        for index63, value99 in ipairs(game:GetService("Players"):GetPlayers()) do
          if value99 ~= localPlayer and value98[value99.Name] == true then
            table.insert(v212, value99)
          end
        end
      end

      for index64, value100 in ipairs(v212) do
        local value101 = v1.Options.Toggle_AutoLikeSelectedPlayers
          and v1.Options.Toggle_AutoLikeSelectedPlayers.Value

        local value102 = v1.Options.Toggle_AutoLikeAllPlayers
          and v1.Options.Toggle_AutoLikeAllPlayers.Value

        if not value101 and not value102 then
          break
        end

        if value100 and value100.Parent then
          pcall(function()
            leaderboardRE:FireServer({ event = "GiveLike", target = value100.UserId })
          end)

          task.wait(0.2)
        end
      end

      task.wait(31)
    end

    v5.Flags.IsAutoLikeLoopRunning = false
  end)
end

local window2 = v1:CreateWindow({ Title = "Build A Beehive", SubTitle = "by Lamduck" })

local v213 = {
  Garden = window2:AddTab({ Title = "Garden", Icon = "flower" }),
  Shop = window2:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
  Reward = window2:AddTab({ Title = "Reward", Icon = "gift" }),
  Event = window2:AddTab({ Title = "Event", Icon = "zap" }),
  Social = window2:AddTab({ Title = "Social", Icon = "users" }),
  Settings = window2:AddTab({ Title = "Settings", Icon = "settings" }),
}

local addSubTabBar = v213.Garden:AddSubTabBar({
  SubTabs = { "Farm", "Plant Seed", "Place Flower", "Pickup / Remove", "Queen Bee" },
})

local farm = addSubTabBar.Farm
local plantSeed = addSubTabBar["Plant Seed"]
local placeFlower = addSubTabBar["Place Flower"]
local pickupRemove = addSubTabBar["Pickup / Remove"]
local queenBee = addSubTabBar["Queen Bee"]

local honeyHARVESTSELL = farm:AddSection("HONEY HARVEST & SELL")

honeyHARVESTSELL:AddToggle("Toggle_Garden_FarmAutoExtractHoney", {
  Title = "Auto Extract Honey",
  Default = false,
  Callback = function(value103)
    if value103 then
      f29()
    end
  end,
})

honeyHARVESTSELL:AddToggle("Toggle_Garden_FarmAutoSellAllHoney", {
  Title = "Auto Sell All Honey",
  Default = false,
  Callback = function(value104)
    if value104 then
      if v1.Options.Toggle_Garden_FarmAutoSellNormalHoney then
        v1.Options.Toggle_Garden_FarmAutoSellNormalHoney:SetValue(false)
      end

      f30()
    end
  end,
})

honeyHARVESTSELL:AddToggle("Toggle_Garden_FarmAutoSellNormalHoney", {
  Title = "Auto Sell Normal Honey Only",
  Default = false,
  Callback = function(value105)
    if value105 then
      if v1.Options.Toggle_Garden_FarmAutoSellAllHoney then
        v1.Options.Toggle_Garden_FarmAutoSellAllHoney:SetValue(false)
      end

      f30()
    end
  end,
})

local autoPLANTSEED = plantSeed:AddSection("AUTO PLANT SEED")

autoPLANTSEED:AddDropdown("Dropdown_TargetPlantSeeds", {
  Title = "Select Seeds",
  Values = v5.Data.FlowerNames,
  Multi = true,
  Searchable = true,
  Default = {},
})

autoPLANTSEED:AddDropdown("Dropdown_AutoPlantSeedPosMode", {
  Title = "Planting Position Mode",
  Values = { "Random Pos", "Current Pos" },
  Default = "Random Pos",
})

autoPLANTSEED:AddDivider()

autoPLANTSEED:AddToggle("Toggle_AutoPlantSeed", {
  Title = "Auto Plant Seed",
  Default = false,
  Callback = function(value106)
    if value106 then
      f54()
    end
  end,
})

local other = plantSeed:AddSection("OTHER")

other:AddToggle("Toggle_AutoSpawnBee", {
  Title = "Auto Spawn Bee",
  Default = false,
  Callback = function(value107)
    if value107 then
      f53()
    end
  end,
})

other:AddToggle("Toggle_AutoUseGrowthPotion", {
  Title = "Auto Use Growth Potion",
  Default = false,
  Callback = function(value108)
    if value108 then
      f56()
    end
  end,
})

local autoPLACEFLOWER = placeFlower:AddSection("AUTO PLACE FLOWER")

autoPLACEFLOWER:AddDropdown("Dropdown_TargetPlaceFlowers", {
  Title = "Select Flowers",
  Values = v5.Data.FlowerNames,
  Multi = true,
  Searchable = true,
  Default = {},
})

autoPLACEFLOWER:AddDropdown("Dropdown_TargetPlaceMutations", {
  Title = "Select Mutations",
  Description = "Must select at least one",
  Values = table.clone(v5.Data.MutationNames),
  Multi = true,
  Default = table.clone(v5.Data.MutationNames),
})

autoPLACEFLOWER:AddDropdown("Dropdown_AutoPlaceFlowerPosMode", {
  Title = "Placement Position Mode",
  Values = { "Random Pos", "Current Pos" },
  Default = "Random Pos",
})

autoPLACEFLOWER:AddDivider()

autoPLACEFLOWER:AddToggle("Toggle_AutoPlaceFlower", {
  Title = "Auto Place Flower",
  Default = false,
  Callback = function(value109)
    if value109 then
      f55()
    end
  end,
})

local flowerPICKUPREMOVE = pickupRemove:AddSection("FLOWER PICKUP / REMOVE")

flowerPICKUPREMOVE:AddDropdown("Dropdown_TargetRemovePickupFlowers", {
  Title = "Select Flowers",
  Values = v5.Data.FlowerNames,
  Multi = true,
  Searchable = true,
  Default = {},
})

flowerPICKUPREMOVE:AddDropdown("Dropdown_TargetRemovePickupMutations", {
  Title = "Select Mutations",
  Description = "Must select at least one",
  Values = table.clone(v5.Data.MutationNames),
  Multi = true,
  Default = {},
})

flowerPICKUPREMOVE:AddDivider()

flowerPICKUPREMOVE:AddToggle("Toggle_AutoPickupSelectedFlowers", {
  Title = "Auto Pickup Selected Flowers",
  Confirm = "Are you sure you want to pickup selected flowers?",
  Default = false,
  Callback = function(value110)
    if value110 then
      v1.Options.Toggle_AutoRemoveSelectedFlowers:SetValue(false)
      f61()
    end
  end,
})

flowerPICKUPREMOVE:AddDivider()

flowerPICKUPREMOVE:AddToggle("Toggle_AutoRemoveSelectedFlowers", {
  Title = "Auto Remove Selected Flowers",
  Confirm = "Are you sure you want to remove selected flowers? THIS CANNOT BE UNDONE!",
  Default = false,
  Callback = function(value111)
    if value111 then
      v1.Options.Toggle_AutoPickupSelectedFlowers:SetValue(false)
      f62()
    end
  end,
})

addParagraph3 = queenBee:AddSection("QUEEN BEE OVERVIEW"):AddParagraph("Paragraph_Garden_QueenBeeOverview", {
  Title = "Queen Bee Overview",
  Content = "Loading queen bee data...",
})

local queenBEEMANAGEMENT = queenBee:AddSection("QUEEN BEE MANAGEMENT")

queenBEEMANAGEMENT:AddToggle("Toggle_Garden_AutoFeedTreeFertilizer", {
  Title = "Auto Feed Tree Fertilizer",
  Default = false,
  Callback = function(value112)
    if value112 then
      f58()
    end
  end,
})

queenBEEMANAGEMENT:AddDivider()

queenBEEMANAGEMENT:AddDropdown("Dropdown_QueenBee_TargetFlowers", {
  Title = "Select Flowers",
  Values = v5.Data.FlowerNames,
  Multi = true,
  Searchable = true,
  Default = {},
})

queenBEEMANAGEMENT:AddDropdown("Dropdown_QueenBee_TargetMutations", {
  Title = "Select Mutations",
  Description = "Must select at least one",
  Values = table.clone(v5.Data.MutationNames),
  Multi = true,
  Default = {},
})

queenBEEMANAGEMENT:AddDivider()

queenBEEMANAGEMENT:AddToggle("Toggle_QueenBee_AutoPlantFlowers", {
  Title = "Auto Plant Selected Flowers",
  Confirm = "Are you sure you want to plant selected flowers to Queen Bee? Flowers CANNOT be returned to inventory!",
  Default = false,
  Callback = function(value113)
    if value113 then
      if v1.Options.Toggle_QueenBee_AutoRemoveFlowers then
        v1.Options.Toggle_QueenBee_AutoRemoveFlowers:SetValue(false)
      end

      f59()
    end
  end,
})

queenBEEMANAGEMENT:AddDivider()

queenBEEMANAGEMENT:AddToggle("Toggle_QueenBee_AutoRemoveFlowers", {
  Title = "Auto Remove Selected Flowers",
  Confirm = "Are you sure you want to remove selected flowers from Queen Bee? Flowers WILL BE PERMANENTLY LOST!",
  Default = false,
  Callback = function(value114)
    if value114 then
      if v1.Options.Toggle_QueenBee_AutoPlantFlowers then
        v1.Options.Toggle_QueenBee_AutoPlantFlowers:SetValue(false)
      end

      f60()
    end
  end,
})

local queenBEEFLOWERUPGRADE = queenBee:AddSection("QUEEN BEE FLOWER UPGRADE")

queenBEEFLOWERUPGRADE:AddParagraph("Paragraph_Garden_QueenBeeNotice", {
  Title = "Notice",
  Content = "<b><font color=\"#00FF88\">[BUG]</font></b> Works even if you <b><font color=\"#00FF88\">do not have any elixir items</font></b> in your inventory!",
})

queenBEEFLOWERUPGRADE:AddDropdown("Dropdown_Garden_TreeUpgradeMode", {
  Title = "Select Upgrade Mode",
  Values = { "None", "Golden", "Giant", "Rainbow" },
  Default = "None",
})

queenBEEFLOWERUPGRADE:AddButton({
  Title = "Upgrade All Tree Flowers",
  Description = "Max level & roll selected mutation for all tree flowers",
  Confirm = "Are you sure you want to upgrade all flowers on tree?",
  Callback = function() f57() end,
})

addParagraph2 = v213.Garden:AddSection("GARDEN OVERVIEW"):AddParagraph("Paragraph_Garden_GardenDisplay", {
  Title = "Garden Overview",
  Content = "Loading garden data...",
})

local general = v213.Shop:AddSection("GENERAL")

general:AddToggle("Toggle_Shop_AutoUpgradePlot", {
  Title = "Auto Expand Farm",
  Default = false,
  Callback = function(value115)
    if value115 then
      f49()
    end
  end,
})

general:AddToggle("Toggle_Shop_AutoBuyQueenBeeTree", {
  Title = "Auto Buy Queen Bee Tree (Tree 1)",
  Default = false,
  Callback = function(value116)
    if value116 then
      f50()
    end
  end,
})

local flowerSHOP = v213.Shop:AddSection("FLOWER SHOP")

flowerSHOP:AddDropdown("Dropdown_TargetFlowers", {
  Title = "Select Flowers",
  Values = v5.Data.FlowerNamesWithPrice,
  Multi = true,
  Searchable = true,
  Default = {},
})

flowerSHOP:AddToggle("Toggle_AutoBuySelectedFlowers", {
  Title = "Auto Buy Flowers",
  Default = false,
  Callback = function(value117)
    if value117 then
      f47()
    end
  end,
})

local itemFERTILIZERSHOP = v213.Shop:AddSection("ITEM & FERTILIZER SHOP")

itemFERTILIZERSHOP:AddDropdown("Dropdown_TargetItems", {
  Title = "Select Items",
  Values = v5.Data.ItemNamesWithPrice,
  Multi = true,
  Searchable = true,
  Default = {},
})

itemFERTILIZERSHOP:AddToggle("Toggle_AutoBuySelectedItems", {
  Title = "Auto Buy Items",
  Default = false,
  Callback = function(value118)
    if value118 then
      f48()
    end
  end,
})

addParagraph = v213.Shop:AddSection("FLOWER & ITEM STOCK"):AddParagraph("Paragraph_StockDisplay", {
  Title = "Live Stock Tracker",
  Content = "Loading data...",
})

local offlineHONEYREWARDS = v213.Reward:AddSection("OFFLINE & HONEY REWARDS")

offlineHONEYREWARDS:AddToggle("Toggle_Reward_AutoClaimOfflineReward", {
  Title = "Auto Claim Offline Reward",
  Default = false,
  Callback = function(value119)
    if value119 then
      f51()
    end
  end,
})

offlineHONEYREWARDS:AddToggle("Toggle_Reward_AutoClaimHoneyJar", {
  Title = "Auto Claim Honey Jar",
  Default = false,
  Callback = function(value120)
    if value120 then
      f52()
    end
  end,
})

local dailyPLAYTIMEREWARDS = v213.Reward:AddSection("DAILY & PLAYTIME REWARDS")

dailyPLAYTIMEREWARDS:AddToggle("Toggle_Reward_AutoClaimPlaytimeRewards", {
  Title = "Auto Claim Playtime Rewards",
  Default = false,
  Callback = function(value121)
    if value121 then
      f67()
    end
  end,
})

dailyPLAYTIMEREWARDS:AddToggle("Toggle_Reward_AutoClaimDailyLogin", {
  Title = "Auto Claim Daily Login",
  Default = false,
  Callback = function(value122)
    if value122 then
      f68()
    end
  end,
})

dailyPLAYTIMEREWARDS:AddToggle("Toggle_Reward_AutoClaimDailyLoot", {
  Title = "Auto Claim Daily Loot",
  Default = false,
  Callback = function(value123)
    if value123 then
      f69()
    end
  end,
})

dailyPLAYTIMEREWARDS:AddToggle("Toggle_Reward_AutoClaimFreeLoopPack", {
  Title = "Auto Claim Free Loop Pack",
  Default = false,
  Callback = function(value124)
    if value124 then
      f70()
    end
  end,
})

v213.Reward:AddSection("SEASON PASS"):AddToggle("Toggle_AutoCollectSeasonPass", {
  Title = "Auto Collect Season Pass",
  Default = false,
  Callback = function(value125)
    if value125 then
      f63()
    end
  end,
})

local seasonPASSLOTTERY = v213.Reward:AddSection("SEASON PASS LOTTERY")

seasonPASSLOTTERY:AddDropdown("Dropdown_SpinAmount", {
  Title = "Select Spin Amount",
  Values = { "1", "3", "10" },
  Default = "1",
})

seasonPASSLOTTERY:AddToggle("Toggle_AutoSpinSeasonLottery", {
  Title = "Auto Spin Season Lottery",
  Default = false,
  Callback = function(value126)
    if value126 then
      f64()
    end
  end,
})

seasonPASSLOTTERY:AddToggle("Toggle_AutoSpinBloomingLottery", {
  Title = "Auto Spin Blooming Treasures Lottery",
  Default = false,
  Callback = function(value127)
    if value127 then
      f65()
    end
  end,
})

local addSubTabBar2 = v213.Event:AddSubTabBar({ SubTabs = { "General", "Bamboo", "Glory" } })
local general2 = addSubTabBar2.General
local bamboo = addSubTabBar2.Bamboo
local glory = addSubTabBar2.Glory

general2:AddSection("EVENT HONEY"):AddToggle("Toggle_AutoDepositEventHoney", {
  Title = "Auto Deposit Event Honey",
  Default = false,
  Callback = function(value128)
    if value128 then
      f33()
    end
  end,
})

local eventQUESTS = general2:AddSection("EVENT QUESTS")

eventQUESTS:AddToggle("Toggle_AutoClaimEventQuest", {
  Title = "Auto Claim Event Quests",
  Default = false,
  Callback = function(value129)
    if value129 then
      f34()
    end
  end,
})

eventQUESTS:AddToggle("Toggle_AutoFreeRefreshEventQuests", {
  Title = "Auto Free Refresh Event Quests",
  Description = "Automatically uses available free refresh when all daily quests are completed to get new quests.",
  Default = false,
  Callback = function(value130)
    if value130 then
      f35()
    end
  end,
})

local eventPACKLOTTERY = general2:AddSection("EVENT PACK & LOTTERY")

eventPACKLOTTERY:AddToggle("Toggle_AutoClaimOnlineEventPack", {
  Title = "Auto Claim Online Event Pack",
  Description = "Only applies to events with Online Pack (e.g. Summer/Valentine).",
  Default = false,
  Callback = function(value131)
    if value131 then
      f36()
    end
  end,
})

eventPACKLOTTERY:AddToggle("Toggle_AutoExchangeLotteryTicket", {
  Title = "Auto Exchange Fortune Ticket",
  Description = "(max 5/month) Cost 10M",
  Default = false,
  Callback = function(value132)
    if value132 then
      f37()
    end
  end,
})

local bambooEVENTCLIMBJUMP = bamboo:AddSection("BAMBOO EVENT (CLIMB JUMP)")

bambooEVENTCLIMBJUMP:AddButton({
  Title = "Bug Inf Bamboo Coin",
  Description = "*MAY GET BAN!!!*",
  Confirm = "Are you sure you want to get Inf Bamboo Coins?",
  Callback = function()
    local remoteEvent28 = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("ClimbJump"):WaitForChild("ClimbJumpUtil"):WaitForChild("RemoteEvent")

    pcall(function()
      remoteEvent28:FireServer("CJFallStart", 10000000000, 0)
      task.wait(0.1)
      remoteEvent28:FireServer("CJFallLand", 0)
    end)
  end,
})

bambooEVENTCLIMBJUMP:AddDivider()

bambooEVENTCLIMBJUMP:AddButton({
  Title = "Teleport to Climb Island",
  Callback = function()
    pcall(function()
      local climbJumpArea2 = workspace:FindFirstChild("ClimbJumpArea")

      local topArea2 = climbJumpArea2 and climbJumpArea2:FindFirstChild("TopPlatform")
        and climbJumpArea2.TopPlatform:FindFirstChild("TopArea")

      local character7 = localPlayer.Character
      local humanoidRootPart5 = character7 and character7:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart5 and topArea2 then
        humanoidRootPart5.CFrame = topArea2.CFrame + Vector3.new(0, 3, 0)
      end
    end)
  end,
})

bambooEVENTCLIMBJUMP:AddToggle("Toggle_AutoFarmBambooCoin", {
  Title = "Auto Farm Bamboo Coin",
  Default = false,
  Callback = function(value133)
    if value133 then
      f38()
    end
  end,
})

bambooEVENTCLIMBJUMP:AddToggle("Toggle_AutoClaimBambooQuests", {
  Title = "Auto Claim Bamboo Quests & Tree Rewards",
  Default = false,
  Callback = function(value134)
    if value134 then
      f39()
    end
  end,
})

local spinTRAINBAMBOO = bamboo:AddSection("SPIN & TRAIN (BAMBOO)")

spinTRAINBAMBOO:AddDropdown("Dropdown_BambooSpinAmount", {
  Title = "Select Spin Amount",
  Values = { "1", "3" },
  Default = "1",
})

spinTRAINBAMBOO:AddToggle("Toggle_AutoSpinBambooWheel", {
  Title = "Auto Spin Bamboo Event Wheel",
  Default = false,
  Callback = function(value135)
    if value135 then
      f40()
    end
  end,
})

spinTRAINBAMBOO:AddDivider()

spinTRAINBAMBOO:AddToggle("Toggle_AutoHoldTrainTool", {
  Title = "Auto Hold Train Tool",
  Description = "Only work when stand in Bamboo event area!",
  Default = false,
  Callback = function(value136)
    if value136 then
      f41()
    end
  end,
})

spinTRAINBAMBOO:AddToggle("Toggle_AutoClaimTrainDouble", {
  Title = "Auto Claim 2x Train Boost",
  Default = false,
  Callback = function(value137) f78(value137) end,
})

spinTRAINBAMBOO:AddToggle("Toggle_AutoRebirthBamboo", {
  Title = "Auto Rebirth ClimbJump",
  Default = false,
  Callback = function(value138)
    if value138 then
      f42()
    end
  end,
})

local gloryWHEEL = glory:AddSection("GLORY WHEEL")

gloryWHEEL:AddDropdown("Dropdown_GlorySpinAmount", {
  Title = "Select Spin Amount",
  Values = { "1", "10" },
  Default = "1",
})

gloryWHEEL:AddToggle("Toggle_AutoSpinGloryWheel", {
  Title = "Auto Spin Glory Wheel",
  Default = false,
  Callback = function(value139)
    if value139 then
      f43()
    end
  end,
})

gloryWHEEL:AddToggle("Toggle_AutoClaimGloryStage", {
  Title = "Auto Claim Stage Rewards",
  Default = false,
  Callback = function(value140)
    if value140 then
      f44()
    end
  end,
})

local crystalEXCHANGE = glory:AddSection("CRYSTAL EXCHANGE")

crystalEXCHANGE:AddDropdown("Dropdown_GloryExchangeFlower", {
  Title = "Select Flowers to Exchange",
  Values = v5.Data.GloryExchangeOptions
    or { "Lily", "Butterfly Pink Rose", "Evening Glow Flower", "Forget-me-not" },
  Multi = true,
  Searchable = true,
  Default = {},
})

crystalEXCHANGE:AddToggle("Toggle_AutoExchangeGloryCrystal", {
  Title = "Auto Exchange",
  Default = false,
  Callback = function(value141)
    if value141 then
      f45()
    end
  end,
})

v213.Social:AddSection("Friend ~"):AddToggle("Toggle_AutoFriendRequest", {
  Title = "Auto Send Friend Request",
  Description = "Send friend requests to all players for friendboost",
  Default = false,
  Callback = function(value142) f79(value142) end,
})

local addSubTabBar3 = v213.Social:AddSubTabBar({ SubTabs = { "Gift", "Like" } })
local gift = addSubTabBar3.Gift
local like = addSubTabBar3.Like
local autoGift = gift:AddSection("Auto gift")

local addDropdown = autoGift:AddDropdown("Dropdown_GiftTargetPlayer", {
  Title = "Select Target Player",
  Values = {},
  Default = nil,
})

autoGift:AddButton({ Title = "Refresh Players", Callback = function() f28() end })
autoGift:AddDivider()

autoGift:AddDropdown("Dropdown_GiftFlowers", {
  Title = "Select Flowers",
  Values = v5.Data.FlowerNames,
  Multi = true,
  Searchable = true,
  Default = {},
})

autoGift:AddDropdown("Dropdown_GiftFertilizers", {
  Title = "Select Fertilizers",
  Values = v5.Data.ItemNames,
  Multi = true,
  Searchable = true,
  Default = {},
})

autoGift:AddDivider()

autoGift:AddToggle("Toggle_AutoGift", {
  Title = "Auto Gift",
  Default = false,
  Callback = function(value143)
    if value143 then
      f80()
    end
  end,
})

local autoLike = like:AddSection("Auto like")

autoLike:AddDropdown("Dropdown_TargetLikePlayers", {
  Title = "Select Target Players",
  Values = {},
  Multi = true,
  Searchable = true,
  Default = {},
})

autoLike:AddButton({ Title = "Refresh Players", Callback = function() f28() end })
autoLike:AddDivider()

autoLike:AddToggle("Toggle_AutoLikeSelectedPlayers", {
  Title = "Auto Like Selected Players",
  Default = false,
  Callback = function(value144)
    if value144 then
      v1.Options.Toggle_AutoLikeAllPlayers:SetValue(false)
      f81()
    end
  end,
})

autoLike:AddDivider()

autoLike:AddToggle("Toggle_AutoLikeAllPlayers", {
  Title = "Auto Like All Players",
  Default = false,
  Callback = function(value145)
    if value145 then
      v1.Options.Toggle_AutoLikeSelectedPlayers:SetValue(false)
      f81()
    end
  end,
})

local performance = v213.Settings:AddSection("PERFORMANCE")

performance:AddToggle("Toggle_HideNotifications", {
  Title = "Hide Notifications",
  Default = false,
  Callback = function(value146) f72(value146) end,
})

performance:AddToggle("Toggle_CleanGameUI", {
  Title = "Clean Game UI",
  Default = false,
  Callback = function(value147) f73(value147) end,
})

performance:AddToggle("Toggle_HideOtherPlots", {
  Title = "Hide Other Player Plots",
  Default = false,
  Callback = function(value148) f75(value148) end,
})

performance:AddToggle("Toggle_HidePlayerFlowers", {
  Title = "Hide Flowers",
  Confirm = "Are you sure you want to hide your flowers? This will make them invisible!",
  Default = false,
  Callback = function(value149) f77(value149) end,
})

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/BAB")
v4:SetFolder("Lamduck/BAB")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v213.Settings)
v3:BuildInterfaceSection(v213.Settings)
v2:BuildConfigSection(v213.Settings)
f46()
f31()
f32()
f28()
f71()

v1.OnUnload:Once(function()
  pcall(function()
    for key19, value150 in pairs(v5.Cache) do
      if typeof(value150) == "RBXScriptConnection" then
        value150:Disconnect()
        v5.Cache[key19] = nil
      end
    end
  end)
end)

v2:LoadAutoloadConfig()
window2:SelectTab(1)
