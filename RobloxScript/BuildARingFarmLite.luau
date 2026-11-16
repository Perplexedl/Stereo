local v1 = os.clock()
local v2, v3, v4, v5 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = game.Players.LocalPlayer
local lighting = game:GetService("Lighting")
local soundService = game:GetService("SoundService")
local v6 = nil

local v7 = {
  Flags = {
    IsSellCratesLoopRunning = false,
    IsSeedGachaLoopRunning = false,
    IsBuyGearsLoopRunning = false,
    IsEggShopBuyLoopRunning = false,
    IsAutoFeedPetsLoopRunning = false,
    IsAutoUpgradePetsLoopRunning = false,
    IsAutoSellPetsLoopRunning = false,
    IsCompostLoopRunning = false,
    IsAutoPlantLoopRunning = false,
    IsUpgradePlantsLoopRunning = false,
    IsFertilizePlantsLoopRunning = false,
    IsUpgradePowerupsLoopRunning = false,
    IsUnlockFarmPlotsLoopRunning = false,
    IsCollectAlienDropLoopRunning = false,
    IsCollectCyberDroneDropLoopRunning = false,
    IsCollectHoneycombLoopRunning = false,
    IsSubmitQueenBeeHoneyTokenLoopRunning = false,
    IsCollectAdminTokensLoopRunning = false,
    IsSpinMegaSpinnerLoopRunning = false,
    IsCollectWeatherEventsLoopRunning = false,
    IsCollectLuckyRainDropLoopRunning = false,
    IsCollectMeteorDropLoopRunning = false,
    IsPlantditchPassRingLoopRunning = false,
    IsPlantditchClaimOrbLoopRunning = false,
    IsShootJesterBossLoopRunning = false,
    IsCollectJesterGiftsLoopRunning = false,
    IsCollectCarnivalGiftsLoopRunning = false,
    IsClaimDailyRewardLoopRunning = false,
    IsClaimPlaytimeRewardLoopRunning = false,
    IsSpinWheelLoopRunning = false,
    IsAutoOpenCratePackLoopRunning = false,
    IsAutoFriendRequestEnabled = false,
    IsAutoNeighbourChoresLoopRunning = false,
    IsAutoZooRushLoopRunning = false,
    IsAutoClaimGuildMissionsRunning = false,
    IsAutoClaimGuildWeeklyRunning = false,
    IsAutoBuyGuildShopRunning = false,
    IsAutoRallyLoopRunning = false,
    IsAutoFriendOTronRunning = false,
    IsAutoFriendOTronSpinRunning = false,
    IsAutoBuyPetMutationUpgradesRunning = false,
    IsAutoStartPetMutationRunning = false,
    IsAutoClaimPetMutationRunning = false,
    IsAutoClaimSeasonPassQuestsRunning = false,
    IsAutoClaimSeasonPassRewardsRunning = false,
    IsAutoSpinSeasonPassCrateRunning = false,
    IsAutoSubmitMerchantTradesRunning = false,
    IsAutoBuyNightMarketRunning = false,
    IsAutoRollVaultRunning = false,
    IsAutoBuyMerchantShopRunning = false,
    IsAutoFuseLoopRunning = false,
    IsGolemAutoSacrificeRunning = false,
    IsGolemAutoAdvanceRunning = false,
    IsAutoDispatchPetExpeditionRunning = false,
    IsAutoClaimPetExpeditionRunning = false,
    IsDisableFovEffects = false,
    IsDisableSeedBounce = false,
    IsRemoveAllEffects = false,
    IsExtremeLowPerformance = false,
  },
  Data = {
    Gacha = { RollData = nil, RollReady = false, BuyResults = {} },
    CurrentRollId = nil,
    PlantRegistry = {},
    PlantNames = {},
    RarityRegistry = {},
    RarityNames = {},
    RarityOrderMap = {},
    GearRegistry = {},
    GearNames = {},
    GearShopItemNames = {},
    GearCosts = {},
    EggNames = {},
    EggPrices = {},
    PetTreatNames = {},
    PetRegistry = {},
    PetNames = {},
    PetRarityLookup = {},
    PetRarityNames = {},
    PetSizeNames = {},
    CompostConfig = nil,
    CompostLevelNames = {},
    CompostCooldownDuration = 300,
    CompostCooldownEndsAt = {},
    FertilizerNames = {},
    MutationRegistry = {},
    MutationNames = {},
    GuildShopItemNames = {},
    GuildShopItemIdMap = {},
    ZooRushPetRate = {},
    PetMutationRarityConfig = nil,
    PetMutationNames = {},
    FriendOTronCooldownUntil = 0,
    FriendOTronSpins = 0,
    FriendOTronPendingSeedKey = "",
    WanderingMerchantConfig = nil,
    WanderingMerchantItemNames = {},
    WanderingMerchantItemIdMap = {},
    PetExpeditionConfig = nil,
    NightMarketConfig = nil,
    NightMarketItemNames = {},
    NightMarketItemIdMap = {},
    MegaSpinnerSpins = 0,
  },
  Cache = {
    QueenBeeHoneyJarInsertPrompt = nil,
    MegaSpinnerPrompt = nil,
    CompostCooldownClient = nil,
    EventSignal = nil,
    EventController = nil,
    MyPlot = nil,
    MyPlotName = nil,
    OriginalAlertVolume = nil,
    GuildServiceRF = nil,
    GolemQuestCache = nil,
    GolemQuestCacheTime = 0,
    ReplicatorSnapshot = nil,
    ReplicatorSnapshotTime = nil,
    DirtNodes = setmetatable({}, { __mode = "k" }),
    DirtNodesTime = setmetatable({}, { __mode = "k" }),
    SavedFOV = nil,
    CycleAnimationHooked = false,
    OriginalCycleAnimationPlay = nil,
  },
  Connections = {
    SeasonPassObserver = nil,
    EventCurrenciesObserver = nil,
    GolemQuestObserver = nil,
    RollSeedsConnection = nil,
    BuySeedConnection = nil,
    FriendOTronCooldownObserver = nil,
    FriendOTronSpinsObserver = nil,
    FriendOTronPendingSeedKeyObserver = nil,
    FriendRequestPlayerAddedConn = nil,
    FuseObserver = nil,
    PetMutationObserver = nil,
    NightMarketMerchantObserver = nil,
    VaultObserver = nil,
    MegaSpinnerSpinsObserver = nil,
    FovChangedConnection = nil,
    DescendantVfxConnection = nil,
    HidePetsConnection = nil,
    HideDirtConnections = {},
  },
  Paragraph = { WanderingMerchantInfo = nil },
}

local v8 = {}

local v9 = {
  FLOOR_NAMES = { "", "Floor2", "Floor3", "Floor4", "Floor5" },
  UPGRADE_MAP = {
    SawRange = {
      SignName = "PlotUpgradeSign",
      UIFolder = "SawRange",
      RemoteArg = "ExtraSawRange",
      Type = "plot",
    },
    SawYield = {
      SignName = "PlotUpgradeSign",
      UIFolder = "SawYield",
      RemoteArg = "ExtraYield",
      Type = "plot",
    },
    SprinklerRange = {
      SignName = "PlotUpgradeSign",
      UIFolder = "SprinklerRange",
      RemoteArg = "ExtraSprinklerRange",
      Type = "plot",
    },
    SprinklerPower = {
      SignName = "PlotUpgradeSign",
      UIFolder = "SprinklerPower",
      RemoteArg = "ExtraPower",
      Type = "plot",
    },
    SoilQuality = {
      SignName = "PlotUpgradeSign",
      UIFolder = "SoilQuality",
      RemoteArg = "SoilQuality",
      Type = "plot",
    },
    CrownedCrops = {
      SignName = "PlotUpgradeSign",
      UIFolder = "CrownedCrops",
      RemoteArg = "CrownedCrops",
      Type = "plot",
    },
    GoldenHarvest = {
      SignName = "PlotUpgradeSign",
      UIFolder = "GoldenHarvest",
      RemoteArg = "GoldenHarvestStage",
      Type = "plot",
    },
    GoldenChance = {
      SignName = "PlotUpgradeSign",
      UIFolder = "GoldenChance",
      RemoteArg = "GoldenChance",
      Type = "plot",
    },
    SeedLuck = { SignName = "UpgradeSign", UIFolder = "SeedLuck", Type = "seedluck" },
    SeedRolls = { SignName = "UpgradeSign", UIFolder = "SeedRolls", Type = "seedrolls" },
  },
  MONEY_SUFFIX_MULTIPLIERS = {
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
  },
  SUFFIX_BY_VALUE = {},
}

for key, value in pairs(v9.MONEY_SUFFIX_MULTIPLIERS) do
  v9.SUFFIX_BY_VALUE[value] = key
end

local function f1(p1, p2, p3, p4, p5)
  p4 = p4 or 5
  p5 = p5 or 2

  task.spawn(function()
    local count = 0
    local v10 = nil
    local v11 = string.split(p2, ".")

    while count < p4 and not v10 do
      local v12, v13 = pcall(function()
        if not p1 then
          error("Parent is nil")
        end

        local waitForChild = p1

        for index, value2 in ipairs(v11) do
          waitForChild = waitForChild:WaitForChild(value2, p5)

          if not waitForChild then
            error("Child not found: " .. value2)
          end
        end

        return require(waitForChild)
      end)

      if v12 and v13 then
        v10 = v13
        break
      end

      count = count + 1
      task.wait(p5)
    end

    if p3 then
      p3(v10)
    end
  end)
end

local function f2(p6)
  if type(p6) == "number" then
    return p6
  end

  if type(p6) ~= "string" or p6 == "" then
    return 0
  end

  local gsub = string.upper(p6):gsub("[$%,%s]", "")
  local v14, v15 = string.match(gsub, "^([%d%.]+)(%a*)$")

  if not v14 then
    return 0
  end

  local v16 = 1

  if v15 and v15 ~= "" then
    v16 = v9.MONEY_SUFFIX_MULTIPLIERS[v15] or 1
  end

  return (tonumber(v14) or 0) * v16
end

local function f3(p7)
  if not p7 then
    return "N/A"
  end

  if p7 == 0 then
    return "0"
  end

  if p7 < 1000 then
    return tostring(math.floor(p7))
  end

  local v17 = 10 ^ (math.floor(math.log10(p7) / 3) * 3)
  local v18 = v9.SUFFIX_BY_VALUE[v17]

  if v18 then
    local v19 = p7 / v17

    local v20 = v19 == math.floor(v19) and string.format("%.0f", v19)
      or string.format("%.2f", v19)

    return string.format("%s%s", v20, v18)
  end

  return tostring(math.floor(p7))
end

local function f4(p8, ...)
  if select("#", ...) > 0 then
    print("[Lamduck] " .. string.format(tostring(p8), ...))
  else
    print("[Lamduck] " .. tostring(p8))
  end
end

local function f5()
  local v21, v22 = pcall(function()
    return (localPlayer:FindFirstChild("leaderstats")
      or localPlayer:FindFirstChild("Leaderstats")).Cash.Value
  end)

  return v21 and f2(v22) or 0
end

local function f6(p9)
  return f5() >= p9
end

local function f7()
  local v23, v24 = pcall(function()
    return localPlayer.PlayerGui.MainUI.MoneyCounter.EventCurrency.HoneyTokens
  end)

  local contentText = v23 and v24 and (v24.ContentText or v24.Text)
  return contentText and contentText ~= "" and f2(contentText) or 0
end

local function f8()
  if v7.Cache.MyPlot and v7.Cache.MyPlot.Parent and v7.Cache.MyPlot:IsDescendantOf(workspace) then
    return v7.Cache.MyPlot
  end

  local plots = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Plots")

  if not plots then
    return nil
  end

  if v7.Cache.MyPlotName then
    local findFirstChild = plots:FindFirstChild(v7.Cache.MyPlotName)

    if findFirstChild and findFirstChild:GetAttribute("OwnerUserId") == localPlayer.UserId then
      v7.Cache.MyPlot = findFirstChild
      return findFirstChild
    end
  end

  local v25, v26 = pcall(function() return plots:GetChildren() end)

  if v25 and v26 then
    for index2, value3 in ipairs(v26) do
      if value3:GetAttribute("OwnerUserId") == localPlayer.UserId then
        v7.Cache.MyPlot = value3
        v7.Cache.MyPlotName = value3.Name
        return value3
      end
    end
  end

  return nil
end

local function f9()
  if v7.Cache.MyPlotName then
    return v7.Cache.MyPlotName
  end

  local v27 = f8()

  if v27 then
    return v27.Name
  end

  return nil
end

local function f10(p10)
  if p10 and p10 ~= localPlayer then
    pcall(function() localPlayer:RequestFriendship(p10) end)
  end
end

local function f11(p11)
  local plots2 = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Plots")

  if not plots2 then
    return
  end

  if p11 then
    local v28 = f9()

    if not v28 then
      return
    end

    for index3, value4 in ipairs(plots2:GetChildren()) do
      if value4.Name ~= v28 then
        value4.Parent = lighting
      end
    end
  else
    local v29 = f9()

    for index4, value5 in ipairs(lighting:GetChildren()) do
      if string.find(value5.Name, "Plot") and value5.Name ~= v29 then
        value5.Parent = plots2
      end
    end
  end
end

local function f12(p12, p13)
  if not p12 or not p12:IsA("Model") then
    return
  end

  if p12.Parent and p12.Parent:IsA("BasePart") then
    p12.Parent.LocalTransparencyModifier = p13 and 1 or 0
  end

  for index5, value6 in ipairs(p12:GetDescendants()) do
    if value6:IsA("BasePart") then
      value6.LocalTransparencyModifier = p13 and 1 or 0
    elseif value6:IsA("ParticleEmitter") or value6:IsA("Beam") or value6:IsA("Trail") then
      value6.Enabled = not p13
    end
  end
end

local function f13(p14)
  if v7.Connections.HideDirtConnections then
    for index6, value7 in ipairs(v7.Connections.HideDirtConnections) do
      pcall(function() value7:Disconnect() end)
    end

    table.clear(v7.Connections.HideDirtConnections)
  else
    v7.Connections.HideDirtConnections = {}
  end

  local v30 = f8()

  if not v30 then
    return
  end

  for index7, value8 in ipairs(v30:GetDescendants()) do
    if value8:IsA("BasePart") and value8.Name == "Dirt" then
      for index8, value9 in ipairs(value8:GetChildren()) do
        if value9:IsA("Model") then
          f12(value9, p14)
        end
      end

      if p14 then
        local connect = value8.ChildAdded:Connect(function(child)
          if child:IsA("Model") then
            task.defer(function() f12(child, true) end)
          end
        end)

        table.insert(v7.Connections.HideDirtConnections, connect)
      end
    end
  end
end

local function f14(p15, p16)
  if not p15 or not p15:IsA("Model") then
    return
  end

  for index9, value10 in ipairs(p15:GetDescendants()) do
    if value10:IsA("BasePart") then
      value10.LocalTransparencyModifier = p16 and 1 or 0
    elseif value10:IsA("ParticleEmitter") or value10:IsA("Beam") or value10:IsA("Trail") then
      value10.Enabled = not p16
    end
  end
end

local function f15(p17)
  if v7.Connections.HidePetsConnection then
    pcall(function() v7.Connections.HidePetsConnection:Disconnect() end)
    v7.Connections.HidePetsConnection = nil
  end

  local clientPetVisuals = workspace:FindFirstChild("ClientPetVisuals")

  if not clientPetVisuals then
    return
  end

  for index10, value11 in ipairs(clientPetVisuals:GetChildren()) do
    if value11:IsA("Model") then
      f14(value11, p17)
    end
  end

  if p17 then
    v7.Connections.HidePetsConnection = clientPetVisuals.ChildAdded:Connect(function(child2)
      if child2:IsA("Model") then
        task.defer(function() f14(child2, true) end)
      end
    end)
  end
end

local function f16(p18)
  v7.Flags.IsExtremeLowPerformance = p18

  pcall(function()
    local setSetting = replicatedStorage.Remotes.Settings.SetSetting
    setSetting:FireServer("VFX", not p18)
    setSetting:FireServer("SFX", not p18)
    setSetting:FireServer("Music", not p18)
    setSetting:FireServer("FarmIcons", not p18)
    setSetting:FireServer("Titles", not p18)
    setSetting:FireServer("LowPerformanceMode", p18)
    setSetting:FireServer("HideOtherFarms", p18)
  end)

  pcall(function() f13(p18) end)
  pcall(function() f15(p18) end)

  f11(p18)
end

local function f17(p19)
  v7.Flags.IsDisableFovEffects = p19
  local currentCamera = workspace.CurrentCamera

  if not currentCamera then
    return
  end

  if p19 then
    v7.Cache.SavedFOV = currentCamera.FieldOfView

    if v7.Connections.FovChangedConnection then
      v7.Connections.FovChangedConnection:Disconnect()
      v7.Connections.FovChangedConnection = nil
    end

    v7.Connections.FovChangedConnection = currentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
      if v7.Flags.IsDisableFovEffects and v7.Cache.SavedFOV
        and currentCamera.FieldOfView ~= v7.Cache.SavedFOV then
        currentCamera.FieldOfView = v7.Cache.SavedFOV
      end
    end)
  else
    if v7.Connections.FovChangedConnection then
      v7.Connections.FovChangedConnection:Disconnect()
      v7.Connections.FovChangedConnection = nil
    end

    v7.Cache.SavedFOV = nil
  end
end

local function f18()
  local playerScripts = localPlayer:FindFirstChild("PlayerScripts")

  if playerScripts then
    local findFirstChild2 = playerScripts:FindFirstChild("CycleAnimation", true)

    if findFirstChild2 then
      return findFirstChild2
    end
  end

  local starterPlayer = game:GetService("StarterPlayer")
  local starterPlayerScripts = starterPlayer:FindFirstChild("StarterPlayerScripts")

  if starterPlayerScripts then
    local findFirstChild3 = starterPlayerScripts:FindFirstChild("CycleAnimation", true)

    if findFirstChild3 then
      return findFirstChild3
    end
  end

  return nil
end

local function f19(p20)
  v7.Flags.IsDisableSeedBounce = p20
  local v31 = f18()

  if not v31 then
    return
  end

  local v32, v33 = pcall(require, v31)

  if not v32 or type(v33) ~= "table" or type(v33.Play) ~= "function" then
    return
  end

  local v34 = typeof(hookfunction) == "function" and hookfunction
    or typeof(replaceclosure) == "function" and replaceclosure

  if not v34 then
    return
  end

  if p20 then
    if not v7.Cache.CycleAnimationHooked then
      v7.Cache.OriginalCycleAnimationPlay = v34(v33.Play, function(p21, p22)
        if v7.Flags.IsDisableSeedBounce then
          local v35 = type(p21) == "table" and type(p21.LandOn) == "function" and p21
            or type(p22) == "table" and type(p22.LandOn) == "function" and p22

          if v35 and type(v35.LandOn) == "function" then
            pcall(v35.LandOn)
            return
          end
        end

        if v7.Cache.OriginalCycleAnimationPlay then
          return v7.Cache.OriginalCycleAnimationPlay(p21, p22)
        end
      end)

      v7.Cache.CycleAnimationHooked = true
    end
  elseif v7.Cache.CycleAnimationHooked and v7.Cache.OriginalCycleAnimationPlay then
    pcall(function() v34(v33.Play, v7.Cache.OriginalCycleAnimationPlay) end)
    v7.Cache.OriginalCycleAnimationPlay = nil
    v7.Cache.CycleAnimationHooked = false
  end
end

local function f20(p23)
  v7.Flags.IsRemoveAllEffects = p23

  local function f21(p24, enabled)
    if p24:IsA("ParticleEmitter") or p24:IsA("Beam") or p24:IsA("Trail") or p24:IsA("Smoke")
      or p24:IsA("Fire") or p24:IsA("Sparkles") or p24:IsA("Highlight") or p24:IsA("PointLight")
      or p24:IsA("SpotLight") or p24:IsA("SurfaceLight") then
      p24.Enabled = enabled
    end
  end

  if p23 then
    pcall(function() lighting.GlobalShadows = false end)

    for index11, value12 in ipairs(lighting:GetChildren()) do
      if value12:IsA("PostEffect") then
        value12.Enabled = false
      end
    end

    for index12, value13 in ipairs(workspace:GetDescendants()) do
      pcall(f21, value13, false)
    end

    if v7.Connections.DescendantVfxConnection then
      v7.Connections.DescendantVfxConnection:Disconnect()
      v7.Connections.DescendantVfxConnection = nil
    end

    v7.Connections.DescendantVfxConnection = workspace.DescendantAdded:Connect(function(descendant)
      if v7.Flags.IsRemoveAllEffects then
        pcall(f21, descendant, false)
      end
    end)
  else
    if v7.Connections.DescendantVfxConnection then
      v7.Connections.DescendantVfxConnection:Disconnect()
      v7.Connections.DescendantVfxConnection = nil
    end

    pcall(function() lighting.GlobalShadows = true end)

    for index13, value14 in ipairs(lighting:GetChildren()) do
      if value14:IsA("PostEffect") then
        value14.Enabled = true
      end
    end

    for index14, value15 in ipairs(workspace:GetDescendants()) do
      pcall(f21, value15, true)
    end
  end
end

local function f22()
  local v36, v37 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Plants", 5
    ))
  end)

  if v36 and type(v37) == "table" and type(v37.GetPlantsForIndex) == "function" then
    local v38, v39 = pcall(v37.GetPlantsForIndex)

    if v38 and type(v39) == "table" and #v39 > 0 then
      local v40 = {}

      for index15, value16 in ipairs(v39) do
        local v41 = v37[value16.Name] or {}

        table.insert(v40, {
          Name = value16.Name,
          Rarity = value16.Rarity,
          Icon = value16.Icon,
          Price = value16.Price,
          Event = value16.Event,
          Cost = v41.Cost,
          StageGrowTime = v41.StageGrowTime,
          MaxStages = v41.MaxStages,
          RollChance = v41.RollChance,
          RollWeather = v41.RollWeather,
          EventFiltering = v41.EventFiltering,
        })
      end

      return v40
    end
  end

  local v42 = {}

  local seeds = replicatedStorage:FindFirstChild("Assets")
    and replicatedStorage.Assets:FindFirstChild("Seeds")

  if seeds then
    for index16, value17 in ipairs(seeds:GetChildren()) do
      table.insert(v42, { Name = string.gsub(value17.Name, " Seed$", "") })
    end

    table.sort(v42, function(p25, p26) return p25.Name < p26.Name end)
  end

  return v42
end

local function f23()
  local v43, v44 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Rarities", 5
    ))
  end)

  local v45 = {}

  if v43 and type(v44) == "table" then
    for key2, value18 in pairs(v44) do
      if type(value18) == "table" and value18.Order then
        table.insert(v45, {
          Name = key2,
          Order = value18.Order,
          AccentColor = value18.AccentColor,
        })
      end
    end

    table.sort(v45, function(p27, p28) return p27.Order < p28.Order end)
  end

  return v45
end

local function f24()
  local v46, v47 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Mutations", 5
    ))
  end)

  local v48 = {}

  if v46 and type(v47) == "table" and type(v47[2]) == "table" then
    for key3, value19 in pairs(v47[2]) do
      if type(value19) == "table" then
        table.insert(v48, {
          Name = key3,
          Chance = value19.Chance,
          IncomeMultiplier = value19.IncomeMultiplier,
          Exclusive = value19.Exclusive,
          Icon = value19.Icon,
          Event = value19.Event,
          MainColor = value19.MainColor,
        })
      end
    end

    table.sort(v48, function(p29, p30) return p29.Name < p30.Name end)
  end

  return v48
end

local function f25()
  local v49 = { LevelNames = { "Rich", "Prime", "Overgrown" }, CooldownDuration = 300 }

  local v50, v51 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("CompostConfig", 5))
  end)

  if v50 and type(v51) == "table" and v51.Tiers then
    local v52 = {}

    for index17, value20 in ipairs(v51.Tiers[2] or {}) do
      table.insert(v52, value20.Name)
    end

    if #v52 > 0 then
      v49.LevelNames = v52
    end
  end

  local v53, v54 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "CompostCooldownConfig", 5
    ))
  end)

  if v53 and type(v54) == "table" and type(v54.Duration) == "number" then
    v49.CooldownDuration = v54.Duration
  end

  return v49
end

local function f26()
  local v55, v56 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Gear", 5
    ))
  end)

  local v57 = {}

  if v55 and type(v56) == "table" and type(v56[2]) == "table" then
    for key4, value21 in pairs(v56[2]) do
      table.insert(v57, {
        Name = key4,
        Chance = value21.Chance,
        MaxStock = value21.MaxStock,
        Cost = value21.Cost,
      })
    end

    table.sort(v57, function(p31, p32) return p31.Name < p32.Name end)
  end

  return v57
end

local function f27()
  local v58, v59 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("EggConfig", 5))
  end)

  local v60 = {}
  local v61 = {}

  if v58 and type(v59) == "table" then
    if v59.Prices then
      for key5, value22 in pairs(v59.Prices) do
        v60[key5] = tonumber(value22) or 0
        table.insert(v61, key5)
      end
    end
  end

  table.sort(v61)
  return v60, v61
end

local function f28()
  local v62, v63 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Pets", 5
    ))
  end)

  local v64 = {}

  if v62 and type(v63) == "table" then
    for key6, value23 in pairs(v63) do
      if type(value23) == "table" and value23.Rarity then
        table.insert(v64, {
          Name = key6,
          Rarity = value23.Rarity,
          AbilityInfo = value23.AbilityInfo,
          MultiplierRanges = value23.MultiplierRanges,
        })
      end
    end

    table.sort(v64, function(p33, p34) return p33.Name < p34.Name end)
  end

  return v64
end

local function f29(p35)
  local v65 = {}

  for index18, value24 in ipairs(p35) do
    local multiplierRanges = value24.MultiplierRanges or value24.MutiplierRanges

    if type(multiplierRanges) == "table" then
      for key7, value25 in pairs(multiplierRanges) do
        v65[key7] = true
      end
    end
  end

  local v66 = {}

  for key8, value26 in pairs(v65) do
    table.insert(v66, key8)
  end

  table.sort(v66)
  return v66
end

local function f30()
  local v67, v68 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("ZooRushConfig", 5))
  end)

  if not (v67 and type(v68) == "table") then
    return {}, {}
  end

  local v69 = {}
  local v70 = {}
  local v71 = {}

  for index19, value27 in ipairs({ v68.SpawnTable, v68.AdminSpawnTable }) do
    if type(value27) == "table" then
      for key9 in pairs(value27) do
        if not v71[key9] then
          v71[key9] = true
          table.insert(v69, key9)
        end
      end
    end
  end

  table.sort(v69)

  for key10, value28 in pairs(v68.SpawnTable) do
    v70[key10] = value28
  end

  for key11, value29 in pairs(v68.AdminSpawnTable) do
    if v70[key11] == nil then
      v70[key11] = value29
    end
  end

  return v69, v70
end

local function f31()
  local v72, v73 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "FriendOTronConfig", 5
    ))
  end)

  if v72 and type(v73) == "table" then
    return v73
  end

  return nil
end

local function f32()
  local v74, v75 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("SharedUtils", 5))
  end)

  if v74 and type(v75) == "table" then
    return v75
  end

  return nil
end

local function f33()
  local v76, v77 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "PetMutationConfig", 5
    ))
  end)

  if not (v76 and type(v77) == "table") then
    return nil, {}
  end

  local v78 = {}

  for index20, value30 in ipairs(v77.Mutations) do
    if value30.Released then
      table.insert(v78, value30.Name)
    end
  end

  return v77.Rarities, v78, v77
end

local function f34()
  return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("GuildConfig", 5))
end

local function f35()
  if v7.Data.WanderingMerchantConfig then
    return v7.Data.WanderingMerchantConfig, v7.Data.WanderingMerchantItemNames, v7.Data.WanderingMerchantItemIdMap
  end

  local v79, v80 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "WanderingMerchantConfig", 5
    ))
  end)

  if v79 and type(v80) == "table" then
    v7.Data.WanderingMerchantConfig = v80
    v7.Data.WanderingMerchantItemNames = {}
    v7.Data.WanderingMerchantItemIdMap = {}

    if type(v80.Items) == "table" then
      for index21, value31 in ipairs(v80.Items) do
        local displayName = value31.DisplayName or value31.Id
        table.insert(v7.Data.WanderingMerchantItemNames, displayName)
        v7.Data.WanderingMerchantItemIdMap[displayName] = value31.Id
      end
    end

    return v80, v7.Data.WanderingMerchantItemNames, v7.Data.WanderingMerchantItemIdMap
  end

  return nil, {}, {}
end

local function f36()
  if v7.Data.NightMarketConfig then
    return v7.Data.NightMarketConfig, v7.Data.NightMarketItemNames, v7.Data.NightMarketItemIdMap
  end

  local v81, v82 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "NightMarketMerchantConfig", 5
    ))
  end)

  if v81 and type(v82) == "table" then
    v7.Data.NightMarketConfig = v82
    v7.Data.NightMarketItemNames = {}
    v7.Data.NightMarketItemIdMap = {}

    if type(v82.Items) == "table" then
      for index22, value32 in ipairs(v82.Items) do
        local displayName2 = value32.DisplayName or value32.Id
        table.insert(v7.Data.NightMarketItemNames, displayName2)
        v7.Data.NightMarketItemIdMap[displayName2] = value32.Id
      end
    end

    return v82, v7.Data.NightMarketItemNames, v7.Data.NightMarketItemIdMap
  end

  return nil, {}, {}
end

local function f37()
  if v8.Configuration then
    return v8.Configuration
  end

  local v83, v84 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Configuration", 5))
  end)

  if v83 and type(v84) == "table" then
    v8.Configuration = v84
    return v84
  end

  return nil
end

local function f38()
  if v8.CrownedCropsConfig then
    return v8.CrownedCropsConfig
  end

  local v85, v86 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "CrownedCropsConfig", 5
    ))
  end)

  if v85 and type(v86) == "table" then
    v8.CrownedCropsConfig = v86
    return v86
  end

  return nil
end

local function f39()
  if v8.GoldenHarvestConfig then
    return v8.GoldenHarvestConfig
  end

  local v87, v88 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "GoldenHarvestConfig", 5
    ))
  end)

  if v87 and type(v88) == "table" then
    v8.GoldenHarvestConfig = v88
    return v88
  end

  return nil
end

local function f40()
  if v7.Data.PetExpeditionConfig then
    return v7.Data.PetExpeditionConfig
  end

  local v89, v90 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "PetExpeditionConfig", 5
    ))
  end)

  if v89 and type(v90) == "table" then
    v7.Data.PetExpeditionConfig = v90
    return v90
  end

  return nil
end

f1(replicatedStorage, "Packages.DataReplicator", function(p36)
  v6 = p36

  if v6 then
    local v91, v92 = pcall(v6.GetReplicator)

    if v91 and v92 then
      pcall(function()
        v7.Connections.SeasonPassObserver = v92:Observe({ "SeasonPasses" }, function() end)
      end)

      pcall(function()
        v7.Connections.EventCurrenciesObserver = v92:Observe({ "EventCurrencies" }, function()
        end)
      end)

      pcall(function()
        v7.Connections.GolemQuestObserver = v92:Observe({ "PlantBossQuest" }, function() end)
      end)

      pcall(function() v7.Connections.FuseObserver = v92:Observe({ "Fuse" }, function() end) end)

      pcall(function()
        v7.Connections.PetMutationObserver = v92:Observe({ "PetMutation" }, function() end)
      end)

      pcall(function()
        v7.Connections.NightMarketMerchantObserver = v92:Observe({ "NightMarketMerchant" }, function()
        end)
      end)

      pcall(function()
        v7.Connections.VaultObserver = v92:Observe({ "Vault" }, function() end)
      end)

      pcall(function()
        v7.Connections.MegaSpinnerSpinsObserver = v92:Observe({
          "InteractiveEvents", "MegaSpinner", "Spins",
        }, function(p37)
          v7.Data.MegaSpinnerSpins = tonumber(p37) or 0
        end)
      end)
    end
  end
end)

v7.Data.PlantRegistry = f22()

for index23, value33 in ipairs(v7.Data.PlantRegistry) do
  table.insert(v7.Data.PlantNames, value33.Name)
end

v7.Data.PlantRarityLookup = {}

for index24, value34 in ipairs(v7.Data.PlantRegistry) do
  v7.Data.PlantRarityLookup[string.lower(value34.Name)] = value34.Rarity or "Unknown"
end

local v93 = f23()
v7.Data.RarityRegistry = v93

for index25, value35 in ipairs(v93) do
  table.insert(v7.Data.RarityNames, value35.Name)
  v7.Data.RarityOrderMap[value35.Name] = value35.Order
end

v7.Data.GearRegistry = f26()

for index26, value36 in ipairs(v7.Data.GearRegistry) do
  local name = value36.Name
  table.insert(v7.Data.GearNames, name)

  if (value36.Chance or 0) > 0 and (value36.MaxStock or 0) > 0 then
    table.insert(v7.Data.GearShopItemNames, name)
  end

  v7.Data.GearCosts[name] = value36.Cost or 0
  local v94 = string.lower(name)

  if string.find(v94, "treat") then
    table.insert(v7.Data.PetTreatNames, name)
  elseif string.find(v94, "fertilizer") and not string.find(v94, "crate")
    and not string.find(v94, "box") then
    table.insert(v7.Data.FertilizerNames, name)
  end
end

v7.Data.EggPrices, v7.Data.EggNames = f27()
v7.Data.PetRegistry = f28()
v7.Data.PetNames = {}

for index27, value37 in ipairs(v7.Data.PetRegistry) do
  table.insert(v7.Data.PetNames, value37.Name)
end

v7.Data.PetSizeNames = f29(v7.Data.PetRegistry)
v7.Data.PetRarityLookup = {}

for index28, value38 in ipairs(v7.Data.PetRegistry) do
  v7.Data.PetRarityLookup[value38.Name] = value38.Rarity
end

v7.Data.PetRarityNames = {}

do
  local v95 = {}

  for index29, value39 in ipairs(v7.Data.PetRegistry) do
    local rarity = value39.Rarity

    if rarity and not v95[rarity] then
      v95[rarity] = true
      table.insert(v7.Data.PetRarityNames, rarity)
    end
  end
end

v7.Data.CompostConfig = f25()
v7.Data.CompostLevelNames = {}

for index30, value40 in ipairs(v7.Data.CompostConfig.LevelNames) do
  table.insert(v7.Data.CompostLevelNames, value40)
end

v7.Data.CompostCooldownDuration = v7.Data.CompostConfig.CooldownDuration
v7.Data.CompostCooldownEndsAt = {}
v7.Data.MutationRegistry = f24()

for index31, value41 in ipairs(v7.Data.MutationRegistry) do
  table.insert(v7.Data.MutationNames, value41.Name)
end

local v96 = f34()

if v96 and v96.Shop and v96.Shop.Items then
  for index32, value42 in ipairs(v96.Shop.Items) do
    local displayName3 = value42.DisplayName
    table.insert(v7.Data.GuildShopItemNames, displayName3)
    v7.Data.GuildShopItemIdMap[displayName3] = value42.Id
  end
end

v7.Data.ZooRushPetNames, v7.Data.ZooRushPetRate = f30()
v7.Data.PetMutationRarityConfig, v7.Data.PetMutationNames, v7.Data.PetMutationConfig = f33()
v7.Data.WanderingMerchantConfig, v7.Data.WanderingMerchantItemNames, v7.Data.WanderingMerchantItemIdMap = f35()
v7.Data.NightMarketConfig, v7.Data.NightMarketItemNames, v7.Data.NightMarketItemIdMap = f36()

f37()

local function f41()
  pcall(function()
    if v7.Connections.RollSeedsConnection then
      v7.Connections.RollSeedsConnection:Disconnect()
    end

    v7.Connections.RollSeedsConnection = replicatedStorage.Remotes.RollSeeds.OnClientEvent:Connect(function(p38)
      if type(p38) ~= "table" then
        return
      end

      if type(p38.Slots) ~= "table" or #p38.Slots == 0 then
        return
      end

      v7.Data.CurrentRollId = p38.RollId
      v7.Data.Gacha.RollData = p38
      v7.Data.Gacha.RollReady = true
    end)
  end)

  pcall(function()
    if v7.Connections.BuySeedConnection then
      v7.Connections.BuySeedConnection:Disconnect()
    end

    v7.Connections.BuySeedConnection = replicatedStorage.Remotes.BuySeed.OnClientEvent:Connect(function(p39, p40)
      if type(p39) == "number" then
        v7.Data.Gacha.BuyResults[p39] = p40 == true
      end
    end)
  end)
end

local function f42(p41)
  if not p41 then
    return nil
  end

  local petKey = p41:GetAttribute("PetKey") or p41:GetAttribute("petKey")

  if not petKey then
    local v97 = string.split(p41.Name, "_")
    petKey = v97[#v97]
  end

  local trueName = p41:GetAttribute("TrueName") or p41:GetAttribute("trueName")
    or p41:GetAttribute("PetName") or p41:GetAttribute("petName") or p41.Name

  local level = tonumber(p41:GetAttribute("PetLevel")) or tonumber(p41:GetAttribute("petLevel"))
    or tonumber(p41:GetAttribute("Level")) or tonumber(p41:GetAttribute("level")) or 1

  local earnings = tonumber(p41:GetAttribute("EarningsMultiplier"))
    or tonumber(p41:GetAttribute("earningsMultiplier"))
    or tonumber(p41:GetAttribute("Earnings")) or tonumber(p41:GetAttribute("earnings")) or 0

  local floorIndex = tonumber(p41:GetAttribute("FloorIndex"))
    or tonumber(p41:GetAttribute("floorIndex"))

  local slotIndex = tonumber(p41:GetAttribute("SlotIndex"))
    or tonumber(p41:GetAttribute("slotIndex"))

  local petBoosted = p41:GetAttribute("PetBoosted") or p41:GetAttribute("petBoosted")

  if not petBoosted and petKey then
    local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

    if playerGui then
      for index33, value43 in ipairs(playerGui:GetChildren()) do
        if value43:IsA("BillboardGui") and value43.Adornee then
          local adornee = value43.Adornee

          while adornee do
            if adornee:IsA("Model")
              and (string.find(adornee.Name, "Pet_") or string.find(adornee.Name, "ClientPet_")) then
              local petKey2 = adornee:GetAttribute("PetKey") or adornee:GetAttribute("petKey")

              if not petKey2 then
                local v98 = string.split(adornee.Name, "_")
                petKey2 = v98[#v98]
              end

              if petKey2 == petKey then
                petBoosted = true
                break
              end
            end

            adornee = adornee.Parent
          end

          if petBoosted then
            break
          end
        end
      end
    end
  end

  local petBoostEndTimestamp = tonumber(p41:GetAttribute("PetBoostEndTimestamp"))
    or tonumber(p41:GetAttribute("petBoostEndTimestamp"))

  local petBoostMultiplier = tonumber(p41:GetAttribute("PetBoostMultiplier"))
    or tonumber(p41:GetAttribute("petBoostMultiplier"))

  local petOwner = p41:GetAttribute("PetOwner") or p41:GetAttribute("petOwner")
  local petSize = p41:GetAttribute("PetSize") or p41:GetAttribute("petSize")
  local petMutation = p41:GetAttribute("PetMutation") or p41:GetAttribute("petMutation")

  return {
    instance = p41,
    petKey = petKey,
    petName = trueName,
    level = level,
    earnings = earnings,
    floorIndex = floorIndex,
    slotIndex = slotIndex,
    petBoosted = petBoosted,
    petBoostEndTimestamp = petBoostEndTimestamp,
    petBoostMultiplier = petBoostMultiplier,
    petOwner = petOwner,
    petSize = petSize,
    rbxReimportId = p41:GetAttribute("RBX_ReimportId") or p41:GetAttribute("rbx_reimportid"),
    petMutation = petMutation,
  }
end

local function f43()
  local v99 = {}
  local v100 = f8()

  if not v100 then
    return v99
  end

  for index34, value44 in ipairs(v100:GetChildren()) do
    if string.sub(value44.Name, 1, 4) == "Pet_" then
      local v101 = f42(value44)

      if v101 then
        if not v101.petKey then
          local v102 = string.split(value44.Name, "_")
          v101.petKey = v102[#v102]
        end

        table.insert(v99, v101)
      end
    end
  end

  return v99
end

local function f44(p42)
  local function f45(p43)
    if not p43 then
      return nil
    end

    for index35, value45 in ipairs(p43:GetChildren()) do
      if value45:IsA("Tool") and string.find(value45.Name, p42, 1, true) then
        return value45
      end
    end

    return nil
  end

  return f45(localPlayer.Character) or f45(localPlayer:FindFirstChild("Backpack"))
end

local function f46(p44)
  if not p44 then
    return nil
  end

  local petKey3 = p44:GetAttribute("petKey") or p44:GetAttribute("PetKey")

  if not petKey3 then
    return nil
  end

  return {
    instance = p44,
    petKey = petKey3,
    petName = p44:GetAttribute("trueName") or p44:GetAttribute("TrueName")
      or p44:GetAttribute("PetName") or p44:GetAttribute("petName") or p44.Name,
    level = tonumber(p44:GetAttribute("Level")) or tonumber(p44:GetAttribute("PetLevel"))
      or tonumber(p44:GetAttribute("level")) or tonumber(p44:GetAttribute("petLevel")) or 1,
    earnings = tonumber(p44:GetAttribute("EarningsMultiplier"))
      or tonumber(p44:GetAttribute("earningsMultiplier")) or 0,
    petSize = p44:GetAttribute("PetSize") or p44:GetAttribute("petSize"),
    petMutation = p44:GetAttribute("PetMutation") or p44:GetAttribute("petMutation"),
    petOwner = p44:GetAttribute("PetOwner") or p44:GetAttribute("petOwner"),
  }
end

local function f47()
  local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")

  if humanoid then
    pcall(function() humanoid:UnequipTools() end)
  end
end

local function f48(p45)
  if p45 and p45.Parent ~= localPlayer.Character then
    local humanoid2 = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")

    if humanoid2 then
      humanoid2:EquipTool(p45)
      task.wait(0.2)
    end
  end
end

local function f49()
  local v103 = f31()

  if not v103 then
    return
  end

  if v103.CooldownUntilPath and v6 then
    local v104, v105 = pcall(v6.GetReplicator)

    if v104 and v105 then
      v7.Connections.FriendOTronCooldownObserver = v105:Observe(v103.CooldownUntilPath, function(p46)
        v7.Data.FriendOTronCooldownUntil = tonumber(p46) or 0
      end)

      v7.Connections.FriendOTronSpinsObserver = v105:Observe(v103.SpinsPath, function(p47)
        v7.Data.FriendOTronSpins = tonumber(p47) or 0
      end)

      if v103.PendingSeedKeyPath then
        v7.Connections.FriendOTronPendingSeedKeyObserver = v105:Observe(v103.PendingSeedKeyPath, function(p48)
          v7.Data.FriendOTronPendingSeedKey = tostring(p48 or "")
        end)
      end
    end
  end
end

local function f50()
  if v7.Cache.QueenBeeHoneyJarInsertPrompt and v7.Cache.QueenBeeHoneyJarInsertPrompt.Parent then
    return v7.Cache.QueenBeeHoneyJarInsertPrompt
  end

  v7.Cache.QueenBeeHoneyJarInsertPrompt = nil

  local honeyJarMachine = workspace:FindFirstChild("HoneyJarMachine")
    or workspace:FindFirstChild("Honey Jar Machine")

  if not honeyJarMachine then
    honeyJarMachine = workspace:FindFirstChild("InteractiveEvents")
      and workspace.InteractiveEvents:FindFirstChild("QueenBee")
      and workspace.InteractiveEvents.QueenBee:FindFirstChild("HoneyJarMachine")
      and workspace.InteractiveEvents.QueenBee.HoneyJarMachine:FindFirstChild("Honey Jar Machine")
  end

  local findFirstChildWhichIsA = honeyJarMachine
    and honeyJarMachine:FindFirstChildWhichIsA("ProximityPrompt", true)

  if not findFirstChildWhichIsA then
    return nil
  end

  v7.Cache.QueenBeeHoneyJarInsertPrompt = findFirstChildWhichIsA
  return v7.Cache.QueenBeeHoneyJarInsertPrompt
end

local function f51()
  if v7.Data.MegaSpinnerSpins and v7.Data.MegaSpinnerSpins > 0 then
    return v7.Data.MegaSpinnerSpins
  end

  if v6 then
    local v106, v107 = pcall(v6.GetReplicator)

    if v106 and v107 then
      return tonumber((v107:Get({ "InteractiveEvents", "MegaSpinner", "Spins" }))) or 0
    end
  end

  return 0
end

local function f52()
  if v7.Cache.MegaSpinnerPrompt and v7.Cache.MegaSpinnerPrompt.Parent then
    return v7.Cache.MegaSpinnerPrompt
  end

  v7.Cache.MegaSpinnerPrompt = nil
  local interactiveEvents = workspace:FindFirstChild("InteractiveEvents")
  local megaSpinner = interactiveEvents and interactiveEvents:FindFirstChild("MegaSpinner")
  local spinner = megaSpinner and megaSpinner:FindFirstChild("Spinner")

  local findFirstChildWhichIsA2 = spinner
    and spinner:FindFirstChildWhichIsA("ProximityPrompt", true)

  if not findFirstChildWhichIsA2 then
    return nil
  end

  v7.Cache.MegaSpinnerPrompt = findFirstChildWhichIsA2
  return v7.Cache.MegaSpinnerPrompt
end

local function f53(p49, p50, p51)
  if not p49 or not p50 then
    return
  end

  local cframe = p50:IsA("BasePart") and p50.CFrame or p50:IsA("Model") and p50:GetPivot()

  if not cframe then
    return
  end

  p49.CFrame = cframe
  task.wait(0.2)

  if p51 and p51:IsA("ProximityPrompt") then
    local holdDuration = p51.HoldDuration or 0
    local maxActivationDistance = p51.MaxActivationDistance
    local requiresLineOfSight = p51.RequiresLineOfSight

    p51.HoldDuration = 0
    p51.MaxActivationDistance = 99999
    p51.RequiresLineOfSight = false

    pcall(function() fireproximityprompt(p51) end)
    pcall(function() p51:InputHoldBegin() end)

    task.wait(holdDuration + 0.2)
    pcall(function() p51:InputHoldEnd() end)

    p51.HoldDuration = holdDuration
    p51.MaxActivationDistance = maxActivationDistance
    p51.RequiresLineOfSight = requiresLineOfSight
  end
end

local function f54()
  if v7.Cache.EventSignal then
    return v7.Cache.EventSignal
  end

  local v108, v109 = pcall(function()
    return require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"))
  end)

  if v108 and v109 then
    local v110, v111 = pcall(function() return v109.GetService("EventService") end)

    if v110 and v111 and v111.ClientEventSignal then
      v7.Cache.EventSignal = v111.ClientEventSignal
      return v7.Cache.EventSignal
    end
  end

  local v112, v113 = pcall(function()
    local index36 = replicatedStorage.Packages:FindFirstChild("_Index")
    local sleitnickKnit170 = index36 and index36:FindFirstChild("sleitnick_knit@1.7.0")

    if not sleitnickKnit170 then
      return nil
    end

    local re = sleitnickKnit170.knit:FindFirstChild("Services")
      and sleitnickKnit170.knit.Services:FindFirstChild("EventService")
      and sleitnickKnit170.knit.Services.EventService:FindFirstChild("RE")

    if not re then
      return nil
    end

    local clientEventSignal = re:FindFirstChild("ClientEventSignal")

    if not clientEventSignal then
      return nil
    end

    return {
      Connect = function(p52, p53) return clientEventSignal.OnClientEvent:Connect(p53) end,
      Fire = function(p54, p55) clientEventSignal:FireServer(p55) end,
    }
  end)

  if v112 and v113 then
    v7.Cache.EventSignal = v113
  end

  return v7.Cache.EventSignal
end

local function f55()
  if v7.Cache.EventController then
    return v7.Cache.EventController
  end

  local v114, v115 = pcall(function()
    return require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"))
  end)

  if v114 and v115 and v115.GetController then
    local v116, v117 = pcall(function() return v115.GetController("EventController") end)

    if v116 and v117 then
      v7.Cache.EventController = v117
      return v117
    end
  end

  return nil
end

local function f56(p56)
  local v118 = f55()

  if v118 and v118.isEventActive then
    local v119, v120 = pcall(function() return v118:isEventActive(p56) end)

    if v119 and type(v120) == "boolean" then
      return v120
    end
  end

  return nil
end

local function f57()
  local placeId = game.PlaceId
  local jobId = game.JobId

  if #game:GetService("Players"):GetPlayers() <= 1 then
    game.Players.LocalPlayer:Kick("\nRejoining... Don't click anything!")
    task.wait(1)
    game:GetService("TeleportService"):Teleport(placeId, game.Players.LocalPlayer)
  else
    pcall(function()
      game:GetService("TeleportService"):TeleportToPlaceInstance(
        placeId, jobId, game.Players.LocalPlayer
      )
    end)
  end
end

local function f58(p57)
  local index37 = replicatedStorage:FindFirstChild("Packages")
    and replicatedStorage.Packages:FindFirstChild("_Index")

  if not index37 then
    return nil
  end

  for index38, value46 in ipairs(index37:GetChildren()) do
    if string.find(value46.Name, "knit") then
      local knit = value46:FindFirstChild("knit")
      local services = knit and knit:FindFirstChild("Services")
      local findFirstChild4 = services and services:FindFirstChild(p57)
      local rf = findFirstChild4 and findFirstChild4:FindFirstChild("RF")

      if rf then
        return rf
      end
    end
  end

  return nil
end

local function f59(p58, p59, p60)
  local index39 = replicatedStorage:FindFirstChild("Packages")
    and replicatedStorage.Packages:FindFirstChild("_Index")

  if not index39 then
    return nil
  end

  for index40, value47 in ipairs(index39:GetChildren()) do
    if string.find(value47.Name, "knit") then
      local knit2 = value47:FindFirstChild("knit")
      local services2 = knit2 and knit2:FindFirstChild("Services")
      local findFirstChild5 = services2 and services2:FindFirstChild(p58)
      local findFirstChild6 = findFirstChild5 and findFirstChild5:FindFirstChild(p59)
      local findFirstChild7 = findFirstChild6 and findFirstChild6:FindFirstChild(p60)

      if findFirstChild7 then
        return findFirstChild7
      end
    end
  end

  return nil
end

local function f60()
  if v7.Cache.GuildServiceRF then
    return v7.Cache.GuildServiceRF
  end

  local guildService = f58("GuildService")

  if guildService then
    v7.Cache.GuildServiceRF = guildService
  end

  return guildService
end

local function f61(p61, ...)
  local v121 = f60()

  if not v121 then
    return nil
  end

  local findFirstChild8 = v121:FindFirstChild(p61)

  if not findFirstChild8 then
    return nil
  end

  local v122 = { ... }
  local v123, v124 = pcall(function() return findFirstChild8:InvokeServer(unpack(v122)) end)

  if v123 then
    return v124
  end

  return nil
end

local function f62()
  local v125 = tick()

  if v7.Cache.ReplicatorSnapshot and v7.Cache.ReplicatorSnapshotTime
    and v125 - v7.Cache.ReplicatorSnapshotTime < 0.5 then
    return v7.Cache.ReplicatorSnapshot
  end

  if v6 and v6.GetReplicator then
    local v126, v127 = pcall(function() return v6.GetReplicator():GetSnapshot() end)

    if v126 and v127 then
      v7.Cache.ReplicatorSnapshot = v127
      v7.Cache.ReplicatorSnapshotTime = v125
      return v127
    end
  end

  return nil
end

local function f63(p62)
  p62 = p62 or 3
  local v128 = tick()

  if v7.Cache.ReplicatorSnapshot and v7.Cache.ReplicatorSnapshotTime
    and v128 - v7.Cache.ReplicatorSnapshotTime < p62 then
    return v7.Cache.ReplicatorSnapshot
  end

  local v129 = f62()

  if v129 then
    v7.Cache.ReplicatorSnapshot = v129
    v7.Cache.ReplicatorSnapshotTime = v128
    return v129
  end

  return v7.Cache.ReplicatorSnapshot
end

local function f64()
  local v130, v131 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 2):WaitForChild("SeasonPassData", 2))
  end)

  if v130 and v131 then
    return v131
  end

  return nil
end

local function f65(p63)
  p63 = p63 or f64()
  local currency = p63 and p63.Currency or "Sparks"
  local v132 = f62()

  if v132 and v132.EventCurrencies and v132.EventCurrencies[currency] then
    return v132.EventCurrencies[currency]
  end

  local v133, v134 = pcall(function()
    return localPlayer.PlayerGui.MainUI.MoneyCounter.EventCurrency.CarnivalTokens
  end)

  local contentText2 = v133 and v134 and (v134.ContentText or v134.Text)
  return contentText2 and contentText2 ~= "" and f2(contentText2) or 0
end

local function f66()
  local v135 = f62()

  if v135 and v135.EventCurrencies and v135.EventCurrencies.Sparks then
    return v135.EventCurrencies.Sparks
  end

  if v6 then
    local v136, v137 = pcall(v6.GetReplicator)

    if v136 and v137 then
      local get = v137:Get({ "EventCurrencies", "Sparks" })

      if get then
        return get
      end
    end
  end

  return 0
end

local function f67()
  local v138 = f36()
  local v139 = f62()
  local nightMarketMerchant = v139 and v139.NightMarketMerchant
  local stock = nightMarketMerchant and nightMarketMerchant.Stock
  local purchased = nightMarketMerchant and nightMarketMerchant.Purchased or {}

  if stock and next(stock) ~= nil then
    local v140 = {}

    for index41, value48 in ipairs(v138 and v138.Items or {}) do
      v140[value48.Id] = tonumber(stock[value48.Id]) or 0
    end

    return v140
  end

  if v6 then
    local v141, v142 = pcall(v6.GetReplicator)

    if v141 and v142 then
      local get2 = v142:Get({ "NightMarketMerchant", "Stock" })

      if get2 and next(get2) ~= nil then
        local v143 = {}

        for index42, value49 in ipairs(v138 and v138.Items or {}) do
          v143[value49.Id] = tonumber(get2[value49.Id]) or 0
        end

        return v143
      end
    end
  end

  if v138 and type(v138.BuildStock) == "function" then
    local v144, v145 = pcall(v138.BuildStock, purchased)

    if v144 and type(v145) == "table" then
      return v145
    end
  end

  local v146 = {}

  for index43, value50 in ipairs(v138 and v138.Items or {}) do
    local stock2 = value50.Stock or 0

    if value50.OneTime then
      local v147 = tonumber(purchased[value50.Id]) or 0
      stock2 = math.max(0, stock2 - v147)
    end

    v146[value50.Id] = stock2
  end

  return v146
end

local function f68(p64)
  local v148 = f59("NightMarketMerchantService", "RF", "BuyItem")

  if v148 then
    local v149, v150 = pcall(function() return v148:InvokeServer(p64) end)
    return v149, v150
  end

  return false, "BuyItem RF not found"
end

local function f69(p65)
  if not p65 then
    return false
  end

  local v151 = nil

  if v6 and v6.GetReplicator then
    local v152, v153 = pcall(v6.GetReplicator)

    if v152 and v153 then
      v151 = v153
    end
  end

  local favorites = nil

  if v151 then
    local v154, v155 = pcall(function() return v151:Get({ "Favorites" }) end)

    if v154 and type(v155) == "table" then
      favorites = v155
    end
  end

  if not favorites then
    local v156 = f63(3)
    favorites = v156 and v156.Favorites
  end

  if type(favorites) ~= "table" then
    return false
  end

  local rodKey = p65:GetAttribute("RodKey")

  local seedKey = p65:GetAttribute("seedKey") or p65:GetAttribute("SeedKey")
    or p65:GetAttribute("petKey") or p65:GetAttribute("PetKey") or p65:GetAttribute("gearKey")
    or p65:GetAttribute("GearKey") or p65:GetAttribute("key") or p65:GetAttribute("Key")
    or rodKey and "rod:" .. tostring(rodKey)

  if seedKey then
    return favorites[tostring(seedKey)] == true
  end

  return false
end

local function f70()
  if v7.Cache.CompostCooldownClient then
    return v7.Cache.CompostCooldownClient
  end

  local starterPlayer2 = game:GetService("StarterPlayer")
  local starterPlayerScripts2 = starterPlayer2:FindFirstChild("StarterPlayerScripts")

  local clientLoader = starterPlayerScripts2
    and starterPlayerScripts2:FindFirstChild("ClientLoader")

  local handlers = clientLoader and clientLoader:FindFirstChild("Handlers")
  local compostCooldownClient = handlers and handlers:FindFirstChild("CompostCooldownClient")

  if compostCooldownClient then
    local v157, v158 = pcall(require, compostCooldownClient)

    if v157 then
      v7.Cache.CompostCooldownClient = v158
      return v158
    end
  end

  return nil
end

local function f71(p66)
  local v159 = f62()

  if not v159 then
    local v160 = f70()

    if v160 and v160.GetRemaining then
      return v160.GetRemaining(p66)
    end

    local v161 = v7.Data.CompostCooldownEndsAt[p66] or 0
    return math.max(0, v161 - workspace:GetServerTimeNow())
  end

  local composter = v159.Composter and v159.Composter[tostring(p66)]

  if composter then
    if composter.CooldownEndsAt then
      return math.max(0, math.floor(composter.CooldownEndsAt - workspace:GetServerTimeNow()))
    end

    return 0
  end

  return 0
end

local function f72(p67)
  local v162 = f8()

  if not v162 then
    return nil
  end

  if p67 == 1 then
    return v162:FindFirstChild("FarmPlot")
  else
    local v163 = v9.FLOOR_NAMES[p67]

    if v163 then
      local findFirstChild9 = v162:FindFirstChild(v163)

      if findFirstChild9 then
        return findFirstChild9:FindFirstChild("FarmPlot")
      end
    end
  end

  return nil
end

local function f73(p68)
  if not p68 then
    return {}
  end

  local v164 = os.clock()

  if v7.Cache.DirtNodes[p68] and v164 - (v7.Cache.DirtNodesTime[p68] or 0) < 3 then
    return v7.Cache.DirtNodes[p68]
  end

  local v165 = {}

  for index44, value51 in ipairs(p68:GetChildren()) do
    if string.match(value51.Name, "^Plot%d+$") then
      local dirt = value51:FindFirstChild("Dirt")

      if dirt then
        table.insert(v165, dirt)
      end
    end
  end

  v7.Cache.DirtNodes[p68] = v165
  v7.Cache.DirtNodesTime[p68] = v164

  return v165
end

local function f74()
  if v7.Flags.IsSellCratesLoopRunning then
    return
  end

  v7.Flags.IsSellCratesLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoSellCrates.Value do
      pcall(function()
        if replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("SellCrates") then
          replicatedStorage.Remotes.SellCrates:FireServer()
        end
      end)

      task.wait(8)
    end

    v7.Flags.IsSellCratesLoopRunning = false
  end)
end

local function f75()
  if v7.Flags.IsBuyGearsLoopRunning then
    return
  end

  if not v2.Options.Toggle_AutoBuySelectedGears.Value then
    return
  end

  v7.Flags.IsBuyGearsLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoBuySelectedGears.Value do
      pcall(function()
        if v2.Unloaded then
          return
        end

        local transaction = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("Gear")
          and replicatedStorage.Remotes.Gear:FindFirstChild("Transaction")

        if not transaction then
          return
        end

        local findFirstChild10 = replicatedStorage:FindFirstChild("GearStocks")
          and replicatedStorage.GearStocks:FindFirstChild(localPlayer.Name)

        if not findFirstChild10 then
          return
        end

        local v166 = {}
        local value52 = v2.Options.Dropdown_TargetBuyGears.Value

        if type(value52) == "table" then
          for key12, value53 in pairs(value52) do
            if value53 == true then
              table.insert(v166, key12)
            end
          end
        end

        for index45, value54 in ipairs(v166) do
          if v2.Unloaded or not v2.Options.Toggle_AutoBuySelectedGears.Value then
            break
          end

          local findFirstChild11 = findFirstChild10:FindFirstChild(value54)

          if (findFirstChild11 and tonumber(findFirstChild11.Value) or 0) > 0 then
            if f6(v7.Data.GearCosts[value54] or 0) then
              pcall(function() transaction:InvokeServer(value54) end)
              task.wait(0.1)
            end
          end
        end
      end)

      task.wait(0.5)
    end

    v7.Flags.IsBuyGearsLoopRunning = false
  end)
end

local function f76()
  if v7.Flags.IsEggShopBuyLoopRunning then
    return
  end

  if not v2.Options.Toggle_AutoBuySelectedEggs.Value then
    return
  end

  v7.Flags.IsEggShopBuyLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoBuySelectedEggs.Value do
      pcall(function()
        local petMerchant = workspace:FindFirstChild("PetMerchant")

        local transaction2 = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("EggShop")
          and replicatedStorage.Remotes.EggShop:FindFirstChild("Transaction")

        local rollEgg = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("RollEgg")

        if petMerchant and transaction2 and rollEgg then
          local value55 = v2.Options.Dropdown_TargetEggShopEggs.Value

          if type(value55) == "table" and next(value55) ~= nil then
            for i = 1, 5 do
              if not v2.Options.Toggle_AutoBuySelectedEggs.Value then
                break
              end

              local findFirstChild12 = petMerchant:FindFirstChild("Podium" .. i .. "Stock")
                or petMerchant:FindFirstChild("Podium" .. i)

              local findFirstChild13 = findFirstChild12
                and findFirstChild12:FindFirstChild("EggLabel", true)

              local text = findFirstChild13 and findFirstChild13.Text

              if text and text ~= "" then
                local v167 = nil
                local v168 = string.gsub(string.lower(text), " ", "")

                for index46, value56 in ipairs(v7.Data.EggNames) do
                  local v169 = string.gsub(string.lower(value56), " ", "")

                  if string.find(v168, v169, 1, true) then
                    v167 = value56
                    break
                  end
                end

                if not v167 then
                  v167 = string.gsub(text, " ", "")
                end

                if value55[v167] then
                  if f6(v7.Data.EggPrices[v167] or 0) then
                    if pcall(function() transaction2:InvokeServer("BuyEgg", i) end) then
                      pcall(function() rollEgg:FireServer(v167) end)
                      task.wait(0.1)
                      pcall(function() rollEgg:FireServer(v167, "ClaimRolledPet") end)
                    end

                    task.wait(0.2)
                  end
                end
              end
            end
          end
        end
      end)

      task.wait(5)
    end

    v7.Flags.IsEggShopBuyLoopRunning = false
  end)
end

local function f77()
  if v7.Flags.IsAutoBuyNightMarketRunning then
    return
  end

  if not (v2.Options.Toggle_AutoBuyNightMarket and v2.Options.Toggle_AutoBuyNightMarket.Value) then
    return
  end

  v7.Flags.IsAutoBuyNightMarketRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoBuyNightMarket
      and v2.Options.Toggle_AutoBuyNightMarket.Value do
      pcall(function()
        local v170 = f36()

        if v170 and type(v170.IsOpen) == "function" and not v170.IsOpen() then
          return
        end

        local value57 = v2.Options.Dropdown_TargetNightMarketItems
            and v2.Options.Dropdown_TargetNightMarketItems.Value
          or {}

        if type(value57) ~= "table" or next(value57) == nil then
          return
        end

        local v171 = f66()
        local v172 = f67()
        local items = v170 and v170.Items or {}
        local v173 = false

        for index47, value58 in ipairs(items) do
          if not (v2.Options.Toggle_AutoBuyNightMarket and v2.Options.Toggle_AutoBuyNightMarket.Value) then
            break
          end

          if value57[value58.DisplayName or value58.Id] or value57[value58.Id] then
            local v174 = v172[value58.Id] or 0
            local v175 = tonumber(value58.Cost) or 0

            while v174 > 0 and v171 >= v175 and v2.Options.Toggle_AutoBuyNightMarket
              and v2.Options.Toggle_AutoBuyNightMarket.Value do
              local v176, v177 = f68(value58.Id)

              if v176 and (type(v177) ~= "table" or v177.ok ~= false) then
                v173 = true
                v174 = v174 - 1
                v172[value58.Id] = v174
                v171 = math.max(0, v171 - v175)
                v7.Cache.ReplicatorSnapshotTime = 0
                task.wait(0.5)
              else
                break
              end
            end
          end
        end

        if not v173 then
          task.wait(5)
        else
          task.wait(1)
        end
      end)

      task.wait(2)
    end

    v7.Flags.IsAutoBuyNightMarketRunning = false
  end)
end

local function f78()
  if v7.Flags.IsSeedGachaLoopRunning then
    return
  end

  if not v2.Options.Toggle_AutoGachaAll.Value then
    return
  end

  v7.Flags.IsSeedGachaLoopRunning = true

  local function f79(p69)
    if not p69 or p69 == "" then
      return 0
    end

    for index48, value59 in ipairs(v7.Data.PlantRegistry) do
      if value59.Name == p69 then
        return tonumber(value59.Cost) or tonumber(value59.Price) or 0
      end
    end

    return 0
  end

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoGachaAll.Value do
      local v178 = false

      repeat
        v7.Data.Gacha.RollReady = false
        v7.Data.Gacha.RollData = nil
        v7.Data.CurrentRollId = nil

        pcall(function() replicatedStorage.Remotes.RollSeeds:FireServer() end)
        local total = 0

        while not v7.Data.Gacha.RollReady and total < 3 do
          task.wait(0.1)
          total = total + 0.1
        end

        if not v7.Data.Gacha.RollReady then
          task.wait(0.5)
          v178 = true
          break
        end

        local rollData = v7.Data.Gacha.RollData

        if not rollData or not rollData.Slots or #rollData.Slots == 0 then
          task.wait(0.5)
          v178 = true
          break
        end

        local rollId = rollData.RollId
        task.wait(0.1)
        pcall(function() replicatedStorage.Remotes.RollAnimationDone:FireServer(rollId) end)
        local count2 = 0

        for index49, value60 in ipairs(rollData.Slots) do
          if not v2.Options.Toggle_AutoGachaAll.Value then
            break
          end

          if f6((f79(value60.Seed))) then
            v7.Data.Gacha.BuyResults[index49] = nil
            pcall(function() replicatedStorage.Remotes.BuySeed:FireServer(index49, rollId) end)
            local total2 = 0

            while v7.Data.Gacha.BuyResults[index49] == nil and total2 < 2 do
              task.wait(0.1)
              total2 = total2 + 0.1
            end

            if v7.Data.Gacha.BuyResults[index49] then
              count2 = count2 + 1
            end

            task.wait(0.5)
          end
        end

        if count2 == 0 then
          task.wait(3)
        end

        v178 = true
      until true

      if not v178 then
        break
      end
    end

    v7.Flags.IsSeedGachaLoopRunning = false
  end)
end

local function f80(p70)
  if not p70 then
    return "Unknown"
  end

  return v7.Data.PlantRarityLookup[string.lower(tostring(p70))] or "Unknown"
end

local function f81(p71)
  if not p71 then
    return nil
  end

  return v7.Data.PetRarityLookup[p71]
end

local function f82()
  if v7.Flags.IsAutoFeedPetsLoopRunning then
    return
  end

  if not v2.Options.Toggle_AutoFeedPets.Value then
    return
  end

  v7.Flags.IsAutoFeedPetsLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoFeedPets.Value do
      pcall(function()
        local usePetTreat = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("UsePetTreat")

        local humanoid3 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("Humanoid")

        local value61 = v2.Options.Dropdown_PetTreatTypes.Value

        if usePetTreat and humanoid3 and type(value61) == "table" and next(value61) ~= nil then
          local v179 = f43()
          local v180 = false

          for index50, value62 in ipairs(v179) do
            if not v2.Options.Toggle_AutoFeedPets.Value then
              break
            end

            if not value62.petBoosted then
              for key13, value63 in pairs(value61) do
                if value63 then
                  local v181 = f44(key13)

                  if v181 then
                    if not v180 then
                      humanoid3:EquipTool(v181)
                      task.wait(0.2)
                      v180 = true
                    end

                    pcall(function() usePetTreat:FireServer(value62.instance) end)
                    task.wait(0.2)
                    break
                  end
                end
              end
            end
          end

          if v180 then
            pcall(function() humanoid3:UnequipTools() end)
          end
        end
      end)

      task.wait(2)
    end

    v7.Flags.IsAutoFeedPetsLoopRunning = false
  end)
end

local function f83()
  if v7.Flags.IsAutoUpgradePetsLoopRunning then
    return
  end

  if not v2.Options.Toggle_AutoUpgradePets.Value then
    return
  end

  v7.Flags.IsAutoUpgradePetsLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoUpgradePets.Value do
      pcall(function()
        local upgradePet = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("Pets")
          and replicatedStorage.Remotes.Pets:FindFirstChild("UpgradePet")

        if upgradePet then
          local v182 = f43()
          local v183 = tonumber(v2.Options.Input_PetUpgradeLevel.Value) or 10
          local v184 = f32()

          for index51, value64 in ipairs(v182) do
            local v185 = false

            repeat
              if not v2.Options.Toggle_AutoUpgradePets.Value then
                break
              end

              if value64.petName == "Plant Rush Golem" or string.find(value64.petName, "Golem") then
                v185 = true
                break
              end

              if value64.level < v183 then
                local calculatePetUpgradePrice = v184 and v184.CalculatePetUpgradePrice and v184.CalculatePetUpgradePrice(
                  value64.petName, value64.level
                )

                if calculatePetUpgradePrice and not f6(calculatePetUpgradePrice) then
                  v185 = true
                  break
                end

                pcall(function()
                  if upgradePet:IsA("RemoteFunction") then
                    upgradePet:InvokeServer(value64.petKey)
                  elseif upgradePet:IsA("RemoteEvent") then
                    upgradePet:FireServer(value64.petKey)
                  end
                end)

                task.wait(0.1)
              end

              v185 = true
            until true

            if not v185 then
              break
            end
          end
        end
      end)

      task.wait(2)
    end

    v7.Flags.IsAutoUpgradePetsLoopRunning = false
  end)
end

local function f84()
  if v7.Flags.IsAutoSellPetsLoopRunning then
    return
  end

  v7.Flags.IsAutoSellPetsLoopRunning = true

  local function f85()
    local v186 = {}
    local v187 = {}

    local function f86(p72)
      if not p72 then
        return
      end

      for index52, value65 in ipairs(p72:GetChildren()) do
        if value65:IsA("Tool") then
          local v188 = f42(value65)

          if v188 and v188.petKey and not v187[v188.petKey] then
            v187[v188.petKey] = true
            table.insert(v186, v188)
          end
        end
      end
    end

    f86(localPlayer.Character)
    f86(localPlayer:FindFirstChild("Backpack"))

    return v186
  end

  task.spawn(function()
    while not v2.Unloaded
      and (v2.Options.Toggle_PetSellFilterName.Value
        or v2.Options.Toggle_PetSellFilterRarity.Value
        or v2.Options.Toggle_PetSellFilterSize.Value) do
      pcall(function()
        local sellPet = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("SellPet")

        if not sellPet then
          return
        end

        local v189 = f85()

        if #v189 == 0 then
          return
        end

        local value66 = v2.Options.Dropdown_PetSellSelection.Value
        local value67 = v2.Options.Dropdown_PetSellRarities.Value
        local value68 = v2.Options.Dropdown_PetSellSizes.Value
        local value69 = v2.Options.Toggle_PetSellFilterName.Value
        local value70 = v2.Options.Toggle_PetSellFilterRarity.Value
        local value71 = v2.Options.Toggle_PetSellFilterSize.Value

        if value69 and (type(value66) ~= "table" or next(value66) == nil)
          or value70 and (type(value67) ~= "table" or next(value67) == nil)
          or value71 and (type(value68) ~= "table" or next(value68) == nil)
          or not value69 and not value70 and not value71 then
          return
        end

        for index53, value72 in ipairs(v189) do
          local v190 = false

          repeat
            if not (v2.Options.Toggle_PetSellFilterName.Value
              or v2.Options.Toggle_PetSellFilterRarity.Value
              or v2.Options.Toggle_PetSellFilterSize.Value) then
              break
            end

            if not value72.petKey then
              v190 = true
              break
            end

            local v191 = false

            if value69 and value72.petName then
              local v192 = string.lower(value72.petName)

              for key14, value73 in pairs(value66) do
                if value73 and string.find(v192, string.lower(key14), 1, true) then
                  v191 = true
                  break
                end
              end
            elseif value70 then
              local v193 = f81(value72.petName)

              if v193 and value67[v193] then
                v191 = true
              end
            elseif value71 then
              if value68[tostring(value72.petSize or "")] then
                v191 = true
              end
            end

            if v191 then
              pcall(function()
                if sellPet:IsA("RemoteEvent") then
                  sellPet:FireServer(value72.petKey)
                else
                  task.spawn(function() sellPet:InvokeServer(value72.petKey) end)
                end
              end)

              task.wait(0.1)
            end

            v190 = true
          until true

          if not v190 then
            break
          end
        end
      end)

      task.wait(5)
    end

    v7.Flags.IsAutoSellPetsLoopRunning = false
  end)
end

local function f87(p73)
  local v194 = f72(p73)

  if v194 then
    local count3 = 0

    while count3 < 5 do
      local v195 = false

      for index54, value74 in ipairs(v194:GetChildren()) do
        if string.match(value74.Name, "^Plot(%d+)$") then
          local dirt2 = value74:FindFirstChild("Dirt")

          if dirt2 and dirt2:GetAttribute("PlantLevel") ~= nil then
            v195 = true

            pcall(function()
              if replicatedStorage:FindFirstChild("Remotes")
                and replicatedStorage.Remotes:FindFirstChild("RemovePlant") then
                replicatedStorage.Remotes.RemovePlant:FireServer(dirt2)
              end
            end)

            task.wait(0.2)
          end
        end
      end

      if not v195 then
        v2:Notify({
          Title = "Floor Manager",
          Content = "All plants on Floor " .. tostring(p73) .. " have been removed.",
          Duration = 3,
        })

        break
      end

      count3 = count3 + 1
      task.wait(1)
    end
  end
end

local function f88()
  if v7.Flags.IsAutoPlantLoopRunning then
    return
  end

  v7.Flags.IsAutoPlantLoopRunning = true

  local function f89(p74)
    local character = localPlayer.Character
    local humanoid4 = character and character:FindFirstChild("Humanoid")

    if not character or not humanoid4 then
      return nil
    end

    local tool = character:FindFirstChildWhichIsA("Tool")

    if tool and tool:GetAttribute("InventoryCategory") == "Seeds"
      and tool:GetAttribute("trueName") == p74 then
      return tool
    end

    if tool then
      pcall(function() humanoid4:UnequipTools() end)
      task.wait(0.1)
    end

    if localPlayer:FindFirstChild("Backpack") then
      for key15, value75 in pairs(localPlayer.Backpack:GetChildren()) do
        if value75:IsA("Tool") and value75:GetAttribute("InventoryCategory") == "Seeds"
          and value75:GetAttribute("trueName") == p74 then
          pcall(function() humanoid4:EquipTool(value75) end)
          task.wait(0.3)
          return value75
        end
      end
    end

    return nil
  end

  task.spawn(function()
    task.wait(1)

    while not v2.Unloaded do
      local value76 = v2.Options.Dropdown_SelectedFloors.Value
      local v196 = false

      for j = 1, 5 do
        local v197 = "Floor " .. j

        if type(value76) ~= "table" or value76[v197] == true then
          if v2.Options.Toggle_AutoPlantBest.Value then
            v196 = true
            local v198 = f72(j)

            if v198 then
              local v199 = {}

              for index55, value77 in ipairs(v198:GetChildren()) do
                if string.match(value77.Name, "^Plot(%d+)$") then
                  local dirt3 = value77:FindFirstChild("Dirt")

                  if dirt3 and dirt3:GetAttribute("PlantLevel") == nil then
                    table.insert(v199, dirt3)
                  end
                end
              end

              if #v199 > 0 then
                local function f90()
                  local character2, backpack = localPlayer.Character, localPlayer:FindFirstChild("Backpack")
                  local v200 = { character2, backpack }
                  local v201 = {}

                  for index56, value78 in ipairs(v200) do
                    if value78 then
                      for index57, value79 in ipairs(value78:GetChildren()) do
                        if value79:IsA("Tool")
                          and value79:GetAttribute("InventoryCategory") == "Seeds" then
                          local trueName2 = value79:GetAttribute("trueName")

                          if trueName2 then
                            local price = 0

                            for index58, value80 in ipairs(v7.Data.PlantRegistry) do
                              if value80.Name == trueName2 then
                                price = value80.Price or 0
                                break
                              end
                            end

                            table.insert(v201, { TrueName = trueName2, Weight = price })
                          end
                        end
                      end
                    end
                  end

                  if #v201 > 0 then
                    table.sort(v201, function(p75, p76) return p75.Weight > p76.Weight end)
                    return v201[1].TrueName
                  end

                  return nil
                end

                local v202 = false

                for index59, value81 in ipairs(v199) do
                  if not v2.Options.Toggle_AutoPlantBest.Value then
                    break
                  end

                  if value81:GetAttribute("PlantLevel") == nil then
                    local v203 = f90()

                    if v203 then
                      if f89(v203) then
                        v202 = true

                        pcall(function()
                          replicatedStorage.Remotes.PlantSeed:FireServer(value81)
                        end)

                        task.wait(0.5)
                      end
                    else
                      break
                    end
                  end
                end

                if v202 then
                  local humanoid5 = localPlayer.Character
                    and localPlayer.Character:FindFirstChild("Humanoid")

                  if humanoid5 then
                    pcall(function() humanoid5:UnequipTools() end)
                  end

                  task.wait(0.1)
                end
              end
            end

            task.wait(0.2)
          end
        end
      end

      if not v196 then
        break
      end

      task.wait(5)
    end

    v7.Flags.IsAutoPlantLoopRunning = false
  end)
end

local function f91()
  if v7.Flags.IsUpgradePlantsLoopRunning then
    return
  end

  v7.Flags.IsUpgradePlantsLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded do
      local value82 = v2.Options.Dropdown_SelectedFloors.Value
      local v204 = false
      local v205 = f32()

      for k = 1, 5 do
        local v206 = "Floor " .. k

        if type(value82) ~= "table" or value82[v206] == true then
          if v2.Options.Toggle_AutoUpgradeAll.Value then
            v204 = true
            local v207 = f72(k)

            if v207 then
              local v208 = tonumber(v2.Options.Input_MaxUpgradeLevel.Value) or 100

              for index60, value83 in ipairs((f73(v207))) do
                if not v2.Options.Toggle_AutoUpgradeAll.Value then
                  break
                end

                local v209 = tonumber(value83:GetAttribute("PlantLevel"))

                if v209 and v209 < v208 then
                  local plantName = value83:GetAttribute("PlantName") or ""

                  local calculateSeedUpgradePrice = v205 and v205.CalculateSeedUpgradePrice and v205.CalculateSeedUpgradePrice(
                    plantName, v209
                  ) or 0

                  if calculateSeedUpgradePrice > 0 and f5() >= calculateSeedUpgradePrice then
                    pcall(function()
                      replicatedStorage.Remotes.UpgradePlant:InvokeServer(value83)
                    end)

                    task.wait(0.2)
                  end
                end
              end
            end
          end
        end
      end

      if not v204 then
        break
      end

      task.wait(0.5)
    end

    v7.Flags.IsUpgradePlantsLoopRunning = false
  end)
end

local function f92(p77, p78)
  local plotKey = p77.Parent and p77.Parent:GetAttribute("PlotKey")
    or p77:GetAttribute("DupeDebugId")

  if plotKey then
    local v210 = p78 == 1 and tostring(plotKey) or "F" .. p78 .. "_" .. tostring(plotKey)
    local v211 = f63(1)

    local plants = v211 and v211.FarmData and v211.FarmData.Plants
      and v211.FarmData.Plants[v210]

    if plants and plants.Fertilizer and plants.Fertilizer.EndsAt
      and plants.Fertilizer.EndsAt > workspace:GetServerTimeNow() then
      return true
    end
  end

  local playerGui2 = localPlayer:FindFirstChildOfClass("PlayerGui")

  if playerGui2 then
    for index61, value84 in ipairs(playerGui2:GetChildren()) do
      if value84:IsA("BillboardGui") and value84.Name == "FertilizerBoost" and value84.Adornee
        and (value84.Adornee == p77 or value84.Adornee:IsDescendantOf(p77)) then
        return true
      end
    end
  end

  return false
end

local function f93(p79)
  if not p79 then
    return nil
  end

  for key16, value85 in pairs(p79) do
    if value85 then
      local v212 = f44(key16)

      if v212 then
        local v213 = string.match(v212.Name, "%(x(%d+)%)")

        if not (v213 and tonumber(v213) == 0) then
          return v212
        end
      end
    end
  end

  return nil
end

local function f94()
  if v7.Flags.IsFertilizePlantsLoopRunning then
    return
  end

  v7.Flags.IsFertilizePlantsLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded do
      local value86 = v2.Options.Dropdown_SelectedFloors.Value
      local v214 = false

      for m = 1, 5 do
        local v215 = "Floor " .. m

        if type(value86) ~= "table" or value86[v215] == true then
          if v2.Options.Toggle_AutoFertilize.Value then
            v214 = true
            local v216 = f72(m)

            if v216 then
              local value87 = v2.Options.Dropdown_FertilizerTypes.Value

              if next(value87) ~= nil then
                local v217 = f73(v216)
                local v218 = false

                for index62, value88 in ipairs(v217) do
                  local v219 = false

                  repeat
                    if not v2.Options.Toggle_AutoFertilize.Value then
                      break
                    end

                    if f92(value88, m) then
                      v219 = true
                      break
                    end

                    local plantName2 = value88:GetAttribute("PlantName")

                    if plantName2 and plantName2 ~= "" then
                      local v220 = f93(value87)

                      if v220 then
                        local humanoid6 = localPlayer.Character
                          and localPlayer.Character:FindFirstChild("Humanoid")

                        if humanoid6 then
                          if v220.Parent ~= localPlayer.Character then
                            pcall(function() humanoid6:EquipTool(v220) end)
                            task.wait(0.2)
                            v218 = true
                          end

                          pcall(function()
                            replicatedStorage.Remotes.UseFertilizer:FireServer(value88)
                          end)

                          task.wait(0.5)
                        end
                      else
                        break
                      end
                    end

                    v219 = true
                  until true

                  if not v219 then
                    break
                  end
                end

                if v218 then
                  local humanoid7 = localPlayer.Character
                    and localPlayer.Character:FindFirstChild("Humanoid")

                  if humanoid7 then
                    pcall(function() humanoid7:UnequipTools() end)
                  end

                  task.wait(0.1)
                end
              end
            end
          end
        end
      end

      if not v214 then
        break
      end

      task.wait(1)
    end

    v7.Flags.IsFertilizePlantsLoopRunning = false
  end)
end

local function f95(p80, p81, p82)
  local configuration = v8.Configuration

  if not configuration or not configuration.FloorConfig then
    return nil
  end

  local v221 = configuration.FloorConfig[p80]

  if not v221 then
    return nil
  end

  local plotUnlockBase = v221.PlotUnlockBase

  if not plotUnlockBase then
    return nil
  end

  local v222 = 1

  if p82 == 2 then
    v222 = 2
  elseif p82 == 3 then
    v222 = 3
  end

  local v223 = plotUnlockBase[v222] or plotUnlockBase[1]

  if not v223 then
    return nil
  end

  local plotUnlockLocalCurve = v221.PlotUnlockLocalCurve

  local v224 = v223
    * (plotUnlockLocalCurve and plotUnlockLocalCurve.Growth or v221.PlotUnlockGrowth)
      ^ ((plotUnlockLocalCurve and plotUnlockLocalCurve.StartIndex or 1) + p81 - 1)

  return math.floor(v224)
end

local function f96()
  if v7.Flags.IsUnlockFarmPlotsLoopRunning then
    return
  end

  v7.Flags.IsUnlockFarmPlotsLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded do
      local value89 = v2.Options.Dropdown_SelectedFloors.Value
      local v225 = false

      for n = 1, 5 do
        local v226 = "Floor " .. n

        if type(value89) ~= "table" or value89[v226] == true then
          if v2.Options.Toggle_AutoUnlockFarmPlots.Value then
            v225 = true
            local v227 = f72(n)

            if v227 then
              local count4 = 0
              local v228 = {}

              for index63, value90 in ipairs(v227:GetChildren()) do
                if not v2.Options.Toggle_AutoUnlockFarmPlots.Value then
                  break
                end

                local v229 = tonumber(value90.Name:match("^Plot(%d+)$"))

                if v229 then
                  if value90:GetAttribute("Unlocked") == true then
                    count4 = count4 + 1
                  else
                    table.insert(v228, { node = value90, index = v229 })
                  end
                end
              end

              for index64, value91 in ipairs(v228) do
                if not v2.Options.Toggle_AutoUnlockFarmPlots.Value then
                  break
                end

                local dirt4 = value91.node:FindFirstChild("Dirt")
                local v230 = f95(n, count4, value91.index)

                if dirt4 and v230 and f5() >= v230 then
                  pcall(function() replicatedStorage.Remotes.UnlockPlot:FireServer(dirt4) end)
                  task.wait(0.5)
                else
                  task.wait(3)
                end
              end
            end
          end
        end
      end

      if not v225 then
        break
      end

      task.wait(2)
    end

    v7.Flags.IsUnlockFarmPlotsLoopRunning = false
  end)
end

local function f97(p83, p84)
  local v231 = f62()

  local floors = v231 and v231.FarmData and v231.FarmData.Floors
    and v231.FarmData.Floors[tostring(p84)]

  local v232 = f32()
  local v233 = f37()

  if p83 == "SawYield" then
    if v232 and v232.CalculateExtraYieldCost and floors then
      return v232.CalculateExtraYieldCost(floors.SawYield or 1, "Floor" .. p84)
    end
  elseif p83 == "SprinklerPower" then
    if v232 and v232.CalculateExtraPowerCost and floors then
      return v232.CalculateExtraPowerCost(floors.SprinklerPower or 1, "Floor" .. p84)
    end
  elseif p83 == "SawRange" then
    if v233 and v233.FloorConfig and floors then
      local sawRange = floors.SawRange or 1

      if v233.MAX_RANGE and sawRange >= v233.MAX_RANGE then
        return "MAX"
      end

      local v234 = v233.FloorConfig[p84]

      if v234 and v234.ExtraSawRangeCosts then
        return v234.ExtraSawRangeCosts[sawRange + 1]
      end
    end
  elseif p83 == "SprinklerRange" then
    if v233 and v233.FloorConfig and floors then
      local sprinklerRange = floors.SprinklerRange or 1

      if v233.MAX_RANGE and sprinklerRange >= v233.MAX_RANGE then
        return "MAX"
      end

      local v235 = v233.FloorConfig[p84]

      if v235 and v235.ExtraSprinklerRangeCosts then
        return v235.ExtraSprinklerRangeCosts[sprinklerRange + 1]
      end
    end
  elseif p83 == "SoilQuality" then
    if v233 and v233.FloorConfig and floors then
      local v236 = v233.FloorConfig[p84]
      local soilQuality = v236 and v236.SoilQuality

      if soilQuality then
        local soilQuality2 = floors.SoilQuality or 1

        if soilQuality.MaxLevel and soilQuality2 >= soilQuality.MaxLevel then
          return "MAX"
        end

        return math.floor(soilQuality.BaseCost * soilQuality.CostGrowth ^ (soilQuality2 - 1))
      end
    end
  elseif p83 == "CrownedCrops" then
    local v237 = f38()

    if v237 and v237.IsEligibleFloor and not v237.IsEligibleFloor(p84) then
      return nil
    end

    if v237 and floors then
      local v238 = v237.GetUpgradeCost(p84, floors.CrownLevel or 0)

      if v238 == nil then
        if (floors.CrownLevel or 0) >= (v237.MaxLevel or 5) then
          return "MAX"
        end
      else
        return v238
      end
    end
  elseif p83 == "GoldenHarvest" then
    local v239 = f39()

    if v239 and v239.IsEligibleFloor and not v239.IsEligibleFloor(p84) then
      return nil
    end

    if v239 and floors then
      local goldenHarvestStage = floors.GoldenHarvestStage or 0

      if goldenHarvestStage >= (v239.MaxStage or 3) then
        return "MAX"
      end

      return v239.GetBuildCost(goldenHarvestStage)
    end
  elseif p83 == "GoldenChance" then
    local v240 = f39()

    if v240 and v240.IsEligibleFloor and not v240.IsEligibleFloor(p84) then
      return nil
    end

    if v240 and floors then
      if (floors.GoldenHarvestStage or 0) < 1 then
        return nil
      end

      return v240.GetUpgradeCost(floors.GoldenChanceLevel or 0)
    end
  elseif p83 == "SeedLuck" then
    if v232 and v232.CalculateSeedLuckUpgradeCost and v231 then
      return v232.CalculateSeedLuckUpgradeCost(v231.CurrentSeedLuckLevel or 1)
    end
  elseif p83 == "SeedRolls" then
    if v233 and v231 then
      local currentSeedRolls = v231.CurrentSeedRolls or 0

      if v233.MAX_ROLLS and currentSeedRolls >= v233.MAX_ROLLS then
        return "MAX"
      end

      if v233.ExtraSeedRollsCosts then
        return v233.ExtraSeedRollsCosts[currentSeedRolls + 1]
      end
    end
  end

  return nil
end

local function f98()
  if v7.Flags.IsUpgradePowerupsLoopRunning then
    return
  end

  v7.Flags.IsUpgradePowerupsLoopRunning = true

  task.spawn(function()
    local v241 = {
      [1] = 1,
      [2] = 1,
      [3] = 1,
      [4] = 1,
      [5] = 1,
    }

    local v242 = {}

    while not v2.Unloaded do
      local value92 = v2.Options.Dropdown_SelectedFloors.Value
      local v243 = false

      for i6 = 1, 5 do
        local v244 = "Floor " .. i6

        if type(value92) ~= "table" or value92[v244] == true then
          if v2.Options.Toggle_AutoUpgradePowerups.Value then
            local value93 = v2.Options.Dropdown_UpgradePowerups.Value
            local v245 = {}
            local v246 = false
            local v247 = true

            for key17, value94 in pairs(value93) do
              local v248 = false

              repeat
                if value94 then
                  if key17 == "SoilQuality" and i6 <= 2 then
                    v248 = true
                    break
                  end

                  if key17 == "CrownedCrops" and i6 == 1 then
                    v248 = true
                    break
                  end

                  if (key17 == "SeedLuck" or key17 == "SeedRolls") and i6 ~= 1 then
                    v248 = true
                    break
                  end

                  v246 = true
                  local v249 = v9.UPGRADE_MAP[key17].Type
                  local v250 = nil

                  if v249 == "plot" then
                    v250 = f97(key17, i6)
                  elseif (v249 == "seedluck" or v249 == "seedrolls") and i6 == 1 then
                    v250 = f97(key17, 1)
                  end

                  if v250 == "MAX" then
                  elseif v250 then
                    v247 = false
                    table.insert(v245, key17)
                  else
                    v247 = false
                  end
                end

                v248 = true
              until true

              if not v248 then
                break
              end
            end

            if v2.Options.Toggle_AutoUpgradePowerups.Value and v246 and v247 then
              pcall(function()
                local toggleAutoUpgradePowerups = v2.Options.Toggle_AutoUpgradePowerups

                if toggleAutoUpgradePowerups then
                  toggleAutoUpgradePowerups:SetValue(false)
                end
              end)

              v2:Notify({
                Title = "Floor " .. i6 .. " Powerups MAXED!",
                Content = "All selected powerups reached MAX level. Auto Upgrade disabled.",
                Duration = 5,
              })
            end

            if v2.Options.Toggle_AutoUpgradePowerups.Value and #v245 > 0 then
              v243 = true

              if v241[i6] > #v245 then
                v241[i6] = 1
              end

              local v251 = v245[v241[i6]]
              local v252 = v9.UPGRADE_MAP[v251].Type
              local v253 = nil

              if v252 == "plot" then
                v253 = f97(v251, i6)
              elseif (v252 == "seedluck" or v252 == "seedrolls") and i6 == 1 then
                v253 = f97(v251, 1)
              end

              local v254 = i6 .. "_" .. v251
              local v255 = v242[v254]

              if v255 then
                if v253 == v255.cost and tick() - v255.time < 3 then
                  v253 = nil
                else
                  v242[v254] = nil
                end
              end

              if v253 and v253 ~= "MAX" and f5() >= v253 then
                v242[v254] = { cost = v253, time = tick() }

                if v252 == "plot" then
                  local remoteArg = v9.UPGRADE_MAP[v251].RemoteArg
                  local v256 = "Floor" .. i6

                  task.spawn(function()
                    pcall(function()
                      replicatedStorage.Remotes.PlotUpgradeTransaction:InvokeServer(
                        remoteArg, v256
                      )
                    end)
                  end)
                elseif v252 == "seedluck" then
                  task.spawn(function()
                    pcall(function() replicatedStorage.Remotes.UpgradeSeedLuck:InvokeServer() end)
                  end)
                elseif v252 == "seedrolls" then
                  task.spawn(function()
                    pcall(function()
                      replicatedStorage.Remotes.UpgradeSeedRolls:InvokeServer()
                    end)
                  end)
                end
              end

              v241[i6] = v241[i6] % #v245 + 1
            end
          end
        end
      end

      if not v243 then
        break
      end

      task.wait(0.2)
    end

    v7.Flags.IsUpgradePowerupsLoopRunning = false
  end)
end

local function f99(p85)
  for index65, value95 in ipairs(v7.Data.CompostLevelNames) do
    if value95 == p85 then
      return index65
    end
  end

  return nil
end

local function f100()
  local value96 = v2.Options.Toggle_AutoCompostSelected
    and v2.Options.Toggle_AutoCompostSelected.Value

  local value97 = v2.Options.Toggle_AutoCompostByRarity
    and v2.Options.Toggle_AutoCompostByRarity.Value

  local v257 = value96 == true
  local v258 = value97 == true

  local value98 = v2.Options.Dropdown_CompostSeeds and v2.Options.Dropdown_CompostSeeds.Value
    or {}

  local value99 = v2.Options.Dropdown_CompostRarities
      and v2.Options.Dropdown_CompostRarities.Value
    or {}

  if v257 and next(value98) == nil then
    return nil
  end

  if v258 and next(value99) == nil then
    return nil
  end

  if not v257 and not v258 then
    return nil
  end

  for index66, value100 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value100 then
      for index67, value101 in ipairs(value100:GetChildren()) do
        if value101:IsA("Tool") and value101:GetAttribute("InventoryCategory") == "Seeds" then
          local plant = value101:GetAttribute("Plant") or value101:GetAttribute("trueName")

          if plant then
            local mutation = value101:GetAttribute("Mutation") or "Normal"
            local v259 = false

            if v257 and value98[plant] == true then
              v259 = true
            elseif v258 then
              local v260 = f80(plant)

              if v260 ~= "Unknown" and value99[v260] == true then
                v259 = true
              end
            end

            if v259 then
              return value101, plant, mutation
            end
          end
        end
      end
    end
  end

  return nil
end

local function f101(p86)
  local v261 = string.match(p86.Name, "%(x(%d+)%)")
  return v261 and tonumber(v261) or 1
end

local function f102(p87, p88, p89)
  local seedKey2 = p87:GetAttribute("seedKey")

  if seedKey2 then
    return seedKey2
  end

  local level2 = p87:GetAttribute("Level") or 1
  return tostring(p88) .. "_" .. tostring(level2) .. "_" .. tostring(p89)
end

local function f103(p90)
  local insertSeed = replicatedStorage:FindFirstChild("Remotes")
    and replicatedStorage.Remotes:FindFirstChild("Composter")
    and replicatedStorage.Remotes.Composter:FindFirstChild("InsertSeed")

  if not insertSeed then
    return nil
  end

  local v262, v263, v264 = f100()

  if not v262 then
    return nil
  end

  local v265 = f101(v262)
  local v266 = f102(v262, v263, v264)
  local v267, v268 = pcall(function() return insertSeed:InvokeServer(p90, v266, v265) end)

  if v267 and type(v268) == "table" and v268.Success then
    return v268
  end

  return nil
end

local function f104()
  local v269 = 1

  pcall(function()
    local v270 = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("SkillTree"))
    local v271 = f62()

    v269 = v270.GetBoostFor(
      v271 and v271.SkillTree and v271.SkillTree.Nodes, "ComposterCooldownReduction"
    )
  end)

  return v269
end

local function f105()
  if v7.Flags.IsCompostLoopRunning then
    return
  end

  v7.Flags.IsCompostLoopRunning = true

  task.spawn(function()
    local pullLever = replicatedStorage:FindFirstChild("Remotes")
      and replicatedStorage.Remotes:FindFirstChild("Composter")
      and replicatedStorage.Remotes.Composter:FindFirstChild("PullLever")

    local v272 = false

    while not v2.Unloaded do
      local getServerTimeNow = workspace:GetServerTimeNow()

      for key18, value102 in pairs(v7.Data.CompostCooldownEndsAt) do
        if value102 <= getServerTimeNow then
          v7.Data.CompostCooldownEndsAt[key18] = nil
        end
      end

      local value103 = v2.Options.Dropdown_CompostSelectedFloors.Value
      local v273 = false

      for i7 = 2, 5 do
        local v274 = "Floor " .. i7

        if type(value103) ~= "table" or value103[v274] == true then
          if v2.Options.Toggle_AutoCompostSelected
              and v2.Options.Toggle_AutoCompostSelected.Value
            or v2.Options.Toggle_AutoCompostByRarity
              and v2.Options.Toggle_AutoCompostByRarity.Value then
            v273 = true
            local v275 = f71(i7)

            if type(v275) == "number" and v275 <= 0 then
              local v276 = f103(i7)

              if v276 then
                v272 = true

                local value104 = v2.Options.Dropdown_CompostPullLevel
                  and v2.Options.Dropdown_CompostPullLevel.Value

                local v277 = nil

                if value104 and value104 ~= "None" then
                  v277 = f99(value104)
                end

                if v277 and v276.Tier then
                  local v278 = f99(v276.Tier)

                  if v278 and v278 >= v277 then
                    if pullLever then
                      local v279, v280 = pcall(function() return pullLever:InvokeServer(i7) end)

                      if v279 and type(v280) == "table" and v280.Success then
                        local v281 = f70()

                        if v281 and v281.MarkLocal then
                          v281.MarkLocal(i7)
                        else
                          local v282 = f104()
                          local compostCooldownDuration = v7.Data.CompostCooldownDuration or 300

                          v7.Data.CompostCooldownEndsAt[i7] = workspace:GetServerTimeNow()
                            + compostCooldownDuration * v282
                        end

                        v2:Notify({
                          Title = "Compost Floor " .. tostring(i7),
                          Content = "Pulled at tier " .. v276.Tier,
                          Duration = 5,
                        })
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      if not v273 then
        break
      end

      if not v272 then
        task.wait(1)
      else
        task.wait(0.25)
      end

      v272 = false
    end

    v7.Flags.IsCompostLoopRunning = false
  end)
end

local function f106()
  if v7.Flags.IsCollectAlienDropLoopRunning or not v2.Options.Toggle_AutoCollectAlienDrop.Value then
    return
  end

  v7.Flags.IsCollectAlienDropLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectAlienDrop.Value do
      pcall(function()
        if f56("AlienInvasion") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
          for index68, value105 in ipairs(workspace:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectAlienDrop.Value then
              break
            end

            if string.find(value105.Name, "AlienDrop", 1, true) then
              local findFirstChildWhichIsA3 = value105:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart = value105:IsA("BasePart") and value105
                or value105:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA3 and basePart then
                f53(humanoidRootPart, basePart, findFirstChildWhichIsA3)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectAlienDropLoopRunning = false
  end)
end

local function f107()
  if v7.Flags.IsCollectCyberDroneDropLoopRunning
    or not v2.Options.Toggle_AutoCollectCyberDroneDrop.Value then
    return
  end

  v7.Flags.IsCollectCyberDroneDropLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectCyberDroneDrop.Value do
      pcall(function()
        local cyberDroneClientFX = workspace:FindFirstChild("CyberDroneClientFX")

        if not cyberDroneClientFX or #cyberDroneClientFX:GetChildren() == 0
          or f56("CyberDrone") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart2 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart2 then
          for index69, value106 in ipairs(cyberDroneClientFX:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectCyberDroneDrop.Value then
              break
            end

            if string.find(value106.Name, "CyberDroneDrop_", 1, true) ~= nil then
              local findFirstChildWhichIsA4 = value106:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart2 = value106:IsA("BasePart") and value106
                or value106:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA4 and basePart2 then
                f53(humanoidRootPart2, basePart2, findFirstChildWhichIsA4)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectCyberDroneDropLoopRunning = false
  end)
end

local function f108()
  if v7.Flags.IsCollectHoneycombLoopRunning
    or not v2.Options.Toggle_AutoCollectQueenBeeHoneycomb.Value then
    return
  end

  v7.Flags.IsCollectHoneycombLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectQueenBeeHoneycomb.Value do
      pcall(function()
        if f56("QueenBee") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart3 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart3 then
          for index70, value107 in ipairs(workspace:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectQueenBeeHoneycomb.Value then
              break
            end

            if value107.Name == "Honeycomb" then
              local findFirstChildWhichIsA5 = value107:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              if findFirstChildWhichIsA5 then
                local basePart3 = value107:IsA("BasePart") and value107
                  or value107:IsA("Model")
                    and (value107.PrimaryPart
                      or value107:FindFirstChildWhichIsA("BasePart", true))

                if findFirstChildWhichIsA5 and basePart3 then
                  f53(humanoidRootPart3, basePart3, findFirstChildWhichIsA5)
                  task.wait(0.5)
                end
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectHoneycombLoopRunning = false
  end)
end

local function f109()
  if v7.Flags.IsSubmitQueenBeeHoneyTokenLoopRunning
    or not v2.Options.Toggle_AutoSubmitQueenBeeHoneyToken.Value then
    return
  end

  v7.Flags.IsSubmitQueenBeeHoneyTokenLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoSubmitQueenBeeHoneyToken.Value do
      if f7() <= 0 then
        task.wait(2)
      else
        local v283 = f50()

        local humanoidRootPart4 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if v283 and humanoidRootPart4 then
          local parent = v283.Parent

          if parent and parent:IsA("Attachment") then
            parent = parent.Parent
          end

          if parent then
            f53(humanoidRootPart4, parent, v283)
          end
        else
          task.wait(2)
        end
      end

      task.wait(1)
    end

    v7.Flags.IsSubmitQueenBeeHoneyTokenLoopRunning = false
  end)
end

local function f110()
  if v7.Flags.IsCollectAdminTokensLoopRunning
    or not v2.Options.Toggle_AutoCollectAdminTokens.Value then
    return
  end

  v7.Flags.IsCollectAdminTokensLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectAdminTokens.Value do
      pcall(function()
        local humanoidRootPart5 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local interactiveEvents2 = workspace:FindFirstChild("InteractiveEvents")

        local megaSpinner2 = interactiveEvents2
          and interactiveEvents2:FindFirstChild("MegaSpinner")

        local runtimeAdminTokens = megaSpinner2
          and megaSpinner2:FindFirstChild("RuntimeAdminTokens")

        if not runtimeAdminTokens or #runtimeAdminTokens:GetChildren() == 0 then
          task.wait(3)
          return
        end

        if humanoidRootPart5 then
          for index71, value108 in ipairs(runtimeAdminTokens:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectAdminTokens.Value then
              break
            end

            local findFirstChildWhichIsA6 = value108:FindFirstChildWhichIsA(
              "ProximityPrompt", true
            )

            local basePart4 = value108:IsA("BasePart") and value108
              or value108:IsA("Model")
                and (value108.PrimaryPart or value108:FindFirstChildWhichIsA("BasePart", true))

            if findFirstChildWhichIsA6 and basePart4 then
              f53(humanoidRootPart5, basePart4, findFirstChildWhichIsA6)
              task.wait(0.5)
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectAdminTokensLoopRunning = false
  end)
end

local function f111()
  if v7.Flags.IsSpinMegaSpinnerLoopRunning or not v2.Options.Toggle_AutoSpinMegaSpinner.Value then
    return
  end

  v7.Flags.IsSpinMegaSpinnerLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoSpinMegaSpinner.Value do
      pcall(function()
        if f51() <= 0 then
          task.wait(2)
        else
          local v284 = f52()

          local humanoidRootPart6 = localPlayer.Character
            and localPlayer.Character:FindFirstChild("HumanoidRootPart")

          if v284 and humanoidRootPart6 then
            local parent2 = v284.Parent

            if parent2 and parent2:IsA("Attachment") then
              parent2 = parent2.Parent
            end

            if parent2 then
              f53(humanoidRootPart6, parent2, v284)
              task.wait(1.5)
            end
          else
            task.wait(2)
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsSpinMegaSpinnerLoopRunning = false
  end)
end

local function f112()
  if v7.Flags.IsCollectWeatherEventsLoopRunning
    or not v2.Options.Toggle_AutoCollectWeatherEvents.Value then
    return
  end

  v7.Flags.IsCollectWeatherEventsLoopRunning = true
  local v285 = setmetatable({}, { __mode = "k" })

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectWeatherEvents.Value do
      pcall(function()
        local humanoidRootPart7 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local v286 = f54()

        if not (humanoidRootPart7 and v286) then
          return
        end

        local rainClientFX = workspace:FindFirstChild("RainClientFX")
        local blizzardClientFX = workspace:FindFirstChild("BlizzardClientFX")
        local fallClientFX = workspace:FindFirstChild("FallClientFX")
        local blackholeClientFX = workspace:FindFirstChild("BlackholeClientFX")
        local nuclearClientFX = workspace:FindFirstChild("NuclearClientFX")
        local galaxyClientFX = workspace:FindFirstChild("GalaxyClientFX")

        if not (rainClientFX or blizzardClientFX or fallClientFX or blackholeClientFX
          or nuclearClientFX or galaxyClientFX) then
          task.wait(3)
          return
        end

        if rainClientFX then
          for index72, value109 in ipairs(rainClientFX:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            local v287 = tonumber(string.match(value109.Name, "^Droplet_(%d+)$"))

            if v287 then
              local basePart5 = value109:IsA("BasePart") and value109
                or value109:FindFirstChildWhichIsA("BasePart", true)

              if basePart5 then
                humanoidRootPart7.CFrame = CFrame.new(basePart5.Position)

                pcall(function()
                  v286:Fire({
                    eventName = "Rain",
                    action = "CollectDroplet",
                    instance = nil,
                    args = { v287 },
                  })
                end)

                task.wait(1.5)
              end
            end
          end
        end

        if blizzardClientFX then
          for index73, value110 in ipairs(blizzardClientFX:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            if string.match(value110.Name, "^Crystal_(%d+)$") then
              local findFirstChildWhichIsA7 = value110:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart6 = value110:IsA("BasePart") and value110
                or value110:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA7 and basePart6 then
                f53(humanoidRootPart7, basePart6, findFirstChildWhichIsA7)
                task.wait(1.2)
              end
            end
          end
        end

        if fallClientFX then
          local getChildren = fallClientFX:GetChildren()

          if #getChildren == 0 then
            table.clear(v285)
          else
            for index74, value111 in ipairs(getChildren) do
              if not v2.Options.Toggle_AutoCollectWeatherEvents.Value then
                break
              end

              if value111.Name == "LeafPile" and not v285[value111] then
                local findFirstChildWhichIsA8 = value111:FindFirstChildWhichIsA(
                  "ProximityPrompt", true
                )

                local basePart7 = value111:IsA("BasePart") and value111
                  or value111:FindFirstChildWhichIsA("BasePart", true)

                if findFirstChildWhichIsA8 and basePart7 then
                  v285[value111] = true
                  f53(humanoidRootPart7, basePart7, findFirstChildWhichIsA8)
                  task.wait(1.2)
                end
              end
            end
          end
        end

        if blackholeClientFX then
          for index75, value112 in ipairs(blackholeClientFX:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            if string.match(value112.Name, "^Blackhole_(%d+)$") then
              local findFirstChildWhichIsA9 = value112:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart8 = value112:IsA("BasePart") and value112
                or value112:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA9 and basePart8 then
                f53(humanoidRootPart7, basePart8, findFirstChildWhichIsA9)
                task.wait(1.2)
              end
            end
          end
        end

        if nuclearClientFX then
          for index76, value113 in ipairs(nuclearClientFX:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            if string.match(value113.Name, "^Barrel_(%d+)$") then
              local findFirstChildWhichIsA10 = value113:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart9 = value113:IsA("BasePart") and value113
                or value113:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA10 and basePart9 then
                f53(humanoidRootPart7, basePart9, findFirstChildWhichIsA10)
                task.wait(1.2)
              end
            end

            local v288 = tonumber(string.match(value113.Name, "^NuclearDrop_(%d+)$"))

            if v288 then
              local basePart10 = value113:IsA("BasePart") and value113
                or value113:FindFirstChildWhichIsA("BasePart", true)

              if basePart10 then
                humanoidRootPart7.CFrame = CFrame.new(basePart10.Position)

                pcall(function()
                  v286:Fire({
                    eventName = "Nuclear",
                    action = "CollectNuclearDrop",
                    instance = nil,
                    args = { v288 },
                  })
                end)

                task.wait(1.5)
              end
            end
          end
        end

        if galaxyClientFX then
          for index77, value114 in ipairs(galaxyClientFX:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            local v289 = tonumber(string.match(value114.Name, "^StarDrop_(%d+)$"))

            if v289 then
              local basePart11 = value114:IsA("BasePart") and value114
                or value114:FindFirstChildWhichIsA("BasePart", true)

              if basePart11 then
                humanoidRootPart7.CFrame = CFrame.new(basePart11.Position)
                task.wait(0.75)

                pcall(function()
                  v286:Fire({
                    eventName = "Galaxy",
                    action = "CollectStarDrop",
                    instance = nil,
                    args = { v289 },
                  })
                end)

                task.wait(1.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectWeatherEventsLoopRunning = false
  end)
end

local function f113()
  if v7.Flags.IsCollectLuckyRainDropLoopRunning
    or not v2.Options.Toggle_AutoCollectLuckyRainDrop.Value then
    return
  end

  v7.Flags.IsCollectLuckyRainDropLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectLuckyRainDrop.Value do
      pcall(function()
        local luckyRainClientFX = workspace:FindFirstChild("LuckyRainClientFX")

        if not luckyRainClientFX or #luckyRainClientFX:GetChildren() == 0
          or f56("LuckyRain") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart8 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local v290 = f54()

        if humanoidRootPart8 and v290 then
          for index78, value115 in ipairs(luckyRainClientFX:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectLuckyRainDrop.Value then
              break
            end

            local v291 = tonumber(string.match(value115.Name, "^LuckyRainDrop_(%d+)$"))

            if v291 then
              local basePart12 = value115:IsA("BasePart") and value115
                or value115:IsA("Model")
                  and (value115.PrimaryPart or value115:FindFirstChildWhichIsA("BasePart", true))

              if basePart12 then
                humanoidRootPart8.CFrame = CFrame.new(basePart12.Position)
                task.wait(0.1)
                v290:Fire({ eventName = "LuckyRain", action = "ClaimDrop", args = { v291 } })
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectLuckyRainDropLoopRunning = false
  end)
end

local function f114()
  if v7.Flags.IsCollectMeteorDropLoopRunning
    or not v2.Options.Toggle_AutoCollectMeteorDrop.Value then
    return
  end

  v7.Flags.IsCollectMeteorDropLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectMeteorDrop.Value do
      pcall(function()
        local meteorShowerClientFX = workspace:FindFirstChild("MeteorShowerClientFX")

        if not meteorShowerClientFX or #meteorShowerClientFX:GetChildren() == 0
          or f56("MeteorShower") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart9 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local v292 = f54()

        if humanoidRootPart9 and v292 then
          for index79, value116 in ipairs(meteorShowerClientFX:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectMeteorDrop.Value then
              break
            end

            local v293 = tonumber(string.match(value116.Name, "^MeteorDrop_(%d+)$"))

            if v293 then
              local basePart13 = value116:IsA("BasePart") and value116
                or value116:IsA("Model")
                  and (value116.PrimaryPart or value116:FindFirstChildWhichIsA("BasePart", true))

              if basePart13 then
                humanoidRootPart9.CFrame = CFrame.new(basePart13.Position)
                task.wait(0.1)

                v292:Fire({
                  eventName = "MeteorShower",
                  action = "ClaimMeteorDrop",
                  instance = nil,
                  args = { v293 },
                })

                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectMeteorDropLoopRunning = false
  end)
end

local function f115()
  if v7.Flags.IsPlantditchPassRingLoopRunning
    or not v2.Options.Toggle_AutoPlantditchPassRing.Value then
    return
  end

  v7.Flags.IsPlantditchPassRingLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoPlantditchPassRing.Value do
      pcall(function()
        local v294 = f54()

        local humanoidRootPart10 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if not (v294 and humanoidRootPart10) then
          return
        end

        local plantditchArena = workspace:FindFirstChild("PlantditchArena")
        local rings = plantditchArena and plantditchArena:FindFirstChild("Rings")

        if not rings then
          task.wait(2)
          return
        end

        for index80, value117 in ipairs(rings:GetChildren()) do
          local v295 = false

          repeat
            if not v2.Options.Toggle_AutoPlantditchPassRing.Value then
              break
            end

            if not value117:IsA("BasePart") then
              v295 = true
              break
            end

            local ringId = value117:GetAttribute("RingId")

            if not ringId then
              v295 = true
              break
            end

            local size = value117.Size
            local vector

            if size.X <= size.Y and size.X <= size.Z then
              vector = Vector3.new(1, 0, 0)
            elseif size.Y <= size.Z then
              vector = Vector3.new(0, 1, 0)
            else
              vector = Vector3.new(0, 0, 1)
            end

            local v296 = value117.CFrame:VectorToWorldSpace(vector) * 2
            humanoidRootPart10.CFrame = CFrame.new(value117.Position + v296)
            task.wait(0.05)
            humanoidRootPart10.CFrame = CFrame.new(value117.Position - v296)
            task.wait(0.05)

            v294:Fire({
              eventName = "Plantditch",
              action = "PassRing",
              instance = nil,
              args = { ringId, humanoidRootPart10.Position },
            })

            task.wait(0.3)
            v295 = true
          until true

          if not v295 then
            break
          end
        end
      end)

      task.wait(0.5)
    end

    v7.Flags.IsPlantditchPassRingLoopRunning = false
  end)
end

local function f116()
  if v7.Flags.IsPlantditchClaimOrbLoopRunning
    or not v2.Options.Toggle_AutoPlantditchClaimOrb.Value then
    return
  end

  v7.Flags.IsPlantditchClaimOrbLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoPlantditchClaimOrb.Value do
      pcall(function()
        local v297 = f54()

        local humanoidRootPart11 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if not (v297 and humanoidRootPart11) then
          return
        end

        local plantditchArena2 = workspace:FindFirstChild("PlantditchArena")
        local orbs = plantditchArena2 and plantditchArena2:FindFirstChild("Orbs")

        if not orbs then
          task.wait(2)
          return
        end

        for index81, value118 in ipairs(orbs:GetChildren()) do
          local v298 = false

          repeat
            if not v2.Options.Toggle_AutoPlantditchClaimOrb.Value then
              break
            end

            local orbId = value118:GetAttribute("OrbId")
            local primaryPart = value118.PrimaryPart or value118:FindFirstChild("Core")

            if not (orbId and primaryPart) then
              v298 = true
              break
            end

            humanoidRootPart11.CFrame = CFrame.new(primaryPart.Position)
            task.wait(0.1)

            v297:Fire({
              eventName = "Plantditch",
              action = "ClaimOrb",
              instance = nil,
              args = { orbId, humanoidRootPart11.Position },
            })

            task.wait(0.3)
            v298 = true
          until true

          if not v298 then
            break
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsPlantditchClaimOrbLoopRunning = false
  end)
end

local function f117()
  if v7.Flags.IsShootJesterBossLoopRunning or not v2.Options.Toggle_AutoShootJesterBoss.Value then
    return
  end

  v7.Flags.IsShootJesterBossLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoShootJesterBoss.Value do
      pcall(function()
        local jester = workspace:FindFirstChild("Jester")

        local primaryPart2 = jester
          and (jester.PrimaryPart or jester:FindFirstChildWhichIsA("BasePart", true))

        local humanoidRootPart12 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local humanoid8 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("Humanoid")

        local v299 = f54()

        if primaryPart2 and humanoidRootPart12 and humanoid8 and v299 then
          local tomatoShooter = f44("Tomato Shooter")

          if tomatoShooter then
            if tomatoShooter.Parent ~= localPlayer.Character then
              humanoid8:EquipTool(tomatoShooter)
              task.wait(0.1)
            end

            if tomatoShooter.Parent == localPlayer.Character then
              local v300 = humanoidRootPart12.Position + Vector3.new(0, 1.5, 0)

              v299:Fire({
                eventName = "JesterBoss",
                action = "Shoot",
                instance = nil,
                args = { v300, (primaryPart2.Position - v300).Unit },
              })

              task.wait(0.25)
              return
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsShootJesterBossLoopRunning = false
  end)
end

local function f118()
  if v7.Flags.IsCollectJesterGiftsLoopRunning
    or not v2.Options.Toggle_AutoCollectJesterGifts.Value then
    return
  end

  v7.Flags.IsCollectJesterGiftsLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectJesterGifts.Value do
      pcall(function()
        local humanoidRootPart13 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local jesterBossGiftsClient = workspace:FindFirstChild("JesterBossGifts_Client")

        if humanoidRootPart13 and jesterBossGiftsClient then
          for index82, value119 in ipairs(jesterBossGiftsClient:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectJesterGifts.Value then
              break
            end

            local findFirstChild14 = value119:FindFirstChild("GiftBoxPrompt", true)

            if findFirstChild14 and findFirstChild14:IsA("ProximityPrompt") then
              local basePart14 = value119:IsA("BasePart") and value119
                or value119:IsA("Model")
                  and (value119.PrimaryPart or value119:FindFirstChildWhichIsA("BasePart", true))

              if basePart14 then
                f53(humanoidRootPart13, basePart14, findFirstChild14)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectJesterGiftsLoopRunning = false
  end)
end

local function f119()
  if v7.Flags.IsCollectCarnivalGiftsLoopRunning
    or not v2.Options.Toggle_AutoCollectCarnivalGifts.Value then
    return
  end

  v7.Flags.IsCollectCarnivalGiftsLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoCollectCarnivalGifts.Value do
      pcall(function()
        local humanoidRootPart14 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local carnivalGiftBoxesClient = workspace:FindFirstChild("CarnivalGiftBoxes_Client")

        if humanoidRootPart14 and carnivalGiftBoxesClient then
          for index83, value120 in ipairs(carnivalGiftBoxesClient:GetChildren()) do
            if not v2.Options.Toggle_AutoCollectCarnivalGifts.Value then
              break
            end

            local findFirstChild15 = value120:FindFirstChild("GiftBoxPrompt", true)

            if findFirstChild15 and findFirstChild15:IsA("ProximityPrompt") then
              local basePart15 = value120:IsA("BasePart") and value120
                or value120:IsA("Model")
                  and (value120.PrimaryPart or value120:FindFirstChildWhichIsA("BasePart", true))

              if basePart15 then
                f53(humanoidRootPart14, basePart15, findFirstChild15)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.Flags.IsCollectCarnivalGiftsLoopRunning = false
  end)
end

local function f120()
  if v7.Flags.IsAutoZooRushLoopRunning then
    return
  end

  v7.Flags.IsAutoZooRushLoopRunning = true
  local v301 = { Tired = 0, Alert = 1, Wander = 2 }

  task.spawn(function()
    while not v2.Unloaded
      and (v2.Options.Toggle_AutoZooRushName.Value or v2.Options.Toggle_AutoZooRushRarity.Value) do
      pcall(function()
        local character3 = localPlayer.Character
        local humanoidRootPart15 = character3 and character3:FindFirstChild("HumanoidRootPart")
        local humanoid9 = character3 and character3:FindFirstChild("Humanoid")

        if not (humanoidRootPart15 and humanoid9) then
          return
        end

        local tool2 = character3:FindFirstChildWhichIsA("Tool")

        if not (tool2 and tool2:GetAttribute("ZooRushNet") == true) then
          local backpack2 = localPlayer:FindFirstChild("Backpack")

          if backpack2 then
            for index84, value121 in ipairs(backpack2:GetChildren()) do
              if value121:IsA("Tool") and value121:GetAttribute("ZooRushNet") == true then
                tool2 = value121
                humanoid9:EquipTool(value121)
                task.wait(0.1)
                break
              end
            end
          end
        end

        local zooRushAnimals = workspace:FindFirstChild("ZooRushAnimals")

        if not zooRushAnimals then
          task.wait(10)
          return
        end

        local v302 = f54()

        if not v302 then
          return
        end

        local value122 = v2.Options.Dropdown_ZooRushNames.Value
        local value123 = v2.Options.Dropdown_ZooRushRarities.Value
        local value124 = v2.Options.Toggle_AutoZooRushName.Value
        local value125 = v2.Options.Toggle_AutoZooRushRarity.Value

        if value124 and (type(value122) ~= "table" or next(value122) == nil)
          or value125 and (type(value123) ~= "table" or next(value123) == nil)
          or not value124 and not value125 then
          task.wait(0.5)
          return
        end

        local getServerTimeNow2 = workspace:GetServerTimeNow()
        local v303 = {}

        for index85, value126 in ipairs(zooRushAnimals:GetChildren()) do
          local v304 = false

          repeat
            if value126:IsA("BasePart") then
              local petName = value126:GetAttribute("PetName")
              local expiresAt = value126:GetAttribute("ExpiresAt")

              if type(petName) ~= "string" then
                v304 = true
                break
              end

              if type(expiresAt) == "number" and expiresAt < getServerTimeNow2 then
                v304 = true
                break
              end

              if value124 and petName then
                local v305 = string.lower(petName)
                local v306 = false

                for key19, value127 in pairs(value122) do
                  if value127 and string.find(v305, string.lower(key19), 1, true) then
                    v306 = true
                    break
                  end
                end

                if not v306 then
                  v304 = true
                  break
                end
              elseif value125 then
                local v307 = f81(petName)

                if not v307 or not value123[v307] then
                  v304 = true
                  break
                end
              end

              local rate = v7.Data.ZooRushPetRate[petName] or 999
              local statePri = v301[value126:GetAttribute("State") or "Wander"] or 3
              table.insert(v303, { Part = value126, Rate = rate, StatePri = statePri })
            end

            v304 = true
          until true

          if not v304 then
            break
          end
        end

        if #v303 == 0 then
          task.wait(0.5)
          return
        end

        table.sort(v303, function(p91, p92)
          if p91.Rate ~= p92.Rate then
            return p91.Rate < p92.Rate
          end

          return p91.StatePri < p92.StatePri
        end)

        local part = v303[1].Part
        humanoidRootPart15.CFrame = CFrame.new(part.Position)
        task.wait(0.05)

        for i8 = 1, 3 do
          if not (v2.Options.Toggle_AutoZooRushName.Value
            or v2.Options.Toggle_AutoZooRushRarity.Value) then
            break
          end

          v302:Fire({
            eventName = "ZooRush",
            action = "Attempt",
            instance = part,
            args = {},
          })

          task.wait(0.05)
        end

        task.wait(3)
      end)
    end

    v7.Flags.IsAutoZooRushLoopRunning = false
  end)
end

local function f121()
  if v7.Flags.IsClaimDailyRewardLoopRunning or not v2.Options.Toggle_AutoClaimDailyReward.Value then
    return
  end

  v7.Flags.IsClaimDailyRewardLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoClaimDailyReward.Value do
      pcall(function()
        if replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("GetDailyRewardState")
          and replicatedStorage.Remotes:FindFirstChild("ClaimDailyReward") then
          local invokeServer = replicatedStorage.Remotes.GetDailyRewardState:InvokeServer()

          if type(invokeServer) == "table"
            and (not invokeServer.SecondsUntilNext or invokeServer.SecondsUntilNext <= 0) then
            if replicatedStorage.Remotes.ClaimDailyReward:InvokeServer() then
              v2:Notify({
                Title = "Daily Reward",
                Content = "Daily reward claimed successfully!",
                Duration = 3,
              })
            end
          end
        end
      end)

      task.wait(60)
    end

    v7.Flags.IsClaimDailyRewardLoopRunning = false
  end)
end

local function f122()
  if v7.Flags.IsClaimPlaytimeRewardLoopRunning
    or not v2.Options.Toggle_AutoClaimPlaytimeReward.Value then
    return
  end

  v7.Flags.IsClaimPlaytimeRewardLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoClaimPlaytimeReward.Value do
      pcall(function()
        if replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("GetPlaytimeRewardState")
          and replicatedStorage.Remotes:FindFirstChild("ClaimPlaytimeReward") then
          local invokeServer2 = replicatedStorage.Remotes.GetPlaytimeRewardState:InvokeServer()

          if type(invokeServer2) == "table" then
            local claimedMap = invokeServer2.ClaimedMap or {}

            for i9 = 1, invokeServer2.EarnedCount or 0 do
              if not v2.Options.Toggle_AutoClaimPlaytimeReward.Value then
                break
              end

              if not (claimedMap[tostring(i9)] == true) then
                if replicatedStorage.Remotes.ClaimPlaytimeReward:InvokeServer(i9) then
                  v2:Notify({
                    Title = "Playtime Reward",
                    Content = "Claimed Playtime Reward #" .. tostring(i9),
                    Duration = 3,
                  })
                end

                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(60)
    end

    v7.Flags.IsClaimPlaytimeRewardLoopRunning = false
  end)
end

local function f123()
  if v7.Flags.IsSpinWheelLoopRunning or not v2.Options.Toggle_AutoSpinWheel.Value then
    return
  end

  v7.Flags.IsSpinWheelLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoSpinWheel.Value do
      local requestSpin = replicatedStorage:FindFirstChild("Remotes")
        and replicatedStorage.Remotes:FindFirstChild("SpinWheel")
        and replicatedStorage.Remotes.SpinWheel:FindFirstChild("RequestSpin")

      if requestSpin then
        requestSpin:InvokeServer(true)
      end

      task.wait(10)
    end

    v7.Flags.IsSpinWheelLoopRunning = false
  end)
end

local function f124()
  if v7.Flags.IsAutoOpenCratePackLoopRunning or not v2.Options.Toggle_AutoOpenCratePack.Value then
    return
  end

  v7.Flags.IsAutoOpenCratePackLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoOpenCratePack.Value do
      local requestOpenSeedPack = replicatedStorage:FindFirstChild("Remotes")
        and replicatedStorage.Remotes:FindFirstChild("RequestOpenSeedPack")

      local seedPackOpenFinished = replicatedStorage:FindFirstChild("Remotes")
        and replicatedStorage.Remotes:FindFirstChild("SeedPackOpenFinished")

      if requestOpenSeedPack and seedPackOpenFinished then
        local character4 = localPlayer.Character
        local humanoid10 = character4 and character4:FindFirstChild("Humanoid")
        local backpack3 = localPlayer:FindFirstChild("Backpack")

        local function f125(p93)
          if not p93 then
            return nil
          end

          for index86, value128 in ipairs(p93:GetChildren()) do
            if value128:IsA("Tool") then
              local v308 = string.lower(value128.Name)

              if string.find(v308, "crate") or string.find(v308, "pack") then
                return value128
              end
            end
          end

          return nil
        end

        local tool3 = character4 and character4:FindFirstChildWhichIsA("Tool")

        if tool3 then
          local v309 = string.lower(tool3.Name)

          if string.find(v309, "crate") or string.find(v309, "pack") then
            requestOpenSeedPack:FireServer()
            task.wait(0.1)
            seedPackOpenFinished:FireServer()
            task.wait(0.2)
          end
        end

        local v310 = f125(backpack3)

        if v310 and humanoid10 then
          humanoid10:EquipTool(v310)
          task.wait(0.2)
          requestOpenSeedPack:FireServer()
          task.wait(0.1)
          seedPackOpenFinished:FireServer()
          task.wait(0.2)
          humanoid10:UnequipTools()
        end
      end

      task.wait(1)
    end

    v7.Flags.IsAutoOpenCratePackLoopRunning = false
  end)
end

local function f126()
  if v7.Flags.IsAutoRollVaultRunning then
    return
  end

  if not (v2.Options.Toggle_AutoRollVault and v2.Options.Toggle_AutoRollVault.Value) then
    return
  end

  v7.Flags.IsAutoRollVaultRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoRollVault
      and v2.Options.Toggle_AutoRollVault.Value do
      pcall(function()
        local v311 = f62()
        local vault = v311 and v311.Vault

        if not vault and v6 then
          local v312, v313 = pcall(v6.GetReplicator)

          if v312 and v313 then
            vault = v313:Get({ "Vault" })
          end
        end

        local v314 = vault and math.max(0, math.floor(tonumber(vault.Credits) or 0)) or 0
        local v315 = vault and tonumber(vault.FreeRollDay) or 0
        local v316 = vault and tonumber(vault.FreeRollsUsed) or 0
        local getServerTimeNow3 = workspace:GetServerTimeNow()
        local v317 = v315 ~= math.floor(getServerTimeNow3 / 86400) or v316 < 1

        if v314 > 0 or v317 then
          local v318 = f59("VaultService", "RF", "Roll")

          if v318 then
            local v319, v320 = pcall(function() return v318:InvokeServer() end)

            if v319 and (type(v320) ~= "table" or v320.ok ~= false) then
              v7.Cache.ReplicatorSnapshotTime = 0
              task.wait(1)
              return
            end
          end
        end
      end)

      task.wait(10)
    end

    v7.Flags.IsAutoRollVaultRunning = false
  end)
end

local function f127()
  if v7.Flags.IsAutoClaimGuildMissionsRunning
    or not v2.Options.Toggle_AutoClaimGuildMissions.Value then
    return
  end

  v7.Flags.IsAutoClaimGuildMissionsRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoClaimGuildMissions.Value do
      local getMissions = f61("GetMissions")

      if type(getMissions) == "table" then
        for index87, value129 in ipairs({ "Hourly", "Daily", "Weekly" }) do
          local v321 = getMissions[value129]

          if type(v321) == "table" then
            for index88, value130 in ipairs(v321) do
              if not v2.Options.Toggle_AutoClaimGuildMissions.Value then
                break
              end

              if value130.complete and not value130.claimed then
                local v322 = f61("ClaimMission", value129, value130.id)

                if type(v322) == "table" and v322.ok then
                  v2:Notify({
                    Title = "Guild Mission",
                    Content = "Claimed " .. (value130.stat or "mission") .. " reward",
                    Duration = 3,
                  })
                end

                task.wait(0.5)
              end
            end
          end
        end
      end

      task.wait(60)
    end

    v7.Flags.IsAutoClaimGuildMissionsRunning = false
  end)
end

local function f128()
  if v7.Flags.IsAutoClaimGuildWeeklyRunning or not v2.Options.Toggle_AutoClaimGuildWeekly.Value then
    return
  end

  v7.Flags.IsAutoClaimGuildWeeklyRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoClaimGuildWeekly.Value do
      local getMyGuild = f61("GetMyGuild")

      if type(getMyGuild) == "table" and getMyGuild.inGuild then
        local getRewardTiers = f61("GetRewardTiers")

        if type(getRewardTiers) == "table" and getRewardTiers.ok then
          for index89, value131 in ipairs(getRewardTiers.tiers) do
            if not v2.Options.Toggle_AutoClaimGuildWeekly.Value then
              break
            end

            if not value131.claimed and value131.guildThreshold <= (getMyGuild.weeklyTotal or 0)
              and value131.personalMinimum <= (getMyGuild.personalWeekly or 0) then
              local v323 = f61("ClaimWeeklyTier", value131.tier)

              if type(v323) == "table" and v323.ok then
                v2:Notify({
                  Title = "Guild Weekly",
                  Content = "Claimed Tier " .. tostring(value131.tier),
                  Duration = 3,
                })
              end

              task.wait(0.5)
            end
          end
        end
      end

      task.wait(60)
    end

    v7.Flags.IsAutoClaimGuildWeeklyRunning = false
  end)
end

local function f129()
  if v7.Flags.IsAutoBuyGuildShopRunning or not v2.Options.Toggle_AutoBuyGuildShop.Value then
    return
  end

  v7.Flags.IsAutoBuyGuildShopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoBuyGuildShop.Value do
      local getShop = f61("GetShop")

      if type(getShop) == "table" then
        local value132 = v2.Options.Dropdown_AutoBuyGuildShopItems.Value

        for index90, value133 in ipairs(getShop) do
          if not v2.Options.Toggle_AutoBuyGuildShop.Value then
            break
          end

          local displayName4 = value133.displayName

          if type(value132) ~= "table" or value132[displayName4] then
            if value133.remaining > 0 and value133.affordable then
              f61("BuyShopItem", value133.id)
              task.wait(0.5)
            end
          end
        end
      end

      task.wait(60)
    end

    v7.Flags.IsAutoBuyGuildShopRunning = false
  end)
end

local function f130()
  if v7.Flags.IsAutoRallyLoopRunning then
    return
  end

  v7.Flags.IsAutoRallyLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded do
      if not (v2.Options.Toggle_AutoStartRally and v2.Options.Toggle_AutoStartRally.Value
        or v2.Options.Toggle_AutoStartGuildFishingRally
          and v2.Options.Toggle_AutoStartGuildFishingRally.Value) then
        break
      end

      pcall(function()
        local v324 = false
        local getRally = f61("GetRally")

        if type(getRally) == "table" and getRally.inGuild and getRally.canStart then
          v324 = true
        end

        if not v324 then
          local getGuildEventState = f61("GetGuildEventState")

          if type(getGuildEventState) == "table" and type(getGuildEventState.rally) == "table"
            and getGuildEventState.rally.canStart then
            v324 = true
          end
        end

        if v324 then
          f61("StartRally")
        end
      end)

      task.wait(60)
    end

    v7.Flags.IsAutoRallyLoopRunning = false
  end)
end

local function f131()
  local value134 = v2.Options.Toggle_AutoFriendOTronSeed.Value
  local value135 = value134 and v2.Options.Dropdown_FriendOTronSeedName.Value
  local value136 = not value134 and v2.Options.Dropdown_FriendOTronRarity.Value

  for index91, value137 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value137 then
      for index92, value138 in ipairs(value137:GetChildren()) do
        if value138:IsA("Tool") and value138:GetAttribute("InventoryCategory") == "Seeds" then
          local plant2 = value138:GetAttribute("Plant") or value138:GetAttribute("trueName")

          if plant2 and not f69(value138) and value138:GetAttribute("Fused") ~= true then
            local v325 = f80(plant2)

            if v325 ~= "Unknown" and v325 ~= "Common" and v325 ~= "Uncommon" then
              if value134 then
                if type(value135) == "table" and value135[plant2] then
                  return value138
                end
              elseif type(value136) == "table" and value136[v325] then
                return value138
              end
            end
          end
        end
      end
    end
  end

  return nil
end

local function f132()
  if v7.Flags.IsAutoFriendOTronRunning then
    return
  end

  if not (v2.Options.Toggle_AutoFriendOTronSeed.Value
    or v2.Options.Toggle_AutoFriendOTronRarity.Value) then
    return
  end

  if v2.Options.Toggle_AutoFriendOTronSeed.Value then
    local value139 = v2.Options.Dropdown_FriendOTronSeedName.Value

    if type(value139) ~= "table" or next(value139) == nil then
      return
    end
  elseif v2.Options.Toggle_AutoFriendOTronRarity.Value then
    local value140 = v2.Options.Dropdown_FriendOTronRarity.Value

    if type(value140) ~= "table" or next(value140) == nil then
      return
    end
  end

  v7.Flags.IsAutoFriendOTronRunning = true

  task.spawn(function()
    while not v2.Unloaded
      and (v2.Options.Toggle_AutoFriendOTronSeed.Value
        or v2.Options.Toggle_AutoFriendOTronRarity.Value) do
      local v326 = false

      repeat
        local v327 = v7.Data.FriendOTronCooldownUntil - workspace:GetServerTimeNow()

        if v327 > 0 then
          task.wait(math.clamp(v327, 3, 5))
          v326 = true
          break
        end

        if v7.Data.FriendOTronPendingSeedKey ~= "" then
          task.wait(3)
          v326 = true
          break
        end

        local friendOTron = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("FriendOTron")

        local insertSeed2 = friendOTron and friendOTron:FindFirstChild("InsertSeed")
        local friendOTron2 = workspace:FindFirstChild("FriendOTron")

        if not insertSeed2 or not friendOTron2 then
          task.wait(3)
          v326 = true
          break
        end

        local value141 = v2.Options.Dropdown_FriendOTronTargetSlot.Value or "Any Empty Slot"
        local v328 = {}

        if value141 == "Blue Slot" then
          v328 = { "Blue" }
        elseif value141 == "Purple Slot" then
          v328 = { "Purple" }
        else
          v328 = { "Blue", "Purple" }
        end

        for index93, value142 in ipairs(v328) do
          local v329 = false

          repeat
            if not (v2.Options.Toggle_AutoFriendOTronSeed.Value
              or v2.Options.Toggle_AutoFriendOTronRarity.Value) then
              break
            end

            if friendOTron2:FindFirstChild("FriendOTronSeedVisual_" .. value142) ~= nil then
              v329 = true
              break
            end

            local v330 = f131()

            if not v330 then
              v329 = true
              break
            end

            f48(v330)
            task.wait(0.2)
            pcall(function() insertSeed2:InvokeServer(value142) end)
            task.wait(0.2)
            f47()
            break
          until true

          if not v329 then
            break
          end
        end

        task.wait(3)
        v326 = true
      until true

      if not v326 then
        break
      end
    end

    v7.Flags.IsAutoFriendOTronRunning = false
  end)
end

local function f133()
  if v7.Flags.IsAutoFriendOTronSpinRunning then
    return
  end

  if not v2.Options.Toggle_AutoFriendOTronSpin.Value then
    return
  end

  v7.Flags.IsAutoFriendOTronSpinRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoFriendOTronSpin.Value do
      local v331 = false

      repeat
        local friendOTron3 = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("FriendOTron")

        local pullLever2 = friendOTron3 and friendOTron3:FindFirstChild("PullLever")

        if not pullLever2 then
          task.wait(3)
          v331 = true
          break
        end

        if v7.Data.FriendOTronSpins <= 0 then
          task.wait(3)
          v331 = true
          break
        end

        pcall(function() pullLever2:InvokeServer() end)
        task.wait(2.5)
        v331 = true
      until true

      if not v331 then
        break
      end
    end

    v7.Flags.IsAutoFriendOTronSpinRunning = false
  end)
end

local function f134()
  local v332 = f63(1)
  local petMutation2 = v332 and v332.PetMutation
  local session = petMutation2 and petMutation2.Session

  if type(session) ~= "table" or session.State ~= "Incubating" then
    return "Idle", nil, 0
  end

  local getServerTimeNow4 = workspace:GetServerTimeNow()

  if not session.ExpiresAt or session.ExpiresAt <= getServerTimeNow4 then
    return "Ready", session, 0
  end

  return "Incubating", session, math.max(0, math.floor(session.ExpiresAt - getServerTimeNow4))
end

local function f135()
  local value143 = v2.Options.Dropdown_PetMutationPetNames
      and v2.Options.Dropdown_PetMutationPetNames.Value
    or {}

  local value144 = v2.Options.Dropdown_PetMutationWhitelistMutations
      and v2.Options.Dropdown_PetMutationWhitelistMutations.Value
    or {}

  if not next(value143) then
    return nil
  end

  local petMutationConfig = v7.Data.PetMutationConfig or f33()
  local v333 = f63(1)
  local petMutation3 = v333 and v333.PetMutation

  local rerollDiscount = petMutation3 and petMutation3.Upgrades
      and petMutation3.Upgrades.RerollDiscount
    or 0

  local v334 = f5()

  for index94, value145 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value145 then
      for index95, value146 in ipairs(value145:GetChildren()) do
        local v335 = false

        repeat
          if value146:IsA("Tool") then
            local v336 = f46(value146)

            if v336 and value143[v336.petName] and (v336.level or 1) >= 50 then
              local petMutation4 = v336.petMutation or "Normal"
              local v337 = false

              if type(value144) == "table" then
                if value144[petMutation4] then
                  v337 = true
                else
                  for index96, value147 in ipairs(value144) do
                    if value147 == petMutation4 then
                      v337 = true
                      break
                    end
                  end
                end
              end

              if not v337 then
                local v338 = f81(v336.petName)

                if v338 and petMutationConfig
                  and type(petMutationConfig.GetMutationCost) == "function" then
                  local v339 = petMutation4 ~= "Normal" and petMutation4 ~= ""
                  local v340 = petMutationConfig.GetMutationCost(v338, v339, rerollDiscount)

                  if v340 and v340 > 0 and v334 < v340 then
                    v335 = true
                    break
                  end
                end

                return v336
              end
            end
          end

          v335 = true
        until true

        if not v335 then
          break
        end
      end
    end
  end

  return nil
end

local function f136()
  if v7.Flags.IsAutoBuyPetMutationUpgradesRunning
    or not v2.Options.Toggle_AutoBuyPetMutationUpgrades.Value then
    return
  end

  v7.Flags.IsAutoBuyPetMutationUpgradesRunning = true
  local v341 = f59("PetMutationService", "RF", "BuyUpgrade")
  local petMutationConfig2 = v7.Data.PetMutationConfig or f33()

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoBuyPetMutationUpgrades.Value do
      if v341 and petMutationConfig2 and petMutationConfig2.UpgradeCosts then
        local v342 = f63(1)
        local petMutation5 = v342 and v342.PetMutation
        local upgrades = petMutation5 and petMutation5.Upgrades or {}
        local value148 = v2.Options.Dropdown_PetMutationUpgradeSelection.Value or {}
        local v343 = f5()

        for index97, value149 in ipairs({ "IncubatorSpeed", "MutationLuck", "RerollDiscount" }) do
          if value148[value149] then
            local v344 = upgrades[value149] or 0

            if v344 < 5 then
              local v345 = petMutationConfig2.UpgradeCosts[value149]
                and petMutationConfig2.UpgradeCosts[value149][v344 + 1]

              if v345 and v345 > 0 and v343 >= v345 then
                pcall(function() v341:InvokeServer(value149) end)
                v343 = v343 - v345
                task.wait(1)
              end
            end
          end
        end
      end

      task.wait(5)
    end

    v7.Flags.IsAutoBuyPetMutationUpgradesRunning = false
  end)
end

local function f137()
  if v7.Flags.IsAutoStartPetMutationRunning or not v2.Options.Toggle_AutoStartPetMutation.Value then
    return
  end

  v7.Flags.IsAutoStartPetMutationRunning = true
  local v346 = f59("PetMutationService", "RF", "StartMutation")
  local v347 = f59("PetMutationService", "RF", "Claim")

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoStartPetMutation.Value do
      local v348, v349, v350 = f134()

      if v348 == "Ready" then
        if v2.Options.Toggle_AutoClaimPetMutation.Value and v347 then
          pcall(function() v347:InvokeServer() end)
        end

        task.wait(3)
      elseif v348 == "Idle" then
        local v351 = f135()

        if v351 and v346 then
          if v351.instance.Parent ~= localPlayer.Character then
            f48(v351.instance)
            task.wait(0.5)
          end

          pcall(function() v346:InvokeServer(v351.petKey) end)
          task.wait(0.5)
          f47()
          task.wait(3)
        else
          task.wait(5)
        end
      elseif v348 == "Incubating" then
        task.wait(math.clamp(v350, 3, 5))
      else
        task.wait(3)
      end
    end

    v7.Flags.IsAutoStartPetMutationRunning = false
  end)
end

local function f138()
  if v7.Flags.IsAutoClaimPetMutationRunning or not v2.Options.Toggle_AutoClaimPetMutation.Value then
    return
  end

  v7.Flags.IsAutoClaimPetMutationRunning = true
  local v352 = f59("PetMutationService", "RF", "Claim")

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoClaimPetMutation.Value do
      local v353, v354, v355 = f134()

      if v353 == "Ready" and v352 then
        pcall(function() v352:InvokeServer() end)
        task.wait(3)
      elseif v353 == "Incubating" then
        task.wait(math.clamp(v355, 3, 5))
      else
        task.wait(5)
      end
    end

    v7.Flags.IsAutoClaimPetMutationRunning = false
  end)
end

local function f139()
  if v7.Flags.IsAutoClaimSeasonPassQuestsRunning
    or not (v2.Options.Toggle_AutoClaimSeasonPassQuests
      and v2.Options.Toggle_AutoClaimSeasonPassQuests.Value) then
    return
  end

  v7.Flags.IsAutoClaimSeasonPassQuestsRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoClaimSeasonPassQuests
      and v2.Options.Toggle_AutoClaimSeasonPassQuests.Value do
      pcall(function()
        local v356 = f64()
        local v357 = f59("SeasonPassService", "RF", "ClaimQuest")

        if v356 and v357 and v356.Quests then
          for key20, value150 in pairs(v356.Quests) do
            if type(value150) == "table" then
              for key21, value151 in pairs(value150) do
                if not (v2.Options.Toggle_AutoClaimSeasonPassQuests
                  and v2.Options.Toggle_AutoClaimSeasonPassQuests.Value) then
                  break
                end

                pcall(function() v357:InvokeServer(key20, key21) end)
                task.wait(0.1)
              end
            end
          end
        end
      end)

      task.wait(30)
    end

    v7.Flags.IsAutoClaimSeasonPassQuestsRunning = false
  end)
end

local function f140()
  if v7.Flags.IsAutoClaimSeasonPassRewardsRunning
    or not (v2.Options.Toggle_AutoClaimSeasonPassRewards
      and v2.Options.Toggle_AutoClaimSeasonPassRewards.Value) then
    return
  end

  v7.Flags.IsAutoClaimSeasonPassRewardsRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoClaimSeasonPassRewards
      and v2.Options.Toggle_AutoClaimSeasonPassRewards.Value do
      pcall(function()
        local v358 = f59("SeasonPassService", "RF", "ClaimAllRewards")

        if v358 then
          pcall(function() v358:InvokeServer() end)
        end
      end)

      task.wait(30)
    end

    v7.Flags.IsAutoClaimSeasonPassRewardsRunning = false
  end)
end

local function f141()
  if v7.Flags.IsAutoSpinSeasonPassCrateRunning
    or not (v2.Options.Toggle_AutoSpinSeasonPassCrate
      and v2.Options.Toggle_AutoSpinSeasonPassCrate.Value) then
    return
  end

  v7.Flags.IsAutoSpinSeasonPassCrateRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoSpinSeasonPassCrate
      and v2.Options.Toggle_AutoSpinSeasonPassCrate.Value do
      pcall(function()
        local v359 = f64()
        local v360 = f59("SeasonPassService", "RF", "PurchaseUseSpin")

        if v360 and v359 then
          local v361 = f62()
          local v362 = tostring(v359.CurrentSeason or 4)
          local seasonPasses = v361 and v361.SeasonPasses and v361.SeasonPasses[v362]
          local spinCount = seasonPasses and seasonPasses.SpinCount or 0
          local v363 = f65(v359)
          local spinCost = v359.SpinCost or 125

          if spinCount > 0 or v363 >= spinCost then
            pcall(function() v360:InvokeServer() end)
          end
        end
      end)

      task.wait(2)
    end

    v7.Flags.IsAutoSpinSeasonPassCrateRunning = false
  end)
end

local function f142()
  local getServerTimeNow5 = workspace:GetServerTimeNow()
  local v364 = f35()
  local v365 = false
  local v366 = nil
  local v367 = nil

  local wanderingMerchant = workspace:FindFirstChild("InteractiveEvents")
    and workspace.InteractiveEvents:FindFirstChild("WanderingMerchant")

  if wanderingMerchant and #wanderingMerchant:GetChildren() > 1 then
    v365 = true
  end

  if v364 and type(v364.GetActiveVisit) == "function" then
    local v368, v369 = v364.GetActiveVisit(getServerTimeNow5)

    if v368 and v369 and getServerTimeNow5 >= v368 and getServerTimeNow5 < v369 then
      v365 = true
      v366 = v368
      v367 = v369
    elseif v368 and v369 and v365 then
      v366 = v368
      v367 = v369
    end
  end

  local v370 = nil

  if v364 and type(v364.GetNextVisitAt) == "function" then
    v370 = v364.GetNextVisitAt(getServerTimeNow5)
  end

  local v371 = 0

  if v365 and v367 and v367 > getServerTimeNow5 then
    v371 = math.max(0, math.floor(v367 - getServerTimeNow5))
  end

  return v365, v366, v367, v371, v370
end

local function f143()
  task.spawn(function()
    while not v2.Unloaded do
      pcall(function()
        if v7.Paragraph.WanderingMerchantInfo then
          local v372, v373, v374, v375, v376 = f142()

          if v372 and v375 > 0 then
            local v377 = math.floor(v375 / 3600)
            local v378 = math.floor(v375 % 3600 / 60)
            local v379 = v375 % 60

            local v380 = v377 > 0 and string.format("%dh %02dm %02ds", v377, v378, v379)
              or string.format("%dm %02ds", v378, v379)

            v7.Paragraph.WanderingMerchantInfo:SetContent("Time Remaining: <font color=\"#00E676\">"
              .. v380 .. "</font>")
          else
            local getServerTimeNow6 = workspace:GetServerTimeNow()

            if v376 and v376 > getServerTimeNow6 then
              local v381 = math.max(0, math.floor(v376 - getServerTimeNow6))
              local v382 = math.floor(v381 / 3600)
              local v383 = math.floor(v381 % 3600 / 60)
              local v384 = v381 % 60
              local v385 = string.format("%dh %02dm %02ds", v382, v383, v384)

              v7.Paragraph.WanderingMerchantInfo:SetContent("Next Visit In: <font color=\"#40C4FF\">"
                .. v385 .. "</font>")
            else
              v7.Paragraph.WanderingMerchantInfo:SetContent("The merchant is away")
            end
          end
        end
      end)

      task.wait(5)
    end
  end)
end

local function f144()
  local v386 = f35()

  if not v386 then
    return nil, nil, nil
  end

  local v387, v388 = f142()

  if not v387 then
    return nil, nil, v386
  end

  local v389 = f62()
  local invokeServer3 = nil
  local v390 = f59("WanderingMerchantService", "RF", "GetState")

  if v390 then
    pcall(function() invokeServer3 = v390:InvokeServer() end)
  end

  local wanderingMerchant2 = v389 and v389.WanderingMerchant or invokeServer3

  local visit = wanderingMerchant2 and wanderingMerchant2.Visit
    or invokeServer3 and invokeServer3.Visit or type(invokeServer3) == "table" and invokeServer3

  local completed = visit and visit.Completed or invokeServer3 and invokeServer3.Completed

  local v391 = v388 or visit and tonumber(visit.Id or visit.VisitId)
    or invokeServer3 and tonumber(invokeServer3.VisitId)

  local orders = visit and type(visit.Orders) == "table" and visit.Orders
    or invokeServer3 and type(invokeServer3.Orders) == "table" and invokeServer3.Orders or nil

  local v392 = nil

  if v391 and type(v386.RollVisitOrders) == "function" then
    local v393, v394 = pcall(v386.RollVisitOrders, v391)

    if v393 and type(v394) == "table" then
      v392 = v394
    end
  end

  local v395 = {}

  for index98, value152 in ipairs(v386.TierOrder or { "Accessible", "MidLate", "Chase" }) do
    local v396 = orders and orders[value152] or v392 and v392[value152]

    if v396 then
      v395[value152] = v396
    end
  end

  if next(v395) ~= nil then
    return v395, completed, v386
  end

  if type(orders) == "table" and next(orders) ~= nil then
    return orders, completed, v386
  end

  return nil, completed, v386
end

local function f145()
  if v7.Flags.IsAutoSubmitMerchantTradesRunning
    or not (v2.Options.Toggle_AutoSubmitMerchantTrades
      and v2.Options.Toggle_AutoSubmitMerchantTrades.Value) then
    return
  end

  v7.Flags.IsAutoSubmitMerchantTradesRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoSubmitMerchantTrades
      and v2.Options.Toggle_AutoSubmitMerchantTrades.Value do
      local v397 = false
      local v398 = false

      if not f142() then
        v398 = true
      else
        local v399, v400, v401 = f144()

        if type(v399) == "table" and next(v399) ~= nil then
          local v402 = f59("WanderingMerchantService", "RF", "SubmitTrade")

          if v402 then
            local backpack4 = localPlayer:FindFirstChild("Backpack")
            local character5 = localPlayer.Character

            for key22, value153 in pairs(v399) do
              if not (v2.Options.Toggle_AutoSubmitMerchantTrades
                and v2.Options.Toggle_AutoSubmitMerchantTrades.Value) then
                break
              end

              if type(value153) == "string" and not (v400 and v400[value153] == true) then
                local v403 = v401.GetTrade(value153)

                if v403 and v403.Def and type(v403.Def.Predicate) == "function" then
                  local v404 = nil

                  for index99, value154 in ipairs({ backpack4, character5 }) do
                    if value154 then
                      for index100, value155 in ipairs(value154:GetChildren()) do
                        if value155:IsA("Tool") then
                          if not f69(value155) then
                            local plant3 = value155:GetAttribute("Plant")
                              or value155:GetAttribute("seedKey")

                            if plant3 then
                              local mutation2 = value155:GetAttribute("Mutation") or "Normal"
                              local fused = value155:GetAttribute("Fused") or false

                              local v405, v406 = pcall(
                                v403.Def.Predicate, plant3, mutation2, nil, fused
                              )

                              if v405 and v406 then
                                v404 = value155
                                break
                              end
                            end
                          end
                        end
                      end
                    end

                    if v404 then
                      break
                    end
                  end

                  if v404 then
                    f48(v404)
                    local seedKey3 = v404:GetAttribute("seedKey") or v404.Name

                    local v407, v408 = pcall(function()
                      return v402:InvokeServer(value153, seedKey3)
                    end)

                    if v407 and type(v408) == "table" then
                      if v408.ok == true then
                        v7.Cache.ReplicatorSnapshotTime = 0
                        v397 = true
                      elseif v408.ok == false
                        and string.find(tostring(v408.error), "away", 1, true) then
                        v398 = true
                      end
                    end
                  end
                end
              end

              if v398 then
                break
              end
            end
          end
        end
      end

      if v397 then
        task.wait(0.5)
      elseif v398 then
        task.wait(10)
      else
        task.wait(5)
      end
    end

    v7.Flags.IsAutoSubmitMerchantTradesRunning = false
  end)
end

local function f146()
  if v7.Flags.IsAutoBuyMerchantShopRunning
    or not (v2.Options.Toggle_AutoBuyMerchantShop and v2.Options.Toggle_AutoBuyMerchantShop.Value) then
    return
  end

  v7.Flags.IsAutoBuyMerchantShopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoBuyMerchantShop
      and v2.Options.Toggle_AutoBuyMerchantShop.Value do
      local v409 = false
      local v410 = false

      if not f142() then
        v410 = true
      else
        local v411 = f35()
        local v412 = f62()
        local invokeServer4 = nil
        local v413 = f59("WanderingMerchantService", "RF", "GetState")

        if v413 then
          pcall(function() invokeServer4 = v413:InvokeServer() end)
        end

        local wanderingMerchant3 = v412 and v412.WanderingMerchant or invokeServer4

        local favor = wanderingMerchant3 and wanderingMerchant3.Favor
          or invokeServer4 and invokeServer4.Favor or 0

        local shop = wanderingMerchant3 and wanderingMerchant3.Shop
          or invokeServer4 and invokeServer4.Shop

        local value156 = v2.Options.Dropdown_MerchantShopItems
          and v2.Options.Dropdown_MerchantShopItems.Value

        if type(value156) == "table" then
          local v414 = f59("WanderingMerchantService", "RF", "BuyShopItem")

          if v414 then
            for key23, value157 in pairs(value156) do
              if value157 then
                local wanderingMerchantItemIdMap = v7.Data.WanderingMerchantItemIdMap
                  and v7.Data.WanderingMerchantItemIdMap[key23]

                if wanderingMerchantItemIdMap then
                  local v415 = v411.GetItem(wanderingMerchantItemIdMap)
                  local cost = v415 and (v415.Cost or 0) or 0

                  if (shop and shop[wanderingMerchantItemIdMap]
                          and shop[wanderingMerchantItemIdMap].Bought
                        or 0)
                      < (v415 and (v415.Stock or 1) or 1)
                    and favor >= cost then
                    local v416, v417 = pcall(function()
                      return v414:InvokeServer(wanderingMerchantItemIdMap)
                    end)

                    if v416 and type(v417) == "table" then
                      if v417.ok == true then
                        v7.Cache.ReplicatorSnapshotTime = 0
                        v409 = true
                      elseif v417.ok == false
                        and string.find(tostring(v417.error), "away", 1, true) then
                        v410 = true
                        break
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      if v409 then
        task.wait(0.5)
      elseif v410 then
        task.wait(10)
      else
        task.wait(5)
      end
    end

    v7.Flags.IsAutoBuyMerchantShopRunning = false
  end)
end

local function f147()
  local v418, v419 = pcall(function()
    return require(replicatedStorage:WaitForChild("Packages", 2):WaitForChild("Knit", 2))
  end)

  if v418 and v419 then
    local v420, v421 = pcall(function() return v419.GetService("FuseService") end)

    if v420 and v421 then
      return v421
    end
  end

  return nil
end

local function f148(p94, ...)
  local v422 = f147()

  if v422 and type(v422[p94]) == "function" then
    local v423, v424 = pcall(function(...) return v422[p94](v422, ...) end, ...)

    if v423 then
      return v423, v424
    end
  end

  local v425 = f59("FuseService", "RF", p94)

  if v425 then
    local v426, v427 = pcall(function(...) return v425:InvokeServer(...) end, ...)
    return v426, v427
  end

  return false, "FuseService / RF not found"
end

local function f149()
  local v428 = f63(1)
  local session2 = v428 and v428.Fuse and v428.Fuse.Session

  if type(session2) ~= "table" or type(session2.Inserted) ~= "table" then
    return "Idle", nil, 0
  end

  if session2.State == "Staging" then
    return "Staging", session2, 0
  end

  if session2.State ~= "Fusing" or type(session2.ExpiresAt) ~= "number" then
    return "Idle", nil, 0
  end

  local getServerTimeNow7 = workspace:GetServerTimeNow()

  if session2.ExpiresAt <= getServerTimeNow7 then
    return "Ready", session2, 0
  end

  return "Fusing", session2, math.max(0, math.floor(session2.ExpiresAt - getServerTimeNow7))
end

local function f150()
  local value158 = v2.Options.Toggle_AutoFuseSelected
    and v2.Options.Toggle_AutoFuseSelected.Value

  local value159 = v2.Options.Toggle_AutoFuseByRarity
    and v2.Options.Toggle_AutoFuseByRarity.Value

  if not value158 and not value159 then
    return nil
  end

  local value160 = v2.Options.Dropdown_FuseSeeds and v2.Options.Dropdown_FuseSeeds.Value or {}

  local value161 = v2.Options.Dropdown_FuseRarities and v2.Options.Dropdown_FuseRarities.Value
    or {}

  if value158 and next(value160) == nil then
    return nil
  end

  if value159 and next(value161) == nil then
    return nil
  end

  for index101, value162 in ipairs({
    localPlayer:FindFirstChild("Backpack"), localPlayer.Character,
  }) do
    if value162 then
      for index102, value163 in ipairs(value162:GetChildren()) do
        if value163:IsA("Tool") and value163:GetAttribute("InventoryCategory") == "Seeds" then
          if not f69(value163) and value163:GetAttribute("Fused") ~= true then
            local plant4 = value163:GetAttribute("Plant") or value163:GetAttribute("trueName")

            if plant4 then
              local v429 = false

              if value158 and value160[plant4] == true then
                v429 = true
              elseif value159 then
                if value161[f80(plant4)] == true then
                  v429 = true
                end
              end

              if v429 then
                return value163
              end
            end
          end
        end
      end
    end
  end

  return nil
end

local function f151(p95)
  if not p95 or not p95.Parent then
    return false
  end

  f48(p95)
  local v430, v431 = f148("Stage")
  f47()
  task.wait(0.55)
  return v430
end

local function f152()
  if v7.Flags.IsAutoFuseLoopRunning then
    return
  end

  if not (v2.Options.Toggle_AutoFuseSelected.Value or v2.Options.Toggle_AutoFuseByRarity.Value) then
    return
  end

  v7.Flags.IsAutoFuseLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded
      and (v2.Options.Toggle_AutoFuseSelected.Value or v2.Options.Toggle_AutoFuseByRarity.Value) do
      local v432, v433, v434 = f149()

      if v432 == "Ready" then
        f148("Collect")
        task.wait(3)
      elseif v432 == "Idle" or v432 == "Staging" then
        if (v433 and type(v433.Inserted) == "table" and #v433.Inserted or 0) >= 4 then
          f148("StartFuse")
          task.wait(3)
        else
          local v435 = f150()

          if v435 then
            f151(v435)
          else
            task.wait(5)
          end
        end
      elseif v432 == "Fusing" then
        task.wait(math.clamp(v434, 3, 5))
      else
        task.wait(3)
      end
    end

    v7.Flags.IsAutoFuseLoopRunning = false
  end)
end

local function f153()
  local v436, v437 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 2):WaitForChild("PlantBossConfig", 2))
  end)

  if v436 and v437 then
    return v437
  end

  return nil
end

local function f154(p96, p97, p98, p99, p100)
  local v438, v439 = pcall(function() return p97:InvokeServer(p96) end)

  if not v438 or not v439 then
    return
  end

  local entry = v439.Entry

  if entry == "boss_root" or entry == "boss_submit" or entry == "boss_idle"
    or entry == "task_show" or entry == "final_unlock" then
    p100.Unlocked = true
  end

  if not p100.Unlocked then
    local v440, v441 = pcall(function() return p98:InvokeServer(p96, "quest_current") end)
    local context = v440 and v441 and v441.Context

    if context and context.desc then
      for index103, value164 in ipairs(p99.Quests) do
        if value164.Description == context.desc
          or string.find(context.desc, value164.Description, 1, true)
          or string.find(value164.Description, context.desc, 1, true) then
          p100.CurrentQuest = value164
          p100.IsSacrifice = value164.Sacrifice == true
          break
        end
      end

      p100.Progress = tonumber(context.progress) or 0

      p100.Requirement = tonumber(context.req)
        or p100.CurrentQuest and p100.CurrentQuest.Requirement or 0

      if entry == "ready_work" or entry == "ready_sacrifice"
        or p100.Requirement > 0 and p100.Progress >= p100.Requirement then
        p100.IsReady = true
        p100.Progress = math.max(p100.Progress, p100.Requirement)
      end
    end
  end
end

local function f155(p101, p102, p103)
  if not p101.Unlocked and not p101.CurrentQuest and p102 and p103 then
    local claimed = p103.Claimed or {}

    for index104, value165 in ipairs(p102.Quests) do
      if claimed[tostring(value165.Id)] ~= true and claimed[value165.Id] ~= true then
        p101.CurrentQuest = value165
        p101.IsSacrifice = value165.Sacrifice == true
        p101.Requirement = value165.Requirement or 0

        break
      end
    end

    if p101.CurrentQuest and p103.Progress then
      p101.Progress = tonumber(p103.Progress[tostring(p101.CurrentQuest.Id)])
        or tonumber(p103.Progress[p101.CurrentQuest.Id]) or 0

      if p101.Requirement > 0 and p101.Progress >= p101.Requirement then
        p101.IsReady = true
      end
    end
  end

  if p101.Unlocked and p103 and type(p103.ActiveTask) == "table" then
    p101.HasTask = true
    p101.ActiveTask = p103.ActiveTask
    p101.TaskRequirement = p103.ActiveTask.Requirement or 0
    p101.TaskProgress = tonumber(p103.TaskProgress) or 0

    p101.IsTaskSacrifice = p102
        and p103.ActiveTask.Objective == p102.Objectives.SubmitPlantValue
      or false

    if p101.TaskRequirement > 0 and p101.TaskProgress >= p101.TaskRequirement then
      p101.IsTaskReady = true
    end
  end
end

local function f156(p104)
  local v442 = tick()

  if not p104 and v7.Cache.GolemQuestCache and v7.Cache.GolemQuestCacheTime
    and v442 - v7.Cache.GolemQuestCacheTime < 3 then
    return v7.Cache.GolemQuestCache
  end

  local v443 = f153()
  local overgrownFarmer = workspace:FindFirstChild("OvergrownFarmer")
  local v444 = f59("DialogueService", "RF", "BeginDialogue")
  local v445 = f59("DialogueService", "RF", "ResolveDialogue")
  local v446 = f62()
  local plantBossQuest = v446 and v446.PlantBossQuest

  local v447 = {
    Unlocked = plantBossQuest and plantBossQuest.Unlocked or false,
    PetLevel = plantBossQuest and plantBossQuest.PetLevel or 1,
    PetXP = plantBossQuest and plantBossQuest.PetXP or 0,
    Size = v443 and v443.SizeForLevel
        and v443.SizeForLevel(plantBossQuest and plantBossQuest.PetLevel or 1)
      or "Regular",
    Earnings = v443 and v443.EarningsForLevel
        and v443.EarningsForLevel(plantBossQuest and plantBossQuest.PetLevel or 1)
      or 5.5,
    XPRequired = v443 and v443.XPRequired
        and v443.XPRequired(plantBossQuest and plantBossQuest.PetLevel or 1)
      or 0,
    CurrentQuest = nil,
    Progress = 0,
    Requirement = 0,
    IsSacrifice = false,
    IsReady = false,
    HasTask = false,
    ActiveTask = nil,
    TaskProgress = 0,
    TaskRequirement = 0,
    IsTaskSacrifice = false,
    IsTaskReady = false,
  }

  if v443 and overgrownFarmer and v444 and v445 then
    f154(overgrownFarmer, v444, v445, v443, v447)
  end

  f155(v447, v443, plantBossQuest)

  v7.Cache.GolemQuestCache = v447
  v7.Cache.GolemQuestCacheTime = v442

  return v447
end

local function f157()
  local v448 = {}
  local backpack5 = localPlayer:FindFirstChild("Backpack")
  local character6 = localPlayer.Character

  local function f158(p105)
    if not p105 then
      return
    end

    for index105, value166 in ipairs(p105:GetChildren()) do
      if value166:IsA("Tool") and value166:GetAttribute("seedKey") and not f69(value166) then
        table.insert(v448, value166)
      end
    end
  end

  f158(backpack5)
  f158(character6)

  return v448
end

local function f159(p106, p107, p108, p109, p110)
  if not p109 or not p109.Parent then
    return false
  end

  f48(p109)
  task.wait(0.2)

  local v449 = pcall(function()
    p107:InvokeServer(p106)
    task.wait(0.2)
    p108:InvokeServer(p106, p110 and "task_finish" or "sacrifice_check")
  end)

  task.wait(0.3)
  f47()
  v7.Cache.GolemQuestCacheTime = 0
  return v449
end

local function f160(p111, p112, p113)
  return (pcall(function()
    p112:InvokeServer(p111)
    task.wait(0.2)
    p113:InvokeServer(p111, "work_check")
    v7.Cache.GolemQuestCacheTime = 0
  end))
end

local function f161(p114, p115, p116)
  return (pcall(function()
    p115:InvokeServer(p114)
    task.wait(0.2)
    p116:InvokeServer(p114, "task_give")
    v7.Cache.GolemQuestCacheTime = 0
  end))
end

local function f162(p117, p118, p119)
  return (pcall(function()
    p118:InvokeServer(p117)
    task.wait(0.2)
    p119:InvokeServer(p117, "task_finish")
    v7.Cache.GolemQuestCacheTime = 0
  end))
end

local function f163()
  local v450 = f156()
  local v451 = false
  local v452 = false

  if not v450.Unlocked then
    if v450.CurrentQuest and v450.IsSacrifice and v450.Progress < v450.Requirement then
      v451 = true
      v452 = false
    end
  elseif v450.HasTask and v450.IsTaskSacrifice and v450.TaskProgress < v450.TaskRequirement then
    v451 = true
    v452 = true
  end

  if not v451 then
    return
  end

  local overgrownFarmer2 = workspace:FindFirstChild("OvergrownFarmer")
  local v453 = f59("DialogueService", "RF", "BeginDialogue")
  local v454 = f59("DialogueService", "RF", "ResolveDialogue")

  if not overgrownFarmer2 or not v453 or not v454 then
    return
  end

  local v455 = f157()

  if #v455 == 0 then
    return
  end

  for index106, value167 in ipairs(v455) do
    if not (v2.Options.Toggle_GolemAutoSacrifice and v2.Options.Toggle_GolemAutoSacrifice.Value) then
      break
    end

    local v456 = f156()

    if not v452 then
      if not v456.CurrentQuest or not v456.IsSacrifice or v456.Progress >= v456.Requirement then
        break
      end
    elseif not v456.HasTask or not v456.IsTaskSacrifice
      or v456.TaskProgress >= v456.TaskRequirement then
      break
    end

    f159(overgrownFarmer2, v453, v454, value167, v452)
  end
end

local function f164()
  if v7.Flags.IsGolemAutoSacrificeRunning
    or not (v2.Options.Toggle_GolemAutoSacrifice and v2.Options.Toggle_GolemAutoSacrifice.Value) then
    return
  end

  v7.Flags.IsGolemAutoSacrificeRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_GolemAutoSacrifice
      and v2.Options.Toggle_GolemAutoSacrifice.Value do
      pcall(f163)
      task.wait(2)
    end

    f47()
    v7.Flags.IsGolemAutoSacrificeRunning = false
  end)
end

local function f165()
  local v457 = f156()
  local overgrownFarmer3 = workspace:FindFirstChild("OvergrownFarmer")
  local v458 = f59("DialogueService", "RF", "BeginDialogue")
  local v459 = f59("DialogueService", "RF", "ResolveDialogue")

  if not overgrownFarmer3 or not v458 or not v459 then
    return
  end

  if not v457.Unlocked then
    if v457.IsReady or v457.Requirement > 0 and v457.Progress >= v457.Requirement then
      f160(overgrownFarmer3, v458, v459)
    end
  elseif not v457.HasTask then
    f161(overgrownFarmer3, v458, v459)
  elseif not v457.IsTaskSacrifice
    and (v457.IsTaskReady
      or v457.TaskRequirement > 0 and v457.TaskProgress >= v457.TaskRequirement) then
    f162(overgrownFarmer3, v458, v459)
  end
end

local function f166()
  if v7.Flags.IsGolemAutoAdvanceRunning
    or not (v2.Options.Toggle_GolemAutoAdvance and v2.Options.Toggle_GolemAutoAdvance.Value) then
    return
  end

  v7.Flags.IsGolemAutoAdvanceRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_GolemAutoAdvance
      and v2.Options.Toggle_GolemAutoAdvance.Value do
      pcall(f165)
      task.wait(10)
    end

    v7.Flags.IsGolemAutoAdvanceRunning = false
  end)
end

local function f167(p120)
  v7.Flags.IsAutoFriendRequestEnabled = p120

  if p120 then
    for index107, value168 in ipairs(game:GetService("Players"):GetPlayers()) do
      f10(value168)
      task.wait(1)
    end

    if not v7.Connections.FriendRequestPlayerAddedConn then
      v7.Connections.FriendRequestPlayerAddedConn = game:GetService("Players").PlayerAdded:Connect(function(player)
        if v7.Flags.IsAutoFriendRequestEnabled then
          task.wait(2)
          f10(player)
        end
      end)
    end
  elseif v7.Connections.FriendRequestPlayerAddedConn then
    v7.Connections.FriendRequestPlayerAddedConn:Disconnect()
    v7.Connections.FriendRequestPlayerAddedConn = nil
  end
end

local function f168()
  local character7 = localPlayer.Character
  local humanoidRootPart16 = character7 and character7:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart16 then
    return
  end

  local value169 = v2.Options.Dropdown_NeighbourChoreTypes
      and v2.Options.Dropdown_NeighbourChoreTypes.Value
    or {}

  local v460 = value169.Tend == true
  local v461 = value169.Prune == true
  local v462 = value169.Groom == true

  if not v460 and not v461 and not v462 then
    return
  end

  local v463 = f59("NeighbourChoresService", "RF", "GetState")
  local v464 = f59("NeighbourChoresService", "RF", "PerformChore")

  if not v463 or not v464 then
    return
  end

  local v465, v466 = pcall(function() return v463:InvokeServer() end)

  if not v465 or not v466 or (v466.Remaining or 0) <= 0 then
    return
  end

  local cframe2 = humanoidRootPart16.CFrame
  local remaining = v466.Remaining

  local value170 = v2.Options.Toggle_ExtremeLowPerf and v2.Options.Toggle_ExtremeLowPerf.Value
    or v2.Options.Toggle_HideOtherPlots and v2.Options.Toggle_HideOtherPlots.Value

  if value170 then
    f11(false)
    task.wait(0.2)
  end

  local v467 = require(replicatedStorage.Shared.FarmPlots)
  local v468 = require(replicatedStorage.Shared.PlotUtils)
  local v469 = v468.GetPlotsFolder()

  if v469 then
    local players = game:GetService("Players")

    for index108, value171 in ipairs(v469:GetChildren()) do
      if remaining <= 0 then
        break
      end

      if not (v2.Options.Toggle_AutoNeighbourChores and v2.Options.Toggle_AutoNeighbourChores.Value) then
        break
      end

      local v470 = v468.GetPlotOwner(value171)

      if v470 and v470 ~= localPlayer.UserId and players:GetPlayerByUserId(v470) then
        local perFarm = v466.PerFarm and v466.PerFarm[tostring(v470)] or 0
        local maxPerFarm = v466.MaxPerFarm or 3

        while perFarm < maxPerFarm and remaining > 0 do
          if not (v2.Options.Toggle_AutoNeighbourChores
            and v2.Options.Toggle_AutoNeighbourChores.Value) then
            break
          end

          local v471 = nil

          if v460 or v461 then
            for i10 = 1, 5 do
              local v472 = v467.FarmPlotForFloor(value171, i10)

              if v472 then
                for index109, value172 in ipairs(v472:GetChildren()) do
                  local dirt5 = value172:IsA("Model") and value172:FindFirstChild("Dirt")

                  if dirt5 and dirt5:IsA("BasePart") and dirt5:GetAttribute("PlantName") then
                    local v473 = v467.PlotKeyFromDirt(dirt5)

                    if v473 then
                      if dirt5:GetAttribute("PlantFullyGrown") ~= true then
                        if v460 then
                          v471 = { ChoreId = "Tend", TargetKey = v473, Part = dirt5 }
                          break
                        end
                      elseif v461 and not v471 then
                        v471 = { ChoreId = "Prune", TargetKey = v473, Part = dirt5 }
                      end
                    end
                  end
                end
              end

              if v471 and v471.ChoreId == "Tend" then
                break
              end
            end
          end

          if v462 and not v471 then
            for index110, value173 in ipairs(value171:GetChildren()) do
              if value173:IsA("Model") and value173.PrimaryPart then
                local petKey4 = value173:GetAttribute("PetKey")

                if type(petKey4) == "string" then
                  v471 = { ChoreId = "Groom", TargetKey = petKey4, Part = value173.PrimaryPart }
                  break
                end
              end
            end
          end

          if not v471 then
            break
          end

          local character8 = localPlayer.Character

          local humanoidRootPart17 = character8
            and character8:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart17 then
            break
          end

          humanoidRootPart17.CFrame = v471.Part.CFrame + Vector3.new(0, 3, 0)
          task.wait(0.6)

          local v474, v475 = pcall(function()
            return v464:InvokeServer(v470, v471.ChoreId, v471.TargetKey)
          end)

          if v474 and v475 then
            perFarm = perFarm + 1
            remaining = remaining - 1

            v2:Notify({
              Title = "Neighbour Chores",
              Content = "Completed " .. v471.ChoreId .. " (" .. 12 - remaining .. "/12)",
              Duration = 3,
            })
          else
            break
          end

          task.wait(0.3)
        end
      end
    end
  end

  if value170 then
    f11(true)
  end

  local character9 = localPlayer.Character
  local humanoidRootPart18 = character9 and character9:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart18 and cframe2 then
    humanoidRootPart18.CFrame = cframe2
  end
end

local function f169()
  if v7.Flags.IsAutoNeighbourChoresLoopRunning then
    return
  end

  if not (v2.Options.Toggle_AutoNeighbourChores and v2.Options.Toggle_AutoNeighbourChores.Value) then
    return
  end

  v7.Flags.IsAutoNeighbourChoresLoopRunning = true

  task.spawn(function()
    while not v2.Unloaded and v2.Options.Toggle_AutoNeighbourChores
      and v2.Options.Toggle_AutoNeighbourChores.Value do
      f168()

      for i11 = 1, 60 do
        if v2.Unloaded
          or not (v2.Options.Toggle_AutoNeighbourChores
            and v2.Options.Toggle_AutoNeighbourChores.Value) then
          break
        end

        task.wait(1)
      end
    end

    v7.Flags.IsAutoNeighbourChoresLoopRunning = false
  end)
end

local function f170()
  if v7.Flags.IsAutoClaimPetExpeditionRunning
    or not v2.Options.Toggle_AutoClaimPetExpedition.Value then
    return
  end

  v7.Flags.IsAutoClaimPetExpeditionRunning = true

  task.spawn(function()
    local v476 = f59("PetExpeditionService", "RF", "Claim")

    while not v2.Unloaded and v2.Options.Toggle_AutoClaimPetExpedition.Value do
      if v476 then
        local v477 = f63(1)
        local petExpeditions = v477 and v477.PetExpeditions
        local slots = petExpeditions and petExpeditions.Slots

        if slots then
          local getServerTimeNow8 = workspace:GetServerTimeNow()

          for key24, value174 in pairs(slots) do
            if type(value174) == "table" and value174.ExpiresAt
              and value174.ExpiresAt <= getServerTimeNow8 then
              local v478 = tonumber(key24)

              if v478 then
                if v476:InvokeServer(v478) then
                  v2:Notify({
                    Title = "Pet Expeditions",
                    Content = "Claimed rewards for "
                      .. (value174.ExpeditionId or "Slot " .. v478),
                    Duration = 4,
                  })
                end
              end
            end
          end
        end
      end

      task.wait(3)
    end

    v7.Flags.IsAutoClaimPetExpeditionRunning = false
  end)
end

local function f171()
  if v7.Flags.IsAutoDispatchPetExpeditionRunning
    or not v2.Options.Toggle_AutoDispatchPetExpedition.Value then
    return
  end

  v7.Flags.IsAutoDispatchPetExpeditionRunning = true

  task.spawn(function()
    local v479 = f59("PetExpeditionService", "RF", "GetBoard")
    local v480 = f59("PetExpeditionService", "RF", "Dispatch")
    local v481 = f40()

    while not v2.Unloaded and v2.Options.Toggle_AutoDispatchPetExpedition.Value do
      if v479 and v480 and v481 then
        local v482 = f63(1)
        local petExpeditions2 = v482 and v482.PetExpeditions
        local slots2 = petExpeditions2 and petExpeditions2.Slots

        if slots2 then
          local v483 = nil
          local v484 = {}

          for key25, value175 in pairs(slots2) do
            if type(value175) == "table" then
              if value175.PetKeys then
                for index111, value176 in ipairs(value175.PetKeys) do
                  v484[value176] = true
                end
              end
            elseif value175 == false and not v483 then
              v483 = tonumber(key25)
            end
          end

          if v483 then
            local invokeServer5 = v479:InvokeServer()

            if type(invokeServer5) == "table" and invokeServer5.Expeditions
              and #invokeServer5.Expeditions > 0 then
              local v485 = {}

              if v482.EquippedPets then
                for key26, value177 in pairs(v482.EquippedPets) do
                  if value177 ~= "" then
                    v485[value177] = true
                  end
                end
              end

              local petInventory = v482.PetInventory or {}
              local v486 = {}

              for key27, value178 in pairs(petInventory) do
                if type(value178) == "table" and value178.Name and not v485[key27]
                  and not v484[key27] then
                  local v487 = v7.Data.PetRarityLookup[value178.Name] or "Common"
                  local rank = v7.Data.RarityOrderMap[v487] or 0
                  local trait = v481.GetTrait(value178.Name)

                  table.insert(v486, {
                    Key = key27,
                    Name = value178.Name,
                    Rarity = v487,
                    Rank = rank,
                    Trait = trait,
                    Level = value178.Level or 1,
                  })
                end
              end

              if #v486 > 0 then
                local v488 = nil
                local v489 = -1

                for index112, value179 in ipairs(invokeServer5.Expeditions) do
                  local v490 = v481.ById[value179]

                  if v490 then
                    local v491 = v7.Data.RarityOrderMap[v490.PreferredRarity] or 0
                    local preferredTrait = v490.PreferredTrait
                    local v492 = {}
                    local v493 = {}
                    local v494 = {}

                    for index113, value180 in ipairs(v486) do
                      if value180.Trait == preferredTrait and value180.Rank >= v491 then
                        table.insert(v492, value180)
                      elseif value180.Trait == preferredTrait then
                        table.insert(v493, value180)
                      else
                        table.insert(v494, value180)
                      end
                    end

                    local v495 = {}

                    for index114, value181 in ipairs(v492) do
                      if #v495 < 3 then
                        table.insert(v495, value181)
                      end
                    end

                    for index115, value182 in ipairs(v493) do
                      if #v495 < 3 then
                        table.insert(v495, value182)
                      end
                    end

                    for index116, value183 in ipairs(v494) do
                      if #v495 < 3 then
                        table.insert(v495, value183)
                      end
                    end

                    if #v495 > 0 then
                      local v496 = {}

                      for index117, value184 in ipairs(v495) do
                        table.insert(v496, value184.Name)
                      end

                      local v497 = v481.ScoreParty(v490, v496)

                      local v498 = (v497 == "Perfect" and 4 or v497 == "Great" and 3
                            or v497 == "Good" and 2 or 1)
                          * 10
                        + #v495

                      if v498 > v489 then
                        v489 = v498

                        v488 = {
                          ExpeditionId = value179,
                          ExpeditionName = v490.Name,
                          Tier = v497,
                          Pets = v495,
                        }
                      end
                    end
                  end
                end

                if v488 and #v488.Pets > 0 then
                  local v499 = {}

                  for index118, value185 in ipairs(v488.Pets) do
                    table.insert(v499, value185.Key)
                  end

                  if v480:InvokeServer(v483, v488.ExpeditionId, v499) then
                    v2:Notify({
                      Title = "Pet Expeditions",
                      Content = "Dispatched " .. v488.ExpeditionName .. " (" .. v488.Tier
                        .. ") with " .. #v499 .. " pets",
                      Duration = 4,
                    })
                  end
                end
              end
            end
          end
        end
      end

      task.wait(5)
    end

    v7.Flags.IsAutoDispatchPetExpeditionRunning = false
  end)
end

function InitUI()
  local window = v2:CreateWindow({ Title = "Build A Ring Farm LITE", SubTitle = "by Lamduck" })

  local v500 = {
    FarmShop = window:AddTab({ Title = "Farm & Shop", Icon = "sprout" }),
    Pets = window:AddTab({ Title = "Pets", Icon = "cat" }),
    FloorManager = window:AddTab({ Title = "Floor Manager", Icon = "layers" }),
    Compost = window:AddTab({ Title = "Compost Manager", Icon = "leaf" }),
    Events = window:AddTab({ Title = "Event & Reward", Icon = "gift" }),
    Social = window:AddTab({ Title = "Social", Icon = "users" }),
    Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
  }

  v500.FarmShop:AddParagraph("NotiParagraph", {
    Title = "Feature Note",
    Content = "Need the full set of features? If you're missing <font color=\"#4ecdc4\">more tools</font> and <font color=\"#4ecdc4\">extra options</font>, use the <font color=\"#ffd93d\">Full version</font> in <font color=\"#ffd93d\">Settings</font>.",
  })

  v500.FarmShop:AddSection("Auto Farming")

  v500.FarmShop:AddToggle("Toggle_AutoSellCrates", {
    Title = "Auto Sell Crates",
    Default = false,
    Callback = function(value186)
      if value186 then
        f74()
      end
    end,
  })

  v500.FarmShop:AddSection("Seed Gacha")

  v500.FarmShop:AddToggle("Toggle_AutoGachaAll", {
    Title = "Auto Gacha (Buy All Seeds)",
    Default = false,
    Callback = function(value187)
      if value187 then
        f78()
      end
    end,
  })

  v500.FarmShop:AddSection("Gear Shop")

  v500.FarmShop:AddDropdown("Dropdown_TargetBuyGears", {
    Title = "Target Gears",
    Values = v7.Data.GearShopItemNames,
    Multi = true,
    Searchable = true,
  })

  v500.FarmShop:AddToggle("Toggle_AutoBuySelectedGears", {
    Title = "Auto Buy Gears",
    Default = false,
    Callback = function(value188)
      if value188 then
        f75()
      end
    end,
  })

  v500.FarmShop:AddSection("Egg Shop")

  v500.FarmShop:AddDropdown("Dropdown_TargetEggShopEggs", {
    Title = "Target Eggs",
    Values = v7.Data.EggNames,
    Multi = true,
    Searchable = true,
  })

  v500.FarmShop:AddToggle("Toggle_AutoBuySelectedEggs", {
    Title = "Auto Buy Eggs",
    Default = false,
    Callback = function(value189)
      if value189 then
        f76()
      end
    end,
  })

  v500.FarmShop:AddSection("Night Market Merchant")

  v500.FarmShop:AddDropdown("Dropdown_TargetNightMarketItems", {
    Title = "Target Items",
    Values = v7.Data.NightMarketItemNames,
    Multi = true,
    Searchable = true,
  })

  v500.FarmShop:AddToggle("Toggle_AutoBuyNightMarket", {
    Title = "Auto Buy Night Market Items",
    Default = false,
    Callback = function(value190)
      if value190 then
        f77()
      end
    end,
  })

  task.wait()

  do
    local addSubTabBar = v500.Pets:AddSubTabBar({ SubTabs = { "Pet", "Pet Expedition" } })
    local pet = addSubTabBar.Pet
    local petExpedition = addSubTabBar["Pet Expedition"]

    pet:AddSection("Pet Feeding")

    pet:AddDropdown("Dropdown_PetTreatTypes", {
      Title = "Select Treats",
      Values = v7.Data.PetTreatNames,
      Multi = true,
    })

    pet:AddToggle("Toggle_AutoFeedPets", {
      Title = "Auto Feed Pets",
      Default = false,
      Callback = function(value191)
        if value191 then
          f82()
        end
      end,
    })

    pet:AddSection("Pet Upgrade")

    pet:AddInput("Input_PetUpgradeLevel", {
      Title = "Max Upgrade Level",
      Default = "50",
      Numeric = true,
      Min = 1,
      Max = 50,
      Finished = false,
    })

    pet:AddToggle("Toggle_AutoUpgradePets", {
      Title = "Auto Upgrade Pets",
      Default = false,
      Callback = function(value192)
        if value192 then
          f83()
        end
      end,
    })

    pet:AddSection("Pet Sell")

    pet:AddDropdown("Dropdown_PetSellSelection", {
      Title = "Select Pet Names",
      Values = v7.Data.PetNames,
      Multi = true,
      Searchable = true,
    })

    pet:AddToggle("Toggle_PetSellFilterName", {
      Title = "Auto Sell by Name",
      Default = false,
      Callback = function(value193)
        if value193 then
          v2.Options.Toggle_PetSellFilterRarity:SetValue(false)
          v2.Options.Toggle_PetSellFilterSize:SetValue(false)
          f84()
        end
      end,
    })

    pet:AddDivider()

    pet:AddDropdown("Dropdown_PetSellRarities", {
      Title = "Select Pet Rarities",
      Values = v7.Data.PetRarityNames,
      Multi = true,
    })

    pet:AddToggle("Toggle_PetSellFilterRarity", {
      Title = "Auto Sell by Rarity",
      Default = false,
      Callback = function(value194)
        if value194 then
          v2.Options.Toggle_PetSellFilterName:SetValue(false)
          v2.Options.Toggle_PetSellFilterSize:SetValue(false)
          f84()
        end
      end,
    })

    pet:AddDivider()

    pet:AddDropdown("Dropdown_PetSellSizes", {
      Title = "Select Pet Sizes",
      Values = v7.Data.PetSizeNames,
      Multi = true,
    })

    pet:AddToggle("Toggle_PetSellFilterSize", {
      Title = "Auto Sell by Size",
      Default = false,
      Callback = function(value195)
        if value195 then
          v2.Options.Toggle_PetSellFilterName:SetValue(false)
          v2.Options.Toggle_PetSellFilterRarity:SetValue(false)
          f84()
        end
      end,
    })

    petExpedition:AddSection("Pet Expeditions")

    petExpedition:AddToggle("Toggle_AutoDispatchPetExpedition", {
      Title = "Auto Dispatch",
      Description = "Auto pick and send best pets to available expeditions",
      Default = false,
      Callback = function(value196)
        if value196 then
          f171()
        end
      end,
    })

    petExpedition:AddToggle("Toggle_AutoClaimPetExpedition", {
      Title = "Auto Claim",
      Description = "Auto claim completed expeditions when ready",
      Default = false,
      Callback = function(value197)
        if value197 then
          f170()
        end
      end,
    })
  end

  task.wait()

  v500.FloorManager:AddSection("Floor Selection")

  v500.FloorManager:AddDropdown("Dropdown_SelectedFloors", {
    Title = "Select Floors",
    Values = { "Floor 1", "Floor 2", "Floor 3", "Floor 4", "Floor 5" },
    Multi = true,
    AllowNone = true,
  })

  v500.FloorManager:AddSection("Auto Plant")

  v500.FloorManager:AddToggle("Toggle_AutoPlantBest", {
    Title = "Auto Plant Best Seed (Highest Price)",
    Default = false,
    Callback = function(value198)
      if value198 then
        f88()
      end
    end,
  })

  v500.FloorManager:AddButton({
    Title = "Remove All Plants",
    Description = "Clear all plants on selected floors and recover seeds.",
    Confirm = "Are you sure you want to remove ALL plants on selected floors?",
    Callback = function()
      local value199 = v2.Options.Dropdown_SelectedFloors.Value

      for i12 = 1, 5 do
        local v501 = "Floor " .. i12

        if type(value199) ~= "table" or value199[v501] == true then
          task.spawn(f87, i12)
        end
      end
    end,
  })

  v500.FloorManager:AddSection("Auto Upgrade Plant")

  v500.FloorManager:AddInput("Input_MaxUpgradeLevel", {
    Title = "Max Upgrade Level",
    Default = "100",
    Numeric = true,
    Min = 1,
    Finished = false,
  })

  v500.FloorManager:AddToggle("Toggle_AutoUpgradeAll", {
    Title = "Auto Upgrade All Plants",
    Default = false,
    Callback = function(value200)
      if value200 then
        f91()
      end
    end,
  })

  v500.FloorManager:AddSection("Auto Fertilize")

  v500.FloorManager:AddDropdown("Dropdown_FertilizerTypes", {
    Title = "Select Fertilizers",
    Values = v7.Data.FertilizerNames,
    Multi = true,
  })

  v500.FloorManager:AddToggle("Toggle_AutoFertilize", {
    Title = "Auto Fertilize All Plants",
    Default = false,
    Callback = function(value201)
      if value201 then
        f94()
      end
    end,
  })

  v500.FloorManager:AddSection("Auto Upgrade Powerups")

  v500.FloorManager:AddDropdown("Dropdown_UpgradePowerups", {
    Title = "Select Powerups",
    Values = {
      "SawRange", "SawYield", "SprinklerRange", "SprinklerPower", "CrownedCrops", "SoilQuality",
      "GoldenHarvest", "GoldenChance", "SeedLuck", "SeedRolls",
    },
    Multi = true,
  })

  v500.FloorManager:AddToggle("Toggle_AutoUpgradePowerups", {
    Title = "Auto Upgrade Powerups",
    Default = false,
    Callback = function(value202)
      if value202 then
        f98()
      end
    end,
  })

  v500.FloorManager:AddSection("Auto Unlock Farm Plots")

  v500.FloorManager:AddToggle("Toggle_AutoUnlockFarmPlots", {
    Title = "Auto Unlock Farm Plots",
    Default = false,
    Callback = function(value203)
      if value203 then
        f96()
      end
    end,
  })

  task.wait()

  do
    v500.Compost:AddSection("Floor Selection")

    v500.Compost:AddDropdown("Dropdown_CompostSelectedFloors", {
      Title = "Select Floors",
      Values = { "Floor 2", "Floor 3", "Floor 4", "Floor 5" },
      Multi = true,
      AllowNone = true,
    })

    v500.Compost:AddSection("Auto Compost Settings")

    v500.Compost:AddDropdown("Dropdown_CompostPullLevel", {
      Title = "Pull Lever Tier",
      Values = v7.Data.CompostLevelNames,
      Default = "Overgrown",
    })

    v500.Compost:AddDivider()

    v500.Compost:AddDropdown("Dropdown_CompostSeeds", {
      Title = "Target Seeds",
      Values = v7.Data.PlantNames,
      Multi = true,
      Searchable = true,
    })

    local addToggle

    local addToggle2 = v500.Compost:AddToggle("Toggle_AutoCompostSelected", {
      Title = "Auto Compost Selected",
      Default = false,
      Callback = function(value204)
        if value204 then
          addToggle:SetValue(false)
          f105()
        end
      end,
    })

    v500.Compost:AddDivider()

    v500.Compost:AddDropdown("Dropdown_CompostRarities", {
      Title = "Target Rarities",
      Values = v7.Data.RarityNames,
      Multi = true,
    })

    addToggle = v500.Compost:AddToggle("Toggle_AutoCompostByRarity", {
      Title = "Auto Compost By Rarity",
      Default = false,
      Callback = function(value205)
        if value205 then
          addToggle2:SetValue(false)
          f105()
        end
      end,
    })
  end

  task.wait()

  do
    local addSubTabBar2 = v500.Events:AddSubTabBar({
      SubTabs = {
        "Events", "Guild", "Friend O Tron", "Pet Mutation", "Fuse", "Rewards", "Golem",
      },
    })

    local events = addSubTabBar2.Events
    local guild = addSubTabBar2.Guild
    local friendOTron4 = addSubTabBar2["Friend O Tron"]
    local petMutation6 = addSubTabBar2["Pet Mutation"]
    local fuse = addSubTabBar2.Fuse
    local rewards = addSubTabBar2.Rewards
    local golem = addSubTabBar2.Golem
    events:AddSection("Wandering Merchant")

    v7.Paragraph.WanderingMerchantInfo = events:AddParagraph("WanderingMerchantInfoParagraph", {
      Title = "Merchant Status",
      Content = "Loading...",
    })

    events:AddToggle("Toggle_AutoSubmitMerchantTrades", {
      Title = "Auto Submit Merchant Trades",
      Default = false,
      Callback = function(value206)
        if value206 then
          f145()
        end
      end,
    })

    events:AddDivider()

    events:AddDropdown("Dropdown_MerchantShopItems", {
      Title = "Select Merchant Shop Items",
      Values = v7.Data.WanderingMerchantItemNames,
      Multi = true,
    })

    events:AddToggle("Toggle_AutoBuyMerchantShop", {
      Title = "Auto Buy Merchant Shop Items",
      Default = false,
      Callback = function(value207)
        if value207 then
          f146()
        end
      end,
    })

    events:AddSection("Zoo Rush")

    events:AddDropdown("Dropdown_ZooRushNames", {
      Title = "Select ZooRush Pets",
      Values = v7.Data.ZooRushPetNames,
      Multi = true,
      Searchable = true,
    })

    events:AddToggle("Toggle_AutoZooRushName", {
      Title = "Auto Catch by Name",
      Default = false,
      Callback = function(value208)
        if value208 then
          v2.Options.Toggle_AutoZooRushRarity:SetValue(false)
          f120()
        end
      end,
    })

    events:AddDivider()

    events:AddDropdown("Dropdown_ZooRushRarities", {
      Title = "Select ZooRush Rarities",
      Values = v7.Data.PetRarityNames,
      Multi = true,
    })

    events:AddToggle("Toggle_AutoZooRushRarity", {
      Title = "Auto Catch by Rarity",
      Default = false,
      Callback = function(value209)
        if value209 then
          v2.Options.Toggle_AutoZooRushName:SetValue(false)
          f120()
        end
      end,
    })

    events:AddSection("World Events")

    events:AddToggle("Toggle_AutoCollectCyberDroneDrop", {
      Title = "Auto Collect Cyber Drone Drop",
      Default = false,
      Callback = function(value210)
        if value210 then
          f107()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectAlienDrop", {
      Title = "Auto Collect Alien Drop",
      Default = false,
      Callback = function(value211)
        if value211 then
          f106()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectQueenBeeHoneycomb", {
      Title = "Auto Collect Queen Bee Honeycomb",
      Default = false,
      Callback = function(value212)
        if value212 then
          f108()
        end
      end,
    })

    events:AddToggle("Toggle_AutoSubmitQueenBeeHoneyToken", {
      Title = "Auto Submit Honey Token",
      Default = false,
      Callback = function(value213)
        if value213 then
          f109()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectWeatherEvents", {
      Title = "Auto Collect Weather Events",
      Description = "Rain, Blizzard, Fall, Blackhole, Nuclear, Galaxy",
      Default = false,
      Callback = function(value214)
        if value214 then
          f112()
        end
      end,
    })

    events:AddToggle("Toggle_AutoCollectMeteorDrop", {
      Title = "Auto Collect Meteor Drops",
      Default = false,
      Callback = function(value215)
        if value215 then
          f114()
        end
      end,
    })

    events:AddSection("Admin Events")

    events:AddToggle("Toggle_AutoCollectAdminTokens", {
      Title = "Auto Collect Admin Tokens",
      Default = false,
      Callback = function(value216)
        if value216 then
          f110()
        end
      end,
    })

    events:AddToggle("Toggle_AutoSpinMegaSpinner", {
      Title = "Auto Spin Mega Spinner",
      Default = false,
      Callback = function(value217)
        if value217 then
          f111()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectLuckyRainDrop", {
      Title = "Auto Collect Lucky Rain Drop",
      Default = false,
      Callback = function(value218)
        if value218 then
          f113()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoShootJesterBoss", {
      Title = "Auto Shoot Jester Boss",
      Default = false,
      Callback = function(value219)
        if value219 then
          f117()
        end
      end,
    })

    events:AddToggle("Toggle_AutoCollectJesterGifts", {
      Title = "Auto Collect Jester Gifts",
      Default = false,
      Callback = function(value220)
        if value220 then
          f118()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectCarnivalGifts", {
      Title = "Auto Collect Carnival Gifts",
      Default = false,
      Callback = function(value221)
        if value221 then
          f119()
        end
      end,
    })

    events:AddSection("Legacy Events")

    events:AddToggle("Toggle_AutoPlantditchPassRing", {
      Title = "Auto Pass Ring (Plantditch)",
      Default = false,
      Callback = function(value222)
        if value222 then
          f115()
        end
      end,
    })

    events:AddToggle("Toggle_AutoPlantditchClaimOrb", {
      Title = "Auto Claim Orb (Plantditch)",
      Default = false,
      Callback = function(value223)
        if value223 then
          f116()
        end
      end,
    })

    guild:AddSection("Guild Rewards")

    guild:AddToggle("Toggle_AutoClaimGuildMissions", {
      Title = "Auto Claim Missions",
      Default = false,
      Callback = function(value224)
        if value224 then
          f127()
        end
      end,
    })

    guild:AddToggle("Toggle_AutoClaimGuildWeekly", {
      Title = "Auto Claim Weekly Tier Reward",
      Default = false,
      Callback = function(value225)
        if value225 then
          f128()
        end
      end,
    })

    guild:AddDivider()

    guild:AddToggle("Toggle_AutoStartRally", {
      Title = "Auto Start Rally",
      Default = false,
      Callback = function(value226)
        if value226 then
          f130()
        end
      end,
    })

    guild:AddSection("Guild Shop")

    guild:AddDropdown("Dropdown_AutoBuyGuildShopItems", {
      Title = "Select Items to Buy",
      Values = v7.Data.GuildShopItemNames,
      Multi = true,
      Searchable = true,
    })

    guild:AddToggle("Toggle_AutoBuyGuildShop", {
      Title = "Auto Buy Guild Shop",
      Default = false,
      Callback = function(value227)
        if value227 then
          f129()
        end
      end,
    })

    friendOTron4:AddSection("Friend-O-Tron")

    friendOTron4:AddDropdown("Dropdown_FriendOTronTargetSlot", {
      Title = "Target Slot",
      Values = { "Any Empty Slot", "Blue Slot", "Purple Slot" },
      Default = "Any Empty Slot",
    })

    friendOTron4:AddDivider()

    do
      local v502 = {}

      for index119, value228 in ipairs(v7.Data.RarityNames) do
        if value228 ~= "Common" and value228 ~= "Uncommon" then
          table.insert(v502, value228)
        end
      end

      local v503 = {}

      for index120, value229 in ipairs(v7.Data.PlantNames) do
        local v504 = f80(value229)

        if v504 ~= "Unknown" and v504 ~= "Common" and v504 ~= "Uncommon" then
          table.insert(v503, value229)
        end
      end

      friendOTron4:AddDropdown("Dropdown_FriendOTronSeedName", {
        Title = "Select Target Seeds",
        Values = v503,
        Multi = true,
        Searchable = true,
      })

      friendOTron4:AddToggle("Toggle_AutoFriendOTronSeed", {
        Title = "Auto Friend-O-Tron by Seed",
        Default = false,
        Callback = function(value230)
          if value230 then
            v2.Options.Toggle_AutoFriendOTronRarity:SetValue(false)
            f132()
          end
        end,
      })

      friendOTron4:AddDivider()

      friendOTron4:AddDropdown("Dropdown_FriendOTronRarity", {
        Title = "Select Target Rarities",
        Values = v502,
        Multi = true,
      })

      friendOTron4:AddToggle("Toggle_AutoFriendOTronRarity", {
        Title = "Auto Friend-O-Tron by Rarity",
        Default = false,
        Callback = function(value231)
          if value231 then
            v2.Options.Toggle_AutoFriendOTronSeed:SetValue(false)
            f132()
          end
        end,
      })
    end

    friendOTron4:AddDivider()

    friendOTron4:AddButton({
      Title = "Remove Seeds",
      Confirm = "Are you sure you want to remove seeds?",
      Callback = function()
        task.spawn(function()
          local friendOTron5 = replicatedStorage:FindFirstChild("Remotes")
            and replicatedStorage.Remotes:FindFirstChild("FriendOTron")

          if not friendOTron5 then
            return
          end

          local removeSeed = friendOTron5:FindFirstChild("RemoveSeed")

          if not removeSeed then
            return
          end

          pcall(function() removeSeed:InvokeServer("Blue") end)
          pcall(function() removeSeed:InvokeServer("Purple") end)
        end)
      end,
    })

    friendOTron4:AddSection("Friend-O-Tron Spin")

    friendOTron4:AddToggle("Toggle_AutoFriendOTronSpin", {
      Title = "Auto Spin",
      Default = false,
      Callback = function(value232)
        if value232 then
          f133()
        end
      end,
    })

    petMutation6:AddSection("Pet Mutation")

    petMutation6:AddDropdown("Dropdown_PetMutationPetNames", {
      Title = "Select Pet",
      Values = v7.Data.PetNames,
      Multi = true,
      Searchable = true,
    })

    petMutation6:AddDropdown("Dropdown_PetMutationWhitelistMutations", {
      Title = "Exclude Mutations (Whitelist)",
      Description = [[
Selected mutations will NOT be auto mutation!
Deselect to reroll mutation!]],
      Values = v7.Data.PetMutationNames,
      Multi = true,
      Searchable = true,
      Default = v7.Data.PetMutationNames,
    })

    petMutation6:AddToggle("Toggle_AutoStartPetMutation", {
      Title = "Auto Start Mutation",
      Default = false,
      Callback = function(value233)
        if value233 then
          f137()
        end
      end,
    })

    petMutation6:AddToggle("Toggle_AutoClaimPetMutation", {
      Title = "Auto Claim Mutation",
      Default = false,
      Callback = function(value234)
        if value234 then
          f138()
        end
      end,
    })

    petMutation6:AddSection("Machine Upgrades")

    petMutation6:AddDropdown("Dropdown_PetMutationUpgradeSelection", {
      Title = "Select Upgrades",
      Values = { "IncubatorSpeed", "MutationLuck", "RerollDiscount" },
      Multi = true,
    })

    petMutation6:AddToggle("Toggle_AutoBuyPetMutationUpgrades", {
      Title = "Auto Upgrades",
      Default = false,
      Callback = function(value235)
        if value235 then
          f136()
        end
      end,
    })

    fuse:AddSection("Seed Fuse")
    local v505 = {}

    for index121, value236 in ipairs(v7.Data.RarityNames) do
      if value236 ~= "Eternal" then
        table.insert(v505, value236)
      end
    end

    local v506 = {}

    for index122, value237 in ipairs(v7.Data.PlantNames) do
      if f80(value237) ~= "Eternal" then
        table.insert(v506, value237)
      end
    end

    fuse:AddDropdown("Dropdown_FuseSeeds", {
      Title = "Select Seeds",
      Values = v506,
      Multi = true,
    })

    fuse:AddToggle("Toggle_AutoFuseSelected", {
      Title = "Auto Fuse Selected Seeds",
      Default = false,
      Callback = function(value238)
        if value238 then
          v2.Options.Toggle_AutoFuseByRarity:SetValue(false)
          f152()
        end
      end,
    })

    fuse:AddDivider()

    fuse:AddDropdown("Dropdown_FuseRarities", {
      Title = "Select Rarities",
      Values = v505,
      Multi = true,
    })

    fuse:AddToggle("Toggle_AutoFuseByRarity", {
      Title = "Auto Fuse Selected Rarities",
      Default = false,
      Callback = function(value239)
        if value239 then
          v2.Options.Toggle_AutoFuseSelected:SetValue(false)
          f152()
        end
      end,
    })

    rewards:AddSection("The Vault")

    rewards:AddToggle("Toggle_AutoRollVault", {
      Title = "Auto Roll Vault",
      Default = false,
      Callback = function(value240)
        if value240 then
          f126()
        end
      end,
    })

    rewards:AddSection("Season Pass")

    rewards:AddToggle("Toggle_AutoClaimSeasonPassQuests", {
      Title = "Auto Claim Quests",
      Default = false,
      Callback = function(value241)
        if value241 then
          f139()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoClaimSeasonPassRewards", {
      Title = "Auto Claim Rewards",
      Default = false,
      Callback = function(value242)
        if value242 then
          f140()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoSpinSeasonPassCrate", {
      Title = "Auto Spin Crate (125 Data Shards)",
      Default = false,
      Callback = function(value243)
        if value243 then
          f141()
        end
      end,
    })

    rewards:AddSection("Other")

    rewards:AddToggle("Toggle_AutoClaimDailyReward", {
      Title = "Auto Claim Daily Reward",
      Default = false,
      Callback = function(value244)
        if value244 then
          f121()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoClaimPlaytimeReward", {
      Title = "Auto Claim Playtime Reward",
      Default = false,
      Callback = function(value245)
        if value245 then
          f122()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoSpinWheel", {
      Title = "Auto Spin Wheel",
      Default = false,
      Callback = function(value246)
        if value246 then
          f123()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoOpenCratePack", {
      Title = "Auto Open Crate / Pack",
      Default = false,
      Callback = function(value247)
        if value247 then
          f124()
        end
      end,
    })

    golem:AddSection("Overgrown Farmer")

    golem:AddToggle("Toggle_GolemAutoSacrifice", {
      Title = "Auto Sacrifice Seeds",
      Description = "(Only quest 1 & 5)",
      Confirm = [[
Are you sure you want to enable Auto Sacrifice Seeds?

Reminder: This will permanently consume eligible non-favorited seeds from your inventory to complete the quest.]],
      Default = false,
      Callback = function(value248)
        if value248 then
          f164()
        end
      end,
    })

    golem:AddToggle("Toggle_GolemAutoAdvance", {
      Title = "Auto Advance Quests",
      Description = "Auto advance new quest when current is done",
      Default = false,
      Callback = function(value249)
        if value249 then
          f166()
        end
      end,
    })
  end

  task.wait()

  v500.Social:AddSection("Friend ~"):AddToggle("Toggle_AutoFriendRequest", {
    Title = "Auto Send Friend Request",
    Description = "Send friend requests to all players for friendboost",
    Default = false,
    Callback = function(value250) f167(value250) end,
  })

  local neighbourChores = v500.Social:AddSection("Neighbour Chores")

  neighbourChores:AddParagraph("NeighbourChoresParagraph", {
    Title = "Chore Buffs",
    Content = [[
- <b>Tend:</b> +2% Grow Speed / stack (max +20%, 30m)
- <b>Groom:</b> +2% Egg Luck / stack (max +10%, 10m)
- <b>Prune:</b> -1 min crop growth skip]],
  })

  neighbourChores:AddDropdown("Dropdown_NeighbourChoreTypes", {
    Title = "Chore Types",
    Values = { "Tend", "Prune", "Groom" },
    Default = { "Tend", "Prune", "Groom" },
    Multi = true,
  })

  neighbourChores:AddToggle("Toggle_AutoNeighbourChores", {
    Title = "Auto Neighbour Chores",
    Description = "Auto visit other farms and do chores",
    Default = false,
    Callback = function(value251)
      if value251 then
        f169()
      end
    end,
  })

  task.wait()

  v500.Settings:AddButton({
    Title = "Switch to Full Version",
    Description = "More features but a bit heavy",
    Confirm = "Switch to Full version? This will rejoin the game.",
    Callback = function()
      writefile("BARFVersionPref.txt", "full")

      local queueOnTeleport = queue_on_teleport or syn and syn.queue_on_teleport
        or fluxus and fluxus.queue_on_teleport

      if queueOnTeleport then
        pcall(
          queueOnTeleport,
          "loadstring(game:HttpGet('https://lamduck2005.github.io/RobloxScript/loader.lua'))()"
        )
      end

      v2:Notify({ Title = "Switching to Full Version", Content = "Rejoining...", Duration = 5 })
      task.wait(2)
      f57()
    end,
  })

  v500.Settings:AddSection("Visuals")

  v500.Settings:AddToggle("Toggle_ExtremeLowPerf", {
    Title = "Extreme Low Performance",
    Description = "Hide plots + LowPerformanceMode + Disable sound",
    Default = false,
    Callback = function(value252) f16(value252) end,
  })

  v500.Settings:AddToggle("Toggle_CleanGameUI", {
    Title = "Clean Game UI",
    Description = "Best for mobile player",
    Default = false,
    Callback = function(value253)
      local playerGui3 = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")

      if playerGui3 then
        local mainUI = playerGui3:FindFirstChild("MainUI")

        if mainUI then
          local leftButtons = mainUI:FindFirstChild("LeftButtons")
          local rightSide = mainUI:FindFirstChild("RightSide")

          if leftButtons then
            leftButtons.Visible = not value253
          end

          if rightSide then
            rightSide.Visible = not value253
          end
        end
      end
    end,
  })

  v500.Settings:AddToggle("Toggle_MuteAndHideAlerts", {
    Title = "Mute & Hide Alerts",
    Default = false,
    Callback = function(value254)
      pcall(function()
        local notificationsUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("NotificationsUI")

        if notificationsUI then
          notificationsUI.Enabled = not value254
        end

        local saAlert = soundService:FindFirstChild("SFX")
          and soundService.SFX:FindFirstChild("SAAlert")

        if saAlert then
          if value254 then
            v7.Cache.OriginalAlertVolume = saAlert.Volume
            saAlert.Volume = 0
          elseif v7.Cache.OriginalAlertVolume then
            saAlert.Volume = v7.Cache.OriginalAlertVolume
          end
        end
      end)
    end,
  })

  v500.Settings:AddToggle("Toggle_LockCameraFov", {
    Title = "Lock Camera FOV",
    Description = "Prevent camera FOV changes during spins and menus",
    Default = false,
    Callback = function(value255) f17(value255) end,
  })

  v500.Settings:AddToggle("Toggle_DisableSeedBounce", {
    Title = "Disable Seed Bounce",
    Description = "Skip seed bounce animation and fast roll",
    Default = false,
    Callback = function(value256) f19(value256) end,
  })

  v500.Settings:AddToggle("Toggle_RemoveAllEffects", {
    Title = "Remove All Effects",
    Description = "Disable particles, beams, lights, highlights and postfx",
    Default = false,
    Callback = function(value257) f20(value257) end,
  })

  v4:SetLibrary(v2)
  v3:SetLibrary(v2)
  v5:SetLibrary(v2)
  v4:SetFolder("Lamduck")
  v3:SetFolder("Lamduck/BARFLite")
  v5:SetFolder("Lamduck/BARFLite")
  v3:SetIgnoreIndexes({})
  v5:BuildExtraSection(v500.Settings)
  v4:BuildInterfaceSection(v500.Settings)
  v3:BuildConfigSection(v500.Settings)
  v5:SetAFKInfo("Cash", function() return "💲", f3(f5()) end)
  window:SelectTab(1)
  v3:LoadAutoloadConfig()
  f4("Boot completed in %.2fs", os.clock() - v1)
end

task.spawn(InitUI)
f41()
f49()

task.delay(3, function()
  if v2.Unloaded then
    return
  end

  f143()
end)

v2.OnUnload:Once(function()
  pcall(function()
    f16(false)
    f17(false)
    f19(false)
    f20(false)
    local playerGui4 = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")

    if playerGui4 then
      local mainUI2 = playerGui4:FindFirstChild("MainUI")

      if mainUI2 then
        local leftButtons2 = mainUI2:FindFirstChild("LeftButtons")
        local rightSide2 = mainUI2:FindFirstChild("RightSide")

        if leftButtons2 then
          leftButtons2.Visible = true
        end

        if rightSide2 then
          rightSide2.Visible = true
        end
      end

      local notificationsUI2 = playerGui4:FindFirstChild("NotificationsUI")

      if notificationsUI2 then
        notificationsUI2.Enabled = true
      end
    end

    local saAlert2 = soundService:FindFirstChild("SFX")
      and soundService.SFX:FindFirstChild("SAAlert")

    if saAlert2 and v7.Cache.OriginalAlertVolume then
      saAlert2.Volume = v7.Cache.OriginalAlertVolume
    end
  end)

  for key28, value258 in pairs(v7.Connections) do
    if typeof(value258) == "RBXScriptConnection" then
      pcall(function() value258:Disconnect() end)
    elseif type(value258) == "table" then
      for index123, value259 in ipairs(value258) do
        if typeof(value259) == "RBXScriptConnection" then
          pcall(function() value259:Disconnect() end)
        end
      end

      table.clear(value258)
    end
  end

  table.clear(v7.Connections)
end)
