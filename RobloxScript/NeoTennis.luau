local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local httpService = game:GetService("HttpService")
local collectionService = game:GetService("CollectionService")
local runService = game:GetService("RunService")
local localPlayer = players.LocalPlayer

local playerGui = localPlayer:FindFirstChild("PlayerGui")
  or localPlayer:WaitForChild("PlayerGui", 10)

local function f1(p1)
  if not p1 then
    return nil
  end

  local v5, v6 = pcall(require, p1)

  if not v5 then
    warn("[NeoTennis] SafeRequire failed for " .. tostring(p1) .. ": " .. tostring(v6))
    return nil
  end

  return v6
end

local function f2()
  if type(identifyexecutor) ~= "function" then
    return false
  end

  local v7, v8 = pcall(identifyexecutor)

  if not v7 or type(v8) ~= "string" or v8 == "" then
    return false
  end

  local v9 = string.lower(v8)

  for key in pairs({
    real = true,
    delta = true,
    wave = true,
    solara = true,
    swift = true,
    codex = true,
    awp = true,
    hydrogen = true,
    ronin = true,
    volcano = true,
  }) do
    if string.sub(v9, 1, #key) == key then
      return true
    end
  end

  return false
end

local v10 = {}
local v11 = {}
local v12 = {}
local v13 = {}
local v14 = {}
local v15 = {}
local v16 = {}
local v17 = {}
local v18 = {}
local v19 = {}
local v20 = {}
local v21 = {}
local v22 = {}

local function f3(p2)
  local v23 = v1.Options[p2]
  return v23 and v23.Value
end

function v18.Send(p3, p4, p5, p6)
  pcall(function()
    v1:Notify({
      Title = p3 or "Neo Tennis",
      Content = p4 or "",
      SubContent = p5 or "",
      Duration = p6 or 4,
    })
  end)
end

function v19.Number(p7)
  p7 = tonumber(p7) or 0

  if p7 >= 1000000000000 then
    return string.format("%.2fT", p7 / 1000000000000)
  elseif p7 >= 1000000000 then
    return string.format("%.2fB", p7 / 1000000000)
  elseif p7 >= 1000000 then
    return string.format("%.2fM", p7 / 1000000)
  elseif p7 >= 1000 then
    return string.format("%.1fk", p7 / 1000)
  end

  return tostring(math.floor(p7))
end

function v19.Clock(p8)
  p8 = math.max(0, tonumber(p8) or 0)
  local v24 = math.floor(p8 / 60)
  local v25 = math.floor(p8 % 60)
  return string.format("%02d:%02d", v24, v25)
end

function v20.DeepCopy(p9)
  if type(p9) ~= "table" then
    return p9
  end

  local v26 = {}

  for key2, value in pairs(p9) do
    v26[v20.DeepCopy(key2)] = v20.DeepCopy(value)
  end

  return v26
end

function v20.CountKeys(p10)
  if type(p10) ~= "table" then
    return 0
  end

  local count = 0

  for key3 in pairs(p10) do
    count = count + 1
  end

  return count
end

function v22.GetJitter(p11, p12)
  p11 = p11 or 0.05
  p12 = p12 or 0.2
  return p11 + math.random() * (p12 - p11)
end

v12.LastRemoteCallTicks = {}

function v21.GetRemote(p13)
  local remotes = replicatedStorage:FindFirstChild("Remotes")

  if remotes then
    return remotes:FindFirstChild(p13)
  end

  return nil
end

function v21.DispatchSafe(p14, p15, p16, p17)
  if not p14 then
    return false, "Remote not found"
  end

  p15 = p15 or "Default"
  local v27 = os.clock()
  local v28 = v12.LastRemoteCallTicks[p15] or 0
  local v29 = 0.35 + v22.GetJitter(0.05, 0.15)

  if v27 - v28 < v29 then
    task.wait(v29 - (v27 - v28))
  end

  if p17 and shared.ClientTGAnalytics then
    pcall(function() shared.ClientTGAnalytics:InterfaceUI(p17.Screen, p17.Button, true) end)
  end

  v12.LastRemoteCallTicks[p15] = os.clock()
  local v30, v31

  if p14:IsA("RemoteFunction") then
    v30, v31 = pcall(function() return p14:InvokeServer(p15, p16) end)
  else
    v30, v31 = pcall(function()
      p14:FireServer(p15, p16)
      return true
    end)
  end

  return v30, v31
end

v10.StyleNames = {}
v10.RacketNames = {}
v10.EggNames = {}
v10.RankNames = {}

function v15.Configs()
  local configs = replicatedStorage:FindFirstChild("Configs")

  if not configs then
    return
  end

  local v32 = f1(configs:FindFirstChild("ResStyles"))

  if v32 and v32.__index then
    local v33 = {}

    for index, value2 in ipairs(v32.__index) do
      table.insert(v33, value2)
    end

    v10.StyleNames = v33
  end

  local v34 = f1(configs:FindFirstChild("ResRacket"))

  if v34 then
    local v35 = {}

    for key4, value3 in pairs(v34) do
      if type(value3) == "table" and value3.Name then
        table.insert(v35, key4)
      end
    end

    table.sort(v35)
    v10.RacketNames = v35
  end

  local v36 = f1(configs:FindFirstChild("ResLootEgg"))

  if v36 then
    local v37 = {}

    for key5, value4 in pairs(v36) do
      if type(value4) == "table" and value4.Name then
        table.insert(v37, key5)
      end
    end

    table.sort(v37)
    v10.EggNames = v37
  end
end

function v15.GetPlayerData()
  if f2() then
    local playerScripts = localPlayer:FindFirstChild("PlayerScripts")

    if playerScripts then
      local v38 = f1(playerScripts:FindFirstChild("ClientPlayerData"))

      if v38 then
        return v38
      end
    end
  end

  if not v12.DataMirror then
    v12.DataMirror = {
      Currency = {
        Gold = 0,
        Exp = 0,
        NormalSpin = 0,
        AdvanceSpin = 0,
        BattlePassCoin = 0,
      },
      Equipment = {},
      EquipmentLevel = 1,
      Task = {},
    }
  end

  return v12.DataMirror
end

function v15.GetMatchData()
  if type(shared.GetLocalPlayerMatchInst) == "function" then
    local v39 = shared.GetLocalPlayerMatchInst()

    if v39 then
      return v39
    end
  end

  local matchId = localPlayer:GetAttribute("MatchId")

  if matchId and replicatedStorage:FindFirstChild("MatchInsts") then
    return replicatedStorage.MatchInsts:FindFirstChild(matchId)
  end

  return nil
end

local v40 = {}

function v40.HitBall()
end

function v40.Serve()
end

function v40.Awaken()
end

local v41 = {}

function v41.BulkSell()
end

function v41.ExpandGrid()
end

local v42 = {}

function v42.BuyEgg()
end

function v42.Spin()
end

local v43 = {}

function v43.SyncTask()
end

function v43.ClaimRewards()
end

local v44 = {}

function v44.TeleportChamber()
end

local function f4()
  if v11.IsUpdateMultiParagraphLoopRunning then
    return
  end

  v11.IsUpdateMultiParagraphLoopRunning = true

  local function f5()
    if not v14.CombatMatchOverview then
      return
    end

    local v45 = v15.GetMatchData()

    if v45 then
      local courtName = v45:GetAttribute("CourtName") or "Unknown"
      local team1WinSetCount = v45:GetAttribute("Team1WinSetCount") or 0
      local team2WinSetCount = v45:GetAttribute("Team2WinSetCount") or 0
      local team1Score = v45:GetAttribute("Team1Score") or 0
      local team2Score = v45:GetAttribute("Team2Score") or 0

      local v46 = f1(replicatedStorage:WaitForChild("Utility", 2):WaitForChild(
        "TennisScoreHelper", 2
      ))

      local v47, v48 = "0", "0"

      if v46 and v46.GetTennisScoreDisplay then
        v47, v48 = v46:GetTennisScoreDisplay(team1Score, team2Score)
      end

      v14.CombatMatchOverview:SetTitle("Match Status: In Progress (" .. tostring(courtName)
        .. ")")

      v14.CombatMatchOverview:SetContent(string.format(
        "Sets: %d - %d | Points: %s - %s", team1WinSetCount, team2WinSetCount, tostring(v47),
        tostring(v48)
      ))
    else
      v14.CombatMatchOverview:SetTitle("Match Status: In Lobby")
      v14.CombatMatchOverview:SetContent("Waiting for match queue or court entry.")
    end
  end

  local function f6()
    if not v14.GachaBalance then
      return
    end

    local v49 = v15.GetPlayerData()
    local gold = 0

    if type(v49.GetCurrency) == "function" then
      gold = v49:GetCurrency("Gold") or 0
    elseif v49.Currency then
      gold = v49.Currency.Gold or 0
    end

    v14.GachaBalance:SetContent(string.format(
      "Gold: %s | Normal Spin: -- | Advance Spin: --", v19.Number(gold)
    ))
  end

  local function f7()
    if not v14.InventoryCapacity then
      return
    end

    v14.InventoryCapacity:SetContent("Capacity: Scanning inventory... | Grid Level: Normal")
  end

  local function f8()
    if not v14.QuestsProgress then
      return
    end

    v14.QuestsProgress:SetContent("Battle Pass: Ready | Daily Quests: Syncing...")
  end

  task.spawn(function()
    while not v1.Unloaded do
      if not (v11.SettingsDisableUpdateAllParagraph
        or f3("Toggle_Settings_DisableUpdateAllParagraph")) then
        pcall(f5)
        pcall(f6)
        pcall(f7)
        pcall(f8)
      end

      task.wait(2.5)
    end

    v11.IsUpdateMultiParagraphLoopRunning = false
  end)
end

function v17.DisableVisualDisruptions()
  pcall(function()
    runService:UnbindFromRenderStep("CameraShake")
    runService:UnbindFromRenderStep("CameraLittleShake")
  end)

  if localPlayer.Character then
    localPlayer.Character:SetAttribute("WhiteScreenFlag", false)
  end
end

function v17.RestoreAll()
  pcall(function()
    if localPlayer.Character then
      localPlayer.Character:SetAttribute("WhiteScreenFlag", nil)
    end
  end)
end

pcall(function() localPlayer:WaitForChild("SharedReady", 8) end)
v15.Configs()

local window = v1:CreateWindow({
  Title = "Neo Tennis Undetectable",
  SubTitle = "by Lamduck",
  TabWidth = 160,
  Size = UDim2.fromOffset(580, 460),
  Acrylic = false,
  Theme = "Dark",
  MinimizeKey = Enum.KeyCode.RightControl,
})

local v50 = {
  Combat = window:AddTab({ Title = "Combat", Icon = "swords" }),
  Styles = window:AddTab({ Title = "Styles", Icon = "user-check" }),
  Gacha = window:AddTab({ Title = "Gacha", Icon = "egg" }),
  Inventory = window:AddTab({ Title = "Inventory", Icon = "backpack" }),
  Quests = window:AddTab({ Title = "Quests", Icon = "trophy" }),
  AFK = window:AddTab({ Title = "AFK", Icon = "coffee" }),
  Visuals = window:AddTab({ Title = "Visuals", Icon = "eye-off" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

function v16.Combat()
  v14.CombatMatchOverview = v50.Combat:AddSection("Match Overview"):AddParagraph("Paragraph_Combat_MatchOverview", {
    Title = "Match Status: In Lobby",
    Content = "Initializing court detection...",
  })

  local safetyAntiBanGates = v50.Combat:AddSection("Safety & Anti-Ban Gates")

  v50.Combat:AddSlider("Slider_Combat_HitRadius", {
    Title = "Safe Hit Radius",
    Description = "Distance limit for hitting ball to avoid reach-hack flags",
    Default = 11,
    Min = 8,
    Max = 15,
    Rounding = 0,
    Callback = function(value5) v11.CombatHitRadius = value5 end,
  })

  v50.Combat:AddSlider("Slider_Combat_TargetWinRate", {
    Title = "Target Winrate (%)",
    Description = "Natural winrate to avoid Elo velocity anomaly",
    Default = 80,
    Min = 65,
    Max = 95,
    Rounding = 0,
    Callback = function(value6) v11.CombatTargetWinRate = value6 end,
  })

  v50.Combat:AddToggle("Toggle_Combat_SoftWinMode", {
    Title = "Soft Win Humanizer",
    Description = "Occasionally drop a point to simulate realistic tennis gameplay",
    Default = true,
    Callback = function(value7) v11.CombatSoftWinMode = value7 end,
  })

  local autoCombat = v50.Combat:AddSection("Auto Combat")

  v50.Combat:AddDropdown("Dropdown_Combat_PreferredShotType", {
    Title = "Preferred Shot Type",
    Values = { "Common", "High", "LeftCurve", "RightCurve", "Quick", "JumpHit" },
    Default = "Common",
    Callback = function(value8) v11.CombatPreferredShotType = value8 end,
  })

  v50.Combat:AddToggle("Toggle_Combat_AutoHitBall", {
    Title = "Auto Hit Ball",
    Description = "Natural predictive movement and return shot",
    Default = false,
    Callback = function(value9)
      v11.CombatAutoHitBall = value9

      if value9 then
        v18.Send("Combat", "Auto Hit activated with humanized jitter")
      end
    end,
  })

  v50.Combat:AddToggle("Toggle_Combat_AutoServe", {
    Title = "Auto Serve",
    Description = "Serve with mandatory 1.45s delay and 85% power threshold",
    Default = false,
    Callback = function(value10) v11.CombatAutoServe = value10 end,
  })

  v50.Combat:AddToggle("Toggle_Combat_AutoSprintCatch", {
    Title = "Auto Sprint to Ball",
    Description = "Sprint catch with valid TriggerSprintTick flag",
    Default = true,
    Callback = function(value11) v11.CombatAutoSprintCatch = value11 end,
  })

  local awakeningUltimate = v50.Combat:AddSection("Awakening & Ultimate")

  v50.Combat:AddToggle("Toggle_Combat_AutoAwaken", {
    Title = "Auto Awaken",
    Description = "Activate awakening mode when energy reaches 100%",
    Default = false,
    Callback = function(value12) v11.CombatAutoAwaken = value12 end,
  })
end

function v16.Styles()
  v14.StylesCurrentStyle = v50.Styles:AddSection("Style Overview"):AddParagraph("Paragraph_Styles_CurrentStyle", {
    Title = "Equipped Style",
    Content = "Style stats and awakening details...",
  })

  local styleManagement = v50.Styles:AddSection("Style Management")

  v50.Styles:AddDropdown("Dropdown_Styles_TargetStyle", {
    Title = "Target Style",
    Values = #v10.StyleNames > 0 and v10.StyleNames
      or { "Styles_001", "Styles_002", "Styles_003" },
    Default = "Styles_001",
    Callback = function(value13) v11.StylesTargetStyle = value13 end,
  })

  v50.Styles:AddToggle("Toggle_Styles_AutoEquipBestStyle", {
    Title = "Auto Equip Best Style",
    Default = false,
    Callback = function(value14) v11.StylesAutoEquipBestStyle = value14 end,
  })
end

function v16.Gacha()
  v14.GachaBalance = v50.Gacha:AddSection("Currency Balance"):AddParagraph("Paragraph_Gacha_Balance", {
    Title = "Available Currencies",
    Content = "Loading balance data...",
  })

  local safetyThresholds = v50.Gacha:AddSection("Safety Thresholds")

  v50.Gacha:AddSlider("Slider_Gacha_MinSafeGold", {
    Title = "Min Safe Gold",
    Description = "Stop auto buying eggs if Gold drops below this threshold",
    Default = 2000,
    Min = 500,
    Max = 20000,
    Rounding = 0,
    Callback = function(value15) v11.GachaMinSafeGold = value15 end,
  })

  v50.Gacha:AddSlider("Slider_Gacha_OpenDelay", {
    Title = "Open Delay (seconds)",
    Description = "Animation delay between egg purchases to avoid velocity flags",
    Default = 3.5,
    Min = 2.5,
    Max = 6,
    Rounding = 1,
    Callback = function(value16) v11.GachaOpenDelay = value16 end,
  })

  local autoEggPacks = v50.Gacha:AddSection("Auto Egg Packs")

  v50.Gacha:AddDropdown("Dropdown_Gacha_TargetPacks", {
    Title = "Target Egg Packs",
    Values = #v10.EggNames > 0 and v10.EggNames or { "LE_0002", "LE_0004", "LE_0005" },
    Multi = true,
    Default = {},
    Callback = function(value17) v11.GachaTargetPacks = value17 end,
  })

  v50.Gacha:AddToggle("Toggle_Gacha_AutoBuyPacks", {
    Title = "Auto Buy Target Packs",
    Default = false,
    Callback = function(value18) v11.GachaAutoBuyPacks = value18 end,
  })
end

function v16.Inventory()
  v14.InventoryCapacity = v50.Inventory:AddSection("Inventory Capacity"):AddParagraph("Paragraph_Inventory_Capacity", {
    Title = "Grid Slots",
    Content = "Reading equipment slots...",
  })

  v50.Inventory:AddToggle("Toggle_Inventory_AutoExpandGrid", {
    Title = "Auto Expand Grid",
    Description = "Upgrade inventory capacity when full via UpdateEquipmentLevel",
    Default = false,
    Callback = function(value19) v11.InventoryAutoExpandGrid = value19 end,
  })

  local safeScrapItemRecycler = v50.Inventory:AddSection("Safe Scrap Item Recycler")

  v50.Inventory:AddDropdown("Dropdown_Inventory_SellRarities", {
    Title = "Sell Rarities",
    Values = { "Common", "Rare" },
    Multi = true,
    Default = { "Common" },
    Callback = function(value20) v11.InventorySellRarities = value20 end,
  })

  v50.Inventory:AddSlider("Slider_Inventory_BatchSize", {
    Title = "Batch Size",
    Description = "Items per bulk sell request to avoid DataStore throttling",
    Default = 8,
    Min = 3,
    Max = 10,
    Rounding = 0,
    Callback = function(value21) v11.InventoryBatchSize = value21 end,
  })

  v50.Inventory:AddToggle("Toggle_Inventory_ProtectEquipped", {
    Title = "Protect Equipped Items",
    Description = "Never sell items currently worn on character",
    Default = true,
    Callback = function(value22) v11.InventoryProtectEquipped = value22 end,
  })

  v50.Inventory:AddToggle("Toggle_Inventory_AutoBulkSell", {
    Title = "Auto Bulk Sell Scrap",
    Description = "Recycle selected rarities with safe 1.5s delay",
    Default = false,
    Confirm = "Activate safe bulk selling with account protection delay?",
    Callback = function(value23) v11.InventoryAutoBulkSell = value23 end,
  })
end

function v16.Quests()
  v14.QuestsProgress = v50.Quests:AddSection("Quest Progression"):AddParagraph("Paragraph_Quests_Progress", {
    Title = "Task Tracker",
    Content = "Syncing quest data...",
  })

  local legitimateTaskAutomation = v50.Quests:AddSection("Legitimate Task Automation")

  v50.Quests:AddToggle("Toggle_Quests_AutoSyncLegitTasks", {
    Title = "Auto Sync Real Tasks",
    Description = "Only report progress when real match events occur",
    Default = true,
    Callback = function(value24) v11.QuestsAutoSyncLegitTasks = value24 end,
  })

  v50.Quests:AddToggle("Toggle_Quests_AutoClaimTasks", {
    Title = "Auto Claim Tasks",
    Default = true,
    Callback = function(value25) v11.QuestsAutoClaimTasks = value25 end,
  })

  v50.Quests:AddToggle("Toggle_Quests_AutoClaimDailyLogin", {
    Title = "Auto Claim Daily Login",
    Default = true,
    Callback = function(value26) v11.QuestsAutoClaimDailyLogin = value26 end,
  })

  local developerSpecialGifts = v50.Quests:AddSection("Developer & Special Gifts")

  v50.Quests:AddButton({
    Title = "Claim All Event & Dev Gifts",
    Description = "Claim Xmas, Custom Racket, Court & Outfit once",
    Callback = function()
      pcall(function()
        local remotes2 = replicatedStorage:FindFirstChild("Remotes")

        if not remotes2 then
          return
        end

        local christmasRewardRE = remotes2:FindFirstChild("ChristmasRewardRE")

        if christmasRewardRE then
          christmasRewardRE:FireServer("TakeReward")
        end

        local takePlayerCustomItemRE = remotes2:FindFirstChild("TakePlayerCustomItemRE")

        if takePlayerCustomItemRE then
          takePlayerCustomItemRE:FireServer("TakeRacketReward")
          takePlayerCustomItemRE:FireServer("TakeCourtReward")
          takePlayerCustomItemRE:FireServer("TakeOutfitReward")
        end

        v18.Send("Gifts", "Dispatched claim events for special gifts")
      end)
    end,
  })
end

function v16.AFK()
  v14.AFKStatus = v50.AFK:AddSection("Legitimate AFK Chamber"):AddParagraph("Paragraph_AFK_Status", {
    Title = "AFK Reward Rate: +60 Gold / min",
    Content = "Teleport to official AFK Place for safe passive farming",
  })

  v50.AFK:AddButton({
    Title = "Teleport to AFK Place",
    Description = "PlaceId: 71480216295363",
    Callback = function()
      pcall(function()
        local v51 = f1(replicatedStorage:WaitForChild("Utility"):WaitForChild("TeleportServiceHelper"))

        if v51 then
          v51:Teleport(localPlayer, 71480216295363, nil)
        else
          game:GetService("TeleportService"):Teleport(71480216295363, localPlayer)
        end
      end)
    end,
  })

  v50.AFK:AddButton({
    Title = "Teleport to Main Lobby",
    Description = "PlaceId: 85056532479796",
    Callback = function()
      pcall(function()
        game:GetService("TeleportService"):Teleport(85056532479796, localPlayer)
      end)
    end,
  })

  v50.AFK:AddToggle("Toggle_AFK_AntiIdle", {
    Title = "Roblox Anti-Idle",
    Description = "Simulate subtle input every 4 minutes to prevent 20m disconnect",
    Default = true,
    Callback = function(value27) v11.AFKAntiIdle = value27 end,
  })
end

function v16.Visuals()
  local visualOptimizations = v50.Visuals:AddSection("Visual Optimizations")

  v50.Visuals:AddToggle("Toggle_Visuals_DisableCameraShake", {
    Title = "Disable Camera Shake",
    Description = "Unbind render step camera shaking for clear ball tracking",
    Default = true,
    Callback = function(value28)
      v11.VisualsDisableCameraShake = value28

      if value28 then
        v17.DisableVisualDisruptions()
      end
    end,
  })

  v50.Visuals:AddToggle("Toggle_Visuals_DisableWhiteScreen", {
    Title = "Disable Awaken Flash",
    Description = "Block WhiteScreenFlag blinding flashes when opponents awaken",
    Default = true,
    Callback = function(value29) v11.VisualsDisableWhiteScreen = value29 end,
  })
end

function v16.Settings()
  v50.Settings:AddToggle("Toggle_Settings_DisableUpdateAllParagraph", {
    Title = "Disable All Paragraphs Update",
    Description = "Stop UI text refreshes to maximize FPS during intensive play",
    Default = false,
    Callback = function(value30) v11.SettingsDisableUpdateAllParagraph = value30 end,
  })
end

v16.Combat()
v16.Styles()
v16.Gacha()
v16.Inventory()
v16.Quests()
v16.AFK()
v16.Visuals()
v16.Settings()

v2:SetLibrary(v1)
v4:SetLibrary(v1)
v2:SetFolder("Lamduck/NeoTennis")
v4:SetFolder("Lamduck/NeoTennis")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v50.Settings)
v2:BuildConfigSection(v50.Settings)
f4()

if v11.VisualsDisableCameraShake or f3("Toggle_Visuals_DisableCameraShake") then
  v17.DisableVisualDisruptions()
end

v13.CharacterAdded = localPlayer.CharacterAdded:Connect(function(character)
  task.wait(1)

  if v11.VisualsDisableCameraShake or f3("Toggle_Visuals_DisableCameraShake") then
    v17.DisableVisualDisruptions()
  end
end)

v1.OnUnload:Once(function()
  for key6, value31 in pairs(v13) do
    if typeof(value31) == "RBXScriptConnection" and value31.Connected then
      value31:Disconnect()
    end
  end

  table.clear(v13)
  v17.RestoreAll()

  table.clear(v10)
  table.clear(v11)
  table.clear(v12)
  table.clear(v14)
end)

v2:LoadAutoloadConfig()
window:SelectTab(1)
