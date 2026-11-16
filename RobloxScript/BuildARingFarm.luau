local v1 = os.clock()
local v2, v3 = pcall(readfile, "BARFVersionPref.txt")

if (v2 and v3 and v3:lower():match("^%s*(%S+)") or "full") == "lite" then
  local v4, v5 = pcall(
    game.HttpGet, game, "https://lamduck2005.github.io/RobloxScript/BuildARingFarmLite.luau"
  )

  if v4 and v5 and #v5 > 0 then
    local v6 = loadstring(v5)

    if v6 then
      v6()
      return
    end
  end
end

local v7, v8, v9, v10 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = game.Players.LocalPlayer
local lighting = game:GetService("Lighting")
local soundService = game:GetService("SoundService")
local v11 = nil

local v12 = {
  Flags = {
    IsSellCratesLoopRunning = false,
    IsExpandFarmPlotLoopRunning = false,
    IsSeedGachaLoopRunning = false,
    IsAutoDiscardLoopRunning = false,
    IsBuyGearsLoopRunning = false,
    IsUnlockEggSlotsLoopRunning = false,
    IsEggShopBuyLoopRunning = false,
    IsAutoFeedPetsLoopRunning = false,
    IsAutoUpgradePetsLoopRunning = false,
    IsAutoSellPetsLoopRunning = false,
    IsCompostLoopRunning = false,
    IsAutoPlantLoopRunning = false,
    IsUpgradePlantsLoopRunning = false,
    IsFertilizePlantsLoopRunning = false,
    IsSprayPlantsLoopRunning = false,
    IsUpgradePowerupsLoopRunning = false,
    IsUnlockFarmPlotsLoopRunning = false,
    IsAutoFuseLoopRunning = false,
    IsFuseParagraphLoopRunning = false,
    IsCollectAlienDropLoopRunning = false,
    IsCollectCyberDroneDropLoopRunning = false,
    IsCollectHoneycombLoopRunning = false,
    IsSubmitQueenBeeHoneyTokenLoopRunning = false,
    IsCollectAdminTokensLoopRunning = false,
    IsSpinMegaSpinnerLoopRunning = false,
    IsPlantditchPassRingLoopRunning = false,
    IsPlantditchClaimOrbLoopRunning = false,
    IsCollectWeatherEventsLoopRunning = false,
    IsCollectLuckyRainDropLoopRunning = false,
    IsCollectMeteorDropLoopRunning = false,
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
    IsAutoFriendOTronRunning = false,
    IsAutoFriendOTronSpinRunning = false,
    IsAutoClaimGuildMissionsRunning = false,
    IsAutoClaimGuildWeeklyRunning = false,
    IsAutoBuyGuildShopRunning = false,
    IsAutoRallyLoopRunning = false,
    IsAutoBuyPetMutationUpgradesRunning = false,
    IsAutoStartPetMutationRunning = false,
    IsAutoClaimPetMutationRunning = false,
    IsAutoClaimSeasonPassQuestsRunning = false,
    IsAutoClaimSeasonPassRewardsRunning = false,
    IsAutoSpinSeasonPassCrateRunning = false,
    IsAutoSubmitMerchantTradesRunning = false,
    IsAutoBuyMerchantShopRunning = false,
    IsAutoBuyCyberMerchantRunning = false,
    IsAutoBuyNightMarketRunning = false,
    IsAutoRollVaultRunning = false,
    IsAutoContractRunning = false,
    IsGolemAutoSacrificeRunning = false,
    IsGolemAutoAdvanceRunning = false,
    IsAutoDispatchPetExpeditionRunning = false,
    IsAutoClaimPetExpeditionRunning = false,
    IsPetExpeditionParagraphRunning = false,
    IsGolemParagraphLoopRunning = false,
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
    PlantRarityLookup = {},
    GearRegistry = {},
    GearNames = {},
    GearShopItemNames = {},
    GearCosts = {},
    SessionUnlockedEggSlots = {},
    EggNames = {},
    EggPrices = {},
    EggSlotPrices = {},
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
    SprayNames = {},
    MutationSprayNames = {},
    MutationRegistry = {},
    MutationNames = {},
    MutationOrderMap = {},
    GuildShopItemNames = {},
    GuildShopItemIdMap = {},
    ZooRushPetRate = {},
    ZooRushPetNames = {},
    PetMutationRarityConfig = nil,
    PetMutationNames = {},
    FriendOTronCooldownUntil = 0,
    FriendOTronSpins = 0,
    FriendOTronPendingSeedKey = "",
    ContractsConfig = nil,
    ContractRegistry = nil,
    WanderingMerchantConfig = nil,
    WanderingMerchantItemNames = {},
    WanderingMerchantItemIdMap = {},
    CyberMerchantConfig = nil,
    CyberMerchantItemNames = {},
    CyberMerchantItemIdMap = {},
    PetExpeditionConfig = nil,
    NightMarketConfig = nil,
    NightMarketItemNames = {},
    NightMarketItemIdMap = {},
    MegaSpinnerSpins = 0,
  },
  Cache = {
    QueenBeeHoneyJarInsertPrompt = nil,
    MegaSpinnerPrompt = nil,
    FloatingTPGui = nil,
    CompostCooldownClient = nil,
    EventSignal = nil,
    EventController = nil,
    MyPlot = nil,
    MyPlotName = nil,
    OriginalAlertVolume = nil,
    GuildServiceRF = nil,
    ReplicatorSnapshot = nil,
    ReplicatorSnapshotTime = nil,
    ContractsComm = nil,
    GolemQuestCache = nil,
    GolemQuestCacheTime = 0,
    SharedUtils = nil,
    DirtNodes = setmetatable({}, { __mode = "k" }),
    DirtNodesTime = setmetatable({}, { __mode = "k" }),
    SavedFOV = nil,
    CycleAnimationHooked = false,
    OriginalCycleAnimationPlay = nil,
  },
  Connections = {
    ContractsObserver = nil,
    FavoritesObserver = nil,
    SeasonPassObserver = nil,
    EventCurrenciesObserver = nil,
    GolemQuestObserver = nil,
    RollSeedsConnection = nil,
    BuySeedConnection = nil,
    FloatingTPUISConn = nil,
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
  Paragraph = {
    PetInfo = nil,
    CompostInfo = nil,
    FriendOTronInfo = nil,
    PetMutationInfo = nil,
    WanderingMerchantInfo = nil,
    GolemQuest = nil,
    PetExpeditionInfo = nil,
    FloorPlants = {},
    FuseInfo = nil,
  },
}

local v13 = {}

local v14 = {
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
  TELEPORT_DESTINATIONS = {
    { Label = "Farm Floor 1", Path = "MyPlot", Offset = Vector3.new(0, 5, 40) },
    { Label = "Farm Floor 2", Path = "MyPlot", Offset = Vector3.new(0, 35, 40) },
    { Label = "Farm Floor 3", Path = "MyPlot", Offset = Vector3.new(0, 60, 40) },
    { Label = "Farm Floor 4", Path = "MyPlot", Offset = Vector3.new(0, 80, 40) },
    { Label = "Farm Floor 5", Path = "MyPlot", Offset = Vector3.new(0, 100, 40) },
    {
      Label = "Pet Merchant",
      Path = "PetMerchant/MerchantSign",
      Offset = Vector3.new(0, 5, 10),
    },
    { Label = "Friend-O-Tron", Path = "FriendOTron", Offset = Vector3.new(0, 5, 10) },
    { Label = "Fuse Machine", Path = "Cyber Fuse Machine", Offset = Vector3.new(0, 5, 20) },
    {
      Label = "Leaderboards",
      Path = "Leaderboards/CashLeaderboard",
      Offset = Vector3.new(0, 5, 10),
    },
  },
  GIFTCODES = {
    "BEESPART2", "BZZBZZ", "CARNIVAL", "UPDATE5", "250KUSERS", "PLANTRUSH", "UPDATE2",
    "THANKYOU", "BARF:3", "100KVISITS", "2KLIKES", "UPDATE1",
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

for key, value in pairs(v14.MONEY_SUFFIX_MULTIPLIERS) do
  v14.SUFFIX_BY_VALUE[value] = key
end

local function f1(p1, p2, p3, p4, p5)
  p4 = p4 or 5
  p5 = p5 or 2

  task.spawn(function()
    local count = 0
    local v15 = nil
    local v16 = string.split(p2, ".")

    while count < p4 and not v15 do
      local v17, v18 = pcall(function()
        if not p1 then
          error("Parent is nil")
        end

        local waitForChild = p1

        for index, value2 in ipairs(v16) do
          waitForChild = waitForChild:WaitForChild(value2, p5)

          if not waitForChild then
            error("Child not found: " .. value2)
          end
        end

        return require(waitForChild)
      end)

      if v17 and v18 then
        v15 = v18
        break
      end

      count = count + 1
      task.wait(p5)
    end

    if p3 then
      p3(v15)
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
  local v19, v20 = string.match(gsub, "^([%d%.]+)(%a*)$")

  if not v19 then
    return 0
  end

  local v21 = 1

  if v20 and v20 ~= "" then
    v21 = v14.MONEY_SUFFIX_MULTIPLIERS[v20] or 1
  end

  return (tonumber(v19) or 0) * v21
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

  local v22 = 10 ^ (math.floor(math.log10(p7) / 3) * 3)
  local v23 = v14.SUFFIX_BY_VALUE[v22]

  if v23 then
    local v24 = p7 / v22

    local v25 = v24 == math.floor(v24) and string.format("%.0f", v24)
      or string.format("%.2f", v24)

    return string.format("%s%s", v25, v23)
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

function GetPlayerCash()
  local v26, v27 = pcall(function()
    return (localPlayer:FindFirstChild("leaderstats")
      or localPlayer:FindFirstChild("Leaderstats")).Cash.Value
  end)

  return v26 and f2(v27) or 0
end

function CanAffordPurchase(p9)
  return GetPlayerCash() >= p9
end

function GetHoneyTokens()
  local v28, v29 = pcall(function()
    return localPlayer.PlayerGui.MainUI.MoneyCounter.EventCurrency.HoneyTokens
  end)

  local contentText = v28 and v29 and (v29.ContentText or v29.Text)
  return contentText and contentText ~= "" and f2(contentText) or 0
end

function GetMyPlot()
  if v12.Cache.MyPlot and v12.Cache.MyPlot.Parent and v12.Cache.MyPlot:IsDescendantOf(workspace) then
    return v12.Cache.MyPlot
  end

  local plots = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Plots")

  if not plots then
    return nil
  end

  if v12.Cache.MyPlotName then
    local findFirstChild = plots:FindFirstChild(v12.Cache.MyPlotName)

    if findFirstChild and findFirstChild:GetAttribute("OwnerUserId") == localPlayer.UserId then
      v12.Cache.MyPlot = findFirstChild
      return findFirstChild
    end
  end

  local v30, v31 = pcall(function() return plots:GetChildren() end)

  if v30 and v31 then
    for index2, value3 in ipairs(v31) do
      if value3:GetAttribute("OwnerUserId") == localPlayer.UserId then
        v12.Cache.MyPlot = value3
        v12.Cache.MyPlotName = value3.Name
        return value3
      end
    end
  end

  return nil
end

function GetMyPlotName()
  if v12.Cache.MyPlotName then
    return v12.Cache.MyPlotName
  end

  local v32 = GetMyPlot()

  if v32 then
    return v32.Name
  end

  return nil
end

function SendFriendRequestTo(p10)
  if p10 and p10 ~= localPlayer then
    pcall(function() localPlayer:RequestFriendship(p10) end)
  end
end

function HideOtherPlayerPlots(p11)
  local plots2 = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Plots")

  if not plots2 then
    return
  end

  if p11 then
    local v33 = GetMyPlotName()

    if not v33 then
      return
    end

    for index3, value4 in ipairs(plots2:GetChildren()) do
      if value4.Name ~= v33 then
        value4.Parent = lighting
      end
    end
  else
    local v34 = GetMyPlotName()

    for index4, value5 in ipairs(lighting:GetChildren()) do
      if string.find(value5.Name, "Plot") and value5.Name ~= v34 then
        value5.Parent = plots2
      end
    end
  end
end

function GetFarmRenderClient()
  local starterPlayer = game:GetService("StarterPlayer")
  local starterPlayerScripts = starterPlayer:FindFirstChild("StarterPlayerScripts")

  local clientLoader = starterPlayerScripts
    and starterPlayerScripts:FindFirstChild("ClientLoader")

  local handlers = clientLoader and clientLoader:FindFirstChild("Handlers")
  local farmRenderClient = handlers and handlers:FindFirstChild("FarmRenderClient")

  if farmRenderClient then
    local v35, v36 = pcall(require, farmRenderClient)

    if v35 and type(v36) == "table" then
      return v36
    end
  end

  return nil
end

function GetClientHandlerModule(p12)
  local starterPlayer2 = game:GetService("StarterPlayer")
  local starterPlayerScripts2 = starterPlayer2:FindFirstChild("StarterPlayerScripts")

  local clientLoader2 = starterPlayerScripts2
    and starterPlayerScripts2:FindFirstChild("ClientLoader")

  local handlers2 = clientLoader2 and clientLoader2:FindFirstChild("Handlers")
  local findFirstChild2 = handlers2 and handlers2:FindFirstChild(p12)

  if findFirstChild2 then
    local v37, v38 = pcall(require, findFirstChild2)

    if v37 and type(v38) == "table" then
      return v38
    end
  end

  return nil
end

function ApplyPlantVisualState(p13, p14)
  if not p13 or not p13:IsA("Model") then
    return
  end

  if p13.Parent and p13.Parent:IsA("BasePart") then
    p13.Parent.LocalTransparencyModifier = p14 and 1 or 0
  end

  for index5, value6 in ipairs(p13:GetDescendants()) do
    if value6:IsA("BasePart") then
      value6.LocalTransparencyModifier = p14 and 1 or 0
    elseif value6:IsA("ParticleEmitter") or value6:IsA("Beam") or value6:IsA("Trail") then
      value6.Enabled = not p14
    end
  end
end

function SetHidePlants(p15)
  if v12.Connections.HideDirtConnections then
    for index6, value7 in ipairs(v12.Connections.HideDirtConnections) do
      pcall(function() value7:Disconnect() end)
    end

    table.clear(v12.Connections.HideDirtConnections)
  else
    v12.Connections.HideDirtConnections = {}
  end

  local v39 = GetMyPlot()

  if not v39 then
    return
  end

  for index7, value8 in ipairs(v39:GetDescendants()) do
    if value8:IsA("BasePart") and value8.Name == "Dirt" then
      for index8, value9 in ipairs(value8:GetChildren()) do
        if value9:IsA("Model") then
          ApplyPlantVisualState(value9, p15)
        end
      end

      if p15 then
        local connect = value8.ChildAdded:Connect(function(child)
          if child:IsA("Model") then
            task.defer(function() ApplyPlantVisualState(child, true) end)
          end
        end)

        table.insert(v12.Connections.HideDirtConnections, connect)
      end
    end
  end
end

function ApplyPetVisualState(p16, p17)
  if not p16 or not p16:IsA("Model") then
    return
  end

  for index9, value10 in ipairs(p16:GetDescendants()) do
    if value10:IsA("BasePart") then
      value10.LocalTransparencyModifier = p17 and 1 or 0
    elseif value10:IsA("ParticleEmitter") or value10:IsA("Beam") or value10:IsA("Trail") then
      value10.Enabled = not p17
    end
  end
end

function SetHidePets(p18)
  if v12.Connections.HidePetsConnection then
    pcall(function() v12.Connections.HidePetsConnection:Disconnect() end)
    v12.Connections.HidePetsConnection = nil
  end

  local clientPetVisuals = workspace:FindFirstChild("ClientPetVisuals")

  if not clientPetVisuals then
    return
  end

  for index10, value11 in ipairs(clientPetVisuals:GetChildren()) do
    if value11:IsA("Model") then
      ApplyPetVisualState(value11, p18)
    end
  end

  if p18 then
    v12.Connections.HidePetsConnection = clientPetVisuals.ChildAdded:Connect(function(child2)
      if child2:IsA("Model") then
        task.defer(function() ApplyPetVisualState(child2, true) end)
      end
    end)
  end
end

function SetExtremeLowPerformance(p19)
  v12.Flags.IsExtremeLowPerformance = p19

  pcall(function()
    local setSetting = replicatedStorage.Remotes.Settings.SetSetting
    setSetting:FireServer("VFX", not p19)
    setSetting:FireServer("SFX", not p19)
    setSetting:FireServer("Music", not p19)
    setSetting:FireServer("FarmIcons", not p19)
    setSetting:FireServer("Titles", not p19)
    setSetting:FireServer("LowPerformanceMode", p19)
    setSetting:FireServer("HideOtherFarms", p19)
  end)

  pcall(function() SetHidePlants(p19) end)
  pcall(function() SetHidePets(p19) end)

  HideOtherPlayerPlots(p19)
end

function SetLockCameraFov(p20)
  v12.Flags.IsDisableFovEffects = p20
  local currentCamera = workspace.CurrentCamera

  if not currentCamera then
    return
  end

  if p20 then
    v12.Cache.SavedFOV = currentCamera.FieldOfView

    if v12.Connections.FovChangedConnection then
      v12.Connections.FovChangedConnection:Disconnect()
      v12.Connections.FovChangedConnection = nil
    end

    v12.Connections.FovChangedConnection = currentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
      if v12.Flags.IsDisableFovEffects and v12.Cache.SavedFOV
        and currentCamera.FieldOfView ~= v12.Cache.SavedFOV then
        currentCamera.FieldOfView = v12.Cache.SavedFOV
      end
    end)
  else
    if v12.Connections.FovChangedConnection then
      v12.Connections.FovChangedConnection:Disconnect()
      v12.Connections.FovChangedConnection = nil
    end

    v12.Cache.SavedFOV = nil
  end
end

function GetCycleAnimationModule()
  local playerScripts = localPlayer:FindFirstChild("PlayerScripts")

  if playerScripts then
    local findFirstChild3 = playerScripts:FindFirstChild("CycleAnimation", true)

    if findFirstChild3 then
      return findFirstChild3
    end
  end

  local starterPlayer3 = game:GetService("StarterPlayer")
  local starterPlayerScripts3 = starterPlayer3:FindFirstChild("StarterPlayerScripts")

  if starterPlayerScripts3 then
    local findFirstChild4 = starterPlayerScripts3:FindFirstChild("CycleAnimation", true)

    if findFirstChild4 then
      return findFirstChild4
    end
  end

  return nil
end

function SetDisableSeedBounce(p21)
  v12.Flags.IsDisableSeedBounce = p21
  local v40 = GetCycleAnimationModule()

  if not v40 then
    return
  end

  local v41, v42 = pcall(require, v40)

  if not v41 or type(v42) ~= "table" or type(v42.Play) ~= "function" then
    return
  end

  local v43 = typeof(hookfunction) == "function" and hookfunction
    or typeof(replaceclosure) == "function" and replaceclosure

  if not v43 then
    return
  end

  if p21 then
    if not v12.Cache.CycleAnimationHooked then
      v12.Cache.OriginalCycleAnimationPlay = v43(v42.Play, function(p22, p23)
        if v12.Flags.IsDisableSeedBounce then
          local v44 = type(p22) == "table" and type(p22.LandOn) == "function" and p22
            or type(p23) == "table" and type(p23.LandOn) == "function" and p23

          if v44 and type(v44.LandOn) == "function" then
            pcall(v44.LandOn)
            return
          end
        end

        if v12.Cache.OriginalCycleAnimationPlay then
          return v12.Cache.OriginalCycleAnimationPlay(p22, p23)
        end
      end)

      v12.Cache.CycleAnimationHooked = true
    end
  elseif v12.Cache.CycleAnimationHooked and v12.Cache.OriginalCycleAnimationPlay then
    pcall(function() v43(v42.Play, v12.Cache.OriginalCycleAnimationPlay) end)
    v12.Cache.OriginalCycleAnimationPlay = nil
    v12.Cache.CycleAnimationHooked = false
  end
end

function SetRemoveAllEffects(p24)
  v12.Flags.IsRemoveAllEffects = p24

  local function f5(p25, enabled)
    if p25:IsA("ParticleEmitter") or p25:IsA("Beam") or p25:IsA("Trail") or p25:IsA("Smoke")
      or p25:IsA("Fire") or p25:IsA("Sparkles") or p25:IsA("Highlight") or p25:IsA("PointLight")
      or p25:IsA("SpotLight") or p25:IsA("SurfaceLight") then
      p25.Enabled = enabled
    end
  end

  if p24 then
    pcall(function() lighting.GlobalShadows = false end)

    for index11, value12 in ipairs(lighting:GetChildren()) do
      if value12:IsA("PostEffect") then
        value12.Enabled = false
      end
    end

    for index12, value13 in ipairs(workspace:GetDescendants()) do
      pcall(f5, value13, false)
    end

    if v12.Connections.DescendantVfxConnection then
      v12.Connections.DescendantVfxConnection:Disconnect()
      v12.Connections.DescendantVfxConnection = nil
    end

    v12.Connections.DescendantVfxConnection = workspace.DescendantAdded:Connect(function(descendant)
      if v12.Flags.IsRemoveAllEffects then
        pcall(f5, descendant, false)
      end
    end)
  else
    if v12.Connections.DescendantVfxConnection then
      v12.Connections.DescendantVfxConnection:Disconnect()
      v12.Connections.DescendantVfxConnection = nil
    end

    pcall(function() lighting.GlobalShadows = true end)

    for index13, value14 in ipairs(lighting:GetChildren()) do
      if value14:IsA("PostEffect") then
        value14.Enabled = true
      end
    end

    for index14, value15 in ipairs(workspace:GetDescendants()) do
      pcall(f5, value15, true)
    end
  end
end

function GetPlantRegistry()
  local v45, v46 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Plants", 5
    ))
  end)

  if v45 and type(v46) == "table" and type(v46.GetPlantsForIndex) == "function" then
    local v47, v48 = pcall(v46.GetPlantsForIndex)

    if v47 and type(v48) == "table" and #v48 > 0 then
      local v49 = {}

      for index15, value16 in ipairs(v48) do
        local v50 = v46[value16.Name] or {}

        table.insert(v49, {
          Name = value16.Name,
          Rarity = value16.Rarity,
          Icon = value16.Icon,
          Price = value16.Price,
          Event = value16.Event,
          Cost = v50.Cost,
          StageGrowTime = v50.StageGrowTime,
          MaxStages = v50.MaxStages,
          RollChance = v50.RollChance,
          RollWeather = v50.RollWeather,
          EventFiltering = v50.EventFiltering,
        })
      end

      return v49
    end
  end

  local v51 = {}

  local seeds = replicatedStorage:FindFirstChild("Assets")
    and replicatedStorage.Assets:FindFirstChild("Seeds")

  if seeds then
    for index16, value17 in ipairs(seeds:GetChildren()) do
      table.insert(v51, { Name = string.gsub(value17.Name, " Seed$", "") })
    end

    table.sort(v51, function(p26, p27) return p26.Name < p27.Name end)
  end

  return v51
end

function GetPlantRarityRegistry()
  local v52, v53 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Rarities", 5
    ))
  end)

  local v54 = {}

  if v52 and type(v53) == "table" then
    for key2, value18 in pairs(v53) do
      if type(value18) == "table" and value18.Order then
        table.insert(v54, {
          Name = key2,
          Order = value18.Order,
          AccentColor = value18.AccentColor,
        })
      end
    end

    table.sort(v54, function(p28, p29) return p28.Order < p29.Order end)
  end

  return v54
end

function GetMutationRegistry()
  local v55, v56 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Mutations", 5
    ))
  end)

  local v57 = {}

  if v55 and type(v56) == "table" and type(v56[2]) == "table" then
    for key3, value19 in pairs(v56[2]) do
      if type(value19) == "table" then
        table.insert(v57, {
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

    table.sort(v57, function(p30, p31) return p30.Name < p31.Name end)
  end

  return v57
end

function GetCompostConfig()
  local v58 = { LevelNames = { "Rich", "Prime", "Overgrown" }, CooldownDuration = 300 }

  local v59, v60 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("CompostConfig", 5))
  end)

  if v59 and type(v60) == "table" and v60.Tiers then
    local v61 = {}

    for index17, value20 in ipairs(v60.Tiers[2] or {}) do
      table.insert(v61, value20.Name)
    end

    if #v61 > 0 then
      v58.LevelNames = v61
    end
  end

  local v62, v63 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "CompostCooldownConfig", 5
    ))
  end)

  if v62 and type(v63) == "table" and type(v63.Duration) == "number" then
    v58.CooldownDuration = v63.Duration
  end

  return v58
end

function GetGearRegistry()
  local v64, v65 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Gear", 5
    ))
  end)

  local v66 = {}

  if v64 and type(v65) == "table" and type(v65[2]) == "table" then
    for key4, value21 in pairs(v65[2]) do
      table.insert(v66, {
        Name = key4,
        Chance = value21.Chance,
        MaxStock = value21.MaxStock,
        Cost = value21.Cost,
      })
    end

    table.sort(v66, function(p32, p33) return p32.Name < p33.Name end)
  end

  return v66
end

function GetEggConfig()
  local v67, v68 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("EggConfig", 5))
  end)

  local v69 = {}
  local v70 = {}
  local v71 = {}

  if v67 and type(v68) == "table" then
    if v68.Prices then
      for key5, value22 in pairs(v68.Prices) do
        v69[key5] = tonumber(value22) or 0
        table.insert(v70, key5)
      end
    end

    if v68.UnlockPrices then
      for key6, value23 in pairs(v68.UnlockPrices) do
        local v72 = string.match(key6, "%d+")

        if v72 then
          table.insert(v71, {
            EggSlotNumber = tonumber(v72),
            UnlockPrice = tonumber(value23) or 0,
          })
        end
      end

      table.sort(v71, function(p34, p35) return p34.EggSlotNumber < p35.EggSlotNumber end)
    end
  end

  table.sort(v70)
  return v69, v70, v71
end

function GetPetRegistry()
  local v73, v74 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Pets", 5
    ))
  end)

  local v75 = {}

  if v73 and type(v74) == "table" then
    for key7, value24 in pairs(v74) do
      if type(value24) == "table" and value24.Rarity then
        table.insert(v75, {
          Name = key7,
          Rarity = value24.Rarity,
          AbilityInfo = value24.AbilityInfo,
          MultiplierRanges = value24.MultiplierRanges,
        })
      end
    end

    table.sort(v75, function(p36, p37) return p36.Name < p37.Name end)
  end

  return v75
end

function GetPetSizeRegistry(p38)
  local v76 = {}

  for index18, value25 in ipairs(p38) do
    local multiplierRanges = value25.MultiplierRanges or value25.MutiplierRanges

    if type(multiplierRanges) == "table" then
      for key8, value26 in pairs(multiplierRanges) do
        v76[key8] = true
      end
    end
  end

  local v77 = {}

  for key9, value27 in pairs(v76) do
    table.insert(v77, key9)
  end

  table.sort(v77)
  return v77
end

function GetZooRushConfig()
  local v78, v79 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("ZooRushConfig", 5))
  end)

  if not (v78 and type(v79) == "table") then
    return {}, {}
  end

  local v80 = {}
  local v81 = {}
  local v82 = {}

  for index19, value28 in ipairs({ v79.SpawnTable, v79.AdminSpawnTable }) do
    if type(value28) == "table" then
      for key10 in pairs(value28) do
        if not v82[key10] then
          v82[key10] = true
          table.insert(v80, key10)
        end
      end
    end
  end

  table.sort(v80)

  for key11, value29 in pairs(v79.SpawnTable) do
    v81[key11] = value29
  end

  for key12, value30 in pairs(v79.AdminSpawnTable) do
    if v81[key12] == nil then
      v81[key12] = value30
    end
  end

  return v80, v81
end

function GetGuildConfig()
  return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("GuildConfig", 5))
end

function GetPetMutationConfig()
  local v83, v84 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "PetMutationConfig", 5
    ))
  end)

  if not (v83 and type(v84) == "table") then
    return nil, {}
  end

  local v85 = {}

  for index20, value31 in ipairs(v84.Mutations) do
    if value31.Released then
      table.insert(v85, value31.Name)
    end
  end

  return v84.Rarities, v85, v84
end

function GetFriendOTronConfig()
  local v86, v87 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "FriendOTronConfig", 5
    ))
  end)

  if v86 and type(v87) == "table" then
    return v87
  end

  return nil
end

function GetContractsConfig()
  if v12.Data.ContractsConfig then
    return v12.Data.ContractsConfig
  end

  local v88, v89 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Contracts", 5))
  end)

  if v88 and type(v89) == "table" then
    v12.Data.ContractsConfig = v89
    return v89
  end

  return nil
end

function GetContractRegistry()
  if v12.Data.ContractRegistry then
    return v12.Data.ContractRegistry
  end

  local v90, v91 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5))
  end)

  if v90 and type(v91) == "table" then
    v12.Data.ContractRegistry = v91
    return v91
  end

  return nil
end

function GetSharedUtils()
  if v12.Cache.SharedUtils then
    return v12.Cache.SharedUtils
  end

  local v92, v93 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("SharedUtils", 5))
  end)

  if v92 and type(v93) == "table" then
    v12.Cache.SharedUtils = v93
    return v93
  end

  return nil
end

function GetWanderingMerchantConfig()
  if v12.Data.WanderingMerchantConfig then
    return v12.Data.WanderingMerchantConfig, v12.Data.WanderingMerchantItemNames, v12.Data.WanderingMerchantItemIdMap
  end

  local v94, v95 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "WanderingMerchantConfig", 5
    ))
  end)

  if v94 and type(v95) == "table" then
    v12.Data.WanderingMerchantConfig = v95
    v12.Data.WanderingMerchantItemNames = {}
    v12.Data.WanderingMerchantItemIdMap = {}

    if type(v95.Items) == "table" then
      for index21, value32 in ipairs(v95.Items) do
        local displayName = value32.DisplayName or value32.Id
        table.insert(v12.Data.WanderingMerchantItemNames, displayName)
        v12.Data.WanderingMerchantItemIdMap[displayName] = value32.Id
      end
    end

    return v95, v12.Data.WanderingMerchantItemNames, v12.Data.WanderingMerchantItemIdMap
  end

  return nil, {}, {}
end

function GetNightMarketConfig()
  if v12.Data.NightMarketConfig then
    return v12.Data.NightMarketConfig, v12.Data.NightMarketItemNames, v12.Data.NightMarketItemIdMap
  end

  local v96, v97 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "NightMarketMerchantConfig", 5
    ))
  end)

  if v96 and type(v97) == "table" then
    v12.Data.NightMarketConfig = v97
    v12.Data.NightMarketItemNames = {}
    v12.Data.NightMarketItemIdMap = {}

    if type(v97.Items) == "table" then
      for index22, value33 in ipairs(v97.Items) do
        local displayName2 = value33.DisplayName or value33.Id
        table.insert(v12.Data.NightMarketItemNames, displayName2)
        v12.Data.NightMarketItemIdMap[displayName2] = value33.Id
      end
    end

    return v97, v12.Data.NightMarketItemNames, v12.Data.NightMarketItemIdMap
  end

  return nil, {}, {}
end

function GetConfigurationConfig()
  if v13.Configuration then
    return v13.Configuration
  end

  local v98, v99 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Configuration", 5))
  end)

  if v98 and type(v99) == "table" then
    v13.Configuration = v99
    return v99
  end

  return nil
end

function GetCrownedCropsConfig()
  if v13.CrownedCropsConfig then
    return v13.CrownedCropsConfig
  end

  local v100, v101 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "CrownedCropsConfig", 5
    ))
  end)

  if v100 and type(v101) == "table" then
    v13.CrownedCropsConfig = v101
    return v101
  end

  return nil
end

function GetGoldenHarvestConfig()
  if v13.GoldenHarvestConfig then
    return v13.GoldenHarvestConfig
  end

  local v102, v103 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "GoldenHarvestConfig", 5
    ))
  end)

  if v102 and type(v103) == "table" then
    v13.GoldenHarvestConfig = v103
    return v103
  end

  return nil
end

function GetPetExpeditionConfig()
  if v12.Data.PetExpeditionConfig then
    return v12.Data.PetExpeditionConfig
  end

  local v104, v105 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "PetExpeditionConfig", 5
    ))
  end)

  if v104 and type(v105) == "table" then
    v12.Data.PetExpeditionConfig = v105
    return v105
  end

  return nil
end

f1(replicatedStorage, "Packages.DataReplicator", function(p39)
  v11 = p39

  if v11 then
    local v106, v107 = pcall(v11.GetReplicator)

    if v106 and v107 then
      pcall(function()
        v12.Connections.ContractsObserver = v107:Observe({ "Contracts" }, function() end)
      end)

      pcall(function()
        v12.Connections.FavoritesObserver = v107:Observe({ "Favorites" }, function() end)
      end)

      pcall(function()
        v12.Connections.SeasonPassObserver = v107:Observe({ "SeasonPasses" }, function() end)
      end)

      pcall(function()
        v12.Connections.EventCurrenciesObserver = v107:Observe({ "EventCurrencies" }, function()
        end)
      end)

      pcall(function()
        v12.Connections.GolemQuestObserver = v107:Observe({ "PlantBossQuest" }, function() end)
      end)

      pcall(function()
        v12.Connections.FuseObserver = v107:Observe({ "Fuse" }, function() end)
      end)

      pcall(function()
        v12.Connections.PetMutationObserver = v107:Observe({ "PetMutation" }, function() end)
      end)

      pcall(function()
        v12.Connections.NightMarketMerchantObserver = v107:Observe({ "NightMarketMerchant" }, function()
        end)
      end)

      pcall(function()
        v12.Connections.VaultObserver = v107:Observe({ "Vault" }, function() end)
      end)

      pcall(function()
        v12.Connections.MegaSpinnerSpinsObserver = v107:Observe({
          "InteractiveEvents", "MegaSpinner", "Spins",
        }, function(p40)
          v12.Data.MegaSpinnerSpins = tonumber(p40) or 0
        end)
      end)
    end
  end
end)

v12.Data.PlantRegistry = GetPlantRegistry()

for index23, value34 in ipairs(v12.Data.PlantRegistry) do
  table.insert(v12.Data.PlantNames, value34.Name)
end

v12.Data.PlantRarityLookup = {}

for index24, value35 in ipairs(v12.Data.PlantRegistry) do
  v12.Data.PlantRarityLookup[string.lower(value35.Name)] = value35.Rarity or "Unknown"
end

local v108 = GetPlantRarityRegistry()
v12.Data.RarityRegistry = v108

for index25, value36 in ipairs(v108) do
  table.insert(v12.Data.RarityNames, value36.Name)
  v12.Data.RarityOrderMap[value36.Name] = value36.Order
end

v12.Data.GearRegistry = GetGearRegistry()

for index26, value37 in ipairs(v12.Data.GearRegistry) do
  local name = value37.Name
  table.insert(v12.Data.GearNames, name)

  if (value37.Chance or 0) > 0 and (value37.MaxStock or 0) > 0 then
    table.insert(v12.Data.GearShopItemNames, name)
  end

  v12.Data.GearCosts[name] = value37.Cost or 0
  local v109 = string.lower(name)

  if string.find(v109, "treat") then
    table.insert(v12.Data.PetTreatNames, name)
  elseif string.find(v109, "fertilizer") and not string.find(v109, "crate")
    and not string.find(v109, "box") then
    table.insert(v12.Data.FertilizerNames, name)
  elseif string.find(v109, "spray") then
    table.insert(v12.Data.SprayNames, name)

    if name ~= "Acid Spray" then
      table.insert(v12.Data.MutationSprayNames, name)
    end
  end
end

v12.Data.EggPrices, v12.Data.EggNames, v12.Data.EggSlotPrices = GetEggConfig()
v12.Data.PetRegistry = GetPetRegistry()
v12.Data.PetNames = {}

for index27, value38 in ipairs(v12.Data.PetRegistry) do
  table.insert(v12.Data.PetNames, value38.Name)
end

v12.Data.PetSizeNames = GetPetSizeRegistry(v12.Data.PetRegistry)
v12.Data.PetRarityNames = {}

do
  local v110 = {}

  for index28, value39 in ipairs(v12.Data.PetRegistry) do
    local rarity = value39.Rarity

    if rarity and not v110[rarity] then
      v110[rarity] = true
      table.insert(v12.Data.PetRarityNames, rarity)
    end
  end
end

v12.Data.PetRarityLookup = {}

for index29, value40 in ipairs(v12.Data.PetRegistry) do
  v12.Data.PetRarityLookup[value40.Name] = value40.Rarity
end

v12.Data.CompostConfig = GetCompostConfig()
v12.Data.CompostLevelNames = {}

for index30, value41 in ipairs(v12.Data.CompostConfig.LevelNames) do
  table.insert(v12.Data.CompostLevelNames, value41)
end

v12.Data.CompostCooldownDuration = v12.Data.CompostConfig.CooldownDuration
v12.Data.CompostCooldownEndsAt = {}
v12.Data.MutationRegistry = GetMutationRegistry()

for index31, value42 in ipairs(v12.Data.MutationRegistry) do
  table.insert(v12.Data.MutationNames, value42.Name)
end

local v111 = GetGuildConfig()

if v111 and v111.Shop and v111.Shop.Items then
  for index32, value43 in ipairs(v111.Shop.Items) do
    local displayName3 = value43.DisplayName
    table.insert(v12.Data.GuildShopItemNames, displayName3)
    v12.Data.GuildShopItemIdMap[displayName3] = value43.Id
  end
end

v12.Data.ZooRushPetNames, v12.Data.ZooRushPetRate = GetZooRushConfig()
v12.Data.PetMutationRarityConfig, v12.Data.PetMutationNames, v12.Data.PetMutationConfig = GetPetMutationConfig()
v12.Data.WanderingMerchantConfig, v12.Data.WanderingMerchantItemNames, v12.Data.WanderingMerchantItemIdMap = GetWanderingMerchantConfig()
v12.Data.NightMarketConfig, v12.Data.NightMarketItemNames, v12.Data.NightMarketItemIdMap = GetNightMarketConfig()
v12.Data.ContractsConfig = GetContractsConfig()
v12.Data.ContractRegistry = GetContractRegistry()

GetConfigurationConfig()

local function f6(p41)
  if not p41 then
    return "Unknown"
  end

  return v12.Data.PlantRarityLookup[string.lower(tostring(p41))] or "Unknown"
end

local function f7(p42)
  if not p42 then
    return nil
  end

  return v12.Data.PetRarityLookup[p42]
end

local function f8()
  pcall(function()
    if v12.Connections.RollSeedsConnection then
      v12.Connections.RollSeedsConnection:Disconnect()
    end

    v12.Connections.RollSeedsConnection = replicatedStorage.Remotes.RollSeeds.OnClientEvent:Connect(function(p43)
      if type(p43) ~= "table" then
        return
      end

      if type(p43.Slots) ~= "table" or #p43.Slots == 0 then
        return
      end

      v12.Data.CurrentRollId = p43.RollId
      v12.Data.Gacha.RollData = p43
      v12.Data.Gacha.RollReady = true
    end)
  end)

  pcall(function()
    if v12.Connections.BuySeedConnection then
      v12.Connections.BuySeedConnection:Disconnect()
    end

    v12.Connections.BuySeedConnection = replicatedStorage.Remotes.BuySeed.OnClientEvent:Connect(function(p44, p45)
      if type(p44) == "number" then
        v12.Data.Gacha.BuyResults[p44] = p45 == true
      end
    end)
  end)
end

local function f9()
  local v112 = GetFriendOTronConfig()

  if not v112 then
    return
  end

  if v112.CooldownUntilPath and v11 then
    local v113, v114 = pcall(v11.GetReplicator)

    if v113 and v114 then
      v12.Connections.FriendOTronCooldownObserver = v114:Observe(v112.CooldownUntilPath, function(p46)
        v12.Data.FriendOTronCooldownUntil = tonumber(p46) or 0
      end)

      v12.Connections.FriendOTronSpinsObserver = v114:Observe(v112.SpinsPath, function(p47)
        v12.Data.FriendOTronSpins = tonumber(p47) or 0
      end)

      if v112.PendingSeedKeyPath then
        v12.Connections.FriendOTronPendingSeedKeyObserver = v114:Observe(v112.PendingSeedKeyPath, function(p48)
          v12.Data.FriendOTronPendingSeedKey = tostring(p48 or "")
        end)
      end
    end
  end
end

local function f10(p49)
  if not p49 then
    return nil
  end

  local petKey = p49:GetAttribute("PetKey") or p49:GetAttribute("petKey")

  if not petKey then
    local v115 = string.split(p49.Name, "_")
    petKey = v115[#v115]
  end

  local trueName = p49:GetAttribute("TrueName") or p49:GetAttribute("trueName")
    or p49:GetAttribute("PetName") or p49:GetAttribute("petName") or p49.Name

  local level = tonumber(p49:GetAttribute("PetLevel")) or tonumber(p49:GetAttribute("petLevel"))
    or tonumber(p49:GetAttribute("Level")) or tonumber(p49:GetAttribute("level")) or 1

  local earnings = tonumber(p49:GetAttribute("EarningsMultiplier"))
    or tonumber(p49:GetAttribute("earningsMultiplier"))
    or tonumber(p49:GetAttribute("Earnings")) or tonumber(p49:GetAttribute("earnings")) or 0

  local floorIndex = tonumber(p49:GetAttribute("FloorIndex"))
    or tonumber(p49:GetAttribute("floorIndex"))

  local slotIndex = tonumber(p49:GetAttribute("SlotIndex"))
    or tonumber(p49:GetAttribute("slotIndex"))

  local petBoosted = p49:GetAttribute("PetBoosted") or p49:GetAttribute("petBoosted")

  if not petBoosted and petKey then
    local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

    if playerGui then
      for index33, value44 in ipairs(playerGui:GetChildren()) do
        if value44:IsA("BillboardGui") and value44.Adornee then
          local adornee = value44.Adornee

          while adornee do
            if adornee:IsA("Model")
              and (string.find(adornee.Name, "Pet_") or string.find(adornee.Name, "ClientPet_")) then
              local petKey2 = adornee:GetAttribute("PetKey") or adornee:GetAttribute("petKey")

              if not petKey2 then
                local v116 = string.split(adornee.Name, "_")
                petKey2 = v116[#v116]
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

  return {
    instance = p49,
    petKey = petKey,
    petName = trueName,
    level = level,
    earnings = earnings,
    floorIndex = floorIndex,
    slotIndex = slotIndex,
    petBoosted = petBoosted,
    petBoostEndTimestamp = tonumber(p49:GetAttribute("PetBoostEndTimestamp"))
      or tonumber(p49:GetAttribute("petBoostEndTimestamp")),
    petBoostMultiplier = tonumber(p49:GetAttribute("PetBoostMultiplier"))
      or tonumber(p49:GetAttribute("petBoostMultiplier")),
    petOwner = p49:GetAttribute("PetOwner") or p49:GetAttribute("petOwner"),
    petSize = p49:GetAttribute("PetSize") or p49:GetAttribute("petSize"),
    petMutation = p49:GetAttribute("PetMutation") or p49:GetAttribute("petMutation"),
    rbxReimportId = p49:GetAttribute("RBX_ReimportId") or p49:GetAttribute("rbx_reimportid"),
  }
end

local function f11(p50)
  if not p50 then
    return nil
  end

  local petKey3 = p50:GetAttribute("petKey") or p50:GetAttribute("PetKey")

  if not petKey3 then
    return nil
  end

  return {
    instance = p50,
    petKey = petKey3,
    petName = p50:GetAttribute("trueName") or p50:GetAttribute("TrueName")
      or p50:GetAttribute("PetName") or p50:GetAttribute("petName") or p50.Name,
    level = tonumber(p50:GetAttribute("Level")) or tonumber(p50:GetAttribute("PetLevel"))
      or tonumber(p50:GetAttribute("level")) or tonumber(p50:GetAttribute("petLevel")) or 1,
    earnings = tonumber(p50:GetAttribute("EarningsMultiplier"))
      or tonumber(p50:GetAttribute("earningsMultiplier")) or 0,
    petSize = p50:GetAttribute("PetSize") or p50:GetAttribute("petSize"),
    petMutation = p50:GetAttribute("PetMutation") or p50:GetAttribute("petMutation"),
    petOwner = p50:GetAttribute("PetOwner") or p50:GetAttribute("petOwner"),
  }
end

local function f12()
  local v117 = {}
  local v118 = GetMyPlot()

  if not v118 then
    return v117
  end

  for index34, value45 in ipairs(v118:GetChildren()) do
    if string.sub(value45.Name, 1, 4) == "Pet_" then
      local v119 = f10(value45)

      if v119 then
        if not v119.petKey then
          local v120 = string.split(value45.Name, "_")
          v119.petKey = v120[#v120]
        end

        table.insert(v117, v119)
      end
    end
  end

  return v117
end

local function f13(p51)
  local function f14(p52)
    if not p52 then
      return nil
    end

    for index35, value46 in ipairs(p52:GetChildren()) do
      if value46:IsA("Tool") and string.find(value46.Name, p51, 1, true) then
        return value46
      end
    end

    return nil
  end

  return f14(localPlayer.Character) or f14(localPlayer:FindFirstChild("Backpack"))
end

local function f15()
  local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")

  if humanoid then
    pcall(function() humanoid:UnequipTools() end)
  end
end

local function f16(p53)
  if p53 and p53.Parent ~= localPlayer.Character then
    local humanoid2 = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")

    if humanoid2 then
      humanoid2:EquipTool(p53)
      task.wait(0.2)
    end
  end
end

local function f17()
  if v12.Cache.QueenBeeHoneyJarInsertPrompt and v12.Cache.QueenBeeHoneyJarInsertPrompt.Parent then
    return v12.Cache.QueenBeeHoneyJarInsertPrompt
  end

  v12.Cache.QueenBeeHoneyJarInsertPrompt = nil

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

  v12.Cache.QueenBeeHoneyJarInsertPrompt = findFirstChildWhichIsA
  return v12.Cache.QueenBeeHoneyJarInsertPrompt
end

local function f18()
  if v12.Data.MegaSpinnerSpins and v12.Data.MegaSpinnerSpins > 0 then
    return v12.Data.MegaSpinnerSpins
  end

  if v11 then
    local v121, v122 = pcall(v11.GetReplicator)

    if v121 and v122 then
      return tonumber((v122:Get({ "InteractiveEvents", "MegaSpinner", "Spins" }))) or 0
    end
  end

  return 0
end

local function f19()
  if v12.Cache.MegaSpinnerPrompt and v12.Cache.MegaSpinnerPrompt.Parent then
    return v12.Cache.MegaSpinnerPrompt
  end

  v12.Cache.MegaSpinnerPrompt = nil
  local interactiveEvents = workspace:FindFirstChild("InteractiveEvents")
  local megaSpinner = interactiveEvents and interactiveEvents:FindFirstChild("MegaSpinner")
  local spinner = megaSpinner and megaSpinner:FindFirstChild("Spinner")

  local findFirstChildWhichIsA2 = spinner
    and spinner:FindFirstChildWhichIsA("ProximityPrompt", true)

  if not findFirstChildWhichIsA2 then
    return nil
  end

  v12.Cache.MegaSpinnerPrompt = findFirstChildWhichIsA2
  return v12.Cache.MegaSpinnerPrompt
end

local function f20(p54, p55, p56)
  if not p54 or not p55 then
    return
  end

  local cframe = p55:IsA("BasePart") and p55.CFrame or p55:IsA("Model") and p55:GetPivot()

  if not cframe then
    return
  end

  p54.CFrame = cframe
  task.wait(0.2)

  if p56 and p56:IsA("ProximityPrompt") then
    local holdDuration = p56.HoldDuration or 0
    local maxActivationDistance = p56.MaxActivationDistance
    local requiresLineOfSight = p56.RequiresLineOfSight

    p56.HoldDuration = 0
    p56.MaxActivationDistance = 99999
    p56.RequiresLineOfSight = false

    pcall(function() fireproximityprompt(p56) end)
    pcall(function() p56:InputHoldBegin() end)

    task.wait(holdDuration + 0.2)
    pcall(function() p56:InputHoldEnd() end)

    p56.HoldDuration = holdDuration
    p56.MaxActivationDistance = maxActivationDistance
    p56.RequiresLineOfSight = requiresLineOfSight
  end
end

local function f21(p57, p58, p59)
  local index36 = replicatedStorage:FindFirstChild("Packages")
    and replicatedStorage.Packages:FindFirstChild("_Index")

  if not index36 then
    return nil
  end

  for index37, value47 in ipairs(index36:GetChildren()) do
    if string.find(value47.Name, "knit") then
      local knit = value47:FindFirstChild("knit")
      local services = knit and knit:FindFirstChild("Services")
      local findFirstChild5 = services and services:FindFirstChild(p57)
      local findFirstChild6 = findFirstChild5 and findFirstChild5:FindFirstChild(p58)
      local findFirstChild7 = findFirstChild6 and findFirstChild6:FindFirstChild(p59)

      if findFirstChild7 then
        return findFirstChild7
      end
    end
  end

  return nil
end

local function f22()
  if v12.Cache.EventSignal then
    return v12.Cache.EventSignal
  end

  local v123, v124 = pcall(function()
    return require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"))
  end)

  if v123 and v124 then
    local v125, v126 = pcall(function() return v124.GetService("EventService") end)

    if v125 and v126 and v126.ClientEventSignal then
      v12.Cache.EventSignal = v126.ClientEventSignal
      return v12.Cache.EventSignal
    end
  end

  local v127, v128 = pcall(function()
    local index38 = replicatedStorage.Packages:FindFirstChild("_Index")
    local sleitnickKnit170 = index38 and index38:FindFirstChild("sleitnick_knit@1.7.0")

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
      Connect = function(p60, p61) return clientEventSignal.OnClientEvent:Connect(p61) end,
      Fire = function(p62, p63) clientEventSignal:FireServer(p63) end,
    }
  end)

  if v127 and v128 then
    v12.Cache.EventSignal = v128
  end

  return v12.Cache.EventSignal
end

local function f23()
  if v12.Cache.EventController then
    return v12.Cache.EventController
  end

  local v129, v130 = pcall(function()
    return require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"))
  end)

  if v129 and v130 and v130.GetController then
    local v131, v132 = pcall(function() return v130.GetController("EventController") end)

    if v131 and v132 then
      v12.Cache.EventController = v132
      return v132
    end
  end

  return nil
end

local function f24(p64)
  local v133 = f23()

  if v133 and v133.isEventActive then
    local v134, v135 = pcall(function() return v133:isEventActive(p64) end)

    if v134 and type(v135) == "boolean" then
      return v135
    end
  end

  return nil
end

local function f25()
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

local function f26(p65)
  local index39 = replicatedStorage:FindFirstChild("Packages")
    and replicatedStorage.Packages:FindFirstChild("_Index")

  if not index39 then
    return nil
  end

  for index40, value48 in ipairs(index39:GetChildren()) do
    if string.find(value48.Name, "knit") then
      local knit2 = value48:FindFirstChild("knit")
      local services2 = knit2 and knit2:FindFirstChild("Services")
      local findFirstChild8 = services2 and services2:FindFirstChild(p65)
      local rf = findFirstChild8 and findFirstChild8:FindFirstChild("RF")

      if rf then
        return rf
      end
    end
  end

  return nil
end

local function f27()
  if v12.Cache.GuildServiceRF then
    return v12.Cache.GuildServiceRF
  end

  local guildService = f26("GuildService")

  if guildService then
    v12.Cache.GuildServiceRF = guildService
  end

  return guildService
end

local function f28(p66, ...)
  local v136 = f27()

  if not v136 then
    return nil
  end

  local findFirstChild9 = v136:FindFirstChild(p66)

  if not findFirstChild9 then
    return nil
  end

  local v137 = { ... }
  local v138, v139 = pcall(function() return findFirstChild9:InvokeServer(unpack(v137)) end)

  if v138 then
    return v139
  end

  return nil
end

local function f29()
  local v140 = tick()

  if v12.Cache.ReplicatorSnapshot and v12.Cache.ReplicatorSnapshotTime
    and v140 - v12.Cache.ReplicatorSnapshotTime < 0.5 then
    return v12.Cache.ReplicatorSnapshot
  end

  if v11 and v11.GetReplicator then
    local v141, v142 = pcall(function() return v11.GetReplicator():GetSnapshot() end)

    if v141 and v142 then
      v12.Cache.ReplicatorSnapshot = v142
      v12.Cache.ReplicatorSnapshotTime = v140
      return v142
    end
  end

  return nil
end

local function f30(p67)
  p67 = p67 or 3
  local v143 = tick()

  if v12.Cache.ReplicatorSnapshot and v12.Cache.ReplicatorSnapshotTime
    and v143 - v12.Cache.ReplicatorSnapshotTime < p67 then
    return v12.Cache.ReplicatorSnapshot
  end

  local v144 = f29()

  if v144 then
    v12.Cache.ReplicatorSnapshot = v144
    v12.Cache.ReplicatorSnapshotTime = v143
    return v144
  end

  return v12.Cache.ReplicatorSnapshot
end

local function f31()
  local v145, v146 = pcall(function()
    return require(replicatedStorage:WaitForChild("Packages", 2):WaitForChild("Knit", 2))
  end)

  if v145 and v146 then
    local v147, v148 = pcall(function() return v146.GetService("FuseService") end)

    if v147 and v148 then
      return v148
    end
  end

  return nil
end

local function f32(p68, ...)
  local v149 = f31()

  if v149 and type(v149[p68]) == "function" then
    local v150, v151 = pcall(function(...) return v149[p68](v149, ...) end, ...)

    if v150 then
      return true, v151
    end
  end

  local v152 = f21("FuseService", "RF", p68)

  if v152 then
    local v153, v154 = pcall(function(...) return v152:InvokeServer(...) end, ...)
    return v153, v154
  end

  return false, "FuseService / RF not found"
end

local function f33()
  local v155, v156 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 2):WaitForChild("SeasonPassData", 2))
  end)

  if v155 and v156 then
    return v156
  end

  return nil
end

local function f34(p69)
  p69 = p69 or f33()
  local currency = p69 and p69.Currency or "Sparks"
  local v157 = f29()

  if v157 and v157.EventCurrencies and v157.EventCurrencies[currency] then
    return v157.EventCurrencies[currency]
  end

  local v158, v159 = pcall(function()
    return localPlayer.PlayerGui.MainUI.MoneyCounter.EventCurrency.CarnivalTokens
  end)

  local contentText2 = v158 and v159 and (v159.ContentText or v159.Text)
  return contentText2 and contentText2 ~= "" and f2(contentText2) or 0
end

local function f35()
  local v160 = f29()

  if v160 and v160.EventCurrencies and v160.EventCurrencies.Sparks then
    return v160.EventCurrencies.Sparks
  end

  if v11 then
    local v161, v162 = pcall(v11.GetReplicator)

    if v161 and v162 then
      local get = v162:Get({ "EventCurrencies", "Sparks" })

      if get then
        return get
      end
    end
  end

  return 0
end

local function f36()
  local v163 = GetNightMarketConfig()
  local v164 = f29()
  local nightMarketMerchant = v164 and v164.NightMarketMerchant
  local stock = nightMarketMerchant and nightMarketMerchant.Stock
  local purchased = nightMarketMerchant and nightMarketMerchant.Purchased or {}

  if stock and next(stock) ~= nil then
    local v165 = {}

    for index41, value49 in ipairs(v163 and v163.Items or {}) do
      v165[value49.Id] = tonumber(stock[value49.Id]) or 0
    end

    return v165
  end

  if v11 then
    local v166, v167 = pcall(v11.GetReplicator)

    if v166 and v167 then
      local get2 = v167:Get({ "NightMarketMerchant", "Stock" })

      if get2 and next(get2) ~= nil then
        local v168 = {}

        for index42, value50 in ipairs(v163 and v163.Items or {}) do
          v168[value50.Id] = tonumber(get2[value50.Id]) or 0
        end

        return v168
      end
    end
  end

  if v163 and type(v163.BuildStock) == "function" then
    local v169, v170 = pcall(v163.BuildStock, purchased)

    if v169 and type(v170) == "table" then
      return v170
    end
  end

  local v171 = {}

  for index43, value51 in ipairs(v163 and v163.Items or {}) do
    local stock2 = value51.Stock or 0

    if value51.OneTime then
      local v172 = tonumber(purchased[value51.Id]) or 0
      stock2 = math.max(0, stock2 - v172)
    end

    v171[value51.Id] = stock2
  end

  return v171
end

local function f37(p70)
  local v173 = f21("NightMarketMerchantService", "RF", "BuyItem")

  if v173 then
    local v174, v175 = pcall(function() return v173:InvokeServer(p70) end)
    return v174, v175
  end

  return false, "BuyItem RF not found"
end

local function f38(p71)
  if not p71 then
    return false
  end

  local v176 = nil

  if v11 and v11.GetReplicator then
    local v177, v178 = pcall(v11.GetReplicator)

    if v177 and v178 then
      v176 = v178
    end
  end

  local favorites = nil

  if v176 then
    local v179, v180 = pcall(function() return v176:Get({ "Favorites" }) end)

    if v179 and type(v180) == "table" then
      favorites = v180
    end
  end

  if not favorites then
    local v181 = f30(3)
    favorites = v181 and v181.Favorites
  end

  if type(favorites) ~= "table" then
    return false
  end

  local rodKey = p71:GetAttribute("RodKey")

  local seedKey = p71:GetAttribute("seedKey") or p71:GetAttribute("SeedKey")
    or p71:GetAttribute("petKey") or p71:GetAttribute("PetKey") or p71:GetAttribute("gearKey")
    or p71:GetAttribute("GearKey") or p71:GetAttribute("key") or p71:GetAttribute("Key")
    or rodKey and "rod:" .. tostring(rodKey)

  return seedKey ~= nil and favorites[seedKey] == true
end

local function f39()
  if v12.Cache.ContractsComm then
    return v12.Cache.ContractsComm
  end

  local v182, v183 = pcall(function()
    local comm = replicatedStorage:FindFirstChild("Packages")
      and replicatedStorage.Packages:FindFirstChild("Comm")

    if comm then
      return require(comm)
    end

    local index44 = replicatedStorage:FindFirstChild("Packages")
      and replicatedStorage.Packages:FindFirstChild("_Index")

    if not index44 then
      return nil
    end

    for index45, value52 in ipairs(index44:GetChildren()) do
      if string.find(value52.Name, "sleitnick_comm") then
        return require(value52:FindFirstChild("comm", true))
      end
    end

    return nil
  end)

  if not v182 or not v183 then
    return nil
  end

  local v184, v185 = pcall(function()
    return v183.ClientComm.new(replicatedStorage, false, "Contracts"):BuildObject()
  end)

  if v184 and v185 then
    v12.Cache.ContractsComm = v185
    return v185
  end

  return nil
end

local function f40()
  local v186 = f30(3)

  if v186 and v186.Contracts and type(v186.Contracts.Slots) == "table"
    and next(v186.Contracts.Slots) then
    return v186.Contracts.Slots
  end

  local v187 = f39()

  if v187 and v187.GetBoard then
    local v188, v189 = pcall(function() return v187:GetBoard() end)

    if v188 and type(v189) == "table" then
      return v189.Contracts and type(v189.Contracts.Slots) == "table" and v189.Contracts.Slots
        or type(v189.Slots) == "table" and v189.Slots or v189
    end
  end

  return nil
end

local function f41()
  if v12.Cache.CompostCooldownClient then
    return v12.Cache.CompostCooldownClient
  end

  local starterPlayer4 = game:GetService("StarterPlayer")
  local starterPlayerScripts4 = starterPlayer4:FindFirstChild("StarterPlayerScripts")

  local clientLoader3 = starterPlayerScripts4
    and starterPlayerScripts4:FindFirstChild("ClientLoader")

  local handlers3 = clientLoader3 and clientLoader3:FindFirstChild("Handlers")
  local compostCooldownClient = handlers3 and handlers3:FindFirstChild("CompostCooldownClient")

  if compostCooldownClient then
    local v190, v191 = pcall(require, compostCooldownClient)

    if v190 then
      v12.Cache.CompostCooldownClient = v191
      return v191
    end
  end

  return nil
end

local function f42(p72)
  local v192 = f29()

  if not v192 then
    local v193 = f41()

    if v193 and v193.GetRemaining then
      return v193.GetRemaining(p72)
    end

    local v194 = v12.Data.CompostCooldownEndsAt[p72] or 0
    return math.max(0, v194 - workspace:GetServerTimeNow())
  end

  local composter = v192.Composter and v192.Composter[tostring(p72)]

  if composter then
    if composter.CooldownEndsAt then
      return math.max(0, math.floor(composter.CooldownEndsAt - workspace:GetServerTimeNow()))
    end

    return 0
  end

  return 0
end

local function f43(p73)
  local v195 = GetMyPlot()

  if not v195 then
    return nil
  end

  if p73 == 1 then
    return v195:FindFirstChild("FarmPlot")
  else
    local v196 = v14.FLOOR_NAMES[p73]

    if v196 then
      local findFirstChild10 = v195:FindFirstChild(v196)

      if findFirstChild10 then
        return findFirstChild10:FindFirstChild("FarmPlot")
      end
    end
  end

  return nil
end

local function f44(p74)
  if not p74 then
    return {}
  end

  local v197 = os.clock()

  if v12.Cache.DirtNodes[p74] and v197 - (v12.Cache.DirtNodesTime[p74] or 0) < 3 then
    return v12.Cache.DirtNodes[p74]
  end

  local v198 = {}

  for index46, value53 in ipairs(p74:GetChildren()) do
    if string.match(value53.Name, "^Plot%d+$") then
      local dirt = value53:FindFirstChild("Dirt")

      if dirt then
        table.insert(v198, dirt)
      end
    end
  end

  v12.Cache.DirtNodes[p74] = v198
  v12.Cache.DirtNodesTime[p74] = v197

  return v198
end

local function f45(p75)
  local v199 = string.split(p75.Path, "/")
  local v200

  if v199[1] == "MyPlot" then
    v200 = GetMyPlot()
    table.remove(v199, 1)
  else
    v200 = workspace
  end

  for index47, value54 in ipairs(v199) do
    v200 = v200 and v200:FindFirstChild(value54)
  end

  if not v200 then
    return nil
  end

  return (v200:IsA("BasePart") and v200.CFrame or v200:GetPivot())
    + (p75.Offset or Vector3.zero)
end

local function f46()
  local coreGui = game:GetService("CoreGui")
  local userInputService = game:GetService("UserInputService")

  for index48, value55 in ipairs({
    "LamduckFloatingTP", "LamduckTeleportGui", "LamduckUtilitiesFloatingGui",
  }) do
    local findFirstChild11 = coreGui:FindFirstChild(value55)

    if findFirstChild11 then
      findFirstChild11:Destroy()
    end
  end

  local lamduckFloatingTP = Instance.new("ScreenGui")
  lamduckFloatingTP.Name = "LamduckFloatingTP"
  lamduckFloatingTP.ResetOnSpawn = false
  lamduckFloatingTP.Enabled = false

  pcall(function() lamduckFloatingTP.Parent = gethui and gethui() or coreGui end)

  if not lamduckFloatingTP.Parent then
    lamduckFloatingTP.Parent = localPlayer:WaitForChild("PlayerGui")
  end

  local udim = UDim2.new(0.85, 0, 0.2, 0)

  local textButton = Instance.new("TextButton")
  textButton.Size = UDim2.new(0, 48, 0, 32)
  textButton.Position = udim
  textButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
  textButton.Text = "TP"
  textButton.Font = Enum.Font.GothamBold
  textButton.TextSize = 14
  textButton.Parent = lamduckFloatingTP

  Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)

  local frame = Instance.new("Frame")
  frame.Position = UDim2.new(0, 54, 0, 0)
  frame.Size = UDim2.new(0, 140, 0, 0)
  frame.AutomaticSize = Enum.AutomaticSize.Y
  frame.BackgroundTransparency = 1
  frame.Visible = false
  frame.Parent = textButton

  local instance = Instance.new("UIListLayout", frame)
  instance.Padding = UDim.new(0, 4)
  instance.SortOrder = Enum.SortOrder.LayoutOrder

  for index49, value56 in ipairs(v14.TELEPORT_DESTINATIONS) do
    local textButton2 = Instance.new("TextButton")
    textButton2.Size = UDim2.new(1, 0, 0, 32)
    textButton2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    textButton2.TextColor3 = Color3.fromRGB(200, 200, 200)
    textButton2.Text = value56.Label
    textButton2.Font = Enum.Font.GothamSemibold
    textButton2.TextSize = 13
    textButton2.LayoutOrder = index49
    textButton2.Parent = frame

    Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 6)

    textButton2.MouseButton1Click:Connect(function()
      frame.Visible = false

      pcall(function()
        local v201 = f45(value56)

        if v201 then
          local humanoidRootPart = localPlayer.Character
            and localPlayer.Character:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart then
            humanoidRootPart.CFrame = v201
          end
        end
      end)
    end)
  end

  local v202, position, position2 = false, nil, nil

  textButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
      or input.UserInputType == Enum.UserInputType.Touch then
      v202 = true
      position = input.Position
      position2 = textButton.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
          v202 = false
        end
      end)
    end
  end)

  local v203 = nil

  textButton.InputChanged:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseMovement
      or input2.UserInputType == Enum.UserInputType.Touch then
      v203 = input2
    end
  end)

  if v12.Connections.FloatingTPUISConn then
    v12.Connections.FloatingTPUISConn:Disconnect()
    v12.Connections.FloatingTPUISConn = nil
  end

  v12.Connections.FloatingTPUISConn = userInputService.InputChanged:Connect(function(input3)
    if input3 == v203 and v202 and position then
      local v204 = input3.Position - position

      textButton.Position = UDim2.new(
        position2.X.Scale, position2.X.Offset + v204.X, position2.Y.Scale,
        position2.Y.Offset + v204.Y
      )
    end
  end)

  local v205 = nil

  textButton.InputBegan:Connect(function(input4)
    if input4.UserInputType == Enum.UserInputType.MouseButton1
      or input4.UserInputType == Enum.UserInputType.Touch then
      v205 = tick()
    end
  end)

  textButton.InputEnded:Connect(function(input5)
    if (input5.UserInputType == Enum.UserInputType.MouseButton1
        or input5.UserInputType == Enum.UserInputType.Touch)
      and v205
      and tick() - v205 < 0.2 then
      frame.Visible = not frame.Visible
    end
  end)

  v12.Cache.FloatingTPGui = lamduckFloatingTP
  return lamduckFloatingTP
end

local function f47()
  if v12.Flags.IsSellCratesLoopRunning then
    return
  end

  v12.Flags.IsSellCratesLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoSellCrates.Value do
      pcall(function()
        if replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("SellCrates") then
          replicatedStorage.Remotes.SellCrates:FireServer()
        end
      end)

      task.wait(8)
    end

    v12.Flags.IsSellCratesLoopRunning = false
  end)
end

local function f48()
  if v12.Flags.IsExpandFarmPlotLoopRunning then
    return
  end

  v12.Flags.IsExpandFarmPlotLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoExpandFarmPlot.Value do
      pcall(function()
        local v206 = GetMyPlot()
        local upgradeFarm = replicatedStorage.Remotes.UpgradeFarm

        if v206 and upgradeFarm then
          local v207, v208 = pcall(function()
            return v206.ExpandSign.Screen.SurfaceGui.Expand.Btn.Txt
          end)

          if v207 and v208 then
            local contentText3 = v208.ContentText or v208.Text or ""

            if contentText3 ~= "" and not string.find(string.upper(contentText3), "MAX") then
              if CanAffordPurchase((f2(contentText3))) then
                upgradeFarm:InvokeServer()
              end
            end
          end
        end
      end)

      task.wait(10)
    end

    v12.Flags.IsExpandFarmPlotLoopRunning = false
  end)
end

local function f49()
  if v12.Flags.IsBuyGearsLoopRunning then
    return
  end

  if not v7.Options.Toggle_AutoBuySelectedGears.Value then
    return
  end

  v12.Flags.IsBuyGearsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoBuySelectedGears.Value do
      pcall(function()
        if v7.Unloaded then
          return
        end

        local transaction = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("Gear")
          and replicatedStorage.Remotes.Gear:FindFirstChild("Transaction")

        if not transaction then
          return
        end

        local findFirstChild12 = replicatedStorage:FindFirstChild("GearStocks")
          and replicatedStorage.GearStocks:FindFirstChild(localPlayer.Name)

        if not findFirstChild12 then
          return
        end

        local v209 = {}
        local value57 = v7.Options.Dropdown_TargetBuyGears.Value

        if type(value57) == "table" then
          for key13, value58 in pairs(value57) do
            if value58 == true then
              table.insert(v209, key13)
            end
          end
        end

        for index50, value59 in ipairs(v209) do
          if v7.Unloaded or not v7.Options.Toggle_AutoBuySelectedGears.Value then
            break
          end

          local findFirstChild13 = findFirstChild12:FindFirstChild(value59)

          if (findFirstChild13 and tonumber(findFirstChild13.Value) or 0) > 0 then
            if CanAffordPurchase(v12.Data.GearCosts[value59] or 0) then
              pcall(function() transaction:InvokeServer(value59) end)
              task.wait(0.1)
            end
          end
        end
      end)

      task.wait(0.5)
    end

    v12.Flags.IsBuyGearsLoopRunning = false
  end)
end

local function f50()
  if v12.Flags.IsEggShopBuyLoopRunning then
    return
  end

  if not v7.Options.Toggle_AutoBuySelectedEggs.Value then
    return
  end

  v12.Flags.IsEggShopBuyLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoBuySelectedEggs.Value do
      pcall(function()
        local petMerchant = workspace:FindFirstChild("PetMerchant")

        local transaction2 = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("EggShop")
          and replicatedStorage.Remotes.EggShop:FindFirstChild("Transaction")

        local rollEgg = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("RollEgg")

        if petMerchant and transaction2 and rollEgg then
          local value60 = v7.Options.Dropdown_TargetEggShopEggs.Value

          if type(value60) == "table" and next(value60) ~= nil then
            for i = 1, 5 do
              if not v7.Options.Toggle_AutoBuySelectedEggs.Value then
                break
              end

              local findFirstChild14 = petMerchant:FindFirstChild("Podium" .. i .. "Stock")
                or petMerchant:FindFirstChild("Podium" .. i)

              local findFirstChild15 = findFirstChild14
                and findFirstChild14:FindFirstChild("EggLabel", true)

              local text = findFirstChild15 and findFirstChild15.Text

              if text and text ~= "" then
                local v210 = nil
                local v211 = string.gsub(string.lower(text), " ", "")

                for index51, value61 in ipairs(v12.Data.EggNames) do
                  local v212 = string.gsub(string.lower(value61), " ", "")

                  if string.find(v211, v212, 1, true) then
                    v210 = value61
                    break
                  end
                end

                if not v210 then
                  v210 = string.gsub(text, " ", "")
                end

                if value60[v210] then
                  if CanAffordPurchase(v12.Data.EggPrices[v210] or 0) then
                    if pcall(function() transaction2:InvokeServer("BuyEgg", i) end) then
                      pcall(function() rollEgg:FireServer(v210) end)
                      task.wait(0.1)
                      pcall(function() rollEgg:FireServer(v210, "ClaimRolledPet") end)
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

    v12.Flags.IsEggShopBuyLoopRunning = false
  end)
end

local function f51()
  if v12.Flags.IsAutoBuyNightMarketRunning then
    return
  end

  if not (v7.Options.Toggle_AutoBuyNightMarket and v7.Options.Toggle_AutoBuyNightMarket.Value) then
    return
  end

  v12.Flags.IsAutoBuyNightMarketRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoBuyNightMarket
      and v7.Options.Toggle_AutoBuyNightMarket.Value do
      pcall(function()
        local v213 = GetNightMarketConfig()

        if v213 and type(v213.IsOpen) == "function" and not v213.IsOpen() then
          return
        end

        local value62 = v7.Options.Dropdown_TargetNightMarketItems
            and v7.Options.Dropdown_TargetNightMarketItems.Value
          or {}

        if type(value62) ~= "table" or next(value62) == nil then
          return
        end

        local v214 = f35()
        local v215 = f36()
        local items = v213 and v213.Items or {}
        local v216 = false

        for index52, value63 in ipairs(items) do
          if not (v7.Options.Toggle_AutoBuyNightMarket and v7.Options.Toggle_AutoBuyNightMarket.Value) then
            break
          end

          if value62[value63.DisplayName or value63.Id] or value62[value63.Id] then
            local v217 = v215[value63.Id] or 0
            local v218 = tonumber(value63.Cost) or 0

            while v217 > 0 and v214 >= v218 and v7.Options.Toggle_AutoBuyNightMarket
              and v7.Options.Toggle_AutoBuyNightMarket.Value do
              local v219, v220 = f37(value63.Id)

              if v219 and (type(v220) ~= "table" or v220.ok ~= false) then
                v216 = true
                v217 = v217 - 1
                v215[value63.Id] = v217
                v214 = math.max(0, v214 - v218)
                v12.Cache.ReplicatorSnapshotTime = 0
                task.wait(0.5)
              else
                break
              end
            end
          end
        end

        if not v216 then
          task.wait(5)
        else
          task.wait(1)
        end
      end)

      task.wait(2)
    end

    v12.Flags.IsAutoBuyNightMarketRunning = false
  end)
end

local function f52()
  if v12.Flags.IsUnlockEggSlotsLoopRunning then
    return
  end

  if not v7.Options.Toggle_AutoUnlockEggSlots.Value then
    return
  end

  v12.Flags.IsUnlockEggSlotsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoUnlockEggSlots.Value do
      pcall(function()
        local transaction3 = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("EggShop")
          and replicatedStorage.Remotes.EggShop:FindFirstChild("Transaction")

        if transaction3 then
          for index53, value64 in ipairs(v12.Data.EggSlotPrices) do
            if not v7.Options.Toggle_AutoUnlockEggSlots.Value then
              break
            end

            local eggSlotNumber = value64.EggSlotNumber

            if not v12.Data.SessionUnlockedEggSlots[eggSlotNumber]
              and CanAffordPurchase(value64.UnlockPrice) then
              task.spawn(function()
                if pcall(function()
                  return transaction3:InvokeServer("UnlockSlot", eggSlotNumber)
                end) then
                  v12.Data.SessionUnlockedEggSlots[eggSlotNumber] = true
                  task.wait(1.5)
                end
              end)
            end
          end
        end
      end)

      task.wait(10)
    end

    v12.Flags.IsUnlockEggSlotsLoopRunning = false
  end)
end

local function f53()
  if v12.Flags.IsAutoFeedPetsLoopRunning then
    return
  end

  if not v7.Options.Toggle_AutoFeedPets.Value then
    return
  end

  v12.Flags.IsAutoFeedPetsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoFeedPets.Value do
      pcall(function()
        local usePetTreat = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("UsePetTreat")

        local humanoid3 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("Humanoid")

        local value65 = v7.Options.Dropdown_PetTreatTypes.Value

        if usePetTreat and humanoid3 and type(value65) == "table" and next(value65) ~= nil then
          local v221 = f12()
          local v222 = false

          for index54, value66 in ipairs(v221) do
            if not v7.Options.Toggle_AutoFeedPets.Value then
              break
            end

            if not value66.petBoosted then
              for key14, value67 in pairs(value65) do
                if value67 then
                  local v223 = f13(key14)

                  if v223 then
                    if not v222 then
                      humanoid3:EquipTool(v223)
                      task.wait(0.2)
                      v222 = true
                    end

                    pcall(function() usePetTreat:FireServer(value66.instance) end)
                    task.wait(0.2)
                    break
                  end
                end
              end
            end
          end

          if v222 then
            pcall(function() humanoid3:UnequipTools() end)
          end
        end
      end)

      task.wait(2)
    end

    v12.Flags.IsAutoFeedPetsLoopRunning = false
  end)
end

local function f54()
  if v12.Flags.IsAutoUpgradePetsLoopRunning then
    return
  end

  if not v7.Options.Toggle_AutoUpgradePets.Value then
    return
  end

  v12.Flags.IsAutoUpgradePetsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoUpgradePets.Value do
      pcall(function()
        local upgradePet = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("Pets")
          and replicatedStorage.Remotes.Pets:FindFirstChild("UpgradePet")

        if upgradePet then
          local v224 = f12()
          local v225 = tonumber(v7.Options.Input_PetUpgradeLevel.Value) or 10
          local v226 = GetSharedUtils()

          for index55, value68 in ipairs(v224) do
            local v227 = false

            repeat
              if not v7.Options.Toggle_AutoUpgradePets.Value then
                break
              end

              if value68.petName == "Plant Rush Golem" or string.find(value68.petName, "Golem") then
                v227 = true
                break
              end

              if value68.level < v225 then
                local calculatePetUpgradePrice = v226 and v226.CalculatePetUpgradePrice and v226.CalculatePetUpgradePrice(
                  value68.petName, value68.level
                )

                if calculatePetUpgradePrice and not CanAffordPurchase(calculatePetUpgradePrice) then
                  v227 = true
                  break
                end

                pcall(function()
                  if upgradePet:IsA("RemoteFunction") then
                    upgradePet:InvokeServer(value68.petKey)
                  elseif upgradePet:IsA("RemoteEvent") then
                    upgradePet:FireServer(value68.petKey)
                  end
                end)

                task.wait(0.1)
              end

              v227 = true
            until true

            if not v227 then
              break
            end
          end
        end
      end)

      task.wait(2)
    end

    v12.Flags.IsAutoUpgradePetsLoopRunning = false
  end)
end

local function f55()
  if v12.Flags.IsAutoSellPetsLoopRunning then
    return
  end

  v12.Flags.IsAutoSellPetsLoopRunning = true

  local function f56()
    local v228 = {}
    local v229 = {}

    local function f57(p76)
      if not p76 then
        return
      end

      for index56, value69 in ipairs(p76:GetChildren()) do
        if value69:IsA("Tool") then
          local v230 = f11(value69)

          if v230 and v230.petKey and not v229[v230.petKey] then
            v229[v230.petKey] = true
            table.insert(v228, v230)
          end
        end
      end
    end

    f57(localPlayer.Character)
    f57(localPlayer:FindFirstChild("Backpack"))

    return v228
  end

  task.spawn(function()
    while not v7.Unloaded
      and (v7.Options.Toggle_PetSellFilterName.Value
        or v7.Options.Toggle_PetSellFilterRarity.Value
        or v7.Options.Toggle_PetSellFilterSize.Value) do
      pcall(function()
        local sellPet = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("SellPet")

        if not sellPet then
          return
        end

        local v231 = f56()

        if #v231 == 0 then
          return
        end

        local value70 = v7.Options.Dropdown_PetSellSelection.Value
        local value71 = v7.Options.Dropdown_PetSellRarities.Value
        local value72 = v7.Options.Dropdown_PetSellSizes.Value
        local value73 = v7.Options.Toggle_PetSellFilterName.Value
        local value74 = v7.Options.Toggle_PetSellFilterRarity.Value
        local value75 = v7.Options.Toggle_PetSellFilterSize.Value

        if value73 and (type(value70) ~= "table" or next(value70) == nil)
          or value74 and (type(value71) ~= "table" or next(value71) == nil)
          or value75 and (type(value72) ~= "table" or next(value72) == nil)
          or not value73 and not value74 and not value75 then
          return
        end

        for index57, value76 in ipairs(v231) do
          local v232 = false

          repeat
            if not (v7.Options.Toggle_PetSellFilterName.Value
              or v7.Options.Toggle_PetSellFilterRarity.Value
              or v7.Options.Toggle_PetSellFilterSize.Value) then
              break
            end

            if not value76.petKey then
              v232 = true
              break
            end

            local v233 = false

            if value73 and value76.petName then
              local v234 = string.lower(value76.petName)

              for key15, value77 in pairs(value70) do
                if value77 and string.find(v234, string.lower(key15), 1, true) then
                  v233 = true
                  break
                end
              end
            elseif value74 then
              local v235 = f7(value76.petName)

              if v235 and value71[v235] then
                v233 = true
              end
            elseif value75 then
              if value72[tostring(value76.petSize or "")] then
                v233 = true
              end
            end

            if v233 then
              pcall(function()
                if sellPet:IsA("RemoteEvent") then
                  sellPet:FireServer(value76.petKey)
                else
                  task.spawn(function() sellPet:InvokeServer(value76.petKey) end)
                end
              end)

              task.wait(0.1)
            end

            v232 = true
          until true

          if not v232 then
            break
          end
        end
      end)

      task.wait(5)
    end

    v12.Flags.IsAutoSellPetsLoopRunning = false
  end)
end

local function f58()
  task.spawn(function()
    while not v7.Unloaded do
      pcall(function()
        if v12.Paragraph.PetInfo then
          local v236 = f12()

          if #v236 == 0 then
            v12.Paragraph.PetInfo:SetContent("No active pets on plot.")
          else
            local v237 = {}

            for index58, value78 in ipairs(v236) do
              local petBoosted2 = value78.petBoosted and "🔥" or "❄️"
              local v238 = string.format("[<font color='#00E5FF'>Lv.%d</font>]", value78.level)

              local v239 = string.format(
                "[<font color='#FF5252'>x%s</font>]", tostring(value78.earnings)
              )

              local v240 = value78.petSize and value78.petSize ~= ""
                  and string.format("[<font color='#FFFF00'>%s</font>] ", value78.petSize)
                or ""

              table.insert(v237, string.format(
                "%s %s %s %s%s", petBoosted2, v238, v239, v240, value78.petName
              ))
            end

            v12.Paragraph.PetInfo:SetContent(table.concat(v237, "\n"))
          end
        end
      end)

      task.wait(5)
    end
  end)
end

function PetTeamsEnsureFolder()
  if isfolder and makefolder then
    pcall(function()
      if not isfolder("Lamduck") then
        makefolder("Lamduck")
      end
    end)
  end
end

function PetTeamsLoadTeams()
  PetTeamsEnsureFolder()

  if isfile and isfile("Lamduck/BuildARingFarm_PetTeams.json") and readfile then
    local v241, v242 = pcall(readfile, "Lamduck/BuildARingFarm_PetTeams.json")

    if v241 and type(v242) == "string" and v242 ~= "" then
      local httpService = game:GetService("HttpService")
      local v243, v244 = pcall(function() return httpService:JSONDecode(v242) end)

      if v243 and type(v244) == "table" then
        return v244
      end
    end
  end

  return {}
end

function PetTeamsSaveTeams(p77)
  PetTeamsEnsureFolder()

  if writefile then
    local httpService2 = game:GetService("HttpService")
    local v245, v246 = pcall(function() return httpService2:JSONEncode(p77) end)

    if v245 and type(v246) == "string" then
      pcall(writefile, "Lamduck/BuildARingFarm_PetTeams.json", v246)
    end
  end
end

function PetTeamsGetNamesList(p78)
  local v247 = {}

  for key16 in pairs(p78) do
    table.insert(v247, key16)
  end

  table.sort(v247, function(p79, p80)
    local v248 = tonumber(string.match(p79, "%d+"))
    local v249 = tonumber(string.match(p80, "%d+"))

    if v248 and v249 and v248 ~= v249 then
      return v248 < v249
    end

    return p79 < p80
  end)

  return v247
end

function PetTeamsGetNextName(p81)
  local v250 = 1

  while p81["Team " .. v250] ~= nil do
    v250 = v250 + 1
  end

  return "Team " .. v250
end

function PetTeamsGetCurrentEquipped()
  local v251 = {}

  local v252, v253 = pcall(function()
    local v254 = require(replicatedStorage.Packages.DataReplicator).GetReplicator()
    return v254 and v254:GetSnapshot()
  end)

  local equippedPets = v252 and v253 and v253.EquippedPets
  local petInventory = v252 and v253 and v253.PetInventory

  if type(equippedPets) == "table" and next(equippedPets) ~= nil then
    for key17, value79 in pairs(equippedPets) do
      if value79 and value79 ~= "" then
        local v255 = petInventory and petInventory[value79]

        v251[tostring(key17)] = {
          PetKey = value79,
          Name = v255 and (v255.Name or v255.PetName) or string.split(value79, "_")[1]
            or "Unknown",
          Level = v255 and v255.Level or 1,
          Size = v255 and v255.Size or "Normal",
        }
      end
    end
  else
    for index59, value80 in ipairs((f12())) do
      if value80.petKey and value80.slotIndex then
        v251[tostring(value80.slotIndex)] = {
          PetKey = value80.petKey,
          Name = value80.petName or "Unknown",
          Level = value80.level or 1,
          Size = value80.petSize or "Normal",
        }
      end
    end
  end

  return v251
end

function PetTeamsUnequipAll()
  local farmManagementService = require(replicatedStorage.Packages.Knit).GetService("FarmManagementService")

  local unequipPet = replicatedStorage:FindFirstChild("Remotes")
    and replicatedStorage.Remotes:FindFirstChild("Pets")
    and replicatedStorage.Remotes.Pets:FindFirstChild("UnequipPet")

  for key18, value81 in pairs((PetTeamsGetCurrentEquipped())) do
    if value81.PetKey and value81.PetKey ~= "" then
      local v256, v257 = pcall(function()
        return farmManagementService:UnequipPet(value81.PetKey)
      end)

      if (not v256 or not v257) and unequipPet then
        pcall(function() unequipPet:FireServer(value81.PetKey) end)
      end

      task.wait(0.15)
    end
  end
end

function PetTeamsEquipTeam(p82)
  if type(p82) ~= "table" then
    return
  end

  PetTeamsUnequipAll()
  task.wait(0.2)
  local farmManagementService2 = require(replicatedStorage.Packages.Knit).GetService("FarmManagementService")

  local equipPet = replicatedStorage:FindFirstChild("Remotes")
    and replicatedStorage.Remotes:FindFirstChild("Pets")
    and replicatedStorage.Remotes.Pets:FindFirstChild("EquipPet")

  for key19, value82 in pairs(p82) do
    local v258 = tonumber(key19)
    local petKey4 = value82.PetKey

    if v258 and petKey4 and petKey4 ~= "" then
      local v259, v260 = pcall(function()
        return farmManagementService2:EquipPetToSlot(petKey4, v258)
      end)

      if (not v259 or not v260) and equipPet then
        pcall(function() equipPet:FireServer(petKey4, v258) end)
      end

      task.wait(0.2)
    end
  end
end

function PetTeamsSaveCurrent(p83, p84, p85)
  local v261 = PetTeamsLoadTeams()
  local value83 = type(p83) == "table" and p83.Value or type(p83) == "string" and p83 or ""
  local v262 = string.match(value83 or "", "^%s*(.-)%s*$")

  if not v262 or v262 == "" then
    v262 = PetTeamsGetNextName(v261)
  end

  local v263 = PetTeamsGetCurrentEquipped()

  if next(v263) == nil then
    pcall(function()
      v7:Notify({
        Title = "Pet Teams",
        Content = "No pets are currently equipped on plot.",
        Duration = 3,
      })
    end)

    return
  end

  local function f59()
    v261[v262] = v263
    PetTeamsSaveTeams(v261)
    p84:SetValues((PetTeamsGetNamesList(v261)))

    if type(p83) == "table" and type(p83.SetValue) == "function" then
      pcall(function() p83:SetValue("") end)
    end

    pcall(function()
      v7:Notify({ Title = "Pet Teams", Content = "Saved team: " .. v262, Duration = 3 })
    end)
  end

  if v261[v262] ~= nil then
    p85:Dialog({
      Title = "Confirm Override",
      Content = string.format(
        "Team %q already exists. Are you sure you want to overwrite it?", v262
      ),
      Buttons = { { Title = "Confirm", Callback = f59 }, { Title = "Cancel" } },
    })
  else
    f59()
  end
end

function PetTeamsEquipSelected(p86)
  if not p86 or p86 == "" then
    pcall(function()
      v7:Notify({
        Title = "Pet Teams",
        Content = "Please select a team from the dropdown first.",
        Duration = 3,
      })
    end)

    return
  end

  local v264 = PetTeamsLoadTeams()[p86]

  if not v264 then
    pcall(function()
      v7:Notify({
        Title = "Pet Teams",
        Content = "Team " .. p86 .. " not found in saved file.",
        Duration = 3,
      })
    end)

    return
  end

  task.spawn(function()
    PetTeamsEquipTeam(v264)

    pcall(function()
      v7:Notify({ Title = "Pet Teams", Content = "Equipped team: " .. p86, Duration = 3 })
    end)
  end)
end

function PetTeamsDeleteSelected(p87, p88, p89)
  if not p87 or p87 == "" then
    return
  end

  if not PetTeamsLoadTeams()[p87] then
    return
  end

  p89:Dialog({
    Title = "Confirm Delete",
    Content = string.format("Are you sure you want to delete team %q?", p87),
    Buttons = {
      {
        Title = "Confirm",
        Callback = function()
          local v265 = PetTeamsLoadTeams()

          if v265[p87] then
            v265[p87] = nil
            PetTeamsSaveTeams(v265)

            if p88.Value == p87 then
              p88:SetValue(nil)
            end

            p88:SetValues((PetTeamsGetNamesList(v265)))

            pcall(function()
              v7:Notify({ Title = "Pet Teams", Content = "Deleted team: " .. p87, Duration = 3 })
            end)
          end
        end,
      },
      { Title = "Cancel" },
    },
  })
end

function PetTeamsUnequipAllAction()
  task.spawn(function()
    PetTeamsUnequipAll()

    pcall(function()
      v7:Notify({ Title = "Pet Teams", Content = "All pets unequipped.", Duration = 3 })
    end)
  end)
end

local function f60()
  task.spawn(function()
    while not v7.Unloaded do
      pcall(function()
        if v12.Paragraph.CompostInfo then
          local v266 = {}

          for j = 2, 5 do
            local v267 = f42(j)

            if type(v267) == "number" and v267 > 0 then
              local v268 = math.floor(v267 / 60)
              local v269 = v267 % 60

              table.insert(v266, string.format(
                "Floor %d:   ⏳   Recharging (%dm %ds left)", j, v268, v269
              ))
            else
              table.insert(v266, string.format("Floor %d:   ✅   Ready", j))
            end
          end

          table.insert(
            v266,
            "\nNote: On script first load, composting statuses might show incorrect ready times until a machine completes its current cooldown/compost cycle."
          )

          v12.Paragraph.CompostInfo:SetContent(table.concat(v266, "\n"))
        end
      end)

      task.wait(5)
    end
  end)
end

local function f61()
  if v12.Flags.IsSeedGachaLoopRunning then
    return
  end

  if not (v7.Options.Toggle_AutoGachaSelected.Value or v7.Options.Toggle_AutoGachaByRarity.Value) then
    return
  end

  v12.Flags.IsSeedGachaLoopRunning = true

  local function f62(p90)
    if not p90 or p90 == "" then
      return 0
    end

    for index60, value84 in ipairs(v12.Data.PlantRegistry) do
      if value84.Name == p90 then
        return tonumber(value84.Cost) or tonumber(value84.Price) or 0
      end
    end

    return 0
  end

  local function f63(p91)
    if v7.Options.Toggle_AutoGachaSelected.Value then
      local value85 = v7.Options.Dropdown_GachaSeeds.Value

      if type(value85) ~= "table" or next(value85) == nil then
        return false
      end

      return value85[p91] == true
    end

    if v7.Options.Toggle_AutoGachaByRarity.Value then
      local value86 = v7.Options.Dropdown_GachaRarities.Value

      if type(value86) ~= "table" or next(value86) == nil then
        return false
      end

      local v270 = f6(p91)
      return v270 ~= "Unknown" and value86[v270] == true
    end

    return false
  end

  task.spawn(function()
    while not v7.Unloaded
      and (v7.Options.Toggle_AutoGachaSelected.Value or v7.Options.Toggle_AutoGachaByRarity.Value) do
      local v271 = false

      repeat
        v12.Data.Gacha.RollReady = false
        v12.Data.Gacha.RollData = nil
        v12.Data.CurrentRollId = nil

        pcall(function() replicatedStorage.Remotes.RollSeeds:FireServer() end)
        local total = 0

        while not v12.Data.Gacha.RollReady and total < 3 do
          task.wait(0.1)
          total = total + 0.1
        end

        if not v12.Data.Gacha.RollReady then
          task.wait(0.5)
          v271 = true
          break
        end

        local rollData = v12.Data.Gacha.RollData

        if not rollData or not rollData.Slots or #rollData.Slots == 0 then
          task.wait(0.5)
          v271 = true
          break
        end

        local rollId = rollData.RollId
        task.wait(0.1)
        pcall(function() replicatedStorage.Remotes.RollAnimationDone:FireServer(rollId) end)
        local v272 = false

        repeat
          local v273 = false
          local v274 = false

          for index61, value87 in ipairs(rollData.Slots) do
            if f63(value87.Seed) then
              v274 = true

              if not CanAffordPurchase((f62(value87.Seed))) then
                v273 = true
              end
            end
          end

          if v7.Options.Toggle_PauseIfNotEnoughMoney.Value and v273 and v274 then
            if not (v7.Options.Toggle_AutoGachaSelected.Value
              or v7.Options.Toggle_AutoGachaByRarity.Value) then
              break
            end

            if not v272 then
              if v7.Options.Toggle_ShowGachaNotifications.Value then
                v7:Notify({
                  Title = "Gacha Seed",
                  Content = "Not enough cash — waiting...",
                  Duration = 5,
                })
              end

              v272 = true
            end

            task.wait(1)
          end
        until not (v7.Options.Toggle_PauseIfNotEnoughMoney.Value and v273)

        local count2 = 0

        for index62, value88 in ipairs(rollData.Slots) do
          if not (v7.Options.Toggle_AutoGachaSelected.Value
            or v7.Options.Toggle_AutoGachaByRarity.Value) then
            break
          end

          if f63(value88.Seed) then
            local v275 = f62(value88.Seed)

            if CanAffordPurchase(v275) then
              v12.Data.Gacha.BuyResults[index62] = nil
              pcall(function() replicatedStorage.Remotes.BuySeed:FireServer(index62, rollId) end)
              local total2 = 0

              while v12.Data.Gacha.BuyResults[index62] == nil and total2 < 2 do
                task.wait(0.1)
                total2 = total2 + 0.1
              end

              if v12.Data.Gacha.BuyResults[index62] then
                count2 = count2 + 1

                if v7.Options.Toggle_ShowGachaNotifications.Value then
                  v7:Notify({
                    Title = "Gacha Seed Bought",
                    Content = string.format(
                      "%s (%s) - %s cash", value88.Seed, f6(value88.Seed), f3(v275)
                    ),
                    Duration = 2,
                  })
                end
              end

              task.wait(0.5)
            end
          end
        end

        if count2 == 0 then
          task.wait(math.max(v7.Options.Input_GachaRollDelay.Value or 3, 3))
        end

        v271 = true
      until true

      if not v271 then
        break
      end
    end

    v12.Flags.IsSeedGachaLoopRunning = false
  end)
end

local function f64()
  if v12.Flags.IsAutoDiscardLoopRunning then
    return
  end

  if not v7.Options.Toggle_AutoDiscardByRarity.Value then
    return
  end

  v12.Flags.IsAutoDiscardLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoDiscardByRarity.Value do
      pcall(function()
        local discardSeed = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("DiscardSeed")

        local character = localPlayer.Character
        local humanoid4 = character and character:FindFirstChild("Humanoid")
        local backpack = localPlayer:FindFirstChild("Backpack")

        if discardSeed and character and humanoid4 and backpack then
          local function f65(p92)
            if not p92 or not p92:IsA("Tool")
              or p92:GetAttribute("InventoryCategory") ~= "Seeds" then
              return false, nil
            end

            if f38(p92) then
              return false, nil
            end

            local trueName2 = p92:GetAttribute("trueName") or p92:GetAttribute("Plant")

            if not trueName2 then
              return false, nil
            end

            local value89 = v7.Options.Dropdown_DiscardRarities.Value
            local v276 = f6(trueName2)

            if v276 and v276 ~= "Unknown" and type(value89) == "table" and value89[v276] then
              return true, trueName2
            end

            return false, trueName2
          end

          local tool = character:FindFirstChildWhichIsA("Tool")

          if tool then
            local v277, v278 = f65(tool)

            if not v277 then
              return
            end
          end

          local v279 = nil

          for index63, value90 in ipairs(backpack:GetChildren()) do
            local v280, v281 = f65(value90)

            if v280 then
              v279 = v281
              break
            end
          end

          if v279 then
            while not v7.Unloaded and v7.Options.Toggle_AutoDiscardByRarity.Value do
              local v282 = nil
              local tool2 = character:FindFirstChildWhichIsA("Tool")

              if tool2 then
                if (tool2:GetAttribute("trueName") or tool2:GetAttribute("Plant")) == v279 then
                  v282 = tool2
                else
                  break
                end
              else
                for index64, value91 in ipairs(backpack:GetChildren()) do
                  if value91:IsA("Tool")
                    and (value91:GetAttribute("trueName") or value91:GetAttribute("Plant"))
                      == v279 then
                    v282 = value91
                    break
                  end
                end
              end

              if not v282 then
                break
              end

              if v282.Parent ~= character then
                humanoid4:EquipTool(v282)
                task.wait(0.05)
              end

              local tool3 = character:FindFirstChildWhichIsA("Tool")

              if (tool3 and (tool3:GetAttribute("trueName") or tool3:GetAttribute("Plant")))
                == v279 then
                pcall(function() discardSeed:FireServer() end)
                task.wait(0.05)
              else
                break
              end
            end

            local tool4 = character:FindFirstChildWhichIsA("Tool")

            if (tool4 and (tool4:GetAttribute("trueName") or tool4:GetAttribute("Plant")))
              == v279 then
              pcall(function() humanoid4:UnequipTools() end)
            end
          end
        end
      end)

      task.wait(0.5)
    end

    v12.Flags.IsAutoDiscardLoopRunning = false
  end)
end

local function f66(p93)
  for index65, value92 in ipairs(v12.Data.CompostLevelNames) do
    if value92 == p93 then
      return index65
    end
  end

  return nil
end

local function f67(p94)
  local v283 = "_F" .. p94

  local value93 = v7.Options["Toggle_AutoCompostSelected" .. v283]
    and v7.Options["Toggle_AutoCompostSelected" .. v283].Value

  local value94 = v7.Options["Toggle_AutoCompostByRarity" .. v283]
    and v7.Options["Toggle_AutoCompostByRarity" .. v283].Value

  local v284 = value93 == true
  local v285 = value94 == true

  local value95 = v7.Options["Dropdown_CompostSeeds" .. v283]
      and v7.Options["Dropdown_CompostSeeds" .. v283].Value
    or {}

  local value96 = v7.Options["Dropdown_CompostRarities" .. v283]
      and v7.Options["Dropdown_CompostRarities" .. v283].Value
    or {}

  if v284 and next(value95) == nil then
    return nil
  end

  if v285 and next(value96) == nil then
    return nil
  end

  if not v284 and not v285 then
    return nil
  end

  for index66, value97 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value97 then
      for index67, value98 in ipairs(value97:GetChildren()) do
        if value98:IsA("Tool") and value98:GetAttribute("InventoryCategory") == "Seeds" then
          local plant = value98:GetAttribute("Plant") or value98:GetAttribute("trueName")

          if plant then
            local mutation = value98:GetAttribute("Mutation") or "Normal"
            local v286 = false

            if v284 and value95[plant] == true then
              v286 = true
            elseif v285 then
              local v287 = f6(plant)

              if v287 ~= "Unknown" and value96[v287] == true then
                v286 = true
              end
            end

            if v286 then
              return value98, plant, mutation
            end
          end
        end
      end
    end
  end

  return nil
end

local function f68(p95)
  local v288 = string.match(p95.Name, "%(x(%d+)%)")
  return v288 and tonumber(v288) or 1
end

local function f69(p96, p97, p98)
  local seedKey2 = p96:GetAttribute("seedKey")

  if seedKey2 then
    return seedKey2
  end

  local level2 = p96:GetAttribute("Level") or 1
  return tostring(p97) .. "_" .. tostring(level2) .. "_" .. tostring(p98)
end

local function f70(p99)
  local insertSeed = replicatedStorage:FindFirstChild("Remotes")
    and replicatedStorage.Remotes:FindFirstChild("Composter")
    and replicatedStorage.Remotes.Composter:FindFirstChild("InsertSeed")

  if not insertSeed then
    return nil
  end

  local v289, v290, v291 = f67(p99)

  if not v289 then
    return nil
  end

  local v292 = f68(v289)
  local v293 = f69(v289, v290, v291)
  local v294, v295 = pcall(function() return insertSeed:InvokeServer(p99, v293, v292) end)

  if v294 and type(v295) == "table" and v295.Success then
    return v295
  end

  return nil
end

local function f71()
  local v296 = 1

  pcall(function()
    local v297 = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("SkillTree"))
    local v298 = f29()

    v296 = v297.GetBoostFor(
      v298 and v298.SkillTree and v298.SkillTree.Nodes, "ComposterCooldownReduction"
    )
  end)

  return v296
end

local function f72()
  if v12.Flags.IsCompostLoopRunning then
    return
  end

  v12.Flags.IsCompostLoopRunning = true

  task.spawn(function()
    local pullLever = replicatedStorage:FindFirstChild("Remotes")
      and replicatedStorage.Remotes:FindFirstChild("Composter")
      and replicatedStorage.Remotes.Composter:FindFirstChild("PullLever")

    local v299 = false

    while not v7.Unloaded do
      local getServerTimeNow = workspace:GetServerTimeNow()

      for key20, value99 in pairs(v12.Data.CompostCooldownEndsAt) do
        if value99 <= getServerTimeNow then
          v12.Data.CompostCooldownEndsAt[key20] = nil
        end
      end

      local v300 = false

      for k = 2, 5 do
        local v301 = "_F" .. k

        if v7.Options["Toggle_AutoCompostSelected" .. v301]
            and v7.Options["Toggle_AutoCompostSelected" .. v301].Value
          or v7.Options["Toggle_AutoCompostByRarity" .. v301]
            and v7.Options["Toggle_AutoCompostByRarity" .. v301].Value then
          v300 = true
          local v302 = f42(k)

          if type(v302) == "number" and v302 <= 0 then
            local v303 = f70(k)

            if v303 then
              v299 = true

              local value100 = v7.Options["Dropdown_CompostPullLevel" .. v301]
                and v7.Options["Dropdown_CompostPullLevel" .. v301].Value

              local v304 = nil

              if value100 and value100 ~= "None" then
                v304 = f66(value100)
              end

              if v304 and v303.Tier then
                local v305 = f66(v303.Tier)

                if v305 and v305 >= v304 then
                  if pullLever then
                    local v306, v307 = pcall(function() return pullLever:InvokeServer(k) end)

                    if v306 and type(v307) == "table" and v307.Success then
                      local v308 = f41()

                      if v308 and v308.MarkLocal then
                        v308.MarkLocal(k)
                      else
                        local v309 = f71()
                        local compostCooldownDuration = v12.Data.CompostCooldownDuration or 300

                        v12.Data.CompostCooldownEndsAt[k] = workspace:GetServerTimeNow()
                          + compostCooldownDuration * v309
                      end

                      v7:Notify({
                        Title = "Compost Floor " .. tostring(k),
                        Content = "Pulled at tier " .. v303.Tier,
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

      if not v300 then
        break
      end

      if not v299 then
        task.wait(1)
      else
        task.wait(0.25)
      end

      v299 = false
    end

    v12.Flags.IsCompostLoopRunning = false
  end)
end

local function f73(p100)
  local v310 = f43(p100)

  if v310 then
    local count3 = 0

    while count3 < 5 do
      local v311 = false

      for index68, value101 in ipairs(v310:GetChildren()) do
        if string.match(value101.Name, "^Plot(%d+)$") then
          local dirt2 = value101:FindFirstChild("Dirt")

          if dirt2 and dirt2:GetAttribute("PlantLevel") ~= nil then
            v311 = true

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

      if not v311 then
        v7:Notify({
          Title = "Floor Manager",
          Content = "All plants on Floor " .. tostring(p100) .. " have been removed.",
          Duration = 3,
        })

        break
      end

      count3 = count3 + 1
      task.wait(1)
    end
  end
end

local function f74()
  if v12.Flags.IsAutoPlantLoopRunning then
    return
  end

  v12.Flags.IsAutoPlantLoopRunning = true

  local function f75(p101)
    local character2 = localPlayer.Character
    local humanoid5 = character2 and character2:FindFirstChild("Humanoid")

    if not character2 or not humanoid5 then
      return nil
    end

    local tool5 = character2:FindFirstChildWhichIsA("Tool")

    if tool5 and tool5:GetAttribute("InventoryCategory") == "Seeds"
      and tool5:GetAttribute("trueName") == p101 then
      return tool5
    end

    if tool5 then
      pcall(function() humanoid5:UnequipTools() end)
      task.wait(0.1)
    end

    if localPlayer:FindFirstChild("Backpack") then
      for key21, value102 in pairs(localPlayer.Backpack:GetChildren()) do
        if value102:IsA("Tool") and value102:GetAttribute("InventoryCategory") == "Seeds"
          and value102:GetAttribute("trueName") == p101 then
          pcall(function() humanoid5:EquipTool(value102) end)
          task.wait(0.3)
          return value102
        end
      end
    end

    return nil
  end

  task.spawn(function()
    while not v7.Unloaded do
      local v312 = false

      for m = 1, 5 do
        local v313 = "_F" .. m

        local value103 = v7.Options["Toggle_AutoPlantBest" .. v313]
          and v7.Options["Toggle_AutoPlantBest" .. v313].Value

        local value104 = v7.Options["Toggle_AutoPlantSelected" .. v313]
          and v7.Options["Toggle_AutoPlantSelected" .. v313].Value

        local value105 = v7.Options["Toggle_AutoPlantRarity" .. v313]
          and v7.Options["Toggle_AutoPlantRarity" .. v313].Value

        if value103 or value104 or value105 then
          v312 = true
          local v314 = f43(m)

          if v314 then
            local v315 = {}

            for index69, value106 in ipairs(v314:GetChildren()) do
              if string.match(value106.Name, "^Plot(%d+)$") then
                local dirt3 = value106:FindFirstChild("Dirt")

                if dirt3 and dirt3:GetAttribute("PlantLevel") == nil then
                  table.insert(v315, dirt3)
                end
              end
            end

            if #v315 > 0 then
              local function f76()
                local character3, backpack2 = localPlayer.Character, localPlayer:FindFirstChild("Backpack")
                local v316 = { character3, backpack2 }
                local v317 = {}

                local value107 = v7.Options["Dropdown_AutoPlantSeeds" .. v313]
                    and v7.Options["Dropdown_AutoPlantSeeds" .. v313].Value
                  or {}

                local value108 = v7.Options["Dropdown_AutoPlantRarities" .. v313]
                    and v7.Options["Dropdown_AutoPlantRarities" .. v313].Value
                  or {}

                for index70, value109 in ipairs(v316) do
                  if value109 then
                    for index71, value110 in ipairs(value109:GetChildren()) do
                      if value110:IsA("Tool")
                        and value110:GetAttribute("InventoryCategory") == "Seeds" then
                        local trueName3 = value110:GetAttribute("trueName")

                        if trueName3 then
                          if value103 then
                            local price = 0

                            for index72, value111 in ipairs(v12.Data.PlantRegistry) do
                              if value111.Name == trueName3 then
                                price = value111.Price or 0
                                break
                              end
                            end

                            table.insert(v317, { TrueName = trueName3, Weight = price })
                          elseif value104 then
                            if value107[trueName3] == true then
                              table.insert(v317, { TrueName = trueName3, Weight = 1 })
                            end
                          elseif value105 then
                            local v318 = f6(trueName3)

                            if v318 and v318 ~= "Unknown" and value108[v318] == true then
                              table.insert(v317, {
                                TrueName = trueName3,
                                Weight = v12.Data.RarityOrderMap[v318] or 0,
                              })
                            end
                          end
                        end
                      end
                    end
                  end
                end

                if #v317 > 0 then
                  table.sort(v317, function(p102, p103) return p102.Weight > p103.Weight end)
                  return v317[1].TrueName
                end

                return nil
              end

              local v319 = false

              for index73, value112 in ipairs(v315) do
                local value113 = v7.Options["Toggle_AutoPlantBest" .. v313]
                  and v7.Options["Toggle_AutoPlantBest" .. v313].Value

                local value114 = v7.Options["Toggle_AutoPlantSelected" .. v313]
                  and v7.Options["Toggle_AutoPlantSelected" .. v313].Value

                local value115 = v7.Options["Toggle_AutoPlantRarity" .. v313]
                  and v7.Options["Toggle_AutoPlantRarity" .. v313].Value

                if not (value113 or value114 or value115) then
                  break
                end

                if value112:GetAttribute("PlantLevel") == nil then
                  local v320 = f76()

                  if v320 then
                    if f75(v320) then
                      v319 = true

                      pcall(function()
                        replicatedStorage.Remotes.PlantSeed:FireServer(value112)
                      end)

                      task.wait(0.5)
                    end
                  else
                    break
                  end
                end
              end

              if v319 then
                local humanoid6 = localPlayer.Character
                  and localPlayer.Character:FindFirstChild("Humanoid")

                if humanoid6 then
                  pcall(function() humanoid6:UnequipTools() end)
                end

                task.wait(0.1)
              end
            end
          end

          task.wait(0.2)
        end
      end

      if not v312 then
        break
      end

      task.wait(5)
    end

    v12.Flags.IsAutoPlantLoopRunning = false
  end)
end

local function f77()
  local function f78(p104, p105)
    local v321 = {}
    local v322 = f43(p104)

    if not v322 then
      return v321
    end

    for index74, value116 in ipairs(v322:GetChildren()) do
      local v323 = string.match(value116.Name, "^Plot(%d+)$")

      if v323 then
        local plotIndex = tonumber(v323)
        local dirt4 = value116:FindFirstChild("Dirt")

        if dirt4 then
          table.insert(v321, {
            Instance = dirt4,
            Floor = p104,
            PlotName = value116.Name,
            PlotIndex = plotIndex,
            PlantFullyGrown = dirt4:GetAttribute("PlantFullyGrown") or false,
            PlantLevel = dirt4:GetAttribute("PlantLevel") or 0,
            PlantMaxStages = dirt4:GetAttribute("PlantMaxStages") or 0,
            PlantMutation = dirt4:GetAttribute("PlantMutation") or "Normal",
            PlantName = dirt4:GetAttribute("PlantName") or "",
            PlantStage = dirt4:GetAttribute("PlantStage") or 0,
            PlantTag = dirt4:GetAttribute("PlantTag") or "",
            PlotRing = dirt4:GetAttribute("PlotRing") or 0,
            Watered = dirt4:GetAttribute("Watered") or false,
            WaterTimeBonus = dirt4:GetAttribute("WaterTimeBonus") or 0,
            Fertilized = p105 and p105[dirt4] or false,
          })
        end
      end
    end

    return v321
  end

  task.spawn(function()
    while not v7.Unloaded do
      local v324 = {}
      local playerGui2 = localPlayer:FindFirstChildOfClass("PlayerGui")

      if playerGui2 then
        for index75, value117 in ipairs(playerGui2:GetChildren()) do
          if value117:IsA("BillboardGui") and value117.Name == "FertilizerBoost"
            and value117.Adornee then
            local adornee2 = value117.Adornee

            while adornee2 do
              if adornee2.Name == "Dirt" and adornee2:IsA("BasePart") then
                v324[adornee2] = true
                break
              end

              adornee2 = adornee2.Parent
            end
          end
        end
      end

      for n = 1, 5 do
        pcall(function()
          local v325 = v12.Paragraph.FloorPlants[n]

          if v325 then
            local v326 = ""

            for index76, value118 in ipairs((f78(n, v324))) do
              if value118.PlantName and value118.PlantName ~= "" then
                local v327 = "- " .. tostring(value118.PlantName)
                local v328 = {}

                if value118.PlantLevel ~= nil then
                  table.insert(
                    v328, string.format("Lvl %d", tonumber(value118.PlantLevel) or 0)
                  )
                end

                if value118.PlantMutation and tostring(value118.PlantMutation) ~= "" then
                  local v329 = tostring(value118.PlantMutation)
                  local v330 = string.lower(v329)

                  local v331 = (v330 == "normal" or v330 == "none")
                      and "<font color=\"#B0B0B0\">" .. v329 .. "</font>"
                    or "<font color=\"#FF5252\">" .. v329 .. "</font>"

                  table.insert(v328, v331)
                end

                if value118.Fertilized then
                  table.insert(v328, "<font color=\"#FFD740\">Fertilized</font>")
                end

                if #v328 > 0 then
                  v327 = v327 .. " | " .. table.concat(v328, " | ")
                end

                v326 = v326 .. v327 .. "\n"
              end
            end

            if v326 == "" then
              v326 = "No plants planted."
            end

            v325:SetContent(v326)
          end
        end)
      end

      task.wait(5)
    end
  end)
end

local function f79()
  if v12.Flags.IsUpgradePlantsLoopRunning then
    return
  end

  v12.Flags.IsUpgradePlantsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded do
      local v332 = false
      local v333 = GetSharedUtils()

      for i6 = 1, 5 do
        local v334 = "_F" .. i6

        if v7.Options["Toggle_AutoUpgradePlants" .. v334]
          and v7.Options["Toggle_AutoUpgradePlants" .. v334].Value then
          v332 = true
          local v335 = f43(i6)

          if v335 then
            local v336 = v7.Options["Input_MaxUpgradeLevel" .. v334]
                and tonumber(v7.Options["Input_MaxUpgradeLevel" .. v334].Value)
              or 100

            local value119 = v7.Options["Dropdown_UpgradePlantNames" .. v334]
                and v7.Options["Dropdown_UpgradePlantNames" .. v334].Value
              or {}

            if next(value119) ~= nil then
              for index77, value120 in ipairs((f44(v335))) do
                if not (v7.Options["Toggle_AutoUpgradePlants" .. v334]
                  and v7.Options["Toggle_AutoUpgradePlants" .. v334].Value) then
                  break
                end

                local v337 = tonumber(value120:GetAttribute("PlantLevel"))

                if v337 then
                  local plantName = value120:GetAttribute("PlantName") or ""

                  if value119[plantName] == true and v337 < v336 then
                    local calculateSeedUpgradePrice = v333 and v333.CalculateSeedUpgradePrice and v333.CalculateSeedUpgradePrice(
                      plantName, v337
                    ) or 0

                    if calculateSeedUpgradePrice > 0
                      and GetPlayerCash() >= calculateSeedUpgradePrice then
                      pcall(function()
                        replicatedStorage.Remotes.UpgradePlant:InvokeServer(value120)
                      end)

                      task.wait(0.2)
                    end
                  end
                end
              end
            end
          end
        end
      end

      if not v332 then
        break
      end

      task.wait(0.5)
    end

    v12.Flags.IsUpgradePlantsLoopRunning = false
  end)
end

local function f80(p106, p107)
  local plotKey = p106.Parent and p106.Parent:GetAttribute("PlotKey")
    or p106:GetAttribute("DupeDebugId")

  if plotKey then
    local v338 = p107 == 1 and tostring(plotKey) or "F" .. p107 .. "_" .. tostring(plotKey)
    local v339 = f30(1)

    local plants = v339 and v339.FarmData and v339.FarmData.Plants
      and v339.FarmData.Plants[v338]

    if plants and plants.Fertilizer and plants.Fertilizer.EndsAt
      and plants.Fertilizer.EndsAt > workspace:GetServerTimeNow() then
      return true
    end
  end

  local playerGui3 = localPlayer:FindFirstChildOfClass("PlayerGui")

  if playerGui3 then
    for index78, value121 in ipairs(playerGui3:GetChildren()) do
      if value121:IsA("BillboardGui") and value121.Name == "FertilizerBoost"
        and value121.Adornee
        and (value121.Adornee == p106 or value121.Adornee:IsDescendantOf(p106)) then
        return true
      end
    end
  end

  return false
end

local function f81(p108)
  if not p108 then
    return nil
  end

  for key22, value122 in pairs(p108) do
    if value122 then
      local v340 = f13(key22)

      if v340 then
        local v341 = string.match(v340.Name, "%(x(%d+)%)")

        if not (v341 and tonumber(v341) == 0) then
          return v340
        end
      end
    end
  end

  return nil
end

local function f82()
  if v12.Flags.IsFertilizePlantsLoopRunning then
    return
  end

  v12.Flags.IsFertilizePlantsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded do
      local v342 = false

      for i7 = 1, 5 do
        local v343 = "_F" .. i7

        if v7.Options["Toggle_AutoFertilize" .. v343]
          and v7.Options["Toggle_AutoFertilize" .. v343].Value then
          v342 = true
          local v344 = f43(i7)

          if v344 then
            local value123 = v7.Options["Dropdown_FertilizePlants" .. v343]
                and v7.Options["Dropdown_FertilizePlants" .. v343].Value
              or {}

            local value124 = v7.Options["Dropdown_FertilizerTypes" .. v343]
                and v7.Options["Dropdown_FertilizerTypes" .. v343].Value
              or {}

            if next(value124) ~= nil and next(value123) ~= nil then
              local v345 = f44(v344)
              local v346 = false

              for index79, value125 in ipairs(v345) do
                local v347 = false

                repeat
                  if not (v7.Options["Toggle_AutoFertilize" .. v343]
                    and v7.Options["Toggle_AutoFertilize" .. v343].Value) then
                    break
                  end

                  if f80(value125, i7) then
                    v347 = true
                    break
                  end

                  local plantName2 = value125:GetAttribute("PlantName")

                  if plantName2 and plantName2 ~= "" and value123[plantName2] == true then
                    local v348 = f81(value124)

                    if v348 then
                      local humanoid7 = localPlayer.Character
                        and localPlayer.Character:FindFirstChild("Humanoid")

                      if humanoid7 then
                        if v348.Parent ~= localPlayer.Character then
                          pcall(function() humanoid7:EquipTool(v348) end)
                          task.wait(0.2)
                          v346 = true
                        end

                        pcall(function()
                          replicatedStorage.Remotes.UseFertilizer:FireServer(value125)
                        end)

                        task.wait(0.5)
                      end
                    else
                      break
                    end
                  end

                  v347 = true
                until true

                if not v347 then
                  break
                end
              end

              if v346 then
                local humanoid8 = localPlayer.Character
                  and localPlayer.Character:FindFirstChild("Humanoid")

                if humanoid8 then
                  pcall(function() humanoid8:UnequipTools() end)
                end

                task.wait(0.1)
              end
            end
          end
        end
      end

      if not v342 then
        break
      end

      task.wait(1)
    end

    v12.Flags.IsFertilizePlantsLoopRunning = false
  end)
end

local function f83()
  if v12.Flags.IsSprayPlantsLoopRunning then
    return
  end

  v12.Flags.IsSprayPlantsLoopRunning = true

  local function f84(p109)
    if not p109 or p109 == "" then
      return true
    end

    local v349 = string.lower(p109)
    return v349 == "normal" or v349 == "none"
  end

  task.spawn(function()
    while not v7.Unloaded do
      local v350 = false

      for i8 = 1, 5 do
        local v351 = "_F" .. i8

        local value126 = v7.Options["Toggle_AutoSpray" .. v351]
          and v7.Options["Toggle_AutoSpray" .. v351].Value

        local value127 = v7.Options["Toggle_AutoClearMutation" .. v351]
          and v7.Options["Toggle_AutoClearMutation" .. v351].Value

        if value126 or value127 then
          v350 = true
          local v352 = f43(i8)

          if v352 then
            local useSpray = replicatedStorage:FindFirstChild("Remotes")
              and replicatedStorage.Remotes:FindFirstChild("UseSpray")

            local humanoid9 = localPlayer.Character
              and localPlayer.Character:FindFirstChild("Humanoid")

            if useSpray and humanoid9 then
              local v353 = f44(v352)
              local v354 = false

              if value126 then
                local value128 = v7.Options["Dropdown_SprayType" .. v351]
                  and v7.Options["Dropdown_SprayType" .. v351].Value

                local value129 = v7.Options["Dropdown_SprayPlants" .. v351]
                    and v7.Options["Dropdown_SprayPlants" .. v351].Value
                  or {}

                if value128 and value128 ~= "" and next(value129) ~= nil then
                  local v355 = f13(value128)

                  if v355 then
                    for index80, value130 in ipairs(v353) do
                      if not (v7.Options["Toggle_AutoSpray" .. v351]
                        and v7.Options["Toggle_AutoSpray" .. v351].Value) then
                        break
                      end

                      local plantName3 = value130:GetAttribute("PlantName")

                      if plantName3 and plantName3 ~= "" and value129[plantName3] == true then
                        if f84(value130:GetAttribute("PlantMutation") or "None") then
                          if v355.Parent ~= localPlayer.Character then
                            pcall(function() humanoid9:EquipTool(v355) end)
                            task.wait(0.2)
                            v354 = true
                          end

                          pcall(function() useSpray:FireServer(value130) end)
                          task.wait(0.5)
                        end
                      end
                    end
                  end
                end
              end

              if value127 then
                local value131 = v7.Options["Dropdown_ClearMutationPlants" .. v351]
                    and v7.Options["Dropdown_ClearMutationPlants" .. v351].Value
                  or {}

                local value132 = v7.Options["Dropdown_ClearMutationNames" .. v351]
                    and v7.Options["Dropdown_ClearMutationNames" .. v351].Value
                  or {}

                if next(value131) ~= nil and next(value132) ~= nil then
                  local acidSpray = f13("Acid Spray")

                  if acidSpray then
                    for index81, value133 in ipairs(v353) do
                      if not (v7.Options["Toggle_AutoClearMutation" .. v351]
                        and v7.Options["Toggle_AutoClearMutation" .. v351].Value) then
                        break
                      end

                      local plantName4 = value133:GetAttribute("PlantName")

                      if plantName4 and plantName4 ~= "" and value131[plantName4] == true then
                        local plantMutation = value133:GetAttribute("PlantMutation") or "None"

                        if not f84(plantMutation) and value132[plantMutation] == true then
                          if acidSpray.Parent ~= localPlayer.Character then
                            pcall(function() humanoid9:EquipTool(acidSpray) end)
                            task.wait(0.2)
                            v354 = true
                          end

                          pcall(function() useSpray:FireServer(value133) end)
                          task.wait(0.5)
                        end
                      end
                    end
                  end
                end
              end

              if v354 then
                pcall(function() humanoid9:UnequipTools() end)
                task.wait(0.1)
              end
            end
          end
        end
      end

      if not v350 then
        break
      end

      task.wait(1)
    end

    v12.Flags.IsSprayPlantsLoopRunning = false
  end)
end

local function f85(p110, p111, p112)
  local configuration = v13.Configuration

  if not configuration or not configuration.FloorConfig then
    return nil
  end

  local v356 = configuration.FloorConfig[p110]

  if not v356 then
    return nil
  end

  local plotUnlockBase = v356.PlotUnlockBase

  if not plotUnlockBase then
    return nil
  end

  local v357 = 1

  if p112 == 2 then
    v357 = 2
  elseif p112 == 3 then
    v357 = 3
  end

  local v358 = plotUnlockBase[v357] or plotUnlockBase[1]

  if not v358 then
    return nil
  end

  local plotUnlockLocalCurve = v356.PlotUnlockLocalCurve

  local v359 = v358
    * (plotUnlockLocalCurve and plotUnlockLocalCurve.Growth or v356.PlotUnlockGrowth)
      ^ ((plotUnlockLocalCurve and plotUnlockLocalCurve.StartIndex or 1) + p111 - 1)

  return math.floor(v359)
end

local function f86()
  if v12.Flags.IsUnlockFarmPlotsLoopRunning then
    return
  end

  v12.Flags.IsUnlockFarmPlotsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded do
      local v360 = false

      for i9 = 1, 5 do
        local v361 = "_F" .. i9

        if v7.Options["Toggle_AutoUnlockFarmPlots" .. v361]
          and v7.Options["Toggle_AutoUnlockFarmPlots" .. v361].Value then
          v360 = true
          local v362 = f43(i9)

          if v362 then
            local count4 = 0
            local count5 = 0
            local count6 = 0
            local v363 = {}

            for index82, value134 in ipairs(v362:GetChildren()) do
              if not (v7.Options["Toggle_AutoUnlockFarmPlots" .. v361]
                and v7.Options["Toggle_AutoUnlockFarmPlots" .. v361].Value) then
                break
              end

              local v364 = tonumber(value134.Name:match("^Plot(%d+)$"))

              if v364 then
                count4 = count4 + 1

                if value134:GetAttribute("Unlocked") == true then
                  count6 = count6 + 1
                else
                  count5 = count5 + 1
                  table.insert(v363, { node = value134, index = v364 })
                end
              end
            end

            for index83, value135 in ipairs(v363) do
              if not (v7.Options["Toggle_AutoUnlockFarmPlots" .. v361]
                and v7.Options["Toggle_AutoUnlockFarmPlots" .. v361].Value) then
                break
              end

              local dirt5 = value135.node:FindFirstChild("Dirt")
              local v365 = f85(i9, count6, value135.index)

              if dirt5 and v365 and GetPlayerCash() >= v365 then
                pcall(function() replicatedStorage.Remotes.UnlockPlot:FireServer(dirt5) end)
                task.wait(0.5)
              else
                task.wait(3)
              end
            end

            if v7.Options["Toggle_AutoUnlockFarmPlots" .. v361]
              and v7.Options["Toggle_AutoUnlockFarmPlots" .. v361].Value and count4 > 0
              and count5 == 0 then
              pcall(function()
                local v366 = v7.Options["Toggle_AutoUnlockFarmPlots" .. v361]

                if v366 then
                  v366:SetValue(false)
                end
              end)

              v7:Notify({
                Title = "Floor " .. i9 .. " Fully Unlocked!",
                Content = "All plots on Floor " .. i9 .. " are unlocked. Auto Unlock disabled.",
                Duration = 5,
              })
            end
          end
        end
      end

      if not v360 then
        break
      end

      task.wait(2)
    end

    v12.Flags.IsUnlockFarmPlotsLoopRunning = false
  end)
end

local function f87(p113, p114)
  local v367 = f29()

  local floors = v367 and v367.FarmData and v367.FarmData.Floors
    and v367.FarmData.Floors[tostring(p114)]

  local v368 = GetSharedUtils()
  local v369 = GetConfigurationConfig()

  if p113 == "SawYield" then
    if v368 and v368.CalculateExtraYieldCost and floors then
      return v368.CalculateExtraYieldCost(floors.SawYield or 1, "Floor" .. p114)
    end
  elseif p113 == "SprinklerPower" then
    if v368 and v368.CalculateExtraPowerCost and floors then
      return v368.CalculateExtraPowerCost(floors.SprinklerPower or 1, "Floor" .. p114)
    end
  elseif p113 == "SawRange" then
    if v369 and v369.FloorConfig and floors then
      local sawRange = floors.SawRange or 1

      if v369.MAX_RANGE and sawRange >= v369.MAX_RANGE then
        return "MAX"
      end

      local v370 = v369.FloorConfig[p114]

      if v370 and v370.ExtraSawRangeCosts then
        return v370.ExtraSawRangeCosts[sawRange + 1]
      end
    end
  elseif p113 == "SprinklerRange" then
    if v369 and v369.FloorConfig and floors then
      local sprinklerRange = floors.SprinklerRange or 1

      if v369.MAX_RANGE and sprinklerRange >= v369.MAX_RANGE then
        return "MAX"
      end

      local v371 = v369.FloorConfig[p114]

      if v371 and v371.ExtraSprinklerRangeCosts then
        return v371.ExtraSprinklerRangeCosts[sprinklerRange + 1]
      end
    end
  elseif p113 == "SoilQuality" then
    if v369 and v369.FloorConfig and floors then
      local v372 = v369.FloorConfig[p114]
      local soilQuality = v372 and v372.SoilQuality

      if soilQuality then
        local soilQuality2 = floors.SoilQuality or 1

        if soilQuality.MaxLevel and soilQuality2 >= soilQuality.MaxLevel then
          return "MAX"
        end

        return math.floor(soilQuality.BaseCost * soilQuality.CostGrowth ^ (soilQuality2 - 1))
      end
    end
  elseif p113 == "CrownedCrops" then
    local v373 = GetCrownedCropsConfig()

    if v373 and v373.IsEligibleFloor and not v373.IsEligibleFloor(p114) then
      return nil
    end

    if v373 and floors then
      local v374 = v373.GetUpgradeCost(p114, floors.CrownLevel or 0)

      if v374 == nil then
        if (floors.CrownLevel or 0) >= (v373.MaxLevel or 5) then
          return "MAX"
        end
      else
        return v374
      end
    end
  elseif p113 == "GoldenHarvest" then
    local v375 = GetGoldenHarvestConfig()

    if v375 and v375.IsEligibleFloor and not v375.IsEligibleFloor(p114) then
      return nil
    end

    if v375 and floors then
      local goldenHarvestStage = floors.GoldenHarvestStage or 0

      if goldenHarvestStage >= (v375.MaxStage or 3) then
        return "MAX"
      end

      return v375.GetBuildCost(goldenHarvestStage)
    end
  elseif p113 == "GoldenChance" then
    local v376 = GetGoldenHarvestConfig()

    if v376 and v376.IsEligibleFloor and not v376.IsEligibleFloor(p114) then
      return nil
    end

    if v376 and floors then
      if (floors.GoldenHarvestStage or 0) < 1 then
        return nil
      end

      return v376.GetUpgradeCost(floors.GoldenChanceLevel or 0)
    end
  elseif p113 == "SeedLuck" then
    if v368 and v368.CalculateSeedLuckUpgradeCost and v367 then
      return v368.CalculateSeedLuckUpgradeCost(v367.CurrentSeedLuckLevel or 1)
    end
  elseif p113 == "SeedRolls" then
    if v369 and v367 then
      local currentSeedRolls = v367.CurrentSeedRolls or 0

      if v369.MAX_ROLLS and currentSeedRolls >= v369.MAX_ROLLS then
        return "MAX"
      end

      if v369.ExtraSeedRollsCosts then
        return v369.ExtraSeedRollsCosts[currentSeedRolls + 1]
      end
    end
  end

  return nil
end

local function f88()
  if v12.Flags.IsUpgradePowerupsLoopRunning then
    return
  end

  v12.Flags.IsUpgradePowerupsLoopRunning = true

  task.spawn(function()
    local v377 = {
      [1] = 1,
      [2] = 1,
      [3] = 1,
      [4] = 1,
      [5] = 1,
    }

    local v378 = {}

    while not v7.Unloaded do
      local v379 = false

      for i10 = 1, 5 do
        local v380 = "_F" .. i10

        if v7.Options["Toggle_AutoUpgradePowerups" .. v380]
          and v7.Options["Toggle_AutoUpgradePowerups" .. v380].Value then
          local value136 = v7.Options["Dropdown_UpgradePowerups" .. v380]
              and v7.Options["Dropdown_UpgradePowerups" .. v380].Value
            or {}

          local v381 = {}
          local v382 = false
          local v383 = true

          for key23, value137 in pairs(value136) do
            local v384 = false

            repeat
              if value137 and not (key23 == "SoilQuality" and i10 <= 2) then
                if key23 == "CrownedCrops" and i10 == 1 then
                  v384 = true
                  break
                end

                if (key23 == "SeedLuck" or key23 == "SeedRolls") and i10 ~= 1 then
                  v384 = true
                  break
                end

                v382 = true
                local v385 = v14.UPGRADE_MAP[key23].Type
                local v386 = nil

                if v385 == "plot" then
                  v386 = f87(key23, i10)
                elseif (v385 == "seedluck" or v385 == "seedrolls") and i10 == 1 then
                  v386 = f87(key23, 1)
                end

                if v386 == "MAX" then
                elseif v386 then
                  v383 = false
                  table.insert(v381, key23)
                else
                  v383 = false
                end
              end

              v384 = true
            until true

            if not v384 then
              break
            end
          end

          if v7.Options["Toggle_AutoUpgradePowerups" .. v380]
            and v7.Options["Toggle_AutoUpgradePowerups" .. v380].Value and v382 and v383 then
            pcall(function()
              local v387 = v7.Options["Toggle_AutoUpgradePowerups" .. v380]

              if v387 then
                v387:SetValue(false)
              end
            end)

            v7:Notify({
              Title = "Floor " .. i10 .. " Powerups MAXED!",
              Content = "All selected powerups reached MAX level. Auto Upgrade disabled.",
              Duration = 5,
            })
          end

          if v7.Options["Toggle_AutoUpgradePowerups" .. v380]
            and v7.Options["Toggle_AutoUpgradePowerups" .. v380].Value and #v381 > 0 then
            v379 = true

            if v377[i10] > #v381 then
              v377[i10] = 1
            end

            local v388 = v381[v377[i10]]
            local v389 = v14.UPGRADE_MAP[v388].Type
            local v390 = nil

            if v389 == "plot" then
              v390 = f87(v388, i10)
            elseif (v389 == "seedluck" or v389 == "seedrolls") and i10 == 1 then
              v390 = f87(v388, 1)
            end

            local v391 = i10 .. "_" .. v388
            local v392 = v378[v391]

            if v392 then
              if v390 == v392.cost and tick() - v392.time < 3 then
                v390 = nil
              else
                v378[v391] = nil
              end
            end

            if v390 and v390 ~= "MAX" and GetPlayerCash() >= v390 then
              v378[v391] = { cost = v390, time = tick() }

              if v389 == "plot" then
                local remoteArg = v14.UPGRADE_MAP[v388].RemoteArg
                local v393 = "Floor" .. i10

                task.spawn(function()
                  pcall(function()
                    replicatedStorage.Remotes.PlotUpgradeTransaction:InvokeServer(
                      remoteArg, v393
                    )
                  end)
                end)
              elseif v389 == "seedluck" then
                task.spawn(function()
                  pcall(function() replicatedStorage.Remotes.UpgradeSeedLuck:InvokeServer() end)
                end)
              elseif v389 == "seedrolls" then
                task.spawn(function()
                  pcall(function() replicatedStorage.Remotes.UpgradeSeedRolls:InvokeServer() end)
                end)
              end
            end

            v377[i10] = v377[i10] % #v381 + 1
          end
        end
      end

      if not v379 then
        break
      end

      task.wait(0.2)
    end

    v12.Flags.IsUpgradePowerupsLoopRunning = false
  end)
end

local function f89()
  if v12.Flags.IsCollectAlienDropLoopRunning or not v7.Options.Toggle_AutoCollectAlienDrop.Value then
    return
  end

  v12.Flags.IsCollectAlienDropLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectAlienDrop.Value do
      pcall(function()
        if f24("AlienInvasion") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart2 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart2 then
          for index84, value138 in ipairs(workspace:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectAlienDrop.Value then
              break
            end

            if string.find(value138.Name, "AlienDrop", 1, true) then
              local findFirstChildWhichIsA3 = value138:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart = value138:IsA("BasePart") and value138
                or value138:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA3 and basePart then
                f20(humanoidRootPart2, basePart, findFirstChildWhichIsA3)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsCollectAlienDropLoopRunning = false
  end)
end

local function f90()
  if v12.Flags.IsCollectCyberDroneDropLoopRunning
    or not v7.Options.Toggle_AutoCollectCyberDroneDrop.Value then
    return
  end

  v12.Flags.IsCollectCyberDroneDropLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectCyberDroneDrop.Value do
      pcall(function()
        local cyberDroneClientFX = workspace:FindFirstChild("CyberDroneClientFX")

        if not cyberDroneClientFX or #cyberDroneClientFX:GetChildren() == 0
          or f24("CyberDrone") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart3 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart3 then
          for index85, value139 in ipairs(cyberDroneClientFX:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectCyberDroneDrop.Value then
              break
            end

            if string.find(value139.Name, "CyberDroneDrop_", 1, true) ~= nil then
              local findFirstChildWhichIsA4 = value139:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart2 = value139:IsA("BasePart") and value139
                or value139:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA4 and basePart2 then
                f20(humanoidRootPart3, basePart2, findFirstChildWhichIsA4)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsCollectCyberDroneDropLoopRunning = false
  end)
end

local function f91()
  if v12.Flags.IsCollectHoneycombLoopRunning
    or not v7.Options.Toggle_AutoCollectQueenBeeHoneycomb.Value then
    return
  end

  v12.Flags.IsCollectHoneycombLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectQueenBeeHoneycomb.Value do
      pcall(function()
        if f24("QueenBee") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart4 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart4 then
          for index86, value140 in ipairs(workspace:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectQueenBeeHoneycomb.Value then
              break
            end

            if value140.Name == "Honeycomb" then
              local findFirstChildWhichIsA5 = value140:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              if findFirstChildWhichIsA5 then
                local basePart3 = value140:IsA("BasePart") and value140
                  or value140:IsA("Model")
                    and (value140.PrimaryPart
                      or value140:FindFirstChildWhichIsA("BasePart", true))

                if findFirstChildWhichIsA5 and basePart3 then
                  f20(humanoidRootPart4, basePart3, findFirstChildWhichIsA5)
                  task.wait(0.5)
                end
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsCollectHoneycombLoopRunning = false
  end)
end

local function f92()
  if v12.Flags.IsSubmitQueenBeeHoneyTokenLoopRunning
    or not v7.Options.Toggle_AutoSubmitQueenBeeHoneyToken.Value then
    return
  end

  v12.Flags.IsSubmitQueenBeeHoneyTokenLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoSubmitQueenBeeHoneyToken.Value do
      if GetHoneyTokens() <= 0 then
        task.wait(2)
      else
        local v394 = f17()

        local humanoidRootPart5 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if v394 and humanoidRootPart5 then
          local parent = v394.Parent

          if parent and parent:IsA("Attachment") then
            parent = parent.Parent
          end

          if parent then
            f20(humanoidRootPart5, parent, v394)
          end
        else
          task.wait(2)
        end
      end

      task.wait(1)
    end

    v12.Flags.IsSubmitQueenBeeHoneyTokenLoopRunning = false
  end)
end

local function f93()
  if v12.Flags.IsCollectAdminTokensLoopRunning
    or not v7.Options.Toggle_AutoCollectAdminTokens.Value then
    return
  end

  v12.Flags.IsCollectAdminTokensLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectAdminTokens.Value do
      pcall(function()
        local humanoidRootPart6 = localPlayer.Character
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

        if humanoidRootPart6 then
          for index87, value141 in ipairs(runtimeAdminTokens:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectAdminTokens.Value then
              break
            end

            local findFirstChildWhichIsA6 = value141:FindFirstChildWhichIsA(
              "ProximityPrompt", true
            )

            local basePart4 = value141:IsA("BasePart") and value141
              or value141:IsA("Model")
                and (value141.PrimaryPart or value141:FindFirstChildWhichIsA("BasePart", true))

            if findFirstChildWhichIsA6 and basePart4 then
              f20(humanoidRootPart6, basePart4, findFirstChildWhichIsA6)
              task.wait(0.5)
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsCollectAdminTokensLoopRunning = false
  end)
end

local function f94()
  if v12.Flags.IsSpinMegaSpinnerLoopRunning or not v7.Options.Toggle_AutoSpinMegaSpinner.Value then
    return
  end

  v12.Flags.IsSpinMegaSpinnerLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoSpinMegaSpinner.Value do
      pcall(function()
        if f18() <= 0 then
          task.wait(2)
        else
          local v395 = f19()

          local humanoidRootPart7 = localPlayer.Character
            and localPlayer.Character:FindFirstChild("HumanoidRootPart")

          if v395 and humanoidRootPart7 then
            local parent2 = v395.Parent

            if parent2 and parent2:IsA("Attachment") then
              parent2 = parent2.Parent
            end

            if parent2 then
              f20(humanoidRootPart7, parent2, v395)
              task.wait(1.5)
            end
          else
            task.wait(2)
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsSpinMegaSpinnerLoopRunning = false
  end)
end

local function f95()
  if v12.Flags.IsPlantditchPassRingLoopRunning
    or not v7.Options.Toggle_AutoPlantditchPassRing.Value then
    return
  end

  v12.Flags.IsPlantditchPassRingLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoPlantditchPassRing.Value do
      pcall(function()
        local v396 = f22()

        local humanoidRootPart8 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if not (v396 and humanoidRootPart8) then
          return
        end

        local plantditchArena = workspace:FindFirstChild("PlantditchArena")
        local rings = plantditchArena and plantditchArena:FindFirstChild("Rings")

        if not rings then
          task.wait(2)
          return
        end

        for index88, value142 in ipairs(rings:GetChildren()) do
          local v397 = false

          repeat
            if not v7.Options.Toggle_AutoPlantditchPassRing.Value then
              break
            end

            if not value142:IsA("BasePart") then
              v397 = true
              break
            end

            local ringId = value142:GetAttribute("RingId")

            if not ringId then
              v397 = true
              break
            end

            local size = value142.Size
            local vector

            if size.X <= size.Y and size.X <= size.Z then
              vector = Vector3.new(1, 0, 0)
            elseif size.Y <= size.Z then
              vector = Vector3.new(0, 1, 0)
            else
              vector = Vector3.new(0, 0, 1)
            end

            local v398 = value142.CFrame:VectorToWorldSpace(vector) * 2
            humanoidRootPart8.CFrame = CFrame.new(value142.Position + v398)
            task.wait(0.05)
            humanoidRootPart8.CFrame = CFrame.new(value142.Position - v398)
            task.wait(0.05)

            v396:Fire({
              eventName = "Plantditch",
              action = "PassRing",
              instance = nil,
              args = { ringId, humanoidRootPart8.Position },
            })

            task.wait(0.3)
            v397 = true
          until true

          if not v397 then
            break
          end
        end
      end)

      task.wait(0.5)
    end

    v12.Flags.IsPlantditchPassRingLoopRunning = false
  end)
end

local function f96()
  if v12.Flags.IsPlantditchClaimOrbLoopRunning
    or not v7.Options.Toggle_AutoPlantditchClaimOrb.Value then
    return
  end

  v12.Flags.IsPlantditchClaimOrbLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoPlantditchClaimOrb.Value do
      pcall(function()
        local v399 = f22()

        local humanoidRootPart9 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if not (v399 and humanoidRootPart9) then
          return
        end

        local plantditchArena2 = workspace:FindFirstChild("PlantditchArena")
        local orbs = plantditchArena2 and plantditchArena2:FindFirstChild("Orbs")

        if not orbs then
          task.wait(2)
          return
        end

        for index89, value143 in ipairs(orbs:GetChildren()) do
          local v400 = false

          repeat
            if not v7.Options.Toggle_AutoPlantditchClaimOrb.Value then
              break
            end

            local orbId = value143:GetAttribute("OrbId")
            local primaryPart = value143.PrimaryPart or value143:FindFirstChild("Core")

            if not (orbId and primaryPart) then
              v400 = true
              break
            end

            humanoidRootPart9.CFrame = CFrame.new(primaryPart.Position)
            task.wait(0.1)

            v399:Fire({
              eventName = "Plantditch",
              action = "ClaimOrb",
              instance = nil,
              args = { orbId, humanoidRootPart9.Position },
            })

            task.wait(0.3)
            v400 = true
          until true

          if not v400 then
            break
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsPlantditchClaimOrbLoopRunning = false
  end)
end

local function f97()
  if v12.Flags.IsCollectWeatherEventsLoopRunning
    or not v7.Options.Toggle_AutoCollectWeatherEvents.Value then
    return
  end

  v12.Flags.IsCollectWeatherEventsLoopRunning = true
  local v401 = setmetatable({}, { __mode = "k" })

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectWeatherEvents.Value do
      pcall(function()
        local humanoidRootPart10 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local v402 = f22()

        if not (humanoidRootPart10 and v402) then
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
          for index90, value144 in ipairs(rainClientFX:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            local v403 = tonumber(string.match(value144.Name, "^Droplet_(%d+)$"))

            if v403 then
              local basePart5 = value144:IsA("BasePart") and value144
                or value144:FindFirstChildWhichIsA("BasePart", true)

              if basePart5 then
                humanoidRootPart10.CFrame = CFrame.new(basePart5.Position)

                pcall(function()
                  v402:Fire({
                    eventName = "Rain",
                    action = "CollectDroplet",
                    instance = nil,
                    args = { v403 },
                  })
                end)

                task.wait(1.5)
              end
            end
          end
        end

        if blizzardClientFX then
          for index91, value145 in ipairs(blizzardClientFX:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            if string.match(value145.Name, "^Crystal_(%d+)$") then
              local findFirstChildWhichIsA7 = value145:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart6 = value145:IsA("BasePart") and value145
                or value145:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA7 and basePart6 then
                f20(humanoidRootPart10, basePart6, findFirstChildWhichIsA7)
                task.wait(1.2)
              end
            end
          end
        end

        if fallClientFX then
          local getChildren = fallClientFX:GetChildren()

          if #getChildren == 0 then
            table.clear(v401)
          else
            for index92, value146 in ipairs(getChildren) do
              if not v7.Options.Toggle_AutoCollectWeatherEvents.Value then
                break
              end

              if value146.Name == "LeafPile" and not v401[value146] then
                local findFirstChildWhichIsA8 = value146:FindFirstChildWhichIsA(
                  "ProximityPrompt", true
                )

                local basePart7 = value146:IsA("BasePart") and value146
                  or value146:FindFirstChildWhichIsA("BasePart", true)

                if findFirstChildWhichIsA8 and basePart7 then
                  v401[value146] = true
                  f20(humanoidRootPart10, basePart7, findFirstChildWhichIsA8)
                  task.wait(1.2)
                end
              end
            end
          end
        end

        if blackholeClientFX then
          for index93, value147 in ipairs(blackholeClientFX:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            if string.match(value147.Name, "^Blackhole_(%d+)$") then
              local findFirstChildWhichIsA9 = value147:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart8 = value147:IsA("BasePart") and value147
                or value147:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA9 and basePart8 then
                f20(humanoidRootPart10, basePart8, findFirstChildWhichIsA9)
                task.wait(1.2)
              end
            end
          end
        end

        if nuclearClientFX then
          for index94, value148 in ipairs(nuclearClientFX:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            if string.match(value148.Name, "^Barrel_(%d+)$") then
              local findFirstChildWhichIsA10 = value148:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              local basePart9 = value148:IsA("BasePart") and value148
                or value148:FindFirstChildWhichIsA("BasePart", true)

              if findFirstChildWhichIsA10 and basePart9 then
                f20(humanoidRootPart10, basePart9, findFirstChildWhichIsA10)
                task.wait(1.2)
              end
            end

            local v404 = tonumber(string.match(value148.Name, "^NuclearDrop_(%d+)$"))

            if v404 then
              local basePart10 = value148:IsA("BasePart") and value148
                or value148:FindFirstChildWhichIsA("BasePart", true)

              if basePart10 then
                humanoidRootPart10.CFrame = CFrame.new(basePart10.Position)

                pcall(function()
                  v402:Fire({
                    eventName = "Nuclear",
                    action = "CollectNuclearDrop",
                    instance = nil,
                    args = { v404 },
                  })
                end)

                task.wait(1.5)
              end
            end
          end
        end

        if galaxyClientFX then
          for index95, value149 in ipairs(galaxyClientFX:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectWeatherEvents.Value then
              break
            end

            local v405 = tonumber(string.match(value149.Name, "^StarDrop_(%d+)$"))

            if v405 then
              local basePart11 = value149:IsA("BasePart") and value149
                or value149:FindFirstChildWhichIsA("BasePart", true)

              if basePart11 then
                humanoidRootPart10.CFrame = CFrame.new(basePart11.Position)
                task.wait(0.75)

                pcall(function()
                  v402:Fire({
                    eventName = "Galaxy",
                    action = "CollectStarDrop",
                    instance = nil,
                    args = { v405 },
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

    v12.Flags.IsCollectWeatherEventsLoopRunning = false
  end)
end

local function f98()
  if v12.Flags.IsCollectLuckyRainDropLoopRunning
    or not v7.Options.Toggle_AutoCollectLuckyRainDrop.Value then
    return
  end

  v12.Flags.IsCollectLuckyRainDropLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectLuckyRainDrop.Value do
      pcall(function()
        local luckyRainClientFX = workspace:FindFirstChild("LuckyRainClientFX")

        if not luckyRainClientFX or #luckyRainClientFX:GetChildren() == 0
          or f24("LuckyRain") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart11 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local v406 = f22()

        if humanoidRootPart11 and v406 then
          for index96, value150 in ipairs(luckyRainClientFX:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectLuckyRainDrop.Value then
              break
            end

            local v407 = tonumber(string.match(value150.Name, "^LuckyRainDrop_(%d+)$"))

            if v407 then
              local basePart12 = value150:IsA("BasePart") and value150
                or value150:IsA("Model")
                  and (value150.PrimaryPart or value150:FindFirstChildWhichIsA("BasePart", true))

              if basePart12 then
                humanoidRootPart11.CFrame = CFrame.new(basePart12.Position)
                task.wait(0.1)
                v406:Fire({ eventName = "LuckyRain", action = "ClaimDrop", args = { v407 } })
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsCollectLuckyRainDropLoopRunning = false
  end)
end

local function f99()
  if v12.Flags.IsCollectMeteorDropLoopRunning
    or not v7.Options.Toggle_AutoCollectMeteorDrop.Value then
    return
  end

  v12.Flags.IsCollectMeteorDropLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectMeteorDrop.Value do
      pcall(function()
        local meteorShowerClientFX = workspace:FindFirstChild("MeteorShowerClientFX")

        if not meteorShowerClientFX or #meteorShowerClientFX:GetChildren() == 0
          or f24("MeteorShower") == false then
          task.wait(3)
          return
        end

        local humanoidRootPart12 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local v408 = f22()

        if humanoidRootPart12 and v408 then
          for index97, value151 in ipairs(meteorShowerClientFX:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectMeteorDrop.Value then
              break
            end

            local v409 = tonumber(string.match(value151.Name, "^MeteorDrop_(%d+)$"))

            if v409 then
              local basePart13 = value151:IsA("BasePart") and value151
                or value151:IsA("Model")
                  and (value151.PrimaryPart or value151:FindFirstChildWhichIsA("BasePart", true))

              if basePart13 then
                humanoidRootPart12.CFrame = CFrame.new(basePart13.Position)
                task.wait(0.1)

                v408:Fire({
                  eventName = "MeteorShower",
                  action = "ClaimMeteorDrop",
                  instance = nil,
                  args = { v409 },
                })

                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsCollectMeteorDropLoopRunning = false
  end)
end

local function f100()
  if v12.Flags.IsShootJesterBossLoopRunning or not v7.Options.Toggle_AutoShootJesterBoss.Value then
    return
  end

  v12.Flags.IsShootJesterBossLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoShootJesterBoss.Value do
      pcall(function()
        local jester = workspace:FindFirstChild("Jester")

        local primaryPart2 = jester
          and (jester.PrimaryPart or jester:FindFirstChildWhichIsA("BasePart", true))

        local humanoidRootPart13 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local humanoid10 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("Humanoid")

        local v410 = f22()

        if primaryPart2 and humanoidRootPart13 and humanoid10 and v410 then
          local tomatoShooter = f13("Tomato Shooter")

          if tomatoShooter then
            if tomatoShooter.Parent ~= localPlayer.Character then
              humanoid10:EquipTool(tomatoShooter)
              task.wait(0.1)
            end

            if tomatoShooter.Parent == localPlayer.Character then
              local v411 = humanoidRootPart13.Position + Vector3.new(0, 1.5, 0)

              v410:Fire({
                eventName = "JesterBoss",
                action = "Shoot",
                instance = nil,
                args = { v411, (primaryPart2.Position - v411).Unit },
              })

              task.wait(0.25)
              return
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsShootJesterBossLoopRunning = false
  end)
end

local function f101()
  if v12.Flags.IsCollectJesterGiftsLoopRunning
    or not v7.Options.Toggle_AutoCollectJesterGifts.Value then
    return
  end

  v12.Flags.IsCollectJesterGiftsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectJesterGifts.Value do
      pcall(function()
        local humanoidRootPart14 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local jesterBossGiftsClient = workspace:FindFirstChild("JesterBossGifts_Client")

        if humanoidRootPart14 and jesterBossGiftsClient then
          for index98, value152 in ipairs(jesterBossGiftsClient:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectJesterGifts.Value then
              break
            end

            local findFirstChild16 = value152:FindFirstChild("GiftBoxPrompt", true)

            if findFirstChild16 and findFirstChild16:IsA("ProximityPrompt") then
              local basePart14 = value152:IsA("BasePart") and value152
                or value152:IsA("Model")
                  and (value152.PrimaryPart or value152:FindFirstChildWhichIsA("BasePart", true))

              if basePart14 then
                f20(humanoidRootPart14, basePart14, findFirstChild16)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsCollectJesterGiftsLoopRunning = false
  end)
end

local function f102()
  if v12.Flags.IsCollectCarnivalGiftsLoopRunning
    or not v7.Options.Toggle_AutoCollectCarnivalGifts.Value then
    return
  end

  v12.Flags.IsCollectCarnivalGiftsLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoCollectCarnivalGifts.Value do
      pcall(function()
        local humanoidRootPart15 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local carnivalGiftBoxesClient = workspace:FindFirstChild("CarnivalGiftBoxes_Client")

        if humanoidRootPart15 and carnivalGiftBoxesClient then
          for index99, value153 in ipairs(carnivalGiftBoxesClient:GetChildren()) do
            if not v7.Options.Toggle_AutoCollectCarnivalGifts.Value then
              break
            end

            local findFirstChild17 = value153:FindFirstChild("GiftBoxPrompt", true)

            if findFirstChild17 and findFirstChild17:IsA("ProximityPrompt") then
              local basePart15 = value153:IsA("BasePart") and value153
                or value153:IsA("Model")
                  and (value153.PrimaryPart or value153:FindFirstChildWhichIsA("BasePart", true))

              if basePart15 then
                f20(humanoidRootPart15, basePart15, findFirstChild17)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v12.Flags.IsCollectCarnivalGiftsLoopRunning = false
  end)
end

local function f103()
  if v12.Flags.IsAutoZooRushLoopRunning then
    return
  end

  v12.Flags.IsAutoZooRushLoopRunning = true
  local v412 = { Tired = 0, Alert = 1, Wander = 2 }

  task.spawn(function()
    while not v7.Unloaded
      and (v7.Options.Toggle_AutoZooRushName.Value or v7.Options.Toggle_AutoZooRushRarity.Value) do
      pcall(function()
        local character4 = localPlayer.Character
        local humanoidRootPart16 = character4 and character4:FindFirstChild("HumanoidRootPart")
        local humanoid11 = character4 and character4:FindFirstChild("Humanoid")

        if not (humanoidRootPart16 and humanoid11) then
          return
        end

        local tool6 = character4:FindFirstChildWhichIsA("Tool")

        if not (tool6 and tool6:GetAttribute("ZooRushNet") == true) then
          local backpack3 = localPlayer:FindFirstChild("Backpack")

          if backpack3 then
            for index100, value154 in ipairs(backpack3:GetChildren()) do
              if value154:IsA("Tool") and value154:GetAttribute("ZooRushNet") == true then
                tool6 = value154
                humanoid11:EquipTool(value154)
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

        local v413 = f22()

        if not v413 then
          return
        end

        local value155 = v7.Options.Dropdown_ZooRushNames.Value
        local value156 = v7.Options.Dropdown_ZooRushRarities.Value
        local value157 = v7.Options.Toggle_AutoZooRushName.Value
        local value158 = v7.Options.Toggle_AutoZooRushRarity.Value

        if value157 and (type(value155) ~= "table" or next(value155) == nil)
          or value158 and (type(value156) ~= "table" or next(value156) == nil)
          or not value157 and not value158 then
          task.wait(0.5)
          return
        end

        local getServerTimeNow2 = workspace:GetServerTimeNow()
        local v414 = {}

        for index101, value159 in ipairs(zooRushAnimals:GetChildren()) do
          local v415 = false

          repeat
            if value159:IsA("BasePart") then
              local petName = value159:GetAttribute("PetName")
              local expiresAt = value159:GetAttribute("ExpiresAt")

              if type(petName) ~= "string" then
                v415 = true
                break
              end

              if type(expiresAt) == "number" and expiresAt < getServerTimeNow2 then
                v415 = true
                break
              end

              if value157 and petName then
                local v416 = string.lower(petName)
                local v417 = false

                for key24, value160 in pairs(value155) do
                  if value160 and string.find(v416, string.lower(key24), 1, true) then
                    v417 = true
                    break
                  end
                end

                if not v417 then
                  v415 = true
                  break
                end
              elseif value158 then
                local v418 = f7(petName)

                if not v418 or not value156[v418] then
                  v415 = true
                  break
                end
              end

              local rate = v12.Data.ZooRushPetRate[petName] or 999
              local statePri = v412[value159:GetAttribute("State") or "Wander"] or 3
              table.insert(v414, { Part = value159, Rate = rate, StatePri = statePri })
            end

            v415 = true
          until true

          if not v415 then
            break
          end
        end

        if #v414 == 0 then
          task.wait(0.5)
          return
        end

        table.sort(v414, function(p115, p116)
          if p115.Rate ~= p116.Rate then
            return p115.Rate < p116.Rate
          end

          return p115.StatePri < p116.StatePri
        end)

        local part = v414[1].Part
        humanoidRootPart16.CFrame = CFrame.new(part.Position)
        task.wait(0.05)

        for i11 = 1, 3 do
          if not (v7.Options.Toggle_AutoZooRushName.Value
            or v7.Options.Toggle_AutoZooRushRarity.Value) then
            break
          end

          v413:Fire({
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

    v12.Flags.IsAutoZooRushLoopRunning = false
  end)
end

local function f104()
  local value161 = v7.Options.Toggle_AutoFriendOTronSeed.Value
  local value162 = value161 and v7.Options.Dropdown_FriendOTronSeedName.Value
  local value163 = not value161 and v7.Options.Dropdown_FriendOTronRarity.Value

  for index102, value164 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value164 then
      for index103, value165 in ipairs(value164:GetChildren()) do
        if value165:IsA("Tool") and value165:GetAttribute("InventoryCategory") == "Seeds" then
          local plant2 = value165:GetAttribute("Plant") or value165:GetAttribute("trueName")

          if plant2 and not f38(value165) and value165:GetAttribute("Fused") ~= true then
            local v419 = f6(plant2)

            if v419 ~= "Unknown" and v419 ~= "Common" and v419 ~= "Uncommon" then
              if value161 then
                if type(value162) == "table" and value162[plant2] then
                  return value165
                end
              elseif type(value163) == "table" and value163[v419] then
                return value165
              end
            end
          end
        end
      end
    end
  end

  return nil
end

local function f105()
  local v420 = { Blue = nil, Purple = nil }

  pcall(function()
    local friendOTron = replicatedStorage:FindFirstChild("Remotes")
      and replicatedStorage.Remotes:FindFirstChild("FriendOTron")

    local chamberSync = friendOTron and friendOTron:FindFirstChild("ChamberSync")

    if not chamberSync or not getconnections or not debug or not debug.getupvalues then
      return
    end

    local v421, v422

    for index104, value166 in ipairs(getconnections(chamberSync.OnClientEvent)) do
      local v423 = value166.Function

      if v423 then
        local v424 = debug.getupvalues(v423)

        if v424 and type(v424[1]) == "table" and type(v424[2]) == "table" then
          v421 = v424[1]
          v422 = v424[2]
          break
        end
      end
    end

    for index105, value167 in ipairs({ "Blue", "Purple" }) do
      if v421 and v421[value167] then
        v420[value167] = {
          SeedName = tostring(v421[value167]),
          Depositor = localPlayer.DisplayName .. " (You)",
        }
      elseif v422 and v422[value167] then
        for key25, value168 in pairs(v422[value167]) do
          local getPlayerByUserId = Players:GetPlayerByUserId(key25)

          local displayName4 = getPlayerByUserId and getPlayerByUserId.DisplayName
            or "User " .. tostring(key25)

          v420[value167] = { SeedName = tostring(value168), Depositor = displayName4 }
          break
        end
      end
    end
  end)

  return v420
end

local function f106()
  task.spawn(function()
    while not v7.Unloaded do
      pcall(function()
        if v12.Paragraph.FriendOTronInfo then
          local v425 = false
          local v426 = false
          local friendOTron2 = workspace:FindFirstChild("FriendOTron")

          if friendOTron2 then
            v425 = friendOTron2:FindFirstChild("FriendOTronSeedVisual_Blue") ~= nil
            v426 = friendOTron2:FindFirstChild("FriendOTronSeedVisual_Purple") ~= nil
          end

          local v427 = f105()
          local v428 = "Empty"

          if v425 then
            if v427.Blue then
              v428 = v427.Blue.SeedName .. " (by " .. v427.Blue.Depositor .. ")"
            else
              v428 = "Occupied"
            end
          end

          local v429 = "Empty"

          if v426 then
            if v427.Purple then
              v429 = v427.Purple.SeedName .. " (by " .. v427.Purple.Depositor .. ")"
            else
              v429 = "Occupied"
            end
          end

          local v430 = {}

          table.insert(v430, "<font color='#00E5FF'>Blue</font>:   " .. v428)
          table.insert(v430, "<font color='#AB47BC'>Purple</font>: " .. v429)

          local v431 = v12.Data.FriendOTronCooldownUntil - workspace:GetServerTimeNow()

          if v431 > 0 then
            local v432 = math.floor(v431 / 60)
            local v433 = math.floor(v431 % 60)

            table.insert(v430, "Cooldown:   <font color='#FFA726'>[Active]</font>   " .. v432 .. "m "
              .. v433 .. "s remaining")
          else
            table.insert(v430, "Cooldown:   <font color='#00E676'>[Ready]</font>")
          end

          table.insert(v430, "Spins:   " .. v12.Data.FriendOTronSpins)

          if v12.Data.FriendOTronPendingSeedKey ~= "" then
            table.insert(
              v430, "My Seed:    <font color='#FFA726'>Deposited (Waiting for Friend)</font>"
            )
          end

          v12.Paragraph.FriendOTronInfo:SetContent(table.concat(v430, "\n"))
        end
      end)

      task.wait(10)
    end
  end)
end

local function f107()
  if v12.Flags.IsAutoFriendOTronRunning then
    return
  end

  if not (v7.Options.Toggle_AutoFriendOTronSeed.Value
    or v7.Options.Toggle_AutoFriendOTronRarity.Value) then
    return
  end

  if v7.Options.Toggle_AutoFriendOTronSeed.Value then
    local value169 = v7.Options.Dropdown_FriendOTronSeedName.Value

    if type(value169) ~= "table" or next(value169) == nil then
      return
    end
  elseif v7.Options.Toggle_AutoFriendOTronRarity.Value then
    local value170 = v7.Options.Dropdown_FriendOTronRarity.Value

    if type(value170) ~= "table" or next(value170) == nil then
      return
    end
  end

  v12.Flags.IsAutoFriendOTronRunning = true

  task.spawn(function()
    while not v7.Unloaded
      and (v7.Options.Toggle_AutoFriendOTronSeed.Value
        or v7.Options.Toggle_AutoFriendOTronRarity.Value) do
      local v434 = false

      repeat
        local v435 = v12.Data.FriendOTronCooldownUntil - workspace:GetServerTimeNow()

        if v435 > 0 then
          task.wait(math.clamp(v435, 3, 5))
          v434 = true
          break
        end

        if v12.Data.FriendOTronPendingSeedKey ~= "" then
          task.wait(3)
          v434 = true
          break
        end

        local friendOTron3 = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("FriendOTron")

        local insertSeed2 = friendOTron3 and friendOTron3:FindFirstChild("InsertSeed")
        local friendOTron4 = workspace:FindFirstChild("FriendOTron")

        if not insertSeed2 or not friendOTron4 then
          task.wait(3)
          v434 = true
          break
        end

        local value171 = v7.Options.Dropdown_FriendOTronTargetSlot.Value or "Any Empty Slot"
        local v436 = {}

        if value171 == "Blue Slot" then
          v436 = { "Blue" }
        elseif value171 == "Purple Slot" then
          v436 = { "Purple" }
        else
          v436 = { "Blue", "Purple" }
        end

        for index106, value172 in ipairs(v436) do
          local v437 = false

          repeat
            if not (v7.Options.Toggle_AutoFriendOTronSeed.Value
              or v7.Options.Toggle_AutoFriendOTronRarity.Value) then
              break
            end

            if friendOTron4:FindFirstChild("FriendOTronSeedVisual_" .. value172) ~= nil then
              v437 = true
              break
            end

            local v438 = f104()

            if not v438 then
              v437 = true
              break
            end

            f16(v438)
            task.wait(0.2)
            pcall(function() insertSeed2:InvokeServer(value172) end)
            task.wait(0.2)
            f15()
            break
          until true

          if not v437 then
            break
          end
        end

        task.wait(3)
        v434 = true
      until true

      if not v434 then
        break
      end
    end

    v12.Flags.IsAutoFriendOTronRunning = false
  end)
end

local function f108()
  if v12.Flags.IsAutoFriendOTronSpinRunning then
    return
  end

  if not v7.Options.Toggle_AutoFriendOTronSpin.Value then
    return
  end

  v12.Flags.IsAutoFriendOTronSpinRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoFriendOTronSpin.Value do
      local v439 = false

      repeat
        local friendOTron5 = replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("FriendOTron")

        local pullLever2 = friendOTron5 and friendOTron5:FindFirstChild("PullLever")

        if not pullLever2 then
          task.wait(3)
          v439 = true
          break
        end

        if v12.Data.FriendOTronSpins <= 0 then
          task.wait(3)
          v439 = true
          break
        end

        pcall(function() pullLever2:InvokeServer() end)
        task.wait(2.5)
        v439 = true
      until true

      if not v439 then
        break
      end
    end

    v12.Flags.IsAutoFriendOTronSpinRunning = false
  end)
end

local function f109()
  local v440 = f30(1)
  local petMutation = v440 and v440.PetMutation
  local session = petMutation and petMutation.Session

  if type(session) ~= "table" or session.State ~= "Incubating" then
    return "Idle", nil, 0
  end

  local getServerTimeNow3 = workspace:GetServerTimeNow()

  if not session.ExpiresAt or session.ExpiresAt <= getServerTimeNow3 then
    return "Ready", session, 0
  end

  return "Incubating", session, math.max(0, math.floor(session.ExpiresAt - getServerTimeNow3))
end

local function f110()
  task.spawn(function()
    while not v7.Unloaded do
      if v12.Paragraph.PetMutationInfo then
        local v441, v442, v443 = f109()
        local v444 = f30(1)
        local petMutation2 = v444 and v444.PetMutation
        local v445 = {}

        if v441 == "Incubating" then
          local v446 = math.floor(v443 / 3600)
          local v447 = math.floor(v443 % 3600 / 60)
          local v448 = v443 % 60

          local v449 = v446 > 0 and string.format("%dh %02dm %02ds", v446, v447, v448)
            or string.format("%02dm %02ds", v447, v448)

          table.insert(v445, "<b>Status:</b> <font color=\"#FFA726\">Incubating</font> (Time Left: "
            .. v449 .. ")")
        elseif v441 == "Ready" then
          table.insert(v445, "<b>Status:</b> <font color=\"#00E676\">Ready to Claim</font>")
        else
          table.insert(v445, "<b>Status:</b> <font color=\"#888888\">Idle</font>")
        end

        if v442 and type(v442.Pet) == "table" then
          local pet = v442.Pet
          local name2 = pet.Name or "Unknown"
          local level3 = pet.Level or 1

          local mutation2 = pet.Mutation and pet.Mutation ~= "" and pet.Mutation ~= "Normal"
              and " (" .. pet.Mutation .. ")"
            or ""

          table.insert(v445, "<b>Pet:</b> " .. name2 .. " [Lv " .. level3 .. "]" .. mutation2)
        end

        local v450 = petMutation2 and tonumber(petMutation2.Pity) or 0
        table.insert(v445, "<b>Pity:</b> " .. v450 .. " / 100")

        if petMutation2 and type(petMutation2.Upgrades) == "table" then
          local upgrades = petMutation2.Upgrades

          table.insert(v445, string.format(
            "<b>Upgrades:</b> Speed: %d/5 | Luck: %d/5 | Discount: %d/5",
            upgrades.IncubatorSpeed or 0, upgrades.MutationLuck or 0,
            upgrades.RerollDiscount or 0
          ))
        end

        v12.Paragraph.PetMutationInfo:SetContent(table.concat(v445, "\n"))
      end

      task.wait(10)
    end
  end)
end

local function f111()
  if v12.Flags.IsClaimDailyRewardLoopRunning or not v7.Options.Toggle_AutoClaimDailyReward.Value then
    return
  end

  v12.Flags.IsClaimDailyRewardLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoClaimDailyReward.Value do
      pcall(function()
        if replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("GetDailyRewardState")
          and replicatedStorage.Remotes:FindFirstChild("ClaimDailyReward") then
          local invokeServer = replicatedStorage.Remotes.GetDailyRewardState:InvokeServer()

          if type(invokeServer) == "table"
            and (not invokeServer.SecondsUntilNext or invokeServer.SecondsUntilNext <= 0) then
            if replicatedStorage.Remotes.ClaimDailyReward:InvokeServer() then
              v7:Notify({
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

    v12.Flags.IsClaimDailyRewardLoopRunning = false
  end)
end

local function f112()
  if v12.Flags.IsClaimPlaytimeRewardLoopRunning
    or not v7.Options.Toggle_AutoClaimPlaytimeReward.Value then
    return
  end

  v12.Flags.IsClaimPlaytimeRewardLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoClaimPlaytimeReward.Value do
      pcall(function()
        if replicatedStorage:FindFirstChild("Remotes")
          and replicatedStorage.Remotes:FindFirstChild("GetPlaytimeRewardState")
          and replicatedStorage.Remotes:FindFirstChild("ClaimPlaytimeReward") then
          local invokeServer2 = replicatedStorage.Remotes.GetPlaytimeRewardState:InvokeServer()

          if type(invokeServer2) == "table" then
            local claimedMap = invokeServer2.ClaimedMap or {}

            for i12 = 1, invokeServer2.EarnedCount or 0 do
              if not v7.Options.Toggle_AutoClaimPlaytimeReward.Value then
                break
              end

              if not (claimedMap[tostring(i12)] == true) then
                if replicatedStorage.Remotes.ClaimPlaytimeReward:InvokeServer(i12) then
                  v7:Notify({
                    Title = "Playtime Reward",
                    Content = "Claimed Playtime Reward #" .. tostring(i12),
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

    v12.Flags.IsClaimPlaytimeRewardLoopRunning = false
  end)
end

local function f113()
  if v12.Flags.IsSpinWheelLoopRunning or not v7.Options.Toggle_AutoSpinWheel.Value then
    return
  end

  v12.Flags.IsSpinWheelLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoSpinWheel.Value do
      local requestSpin = replicatedStorage:FindFirstChild("Remotes")
        and replicatedStorage.Remotes:FindFirstChild("SpinWheel")
        and replicatedStorage.Remotes.SpinWheel:FindFirstChild("RequestSpin")

      if requestSpin then
        requestSpin:InvokeServer(true)
      end

      task.wait(10)
    end

    v12.Flags.IsSpinWheelLoopRunning = false
  end)
end

local function f114()
  if v12.Flags.IsAutoOpenCratePackLoopRunning or not v7.Options.Toggle_AutoOpenCratePack.Value then
    return
  end

  v12.Flags.IsAutoOpenCratePackLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoOpenCratePack.Value do
      local requestOpenSeedPack = replicatedStorage:FindFirstChild("Remotes")
        and replicatedStorage.Remotes:FindFirstChild("RequestOpenSeedPack")

      local seedPackOpenFinished = replicatedStorage:FindFirstChild("Remotes")
        and replicatedStorage.Remotes:FindFirstChild("SeedPackOpenFinished")

      if requestOpenSeedPack and seedPackOpenFinished then
        local character5 = localPlayer.Character
        local humanoid12 = character5 and character5:FindFirstChild("Humanoid")
        local backpack4 = localPlayer:FindFirstChild("Backpack")

        local function f115(p117)
          if not p117 then
            return nil
          end

          for index107, value173 in ipairs(p117:GetChildren()) do
            if value173:IsA("Tool") then
              local v451 = string.lower(value173.Name)

              if string.find(v451, "crate") or string.find(v451, "pack") then
                return value173
              end
            end
          end

          return nil
        end

        local tool7 = character5 and character5:FindFirstChildWhichIsA("Tool")

        if tool7 then
          local v452 = string.lower(tool7.Name)

          if string.find(v452, "crate") or string.find(v452, "pack") then
            requestOpenSeedPack:FireServer()
            task.wait(0.1)
            seedPackOpenFinished:FireServer()
            task.wait(0.2)
          end
        end

        local v453 = f115(backpack4)

        if v453 and humanoid12 then
          humanoid12:EquipTool(v453)
          task.wait(0.2)
          requestOpenSeedPack:FireServer()
          task.wait(0.1)
          seedPackOpenFinished:FireServer()
          task.wait(0.2)
          humanoid12:UnequipTools()
        end
      end

      task.wait(1)
    end

    v12.Flags.IsAutoOpenCratePackLoopRunning = false
  end)
end

local function f116()
  if v12.Flags.IsAutoRollVaultRunning then
    return
  end

  if not (v7.Options.Toggle_AutoRollVault and v7.Options.Toggle_AutoRollVault.Value) then
    return
  end

  v12.Flags.IsAutoRollVaultRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoRollVault
      and v7.Options.Toggle_AutoRollVault.Value do
      pcall(function()
        local v454 = f29()
        local vault = v454 and v454.Vault

        if not vault and v11 then
          local v455, v456 = pcall(v11.GetReplicator)

          if v455 and v456 then
            vault = v456:Get({ "Vault" })
          end
        end

        local v457 = vault and math.max(0, math.floor(tonumber(vault.Credits) or 0)) or 0
        local v458 = vault and tonumber(vault.FreeRollDay) or 0
        local v459 = vault and tonumber(vault.FreeRollsUsed) or 0
        local getServerTimeNow4 = workspace:GetServerTimeNow()
        local v460 = v458 ~= math.floor(getServerTimeNow4 / 86400) or v459 < 1

        if v457 > 0 or v460 then
          local v461 = f21("VaultService", "RF", "Roll")

          if v461 then
            local v462, v463 = pcall(function() return v461:InvokeServer() end)

            if v462 and (type(v463) ~= "table" or v463.ok ~= false) then
              v12.Cache.ReplicatorSnapshotTime = 0
              task.wait(1)
              return
            end
          end
        end
      end)

      task.wait(10)
    end

    v12.Flags.IsAutoRollVaultRunning = false
  end)
end

local function f117()
  if v12.Flags.IsAutoClaimGuildMissionsRunning
    or not v7.Options.Toggle_AutoClaimGuildMissions.Value then
    return
  end

  v12.Flags.IsAutoClaimGuildMissionsRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoClaimGuildMissions.Value do
      local getMissions = f28("GetMissions")

      if type(getMissions) == "table" then
        for index108, value174 in ipairs({ "Hourly", "Daily", "Weekly" }) do
          local v464 = getMissions[value174]

          if type(v464) == "table" then
            for index109, value175 in ipairs(v464) do
              if not v7.Options.Toggle_AutoClaimGuildMissions.Value then
                break
              end

              if value175.complete and not value175.claimed then
                local v465 = f28("ClaimMission", value174, value175.id)

                if type(v465) == "table" and v465.ok then
                  v7:Notify({
                    Title = "Guild Mission",
                    Content = "Claimed " .. (value175.stat or "mission") .. " reward",
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

    v12.Flags.IsAutoClaimGuildMissionsRunning = false
  end)
end

local function f118()
  if v12.Flags.IsAutoClaimGuildWeeklyRunning or not v7.Options.Toggle_AutoClaimGuildWeekly.Value then
    return
  end

  v12.Flags.IsAutoClaimGuildWeeklyRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoClaimGuildWeekly.Value do
      local getMyGuild = f28("GetMyGuild")

      if type(getMyGuild) == "table" and getMyGuild.inGuild then
        local getRewardTiers = f28("GetRewardTiers")

        if type(getRewardTiers) == "table" and getRewardTiers.ok then
          for index110, value176 in ipairs(getRewardTiers.tiers) do
            if not v7.Options.Toggle_AutoClaimGuildWeekly.Value then
              break
            end

            if not value176.claimed and value176.guildThreshold <= (getMyGuild.weeklyTotal or 0)
              and value176.personalMinimum <= (getMyGuild.personalWeekly or 0) then
              local v466 = f28("ClaimWeeklyTier", value176.tier)

              if type(v466) == "table" and v466.ok then
                v7:Notify({
                  Title = "Guild Weekly",
                  Content = "Claimed Tier " .. tostring(value176.tier),
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

    v12.Flags.IsAutoClaimGuildWeeklyRunning = false
  end)
end

local function f119()
  if v12.Flags.IsAutoBuyGuildShopRunning or not v7.Options.Toggle_AutoBuyGuildShop.Value then
    return
  end

  v12.Flags.IsAutoBuyGuildShopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoBuyGuildShop.Value do
      local getShop = f28("GetShop")

      if type(getShop) == "table" then
        local value177 = v7.Options.Dropdown_AutoBuyGuildShopItems.Value

        for index111, value178 in ipairs(getShop) do
          if not v7.Options.Toggle_AutoBuyGuildShop.Value then
            break
          end

          local displayName5 = value178.displayName

          if type(value177) ~= "table" or value177[displayName5] then
            if value178.remaining > 0 and value178.affordable then
              f28("BuyShopItem", value178.id)
              task.wait(0.5)
            end
          end
        end
      end

      task.wait(60)
    end

    v12.Flags.IsAutoBuyGuildShopRunning = false
  end)
end

local function f120()
  if v12.Flags.IsAutoRallyLoopRunning then
    return
  end

  v12.Flags.IsAutoRallyLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded do
      if not (v7.Options.Toggle_AutoStartRally and v7.Options.Toggle_AutoStartRally.Value
        or v7.Options.Toggle_AutoStartGuildFishingRally
          and v7.Options.Toggle_AutoStartGuildFishingRally.Value) then
        break
      end

      pcall(function()
        local v467 = false
        local getRally = f28("GetRally")

        if type(getRally) == "table" and getRally.inGuild and getRally.canStart then
          v467 = true
        end

        if not v467 then
          local getGuildEventState = f28("GetGuildEventState")

          if type(getGuildEventState) == "table" and type(getGuildEventState.rally) == "table"
            and getGuildEventState.rally.canStart then
            v467 = true
          end
        end

        if v467 then
          f28("StartRally")
        end
      end)

      task.wait(60)
    end

    v12.Flags.IsAutoRallyLoopRunning = false
  end)
end

local function f121()
  local value179 = v7.Options.Dropdown_PetMutationPetNames
      and v7.Options.Dropdown_PetMutationPetNames.Value
    or {}

  local value180 = v7.Options.Dropdown_PetMutationWhitelistMutations
      and v7.Options.Dropdown_PetMutationWhitelistMutations.Value
    or {}

  if not next(value179) then
    return nil
  end

  local petMutationConfig = v12.Data.PetMutationConfig or GetPetMutationConfig()
  local v468 = f30(1)
  local petMutation3 = v468 and v468.PetMutation

  local rerollDiscount = petMutation3 and petMutation3.Upgrades
      and petMutation3.Upgrades.RerollDiscount
    or 0

  local v469 = GetPlayerCash()

  for index112, value181 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value181 then
      for index113, value182 in ipairs(value181:GetChildren()) do
        local v470 = false

        repeat
          if value182:IsA("Tool") then
            local v471 = f11(value182)

            if v471 and value179[v471.petName] and (v471.level or 1) >= 50 then
              local petMutation4 = v471.petMutation or "Normal"
              local v472 = false

              if type(value180) == "table" then
                if value180[petMutation4] then
                  v472 = true
                else
                  for index114, value183 in ipairs(value180) do
                    if value183 == petMutation4 then
                      v472 = true
                      break
                    end
                  end
                end
              end

              if not v472 then
                local v473 = f7(v471.petName)

                if v473 and petMutationConfig
                  and type(petMutationConfig.GetMutationCost) == "function" then
                  local v474 = petMutation4 ~= "Normal" and petMutation4 ~= ""
                  local v475 = petMutationConfig.GetMutationCost(v473, v474, rerollDiscount)

                  if v475 and v475 > 0 and v469 < v475 then
                    v470 = true
                    break
                  end
                end

                return v471
              end
            end
          end

          v470 = true
        until true

        if not v470 then
          break
        end
      end
    end
  end

  return nil
end

local function f122()
  if v12.Flags.IsAutoBuyPetMutationUpgradesRunning
    or not v7.Options.Toggle_AutoBuyPetMutationUpgrades.Value then
    return
  end

  v12.Flags.IsAutoBuyPetMutationUpgradesRunning = true
  local v476 = f21("PetMutationService", "RF", "BuyUpgrade")
  local petMutationConfig2 = v12.Data.PetMutationConfig or GetPetMutationConfig()

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoBuyPetMutationUpgrades.Value do
      if v476 and petMutationConfig2 and petMutationConfig2.UpgradeCosts then
        local v477 = f30(1)
        local petMutation5 = v477 and v477.PetMutation
        local upgrades2 = petMutation5 and petMutation5.Upgrades or {}
        local value184 = v7.Options.Dropdown_PetMutationUpgradeSelection.Value or {}
        local v478 = GetPlayerCash()

        for index115, value185 in ipairs({ "IncubatorSpeed", "MutationLuck", "RerollDiscount" }) do
          if value184[value185] then
            local v479 = upgrades2[value185] or 0

            if v479 < 5 then
              local v480 = petMutationConfig2.UpgradeCosts[value185]
                and petMutationConfig2.UpgradeCosts[value185][v479 + 1]

              if v480 and v480 > 0 and v478 >= v480 then
                pcall(function() v476:InvokeServer(value185) end)
                v478 = v478 - v480
                task.wait(1)
              end
            end
          end
        end
      end

      task.wait(5)
    end

    v12.Flags.IsAutoBuyPetMutationUpgradesRunning = false
  end)
end

local function f123()
  if v12.Flags.IsAutoStartPetMutationRunning or not v7.Options.Toggle_AutoStartPetMutation.Value then
    return
  end

  v12.Flags.IsAutoStartPetMutationRunning = true
  local v481 = f21("PetMutationService", "RF", "StartMutation")
  local v482 = f21("PetMutationService", "RF", "Claim")

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoStartPetMutation.Value do
      local v483, v484, v485 = f109()

      if v483 == "Ready" then
        if v7.Options.Toggle_AutoClaimPetMutation.Value and v482 then
          pcall(function() v482:InvokeServer() end)
        end

        task.wait(3)
      elseif v483 == "Idle" then
        local v486 = f121()

        if v486 and v481 then
          if v486.instance.Parent ~= localPlayer.Character then
            f16(v486.instance)
            task.wait(0.5)
          end

          pcall(function() v481:InvokeServer(v486.petKey) end)
          task.wait(0.5)
          f15()
          task.wait(3)
        else
          task.wait(5)
        end
      elseif v483 == "Incubating" then
        task.wait(math.clamp(v485, 3, 5))
      else
        task.wait(3)
      end
    end

    v12.Flags.IsAutoStartPetMutationRunning = false
  end)
end

local function f124()
  if v12.Flags.IsAutoClaimPetMutationRunning or not v7.Options.Toggle_AutoClaimPetMutation.Value then
    return
  end

  v12.Flags.IsAutoClaimPetMutationRunning = true
  local v487 = f21("PetMutationService", "RF", "Claim")

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoClaimPetMutation.Value do
      local v488, v489, v490 = f109()

      if v488 == "Ready" and v487 then
        pcall(function() v487:InvokeServer() end)
        task.wait(3)
      elseif v488 == "Incubating" then
        task.wait(math.clamp(v490, 3, 5))
      else
        task.wait(5)
      end
    end

    v12.Flags.IsAutoClaimPetMutationRunning = false
  end)
end

local function f125()
  if v12.Flags.IsAutoClaimSeasonPassQuestsRunning
    or not (v7.Options.Toggle_AutoClaimSeasonPassQuests
      and v7.Options.Toggle_AutoClaimSeasonPassQuests.Value) then
    return
  end

  v12.Flags.IsAutoClaimSeasonPassQuestsRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoClaimSeasonPassQuests
      and v7.Options.Toggle_AutoClaimSeasonPassQuests.Value do
      pcall(function()
        local v491 = f33()
        local v492 = f21("SeasonPassService", "RF", "ClaimQuest")

        if v491 and v492 and v491.Quests then
          for key26, value186 in pairs(v491.Quests) do
            if type(value186) == "table" then
              for key27, value187 in pairs(value186) do
                if not (v7.Options.Toggle_AutoClaimSeasonPassQuests
                  and v7.Options.Toggle_AutoClaimSeasonPassQuests.Value) then
                  break
                end

                pcall(function() v492:InvokeServer(key26, key27) end)
                task.wait(0.1)
              end
            end
          end
        end
      end)

      task.wait(30)
    end

    v12.Flags.IsAutoClaimSeasonPassQuestsRunning = false
  end)
end

local function f126()
  if v12.Flags.IsAutoClaimSeasonPassRewardsRunning
    or not (v7.Options.Toggle_AutoClaimSeasonPassRewards
      and v7.Options.Toggle_AutoClaimSeasonPassRewards.Value) then
    return
  end

  v12.Flags.IsAutoClaimSeasonPassRewardsRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoClaimSeasonPassRewards
      and v7.Options.Toggle_AutoClaimSeasonPassRewards.Value do
      pcall(function()
        local v493 = f21("SeasonPassService", "RF", "ClaimAllRewards")

        if v493 then
          pcall(function() v493:InvokeServer() end)
        end
      end)

      task.wait(30)
    end

    v12.Flags.IsAutoClaimSeasonPassRewardsRunning = false
  end)
end

local function f127()
  if v12.Flags.IsAutoSpinSeasonPassCrateRunning
    or not (v7.Options.Toggle_AutoSpinSeasonPassCrate
      and v7.Options.Toggle_AutoSpinSeasonPassCrate.Value) then
    return
  end

  v12.Flags.IsAutoSpinSeasonPassCrateRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoSpinSeasonPassCrate
      and v7.Options.Toggle_AutoSpinSeasonPassCrate.Value do
      pcall(function()
        local v494 = f33()
        local v495 = f21("SeasonPassService", "RF", "PurchaseUseSpin")

        if v495 and v494 then
          local v496 = f29()
          local v497 = tostring(v494.CurrentSeason or 4)
          local seasonPasses = v496 and v496.SeasonPasses and v496.SeasonPasses[v497]
          local spinCount = seasonPasses and seasonPasses.SpinCount or 0
          local v498 = f34(v494)
          local spinCost = v494.SpinCost or 125

          if spinCount > 0 or v498 >= spinCost then
            pcall(function() v495:InvokeServer() end)
          end
        end
      end)

      task.wait(2)
    end

    v12.Flags.IsAutoSpinSeasonPassCrateRunning = false
  end)
end

local function f128()
  local v499 = f30(1)
  local session2 = v499 and v499.Fuse and v499.Fuse.Session

  if type(session2) ~= "table" or type(session2.Inserted) ~= "table" then
    return "Idle", nil, 0
  end

  if session2.State == "Staging" then
    return "Staging", session2, 0
  end

  if session2.State ~= "Fusing" or type(session2.ExpiresAt) ~= "number" then
    return "Idle", nil, 0
  end

  local getServerTimeNow5 = workspace:GetServerTimeNow()

  if session2.ExpiresAt <= getServerTimeNow5 then
    return "Ready", session2, 0
  end

  return "Fusing", session2, math.max(0, math.floor(session2.ExpiresAt - getServerTimeNow5))
end

local function f129()
  local value188 = v7.Options.Toggle_AutoFuseSelected
    and v7.Options.Toggle_AutoFuseSelected.Value

  local value189 = v7.Options.Toggle_AutoFuseByRarity
    and v7.Options.Toggle_AutoFuseByRarity.Value

  if not value188 and not value189 then
    return nil
  end

  local value190 = v7.Options.Dropdown_FuseSeeds and v7.Options.Dropdown_FuseSeeds.Value or {}

  local value191 = v7.Options.Dropdown_FuseRarities and v7.Options.Dropdown_FuseRarities.Value
    or {}

  if value188 and next(value190) == nil then
    return nil
  end

  if value189 and next(value191) == nil then
    return nil
  end

  for index116, value192 in ipairs({
    localPlayer:FindFirstChild("Backpack"), localPlayer.Character,
  }) do
    if value192 then
      for index117, value193 in ipairs(value192:GetChildren()) do
        if value193:IsA("Tool") and value193:GetAttribute("InventoryCategory") == "Seeds" then
          if not f38(value193) and value193:GetAttribute("Fused") ~= true then
            local plant3 = value193:GetAttribute("Plant") or value193:GetAttribute("trueName")

            if plant3 then
              local v500 = false

              if value188 and value190[plant3] == true then
                v500 = true
              elseif value189 then
                if value191[f6(plant3)] == true then
                  v500 = true
                end
              end

              if v500 then
                return value193
              end
            end
          end
        end
      end
    end
  end

  return nil
end

local function f130(p118)
  if not p118 or not p118.Parent then
    return false
  end

  f16(p118)
  local v501, v502 = f32("Stage")
  f15()
  task.wait(0.55)
  return v501
end

local function f131()
  if v12.Flags.IsAutoFuseLoopRunning then
    return
  end

  if not (v7.Options.Toggle_AutoFuseSelected.Value or v7.Options.Toggle_AutoFuseByRarity.Value) then
    return
  end

  v12.Flags.IsAutoFuseLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded
      and (v7.Options.Toggle_AutoFuseSelected.Value or v7.Options.Toggle_AutoFuseByRarity.Value) do
      local v503, v504, v505 = f128()

      if v503 == "Ready" then
        f32("Collect")
        task.wait(3)
      elseif v503 == "Idle" or v503 == "Staging" then
        if (v504 and type(v504.Inserted) == "table" and #v504.Inserted or 0) >= 4 then
          f32("StartFuse")
          task.wait(3)
        else
          local v506 = f129()

          if v506 then
            f130(v506)
          else
            task.wait(5)
          end
        end
      elseif v503 == "Fusing" then
        task.wait(math.clamp(v505, 3, 5))
      else
        task.wait(3)
      end
    end

    v12.Flags.IsAutoFuseLoopRunning = false
  end)
end

local function f132()
  task.spawn(function()
    while not v7.Unloaded do
      if v12.Paragraph.FuseInfo then
        local v507, v508, v509 = f128()
        local v510 = {}

        if v507 == "Fusing" then
          local v511 = math.floor(v509 / 3600)
          local v512 = math.floor(v509 % 3600 / 60)
          local v513 = v509 % 60

          local v514 = v511 > 0 and string.format("%dh %02dm %02ds", v511, v512, v513)
            or string.format("%02dm %02ds", v512, v513)

          table.insert(v510, "<b>Status:</b> <font color=\"#FFA726\">Fusing</font> (Time Left: "
            .. v514 .. ")")
        elseif v507 == "Ready" then
          table.insert(v510, "<b>Status:</b> <font color=\"#00E676\">Ready to Collect</font>")
        elseif v507 == "Staging" then
          local v515 = v508 and type(v508.Inserted) == "table" and #v508.Inserted or 0

          table.insert(v510, "<b>Status:</b> <font color=\"#40C4FF\">Staging</font> (" .. v515
            .. "/4 seeds inserted)")
        else
          table.insert(v510, "<b>Status:</b> <font color=\"#888888\">Idle</font> (0/4 seeds)")
        end

        if v508 and type(v508.Inserted) == "table" and #v508.Inserted > 0 then
          table.insert(v510, "")
          table.insert(v510, "<b>Inserted Seeds:</b>")

          for index118, value194 in ipairs(v508.Inserted) do
            local name3 = value194.Name or "Unknown"

            local mutation3 = value194.Mutation and value194.Mutation ~= "Normal"
                and " (" .. value194.Mutation .. ")"
              or ""

            table.insert(v510, string.format("- Slot %d: %s%s", index118, name3, mutation3))
          end
        end

        v12.Paragraph.FuseInfo:SetContent(table.concat(v510, "\n"))
      end

      task.wait(10)
    end
  end)
end

local function f133()
  local getServerTimeNow6 = workspace:GetServerTimeNow()
  local v516 = GetWanderingMerchantConfig()
  local v517 = false
  local v518 = nil
  local v519 = nil

  local wanderingMerchant = workspace:FindFirstChild("InteractiveEvents")
    and workspace.InteractiveEvents:FindFirstChild("WanderingMerchant")

  if wanderingMerchant and #wanderingMerchant:GetChildren() > 1 then
    v517 = true
  end

  if v516 and type(v516.GetActiveVisit) == "function" then
    local v520, v521 = v516.GetActiveVisit(getServerTimeNow6)

    if v520 and v521 and getServerTimeNow6 >= v520 and getServerTimeNow6 < v521 then
      v517 = true
      v518 = v520
      v519 = v521
    elseif v520 and v521 and v517 then
      v518 = v520
      v519 = v521
    end
  end

  local v522 = nil

  if v516 and type(v516.GetNextVisitAt) == "function" then
    v522 = v516.GetNextVisitAt(getServerTimeNow6)
  end

  local v523 = 0

  if v517 and v519 and v519 > getServerTimeNow6 then
    v523 = math.max(0, math.floor(v519 - getServerTimeNow6))
  end

  return v517, v518, v519, v523, v522
end

local function f134()
  task.spawn(function()
    while not v7.Unloaded do
      pcall(function()
        if v12.Paragraph.WanderingMerchantInfo then
          local v524, v525, v526, v527, v528 = f133()

          if v524 and v527 > 0 then
            local v529 = math.floor(v527 / 3600)
            local v530 = math.floor(v527 % 3600 / 60)
            local v531 = v527 % 60

            local v532 = v529 > 0 and string.format("%dh %02dm %02ds", v529, v530, v531)
              or string.format("%dm %02ds", v530, v531)

            v12.Paragraph.WanderingMerchantInfo:SetContent("Time Remaining: <font color=\"#00E676\">"
              .. v532 .. "</font>")
          else
            local getServerTimeNow7 = workspace:GetServerTimeNow()

            if v528 and v528 > getServerTimeNow7 then
              local v533 = math.max(0, math.floor(v528 - getServerTimeNow7))
              local v534 = math.floor(v533 / 3600)
              local v535 = math.floor(v533 % 3600 / 60)
              local v536 = v533 % 60
              local v537 = string.format("%dh %02dm %02ds", v534, v535, v536)

              v12.Paragraph.WanderingMerchantInfo:SetContent("Next Visit In: <font color=\"#40C4FF\">"
                .. v537 .. "</font>")
            else
              v12.Paragraph.WanderingMerchantInfo:SetContent("The merchant is away")
            end
          end
        end
      end)

      task.wait(5)
    end
  end)
end

local function f135()
  local v538 = GetWanderingMerchantConfig()

  if not v538 then
    return nil, nil, nil
  end

  local v539, v540 = f133()

  if not v539 then
    return nil, nil, v538
  end

  local v541 = f29()
  local invokeServer3 = nil
  local v542 = f21("WanderingMerchantService", "RF", "GetState")

  if v542 then
    pcall(function() invokeServer3 = v542:InvokeServer() end)
  end

  local wanderingMerchant2 = v541 and v541.WanderingMerchant or invokeServer3

  local visit = wanderingMerchant2 and wanderingMerchant2.Visit
    or invokeServer3 and invokeServer3.Visit or type(invokeServer3) == "table" and invokeServer3

  local completed = visit and visit.Completed or invokeServer3 and invokeServer3.Completed

  local v543 = v540 or visit and tonumber(visit.Id or visit.VisitId)
    or invokeServer3 and tonumber(invokeServer3.VisitId)

  local orders = visit and type(visit.Orders) == "table" and visit.Orders
    or invokeServer3 and type(invokeServer3.Orders) == "table" and invokeServer3.Orders or nil

  local v544 = nil

  if v543 and type(v538.RollVisitOrders) == "function" then
    local v545, v546 = pcall(v538.RollVisitOrders, v543)

    if v545 and type(v546) == "table" then
      v544 = v546
    end
  end

  local v547 = {}

  for index119, value195 in ipairs(v538.TierOrder or { "Accessible", "MidLate", "Chase" }) do
    local v548 = orders and orders[value195] or v544 and v544[value195]

    if v548 then
      v547[value195] = v548
    end
  end

  if next(v547) ~= nil then
    return v547, completed, v538
  end

  if type(orders) == "table" and next(orders) ~= nil then
    return orders, completed, v538
  end

  return nil, completed, v538
end

local function f136()
  if v12.Flags.IsAutoSubmitMerchantTradesRunning
    or not (v7.Options.Toggle_AutoSubmitMerchantTrades
      and v7.Options.Toggle_AutoSubmitMerchantTrades.Value) then
    return
  end

  v12.Flags.IsAutoSubmitMerchantTradesRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoSubmitMerchantTrades
      and v7.Options.Toggle_AutoSubmitMerchantTrades.Value do
      local v549 = false
      local v550 = false

      if not f133() then
        v550 = true
      else
        local v551, v552, v553 = f135()

        if type(v551) == "table" and next(v551) ~= nil then
          local v554 = f21("WanderingMerchantService", "RF", "SubmitTrade")

          if v554 then
            local backpack5 = localPlayer:FindFirstChild("Backpack")
            local character6 = localPlayer.Character

            for key28, value196 in pairs(v551) do
              if not (v7.Options.Toggle_AutoSubmitMerchantTrades
                and v7.Options.Toggle_AutoSubmitMerchantTrades.Value) then
                break
              end

              if type(value196) == "string" and not (v552 and v552[value196] == true) then
                local v555 = v553.GetTrade(value196)

                if v555 and v555.Def and type(v555.Def.Predicate) == "function" then
                  local v556 = nil

                  for index120, value197 in ipairs({ backpack5, character6 }) do
                    if value197 then
                      for index121, value198 in ipairs(value197:GetChildren()) do
                        if value198:IsA("Tool") then
                          if not f38(value198) then
                            local plant4 = value198:GetAttribute("Plant")
                              or value198:GetAttribute("seedKey")

                            if plant4 then
                              local mutation4 = value198:GetAttribute("Mutation") or "Normal"
                              local fused = value198:GetAttribute("Fused") or false

                              local v557, v558 = pcall(
                                v555.Def.Predicate, plant4, mutation4, nil, fused
                              )

                              if v557 and v558 then
                                v556 = value198
                                break
                              end
                            end
                          end
                        end
                      end
                    end

                    if v556 then
                      break
                    end
                  end

                  if v556 then
                    f16(v556)
                    local seedKey3 = v556:GetAttribute("seedKey") or v556.Name

                    local v559, v560 = pcall(function()
                      return v554:InvokeServer(value196, seedKey3)
                    end)

                    if v559 and type(v560) == "table" then
                      if v560.ok == true then
                        v12.Cache.ReplicatorSnapshotTime = 0
                        v549 = true
                      elseif v560.ok == false
                        and string.find(tostring(v560.error), "away", 1, true) then
                        v550 = true
                      end
                    end
                  end
                end
              end

              if v550 then
                break
              end
            end
          end
        end
      end

      if v549 then
        task.wait(0.5)
      elseif v550 then
        task.wait(10)
      else
        task.wait(5)
      end
    end

    v12.Flags.IsAutoSubmitMerchantTradesRunning = false
  end)
end

local function f137()
  if v12.Flags.IsAutoBuyMerchantShopRunning
    or not (v7.Options.Toggle_AutoBuyMerchantShop and v7.Options.Toggle_AutoBuyMerchantShop.Value) then
    return
  end

  v12.Flags.IsAutoBuyMerchantShopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoBuyMerchantShop
      and v7.Options.Toggle_AutoBuyMerchantShop.Value do
      local v561 = false
      local v562 = false

      if not f133() then
        v562 = true
      else
        local v563 = GetWanderingMerchantConfig()
        local v564 = f29()
        local invokeServer4 = nil
        local v565 = f21("WanderingMerchantService", "RF", "GetState")

        if v565 then
          pcall(function() invokeServer4 = v565:InvokeServer() end)
        end

        local wanderingMerchant3 = v564 and v564.WanderingMerchant or invokeServer4

        local favor = wanderingMerchant3 and wanderingMerchant3.Favor
          or invokeServer4 and invokeServer4.Favor or 0

        local shop = wanderingMerchant3 and wanderingMerchant3.Shop
          or invokeServer4 and invokeServer4.Shop

        local value199 = v7.Options.Dropdown_MerchantShopItems
          and v7.Options.Dropdown_MerchantShopItems.Value

        if type(value199) == "table" then
          local v566 = f21("WanderingMerchantService", "RF", "BuyShopItem")

          if v566 then
            for key29, value200 in pairs(value199) do
              if value200 then
                local wanderingMerchantItemIdMap = v12.Data.WanderingMerchantItemIdMap
                  and v12.Data.WanderingMerchantItemIdMap[key29]

                if wanderingMerchantItemIdMap then
                  local v567 = v563.GetItem(wanderingMerchantItemIdMap)
                  local cost = v567 and (v567.Cost or 0) or 0

                  if (shop and shop[wanderingMerchantItemIdMap]
                          and shop[wanderingMerchantItemIdMap].Bought
                        or 0)
                      < (v567 and (v567.Stock or 1) or 1)
                    and favor >= cost then
                    local v568, v569 = pcall(function()
                      return v566:InvokeServer(wanderingMerchantItemIdMap)
                    end)

                    if v568 and type(v569) == "table" then
                      if v569.ok == true then
                        v12.Cache.ReplicatorSnapshotTime = 0
                        v561 = true
                      elseif v569.ok == false
                        and string.find(tostring(v569.error), "away", 1, true) then
                        v562 = true
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

      if v561 then
        task.wait(0.5)
      elseif v562 then
        task.wait(10)
      else
        task.wait(5)
      end
    end

    v12.Flags.IsAutoBuyMerchantShopRunning = false
  end)
end

local function f138(p119)
  pcall(function()
    local playerGui4 = localPlayer:FindFirstChild("PlayerGui")

    local plantContractsCompleted = playerGui4
      and playerGui4:FindFirstChild("PlantContractsCompleted")

    if plantContractsCompleted then
      plantContractsCompleted.Enabled = p119

      if not p119 then
        plantContractsCompleted:ClearAllChildren()
      end
    end
  end)
end

local function f139()
  if v12.Flags.IsAutoContractRunning or not v7.Options.Toggle_AutoContract.Value then
    return
  end

  v12.Flags.IsAutoContractRunning = true
  f138(false)

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoContract.Value do
      pcall(function()
        local contractsComm = v12.Cache.ContractsComm or f39()
        local contractsConfig = v12.Data.ContractsConfig or GetContractsConfig()
        local contractRegistry = v12.Data.ContractRegistry or GetContractRegistry()

        if not contractsConfig then
          return
        end

        local v570 = f40()

        if not v570 then
          return
        end

        local backpack6 = localPlayer:FindFirstChild("Backpack")
        local character7 = localPlayer.Character

        for key30, value201 in pairs(v570) do
          if not v7.Options.Toggle_AutoContract.Value then
            break
          end

          pcall(function()
            if type(value201) ~= "table" or not value201.DefinitionId then
              return
            end

            local v571 = tostring(value201.SlotKey or key30)

            local definitions = contractsConfig.Definitions
              and contractsConfig.Definitions.GetById(value201.DefinitionId)

            if not definitions then
              return
            end

            local target = definitions.Target or value201.Target or 1
            local progress = value201.Progress or 0

            if progress >= target then
              return
            end

            local minPlantValue = definitions.MinPlantValue or 0

            local minSubmittedValue = definitions.MinSubmittedValue
              or value201.MinSubmittedValue or 0

            local submittedValue = value201.SubmittedValue or 0

            if progress + 1 >= target and minSubmittedValue > 0 then
              local v572 = math.max(0, minSubmittedValue - submittedValue)

              if v572 > minPlantValue then
                minPlantValue = v572
              end
            end

            local v573, huge = nil, math.huge

            for index122, value202 in ipairs({ backpack6, character7 }) do
              if value202 then
                for index123, value203 in ipairs(value202:GetChildren()) do
                  if value203:IsA("Tool")
                    and value203:GetAttribute("InventoryCategory") == "Seeds" then
                    if not f38(value203) then
                      local plant5 = value203:GetAttribute("Plant")

                      if plant5 then
                        local mutation5 = value203:GetAttribute("Mutation") or "Normal"
                        local fused2 = value203:GetAttribute("Fused") or false

                        local v574, v575 = pcall(
                          definitions.Predicate, plant5, mutation5, nil, fused2
                        )

                        if v574 and v575 then
                          local plants2 = contractRegistry and contractRegistry.Plants
                            and contractRegistry.Plants[plant5]

                          local cost2 = plants2 and plants2.Cost or 0

                          if cost2 >= minPlantValue and cost2 < huge then
                            huge = cost2
                            v573 = value203
                          end
                        end
                      end
                    end
                  end
                end
              end
            end

            if v573 then
              f16(v573)
              task.wait(0.2)

              local v576, v577 = pcall(function()
                if contractsComm and contractsComm.Submit then
                  return contractsComm:Submit(v571)
                end

                local submit = replicatedStorage:FindFirstChild("Contracts")
                  and replicatedStorage.Contracts:FindFirstChild("RF")
                  and replicatedStorage.Contracts.RF:FindFirstChild("Submit")

                if submit then
                  return submit:InvokeServer(v571)
                end

                return nil
              end)

              if v576 and type(v577) == "table" and v577.Success then
                v12.Cache.ReplicatorSnapshotTime = 0
              end

              task.wait(0.5)
            end
          end)
        end
      end)

      task.wait(15)
    end

    v12.Flags.IsAutoContractRunning = false
    f138(true)
  end)
end

local function f140()
  local v578, v579 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 2):WaitForChild("PlantBossConfig", 2))
  end)

  if v578 and v579 then
    return v579
  end

  return nil
end

local function f141(p120, p121, p122, p123, p124)
  local v580, v581 = pcall(function() return p121:InvokeServer(p120) end)

  if not v580 or not v581 then
    return
  end

  local entry = v581.Entry

  if entry == "boss_root" or entry == "boss_submit" or entry == "boss_idle"
    or entry == "task_show" or entry == "final_unlock" then
    p124.Unlocked = true
  end

  if not p124.Unlocked then
    local v582, v583 = pcall(function() return p122:InvokeServer(p120, "quest_current") end)
    local context = v582 and v583 and v583.Context

    if context and context.desc then
      for index124, value204 in ipairs(p123.Quests) do
        if value204.Description == context.desc
          or string.find(context.desc, value204.Description, 1, true)
          or string.find(value204.Description, context.desc, 1, true) then
          p124.CurrentQuest = value204
          p124.IsSacrifice = value204.Sacrifice == true
          break
        end
      end

      p124.Progress = tonumber(context.progress) or 0

      p124.Requirement = tonumber(context.req)
        or p124.CurrentQuest and p124.CurrentQuest.Requirement or 0

      if entry == "ready_work" or entry == "ready_sacrifice"
        or p124.Requirement > 0 and p124.Progress >= p124.Requirement then
        p124.IsReady = true
        p124.Progress = math.max(p124.Progress, p124.Requirement)
      end
    end
  end
end

local function f142(p125, p126, p127)
  if not p125.Unlocked and not p125.CurrentQuest and p126 and p127 then
    local claimed = p127.Claimed or {}

    for index125, value205 in ipairs(p126.Quests) do
      if claimed[tostring(value205.Id)] ~= true and claimed[value205.Id] ~= true then
        p125.CurrentQuest = value205
        p125.IsSacrifice = value205.Sacrifice == true
        p125.Requirement = value205.Requirement or 0

        break
      end
    end

    if p125.CurrentQuest and p127.Progress then
      p125.Progress = tonumber(p127.Progress[tostring(p125.CurrentQuest.Id)])
        or tonumber(p127.Progress[p125.CurrentQuest.Id]) or 0

      if p125.Requirement > 0 and p125.Progress >= p125.Requirement then
        p125.IsReady = true
      end
    end
  end

  if p125.Unlocked and p127 and type(p127.ActiveTask) == "table" then
    p125.HasTask = true
    p125.ActiveTask = p127.ActiveTask
    p125.TaskRequirement = p127.ActiveTask.Requirement or 0
    p125.TaskProgress = tonumber(p127.TaskProgress) or 0

    p125.IsTaskSacrifice = p126
        and p127.ActiveTask.Objective == p126.Objectives.SubmitPlantValue
      or false

    if p125.TaskRequirement > 0 and p125.TaskProgress >= p125.TaskRequirement then
      p125.IsTaskReady = true
    end
  end
end

local function f143(p128)
  local v584 = tick()

  if not p128 and v12.Cache.GolemQuestCache and v12.Cache.GolemQuestCacheTime
    and v584 - v12.Cache.GolemQuestCacheTime < 3 then
    return v12.Cache.GolemQuestCache
  end

  local v585 = f140()
  local overgrownFarmer = workspace:FindFirstChild("OvergrownFarmer")
  local v586 = f21("DialogueService", "RF", "BeginDialogue")
  local v587 = f21("DialogueService", "RF", "ResolveDialogue")
  local v588 = f29()
  local plantBossQuest = v588 and v588.PlantBossQuest

  local v589 = {
    Unlocked = plantBossQuest and plantBossQuest.Unlocked or false,
    PetLevel = plantBossQuest and plantBossQuest.PetLevel or 1,
    PetXP = plantBossQuest and plantBossQuest.PetXP or 0,
    Size = v585 and v585.SizeForLevel
        and v585.SizeForLevel(plantBossQuest and plantBossQuest.PetLevel or 1)
      or "Regular",
    Earnings = v585 and v585.EarningsForLevel
        and v585.EarningsForLevel(plantBossQuest and plantBossQuest.PetLevel or 1)
      or 5.5,
    XPRequired = v585 and v585.XPRequired
        and v585.XPRequired(plantBossQuest and plantBossQuest.PetLevel or 1)
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

  if v585 and overgrownFarmer and v586 and v587 then
    f141(overgrownFarmer, v586, v587, v585, v589)
  end

  f142(v589, v585, plantBossQuest)

  v12.Cache.GolemQuestCache = v589
  v12.Cache.GolemQuestCacheTime = v584

  return v589
end

local function f144()
  local v590 = {}
  local backpack7 = localPlayer:FindFirstChild("Backpack")
  local character8 = localPlayer.Character

  local function f145(p129)
    if not p129 then
      return
    end

    for index126, value206 in ipairs(p129:GetChildren()) do
      if value206:IsA("Tool") and value206:GetAttribute("seedKey") and not f38(value206) then
        table.insert(v590, value206)
      end
    end
  end

  f145(backpack7)
  f145(character8)

  return v590
end

local function f146(p130, p131, p132, p133, p134)
  if not p133 or not p133.Parent then
    return false
  end

  f16(p133)
  task.wait(0.2)

  local v591 = pcall(function()
    p131:InvokeServer(p130)
    task.wait(0.2)
    p132:InvokeServer(p130, p134 and "task_finish" or "sacrifice_check")
  end)

  task.wait(0.3)
  f15()
  v12.Cache.GolemQuestCacheTime = 0
  return v591
end

local function f147(p135, p136, p137)
  return (pcall(function()
    p136:InvokeServer(p135)
    task.wait(0.2)
    p137:InvokeServer(p135, "work_check")
    v12.Cache.GolemQuestCacheTime = 0
  end))
end

local function f148(p138, p139, p140)
  return (pcall(function()
    p139:InvokeServer(p138)
    task.wait(0.2)
    p140:InvokeServer(p138, "task_give")
    v12.Cache.GolemQuestCacheTime = 0
  end))
end

local function f149(p141, p142, p143)
  return (pcall(function()
    p142:InvokeServer(p141)
    task.wait(0.2)
    p143:InvokeServer(p141, "task_finish")
    v12.Cache.GolemQuestCacheTime = 0
  end))
end

local function f150()
  local v592 = f143()
  local v593 = false
  local v594 = false

  if not v592.Unlocked then
    if v592.CurrentQuest and v592.IsSacrifice and v592.Progress < v592.Requirement then
      v593 = true
      v594 = false
    end
  elseif v592.HasTask and v592.IsTaskSacrifice and v592.TaskProgress < v592.TaskRequirement then
    v593 = true
    v594 = true
  end

  if not v593 then
    return
  end

  local overgrownFarmer2 = workspace:FindFirstChild("OvergrownFarmer")
  local v595 = f21("DialogueService", "RF", "BeginDialogue")
  local v596 = f21("DialogueService", "RF", "ResolveDialogue")

  if not overgrownFarmer2 or not v595 or not v596 then
    return
  end

  local v597 = f144()

  if #v597 == 0 then
    return
  end

  for index127, value207 in ipairs(v597) do
    if not (v7.Options.Toggle_GolemAutoSacrifice and v7.Options.Toggle_GolemAutoSacrifice.Value) then
      break
    end

    local v598 = f143()

    if not v594 then
      if not v598.CurrentQuest or not v598.IsSacrifice or v598.Progress >= v598.Requirement then
        break
      end
    elseif not v598.HasTask or not v598.IsTaskSacrifice
      or v598.TaskProgress >= v598.TaskRequirement then
      break
    end

    f146(overgrownFarmer2, v595, v596, value207, v594)
  end
end

local function f151()
  if v12.Flags.IsGolemAutoSacrificeRunning
    or not (v7.Options.Toggle_GolemAutoSacrifice and v7.Options.Toggle_GolemAutoSacrifice.Value) then
    return
  end

  v12.Flags.IsGolemAutoSacrificeRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_GolemAutoSacrifice
      and v7.Options.Toggle_GolemAutoSacrifice.Value do
      pcall(f150)
      task.wait(2)
    end

    f15()
    v12.Flags.IsGolemAutoSacrificeRunning = false
  end)
end

local function f152()
  local v599 = f143()
  local overgrownFarmer3 = workspace:FindFirstChild("OvergrownFarmer")
  local v600 = f21("DialogueService", "RF", "BeginDialogue")
  local v601 = f21("DialogueService", "RF", "ResolveDialogue")

  if not overgrownFarmer3 or not v600 or not v601 then
    return
  end

  if not v599.Unlocked then
    if v599.IsReady or v599.Requirement > 0 and v599.Progress >= v599.Requirement then
      f147(overgrownFarmer3, v600, v601)
    end
  elseif not v599.HasTask then
    f148(overgrownFarmer3, v600, v601)
  elseif not v599.IsTaskSacrifice
    and (v599.IsTaskReady
      or v599.TaskRequirement > 0 and v599.TaskProgress >= v599.TaskRequirement) then
    f149(overgrownFarmer3, v600, v601)
  end
end

local function f153()
  if v12.Flags.IsGolemAutoAdvanceRunning
    or not (v7.Options.Toggle_GolemAutoAdvance and v7.Options.Toggle_GolemAutoAdvance.Value) then
    return
  end

  v12.Flags.IsGolemAutoAdvanceRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_GolemAutoAdvance
      and v7.Options.Toggle_GolemAutoAdvance.Value do
      pcall(f152)
      task.wait(10)
    end

    v12.Flags.IsGolemAutoAdvanceRunning = false
  end)
end

local function f154()
  if not v12.Paragraph.GolemQuest then
    return
  end

  local v602 = f143()

  if v602.Unlocked then
    local petLevel = v602.PetLevel
    local petXP = v602.PetXP
    local v603 = v602.XPRequired > 0 and f3(v602.XPRequired) or "MAX"
    local earnings2 = v602.Earnings

    local v604 = "Plant Rush Golem: Lv. " .. petLevel .. "/50 (" .. v602.Size .. " | "
      .. earnings2 .. "x)"

    local v605 = "XP: " .. f3(petXP) .. " / " .. v603
    local v606 = ""

    if v602.HasTask and v602.ActiveTask then
      local description = v602.ActiveTask.Description or ""
      local taskProgress = v602.TaskProgress
      local taskRequirement = v602.TaskRequirement

      local v607 = taskRequirement > 0
          and math.clamp(math.floor(taskProgress / taskRequirement * 1000) / 10, 0, 100)
        or 0

      v606 = "\nActive " .. (v602.IsTaskSacrifice and "Sacrifice" or "Task") .. ": "
        .. description .. "\nProgress: " .. f3(taskProgress) .. " / " .. f3(taskRequirement)
        .. " (" .. v607 .. "%)"
    else
      v606 = "\nTask: Idle (Waiting for new task)"
    end

    v12.Paragraph.GolemQuest:SetContent(v604 .. "\n" .. v605 .. v606)
  elseif v602.CurrentQuest then
    local currentQuest = v602.CurrentQuest
    local requirement = v602.Requirement
    local progress2 = v602.Progress

    local v608 = requirement > 0
        and math.clamp(math.floor(progress2 / requirement * 1000) / 10, 0, 100)
      or 0

    local isSacrifice = v602.IsSacrifice and "Sacrifice" or "Objective"
    local description2 = currentQuest.Description or ""

    v12.Paragraph.GolemQuest:SetContent("Quest " .. currentQuest.Id .. " (" .. isSacrifice .. [[
):
]] .. description2 .. "\n\nProgress: " .. f3(progress2) .. " / " .. f3(requirement) .. " (" .. v608 .. "%)")
  else
    v12.Paragraph.GolemQuest:SetContent("No active quest found.")
  end
end

local function f155()
  if v12.Flags.IsGolemParagraphLoopRunning then
    return
  end

  v12.Flags.IsGolemParagraphLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded do
      pcall(f154)
      task.wait(10)
    end

    v12.Flags.IsGolemParagraphLoopRunning = false
  end)
end

local function f156(p144)
  v12.Flags.IsAutoFriendRequestEnabled = p144

  if p144 then
    for index128, value208 in ipairs(game:GetService("Players"):GetPlayers()) do
      SendFriendRequestTo(value208)
      task.wait(1)
    end

    if not v12.Connections.FriendRequestPlayerAddedConn then
      v12.Connections.FriendRequestPlayerAddedConn = game:GetService("Players").PlayerAdded:Connect(function(player)
        if v12.Flags.IsAutoFriendRequestEnabled then
          task.wait(2)
          SendFriendRequestTo(player)
        end
      end)
    end
  elseif v12.Connections.FriendRequestPlayerAddedConn then
    v12.Connections.FriendRequestPlayerAddedConn:Disconnect()
    v12.Connections.FriendRequestPlayerAddedConn = nil
  end
end

local function f157()
  local character9 = localPlayer.Character
  local humanoidRootPart17 = character9 and character9:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart17 then
    return
  end

  local value209 = v7.Options.Dropdown_NeighbourChoreTypes
      and v7.Options.Dropdown_NeighbourChoreTypes.Value
    or {}

  local v609 = value209.Tend == true
  local v610 = value209.Prune == true
  local v611 = value209.Groom == true

  if not v609 and not v610 and not v611 then
    return
  end

  local v612 = f21("NeighbourChoresService", "RF", "GetState")
  local v613 = f21("NeighbourChoresService", "RF", "PerformChore")

  if not v612 or not v613 then
    return
  end

  local v614, v615 = pcall(function() return v612:InvokeServer() end)

  if not v614 or not v615 or (v615.Remaining or 0) <= 0 then
    return
  end

  local cframe2 = humanoidRootPart17.CFrame
  local remaining = v615.Remaining

  local value210 = v7.Options.Toggle_ExtremeLowPerf and v7.Options.Toggle_ExtremeLowPerf.Value
    or v7.Options.Toggle_HideOtherPlots and v7.Options.Toggle_HideOtherPlots.Value

  if value210 then
    HideOtherPlayerPlots(false)
    task.wait(0.2)
  end

  local v616 = require(replicatedStorage.Shared.FarmPlots)
  local v617 = require(replicatedStorage.Shared.PlotUtils)
  local v618 = v617.GetPlotsFolder()

  if v618 then
    local players = game:GetService("Players")

    for index129, value211 in ipairs(v618:GetChildren()) do
      if remaining <= 0 then
        break
      end

      if not (v7.Options.Toggle_AutoNeighbourChores and v7.Options.Toggle_AutoNeighbourChores.Value) then
        break
      end

      local v619 = v617.GetPlotOwner(value211)

      if v619 and v619 ~= localPlayer.UserId and players:GetPlayerByUserId(v619) then
        local perFarm = v615.PerFarm and v615.PerFarm[tostring(v619)] or 0
        local maxPerFarm = v615.MaxPerFarm or 3

        while perFarm < maxPerFarm and remaining > 0 do
          if not (v7.Options.Toggle_AutoNeighbourChores
            and v7.Options.Toggle_AutoNeighbourChores.Value) then
            break
          end

          local v620 = nil

          if v609 or v610 then
            for i13 = 1, 5 do
              local v621 = v616.FarmPlotForFloor(value211, i13)

              if v621 then
                for index130, value212 in ipairs(v621:GetChildren()) do
                  local dirt6 = value212:IsA("Model") and value212:FindFirstChild("Dirt")

                  if dirt6 and dirt6:IsA("BasePart") and dirt6:GetAttribute("PlantName") then
                    local v622 = v616.PlotKeyFromDirt(dirt6)

                    if v622 then
                      if dirt6:GetAttribute("PlantFullyGrown") ~= true then
                        if v609 then
                          v620 = { ChoreId = "Tend", TargetKey = v622, Part = dirt6 }
                          break
                        end
                      elseif v610 and not v620 then
                        v620 = { ChoreId = "Prune", TargetKey = v622, Part = dirt6 }
                      end
                    end
                  end
                end
              end

              if v620 and v620.ChoreId == "Tend" then
                break
              end
            end
          end

          if v611 and not v620 then
            for index131, value213 in ipairs(value211:GetChildren()) do
              if value213:IsA("Model") and value213.PrimaryPart then
                local petKey5 = value213:GetAttribute("PetKey")

                if type(petKey5) == "string" then
                  v620 = { ChoreId = "Groom", TargetKey = petKey5, Part = value213.PrimaryPart }
                  break
                end
              end
            end
          end

          if not v620 then
            break
          end

          local character10 = localPlayer.Character

          local humanoidRootPart18 = character10
            and character10:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart18 then
            break
          end

          humanoidRootPart18.CFrame = v620.Part.CFrame + Vector3.new(0, 3, 0)
          task.wait(0.6)

          local v623, v624 = pcall(function()
            return v613:InvokeServer(v619, v620.ChoreId, v620.TargetKey)
          end)

          if v623 and v624 then
            perFarm = perFarm + 1
            remaining = remaining - 1

            v7:Notify({
              Title = "Neighbour Chores",
              Content = "Completed " .. v620.ChoreId .. " (" .. 12 - remaining .. "/12)",
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

  if value210 then
    HideOtherPlayerPlots(true)
  end

  local character11 = localPlayer.Character
  local humanoidRootPart19 = character11 and character11:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart19 and cframe2 then
    humanoidRootPart19.CFrame = cframe2
  end
end

local function f158()
  if v12.Flags.IsAutoNeighbourChoresLoopRunning then
    return
  end

  if not (v7.Options.Toggle_AutoNeighbourChores and v7.Options.Toggle_AutoNeighbourChores.Value) then
    return
  end

  v12.Flags.IsAutoNeighbourChoresLoopRunning = true

  task.spawn(function()
    while not v7.Unloaded and v7.Options.Toggle_AutoNeighbourChores
      and v7.Options.Toggle_AutoNeighbourChores.Value do
      f157()

      for i14 = 1, 60 do
        if v7.Unloaded
          or not (v7.Options.Toggle_AutoNeighbourChores
            and v7.Options.Toggle_AutoNeighbourChores.Value) then
          break
        end

        task.wait(1)
      end
    end

    v12.Flags.IsAutoNeighbourChoresLoopRunning = false
  end)
end

local function f159()
  if v12.Flags.IsAutoClaimPetExpeditionRunning
    or not v7.Options.Toggle_AutoClaimPetExpedition.Value then
    return
  end

  v12.Flags.IsAutoClaimPetExpeditionRunning = true

  task.spawn(function()
    local v625 = f21("PetExpeditionService", "RF", "Claim")

    while not v7.Unloaded and v7.Options.Toggle_AutoClaimPetExpedition.Value do
      if v625 then
        local v626 = f30(1)
        local petExpeditions = v626 and v626.PetExpeditions
        local slots = petExpeditions and petExpeditions.Slots

        if slots then
          local getServerTimeNow8 = workspace:GetServerTimeNow()

          for key31, value214 in pairs(slots) do
            if type(value214) == "table" and value214.ExpiresAt
              and value214.ExpiresAt <= getServerTimeNow8 then
              local v627 = tonumber(key31)

              if v627 then
                if v625:InvokeServer(v627) then
                  v7:Notify({
                    Title = "Pet Expeditions",
                    Content = "Claimed rewards for "
                      .. (value214.ExpeditionId or "Slot " .. v627),
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

    v12.Flags.IsAutoClaimPetExpeditionRunning = false
  end)
end

local function f160()
  if v12.Flags.IsAutoDispatchPetExpeditionRunning
    or not v7.Options.Toggle_AutoDispatchPetExpedition.Value then
    return
  end

  v12.Flags.IsAutoDispatchPetExpeditionRunning = true

  task.spawn(function()
    local v628 = f21("PetExpeditionService", "RF", "GetBoard")
    local v629 = f21("PetExpeditionService", "RF", "Dispatch")
    local v630 = GetPetExpeditionConfig()

    while not v7.Unloaded and v7.Options.Toggle_AutoDispatchPetExpedition.Value do
      if v628 and v629 and v630 then
        local v631 = f30(1)
        local petExpeditions2 = v631 and v631.PetExpeditions
        local slots2 = petExpeditions2 and petExpeditions2.Slots

        if slots2 then
          local v632 = nil
          local v633 = {}

          for key32, value215 in pairs(slots2) do
            if type(value215) == "table" then
              if value215.PetKeys then
                for index132, value216 in ipairs(value215.PetKeys) do
                  v633[value216] = true
                end
              end
            elseif value215 == false and not v632 then
              v632 = tonumber(key32)
            end
          end

          if v632 then
            local invokeServer5 = v628:InvokeServer()

            if type(invokeServer5) == "table" and invokeServer5.Expeditions
              and #invokeServer5.Expeditions > 0 then
              local v634 = {}

              if v631.EquippedPets then
                for key33, value217 in pairs(v631.EquippedPets) do
                  if value217 ~= "" then
                    v634[value217] = true
                  end
                end
              end

              local petInventory2 = v631.PetInventory or {}
              local v635 = {}

              for key34, value218 in pairs(petInventory2) do
                if type(value218) == "table" and value218.Name and not v634[key34]
                  and not v633[key34] then
                  local v636 = v12.Data.PetRarityLookup[value218.Name] or "Common"
                  local rank = v12.Data.RarityOrderMap[v636] or 0
                  local trait = v630.GetTrait(value218.Name)

                  table.insert(v635, {
                    Key = key34,
                    Name = value218.Name,
                    Rarity = v636,
                    Rank = rank,
                    Trait = trait,
                    Level = value218.Level or 1,
                  })
                end
              end

              if #v635 > 0 then
                local v637 = nil
                local v638 = -1

                for index133, value219 in ipairs(invokeServer5.Expeditions) do
                  local v639 = v630.ById[value219]

                  if v639 then
                    local v640 = v12.Data.RarityOrderMap[v639.PreferredRarity] or 0
                    local preferredTrait = v639.PreferredTrait
                    local v641 = {}
                    local v642 = {}
                    local v643 = {}

                    for index134, value220 in ipairs(v635) do
                      if value220.Trait == preferredTrait and value220.Rank >= v640 then
                        table.insert(v641, value220)
                      elseif value220.Trait == preferredTrait then
                        table.insert(v642, value220)
                      else
                        table.insert(v643, value220)
                      end
                    end

                    local v644 = {}

                    for index135, value221 in ipairs(v641) do
                      if #v644 < 3 then
                        table.insert(v644, value221)
                      end
                    end

                    for index136, value222 in ipairs(v642) do
                      if #v644 < 3 then
                        table.insert(v644, value222)
                      end
                    end

                    for index137, value223 in ipairs(v643) do
                      if #v644 < 3 then
                        table.insert(v644, value223)
                      end
                    end

                    if #v644 > 0 then
                      local v645 = {}

                      for index138, value224 in ipairs(v644) do
                        table.insert(v645, value224.Name)
                      end

                      local v646 = v630.ScoreParty(v639, v645)

                      local v647 = (v646 == "Perfect" and 4 or v646 == "Great" and 3
                            or v646 == "Good" and 2 or 1)
                          * 10
                        + #v644

                      if v647 > v638 then
                        v638 = v647

                        v637 = {
                          ExpeditionId = value219,
                          ExpeditionName = v639.Name,
                          Tier = v646,
                          Pets = v644,
                        }
                      end
                    end
                  end
                end

                if v637 and #v637.Pets > 0 then
                  local v648 = {}

                  for index139, value225 in ipairs(v637.Pets) do
                    table.insert(v648, value225.Key)
                  end

                  if v629:InvokeServer(v632, v637.ExpeditionId, v648) then
                    v7:Notify({
                      Title = "Pet Expeditions",
                      Content = "Dispatched " .. v637.ExpeditionName .. " (" .. v637.Tier
                        .. ") with " .. #v648 .. " pets",
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

    v12.Flags.IsAutoDispatchPetExpeditionRunning = false
  end)
end

local function f161()
  if v12.Flags.IsPetExpeditionParagraphRunning then
    return
  end

  v12.Flags.IsPetExpeditionParagraphRunning = true
  local v649 = f21("PetExpeditionService", "RF", "GetBoard")
  local invokeServer6 = nil
  local v650 = 0

  task.spawn(function()
    while not v7.Unloaded do
      pcall(function()
        if v12.Paragraph.PetExpeditionInfo then
          local v651 = GetPetExpeditionConfig()
          local v652 = f30(1)
          local petExpeditions3 = v652 and v652.PetExpeditions
          local slots3 = petExpeditions3 and petExpeditions3.Slots
          local v653 = {}
          local getServerTimeNow9 = workspace:GetServerTimeNow()

          if slots3 then
            for i15 = 1, 3 do
              local v654 = slots3[tostring(i15)]

              if type(v654) == "table" then
                local v655 = v651 and v651.ById[v654.ExpeditionId]
                local name4 = v655 and v655.Name or v654.ExpeditionId
                local tier = v654.Tier or "Good"
                local petKeys = v654.PetKeys and #v654.PetKeys or 0

                local v656 = tier == "Perfect" and "#FFD700" or tier == "Great" and "#AB47BC"
                  or tier == "Good" and "#40C4FF" or "#B0BEC5"

                if v654.ExpiresAt and v654.ExpiresAt <= getServerTimeNow9 then
                  table.insert(v653, "<b><font color=\"#00E676\">[Ready]</font></b> " .. name4
                    .. " <font color=\"#00E676\">(Slot " .. i15 .. " • " .. petKeys
                    .. " Pets • " .. tier .. ")</font>")
                else
                  local v657 = math.max(
                    0, math.floor((v654.ExpiresAt or 0) - getServerTimeNow9)
                  )

                  local v658 = math.floor(v657 / 3600)
                  local v659 = math.floor(v657 % 3600 / 60)
                  local v660 = v657 % 60
                  local v661 = (v658 > 0 and v658 .. "h " or "") .. v659 .. "m " .. v660 .. "s"

                  table.insert(v653, "<b>[" .. v661 .. "]</b> " .. name4 .. " <font color=\"" .. v656
                    .. "\">(Slot " .. i15 .. " • " .. petKeys .. " Pets • " .. tier
                    .. ")</font>")
                end
              elseif v654 == false then
                table.insert(v653, "<b><font color=\"#78909C\">[Idle]</font></b> Slot " .. i15
                  .. " <font color=\"#78909C\">(Ready to dispatch)</font>")
              end
            end
          end

          if tick() - v650 > 10 and v649 then
            v650 = tick()
            pcall(function() invokeServer6 = v649:InvokeServer() end)
          end

          if invokeServer6 and invokeServer6.Expeditions and #invokeServer6.Expeditions > 0 then
            table.insert(v653, "\n<b>Available on Board:</b>")

            for index140, value226 in ipairs(invokeServer6.Expeditions) do
              local v662 = v651 and v651.ById[value226]

              if v662 then
                local label = v651.GetDuration(v662).Label

                table.insert(v653, "<b>[" .. label .. "]</b> " .. v662.Name
                  .. " <font color=\"#40C4FF\">(" .. v662.PreferredRarity .. "+ • "
                  .. v662.PreferredTrait .. ")</font>")
              end
            end
          end

          if #v653 == 0 then
            table.insert(v653, "No expedition data available.")
          end

          v12.Paragraph.PetExpeditionInfo:SetContent(table.concat(v653, "\n"))
        end
      end)

      task.wait(10)
    end

    v12.Flags.IsPetExpeditionParagraphRunning = false
  end)
end

function InitUI()
  local window = v7:CreateWindow({ Title = "Build A Ring Farm", SubTitle = "by Lamduck" })

  local v663 = {
    FarmShop = window:AddTab({ Title = "Farm & Shop", Icon = "sprout" }),
    Pets = window:AddTab({ Title = "Pets", Icon = "cat" }),
    FloorManager = window:AddTab({ Title = "Floor Manager", Icon = "layers" }),
    Compost = window:AddTab({ Title = "Compost Manager", Icon = "leaf" }),
    Events = window:AddTab({ Title = "Event & Reward", Icon = "gift" }),
    Social = window:AddTab({ Title = "Social", Icon = "users" }),
    Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
  }

  v663.FarmShop:AddParagraph("NotiParagraph", {
    Title = "Performance Note",
    Content = "Experiencing lag or crashes? If you feel the game is <font color=\"#ff6b6b\">too laggy</font> or keeps <font color=\"#ff6b6b\">getting disconnected</font>, switch to the <font color=\"#4ecdc4\">Lite version</font> in <font color=\"#ffd93d\">Settings</font>.",
  })

  v663.FarmShop:AddSection("Auto Farming")

  v663.FarmShop:AddToggle("Toggle_AutoSellCrates", {
    Title = "Auto Sell Crates",
    Default = false,
    Callback = function(value227)
      if value227 then
        f47()
      end
    end,
  })

  v663.FarmShop:AddToggle("Toggle_AutoExpandFarmPlot", {
    Title = "Auto Expand Farm Plot",
    Default = false,
    Callback = function(value228)
      if value228 then
        f48()
      end
    end,
  })

  v663.FarmShop:AddSection("Seed Gacha (Roll & Buy)")

  v663.FarmShop:AddInput("Input_GachaRollDelay", {
    Title = "Roll Delay",
    Description = "seconds, min: 3",
    Default = "3",
    Numeric = true,
    Finished = false,
    Callback = function(value229)
      local v664 = tonumber(value229)

      if not v664 or v664 < 3 then
        v7.Options.Input_GachaRollDelay:SetValue("3")
      end
    end,
  })

  v663.FarmShop:AddToggle("Toggle_PauseIfNotEnoughMoney", {
    Title = "Pause If Not Enough Money",
    Default = false,
  })

  v663.FarmShop:AddDivider()

  v663.FarmShop:AddDropdown("Dropdown_GachaSeeds", {
    Title = "Target Seeds",
    Values = v12.Data.PlantNames,
    Multi = true,
    Searchable = true,
  })

  v663.FarmShop:AddToggle("Toggle_AutoGachaSelected", {
    Title = "Auto Gacha Seeds",
    Default = false,
    Callback = function(value230)
      if value230 then
        v7.Options.Toggle_AutoGachaByRarity:SetValue(false)
        f61()
      end
    end,
  })

  v663.FarmShop:AddDivider()

  v663.FarmShop:AddDropdown("Dropdown_GachaRarities", {
    Title = "Target Rarities",
    Values = v12.Data.RarityNames,
    Multi = true,
  })

  v663.FarmShop:AddToggle("Toggle_AutoGachaByRarity", {
    Title = "Auto Gacha Rarities",
    Default = false,
    Callback = function(value231)
      if value231 then
        v7.Options.Toggle_AutoGachaSelected:SetValue(false)
        f61()
      end
    end,
  })

  v663.FarmShop:AddSection("Discard Seeds")

  v663.FarmShop:AddDropdown("Dropdown_DiscardRarities", {
    Title = "Target Rarities",
    Values = v12.Data.RarityNames,
    Multi = true,
  })

  v663.FarmShop:AddToggle("Toggle_AutoDiscardByRarity", {
    Title = "Auto Discard Seeds",
    Default = false,
    Confirm = "Are you sure you want to auto discard seeds by rarity?",
    Callback = function(value232)
      if value232 then
        f64()
      end
    end,
  })

  v663.FarmShop:AddSection("Gear Shop")

  v663.FarmShop:AddDropdown("Dropdown_TargetBuyGears", {
    Title = "Target Gears",
    Values = v12.Data.GearShopItemNames,
    Multi = true,
    Searchable = true,
  })

  v663.FarmShop:AddToggle("Toggle_AutoBuySelectedGears", {
    Title = "Auto Buy Gears",
    Default = false,
    Callback = function(value233)
      if value233 then
        f49()
      end
    end,
  })

  v663.FarmShop:AddSection("Egg Shop")

  v663.FarmShop:AddToggle("Toggle_AutoUnlockEggSlots", {
    Title = "Auto Unlock Egg Slots",
    Default = false,
    Callback = function(value234)
      if value234 then
        f52()
      end
    end,
  })

  v663.FarmShop:AddDivider()

  v663.FarmShop:AddDropdown("Dropdown_TargetEggShopEggs", {
    Title = "Target Eggs",
    Values = v12.Data.EggNames,
    Multi = true,
    Searchable = true,
  })

  v663.FarmShop:AddToggle("Toggle_AutoBuySelectedEggs", {
    Title = "Auto Buy Eggs",
    Default = false,
    Callback = function(value235)
      if value235 then
        f50()
      end
    end,
  })

  v663.FarmShop:AddSection("Night Market Merchant")

  v663.FarmShop:AddDropdown("Dropdown_TargetNightMarketItems", {
    Title = "Target Items",
    Values = v12.Data.NightMarketItemNames,
    Multi = true,
    Searchable = true,
  })

  v663.FarmShop:AddToggle("Toggle_AutoBuyNightMarket", {
    Title = "Auto Buy Night Market Items",
    Default = false,
    Callback = function(value236)
      if value236 then
        f51()
      end
    end,
  })

  task.wait()

  do
    v12.Paragraph.PetInfo = v663.Pets:AddParagraph("PetInfoParagraph", {
      Title = "Active Pets Info",
      Content = "Scanning pets...",
    })

    local addSubTabBar = v663.Pets:AddSubTabBar({ SubTabs = { "Pet", "Team", "Pet Expedition" } })
    local pet2 = addSubTabBar.Pet
    local team = addSubTabBar.Team
    local petExpedition = addSubTabBar["Pet Expedition"]
    local v665 = PetTeamsGetNamesList((PetTeamsLoadTeams()))
    team:AddSection("Pet Teams")

    local addDropdown = team:AddDropdown("Dropdown_PetTeams", {
      Title = "Select Team",
      Values = v665,
      Multi = false,
      Default = v665[1] or nil,
    })

    local addInput = team:AddInput("Input_PetTeamName", {
      Title = "Team Name",
      Default = "",
      Placeholder = "Leave empty for auto name",
      Numeric = false,
      Finished = false,
    })

    team:AddButton({
      Title = "Save Current Team",
      Callback = function() PetTeamsSaveCurrent(addInput, addDropdown, window) end,
    })

    team:AddButton({
      Title = "Equip Selected Team",
      Callback = function() PetTeamsEquipSelected(addDropdown.Value) end,
    })

    team:AddButton({
      Title = "Delete Selected Team",
      Callback = function() PetTeamsDeleteSelected(addDropdown.Value, addDropdown, window) end,
    })

    team:AddSection("Actions")

    team:AddButton({
      Title = "Unequip All Pets",
      Description = "Unequip all currently equipped pets on plot",
      Callback = PetTeamsUnequipAllAction,
    })

    pet2:AddSection("Pet Feeding")

    pet2:AddDropdown("Dropdown_PetTreatTypes", {
      Title = "Select Treats",
      Values = v12.Data.PetTreatNames,
      Multi = true,
    })

    pet2:AddToggle("Toggle_AutoFeedPets", {
      Title = "Auto Feed Pets",
      Default = false,
      Callback = function(value237)
        if value237 then
          f53()
        end
      end,
    })

    pet2:AddSection("Pet Upgrade")

    pet2:AddInput("Input_PetUpgradeLevel", {
      Title = "Max Upgrade Level",
      Default = "50",
      Numeric = true,
      Min = 1,
      Max = 50,
      Finished = false,
    })

    pet2:AddToggle("Toggle_AutoUpgradePets", {
      Title = "Auto Upgrade Pets",
      Default = false,
      Callback = function(value238)
        if value238 then
          f54()
        end
      end,
    })

    pet2:AddSection("Pet Sell")

    pet2:AddDropdown("Dropdown_PetSellSelection", {
      Title = "Select Pet Names",
      Values = v12.Data.PetNames,
      Multi = true,
      Searchable = true,
    })

    pet2:AddToggle("Toggle_PetSellFilterName", {
      Title = "Auto Sell by Name",
      Default = false,
      Callback = function(value239)
        if value239 then
          v7.Options.Toggle_PetSellFilterRarity:SetValue(false)
          v7.Options.Toggle_PetSellFilterSize:SetValue(false)
          f55()
        end
      end,
    })

    pet2:AddDivider()

    pet2:AddDropdown("Dropdown_PetSellRarities", {
      Title = "Select Pet Rarities",
      Values = v12.Data.PetRarityNames,
      Multi = true,
    })

    pet2:AddToggle("Toggle_PetSellFilterRarity", {
      Title = "Auto Sell by Rarity",
      Default = false,
      Callback = function(value240)
        if value240 then
          v7.Options.Toggle_PetSellFilterName:SetValue(false)
          v7.Options.Toggle_PetSellFilterSize:SetValue(false)
          f55()
        end
      end,
    })

    pet2:AddDivider()

    pet2:AddDropdown("Dropdown_PetSellSizes", {
      Title = "Select Pet Sizes",
      Values = v12.Data.PetSizeNames,
      Multi = true,
    })

    pet2:AddToggle("Toggle_PetSellFilterSize", {
      Title = "Auto Sell by Size",
      Default = false,
      Callback = function(value241)
        if value241 then
          v7.Options.Toggle_PetSellFilterName:SetValue(false)
          v7.Options.Toggle_PetSellFilterRarity:SetValue(false)
          f55()
        end
      end,
    })

    petExpedition:AddSection("Expedition Status")

    v12.Paragraph.PetExpeditionInfo = petExpedition:AddParagraph("PetExpeditionInfoParagraph", {
      Title = "Active Expeditions",
      Content = "Loading...",
    })

    petExpedition:AddSection("Automation")

    petExpedition:AddToggle("Toggle_AutoDispatchPetExpedition", {
      Title = "Auto Dispatch",
      Description = "Auto pick and send best pets to available expeditions",
      Default = false,
      Callback = function(value242)
        if value242 then
          f160()
        end
      end,
    })

    petExpedition:AddToggle("Toggle_AutoClaimPetExpedition", {
      Title = "Auto Claim",
      Description = "Auto claim completed expeditions when ready",
      Default = false,
      Callback = function(value243)
        if value243 then
          f159()
        end
      end,
    })
  end

  task.wait()

  do
    local addSubTabBar2 = v663.FloorManager:AddSubTabBar({
      SubTabs = { "Floor 1", "Floor 2", "Floor 3", "Floor 4", "Floor 5" },
      Default = "Floor 1",
    })

    for index141, value244 in ipairs({ 1, 2, 3, 4, 5 }) do
      local v666 = addSubTabBar2["Floor " .. value244]
      local v667 = "_F" .. value244
      v666:AddSection("Plant Status")

      v12.Paragraph.FloorPlants[value244] = v666:AddParagraph("FloorPlantParagraph" .. v667, {
        Title = "Plant Status",
        Content = "Scanning floor status...",
      })

      v666:AddSection("Auto Plant")
      local addToggle
      local addToggle2

      local addToggle3 = v666:AddToggle("Toggle_AutoPlantBest" .. v667, {
        Title = "Auto Plant Best Seed (Highest Price)",
        Default = false,
        Callback = function(value245)
          if value245 then
            addToggle:SetValue(false)
            addToggle2:SetValue(false)
            f74()
          end
        end,
      })

      v666:AddDivider()

      v666:AddDropdown("Dropdown_AutoPlantSeeds" .. v667, {
        Title = "Select Target Seeds",
        Values = v12.Data.PlantNames,
        Multi = true,
        Searchable = true,
      })

      addToggle = v666:AddToggle("Toggle_AutoPlantSelected" .. v667, {
        Title = "Auto Plant Selected Seeds",
        Default = false,
        Callback = function(value246)
          if value246 then
            addToggle3:SetValue(false)
            addToggle2:SetValue(false)
            f74()
          end
        end,
      })

      v666:AddDivider()

      v666:AddDropdown("Dropdown_AutoPlantRarities" .. v667, {
        Title = "Select Target Rarities",
        Values = v12.Data.RarityNames,
        Multi = true,
      })

      addToggle2 = v666:AddToggle("Toggle_AutoPlantRarity" .. v667, {
        Title = "Auto Plant Selected Rarity",
        Default = false,
        Callback = function(value247)
          if value247 then
            addToggle3:SetValue(false)
            addToggle:SetValue(false)
            f74()
          end
        end,
      })

      v666:AddDivider()

      v666:AddButton({
        Title = "Remove All Plants",
        Description = "Clear all plants on this floor and recover seeds.",
        Confirm = "Are you sure you want to remove ALL plants on Floor " .. value244
          .. "? This action cannot be undone!",
        Callback = function() task.spawn(f73, value244) end,
      })

      v666:AddSection("Auto Upgrade Plant")

      v666:AddInput("Input_MaxUpgradeLevel" .. v667, {
        Title = "Max Upgrade Level",
        Default = "100",
        Numeric = true,
        Min = 1,
        Finished = false,
      })

      v666:AddDropdown("Dropdown_UpgradePlantNames" .. v667, {
        Title = "Select Plants",
        Values = v12.Data.PlantNames,
        Multi = true,
        Searchable = true,
      })

      v666:AddToggle("Toggle_AutoUpgradePlants" .. v667, {
        Title = "Auto Upgrade",
        Default = false,
        Callback = function(value248)
          if value248 then
            f79()
          end
        end,
      })

      v666:AddSection("Auto Fertilize")

      v666:AddDropdown("Dropdown_FertilizerTypes" .. v667, {
        Title = "Select Fertilizers",
        Values = v12.Data.FertilizerNames,
        Multi = true,
      })

      v666:AddDropdown("Dropdown_FertilizePlants" .. v667, {
        Title = "Select Plants",
        Values = v12.Data.PlantNames,
        Multi = true,
        Searchable = true,
      })

      v666:AddToggle("Toggle_AutoFertilize" .. v667, {
        Title = "Auto Fertilize",
        Default = false,
        Callback = function(value249)
          if value249 then
            f82()
          end
        end,
      })

      v666:AddSection("Auto Spray")

      v666:AddDropdown("Dropdown_SprayType" .. v667, {
        Title = "Select Spray Type",
        Values = v12.Data.MutationSprayNames,
        Default = "",
      })

      v666:AddDropdown("Dropdown_SprayPlants" .. v667, {
        Title = "Select Plants",
        Values = v12.Data.PlantNames,
        Multi = true,
        Searchable = true,
      })

      v666:AddToggle("Toggle_AutoSpray" .. v667, {
        Title = "Auto Spray",
        Default = false,
        Callback = function(value250)
          if value250 then
            f83()
          end
        end,
      })

      v666:AddSection("Auto Clear Mutation (Acid Spray)")

      v666:AddDropdown("Dropdown_ClearMutationNames" .. v667, {
        Title = "Select Mutations",
        Values = v12.Data.MutationNames,
        Multi = true,
      })

      v666:AddDropdown("Dropdown_ClearMutationPlants" .. v667, {
        Title = "Select Plants",
        Values = v12.Data.PlantNames,
        Multi = true,
        Searchable = true,
      })

      v666:AddToggle("Toggle_AutoClearMutation" .. v667, {
        Title = "Auto Clear Mutation",
        Default = false,
        Confirm = "Are you sure you want to clear mutation?",
        Callback = function(value251)
          if value251 then
            f83()
          end
        end,
      })

      v666:AddSection("Auto Upgrade Powerups")

      local v668 = { "SawRange", "SawYield", "SprinklerRange", "SprinklerPower" }

      if value244 == 1 then
        table.insert(v668, "SeedLuck")
        table.insert(v668, "SeedRolls")
      end

      if value244 >= 2 then
        table.insert(v668, "CrownedCrops")
      end

      if value244 >= 3 then
        table.insert(v668, "SoilQuality")
      end

      if value244 == 5 then
        table.insert(v668, "GoldenHarvest")
        table.insert(v668, "GoldenChance")
      end

      v666:AddDropdown("Dropdown_UpgradePowerups" .. v667, {
        Title = "Select Powerups",
        Values = v668,
        Multi = true,
      })

      v666:AddToggle("Toggle_AutoUpgradePowerups" .. v667, {
        Title = "Auto Upgrade Powerups",
        Default = false,
        Callback = function(value252)
          if value252 then
            f88()
          end
        end,
      })

      v666:AddSection("Auto Unlock Farm Plots")

      v666:AddToggle("Toggle_AutoUnlockFarmPlots" .. v667, {
        Title = "Auto Unlock Farm Plots",
        Default = false,
        Callback = function(value253)
          if value253 then
            f86()
          end
        end,
      })
    end
  end

  task.wait()

  v12.Paragraph.CompostInfo = v663.Compost:AddParagraph("CompostInfoParagraph", {
    Title = "Compost Status",
    Content = "Scanning composter status...",
  })

  do
    local addSubTabBar3 = v663.Compost:AddSubTabBar({
      SubTabs = { "Floor 2", "Floor 3", "Floor 4", "Floor 5" },
      Default = "Floor 2",
    })

    for index142, value254 in ipairs({ 2, 3, 4, 5 }) do
      local v669 = addSubTabBar3["Floor " .. value254]
      local v670 = "_F" .. value254

      v669:AddSection("Auto Compost settings")

      v669:AddDropdown("Dropdown_CompostPullLevel" .. v670, {
        Title = "Pull Lever Tier",
        Values = v12.Data.CompostLevelNames,
        Default = "Overgrown",
      })

      v669:AddDivider()

      v669:AddDropdown("Dropdown_CompostSeeds" .. v670, {
        Title = "Target Seeds",
        Values = v12.Data.PlantNames,
        Multi = true,
        Searchable = true,
      })

      local addToggle4

      local addToggle5 = v669:AddToggle("Toggle_AutoCompostSelected" .. v670, {
        Title = "Auto Compost Selected",
        Default = false,
        Callback = function(value255)
          if value255 then
            addToggle4:SetValue(false)
            f72()
          end
        end,
      })

      v669:AddDivider()

      v669:AddDropdown("Dropdown_CompostRarities" .. v670, {
        Title = "Target Rarities",
        Values = v12.Data.RarityNames,
        Multi = true,
      })

      addToggle4 = v669:AddToggle("Toggle_AutoCompostByRarity" .. v670, {
        Title = "Auto Compost By Rarity",
        Default = false,
        Callback = function(value256)
          if value256 then
            addToggle5:SetValue(false)
            f72()
          end
        end,
      })
    end
  end

  task.wait()

  do
    local addSubTabBar4 = v663.Events:AddSubTabBar({
      SubTabs = {
        "Events", "Guild", "Friend O Tron", "Pet Mutation", "Fuse", "Rewards", "Contract",
        "Golem",
      },
    })

    local events = addSubTabBar4.Events
    local guild = addSubTabBar4.Guild
    local friendOTron6 = addSubTabBar4["Friend O Tron"]
    local petMutation6 = addSubTabBar4["Pet Mutation"]
    local fuse = addSubTabBar4.Fuse
    local rewards = addSubTabBar4.Rewards
    local contract = addSubTabBar4.Contract
    local golem = addSubTabBar4.Golem
    events:AddSection("Wandering Merchant (Not tested yet)")

    v12.Paragraph.WanderingMerchantInfo = events:AddParagraph("WanderingMerchantInfoParagraph", {
      Title = "Merchant Status",
      Content = "Loading...",
    })

    events:AddToggle("Toggle_AutoSubmitMerchantTrades", {
      Title = "Auto Submit Merchant Trades",
      Default = false,
      Callback = function(value257)
        if value257 then
          f136()
        end
      end,
    })

    events:AddDivider()

    events:AddDropdown("Dropdown_MerchantShopItems", {
      Title = "Select Merchant Shop Items",
      Values = v12.Data.WanderingMerchantItemNames,
      Multi = true,
    })

    events:AddToggle("Toggle_AutoBuyMerchantShop", {
      Title = "Auto Buy Merchant Shop Items",
      Default = false,
      Callback = function(value258)
        if value258 then
          f137()
        end
      end,
    })

    events:AddSection("Zoo Rush")

    events:AddDropdown("Dropdown_ZooRushNames", {
      Title = "Select ZooRush Pets",
      Values = v12.Data.ZooRushPetNames,
      Multi = true,
      Searchable = true,
    })

    events:AddToggle("Toggle_AutoZooRushName", {
      Title = "Auto Catch by Name",
      Default = false,
      Callback = function(value259)
        if value259 then
          v7.Options.Toggle_AutoZooRushRarity:SetValue(false)
          f103()
        end
      end,
    })

    events:AddDivider()

    events:AddDropdown("Dropdown_ZooRushRarities", {
      Title = "Select ZooRush Rarities",
      Values = v12.Data.PetRarityNames,
      Multi = true,
    })

    events:AddToggle("Toggle_AutoZooRushRarity", {
      Title = "Auto Catch by Rarity",
      Default = false,
      Callback = function(value260)
        if value260 then
          v7.Options.Toggle_AutoZooRushName:SetValue(false)
          f103()
        end
      end,
    })

    events:AddSection("World Events")

    events:AddToggle("Toggle_AutoCollectCyberDroneDrop", {
      Title = "Auto Collect Cyber Drone Drop",
      Default = false,
      Callback = function(value261)
        if value261 then
          f90()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectAlienDrop", {
      Title = "Auto Collect Alien Drop",
      Default = false,
      Callback = function(value262)
        if value262 then
          f89()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectQueenBeeHoneycomb", {
      Title = "Auto Collect Queen Bee Honeycomb",
      Default = false,
      Callback = function(value263)
        if value263 then
          f91()
        end
      end,
    })

    events:AddToggle("Toggle_AutoSubmitQueenBeeHoneyToken", {
      Title = "Auto Submit Honey Token",
      Default = false,
      Callback = function(value264)
        if value264 then
          f92()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectWeatherEvents", {
      Title = "Auto Collect Weather Events",
      Description = "*Rain, Blizzard, Fall, Blackhole, Nuclear, Galaxy*",
      Default = false,
      Callback = function(value265)
        if value265 then
          f97()
        end
      end,
    })

    events:AddToggle("Toggle_AutoCollectMeteorDrop", {
      Title = "Auto Collect Meteor Drops",
      Default = false,
      Callback = function(value266)
        if value266 then
          f99()
        end
      end,
    })

    events:AddSection("Admin Events")

    events:AddToggle("Toggle_AutoCollectAdminTokens", {
      Title = "Auto Collect Admin Tokens",
      Default = false,
      Callback = function(value267)
        if value267 then
          f93()
        end
      end,
    })

    events:AddToggle("Toggle_AutoSpinMegaSpinner", {
      Title = "Auto Spin Mega Spinner",
      Default = false,
      Callback = function(value268)
        if value268 then
          f94()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectLuckyRainDrop", {
      Title = "Auto Collect Lucky Rain Drop",
      Default = false,
      Callback = function(value269)
        if value269 then
          f98()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoShootJesterBoss", {
      Title = "Auto Shoot Jester Boss",
      Default = false,
      Callback = function(value270)
        if value270 then
          f100()
        end
      end,
    })

    events:AddToggle("Toggle_AutoCollectJesterGifts", {
      Title = "Auto Collect Jester Gifts",
      Default = false,
      Callback = function(value271)
        if value271 then
          f101()
        end
      end,
    })

    events:AddDivider()

    events:AddToggle("Toggle_AutoCollectCarnivalGifts", {
      Title = "Auto Collect Carnival Gifts",
      Default = false,
      Callback = function(value272)
        if value272 then
          f102()
        end
      end,
    })

    events:AddSection("Legacy Events")

    events:AddToggle("Toggle_AutoPlantditchPassRing", {
      Title = "Auto Pass Ring (Plantditch)",
      Default = false,
      Callback = function(value273)
        if value273 then
          f95()
        end
      end,
    })

    events:AddToggle("Toggle_AutoPlantditchClaimOrb", {
      Title = "Auto Claim Orb (Plantditch)",
      Default = false,
      Callback = function(value274)
        if value274 then
          f96()
        end
      end,
    })

    v12.Paragraph.PetMutationInfo = petMutation6:AddParagraph("PetMutationInfoParagraph", {
      Title = "Machine Status",
      Content = "NOT FINISH YET, IT MAY BUGGY ( yeah im stupid and cannot just fix the timer )",
    })

    petMutation6:AddSection("Pet Mutation")

    petMutation6:AddDropdown("Dropdown_PetMutationPetNames", {
      Title = "Select Pet",
      Values = v12.Data.PetNames,
      Multi = true,
      Searchable = true,
    })

    petMutation6:AddDropdown("Dropdown_PetMutationWhitelistMutations", {
      Title = "Exclude Mutations (Whitelist)",
      Description = [[
Selected mutations will NOT be auto mutation!
Deselect to reroll mutation!]],
      Values = v12.Data.PetMutationNames,
      Multi = true,
      Searchable = true,
      Default = v12.Data.PetMutationNames,
    })

    petMutation6:AddToggle("Toggle_AutoStartPetMutation", {
      Title = "Auto Start Mutation",
      Default = false,
      Callback = function(value275)
        if value275 then
          f123()
        end
      end,
    })

    petMutation6:AddToggle("Toggle_AutoClaimPetMutation", {
      Title = "Auto Claim Mutation",
      Default = false,
      Callback = function(value276)
        if value276 then
          f124()
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
      Callback = function(value277)
        if value277 then
          f122()
        end
      end,
    })

    guild:AddSection("Guild Rewards")

    guild:AddToggle("Toggle_AutoClaimGuildMissions", {
      Title = "Auto Claim Missions",
      Default = false,
      Callback = function(value278)
        if value278 then
          f117()
        end
      end,
    })

    guild:AddToggle("Toggle_AutoClaimGuildWeekly", {
      Title = "Auto Claim Weekly Tier Reward",
      Default = false,
      Callback = function(value279)
        if value279 then
          f118()
        end
      end,
    })

    guild:AddDivider()

    guild:AddToggle("Toggle_AutoStartRally", {
      Title = "Auto Start Rally",
      Default = false,
      Callback = function(value280)
        if value280 then
          f120()
        end
      end,
    })

    guild:AddSection("Guild Shop")

    guild:AddDropdown("Dropdown_AutoBuyGuildShopItems", {
      Title = "Select Items to Buy",
      Values = v12.Data.GuildShopItemNames,
      Multi = true,
      Searchable = true,
    })

    guild:AddToggle("Toggle_AutoBuyGuildShop", {
      Title = "Auto Buy Guild Shop",
      Default = false,
      Callback = function(value281)
        if value281 then
          f119()
        end
      end,
    })

    friendOTron6:AddSection("Friend-O-Tron")

    v12.Paragraph.FriendOTronInfo = friendOTron6:AddParagraph("FriendOTronInfoParagraph", {
      Title = "Friend-O-Tron Status",
      Content = "Scanning chambers...",
    })

    friendOTron6:AddDropdown("Dropdown_FriendOTronTargetSlot", {
      Title = "Target Slot",
      Values = { "Any Empty Slot", "Blue Slot", "Purple Slot" },
      Default = "Any Empty Slot",
    })

    friendOTron6:AddDivider()

    do
      local v671 = {}

      for index143, value282 in ipairs(v12.Data.RarityNames) do
        if value282 ~= "Common" and value282 ~= "Uncommon" then
          table.insert(v671, value282)
        end
      end

      local v672 = {}

      for index144, value283 in ipairs(v12.Data.PlantNames) do
        local v673 = f6(value283)

        if v673 ~= "Unknown" and v673 ~= "Common" and v673 ~= "Uncommon" then
          table.insert(v672, value283)
        end
      end

      friendOTron6:AddDropdown("Dropdown_FriendOTronSeedName", {
        Title = "Select Target Seeds",
        Values = v672,
        Multi = true,
        Searchable = true,
      })

      friendOTron6:AddToggle("Toggle_AutoFriendOTronSeed", {
        Title = "Auto Friend-O-Tron by Seed",
        Default = false,
        Callback = function(value284)
          if value284 then
            v7.Options.Toggle_AutoFriendOTronRarity:SetValue(false)
            f107()
          end
        end,
      })

      friendOTron6:AddDivider()

      friendOTron6:AddDropdown("Dropdown_FriendOTronRarity", {
        Title = "Select Target Rarities",
        Values = v671,
        Multi = true,
      })

      friendOTron6:AddToggle("Toggle_AutoFriendOTronRarity", {
        Title = "Auto Friend-O-Tron by Rarity",
        Default = false,
        Callback = function(value285)
          if value285 then
            v7.Options.Toggle_AutoFriendOTronSeed:SetValue(false)
            f107()
          end
        end,
      })
    end

    friendOTron6:AddDivider()

    friendOTron6:AddButton({
      Title = "Remove Seeds",
      Confirm = "Are you sure you want to remove seeds?",
      Callback = function()
        task.spawn(function()
          local friendOTron7 = replicatedStorage:FindFirstChild("Remotes")
            and replicatedStorage.Remotes:FindFirstChild("FriendOTron")

          if not friendOTron7 then
            return
          end

          local removeSeed = friendOTron7:FindFirstChild("RemoveSeed")

          if not removeSeed then
            return
          end

          pcall(function() removeSeed:InvokeServer("Blue") end)
          pcall(function() removeSeed:InvokeServer("Purple") end)
        end)
      end,
    })

    friendOTron6:AddSection("Friend-O-Tron Spin")

    friendOTron6:AddToggle("Toggle_AutoFriendOTronSpin", {
      Title = "Auto Spin",
      Default = false,
      Callback = function(value286)
        if value286 then
          f108()
        end
      end,
    })

    rewards:AddSection("The Vault")

    rewards:AddToggle("Toggle_AutoRollVault", {
      Title = "Auto Roll Vault",
      Default = false,
      Callback = function(value287)
        if value287 then
          f116()
        end
      end,
    })

    rewards:AddParagraph("RewardsVisualBugWarning", {
      Title = "Note",
      Content = "Auto-claims may have visual bugs showing rewards/quests as unclaimed, but they've already been claimed.",
    })

    rewards:AddSection("Season Pass")

    rewards:AddToggle("Toggle_AutoClaimSeasonPassQuests", {
      Title = "Auto Claim Quests",
      Default = false,
      Callback = function(value288)
        if value288 then
          f125()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoClaimSeasonPassRewards", {
      Title = "Auto Claim Season Rewards",
      Default = false,
      Callback = function(value289)
        if value289 then
          f126()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoSpinSeasonPassCrate", {
      Title = "Auto Spin Crate",
      Default = false,
      Callback = function(value290)
        if value290 then
          f127()
        end
      end,
    })

    rewards:AddSection("Other")

    rewards:AddToggle("Toggle_AutoClaimDailyReward", {
      Title = "Auto Claim Daily Reward",
      Default = false,
      Callback = function(value291)
        if value291 then
          f111()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoClaimPlaytimeReward", {
      Title = "Auto Claim Playtime Reward",
      Default = false,
      Callback = function(value292)
        if value292 then
          f112()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoSpinWheel", {
      Title = "Auto Spin Wheel",
      Default = false,
      Callback = function(value293)
        if value293 then
          f113()
        end
      end,
    })

    rewards:AddToggle("Toggle_AutoOpenCratePack", {
      Title = "Auto Open Crate / Pack",
      Default = false,
      Callback = function(value294)
        if value294 then
          f114()
        end
      end,
    })

    rewards:AddSection("Gift Codes")

    rewards:AddButton({
      Title = "Redeem All Codes",
      Description = "Automatically redeem all standard active giftcodes",
      Callback = function()
        v7:Notify({ Title = "System", Content = "Redeeming all codes...", Duration = 3 })

        task.spawn(function()
          local submitCode = replicatedStorage:FindFirstChild("Remotes")
            and replicatedStorage.Remotes:FindFirstChild("SubmitCode")

          if submitCode then
            for index145, value295 in ipairs(v14.GIFTCODES) do
              submitCode:InvokeServer(value295)
              task.wait(1)
            end

            v7:Notify({
              Title = "System",
              Content = "Finished trying to redeem all codes!",
              Duration = 3,
            })
          end
        end)
      end,
    })

    do
      local v674 = {}

      for index146, value296 in ipairs(v12.Data.RarityNames) do
        if value296 ~= "Eternal" then
          table.insert(v674, value296)
        end
      end

      local v675 = {}

      for index147, value297 in ipairs(v12.Data.PlantNames) do
        if f6(value297) ~= "Eternal" then
          table.insert(v675, value297)
        end
      end

      v12.Paragraph.FuseInfo = fuse:AddParagraph("FuseInfoParagraph", {
        Title = "Fuse Machine Info",
        Content = "Loading...",
      })

      fuse:AddDropdown("Dropdown_FuseSeeds", {
        Title = "Select Seeds",
        Values = v675,
        Multi = true,
      })

      fuse:AddToggle("Toggle_AutoFuseSelected", {
        Title = "Auto Fuse Selected Seeds",
        Default = false,
        Callback = function(value298)
          if value298 then
            v7.Options.Toggle_AutoFuseByRarity:SetValue(false)
            f131()
          end
        end,
      })

      fuse:AddDivider()

      fuse:AddDropdown("Dropdown_FuseRarities", {
        Title = "Select Rarities",
        Values = v674,
        Multi = true,
      })

      fuse:AddToggle("Toggle_AutoFuseByRarity", {
        Title = "Auto Fuse Selected Rarities",
        Default = false,
        Callback = function(value299)
          if value299 then
            v7.Options.Toggle_AutoFuseSelected:SetValue(false)
            f131()
          end
        end,
      })
    end

    contract:AddParagraph("ContractWarningParagraph", {
      Title = "Warning ( BUGGY )",
      Content = "Auto Contract will automatically submit any matching seeds from your inventory. Please favorite any seeds you do not want to lose!",
    })

    contract:AddToggle("Toggle_AutoContract", {
      Title = "Auto Contract",
      Description = "Automatically submit plants to contract slots",
      Confirm = [[
Are you sure you want to enable Auto Contract?

Reminder: Auto Contract will submit ANY matching seed from your inventory. Please favorite any seeds you do not want to lose!]],
      Default = false,
      Callback = function(value300)
        if value300 then
          f139()
        end
      end,
    })

    v12.Paragraph.GolemQuest = golem:AddParagraph("GolemQuestParagraph", {
      Title = "Current Quest",
      Content = "Loading quest status...",
    })

    golem:AddSection("Overgrown Farmer (TEST)")

    golem:AddToggle("Toggle_GolemAutoSacrifice", {
      Title = "Auto Sacrifice Seeds",
      Description = "(Only quest 1 & 5)",
      Confirm = [[
Are you sure you want to enable Auto Sacrifice Seeds?

Reminder: This will permanently consume eligible non-favorited seeds from your inventory to complete the quest.]],
      Default = false,
      Callback = function(value301)
        if value301 then
          f151()
        end
      end,
    })

    golem:AddToggle("Toggle_GolemAutoAdvance", {
      Title = "Auto Advance Quests",
      Description = "Auto advance new quest when current is done",
      Default = false,
      Callback = function(value302)
        if value302 then
          f153()
        end
      end,
    })
  end

  task.wait()

  v663.Social:AddSection("Friend ~"):AddToggle("Toggle_AutoFriendRequest", {
    Title = "Auto Send Friend Request",
    Description = "Send friend requests to all players for friendboost",
    Default = false,
    Callback = function(value303) f156(value303) end,
  })

  local neighbourChores = v663.Social:AddSection("Neighbour Chores")

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
    Callback = function(value304)
      if value304 then
        f158()
      end
    end,
  })

  task.wait()

  v663.Settings:AddButton({
    Title = "Switch to Lite Version",
    Description = "Only use if your device is weak",
    Confirm = "Switch to Lite version? This will rejoin the game.",
    Callback = function()
      writefile("BARFVersionPref.txt", "lite")

      local queueOnTeleport = queue_on_teleport or syn and syn.queue_on_teleport
        or fluxus and fluxus.queue_on_teleport

      if queueOnTeleport then
        pcall(
          queueOnTeleport,
          "loadstring(game:HttpGet('https://lamduck2005.github.io/RobloxScript/loader.lua'))()"
        )
      end

      v7:Notify({ Title = "Switching to Lite Version", Content = "Rejoining...", Duration = 5 })
      task.wait(2)
      f25()
    end,
  })

  v663.Settings:AddSection("Gacha")

  v663.Settings:AddToggle("Toggle_ShowGachaNotifications", {
    Title = "Show Gacha Notifications",
    Default = false,
  })

  v663.Settings:AddSection("Teleport")

  v663.Settings:AddToggle("Toggle_ShowFloatingTP", {
    Title = "Show Floating Teleport Button",
    Default = false,
    Callback = function(value305)
      if value305 and not v12.Cache.FloatingTPGui then
        f46()
      end

      if v12.Cache.FloatingTPGui then
        v12.Cache.FloatingTPGui.Enabled = value305
      end
    end,
  })

  v663.Settings:AddKeybind("Keybind_TeleportToFarm", {
    Title = "Keybind Teleport to Farm",
    Description = "PC only",
    Mode = "Toggle",
    Default = "P",
    Callback = function()
      pcall(function()
        local humanoidRootPart20 = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local v676 = f45(v14.TELEPORT_DESTINATIONS[1])

        if humanoidRootPart20 and v676 then
          humanoidRootPart20.CFrame = v676
        end
      end)
    end,
  })

  v663.Settings:AddSection("Visuals")

  v663.Settings:AddToggle("Toggle_ExtremeLowPerf", {
    Title = "Extreme Low Performance",
    Description = "Hide plots + LowPerformanceMode + Disable sound",
    Default = false,
    Callback = function(value306) SetExtremeLowPerformance(value306) end,
  })

  v663.Settings:AddToggle("Toggle_CleanGameUI", {
    Title = "Clean Game UI",
    Description = "Best for mobile player",
    Default = false,
    Callback = function(value307)
      local playerGui5 = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")

      if playerGui5 then
        local mainUI = playerGui5:FindFirstChild("MainUI")

        if mainUI then
          local leftButtons = mainUI:FindFirstChild("LeftButtons")
          local rightSide = mainUI:FindFirstChild("RightSide")

          if leftButtons then
            leftButtons.Visible = not value307
          end

          if rightSide then
            rightSide.Visible = not value307
          end
        end
      end
    end,
  })

  v663.Settings:AddToggle("Toggle_MuteAndHideAlerts", {
    Title = "Mute & Hide Alerts",
    Default = false,
    Callback = function(value308)
      pcall(function()
        local notificationsUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("NotificationsUI")

        if notificationsUI then
          notificationsUI.Enabled = not value308
        end

        local saAlert = soundService:FindFirstChild("SFX")
          and soundService.SFX:FindFirstChild("SAAlert")

        if saAlert then
          if value308 then
            v12.Cache.OriginalAlertVolume = saAlert.Volume
            saAlert.Volume = 0
          elseif v12.Cache.OriginalAlertVolume then
            saAlert.Volume = v12.Cache.OriginalAlertVolume
          end
        end
      end)
    end,
  })

  v663.Settings:AddToggle("Toggle_LockCameraFov", {
    Title = "Lock Camera FOV",
    Description = "Prevent camera FOV changes during spins and menus",
    Default = false,
    Callback = function(value309) SetLockCameraFov(value309) end,
  })

  v663.Settings:AddToggle("Toggle_DisableSeedBounce", {
    Title = "Disable Seed Bounce",
    Description = "Skip seed bounce animation and fast roll",
    Default = false,
    Callback = function(value310) SetDisableSeedBounce(value310) end,
  })

  v663.Settings:AddToggle("Toggle_RemoveAllEffects", {
    Title = "Remove All Effects",
    Description = "Disable particles, beams, lights, highlights and postfx",
    Default = false,
    Callback = function(value311) SetRemoveAllEffects(value311) end,
  })

  v8:SetLibrary(v7)
  v10:SetLibrary(v7)
  v8:SetFolder("Lamduck/BARF")
  v10:SetFolder("Lamduck/BARF")
  v8:SetIgnoreIndexes({})
  v10:BuildExtraSection(v663.Settings)
  v8:BuildConfigSection(v663.Settings)
  v10:SetAFKInfo("Cash", function() return "💲", f3(GetPlayerCash()) end)
  window:SelectTab(1)
  v8:LoadAutoloadConfig()
  f4("Boot completed in %.2fs", os.clock() - v1)
end

task.spawn(InitUI)
f8()
f9()

task.delay(3, function()
  if v7.Unloaded then
    return
  end

  f58()
  f60()
  f106()
  f134()
  f110()
  f77()
  f155()
  f161()
  f132()
end)

v7.OnUnload:Once(function()
  pcall(function()
    SetExtremeLowPerformance(false)
    SetLockCameraFov(false)
    SetDisableSeedBounce(false)
    SetRemoveAllEffects(false)

    if v12.Cache.FloatingTPGui then
      v12.Cache.FloatingTPGui:Destroy()
    end

    local playerGui6 = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")

    if playerGui6 then
      local mainUI2 = playerGui6:FindFirstChild("MainUI")

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

      local notificationsUI2 = playerGui6:FindFirstChild("NotificationsUI")

      if notificationsUI2 then
        notificationsUI2.Enabled = true
      end

      local plantContractsCompleted2 = playerGui6:FindFirstChild("PlantContractsCompleted")

      if plantContractsCompleted2 then
        plantContractsCompleted2.Enabled = true
      end
    end

    local saAlert2 = soundService:FindFirstChild("SFX")
      and soundService.SFX:FindFirstChild("SAAlert")

    if saAlert2 and v12.Cache.OriginalAlertVolume then
      saAlert2.Volume = v12.Cache.OriginalAlertVolume
    end
  end)

  for key35, value312 in pairs(v12.Connections) do
    if typeof(value312) == "RBXScriptConnection" then
      pcall(function() value312:Disconnect() end)
    elseif type(value312) == "table" then
      for index148, value313 in ipairs(value312) do
        if typeof(value313) == "RBXScriptConnection" then
          pcall(function() value313:Disconnect() end)
        end
      end

      table.clear(value312)
    end
  end

  table.clear(v12.Connections)
end)
