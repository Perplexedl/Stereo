local function f1(p1)
  local v1, v2 = pcall(require, p1)

  if not v1 then
    warn("[Lamduck] Failed to require " .. tostring(p1) .. ": " .. tostring(v2))
    return nil
  end

  return v2
end

local function f2()
  if type(identifyexecutor) ~= "function" then
    return false
  end

  local v3, v4 = pcall(identifyexecutor)

  if not v3 or type(v4) ~= "string" or v4 == "" then
    return false
  end

  local v5 = string.lower(v4)

  for key in pairs({
    real = true,
    delta = true,
    wave = true,
    swift = true,
    codex = true,
    awp = true,
    hydrogen = true,
    ronin = true,
    volcano = true,
  }) do
    if string.sub(v5, 1, #key) == key then
      return true
    end
  end

  return false
end

local v6, v7, v8, v9 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer

local playerGui = localPlayer:FindFirstChild("PlayerGui")
  or localPlayer:WaitForChild("PlayerGui", 10)

local function f3()
  if not playerGui or not playerGui.Parent then
    playerGui = localPlayer
      and (localPlayer:FindFirstChild("PlayerGui") or localPlayer:WaitForChild("PlayerGui", 2))
  end

  return playerGui
end

local httpService = game:GetService("HttpService")
local collectionService = game:GetService("CollectionService")
local playerDATACHANGED = nil
local v10 = nil
local v11 = nil
local v12 = nil

local function f4()
  if not playerDATACHANGED then
    playerDATACHANGED = replicatedStorage:FindFirstChild("PLAYER_DATA_CHANGED")
      or replicatedStorage:WaitForChild("PLAYER_DATA_CHANGED", 10)
  end

  return playerDATACHANGED
end

local function f5()
  if not v10 then
    local shared = replicatedStorage:FindFirstChild("Shared")
    local libraries = shared and shared:FindFirstChild("Libraries")
    local serializer = libraries and libraries:FindFirstChild("Serializer")
    v10 = serializer and f1(serializer) or nil
  end

  return v10
end

local v13 = {
  SUFFIXES = {
    "", "K", "M", "B", "T", "QA", "QI", "SX", "SP", "OC", "NO", "DE", "UN", "DD", "TD", "QAD",
    "QID", "SXD", "SPD", "OCD", "NOD", "VG",
  },
  SEED_PROP_KEYS = { "Grade", "Size", "Mutation", "Serial" },
  MoneySuffixMultipliers = {
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
  GRADE_MULTIPLIERS = {
    Small = 0.65217391304348,
    Standard = 1,
    Large = 1.3478260869565,
    Huge = 1.695652173913,
    Colossal = 2.0434782608696,
  },
  COMPOST_THRESHOLDS = {
    [1] = {
      ["Poor Compost"] = 25000000,
      ["Rich Compost"] = 150000000,
      ["Prime Compost"] = 500000000,
      ["Overgrown Compost"] = 1000000000,
    },
    [2] = {
      ["Poor Compost"] = 500000000,
      ["Rich Compost"] = 1000000000,
      ["Prime Compost"] = 8000000000,
      ["Overgrown Compost"] = 20000000000,
    },
    [3] = {
      ["Poor Compost"] = 20000000000,
      ["Rich Compost"] = 80000000000,
      ["Prime Compost"] = 300000000000,
      ["Overgrown Compost"] = 3200000000000,
    },
  },
  KNOWN_FISH_RARITIES = {
    Minnow = "Common",
    Goldfish = "Common",
    Bluegill = "Common",
    Perch = "Common",
    Bass = "Uncommon",
    Carp = "Uncommon",
    Pumpkinseed = "Uncommon",
    ["Rainbow Trout"] = "Rare",
    Catfish = "Rare",
    Pike = "Rare",
    Koi = "Epic",
    Piranha = "Epic",
    ["Electric Eel"] = "Epic",
    Sturgeon = "Legendary",
    ["Golden Arowana"] = "Legendary",
    ["Phantom Gar"] = "Secret",
    ["Prism Betta"] = "Prismatic",
    ["Cosmic Discus"] = "Transcended",
    ["Phoenix Fish"] = "Celestial",
    ["Dragon Koi"] = "Celestial",
  },
  PARAGRAPH_DISABLED_TEXT = "<font color=\"#888888\">Paragraph updates are disabled (Performance Mode)</font>",
}

local v14 = {}

local v15 = {
  DebugPrintData = false,
  SettingsEnableFileLogging = false,
  SettingsAnimalsNotification = true,
  RollVersion = 0,
  GameReady = false,
  ExecCanScrape = f2(),
  IsAutoFishLoopRunning = false,
  IsAutoSellFishLoopRunning = false,
  IsAutoFishingUpgradesLoopRunning = false,
  IsUpdateFishOverviewLoopRunning = false,
  IsAutoEquipBestFishLoopRunning = false,
}

local v16 = {
  DataMirrorCache = {},
  RawPayloadBuffer = {},
  PlantedSeedsBuffer = {},
  AvailableSeedsBuffer = {},
  FloorTilesBuffer = {},
  FishingCastAccepted = false,
  FishingBiteTriggered = false,
  FishingLastCastTime = 0,
  FishingLastBiteTime = 0,
  PearlShopLastRestock = 0,
  LastCaughtFish = nil,
}

local v17 = {}
local v18 = {}
local v19 = {}
local v20 = {}
local v21 = {}
local v22 = {}
local v23 = {}
local v24 = {}
local v25 = {}
local v26 = {}
local v27 = {}
local v28 = { FILE = "Lamduck/BuildARingFarm2_PetTeams.json" }
local v29 = {}
local v30 = {}
local v31 = {}
local v32 = { FilePath = nil, LastMsg = nil }
local f6 = nil

function v32.InitFile()
  if type(appendfile) ~= "function" then
    return
  end

  local v33, v34 = pcall(function()
    if type(makefolder) == "function" then
      if type(isfolder) == "function" then
        if not isfolder("Lamduck") then
          pcall(makefolder, "Lamduck")
        end

        if not isfolder("Lamduck/BuildARingFarm2") then
          pcall(makefolder, "Lamduck/BuildARingFarm2")
        end
      else
        pcall(makefolder, "Lamduck")
        pcall(makefolder, "Lamduck/BuildARingFarm2")
      end
    end

    if type(listfiles) == "function" then
      local v35, v36 = pcall(listfiles, "Lamduck/BuildARingFarm2")

      if v35 and type(v36) == "table" then
        local v37 = {}

        for index, value in ipairs(v36) do
          local v38 = string.match(value, "[^/\\]+$") or value

          if string.sub(v38, 1, 16) == "BuildARingFarm2_" and string.sub(v38, -4) == ".log" then
            table.insert(v37, { path = value, name = v38 })
          end
        end

        table.sort(v37, function(p2, p3)
          return (string.match(p2.name, "(%d%d%d%d%-%d%d%-%d%d_%d%d%-%d%d%-%d%d)") or p2.name)
            < (string.match(p3.name, "(%d%d%d%d%-%d%d%-%d%d_%d%d%-%d%d%-%d%d)") or p3.name)
        end)

        while #v37 >= 10 do
          local v39 = table.remove(v37, 1)

          if type(delfile) == "function" then
            pcall(delfile, v39.path)
          end
        end
      end
    end

    local toLocalTime = DateTime.now():ToLocalTime()

    local v40 = string.format(
      "%04d-%02d-%02d_%02d-%02d-%02d", toLocalTime.Year, toLocalTime.Month, toLocalTime.Day,
      toLocalTime.Hour, toLocalTime.Minute, toLocalTime.Second
    )

    local gsub = "Unknown"

    if type(identifyexecutor) == "function" then
      local v41, v42 = pcall(identifyexecutor)

      if v41 and type(v42) == "string" and v42 ~= "" then
        gsub = v42:gsub("[%c%p%s]+", "_")
      end
    end

    local v43 = string.format(
      "%s/BuildARingFarm2_%s_%s.log", "Lamduck/BuildARingFarm2", gsub, v40
    )

    local v44 = string.format([[
========================================
BuildARingFarm2 Log Session
Executor: %s
Start Time: %s
========================================
]], gsub, DateTime.now():ToIsoDate())

    if type(writefile) == "function" then
      local v45 = pcall(writefile, v43, v44)

      if not v45 then
        v43 = string.format("BuildARingFarm2_%s_%s.log", gsub, v40)
        v45 = pcall(writefile, v43, v44)
      end

      if v45 then
        v32.FilePath = v43
      end
    end
  end)

  if not v33 then
    warn("[Logger] Failed to initialize file logger: " .. tostring(v34))
  end
end

function v32.AppendFile(p4)
  if type(appendfile) ~= "function" then
    return
  end

  if not v32.FilePath then
    v32.InitFile()
  end

  if not v32.FilePath then
    return
  end

  pcall(appendfile, v32.FilePath, p4 .. "\n")
end

function v32.IsFileEnabled()
  local settingsEnableFileLogging = v15.SettingsEnableFileLogging

  if settingsEnableFileLogging == nil then
    settingsEnableFileLogging = GetOptionValue("Toggle_Settings_EnableFileLogging")
  end

  return settingsEnableFileLogging == true
end

function v32.Log(p5, ...)
  local v46 = select("#", ...) > 0 and string.format(tostring(p5), ...) or tostring(p5)

  if v46 == v32.LastMsg then
    return
  end

  v32.LastMsg = v46
  local toLocalTime2 = DateTime.now():ToLocalTime()

  local v47 = string.format(
    "[%02d:%02d:%02d.%03d] %s", toLocalTime2.Hour, toLocalTime2.Minute, toLocalTime2.Second,
    toLocalTime2.Millisecond, v46
  )

  print(v47)

  if v32.IsFileEnabled() then
    v32.AppendFile(v47)
  end
end

function v32.Debug(p6, ...)
  if not v32.IsFileEnabled() then
    return
  end

  local v48 = select("#", ...) > 0 and string.format(tostring(p6), ...) or tostring(p6)

  if v48 == v32.LastMsg then
    return
  end

  v32.LastMsg = v48
  local toLocalTime3 = DateTime.now():ToLocalTime()

  local v49 = string.format(
    "[%02d:%02d:%02d.%03d] %s", toLocalTime3.Hour, toLocalTime3.Minute, toLocalTime3.Second,
    toLocalTime3.Millisecond, v48
  )

  print(v49)
  v32.AppendFile(v49)
end

local log = v32.Log
local v50 = v32.Debug

local function f7(p7)
  local shared2 = replicatedStorage:FindFirstChild("Shared")
  local services = shared2 and shared2:FindFirstChild("Services")
  local config = services and services:FindFirstChild("Config")
  local findFirstChild = config and config:FindFirstChild(p7)

  if findFirstChild and findFirstChild:IsA("ModuleScript") then
    local v51, v52 = pcall(require, findFirstChild)

    if v51 and type(v52) == "table" then
      return v52
    end
  end

  return nil
end

local function f8(p8)
  local v53 = v6.Options[p8]
  return v53 and v53.Value
end

local function f9(title, p9, p10)
  if not pcall(function() v6:Notify({ Title = title, Content = p9, Duration = p10 or 4 }) end) then
    pcall(function()
      game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = p9,
        Icon = "rbxthumb://type=Asset&id=81215685023875&w=150&h=150",
        Duration = p10 or 4,
      })
    end)
  end
end

local function f10()
  local settingsDisableParagraphs = v15.SettingsDisableParagraphs

  if settingsDisableParagraphs == nil then
    settingsDisableParagraphs = f8("Toggle_Settings_DisableParagraphs")
  end

  return settingsDisableParagraphs == true
end

local function f11(p11, p12)
  if not p11 then
    return
  end

  if f10() then
    p12 = "<font color=\"#888888\">Paragraph updates are disabled (Performance Mode)</font>"
  else
    p12 = p12 or ""
  end

  if rawget(p11, "Value") == p12 then
    return
  end

  p11:SetContent(p12)
end

local function f12()
  for key2, value2 in pairs(v18) do
    if type(value2) == "table" then
      if value2.SetContent then
        f11(value2)
      else
        for key3, value3 in pairs(value2) do
          if type(value3) == "table" and value3.SetContent then
            f11(value3)
          end
        end
      end
    end
  end
end

function v22.Farm(p13, p14)
  local settingsFarmNotification = v15.SettingsFarmNotification

  if settingsFarmNotification == nil then
    settingsFarmNotification = f8("Toggle_Settings_FarmNotification")
  end

  if settingsFarmNotification ~= false then
    f9("Farm", p13, p14 or 4)
    v50("[Farm] " .. tostring(p13))
  end
end

function v22.Gacha(p15, p16)
  local settingsSeedGachaNotification = v15.SettingsSeedGachaNotification

  if settingsSeedGachaNotification == nil then
    settingsSeedGachaNotification = f8("Toggle_Settings_SeedGachaNotification")
  end

  if settingsSeedGachaNotification ~= false then
    f9("Seed Gacha", p15, p16 or 4)
    v50(p15)
  end
end

function v22.Shop(p17, p18)
  local settingsShopNotification = v15.SettingsShopNotification

  if settingsShopNotification == nil then
    settingsShopNotification = f8("Toggle_Settings_ShopNotification")
  end

  if settingsShopNotification ~= false then
    f9("Shop", p17, p18 or 4)
    v50(p17)
  end
end

function v22.FloorManager(p19, p20)
  local settingsFloorManagerNotification = v15.SettingsFloorManagerNotification

  if settingsFloorManagerNotification == nil then
    settingsFloorManagerNotification = f8("Toggle_Settings_FloorManagerNotification")
  end

  if settingsFloorManagerNotification ~= false then
    f9("Floor Manager", p19, p20 or 4)
  end
end

function v22.QuickSettings(p21, p22)
  f9("Quick Settings", p21, p22 or 4)
  v50("[QuickSettings] " .. tostring(p21))
end

function v22.Animals(p23, p24, p25)
  local settingsAnimalsNotification = v15.SettingsAnimalsNotification

  if settingsAnimalsNotification == nil then
    settingsAnimalsNotification = f8("Toggle_Settings_AnimalsNotification")
  end

  if settingsAnimalsNotification ~= false then
    f9(p25 or "Animals", p23, p24 or 4)
  end
end

function v22.Pets(p26, p27)
  v22.Animals(p26, p27, "Animals")
end

function v22.Bees(p28, p29)
  v22.Animals(p28, p29, "Animals")
end

function v22.Fish(p30, p31)
  v22.Animals(p30, p31, "Animals")
end

function v22.Reward(p32, p33, p34)
  if p34 then
    local settingsRewardNotification = v15.SettingsRewardNotification

    if settingsRewardNotification == nil then
      settingsRewardNotification = f8("Toggle_Settings_RewardNotification")
    end

    if settingsRewardNotification == false then
      return
    end
  end

  f9("Reward", p32, p33 or 4)
  v50("[Reward] " .. tostring(p32))
end

function v22.Event(p35, p36)
  local settingsEventNotification = v15.SettingsEventNotification

  if settingsEventNotification == nil then
    settingsEventNotification = f8("Toggle_Settings_EventNotification")
  end

  if settingsEventNotification ~= false then
    f9("World Events", p35, p36 or 4)
    v50("[Events] " .. tostring(p35))
  end
end

function v22.Guild(p37, p38)
  local settingsEventNotification2 = v15.SettingsEventNotification

  if settingsEventNotification2 == nil then
    settingsEventNotification2 = f8("Toggle_Settings_EventNotification")
  end

  if settingsEventNotification2 ~= false then
    f9("Guild", p37, p38 or 4)
    v50("[Guild] " .. tostring(p37))
  end
end

function v24.Number(p39)
  if not p39 or p39 == 0 then
    return "0"
  end

  if p39 < 1000 then
    return tostring(math.floor(p39))
  end

  local v54 = math.floor(math.log10(p39) / 3)

  if v54 < 1 then
    v54 = 1
  end

  if v54 > #v13.SUFFIXES - 1 then
    v54 = #v13.SUFFIXES - 1
  end

  local v55 = p39 / 10 ^ (v54 * 3)

  return (v55 == math.floor(v55) and string.format("%.0f", v55) or string.format("%.2f", v55))
    .. v13.SUFFIXES[v54 + 1]
end

function v24.Clock(p40)
  p40 = math.max(0, math.floor(p40 or 0))
  local v56 = math.floor(p40 / 60)
  local v57 = p40 % 60
  return string.format("%02d:%02d", v56, v57)
end

function v24.TrackedValue(p41)
  if p41 == nil then
    return "N/A"
  end

  return v24.Number(p41)
end

function v25.MergeDiff(p42, p43, p44)
  if type(p43) == "table" then
    for key4, value4 in pairs(p43) do
      if typeof(value4) ~= "table" or typeof(p42[key4]) ~= "table" then
        p42[key4] = value4
      else
        v25.MergeDiff(p42[key4], value4, {})
      end
    end
  end

  if type(p44) == "table" then
    for key5, value5 in pairs(p44) do
      if typeof(value5) ~= "table" or typeof(p42[key5]) ~= "table" then
        p42[key5] = nil
      else
        v25.MergeDiff(p42[key5], {}, value5)
      end
    end
  end
end

function v25.ShallowCopy(p45)
  if type(p45) ~= "table" then
    return {}
  end

  local v58 = {}

  for key6, value6 in pairs(p45) do
    v58[key6] = value6
  end

  return v58
end

function v25.CountKeys(p46)
  local count = 0

  for key7 in pairs(p46) do
    count = count + 1
  end

  return count
end

function v25.DumpValue(p47, p48, p49, p50)
  p48 = p48 or ""
  p49 = p49 or 0
  p50 = p50 or {}

  if typeof(p47) ~= "table" then
    return tostring(p47)
  end

  if p50[p47] or p49 > 2 then
    return tostring(p47)
  end

  p50[p47] = true
  local v59 = {}
  local count2 = 0

  for key8, value7 in pairs(p47) do
    count2 = count2 + 1

    if count2 > 80 then
      table.insert(
        v59, p48 .. "  ... (" .. tostring(v25.CountKeys(p47) - 80) .. " more entries)"
      )

      break
    end

    table.insert(v59, p48 .. "  " .. tostring(key8) .. " = "
      .. v25.DumpValue(value7, p48 .. "  ", p49 + 1, p50))
  end

  if count2 == 0 then
    return "{}"
  end

  return [[
{
]] .. table.concat(v59, [[
,
]]) .. "\n" .. p48 .. "}"
end

function v23.GetRemote(p51)
  if not v16.NetworkFolder then
    local shared3 = replicatedStorage:FindFirstChild("Shared")
      or replicatedStorage:WaitForChild("Shared", 5)

    local services2 = shared3
      and (shared3:FindFirstChild("Services") or shared3:WaitForChild("Services", 5))

    v16.NetworkFolder = services2
      and (services2:FindFirstChild("Network") or services2:WaitForChild("Network", 5))
  end

  if not v16.NetworkFolder then
    return nil
  end

  return v16.NetworkFolder:FindFirstChild(p51) or v16.NetworkFolder:WaitForChild(p51, 5)
end

function v23.FireServer(p52, ...)
  local v60 = v23.GetRemote(p52)

  if v60 and (v60:IsA("RemoteEvent") or v60:IsA("UnreliableRemoteEvent")) then
    local v61, v62 = pcall(v60.FireServer, v60, ...)

    if not v61 then
      log("FireServer '%s' failed: %s", p52, tostring(v62))
    end

    return v61
  end

  log("FireServer '%s' failed: remote not found", p52)
  return false
end

function v23.InvokeServer(p53, ...)
  local v63 = v23.GetRemote(p53)

  if v63 and v63:IsA("RemoteFunction") then
    local v64, v65 = pcall(v63.InvokeServer, v63, ...)

    if not v64 then
      log("InvokeServer '%s' failed: %s", p53, tostring(v65))
      return nil
    end

    return v65
  end

  log("InvokeServer '%s' failed: remote not found", p53)
  return nil
end

function v23.OnClientEvent(p54, p55)
  local v66 = v23.GetRemote(p54)

  if v66 and (v66:IsA("RemoteEvent") or v66:IsA("UnreliableRemoteEvent")) then
    local v67, v68 = pcall(function() return v66.OnClientEvent:Connect(p55) end)

    if v67 then
      return v68
    end

    log("OnClientEvent '%s' failed: %s", p54, tostring(v68))
    return nil
  end

  log("OnClientEvent '%s' failed: remote not found", p54)
  return nil
end

local function f13()
  local character = localPlayer.Character
  local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
  return humanoidRootPart and humanoidRootPart.CFrame
end

local function f14(cframe)
  if v15.IsHacking then
    return false
  end

  local character2 = localPlayer.Character
  local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart2 then
    if typeof(cframe) == "Vector3" then
      cframe = CFrame.new(cframe)
    end

    humanoidRootPart2.CFrame = cframe
    return true
  end

  return false
end

local function f15()
  if v16.MyPlot and v16.MyPlot.Parent and v16.MyPlot:IsDescendantOf(workspace) then
    return v16.MyPlot, v16.MyPlotIndex
  end

  local plots = workspace:FindFirstChild("Plots")

  if not plots then
    return nil, nil
  end

  local v69, v70 = pcall(plots.GetChildren, plots)

  if v69 and v70 then
    for index2, value8 in ipairs(v70) do
      local occupant = value8:GetAttribute("Occupant")

      if occupant == localPlayer.UserId
        or occupant and tonumber(occupant) == tonumber(localPlayer.UserId) then
        v16.MyPlot = value8
        v16.MyPlotIndex = index2
        return value8, index2
      end
    end
  end

  return nil, nil
end

local function f16()
  local v71, v72 = f15()

  if v71 then
    return v71, v72
  end

  workspace:WaitForChild("Plots", 5)
  return f15()
end

local function f17()
  if v15.GameReady then
    return true
  end

  if localPlayer:GetAttribute("LoadingScreenDismissed") ~= true then
    return false
  end

  if f15() == nil then
    return false
  end

  if not v15.ExecCanScrape then
    v15.GameReady = true
    return true
  end

  local playerData = v16.PlayerData and v25.CountKeys(v16.PlayerData) or 0

  if not v15.PlayerDataComplete and playerData < 40 and not v15.DataPartialNotified then
    return false
  end

  v15.GameReady = true
  return true
end

local function f18(p56)
  if type(p56) == "number" then
    return p56
  end

  if type(p56) ~= "string" or p56 == "" then
    return nil
  end

  local gsub2 = string.upper(p56):gsub("PEARLS?", ""):gsub("HONEY", ""):gsub("BYTES?", ""):gsub(
    "CANDY", ""
  ):gsub(
    "COINS?", ""
  ):gsub(
    "[$%,%s]", ""
  )

  local v73, v74 = string.match(gsub2, "^([%d%.]+)(%a*)$")

  if not v73 then
    return nil
  end

  local v75 = v74 and v74 ~= "" and (v13.MoneySuffixMultipliers[v74] or 1) or 1
  return (tonumber(v73) or 0) * v75
end

local function f19()
  if v15.ExecCanScrape and v15.PlayerDataComplete and v16.PlayerData
    and rawget(v16.PlayerData, "Cash") ~= nil then
    return tonumber(rawget(v16.PlayerData, "Cash")) or 0
  end

  local leaderstats = localPlayer:FindFirstChild("leaderstats")
    or localPlayer:FindFirstChild("Leaderstats")

  local cash = leaderstats and leaderstats:FindFirstChild("Cash")

  if cash then
    return f18(cash.Value) or 0
  end

  if v16.PlayerData and rawget(v16.PlayerData, "Cash") ~= nil then
    return tonumber(rawget(v16.PlayerData, "Cash")) or 0
  end

  return 0
end

local function f20()
  if v15.ExecCanScrape and v15.PlayerDataComplete and v16.PlayerData
    and rawget(v16.PlayerData, "CashPerMin") ~= nil then
    return tonumber(rawget(v16.PlayerData, "CashPerMin")) or 0
  end

  local leaderstats2 = localPlayer:FindFirstChild("leaderstats")
    or localPlayer:FindFirstChild("Leaderstats")

  local cashPerMin = leaderstats2
    and (leaderstats2:FindFirstChild("Cash Per Min") or leaderstats2:FindFirstChild("CashPerMin"))

  if cashPerMin then
    local v76 = f18(cashPerMin.Value)

    if v76 and v76 > 0 then
      return v76
    end
  end

  pcall(function()
    local v77 = f3()

    if not v77 then
      return
    end

    for index3, value9 in ipairs(v77:GetChildren()) do
      if value9.Name == "PlotLabel" and value9:IsA("BillboardGui") then
        local frame = value9:FindFirstChild("Frame")
        local playerName = frame and frame:FindFirstChild("PlayerName")
        local playerEarnings = frame and frame:FindFirstChild("PlayerEarnings")

        if playerName and playerName.Text == "Your Farm" and playerEarnings
          and playerEarnings.Text ~= "" then
          local v78 = f18(playerEarnings.Text)

          if v78 and v78 > 0 then
            return v78
          end
        end
      end
    end
  end)

  if v16.PlayerData and rawget(v16.PlayerData, "CashPerMin") ~= nil then
    return tonumber(rawget(v16.PlayerData, "CashPerMin")) or 0
  end

  return nil
end

local function f21()
  if v15.ExecCanScrape and v15.PlayerDataComplete and v16.PlayerData
    and rawget(v16.PlayerData, "Honey") ~= nil then
    return tonumber(rawget(v16.PlayerData, "Honey")) or 0
  end

  local v79, v80 = pcall(function()
    local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
    local mainUI = playerGui2 and playerGui2:FindFirstChild("MainUI")

    if mainUI then
      local leftBottom = mainUI:FindFirstChild("LeftBottom")
      local honey = leftBottom and leftBottom:FindFirstChild("Honey")
      local text = honey and honey:FindFirstChild("Amount") and honey.Amount.Text

      if text and text ~= "" then
        return f18(text)
      end

      local beeHive = mainUI:FindFirstChild("BeeHive")

      local honey2 = beeHive and beeHive:FindFirstChild("Header")
        and beeHive.Header:FindFirstChild("Honey")

      local text2 = honey2 and honey2:FindFirstChild("Amount") and honey2.Amount.Text

      if text2 and text2 ~= "" then
        return f18(text2)
      end
    end

    return nil
  end)

  if v79 and type(v80) == "number" then
    return v80
  end

  if v16.PlayerData and rawget(v16.PlayerData, "Honey") ~= nil then
    return tonumber(rawget(v16.PlayerData, "Honey")) or 0
  end

  return 0
end

function v30.GetPlayerBytes()
  if v15.ExecCanScrape and v15.PlayerDataComplete and v16.PlayerData
    and rawget(v16.PlayerData, "Bytes") ~= nil then
    return tonumber(rawget(v16.PlayerData, "Bytes")) or 0
  end

  local v81 = f3()

  local leftBottom2 = v81 and v81:FindFirstChild("MainUI")
    and v81.MainUI:FindFirstChild("LeftBottom")

  local bytes = leftBottom2 and leftBottom2:FindFirstChild("Bytes")
  local amount = bytes and bytes:FindFirstChild("Amount")

  if amount and amount:IsA("TextLabel") and amount.Text ~= "" then
    return f18(amount.Text) or 0
  end

  if v16.PlayerData and rawget(v16.PlayerData, "Bytes") ~= nil then
    return tonumber(rawget(v16.PlayerData, "Bytes")) or 0
  end

  return 0
end

function v30.GetPlayerAdminCoins()
  if v15.ExecCanScrape and v15.PlayerDataComplete and v16.PlayerData
    and rawget(v16.PlayerData, "AdminCoins") ~= nil then
    return tonumber(rawget(v16.PlayerData, "AdminCoins")) or 0
  end

  local v82 = f3()

  local leftBottom3 = v82 and v82:FindFirstChild("MainUI")
    and v82.MainUI:FindFirstChild("LeftBottom")

  local adminCoins = leftBottom3 and leftBottom3:FindFirstChild("AdminCoins")
  local amount2 = adminCoins and adminCoins:FindFirstChild("Amount")

  if amount2 and amount2:IsA("TextLabel") and amount2.Text ~= "" then
    return f18(amount2.Text) or 0
  end

  if v16.PlayerData and rawget(v16.PlayerData, "AdminCoins") ~= nil then
    return tonumber(rawget(v16.PlayerData, "AdminCoins")) or 0
  end

  return 0
end

function v30.GetPlayerPearls()
  local v83 = f6()

  if v83 and v83.Pearls ~= nil then
    local v84 = tonumber(v83.Pearls)

    if v84 and v84 > 0 then
      return v84
    end
  end

  if v16.PlayerData and rawget(v16.PlayerData, "Pearls") ~= nil then
    local v85 = tonumber(rawget(v16.PlayerData, "Pearls"))

    if v85 and v85 > 0 then
      return v85
    end
  end

  local v86 = f3()

  local leftBottom4 = v86 and v86:FindFirstChild("MainUI")
    and v86.MainUI:FindFirstChild("LeftBottom")

  local pearls = leftBottom4 and leftBottom4:FindFirstChild("Pearls")
  local amount3 = pearls and pearls:FindFirstChild("Amount")

  if amount3 and amount3:IsA("TextLabel") and amount3.Text ~= "" then
    local v87 = f18(amount3.Text)

    if v87 and v87 > 0 then
      return v87
    end
  end

  local aquarium = v86 and v86:FindFirstChild("MainUI")
    and v86.MainUI:FindFirstChild("Aquarium")

  local amount4 = aquarium and aquarium:FindFirstChild("Header")
    and aquarium.Header:FindFirstChild("Pearls")
    and aquarium.Header.Pearls:FindFirstChild("Amount")

  if amount4 and amount4:IsA("TextLabel") and amount4.Text ~= "" then
    local v88 = f18(amount4.Text)

    if v88 and v88 > 0 then
      return v88
    end
  end

  return 0
end

function v31.GetRodTool()
  local v89 = nil
  local v90 = -1
  local v91 = false
  local character3 = localPlayer.Character

  if character3 then
    for index4, value10 in ipairs(character3:GetChildren()) do
      if value10:IsA("Tool") then
        local rodLevel = value10:GetAttribute("RodLevel")

        if rodLevel ~= nil or value10.Name:find("Rod") then
          local v92 = tonumber(rodLevel) or 1

          if v92 > v90 then
            v90 = v92
            v89 = value10
            v91 = true
          end
        end
      end
    end
  end

  local backpack = localPlayer:FindFirstChild("Backpack")

  if backpack then
    for index5, value11 in ipairs(backpack:GetChildren()) do
      if value11:IsA("Tool") then
        local rodLevel2 = value11:GetAttribute("RodLevel")

        if rodLevel2 ~= nil or value11.Name:find("Rod") then
          local v93 = tonumber(rodLevel2) or 1

          if v93 > v90 then
            v90 = v93
            v89 = value11
            v91 = false
          end
        end
      end
    end
  end

  return v89, v91
end

function v31.GetRodLevel()
  local v94 = f6()

  if v94 and v94.FishingRodLevel ~= nil then
    return tonumber(v94.FishingRodLevel) or 1
  end

  if v16.PlayerData and rawget(v16.PlayerData, "FishingRodLevel") ~= nil then
    return tonumber(rawget(v16.PlayerData, "FishingRodLevel")) or 1
  end

  local v95 = v31.GetRodTool()

  if v95 and v95:GetAttribute("RodLevel") then
    return tonumber(v95:GetAttribute("RodLevel")) or 1
  end

  local v96 = f3()
  local fishingUpgrades = v96 and v96:FindFirstChild("FishingUpgrades")

  if fishingUpgrades then
    local fishingRod = fishingUpgrades:FindFirstChild("BG")
      and fishingUpgrades.BG:FindFirstChild("FishingRod")

    local title2 = fishingRod and fishingRod:FindFirstChild("Title")

    if title2 and title2:IsA("TextLabel") then
      local v97 = string.match(title2.Text, "%((%d+)/")

      if v97 and tonumber(v97) then
        return math.max(1, tonumber(v97) - 1)
      end
    end
  end

  return 1
end

function v31.GetFishingLuckLevel()
  local v98 = f6()

  if v98 and v98.FishingLuckLevel ~= nil then
    return tonumber(v98.FishingLuckLevel) or 0
  end

  if v16.PlayerData and rawget(v16.PlayerData, "FishingLuckLevel") ~= nil then
    return tonumber(rawget(v16.PlayerData, "FishingLuckLevel")) or 0
  end

  local v99 = f3()
  local fishingUpgrades2 = v99 and v99:FindFirstChild("FishingUpgrades")

  if fishingUpgrades2 then
    local fishingLuck = fishingUpgrades2:FindFirstChild("BG")
      and fishingUpgrades2.BG:FindFirstChild("FishingLuck")

    local desc = fishingLuck and fishingLuck:FindFirstChild("Desc")

    if desc and desc:IsA("TextLabel") then
      local v100 = string.match(desc.Text, "(%d+)x")

      if v100 and tonumber(v100) then
        return math.max(0, tonumber(v100) - 1)
      end
    end
  end

  return 0
end

function v31.GetRodUpgradePrice(p57)
  local v101 = f3()
  local fishingUpgrades3 = v101 and v101:FindFirstChild("FishingUpgrades")

  local fishingRod2 = fishingUpgrades3 and fishingUpgrades3:FindFirstChild("BG")
    and fishingUpgrades3.BG:FindFirstChild("FishingRod")

  local btn = fishingRod2 and fishingRod2:FindFirstChild("Btn")
  local txt = btn and (btn:FindFirstChild("Txt") or btn:FindFirstChildWhichIsA("TextLabel"))

  if txt and txt.Text ~= "" then
    if string.find(string.upper(txt.Text), "MAX") then
      return math.huge
    end

    local v102 = f18(txt.Text)

    if v102 and v102 > 0 then
      return v102
    end
  end

  if v15.ExecCanScrape then
    local v103 = f1(replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Services")
      and replicatedStorage.Shared.Services:FindFirstChild("FishUtil"))

    if v103 and v103.GetRodUpgradePrice then
      local v104, v105 = pcall(v103.GetRodUpgradePrice, p57)

      if v104 and type(v105) == "number" then
        return v105
      end
    end
  end

  local v106 = p57 + 1

  if v14.FishingRods then
    for key9, value12 in pairs(v14.FishingRods) do
      if type(value12) == "table" and value12.Level == v106 and value12.Price then
        return value12.Price
      end
    end
  end

  local v107 = {
    [1] = 800,
    [2] = 2500,
    [3] = 6000,
    [4] = 14000,
    [5] = 30000,
    [6] = 60000,
    [7] = 110000,
    [8] = 200000,
    [9] = 350000,
    [10] = 600000,
    [11] = 1000000,
    [12] = 1700000,
    [13] = 2800000,
    [14] = 4500000,
  }

  return v107[p57] or 999999999
end

function v31.GetLuckUpgradePrice(p58)
  local v108 = f3()
  local fishingUpgrades4 = v108 and v108:FindFirstChild("FishingUpgrades")

  local fishingLuck2 = fishingUpgrades4 and fishingUpgrades4:FindFirstChild("BG")
    and fishingUpgrades4.BG:FindFirstChild("FishingLuck")

  local btn2 = fishingLuck2 and fishingLuck2:FindFirstChild("Btn")
  local txt2 = btn2 and (btn2:FindFirstChild("Txt") or btn2:FindFirstChildWhichIsA("TextLabel"))

  if txt2 and txt2.Text ~= "" then
    if string.find(string.upper(txt2.Text), "MAX") then
      return math.huge
    end

    local v109 = f18(txt2.Text)

    if v109 and v109 > 0 then
      return v109
    end
  end

  if v15.ExecCanScrape then
    local v110 = f1(replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Services")
      and replicatedStorage.Shared.Services:FindFirstChild("FishUtil"))

    if v110 and v110.GetLuckUpgradePrice then
      local v111, v112 = pcall(v110.GetLuckUpgradePrice, p58)

      if v111 and type(v112) == "number" then
        return v112
      end
    end
  end

  local v113 = {
    [0] = 1500,
    [1] = 2900,
    [2] = 5400,
    [3] = 10000,
    [4] = 20000,
    [5] = 37000,
    [6] = 71000,
    [7] = 130000,
    [8] = 250000,
    [9] = 480000,
  }

  return v113[p58] or 999999999
end

function v31.GetCastFillTime(p59)
  local castFillTime = localPlayer:GetAttribute("CastFillTime")

  if castFillTime and tonumber(castFillTime) then
    return tonumber(castFillTime)
  end

  return 0.75 / (1 + ((p59 or v31.GetRodLevel()) - 1) * 0.1)
end

function v31.GetFishStorageCounts()
  local count3 = 0
  local v114 = 0
  local playerData2 = f6 and f6() or v16.PlayerData

  if playerData2 and type(playerData2.Fish) == "table" then
    for key10 in pairs(playerData2.Fish) do
      count3 = count3 + 1
    end
  end

  local v115 = 0

  if playerData2 and playerData2.PlotSave and playerData2.PlotSave.Buildings
    and playerData2.PlotSave.Buildings.Aquarium then
    v115 = tonumber(playerData2.PlotSave.Buildings.Aquarium) or 0
  else
    local readPlotBuildingSigns = v26.ReadPlotBuildingSigns and v26.ReadPlotBuildingSigns()

    if readPlotBuildingSigns and readPlotBuildingSigns.Aquarium then
      v115 = tonumber(readPlotBuildingSigns.Aquarium.CurrentLevel
          or readPlotBuildingSigns.Aquarium.Level)
        or 0
    else
      local v116 = f15 and f15() or f16 and f16()
      local buildings = v116 and v116:FindFirstChild("Buildings")
      local aquarium2 = buildings and buildings:FindFirstChild("Aquarium")

      if aquarium2 then
        v115 = tonumber(aquarium2:GetAttribute("Level")) or 1
      end
    end
  end

  local v117 = {
    [0] = 0,
    [1] = 60,
    [2] = 90,
    [3] = 120,
  }

  v114 = v117[v115] or v115 > 0 and 60 or 0
  local v118 = f3()
  local mainUI2 = v118 and v118:FindFirstChild("MainUI")
  local findFirstChild2 = mainUI2 and mainUI2:FindFirstChild("Aquarium", true)
  local findFirstChild3 = findFirstChild2 and findFirstChild2:FindFirstChild("SellAll", true)

  if findFirstChild3 then
    local txt3 = findFirstChild3:FindFirstChild("Txt")
      or findFirstChild3:FindFirstChildOfClass("TextLabel")

    local text3 = txt3 and txt3.Text
      or findFirstChild3:IsA("TextButton") and findFirstChild3.Text or ""

    local v119, v120 = string.match(text3, "(%d+)%s*/%s*(%d+)")

    if v119 and v120 then
      return tonumber(v119) or count3, tonumber(v120) or v114
    end
  end

  return count3, v114
end

function v31.GetCastTarget(p60, p61)
  p61 = p61 or 0.95

  if v15.ExecCanScrape then
    local v121 = f1(replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Services")
      and replicatedStorage.Shared.Services:FindFirstChild("FishUtil"))

    if v121 and type(v121.GetCastTarget) == "function" then
      local v122, v123 = pcall(v121.GetCastTarget, p60, p61)

      if v122 and typeof(v123) == "Vector3" then
        return v123
      end
    end
  end

  local lookVector = p60.LookVector
  return p60.Position + Vector3.new(lookVector.X, 0, lookVector.Z).Unit * (4 + 11 * p61)
end

function v31.GetFishRarity(p62)
  if not p62 then
    return nil
  end

  if v14.Fish and v14.Fish[p62] and v14.Fish[p62].Rarity then
    return v14.Fish[p62].Rarity
  end

  return v13.KNOWN_FISH_RARITIES and v13.KNOWN_FISH_RARITIES[p62] or nil
end

function v26.Copy(p63)
  if type(p63) ~= "table" then
    return p63
  end

  local v124 = {}

  for key11, value13 in pairs(p63) do
    v124[key11] = v26.Copy(value13)
  end

  return v124
end

function v26.CollectGuiTexts(p64, p65)
  local v125 = {}

  for index6, value14 in ipairs(p64:GetDescendants()) do
    if (value14:IsA("TextLabel") or value14:IsA("TextButton")) and value14.Text ~= "" then
      table.insert(v125, value14.Text)

      if p65 and #v125 >= p65 then
        break
      end
    end
  end

  return v125
end

function v26.AdorneeIsMyPlot(p66)
  local adornee = p66.Adornee

  if not adornee then
    return false
  end

  local parent = adornee

  while parent and parent ~= workspace do
    if parent:GetAttribute("Occupant") == localPlayer.UserId then
      return true
    end

    parent = parent.Parent
  end

  return false
end

function v26.GetMainUIScreen(p67)
  local v126 = f3()
  local mainUI3 = v126 and v126:FindFirstChild("MainUI")
  return mainUI3 and mainUI3:FindFirstChild(p67, true) or nil
end

function v26.ReadPlotUpgradeSign()
  local v127 = {}
  local v128 = f15() or f16()
  local v129 = f3()

  if not v129 then
    return nil
  end

  for index7, value15 in ipairs(v129:GetChildren()) do
    if value15:IsA("SurfaceGui")
      and (value15.Name == "PlotUpgrades" or value15.Name == "FloorUpgrades") then
      if not v128 or value15.Adornee and value15.Adornee:IsDescendantOf(v128)
        or v26.AdorneeIsMyPlot(value15) then
        local bg = value15:FindFirstChild("BG") or value15
        local v130 = {}

        if value15.Name == "PlotUpgrades" then
          for index8, value16 in ipairs(bg:GetChildren()) do
            table.insert(v130, value16)
          end
        elseif value15.Name == "FloorUpgrades" then
          local expansion = bg:FindFirstChild("Expansion")

          if expansion then
            table.insert(v130, expansion)
          end
        end

        for index9, value17 in ipairs(v130) do
          local name = value17.Name

          if name == "RollLuck" or name == "RollPodiums" or name == "Expansion" then
            local findFirstChild4 = value17:FindFirstChild("Btn", true) or value17

            local findFirstChild5 = findFirstChild4
              and (findFirstChild4:FindFirstChild("Txt", true)
                or findFirstChild4:FindFirstChild("Price", true))

            local findFirstChild6 = value17:FindFirstChild("Desc", true)
            local text4 = findFirstChild5 and findFirstChild5.Text
            local text5 = findFirstChild6 and findFirstChild6.Text
            local max = text4 == "MAX" or text5 == "MAX"
            local price = text4 and f18(text4)
            local value18, nextValue = nil, nil

            if text5 and text5 ~= "MAX" then
              local v131, v132 = text5:match("(%d+)[^%d]+(%d+)")
              value18 = tonumber(v131) or tonumber(text5:match("(%d+)"))
              nextValue = tonumber(v132)
            end

            v127[name] = {
              Value = value18,
              NextValue = nextValue,
              Price = price,
              Max = max,
            }
          end
        end
      end
    end
  end

  return next(v127) and v127 or nil
end

function v26.ReadPlotBuildingSigns()
  local v133 = {}
  local v134 = f3()

  if not v134 then
    return v133
  end

  local v135 = {}

  if v14.PlotBuildings then
    for key12, value19 in pairs(v14.PlotBuildings) do
      v135[value19.DisplayName or key12] = key12
      v135[key12] = key12
    end
  end

  for index10, value20 in ipairs(v134:GetChildren()) do
    if value20:IsA("SurfaceGui") and value20.Name == "BuildingSignGui" then
      local main = value20:FindFirstChild("Main")
      local buildingName = main and main:FindFirstChild("BuildingName")
      local text6 = buildingName and buildingName:IsA("TextLabel") and buildingName.Text

      if text6 and text6 ~= "" then
        local gsub3 = v135[text6] or text6:gsub("%s+", "")
        local buildingLevel = main:FindFirstChild("BuildingLevel")

        local text7 = buildingLevel and buildingLevel:IsA("TextLabel") and buildingLevel.Text
          or ""

        local v136, nextLevel = 0, 1
        local v137 = text7 == "MAX"

        if not v137 and text7 ~= "" then
          local v138, v139 = text7:match("Level%s*(%d+)%s*→%s*Level%s*(%d+)")

          if v138 and v139 then
            v136 = tonumber(v138) or 0
            nextLevel = tonumber(v139) or 1
          else
            v136 = tonumber(text7:match("%d+")) or 0
            nextLevel = v136 + 1
          end
        end

        local buyButton = main:FindFirstChild("BuyButton")
        local price2 = buyButton and buyButton:FindFirstChild("Price")
        local text8 = price2 and price2:IsA("TextLabel") and price2.Text or ""

        if text8 == "MAX" then
          v137 = true
        end

        local price3 = f18(text8) or 0
        local v140 = true
        local yellowGradient = buyButton and buyButton:FindFirstChild("YellowGradient")
        local grayGradient = buyButton and buyButton:FindFirstChild("GrayGradient")

        if yellowGradient and yellowGradient:IsA("UIGradient") then
          v140 = yellowGradient.Enabled == true
        elseif grayGradient and grayGradient:IsA("UIGradient") then
          v140 = grayGradient.Enabled == false
        end

        v133[gsub3] = {
          CurrentLevel = v136,
          NextLevel = nextLevel,
          Price = price3,
          Max = v137,
          CanBuy = v140 and not v137,
        }
      end
    end
  end

  return v133
end

function v26.ReadFloorUpgradeSigns()
  local v141 = {}
  local v142 = f15() or f16()

  if not v142 then
    return v141
  end

  local floorUpgradeSign = v142:FindFirstChild("FloorUpgradeSign")

  if floorUpgradeSign then
    v141[1] = {
      SawYield = { Value = floorUpgradeSign:GetAttribute("SawYield") or 1 },
      SprinklerPower = { Value = floorUpgradeSign:GetAttribute("SprinklerPower") or 1 },
      SawRange = { Value = floorUpgradeSign:GetAttribute("SawRange") or 1 },
      SprinklerRange = { Value = floorUpgradeSign:GetAttribute("SprinklerRange") or 1 },
    }
  end

  local farmFloors = v142:FindFirstChild("FarmFloors")

  if farmFloors then
    for index11, value21 in ipairs(farmFloors:GetChildren()) do
      local v143 = tonumber(value21:GetAttribute("FloorIndex"))
        or tonumber(string.match(value21.Name, "%d+$"))

      local floorUpgradeSign2 = value21:FindFirstChild("FloorUpgradeSign")

      if v143 and floorUpgradeSign2 then
        v141[v143] = {
          SawYield = { Value = floorUpgradeSign2:GetAttribute("SawYield") or 1 },
          SprinklerPower = { Value = floorUpgradeSign2:GetAttribute("SprinklerPower") or 1 },
          SawRange = { Value = floorUpgradeSign2:GetAttribute("SawRange") or 1 },
          SprinklerRange = { Value = floorUpgradeSign2:GetAttribute("SprinklerRange") or 1 },
        }
      end
    end
  end

  local v144 = f3()

  if v144 then
    for index12, value22 in ipairs(v144:GetChildren()) do
      if value22:IsA("SurfaceGui") and value22.Name == "FloorUpgrades" and value22.Adornee
        and (value22.Adornee:IsDescendantOf(v142) or v26.AdorneeIsMyPlot(value22)) then
        local adornee2 = value22.Adornee
        local floorIndex = 1

        while adornee2 and adornee2 ~= v142 and adornee2 ~= workspace do
          if adornee2:GetAttribute("FloorIndex") then
            floorIndex = adornee2:GetAttribute("FloorIndex")
            break
          end

          adornee2 = adornee2.Parent
        end

        v141[floorIndex] = v141[floorIndex] or {}
        local findFirstChild7 = value22:FindFirstChild("Holder", true)

        if findFirstChild7 then
          for index13, value23 in ipairs(findFirstChild7:GetChildren()) do
            local name2 = value23.Name

            if name2 == "SawYield" or name2 == "SprinklerPower" or name2 == "SawRange"
              or name2 == "SprinklerRange" then
              local findFirstChild8 = value23:FindFirstChild("Btn", true) or value23

              local findFirstChild9 = findFirstChild8
                and (findFirstChild8:FindFirstChild("Price", true)
                  or findFirstChild8:FindFirstChild("Txt", true))

              local findFirstChild10 = value23:FindFirstChild("Desc", true)
              local text9 = findFirstChild9 and findFirstChild9.Text
              local text10 = findFirstChild10 and findFirstChild10.Text
              local max2 = text9 == "MAX" or text10 == "MAX"
              local price4 = text9 and f18(text9)
              local v145, v146 = nil, nil

              if text10 and text10 ~= "MAX" then
                local v147, v148 = text10:match("(%d+)[^%d]+(%d+)")
                v145 = tonumber(v147) or tonumber(text10:match("(%d+)"))
                v146 = tonumber(v148)
              end

              local v149 = v141[floorIndex][name2] or {}
              v149.Price = price4
              v149.Max = max2

              if v145 then
                v149.Value = v145
              end

              if v146 then
                v149.NextValue = v146
              end

              v141[floorIndex][name2] = v149
            end
          end
        end
      end
    end
  end

  return v141
end

v26.Getters = {}

function v26.Getters.Cash()
  return f19()
end

function v26.Getters.Honey()
  return f21()
end

function v26.Getters.Bytes()
  return v30.GetPlayerBytes and v30.GetPlayerBytes() or 0
end

function v26.Getters.AdminCoins()
  return v30.GetPlayerAdminCoins and v30.GetPlayerAdminCoins() or 0
end

function v26.Getters.DataMiner()
  local dataMiners = workspace:FindFirstChild("Data Miners")

  local findFirstChild11 = dataMiners
    and dataMiners:FindFirstChild("Data Miner " .. tostring(localPlayer.UserId))

  if not findFirstChild11 then
    return nil
  end

  return {
    Stored = tonumber(findFirstChild11:GetAttribute("Stored")) or 0,
    Capacity = tonumber(findFirstChild11:GetAttribute("Capacity")) or 60,
    Rate = tonumber(findFirstChild11:GetAttribute("Rate")) or 0,
    Active = findFirstChild11:GetAttribute("Active") == true,
    Plants = tonumber(findFirstChild11:GetAttribute("Plants")) or 0,
    Model = findFirstChild11,
  }
end

function v26.Getters.HackerShop()
  local hackerShopStock = workspace:GetAttribute("HackerShopStock")
  local jsonDecode = {}

  if type(hackerShopStock) == "string" and #hackerShopStock > 0 then
    pcall(function() jsonDecode = httpService:JSONDecode(hackerShopStock) end)
  end

  return {
    Stock = jsonDecode,
    Restock = workspace:GetAttribute("HackerShopRestock"),
    Deal = workspace:GetAttribute("HackerShopDeal"),
  }
end

function v26.Getters.Seeds()
  local v150 = {}
  local playerGui3 = localPlayer:FindFirstChild("PlayerGui")
  local findFirstChild12 = playerGui3 and playerGui3:FindFirstChild("DiscardSeedsFrame", true)

  local findFirstChild13 = findFirstChild12
    and findFirstChild12:FindFirstChild("Scroller", true)

  if findFirstChild13 then
    for index14, value24 in ipairs(findFirstChild13:GetChildren()) do
      local seedName = value24:GetAttribute("SeedName")

      if seedName then
        local v151 = 1
        local findFirstChild14 = value24:FindFirstChild("ItemName", true)

        if findFirstChild14 and findFirstChild14:IsA("TextLabel") then
          local xD = findFirstChild14.Text:match("x(%d+)$")

          if xD then
            v151 = tonumber(xD) or 1
          end
        end

        v150[seedName] = v151
      end
    end
  end

  if not next(v150) then
    local function f22(p68)
      if not p68 then
        return
      end

      for index15, value25 in ipairs(p68:GetChildren()) do
        if value25:IsA("Tool") then
          local seedName2 = value25:GetAttribute("SeedName")
            or value25:GetAttribute("SeedStack")

          if seedName2 then
            v150[seedName2] = (v150[seedName2] or 0)
              + (tonumber(value25:GetAttribute("Amount")) or 1)
          end
        end
      end
    end

    f22(localPlayer.Character)
    f22(localPlayer:FindFirstChild("Backpack"))
  end

  return next(v150) and v150 or nil
end

function v26.Getters.Gears()
  local v152 = {}

  local function f23(p69)
    if not p69 then
      return
    end

    for index16, value26 in ipairs(p69:GetChildren()) do
      if value26:IsA("Tool") and value26:GetAttribute("GearIndex") then
        v152[value26:GetAttribute("GearIndex")] = {
          Name = value26:GetAttribute("GearKey") or value26:GetAttribute("GearName")
            or value26.Name,
          Amount = tonumber(value26:GetAttribute("Amount")) or 1,
          Count = tonumber(value26:GetAttribute("Amount")) or 1,
        }
      end
    end
  end

  f23(localPlayer.Character)
  f23(localPlayer:FindFirstChild("Backpack"))

  return next(v152) and v152 or nil
end

function v26.Getters.Pets()
  local v153 = {}

  local function f24(p70)
    if not p70 then
      return
    end

    for index17, value27 in ipairs(p70:GetChildren()) do
      if value27:IsA("Tool") and value27:GetAttribute("PetIndex") then
        local petIndex = value27:GetAttribute("PetIndex")

        local toolTip = value27.ToolTip
          and tonumber(value27.ToolTip:match("Earnings Multiplier:%s*([%d%.]+)x"))

        v153[petIndex] = { Name = value27.Name, ParsedMultiplier = toolTip }
      end
    end
  end

  f24(localPlayer.Character)
  f24(localPlayer:FindFirstChild("Backpack"))

  local v154 = f15()
  local pets = v154 and v154:GetAttribute("Pets")

  if type(pets) == "string" and pets ~= "" then
    local v155, v156 = pcall(httpService.JSONDecode, httpService, pets)

    if v155 and type(v156) == "table" then
      for key13, value28 in pairs(v156) do
        if type(value28) == "table" and value28.Name then
          v153[key13] = {
            Name = value28.Name,
            Level = value28.Level,
            Grade = value28.Grade,
            Size = value28.Size,
          }
        end
      end
    end
  end

  return next(v153) and v153 or nil
end

function v26.Getters.EquippedPets()
  local v157 = f15()
  local pets2 = v157 and v157:GetAttribute("Pets")

  if type(pets2) ~= "string" or pets2 == "" then
    return nil
  end

  local v158, v159 = pcall(httpService.JSONDecode, httpService, pets2)

  if not v158 or type(v159) ~= "table" then
    return nil
  end

  local v160 = {}

  for key14 in pairs(v159) do
    v160[key14] = true
  end

  return next(v160) and v160 or nil
end

function v26.Getters.Bees()
  local v161 = {}
  local playerGui4 = localPlayer:FindFirstChild("PlayerGui")

  local scroller = playerGui4 and playerGui4:FindFirstChild("MainUI")
    and playerGui4.MainUI:FindFirstChild("BeeHive")
    and playerGui4.MainUI.BeeHive:FindFirstChild("Content")
    and playerGui4.MainUI.BeeHive.Content:FindFirstChild("ActiveBeesPage")
    and playerGui4.MainUI.BeeHive.Content.ActiveBeesPage:FindFirstChild("SlotsHolder")
    and playerGui4.MainUI.BeeHive.Content.ActiveBeesPage.SlotsHolder:FindFirstChild("Slots")
    and playerGui4.MainUI.BeeHive.Content.ActiveBeesPage.SlotsHolder.Slots:FindFirstChild("Scroller")

  if scroller then
    local v162 = 1

    for index18, value29 in ipairs(scroller:GetChildren()) do
      if value29.Name == "ActiveItem" and value29:IsA("ImageButton") then
        local itemName = value29:FindFirstChild("ItemName")
        local text11 = itemName and itemName.Text or "Worker Bee"
        local v163 = 0
        local starsHolder = value29:FindFirstChild("StarsHolder")

        if starsHolder then
          for i = 1, 5 do
            local findFirstChild15 = starsHolder:FindFirstChild("Star" .. i)

            if findFirstChild15 and findFirstChild15.Visible then
              v163 = i
            end
          end
        end

        v161["equipped_bee_" .. v162] = {
          Name = text11,
          Level = v163 > 0 and v163 or 1,
          IsEquipped = true,
        }

        v162 = v162 + 1
      end
    end
  end

  local function f25(p71)
    if not p71 then
      return
    end

    for index19, value30 in ipairs(p71:GetChildren()) do
      if value30:IsA("Tool") and value30:GetAttribute("BeeIndex") then
        local beeIndex = value30:GetAttribute("BeeIndex")

        v161[beeIndex] = {
          Name = value30.Name,
          Level = value30:GetAttribute("Level") or 1,
          IsEquipped = false,
        }
      end
    end
  end

  f25(localPlayer.Character)
  f25(localPlayer:FindFirstChild("Backpack"))

  return next(v161) and v161 or nil
end

function v26.Getters.EquippedBees()
  local playerGui5 = localPlayer:FindFirstChild("PlayerGui")

  local scroller2 = playerGui5 and playerGui5:FindFirstChild("MainUI")
    and playerGui5.MainUI:FindFirstChild("BeeHive")
    and playerGui5.MainUI.BeeHive:FindFirstChild("Content")
    and playerGui5.MainUI.BeeHive.Content:FindFirstChild("ActiveBeesPage")
    and playerGui5.MainUI.BeeHive.Content.ActiveBeesPage:FindFirstChild("SlotsHolder")
    and playerGui5.MainUI.BeeHive.Content.ActiveBeesPage.SlotsHolder:FindFirstChild("Slots")
    and playerGui5.MainUI.BeeHive.Content.ActiveBeesPage.SlotsHolder.Slots:FindFirstChild("Scroller")

  if not scroller2 then
    return nil
  end

  local v164 = {}
  local v165 = 1

  for index20, value31 in ipairs(scroller2:GetChildren()) do
    if value31.Name == "ActiveItem" and value31:IsA("ImageButton") then
      v164["equipped_bee_" .. v165] = true
      v165 = v165 + 1
    end
  end

  return next(v164) and v164 or nil
end

function v26.Getters.PetMerchantSlots()
  local middle = workspace:FindFirstChild("Middle")
  local petMerchant = middle and middle:FindFirstChild("Pet Merchant")
  local slots = petMerchant and petMerchant:FindFirstChild("Slots")

  if not slots then
    return nil
  end

  local v166 = 0
  local v167 = 0

  for index21, value32 in ipairs(slots:GetChildren()) do
    local v168 = tonumber(value32.Name)

    if v168 then
      v167 = math.max(v167, v168)
      local eggSlot = value32:FindFirstChild("EggSlot")

      if eggSlot and eggSlot.Enabled then
        local nameLabel = eggSlot:FindFirstChild("Frame")
            and eggSlot.Frame:FindFirstChild("NameLabel")
          or eggSlot:FindFirstChild("NameLabel", true)

        local text12 = nameLabel and nameLabel.Text

        if text12 == "Egg Slot" then
          v166 = math.max(v166, v168 - 1)
        elseif text12 and text12 ~= "" then
          v166 = math.max(v166, v168)
        end
      end
    end
  end

  return v166 > 0 and v166 or v167 > 0 and 1 or nil
end

function v26.Getters.PetMerchantStock()
  local middle2 = workspace:FindFirstChild("Middle")
  local petMerchant2 = middle2 and middle2:FindFirstChild("Pet Merchant")
  local slots2 = petMerchant2 and petMerchant2:FindFirstChild("Slots")

  if not slots2 then
    return nil
  end

  local v169 = {}

  for index22, value33 in ipairs(slots2:GetChildren()) do
    local v170 = tonumber(value33.Name)
    local eggSlot2 = value33:FindFirstChild("EggSlot")

    if v170 and eggSlot2 and eggSlot2.Enabled then
      local nameLabel2 = eggSlot2:FindFirstChild("Frame")
          and eggSlot2.Frame:FindFirstChild("NameLabel")
        or eggSlot2:FindFirstChild("NameLabel", true)

      local text13 = nameLabel2 and nameLabel2.Text

      if text13 and text13 ~= "" and text13 ~= "Egg Slot" then
        v169[v170] = text13
      end
    end
  end

  return v169
end

function v26.Getters.GearShopBought()
  local v171 = f3()
  local mainUI4 = v171 and v171:FindFirstChild("MainUI")
  local gearShop = mainUI4 and mainUI4:FindFirstChild("GearShop")

  if not gearShop then
    return nil
  end

  local gearShopItems = v14.GearShopItems or {}

  if #gearShopItems == 0 then
    return nil
  end

  local gearShopStock = workspace:GetAttribute("GearShopStock")
  local jsonDecode2 = nil

  if gearShopStock then
    pcall(function() jsonDecode2 = httpService:JSONDecode(gearShopStock) end)
  end

  local v172 = {}
  local findFirstChild16 = gearShop:FindFirstChild("Scroller", true)

  if findFirstChild16 then
    for index23, value34 in ipairs(findFirstChild16:GetChildren()) do
      local description = value34:FindFirstChild("Description")
      local gearName = description and description:FindFirstChild("GearName")
      local price5 = description and description:FindFirstChild("Price")

      if gearName and price5 then
        local text14 = gearName.Text
        local v173 = tonumber(price5.Text:match("x(%d+)%s*Stock"))

        if v173 ~= nil then
          for index24, value35 in ipairs(gearShopItems) do
            if value35.Name == text14 then
              local v174 = jsonDecode2
                  and tonumber(jsonDecode2[tostring(value35.Index)] or jsonDecode2[value35.Index])
                or v173

              local v175 = math.max(0, v174 - v173)
              v172[value35.Index] = v175
              break
            end
          end
        end
      end
    end
  end

  if next(v172) == nil then
    local v176 = v26.CollectGuiTexts(gearShop, 160)
    local v177 = nil

    for index25, value36 in ipairs(v176) do
      for index26, value37 in ipairs(gearShopItems) do
        if value36 == value37.Name then
          v177 = value37
          break
        end
      end

      local xDSStock = value36:match("^x(%d+)%s*Stock$")

      if xDSStock and v177 then
        local v178 = jsonDecode2
            and tonumber(jsonDecode2[tostring(v177.Index)] or jsonDecode2[v177.Index])
          or tonumber(xDSStock)

        local v179 = math.max(0, v178 - tonumber(xDSStock))
        v172[v177.Index] = v179
        v177 = nil
      end
    end
  end

  return next(v172) and v172 or nil
end

function v26.Getters.BeeShopStock()
  local v180 = f3()
  local mainUI5 = v180 and v180:FindFirstChild("MainUI")
  local beeHive2 = mainUI5 and mainUI5:FindFirstChild("BeeHive")

  local items = beeHive2 and beeHive2:FindFirstChild("Content")
    and beeHive2.Content:FindFirstChild("ShopPage")
    and beeHive2.Content.ShopPage:FindFirstChild("Scroller")
    and beeHive2.Content.ShopPage.Scroller:FindFirstChild("Items")

  if not items then
    return nil
  end

  local v181 = {}

  for index27, value38 in ipairs(items:GetChildren()) do
    local itemName2 = value38:FindFirstChild("ItemName")
    local amount5 = value38:FindFirstChild("Amount")

    if itemName2 and amount5 then
      local v182 = tonumber(amount5.Text:match("x(%d+)"))

      if v182 ~= nil then
        v181[itemName2.Text] = v182
      end
    end
  end

  return next(v181) and v181 or nil
end

function v26.Getters.SuperRollerRolls()
  local middle3 = workspace:FindFirstChild("Middle")
  local superRoller = middle3 and middle3:FindFirstChild("Super Roller")
  local lever = superRoller and superRoller:FindFirstChild("Lever")
  local leverPrompt = lever and lever:FindFirstChild("LeverPrompt")
  local proximityPrompt = leverPrompt and leverPrompt:FindFirstChildOfClass("ProximityPrompt")

  if proximityPrompt and proximityPrompt.ObjectText then
    local dSRollsLeft = proximityPrompt.ObjectText:match("(%d+)%s*Rolls Left")

    if dSRollsLeft then
      return tonumber(dSRollsLeft)
    end
  end

  return nil
end

function v26.Getters.PlotSave()
  local v183 = f15()

  if not v183 then
    return nil
  end

  local v184 = {}
  local v185 = v26.ReadPlotBuildingSigns() or {}
  local v186 = {}

  for key15, value39 in pairs(v185) do
    v186[key15] = value39.CurrentLevel or 0
  end

  local buildings2 = v183:FindFirstChild("Buildings")

  if buildings2 then
    for index28, value40 in ipairs(buildings2:GetChildren()) do
      local v187 = tonumber(value40:GetAttribute("Level")) or 1
      v186[value40.Name] = math.max(v186[value40.Name] or 0, v187)
    end
  end

  if next(v186) then
    v184.Buildings = v186
  end

  local farmFloors2 = v183:FindFirstChild("FarmFloors")
  local v188 = v26.ReadFloorUpgradeSigns() or {}

  if farmFloors2 then
    local v189 = {}

    for index29, value41 in ipairs(farmFloors2:GetChildren()) do
      local v190 = tonumber(value41:GetAttribute("FloorIndex"))
        or tonumber(string.match(value41.Name, "%d+$"))

      if v190 then
        local v191 = {}

        for index30, value42 in ipairs(value41:GetChildren()) do
          if value42:IsA("Model") and value42:GetAttribute("PlotKey") then
            v191[value42:GetAttribute("PlotKey")] = {
              SeedName = value42:GetAttribute("SeedName"),
            }
          end
        end

        local v192 = v188[v190]

        local function f26(p72)
          if type(p72) == "table" then
            return tonumber(p72.Value) or 1
          end

          return tonumber(p72) or 1
        end

        local v193 = {
          Tiles = v191,
          SawYield = f26(v192 and v192.SawYield),
          SprinklerPower = f26(v192 and v192.SprinklerPower),
          SawRange = f26(v192 and v192.SawRange),
          SprinklerRange = f26(v192 and v192.SprinklerRange),
        }

        local buildings3 = value41:FindFirstChild("Buildings")

        if buildings3 then
          local v194 = {}

          for index31, value43 in ipairs(buildings3:GetChildren()) do
            v194[value43.Name] = value43:GetAttribute("Level") or 1
          end

          if next(v194) then
            v193.Buildings = v194
          end
        end

        v189[v190] = v193
      end
    end

    if next(v189) then
      v184.UnlockedFloors = v189
    end
  end

  local plantPot = v183:FindFirstChild("PlantPot")

  if plantPot and plantPot:GetAttribute("SeedName") then
    v184.PlantPot = { SeedName = plantPot:GetAttribute("SeedName") }
  end

  local seedRoller = v183:FindFirstChild("SeedRoller")

  if seedRoller then
    local v195 = {}

    for index32, value44 in ipairs(seedRoller:GetChildren()) do
      local v196 = tonumber(string.match(value44.Name, "^Seed(%d+)$"))

      if v196 and value44:GetAttribute("SeedName") then
        v195[v196] = value44:GetAttribute("SeedName")
      end
    end

    if next(v195) then
      v184.Rolled = v195
    end
  end

  local v197 = v26.ReadPlotUpgradeSign()
  local value45, value46

  if v197 then
    if v197.RollLuck and v197.RollLuck.Value then
      value45 = v197.RollLuck.Value
    end

    if v197.RollPodiums and v197.RollPodiums.Value then
      value46 = v197.RollPodiums.Value
    end

    if v197.Expansion and v197.Expansion.Value then
      v184.Expansion = v197.Expansion.Value
    end
  end

  if value45 then
    v184.RollLuck = value45
  end

  if value46 then
    v184.RollPodiums = value46
  end

  return next(v184) and v184 or nil
end

function v26.Getters.Guild()
  local guildId = localPlayer:GetAttribute("GuildId")

  if not guildId or guildId == "" then
    return nil
  end

  local v198 = f3()
  local mainUI6 = v198 and v198:FindFirstChild("MainUI")
  local guildsFrame = mainUI6 and mainUI6:FindFirstChild("GuildsFrame")

  if not guildsFrame then
    return nil
  end

  local noGuildTab = guildsFrame:FindFirstChild("NoGuildTab")

  if noGuildTab and noGuildTab.Visible == true then
    return nil
  end

  local myGuildTab = guildsFrame:FindFirstChild("MyGuildTab")

  if myGuildTab and myGuildTab.Visible == false then
    return nil
  end

  local myGuildPage = myGuildTab and myGuildTab:FindFirstChild("MyGuildPage")

  local rewardsPage = guildsFrame:FindFirstChild("RewardsTab")
    and guildsFrame.RewardsTab:FindFirstChild("RewardsPage")

  local guildInfo = myGuildPage and myGuildPage:FindFirstChild("GuildInfo")

  local text15 = guildInfo and guildInfo:FindFirstChild("GuildName")
    and guildInfo.GuildName.Text

  if not text15 or text15 == "" or text15 == "Loading..." or text15 == "The Ring Lords" then
    return nil
  end

  local isOwner = false

  local editButton = guildInfo:FindFirstChild("ButtonsHolder")
    and guildInfo.ButtonsHolder:FindFirstChild("EditButton")

  local leaveButton = guildInfo:FindFirstChild("ButtonsHolder")
    and guildInfo.ButtonsHolder:FindFirstChild("LeaveButton")

  local text16 = leaveButton and leaveButton:FindFirstChild("Txt") and leaveButton.Txt.Text

  if editButton and editButton.Visible or text16 == "Disband" then
    isOwner = true
  end

  local weeklyScore = 0
  local lifetimeScore = 0
  local statsHolder = guildInfo:FindFirstChild("StatsHolder")
  local weeklyRow = statsHolder and statsHolder:FindFirstChild("WeeklyRow")

  if weeklyRow and weeklyRow:FindFirstChild("Amount") then
    weeklyScore = f18(weeklyRow.Amount.Text) or 0
  end

  local lifetimeRow = statsHolder and statsHolder:FindFirstChild("LifetimeRow")

  if lifetimeRow and lifetimeRow:FindFirstChild("Amount") then
    lifetimeScore = f18(lifetimeRow.Amount.Text) or 0
  end

  local level = 1
  local levelSection = guildInfo:FindFirstChild("LevelSection")

  local txt4 = levelSection and levelSection:FindFirstChild("TitleHolder")
    and levelSection.TitleHolder:FindFirstChild("Txt")

  if txt4 and txt4.Text then
    level = tonumber(txt4.Text:match("%d+")) or 1
  end

  local membersCount = 0
  local memberSlots = 6
  local membersInfo = myGuildPage:FindFirstChild("MembersInfo")
  local title3 = membersInfo and membersInfo:FindFirstChild("Title")

  if title3 and title3.Text then
    local v199, v200 = title3.Text:match("(%d+)/(%d+)")
    membersCount = tonumber(v199) or 0
    memberSlots = tonumber(v200) or 6
  end

  local d = nil
  local weeklyPanel = rewardsPage and rewardsPage:FindFirstChild("WeeklyPanel")
  local rankTile = weeklyPanel and weeklyPanel:FindFirstChild("RankTile")
  local rank = rankTile and rankTile:FindFirstChild("Rank")

  if rank and rank.Text then
    d = rank.Text:match("#?(%d+)")
  end

  local personalContribution = 0

  local personalScoreRow = weeklyPanel and weeklyPanel:FindFirstChild("StatsHolder")
    and weeklyPanel.StatsHolder:FindFirstChild("PersonalScoreRow")

  if personalScoreRow and personalScoreRow:FindFirstChild("Amount") then
    personalContribution = f18(personalScoreRow.Amount.Text) or 0
  end

  local canClaim = false
  local claimed = false

  local previousWeekReward = rewardsPage and rewardsPage:FindFirstChild("RewardsPanel")
    and rewardsPage.RewardsPanel:FindFirstChild("RewardsHolder")
    and rewardsPage.RewardsPanel.RewardsHolder:FindFirstChild("PreviousWeekReward")

  if previousWeekReward then
    local claim = previousWeekReward:FindFirstChild("Claim")

    if claim and claim.Visible then
      canClaim = true
    end

    local completedFrame = previousWeekReward:FindFirstChild("CompletedFrame")

    if completedFrame and completedFrame.Visible then
      claimed = true
    end
  end

  return {
    Name = text15,
    Level = level,
    WeeklyScore = weeklyScore,
    LifetimeScore = lifetimeScore,
    MembersCount = membersCount,
    MemberSlots = memberSlots,
    Rank = d,
    IsOwner = isOwner,
    PersonalContribution = personalContribution,
    Reward = { CanClaim = canClaim, Claimed = claimed },
  }
end

function v26.Invalidate(p73)
  if p73 then
    v16.DataMirrorCache[p73] = nil
  else
    table.clear(v16.DataMirrorCache)
  end

  if p73 == "PlotSave" or not p73 then
    if v16.FloorPlotInfoCache then
      table.clear(v16.FloorPlotInfoCache)
    end
  end
end

function v26.Get(p74)
  local v201 = os.clock()
  local v202 = v16.DataMirrorCache[p74]

  if v202 and v201 - v202.t < 6 then
    return v202.v
  end

  local v203 = v26.Getters[p74]
  local v204, v205

  if v203 then
    v204, v205 = pcall(v203)
  end

  v205 = v204 and v205 or nil
  v16.DataMirrorCache[p74] = { t = v201, v = v205 }
  return v205
end

local function f27(p75)
  if v15.PlayerDataComplete then
    return
  end

  v15.PlayerDataComplete = true
  v15.PlayerDataSource = p75

  log(
    "Player data complete via %s (%d top-level keys)", p75,
    v16.PlayerData and v25.CountKeys(v16.PlayerData) or 0
  )
end

local v206 = {
  Cash = true,
  Honey = true,
  EquippedPets = true,
  GearShopBought = true,
  Pets = true,
  Seeds = true,
  PetMerchantStock = true,
  PetMerchantSlots = true,
  BeeShopStock = true,
}

local function f28()
  if v15.ExecCanScrape then
    return
  end

  if v15.PlayerDataComplete then
    return
  end

  if not f17() then
    return
  end

  if type(v26.Getters) ~= "table" then
    return
  end

  if not v16.PlayerData then
    v16.PlayerData = {}
  end

  local playerData3 = v16.PlayerData

  if playerData3.Cash ~= nil and tick() - (v16.LastMirrorMerge or 0) < 3 then
    return
  end

  v16.LastMirrorMerge = tick()
  local v207 = f19()

  if v207 and (playerData3.Cash == nil or true) then
    rawset(playerData3, "Cash", v207)
  end

  local v208 = f21()

  if v208 and (playerData3.Honey == nil or true) then
    rawset(playerData3, "Honey", v208)
  end

  for key16, value47 in pairs(v26.Getters) do
    local v209, v210 = pcall(value47)

    if v209 and v210 ~= nil and type(v210) == "table" then
      v16.MirrorMergedFields = v16.MirrorMergedFields or {}
      v16.MirrorMergedFields[key16] = true

      if key16 == "PlotSave" then
        playerData3.PlotSave = playerData3.PlotSave or {}

        for key17, value48 in pairs(v210) do
          playerData3.PlotSave[key17] = value48
        end
      elseif v206[key16] or playerData3[key16] == nil then
        rawset(playerData3, key16, v210)
      else
        local v211 = playerData3[key16]

        if type(v211) == "table" then
          for key18, value49 in pairs(v210) do
            if v211[key18] == nil then
              v211[key18] = value49
            end
          end
        else
          rawset(playerData3, key16, v210)
        end
      end
    end
  end

  if v15.DebugDataAccess then
    v50("[Debug] Mirrors merged: %s", v25.DumpValue(v16.MirrorMergedFields))
  end
end

local function f29(p76)
  if type(p76) ~= "table" then
    return
  end

  local v212 = rawget(p76, "PlotSave")

  if type(v212) ~= "table" then
    return
  end

  local v213 = rawget(v212, "UnlockedFloors")

  if type(v213) ~= "table" then
    return
  end

  for key19, value50 in pairs(v213) do
    if type(value50) == "table" then
      if value50.SprinklerRange == nil then
        value50.SprinklerRange = 1
      end

      if value50.SawRange == nil then
        value50.SawRange = 1
      end

      if value50.SawYield == nil then
        value50.SawYield = 1
      end

      if value50.SprinklerPower == nil then
        value50.SprinklerPower = 1
      end

      if value50.Buildings == nil then
        value50.Buildings = { Upgrader1 = 0, Upgrader2 = 0, Upgrader3 = 0 }
      end

      local v214 = rawget(value50, "Tiles")

      if type(v214) == "table" then
        for key20, value51 in pairs(v214) do
          if type(value51) == "table" then
            local v215 = rawget(value51, "GrowthSpeedMulti")

            if type(v215) == "table" then
              for key21, value52 in pairs(v215) do
                if type(value52) == "table" then
                  if value52.Duration == nil then
                    value52.Duration = value52.TimeLeft or 300
                  end

                  if value52.TimeLeft == nil then
                    value52.TimeLeft = value52.Duration or 300
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

local function f30(p77)
  if not v15.ExecCanScrape then
    return
  end

  if not v16.PlayerData or v25.CountKeys(v16.PlayerData) < 30 then
    return
  end

  local v216 = os.clock()

  if not p77 and v16.LastSyncDataControllerTime and v216 - v16.LastSyncDataControllerTime < 2 then
    return
  end

  v16.LastSyncDataControllerTime = v216

  pcall(function()
    local client = replicatedStorage:FindFirstChild("Client")
    local controllers = client and client:FindFirstChild("Controllers")
    local dataController = controllers and controllers:FindFirstChild("DataController")

    if not dataController then
      return
    end

    local v217 = f1(dataController)

    if not v217 or type(v217.GetData) ~= "function" then
      return
    end

    local getData = v217:GetData()

    if type(getData) == "table" then
      v25.MergeDiff(getData, v16.PlayerData, {})
      f29(getData)
    elseif type(debug.setupvalue) == "function" and type(debug.getupvalues) == "function" then
      for key22, value53 in pairs((debug.getupvalues(v217.GetData))) do
        if value53 == nil or type(value53) == "table" then
          debug.setupvalue(v217.GetData, key22, v16.PlayerData)
          f29(v16.PlayerData)
          break
        end
      end
    end
  end)
end

local v218 = nil

local function f31()
  if not v15.ExecCanScrape then
    log("[ChainController] Bail: ExecCanScrape is false")
    return false
  end

  if not v218 then
    local client2 = replicatedStorage:FindFirstChild("Client")
      or replicatedStorage:WaitForChild("Client", 2)

    local controllers2 = client2
      and (client2:FindFirstChild("Controllers") or client2:WaitForChild("Controllers", 2))

    local dataController2 = controllers2
      and (controllers2:FindFirstChild("DataController")
        or controllers2:WaitForChild("DataController", 2))

    if not dataController2 then
      log("[ChainController] DataController ModuleScript not found in ReplicatedStorage.Client.Controllers")
      return false
    end

    local v219 = f1(dataController2)

    if not v219 then
      log("[ChainController] SafeRequire(DataController) returned nil")
      return false
    end

    if type(v219.GetData) ~= "function" then
      log(
        "[ChainController] DataController.GetData is not a function (type: %s)",
        type(v219.GetData)
      )

      return false
    end

    v218 = v219
  end

  local v220 = v218

  if not v220 or type(v220.GetData) ~= "function" then
    log("[ChainController] DataController module is invalid or missing GetData")
    return false
  end

  local v221, v222 = pcall(function() return v220:GetData() end)

  if not v221 or type(v222) ~= "table" then
    v221, v222 = pcall(v220.GetData)
  end

  if type(v222) ~= "table" then
    f30()
    v221, v222 = pcall(function() return v220:GetData() end)
  end

  if not v221 then
    log("[ChainController] dc:GetData() threw error: %s", tostring(v222))
    return false
  end

  if type(v222) ~= "table" then
    log("[ChainController] dc:GetData() returned non-table: %s", typeof(v222))
    return false
  end

  f30()
  f29(v222)

  if rawget(v222, "Cash") == nil then
    log(
      "[ChainController] dc:GetData() table missing 'Cash' (found %d keys)",
      (v25.CountKeys(v222))
    )

    return false
  end

  local v223, v224 = pcall(v25.CountKeys, v222)
  local v225 = v223 and type(v224) == "number" and v224 or 0

  if v225 < 30 then
    log("[ChainController] dc:GetData() incomplete: only %d keys (< 30)", v225)
    return false
  end

  v16.PlayerData = v222
  v15.PlayerDataSource = "ChainController (DataController.GetData)"
  f27("ChainController (DataController.GetData)")
  log("[ChainController] Successfully acquired complete player data snapshot (%d keys)", v225)
  return true
end

local function f32()
  if v15.GcScanInProgress then
    return
  end

  v15.GcScanInProgress = true

  task.spawn(function()
    local v226 = tick()
    local v227, v228 = pcall(getgc, true)

    if not v227 or type(v228) ~= "table" then
      v227, v228 = pcall(getgc)
    end

    if not v227 or type(v228) ~= "table" then
      log("ChainGcScan error: %s", tostring(v228))
      v15.GcScanInProgress = nil
      return
    end

    local v229 = nil

    for index33, value54 in ipairs(v228) do
      if type(value54) == "table" then
        if rawget(value54, "Cash") ~= nil and rawget(value54, "PlotSave") ~= nil
          and v25.CountKeys(value54) >= 30 then
          v229 = value54
          break
        else
          local v230, v231 = pcall(function() return value54.GetData end)

          if v230 and type(v231) == "function" then
            local v232, v233 = pcall(function() return value54.GetDataAsync end)
            local v234, v235 = pcall(function() return value54.GetDataFromPath end)

            if v232 and type(v233) == "function" and v234 and type(v235) == "function" then
              local v236, v237 = pcall(v231, value54)

              if v236 and type(v237) == "table" and rawget(v237, "Cash") ~= nil
                and v25.CountKeys(v237) >= 30 then
                v229 = v237
                break
              end
            end
          end
        end
      end
    end

    local v238 = math.floor((tick() - v226) * 1000)

    if v238 > 1500 then
      v15.GcScanAttempts = 999
      log("ChainGcScan took %dms, heap too large, disabling further scans", v238)
    end

    if v229 then
      v16.PlayerData = v229
      f29(v229)
      f30()
      f27("ChainGcScan (getgc scan)")
    elseif v15.DebugPrintData then
      log("ChainGcScan attempt #%d (%dms) found no data table", v15.GcScanAttempts, v238)
    end

    v15.GcScanInProgress = nil
  end)
end

local function f33()
  if type(getgc) ~= "function" then
    return
  end

  if tick() - (v16.LastGcScanAttempt or 0) < 3 then
    return
  end

  v16.LastGcScanAttempt = tick()
  v15.GcScanAttempts = (v15.GcScanAttempts or 0) + 1

  if v15.GcScanAttempts > 3 then
    return
  end

  if v15.DebugPrintData then
    log("ChainGcScan attempt #%d starting", v15.GcScanAttempts)
  end

  f32()
end

local function f34(p78, p79)
  if not v10 then
    log("ProcessDataPayload: Serializer missing (payload dropped)")
    return
  end

  local v239, v240 = pcall(v10.decode, p78)
  local v241, v242 = pcall(v10.decode, p79)

  if not v239 or not v241 then
    if not v15.DecodeFailLogged then
      v15.DecodeFailLogged = true

      log(
        "Payload decode failed: ok1=%s ok2=%s argType=%s/%s err1=%s", tostring(v239),
        tostring(v241), typeof(p78), typeof(p79), tostring(v239 and "" or v240)
      )
    end

    return
  end

  v16.PlayerData = v16.PlayerData or {}
  v25.MergeDiff(v16.PlayerData, v240, v242)
  f29(v16.PlayerData)

  if not v15.PlayerDataComplete and v25.CountKeys(v16.PlayerData) >= 40 then
    f27("ChainEventStream (PLAYER_DATA_CHANGED)")
  end

  f30()

  if v15.DebugPrintData then
    local v243, v244 = pcall(v25.DumpValue, v240)
    log("Data event (+): %s", v243 and v244 or tostring(v240))

    if type(v242) == "table" and next(v242) ~= nil then
      local v245, v246 = pcall(v25.DumpValue, v242)
      log("Data event (-): %s", v245 and v246 or tostring(v242))
    end

    local v247, v248 = pcall(v25.DumpValue, v16.PlayerData)

    log([[
[Data] FULL CACHE (%d top-level keys):
%s]], v25.CountKeys(v16.PlayerData), v247 and v248 or tostring(v16.PlayerData))
  end
end

local function f35()
  if not f5() or #v16.RawPayloadBuffer == 0 then
    return
  end

  local rawPayloadBuffer = v16.RawPayloadBuffer
  v16.RawPayloadBuffer = {}

  for index34, value55 in ipairs(rawPayloadBuffer) do
    f34(value55[1], value55[2])
  end

  f29(v16.PlayerData)
  f30()
  log("Processed %d buffered data payload(s) (Serializer arrived late)", #rawPayloadBuffer)
end

local function f36()
  if v17.PlayerDataChanged then
    return true
  end

  local v249 = f4()

  if not v249 then
    return false
  end

  v17.PlayerDataChanged = v249.OnClientEvent:Connect(function(p80, p81)
    if not f5() then
      table.insert(v16.RawPayloadBuffer, { p80, p81 })

      if #v16.RawPayloadBuffer > 100 then
        table.remove(v16.RawPayloadBuffer, 1)
      end

      return
    end

    f35()
    f34(p80, p81)
  end)

  return true
end

local function f37()
  if v15.PlayerDataComplete then
    return true
  end

  if v15.BackfillImpossible then
    return false
  end

  if v16.PlayerData and rawget(v16.PlayerData, "Cash") ~= nil then
    return true
  end

  f36()

  if not v15.ExecCanScrape then
    v15.BackfillImpossible = true
    f28()
    return false
  end

  if f31() then
    return true
  end

  if tick() - (v16.LastBackfillAttempt or 0) < 15 then
    return false
  end

  v16.LastBackfillAttempt = tick()
  f33()
  return false
end

task.spawn(function()
  log(
    "Executor scrape capability: %s (%s)", tostring(v15.ExecCanScrape),
    type(identifyexecutor) == "function" and identifyexecutor() or "unknown"
  )

  local v250 = os.clock() + 120

  while not v17.PlayerDataChanged and not v6.Unloaded and os.clock() < v250 do
    f36()

    if not v17.PlayerDataChanged then
      task.wait(0.25)
    end
  end

  if v17.PlayerDataChanged then
    log(
      "Player data listener installed (%s exec, buffered: %d)",
      v15.ExecCanScrape and "capable" or "diff-only", #v16.RawPayloadBuffer
    )
  else
    log("Player data listener NOT installed after 120s (remote never replicated?)")
  end

  local v251 = os.clock() + 300

  while v6.Unloaded == false and #v16.RawPayloadBuffer > 0 and os.clock() < v251 do
    if f5() then
      f35()
    end

    if #v16.RawPayloadBuffer > 0 then
      task.wait(0.5)
    end
  end

  if #v16.RawPayloadBuffer > 0 then
    log("Raw payload buffer still has %d item(s) after drain window", #v16.RawPayloadBuffer)
  end

  local count4 = 0

  while not v6.Unloaded do
    if v15.PlayerDataComplete then
      break
    end

    if not v15.ExecCanScrape and f17() then
      f28()
      count4 = count4 + 1

      if count4 >= 5 then
        break
      end
    end

    task.wait(1)
  end
end)

if v15.ExecCanScrape then
  task.spawn(function()
    local v252 = os.clock() + 30

    while not v6.Unloaded and not v15.DataControllerSanitized and os.clock() < v252 do
      pcall(function()
        f30()

        local client3 = replicatedStorage:FindFirstChild("Client")
          or replicatedStorage:WaitForChild("Client", 1)

        local controllers3 = client3
          and (client3:FindFirstChild("Controllers") or client3:WaitForChild("Controllers", 1))

        local dataController3 = controllers3
          and (controllers3:FindFirstChild("DataController")
            or controllers3:WaitForChild("DataController", 1))

        if dataController3 then
          local v253 = f1(dataController3)

          if v253 and type(v253.GetData) == "function" then
            v218 = v253
            local getData2 = v253:GetData()

            if type(getData2) == "table" and rawget(getData2, "Cash") ~= nil
              and v25.CountKeys(getData2) >= 50 then
              f29(getData2)
              v15.DataControllerSanitized = true
              v16.PlayerData = getData2
              v15.PlayerDataSource = "ChainController (DataController.GetData)"
              f27("ChainController (DataController.GetData)")
            end
          end
        end
      end)

      if v15.DataControllerSanitized then
        break
      end

      task.wait(0.25)
    end
  end)
end

function f6()
  if v16.PlayerData and rawget(v16.PlayerData, "Cash") ~= nil then
    return v16.PlayerData
  end

  if not v15.ExecCanScrape then
    return v16.PlayerData or {}
  end

  f37()
  return v16.PlayerData or {}
end

local function f38(...)
  local v254 = f6()
  local v255 = { ... }

  for j = 1, #v255 do
    if v254 ~= nil then
      v254 = v254[v255[j]]
    end

    if v254 == nil then
      v254 = v26.Get(v255[1])

      if v254 == nil then
        if v15.DebugDataAccess then
          v50("[Debug] GetPlayerDataValue(%s): no data and no mirror", table.concat(v255, "."))
        end

        return nil
      end

      for k = 2, #v255 do
        if v254 == nil then
          break
        end

        v254 = v254[v255[k]]
      end

      if v254 == nil and v15.DebugDataAccess then
        v50(
          "[Debug] GetPlayerDataValue(%s): mirror present but subpath nil",
          table.concat(v255, ".")
        )
      end

      break
    end
  end

  return v254
end

local function f39(p82)
  p82 = p82 or f6()

  local equippedBees = p82 and type(p82.EquippedBees) == "table"
      and next(p82.EquippedBees) ~= nil and p82.EquippedBees
    or v26.Get("EquippedBees")

  local bees = p82 and type(p82.Bees) == "table" and next(p82.Bees) ~= nil and p82.Bees
    or v26.Get("Bees")

  if not equippedBees or not bees then
    return 0
  end

  local total = 0

  for key23 in pairs(equippedBees) do
    local v256 = bees[key23]
    local bees2 = v256 and v14.Bees and v14.Bees[v256.Name]

    if bees2 and bees2.AbilityInfo and bees2.AbilityInfo.Boost == "BeeAbility" then
      local percent = bees2.AbilityInfo.Percent
      local start = percent and percent.Start or 0.25
      local max3 = percent and percent.Max or start
      local v257 = math.clamp(v256.Level or 1, 1, 5)
      total = total + (start + (max3 - start) * (v257 - 1) / 4)
    end
  end

  local v258 = 1 + math.min(total, 1)
  local v259 = 1

  for key24 in pairs(equippedBees) do
    local v260 = bees[key24]
    local bees3 = v260 and v14.Bees and v14.Bees[v260.Name]

    if bees3 and bees3.AbilityInfo and bees3.AbilityInfo.Boost == "BeeShopDiscount" then
      local percent2 = bees3.AbilityInfo.Percent
      local start2 = percent2 and percent2.Start or 0.06
      local max4 = percent2 and percent2.Max or start2
      local v261 = math.clamp(v260.Level or 1, 1, 5)
      local v262 = (start2 + (max4 - start2) * (v261 - 1) / 4) * v258
      v259 = v259 * (1 - math.clamp(v262 / 0.5, 0, 1))
    end
  end

  return (1 - v259) * 0.5
end

local function f40(p83)
  p83 = p83 or f6()

  local equippedPets = p83 and type(p83.EquippedPets) == "table"
      and next(p83.EquippedPets) ~= nil and p83.EquippedPets
    or v26.Get("EquippedPets")

  local pets3 = p83 and type(p83.Pets) == "table" and next(p83.Pets) ~= nil and p83.Pets
    or v26.Get("Pets")

  if not equippedPets or not pets3 then
    return 0
  end

  local total2 = 0

  for key25 in pairs(equippedPets) do
    local v263 = pets3[key25]

    if v263 then
      local pets4 = v14.Pets and v14.Pets[v263.Name]

      if pets4 and pets4.AbilityParams and pets4.AbilityParams.Boost == "SeedCostDiscount" then
        local boostValue = v263.BoostValue

        if not boostValue then
          boostValue = (pets4.BaseAbilityValue or 0.1)
            + (pets4.ValuePerLevel or 0.003) * (math.clamp(v263.Level or 1, 1, 50) - 1)

          if pets4.AbilityParams.MaxValue then
            boostValue = math.min(boostValue, pets4.AbilityParams.MaxValue)
          end
        end

        total2 = total2 + boostValue
      end
    end
  end

  return math.clamp(total2, 0, 0.5)
end

local function f41(p84, p85)
  local beeShop = v14.BeeShop and v14.BeeShop[p84]

  if not beeShop then
    return 0
  end

  local cost = beeShop.Cost or 0
  p85 = p85 or f6()
  local v264 = p85 and f39(p85) or 0
  return math.floor(cost * (1 - v264))
end

local function f42(p86, p87)
  local beeShop2 = v14.BeeShop and v14.BeeShop[p86]

  if not beeShop2 then
    return 0
  end

  local stock = beeShop2.Stock or 0
  p87 = p87 or f6()
  local getServerTimeNow = workspace:GetServerTimeNow()
  local v265 = math.floor(getServerTimeNow / 900)

  if p87 and p87.LastBeeShopSeed == v265 and type(p87.BeeShopBought) == "table" then
    local v266 = tonumber(p87.BeeShopBought[p86] or p87.BeeShopBought[tostring(p86)]) or 0
    return math.max(0, stock - v266)
  end

  local beeShopStock = v26.Get("BeeShopStock")

  if beeShopStock and beeShopStock[p86] ~= nil then
    return beeShopStock[p86]
  end

  return stock
end

local function f43(p88)
  v16.LocalGearShopBought = v16.LocalGearShopBought or {}

  if not p88 or p88 == "" then
    return
  end

  if v16.LastGearShopStockRaw ~= p88 then
    if v16.LastGearShopStockRaw ~= nil then
      table.clear(v16.LocalGearShopBought)
      v26.Invalidate("GearShopBought")
    end

    v16.LastGearShopStockRaw = p88
  end
end

local function f44(p89, p90)
  local v267 = 0

  if v16.LocalGearShopBought and type(v16.LocalGearShopBought) == "table" then
    local v268 = tonumber(v16.LocalGearShopBought[p89])
      or tonumber(v16.LocalGearShopBought[tostring(p89)]) or 0

    if v268 > v267 then
      v267 = v268
    end
  end

  p90 = p90 or f6()

  if type(p90) == "table" and type(p90.GearShopBought) == "table" then
    local v269 = tonumber(p90.GearShopBought[p89])
      or tonumber(p90.GearShopBought[tostring(p89)]) or 0

    if v269 > v267 then
      v267 = v269
    end
  end

  if v218 and type(v218.GetData) == "function" then
    local v270, v271 = pcall(v218.GetData, v218)

    if v270 and v271 and type(v271.GearShopBought) == "table" then
      local v272 = tonumber(v271.GearShopBought[p89])
        or tonumber(v271.GearShopBought[tostring(p89)]) or 0

      if v272 > v267 then
        v267 = v272
      end
    end
  end

  local gearShopBought = v26.Get("GearShopBought")

  if type(gearShopBought) == "table" then
    local v273 = tonumber(gearShopBought[p89]) or tonumber(gearShopBought[tostring(p89)]) or 0

    if v273 > v267 then
      v267 = v273
    end
  end

  return v267
end

local function f45(p91)
  local v274, v275 = pcall(function() return httpService:JSONDecode(p91) end)

  if v274 and type(v275) == "table" and v275[1] then
    local v276 = {}

    for index35, value56 in ipairs(v13.SEED_PROP_KEYS) do
      if v275[index35 + 1] ~= nil and v275[index35 + 1] ~= "" then
        v276[value56] = v275[index35 + 1]
      end
    end

    v276.Mutation = v276.Mutation or "Normal"
    return v275[1], v276
  end

  if not v15.ExecCanScrape then
    return nil, {}
  end

  if not v11 and f17() then
    local shared4 = replicatedStorage:FindFirstChild("Shared")
    local services3 = shared4 and shared4:FindFirstChild("Services")
    local seedUtil = services3 and services3:FindFirstChild("SeedUtil")
    v11 = seedUtil and f1(seedUtil)
  end

  if v11 and v11.DecodeSeedName then
    local v277, v278, v279 = pcall(v11.DecodeSeedName, p91)

    if v277 and v278 then
      return v278, v279 or {}
    end
  end

  return nil, {}
end

local function f46()
  if not v15.ExecCanScrape then
    return nil
  end

  if not v12 and f17() then
    local shared5 = replicatedStorage:FindFirstChild("Shared")
    local services4 = shared5 and shared5:FindFirstChild("Services")
    local plotUtil = services4 and services4:FindFirstChild("PlotUtil")
    v12 = plotUtil and f1(plotUtil)
  end

  return v12
end

local f47

function f47(p92, p93)
  for index36, value57 in ipairs(p92:GetChildren()) do
    if value57:IsA("ModuleScript") then
      local v280, v281 = pcall(require, value57)

      if v280 and type(v281) == "table" then
        p93[value57.Name] = v281

        if value57.Name == "Plot" then
          for key26, value58 in pairs(v281) do
            p93[key26] = value58
          end
        end
      end
    elseif value57:IsA("Folder") then
      p93[value57.Name] = {}
      f47(value57, p93[value57.Name])
    end
  end
end

local function f48()
  if not v15.ExecCanScrape then
    return false
  end

  if v15.PlotUtilUsable == true then
    return true
  end

  local v282 = f46()

  if not v282 or type(v282.GetFloorUpgrade) ~= "function" then
    return false
  end

  local v283, v284 = pcall(v282.GetFloorUpgrade, "SawYield", 1, 1)

  if not v283 and string.find(tostring(v284), "attempt to index nil", 1, true) then
    if tick() - (v16.LastPlotUtilFill or 0) >= 10 then
      v16.LastPlotUtilFill = tick()

      pcall(function()
        local services5 = replicatedStorage:FindFirstChild("Shared")
          and replicatedStorage.Shared:FindFirstChild("Services")

        local config2 = services5 and services5:FindFirstChild("Config")

        if config2 and config2:IsA("ModuleScript") then
          local v285, v286 = pcall(require, config2)

          if v285 and type(v286) == "table" then
            f47(config2, v286)
          end
        end
      end)

      v283, v284 = pcall(v282.GetFloorUpgrade, "SawYield", 1, 1)
    end
  end

  if v283 then
    if v15.PlotUtilUsable ~= true then
      log("PlotUtil usable: config-dependent functions enabled")
    end

    v15.PlotUtilUsable = true
    return true
  end

  if not string.find(tostring(v284), "attempt to index nil", 1, true) then
    v15.PlotUtilUsable = true
    return true
  end

  if not v15.PlotUtilRetryLogged then
    v15.PlotUtilRetryLogged = true
    log("PlotUtil config copy not ready yet, retrying every 10s...")
  end

  return false
end

local function f49()
  if not v15.ExecCanScrape then
    return nil
  end

  if not v11 and f17() then
    local shared6 = replicatedStorage:FindFirstChild("Shared")
    local services6 = shared6 and shared6:FindFirstChild("Services")
    local seedUtil2 = services6 and services6:FindFirstChild("SeedUtil")
    v11 = seedUtil2 and f1(seedUtil2)
  end

  return v11
end

local function f50(p94, p95)
  if type(p94) ~= "table" or p95 == nil then
    return false
  end

  if p94[p95] == true then
    return true
  end

  for key27, value59 in pairs(p94) do
    if value59 == p95 or key27 == p95 then
      return true
    end
  end

  return false
end

local function f51(p96)
  if not p96 then
    return { "Normal" }
  end

  local plantFilters = v14.PlantFilters

  if plantFilters and plantFilters[p96] then
    return plantFilters[p96]
  end

  local plants = v14.Plants and v14.Plants[p96]

  if plants and type(plants.FilterFlags) == "table" and #plants.FilterFlags > 0 then
    return plants.FilterFlags
  end

  return { "Normal" }
end

local function f52(p97, p98, p99)
  local v287 = f49()
  local v288 = f46()
  local v289 = f6()
  local v290, v291 = f45(p97)
  local plants2 = v290 and v14.Plants and v14.Plants[v290]
  local v292 = 0

  if not p99 and v287 and v287.GetSeedValue then
    local v293, v294 = pcall(v287.GetSeedValue, p97)

    if v293 and type(v294) == "number" then
      v292 = v294
    end
  end

  if v292 <= 0 then
    local fruitValue = plants2 and plants2.FruitValue or plants2 and plants2.Price or 10
    local multiplier = 1

    if not p99 and v291 and v291.Mutation and v291.Mutation ~= "Normal" then
      local mutations = v14.Mutations and v14.Mutations[v291.Mutation]
      multiplier = mutations and mutations.Multiplier or 1
    end

    local size = v291 and v291.Size or 1
    local v295 = 1

    if v291 and v291.Grade and v291.Size then
      local grades = v14.Grades and v14.Grades[v291.Grade]

      if grades and grades.SizeRange
        and math.round(v291.Size * 100) == math.round(grades.SizeRange.Max * 100) then
        v295 = 1.15
      end
    end

    v292 = math.floor(fruitValue * multiplier * size * v295)
  end

  local v296 = 10

  if v288 and v288.GetHarvestInterval and v290 then
    local v297 = 1

    if v288.GetTileGrowthSpeed and v289 and p98 then
      local v298, v299 = pcall(v288.GetTileGrowthSpeed, p98, 1, v289)

      if v298 and type(v299) == "number" and v299 > 0 then
        v297 = v299
      end
    end

    local v300, v301 = pcall(v288.GetHarvestInterval, v290, v297)

    if v300 and type(v301) == "number" and v301 > 0 then
      v296 = v301
    end
  end

  if v296 == 10 and plants2 then
    local fruitGrowTime = plants2.FruitGrowTime or plants2.FruitGrowthTime
      or plants2.PlantGrowTime or 10

    v296 = math.max(fruitGrowTime, 10)
  end

  local sawYield = 1
  local v302 = 0

  if v288 and v289 and p98 then
    if v288.GetSawYield then
      local v303, v304 = pcall(v288.GetSawYield, p98, v289)

      if v303 and type(v304) == "number" then
        sawYield = v304
      end
    end

    if v288.GetFruitIncomeBoost then
      local v305, v306 = pcall(v288.GetFruitIncomeBoost, p98, v289)

      if v305 and type(v306) == "number" then
        v302 = v306
      end
    end
  elseif p98 then
    local getFloorPlotInfo = GetFloorPlotInfo and GetFloorPlotInfo(p98)

    if getFloorPlotInfo then
      sawYield = getFloorPlotInfo.SawYield or 1
    end
  end

  local v307 = 1

  if v288 and v289 and v288.GetPetEarningsMultiplier then
    local v308, v309 = pcall(v288.GetPetEarningsMultiplier, v289)

    if v308 and type(v309) == "number" then
      v307 = v309
    end
  end

  return (v292 + math.floor(v292) * v302) * sawYield / v296 * 60 * v307
end

local function f53(p100, p101)
  local v310 = f46()
  local v311

  if v310 and v310.GetSeedPrice then
    local v312, v313 = pcall(v310.GetSeedPrice, p100, p101)

    if v312 and type(v313) == "number" and v313 > 0 then
      return v313
    elseif not v312 then
      v311 = tostring(v313)
    end
  else
    v311 = not v310 and "PlotUtil missing" or "PlotUtil.GetSeedPrice missing"
  end

  local v314, v315 = f45(p100)

  if v314 then
    local plants3 = v14.Plants and v14.Plants[v314]
    local price6 = plants3 and plants3.Price

    if price6 and price6 > 0 then
      local grade = v315 and v315.Grade or "Standard"
      local v316 = v13.GRADE_MULTIPLIERS[grade] or 1

      if v14.Grades and v14.Grades[grade] and v14.Grades.Standard then
        local sizeRange = v14.Grades.Standard.SizeRange
        local v317 = (sizeRange.Min + sizeRange.Max) * 0.5
        local sizeRange2 = v14.Grades[grade].SizeRange
        v316 = (sizeRange2.Min + sizeRange2.Max) * 0.5 / v317
      end

      return math.floor(price6 * v316)
    end
  end

  log(
    "GetSeedPrice returned 0 for '%s' (Plant: %s) | pUtil error: %s | HasPlantData: %s",
    tostring(p100), tostring(v314), tostring(v311),
    tostring(v314 and v14.Plants and v14.Plants[v314] ~= nil)
  )

  return 0
end

local function f54(p102, p103)
  local v318 = f46()

  if v318 and v318.GetSeedCost then
    local v319, v320, v321 = pcall(v318.GetSeedCost, p102, p103)

    if v319 and type(v320) == "number" and v320 > 0 then
      return v320, v321 or "Cash"
    end
  end

  local v322, v323 = f45(p102)
  local v324 = f40 and f40(p103 or f6()) or 0
  local grade2 = v323 and v323.Grade or "Standard"
  local v325 = v13.GRADE_MULTIPLIERS[grade2] or 1

  if v322 then
    if v14.Events and v14.Events.Bytes and v14.Events.Bytes.Prices
      and v14.Events.Bytes.Prices[v322] then
      local v326 = v14.Events.Bytes.Prices[v322]
      return math.max(math.floor(v326 * v325 * (1 - v324)), 1), "Bytes"
    end

    if v14.AdminEvent and v14.AdminEvent.SeedPrices and v14.AdminEvent.SeedPrices[v322] then
      local v327 = v14.AdminEvent.SeedPrices[v322]
      return math.max(math.floor(v327 * v325 * (1 - v324)), 1), "AdminCoins"
    end

    if v14.Events and v14.Events.Candy and v14.Events.Candy.Prices
      and v14.Events.Candy.Prices[v322] then
      local v328 = v14.Events.Candy.Prices[v322]
      return math.max(math.floor(v328 * v325 * (1 - v324)), 1), "Candy"
    end
  end

  return f53(p102, p103), "Cash"
end

function v24.SeedCost(p104, p105)
  if p105 == "Cash" or not p105 then
    return string.format("$%s", v24.Number(p104))
  elseif p105 == "Bytes" then
    return string.format("%s Bytes", v24.Number(p104))
  elseif p105 == "AdminCoins" then
    return string.format("%s Admin Coins", v24.Number(p104))
  else
    return string.format("%s %s", v24.Number(p104), tostring(p105))
  end
end

local function f55(p106)
  if p106 == "Cash" or not p106 then
    return f19()
  elseif p106 == "Bytes" then
    if v30.GetPlayerBytes then
      local v329 = v30.GetPlayerBytes()

      if type(v329) == "number" then
        return v329
      end
    end

    return tonumber((f38("Bytes"))) or 0
  elseif p106 == "AdminCoins" then
    if v30.GetPlayerAdminCoins then
      local v330 = v30.GetPlayerAdminCoins()

      if type(v330) == "number" then
        return v330
      end
    end

    return tonumber((f38("AdminCoins"))) or 0
  elseif p106 == "Candy" then
    return tonumber((f38("Candy"))) or 0
  elseif p106 == "Honey" then
    return f21()
  end

  return tonumber((f38(p106))) or 0
end

local function f56(p107)
  local v331 = {}
  local total3 = 0
  local v332 = f6()

  if v332 and type(v332.Gears) == "table" then
    for key28, value60 in pairs(v332.Gears) do
      if type(value60) == "table" and value60.Name == p107 then
        local v333 = math.max(0, tonumber(value60.Amount) or tonumber(value60.Count) or 1)

        if v333 > 0 then
          table.insert(v331, { Id = key28, Amount = v333 })
          total3 = total3 + v333
        end
      end
    end
  end

  if total3 == 0 then
    for index37, value61 in ipairs({
      localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
    }) do
      if value61 then
        for index38, value62 in ipairs(value61:GetChildren()) do
          if value62:IsA("Tool") and value62.Name == p107 then
            local gearIndex = value62:GetAttribute("GearIndex")
            local v334 = math.max(0, tonumber(value62:GetAttribute("Amount")) or 1)

            if gearIndex and v334 > 0 then
              table.insert(v331, { Id = gearIndex, Amount = v334 })
              total3 = total3 + v334
            end
          end
        end
      end
    end
  end

  return v331, total3
end

local function f57(p108)
  for index39, value63 in ipairs(p108) do
    if value63.Amount > 0 then
      value63.Amount = value63.Amount - 1
      return value63.Id
    end
  end

  return nil
end

local function f58(p109)
  local v335, v336 = f56(p109)
  return v336
end

local function f59()
  table.clear(v16.AvailableSeedsBuffer)
  local availableSeedsBuffer = v16.AvailableSeedsBuffer
  local v337 = f6()

  if v15.PlayerDataComplete and v337 and type(v337.Seeds) == "table" and next(v337.Seeds) ~= nil then
    for key29, value64 in pairs(v337.Seeds) do
      if type(value64) == "number" and value64 > 0 then
        availableSeedsBuffer[key29] = value64
      end
    end

    return availableSeedsBuffer
  end

  local seeds = v26.Get("Seeds")

  if seeds and next(seeds) ~= nil then
    for key30, value65 in pairs(seeds) do
      if type(value65) == "number" and value65 > 0 then
        availableSeedsBuffer[key30] = value65
      end
    end

    return availableSeedsBuffer
  end

  for index40, value66 in ipairs({
    localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
  }) do
    if value66 then
      for index41, value67 in ipairs(value66:GetChildren()) do
        if value67:IsA("Tool") then
          local seedName3 = value67:GetAttribute("SeedName")
            or value67:GetAttribute("SeedStack")

          if seedName3 and type(seedName3) == "string" and seedName3 ~= "" then
            local amount6 = value67:GetAttribute("Amount")
            local v338 = type(amount6) == "number" and amount6 > 0 and amount6 or 1

            availableSeedsBuffer[seedName3] = math.max(
              availableSeedsBuffer[seedName3] or 0, v338
            )
          end
        end
      end
    end
  end

  return availableSeedsBuffer
end

local function f60()
  local plot = f7("Plot")

  if plot and type(plot.MaxFloors) == "number" then
    return plot.MaxFloors
  end

  local v339 = f16()
  local farmFloors3 = v339 and v339:FindFirstChild("FarmFloors")

  if farmFloors3 then
    local v340 = #farmFloors3:GetChildren()

    if v340 > 0 then
      return v340
    end
  end

  return 3
end

local function f61(p110)
  local v341 = f16()

  if not v341 then
    if not v15.MyPlotMissingLogged then
      v15.MyPlotMissingLogged = true
      log("[GetFloorModel] MyPlot not found yet (waiting for plot Occupant replication...)")
    end

    return nil
  end

  v15.MyPlotMissingLogged = nil
  local farmFloors4 = v341:FindFirstChild("FarmFloors")

  if not farmFloors4 then
    log("[GetFloorModel] FarmFloors folder not found in MyPlot")
    return nil
  end

  return farmFloors4:FindFirstChild("Floor" .. p110)
    or farmFloors4:FindFirstChild(tostring(p110))
end

local function f62(p111)
  table.clear(v16.FloorTilesBuffer)
  local floorTilesBuffer = v16.FloorTilesBuffer

  if p111 then
    for index42, value68 in ipairs(p111:GetChildren()) do
      local plotKey = value68:GetAttribute("PlotKey")

      if plotKey then
        floorTilesBuffer[plotKey] = value68
      end
    end
  end

  return floorTilesBuffer
end

local function f63(p112, p113, p114, p115, p116)
  p114 = p114 or f6()

  if not p115 and p114 and p114.PlotSave and p114.PlotSave.UnlockedFloors then
    p115 = p114.PlotSave.UnlockedFloors[p112] or p114.PlotSave.UnlockedFloors[tostring(p112)]
  end

  if not p116 then
    local v342 = f61(p112)

    if v342 then
      for index43, value69 in ipairs(v342:GetChildren()) do
        if value69:GetAttribute("PlotKey") == p113 then
          p116 = value69
          break
        end
      end
    end
  end

  local tiles = p115 and p115.Tiles and (p115.Tiles[p113] or p115.Tiles[tostring(p113)])
  local dirt = p116 and p116:FindFirstChild("Dirt")
  local v343 = tiles ~= nil or dirt and dirt.Transparency < 0.5

  local seedName4 = type(tiles) == "table" and tiles.SeedName
    or p116 and p116:GetAttribute("SeedName")

  local v344 = seedName4 ~= nil and seedName4 ~= ""
  local v345 = v343 and not v344
  local v346 = math.ceil(p113 / 5)
  local sawRange = p115 and p115.SawRange or 1

  if type(sawRange) == "table" then
    sawRange = sawRange.Value or 1
  end

  sawRange = tonumber(sawRange) or 1
  local sprinklerRange = p115 and p115.SprinklerRange or 1

  if type(sprinklerRange) == "table" then
    sprinklerRange = sprinklerRange.Value or 1
  end

  sprinklerRange = tonumber(sprinklerRange) or 1

  local v347 = {
    FloorIndex = p112,
    TileIndex = p113,
    RingIndex = v346,
    Position = dirt and dirt.Position,
    CFrame = dirt and dirt.CFrame,
    IsUnlocked = v343 or false,
    IsPlanted = v344 or false,
    IsEmpty = v345 or false,
    SawCovered = sawRange >= v346,
    SprinklerCovered = sprinklerRange >= v346,
    RawTileData = type(tiles) == "table" and tiles or nil,
  }

  local v348 = f46()

  if v344 and seedName4 then
    v347.SeedName = seedName4
    local v349, v350 = f45(seedName4)

    v347.PlantName = v349 or "Unknown"

    v347.Rarity = v349 and v14.Plants and v14.Plants[v349] and v14.Plants[v349].Rarity
      or "Common"

    v347.Grade = v350 and v350.Grade or "Standard"
    v347.Size = v350 and v350.Size
    v347.Mutation = v350 and v350.Mutation or "Normal"
    v347.IsMutated = v347.Mutation ~= "Normal" and v347.Mutation ~= ""
    v347.Serial = v350 and v350.Serial

    local plants4 = v349 and v14.Plants and v14.Plants[v349]
    local v351 = type(tiles) == "table" and tiles.PlantGrown == true or false

    if not v351 and plants4 and type(tiles) == "table" and tiles.GrowthStartTime then
      local getServerTimeNow2 = workspace:GetServerTimeNow()
      local plantGrowTime = plants4.PlantGrowTime or 0

      if plantGrowTime > 0 and getServerTimeNow2 - tiles.GrowthStartTime >= plantGrowTime then
        v351 = true
      end
    end

    if type(tiles) == "table" then
      v347.PlantGrown = v351
      v347.GrowthStartTime = tiles.GrowthStartTime

      local fruitGrowTime2 = plants4
          and (v351 and (plants4.FruitGrowTime or plants4.PlantGrowTime) or plants4.PlantGrowTime)
        or 0

      v347.GrowthDuration = fruitGrowTime2

      if tiles.GrowthStartTime and fruitGrowTime2 > 0 then
        local getServerTimeNow3 = workspace:GetServerTimeNow()
        local v352 = math.max(0, getServerTimeNow3 - tiles.GrowthStartTime)

        v347.GrowthProgress = math.clamp(v352 / fruitGrowTime2, 0, 1)
        v347.GrowthTimeLeft = math.max(0, fruitGrowTime2 - v352)
        v347.IsReady = v352 >= fruitGrowTime2
        v347.CanWater = v352 < fruitGrowTime2 - 0.5
      else
        v347.GrowthProgress = v351 and 1 or 0
        v347.GrowthTimeLeft = 0
        v347.IsReady = v351
        v347.CanWater = false
      end

      local growthSpeedMulti = tiles.GrowthSpeedMulti
      v347.GrowthSpeedMulti = growthSpeedMulti or {}
      local v353 = false
      local v354 = nil
      local v355 = 0

      if type(growthSpeedMulti) == "table" then
        local getServerTimeNow4 = workspace:GetServerTimeNow()

        for key31, value70 in pairs(growthSpeedMulti) do
          local timeLeft = 0

          if type(value70) == "table" and type(value70.TimeLeft) == "number" then
            timeLeft = value70.TimeLeft
          elseif type(value70) == "number" then
            timeLeft = math.max(0, value70 - getServerTimeNow4)
          end

          if timeLeft > 0 then
            v353 = true
            v355 = math.max(v355, timeLeft)

            if key31 == "2" or key31 == 2 then
              v354 = "Basic Fertilizer"
            elseif key31 == "4" or key31 == 4 then
              v354 = "Good Fertilizer"
            elseif key31 == "8" or key31 == 8 then
              v354 = "Super Fertilizer"
            else
              v354 = "Fertilizer (" .. tostring(key31) .. "x)"
            end
          end
        end
      end

      v347.HasFertilizer = v353
      v347.FertilizerName = v354
      v347.FertilizerTimeLeft = v355
      v347.Fertilizer = v353 and { Name = v354, TimeLeft = v355 } or nil
    else
      v347.PlantGrown = true
      v347.GrowthDuration = 0
      v347.GrowthProgress = 1
      v347.GrowthTimeLeft = 0
      v347.IsReady = true
      v347.CanWater = false
      v347.GrowthSpeedMulti = {}
      v347.HasFertilizer = false
      v347.FertilizerTimeLeft = 0
      v347.Fertilizer = nil
    end

    local v356 = 0

    if v348 and v348.GetTileCashPerMinute and p114 then
      local v357, v358 = pcall(v348.GetTileCashPerMinute, p114, p112, p113)

      if v357 and type(v358) == "number" then
        v356 = v358
      end
    end

    if v356 <= 0 then
      v356 = tonumber(f52(seedName4, p112)) or 0
    end

    v347.CashPerMinute = v356
  elseif not v343 then
    v347.PlantGrown = false
    v347.GrowthDuration = 0
    v347.GrowthProgress = 0
    v347.GrowthTimeLeft = 0
    v347.IsReady = false
    v347.CanWater = false
    v347.GrowthSpeedMulti = {}
    v347.HasFertilizer = false
    v347.FertilizerTimeLeft = 0
    v347.Fertilizer = nil

    if v348 and v348.GetTilePrice then
      local v359, v360 = pcall(v348.GetTilePrice, p114, p112, p113)

      if v359 and type(v360) == "number" then
        v347.UnlockPrice = v360
      end
    end
  else
    v347.PlantGrown = false
    v347.GrowthDuration = 0
    v347.GrowthProgress = 0
    v347.GrowthTimeLeft = 0
    v347.IsReady = false
    v347.CanWater = false
    v347.GrowthSpeedMulti = {}
    v347.HasFertilizer = false
    v347.FertilizerTimeLeft = 0
    v347.Fertilizer = nil
  end

  return v347
end

local function f64(p117, p118, p119)
  if not p119 and not p118 and v16.FloorPlotInfoCache then
    local v361 = v16.FloorPlotInfoCache[p117]

    if v361 and os.clock() - v361.t < 1.5 then
      return v361.data
    end
  end

  p118 = p118 or f6()
  local v362 = f61(p117)

  local unlockedFloors = p118 and p118.PlotSave and p118.PlotSave.UnlockedFloors
    and (p118.PlotSave.UnlockedFloors[p117] or p118.PlotSave.UnlockedFloors[tostring(p117)])

  if not (unlockedFloors ~= nil and next(unlockedFloors) ~= nil or v362 ~= nil) then
    local v363 = {
      FloorIndex = p117,
      IsUnlocked = false,
      FloorModel = nil,
      Tiles = {},
      UnlockedTiles = {},
      EmptyTiles = {},
      PlantedTiles = {},
      TotalCashPerMinute = 0,
      SawYield = 1,
      SprinklerPower = 1,
      SawRange = 1,
      SprinklerRange = 1,
      Buildings = {},
    }

    if not p118 then
      v16.FloorPlotInfoCache = v16.FloorPlotInfoCache or {}
      v16.FloorPlotInfoCache[p117] = { t = os.clock(), data = v363 }
    end

    return v363
  end

  if not v362 and not unlockedFloors then
    log("[GetFloorPlotInfo] Floor %d has no model and no save data", p117)
  end

  local v364 = f62(v362)
  local v365 = {}
  local v366 = {}
  local v367 = {}
  local v368 = {}
  local total4 = 0

  for m = 1, 30 do
    local v369 = f63(p117, m, p118, unlockedFloors, v364[m])
    v365[m] = v369

    if v369.IsUnlocked then
      table.insert(v366, v369)

      if v369.IsEmpty then
        table.insert(v367, v369)
      elseif v369.IsPlanted then
        table.insert(v368, v369)
        total4 = total4 + (v369.CashPerMinute or 0)
      end
    end
  end

  local v370 = f15()

  local floorUpgradeSign3 = p117 == 1 and v370 and v370:FindFirstChild("FloorUpgradeSign")
    or v362 and v362:FindFirstChild("FloorUpgradeSign")

  local sawYield2 = unlockedFloors and unlockedFloors.SawYield
    or floorUpgradeSign3 and floorUpgradeSign3:GetAttribute("SawYield") or 1

  local sprinklerPower = unlockedFloors and unlockedFloors.SprinklerPower
    or floorUpgradeSign3 and floorUpgradeSign3:GetAttribute("SprinklerPower") or 1

  local sawRange2 = unlockedFloors and unlockedFloors.SawRange
    or floorUpgradeSign3 and floorUpgradeSign3:GetAttribute("SawRange") or 1

  local sprinklerRange2 = unlockedFloors and unlockedFloors.SprinklerRange
    or floorUpgradeSign3 and floorUpgradeSign3:GetAttribute("SprinklerRange") or 1

  local buildings4 = unlockedFloors and unlockedFloors.Buildings or {}

  if v362 then
    local buildings5 = v362:FindFirstChild("Buildings")

    if buildings5 then
      buildings4 = v25.ShallowCopy(buildings4)

      for index44, value71 in ipairs(buildings5:GetChildren()) do
        if buildings4[value71.Name] == nil then
          buildings4[value71.Name] = value71:GetAttribute("Level") or 1
        end
      end
    end
  end

  local v371 = {
    FloorIndex = p117,
    IsUnlocked = true,
    Tiles = v365,
    UnlockedTiles = v366,
    EmptyTiles = v367,
    PlantedTiles = v368,
    TotalCashPerMinute = total4,
    SawYield = sawYield2,
    SprinklerPower = sprinklerPower,
    SawRange = sawRange2,
    SprinklerRange = sprinklerRange2,
    Buildings = buildings4,
  }

  if not p118 then
    v16.FloorPlotInfoCache = v16.FloorPlotInfoCache or {}
    v16.FloorPlotInfoCache[p117] = { t = os.clock(), data = v371 }
  end

  return v371
end

local function f65(p120)
  p120 = p120 or f6()
  local v372 = f60()

  if not v372 or v372 <= 0 then
    log("[GetAllFarmPlots] GetMaxFloors returned invalid value: %s", tostring(v372))
    v372 = 3
  end

  local v373 = {}
  local count5 = 0
  local total5 = 0
  local total6 = 0
  local total7 = 0
  local total8 = 0

  for n = 1, v372 do
    local v374 = f64(n, p120)
    v373[n] = v374

    if v374.IsUnlocked then
      count5 = count5 + 1
      total5 = total5 + #v374.UnlockedTiles
      total6 = total6 + #v374.EmptyTiles
      total7 = total7 + #v374.PlantedTiles
      total8 = total8 + v374.TotalCashPerMinute
    end
  end

  local v375 = f46()
  local v376 = 0

  if v375 and v375.GetCashPerMinute and p120 then
    local v377, v378 = pcall(v375.GetCashPerMinute, p120)

    if v377 and type(v378) == "number" and v378 > 0 then
      v376 = v378
    end
  end

  if v376 <= 0 then
    v376 = total8
  end

  if not v15.PlayerDataComplete then
    local v379, v380 = pcall(function()
      local v381 = f3()

      if not v381 then
        return 0
      end

      for index45, value72 in ipairs(v381:GetChildren()) do
        if value72.Name == "PlotLabel" and value72:IsA("BillboardGui")
          and v26.AdorneeIsMyPlot(value72) then
          for index46, value73 in ipairs(v26.CollectGuiTexts(value72, 8)) do
            if value73:match("^%$") and value73:match("/m$") then
              return f18(value73) or 0
            end
          end
        end
      end

      return 0
    end)

    if v379 and v380 and v380 > 0 then
      v376 = v380
    end
  end

  return {
    Floors = v373,
    TotalUnlockedFloors = count5,
    TotalUnlockedTiles = total5,
    TotalEmptyTiles = total6,
    TotalPlantedTiles = total7,
    TotalFarmCashPerMinute = v376,
  }
end

local function f66()
  local v382 = f16()

  if not v382 then
    return nil
  end

  local buildings6 = v382:FindFirstChild("Buildings")
  return buildings6 and buildings6:FindFirstChild("Composter")
end

local function f67()
  local v383 = f66()

  if not v383 then
    return nil
  end

  local leverPrompt2 = v383:FindFirstChild("LeverPrompt")
  return leverPrompt2 and leverPrompt2:FindFirstChildOfClass("ProximityPrompt")
end

local function f68()
  local v384 = f38("PlotSave", "Buildings", "Composter")

  if type(v384) == "number" and v384 >= 1 then
    return v384
  end

  local v385 = f66()

  if v385 then
    local level2 = v385:GetAttribute("Level")

    if type(level2) == "number" and level2 >= 1 then
      return level2
    end

    local v386 = f16()
    local buildingSignPositions = v386 and v386:FindFirstChild("BuildingSignPositions")

    local composter = buildingSignPositions
      and buildingSignPositions:FindFirstChild("Composter")

    if composter then
      for index47, value74 in ipairs(workspace:GetChildren()) do
        if value74.Name == "BuildingSign"
          and (value74:GetPivot().Position - composter.Position).Magnitude < 10 then
          local screen = value74:FindFirstChild("Screen")
          local v387 = f3()

          if screen and v387 then
            for index48, value75 in ipairs(v387:GetChildren()) do
              if value75.Name == "BuildingSignGui" and value75.Adornee == screen then
                local text17 = value75.Main and value75.Main.BuildingLevel
                  and value75.Main.BuildingLevel.Text

                if text17 then
                  local v388 = string.match(text17, "Level (%d+)")

                  if v388 then
                    return tonumber(v388)
                  end

                  if text17 == "MAX" then
                    return 3
                  end
                end
              end
            end
          end
        end
      end
    end

    return 1
  end

  return 0
end

local function f69(p121, p122)
  p121 = math.clamp(p121 or 1, 1, 3)
  p122 = p122 or "Overgrown Compost"

  if v14.ComposterRewards and v14.ComposterRewards[p121] then
    for index49, value76 in ipairs(v14.ComposterRewards[p121]) do
      if value76.Name == p122 then
        return value76.Threshold
      end
    end
  end

  local v389 = v13.COMPOST_THRESHOLDS[p121]
  return v389 and v389[p122] or 1000000000
end

local function f70()
  local v390 = f66() ~= nil
  local level3 = f68()
  local value77 = f38("PlotSave", "ComposterValue") or 0
  local v391 = f67()
  local isReady = false
  local actionText = "Not Built"

  if v390 then
    if v391 then
      if v391.ActionText == "Pull Lever" then
        isReady = true
        actionText = "Ready to Pull"
      else
        isReady = false
        actionText = v391.ActionText
      end
    else
      local v392 = nil
      local v393 = f46()
      local v394 = f6()

      if v393 and v394 and v393.GetComposterCooldownLeft then
        v392 = v393.GetComposterCooldownLeft(v394)
      end

      if type(v392) == "number" then
        if v392 <= 0 then
          isReady = true
          actionText = "Ready to Pull"
        else
          isReady = false
          actionText = string.format("Ready in %ds", math.ceil(v392))
        end
      else
        actionText = "Active"
      end
    end
  end

  return {
    IsBuilt = v390,
    Level = level3,
    Value = value77,
    Prompt = v391,
    IsReady = isReady,
    CooldownText = actionText,
  }
end

local function f71(p123, pets5, p124)
  p124 = p124 or f6()
  pets5 = pets5 or p124 and p124.Pets and p124.Pets[p123]

  if not pets5 or type(pets5) ~= "table" then
    return nil
  end

  local pets6 = v14.Pets and v14.Pets[pets5.Name] or {}
  local level4 = pets5.Level or 1
  local size2 = pets5.Size or 1
  local rarity = pets6.Rarity or "Common"
  local grade3 = pets5.Grade or "Standard"

  local v395 = {
    Common = 1000,
    Uncommon = 2000,
    Rare = 3500,
    Epic = 6000,
    Legendary = 10000,
    Secret = 16000,
    Prismatic = 25000,
    Transcended = 40000,
    Celestial = 60000,
  }

  local v396 = v395[rarity] or 1000
  local v397 = math.floor(v396 * level4 ^ 1.5)
  local v398 = 1 + (math.clamp(level4, 1, 50) - 1) / 49

  local parsedMultiplier = pets5.ParsedMultiplier
    or math.floor((pets6.EarningsMultiplier or 1) * math.max(size2, 1) * v398 * 10) / 10

  local v399 = nil

  if pets6.BaseAbilityValue then
    v399 = pets6.BaseAbilityValue + (pets6.ValuePerLevel or 0) * (level4 - 1)

    if pets6.AbilityParams and pets6.AbilityParams.MaxValue then
      v399 = math.min(v399, pets6.AbilityParams.MaxValue)
    end
  end

  local equippedPets2 = p124 and p124.EquippedPets and p124.EquippedPets[p123] == true or false

  local favoritedPets = p124 and p124.FavoritedPets and p124.FavoritedPets[p123] == true
    or false

  return {
    Id = p123,
    Name = pets5.Name,
    CustomName = pets5.CustomName,
    DisplayName = pets5.CustomName or pets5.Name,
    Rarity = rarity,
    Grade = grade3,
    Size = size2,
    Level = level4,
    Exp = pets5.Exp or 0,
    NextLevelExp = v397,
    IsMaxLevel = level4 >= 50,
    EarningsMultiplier = parsedMultiplier,
    BoostType = pets6.AbilityParams and pets6.AbilityParams.Boost,
    BoostValue = v399,
    IsProcAbility = pets6.AbilityCooldown ~= nil,
    AbilityTimeLeft = pets5.AbilityTimeLeft,
    TreatName = pets5.TreatName,
    TreatTimeLeft = pets5.TreatTimeLeft or 0,
    HasActiveTreat = (pets5.TreatTimeLeft or 0) > 0,
    CanEatTreat = level4 < 50,
    IsEquipped = equippedPets2,
    IsFavorited = favoritedPets,
    RawData = pets5,
  }
end

local function f72(p125)
  p125 = p125 or f6()
  local v400 = {}

  local pets7 = p125 and type(p125.Pets) == "table" and p125.Pets or f38("Pets")
    or v26.Get("Pets")

  if type(pets7) == "table" then
    for key32, value78 in pairs(pets7) do
      local v401 = f71(key32, value78, p125)

      if v401 then
        table.insert(v400, v401)
      end
    end
  end

  return v400
end

local function f73(p126)
  p126 = p126 or f6()

  local petBarn = p126 and p126.PlotSave and p126.PlotSave.Buildings
      and p126.PlotSave.Buildings.PetBarn
    or 0

  if petBarn == 0 then
    local v402 = f16()

    local petBarn2 = v402
      and (v402:FindFirstChild("Buildings") and v402.Buildings:FindFirstChild("PetBarn")
        or v402:FindFirstChild("PetBarn", true))

    if petBarn2 then
      petBarn = tonumber(petBarn2:GetAttribute("Level")) or 1
    end
  end

  local extraMaxEquippedPets = p126 and p126.ExtraMaxEquippedPets or 0
  local count6 = 0

  if p126 and type(p126.EquippedPets) == "table" then
    for key33 in pairs(p126.EquippedPets) do
      count6 = count6 + 1
    end
  end

  return math.max(petBarn + extraMaxEquippedPets, count6)
end

local function f74(p127)
  p127 = p127 or f6()
  local total9 = 0
  local total10 = 0

  local equippedBees2 = p127 and type(p127.EquippedBees) == "table"
      and next(p127.EquippedBees) ~= nil and p127.EquippedBees
    or v26.Get("EquippedBees")

  local bees4 = p127 and type(p127.Bees) == "table" and next(p127.Bees) ~= nil and p127.Bees
    or v26.Get("Bees")

  if equippedBees2 and bees4 then
    for key34 in pairs(equippedBees2) do
      local v403 = bees4[key34]

      if v403 then
        local bees5 = v14.Bees and v14.Bees[v403.Name]

        if bees5 and bees5.AbilityInfo and bees5.AbilityInfo.Percent then
          local percent3 = bees5.AbilityInfo.Percent
          local v404 = math.clamp(v403.Level or 1, 1, 5)
          local v405 = percent3.Start + (percent3.Max - percent3.Start) * (v404 - 1) / 4

          if v403.Name == "Queen Bee" then
            total9 = total9 + v405
          elseif bees5.AbilityInfo.Boost == "BeeAbility" then
            total10 = total10 + v405
          end
        end
      end
    end
  end

  return 1 + total9 * (1 + math.min(total10, 1))
end

local function f75(p128)
  p128 = p128 or f6()
  local playerGui6 = localPlayer:FindFirstChild("PlayerGui")

  local txt5 = playerGui6 and playerGui6:FindFirstChild("MainUI")
    and playerGui6.MainUI:FindFirstChild("BeeHive")
    and playerGui6.MainUI.BeeHive:FindFirstChild("Content")
    and playerGui6.MainUI.BeeHive.Content:FindFirstChild("Navigation")
    and playerGui6.MainUI.BeeHive.Content.Navigation:FindFirstChild("ActiveBees")
    and playerGui6.MainUI.BeeHive.Content.Navigation.ActiveBees:FindFirstChild("Txt")

  if txt5 and txt5.Text then
    local v406, v407 = txt5.Text:match("(%d+)%s*/%s*(%d+)")

    if v407 then
      return tonumber(v407)
    end
  end

  local maxEquippedBees = p128 and p128.MaxEquippedBees or 2
  local beeHive3 = 1

  if p128 and p128.PlotSave and p128.PlotSave.Buildings and p128.PlotSave.Buildings.BeeHive then
    beeHive3 = p128.PlotSave.Buildings.BeeHive
  else
    local v408 = f16()

    local beeHive4 = v408 and v408:FindFirstChild("Buildings")
      and v408.Buildings:FindFirstChild("BeeHive")

    if beeHive4 then
      beeHive3 = tonumber(beeHive4:GetAttribute("Level")) or 1
    end
  end

  return maxEquippedBees + (math.max(beeHive3, 1) - 1) * 2
end

local function f76(p129, bees6, p130)
  p130 = p130 or f6()
  bees6 = bees6 or p130 and p130.Bees and p130.Bees[p129]

  if not bees6 or type(bees6) ~= "table" then
    return nil
  end

  local bees7 = v14.Bees and v14.Bees[bees6.Name] or {}
  local v409 = math.clamp(bees6.Level or 1, 1, 5)

  local equippedBees3 = bees6.IsEquipped == true
    or p130 and p130.EquippedBees and p130.EquippedBees[p129] ~= nil
    or v26.Get("EquippedBees") and v26.Get("EquippedBees")[p129] ~= nil or false

  local favoritedBees = p130 and p130.FavoritedBees and p130.FavoritedBees[p129] == true
    or false

  local honeyPerMin = bees7.HoneyPerMin or 0

  return {
    Id = p129,
    Name = bees6.Name,
    Rarity = bees7.Rarity or "Common",
    Level = v409,
    BaseHoneyPerMin = honeyPerMin,
    Cost = bees7.Cost or 0,
    SellValue = math.floor((bees7.Cost or 0) * 0.5),
    IsEquipped = equippedBees3,
    IsFavorited = favoritedBees,
    IsMaxLevel = v409 >= 5,
    AbilityInfo = bees7.AbilityInfo,
  }
end

local function f77(p131)
  p131 = p131 or f6()
  local v410 = {}

  local bees8 = p131 and type(p131.Bees) == "table" and p131.Bees or f38("Bees")
    or v26.Get("Bees")

  if type(bees8) == "table" then
    for key35, value79 in pairs(bees8) do
      local v411 = f76(key35, value79, p131)

      if v411 then
        table.insert(v410, v411)
      end
    end
  end

  table.sort(v410, function(p132, p133)
    if p132.BaseHoneyPerMin ~= p133.BaseHoneyPerMin then
      return p132.BaseHoneyPerMin > p133.BaseHoneyPerMin
    end

    return p132.Level > p133.Level
  end)

  return v410
end

local function f78(p134)
  local function f79(p135)
    if not p135 then
      return nil
    end

    for index50, value80 in ipairs(p135:GetChildren()) do
      if value80:IsA("Tool") then
        if value80.Name == p134 or value80:GetAttribute("GearName") == p134
          or value80:GetAttribute("GearKey") == p134 or string.find(value80.Name, p134, 1, true) then
          return value80
        end
      end
    end

    return nil
  end

  return f79(localPlayer.Character) or f79(localPlayer:FindFirstChild("Backpack"))
end

local function f80(p136)
  if not p136 then
    return 0
  end

  if typeof(p136) == "Instance" and p136:IsA("Tool") then
    local amount7 = p136:GetAttribute("Amount")

    if typeof(amount7) == "number" then
      return amount7
    end
  end

  local name3 = typeof(p136) == "Instance" and p136:IsA("Tool") and p136.Name or tostring(p136)

  return tonumber(string.match(name3, "%(%s*[xX]?(%d+)%s*%)")
      or string.match(name3, "%[%s*[xX](%d+)%s*%]") or string.match(name3, "%s+[xX](%d+)"))
    or 1
end

local function f81(p137)
  if p137 and p137.Parent ~= localPlayer.Character then
    local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")

    if humanoid then
      pcall(function() humanoid:EquipTool(p137) end)
    end
  end
end

function v19.Plant()
  local plants5 = f7("Plants")
  local v412 = {}
  local v413 = {}
  local v414 = {}

  if plants5 then
    for key36, value81 in pairs(plants5) do
      table.insert(v412, key36)
      local v415 = {}

      if type(value81) == "table" and type(value81.FilterFlags) == "table"
        and #value81.FilterFlags > 0 then
        for index51, value82 in ipairs(value81.FilterFlags) do
          if type(value82) == "string" and value82 ~= "" then
            table.insert(v415, value82)
            v413[value82] = true
          end
        end
      end

      if #v415 == 0 then
        v415 = { "Normal" }
      end

      v414[key36] = v415
    end

    table.sort(v412)
  end

  if #v412 == 0 then
    log("[LoadPlantData] Warning: No plants loaded from Config.Plants")
    plants5 = {}
  end

  local v416 = {}

  for key37, value83 in pairs(v413) do
    table.insert(v416, key37)
  end

  table.sort(v416)
  local v417 = { "Normal" }

  for index52, value84 in ipairs(v416) do
    table.insert(v417, value84)
  end

  v14.PlantNames = v412
  v14.Plants = plants5
  v14.PlantFilterNames = v417
  v14.PlantFilters = v414
end

function v19.Rarity()
  local rarities = f7("Rarities")
  local v418 = {}
  local v419 = {}

  if rarities then
    local v420 = {}

    for key38, value85 in pairs(rarities) do
      table.insert(v420, {
        Name = key38,
        Index = type(value85) == "table" and value85.Index or 0,
      })
    end

    table.sort(v420, function(p138, p139) return p138.Index < p139.Index end)

    for index53, value86 in ipairs(v420) do
      table.insert(v418, value86.Name)
      v419[value86.Name] = value86.Index
    end
  else
    log("[LoadRarityData] Fallback rarities data!")

    v418 = {
      "Common", "Uncommon", "Rare", "Epic", "Legendary", "Secret", "Prismatic", "Transcended",
      "Celestial", "Eternal", "Primordial",
    }

    for index54, value87 in ipairs(v418) do
      v419[value87] = index54
    end
  end

  v14.PlantRarities = v418
  v14.RarityOrderMap = v419
end

function v19.Grade()
  local grades2 = f7("Grades")
  local v421 = {}
  local v422 = {}

  if grades2 then
    local v423 = {}

    for key39, value88 in pairs(grades2) do
      table.insert(v423, {
        Name = key39,
        Index = type(value88) == "table" and value88.Index or 0,
      })
    end

    table.sort(v423, function(p140, p141) return p140.Index < p141.Index end)

    for index55, value89 in ipairs(v423) do
      table.insert(v421, value89.Name)
      v422[value89.Name] = value89.Index
    end
  else
    log("[LoadGradeData] Fallback grades data!")
    v421 = { "Small", "Standard", "Large", "Huge", "Colossal" }

    for index56, value90 in ipairs(v421) do
      v422[value90] = index56
    end
  end

  v14.PlantGrades = v421
  v14.GradeOrderMap = v422
  v14.Grades = grades2 or {}
end

function v19.Mutation()
  local mutations2 = f7("Mutations")
  local v424 = {}
  local v425 = {}

  if mutations2 then
    local v426 = {}

    for key40, value91 in pairs(mutations2) do
      table.insert(v426, {
        Name = key40,
        Index = type(value91) == "table" and value91.Index or 0,
      })
    end

    table.sort(v426, function(p142, p143) return p142.Index < p143.Index end)

    for index57, value92 in ipairs(v426) do
      table.insert(v424, value92.Name)
      v425[value92.Name] = value92.Index
    end
  else
    log("[LoadMutationData] Fallback mutations data!")

    v424 = {
      "Normal", "Shiny", "Frozen", "Electric", "Radioactive", "Ignited", "Plasma", "Soilbound",
      "Blooming", "Ironclad", "Gilded", "Admin", "Glacial", "Aurora", "Rainbow",
    }

    for index58, value93 in ipairs(v424) do
      v425[value93] = index58
    end
  end

  v14.MutationNames = v424
  v14.MutationOrderMap = v425
  v14.Mutations = mutations2 or {}

  local v427 = {}

  for index59, value94 in ipairs(v424) do
    if value94 ~= "Normal" and value94 ~= "" then
      table.insert(v427, value94)
    end
  end

  v14.RemovableMutationNames = v427
end

function v19.Fishing()
  local fish = f7("Fish")
  local fishingRods = f7("FishingRods")
  local fishing = f7("Fishing")
  local pearlShop = f7("PearlShop")
  local v428 = {}
  local v429 = {}
  local v430 = {}
  local v431 = {}

  if fish and type(fish) == "table" and next(fish) then
    for key41, value95 in pairs(fish) do
      if type(value95) == "table" then
        local rarity2 = value95.Rarity or v13.KNOWN_FISH_RARITIES[key41] or "Common"

        table.insert(v428, {
          Name = key41,
          Rarity = rarity2,
          BaseWeight = value95.BaseWeight or 1,
          SellValue = value95.SellValue or 0,
          Index = value95.Index or 0,
          Buff = value95.Buff,
        })

        table.insert(v429, key41)

        if rarity2 and not v431[rarity2] then
          v431[rarity2] = true
          table.insert(v430, rarity2)
        end
      end
    end

    table.sort(v428, function(p144, p145) return (p144.Index or 0) < (p145.Index or 0) end)
    local rarityOrderMap = v14.RarityOrderMap or {}

    table.sort(v430, function(p146, p147)
      return (rarityOrderMap[p146] or 99) < (rarityOrderMap[p147] or 99)
    end)

    v14.Fish = fish
  else
    local v432 = {}

    for key42, value96 in pairs(v13.KNOWN_FISH_RARITIES) do
      table.insert(v429, key42)
      v432[key42] = { Name = key42, Rarity = value96 }

      table.insert(v428, {
        Name = key42,
        Rarity = value96,
        BaseWeight = 1,
        SellValue = 0,
        Index = 0,
      })

      if value96 and not v431[value96] then
        v431[value96] = true
        table.insert(v430, value96)
      end
    end

    local rarityOrderMap2 = v14.RarityOrderMap or {}

    table.sort(v430, function(p148, p149)
      return (rarityOrderMap2[p148] or 99) < (rarityOrderMap2[p149] or 99)
    end)

    v14.Fish = v432
  end

  table.sort(v429)

  v14.FishList = v428
  v14.FishNames = v429

  v14.FishRarities = #v430 > 0 and v430 or v14.PlantRarities or {
    "Common", "Uncommon", "Rare", "Epic", "Legendary", "Secret", "Prismatic", "Transcended",
    "Celestial",
  }

  v14.FishingRods = fishingRods or {}
  v14.FishingSettings = fishing or {}
  v14.PearlShop = pearlShop or {}

  local v433 = {}

  if pearlShop and type(pearlShop) == "table" then
    for key43, value97 in pairs(pearlShop.Stock or pearlShop) do
      if type(value97) == "table" and value97.Cost then
        table.insert(v433, key43)
      end
    end

    table.sort(v433)
  end

  if #v433 == 0 then
    v433 = {
      "Abyssal Bait", "Golden Bait", "Good Fertilizer", "Super Pet Treat", "Super Roller Token",
      "Worm Bait",
    }
  end

  v14.PearlShopItems = v433
  local gears = f7("Gears")
  local v434 = {}

  if gears and type(gears) == "table" then
    for key44, value98 in pairs(gears) do
      if type(value98) == "table" and value98.Bait ~= nil then
        table.insert(v434, key44)
      end
    end

    table.sort(v434)
  end

  if #v434 == 0 then
    v434 = { "Abyssal Bait", "Golden Bait", "Worm Bait" }
  end

  v14.FishingBaitNames = v434
end

function v19.GearShop()
  local gearShop2 = f7("GearShop")
  local gears2 = f7("Gears")
  local v435 = {}
  local v436 = {}
  local v437 = {}

  if gearShop2 and type(gearShop2.Pool) == "table" then
    for index60, value99 in ipairs(gearShop2.Pool) do
      local name4 = value99.Name
      local shopPrice = gears2 and gears2[name4] and gears2[name4].ShopPrice or 0

      if shopPrice <= 0 then
        shopPrice = 0
      end

      table.insert(v435, { Index = index60, Name = name4, ShopPrice = shopPrice })

      if not v437[name4] then
        v437[name4] = true
        table.insert(v436, name4)
      end
    end
  end

  if #v435 == 0 then
    log("[LoadGearShopData] Warning: No gear shop data from Config.GearShop")
  end

  v14.GearShopItems = v435
  v14.GearShopNames = v436
  v14.Gears = gears2
end

function v19.Fertilizer()
  local gears3 = f7("Gears")
  local v438 = {}
  local v439 = {}

  if gears3 and type(gears3) == "table" then
    for key45, value100 in pairs(gears3) do
      if type(value100) == "table"
        and (key45:find("Fertilizer") or value100.Name and value100.Name:find("Fertilizer")) then
        local name5 = value100.Name or key45

        table.insert(v438, {
          Name = name5,
          Index = tonumber(value100.Index) or 0,
          Data = value100,
        })

        v439[name5] = value100
      end
    end

    table.sort(v438, function(p150, p151) return p150.Index < p151.Index end)
  end

  local v440 = {}

  for index61, value101 in ipairs(v438) do
    table.insert(v440, value101.Name)
  end

  if #v440 == 0 then
    v440 = { "Basic Fertilizer", "Good Fertilizer", "Super Fertilizer" }
  end

  v14.FertilizerNames = v440
  v14.Fertilizers = v439
end

function v19.Spray()
  local gears4 = f7("Gears")
  local v441 = {}
  local v442 = {}

  if gears4 and type(gears4) == "table" then
    for key46, value102 in pairs(gears4) do
      if type(value102) == "table"
        and (key46:find("Spray") or value102.Name and value102.Name:find("Spray")) then
        local name6 = value102.Name or key46
        local price7 = tonumber(value102.ShopPrice) or 0
        table.insert(v441, { Name = name6, Price = price7, Data = value102 })
        v442[name6] = value102
      end
    end

    table.sort(v441, function(p152, p153) return p152.Price < p153.Price end)
  end

  local v443 = {}
  local v444 = {}

  for index62, value103 in ipairs(v441) do
    table.insert(v443, value103.Name)

    if value103.Name ~= "Acid Spray" then
      table.insert(v444, value103.Name)
    end
  end

  if #v443 == 0 then
    v443 = {
      "Acid Spray", "Shiny Spray", "Frozen Spray", "Thunder Spray", "Fire Spray",
      "Plasma Spray", "Soilbound Spray", "Radioactive Spray", "Butterfly Spray",
      "Ironclad Spray", "Gilded Spray", "Admin Spray",
    }

    for index63, value104 in ipairs(v443) do
      if value104 ~= "Acid Spray" then
        table.insert(v444, value104)
      end
    end
  end

  v14.SprayNames = v443
  v14.MutationSprayNames = v444
  v14.Sprays = v442
end

function v19.PlotBuilding()
  v14.PlotBuildings = f7("PlotBuildings") or {}
end

function v19.Event()
  v14.Events = f7("Events") or {}
  v14.HackerBoss = f7("HackerBoss") or {}
  v14.HackerBytes = f7("HackerBytes") or {}
  v14.HackerShop = f7("HackerShop") or {}
  v14.AdminEvent = f7("AdminEvent") or {}
  v14.IndexRewards = f7("IndexRewards") or {}

  local v445 = {}

  if v14.HackerShop and v14.HackerShop.Items then
    for index64, value105 in ipairs(v14.HackerShop.Items) do
      if value105 and value105.Name then
        table.insert(v445, value105.Name)
      end
    end
  end

  v14.HackerShopItemNames = v445
end

function v19.Compost()
  local composterRewards = f7("ComposterRewards")
  v14.ComposterRewards = composterRewards
  local v446 = {}

  if composterRewards and type(composterRewards) == "table" and composterRewards[1] then
    for index65, value106 in ipairs(composterRewards[1]) do
      if value106.Name then
        table.insert(v446, value106.Name)
      end
    end
  end

  if #v446 == 0 then
    log("[LoadCompostData] Using CONST.COMPOST_THRESHOLDS fallback")
    v446 = { "Poor Compost", "Rich Compost", "Prime Compost", "Overgrown Compost" }
  end

  v14.CompostTierNames = v446
end

function v19.PetEgg()
  local petEggs = f7("PetEggs")
  local v447 = {}
  local v448 = {}

  if petEggs then
    for key47, value107 in pairs(petEggs) do
      table.insert(v447, key47)
      v448[key47] = value107
    end

    table.sort(v447)
  end

  if #v447 == 0 then
    log("[LoadPetEggData] Warning: No pet eggs from Config.PetEggs")
  end

  v14.PetEggs = v448
  v14.PetEggNames = v447
end

function v19.PetMerchant()
  local petMerchant3 = f7("PetMerchant")

  local slotPrices = petMerchant3 and petMerchant3.SlotPrices
    or { 15000000, 2000000000, 40000000000 }

  v14.PetMerchant = {
    SlotPrices = slotPrices,
    MaxSlots = petMerchant3 and petMerchant3.MaxSlots or #slotPrices,
    RestockTime = petMerchant3 and petMerchant3.RestockTime or 600,
  }
end

function v19.Pet()
  local pets8 = f7("Pets")
  local v449 = {}

  if pets8 and type(pets8) == "table" then
    for key48, value108 in pairs(pets8) do
      table.insert(v449, key48)
    end

    table.sort(v449)
  end

  if #v449 == 0 then
    log("[LoadPetData] Warning: No pets from Config.Pets")
    pets8 = {}

    for key49, value109 in pairs(pets8) do
      table.insert(v449, key49)
    end

    table.sort(v449)
  end

  v14.Pets = pets8
  v14.PetNames = v449
end

function v19.PetTreat()
  local gears5 = f7("Gears")
  local v450 = {}
  local v451 = {}

  if gears5 and type(gears5) == "table" then
    for key50, value110 in pairs(gears5) do
      if type(value110) == "table"
        and (key50:find("Pet Treat") or value110.Name and value110.Name:find("Pet Treat")) then
        local name7 = value110.Name or key50

        table.insert(v450, {
          Name = name7,
          Index = tonumber(value110.Index) or 0,
          Data = value110,
        })

        v451[name7] = value110
      end
    end

    table.sort(v450, function(p154, p155) return p154.Index < p155.Index end)
  end

  local v452 = {}

  for index66, value111 in ipairs(v450) do
    table.insert(v452, value111.Name)
  end

  if #v452 == 0 then
    v452 = { "Basic Pet Treat", "Good Pet Treat", "Super Pet Treat" }
  end

  v14.PetTreatNames = v452
  v14.PetTreats = v451

  local v453 = {}
  local v454 = {}

  for index67, value112 in ipairs({ v14.SprayNames, v14.FertilizerNames, v452 }) do
    if type(value112) == "table" then
      for index68, value113 in ipairs(value112) do
        if not v454[value113] then
          v454[value113] = true
          table.insert(v453, value113)
        end
      end
    end
  end

  table.sort(v453)
  v14.CollectorGearNames = v453
end

function v19.Bee()
  local bees9 = f7("Bees")
  local v455 = {}

  if bees9 and type(bees9) == "table" then
    for key51 in pairs(bees9) do
      table.insert(v455, key51)
    end

    table.sort(v455)
  end

  if #v455 == 0 then
    bees9 = {}

    for key52 in pairs(bees9) do
      table.insert(v455, key52)
    end

    table.sort(v455)
  end

  v14.Bees = bees9
  v14.BeeNames = v455

  local v456 = {}
  local v457 = {}

  for key53, value114 in pairs(bees9) do
    if type(value114) == "table" and value114.Rarity and not v456[value114.Rarity] then
      v456[value114.Rarity] = true
      table.insert(v457, value114.Rarity)
    end
  end

  local rarityOrderMap3 = v14.RarityOrderMap or {}

  table.sort(v457, function(p156, p157)
    local v458 = rarityOrderMap3[p156] or 0
    local v459 = rarityOrderMap3[p157] or 0

    if v458 ~= v459 then
      return v458 < v459
    end

    return p156 < p157
  end)

  v14.BeeRarities = v457
end

function v19.BeeShop()
  local beeShop3 = f7("BeeShop")
  local v460 = {}
  local v461 = {}

  if beeShop3 and type(beeShop3) == "table" then
    for key54, value115 in pairs(beeShop3) do
      if type(value115) == "table" then
        v460[key54] = value115
        table.insert(v461, key54)
      end
    end

    table.sort(v461, function(p158, p159)
      return (v460[p158] and v460[p158].Index or v460[p158] and v460[p158].Cost or 0)
        < (v460[p159] and v460[p159].Index or v460[p159] and v460[p159].Cost or 0)
    end)
  end

  if #v461 == 0 then
    v460 = {}

    v461 = {
      "Good Fertilizer", "Super Fertilizer", "Super Pet Treat", "Conductor Crate", "Bee Cocoon",
      "Butterfly Spray", "Super Roller Tokens", "Ironclad Spray", "Gilded Spray",
    }
  end

  v14.BeeShop = v460
  v14.BeeShopItemNames = v461
end

function v27.IsMember()
  local guildId2 = localPlayer:GetAttribute("GuildId")

  if guildId2 ~= nil and guildId2 ~= "" then
    return true
  end

  if v16.GuildData and type(v16.GuildData) == "table" and v16.GuildData.Name
    and v16.GuildData.Name ~= "" then
    return true
  end

  return false
end

function v27.GetData()
  if not v27.IsMember() then
    return nil
  end

  if v16.GuildData and v16.GuildData.Name then
    return v16.GuildData
  end

  local guild = v26.Get("Guild")

  if guild and guild.Name then
    return guild
  end

  return v16.GuildData
end

function v27.IsOwner()
  if not v27.IsMember() then
    return false
  end

  local v462 = v27.GetData()

  if not v462 then
    return false
  end

  if v462.OwnerUserId ~= nil then
    return v462.OwnerUserId == localPlayer.UserId
  end

  if v462.IsOwner ~= nil then
    return v462.IsOwner == true
  end

  return false
end

function v27.GetWeekTimeInfo()
  local v463 = os.time()
  local v464 = (math.floor((v463 - 345600) / 604800) + 1) * 604800 + 345600
  local v465 = math.max(0, v464 - v463)
  return v465, v465 <= 7200
end

function v27.UpdateParagraph()
  if not v18.EventsGuildOverview then
    return
  end

  if f10() then
    f11(v18.EventsGuildOverview)
    return
  end

  local v466 = v27.IsMember()
  local v467 = v27.GetData()

  if not v466 or not v467 or not v467.Name or v467.Name == "" then
    f11(v18.EventsGuildOverview, [[
- Status: <font color="#888888">Not in any Guild</font>
- Interact with the Guild Stand NPC at Middle to create or join a guild.]])

    return
  end

  local v468 = v27.IsOwner()
  local v469, v470 = v27.GetWeekTimeInfo()
  local v471 = v24.Clock(v469)

  local v472 = v470 and "<font color=\"#FF5252\">LOCKED</font>"
    or "<font color=\"#00E676\">Active</font>"

  local v473 = v468 and "<font color=\"#FFD700\">Owner (Leader)</font>"
    or "<font color=\"#80D8FF\">Member</font>"

  local rank2 = v467.Rank and "#" .. tostring(v467.Rank) or "Unranked"
  local v474 = v24.Number(v467.WeeklyScore or 0)

  local membersCount2 = v467.MembersCount or type(v467.Members) == "table" and #v467.Members
    or 1

  local memberSlots2 = v467.MemberSlots or 6
  local personalContribution2 = v467.PersonalContribution

  if not personalContribution2 and type(v467.Members) == "table" then
    for index69, value116 in ipairs(v467.Members) do
      if value116.UserId == localPlayer.UserId then
        personalContribution2 = value116.ContributedWeekly
        break
      end
    end
  end

  personalContribution2 = personalContribution2 or 0
  local v475 = "<font color=\"#888888\">In Progress</font>"

  if v467.Reward then
    if v467.Reward.CanClaim == true then
      v475 = "<font color=\"#00E676\">Ready to Claim!</font>"
    elseif v467.Reward.Claimed == true then
      v475 = "<font color=\"#80D8FF\">Claimed</font>"
    end
  end

  local v476 = v468 and " <font color=\"#FFD700\">[OWNER]</font>" or ""

  local v477 = {
    string.format(
      "- Guild: <font color=\"#00E676\">%s</font> (Lv <font color=\"#FFD700\">%d</font>)%s",
      v467.Name, v467.Level or 1, v476
    ),
    string.format("- Role: %s", v473),
    string.format(
      "- Weekly Rank: <font color=\"#00E676\">%s</font> (Score: <font color=\"#FFD700\">%s</font>)",
      rank2, v474
    ),
    string.format(
      "- Your Weekly Contribution: <font color=\"#00E676\">%s</font> pts",
      v24.Number(personalContribution2)
    ),
    string.format(
      "- Members: <font color=\"#80D8FF\">%d / %d</font>", membersCount2, memberSlots2
    ),
    string.format("- Week Status: %s (Resets in <font color=\"#FFD700\">%s</font>)", v472, v471),
    string.format("- Season Reward: %s", v475),
  }

  if v468 and v467.LifetimeScore then
    table.insert(v477, string.format(
      "- Lifetime Score: <font color=\"#FFD700\">%s</font>", v24.Number(v467.LifetimeScore)
    ))
  end

  f11(v18.EventsGuildOverview, table.concat(v477, "\n"))
end

local function f82(p160)
  local v478 = string.gsub(string.lower(tostring(p160 or "")), " ", "")

  return string.find(v478, "ff0000", 1, true) ~= nil
    or string.find(v478, "rgb(255,0,0)", 1, true) ~= nil
end

local function f83(p161)
  pcall(function()
    local sfx = game:GetService("SoundService"):FindFirstChild("SFX")

    if not sfx then
      return
    end

    local notification = sfx:FindFirstChild("Notification")
    local deactivated = sfx:FindFirstChild("Deactivated")

    if not v16.OriginalSoundVolumes then
      v16.OriginalSoundVolumes = {}
    end

    if p161 then
      if notification and v16.OriginalSoundVolumes.Notification == nil then
        v16.OriginalSoundVolumes.Notification = notification.Volume
      end

      if deactivated and v16.OriginalSoundVolumes.Deactivated == nil then
        v16.OriginalSoundVolumes.Deactivated = deactivated.Volume
      end

      if notification then
        notification.Volume = 0
      end

      if deactivated then
        deactivated.Volume = 0
      end
    else
      if notification and v16.OriginalSoundVolumes.Notification ~= nil then
        notification.Volume = v16.OriginalSoundVolumes.Notification
        v16.OriginalSoundVolumes.Notification = nil
      end

      if deactivated and v16.OriginalSoundVolumes.Deactivated ~= nil then
        deactivated.Volume = v16.OriginalSoundVolumes.Deactivated
        v16.OriginalSoundVolumes.Deactivated = nil
      end
    end
  end)
end

local function f84()
  task.spawn(function()
    local waitForChild = localPlayer:WaitForChild("PlayerGui", 10)
    local waitForChild2 = waitForChild and waitForChild:WaitForChild("Fullscreen", 10)
    local waitForChild3 = waitForChild2 and waitForChild2:WaitForChild("Notifications", 10)

    if not waitForChild3 then
      return
    end

    v17.GameNotificationWatcher = waitForChild3.ChildAdded:Connect(function(child)
      if v6.Unloaded or not child:IsA("GuiObject") then
        return
      end

      local textLabel = child:FindFirstChild("TextLabel")
      local text18 = textLabel and textLabel.Text

      if not text18 or text18 == "" then
        return
      end

      local v479 = f82(text18)

      if v479 and v15.SettingsHideGameErrorPopups
        or not v479 and v15.SettingsHideGameSuccessPopups then
        child.Visible = false
      end
    end)
  end)
end

local function f85(p162)
  if p162 then
    v15.PlantRemovalActiveCount = (v15.PlantRemovalActiveCount or 0) + 1
    v15.IsPlantRemovalActive = true
  else
    v15.PlantRemovalActiveCount = math.max(0, (v15.PlantRemovalActiveCount or 1) - 1)
    v15.IsPlantRemovalActive = v15.PlantRemovalActiveCount > 0
  end
end

local function f86(p163)
  local v480 = f8("Dropdown_FloorManager_F" .. p163 .. "RemovalRarities") or {}

  if next(v480) == nil then
    local v481 = string.format(
      "Floor %d: Please select at least one Rarity in Removal Rarities first!", p163
    )

    f9("Floor Manager", v481, 3)
    log(v481)
    return
  end

  local v482 = f64(p163)

  if not v482.IsUnlocked or #v482.PlantedTiles == 0 then
    local v483 = string.format("Floor %d: No crops currently planted on this floor.", p163)
    f9("Floor Manager", v483, 3)
    log(v483)
    return
  end

  local v484 = {}

  for index70, value117 in ipairs(v482.PlantedTiles) do
    local rarity3 = value117.Rarity
      or value117.PlantName and v14.Plants and v14.Plants[value117.PlantName]
        and v14.Plants[value117.PlantName].Rarity

    if rarity3 and (v480[rarity3] == true or f50(v480, rarity3)) then
      table.insert(v484, value117.TileIndex)
    end
  end

  if #v484 == 0 then
    local v485 = string.format("Floor %d: No matching crops found for selected rarities.", p163)
    f9("Floor Manager", v485, 3)
    log(v485)
    return
  end

  task.spawn(function()
    f85(true)
    local count7 = 0

    local v486, v487 = pcall(function()
      for index71, value118 in ipairs(v484) do
        if v6.Unloaded then
          break
        end

        if v23.FireServer("ShovelTile", p163, value118) then
          count7 = count7 + 1
          task.wait(0.15)
        end
      end
    end)

    f85(false)

    if v16.FloorPlotInfoCache then
      table.clear(v16.FloorPlotInfoCache)
    end

    if not v486 then
      log("ExecuteShovelRemoval failed: %s", tostring(v487))
    end

    local v488 = string.format(
      "Floor %d: Successfully destroyed %d plants with Shovel", p163, count7
    )

    f9("Floor Manager", v488, 4)
    log(v488)
  end)
end

function v29.ShovelAll()
  if v15.IsPlantRemovalActive then
    v22.QuickSettings("Action rejected: Plant removal is already in progress! Please wait.", 3)
    return
  end

  f85(true)

  task.spawn(function()
    local v489, v490 = pcall(function()
      local floorManagerQuickSettingsTargetFloors = v15.FloorManagerQuickSettingsTargetFloors
        or f8("Dropdown_FloorManager_QuickSettingsTargetFloors")

      local v491 = f60()
      local v492 = {}

      for i6 = 1, v491 do
        local v493 = "Floor " .. i6
        local v494 = true

        if type(floorManagerQuickSettingsTargetFloors) == "table"
          and next(floorManagerQuickSettingsTargetFloors) ~= nil then
          v494 = floorManagerQuickSettingsTargetFloors[v493] == true
            or f50(floorManagerQuickSettingsTargetFloors, v493)
        end

        if v494 then
          local v495 = f64(i6)

          if v495.IsUnlocked and #v495.PlantedTiles > 0 then
            for index72, value119 in ipairs(v495.PlantedTiles) do
              table.insert(v492, {
                Floor = i6,
                Tile = value119.TileIndex,
                Name = value119.PlantName,
              })
            end
          end
        end
      end

      local v496 = #v492

      if v496 == 0 then
        v22.QuickSettings("No planted crops found on selected floor(s) to destroy.", 4)
        log("No planted crops found on selected floor(s) to destroy.")
        return
      end

      v22.QuickSettings(string.format("Started destroying %d plant(s) with Shovel...", v496), 3)
      local count8 = 0

      for index73, value120 in ipairs(v492) do
        if v6.Unloaded then
          break
        end

        if v23.FireServer("ShovelTile", value120.Floor, value120.Tile) then
          count8 = count8 + 1
          task.wait(0.15)
        end
      end

      local v497 = string.format(
        "Successfully destroyed %d/%d plants on selected floor(s) with Shovel.", count8, v496
      )

      v22.QuickSettings(v497, 4)
      log(v497)
    end)

    f85(false)

    if v16.FloorPlotInfoCache then
      table.clear(v16.FloorPlotInfoCache)
    end

    if not v489 then
      log("CropActions.ShovelAll failed: %s", tostring(v490))
    end
  end)
end

function v29.TrowelAll(p164, p165)
  if v15.IsPlantRemovalActive then
    v22.QuickSettings("Action rejected: Plant removal is already in progress! Please wait.", 3)
    return
  end

  f85(true)

  task.spawn(function()
    local count9 = 0
    local v498 = 0
    local v499 = false

    local v500, v501 = pcall(function()
      local floorManagerQuickSettingsTargetFloors2 = p165
        or v15.FloorManagerQuickSettingsTargetFloors
        or f8("Dropdown_FloorManager_QuickSettingsTargetFloors")

      local v502 = f60()
      local v503 = {}

      for i7 = 1, v502 do
        local v504 = "Floor " .. i7
        local v505 = true

        if type(floorManagerQuickSettingsTargetFloors2) == "table"
          and next(floorManagerQuickSettingsTargetFloors2) ~= nil then
          v505 = floorManagerQuickSettingsTargetFloors2[v504] == true
            or f50(floorManagerQuickSettingsTargetFloors2, v504)
        end

        if v505 then
          local v506 = f64(i7)

          if v506.IsUnlocked and #v506.PlantedTiles > 0 then
            for index74, value121 in ipairs(v506.PlantedTiles) do
              table.insert(v503, {
                Floor = i7,
                Tile = value121.TileIndex,
                Name = value121.PlantName,
                Income = value121.CashPerMinute or 0,
              })
            end
          end
        end
      end

      v498 = #v503

      if v498 == 0 then
        v22.QuickSettings("No planted crops found on selected floor(s) to trowel.", 4)
        log("No planted crops found on selected floor(s) to trowel.")
        v499 = true
        return
      end

      table.sort(v503, function(p166, p167) return (p166.Income or 0) > (p167.Income or 0) end)
      local v507, v508 = f56("Trowel")

      if v508 == 0 then
        local v509 = string.format(
          "Found %d plants on selected floor(s), but you have NO Trowels in inventory!", v498
        )

        v22.QuickSettings(v509, 4)
        log(v509)
        return
      end

      v22.QuickSettings(string.format(
        "Started recovering seeds for %d plant(s) with Trowel...", v498
      ), 3)

      local count10 = 0

      for index75, value122 in ipairs(v503) do
        if v6.Unloaded then
          break
        end

        local v510 = f57(v507)

        if not v510 then
          break
        end

        if v23.FireServer("ActivateGearOnTile", v510, value122.Floor, value122.Tile) then
          count9 = count9 + 1
          task.wait(0.25)
        else
          count10 = count10 + 1
          task.wait(0.15)
        end
      end

      v499 = true
      local v511

      if count9 == v498 then
        v511 = string.format(
          "Successfully troweled all %d plants on selected floor(s) (recovered seeds)!", v498
        )
      else
        local v512 = math.max(0, v498 - v508)

        if v512 > 0 then
          v511 = string.format(
            "Troweled %d/%d plants. Missing %d Trowel(s) to recover remaining crops!", count9,
            v498, v512
          )
        elseif count10 > 0 then
          v511 = string.format(
            "Troweled %d/%d plants (%d failed / out of sync).", count9, v498, count10
          )
        else
          v511 = string.format("Troweled %d/%d plants.", count9, v498)
        end
      end

      v22.QuickSettings(v511, 5)
      log(v511)
    end)

    f85(false)

    if v16.FloorPlotInfoCache then
      table.clear(v16.FloorPlotInfoCache)
    end

    if not v500 then
      log("CropActions.TrowelAll failed: %s", tostring(v501))
    end

    if v499 and type(p164) == "function" then
      if v498 == 0 or count9 == v498 then
        p164(count9, v498)
      else
        v22.QuickSettings("Auto Plant Best cancelled: Farm was not completely cleared.", 4)
      end
    end
  end)
end

function v29.TrowelAllAndPlantBest()
  if v15.IsPlantRemovalActive then
    v22.QuickSettings("Action rejected: Plant removal is already in progress! Please wait.", 3)
    return
  end

  local floorManagerAutoPlantTargetFloors = v15.FloorManagerAutoPlantTargetFloors
    or f8("Dropdown_FloorManager_AutoPlantTargetFloors")
    or v15.FloorManagerQuickSettingsTargetFloors
    or f8("Dropdown_FloorManager_QuickSettingsTargetFloors")

  local v513 = f60()
  local total11 = 0

  for i8 = 1, v513 do
    local v514 = "Floor " .. i8
    local v515 = true

    if type(floorManagerAutoPlantTargetFloors) == "table"
      and next(floorManagerAutoPlantTargetFloors) ~= nil then
      v515 = floorManagerAutoPlantTargetFloors[v514] == true
        or f50(floorManagerAutoPlantTargetFloors, v514)
    end

    if v515 then
      local v516 = f64(i8)

      if v516.IsUnlocked and v516.PlantedTiles then
        total11 = total11 + #v516.PlantedTiles
      end
    end
  end

  local trowel = f58("Trowel")

  if total11 > 0 and trowel < total11 then
    local v517 = string.format(
      "Not enough Trowels! (Have: %d / Need: %d). Please use Smart Replace instead.", trowel,
      total11
    )

    v22.QuickSettings(v517, 5)
    log(v517)
    return
  end

  v29.TrowelAll(function(p168, p169)
    if v6.Unloaded then
      return
    end

    if v6.Options.Toggle_FloorManager_AutoPlantBestAllFloors then
      v6.Options.Toggle_FloorManager_AutoPlantBestAllFloors:SetValue(true)
    else
      v15.FloorManagerAutoPlantBestAllFloors = true
      StartAutoPlantLoop()
    end

    v22.QuickSettings("Trowel completed! Auto Plant Best Seeds has been activated.", 4)
  end, floorManagerAutoPlantTargetFloors)
end

function v29.SmartReplace(p170)
  if v15.IsPlantRemovalActive then
    v22.QuickSettings("Action rejected: Plant removal is already in progress! Please wait.", 3)
    return
  end

  f85(true)

  task.spawn(function()
    local v518, v519 = pcall(function()
      local floorManagerAutoPlantTargetFloors2 = v15.FloorManagerAutoPlantTargetFloors
        or f8("Dropdown_FloorManager_AutoPlantTargetFloors")
        or v15.FloorManagerQuickSettingsTargetFloors
        or f8("Dropdown_FloorManager_QuickSettingsTargetFloors")

      local v520 = f60()
      local v521 = {}

      for i9 = 1, v520 do
        local v522 = "Floor " .. i9
        local v523 = true

        if type(floorManagerAutoPlantTargetFloors2) == "table"
          and next(floorManagerAutoPlantTargetFloors2) ~= nil then
          v523 = floorManagerAutoPlantTargetFloors2[v522] == true
            or f50(floorManagerAutoPlantTargetFloors2, v522)
        end

        if v523 then
          local v524 = f64(i9)

          if v524.IsUnlocked then
            if v524.EmptyTiles and #v524.EmptyTiles > 0 then
              for index76, value123 in ipairs(v524.EmptyTiles) do
                table.insert(v521, {
                  Floor = i9,
                  Tile = value123.TileIndex,
                  Name = "Empty",
                  Income = 0,
                  IsEmpty = true,
                })
              end
            end

            if v524.PlantedTiles and #v524.PlantedTiles > 0 then
              for index77, value124 in ipairs(v524.PlantedTiles) do
                table.insert(v521, {
                  Floor = i9,
                  Tile = value124.TileIndex,
                  Name = value124.PlantName,
                  Income = value124.CashPerMinute or 0,
                  IsEmpty = false,
                })
              end
            end
          end
        end
      end

      if #v521 == 0 then
        v22.QuickSettings("No unlocked tiles found on selected floor(s)!", 4)
        log("No unlocked tiles found on selected floor(s)!")
        return
      end

      local floorManagerAutoPlantIgnoreMutation = v15.FloorManagerAutoPlantIgnoreMutation

      if floorManagerAutoPlantIgnoreMutation == nil then
        floorManagerAutoPlantIgnoreMutation = f8("Toggle_FloorManager_AutoPlantIgnoreMutation")
      end

      local v525 = v25.ShallowCopy(f59())
      local v526 = {}

      for key55, value125 in pairs(v525) do
        if type(value125) == "number" and value125 > 0 then
          local baseCPM = tonumber(f52(key55, 1, floorManagerAutoPlantIgnoreMutation)) or 0
          local v527 = f45(key55) or "Unknown"
          local plants6 = v527 and v14.Plants and v14.Plants[v527]

          local rarityOrderMap4 = plants6 and plants6.Rarity and v14.RarityOrderMap
              and v14.RarityOrderMap[plants6.Rarity]
            or 1

          table.insert(v526, {
            JSON = key55,
            Name = v527,
            RarityRank = rarityOrderMap4,
            BaseCPM = baseCPM,
            Count = value125,
          })
        end
      end

      if #v526 == 0 then
        v22.QuickSettings("No seeds found in your inventory to plant!", 4)
        log("No seeds found in your inventory to plant!")
        return
      end

      table.sort(v526, function(p171, p172)
        if p171.RarityRank ~= p172.RarityRank then
          return p171.RarityRank > p172.RarityRank
        end

        return p171.BaseCPM > p172.BaseCPM
      end)

      local v528 = {}
      local v529 = #v521

      for index78, value126 in ipairs(v526) do
        for i10 = 1, math.min(value126.Count, v529 - #v528) do
          table.insert(v528, {
            JSON = value126.JSON,
            Name = value126.Name,
            BaseCPM = value126.BaseCPM,
          })
        end

        if #v528 >= v529 then
          break
        end
      end

      local trowel2, v530 = p170 == "Trowel" and f56("Trowel") or nil, 0

      if p170 == "Trowel" then
        local v531, v532 = f56("Trowel")
        trowel2 = v531
        v530 = v532
      end

      if p170 == "Trowel" and v530 == 0 then
        local v533 = true

        for index79, value127 in ipairs(v521) do
          if value127.IsEmpty then
            v533 = false
            break
          end
        end

        if v533 then
          v22.QuickSettings(
            "You have NO Trowels in your inventory to recover planted crops!", 4
          )

          log("You have NO Trowels in your inventory to recover planted crops!")
          return
        end
      end

      table.sort(v521, function(p173, p174) return p173.Income < p174.Income end)
      local v534 = {}
      local v535 = v530

      for i11 = 1, math.min(#v521, #v528) do
        local v536 = v521[i11]
        local v537 = v528[i11]

        local v538 = tonumber(f52(v537.JSON, v536.Floor, floorManagerAutoPlantIgnoreMutation))
          or 0

        if v538 > v536.Income then
          if p170 == "Trowel" and not v536.IsEmpty then
            if v535 <= 0 then
              break
            end

            v535 = v535 - 1
          end

          table.insert(v534, {
            Target = v536,
            Seed = v537,
            NewIncome = v538,
            Gain = v538 - v536.Income,
          })
        else
          break
        end
      end

      if #v534 == 0 then
        v22.QuickSettings(
          "All crops on selected floor(s) are already stronger than seeds in your inventory!", 4
        )

        log("All crops on selected floor(s) are already stronger than seeds in your inventory!")
        return
      end

      v22.QuickSettings(string.format(
        "Starting Smart Replace (%s) for %d tile(s)...", p170, #v534
      ), 3)

      local count11 = 0
      local total12 = 0

      for index80, value128 in ipairs(v534) do
        if v6.Unloaded then
          break
        end

        local v539 = false

        if value128.Target.IsEmpty then
          v539 = true
        elseif p170 == "Trowel" then
          local v540 = trowel2 and f57(trowel2)

          if v540 then
            v539 = v23.FireServer(
              "ActivateGearOnTile", v540, value128.Target.Floor, value128.Target.Tile
            )
          end
        elseif p170 == "Shovel" then
          v539 = v23.FireServer("ShovelTile", value128.Target.Floor, value128.Target.Tile)
        end

        if v539 then
          if not value128.Target.IsEmpty then
            task.wait(0.25)
          end

          if v23.FireServer(
            "PlantSeed", value128.Seed.JSON, value128.Target.Floor, value128.Target.Tile
          ) then
            count11 = count11 + 1
            total12 = total12 + value128.Gain
          end

          task.wait(0.25)
        else
          task.wait(0.15)
        end
      end

      local v541 = string.format(
        "Smart Replace (%s): Upgraded %d/%d tile(s) (+%s $/min)!", p170, count11, #v534,
        v24.Number(total12)
      )

      v22.QuickSettings(v541, 5)
      log(v541)
    end)

    f85(false)

    if v16.FloorPlotInfoCache then
      table.clear(v16.FloorPlotInfoCache)
    end

    if not v518 then
      log("CropActions.SmartReplace failed: %s", tostring(v519))
    end
  end)
end

function v28.GetBarnCFrame()
  local v542 = f16()

  local petBarn3 = v542
    and (v542:FindFirstChild("Buildings") and v542.Buildings:FindFirstChild("PetBarn")
      or v542:FindFirstChild("PetBarn", true))

  if not petBarn3 then
    return nil
  end

  local findFirstChild17 = petBarn3:FindFirstChild("Prompt", true)

  if findFirstChild17 then
    local worldCFrame = findFirstChild17:IsA("Attachment") and findFirstChild17.WorldCFrame
      or findFirstChild17:IsA("BasePart") and findFirstChild17.CFrame

    local worldPosition = findFirstChild17:IsA("Attachment") and findFirstChild17.WorldPosition
      or findFirstChild17:IsA("BasePart") and findFirstChild17.Position

    if worldCFrame and worldPosition then
      local position = (worldCFrame * CFrame.new(0, 1.5, -4)).Position
      return CFrame.lookAt(position, Vector3.new(worldPosition.X, position.Y, worldPosition.Z))
    end
  end

  return petBarn3:GetPivot() * CFrame.new(0, 2, -18)
end

function v28.IsNearBarn()
  local v543 = v28.GetBarnCFrame()

  if not v543 then
    return false
  end

  local character4 = localPlayer.Character

  local humanoidRootPart3 = character4
    and (character4:FindFirstChild("HumanoidRootPart") or character4:FindFirstChild("Torso"))

  if not humanoidRootPart3 then
    return false
  end

  return (humanoidRootPart3.Position - v543.Position).Magnitude <= 30
end

function v28.TeleportToBarn()
  local v544 = v28.GetBarnCFrame()

  if not v544 then
    return false
  end

  local character5 = localPlayer.Character

  local humanoidRootPart4 = character5
    and (character5:FindFirstChild("HumanoidRootPart") or character5:FindFirstChild("Torso"))

  if not humanoidRootPart4 then
    return false
  end

  if character5.PivotTo then
    character5:PivotTo(v544)
  else
    humanoidRootPart4.CFrame = v544
  end

  task.wait(0.35)
  return true
end

function v28.EnsureFolder()
  if isfolder and makefolder then
    pcall(function()
      if not isfolder("Lamduck") then
        makefolder("Lamduck")
      end
    end)
  end
end

function v28.Load()
  v28.EnsureFolder()

  if isfile and isfile("Lamduck/BuildARingFarm2_PetTeams.json") and readfile then
    local v545, v546 = pcall(readfile, "Lamduck/BuildARingFarm2_PetTeams.json")

    if v545 and type(v546) == "string" and v546 ~= "" then
      local v547, v548 = pcall(function()
        return game:GetService("HttpService"):JSONDecode(v546)
      end)

      if v547 and type(v548) == "table" then
        return v548
      end
    end
  end

  return {}
end

function v28.Save(p175)
  v28.EnsureFolder()

  if writefile then
    local v549, v550 = pcall(function()
      return game:GetService("HttpService"):JSONEncode(p175)
    end)

    if v549 and type(v550) == "string" then
      pcall(writefile, "Lamduck/BuildARingFarm2_PetTeams.json", v550)
    end
  end
end

function v28.GetNames(p176)
  local v551 = {}

  for key56 in pairs(p176) do
    table.insert(v551, key56)
  end

  table.sort(v551, function(p177, p178)
    local v552 = tonumber(string.match(p177, "%d+"))
    local v553 = tonumber(string.match(p178, "%d+"))

    if v552 and v553 and v552 ~= v553 then
      return v552 < v553
    end

    return p177 < p178
  end)

  return v551
end

function v28.GetNextName(p179)
  local v554 = 1

  while p179["Team " .. v554] ~= nil do
    v554 = v554 + 1
  end

  return "Team " .. v554
end

function v28.GetCurrentEquipped()
  local v555 = {}
  local v556 = {}
  local v557 = f6()

  local equippedPets3 = v557 and type(v557.EquippedPets) == "table"
      and next(v557.EquippedPets) ~= nil and v557.EquippedPets
    or v26.Get("EquippedPets")

  local pets9 = v557 and type(v557.Pets) == "table" and v557.Pets or v26.Get("Pets") or {}

  if equippedPets3 and type(equippedPets3) == "table" then
    for key57 in pairs(equippedPets3) do
      if type(key57) == "string" and key57 ~= "" and not v556[key57] then
        v556[key57] = true
        local v558 = pets9[key57]
        local v559 = v558 and f71(key57, v558, v557)
        local name8 = v559 and v559.Name or v558 and v558.Name or "Unknown"

        local earningsMultiplier = v559 and v559.EarningsMultiplier
          or v558 and v558.ParsedMultiplier or 1

        local level5 = v559 and v559.Level or v558 and v558.Level or 1
        local size3 = v559 and v559.Size or v558 and v558.Size or 1

        if name8 == "Unknown" then
          local v560 = f15()
          local pets10 = v560 and v560:GetAttribute("Pets")

          if type(pets10) == "string" and pets10 ~= "" then
            local v561, v562 = pcall(httpService.JSONDecode, httpService, pets10)

            if v561 and type(v562) == "table" and v562[key57] then
              name8 = v562[key57].Name or name8
              level5 = v562[key57].Level or level5
              size3 = v562[key57].Size or size3
              local pets11 = v14.Pets and v14.Pets[name8]
              earningsMultiplier = pets11 and pets11.EarningsMultiplier or earningsMultiplier
            end
          end
        end

        table.insert(v555, {
          Id = key57,
          Name = name8,
          Level = level5,
          Size = size3,
          EarningsMultiplier = earningsMultiplier,
        })
      end
    end

    if #v555 > 0 then
      return v555
    end
  end

  local clientModels = workspace:FindFirstChild("ClientModels")

  if clientModels then
    for index81, value129 in ipairs(clientModels:GetChildren()) do
      local index82 = value129:GetAttribute("Index")

      if index82 and type(index82) == "string" and index82 ~= "" and not v556[index82] then
        v556[index82] = true
        local pets12 = v14.Pets and v14.Pets[value129.Name]
        local earningsMultiplier2 = pets12 and pets12.EarningsMultiplier or 1

        table.insert(v555, {
          Id = index82,
          Name = value129.Name,
          Level = 1,
          EarningsMultiplier = earningsMultiplier2,
        })
      end
    end
  end

  if #v555 == 0 then
    local v563 = f16()

    local petBarn4 = v563
      and (v563:FindFirstChild("Buildings") and v563.Buildings:FindFirstChild("PetBarn")
        or v563:FindFirstChild("PetBarn", true))

    if petBarn4 then
      for index83, value130 in ipairs(petBarn4:GetDescendants()) do
        local index84 = value130:GetAttribute("Index")

        if index84 and type(index84) == "string" and index84 ~= "" and not v556[index84] then
          v556[index84] = true
          local pets13 = v14.Pets and v14.Pets[value130.Name]
          local earningsMultiplier3 = pets13 and pets13.EarningsMultiplier or 1

          table.insert(v555, {
            Id = index84,
            Name = value130.Name,
            Level = 1,
            EarningsMultiplier = earningsMultiplier3,
          })
        end
      end
    end
  end

  return v555
end

function v28.SaveCurrent(p180, p181, p182, p183)
  local v564 = v28.Load()
  local value131 = type(p180) == "string" and p180 or type(p182) == "table" and p182.Value or ""
  local v565 = string.match(value131 or "", "^%s*(.-)%s*$")

  if not v565 or v565 == "" then
    v565 = v28.GetNextName(v564)
  end

  local v566 = v28.GetCurrentEquipped()

  if #v566 == 0 then
    v22.Pets("No equipped pets found to save!")
    return
  end

  local function f87()
    v564[v565] = v566
    v28.Save(v564)

    if p181 then
      p181:SetValues((v28.GetNames(v564)))
      p181:SetValue(v565)
    end

    if p182 and type(p182.SetValue) == "function" then
      pcall(function() p182:SetValue("") end)
    end

    v22.Pets(string.format("Saved team '%s' (%d pets)", v565, #v566))
  end

  if v564[v565] ~= nil and p183 and p183.Dialog then
    p183:Dialog({
      Title = "Confirm Override",
      Content = string.format("Team %q already exists. Do you want to overwrite it?", v565),
      Buttons = { { Title = "Overwrite", Callback = f87 }, { Title = "Cancel" } },
    })
  else
    f87()
  end
end

function v28.Equip(p184)
  if not p184 or p184 == "" then
    v22.Pets("Please select a team from dropdown first!")
    return
  end

  local v567 = v28.Load()[p184]

  if not v567 or #v567 == 0 then
    v22.Pets("Team not found or is empty!")
    return
  end

  if not v28.IsNearBarn() then
    v28.TeleportToBarn()
  end

  local v568 = v28.GetCurrentEquipped()
  local v569 = {}

  for index85, value132 in ipairs(v568) do
    v569[value132.Id] = true
  end

  local v570 = {}

  for index86, value133 in ipairs(v567) do
    v570[value133.Id] = true
  end

  task.spawn(function()
    for index87, value134 in ipairs(v568) do
      if not v570[value134.Id] then
        v23.FireServer("UnequipPet", value134.Id)
        task.wait(0.2)
      end
    end

    for index88, value135 in ipairs(v567) do
      if v6.Unloaded then
        break
      end

      if not v569[value135.Id] then
        v23.FireServer("EquipPet", value135.Id)
        task.wait(0.25)
      end
    end

    v22.Pets("Equipped team: " .. p184)
  end)
end

function v28.Delete(p185, p186)
  if not p185 or p185 == "" then
    return
  end

  local v571 = v28.Load()

  if v571[p185] then
    v571[p185] = nil
    v28.Save(v571)

    if p186 then
      local v572 = v28.GetNames(v571)
      p186:SetValues(v572)

      if p186.Value == p185 then
        p186:SetValue(v572[1] or nil)
      end
    end

    v22.Pets("Deleted team: " .. p185)
  end
end

function v28.UnequipAll()
  if not v28.IsNearBarn() then
    v28.TeleportToBarn()
  end

  local v573 = v28.GetCurrentEquipped()

  if #v573 == 0 then
    v22.Pets("No equipped pets found!")
    return
  end

  task.spawn(function()
    local count12 = 0

    for index89, value136 in ipairs(v573) do
      if v6.Unloaded then
        break
      end

      v23.FireServer("UnequipPet", value136.Id)
      count12 = count12 + 1
      task.wait(0.2)
    end

    v22.Pets(string.format("Unequipped %d pet(s)", count12))
  end)
end

function v28.GetCurrentEquippedBees()
  local v574 = {}
  local v575 = {}
  local v576 = f6()

  local equippedBees4 = v576 and type(v576.EquippedBees) == "table" and v576.EquippedBees
    or f38("EquippedBees") or v26.Get("EquippedBees")

  local bees10 = v576 and type(v576.Bees) == "table" and v576.Bees or f38("Bees")
    or v26.Get("Bees")

  if type(equippedBees4) == "table" and type(bees10) == "table" then
    for key58 in pairs(equippedBees4) do
      if type(key58) == "string" and key58 ~= "" and not v575[key58] then
        v575[key58] = true
        local v577 = bees10[key58]
        local v578 = v577 and f76(key58, v577, v576)

        if v578 then
          table.insert(v574, v578)
        end
      end
    end
  end

  return v574
end

local function f88(p187)
  if not (p187 and p187.AbilityInfo and p187.AbilityInfo.Percent) then
    return 0
  end

  local percent4 = p187.AbilityInfo.Percent
  local start3 = percent4.Start or 0.04
  local max5 = percent4.Max or start3
  local v579 = math.clamp(p187.Level or 1, 1, 5)
  return start3 + (max5 - start3) * (v579 - 1) / 4
end

function v28.EvaluateTeamIncome(p188, p189)
  local v580 = 1
  local total13 = 0
  local total14 = 0
  local total15 = 0

  if p188 then
    for index90, value137 in ipairs(p188) do
      v580 = v580 + math.max((value137.EarningsMultiplier or 1) - 0.5, 0)

      if value137.BoostType == "SawYield" then
        total13 = total13 + (value137.BoostValue or 0.04)
      elseif value137.BoostType == "FruitIncome" then
        total14 = total14 + (value137.BoostValue or 0.1)
      elseif value137.BoostType == "SprinklerPower" then
        total15 = total15 + (value137.BoostValue or 0.03)
      end
    end
  end

  local v581 = 0
  local v582 = 0
  local v583 = 0
  local total16 = 0

  if p189 then
    for index91, value138 in ipairs(p189) do
      if value138.AbilityInfo and value138.AbilityInfo.Boost then
        local boost = value138.AbilityInfo.Boost
        local v584 = f88(value138)

        if boost == "BeeAbility" then
          total16 = total16 + v584
        elseif boost == "SawYield" then
          v581 = v581 + v584
        elseif boost == "FruitIncome" then
          v582 = v582 + v584
        elseif boost == "SprinklerPower" then
          v583 = v583 + v584
        end
      end
    end

    local v585 = 1 + math.min(total16, 1)
    v581 = v581 * v585
    v582 = v582 * v585
    v583 = v583 * v585
  end

  local v586 = 1 + total13 + v581
  local v587 = 1.5 + total14 + v582
  local v588 = 1 + total15 + v583
  local v589 = 30 / math.max(30, 60 / v588)
  return v586 * v587 * v589 * v580
end

function v28.SelectBestCashPets(p190, p191, p192)
  local v590 = {}

  for index92, value139 in ipairs(p190) do
    table.insert(v590, value139)
  end

  p192 = p192 or v28.GetCurrentEquippedBees()
  local v591 = {}

  for i12 = 1, math.min(p191, #v590) do
    local v592 = nil
    local v593 = -1

    for index93, value140 in ipairs(v590) do
      table.insert(v591, value140)
      local v594 = v28.EvaluateTeamIncome(v591, p192)
      table.remove(v591)

      if v594 > v593 then
        v593 = v594
        v592 = index93
      end
    end

    if v592 then
      local v595 = table.remove(v590, v592)
      table.insert(v591, v595)
    else
      break
    end
  end

  return v591
end

function v28.SelectBestCashBees(p193, p194, p195)
  local v596 = {}

  for index94, value141 in ipairs(p193) do
    table.insert(v596, value141)
  end

  p195 = p195 or v28.GetCurrentEquipped()
  local v597 = {}

  for i13 = 1, math.min(p194, #v596) do
    local v598 = nil
    local v599 = -1
    local v600 = -1

    for index95, value142 in ipairs(v596) do
      table.insert(v597, value142)
      local v601 = v28.EvaluateTeamIncome(p195, v597)
      table.remove(v597)
      local v602 = (value142.BaseHoneyPerMin or 0) * 10 + (value142.Level or 1)

      if v601 > v599 or math.abs(v601 - v599) < 0.000001 and v602 > v600 then
        v599 = v601
        v600 = v602
        v598 = index95
      end
    end

    if v598 then
      local v603 = table.remove(v596, v598)
      table.insert(v597, v603)
    else
      break
    end
  end

  return v597
end

function v28.SelectBestBoostBees(p196, p197, p198)
  local v604 = {}

  for index96, value143 in ipairs(p196) do
    table.insert(v604, value143)
  end

  local v605 = {}

  for i14 = 1, math.min(p197, #v604) do
    local v606 = nil
    local v607 = -1
    local v608 = -1

    for index97, value144 in ipairs(v604) do
      table.insert(v605, value144)
      local total17 = 0
      local total18 = 0

      for index98, value145 in ipairs(v605) do
        if value145.AbilityInfo and value145.AbilityInfo.Boost then
          local boost2 = value145.AbilityInfo.Boost
          local v609 = f88(value145)

          if boost2 == p198 then
            total17 = total17 + v609
          elseif boost2 == "BeeAbility" then
            total18 = total18 + v609
          end
        end
      end

      local v610 = total17 * (1 + math.min(total18, 1))
      table.remove(v605)

      local v611 = (value144.AbilityInfo and value144.AbilityInfo.Boost == p198 and f88(value144)
            or value144.AbilityInfo and value144.AbilityInfo.Boost == "BeeAbility"
              and f88(value144)
            or 0)
          * 1000
        + (value144.BaseHoneyPerMin or 0) * 10
        + (value144.Level or 1)

      if v610 > v607 or math.abs(v610 - v607) < 0.000001 and v611 > v608 then
        v607 = v610
        v608 = v611
        v606 = index97
      end
    end

    if v606 then
      local v612 = table.remove(v604, v606)
      table.insert(v605, v612)
    else
      break
    end
  end

  return v605
end

local function f89(p199)
  if p199 and p199 ~= localPlayer then
    pcall(function() localPlayer:RequestFriendship(p199) end)
  end
end

local function f90(p200)
  v15.MiscAutoFriendRequest = p200

  if p200 then
    task.spawn(function()
      for index99, value146 in ipairs(players:GetPlayers()) do
        if not v15.MiscAutoFriendRequest or v6.Unloaded then
          break
        end

        f89(value146)
        task.wait(1)
      end
    end)

    if not v17.FriendRequestPlayerAdded then
      v17.FriendRequestPlayerAdded = players.PlayerAdded:Connect(function(player)
        if v6.Unloaded or not v15.MiscAutoFriendRequest then
          return
        end

        task.wait(2)
        f89(player)
      end)
    end

    if not v17.FriendRequestReceived then
      pcall(function()
        v17.FriendRequestReceived = localPlayer.FriendRequestEvent:Connect(function(p201)
          if v6.Unloaded or not v15.MiscAutoFriendRequest then
            return
          end

          task.wait(1)
          f89(p201)
        end)
      end)
    end
  else
    if v17.FriendRequestPlayerAdded then
      v17.FriendRequestPlayerAdded:Disconnect()
      v17.FriendRequestPlayerAdded = nil
    end

    if v17.FriendRequestReceived and typeof(v17.FriendRequestReceived) == "RBXScriptConnection" then
      v17.FriendRequestReceived:Disconnect()
      v17.FriendRequestReceived = nil
    end
  end
end

function v30.ClaimQueenMoth(p202)
  if not p202 or not p202.Parent then
    return
  end

  local v613 = f6()
  local queenMothClaimTime = v613 and v613.QueenMothClaimTime or 0
  local events = f7("Events")
  local claimCooldown = events and events.QueenMoth and events.QueenMoth.ClaimCooldown or 1800
  local v614 = math.max(0, queenMothClaimTime + claimCooldown - workspace:GetServerTimeNow())

  if v614 and v614 > 0 then
    if not v16.QueenMothNotified then
      v16.QueenMothNotified = true

      v22.Event(string.format(
        "Queen Moth spotted! Claim cooldown: %ds remaining", math.ceil(v614)
      ), 10)

      task.spawn(function()
        task.wait(v614)

        if p202 and p202.Parent
          and (v15.EventsAutoClaimQueenMoth or f8("Toggle_Events_AutoClaimQueenMoth")) then
          local v615 = f13()

          if v615 and f14(p202:GetPivot() + Vector3.new(0, 1, 2)) then
            task.wait(0.3)
            v23.FireServer("ClaimQueenMoth")
            task.wait(0.2)
            f14(v615)
            v22.Event("Claimed Queen Moth Pet!")
            v16.QueenMothNotified = nil
          end
        end
      end)
    end

    return
  end

  local v616 = f13()

  if not v616 then
    return
  end

  if not f14(p202:GetPivot() + Vector3.new(0, 1, 2)) then
    return
  end

  task.wait(0.3)
  v23.FireServer("ClaimQueenMoth")
  task.wait(0.2)
  f14(v616)
  v22.Event("Claimed Queen Moth Pet!")
  v16.QueenMothNotified = nil
end

local function f91(p203)
  local v617 = f16()
  local v618 = f61(p203)
  local floorUpgradeSign4 = nil

  if p203 == 1 then
    floorUpgradeSign4 = v617 and v617:FindFirstChild("FloorUpgradeSign")
      or v618 and v618:FindFirstChild("FloorUpgradeSign")
  elseif v618 then
    floorUpgradeSign4 = v618:FindFirstChild("FloorUpgradeSign")
  elseif v617 then
    local farmFloors5 = v617:FindFirstChild("FarmFloors")

    local findFirstChild18 = farmFloors5
      and (farmFloors5:FindFirstChild("Floor" .. p203)
        or farmFloors5:FindFirstChild(tostring(p203)))

    floorUpgradeSign4 = findFirstChild18 and findFirstChild18:FindFirstChild("FloorUpgradeSign")
  end

  if floorUpgradeSign4 then
    local screen2 = floorUpgradeSign4:FindFirstChild("Screen") or floorUpgradeSign4.PrimaryPart
      or floorUpgradeSign4:FindFirstChildWhichIsA("BasePart")

    if screen2 then
      local position2 = screen2.Position
      local v619 = position2 + -screen2.CFrame.LookVector * 6.5
      local v620 = position2.Y - (p203 == 1 and 2.5 or 3)

      return f14((CFrame.lookAt(
        Vector3.new(v619.X, v620, v619.Z), Vector3.new(position2.X, v620, position2.Z)
      )))
    end
  end

  if v618 then
    return f14(v618:GetPivot() * CFrame.new(0, 5, 25))
  end

  if v617 then
    local v621 = (p203 - 1) * 21.55 + 5
    return f14(v617:GetPivot() * CFrame.new(0, v621, 25))
  end

  return false
end

local function f92()
  local coreGui = game:GetService("CoreGui")

  if v16.FloorTeleportGui then
    v16.FloorTeleportGui:Destroy()
    v16.FloorTeleportGui = nil
  end

  for index100, value147 in ipairs({ "LamduckFloorTP", "LamduckFloatingTP" }) do
    local findFirstChild19 = coreGui:FindFirstChild(value147)

    if findFirstChild19 then
      findFirstChild19:Destroy()
    end
  end

  local lamduckFloorTP = Instance.new("ScreenGui")
  lamduckFloorTP.Name = "LamduckFloorTP"
  lamduckFloorTP.ResetOnSpawn = false

  pcall(function() lamduckFloorTP.Parent = gethui and gethui() or coreGui end)

  if not lamduckFloorTP.Parent then
    lamduckFloorTP.Parent = localPlayer:WaitForChild("PlayerGui")
  end

  local container = Instance.new("Frame")
  container.Name = "Container"
  container.Position = UDim2.new(0, 12, 0, 10)
  container.Size = UDim2.new(0, 0, 0, 24)
  container.AutomaticSize = Enum.AutomaticSize.X
  container.BackgroundTransparency = 1
  container.BorderSizePixel = 0
  container.Parent = lamduckFloorTP

  local uiListLayout = Instance.new("UIListLayout")
  uiListLayout.FillDirection = Enum.FillDirection.Horizontal
  uiListLayout.Padding = UDim.new(0, 4)
  uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout.Parent = container

  for i15 = 1, f60() do
    local textButton = Instance.new("TextButton")
    textButton.Name = "Floor" .. i15
    textButton.Size = UDim2.new(0, 30, 0, 24)
    textButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    textButton.BackgroundTransparency = 0.2
    textButton.Text = "F" .. i15
    textButton.TextColor3 = Color3.fromRGB(230, 230, 230)
    textButton.Font = Enum.Font.GothamBold
    textButton.TextSize = 12
    textButton.LayoutOrder = i15
    textButton.Parent = container

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 4)
    uiCorner.Parent = textButton

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(60, 60, 60)
    uiStroke.Thickness = 1
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Parent = textButton

    textButton.MouseButton1Click:Connect(function() pcall(function() f91(i15) end) end)
  end

  v16.FloorTeleportGui = lamduckFloorTP
  return lamduckFloorTP
end

function v30.RemoveHover()
  local character6 = localPlayer.Character
  local humanoidRootPart5 = character6 and character6:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart5 then
    return
  end

  local hackerBossHover = humanoidRootPart5:FindFirstChild("HackerBossHover")

  if hackerBossHover then
    hackerBossHover:Destroy()
  end
end

local function f93()
  if v15.IsAutoSellFruitsLoopRunning then
    return
  end

  v15.IsAutoSellFruitsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.ShopFruitAutoSellFruits or f8("Toggle_Shop_FruitAutoSellFruits")) do
      local v622, v623 = pcall(function()
        local v624 = false
        local eventsPauseAutoSellFruits = v15.EventsPauseAutoSellFruits

        if eventsPauseAutoSellFruits == nil then
          eventsPauseAutoSellFruits = f8("Toggle_Events_PauseAutoSellFruits")
        end

        local eventsAutoTrainVoyage = v15.EventsAutoTrainVoyage

        if eventsAutoTrainVoyage == nil then
          eventsAutoTrainVoyage = f8("Toggle_Events_AutoTrainVoyage")
        end

        if eventsPauseAutoSellFruits and eventsAutoTrainVoyage then
          local v625, v626 = pcall(function()
            local activeEvents = replicatedStorage:FindFirstChild("ActiveEvents")

            if not activeEvents or not activeEvents:FindFirstChild("Train Voyage") then
              return false
            end

            local trainCarts = workspace:GetAttribute("TrainCarts")

            if type(trainCarts) ~= "string" then
              return false
            end

            local v627, v628 = pcall(httpService.JSONDecode, httpService, trainCarts)

            if not v627 or type(v628) ~= "table" then
              return false
            end

            for key59, value148 in pairs(v628) do
              if value148 and value148.UserId == localPlayer.UserId then
                return value148.Completed ~= true
              end
            end

            return false
          end)

          if v625 and v626 == true then
            v624 = true
          end
        end

        if v624 then
        else
          local sellFruits = v23.FireServer("SellFruits")
        end
      end)

      local shopFruitSellInterval = v15.ShopFruitSellInterval
        or f8("Slider_Shop_FruitSellInterval") or 10

      task.wait(math.max(1, shopFruitSellInterval))
    end

    v15.IsAutoSellFruitsLoopRunning = false
  end)
end

local function f94()
  if v15.IsAutoBuyGearShopLoopRunning then
    return
  end

  v15.IsAutoBuyGearShopLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.ShopGearShopAutoBuyTargetGears or f8("Toggle_Shop_GearShopAutoBuyTargetGears")) do
      local v629, v630 = pcall(function()
        local gearShopStock2 = workspace:GetAttribute("GearShopStock")

        if not gearShopStock2 or gearShopStock2 == "" then
          return
        end

        f43(gearShopStock2)
        local v631, v632 = pcall(httpService.JSONDecode, httpService, gearShopStock2)

        if not v631 or type(v632) ~= "table" then
          return
        end

        local dropdownShopGearShopTargetGears = f8("Dropdown_Shop_GearShopTargetGears")

        if type(dropdownShopGearShopTargetGears) ~= "table"
          or next(dropdownShopGearShopTargetGears) == nil then
          return
        end

        local gearShopItems2 = v14.GearShopItems

        if not gearShopItems2 or #gearShopItems2 == 0 then
          return
        end

        local v633 = f19()
        local v634 = {}
        local total19 = 0

        for index101, value149 in ipairs(gearShopItems2) do
          if not (v15.ShopGearShopAutoBuyTargetGears or f8("Toggle_Shop_GearShopAutoBuyTargetGears"))
            or v6.Unloaded then
            break
          end

          if dropdownShopGearShopTargetGears[value149.Name] == true then
            local v635 = tonumber(v632[tostring(value149.Index)] or v632[value149.Index]) or 0
            local v636 = f44(value149.Index)
            local v637 = math.max(0, v635 - v636)
            local v638 = value149.ShopPrice > 0 and math.floor(v633 / value149.ShopPrice) or 0
            local v639 = math.min(v637, v638)

            if v637 <= 0 then
            elseif v638 <= 0 then
              if not v15["LoggedNoCashGear_" .. value149.Name] then
                v15["LoggedNoCashGear_" .. value149.Name] = true
              end
            else
              v15["LoggedNoCashGear_" .. value149.Name] = nil
              local count13 = 0
              local v640 = v636

              for i16 = 1, v639 do
                if not (v15.ShopGearShopAutoBuyTargetGears
                    or f8("Toggle_Shop_GearShopAutoBuyTargetGears"))
                  or v6.Unloaded then
                  break
                end

                if v23.FireServer("BuyFromGearShop", value149.Index) then
                  v633 = v633 - value149.ShopPrice
                  total19 = total19 + value149.ShopPrice
                  count13 = count13 + 1
                  v640 = v640 + 1
                  v16.LocalGearShopBought[value149.Index] = v640
                  task.wait(0.2)
                else
                  break
                end
              end

              if count13 > 0 then
                table.insert(v634, string.format("%dx %s", count13, value149.Name))
                v26.Invalidate("GearShopBought")
              end
            end
          end
        end

        if #v634 > 0 then
          v22.Shop(string.format(
            "Bought from Gear Shop: %s ($%s)", table.concat(v634, ", "), v24.Number(total19)
          ), 4)
        end
      end)

      task.wait(3)
    end

    v15.IsAutoBuyGearShopLoopRunning = false
  end)
end

local function f95()
  if v15.IsAutoBuyPlotUpgradesLoopRunning then
    return
  end

  v15.IsAutoBuyPlotUpgradesLoopRunning = true

  task.spawn(function()
    local function f96()
      return v15.ShopPlotUpgradeAutoBuyExpansion or v15.ShopPlotUpgradeAutoBuyRollLuck
        or v15.ShopPlotUpgradeAutoBuyRollPodiums
        or f8("Toggle_Shop_PlotUpgradeAutoBuyExpansion")
        or f8("Toggle_Shop_PlotUpgradeAutoBuyRollLuck")
        or f8("Toggle_Shop_PlotUpgradeAutoBuyRollPodiums")
    end

    while not v6.Unloaded and f96() do
      local v641, v642 = pcall(function()
        f46()
        local playerDataComplete = v15.PlayerDataComplete and v12 and f48()
        local v643 = f6()
        local plotSave = v643 and v643.PlotSave
        local v644 = f16()
        local plotUpgradeSign = v644 and v644:FindFirstChild("PlotUpgradeSign")

        if not plotSave and not plotUpgradeSign then
          return
        end

        local v645 = f19()

        local v646 = {
          {
            Name = "Expansion",
            Enabled = v15.ShopPlotUpgradeAutoBuyExpansion
              or f8("Toggle_Shop_PlotUpgradeAutoBuyExpansion"),
            DisplayName = "Farm Expansion",
          },
          {
            Name = "RollLuck",
            Enabled = v15.ShopPlotUpgradeAutoBuyRollLuck
              or f8("Toggle_Shop_PlotUpgradeAutoBuyRollLuck"),
            DisplayName = "Roll Luck",
          },
          {
            Name = "RollPodiums",
            Enabled = v15.ShopPlotUpgradeAutoBuyRollPodiums
              or f8("Toggle_Shop_PlotUpgradeAutoBuyRollPodiums"),
            DisplayName = "Roll Podiums",
          },
        }

        local v647 = nil

        if not playerDataComplete then
          pcall(function() v647 = v26.ReadPlotUpgradeSign() end)
        end

        for index102, value150 in ipairs(v646) do
          if not f96() or v6.Unloaded then
            break
          end

          if value150.Enabled then
            local getAttribute = plotUpgradeSign and plotUpgradeSign:GetAttribute(value150.Name)

            local value151 = plotSave and plotSave[value150.Name] or getAttribute
              or v647 and v647[value150.Name] and v647[value150.Name].Value or 1

            if value151 <= 0 then
              value151 = 1
            end

            local price8 = nil
            local nextValue2 = value151 + 1
            local v648 = false

            if playerDataComplete and v12.GetPlotUpgrade then
              local v649, v650 = pcall(v12.GetPlotUpgrade, value150.Name, value151 + 1)

              if v649 and v650 and v650.Price and v650.Price > 0 then
                price8 = v650.Price
                nextValue2 = value151 + 1
              elseif v649 and v650 == nil then
                v648 = true

                if not v15["LoggedMaxPlotUpg_" .. value150.Name] then
                  v15["LoggedMaxPlotUpg_" .. value150.Name] = true
                end
              end
            end

            if not v648 and (not price8 or price8 <= 0) then
              if not v647 then
                pcall(function() v647 = v26.ReadPlotUpgradeSign() end)
              end

              local v651 = v647 and v647[value150.Name]

              if v651 and v651.Max then
                v648 = true

                if not v15["LoggedMaxPlotUpg_" .. value150.Name] then
                  v15["LoggedMaxPlotUpg_" .. value150.Name] = true
                end
              elseif v651 and v651.Price and v651.Price > 0 then
                price8 = v651.Price
                nextValue2 = v651.NextValue or value151 + 1
              end
            end

            if not v648 and (not price8 or price8 <= 0) then
              local plot2 = f7("Plot")

              if plot2 and plot2.PlotUpgrades and plot2.PlotUpgrades[value150.Name] then
                local v652 = plot2.PlotUpgrades[value150.Name]

                if type(v652) == "function" then
                  local v653, v654 = pcall(v652, value151 + 1)

                  if v653 and v654 and v654.Price and v654.Price > 0 then
                    price8 = v654.Price
                    nextValue2 = value151 + 1
                  elseif v653 and v654 == nil then
                    v648 = true

                    if not v15["LoggedMaxPlotUpg_" .. value150.Name] then
                      v15["LoggedMaxPlotUpg_" .. value150.Name] = true
                    end
                  end
                end
              end
            end

            if v648 then
            elseif not price8 or price8 <= 0 then
              if not v15["LoggedNoPricePlotUpg_" .. value150.Name] then
                v15["LoggedNoPricePlotUpg_" .. value150.Name] = true
              end
            elseif v645 < price8 then
              if not v15["LoggedNoCashPlotUpg_" .. value150.Name] then
                v15["LoggedNoCashPlotUpg_" .. value150.Name] = true
              end
            else
              v15["LoggedNoCashPlotUpg_" .. value150.Name] = nil
              v15["LoggedMaxPlotUpg_" .. value150.Name] = nil

              if v23.FireServer("BuyNextPlotUpgrade", value150.Name) then
                v645 = v645 - price8

                if nextValue2 then
                  v22.Shop(string.format(
                    "Upgraded %s to Lv.%d ($%s)", value150.DisplayName, nextValue2,
                    v24.Number(price8)
                  ), 4)
                else
                  v22.Shop(string.format(
                    "Upgraded %s ($%s)", value150.DisplayName, v24.Number(price8)
                  ), 4)
                end

                v26.Invalidate("PlotSave")
                task.wait(0.3)
                local v655 = f19()

                if v655 < v645 then
                  v645 = v655
                end
              end
            end
          end
        end
      end)

      local total20 = 0

      while not v6.Unloaded and total20 < 5 do
        if not f96() then
          break
        end

        task.wait(0.5)
        total20 = total20 + 0.5
      end
    end

    v15.IsAutoBuyPlotUpgradesLoopRunning = false
  end)
end

local function f97()
  if v15.IsAutoBuyPlotBuildingsLoopRunning then
    return
  end

  v15.IsAutoBuyPlotBuildingsLoopRunning = true

  task.spawn(function()
    local function f98()
      if v14.PlotBuildings then
        for key60 in pairs(v14.PlotBuildings) do
          if f8("Toggle_Shop_PlotBuildingAutoUpgrade" .. key60)
            or v15["ShopPlotBuildingAutoUpgrade" .. key60] then
            return true
          end
        end
      end

      return f8("Toggle_Shop_PlotBuildingAutoUpgradePetBarn")
        or f8("Toggle_Shop_PlotBuildingAutoUpgradeTradingPost")
        or f8("Toggle_Shop_PlotBuildingAutoUpgradeComposter")
        or f8("Toggle_Shop_PlotBuildingAutoUpgradeBeeHive")
        or f8("Toggle_Shop_PlotBuildingAutoUpgradeAquarium")
    end

    while not v6.Unloaded and f98() do
      local v656, v657 = pcall(function()
        f46()
        local v658 = f6()
        local plotSave2 = v658 and v658.PlotSave or v26.Get("PlotSave")
        local v659 = v26.ReadPlotBuildingSigns() or {}
        local v660 = f15() or f16()
        local buildings7 = v660 and v660:FindFirstChild("Buildings")
        local v661 = {}

        if plotSave2 and type(plotSave2.Buildings) == "table" then
          for key61, value152 in pairs(plotSave2.Buildings) do
            v661[key61] = tonumber(value152) or 0
          end
        end

        for key62, value153 in pairs(v659) do
          v661[key62] = math.max(v661[key62] or 0, value153.CurrentLevel or 0)
        end

        if buildings7 then
          for index103, value154 in ipairs(buildings7:GetChildren()) do
            local v662 = tonumber(value154:GetAttribute("Level")) or 1
            v661[value154.Name] = math.max(v661[value154.Name] or 0, v662)
          end
        end

        if not plotSave2 and not buildings7 and not next(v659) then
          return
        end

        local v663 = f19()
        local cashPerMin2 = v658 and v658.CashPerMin or f20() or 0
        local plotBuildings = v14.PlotBuildings or {}
        local v664 = {}

        for key63, value155 in pairs(plotBuildings) do
          table.insert(v664, {
            Name = key63,
            Index = value155.Index or 99,
            DisplayName = value155.DisplayName or key63,
            Enabled = f8("Toggle_Shop_PlotBuildingAutoUpgrade" .. key63)
              or v15["ShopPlotBuildingAutoUpgrade" .. key63],
          })
        end

        table.sort(v664, function(p204, p205) return p204.Index < p205.Index end)

        for index104, value156 in ipairs(v664) do
          if not f98() or v6.Unloaded then
            break
          end

          if value156.Enabled then
            local v665 = plotBuildings[value156.Name]
            local v666 = v659[value156.Name]
            local currentLevel = v661[value156.Name] or v666 and v666.CurrentLevel or 0

            if currentLevel
                >= (v665 and (v665.MaxUpgrade or v665.UpgradePrices and #v665.UpgradePrices) or 1)
              or v666 and v666.Max then
              if not v15["LoggedMaxBuilding_" .. value156.Name] then
                v15["LoggedMaxBuilding_" .. value156.Name] = true
              end
            else
              local v667 = currentLevel + 1

              local price9 = v666 and v666.Price and v666.Price > 0 and v666.Price
                or v665 and v665.UpgradePrices and v665.UpgradePrices[v667]

              local canBuy = false

              if v666 and v666.CanBuy ~= nil then
                canBuy = v666.CanBuy and v663 >= (price9 or 0)
              else
                local v668 = true

                if v12 and f48() and v12.CanPlotBuildingBeUnlocked then
                  v668 = v12.CanPlotBuildingBeUnlocked(value156.Name, v658)
                elseif v665 and v665.UnlockRequirement then
                  for key64, value157 in pairs(v665.UnlockRequirement) do
                    if (v661[key64] or 0) < value157 then
                      v668 = false
                      break
                    end
                  end
                end

                local v669 = true

                if v668 then
                  local cashRequirement = 0

                  if v12 and v12.GetPlotBuildingCashRequirement then
                    cashRequirement = v12.GetPlotBuildingCashRequirement(value156.Name, v667)
                  elseif v665 and v665.CashRequirement then
                    if type(v665.CashRequirement) == "number" then
                      cashRequirement = v665.CashRequirement
                    else
                      cashRequirement = v665.CashRequirement[math.clamp(v667, 1, #v665.CashRequirement)]
                        or 0
                    end
                  end

                  v669 = cashPerMin2 >= cashRequirement
                end

                canBuy = v668 and v669 and price9 and price9 > 0 and v663 >= price9
              end

              if canBuy then
                if v23.FireServer("UpgradePlotBuilding", value156.Name) then
                  v661[value156.Name] = v667
                  v15["LoggedMaxBuilding_" .. value156.Name] = nil

                  if price9 then
                    v663 = v663 - price9
                  end

                  v22.Shop(string.format(
                    "Upgraded %s to Lv.%d ($%s)", value156.DisplayName, v667,
                    v24.Number(price9 or 0)
                  ), 4)

                  v26.Invalidate("PlotSave")
                  task.wait(0.3)
                  local v670 = f19()

                  if v670 < v663 then
                    v663 = v670
                  end
                end
              end
            end
          end
        end
      end)

      local total21 = 0

      while not v6.Unloaded and total21 < 5 do
        if not f98() then
          break
        end

        task.wait(0.5)
        total21 = total21 + 0.5
      end
    end

    v15.IsAutoBuyPlotBuildingsLoopRunning = false
  end)
end

local function f99()
  if v15.IsPlayerDataBackfillLoopRunning then
    return
  end

  v15.IsPlayerDataBackfillLoopRunning = true

  task.spawn(function()
    local count14 = 0

    while not v6.Unloaded do
      if not v15.PlayerDataComplete then
        pcall(f37)
        count14 = count14 + 1

        if count14 >= 5 then
          break
        end
      else
        break
      end

      task.wait(1)
    end

    v15.IsPlayerDataBackfillLoopRunning = false
  end)
end

local function f100()
  if v15.IsUpdateShopParagraphsLoopRunning then
    return
  end

  v15.IsUpdateShopParagraphsLoopRunning = true

  local function f101()
    if not v18.GearShopInfo then
      return
    end

    if f10() then
      f11(v18.GearShopInfo)
      return
    end

    local getServerTimeNow5 = workspace:GetServerTimeNow()
    local restockTime = v14.GearShop and v14.GearShop.RestockTime or 300

    local v671 = math.max(0, math.ceil(getServerTimeNow5 / restockTime) * restockTime + 1
      - getServerTimeNow5)

    local gearShopStock3 = workspace:GetAttribute("GearShopStock")
    local jsonDecode3 = nil

    if gearShopStock3 and gearShopStock3 ~= "" then
      f43(gearShopStock3)
      pcall(function() jsonDecode3 = httpService:JSONDecode(gearShopStock3) end)
    end

    local gearShopItems3 = v14.GearShopItems or {}
    local v672 = {}

    if jsonDecode3 and type(jsonDecode3) == "table" then
      for index105, value158 in ipairs(gearShopItems3) do
        local v673 = tonumber(jsonDecode3[tostring(value158.Index)]
            or jsonDecode3[value158.Index])
          or 0

        local v674 = f44(value158.Index)
        local v675 = math.max(0, v673 - v674)

        if v675 > 0 then
          table.insert(v672, string.format(
            "- %s: <font color=\"#00E676\">x%d</font> ($%s)", value158.Name, v675,
            v24.Number(value158.ShopPrice)
          ))
        end
      end
    end

    local v676 = #v672 > 0 and table.concat(v672, "\n")
      or "<font color=\"#FF5252\">Out of stock</font>"

    local v677 = string.format([[
- Restocks In: <font color="#00E676">%s</font>
- Items In Stock (%d):
%s]], v24.Clock(v671), #v672, v676)

    f11(v18.GearShopInfo, v677)
  end

  task.spawn(function()
    while not v6.Unloaded do
      pcall(f101)
      task.wait(5)
    end

    v15.IsUpdateShopParagraphsLoopRunning = false
  end)
end

local function f102()
  if v15.IsAutoPlantPotLoopRunning then
    return
  end

  v15.IsAutoPlantPotLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.FloorManagerHonorPotAutoSetBestPlant
        or f8("Toggle_FloorManager_HonorPotAutoSetBestPlant")) do
      local v678 = false

      repeat
        if v15.IsPlantRemovalActive then
          task.wait(1)
          v678 = true
          break
        end

        pcall(function()
          local v679 = f6()

          if not v679 then
            return
          end

          local v680 = f46()
          table.clear(v16.PlantedSeedsBuffer)
          local plantedSeedsBuffer = v16.PlantedSeedsBuffer

          if v680 and v680.GetPlantedSeeds then
            local v681, v682 = pcall(v680.GetPlantedSeeds, v679)

            if v681 and type(v682) == "table" then
              plantedSeedsBuffer = v682
            end
          end

          if not next(plantedSeedsBuffer) then
            for key65, value159 in pairs(f38("PlotSave", "UnlockedFloors") or {}) do
              for key66, value160 in pairs(value159.Tiles or {}) do
                if type(value160) == "table" and value160.SeedName then
                  plantedSeedsBuffer[value160.SeedName] = true
                end
              end
            end
          end

          if not next(plantedSeedsBuffer) then
            local v683 = f16()
            local farmFloors6 = v683 and v683:FindFirstChild("FarmFloors")

            if farmFloors6 then
              for index106, value161 in ipairs(farmFloors6:GetChildren()) do
                for index107, value162 in ipairs(value161:GetChildren()) do
                  local seedName5 = value162:GetAttribute("SeedName")

                  if seedName5 and seedName5 ~= "" then
                    plantedSeedsBuffer[seedName5] = true
                  end
                end
              end
            end
          end

          local v684 = nil
          local v685 = -1

          for key67 in pairs(plantedSeedsBuffer) do
            local v686 = 0

            if v680 and v680.GetBestPlantedCashPerMinute and v679 and next(v679) ~= nil then
              local v687, v688 = pcall(v680.GetBestPlantedCashPerMinute, v679, key67)

              if v687 and type(v688) == "number" then
                v686 = v688
              end
            end

            if v686 <= 0 then
              v686 = tonumber(f52(key67)) or 0
            end

            if v686 > v685 then
              v685 = v686
              v684 = key67
            end
          end

          if v684 then
            local v689 = f16()
            local plantPot2 = v689 and v689:FindFirstChild("PlantPot")
            local seedName6 = plantPot2 and plantPot2:GetAttribute("SeedName")

            if not seedName6 or seedName6 == "" then
              local v690 = f38("PlotSave", "PlantPot")
              seedName6 = v690 and v690.SeedName
            end

            if seedName6 ~= v684 and plantPot2 then
              local character7 = localPlayer.Character

              local humanoidRootPart6 = character7
                and character7:FindFirstChild("HumanoidRootPart")

              local cframe2 = humanoidRootPart6 and humanoidRootPart6.CFrame
              local position3 = plantPot2:GetPivot().Position

              if humanoidRootPart6 and (humanoidRootPart6.Position - position3).Magnitude > 12 then
                humanoidRootPart6.CFrame = plantPot2:GetPivot() + Vector3.new(0, 3, 0)
                task.wait(0.2)
              end

              if v23.FireServer("SetPlantPot", v684) then
                task.wait(0.5)
                local seedName7 = plantPot2:GetAttribute("SeedName")

                if not seedName7 or seedName7 == "" then
                  local v691 = f38("PlotSave", "PlantPot")
                  seedName7 = v691 and v691.SeedName
                end

                if seedName7 == v684 and v15.LastNotifiedHonorPotSeed ~= v684 then
                  v15.LastNotifiedHonorPotSeed = v684
                  local v692 = f45(v684)

                  v22.FloorManager(string.format(
                    "Set Honor Pot to %s ($%s/min)", v692 or "Best Plant", v24.Number(v685)
                  ), 4)
                end

                v26.Invalidate("PlotSave")
                v16.LatestFarmPlots = nil
              end

              if cframe2 and humanoidRootPart6
                and (humanoidRootPart6.Position - cframe2.Position).Magnitude > 5 then
                humanoidRootPart6.CFrame = cframe2
              end
            end
          end
        end)

        task.wait(10)
        v678 = true
      until true

      if not v678 then
        break
      end
    end

    v15.IsAutoPlantPotLoopRunning = false
  end)
end

local function f103()
  if v15.IsAutoPlantLoopRunning then
    return
  end

  v15.IsAutoPlantLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v693 = false

      repeat
        if v15.IsPlantRemovalActive then
          task.wait(1)
          v693 = true
          break
        end

        local v694 = false
        local count15 = 0
        local v695 = {}
        local floor = 1

        local v696, v697 = pcall(function()
          local floorManagerAutoPlantBestAllFloors = v15.FloorManagerAutoPlantBestAllFloors

          if floorManagerAutoPlantBestAllFloors == nil then
            floorManagerAutoPlantBestAllFloors = f8("Toggle_FloorManager_AutoPlantBestAllFloors")
          end

          local v698 = f59()
          local v699 = f60()

          if floorManagerAutoPlantBestAllFloors then
            v694 = true

            if next(v698) ~= nil then
              local floorManagerAutoPlantTargetFloors3 = v15.FloorManagerAutoPlantTargetFloors
                or f8("Dropdown_FloorManager_AutoPlantTargetFloors")

              local v700 = {}

              for i17 = 1, v699 do
                local v701 = "Floor " .. i17
                local v702 = true

                if type(floorManagerAutoPlantTargetFloors3) == "table"
                  and next(floorManagerAutoPlantTargetFloors3) ~= nil then
                  v702 = floorManagerAutoPlantTargetFloors3[v701] == true
                    or f50(floorManagerAutoPlantTargetFloors3, v701)
                end

                if v702 then
                  local v703 = f64(i17)

                  if v703 and v703.IsUnlocked and v703.EmptyTiles then
                    for index108, value163 in ipairs(v703.EmptyTiles) do
                      table.insert(v700, { Floor = i17, Tile = value163.TileIndex })
                    end
                  end
                end
              end

              if #v700 > 0 then
                table.sort(v700, function(p206, p207)
                  local v704 = math.ceil(p206.Tile / 10)
                  local v705 = math.ceil(p207.Tile / 10)

                  if v704 ~= v705 then
                    return v704 > v705
                  end

                  if p206.Floor ~= p207.Floor then
                    return p206.Floor > p207.Floor
                  end

                  return p206.Tile > p207.Tile
                end)

                local floorManagerAutoPlantIgnoreMutation2 = v15.FloorManagerAutoPlantIgnoreMutation

                if floorManagerAutoPlantIgnoreMutation2 == nil then
                  floorManagerAutoPlantIgnoreMutation2 = f8("Toggle_FloorManager_AutoPlantIgnoreMutation")
                end

                for index109, value164 in ipairs(v700) do
                  if v6.Unloaded or v15.IsPlantRemovalActive then
                    break
                  end

                  local floorManagerAutoPlantBestAllFloors2 = v15.FloorManagerAutoPlantBestAllFloors

                  if floorManagerAutoPlantBestAllFloors2 == nil then
                    floorManagerAutoPlantBestAllFloors2 = f8("Toggle_FloorManager_AutoPlantBestAllFloors")
                  end

                  if not floorManagerAutoPlantBestAllFloors2 then
                    break
                  end

                  local v706 = nil
                  local v707 = -1

                  for key68, value165 in pairs(v698) do
                    if value165 > 0 then
                      local v708 = tonumber(f52(
                        key68, value164.Floor, floorManagerAutoPlantIgnoreMutation2
                      )) or 0

                      local v709 = f45(key68)
                      local plants7 = v709 and v14.Plants and v14.Plants[v709]

                      local v710 = (plants7 and plants7.Rarity and v14.RarityOrderMap
                              and v14.RarityOrderMap[plants7.Rarity]
                            or 1)
                          * 100000000000000
                        + v708

                      if v710 > v707 then
                        v707 = v710
                        v706 = key68
                      end
                    end
                  end

                  if v706 then
                    local v711 = f45(v706) or "Unknown"

                    if v23.FireServer("PlantSeed", v706, value164.Floor, value164.Tile) then
                      v698[v706] = v698[v706] - 1
                      count15 = count15 + 1
                      floor = value164.Floor
                      v695[v711] = (v695[v711] or 0) + 1
                      task.wait(0.25)
                    end
                  else
                    break
                  end
                end
              end
            end
          else
            for i18 = v699, 1, -1 do
              if v15.IsPlantRemovalActive then
                break
              end

              local v712 = v15["FloorManagerF" .. i18 .. "AutoPlantTargetSeeds"]

              if v712 == nil then
                v712 = f8("Toggle_FloorManager_F" .. i18 .. "AutoPlantTargetSeeds")
              end

              local v713 = v15["FloorManagerF" .. i18 .. "AutoPlantTargetRarities"]

              if v713 == nil then
                v713 = f8("Toggle_FloorManager_F" .. i18 .. "AutoPlantTargetRarities")
              end

              if v712 or v713 then
                v694 = true
                local v714 = f64(i18)
                local v715 = {}

                for index110, value166 in ipairs(v714.EmptyTiles) do
                  table.insert(v715, value166.TileIndex)
                end

                if #v715 > 0 and next(v698) ~= nil then
                  table.sort(v715, function(p208, p209)
                    local v716 = math.ceil(p208 / 10)
                    local v717 = math.ceil(p209 / 10)

                    if v716 ~= v717 then
                      return v716 > v717
                    end

                    return p208 > p209
                  end)

                  local v718 = v712
                    and (f8("Dropdown_FloorManager_F" .. i18 .. "TargetSeeds") or {})

                  local v719 = v713
                    and (f8("Dropdown_FloorManager_F" .. i18 .. "TargetRarities") or {})

                  for index111, value167 in ipairs(v715) do
                    if v6.Unloaded or v15.IsPlantRemovalActive then
                      break
                    end

                    local v720 = v15["FloorManagerF" .. i18 .. "AutoPlantTargetSeeds"]

                    if v720 == nil then
                      v720 = f8("Toggle_FloorManager_F" .. i18 .. "AutoPlantTargetSeeds")
                    end

                    local v721 = v15["FloorManagerF" .. i18 .. "AutoPlantTargetRarities"]

                    if v721 == nil then
                      v721 = f8("Toggle_FloorManager_F" .. i18 .. "AutoPlantTargetRarities")
                    end

                    if not (v720 or v721) then
                      break
                    end

                    local v722 = nil
                    local v723 = -1

                    for key69, value168 in pairs(v698) do
                      if value168 > 0 then
                        local v724 = f45(key69)
                        local v725 = false

                        if v720 then
                          if v724 and (v718[v724] == true or f50(v718, v724)) then
                            v725 = true
                          end
                        elseif v721 then
                          local rarity4 = v724 and v14.Plants and v14.Plants[v724]
                            and v14.Plants[v724].Rarity

                          if rarity4 and (v719[rarity4] == true or f50(v719, rarity4)) then
                            v725 = true
                          end
                        end

                        if v725 then
                          local v726 = tonumber(f52(key69, i18)) or 0

                          if v726 > v723 then
                            v723 = v726
                            v722 = key69
                          end
                        end
                      end
                    end

                    if v722 then
                      local v727 = f45(v722) or "Unknown"

                      if v23.FireServer("PlantSeed", v722, i18, value167) then
                        v698[v722] = v698[v722] - 1
                        count15 = count15 + 1
                        floor = i18
                        v695[v727] = (v695[v727] or 0) + 1
                        task.wait(0.25)
                      end
                    else
                      break
                    end
                  end
                end
              end
            end
          end

          if count15 > 0 and v16.FloorPlotInfoCache then
            table.clear(v16.FloorPlotInfoCache)
          end

          if count15 == 1 then
            local v728 = next(v695) or "Seed"
            v22.FloorManager(string.format("Planted %s on Floor %d", v728, floor), 3)
          elseif count15 > 1 then
            local v729 = {}

            for key70, value169 in pairs(v695) do
              table.insert(v729, string.format("%dx %s", value169, key70))
            end

            v22.FloorManager(string.format(
              "Planted %d seeds: %s", count15, table.concat(v729, ", ")
            ), 3)
          end
        end)

        if not v694 then
          break
        end

        task.wait(2)
        v693 = true
      until true

      if not v693 then
        break
      end
    end

    v15.IsAutoPlantLoopRunning = false
  end)
end

local function f104()
  if v15.IsAutoTrowelLoopRunning then
    return
  end

  v15.IsAutoTrowelLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v730 = false

      local v731, v732 = pcall(function()
        for i19 = 1, f60() do
          local v733 = v15["FloorManagerF" .. i19 .. "AutoTrowel"]

          if v733 == nil then
            v733 = f8("Toggle_FloorManager_F" .. i19 .. "AutoTrowel")
          end

          if v733 then
            v730 = true
            local v734 = f8("Dropdown_FloorManager_F" .. i19 .. "RemovalRarities") or {}

            if next(v734) ~= nil then
              local v735 = f64(i19)

              if v735.IsUnlocked and #v735.PlantedTiles > 0 then
                local v736 = {}

                for index112, value170 in ipairs(v735.PlantedTiles) do
                  local rarity5 = value170.Rarity
                    or value170.PlantName and v14.Plants and v14.Plants[value170.PlantName]
                      and v14.Plants[value170.PlantName].Rarity

                  if rarity5 and (v734[rarity5] == true or f50(v734, rarity5)) then
                    table.insert(v736, value170)
                  end
                end

                if #v736 > 0 then
                  table.sort(v736, function(p210, p211)
                    return (p210.CashPerMinute or 0) > (p211.CashPerMinute or 0)
                  end)

                  local v737, v738 = f56("Trowel")

                  if v738 > 0 then
                    local v739 = math.min(#v736, v738)
                    local count16 = 0
                    f85(true)

                    local v740, v741 = pcall(function()
                      for i20 = 1, v739 do
                        if v6.Unloaded then
                          break
                        end

                        local v742 = v15["FloorManagerF" .. i19 .. "AutoTrowel"]

                        if v742 == nil then
                          v742 = f8("Toggle_FloorManager_F" .. i19 .. "AutoTrowel")
                        end

                        if not v742 then
                          break
                        end

                        local tileIndex = v736[i20].TileIndex
                        local v743 = f57(v737)

                        if not v743 then
                          break
                        end

                        if v23.FireServer("ActivateGearOnTile", v743, i19, tileIndex) then
                          count16 = count16 + 1
                          task.wait(0.25)
                        end
                      end
                    end)

                    f85(false)

                    if not v740 then
                      log("StartAutoTrowelLoop removal failed: %s", tostring(v741))
                    end

                    local v744 = #v736 - count16

                    if count16 > 0 then
                      local v745

                      if v744 > 0 then
                        v745 = string.format(
                          "Floor %d: Troweled %d plants (%d remaining - out of Trowels)", i19,
                          count16, v744
                        )
                      else
                        v745 = string.format(
                          "Floor %d: Successfully troweled %d plants (recovered seeds)", i19,
                          count16
                        )
                      end

                      v22.FloorManager(v745, 4)
                    end
                  end
                end
              end
            end
          end
        end
      end)

      if not v730 then
        break
      end

      task.wait(2.5)
    end

    v15.IsAutoTrowelLoopRunning = false
  end)
end

local function f105()
  if v15.IsAutoWaterLoopRunning then
    return
  end

  v15.IsAutoWaterLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v746 = false

      local v747, v748 = pcall(function()
        local v749 = f60()
        local v750 = {}

        for i21 = v749, 1, -1 do
          local v751 = v15["FloorManagerF" .. i21 .. "AutoWater"]

          if v751 == nil then
            v751 = f8("Toggle_FloorManager_F" .. i21 .. "AutoWater")
          end

          if v751 then
            v746 = true
            local v752 = f64(i21)

            if v752.IsUnlocked and #v752.PlantedTiles > 0 then
              for index113, value171 in ipairs(v752.PlantedTiles) do
                if value171.CanWater then
                  table.insert(v750, {
                    Floor = i21,
                    Tile = value171.TileIndex,
                    Name = value171.PlantName,
                    Income = value171.CashPerMinute or 0,
                  })
                end
              end
            end
          end
        end

        if #v750 > 0 then
          table.sort(v750, function(p212, p213)
            return (p212.Income or 0) > (p213.Income or 0)
          end)

          local superWateringCan = f56("Super Watering Can")
          local wateringCan = f56("Watering Can")

          for index114, value172 in ipairs(v750) do
            if v6.Unloaded then
              break
            end

            local v753 = v15["FloorManagerF" .. value172.Floor .. "AutoWater"]

            if v753 == nil then
              v753 = f8("Toggle_FloorManager_F" .. value172.Floor .. "AutoWater")
            end

            if v753 then
              local v754 = f57(superWateringCan) or f57(wateringCan)

              if not v754 then
                break
              end

              if v23.FireServer("ActivateGearOnTile", v754, value172.Floor, value172.Tile) then
                task.wait(0.25)
              end
            end
          end
        end
      end)

      if not v746 then
        break
      end

      task.wait(2)
    end

    v15.IsAutoWaterLoopRunning = false
  end)
end

local function f106()
  if v15.IsAutoFertilizeLoopRunning then
    return
  end

  v15.IsAutoFertilizeLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v755 = false

      local v756, v757 = pcall(function()
        local v758 = f60()
        local v759 = {}

        for i22 = v758, 1, -1 do
          local v760 = v15["FloorManagerF" .. i22 .. "AutoFertilize"]

          if v760 == nil then
            v760 = f8("Toggle_FloorManager_F" .. i22 .. "AutoFertilize")
          end

          if v760 then
            v755 = true
            local v761 = f8("Dropdown_FloorManager_F" .. i22 .. "FertilizePlants") or {}

            if next(v761) ~= nil then
              local v762 = f64(i22)

              if v762.IsUnlocked and #v762.PlantedTiles > 0 then
                local v763 = f8("Dropdown_FloorManager_F" .. i22 .. "FertilizerTypes") or {}
                local v764 = {}

                if type(v763) == "table" then
                  for key71, value173 in pairs(v763) do
                    if value173 == true
                      or type(key71) == "number" and type(value173) == "string" then
                      table.insert(v764, type(key71) == "number" and value173 or key71)
                    end
                  end
                elseif type(v763) == "string" and v763 ~= "" then
                  table.insert(v764, v763)
                end

                if #v764 == 0 then
                  v764 = table.clone(v14.FertilizerNames or {})
                end

                for index115, value174 in ipairs(v762.PlantedTiles) do
                  if v761[value174.PlantName] == true or f50(v761, value174.PlantName) then
                    if not value174.HasFertilizer
                      or value174.FertilizerTimeLeft and value174.FertilizerTimeLeft <= 10 then
                      table.insert(v759, {
                        Floor = i22,
                        Tile = value174.TileIndex,
                        Name = value174.PlantName,
                        Income = value174.CashPerMinute or 0,
                        FertList = v764,
                      })
                    end
                  end
                end
              end
            end
          end
        end

        if #v759 > 0 then
          table.sort(v759, function(p214, p215)
            return (p214.Income or 0) > (p215.Income or 0)
          end)

          local function f107(p216)
            local fertilizerNames = v14.FertilizerNames

            if fertilizerNames then
              for i23 = #fertilizerNames, 1, -1 do
                local v765 = fertilizerNames[i23]

                for index116, value175 in ipairs(p216) do
                  if value175 == v765 then
                    local v766 = f57((f56(value175)))

                    if v766 then
                      return value175, v766
                    end
                  end
                end
              end
            end

            for index117, value176 in ipairs(p216) do
              local v767 = f57((f56(value176)))

              if v767 then
                return value176, v767
              end
            end

            return nil, nil
          end

          local count17 = 0

          for index118, value177 in ipairs(v759) do
            if v6.Unloaded then
              break
            end

            local v768 = v15["FloorManagerF" .. value177.Floor .. "AutoFertilize"]

            if v768 == nil then
              v768 = f8("Toggle_FloorManager_F" .. value177.Floor .. "AutoFertilize")
            end

            if v768 then
              local v769, v770 = f107(value177.FertList)

              if not v770 then
                break
              end

              if v23.FireServer("ActivateGearOnTile", v770, value177.Floor, value177.Tile) then
                count17 = count17 + 1
                task.wait(0.25)
              end
            end
          end

          if count17 > 0 then
            v22.FloorManager(string.format("Fertilized %d plant(s) across farm", count17), 3)
          end
        end
      end)

      if not v755 then
        break
      end

      task.wait(2.5)
    end

    v15.IsAutoFertilizeLoopRunning = false
  end)
end

local function f108()
  if v15.IsAutoSprayLoopRunning then
    return
  end

  v15.IsAutoSprayLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v771 = false

      local v772, v773 = pcall(function()
        for i24 = 1, f60() do
          local v774 = v15["FloorManagerF" .. i24 .. "AutoSpray"]

          if v774 == nil then
            v774 = f8("Toggle_FloorManager_F" .. i24 .. "AutoSpray")
          end

          if v774 then
            v771 = true
            local v775 = f8("Dropdown_FloorManager_F" .. i24 .. "SprayType") or {}
            local v776 = f8("Dropdown_FloorManager_F" .. i24 .. "SprayPlants") or {}
            local v777 = {}

            if type(v775) == "table" then
              for key72, value178 in pairs(v775) do
                if value178 == true or type(key72) == "number" and type(value178) == "string" then
                  table.insert(v777, type(key72) == "number" and value178 or key72)
                end
              end
            elseif type(v775) == "string" and v775 ~= "" then
              table.insert(v777, v775)
            end

            if #v777 > 0 and next(v776) ~= nil then
              local v778 = f64(i24)

              if v778.IsUnlocked and #v778.PlantedTiles > 0 then
                local v779 = v16["SprayRotIndex_F" .. i24] or 1
                local count18 = 0

                for index119, value179 in ipairs(v778.PlantedTiles) do
                  if v6.Unloaded then
                    break
                  end

                  local v780 = v15["FloorManagerF" .. i24 .. "AutoSpray"]

                  if v780 == nil then
                    v780 = f8("Toggle_FloorManager_F" .. i24 .. "AutoSpray")
                  end

                  if not v780 then
                    break
                  end

                  if (v776[value179.PlantName] == true or f50(v776, value179.PlantName))
                    and not value179.IsMutated then
                    local v781 = nil

                    for i25 = 0, #v777 - 1 do
                      local v782 = (v779 - 1 + i25) % #v777 + 1
                      local v783 = f57((f56(v777[v782])))

                      if v783 then
                        v781 = v783
                        v779 = v782 % #v777 + 1
                        v16["SprayRotIndex_F" .. i24] = v779
                        break
                      end
                    end

                    if not v781 then
                      break
                    end

                    if v23.FireServer("ActivateGearOnTile", v781, i24, value179.TileIndex) then
                      count18 = count18 + 1
                      task.wait(0.2)
                    end
                  end
                end

                if count18 > 0 then
                  v22.FloorManager(
                    string.format("Floor %d: Sprayed %d plant(s)", i24, count18), 3
                  )
                end
              end
            end
          end
        end
      end)

      if not v771 then
        break
      end

      task.wait(2.5)
    end

    v15.IsAutoSprayLoopRunning = false
  end)
end

local function f109()
  if v15.IsAutoAcidSprayLoopRunning then
    return
  end

  v15.IsAutoAcidSprayLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v784 = false

      local v785, v786 = pcall(function()
        for i26 = 1, f60() do
          local v787 = v15["FloorManagerF" .. i26 .. "AutoAcidSpray"]

          if v787 == nil then
            v787 = f8("Toggle_FloorManager_F" .. i26 .. "AutoAcidSpray")
          end

          if v787 then
            v784 = true

            local v788 = f8("Dropdown_FloorManager_F" .. i26 .. "AcidSprayUnwantedMutations")
              or {}

            if next(v788) ~= nil then
              local v789 = f64(i26)

              if v789.IsUnlocked and #v789.PlantedTiles > 0 then
                local count19 = 0

                for index120, value180 in ipairs(v789.PlantedTiles) do
                  if v6.Unloaded then
                    break
                  end

                  local v790 = v15["FloorManagerF" .. i26 .. "AutoAcidSpray"]

                  if v790 == nil then
                    v790 = f8("Toggle_FloorManager_F" .. i26 .. "AutoAcidSpray")
                  end

                  if not v790 then
                    break
                  end

                  if value180.IsMutated
                    and (v788[value180.Mutation] == true or f50(v788, value180.Mutation)) then
                    local v791 = f57((f56("Acid Spray")))

                    if not v791 then
                      break
                    end

                    if v23.FireServer("ActivateGearOnTile", v791, i26, value180.TileIndex) then
                      count19 = count19 + 1
                      task.wait(0.2)
                    end
                  end
                end

                if count19 > 0 then
                  v22.FloorManager(string.format(
                    "Floor %d: Acid sprayed %d plant(s)", i26, count19
                  ), 3)
                end
              end
            end
          end
        end
      end)

      if not v784 then
        break
      end

      task.wait(2.5)
    end

    v15.IsAutoAcidSprayLoopRunning = false
  end)
end

local function f110()
  if v15.IsAutoUnlockTilesLoopRunning then
    return
  end

  v15.IsAutoUnlockTilesLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v792 = false

      local v793, v794 = pcall(function()
        f46()

        if not v12 or not v12.GetTilePrice then
          return
        end

        if not f48() then
          return
        end

        local v795 = f60()
        local v796 = f6()

        if not v796 or not v796.PlotSave or not v796.PlotSave.UnlockedFloors then
          return
        end

        for i27 = 1, v795 do
          local v797 = v15["FloorManagerF" .. i27 .. "AutoUnlockTiles"]

          if v797 == nil then
            v797 = f8("Toggle_FloorManager_F" .. i27 .. "AutoUnlockTiles")
          end

          if v797 then
            v792 = true

            local v798 = v796.PlotSave.UnlockedFloors[i27]
              or v796.PlotSave.UnlockedFloors[tostring(i27)]

            if v798 and v798.Tiles then
              local v799 = f19()
              local count20 = 0

              for i28 = 1, 30 do
                if v6.Unloaded then
                  break
                end

                local v800 = v15["FloorManagerF" .. i27 .. "AutoUnlockTiles"]

                if v800 == nil then
                  v800 = f8("Toggle_FloorManager_F" .. i27 .. "AutoUnlockTiles")
                end

                if not v800 then
                  break
                end

                if not (v798.Tiles[i28] ~= nil or v798.Tiles[tostring(i28)] ~= nil) then
                  local v801 = true

                  if v12.IsTileIndexUnlockable then
                    v801 = v12.IsTileIndexUnlockable(v796, i27, i28)
                  end

                  if v801 then
                    local v802 = v12.GetTilePrice(v796, i27, i28)

                    if v802 and v799 >= v802 then
                      if v23.FireServer("UnlockTile", i27, i28) then
                        count20 = count20 + 1
                        v799 = v799 - v802
                        task.wait(0.2)
                        local v803 = f19()

                        if v803 < v799 then
                          v799 = v803
                        end
                      end
                    end
                  end
                end
              end

              if count20 > 0 then
                if v16.FloorPlotInfoCache then
                  table.clear(v16.FloorPlotInfoCache)
                end

                v22.FloorManager(
                  string.format("Floor %d: Unlocked %d tile(s)", i27, count20), 3
                )
              end
            end
          end
        end
      end)

      if not v792 then
        break
      end

      task.wait(3)
    end

    v15.IsAutoUnlockTilesLoopRunning = false
  end)
end

local function f111()
  if v15.IsAutoUpgradeMachinesLoopRunning then
    return
  end

  v15.IsAutoUpgradeMachinesLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v804 = false

      local v805, v806 = pcall(function()
        f46()
        local playerDataComplete2 = v15.PlayerDataComplete and v12 and f48()
        local v807 = f60()
        local v808 = f6()
        local v809 = f16()

        if not v809 then
          return
        end

        local v810 = nil

        if not playerDataComplete2 then
          pcall(function() v810 = v26.ReadFloorUpgradeSigns() end)
        end

        for i29 = 1, v807 do
          local v811 = v15["FloorManagerF" .. i29 .. "AutoUpgradeSawYield"]

          if v811 == nil then
            v811 = f8("Toggle_FloorManager_F" .. i29 .. "AutoUpgradeSawYield")
          end

          local v812 = v15["FloorManagerF" .. i29 .. "AutoUpgradeSprinkler"]

          if v812 == nil then
            v812 = f8("Toggle_FloorManager_F" .. i29 .. "AutoUpgradeSprinkler")
          end

          local v813 = v15["FloorManagerF" .. i29 .. "AutoUpgradeSawRange"]

          if v813 == nil then
            v813 = f8("Toggle_FloorManager_F" .. i29 .. "AutoUpgradeSawRange")
          end

          local v814 = v15["FloorManagerF" .. i29 .. "AutoUpgradeSprinklerRange"]

          if v814 == nil then
            v814 = f8("Toggle_FloorManager_F" .. i29 .. "AutoUpgradeSprinklerRange")
          end

          if v811 or v812 or v813 or v814 then
            v804 = true

            local unlockedFloors2 = v808
              and v808.PlotSave
              and v808.PlotSave.UnlockedFloors
              and (v808.PlotSave.UnlockedFloors[i29]
                or v808.PlotSave.UnlockedFloors[tostring(i29)])

            local floorUpgradeSign5 = nil

            if i29 == 1 then
              floorUpgradeSign5 = v809:FindFirstChild("FloorUpgradeSign")
            else
              local farmFloors7 = v809:FindFirstChild("FarmFloors")

              local findFirstChild20 = farmFloors7
                and (farmFloors7:FindFirstChild("Floor" .. i29)
                  or farmFloors7:FindFirstChild("Floor " .. i29)
                  or farmFloors7:FindFirstChild(tostring(i29)))

              floorUpgradeSign5 = findFirstChild20
                and findFirstChild20:FindFirstChild("FloorUpgradeSign")
            end

            local v815 = f19()
            local v816 = v810 and v810[i29] or nil

            local function f112(p217)
              local getAttribute2 = unlockedFloors2 and unlockedFloors2[p217]
                or floorUpgradeSign5 and floorUpgradeSign5:GetAttribute(p217)
                or v816 and v816[p217] and v816[p217].Value

              if type(getAttribute2) == "table" then
                getAttribute2 = getAttribute2.Value
              end

              local v817 = tonumber(getAttribute2) or 0

              if playerDataComplete2 and v12.GetFloorUpgrade then
                local v818, v819 = pcall(v12.GetFloorUpgrade, p217, i29, v817 + 1)

                if v818 and v819 and v819.Price and v819.Price > 0 then
                  return v819.Price, false, v817 + 1, v817
                elseif v818 and v819 == nil then
                  return nil, true, nil, v817
                end
              end

              if not v810 then
                pcall(function() v810 = v26.ReadFloorUpgradeSigns() end)
                v816 = v810 and v810[i29]
              end

              local v820 = v816 and v816[p217]

              if v820 and v820.Max then
                return nil, true, nil, v820.Value or v817
              elseif v820 and v820.Price and v820.Price > 0 then
                return v820.Price, false, v820.NextValue or v817 + 1, v817
              end

              local plot3 = f7("Plot")

              if plot3 and plot3.FloorUpgrades and plot3.FloorUpgrades[i29] then
                local v821 = plot3.FloorUpgrades[i29][p217]

                if type(v821) == "function" then
                  local v822, v823 = pcall(v821, v817 + 1)

                  if v822 and v823 and v823.Price then
                    return v823.Price, false, v817 + 1, v817
                  elseif v822 and v823 == nil then
                    return nil, true, nil, v817
                  end
                elseif type(v821) == "table" and v821[v817 + 1] then
                  return v821[v817 + 1].Price, false, v817 + 1, v817
                end
              end

              return nil, false, nil, v817
            end

            if v811 then
              local v824, v825, v826, v827 = f112("SawYield")
              local v828 = "LoggedMaxFloorUpg_" .. i29 .. "_SawYield"
              local v829 = "LoggedNoCashFloorUpg_" .. i29 .. "_SawYield"

              if v825 then
                if not v15[v828] then
                  v15[v828] = true
                end
              elseif not v824 or v824 <= 0 then
              elseif v815 < v824 then
                if not v15[v829] then
                  v15[v829] = true
                end
              else
                v15[v828] = nil
                v15[v829] = nil

                if v23.FireServer("BuyNextFloorUpgrade", i29, "SawYield") then
                  v815 = v815 - v824

                  if v826 then
                    v22.FloorManager(string.format(
                      "Floor %d: Upgraded Saw Yield to Lv.%d ($%s)", i29, v826, v24.Number(v824)
                    ), 3)
                  else
                    v22.FloorManager(string.format(
                      "Floor %d: Upgraded Saw Yield ($%s)", i29, v24.Number(v824)
                    ), 3)
                  end

                  v26.Invalidate("PlotSave")
                  v16.LatestFarmPlots = nil
                  task.wait(0.2)
                end
              end
            end

            if v812 then
              local v830, v831, v832, v833 = f112("SprinklerPower")
              local v834 = "LoggedMaxFloorUpg_" .. i29 .. "_SprinklerPower"
              local v835 = "LoggedNoCashFloorUpg_" .. i29 .. "_SprinklerPower"

              if v831 then
                if not v15[v834] then
                  v15[v834] = true
                end
              elseif not v830 or v830 <= 0 then
              elseif v815 < v830 then
                if not v15[v835] then
                  v15[v835] = true
                end
              else
                v15[v834] = nil
                v15[v835] = nil

                if v23.FireServer("BuyNextFloorUpgrade", i29, "SprinklerPower") then
                  v815 = v815 - v830

                  if v832 then
                    v22.FloorManager(string.format(
                      "Floor %d: Upgraded Sprinkler Power to Lv.%d ($%s)", i29, v832,
                      v24.Number(v830)
                    ), 3)
                  else
                    v22.FloorManager(string.format(
                      "Floor %d: Upgraded Sprinkler Power ($%s)", i29, v24.Number(v830)
                    ), 3)
                  end

                  v26.Invalidate("PlotSave")
                  v16.LatestFarmPlots = nil
                  task.wait(0.2)
                end
              end
            end

            if v813 then
              local sawRange3 = unlockedFloors2 and unlockedFloors2.SawRange
                or floorUpgradeSign5 and floorUpgradeSign5:GetAttribute("SawRange") or 1

              if type(sawRange3) == "table" then
                sawRange3 = sawRange3.Value or 1
              end

              sawRange3 = tonumber(sawRange3) or 1
              local v836, v837, v838, v839 = f112("SawRange")
              local v840 = "LoggedMaxFloorUpg_" .. i29 .. "_SawRange"
              local v841 = "LoggedNoCashFloorUpg_" .. i29 .. "_SawRange"

              if v837 or sawRange3 >= 3 then
                if not v15[v840] then
                  v15[v840] = true
                end
              elseif not v836 or v836 <= 0 then
              elseif v815 < v836 then
                if not v15[v841] then
                  v15[v841] = true
                end
              else
                v15[v840] = nil
                v15[v841] = nil

                if v23.FireServer("BuyNextFloorUpgrade", i29, "SawRange") then
                  v815 = v815 - v836

                  if v838 then
                    v22.FloorManager(string.format(
                      "Floor %d: Upgraded Saw Range to Ring %d ($%s)", i29, v838,
                      v24.Number(v836)
                    ), 3)
                  else
                    v22.FloorManager(string.format(
                      "Floor %d: Upgraded Saw Range ($%s)", i29, v24.Number(v836)
                    ), 3)
                  end

                  v26.Invalidate("PlotSave")
                  v16.LatestFarmPlots = nil
                  task.wait(0.2)
                end
              end
            end

            if v814 then
              local sprinklerRange3 = unlockedFloors2 and unlockedFloors2.SprinklerRange or 1

              if type(sprinklerRange3) == "table" then
                sprinklerRange3 = sprinklerRange3.Value or 1
              end

              sprinklerRange3 = tonumber(sprinklerRange3) or 1
              local v842, v843, v844, v845 = f112("SprinklerRange")
              local v846 = "LoggedMaxFloorUpg_" .. i29 .. "_SprinklerRange"
              local v847 = "LoggedNoCashFloorUpg_" .. i29 .. "_SprinklerRange"

              if v843 or sprinklerRange3 >= 3 then
                if not v15[v846] then
                  v15[v846] = true
                end
              elseif not v842 or v842 <= 0 then
              elseif v815 < v842 then
                if not v15[v847] then
                  v15[v847] = true
                end
              else
                v15[v846] = nil
                v15[v847] = nil

                if v23.FireServer("BuyNextFloorUpgrade", i29, "SprinklerRange") then
                  v15["LoggedMaxFloorUpg_" .. i29 .. "_SprinklerRange"] = nil
                  v815 = v815 - v842

                  if v844 then
                    v22.FloorManager(string.format(
                      "Floor %d: Upgraded Sprinkler Range to Ring %d ($%s)", i29, v844,
                      v24.Number(v842)
                    ), 3)
                  else
                    v22.FloorManager(string.format(
                      "Floor %d: Upgraded Sprinkler Range ($%s)", i29, v24.Number(v842)
                    ), 3)
                  end

                  v26.Invalidate("PlotSave")
                  v16.LatestFarmPlots = nil
                  task.wait(0.2)
                end
              end
            end
          end
        end
      end)

      if not v804 then
        break
      end

      task.wait(3)
    end

    v15.IsAutoUpgradeMachinesLoopRunning = false
  end)
end

local function f113()
  if v15.IsAutoUpgradeConveyorsLoopRunning then
    return
  end

  v15.IsAutoUpgradeConveyorsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v848 = false

      local v849, v850 = pcall(function()
        f46()

        if not v12 then
          return
        end

        local v851 = f60()
        local v852 = f6()
        local v853 = f16()
        local farmFloors8 = v853 and v853:FindFirstChild("FarmFloors")

        for i30 = 1, v851 do
          local v854 = v15["FloorManagerF" .. i30 .. "AutoUpgradeConveyor"]

          if v854 == nil then
            v854 = f8("Toggle_FloorManager_F" .. i30 .. "AutoUpgradeConveyor")
          end

          if v854 then
            v848 = true

            local unlockedFloors3 = v852
              and v852.PlotSave
              and v852.PlotSave.UnlockedFloors
              and (v852.PlotSave.UnlockedFloors[i30]
                or v852.PlotSave.UnlockedFloors[tostring(i30)])

            local findFirstChild21 = farmFloors8 and farmFloors8:FindFirstChild("Floor" .. i30)
            local v855 = f19()
            local v856 = f20()
            local buildings8 = unlockedFloors3 and unlockedFloors3.Buildings or {}

            if not next(buildings8) and findFirstChild21 then
              local buildings9 = findFirstChild21:FindFirstChild("Buildings")

              if buildings9 then
                for index121, value181 in ipairs(buildings9:GetChildren()) do
                  local level6 = value181:GetAttribute("Level") or 1
                  buildings8[value181.Name] = level6
                end
              end
            end

            local floorBuildings = f7("FloorBuildings") or v14 and v14.FloorBuildings

            for index122, value182 in ipairs({ "Upgrader1", "Upgrader2", "Upgrader3" }) do
              if v6.Unloaded then
                break
              end

              local v857 = v15["FloorManagerF" .. i30 .. "AutoUpgradeConveyor"]

              if v857 == nil then
                v857 = f8("Toggle_FloorManager_F" .. i30 .. "AutoUpgradeConveyor")
              end

              if not v857 then
                break
              end

              local v858 = buildings8[value182] or 0
              local v859 = floorBuildings and floorBuildings[value182]

              if v858
                < (v859 and (v859.MaxUpgrade or v859.UpgradePrices and #v859.UpgradePrices) or 1) then
                local v860 = v858 + 1
                local v861 = true

                if v12 and f48() and v12.CanFloorBuildingBeUnlocked then
                  v861 = v12.CanFloorBuildingBeUnlocked(i30, value182, v852)
                elseif v859 and v859.UnlockRequirement then
                  for key73, value183 in pairs(v859.UnlockRequirement) do
                    if (buildings8[key73] or 0) < value183 then
                      v861 = false
                      break
                    end
                  end
                end

                if v861 then
                  local cashRequirement2 = nil

                  if v12 and v12.GetFloorBuildingPrice then
                    local v862, v863 = pcall(v12.GetFloorBuildingPrice, i30, value182, v860)

                    if v862 and type(v863) == "number" then
                      cashRequirement2 = v863
                    end
                  end

                  if not cashRequirement2 and v859 and v859.UpgradePrices then
                    cashRequirement2 = v859.UpgradePrices[v860] or v859.CashRequirement
                  end

                  local cashRequirement3 = 0

                  if v12 and v12.GetFloorBuildingCashRequirement then
                    local v864, v865 = pcall(v12.GetFloorBuildingCashRequirement, i30, value182)

                    if v864 and type(v865) == "number" then
                      cashRequirement3 = v865
                    end
                  elseif v859 and v859.CashRequirement then
                    cashRequirement3 = v859.CashRequirement
                  end

                  if cashRequirement2 and v855 >= cashRequirement2 and v856 >= cashRequirement3 then
                    if v23.FireServer("UpgradeFloorBuilding", i30, value182) then
                      task.wait(0.5)
                      buildings8[value182] = v860
                      v855 = f19()

                      if v858 == 0 then
                        v22.FloorManager(string.format(
                          "Floor %d: Built %s ($%s)", i30, value182,
                          v24.Number(cashRequirement2)
                        ), 3)
                      else
                        v22.FloorManager(string.format(
                          "Floor %d: Upgraded %s to Lv.%d ($%s)", i30, value182, v860,
                          v24.Number(cashRequirement2)
                        ), 3)
                      end

                      v26.Invalidate("PlotSave")
                      v16.LatestFarmPlots = nil
                    end
                  end
                end
              end
            end
          end
        end
      end)

      if not v848 then
        break
      end

      task.wait(3)
    end

    v15.IsAutoUpgradeConveyorsLoopRunning = false
  end)
end

local function f114()
  local v866 = f16()

  if not v866 then
    return
  end

  local v867 = {}
  local floorUpgradeSign6 = v866:FindFirstChild("FloorUpgradeSign")

  if floorUpgradeSign6 then
    table.insert(v867, floorUpgradeSign6)
  end

  local farmFloors9 = v866:FindFirstChild("FarmFloors")

  if farmFloors9 then
    for index123, value184 in ipairs(farmFloors9:GetChildren()) do
      local floorUpgradeSign7 = value184:FindFirstChild("FloorUpgradeSign")

      if floorUpgradeSign7 then
        table.insert(v867, floorUpgradeSign7)
      end
    end
  end

  for index124, value185 in ipairs(v867) do
    local v868 = "FloorUpgradeSign_" .. index124

    if not v17[v868] then
      v17[v868] = value185.AttributeChanged:Connect(function()
        v26.Invalidate("PlotSave")
        v16.LatestFarmPlots = nil
      end)
    end
  end

  local plantPot3 = v866:FindFirstChild("PlantPot")

  if plantPot3 and not v17.PlantPotChanged then
    v17.PlantPotChanged = plantPot3.AttributeChanged:Connect(function()
      v26.Invalidate("PlotSave")
      v16.LatestFarmPlots = nil
    end)
  end
end

local function f115()
  if v15.IsUpdateFloorParagraphsLoopRunning then
    return
  end

  v15.IsUpdateFloorParagraphsLoopRunning = true
  pcall(f114)

  local function f116()
    if not v18.FloorOverview then
      return
    end

    if f10() then
      f11(v18.FloorOverview)
      return
    end

    local v869 = f60()
    local v870 = f65()
    v16.LatestFarmPlots = v870
    local v871 = {}

    for i31 = 1, v869 do
      local v872 = v870.Floors[i31]

      if v872 and v872.IsUnlocked then
        local v873 = v15.PlayerDataComplete and string.format(
          " - <font color=\"#FFD700\">+$%s / min</font>", v24.Number(v872.TotalCashPerMinute)
        ) or ""

        table.insert(
          v871, string.format("- Floor %d: %d/30 tiles%s", i31, #v872.UnlockedTiles, v873)
        )
      else
        table.insert(
          v871, string.format("- Floor %d: <font color=\"#888888\">Locked</font>", i31)
        )
      end
    end

    local totalFarmCashPerMinute = v15.PlayerDataComplete and v870.TotalFarmCashPerMinute
        and v870.TotalFarmCashPerMinute > 0 and v870.TotalFarmCashPerMinute
      or f20()

    local v874 = totalFarmCashPerMinute and totalFarmCashPerMinute > 0 and string.format(
      " - <font color=\"#FFD700\">+$%s / min</font>", v24.Number(totalFarmCashPerMinute)
    ) or ""

    local v875 = f16()
    local plantPot4 = v875 and v875:FindFirstChild("PlantPot")
    local seedName8 = plantPot4 and plantPot4:GetAttribute("SeedName")
    local incomePerMin = plantPot4 and plantPot4:GetAttribute("IncomePerMin")

    if not seedName8 or seedName8 == "" then
      local v876 = f38("PlotSave", "PlantPot")
      seedName8 = v876 and v876.SeedName
    end

    local v877

    if seedName8 and seedName8 ~= "" then
      local v878, v879 = f45(seedName8)

      local rarity6 = v878 and v14.Plants and v14.Plants[v878] and v14.Plants[v878].Rarity
        or "Common"

      local mutation = v879 and v879.Mutation

      local v880 = mutation and mutation ~= "Normal" and mutation ~= ""
          and string.format(" <font color=\"#FF5252\">[%s]</font>", mutation)
        or ""

      local v881 = tonumber(incomePerMin)

      if (not v881 or v881 <= 0) and seedName8 then
        v881 = tonumber(f52(seedName8, 1))
      end

      local v882 = v881 and v881 > 0 and string.format(
        " - <font color=\"#FFD700\">+$%s / min</font>", v24.Number(v881)
      ) or ""

      v877 = string.format(
        "- Honor Pot: <font color=\"#00E676\">%s</font> (%s)%s%s", v878 or "Plant", rarity6,
        v880, v882
      )
    else
      v877 = "- Honor Pot: <font color=\"#888888\">None</font>"
    end

    local v883 = string.format([[
- Floors: <font color="#00E676">%d / %d</font> (%d/%d tiles)%s

Floor Breakdown:
%s

%s]], v870.TotalUnlockedFloors, v869, v870.TotalUnlockedTiles, v869 * 30, v874, table.concat(v871, "\n"), v877)

    f11(v18.FloorOverview, v883)
  end

  local function f117(p218)
    local floorStatus = v18.FloorStatus and v18.FloorStatus[p218]

    if not floorStatus then
      return
    end

    if f10() then
      f11(floorStatus)
      return
    end

    local floors = v16.LatestFarmPlots and v16.LatestFarmPlots.Floors
        and v16.LatestFarmPlots.Floors[p218]
      or f64(p218)

    if not floors.IsUnlocked then
      f11(
        floorStatus,
        string.format("<font color=\"#888888\">Floor %d is currently locked.</font>", p218)
      )

      return
    end

    local sawYield3 = floors.SawYield
    local sprinklerPower2 = floors.SprinklerPower
    local sawRange4 = floors.SawRange
    local sprinklerRange4 = floors.SprinklerRange
    local buildings10 = floors.Buildings or {}
    local upgrader3 = buildings10.Upgrader3 or 0
    local upgrader2 = buildings10.Upgrader2 or 0
    local upgrader1 = buildings10.Upgrader1 or 0
    local v884 = upgrader3 > 0 and 3 or upgrader2 > 0 and 2 or upgrader1 > 0 and 1 or 0

    local v885 = v884 > 0 and string.format("Lv.%d", v884)
      or "<font color=\"#888888\">None</font>"

    local v886 = {}

    for i32 = 1, 3 do
      local v887 = (i32 - 1) * 10 + 1
      local v888 = i32 * 10
      local count21 = 0
      local v889 = {}

      for i33 = v887, v888 do
        local v890 = floors.Tiles[i33]

        if v890 and v890.IsUnlocked then
          count21 = count21 + 1

          if v890.IsPlanted then
            table.insert(v889, v890)
          end
        end
      end

      if count21 > 0 then
        local v891 = {
          (string.format(
            "<b>Ring %d (Tiles %d-%d)</b> - Planted: %d/%d", i32, v887, v888, #v889, count21
          )),
        }

        if #v889 == 0 then
          table.insert(v891, "  <font color=\"#888888\">- (No crops planted)</font>")
        else
          for index125, value186 in ipairs(v889) do
            local v892 = {}

            local rarity7 = value186.Rarity
              or value186.PlantName and v14.Plants and v14.Plants[value186.PlantName]
                and v14.Plants[value186.PlantName].Rarity

            if rarity7 and rarity7 ~= "" then
              local v893 = "#B0BEC5"

              if rarity7 == "Uncommon" then
                v893 = "#66BB6A"
              elseif rarity7 == "Rare" then
                v893 = "#42A5F5"
              elseif rarity7 == "Epic" then
                v893 = "#AB47BC"
              elseif rarity7 == "Legendary" then
                v893 = "#FFA726"
              elseif rarity7 == "Mythic" then
                v893 = "#EF5350"
              elseif rarity7 == "Secret" then
                v893 = "#EC407A"
              elseif rarity7 == "Prismatic" then
                v893 = "#26C6DA"
              end

              table.insert(v892, string.format("<font color=\"%s\">%s</font>", v893, rarity7))
            end

            if value186.Grade and value186.Grade ~= "Standard" then
              table.insert(v892, value186.Grade)
            end

            if value186.Size then
              table.insert(v892, string.format("x%.2f", value186.Size))
            end

            if value186.Mutation and value186.Mutation ~= "Normal" and value186.Mutation ~= "" then
              local v894 = "#FF5252"

              if value186.Mutation == "Frozen" then
                v894 = "#40C4FF"
              elseif value186.Mutation == "Electric" then
                v894 = "#FFD700"
              elseif value186.Mutation == "Radioactive" then
                v894 = "#76FF03"
              elseif value186.Mutation == "Plasma" then
                v894 = "#E040FB"
              end

              table.insert(
                v892, string.format("<font color=\"%s\">%s</font>", v894, value186.Mutation)
              )
            end

            if value186.HasFertilizer then
              table.insert(v892, "<font color=\"#FFD740\">Fertilized</font>")
            end

            local v895 = #v892 > 0 and " [" .. table.concat(v892, " | ") .. "]" or ""

            local v896 = v15.PlayerDataComplete and value186.CashPerMinute and value186.CashPerMinute > 0 and string.format(
              "<font color=\"#FFD700\">[%s]</font> ", v24.Number(value186.CashPerMinute)
            ) or ""

            table.insert(v891, string.format(
              "  - %d: %s%s%s", value186.TileIndex, v896, value186.PlantName, v895
            ))
          end
        end

        table.insert(v886, table.concat(v891, "\n"))
      end
    end

    local v897 = #v886 > 0 and table.concat(v886, "\n\n")
      or "<font color=\"#888888\">No rings unlocked</font>"

    local v898 = v15.PlayerDataComplete and string.format([[
- Floor Income: <font color="#FFD700">$%s / min</font>
]], v24.Number(floors.TotalCashPerMinute)) or ""

    f11(floorStatus, (string.format([[
- Tiles: <font color="#00E676">%d / 30</font> (Planted: %d, Empty: %d)
%s- Machines: Saw Lv.%d (Range %d) | Sprinkler Lv.%d (Range %d)
- Upgrader: %s

%s]], #floors.UnlockedTiles, #floors.PlantedTiles, #floors.EmptyTiles, v898, sawYield3, sawRange4, sprinklerPower2, sprinklerRange4, v885, v897)))
  end

  task.spawn(function()
    while not v6.Unloaded do
      pcall(f116)

      for i34 = 1, f60() do
        pcall(f117, i34)
      end

      task.wait(5)
    end

    v15.IsUpdateFloorParagraphsLoopRunning = false
  end)
end

local function f118()
  if v15.IsAutoCompostLoopRunning then
    return
  end

  v15.IsAutoCompostLoopRunning = true

  local function f119(p219)
    local v899 = f49()

    if v899 and v899.GetComposterSeedValue then
      local v900, v901 = pcall(v899.GetComposterSeedValue, p219)

      if v900 and type(v901) == "number" then
        return v901
      end
    end

    local v902, v903 = f45(p219)

    if not v902 then
      return 0
    end

    local plants8 = v14.Plants and v14.Plants[v902]
    local price10 = plants8 and plants8.Price or 10
    local grade4 = v903 and v903.Grade or "Standard"
    local v904 = v13.GRADE_MULTIPLIERS[grade4] or 1
    local v905 = (v903 and v903.Size and { price10 * v903.Size } or { price10 * v904 })[1]

    if v903 and v903.Mutation and v903.Mutation ~= "Normal" and v903.Mutation ~= "" then
      local mutations3 = v14.Mutations and v14.Mutations[v903.Mutation]
      v905 = v905 * (mutations3 and mutations3.Multiplier or 1)
    end

    return math.floor(v905)
  end

  local function f120(p220, p221)
    if not p221 or type(p221) ~= "table" then
      return false
    end

    local v906 = f51(p220)

    if not v906 or #v906 == 0 then
      v906 = { "Normal" }
    end

    local v907 = {}

    for index126, value187 in ipairs(v906) do
      if value187 ~= "Limited" and value187 ~= "Normal" then
        table.insert(v907, value187)
      end
    end

    if #v907 > 0 then
      for index127, value188 in ipairs(v907) do
        if f50(p221, value188) then
          return true
        end
      end

      return false
    end

    for index128, value189 in ipairs(v906) do
      if f50(p221, value189) then
        return true
      end
    end

    return false
  end

  task.spawn(function()
    while not v6.Unloaded do
      local farmCompostAutoCompostBySeed = v15.FarmCompostAutoCompostBySeed

      if farmCompostAutoCompostBySeed == nil then
        farmCompostAutoCompostBySeed = f8("Toggle_Farm_CompostAutoCompostBySeed")
      end

      local farmCompostAutoCompostByRarity = v15.FarmCompostAutoCompostByRarity

      if farmCompostAutoCompostByRarity == nil then
        farmCompostAutoCompostByRarity = f8("Toggle_Farm_CompostAutoCompostByRarity")
      end

      local farmCompostAutoPullLever = v15.FarmCompostAutoPullLever

      if farmCompostAutoPullLever == nil then
        farmCompostAutoPullLever = f8("Toggle_Farm_CompostAutoPullLever")
      end

      if not farmCompostAutoCompostBySeed and not farmCompostAutoCompostByRarity
        and not farmCompostAutoPullLever then
        break
      end

      pcall(function()
        local v908 = f70()

        if not v908.IsBuilt then
          return
        end

        local farmCompostTargetTier = v15.FarmCompostTargetTier
          or f8("Dropdown_Farm_CompostTargetTier") or "Overgrown Compost"

        local v909 = f69(v908.Level, farmCompostTargetTier)

        if (farmCompostAutoCompostBySeed or farmCompostAutoCompostByRarity)
          and v908.Value < v909 then
          local v910 = v909 - v908.Value
          local v911 = f6()

          local favoritedSeeds = v911 and type(v911.FavoritedSeeds) == "table"
              and v911.FavoritedSeeds
            or {}

          local farmCompostTargetSeeds = v15.FarmCompostTargetSeeds
            or f8("Dropdown_Farm_CompostTargetSeeds")

          local farmCompostTargetRarities = v15.FarmCompostTargetRarities
            or f8("Dropdown_Farm_CompostTargetRarities")

          local rarityOrderMap5 = v14.RarityOrderMap or {}
          local v912 = f59()
          local total22 = 0

          for key74, value190 in pairs(v912) do
            if type(value190) == "number" and value190 > 0 then
              total22 = total22 + value190
            end
          end

          if total22 > 1 then
            local farmCompostIgnoreMutatedSeeds = v15.FarmCompostIgnoreMutatedSeeds

            if farmCompostIgnoreMutatedSeeds == nil then
              farmCompostIgnoreMutatedSeeds = f8("Toggle_Farm_CompostIgnoreMutatedSeeds")
            end

            if farmCompostIgnoreMutatedSeeds == nil then
              farmCompostIgnoreMutatedSeeds = true
            end

            local farmCompostIgnorePlantFilters = v15.FarmCompostIgnorePlantFilters

            if farmCompostIgnorePlantFilters == nil then
              farmCompostIgnorePlantFilters = f8("Dropdown_Farm_CompostIgnorePlantFilters")
            end

            local v913 = {}

            for key75, value191 in pairs(v912) do
              local v914 = false

              repeat
                if type(value191) == "number" and value191 > 0 and favoritedSeeds[key75] ~= true then
                  local v915, v916 = f45(key75)

                  if v915 then
                    if farmCompostIgnoreMutatedSeeds and v916 and v916.Mutation
                      and v916.Mutation ~= "Normal" and v916.Mutation ~= "" then
                      v914 = true
                      break
                    end

                    if farmCompostIgnorePlantFilters
                      and f120(v915, farmCompostIgnorePlantFilters) then
                      v914 = true
                      break
                    end

                    local rarity8 = v14.Plants and v14.Plants[v915] and v14.Plants[v915].Rarity
                      or "Common"

                    local v917 = false

                    if farmCompostAutoCompostBySeed
                      and type(farmCompostTargetSeeds) == "table"
                      and (farmCompostTargetSeeds[v915] == true
                        or f50(farmCompostTargetSeeds, v915)) then
                      v917 = true
                    elseif farmCompostAutoCompostByRarity
                      and type(farmCompostTargetRarities) == "table"
                      and (farmCompostTargetRarities[rarity8] == true
                        or f50(farmCompostTargetRarities, rarity8)) then
                      v917 = true
                    end

                    if v917 then
                      local v918 = f119(key75)

                      if v918 > 0 then
                        table.insert(v913, {
                          SeedJSON = key75,
                          Count = value191,
                          UnitValue = v918,
                          RarityRank = rarityOrderMap5[rarity8] or 1,
                        })
                      end
                    end
                  end
                end

                v914 = true
              until true

              if not v914 then
                break
              end
            end

            if #v913 > 0 then
              table.sort(v913, function(p222, p223)
                if p222.RarityRank ~= p223.RarityRank then
                  return p222.RarityRank < p223.RarityRank
                end

                return p222.UnitValue < p223.UnitValue
              end)

              local v919 = {}
              local total23 = 0
              local total24 = 0

              for index129, value192 in ipairs(v913) do
                if total23 >= v910 then
                  break
                end

                local v920 = v910 - total23
                local v921 = math.ceil(v920 / value192.UnitValue)
                local v922 = math.min(value192.Count, v921)

                if total22 - (total24 + v922) < 1 then
                  v922 = math.max(0, total22 - total24 - 1)
                end

                if v922 > 0 then
                  v919[value192.SeedJSON] = v922
                  total23 = total23 + v922 * value192.UnitValue
                  total24 = total24 + v922
                end
              end

              if next(v919) ~= nil and total24 > 0 then
                if pcall(function() v23.FireServer("AddToComposter", v919) end) then
                  v22.Farm(string.format(
                    "Added %d seeds worth $%s to Composter!", total24, v24.Number(total23)
                  ), 3)
                end
              end
            end
          end
        end

        if farmCompostAutoPullLever and v908.IsReady and v908.Value >= v909 and v908.Value > 0 then
          v23.FireServer("UseComposter")

          if v908.Prompt and typeof(fireproximityprompt) == "function" then
            pcall(fireproximityprompt, v908.Prompt)
          end
        end
      end)

      task.wait(8)
    end

    v15.IsAutoCompostLoopRunning = false
  end)
end

local function f121()
  if v15.IsUpdateCompostParagraphLoopRunning then
    return
  end

  v15.IsUpdateCompostParagraphLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      pcall(function()
        if not v18.CompostStatus then
          return
        end

        if f10() then
          f11(v18.CompostStatus)
          return
        end

        local v923 = f70()

        local farmCompostTargetTier2 = v15.FarmCompostTargetTier
          or f8("Dropdown_Farm_CompostTargetTier") or "Overgrown Compost"

        local v924 = f69(v923.Level, farmCompostTargetTier2)

        if not v923.IsBuilt then
          f11(v18.CompostStatus, [[
- Machine Level: <font color="#FF5252">Locked (Not Built)</font>
- Status: <font color="#FFA726">Not Built</font>
- Progress: <font color="#888888">N/A</font>]])

          return
        end

        local value193 = v923.Value or 0
        local v925 = math.clamp(math.floor(value193 / math.max(v924, 1) * 100), 0, 100)
        local v926 = v925 >= 100 and "#00E676" or v925 >= 50 and "#FFD700" or "#FFA726"
        local isReady2 = v923.IsReady and "#00E676" or "#FFA726"
        local isReady3 = v923.IsReady and "Ready to Pull" or v923.CooldownText

        local v927 = string.format([[
- Machine Level: <font color="#00E676">Level %d / 3</font>
- Status: <font color="%s">%s</font>
- Progress: <font color="%s">$%s</font> / <font color="#40C4FF">$%s</font> (<font color="%s">%d%%</font>)]], v923.Level, isReady2, isReady3, v926, v24.Number(value193), v24.Number(v924), v926, v925)

        f11(v18.CompostStatus, v927)
      end)

      task.wait(4)
    end

    v15.IsUpdateCompostParagraphLoopRunning = false
  end)
end

local function f122()
  if v15.IsUpdatePetParagraphLoopRunning then
    return
  end

  v15.IsUpdatePetParagraphLoopRunning = true

  local function f123()
    if not v18.PetsOverview then
      return
    end

    if f10() then
      f11(v18.PetsOverview)
      return
    end

    local v928 = f6()

    if not v928 then
      f11(v18.PetsOverview, "<font color=\"#888888\">Loading player data...</font>")
      return
    end

    local v929 = f72(v928)
    local v930 = {}
    local v931 = 1

    if v929 then
      for index130, value194 in ipairs(v929) do
        if value194.IsEquipped then
          table.insert(v930, value194)
          v931 = v931 + math.max((value194.EarningsMultiplier or 1) - 0.5, 0)
        end
      end
    end

    local v932 = v929 and string.format("<font color=\"#FFD700\">x%.2f</font>", v931) or "N/A"
    local v933 = {}

    if not v929 then
      table.insert(v933, [[
<b>Active Pets:</b>
  <font color="#888888">- Pet data not available</font>]])
    else
      local v934 = string.format("<b>Active Pets (%d):</b>", #v930)
      table.insert(v933, v934)

      if #v930 == 0 then
        table.insert(v933, "  <font color=\"#888888\">- (No pets equipped)</font>")
      else
        for index131, value195 in ipairs(v930) do
          local v935 = {
            string.format("<font color=\"#40C4FF\">%s</font>", value195.Rarity or "Common"),
          }

          if value195.Grade and value195.Grade ~= "Standard" and value195.Grade ~= "" then
            table.insert(
              v935, string.format("<font color=\"#AB47BC\">%s</font>", value195.Grade)
            )
          end

          if value195.Size and value195.Size > 1 then
            table.insert(
              v935, string.format("<font color=\"#00E676\">x%.2f</font>", value195.Size)
            )
          end

          if value195.IsMaxLevel then
            table.insert(v935, "<font color=\"#00E676\">Lv.50 MAX</font>")
          else
            table.insert(v935, string.format("Lv.%d", value195.Level or 1))
          end

          if value195.IsFavorited then
            table.insert(v935, "<font color=\"#FF5252\">Fav</font>")
          end

          local v936 = #v935 > 0 and " [" .. table.concat(v935, " | ") .. "]" or ""

          local v937 = string.format(
            "<font color=\"#FFD700\">[%.1fx]</font>", value195.EarningsMultiplier or 1
          )

          local v938 = value195.CustomName and string.format(
            "<b>%s</b> <i>(%s)</i>", value195.CustomName, value195.Name
          ) or string.format("<b>%s</b>", value195.Name)

          table.insert(v933, string.format("  - %d: %s %s%s", index131, v937, v938, v936))
        end
      end
    end

    local getServerTimeNow6 = workspace:GetServerTimeNow()
    local restockTime2 = (v14.PetMerchant or {}).RestockTime or 600

    local v939 = math.max(0, math.ceil(getServerTimeNow6 / restockTime2) * restockTime2
      - getServerTimeNow6)

    local petMerchantSlots = f38("PetMerchantSlots") or v26.Get("PetMerchantSlots")
    local v940 = type(petMerchantSlots) == "number" and petMerchantSlots or 0
    local petMerchantStock = f38("PetMerchantStock") or v26.Get("PetMerchantStock")
    local petEggs2 = v14.PetEggs or {}

    local v941 = {
      string.format(
        "<b>Pet Merchant:</b> Restock in <font color=\"#00E676\">%s</font>", v24.Clock(v939)
      ),
    }

    if v940 == 0 and type(petMerchantStock) ~= "table" then
      table.insert(v941, "  <font color=\"#888888\">- Egg stock unavailable</font>")
    else
      local v942 = false

      for i35 = 1, math.max(v940, 1) do
        local v943 = type(petMerchantStock) == "table"
            and (petMerchantStock[i35] or petMerchantStock[tostring(i35)])
          or nil

        if v943 then
          v942 = true
          local v944 = petEggs2[v943]
          local price11 = v944 and v944.Price or 0

          table.insert(v941, string.format(
            "  - %d: <font color=\"#00E676\">%s</font> ($%s)", i35, v943, v24.Number(price11)
          ))
        elseif i35 <= v940 then
          table.insert(v941, string.format(
            "  - %d: <font color=\"#888888\">Empty / Bought</font>", i35
          ))
        end
      end

      if v940 == 0 and not v942 then
        table.insert(v941, "  <font color=\"#FFA726\">- No slots unlocked</font>")
      end
    end

    local v945 = string.format([[
- Farm Multiplier Bonus: %s

%s

%s]], v932, table.concat(v933, "\n"), table.concat(v941, "\n"))

    f11(v18.PetsOverview, v945)
  end

  task.spawn(function()
    while not v6.Unloaded do
      pcall(f123)
      task.wait(5)
    end

    v15.IsUpdatePetParagraphLoopRunning = false
  end)
end

local function f124()
  if v15.IsAutoOpenItemsLoopRunning then
    return
  end

  v15.IsAutoOpenItemsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local miscAutoOpenEggs = v15.MiscAutoOpenEggs or f8("Toggle_Misc_AutoOpenEggs")
      local miscAutoOpenCrates = v15.MiscAutoOpenCrates or f8("Toggle_Misc_AutoOpenCrates")

      local miscAutoOpenBeeCocoons = v15.MiscAutoOpenBeeCocoons
        or f8("Toggle_Misc_AutoOpenBeeCocoons")

      local miscAutoOpenSeedPacks = v15.MiscAutoOpenSeedPacks
        or f8("Toggle_Misc_AutoOpenSeedPacks")

      local miscAutoOpenChests = v15.MiscAutoOpenChests or f8("Toggle_Misc_AutoOpenChests")
        or v15.EventsAutoOpenGourdChests or f8("Toggle_Events_AutoOpenGourdChests")

      if not (miscAutoOpenEggs or miscAutoOpenCrates or miscAutoOpenBeeCocoons
        or miscAutoOpenSeedPacks or miscAutoOpenChests) then
        break
      end

      pcall(function()
        local v946 = f6()
        local v947 = {}
        local favoritedGears = v946 and v946.FavoritedGears or {}

        local function f125(p224, p225)
          if not p224 or not p225 then
            return false
          end

          if favoritedGears[p225] == true then
            return false
          end

          if miscAutoOpenEggs and string.find(p224, "Egg", 1, true) then
            return true
          end

          if miscAutoOpenCrates and string.find(p224, "Crate", 1, true) then
            return true
          end

          if miscAutoOpenBeeCocoons and string.find(p224, "Cocoon", 1, true) then
            return true
          end

          if miscAutoOpenSeedPacks and string.find(p224, "Seed Pack", 1, true) then
            return true
          end

          if miscAutoOpenChests
            and (string.find(p224, "Chest", 1, true) or string.find(p224, "Pail", 1, true)
              or string.find(p224, "Cache", 1, true) and not string.find(p224, "Treat", 1, true)) then
            return true
          end

          return false
        end

        if v946 and type(v946.Gears) == "table" then
          for key76, value196 in pairs(v946.Gears) do
            if type(value196) == "table" and value196.Name and f125(value196.Name, key76) then
              table.insert(v947, { Id = key76, Name = value196.Name })
            end
          end
        end

        for index132, value197 in ipairs({
          localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
        }) do
          if value197 then
            for index133, value198 in ipairs(value197:GetChildren()) do
              if value198:IsA("Tool") then
                local gearName2 = value198:GetAttribute("GearName") or value198.Name
                local gearIndex2 = value198:GetAttribute("GearIndex")

                if gearIndex2 and f125(gearName2, gearIndex2) then
                  local v948 = false

                  for index134, value199 in ipairs(v947) do
                    if value199.Id == gearIndex2 then
                      v948 = true
                      break
                    end
                  end

                  if not v948 then
                    table.insert(v947, { Id = gearIndex2, Name = gearName2 })
                  end
                end
              end
            end
          end
        end

        for index135, value200 in ipairs(v947) do
          if v6.Unloaded then
            break
          end

          local miscAutoOpenEggs2 = v15.MiscAutoOpenEggs or f8("Toggle_Misc_AutoOpenEggs")
          local miscAutoOpenCrates2 = v15.MiscAutoOpenCrates or f8("Toggle_Misc_AutoOpenCrates")

          local miscAutoOpenBeeCocoons2 = v15.MiscAutoOpenBeeCocoons
            or f8("Toggle_Misc_AutoOpenBeeCocoons")

          local miscAutoOpenSeedPacks2 = v15.MiscAutoOpenSeedPacks
            or f8("Toggle_Misc_AutoOpenSeedPacks")

          local miscAutoOpenChests2 = v15.MiscAutoOpenChests or f8("Toggle_Misc_AutoOpenChests")
            or v15.EventsAutoOpenGourdChests or f8("Toggle_Events_AutoOpenGourdChests")

          local v949 = false

          if miscAutoOpenEggs2 and string.find(value200.Name, "Egg", 1, true) then
            v949 = true
          elseif miscAutoOpenCrates2 and string.find(value200.Name, "Crate", 1, true) then
            v949 = true
          elseif miscAutoOpenBeeCocoons2 and string.find(value200.Name, "Cocoon", 1, true) then
            v949 = true
          elseif miscAutoOpenSeedPacks2 and string.find(value200.Name, "Seed Pack", 1, true) then
            v949 = true
          elseif miscAutoOpenChests2
            and (string.find(value200.Name, "Chest", 1, true)
              or string.find(value200.Name, "Pail", 1, true)
              or string.find(value200.Name, "Cache", 1, true)
                and not string.find(value200.Name, "Treat", 1, true)) then
            v949 = true
          end

          if v949 then
            if v23.FireServer("ActivateGear", value200.Id) then
              f9("Unboxing", string.format("Opened %s", value200.Name), 3)
            end

            task.wait(0.6)
          end
        end
      end)

      task.wait(2)
    end

    v15.IsAutoOpenItemsLoopRunning = false
  end)
end

local function f126()
  if v15.IsAutoFeedTreatsLoopRunning then
    return
  end

  v15.IsAutoFeedTreatsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.PetsAutoFeedTargetTreats or f8("Toggle_Pets_AutoFeedTargetTreats")) do
      pcall(function()
        local petsTargetTreats = v15.PetsTargetTreats or f8("Dropdown_Pets_TargetTreats")

        if type(petsTargetTreats) ~= "table" or next(petsTargetTreats) == nil then
          return
        end

        local v950 = f6()

        if not v950 or not v950.EquippedPets or not v950.Pets then
          return
        end

        local v951 = {}

        if type(v950.Gears) == "table" then
          for key77, value201 in pairs(v950.Gears) do
            if type(value201) == "table" and value201.Name
              and petsTargetTreats[value201.Name] == true then
              table.insert(v951, { Id = key77, Name = value201.Name })
            end
          end
        end

        for index136, value202 in ipairs({
          localPlayer.Character, localPlayer:FindFirstChild("Backpack"),
        }) do
          if value202 then
            for index137, value203 in ipairs(value202:GetChildren()) do
              if value203:IsA("Tool") and string.find(value203.Name, "Pet Treat", 1, true) then
                local gearName3 = value203:GetAttribute("GearName") or value203.Name
                local gearIndex3 = value203:GetAttribute("GearIndex")

                if gearIndex3 and petsTargetTreats[gearName3] == true then
                  local v952 = false

                  for index138, value204 in ipairs(v951) do
                    if value204.Id == gearIndex3 then
                      v952 = true
                      break
                    end
                  end

                  if not v952 then
                    table.insert(v951, { Id = gearIndex3, Name = gearName3 })
                  end
                end
              end
            end
          end
        end

        if #v951 == 0 then
          return
        end

        table.sort(v951, function(p226, p227)
          local petTreats = v14.PetTreats and v14.PetTreats[p226.Name]
          local petTreats2 = v14.PetTreats and v14.PetTreats[p227.Name]

          return (petTreats and (petTreats.Cost or petTreats.Index) or 0)
            > (petTreats2 and (petTreats2.Cost or petTreats2.Index) or 0)
        end)

        for key78, value205 in pairs(v950.EquippedPets) do
          if v6.Unloaded
            or not (v15.PetsAutoFeedTargetTreats or f8("Toggle_Pets_AutoFeedTargetTreats")) then
            break
          end

          local v953 = v950.Pets[key78]

          if v953 and type(v953) == "table" then
            local level7 = v953.Level or 1
            local treatTimeLeft = v953.TreatTimeLeft or 0

            if level7 < 50 and treatTimeLeft <= 0 then
              local v954 = v951[1]

              if v954 then
                if v23.FireServer("UsePetTreat", v954.Id, key78) then
                  fedCount = fedCount + 1

                  table.insert(fedDetails, string.format("%s (%s)", v953.Name, v954.Name))
                  table.remove(v951, 1)

                  task.wait(0.3)
                end
              end
            end
          end
        end

        if fedCount == 1 then
          v22.Pets(string.format("Fed treat: %s", fedDetails[1]), 3)
        elseif fedCount > 1 then
          v22.Pets(
            string.format("Fed %d pets: %s", fedCount, table.concat(fedDetails, ", ")), 3
          )
        end
      end)

      task.wait(2)
    end

    v15.IsAutoFeedTreatsLoopRunning = false
  end)
end

local function f127()
  if v15.IsAutoEquipBestPetsLoopRunning then
    return
  end

  v15.IsAutoEquipBestPetsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and (v15.PetsAutoEquipBestPets or f8("Toggle_Pets_AutoEquipBestPets")) do
      pcall(function()
        local v955 = f6()
        local v956 = f73(v955)

        if v956 <= 0 then
          return
        end

        local v957 = f72(v955)

        if #v957 == 0 then
          return
        end

        local petsPetEquipMode = v15.PetsPetEquipMode or f8("Dropdown_Pets_PetEquipMode")
          or "Farm Income"

        local v958 = {}

        if petsPetEquipMode == "Seed Discount" then
          local v959 = {}
          local v960 = {}

          for index139, value206 in ipairs(v957) do
            if value206.Name == "Red Fox" or value206.BoostType == "SeedCostDiscount" then
              table.insert(v959, value206)
            else
              table.insert(v960, value206)
            end
          end

          table.sort(v959, function(p228, p229)
            local boostValue2 = p228.BoostValue or p228.Level or 1
            local boostValue3 = p229.BoostValue or p229.Level or 1

            if boostValue2 ~= boostValue3 then
              return boostValue2 > boostValue3
            end

            return (p228.EarningsMultiplier or 1) > (p229.EarningsMultiplier or 1)
          end)

          table.sort(v960, function(p230, p231)
            if p230.EarningsMultiplier ~= p231.EarningsMultiplier then
              return p230.EarningsMultiplier > p231.EarningsMultiplier
            end

            if p230.Level ~= p231.Level then
              return p230.Level > p231.Level
            end

            return (p230.Size or 1) > (p231.Size or 1)
          end)

          local total25 = 0

          for index140, value207 in ipairs(v959) do
            if #v958 < v956 and total25 < 0.5 then
              local boostValue4 = value207.BoostValue
                or math.min(0.1 + 0.003 * ((value207.Level or 1) - 1), 0.25)

              table.insert(v958, value207)
              total25 = total25 + boostValue4
            end
          end

          local v961 = v956 - #v958

          if v961 > 0 then
            local v962 = v28.GetCurrentEquippedBees()

            for index141, value208 in ipairs((v28.SelectBestCashPets(v960, v961, v962))) do
              table.insert(v958, value208)
            end
          end
        elseif petsPetEquipMode == "Seed Roll" then
          local v963 = {}
          local v964 = {}
          local v965 = {}

          for index142, value209 in ipairs(v957) do
            local boostType = value209.BoostType
              or value209.AbilityInfo and value209.AbilityInfo.Boost

            if boostType == "PodiumRollSpeed" then
              table.insert(v963, value209)
            elseif boostType == "SeedLuck" then
              table.insert(v964, value209)
            else
              table.insert(v965, value209)
            end
          end

          table.sort(v963, function(p232, p233)
            return (p232.BoostValue or 0) > (p233.BoostValue or 0)
          end)

          table.sort(v964, function(p234, p235)
            return (p234.BoostValue or 1) > (p235.BoostValue or 1)
          end)

          table.sort(v965, function(p236, p237)
            if p236.EarningsMultiplier ~= p237.EarningsMultiplier then
              return p236.EarningsMultiplier > p237.EarningsMultiplier
            end

            return (p236.Level or 1) > (p237.Level or 1)
          end)

          local v966 = 0

          for index143, value210 in ipairs(v963) do
            if #v958 < v956 and v966 < 0.5 then
              local boostValue5 = value210.BoostValue or 0.15
              table.insert(v958, value210)
              v966 = math.min(v966 + boostValue5, 0.5)
            end
          end

          for index144, value211 in ipairs(v964) do
            if #v958 < v956 then
              table.insert(v958, value211)
            end
          end

          for index145, value212 in ipairs(v965) do
            if #v958 < v956 then
              table.insert(v958, value212)
            end
          end
        elseif petsPetEquipMode == "Super Roller" then
          local v967 = {}
          local v968 = {}

          for index146, value213 in ipairs(v957) do
            local boostType2 = value213.BoostType
              or value213.AbilityInfo and value213.AbilityInfo.Boost

            if boostType2 == "SuperRollerRareBoost" or boostType2 == "SuperRollerTokenSave"
              or value213.Name == "Kraken" or value213.Name == "Pufferfish" then
              table.insert(v967, value213)
            else
              table.insert(v968, value213)
            end
          end

          table.sort(v967, function(p238, p239)
            local boostType3 = p238.BoostType or ""

            if boostType3 ~= (p239.BoostType or "") then
              return boostType3 == "SuperRollerRareBoost"
            end

            return (p238.BoostValue or 0) > (p239.BoostValue or 0)
          end)

          table.sort(v968, function(p240, p241)
            if p240.EarningsMultiplier ~= p241.EarningsMultiplier then
              return p240.EarningsMultiplier > p241.EarningsMultiplier
            end

            return (p240.Level or 1) > (p241.Level or 1)
          end)

          for index147, value214 in ipairs(v967) do
            if #v958 < v956 then
              table.insert(v958, value214)
            end
          end

          for index148, value215 in ipairs(v968) do
            if #v958 < v956 then
              table.insert(v958, value215)
            end
          end
        elseif petsPetEquipMode == "Earnings Multiplier" then
          table.sort(v957, function(p242, p243)
            if p242.EarningsMultiplier ~= p243.EarningsMultiplier then
              return p242.EarningsMultiplier > p243.EarningsMultiplier
            end

            if p242.Level ~= p243.Level then
              return p242.Level > p243.Level
            end

            return (p242.Size or 1) > (p243.Size or 1)
          end)

          for i36 = 1, math.min(#v957, v956) do
            table.insert(v958, v957[i36])
          end
        else
          local v969 = v28.GetCurrentEquippedBees()
          v958 = v28.SelectBestCashPets(v957, v956, v969)
        end

        local v970 = v28.GetCurrentEquipped()
        local v971 = {}
        local v972 = {}

        for index149, value216 in ipairs(v970) do
          v971[value216.Id] = true
          table.insert(v972, value216)
        end

        local v973 = {}

        for index150, value217 in ipairs(v958) do
          v973[value217.Id] = true
        end

        local v974 = false

        for index151, value218 in ipairs(v958) do
          if not v971[value218.Id] then
            v974 = true
            break
          end
        end

        if not v974 and #v972 == #v958 then
          return
        end

        local v975 = v28.IsNearBarn()
        local cframe3 = nil

        if not v975 then
          local character8 = localPlayer.Character

          local humanoidRootPart7 = character8
            and (character8:FindFirstChild("HumanoidRootPart")
              or character8:FindFirstChild("Torso"))

          if humanoidRootPart7 then
            cframe3 = humanoidRootPart7.CFrame
          end

          v28.TeleportToBarn()
          task.wait(0.5)
        end

        table.sort(v972, function(p244, p245)
          local v976 = v973[p244.Id] == true

          if v976 ~= (v973[p245.Id] == true) then
            return not v976
          end

          if p244.EarningsMultiplier ~= p245.EarningsMultiplier then
            return p244.EarningsMultiplier < p245.EarningsMultiplier
          end

          return p244.Level < p245.Level
        end)

        local v977 = {}

        for index152, value219 in ipairs(v958) do
          local petsAutoEquipBestPets = v15.PetsAutoEquipBestPets
            or f8("Toggle_Pets_AutoEquipBestPets")

          if v6.Unloaded or not petsAutoEquipBestPets then
            break
          end

          if not v971[value219.Id] then
            if #v972 < v956 then
              v23.FireServer("EquipPet", value219.Id)
              table.insert(v972, value219)
              v971[value219.Id] = true
              table.insert(v977, string.format("Equipped %s", value219.Name))
              task.wait(0.3)
            else
              local v978 = v972[1]

              if v978 then
                v23.FireServer("UnequipPet", v978.Id)
                task.wait(0.2)
                local v979 = v23.FireServer("EquipPet", value219.Id)

                v971[v978.Id] = nil
                v971[value219.Id] = true

                table.remove(v972, 1)
                table.insert(v972, value219)

                table.sort(v972, function(p246, p247)
                  local v980 = v973[p246.Id] == true

                  if v980 ~= (v973[p247.Id] == true) then
                    return not v980
                  end

                  if p246.EarningsMultiplier ~= p247.EarningsMultiplier then
                    return p246.EarningsMultiplier < p247.EarningsMultiplier
                  end

                  return p246.Level < p247.Level
                end)

                table.insert(
                  v977, string.format("Replaced %s with %s", v978.Name, value219.Name)
                )

                task.wait(0.3)
              end
            end
          end
        end

        if not v975 and cframe3 then
          local character9 = localPlayer.Character

          local humanoidRootPart8 = character9
            and (character9:FindFirstChild("HumanoidRootPart")
              or character9:FindFirstChild("Torso"))

          if humanoidRootPart8 then
            task.wait(0.2)
            humanoidRootPart8.CFrame = cframe3
          end
        end

        if #v977 == 1 then
          v22.Pets(v977[1], 3)
        elseif #v977 > 1 then
          v22.Pets(string.format("Equipped pets: %d update(s) applied", #v977), 3)
        end

        if #v977 > 0 then
          v26.Invalidate("EquippedPets")
          v26.Invalidate("Pets")
        end
      end)

      task.wait(3)
    end

    v15.IsAutoEquipBestPetsLoopRunning = false
  end)
end

local function f128()
  if v15.IsAutoBuyPetMerchantSlotsLoopRunning then
    return
  end

  v15.IsAutoBuyPetMerchantSlotsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.PetsPetMerchantAutoBuySlots or f8("Toggle_Pets_PetMerchantAutoBuySlots")) do
      local v981, v982 = pcall(function()
        local petMerchantSlots2 = f38("PetMerchantSlots") or v26.Get("PetMerchantSlots")

        if type(petMerchantSlots2) ~= "number" then
          return
        end

        local petMerchant4 = v14.PetMerchant
        local slotPrices2 = petMerchant4 and petMerchant4.SlotPrices or {}

        if petMerchantSlots2 >= (petMerchant4 and petMerchant4.MaxSlots or #slotPrices2) then
          if not v15.LoggedMaxPetMerchantSlots then
            v15.LoggedMaxPetMerchantSlots = true
          end
        else
          local v983 = petMerchantSlots2 + 1
          local v984 = slotPrices2[v983]
          local v985 = f19()

          if not v984 or v984 <= 0 then
          elseif v985 < v984 then
          elseif v23.FireServer("BuyNextPetMerchantSlot") then
            v22.Pets(
              string.format("Unlocked Pet Merchant Slot %d ($%s)", v983, v24.Number(v984)), 4
            )

            v26.Invalidate("PetMerchantSlots")
          end
        end
      end)

      task.wait(3)
    end

    v15.IsAutoBuyPetMerchantSlotsLoopRunning = false
  end)
end

local function f129()
  if v15.IsAutoBuyPetMerchantEggsLoopRunning then
    return
  end

  v15.IsAutoBuyPetMerchantEggsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.PetsPetMerchantAutoBuyTargetEggs or f8("Toggle_Pets_PetMerchantAutoBuyTargetEggs")) do
      local v986, v987 = pcall(function()
        local level8 = f38("PlotSave", "Buildings", "PetBarn")

        if type(level8) ~= "number" or level8 < 1 then
          local v988 = f16()

          local petBarn5 = v988 and v988:FindFirstChild("Buildings")
            and v988.Buildings:FindFirstChild("PetBarn")

          level8 = petBarn5 and petBarn5:GetAttribute("Level")
        end

        if type(level8) ~= "number" or level8 < 1 then
          return
        end

        local dropdownPetsPetMerchantTargetEggs = f8("Dropdown_Pets_PetMerchantTargetEggs")

        if type(dropdownPetsPetMerchantTargetEggs) ~= "table"
          or next(dropdownPetsPetMerchantTargetEggs) == nil then
          return
        end

        local petMerchantSlots3 = f38("PetMerchantSlots") or v26.Get("PetMerchantSlots") or 3

        if type(petMerchantSlots3) ~= "number" or petMerchantSlots3 <= 0 then
          return
        end

        local petMerchantStock2 = f38("PetMerchantStock") or v26.Get("PetMerchantStock")

        if type(petMerchantStock2) ~= "table" then
          return
        end

        local petEggs3 = v14.PetEggs or {}
        local v989 = f19()
        local v990 = {}
        local total26 = 0

        for i37 = 1, petMerchantSlots3 do
          if not (v15.PetsPetMerchantAutoBuyTargetEggs
              or f8("Toggle_Pets_PetMerchantAutoBuyTargetEggs"))
            or v6.Unloaded then
            break
          end

          local v991 = petMerchantStock2[i37] or petMerchantStock2[tostring(i37)]

          if not v991 or v991 == "" then
          elseif dropdownPetsPetMerchantTargetEggs[v991] ~= true then
          else
            local v992 = petEggs3[v991]
            local price12 = v992 and v992.Price or 0

            if price12 <= 0 then
            elseif v989 < price12 then
            elseif v23.FireServer("BuyPetMerchantEgg", i37) then
              v989 = v989 - price12

              petMerchantStock2[i37] = nil
              petMerchantStock2[tostring(i37)] = nil

              if v16.PlayerData and type(v16.PlayerData.PetMerchantStock) == "table" then
                v16.PlayerData.PetMerchantStock[i37] = nil
                v16.PlayerData.PetMerchantStock[tostring(i37)] = nil
              end

              v16.DataMirrorCache.PetMerchantStock = nil
              table.insert(v990, v991)
              total26 = total26 + price12
              task.wait(0.5)
              local v993 = f19()

              if v993 < v989 then
                v989 = v993
              end
            end
          end
        end

        if #v990 == 1 then
          v22.Pets(string.format(
            "Bought %s from Pet Merchant ($%s)", v990[1], v24.Number(total26)
          ), 4)
        elseif #v990 > 1 then
          v22.Pets(string.format(
            "Bought %d eggs from Pet Merchant: %s ($%s)", #v990, table.concat(v990, ", "),
            v24.Number(total26)
          ), 4)
        end
      end)

      task.wait(3)
    end

    v15.IsAutoBuyPetMerchantEggsLoopRunning = false
  end)
end

local function f130()
  if v15.IsAutoSellPetsLoopRunning then
    return
  end

  v15.IsAutoSellPetsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.PetsSellPetAutoSellByRarity or f8("Toggle_Pets_SellPetAutoSellByRarity")) do
      local v994, v995 = pcall(function()
        local v996 = f6()

        if not v996 or not v996.Pets then
          return
        end

        local petsSellPetTargetRarities = v15.PetsSellPetTargetRarities
          or f8("Dropdown_Pets_SellPetTargetRarities")

        if type(petsSellPetTargetRarities) ~= "table" then
          return
        end

        local v997 = false

        for key79, value220 in pairs(petsSellPetTargetRarities) do
          if value220 == true then
            v997 = true
            break
          end
        end

        if not v997 then
          return
        end

        local favoritedPets2 = v996.FavoritedPets or {}
        local equippedPets4 = v996.EquippedPets or {}
        local petTeams = v996.PetTeams or {}
        local v998 = {}

        for key80, value221 in pairs(v996.Pets) do
          if type(value221) == "table" and value221.Name then
            if favoritedPets2[key80] == nil and equippedPets4[key80] == nil then
              local v999 = false

              for key81, value222 in pairs(petTeams) do
                if value222 and value222.Pets and value222.Pets[key80] ~= nil then
                  v999 = true
                  break
                end
              end

              if not v999 then
                local pets14 = v14.Pets and v14.Pets[value221.Name]
                local rarity9 = pets14 and pets14.Rarity or value221.Rarity or "Common"
                local grade5 = value221.Grade or "Standard"

                if petsSellPetTargetRarities[rarity9] == true then
                  table.insert(v998, {
                    UUID = key80,
                    Name = value221.Name,
                    Rarity = rarity9,
                    Grade = grade5,
                  })
                end
              end
            end
          end
        end

        local count22 = 0

        for index153, value223 in ipairs(v998) do
          if v6.Unloaded
            or not (v15.PetsSellPetAutoSellByRarity or f8("Toggle_Pets_SellPetAutoSellByRarity")) then
            break
          end

          local v1000 = v23.FireServer("SellPet", value223.UUID)
          count22 = count22 + 1
          task.wait(0.25)
        end

        if count22 > 0 then
          v22.Pets(string.format("Sold %d pet(s)", count22))
        end
      end)

      task.wait(3)
    end

    v15.IsAutoSellPetsLoopRunning = false
  end)
end

local function f131()
  if v15.IsUpdateBeeParagraphLoopRunning then
    return
  end

  v15.IsUpdateBeeParagraphLoopRunning = true

  local function f132()
    if not v18.BeeHoneyStats then
      return
    end

    if f10() then
      f11(v18.BeeHoneyStats)
      return
    end

    local v1001 = f6()
    local v1002 = f21()
    local count23 = 0
    local total27 = 0
    local v1003 = 1

    local equippedBees5 = v1001 and type(v1001.EquippedBees) == "table"
        and next(v1001.EquippedBees) ~= nil and v1001.EquippedBees
      or v26.Get("EquippedBees")

    local bees11 = v1001 and type(v1001.Bees) == "table" and next(v1001.Bees) ~= nil
        and v1001.Bees
      or v26.Get("Bees")

    if equippedBees5 and bees11 then
      v1003 = f74(v1001)

      for key82 in pairs(equippedBees5) do
        local v1004 = bees11[key82]

        if v1004 then
          count23 = count23 + 1
          local bees12 = v14.Bees and v14.Bees[v1004.Name]

          if bees12 and bees12.HoneyPerMin then
            total27 = total27 + bees12.HoneyPerMin * v1003
          end
        end
      end
    end

    local v1005 = f75(v1001)
    local getServerTimeNow7 = workspace:GetServerTimeNow()
    local v1006 = math.floor(getServerTimeNow7 / 900)
    local v1007 = math.max(0, math.ceil((v1006 + 1) * 900 - getServerTimeNow7))
    local beeShopItemNames = v14.BeeShopItemNames or {}
    local v1008 = f39(v1001)
    local v1009 = {}

    for index154, value224 in ipairs(beeShopItemNames) do
      local v1010 = f42(value224, v1001)

      if v1010 > 0 then
        local v1011 = f41(value224, v1001)

        table.insert(v1009, string.format(
          "  - %s: <font color=\"#00E676\">x%d</font> (%s Honey)", value224, v1010,
          v24.Number(v1011)
        ))
      end
    end

    local v1012

    if #v1009 > 0 then
      v1012 = table.concat(v1009, "\n")
    else
      v1012 = "  <font color=\"#888888\">- All items out of stock</font>"
    end

    local v1013 = v1008 > 0 and string.format(
      " (Discount: <font color=\"#00E676\">-%d%%</font>)", math.round(v1008 * 100)
    ) or ""

    local v1014 = string.format([[
- Honey: <font color="#FFD700">%s</font> (<font color="#00E676">+%s/min</font> | <font color="#FFA726">x%.2f</font>)
- Equipped Bees: <font color="#29B6F6">%d / %d</font>

<b>Bee Shop:</b> Restock in <font color="#00E676">%s</font>%s
%s]], v24.Number(v1002), v24.Number(math.floor(total27)), v1003, count23, v1005, v24.Clock(v1007), v1013, v1012)

    f11(v18.BeeHoneyStats, v1014)
  end

  task.spawn(function()
    while not v6.Unloaded do
      pcall(f132)
      task.wait(5)
    end

    v15.IsUpdateBeeParagraphLoopRunning = false
  end)
end

local function f133()
  if v15.IsBeeGachaLoopRunning then
    return
  end

  v15.IsBeeGachaLoopRunning = true

  task.spawn(function()
    local v1015 = nil
    local v1016 = false

    while not v6.Unloaded
      and (v15.PetsBeeGachaAutoBuyTargetBees or v15.PetsBeeGachaAutoBuyTargetRarities
        or f8("Toggle_Pets_BeeGachaAutoBuyTargetBees")
        or f8("Toggle_Pets_BeeGachaAutoBuyTargetRarities")) do
      local v1017 = false

      repeat
        local lastRolledBee = v15.LastRolledBee or f38("RolledBee")

        if lastRolledBee and lastRolledBee ~= "" and lastRolledBee ~= v1015 then
          local v1018 = false
          local bees13 = v14.Bees and v14.Bees[lastRolledBee]
          local rarity10 = bees13 and bees13.Rarity or "Common"

          if v15.PetsBeeGachaAutoBuyTargetBees or f8("Toggle_Pets_BeeGachaAutoBuyTargetBees") then
            local petsBeeGachaTargetBees = v15.PetsBeeGachaTargetBees
              or f8("Dropdown_Pets_BeeGachaTargetBees")

            v1018 = type(petsBeeGachaTargetBees) == "table"
              and petsBeeGachaTargetBees[lastRolledBee] == true
          elseif v15.PetsBeeGachaAutoBuyTargetRarities
            or f8("Toggle_Pets_BeeGachaAutoBuyTargetRarities") then
            local petsBeeGachaTargetRarities = v15.PetsBeeGachaTargetRarities
              or f8("Dropdown_Pets_BeeGachaTargetRarities")

            v1018 = type(petsBeeGachaTargetRarities) == "table"
              and petsBeeGachaTargetRarities[rarity10] == true
          end

          if v1018 then
            local cost2 = bees13 and bees13.Cost or 0

            if f21() >= cost2 then
              local buyRolledBee = v23.FireServer("BuyRolledBee")

              v22.Bees(string.format(
                "Bought %s (%s) for %s Honey", lastRolledBee, rarity10, v24.Number(cost2)
              ), 4)

              v15.LastRolledBee = nil
              v1015 = nil
              v1016 = false
              task.wait(0.2)
            else
              local petsBeeGachaPauseIfNotEnoughHoney = v15.PetsBeeGachaPauseIfNotEnoughHoney

              if petsBeeGachaPauseIfNotEnoughHoney == nil then
                petsBeeGachaPauseIfNotEnoughHoney = f8("Toggle_Pets_BeeGachaPauseIfNotEnoughHoney")
              end

              if petsBeeGachaPauseIfNotEnoughHoney then
                if not v1016 then
                  v1016 = true

                  v22.Bees(string.format(
                    "Not enough honey for %s (%s Honey)! Auto roll paused.", lastRolledBee,
                    v24.Number(cost2)
                  ), 4)
                end

                while not v6.Unloaded
                  and (v15.PetsBeeGachaAutoBuyTargetBees or v15.PetsBeeGachaAutoBuyTargetRarities
                    or f8("Toggle_Pets_BeeGachaAutoBuyTargetBees")
                    or f8("Toggle_Pets_BeeGachaAutoBuyTargetRarities"))
                  and (v15.PetsBeeGachaPauseIfNotEnoughHoney
                    or f8("Toggle_Pets_BeeGachaPauseIfNotEnoughHoney"))
                  and f21() < cost2 do
                  task.wait(0.2)
                end

                if v6.Unloaded
                  or not (v15.PetsBeeGachaAutoBuyTargetBees or v15.PetsBeeGachaAutoBuyTargetRarities
                    or f8("Toggle_Pets_BeeGachaAutoBuyTargetBees")
                    or f8("Toggle_Pets_BeeGachaAutoBuyTargetRarities")) then
                  v15.LastRolledBee = nil
                  v1015 = lastRolledBee
                  break
                end

                if f21() >= cost2 then
                  v23.FireServer("BuyRolledBee")

                  v22.Bees(string.format(
                    "Bought %s (%s) for %s Honey", lastRolledBee, rarity10, v24.Number(cost2)
                  ), 4)

                  v15.LastRolledBee = nil
                  v1015 = nil
                  v1016 = false
                  task.wait(0.2)
                else
                  v15.LastRolledBee = nil
                  v1015 = lastRolledBee
                  v1016 = false
                end
              else
                v15.LastRolledBee = nil
                v1015 = lastRolledBee
              end
            end

            if v15.LastRolledBee ~= nil then
              v1017 = true
              break
            end
          else
            v15.LastRolledBee = nil
            v1015 = lastRolledBee
          end
        end

        v15.RollBeeReceived = false
        v15.LastRolledBee = nil

        v23.FireServer("RollBee")
        local v1019 = tick()

        while not v15.RollBeeReceived and tick() - v1019 < 1 do
          if not (v15.PetsBeeGachaAutoBuyTargetBees or v15.PetsBeeGachaAutoBuyTargetRarities
            or f8("Toggle_Pets_BeeGachaAutoBuyTargetBees")
            or f8("Toggle_Pets_BeeGachaAutoBuyTargetRarities")) then
            break
          end

          task.wait(0.02)
        end

        if v15.RollBeeReceived then
          v1015 = nil
          task.wait(0.1)
        else
          task.wait(0.25)
        end

        v1017 = true
      until true

      if not v1017 then
        break
      end
    end

    v15.IsBeeGachaLoopRunning = false
  end)
end

local function f134()
  if v15.IsAutoEquipBestBeesLoopRunning then
    return
  end

  v15.IsAutoEquipBestBeesLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and (v15.PetsAutoEquipBestBees or f8("Toggle_Pets_AutoEquipBestBees")) do
      pcall(function()
        if v15.IsBeeShopSwappingBees then
          return
        end

        local v1020 = f6()
        local v1021 = f75(v1020)
        local v1022 = f77(v1020)

        if #v1022 == 0 then
          return
        end

        local v1023 = 0

        if v1020 and type(v1020.EquippedBees) == "table" then
          for key83 in pairs(v1020.EquippedBees) do
            v1023 = v1023 + 1
          end
        end

        if v1023 == 0 then
          local playerGui7 = localPlayer:FindFirstChild("PlayerGui")

          local txt6 = playerGui7 and playerGui7:FindFirstChild("MainUI")
            and playerGui7.MainUI:FindFirstChild("BeeHive")
            and playerGui7.MainUI.BeeHive:FindFirstChild("Content")
            and playerGui7.MainUI.BeeHive.Content:FindFirstChild("Navigation")
            and playerGui7.MainUI.BeeHive.Content.Navigation:FindFirstChild("ActiveBees")
            and playerGui7.MainUI.BeeHive.Content.Navigation.ActiveBees:FindFirstChild("Txt")

          if txt6 and txt6.Text then
            local dSSD = txt6.Text:match("(%d+)%s*/%s*(%d+)")

            if dSSD then
              v1023 = tonumber(dSSD) or 0
            end
          end
        end

        local v1024 = {}
        local v1025 = {}

        local equippedBees6 = v1020 and type(v1020.EquippedBees) == "table"
            and v1020.EquippedBees
          or f38("EquippedBees")
          or v26.Get("EquippedBees")

        local bees14 = v1020 and type(v1020.Bees) == "table" and v1020.Bees or f38("Bees")
          or v26.Get("Bees")

        if type(equippedBees6) == "table" and type(bees14) == "table" then
          for key84 in pairs(equippedBees6) do
            local v1026 = bees14[key84]

            if v1026 then
              local v1027 = f76(key84, v1026, v1020)

              if v1027 then
                table.insert(v1025, v1027)
                v1024[key84] = true
              end
            end
          end
        end

        local petsBeeEquipMode = v15.PetsBeeEquipMode or f8("Dropdown_Pets_BeeEquipMode")
          or "Farm Income"

        local v1028 = {}

        if petsBeeEquipMode == "Bee Roll Luck" then
          v1028 = v28.SelectBestBoostBees(v1022, v1021, "BeeLuck")
        elseif petsBeeEquipMode == "Seed Roll" then
          v1028 = v28.SelectBestBoostBees(v1022, v1021, "SeedLuck")
        elseif petsBeeEquipMode == "Honey / Min" then
          table.sort(v1022, function(p248, p249)
            if p248.BaseHoneyPerMin ~= p249.BaseHoneyPerMin then
              return p248.BaseHoneyPerMin > p249.BaseHoneyPerMin
            end

            return p248.Level > p249.Level
          end)

          for i38 = 1, math.min(#v1022, v1021) do
            table.insert(v1028, v1022[i38])
          end
        else
          local v1029 = v28.GetCurrentEquipped()
          v1028 = v28.SelectBestCashBees(v1022, v1021, v1029)
        end

        local v1030 = {}

        for index155, value225 in ipairs(v1028) do
          v1030[value225.Id] = true
        end

        local v1031 = false

        for index156, value226 in ipairs(v1028) do
          if not v1024[value226.Id] then
            v1031 = true
            break
          end
        end

        if not v1031 and #v1025 == #v1028 then
          return
        end

        table.sort(v1025, function(p250, p251)
          local v1032 = v1030[p250.Id] == true

          if v1032 ~= (v1030[p251.Id] == true) then
            return not v1032
          end

          if p250.BaseHoneyPerMin ~= p251.BaseHoneyPerMin then
            return p250.BaseHoneyPerMin < p251.BaseHoneyPerMin
          end

          return p250.Level < p251.Level
        end)

        local v1033 = {}

        for index157, value227 in ipairs(v1028) do
          local petsAutoEquipBestBees = v15.PetsAutoEquipBestBees
            or f8("Toggle_Pets_AutoEquipBestBees")

          if v6.Unloaded or not petsAutoEquipBestBees then
            break
          end

          if not v1024[value227.Id] then
            if #v1025 < v1021 then
              v23.FireServer("EquipBee", value227.Id)
              table.insert(v1025, value227)
              v1024[value227.Id] = true
              table.insert(v1033, string.format("Equipped %s", value227.Name))
              task.wait(0.3)
            elseif #v1025 > 0 then
              local v1034 = v1025[1]

              if v1034 then
                v23.FireServer("UnequipBee", v1034.Id)
                task.wait(0.3)
                local v1035 = v23.FireServer("EquipBee", value227.Id)

                v1024[v1034.Id] = nil
                v1024[value227.Id] = true

                table.remove(v1025, 1)
                table.insert(v1025, value227)

                table.sort(v1025, function(p252, p253)
                  local v1036 = v1030[p252.Id] == true

                  if v1036 ~= (v1030[p253.Id] == true) then
                    return not v1036
                  end

                  if p252.BaseHoneyPerMin ~= p253.BaseHoneyPerMin then
                    return p252.BaseHoneyPerMin < p253.BaseHoneyPerMin
                  end

                  return p252.Level < p253.Level
                end)

                table.insert(
                  v1033, string.format("Replaced %s with %s", v1034.Name, value227.Name)
                )

                task.wait(0.3)
              end
            end
          end
        end

        if #v1033 == 1 then
          v22.Pets(v1033[1], 3)
        elseif #v1033 > 1 then
          v22.Pets(string.format("Equipped best bees: %d update(s) applied", #v1033), 3)
        end

        if #v1033 > 0 then
          v26.Invalidate("EquippedBees")
          v26.Invalidate("Bees")
        end
      end)

      task.wait(4)
    end

    v15.IsAutoEquipBestBeesLoopRunning = false
  end)
end

local function f135()
  if v15.IsAutoBuyBeeShopLoopRunning then
    return
  end

  v15.IsAutoBuyBeeShopLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.PetsBeeShopAutoBuyItems or f8("Toggle_Pets_BeeShopAutoBuyItems")) do
      local v1037, v1038 = pcall(function()
        local petsBeeShopTargetItems = v15.PetsBeeShopTargetItems
          or f8("Dropdown_Pets_BeeShopTargetItems")

        if type(petsBeeShopTargetItems) ~= "table" then
          return
        end

        local v1039 = false

        for key85, value228 in pairs(petsBeeShopTargetItems) do
          if value228 == true then
            v1039 = true
            break
          end
        end

        if not v1039 then
          return
        end

        local v1040 = f6()
        local v1041 = f21()

        if v1041 <= 0 then
          return
        end

        local beeShopItemNames2 = v14.BeeShopItemNames or {}

        local petsBeeShopAutoEquipHaggler = v15.PetsBeeShopAutoEquipHaggler
          or f8("Toggle_Pets_BeeShopAutoEquipHaggler")

        local v1042 = f39(v1040)

        if petsBeeShopAutoEquipHaggler and v15.ExecCanScrape then
          local v1043 = f77(v1040)
          local v1044 = f75(v1040)
          local total28 = 0

          for index158, value229 in ipairs(v1043) do
            if value229.Name == "Empress Bee"
              or value229.AbilityInfo and value229.AbilityInfo.Boost == "BeeAbility" then
              local bees15 = v14.Bees and v14.Bees[value229.Name]
              local percent5 = bees15 and bees15.AbilityInfo and bees15.AbilityInfo.Percent
              local start4 = percent5 and percent5.Start or 0.25
              local max6 = percent5 and percent5.Max or start4
              local v1045 = math.clamp(value229.Level or 1, 1, 5)
              total28 = total28 + (start4 + (max6 - start4) * (v1045 - 1) / 4)
            end
          end

          local v1046 = 1 + math.min(total28, 1)
          local v1047 = 1
          local count24 = 0

          for index159, value230 in ipairs(v1043) do
            if value230.Name == "Haggler Bee" and count24 < v1044 then
              local bees16 = v14.Bees and v14.Bees[value230.Name]
              local percent6 = bees16 and bees16.AbilityInfo and bees16.AbilityInfo.Percent
              local start5 = percent6 and percent6.Start or 0.06
              local max7 = percent6 and percent6.Max or start5
              local v1048 = math.clamp(value230.Level or 1, 1, 5)
              local v1049 = (start5 + (max7 - start5) * (v1048 - 1) / 4) * v1046
              v1047 = v1047 * (1 - math.clamp(v1049 / 0.5, 0, 1))
              count24 = count24 + 1
            end
          end

          if count24 > 0 then
            v1042 = (1 - v1047) * 0.5
          end
        end

        local v1050 = false

        for index160, value231 in ipairs(beeShopItemNames2) do
          if petsBeeShopTargetItems[value231] == true then
            if f42(value231, v1040) > 0 then
              local beeShop4 = v14.BeeShop and v14.BeeShop[value231]
              local cost3 = beeShop4 and beeShop4.Cost or 0
              local v1051 = math.floor(cost3 * (1 - v1042))

              if v1051 > 0 and v1041 >= v1051 then
                v1050 = true
                break
              end
            end
          end
        end

        if not v1050 then
          v15.IsBeeShopSwappingBees = false
          return
        end

        local v1052 = nil
        local v1053 = false

        if petsBeeShopAutoEquipHaggler and v15.ExecCanScrape then
          local v1054 = f77(v1040)
          local v1055 = {}

          for index161, value232 in ipairs(v1054) do
            if value232.Name == "Haggler Bee" then
              table.insert(v1055, value232)
            end
          end

          if #v1055 > 0 then
            local equippedBees7 = v1040 and type(v1040.EquippedBees) == "table"
                and v1040.EquippedBees
              or f38("EquippedBees")
              or v26.Get("EquippedBees")

            v1052 = {}
            local v1056 = {}

            if type(equippedBees7) == "table" then
              for key86 in pairs(equippedBees7) do
                table.insert(v1052, key86)
                v1056[key86] = true
              end
            end

            local v1057 = {}

            for index162, value233 in ipairs(v1055) do
              if not v1056[value233.Id] then
                table.insert(v1057, value233)
              end
            end

            if #v1057 > 0 then
              v15.IsBeeShopSwappingBees = true

              table.sort(v1057, function(p254, p255)
                return (p254.Level or 1) > (p255.Level or 1)
              end)

              local v1058 = f75(v1040)
              local v1059 = {}
              local v1060 = {}

              for index163, value234 in ipairs(v1052) do
                local bees17 = v1040 and v1040.Bees and v1040.Bees[value234]

                if bees17 and bees17.Name ~= "Haggler Bee" then
                  if bees17.Name == "Empress Bee" then
                    table.insert(v1060, value234)
                  else
                    table.insert(v1059, value234)
                  end
                end
              end

              for index164, value235 in ipairs(v1060) do
                table.insert(v1059, value235)
              end

              local v1061 = #v1052

              for index165, value236 in ipairs(v1057) do
                if v1061 < v1058 then
                  v23.FireServer("EquipBee", value236.Id)
                  v1056[value236.Id] = true
                  v1061 = v1061 + 1
                  v1053 = true
                  task.wait(0.2)
                elseif #v1059 > 0 then
                  local v1062 = table.remove(v1059, 1)
                  v23.FireServer("UnequipBee", v1062)
                  v1056[v1062] = nil
                  task.wait(0.2)
                  v23.FireServer("EquipBee", value236.Id)
                  v1056[value236.Id] = true
                  v1053 = true
                  task.wait(0.2)
                end
              end

              if v1053 then
                task.wait(0.3)
                v1040 = f6()
              end
            end
          end
        end

        local v1063 = {}
        local total29 = 0

        for index166, value237 in ipairs(beeShopItemNames2) do
          if v6.Unloaded
            or not (v15.PetsBeeShopAutoBuyItems or f8("Toggle_Pets_BeeShopAutoBuyItems")) then
            break
          end

          if petsBeeShopTargetItems[value237] == true then
            local v1064 = f42(value237, v1040)
            local v1065 = f41(value237, v1040)

            if v1064 <= 0 then
            elseif v1065 <= 0 then
            elseif v1041 < v1065 then
            else
              local v1066 = math.floor(v1041 / v1065)
              local v1067 = math.min(v1064, v1066)
              local count25 = 0

              for i39 = 1, v1067 do
                if not (v15.PetsBeeShopAutoBuyItems or f8("Toggle_Pets_BeeShopAutoBuyItems"))
                  or v6.Unloaded then
                  break
                end

                if v23.FireServer("BuyFromBeeShop", value237) then
                  v1041 = v1041 - v1065
                  total29 = total29 + v1065
                  count25 = count25 + 1

                  if v1040 then
                    v1040.LastBeeShopSeed = math.floor(workspace:GetServerTimeNow() / 900)

                    if type(v1040.BeeShopBought) ~= "table" then
                      v1040.BeeShopBought = {}
                    end

                    v1040.BeeShopBought[value237] = (tonumber(v1040.BeeShopBought[value237]) or 0)
                      + 1
                  end

                  v26.Invalidate("BeeShopStock")
                  task.wait(0.08)
                else
                  break
                end
              end

              if count25 > 0 then
                table.insert(v1063, string.format("%dx %s", count25, value237))
              end
            end
          end
        end

        if v1053 then
          if v15.PetsAutoEquipBestBees or f8("Toggle_Pets_AutoEquipBestBees")
            or v15.PetsBeeEquipMode or f8("Dropdown_Pets_BeeEquipMode") then
            v15.IsBeeShopSwappingBees = false
            f134()
          else
            v1040 = f6()

            local equippedBees8 = v1040 and type(v1040.EquippedBees) == "table"
                and v1040.EquippedBees
              or f38("EquippedBees")
              or v26.Get("EquippedBees")

            local v1068 = {}

            if type(equippedBees8) == "table" then
              for key87 in pairs(equippedBees8) do
                v1068[key87] = true
              end
            end

            local v1069 = {}

            if v1052 then
              for index167, value238 in ipairs(v1052) do
                v1069[value238] = true
              end
            end

            for key88 in pairs(v1068) do
              if not v1069[key88] then
                v23.FireServer("UnequipBee", key88)
                task.wait(0.2)
              end
            end

            v1040 = f6()

            equippedBees8 = v1040 and type(v1040.EquippedBees) == "table" and v1040.EquippedBees
              or f38("EquippedBees") or v26.Get("EquippedBees")

            v1068 = {}

            if type(equippedBees8) == "table" then
              for key89 in pairs(equippedBees8) do
                v1068[key89] = true
              end
            end

            if v1052 then
              for index168, value239 in ipairs(v1052) do
                if not v1068[value239] then
                  v23.FireServer("EquipBee", value239)
                  task.wait(0.2)
                end
              end
            end

            v15.IsBeeShopSwappingBees = false
          end

          if #v1063 == 0 then
            task.wait(2)
          end
        end

        if #v1063 > 0 then
          v22.Bees(string.format(
            "Bought from Bee Shop: %s (%s Honey)", table.concat(v1063, ", "),
            v24.Number(total29)
          ), 4)
        end
      end)

      if not v1037 then
        v15.IsBeeShopSwappingBees = false
      end

      task.wait(3)
    end

    v15.IsBeeShopSwappingBees = false
    v15.IsAutoBuyBeeShopLoopRunning = false
  end)
end

local function f136()
  if v15.IsAutoSellBeesLoopRunning then
    return
  end

  v15.IsAutoSellBeesLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.PetsSellBeeAutoSellByRarity or f8("Toggle_Pets_SellBeeAutoSellByRarity")) do
      local v1070, v1071 = pcall(function()
        local v1072 = f6()

        if not v1072 or not v1072.Bees then
          return
        end

        local petsSellBeeTargetRarities = v15.PetsSellBeeTargetRarities
          or f8("Dropdown_Pets_SellBeeTargetRarities")

        if type(petsSellBeeTargetRarities) ~= "table" then
          return
        end

        local v1073 = false

        for key90, value240 in pairs(petsSellBeeTargetRarities) do
          if value240 == true then
            v1073 = true
            break
          end
        end

        if not v1073 then
          return
        end

        local favoritedBees2 = v1072.FavoritedBees or {}
        local equippedBees9 = v1072.EquippedBees or {}
        local v1074 = {}

        for key91, value241 in pairs(v1072.Bees) do
          if type(value241) == "table" and value241.Name then
            if favoritedBees2[key91] == nil and equippedBees9[key91] == nil then
              local bees18 = v14.Bees and v14.Bees[value241.Name]
              local rarity11 = bees18 and bees18.Rarity or value241.Rarity or "Common"

              if petsSellBeeTargetRarities[rarity11] == true then
                table.insert(v1074, { UUID = key91, Name = value241.Name, Rarity = rarity11 })
              end
            end
          end
        end

        local count26 = 0

        for index169, value242 in ipairs(v1074) do
          if v6.Unloaded
            or not (v15.PetsSellBeeAutoSellByRarity or f8("Toggle_Pets_SellBeeAutoSellByRarity")) then
            break
          end

          local v1075 = v23.FireServer("SellBee", value242.UUID)
          count26 = count26 + 1
          task.wait(0.25)
        end

        if count26 > 0 then
          v22.Bees(string.format("Sold %d bee(s)", count26))
        end
      end)

      task.wait(3)
    end

    v15.IsAutoSellBeesLoopRunning = false
  end)
end

function v31.GetMaxEquippedFish(p256)
  local v1076 = 0

  if p256 and p256.PlotSave and p256.PlotSave.Buildings then
    v1076 = tonumber(p256.PlotSave.Buildings.Aquarium) or 0
  end

  if v1076 <= 0 then
    local v1077 = v26.ReadPlotBuildingSigns()

    if v1077 and v1077.Aquarium then
      v1076 = tonumber(v1077.Aquarium.CurrentLevel) or 0
    end
  end

  if v1076 <= 0 then
    local v1078 = f15() or f16()
    local buildings11 = v1078 and v1078:FindFirstChild("Buildings")
    local aquarium3 = buildings11 and buildings11:FindFirstChild("Aquarium")

    if aquarium3 then
      v1076 = tonumber(aquarium3:GetAttribute("Level")) or 1
    end
  end

  return (v14.FishingSettings and v14.FishingSettings.AquariumSlots
      or f7("Fishing") and f7("Fishing").AquariumSlots or { 2, 4, 6 })[v1076]
    or 0
end

function v31.IsWorldEventActive()
  local activeEvents2 = replicatedStorage:FindFirstChild("ActiveEvents")

  if activeEvents2 then
    for index170, value243 in ipairs(activeEvents2:GetChildren()) do
      local lower = value243.Name:lower()

      if not lower:find("rain") and not lower:find("snow") and not lower:find("fog")
        and not lower:find("clear") and not lower:find("wind") then
        return true
      end
    end
  end

  local queenMoth = collectionService:GetTagged("QueenMoth")

  if queenMoth and #queenMoth > 0 then
    return true
  end

  return false
end

local function f137(p257, p258)
  if not p257 or not p257.Name then
    return 0
  end

  local fish2 = v14.Fish and v14.Fish[p257.Name]

  if not fish2 then
    return 0
  end

  local v1079 = tonumber(p257.Weight) or 1
  local min = fish2.Weight and fish2.Weight.Min or 0.1
  local max8 = fish2.Weight and fish2.Weight.Max or 1
  local v1080 = math.clamp((v1079 - min) / math.max(max8 - min, 0.000001), 0, 1)
  local abilityInfo = fish2.AbilityInfo
  local boost3 = abilityInfo and abilityInfo.Boost or ""
  local start6 = abilityInfo and abilityInfo.Percent and abilityInfo.Percent.Start or 0

  local v1081 = start6
    + ((abilityInfo and abilityInfo.Percent and abilityInfo.Percent.Max or start6) - start6)
      * v1080

  local weightPearlMultiplier = v14.FishingSettings
      and v14.FishingSettings.WeightPearlMultiplier
    or { Min = 1, Max = 2.5 }

  local v1082 = weightPearlMultiplier.Min
    + (weightPearlMultiplier.Max - weightPearlMultiplier.Min) * v1080

  local v1083 = (fish2.PearlsPerMin or 1) * v1082

  local rarityOrderMap6 = v14.RarityOrderMap and v14.RarityOrderMap[fish2.Rarity] or fish2.Index
    or 1

  if p258 == "Fast Bite (Minnow)" or p258 == "Fast Bite" then
    if boost3 == "BiteSpeed" then
      return 100000 + v1081 * 1000 + v1079
    end

    return v1083 * 0.01 + rarityOrderMap6
  elseif p258 == "Pearls / Min" then
    local v1084 = v1083

    if boost3 == "Pearls" then
      v1084 = v1084 * (1 + v1081)
    elseif boost3 == "FishAbility" then
      v1084 = v1084 * (1 + v1081)
    end

    return v1084
  elseif p258 == "Fishing Stats" then
    if boost3 == "DoubleCatch" or boost3 == "RarityUp" or boost3 == "FishLuck"
      or boost3 == "FishWeight" or boost3 == "BiteSpeed" or boost3 == "PerfectZone"
      or boost3 == "FishAbility" then
      return v1081 * 1000 + rarityOrderMap6 * 50 + v1083 * 0.01
    end

    return v1083 * 0.01 + rarityOrderMap6
  elseif p258 == "Farm Income" then
    if boost3 == "FruitIncome" or boost3 == "CrateSellValue" or boost3 == "SawYield"
      or boost3 == "SprinklerPower" or boost3 == "Honey" or boost3 == "FishAbility" then
      return v1081 * 1000 + rarityOrderMap6 * 50 + v1083 * 0.01
    end

    return v1083 * 0.01 + rarityOrderMap6
  elseif p258 == "Roll Luck" then
    if boost3 == "SeedLuck" or boost3 == "BeeLuck" or boost3 == "GradeUpgradeChance"
      or boost3 == "JackpotChance" or boost3 == "LuckyRollChance" or boost3 == "PodiumRollSpeed"
      or boost3 == "SeedCostDiscount" or boost3 == "FishAbility" then
      return v1081 * 1000 + rarityOrderMap6 * 50 + v1083 * 0.01
    end

    return v1083 * 0.01 + rarityOrderMap6
  end

  return v1083
end

function v31.CheckAndEquipBestFish()
  if not v15.ExecCanScrape then
    return
  end

  local v1085 = f6()

  if not v1085 or type(v1085.Fish) ~= "table" then
    return
  end

  local v1086 = v31.GetMaxEquippedFish(v1085)

  if v1086 <= 0 then
    return
  end

  local dropdownPetsFishEquipMode = f8("Dropdown_Pets_FishEquipMode") or "Pearls / Min"
  local v1087 = {}

  for key92, value244 in pairs(v1085.Fish) do
    if type(value244) == "table" and value244.Name then
      table.insert(v1087, {
        UUID = key92,
        Name = value244.Name,
        Weight = tonumber(value244.Weight) or 1,
        Score = f137(value244, dropdownPetsFishEquipMode),
      })
    end
  end

  table.sort(v1087, function(p259, p260) return p259.Score > p260.Score end)
  local equippedFish = type(v1085.EquippedFish) == "table" and v1085.EquippedFish or {}
  local v1088 = {}
  local v1089 = {}

  for key93 in pairs(equippedFish) do
    v1089[key93] = true
    local v1090 = v1085.Fish[key93]

    table.insert(v1088, {
      UUID = key93,
      Name = v1090 and v1090.Name or "Fish",
      Weight = v1090 and tonumber(v1090.Weight) or 1,
      Score = f137(v1090, dropdownPetsFishEquipMode),
    })
  end

  local v1091 = {}
  local v1092 = {}

  for i40 = 1, math.min(#v1087, v1086) do
    local v1093 = v1087[i40]
    table.insert(v1091, v1093)
    v1092[v1093.UUID] = true
  end

  local v1094 = false

  for index171, value245 in ipairs(v1091) do
    if not v1089[value245.UUID] then
      v1094 = true
      break
    end
  end

  if not v1094 and #v1088 == #v1091 then
    return
  end

  table.sort(v1088, function(p261, p262)
    local v1095 = v1092[p261.UUID] == true

    if v1095 ~= (v1092[p262.UUID] == true) then
      return not v1095
    end

    return p261.Score < p262.Score
  end)

  for index172, value246 in ipairs(v1091) do
    if v6.Unloaded or not f8("Toggle_Pets_FishAutoEquipBestFish") then
      break
    end

    if not v1089[value246.UUID] then
      if #v1088 < v1086 then
        v23.FireServer("EquipFish", value246.UUID)
        table.insert(v1088, value246)
        v1089[value246.UUID] = true
        task.wait(0.25)
      elseif #v1088 > 0 then
        local v1096 = v1088[1]

        if v1096 and v1096.Score < value246.Score then
          v23.FireServer("UnequipFish", v1096.UUID)
          task.wait(0.2)
          v23.FireServer("EquipFish", value246.UUID)

          v1089[v1096.UUID] = nil
          v1089[value246.UUID] = true

          table.remove(v1088, 1)
          table.insert(v1088, value246)

          table.sort(v1088, function(p263, p264)
            local v1097 = v1092[p263.UUID] == true

            if v1097 ~= (v1092[p264.UUID] == true) then
              return not v1097
            end

            return p263.Score < p264.Score
          end)

          task.wait(0.25)
        end
      end
    end
  end

  v26.Invalidate("Fish")
end

function v31.StartAutoEquipBestFishLoop()
  if not v15.ExecCanScrape then
    return
  end

  if v15.IsAutoEquipBestFishLoopRunning then
    return
  end

  v15.IsAutoEquipBestFishLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and f8("Toggle_Pets_FishAutoEquipBestFish") do
      pcall(v31.CheckAndEquipBestFish)
      task.wait(5)
    end

    v15.IsAutoEquipBestFishLoopRunning = false
  end)
end

function v31.SellTargetFish()
  local dropdownPetsFishSellTargetRarities = f8("Dropdown_Pets_FishSellTargetRarities")

  if type(dropdownPetsFishSellTargetRarities) ~= "table" then
    return
  end

  local v1098 = false

  for key94, value247 in pairs(dropdownPetsFishSellTargetRarities) do
    if value247 == true or type(value247) == "string" and value247 ~= "" then
      v1098 = true
      break
    end
  end

  if not v1098 then
    return
  end

  local v1099 = f6()

  if not v1099 or type(v1099.Fish) ~= "table" then
    return
  end

  local favoritedFish = v1099.FavoritedFish or {}
  local equippedFish2 = type(v1099.EquippedFish) == "table" and v1099.EquippedFish or {}
  local v1100 = {}

  for key95, value248 in pairs(v1099.Fish) do
    if type(value248) == "table" and value248.Name then
      if favoritedFish[key95] == nil and not equippedFish2[key95] then
        local rarity12 = value248.Rarity or v31.GetFishRarity(value248.Name)

        if rarity12
          and (dropdownPetsFishSellTargetRarities[rarity12] == true
            or f50(dropdownPetsFishSellTargetRarities, rarity12)) then
          table.insert(v1100, key95)
        end
      end
    end
  end

  if #v1100 == 0 then
    return
  end

  local count27 = 0

  for index173, value249 in ipairs(v1100) do
    if v6.Unloaded or not f8("Toggle_Pets_FishAutoSellFish") then
      break
    end

    v23.FireServer("SellFish", value249)
    count27 = count27 + 1
    task.wait(0.05)
  end

  if count27 > 0 then
    v22.Fish(string.format("Sold %d fish", count27), 3)
    v26.Invalidate("Fish")
  end
end

function v31.StartAutoFishLoop()
  if v15.IsAutoFishLoopRunning then
    return
  end

  v15.IsAutoFishLoopRunning = true

  task.spawn(function()
    local vector = Vector3.new(-847, 3.5, -62.47)
    local vector2 = Vector3.new(-829.14, 3.5, -62.47)
    local v1101 = f3()
    local fishingGui = v1101 and v1101:FindFirstChild("FishingGui")
    local castBar = fishingGui and fishingGui:FindFirstChild("CastBar")
    local holdText = castBar and castBar:FindFirstChild("HoldText")
    local connect = nil

    if holdText then
      if holdText.Text == "Hold To Cast" or holdText.Text == "Hold The Screen To Cast" then
        holdText.Text = "Auto Fishing Enabled"
      end

      connect = holdText:GetPropertyChangedSignal("Text"):Connect(function()
        if not v6.Unloaded and f8("Toggle_Pets_FishAutoFish") then
          if holdText.Text == "Hold To Cast" or holdText.Text == "Hold The Screen To Cast" then
            holdText.Text = "Auto Fishing Enabled"
          end
        end
      end)
    end

    if v15.PetsFishAutoUseTargetBaits or f8("Toggle_Pets_FishAutoUseTargetBaits") then
      v31.StartAutoUseBaitLoop()
    end

    while not v6.Unloaded and f8("Toggle_Pets_FishAutoFish") do
      local v1102 = false

      repeat
        local character10 = localPlayer.Character
        local humanoidRootPart9 = character10 and character10:FindFirstChild("HumanoidRootPart")
        local humanoid2 = character10 and character10:FindFirstChildOfClass("Humanoid")

        if not humanoidRootPart9 or not humanoid2 or humanoid2.Health <= 0 then
          task.wait(1)
          v1102 = true
          break
        end

        if (humanoidRootPart9.Position - vector).Magnitude > 35 then
          if f8("Toggle_Pets_FishPauseDuringEvents") ~= false and v31.IsWorldEventActive() then
            task.wait(2)
            v1102 = true
            break
          end

          if f8("Toggle_Pets_FishAutoTeleportToPond") then
            humanoidRootPart9.CFrame = CFrame.lookAt(vector, vector2)
            task.wait(0.5)
          else
            task.wait(2)
            v1102 = true
            break
          end
        else
          humanoidRootPart9.CFrame = CFrame.lookAt(humanoidRootPart9.Position, Vector3.new(
            vector2.X, humanoidRootPart9.Position.Y, vector2.Z
          ))
        end

        local tool = character10:FindFirstChildOfClass("Tool")

        if not tool or tool:GetAttribute("RodLevel") == nil and not tool.Name:find("Rod") then
          local v1103, v1104 = v31.GetRodTool()

          if not v1103 then
            local v1105, v1106 = v31.GetFishStorageCounts()

            if v1106 <= 0 then
              v22.Pets("Aquarium required to fish! Please build Aquarium first.", 5)
            else
              v22.Pets("No fishing rod found in inventory!", 5)
            end

            task.wait(3)
            v1102 = true
            break
          end

          if not v1104 then
            humanoid2:EquipTool(v1103)
            task.wait(0.25)
          end
        end

        local v1107, v1108 = v31.GetFishStorageCounts()

        if v1108 > 0 and v1107 >= v1108 then
          if f8("Toggle_Pets_FishAutoSellFish") then
            pcall(v31.SellTargetFish)
            task.wait(0.3)
            v1107, v1108 = v31.GetFishStorageCounts()
          end

          if v1108 > 0 and v1107 >= v1108 then
            task.wait(2)
            v1102 = true
            break
          end
        end

        v16.FishingCastAccepted = false
        v16.FishingBiteTriggered = false
        v16.LastCaughtFish = nil

        v23.FireServer("StartCast")
        local v1109 = os.clock()
        v16.FishingLastCastTime = v1109
        local v1110 = v31.GetRodLevel()
        local v1111 = v31.GetCastFillTime(v1110)
        local v1112 = math.clamp(v1111 * 0.9, 0.35, 0.75)
        task.wait(v1112)

        if v6.Unloaded or not f8("Toggle_Pets_FishAutoFish") then
          break
        end

        local v1113 = math.clamp(os.clock() - v1109, 0.35, 2.5)
        v23.FireServer("CastRod", v1113)
        local v1114 = os.clock()

        while not v6.Unloaded and not v16.FishingCastAccepted and os.clock() - v1114 < 1.2 do
          task.wait(0.02)
        end

        if not v16.FishingCastAccepted then
          task.wait(0.5)
          v1102 = true
          break
        end

        v16.FishingCastTarget = v31.GetCastTarget(humanoidRootPart9.CFrame, 0.95)
        local v1115 = os.clock()
        local v1116 = false

        while not v6.Unloaded and f8("Toggle_Pets_FishAutoFish") and os.clock() - v1115 < 8 do
          if v16.FishingBiteTriggered then
            v1116 = true
            break
          end

          local reelPrompt = fishingGui and fishingGui:FindFirstChild("ReelPrompt")

          if reelPrompt and reelPrompt.Visible then
            v1116 = true
            break
          end

          task.wait(0.015)
        end

        if v1116 then
          v23.FireServer("ReelFish")
          v16.FishingBiteTriggered = false
          local v1117 = os.clock()

          while os.clock() - v1117 < 0.6 and not v16.LastCaughtFish do
            task.wait(0.015)
          end

          if f8("Toggle_Pets_FishAutoEquipBestFish") then
            task.spawn(pcall, v31.CheckAndEquipBestFish)
          end

          if f8("Toggle_Pets_FishAutoSellFish") then
            task.spawn(pcall, v31.SellTargetFish)
          end

          task.wait(1.4)
        else
          pcall(function() v23.FireServer("CancelFishing") end)
          task.wait(0.5)
        end

        v1102 = true
      until true

      if not v1102 then
        break
      end
    end

    if connect then
      connect:Disconnect()
      connect = nil
    end

    pcall(function()
      if holdText and holdText.Text == "Auto Fishing Enabled" then
        holdText.Text = "Hold To Cast"
      end
    end)

    v15.IsAutoFishLoopRunning = false
  end)
end

function v31.StartAutoSellFishLoop()
  if v15.IsAutoSellFishLoopRunning then
    return
  end

  v15.IsAutoSellFishLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and f8("Toggle_Pets_FishAutoSellFish") do
      pcall(v31.SellTargetFish)
      task.wait(4)
    end

    v15.IsAutoSellFishLoopRunning = false
  end)
end

function v31.StartAutoFishingUpgradesLoop()
  if v15.IsAutoFishingUpgradesLoopRunning then
    return
  end

  v15.IsAutoFishingUpgradesLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (f8("Toggle_Pets_FishAutoUpgradeRod") or f8("Toggle_Pets_FishAutoUpgradeLuck")
        or v15.PetsFishAutoBuyPearlShop or f8("Toggle_Pets_FishAutoBuyPearlShop")) do
      local v1118 = v30.GetPlayerPearls()

      if f8("Toggle_Pets_FishAutoUpgradeRod") then
        local v1119 = v31.GetRodLevel()

        if v1119 < 15 then
          if v1118 >= v31.GetRodUpgradePrice(v1119) then
            if v23.FireServer("UpgradeFishingRod") then
              task.wait(0.5)
              local v1120 = v31.GetRodLevel()

              if v1120 > v1119 then
                v22.Fish(string.format("Upgraded Fishing Rod to Level %d!", v1120), 3)
              end

              v1118 = v30.GetPlayerPearls()
            end
          end
        end
      end

      if f8("Toggle_Pets_FishAutoUpgradeLuck") then
        local v1121 = v31.GetFishingLuckLevel()

        if v1121 < 10 then
          if v1118 >= v31.GetLuckUpgradePrice(v1121) then
            if v23.FireServer("UpgradeFishingLuck") then
              task.wait(0.5)
              local v1122 = v31.GetFishingLuckLevel()

              if v1122 > v1121 then
                v22.Fish(string.format("Upgraded Fishing Luck to Level %d!", v1122), 3)
              end

              v1118 = v30.GetPlayerPearls()
            end
          end
        end
      end

      if v15.PetsFishAutoBuyPearlShop or f8("Toggle_Pets_FishAutoBuyPearlShop") then
        local petsFishTargetPearlShopItems = v15.PetsFishTargetPearlShopItems
          or f8("Dropdown_Pets_FishTargetPearlShopItems")

        if type(petsFishTargetPearlShopItems) == "table" then
          local v1123 = f6()

          local pearlShopBought = v1123 and type(v1123.PearlShopBought) == "table"
              and v1123.PearlShopBought
            or v16.PearlShopBought
            or {}

          v16.PearlShopBought = pearlShopBought
          local stock2 = v14.PearlShop and v14.PearlShop.Stock or v14.PearlShop

          local v1124 = {
            ["Worm Bait"] = { Cost = 1500, Stock = 6 },
            ["Good Fertilizer"] = { Cost = 5000, Stock = 5 },
            ["Golden Bait"] = { Cost = 25000, Stock = 2 },
            ["Super Pet Treat"] = { Cost = 40000, Stock = 2 },
            ["Super Roller Token"] = { Cost = 100000, Stock = 1 },
            ["Abyssal Bait"] = { Cost = 400000, Stock = 1 },
          }

          local v1125 = f3()

          local items2 = v1125 and v1125:FindFirstChild("MainUI")
            and v1125.MainUI:FindFirstChild("Aquarium")
            and v1125.MainUI.Aquarium:FindFirstChild("Content")
            and v1125.MainUI.Aquarium.Content:FindFirstChild("ShopPage")
            and v1125.MainUI.Aquarium.Content.ShopPage:FindFirstChild("Scroller")
            and v1125.MainUI.Aquarium.Content.ShopPage.Scroller:FindFirstChild("Items")

          for index174, value250 in ipairs(v14.PearlShopItems or {
            "Abyssal Bait", "Golden Bait", "Good Fertilizer", "Super Pet Treat",
            "Super Roller Token", "Worm Bait",
          }) do
            if f50(petsFishTargetPearlShopItems, value250) then
              local v1126 = stock2 and stock2[value250] or v1124[value250]
              local cost4 = v1126 and v1126.Cost or 0
              local stock3 = v1126 and v1126.Stock or 1
              local v1127 = tonumber(pearlShopBought[value250]) or 0
              local v1128 = false

              if items2 then
                for index175, value251 in ipairs(items2:GetChildren()) do
                  local itemName3 = value251:FindFirstChild("ItemName")

                  if itemName3 and itemName3:IsA("TextLabel") and itemName3.Text == value250 then
                    local outOfStock = value251:FindFirstChild("OutOfStock")

                    if outOfStock and outOfStock.Visible then
                      v1128 = true
                    end

                    break
                  end
                end
              end

              if cost4 > 0 and v1118 >= cost4 and not v1128 and v1127 < stock3 then
                if v23.FireServer("BuyFromPearlShop", value250) then
                  v1118 = math.max(0, v1118 - cost4)
                  pearlShopBought[value250] = v1127 + 1
                  v22.Fish(string.format("Bought %s from Pearl Shop!", value250), 3)
                  task.wait(0.3)
                end
              end
            end
          end
        end
      end

      task.wait(3)
    end

    v15.IsAutoFishingUpgradesLoopRunning = false
  end)
end

function v31.StartAutoUseBaitLoop()
  if v15.IsAutoUseBaitLoopRunning then
    return
  end

  v15.IsAutoUseBaitLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.PetsFishAutoUseTargetBaits or f8("Toggle_Pets_FishAutoUseTargetBaits")) do
      pcall(function()
        local petsFishTargetBaits = v15.PetsFishTargetBaits
          or f8("Dropdown_Pets_FishTargetBaits")

        if type(petsFishTargetBaits) ~= "table" then
          return
        end

        local character11 = localPlayer.Character

        local humanoidRootPart10 = character11
          and character11:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart10 then
          return
        end

        local vector3 = Vector3.new(-829.14, 3.5, -62.47)
        local v1129 = (humanoidRootPart10.Position - vector3).Magnitude <= 50

        if not v1129 and v15.ExecCanScrape then
          local v1130 = f1(replicatedStorage:FindFirstChild("Shared")
            and replicatedStorage.Shared:FindFirstChild("Services")
            and replicatedStorage.Shared.Services:FindFirstChild("FishUtil"))

          if v1130 and v1130.GetDistanceToWater then
            local v1131 = v1130.GetDistanceToWater(humanoidRootPart10.Position)

            if v1131 and v1131 <= 25 then
              v1129 = true
            end
          end
        end

        if not v1129 then
          return
        end

        local v1132 = f6()

        local fishingBaits = v1132 and type(v1132.FishingBaits) == "table"
            and v1132.FishingBaits
          or {}

        local v1133 = v1132 and tonumber(v1132.AbyssalBaits) or 0
        local v1134 = os.time()
        v16.ActiveBaits = v16.ActiveBaits or {}
        local v1135 = f3()
        local fishingGui2 = v1135 and v1135:FindFirstChild("FishingGui")

        local baitTimer = fishingGui2 and fishingGui2:FindFirstChild("CastBar")
          and fishingGui2.CastBar:FindFirstChild("BaitTimer")

        local text19 = baitTimer and baitTimer.Visible and baitTimer.Text or ""

        local v1136 = {
          ["Worm Bait"] = { LuckKey = "2", Duration = 600, GuiPattern = "2x%s*Bait" },
          ["Golden Bait"] = { LuckKey = "5", Duration = 600, GuiPattern = "5x%s*Bait" },
          ["Abyssal Bait"] = { IsAbyssal = true },
        }

        for index176, value252 in ipairs(v14.FishingBaitNames
          or { "Abyssal Bait", "Golden Bait", "Worm Bait" }) do
          if f50(petsFishTargetBaits, value252) then
            local v1137 = v1136[value252]
            local v1138 = false

            if v1137 and v1137.GuiPattern and text19 ~= ""
              and string.find(text19, v1137.GuiPattern) then
              v1138 = true
            elseif v1137 and v1137.LuckKey then
              local v1139 = tonumber(fishingBaits[v1137.LuckKey])

              if v1139 and v1139 > v1134 + 2 then
                v1138 = true
              elseif v16.ActiveBaits[value252] and v16.ActiveBaits[value252] > v1134 + 2 then
                v1138 = true
              end
            elseif v1137 and v1137.IsAbyssal then
              if v1133 > 0 then
                v1138 = true
              elseif v16.ActiveBaits[value252] and v16.ActiveBaits[value252] > v1134 then
                v1138 = true
              end
            end

            if not v1138 then
              local gearIndex4 = nil

              if v1132 and type(v1132.Gears) == "table" then
                for key96, value253 in pairs(v1132.Gears) do
                  if type(value253) == "table" and value253.Name == value252
                    and (tonumber(value253.Amount) or 0) > 0 then
                    gearIndex4 = key96
                    break
                  end
                end
              end

              if not gearIndex4 then
                local backpack2 = localPlayer:FindFirstChild("Backpack")

                if backpack2 then
                  for index177, value254 in ipairs(backpack2:GetChildren()) do
                    if value254.Name == value252 and value254:GetAttribute("GearIndex") then
                      gearIndex4 = value254:GetAttribute("GearIndex")
                      break
                    end
                  end
                end
              end

              if not gearIndex4 and character11 then
                for index178, value255 in ipairs(character11:GetChildren()) do
                  if value255.Name == value252 and value255:GetAttribute("GearIndex") then
                    gearIndex4 = value255:GetAttribute("GearIndex")
                    break
                  end
                end
              end

              if gearIndex4 then
                if v23.FireServer("ActivateGear", gearIndex4) then
                  if v1137 and v1137.Duration then
                    v16.ActiveBaits[value252] = v1134 + v1137.Duration
                  else
                    v16.ActiveBaits[value252] = v1134 + 60
                  end

                  v22.Fish(string.format("Activated %s!", value252), 3)
                  task.wait(0.5)
                end
              end
            end
          end
        end
      end)

      task.wait(2)
    end

    v15.IsAutoUseBaitLoopRunning = false
  end)
end

function v31.StartUpdateFishOverviewLoop()
  if v15.IsUpdateFishOverviewLoopRunning then
    return
  end

  v15.IsUpdateFishOverviewLoopRunning = true

  local function f138()
    if not v18.FishOverview then
      return
    end

    if f10() then
      f11(v18.FishOverview)
      return
    end

    local v1140 = v31.GetRodLevel()
    local v1141 = v31.GetFishingLuckLevel()
    local v1142 = v30.GetPlayerPearls()
    local v1143, v1144 = v31.GetFishStorageCounts()
    local v1145 = f6()

    local fishingBaits2 = v1145 and type(v1145.FishingBaits) == "table" and v1145.FishingBaits
      or {}

    local v1146 = {}
    local v1147 = os.time()

    for key97, value256 in pairs(fishingBaits2) do
      local v1148 = math.max(0, math.floor(tonumber(value256) - v1147))

      if v1148 > 0 then
        local v1149 = key97 == "2" and "Worm" or key97 == "5" and "Golden" or key97
        table.insert(v1146, string.format("%s (%ds)", v1149, v1148))
      end
    end

    if v1145 and tonumber(v1145.AbyssalBaits) and v1145.AbyssalBaits > 0 then
      table.insert(v1146, string.format("Abyssal (x%d)", v1145.AbyssalBaits))
    end

    if #v1146 == 0 then
      local v1150 = f3()
      local fishingGui3 = v1150 and v1150:FindFirstChild("FishingGui")

      local baitTimer2 = fishingGui3 and fishingGui3:FindFirstChild("CastBar")
        and fishingGui3.CastBar:FindFirstChild("BaitTimer")

      if baitTimer2 and baitTimer2.Visible and baitTimer2.Text ~= "" then
        table.insert(v1146, baitTimer2.Text)
      end
    end

    local v1151 = #v1146 > 0 and table.concat(v1146, ", ") or "None"
    local v1152 = v1143 >= v1144 and v1144 > 0 and "#FF5252" or "#00E676"

    local v1153 = string.format([[
- Rod Level: <font color="#00E676">%d / 15</font>
- Luck Level: <font color="#00E676">%d / 10</font>
- Pearls: <font color="#40C4FF">%s</font>
- Active Baits: <font color="#FFD700">%s</font>
- Fish Storage: <font color="%s">%d / %d</font>]], v1140, v1141, v24.Number(v1142), v1151, v1152, v1143, v1144)

    f11(v18.FishOverview, v1153)
  end

  task.spawn(function()
    while not v6.Unloaded do
      if not (v15.SettingsDisableUpdateAllParagraph
        or f8("Toggle_Settings_DisableUpdateAllParagraph")) then
        pcall(f138)
      end

      task.wait(4)
    end

    v15.IsUpdateFishOverviewLoopRunning = false
  end)
end

local function f139()
  if v15.IsSeedGachaLoopRunning then
    return
  end

  v15.IsSeedGachaLoopRunning = true

  local function f140()
    return f8("Toggle_Farm_SeedGachaAutoBuyTargetSeeds")
      or f8("Toggle_Farm_SeedGachaAutoBuyTargetRarities")
      or f8("Toggle_Farm_SeedGachaAutoBuyTargetGrades")
      or f8("Toggle_Farm_SeedGachaAutoBuyUndiscovered")
  end

  local function f141(p265)
    if not p265 or p265 == "" then
      return false
    end

    local v1154 = f38("DiscoveredIndex", "Plants")

    if type(v1154) == "table" and next(v1154) ~= nil then
      return v1154[p265] ~= true
    end

    local playerGui8 = localPlayer:FindFirstChild("PlayerGui")
    local mainUI7 = playerGui8 and playerGui8:FindFirstChild("MainUI")
    local indexFrame = mainUI7 and mainUI7:FindFirstChild("IndexFrame")
    local content = indexFrame and indexFrame:FindFirstChild("Content")
    local slots3 = content and content:FindFirstChild("Slots")
    local plants9 = slots3 and slots3:FindFirstChild("Plants")
    local findFirstChild22 = plants9 and plants9:FindFirstChild(p265)

    if findFirstChild22 then
      local itemName4 = findFirstChild22:FindFirstChild("ItemName")

      if itemName4 and itemName4:IsA("TextLabel") then
        return itemName4.Text == "???"
      end
    end

    return false
  end

  local function f142(p266, p267, p268)
    if f8("Toggle_Farm_SeedGachaAutoBuyTargetSeeds") then
      local dropdownFarmSeedGachaTargetSeeds = f8("Dropdown_Farm_SeedGachaTargetSeeds")

      return type(dropdownFarmSeedGachaTargetSeeds) == "table"
        and dropdownFarmSeedGachaTargetSeeds[p266] == true
    elseif f8("Toggle_Farm_SeedGachaAutoBuyTargetRarities") then
      local dropdownFarmSeedGachaTargetRarities = f8("Dropdown_Farm_SeedGachaTargetRarities")

      return type(dropdownFarmSeedGachaTargetRarities) == "table"
        and dropdownFarmSeedGachaTargetRarities[p267] == true
    elseif f8("Toggle_Farm_SeedGachaAutoBuyTargetGrades") then
      local dropdownFarmSeedGachaTargetGrades = f8("Dropdown_Farm_SeedGachaTargetGrades")

      return type(dropdownFarmSeedGachaTargetGrades) == "table"
        and dropdownFarmSeedGachaTargetGrades[p268] == true
    elseif f8("Toggle_Farm_SeedGachaAutoBuyUndiscovered") then
      return f141(p266)
    end

    return false
  end

  local function f143(p269, p270, p271)
    local v1155, v1156 = pcall(function()
      if p271 and p271[p269] then
        return false
      end

      local lastRolledSeeds = v16.LastRolledSeeds or f38("PlotSave", "Rolled")

      if lastRolledSeeds then
        local v1157 = lastRolledSeeds[p269] or lastRolledSeeds[tostring(p269)]

        if not v1157 then
          return false
        end

        if p270 and v1157 ~= p270 then
          return false
        end
      end

      return true
    end)

    if v1155 then
      return v1156
    end

    return false
  end

  task.spawn(function()
    local v1158 = false
    local v1159 = false
    local v1160 = -1
    local count28 = 0

    while not v6.Unloaded and f140() do
      local v1161 = false

      repeat
        local activeEvents3 = replicatedStorage:FindFirstChild("ActiveEvents")
          or workspace:FindFirstChild("ActiveEvents")

        local v1162 = activeEvents3
          and (activeEvents3:FindFirstChild("Hacker Invasion") ~= nil
            or activeEvents3:FindFirstChild("Hacker") ~= nil)

        local farmSeedGachaPauseOnHackerEvent = (v15.FarmSeedGachaPauseOnHackerEvent
            or f8("Toggle_Farm_SeedGachaPauseOnHackerEvent"))
          and v1162

        if farmSeedGachaPauseOnHackerEvent then
          if not v1159 then
            v1159 = true

            v22.Gacha(
              "Hacker Invasion active: Auto rolling for Byte drops (buying seeds paused)", 4
            )
          end
        else
          v1159 = false
        end

        if not (farmSeedGachaPauseOnHackerEvent or f19() > 0 or f55("Bytes") > 0) then
          task.wait(0.5)
          v1161 = true
          break
        end

        local v1163 = tick()
        local rollVersion = v15.RollVersion or 0
        local v1164 = {}

        if v1160 == rollVersion then
          v15.RollPodiumsReceived = false
          v16.LastRolledSeeds = nil
          v1163 = tick()
          v23.FireServer("RollPodiums")
          local v1165 = tick()

          while not v15.RollPodiumsReceived and tick() - v1165 < 1.5 do
            if not f140() then
              break
            end

            task.wait(0.02)
          end

          v23.FireServer("RollSequenceDone")
          rollVersion = v15.RollVersion or 0
        end

        if not f140() then
          break
        end

        v1160 = rollVersion
        local lastRolledSeeds2 = v16.LastRolledSeeds or f38("PlotSave", "Rolled")

        if not lastRolledSeeds2 or next(lastRolledSeeds2) == nil then
          task.wait(0.05)
          v1161 = true
          break
        end

        if f8("Toggle_Farm_SeedGachaAutoBuyUndiscovered") then
          count28 = count28 + 1
          local v1166 = {}
          local v1167 = {}
          local v1168 = {}

          for key98 in pairs(lastRolledSeeds2) do
            table.insert(v1168, key98)
          end

          table.sort(v1168, function(p272, p273)
            return (tonumber(p272) or 0) < (tonumber(p273) or 0)
          end)

          for index179, value257 in ipairs(v1168) do
            local v1169 = f45(lastRolledSeeds2[value257]) or "Unknown"

            if f141(v1169) then
              table.insert(v1166, string.format("P%s: %s", tostring(value257), tostring(v1169)))
            else
              table.insert(v1167, tostring(v1169))
            end
          end

          local v1170 = #v1166 > 0 and table.concat(v1166, ", ") or "None"
          local v1171 = #v1167 > 0 and table.concat(v1167, ", ") or "None"

          v50(
            "[Gacha #%d] Unowned (%d): [%s] | Owned (%d): [%s]", count28, #v1166, v1170, #v1167,
            v1171
          )
        end

        local toggleFarmSeedGachaPauseIfFound = f8("Toggle_Farm_SeedGachaPauseIfFound")
        local v1172 = {}
        local v1173 = false
        local v1174 = {}

        if not farmSeedGachaPauseOnHackerEvent then
          local v1175 = {}

          for key99, value258 in pairs(lastRolledSeeds2) do
            local v1176, v1177 = f45(value258)
            local plants10 = v14.Plants and v14.Plants[v1176]
            local rarity13 = plants10 and plants10.Rarity or "Common"
            local grade6 = v1177 and v1177.Grade or "Standard"

            if f142(v1176, rarity13, grade6) and f143(key99, value258, v1164) then
              local v1178, v1179 = f54(value258, f6())
              local costText = v24.SeedCost(v1178, v1179)

              table.insert(v1175, {
                podiumIndex = key99,
                seedJSON = value258,
                name = v1176,
                rarity = rarity13,
                grade = grade6,
                cost = v1178,
                currency = v1179,
                costText = costText,
              })
            end
          end

          if toggleFarmSeedGachaPauseIfFound and #v1175 > 0 then
            v1172 = v1175
          elseif #v1175 > 0 then
            local v1180 = {}
            local v1181 = {}

            local function f144(p274)
              if v1181[p274] == nil then
                v1181[p274] = f55(p274)
              end

              return v1181[p274]
            end

            local function f145(p275, p276)
              v1181[p275] = (v1181[p275] or f55(p275)) - p276
            end

            for index180, value259 in ipairs(v1175) do
              if not f140() then
                break
              end

              if (v15.RollVersion or 0) ~= rollVersion then
                v1173 = true
                break
              end

              local currency = value259.currency or "Cash"
              local v1182 = f144(currency) >= value259.cost

              if currency == "Cash" and f8("Toggle_Farm_SeedGachaPauseIfNotEnoughCash")
                and not v1182 then
                if not v1158 then
                  v1158 = true

                  v22.Gacha(string.format(
                    "Not enough Cash for %s (%s)! Auto roll paused.", value259.name,
                    value259.costText
                  ), 5)
                end

                while not v6.Unloaded and f140()
                  and f8("Toggle_Farm_SeedGachaPauseIfNotEnoughCash")
                  and not (f19() >= value259.cost) and (v15.RollVersion or 0) == rollVersion do
                  task.wait(0.2)
                end

                v1182 = f19() >= value259.cost
                v1181.Cash = f19()
              elseif not v1182 then
                if not v1158 then
                  v1158 = true

                  v22.Gacha(string.format(
                    "Not enough %s for %s (%s)!", currency, value259.name, value259.costText
                  ), 4)
                end
              end

              if not f140() then
                break
              end

              if (v15.RollVersion or 0) ~= rollVersion then
                v1158 = false
                v1173 = true
                break
              end

              if v1182 and not v1164[value259.podiumIndex] then
                v1158 = false
                f145(currency, value259.cost)
                table.insert(v1180, value259)
              end
            end

            if #v1180 > 0 and not v1173 then
              for index181, value260 in ipairs(v1180) do
                if not f140() then
                  break
                end

                if (v15.RollVersion or 0) ~= rollVersion then
                  v1173 = true
                  break
                end

                v23.FireServer("BuyRolledSeed", value260.podiumIndex)
                v1164[value260.podiumIndex] = true
                task.wait(0.15)
              end

              local v1183 = f16()
              local v1184 = tick()

              while tick() - v1184 < 0.35 do
                local v1185 = true

                for index182, value261 in ipairs(v1180) do
                  local findFirstChild23 = v1183 and v1183:FindFirstChild("SeedRoller")
                    and v1183.SeedRoller:FindFirstChild("Seed" .. tostring(value261.podiumIndex))

                  if not (findFirstChild23 and findFirstChild23:GetAttribute("Bought") ~= nil) then
                    v1185 = false
                    break
                  end
                end

                if v1185 then
                  break
                end

                task.wait(0.02)
              end

              for index183, value262 in ipairs(v1180) do
                local findFirstChild24 = v1183 and v1183:FindFirstChild("SeedRoller")
                  and v1183.SeedRoller:FindFirstChild("Seed" .. tostring(value262.podiumIndex))

                if not findFirstChild24 or findFirstChild24:GetAttribute("Bought") ~= nil then
                  table.insert(v1174, { name = value262.name, costText = value262.costText })
                else
                  v1164[value262.podiumIndex] = nil
                end
              end
            end
          end

          if #v1174 == 1 then
            v22.Gacha(string.format("Bought %s for %s", v1174[1].name, v1174[1].costText), 3)
          elseif #v1174 > 1 then
            local v1186 = {}

            for index184, value263 in ipairs(v1174) do
              table.insert(v1186, string.format("%s (%s)", value263.name, value263.costText))
            end

            v22.Gacha(
              string.format("Bought %d seeds: %s", #v1174, table.concat(v1186, ", ")), 4
            )
          end
        end

        if not f140() then
          break
        end

        if v1173 or (v15.RollVersion or 0) ~= rollVersion then
          v1161 = true
          break
        end

        if not farmSeedGachaPauseOnHackerEvent and toggleFarmSeedGachaPauseIfFound
          and #v1172 > 0 then
          local v1187 = {}

          for index185, value264 in ipairs(v1172) do
            table.insert(v1187, string.format("%s (%s)", value264.name, value264.costText))
          end

          v22.Gacha(string.format(
            "Target found: %s! Auto roll paused because *Pause if found* is enabled.",
            table.concat(v1187, ", ")
          ), 5)

          while not v6.Unloaded and f140() and f8("Toggle_Farm_SeedGachaPauseIfFound")
            and (v15.RollVersion or 0) == rollVersion do
            local v1188 = false
            local v1189 = f16()

            for index186, value265 in ipairs(v1172) do
              local findFirstChild25 = v1189 and v1189:FindFirstChild("SeedRoller")
                and v1189.SeedRoller:FindFirstChild("Seed" .. tostring(value265.podiumIndex))

              if not (findFirstChild25 and findFirstChild25:GetAttribute("Bought") ~= nil)
                and f142(value265.name, value265.rarity, value265.grade)
                and f143(value265.podiumIndex, value265.seedJSON, v1164) then
                v1188 = true
                break
              end
            end

            if not v1188 then
              break
            end

            task.wait(0.2)
          end

          if (v15.RollVersion or 0) ~= rollVersion then
            v1161 = true
            break
          end
        end

        if not f140() then
          break
        end

        local v1190 = (v15.FarmSeedGachaRollDelay or f8("Slider_Farm_SeedGachaRollDelay") or 2.5)
          - (tick() - v1163)

        local total30 = 0

        while not v6.Unloaded and total30 < v1190 do
          if not f140() then
            break
          end

          if (v15.RollVersion or 0) ~= rollVersion then
            break
          end

          task.wait(0.05)
          total30 = total30 + 0.05
        end

        v1161 = true
      until true

      if not v1161 then
        break
      end
    end

    v15.IsSeedGachaLoopRunning = false
  end)
end

local function f146()
  if v15.IsSuperRollerAutoInsertTokenLoopRunning then
    return
  end

  v15.IsSuperRollerAutoInsertTokenLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and f8("Toggle_Farm_SuperRollerAutoInsertToken") do
      local superRollerToken = f78("Super Roller Token")

      if superRollerToken then
        f81(superRollerToken)
        local character12 = localPlayer.Character
        local tool2 = character12 and character12:FindFirstChildOfClass("Tool")

        if tool2
          and (tool2:GetAttribute("GearName") == "Super Roller Token"
            or string.find(tool2.Name, "Super Roller Token", 1, true)) then
          local gearIndex5 = tool2:GetAttribute("GearIndex")

          if gearIndex5 ~= nil then
            v23.FireServer("InsertSuperRollerToken", gearIndex5)
          end
        end
      end

      task.wait(3)
    end

    v15.IsSuperRollerAutoInsertTokenLoopRunning = false
  end)
end

local function f147()
  if v15.IsSuperRollerAutoRollLoopRunning then
    return
  end

  v15.IsSuperRollerAutoRollLoopRunning = true

  task.spawn(function()
    local v1191 = -1

    while not v6.Unloaded and f8("Toggle_Farm_SuperRollerAutoRoll") do
      local v1192 = false

      repeat
        local superRollerRollVersion = v15.SuperRollerRollVersion or 0

        if v1191 == superRollerRollVersion then
          local superRollerRolls = f38("SuperRollerRolls")

          if superRollerRolls ~= nil and superRollerRolls <= 0 then
            task.wait(2)
            v1192 = true
            break
          end

          v15.SuperRollerStarted = false
          v15.SuperRollerFinished = false
          v15.SuperRollerResult = nil
          v15.SuperRollerStopSent = false
          v15.SuperRollerState = nil

          v23.FireServer("UseSuperRoller", false)
          local v1193 = tick()

          while not v6.Unloaded and not v15.SuperRollerStarted and tick() - v1193 < 4 do
            if not f8("Toggle_Farm_SuperRollerAutoRoll") then
              break
            end

            task.wait(0.05)
          end

          if not v15.SuperRollerStarted then
            task.wait(5)
            v1192 = true
            break
          end

          local superRollerStartTime = v15.SuperRollerStartTime or time()

          local sliderFarmSuperRollerTargetStopLuck = f8("Slider_Farm_SuperRollerTargetStopLuck")
            or 10

          local v1194 = math.max(0, (sliderFarmSuperRollerTargetStopLuck - 1) / 1.25) + 0.3
          local v1195 = tick()

          while not v6.Unloaded and not v15.SuperRollerFinished and tick() - v1195 < 60 do
            if not f8("Toggle_Farm_SuperRollerAutoRoll") then
              break
            end

            if f8("Toggle_Farm_SuperRollerAutoStopLuck") and not v15.SuperRollerStopSent then
              if time() - superRollerStartTime >= v1194 then
                v15.SuperRollerStopSent = true
                v23.FireServer("UseSuperRoller", true)
              end
            end

            task.wait(0.05)
          end

          superRollerRollVersion = v15.SuperRollerRollVersion or 0
        end

        if not f8("Toggle_Farm_SuperRollerAutoRoll") then
          break
        end

        v1191 = superRollerRollVersion
        local superRollerResult = v15.SuperRollerResult

        if superRollerResult and superRollerResult.SeedName then
          local seedName9 = superRollerResult.SeedName
          local v1196 = f45(seedName9)
          local luck = superRollerResult.Luck or 1
          local v1197 = superRollerResult.Crashed == true

          if f8("Toggle_Farm_SuperRollerAutoBuySeed") then
            local v1198, v1199 = f54(seedName9, f6())
            local v1200 = f55(v1199) >= v1198
            local v1201 = v24.SeedCost(v1198, v1199)

            if v1199 == "Cash" and f8("Toggle_Farm_SuperRollerPauseIfNotEnoughCash")
              and not v1200 then
              v22.Gacha(string.format(
                "[Super Roller] Need %s for %s, paused.", v1201, v1196 or seedName9
              ), 4)

              while not v6.Unloaded and f8("Toggle_Farm_SuperRollerAutoRoll")
                and f8("Toggle_Farm_SuperRollerPauseIfNotEnoughCash") and not (f19() >= v1198)
                and (v15.SuperRollerRollVersion or 0) == superRollerRollVersion
                and not v15.SuperRollerSeedBought do
                task.wait(0.2)
              end
            end

            local v1202 = f55(v1199) >= v1198

            if (v15.SuperRollerRollVersion or 0) == superRollerRollVersion
              and not v15.SuperRollerSeedBought and v1202 then
              v23.FireServer("BuySuperRollerSeed")

              v22.Gacha(string.format(
                "[Super Roller] Bought %s for %s (%.2fx luck%s)", v1196 or seedName9, v1201,
                luck, v1197 and ", Crashed" or ""
              ), 4)
            end
          end
        end

        if (v15.SuperRollerRollVersion or 0) ~= superRollerRollVersion then
          v1192 = true
          break
        end

        local total31 = 0

        while not v6.Unloaded and total31 < 5 do
          if not f8("Toggle_Farm_SuperRollerAutoRoll") then
            break
          end

          if (v15.SuperRollerRollVersion or 0) ~= superRollerRollVersion then
            break
          end

          task.wait(0.1)
          total31 = total31 + 0.1
        end

        v1192 = true
      until true

      if not v1192 then
        break
      end
    end

    v15.IsSuperRollerAutoRollLoopRunning = false
  end)
end

local function f148()
  if v15.IsAutoDiscardSeedsLoopRunning then
    return
  end

  v15.IsAutoDiscardSeedsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.FarmDiscardAutoDiscardByRarity or f8("Toggle_Farm_DiscardAutoDiscardByRarity")) do
      pcall(function()
        local v1203 = f6()

        local seeds2 = not v15.PlayerDataComplete and v26.Get("Seeds") or v1203 and v1203.Seeds
          or v26.Get("Seeds")

        if type(seeds2) ~= "table" or next(seeds2) == nil then
          local v1204 = {}

          local function f149(p277)
            if not p277 then
              return
            end

            for index187, value266 in ipairs(p277:GetChildren()) do
              if value266:IsA("Tool") then
                local seedName10 = value266:GetAttribute("SeedName")
                  or value266:GetAttribute("SeedStack")

                if type(seedName10) == "string" and seedName10 ~= "" then
                  local amount8 = value266:GetAttribute("Amount")

                  if type(amount8) ~= "number" or amount8 <= 0 then
                    amount8 = f80(value266)
                  end

                  v1204[seedName10] = (v1204[seedName10] or 0) + math.max(1, amount8)
                end
              end
            end
          end

          f149(localPlayer:FindFirstChild("Backpack"))
          f149(localPlayer.Character)

          seeds2 = v1204
        end

        if not seeds2 or next(seeds2) == nil then
          if v15.DebugDataAccess then
            v50("[Debug] Discard: no seeds even after mirror merge")
          end

          return
        end

        if v15.DebugDataAccess then
          v50("[Debug] Discard: %d distinct seed stacks visible", v25.CountKeys(seeds2))
        end

        local dropdownFarmDiscardTargetRarities = f8("Dropdown_Farm_DiscardTargetRarities")

        if type(dropdownFarmDiscardTargetRarities) ~= "table"
          or next(dropdownFarmDiscardTargetRarities) == nil then
          return
        end

        local favoritedSeeds2 = v1203 and type(v1203.FavoritedSeeds) == "table"
            and v1203.FavoritedSeeds
          or nil

        local v1205 = {}
        local total32 = 0

        for key100, value267 in pairs(seeds2) do
          if type(value267) == "number" and value267 > 0 then
            if not (favoritedSeeds2 and favoritedSeeds2[key100] == true) then
              local v1206 = f45(key100)

              if not v1206 and v14.Plants and v14.Plants[key100] then
                v1206 = key100
              end

              if v1206 then
                local rarity14 = v14.Plants and v14.Plants[v1206] and v14.Plants[v1206].Rarity

                if rarity14 and dropdownFarmDiscardTargetRarities[rarity14] == true then
                  v1205[key100] = value267
                  total32 = total32 + value267
                end
              end
            end
          end
        end

        if total32 <= 0 then
          return
        end

        local v1207 = false
        f46()

        if v15.PlayerDataComplete and v12 and v12.WouldRemoveLastSeed and v1203 and v1203.Seeds
          and next(v1203.Seeds) ~= nil then
          local v1208, v1209 = pcall(v12.WouldRemoveLastSeed, v1203, total32)

          if v1208 and type(v1209) == "boolean" then
            v1207 = v1209
          end
        else
          local total33 = 0

          for key101, value268 in pairs(seeds2) do
            if type(value268) == "number" and value268 > 0 then
              total33 = total33 + value268
            end
          end

          v1207 = total33 - total32 < 1
        end

        if v1207 then
          return
        end

        local v1210 = v23.FireServer("DiscardSeeds", v1205)
      end)

      local total34 = 0

      while not v6.Unloaded and total34 < 5 do
        if not (v15.FarmDiscardAutoDiscardByRarity or f8("Toggle_Farm_DiscardAutoDiscardByRarity")) then
          break
        end

        task.wait(0.5)
        total34 = total34 + 0.5
      end
    end

    v15.IsAutoDiscardSeedsLoopRunning = false
  end)
end

local function f150()
  if v15.IsAutoLikePlotsLoopRunning then
    return
  end

  v15.IsAutoLikePlotsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and (v15.MiscAutoLikePlots or f8("Toggle_Misc_AutoLikePlots")) do
      pcall(function()
        local plots2 = workspace:FindFirstChild("Plots")

        if not plots2 then
          return
        end

        local likedPlots = f38("LikedPlots") or {}

        for index188, value269 in ipairs(plots2:GetChildren()) do
          if not (v15.MiscAutoLikePlots or f8("Toggle_Misc_AutoLikePlots")) or v6.Unloaded then
            break
          end

          local occupant2 = value269:GetAttribute("Occupant")

          if occupant2 and occupant2 ~= localPlayer.UserId then
            local v1211 = tostring(occupant2)

            if not likedPlots[v1211]
              and not (v16.LocalLikedPlots and v16.LocalLikedPlots[v1211]) then
              if not v16.LocalLikedPlots then
                v16.LocalLikedPlots = {}
              end

              v16.LocalLikedPlots[v1211] = true
              local v1212 = v23.FireServer("LikePlot", occupant2)
              task.wait(0.2)
            end
          end
        end
      end)

      task.wait(5)
    end

    v15.IsAutoLikePlotsLoopRunning = false
  end)
end

local function f151()
  if v15.IsAutoClaimDailyRewardLoopRunning then
    return
  end

  v15.IsAutoClaimDailyRewardLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and (v15.EventsAutoClaimDaily or f8("Toggle_Events_AutoClaimDaily")) do
      pcall(function()
        local v1213 = f6()
        local availableDailyRewards = v1213 and v1213.AvailableDailyRewards
        local claimedDailyRewards = v1213 and v1213.ClaimedDailyRewards

        local v1214 = type(availableDailyRewards) == "table"
          and type(claimedDailyRewards) == "table"

        for i41 = 1, 7 do
          if not (v15.EventsAutoClaimDaily or f8("Toggle_Events_AutoClaimDaily")) or v6.Unloaded then
            break
          end

          local v1215 = claimedDailyRewards and claimedDailyRewards[i41] == true

          local v1216 = not v1214
            or availableDailyRewards and availableDailyRewards[i41] == true

          if not v1215 and v1216 then
            local v1217 = v23.FireServer("ClaimDailyReward", i41)
            task.wait(1)
            local v1218 = f6()
            local claimedDailyRewards2 = v1218 and v1218.ClaimedDailyRewards

            if claimedDailyRewards2 and claimedDailyRewards2[i41] == true then
              v22.Reward(string.format("Claimed Day %d Daily Reward!", i41), 4, true)
            end
          end
        end
      end)

      task.wait(60)
    end

    v15.IsAutoClaimDailyRewardLoopRunning = false
  end)
end

local function f152()
  if v15.IsAutoClaimGroupRewardLoopRunning then
    return
  end

  v15.IsAutoClaimGroupRewardLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and (v15.EventsAutoClaimGroup or f8("Toggle_Events_AutoClaimGroup")) do
      local v1219 = false

      pcall(function()
        local v1220 = f6()

        if v1220 and v1220.GroupRewardClaimed == true then
          v1219 = true
          return
        end

        if v23.InvokeServer("ClaimGroupReward") == true then
          v1219 = true
          v22.Reward("Claimed Roblox Group Reward successfully!", 4, true)
        else
          task.wait(1)
          local v1221 = f6()

          if v1221 and v1221.GroupRewardClaimed == true then
            v1219 = true
            v22.Reward("Claimed Roblox Group Reward successfully!", 4, true)
          end
        end
      end)

      if v1219 then
        break
      end

      task.wait(60)
    end

    v15.IsAutoClaimGroupRewardLoopRunning = false
  end)
end

local function f153()
  if v15.IsUpdateEventsParagraphLoopRunning then
    return
  end

  v15.IsUpdateEventsParagraphLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded do
      local v1222 = false

      repeat
        if f10() then
          f11(v18.EventsCurrentEvent)
          f11(v18.EventsGuildOverview)
          f11(v18.EventsHackerOverview)
          f11(v18.EventsAdminOverview)

          task.wait(5)
          v1222 = true
          break
        end

        pcall(function()
          if not v18.EventsCurrentEvent then
            return
          end

          local v1223 = {}
          local activeEvents4 = replicatedStorage:FindFirstChild("ActiveEvents")

          if activeEvents4 and #activeEvents4:GetChildren() > 0 then
            for index189, value270 in ipairs(activeEvents4:GetChildren()) do
              local totalTime = value270:GetAttribute("TotalTime") or 150
              local elapsedTime = value270:GetAttribute("ElapsedTime") or 0
              local v1224 = math.max(0, math.ceil(totalTime - elapsedTime))

              table.insert(v1223, string.format(
                "- Active Event: <font color=\"#00E676\">%s</font> (<font color=\"#FFD700\">%s</font> remaining)",
                value270.Name, v24.Clock(v1224)
              ))
            end
          else
            table.insert(v1223, "- Active Event: <font color=\"#888888\">None</font>")
          end

          local nextEventStart = workspace:GetAttribute("NextEventStart")

          if nextEventStart then
            local v1225 = math.max(0, math.ceil(nextEventStart - workspace:GetServerTimeNow()))

            table.insert(v1223, string.format(
              "- Next Event in: <font color=\"#00E676\">%s</font>", v24.Clock(v1225)
            ))
          else
            table.insert(
              v1223,
              "- Next Event in: <font color=\"#888888\">Waiting for server schedule...</font>"
            )
          end

          f11(v18.EventsCurrentEvent, table.concat(v1223, "\n"))
        end)

        pcall(v27.UpdateParagraph)

        if v30.UpdateHackerParagraph then
          pcall(v30.UpdateHackerParagraph)
        end

        if v30.UpdateAdminParagraph then
          pcall(v30.UpdateAdminParagraph)
        end

        task.wait(5)
        v1222 = true
      until true

      if not v1222 then
        break
      end
    end

    v15.IsUpdateEventsParagraphLoopRunning = false
  end)
end

function v27.StartAutoClaimDailyQuestsLoop()
  if v15.IsAutoClaimGuildDailyQuestsLoopRunning then
    return
  end

  v15.IsAutoClaimGuildDailyQuestsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.EventsGuildAutoClaimDailyQuests or f8("Toggle_Events_GuildAutoClaimDailyQuests")) do
      pcall(function()
        if not v27.IsMember() then
          return
        end

        local v1226 = false
        local v1227 = f6()
        local guildQuests = v1227 and v1227.GuildQuests

        if type(guildQuests) == "table" and type(guildQuests.Quests) == "table" then
          for key102, value271 in pairs(guildQuests.Quests) do
            local v1228 = tonumber(value271.Target) or 0
            local v1229 = tonumber(value271.Progress) or 0

            if v1228 > 0 and v1229 >= v1228 and value271.Claimed ~= true then
              v23.FireServer("ClaimGuildQuest", key102)
              v1226 = true

              v22.Guild(string.format(
                "Claimed daily quest #%s: %s", tostring(key102),
                tostring(value271.Name or "Quest")
              ), 3)

              task.wait(0.5)
            end
          end
        end

        if not v1226 then
          local mainUI8 = localPlayer:FindFirstChild("PlayerGui")
            and localPlayer.PlayerGui:FindFirstChild("MainUI")

          local guildsFrame2 = mainUI8 and mainUI8:FindFirstChild("GuildsFrame")

          local questsHolder = guildsFrame2 and guildsFrame2:FindFirstChild("QuestsTab")
            and guildsFrame2.QuestsTab:FindFirstChild("QuestsPage")
            and guildsFrame2.QuestsTab.QuestsPage:FindFirstChild("DailyQuests")
            and guildsFrame2.QuestsTab.QuestsPage.DailyQuests:FindFirstChild("QuestsHolder")

          if questsHolder then
            for index190, value272 in ipairs(questsHolder:GetChildren()) do
              local claim2 = value272:FindFirstChild("Claim")

              if claim2 and claim2.Visible then
                local v1230 = tonumber(string.match(value272.Name, "%d+"))

                if v1230 then
                  v23.FireServer("ClaimGuildQuest", v1230)
                  v22.Guild(string.format("Claimed daily quest #%d", v1230), 3)
                  task.wait(0.5)
                end
              end
            end
          end
        end
      end)

      task.wait(15)
    end

    v15.IsAutoClaimGuildDailyQuestsLoopRunning = false
  end)
end

function v27.StartAutoClaimRewardLoop()
  if v15.IsAutoClaimGuildRewardLoopRunning then
    return
  end

  v15.IsAutoClaimGuildRewardLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.EventsGuildAutoClaimReward or f8("Toggle_Events_GuildAutoClaimReward")) do
      pcall(function()
        if not v27.IsMember() then
          return
        end

        local v1231 = v27.GetData()

        if v1231 and v1231.Reward and v1231.Reward.CanClaim == true
          and v1231.Reward.Claimed ~= true then
          v23.FireServer("ClaimGuildReward")
          v22.Reward("Claimed weekly guild competition reward!")
          task.wait(2)
          v23.FireServer("RequestGuildSnapshot")
        end
      end)

      task.wait(30)
    end

    v15.IsAutoClaimGuildRewardLoopRunning = false
  end)
end

function v30.StartCollectorLoop()
  if v15.IsAutoCollectorLoopRunning then
    return
  end

  v15.IsAutoCollectorLoopRunning = true

  local function f154(p278, p279)
    local v1232 = f6()
    local favoriteSeeds = v1232 and v1232.FavoriteSeeds or {}
    local rarityOrderMap7 = v14.RarityOrderMap or {}
    local gradeOrderMap = v14.GradeOrderMap or {}
    local backpack3 = localPlayer:FindFirstChild("Backpack")
    local character13 = localPlayer.Character
    local v1233 = {}
    local eventsCollectorIgnoreRarities = v15.EventsCollectorIgnoreRarities

    if eventsCollectorIgnoreRarities == nil then
      eventsCollectorIgnoreRarities = f8("Dropdown_Events_CollectorIgnoreRarities")
    end

    if eventsCollectorIgnoreRarities == nil then
      eventsCollectorIgnoreRarities = { Celestial = true, Eternal = true }
    end

    local function f155(p280)
      if not p280:IsA("Tool") then
        return
      end

      local seedName11 = p280:GetAttribute("SeedName")

      if not seedName11 then
        return
      end

      if favoriteSeeds[seedName11] then
        return
      end

      local v1234, v1235 = f45(seedName11)

      if not v1234 then
        return
      end

      local plants11 = v14.Plants and v14.Plants[v1234]
      local rarity15 = plants11 and plants11.Rarity or "Common"
      local rarityRank = rarityOrderMap7[rarity15] or 1

      if f50(eventsCollectorIgnoreRarities, rarity15) then
        return
      end

      local grade7 = v1235 and v1235.Grade or "Standard"
      local gradeRank = gradeOrderMap[grade7] or 2
      local price13 = f53(seedName11, v1232)

      table.insert(v1233, {
        Tool = p280,
        SeedJSON = seedName11,
        PlantName = v1234,
        Rarity = rarity15,
        RarityRank = rarityRank,
        Grade = grade7,
        GradeRank = gradeRank,
        Price = price13,
      })
    end

    if character13 then
      for index191, value273 in ipairs(character13:GetChildren()) do
        f155(value273)
      end
    end

    if backpack3 then
      for index192, value274 in ipairs(backpack3:GetChildren()) do
        f155(value274)
      end
    end

    if #v1233 == 0 then
      return nil, nil
    end

    table.sort(v1233, function(p281, p282)
      if p281.RarityRank ~= p282.RarityRank then
        return p281.RarityRank < p282.RarityRank
      end

      return p281.Price < p282.Price
    end)

    local v1236 = string.lower(p279 or "")
    local v1237 = nil
    local v1238 = nil
    local v1239 = nil
    local v1240 = nil
    local v1241 = nil

    if p278 == "Seed" then
      for key103, value275 in pairs(rarityOrderMap7) do
        local v1242 = string.lower(key103)

        if string.find(v1236, "%f[%a]" .. v1242 .. "%+") then
          v1237 = value275
        elseif string.find(v1236, "%f[%a]" .. v1242 .. "%f[%A]")
          and not string.find(v1236, "%+") then
          v1238 = value275
        end
      end

      for key104, value276 in pairs(gradeOrderMap) do
        local v1243 = string.lower(key104)

        if string.find(v1236, "%f[%a]" .. v1243 .. "%+") then
          v1239 = value276
        elseif string.find(v1236, "%f[%a]" .. v1243 .. "%f[%A]")
          and string.find(v1236, "grade") then
          v1240 = value276
        end
      end
    elseif p278 == "SeedValue" then
      local v1244 = string.match(p279 or "", "%$[%d%,%.]+%a*")

      if v1244 then
        v1241 = f18(v1244)
      end
    end

    for index193, value277 in ipairs(v1233) do
      local v1245 = true

      if v1237 and value277.RarityRank < v1237 then
        v1245 = false
      end

      if v1238 and value277.RarityRank ~= v1238 then
        v1245 = false
      end

      if v1239 and value277.GradeRank < v1239 then
        v1245 = false
      end

      if v1240 and value277.GradeRank ~= v1240 then
        v1245 = false
      end

      if v1241 and value277.Price < v1241 then
        v1245 = false
      end

      if v1245 then
        return value277.Tool, value277.SeedJSON
      end
    end

    return nil, nil
  end

  task.spawn(function()
    while not v6.Unloaded
      and (v15.EventsAutoSubmitCollector or f8("Toggle_Events_AutoSubmitCollector")) do
      pcall(function()
        local theCollector = workspace:FindFirstChild("The Collector")

        if not theCollector then
          return
        end

        if theCollector:GetAttribute("TargetUserId") ~= localPlayer.UserId then
          return
        end

        if theCollector:GetAttribute("Phase") ~= "Waiting" then
          return
        end

        local questType = theCollector:GetAttribute("QuestType")
        local questItem = theCollector:GetAttribute("QuestItem")
        local endTime = theCollector:GetAttribute("EndTime")
        local v1246 = nil
        local v1247 = nil
        local gearIndex6 = nil

        if questType == "Cash" or questType == "Honey" then
        elseif questType == "Seed" or questType == "SeedValue" then
          local v1248, v1249 = f154(questType, questItem)

          if not v1248 then
            if v16.CollectorNotifiedEndTime ~= endTime then
              v16.CollectorNotifiedEndTime = endTime

              v22.Event("No eligible seed found for The Collector (" .. tostring(questItem or "")
                .. ")")
            end

            return
          end

          v1246 = v1248
          v1247 = "Seeds"
          gearIndex6 = v1249
        elseif questType == "Gear" then
          local v1250 = string.lower(questItem or "")
          local eventsCollectorIgnoreGears = v15.EventsCollectorIgnoreGears

          if eventsCollectorIgnoreGears == nil then
            eventsCollectorIgnoreGears = f8("Dropdown_Events_CollectorIgnoreGears")
          end

          if eventsCollectorIgnoreGears == nil then
            eventsCollectorIgnoreGears = {
              ["Gilded Spray"] = true,
              ["Admin Spray"] = true,
              ["Butterfly Spray"] = true,
              ["Ironclad Spray"] = true,
              ["Haunted Spray"] = true,
              ["Hacker Spray"] = true,
              ["Acid Spray"] = true,
              ["Super Fertilizer"] = true,
              ["Super Pet Treat"] = true,
            }
          end

          local function f156(p283)
            if not p283:IsA("Tool") or not p283:GetAttribute("GearIndex") then
              return false
            end

            local name9 = p283.Name

            local v1251 = string.gsub(name9, "%s*%[.*%]", "")
            v1251 = string.gsub(v1251, "%s*%(.*%)", "")
            v1251 = string.gsub(v1251, "%s+[xX]%d+", "")
            v1251 = string.match(v1251, "^%s*(.-)%s*$") or name9

            if f50(eventsCollectorIgnoreGears, v1251) or f50(eventsCollectorIgnoreGears, name9) then
              return false
            end

            local v1252 = string.lower(name9)

            if string.find(v1250, "spray") then
              return string.find(v1252, "spray") ~= nil
            elseif string.find(v1250, "fertilizer") and string.find(v1250, "treat") then
              return string.find(v1252, "fertilizer") ~= nil
                or string.find(v1252, "treat") ~= nil
            elseif string.find(v1250, "fertilizer") then
              return string.find(v1252, "fertilizer") ~= nil
            elseif string.find(v1250, "treat") then
              return string.find(v1252, "treat") ~= nil
            end

            return false
          end

          local v1253 = {}

          local function f157(p284)
            if not p284 then
              return
            end

            for index194, value278 in ipairs(p284:GetChildren()) do
              if f156(value278) then
                local v1254 = string.gsub(value278.Name, "%s*%[.*%]", "")
                v1254 = string.gsub(v1254, "%s*%(.*%)", "")
                v1254 = string.gsub(v1254, "%s+[xX]%d+", "")
                v1254 = string.match(v1254, "^%s*(.-)%s*$") or value278.Name

                local gears6 = v14.Gears and v14.Gears[v1254]
                  or v14.Sprays and v14.Sprays[v1254]
                  or v14.Fertilizers and v14.Fertilizers[v1254]
                  or v14.PetTreats and v14.PetTreats[v1254]

                local rarityOrderMap8 = gears6 and gears6.Rarity and v14.RarityOrderMap
                    and v14.RarityOrderMap[gears6.Rarity]
                  or 1

                local shopPrice2 = gears6 and (gears6.ShopPrice or gears6.Price) or 0

                table.insert(v1253, {
                  Tool = value278,
                  Rank = rarityOrderMap8,
                  Price = shopPrice2,
                })
              end
            end
          end

          f157(localPlayer.Character)
          f157(localPlayer:FindFirstChild("Backpack"))

          local tool3 = nil

          if #v1253 > 0 then
            table.sort(v1253, function(p285, p286)
              if p285.Rank ~= p286.Rank then
                return p285.Rank < p286.Rank
              end

              return p285.Price < p286.Price
            end)

            tool3 = v1253[1].Tool
          end

          if not tool3 then
            if v16.CollectorNotifiedEndTime ~= endTime then
              v16.CollectorNotifiedEndTime = endTime

              v22.Event("No eligible gear found for The Collector (" .. tostring(questItem or "")
                .. ")")
            end

            return
          end

          v1246 = tool3
          v1247 = "Gears"
          gearIndex6 = tool3:GetAttribute("GearIndex")
        end

        local v1255 = f13()

        if not v1255 then
          return
        end

        if not f14(theCollector:GetPivot() + Vector3.new(0, 2, 4)) then
          return
        end

        task.wait(0.3)

        if v1246 and v1247 and gearIndex6 then
          local character14 = localPlayer.Character
          local humanoid3 = character14 and character14:FindFirstChildOfClass("Humanoid")

          if humanoid3 and v1246.Parent ~= character14 then
            humanoid3:EquipTool(v1246)
            task.wait(0.2)
          end

          local v1256 = v23.FireServer("SubmitToCollector", v1247, gearIndex6)

          v22.Event(string.format(
            "Submitted %s '%s' to The Collector!", v1247, tostring(v1246.Name)
          ))
        else
          local submitToCollector = v23.FireServer("SubmitToCollector")
          v22.Event(string.format("Submitted %s to The Collector!", tostring(questType)))
        end

        local v1257 = tick()

        while tick() - v1257 < 1.5 do
          if not theCollector:IsDescendantOf(workspace)
            or theCollector:GetAttribute("Phase") ~= "Waiting" then
            break
          end

          if v1246 and (v1246.Parent == nil or not v1246:IsDescendantOf(game)) then
            break
          end

          task.wait(0.1)
        end

        f14(v1255)
      end)

      task.wait(1.5)
    end

    v15.IsAutoCollectorLoopRunning = false
  end)
end

function v30.StartTrainVoyageLoop()
  if v15.IsAutoTrainVoyageLoopRunning then
    return
  end

  v15.IsAutoTrainVoyageLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded and (v15.EventsAutoTrainVoyage or f8("Toggle_Events_AutoTrainVoyage")) do
      pcall(function()
        local activeEvents5 = replicatedStorage:FindFirstChild("ActiveEvents")

        if not activeEvents5 or not activeEvents5:FindFirstChild("Train Voyage") then
          return
        end

        local trainCarts2 = workspace:GetAttribute("TrainCarts")

        if type(trainCarts2) ~= "string" then
          return
        end

        local v1258, v1259 = pcall(httpService.JSONDecode, httpService, trainCarts2)

        if not v1258 or type(v1259) ~= "table" then
          return
        end

        local v1260, v1261 = nil, nil

        for key105, value279 in pairs(v1259) do
          if value279 and value279.UserId == localPlayer.UserId then
            v1260 = tonumber(key105)
            v1261 = value279
            break
          end
        end

        if not v1261 or v1261.Completed == true then
          return
        end

        local v1262 = f6()
        local fruitsToSell = v1262 and v1262.PlotSave and v1262.PlotSave.FruitsToSell or {}
        local total35 = 0

        for key106, value280 in pairs(fruitsToSell) do
          if type(value280) == "number" then
            total35 = total35 + value280
          end
        end

        if total35 <= 0 then
          return
        end

        local train = workspace:FindFirstChild("Train")
        local findFirstChild26 = train and train:FindFirstChild("Cart" .. tostring(v1260))

        if not findFirstChild26 then
          return
        end

        local v1263 = f13()

        if not v1263 then
          return
        end

        if not f14(findFirstChild26:GetPivot() + Vector3.new(0, 3, 5)) then
          return
        end

        task.wait(0.4)
        local v1264, v1265 = v23.InvokeServer("SubmitTrainCrate")

        if v1264 and v1265 and v1265 ~= 0 then
          v22.Event("Delivered fruits to your train cart!")
        end

        task.wait(0.2)
        f14(v1263)
      end)

      task.wait(10)
    end

    v15.IsAutoTrainVoyageLoopRunning = false
  end)
end

function v30.UpdateHackerParagraph()
  if not v18.EventsHackerStatus then
    return
  end

  if f10() then
    f11(v18.EventsHackerStatus)
    return
  end

  local v1266 = v30.GetPlayerBytes()

  local activeEvents6 = replicatedStorage:FindFirstChild("ActiveEvents")
    or workspace:FindFirstChild("ActiveEvents")

  local hackerInvasion = activeEvents6 and activeEvents6:FindFirstChild("Hacker Invasion")
  local v1267 = hackerInvasion ~= nil
  local v1268 = nil

  if v15.ExecCanScrape then
    local hackerBossController = replicatedStorage:FindFirstChild("Client")
      and replicatedStorage.Client:FindFirstChild("Controllers")
      and replicatedStorage.Client.Controllers:FindFirstChild("HackerBossController")

    v1268 = hackerBossController and f1(hackerBossController)
  end

  local getPhase = v1268 and v1268.GetPhase and v1268.GetPhase()
    or hackerInvasion and hackerInvasion:GetAttribute("HackerBossPhase") or "Inactive"

  local hackerBossHits = localPlayer:GetAttribute("HackerBossHits") or 0
  local dataMiners2 = workspace:FindFirstChild("Data Miners")

  local findFirstChild27 = dataMiners2
    and dataMiners2:FindFirstChild("Data Miner " .. tostring(localPlayer.UserId))

  local v1269 = "Not Found"

  if findFirstChild27 then
    local stored = findFirstChild27:GetAttribute("Stored") or 0
    local capacity = findFirstChild27:GetAttribute("Capacity") or 60
    local rate = findFirstChild27:GetAttribute("Rate") or 0
    v1269 = string.format("%d/%d Bytes (%d/s)", stored, capacity, rate)
  end

  local v1270 = string.format([[
- Bytes Balance: <font color="#00E5FF">%s</font>
- Event Status: <font color="%s">%s</font>
- Boss Phase: <font color="#FF9800">%s</font> (Your Hits: %d)
- Data Miner: <font color="#76FF03">%s</font>]], v24.Number(v1266), v1267 and "#00E676" or "#B0BEC5", v1267 and "ACTIVE" or "INACTIVE", tostring(getPhase), hackerBossHits, v1269)

  f11(v18.EventsHackerStatus, v1270)
end

function v30.UpdateAdminParagraph()
  if not v18.EventsAdminStatus then
    return
  end

  if f10() then
    f11(v18.EventsAdminStatus)
    return
  end

  local v1271 = v30.GetPlayerAdminCoins()

  local activeEvents7 = replicatedStorage:FindFirstChild("ActiveEvents")
    or workspace:FindFirstChild("ActiveEvents")

  local v1272 = activeEvents7 and activeEvents7:FindFirstChild("Admin") ~= nil
  local v1273 = f16()
  local plotUpgradeSign2 = v1273 and v1273:FindFirstChild("PlotUpgradeSign")
  local adminRollLuck = plotUpgradeSign2 and plotUpgradeSign2:GetAttribute("AdminRollLuck") or 1

  local adminRollPodiums = plotUpgradeSign2
      and plotUpgradeSign2:GetAttribute("AdminRollPodiums")
    or 1

  local v1274 = string.format([[
- Admin Coins: <font color="#FFD700">%s</font>
- Event Status: <font color="%s">%s</font>
- Admin Seed Luck: <font color="#00E5FF">Lv %d / 30</font>
- Admin Podiums: <font color="#76FF03">%d / 10</font>]], v24.Number(v1271), v1272 and "#00E676" or "#B0BEC5", v1272 and "ACTIVE" or "INACTIVE", adminRollLuck, adminRollPodiums)

  f11(v18.EventsAdminStatus, v1274)
end

function v30.TriggerHackerBossEvent()
  pcall(function()
    local v1275 = f3()
    local mainUI9 = v1275 and v1275:FindFirstChild("MainUI")
    local hackerBoss = mainUI9 and mainUI9:FindFirstChild("HackerBoss")
    local superButton = hackerBoss and hackerBoss:FindFirstChild("SuperButton")

    if superButton then
      if firesignal then
        pcall(firesignal, superButton.InputBegan, { UserInputType = Enum.UserInputType.Touch })
      end

      if getconnections then
        for index195, value281 in ipairs(getconnections(superButton.InputBegan)) do
          pcall(function()
            if value281.Fire then
              value281:Fire({ UserInputType = Enum.UserInputType.Touch })
            elseif value281.Function then
              value281.Function({ UserInputType = Enum.UserInputType.Touch })
            end
          end)
        end
      end
    end

    local virtualInputManager = game:GetService("VirtualInputManager")

    if virtualInputManager then
      virtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
      task.wait(0.01)
      virtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
    end
  end)
end

function v30.StartHackerBossFightLoop()
  if v15.IsHackerBossFightLoopRunning then
    return
  end

  v15.IsHackerBossFightLoopRunning = true

  task.spawn(function()
    local cframe4 = nil
    local v1276 = nil

    if v15.ExecCanScrape then
      local hackerBossController2 = replicatedStorage:FindFirstChild("Client")
        and replicatedStorage.Client:FindFirstChild("Controllers")
        and replicatedStorage.Client.Controllers:FindFirstChild("HackerBossController")

      v1276 = hackerBossController2 and f1(hackerBossController2)
    end

    while not v6.Unloaded
      and (v15.EventsHackerAutoBossFight or f8("Toggle_Events_HackerAutoBossFight")) do
      local v1277 = 0.35

      local activeEvents8 = replicatedStorage:FindFirstChild("ActiveEvents")
        or workspace:FindFirstChild("ActiveEvents")

      local hackerInvasion2 = activeEvents8 and activeEvents8:FindFirstChild("Hacker Invasion")

      local getPhase2 = v1276 and v1276.GetPhase and v1276.GetPhase()
        or hackerInvasion2 and hackerInvasion2:GetAttribute("HackerBossPhase") or "None"

      if hackerInvasion2 ~= nil
        and (getPhase2 == "Fight" or getPhase2 == "Rising"
          or v1276 and v1276.IsFightOn and v1276.IsFightOn() == true) then
        local character15 = localPlayer.Character

        local humanoidRootPart11 = character15
          and character15:FindFirstChild("HumanoidRootPart")

        local humanoid4 = character15 and character15:FindFirstChildOfClass("Humanoid")

        if humanoidRootPart11 and humanoid4 and humanoid4.Health > 0 then
          pcall(function()
            humanoid4:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            humanoid4:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
          end)

          if not cframe4 then
            cframe4 = humanoidRootPart11.CFrame

            v50(
              "[Hacker/Boss] 1x1x1x1 Boss fight started (Phase: %s). Positioned into Arena.",
              tostring(getPhase2)
            )

            v22.Event("1x1x1x1 Boss fight started! Fighting...")
          end

          pcall(function()
            local getServerTimeNow8 = workspace:GetServerTimeNow()

            local hackerBossCrashStart = hackerInvasion2:GetAttribute("HackerBossCrashStart")
              or 0

            local hackerBossCrashEnd = hackerInvasion2:GetAttribute("HackerBossCrashEnd") or 0

            local isCrashed = getServerTimeNow8 >= hackerBossCrashStart
                and getServerTimeNow8 < hackerBossCrashEnd
              or v1276 and v1276.IsCrashed and v1276.IsCrashed() == true

            local function f158(p287, p288)
              local position4 = humanoidRootPart11.Position

              if (Vector3.new(position4.X, 0, position4.Z) - Vector3.new(p287.X, 0, p287.Z)).Magnitude
                  > 5
                or math.abs(position4.Y - p287.Y) > 3.5 then
                if p288 then
                  humanoidRootPart11.CFrame = CFrame.lookAt(p287, p288)
                else
                  humanoidRootPart11.CFrame = CFrame.new(p287)
                end

                humanoidRootPart11.AssemblyLinearVelocity = Vector3.zero
                humanoidRootPart11.AssemblyAngularVelocity = Vector3.zero
              end
            end

            local position5 = nil
            local hackerBoss2 = workspace:FindFirstChild("HackerBoss")
            local king = hackerBoss2 and hackerBoss2:FindFirstChild("King")

            if king and king.PrimaryPart then
              position5 = king.PrimaryPart.Position
            elseif king then
              position5 = king:GetPivot().Position
            elseif v1276 and v1276.GetKingTarget then
              local v1278 = v1276.GetKingTarget()

              if v1278 then
                position5 = v1278.WorldPosition
                  or v1278:IsA("PVInstance") and v1278:GetPivot().Position
              end
            end

            if isCrashed then
              v30.RemoveHover()

              if v15.EventsHackerAutoSmash or f8("Toggle_Events_HackerAutoSmash") then
                if king then
                  pcall(function()
                    for index196, value282 in ipairs(king:GetDescendants()) do
                      if value282:IsA("BasePart") and value282.CanCollide then
                        value282.CanCollide = false
                      end
                    end
                  end)
                end

                local vector4 = position5 or Vector3.new(0, 1.4, 0)
                local vector5 = Vector3.new(vector4.X, 0, vector4.Z)

                if vector5.Magnitude < 0.5 then
                  vector5 = Vector3.new(0, 0, 1)
                else
                  vector5 = vector5.Unit
                end

                f158(Vector3.new(vector4.X, 4.8, vector4.Z) + vector5 * 11, vector4)
                v23.FireServer("HackerBossSmash")
                v30.TriggerHackerBossEvent()
                v50("[Hacker/Boss] Boss is CRASHED! Smashed boss with hammer.")
                v1277 = 0.28
              end
            else
              local v1279 = false

              if v15.EventsHackerAutoUplink or f8("Toggle_Events_HackerAutoUplink") then
                local v1280 = nil
                local hackerBossUplinks = hackerInvasion2:GetAttribute("HackerBossUplinks")

                if hackerBossUplinks and hackerBossUplinks ~= "" then
                  local v1281, v1282 = pcall(
                    httpService.JSONDecode, httpService, hackerBossUplinks
                  )

                  if v1281 and type(v1282) == "table" then
                    for index197, value283 in ipairs(v1282) do
                      if value283.Done == 0 and getServerTimeNow8 < (value283.End or 0) then
                        v1280 = value283
                        break
                      end
                    end
                  end
                end

                if v1280 then
                  v30.RemoveHover()
                  f158((Vector3.new(v1280.X, 4.8, v1280.Z)))
                  v1279 = true

                  v50(
                    "[Hacker/Boss] Capturing Uplink node %d at (%.1f, %.1f) - Progress: %.0f%%",
                    v1280.Id, v1280.X, v1280.Z, (v1280.P or 0) * 100
                  )

                  v1277 = 0.25
                end
              end

              if not v1279 then
                v30.RemoveHover()
                local vector6

                if position5 then
                  local vector7 = Vector3.new(position5.X, 0, position5.Z)
                  vector7 = vector7.Magnitude > 0.1 and vector7.Unit or Vector3.new(0, 0, 1)

                  vector6 = vector7 * 55 + Vector3.new(0, 4.8, 0)
                  f158(vector6, position5)
                else
                  vector6 = Vector3.new(0, 4.8, 55)
                  f158(vector6, Vector3.new(0, 1.34, 0))
                end

                v1277 = 0.35
              end

              local hackerBossAttack = hackerInvasion2:GetAttribute("HackerBossAttack")

              if hackerBossAttack and type(hackerBossAttack) == "string"
                and hackerBossAttack ~= "" then
                pcall(function()
                  local jsonDecode4 = httpService:JSONDecode(hackerBossAttack)

                  if jsonDecode4 and jsonDecode4.Id and v16.LastDodgedAttackId ~= jsonDecode4.Id then
                    v16.LastDodgedAttackId = jsonDecode4.Id

                    if jsonDecode4.Type == "FirewallSweep" then
                      humanoid4:ChangeState(Enum.HumanoidStateType.Jumping)
                      humanoidRootPart11.AssemblyLinearVelocity = Vector3.new(0, 35, 0)
                      v50("[Hacker/Boss] Jumped to dodge Firewall Sweep!")
                    elseif jsonDecode4.Type == "GlitchGrid" or jsonDecode4.Type == "DataBeam" then
                      if not v1279 then
                        humanoidRootPart11.CFrame = humanoidRootPart11.CFrame
                          * CFrame.new(8, 0, 0)
                      end

                      v50("[Hacker/Boss] Evaded %s danger zone!", tostring(jsonDecode4.Type))
                    end

                    v23.FireServer("HackerBossDodge", jsonDecode4.Id)
                  end
                end)
              end

              local hackerBossOverheat = hackerInvasion2:GetAttribute("HackerBossOverheat")

              if hackerBossOverheat and type(hackerBossOverheat) == "string"
                and hackerBossOverheat ~= "" then
                pcall(function()
                  local jsonDecode5 = httpService:JSONDecode(hackerBossOverheat)

                  if jsonDecode5 and type(jsonDecode5.Id) == "number"
                    and jsonDecode5.Id ~= v16.LastCounteredId then
                    local getServerTimeNow9 = workspace:GetServerTimeNow()

                    if jsonDecode5.Start <= getServerTimeNow9
                      and getServerTimeNow9 <= jsonDecode5.End then
                      v23.FireServer("HackerBossCounter", jsonDecode5.Id)
                      v16.LastCounteredId = jsonDecode5.Id

                      v50(
                        "[Hacker/Boss] Hit Counter on overheated Boss (ID: %d)!", jsonDecode5.Id
                      )

                      v22.Event("Countered Boss Overheat (+24 DMG)!")
                    end
                  end
                end)
              end
            end
          end)
        end
      else
        if cframe4 then
          v30.RemoveHover()
          task.wait(0.5)
          f14(cframe4)

          v50(
            "[Hacker/Boss] Boss fight finished/escaped (Phase: %s). Returned to plot.",
            tostring(getPhase2)
          )

          v22.Event("1x1x1x1 Boss fight finished! Returned to plot.")
          cframe4 = nil
        end

        v1277 = 1.5
      end

      task.wait(v1277)
    end

    if cframe4 then
      v30.RemoveHover()
      f14(cframe4)
      cframe4 = nil
    end

    v30.RemoveHover()
    v15.IsHackerBossFightLoopRunning = false
  end)
end

function v30.StartHackerGatheringLoop()
  if v15.IsHackerGatheringLoopRunning then
    return
  end

  v15.IsHackerGatheringLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.EventsHackerAutoStompBugs or f8("Toggle_Events_HackerAutoStompBugs")
        or v15.EventsHackerAutoCollectPiles or f8("Toggle_Events_HackerAutoCollectPiles")) do
      pcall(function()
        local character16 = localPlayer.Character

        local humanoidRootPart12 = character16
          and character16:FindFirstChild("HumanoidRootPart")

        local humanoid5 = character16 and character16:FindFirstChildOfClass("Humanoid")

        if not humanoidRootPart12 or not humanoid5 then
          return
        end

        if v15.IsHacking then
          return
        end

        if v15.EventsHackerAutoCollectPiles or f8("Toggle_Events_HackerAutoCollectPiles") then
          local bytesDrops = workspace:FindFirstChild("BytesDrops")

          if bytesDrops and #bytesDrops:GetChildren() > 0 then
            local getChildren = bytesDrops:GetChildren()
            v50("[Hacker/Gathering] Found %d Byte drops in workspace", #getChildren)

            for index198, value284 in ipairs(getChildren) do
              if v15.IsHacking then
                break
              end

              if not (v15.EventsHackerAutoCollectPiles or f8("Toggle_Events_HackerAutoCollectPiles")) then
                break
              end

              if value284.Name == "Byte" or value284.Name == "BytesDrop"
                or value284:FindFirstChild("BytesPickup") then
                local position6 = value284:IsA("PVInstance") and value284:GetPivot().Position
                  or value284:IsA("BasePart") and value284.Position

                if position6 then
                  if v15.IsHacking then
                    break
                  end

                  humanoidRootPart12.CFrame = CFrame.new(position6 + Vector3.new(0, 1.5, 0))
                  task.wait(0.08)
                  local id = value284:GetAttribute("Id") or value284:GetAttribute("DropId")

                  if id then
                    v23.FireServer("CollectBytes", { id })
                  else
                    v23.FireServer("CollectBytes", { value284.Name })
                  end

                  v50("[Hacker/Gathering] Collected Bytes drop at %s", tostring(position6))
                  task.wait(0.08)
                end
              end
            end
          end
        end

        if v15.EventsHackerAutoStompBugs or f8("Toggle_Events_HackerAutoStompBugs") then
          local v1283 = {}

          if v15.ExecCanScrape then
            local bytesController = replicatedStorage:FindFirstChild("Client")
              and replicatedStorage.Client:FindFirstChild("Controllers")
              and replicatedStorage.Client.Controllers:FindFirstChild("BytesController")

            local v1284 = bytesController and f1(bytesController)

            if v1284 and v1284.GetActiveBugs then
              local v1285 = v1284.GetActiveBugs()

              if type(v1285) == "table" then
                for index199, value285 in ipairs(v1285) do
                  if value285.Bug and not value285.Bug.Squashed and value285.Position then
                    table.insert(v1283, {
                      Id = value285.Bug.Id,
                      Position = value285.Position,
                      BugRef = value285.Bug,
                    })
                  end
                end
              end
            end
          end

          if #v1283 == 0 then
            local bytesDrops2 = workspace:FindFirstChild("BytesDrops")

            if bytesDrops2 then
              for index200, value286 in ipairs(bytesDrops2:GetChildren()) do
                if value286:IsA("Model")
                  and (value286.Name == "Bug" or value286.Name == "GoldenBug") then
                  local position7 = value286:GetPivot().Position

                  if position7 and position7.Y > -100 then
                    table.insert(v1283, {
                      Position = position7,
                      Model = value286,
                      Id = value286:GetAttribute("Id") or value286:GetAttribute("BugId"),
                    })
                  end
                end
              end
            end
          end

          if #v1283 > 0 then
            v50("[Hacker/Gathering] Found %d active glitch bugs to stomp", #v1283)
            local v1286 = humanoidRootPart12.Size.Y / 2 + (humanoid5.HipHeight or 2)

            for index201, value287 in ipairs(v1283) do
              local v1287 = false

              repeat
                if v15.IsHacking then
                  break
                end

                if not (v15.EventsHackerAutoStompBugs or f8("Toggle_Events_HackerAutoStompBugs")) then
                  break
                end

                if value287.BugRef and value287.BugRef.Squashed then
                  v1287 = true
                  break
                end

                if value287.Model and not value287.Model:IsDescendantOf(workspace) then
                  v1287 = true
                  break
                end

                local position8 = value287.Position

                if position8 then
                  if v15.IsHacking then
                    break
                  end

                  local v1288 = position8.Y + v1286 + 0.8

                  humanoidRootPart12.CFrame = CFrame.new(position8.X, v1288, position8.Z)
                  humanoidRootPart12.AssemblyLinearVelocity = Vector3.new(0, -6, 0)

                  humanoid5:ChangeState(Enum.HumanoidStateType.Freefall)

                  if value287.Id then
                    v23.FireServer("StompBug", value287.Id)
                  end

                  local model = (value287.Model and value287.Model.Name == "GoldenBug"
                        or value287.BugRef and value287.BugRef.Golden)
                      and 12
                    or 2

                  v50(
                    "[Hacker/Gathering] Stomped bug %s (+%d Bytes) at %s",
                    tostring(value287.Id), model, tostring(position8)
                  )

                  task.wait(0.18)
                end

                v1287 = true
              until true

              if not v1287 then
                break
              end
            end
          end
        end
      end)

      task.wait(0.8)
    end

    v15.IsHackerGatheringLoopRunning = false
  end)
end

function v30.StartHackerTerminalSolverLoop()
  if v15.IsHackerTerminalSolverLoopRunning then
    return
  end

  v15.IsHackerTerminalSolverLoopRunning = true

  task.spawn(function()
    local v1289 = nil

    if v15.ExecCanScrape then
      local hackTerminalController = replicatedStorage:FindFirstChild("Client")
        and replicatedStorage.Client:FindFirstChild("Controllers")
        and replicatedStorage.Client.Controllers:FindFirstChild("HackTerminalController")

      v1289 = hackTerminalController and f1(hackTerminalController)
    end

    while not v6.Unloaded
      and (v15.EventsHackerAutoSolveTerminals or f8("Toggle_Events_HackerAutoSolveTerminals")) do
      pcall(function()
        local activeEvents9 = replicatedStorage:FindFirstChild("ActiveEvents")
          or workspace:FindFirstChild("ActiveEvents")

        local hackerInvasion3 = activeEvents9
          and activeEvents9:FindFirstChild("Hacker Invasion")

        local v1290 = workspace:GetAttribute("HackTerminalsActive") == true

        if not hackerInvasion3 or not v1290 then
          task.wait(5)
          return
        end

        local getServerTimeNow10 = workspace:GetServerTimeNow()

        if getServerTimeNow10 < (v16.HackerTerminalCooldownUntil or 0) then
          local v1291 = math.ceil(v16.HackerTerminalCooldownUntil - getServerTimeNow10)
          task.wait(math.min(v1291, 5))
          return
        end

        local character17 = localPlayer.Character

        local humanoidRootPart13 = character17
          and character17:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart13 then
          return
        end

        local hackerHideout = workspace:FindFirstChild("Middle")
          and workspace.Middle:FindFirstChild("Hacker Hideout")

        local terminals = hackerHideout and hackerHideout:FindFirstChild("Terminals")

        if not terminals then
          task.wait(5)
          return
        end

        for index202, value288 in ipairs(terminals:GetChildren()) do
          local v1292 = false

          repeat
            if not (v15.EventsHackerAutoSolveTerminals
              or f8("Toggle_Events_HackerAutoSolveTerminals")) then
              break
            end

            local v1293 = tonumber(string.match(value288.Name, "^Terminal(%d+)$"))

            if not v1293 then
              v1292 = true
              break
            end

            local screen3 = value288:FindFirstChild("Screen")
            local display = screen3 and screen3:FindFirstChild("Display")
            local findFirstChild28 = display and display:FindFirstChild("Status", true)
            local findFirstChild29 = display and display:FindFirstChild("Sub", true)

            if findFirstChild28 and string.find(findFirstChild28.Text, "REBOOTING") then
              v16.HackerTerminalCooldownUntil = getServerTimeNow10 + (findFirstChild29 and tonumber(string.match(
                findFirstChild29.Text, "(%d+)"
              )) or 38) + 2

              break
            end

            local findFirstChild30 = value288:FindFirstChild("PromptAttachment", true)
            local position9 = value288:GetPivot().Position

            local worldPosition2 = findFirstChild30 and findFirstChild30.WorldPosition
              or position9

            local lookVector2 = findFirstChild30 and findFirstChild30.WorldCFrame.LookVector
              or value288:GetPivot().LookVector

            humanoidRootPart13.CFrame = CFrame.lookAt(
              worldPosition2 + lookVector2 * 2.5, worldPosition2
            )

            humanoidRootPart13.AssemblyLinearVelocity = Vector3.zero
            humanoidRootPart13.AssemblyAngularVelocity = Vector3.zero

            task.wait(0.2)
            v15.IsHacking = true
            v50("[Hacker/Terminals] Starting hack on Terminal %d...", v1293)
            local v1294 = false

            if v1289 and v1289.StartHack then
              pcall(function()
                v1289.StartHack(v1293)
                v1294 = true
              end)
            end

            if not v1294 then
              local proximityPrompt2 = findFirstChild30
                  and findFirstChild30:FindFirstChildWhichIsA("ProximityPrompt")
                or value288:FindFirstChildWhichIsA("ProximityPrompt", true)

              if proximityPrompt2 then
                proximityPrompt2.Enabled = true
                proximityPrompt2.RequiresLineOfSight = false
                proximityPrompt2.MaxActivationDistance = 25
                proximityPrompt2.HoldDuration = 0

                if type(fireproximityprompt) == "function" then
                  pcall(fireproximityprompt, proximityPrompt2, 0)
                  pcall(fireproximityprompt, proximityPrompt2)
                  v1294 = true
                elseif firesignal then
                  pcall(firesignal, proximityPrompt2.Triggered)
                  v1294 = true
                elseif getconnections then
                  for index203, value289 in ipairs(getconnections(proximityPrompt2.Triggered)) do
                    pcall(function()
                      if value289.Fire then
                        value289:Fire()
                        v1294 = true
                      elseif value289.Function then
                        value289.Function()
                        v1294 = true
                      end
                    end)
                  end
                end
              end

              if not v1294 then
                v23.FireServer("StartHack", v1293)
              end
            end

            local v1295 = os.clock() + 12

            while os.clock() < v1295 do
              if not v15.IsHacking and v16.HackerTerminalCooldownUntil
                and workspace:GetServerTimeNow() < v16.HackerTerminalCooldownUntil then
                break
              end

              task.wait(0.3)
            end

            v15.IsHacking = false
            task.wait(0.4)
            break
          until true

          if not v1292 then
            break
          end
        end
      end)

      task.wait(3)
    end

    v15.IsHackerTerminalSolverLoopRunning = false
  end)
end

function v30.StartHackerDataMinerLoop()
  if v15.IsHackerDataMinerLoopRunning then
    return
  end

  v15.IsHackerDataMinerLoopRunning = true

  task.spawn(function()
    local v1296 = nil

    if v15.ExecCanScrape then
      local dataMinerController = replicatedStorage:FindFirstChild("Client")
        and replicatedStorage.Client:FindFirstChild("Controllers")
        and replicatedStorage.Client.Controllers:FindFirstChild("DataMinerController")

      v1296 = dataMinerController and f1(dataMinerController)
    end

    while not v6.Unloaded
      and (v15.EventsHackerAutoCollectMiner or f8("Toggle_Events_HackerAutoCollectMiner")) do
      pcall(function()
        if v15.IsHacking then
          return
        end

        local dataMiners3 = workspace:FindFirstChild("Data Miners")
        local findFirstChild31 = nil

        if v1296 and v1296.GetOwnMiner then
          findFirstChild31 = v1296.GetOwnMiner()
        end

        if not findFirstChild31 and dataMiners3 then
          for index204, value290 in ipairs(dataMiners3:GetChildren()) do
            if value290:GetAttribute("OwnerId") == localPlayer.UserId then
              findFirstChild31 = value290
              break
            end
          end

          if not findFirstChild31 then
            findFirstChild31 = dataMiners3:FindFirstChild("Data Miner "
              .. tostring(localPlayer.UserId))
          end
        end

        if findFirstChild31 then
          local v1297 = tonumber(findFirstChild31:GetAttribute("Stored")) or 0
          local v1298 = tonumber(findFirstChild31:GetAttribute("Capacity")) or 60
          local v1299 = findFirstChild31:GetAttribute("Active") == true

          if v1297 >= 1 then
            if v15.IsHacking then
              return
            end

            local character18 = localPlayer.Character

            local humanoidRootPart14 = character18
              and character18:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart14 then
              if v15.IsHacking then
                return
              end

              local position10 = findFirstChild31:GetPivot().Position

              humanoidRootPart14.CFrame = CFrame.lookAt(
                position10 + Vector3.new(0, 0, 6), position10
              )

              task.wait(0.3)
              v23.FireServer("CollectMinedBytes")
              v50("[Hacker/Miner] Collected %d Bytes from Data Miner!", v1297)
              v22.Event(string.format("Collected %d Bytes from Data Miner!", v1297))
            end
          end
        end
      end)

      task.wait(8)
    end

    v15.IsHackerDataMinerLoopRunning = false
  end)
end

function v30.StartHackerShopLoop()
  if v15.IsHackerShopLoopRunning then
    return
  end

  v15.IsHackerShopLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.EventsHackerShopAutoBuy or f8("Toggle_Events_HackerShopAutoBuy")) do
      pcall(function()
        local hackerShopStock2 = workspace:GetAttribute("HackerShopStock")

        if type(hackerShopStock2) ~= "string" or #hackerShopStock2 == 0 then
          return
        end

        local jsonDecode6 = {}
        pcall(function() jsonDecode6 = httpService:JSONDecode(hackerShopStock2) end)

        if not jsonDecode6 then
          return
        end

        local eventsHackerShopTargetItems = v15.EventsHackerShopTargetItems
          or f8("Dropdown_Events_HackerShopTargetItems") or {}

        local v1300 = v30.GetPlayerBytes()
        local itemsByName = v14.HackerShop and v14.HackerShop.ItemsByName or {}

        for key107, value291 in pairs(eventsHackerShopTargetItems) do
          if value291 and (jsonDecode6[key107] or 0) > 0 then
            local v1301 = itemsByName[key107]
            local bytes2 = v1301 and v1301.Bytes or 999999

            if v1300 >= bytes2 then
              v23.FireServer("BuyFromHackerShop", key107)
              v50("[Hacker/Shop] Purchased '%s' for %d Bytes", key107, bytes2)

              v22.Shop(string.format(
                "Purchased '%s' from Hacker Shop for %d Bytes!", key107, bytes2
              ))

              v1300 = v1300 - bytes2
              task.wait(0.5)
            end
          end
        end
      end)

      task.wait(4)
    end

    v15.IsHackerShopLoopRunning = false
  end)
end

function v30.StartAdminEventLoop()
  if v15.IsAdminEventLoopRunning then
    return
  end

  v15.IsAdminEventLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.EventsAdminAutoUpgradeLuck or f8("Toggle_Events_AdminAutoUpgradeLuck")
        or v15.EventsAdminAutoUpgradePodiums or f8("Toggle_Events_AdminAutoUpgradePodiums")
        or v15.EventsAdminAutoBuyPodiumSpecials
        or f8("Toggle_Events_AdminAutoBuyPodiumSpecials")) do
      pcall(function()
        local activeEvents10 = replicatedStorage:FindFirstChild("ActiveEvents")
          or workspace:FindFirstChild("ActiveEvents")

        if not (activeEvents10 and activeEvents10:FindFirstChild("Admin")) then
          return
        end

        local v1302 = v30.GetPlayerAdminCoins()
        local v1303 = f16()
        local plotUpgradeSign3 = v1303 and v1303:FindFirstChild("PlotUpgradeSign")

        if v15.EventsAdminAutoUpgradeLuck or f8("Toggle_Events_AdminAutoUpgradeLuck") then
          if (plotUpgradeSign3 and plotUpgradeSign3:GetAttribute("AdminRollLuck") or 1) < 30 then
            v23.FireServer("BuyAdminUpgrade", "AdminRollLuck")
            task.wait(0.3)
          end
        end

        if v15.EventsAdminAutoUpgradePodiums or f8("Toggle_Events_AdminAutoUpgradePodiums") then
          if (plotUpgradeSign3 and plotUpgradeSign3:GetAttribute("AdminRollPodiums") or 1) < 10 then
            v23.FireServer("BuyAdminUpgrade", "AdminRollPodiums")
            task.wait(0.3)
          end
        end

        if v15.EventsAdminAutoBuyPodiumSpecials
          or f8("Toggle_Events_AdminAutoBuyPodiumSpecials") then
          local plotSave3 = f38("PlotSave")
          local rolled = plotSave3 and plotSave3.Rolled

          if rolled then
            for key108, value292 in pairs(rolled) do
              local name10 = type(value292) == "table" and value292.Name or tostring(value292)

              if name10 == "Admin Spray" or name10 == "Admin Egg" then
                v23.FireServer("BuyRolledSeed", key108)

                v22.Event(string.format(
                  "Auto bought special '%s' on Admin Podium #%s!", name10, tostring(key108)
                ))

                task.wait(0.2)
              end
            end
          end
        end
      end)

      task.wait(3)
    end

    v15.IsAdminEventLoopRunning = false
  end)
end

function v30.StartIndexRewardsLoop()
  if v15.IsAutoClaimIndexRewardsLoopRunning then
    return
  end

  v15.IsAutoClaimIndexRewardsLoopRunning = true

  task.spawn(function()
    while not v6.Unloaded
      and (v15.EventsAutoClaimIndexRewards or f8("Toggle_Events_AutoClaimIndexRewards")) do
      pcall(function()
        for key109, value293 in pairs({ Main = 3, Admin = 3 }) do
          for i42 = 1, value293 do
            v23.FireServer("ClaimIndexReward", key109, i42)
            task.wait(0.15)
          end
        end
      end)

      task.wait(20)
    end

    v15.IsAutoClaimIndexRewardsLoopRunning = false
  end)
end

function v21.UpdateParticlesCulling(p289)
  if p289 then
    v16.DisabledParticles = v16.DisabledParticles or setmetatable({}, { __mode = "k" })

    for index205, value294 in ipairs(workspace:GetDescendants()) do
      if value294:IsA("ParticleEmitter") or value294:IsA("Sparkles") or value294:IsA("Smoke")
        or value294:IsA("Fire") or value294:IsA("Beam") or value294:IsA("Trail")
        or value294:IsA("Highlight") or value294:IsA("Light") then
        if value294.Enabled then
          v16.DisabledParticles[value294] = true
          value294.Enabled = false
        end
      end
    end

    if not v17.PotatoParticlesAdded then
      v17.PotatoParticlesAdded = workspace.DescendantAdded:Connect(function(descendant)
        if v6.Unloaded then
          return
        end

        if descendant:IsA("ParticleEmitter") or descendant:IsA("Sparkles")
          or descendant:IsA("Smoke") or descendant:IsA("Fire") or descendant:IsA("Beam")
          or descendant:IsA("Trail") or descendant:IsA("Highlight") or descendant:IsA("Light") then
          pcall(function()
            if v16.DisabledParticles then
              v16.DisabledParticles[descendant] = true
            end

            descendant.Enabled = false
          end)
        end
      end)
    end
  else
    if v17.PotatoParticlesAdded then
      v17.PotatoParticlesAdded:Disconnect()
      v17.PotatoParticlesAdded = nil
    end

    if v16.DisabledParticles then
      for key110, value295 in pairs(v16.DisabledParticles) do
        pcall(function() key110.Enabled = true end)
      end

      table.clear(v16.DisabledParticles)
    end
  end
end

function v21.UpdateEventEffectsCulling(p290)
  if p290 then
    v16.OriginalEventParts = v16.OriginalEventParts or setmetatable({}, { __mode = "k" })
    v16.OriginalEventSounds = v16.OriginalEventSounds or setmetatable({}, { __mode = "k" })

    local function f159(p291)
      local name11 = p291.Name

      if name11 == "VFX" or name11 == "SeasonDecor" or name11 == "Meteor"
        or string.find(name11, "Meteor") then
        return true
      end

      if string.find(name11, "follows player") or string.find(name11, "Should follow player")
        or string.find(name11, "Environmental VFX") then
        return true
      end

      if string.find(name11, "LightningStrike") or string.find(name11, "GhostStrike") then
        return true
      end

      local parent2 = p291.Parent

      if parent2
        and (parent2.Name == "VFX" or parent2.Name == "Meteor"
          or string.find(parent2.Name, "follows player")) then
        return true
      end

      return false
    end

    local function f160(p292)
      pcall(function()
        if p292:IsA("BasePart") then
          if v16.OriginalEventParts[p292] == nil then
            v16.OriginalEventParts[p292] = {
              Transparency = p292.Transparency,
              CastShadow = p292.CastShadow,
            }
          end

          p292.Transparency = 1
          p292.CastShadow = false
        elseif p292:IsA("ParticleEmitter") or p292:IsA("Beam") or p292:IsA("Trail")
          or p292:IsA("Light") or p292:IsA("Highlight") then
          p292.Enabled = false
        elseif p292:IsA("Sound") then
          if v16.OriginalEventSounds[p292] == nil then
            v16.OriginalEventSounds[p292] = p292.Volume
          end

          p292.Volume = 0
        elseif p292:IsA("Model") or p292:IsA("Folder") then
          for index206, value296 in ipairs(p292:GetDescendants()) do
            f160(value296)
          end
        end
      end)
    end

    for index207, value297 in ipairs(workspace:GetChildren()) do
      if f159(value297) then
        f160(value297)
      end
    end

    pcall(function()
      local eventMusic = game:GetService("SoundService"):FindFirstChild("BackgroundMusic")
        and game:GetService("SoundService").BackgroundMusic:FindFirstChild("EventMusic")

      if eventMusic then
        for index208, value298 in ipairs(eventMusic:GetChildren()) do
          if value298:IsA("Sound") then
            if v16.OriginalEventSounds[value298] == nil then
              v16.OriginalEventSounds[value298] = value298.Volume
            end

            value298.Volume = 0
          end
        end
      end
    end)

    if not v17.PotatoEventVisualsAdded then
      v17.PotatoEventVisualsAdded = workspace.DescendantAdded:Connect(function(descendant2)
        if v6.Unloaded then
          return
        end

        if f159(descendant2) then
          f160(descendant2)
        end
      end)
    end
  else
    if v17.PotatoEventVisualsAdded then
      v17.PotatoEventVisualsAdded:Disconnect()
      v17.PotatoEventVisualsAdded = nil
    end

    if v16.OriginalEventParts then
      for key111, value299 in pairs(v16.OriginalEventParts) do
        pcall(function()
          key111.Transparency = value299.Transparency
          key111.CastShadow = value299.CastShadow
        end)
      end

      table.clear(v16.OriginalEventParts)
    end

    if v16.OriginalEventSounds then
      for key112, value300 in pairs(v16.OriginalEventSounds) do
        pcall(function() key112.Volume = value300 end)
      end

      table.clear(v16.OriginalEventSounds)
    end
  end
end

function v21.UpdateEnvironmentCulling(p293)
  pcall(function()
    local terrain = workspace.Terrain
    local lighting = game:GetService("Lighting")

    if p293 then
      if terrain and v16.OriginalTerrainDecoration == nil then
        v16.OriginalTerrainDecoration = terrain.Decoration

        terrain.Decoration = false
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
      end

      if lighting and v16.OriginalGlobalShadows == nil then
        v16.OriginalGlobalShadows = lighting.GlobalShadows
        lighting.GlobalShadows = false
      end
    else
      if terrain and v16.OriginalTerrainDecoration ~= nil then
        terrain.Decoration = v16.OriginalTerrainDecoration
        terrain.WaterWaveSize = 0.15
        terrain.WaterWaveSpeed = 10
        terrain.WaterReflectance = 1

        v16.OriginalTerrainDecoration = nil
      end

      if lighting and v16.OriginalGlobalShadows ~= nil then
        lighting.GlobalShadows = v16.OriginalGlobalShadows
        v16.OriginalGlobalShadows = nil
      end
    end
  end)
end

function v21.UpdatePostEffectsCulling(p294)
  local lighting2 = game:GetService("Lighting")

  if p294 then
    v16.OriginalPostFX = v16.OriginalPostFX or {}

    for index209, value301 in ipairs(lighting2:GetChildren()) do
      if value301:IsA("PostEffect") and value301.Enabled then
        v16.OriginalPostFX[value301] = true
        value301.Enabled = false
      end
    end
  elseif v16.OriginalPostFX then
    for key113, value302 in pairs(v16.OriginalPostFX) do
      pcall(function() key113.Enabled = true end)
    end

    table.clear(v16.OriginalPostFX)
  end
end

function v21.UpdateStaticDecorCulling(p295)
  if p295 then
    v16.CulledStaticDecor = v16.CulledStaticDecor or {}

    for index210, value303 in ipairs({ "Borders", "Decorations", "Paths" }) do
      local findFirstChild32 = workspace:FindFirstChild(value303)

      if findFirstChild32 then
        v16.CulledStaticDecor[value303] = findFirstChild32
        findFirstChild32.Parent = nil
      end
    end
  elseif v16.CulledStaticDecor then
    for key114, value304 in pairs(v16.CulledStaticDecor) do
      pcall(function() value304.Parent = workspace end)
    end

    table.clear(v16.CulledStaticDecor)
  end
end

function v21.StartGCAssistantLoop()
  if v15.IsGCAssistantLoopRunning then
    return
  end

  v15.IsGCAssistantLoopRunning = true

  task.spawn(function()
    if not pcall(collectgarbage, "step", 1) then
      v15.IsGCAssistantLoopRunning = false
      return
    end

    while not v6.Unloaded do
      task.wait(15)

      pcall(function()
        local v1304 = gcinfo() / 1024

        if v1304 >= 100 then
          if not pcall(collectgarbage, "step", 500) then
            pcall(collectgarbage, "collect")
          end

          local v1305 = gcinfo() / 1024
          local v1306 = v1304 - v1305

          if v1306 > 0.5 then
            v50(
              "[GC Assistant] Lua Mem: %.1fMB -> %.1fMB (Freed: %+.1fMB)", v1304, v1305, v1306
            )
          end
        end
      end)
    end

    v15.IsGCAssistantLoopRunning = false
  end)
end

function v21.UpdateQualityLevel(p296)
  pcall(function()
    local rendering = settings().Rendering

    if p296 then
      v16.OriginalQualityLevel = rendering.QualityLevel
      rendering.QualityLevel = Enum.QualityLevel.Level01
    elseif v16.OriginalQualityLevel then
      rendering.QualityLevel = v16.OriginalQualityLevel
      v16.OriginalQualityLevel = nil
    end
  end)
end

function v21.ApplyRollerSoundMute(p297)
  pcall(function()
    local sfx2 = game:GetService("SoundService"):FindFirstChild("SFX")

    if not sfx2 then
      return
    end

    if not v16.OriginalRollerSoundVolumes then
      v16.OriginalRollerSoundVolumes = {}
    end

    for index211, value305 in ipairs({
      "Spin", "Pop", "Pop2", "Pop3", "RollMedium", "RollGood", "Rare", "CloverSpawn",
      "Lightning", "SeedRollerCrash", "Crash", "Crash2", "CelestialLightningCharge",
      "CelestialIdle", "EternalNightFall", "EternalMeteorIgnite", "EternalMeteorCrash",
      "EternalMeteorExplode", "EternalDayReturn", "EternalReveal", "EternalIdle",
      "EternalMeteorLoop1", "EternalMeteorLoop2", "EternalRumble", "InsertToken", "Purchase",
      "Cash", "Pickup", "OfflineCoins", "MagicSparkle", "CutsceneCutHit", "Jackpot1",
      "Jackpot2", "Reward", "Confetti",
    }) do
      local findFirstChild33 = sfx2:FindFirstChild(value305)
        or sfx2:FindFirstChild(value305, true)

      if findFirstChild33 and findFirstChild33:IsA("Sound") then
        if p297 then
          if v16.OriginalRollerSoundVolumes[value305] == nil then
            v16.OriginalRollerSoundVolumes[value305] = findFirstChild33.Volume
          end

          findFirstChild33.Volume = 0
        elseif v16.OriginalRollerSoundVolumes[value305] ~= nil then
          findFirstChild33.Volume = v16.OriginalRollerSoundVolumes[value305]
          v16.OriginalRollerSoundVolumes[value305] = nil
        end
      end
    end
  end)
end

function v21.UpdateFovWatchdog(p298)
  if p298 then
    local currentCamera = workspace.CurrentCamera

    if currentCamera then
      v16.BaseFieldOfView = currentCamera.FieldOfView
    end

    if v17.FovWatchdog then
      return
    end

    v17.FovWatchdog = game:GetService("RunService").RenderStepped:Connect(function()
      local currentCamera2 = workspace.CurrentCamera

      if currentCamera2 and v16.BaseFieldOfView
        and math.abs(currentCamera2.FieldOfView - v16.BaseFieldOfView) > 0.01 then
        currentCamera2.FieldOfView = v16.BaseFieldOfView
      end
    end)
  else
    if v17.FovWatchdog then
      v17.FovWatchdog:Disconnect()
      v17.FovWatchdog = nil
    end

    local currentCamera3 = workspace.CurrentCamera

    if currentCamera3 and v16.BaseFieldOfView then
      currentCamera3.FieldOfView = v16.BaseFieldOfView
      v16.BaseFieldOfView = nil
    end
  end
end

function v21.UpdatePotatoGraphics(p299)
  v21.UpdateParticlesCulling(p299)
  v21.UpdateEventEffectsCulling(p299)
  v21.UpdateEnvironmentCulling(p299)
  v21.UpdatePostEffectsCulling(p299)
  v21.UpdateStaticDecorCulling(p299)
  v21.UpdateQualityLevel(p299)
end

function v21.UpdateInstantRoll(p300)
  if not p300 and not v15.InstantRollPatchActive then
    return
  end

  if not v15.PlayerDataComplete or not v15.ExecCanScrape then
    v15.InstantRollPatchBlockedLogged = v15.InstantRollPatchBlockedLogged
      or log("Instant Roll module patch unavailable on this executor (FOV protection still works)")
      or true

    return
  end

  task.spawn(function()
    if v6.Unloaded then
      return
    end

    pcall(function()
      local controllers4 = replicatedStorage:FindFirstChild("Client")
        and replicatedStorage.Client:FindFirstChild("Controllers")

      if not controllers4 then
        return
      end

      local rollFruitController = controllers4:FindFirstChild("RollFruitController")

      if not rollFruitController then
        return
      end

      local v1307 = f1(rollFruitController)

      if not v1307 then
        return
      end

      local cinematic = rollFruitController:FindFirstChild("Cinematic")
      local v1308 = cinematic and f1(cinematic)

      if p300 then
        v15.InstantRollPatchActive = true

        if not v16.OriginalRollMethods then
          v16.OriginalRollMethods = {
            ZoomCamera = v1307.ZoomCamera,
            PunchCamera = v1307.PunchCamera,
            CycleAsync = v1307.CycleAsync,
            GetCycleTime = v1307.GetCycleTime,
            PlayRollTierEffect = v1307.PlayRollTierEffect,
          }
        end

        function v1307.ZoomCamera()
        end

        function v1307.PunchCamera()
        end

        function v1307.CycleAsync()
        end

        function v1307.GetCycleTime()
          return 0
        end

        function v1307.PlayRollTierEffect()
        end

        pcall(v1307.ResetCamera)

        if v1308 and v1308.SetEnabled and v1308.IsEnabled then
          if not v16.OriginalCutscenesSettings then
            v16.OriginalCutscenesSettings = {}

            for index212, value306 in ipairs({
              "Cutscenes", "CutscenesTranscended", "CutscenesEternal", "CutscenesCelestial",
              "CutscenesTimeSkip",
            }) do
              v16.OriginalCutscenesSettings[value306] = v1308.IsEnabled(value306)
            end
          end

          for index213, value307 in ipairs({
            "Cutscenes", "CutscenesTranscended", "CutscenesEternal", "CutscenesCelestial",
            "CutscenesTimeSkip",
          }) do
            v1308.SetEnabled(value307, false)
          end
        end
      else
        if v16.OriginalRollMethods then
          for key115, value308 in pairs(v16.OriginalRollMethods) do
            v1307[key115] = value308
          end

          v16.OriginalRollMethods = nil
        end

        if v1308 and v1308.SetEnabled and v16.OriginalCutscenesSettings then
          for key116, value309 in pairs(v16.OriginalCutscenesSettings) do
            v1308.SetEnabled(key116, value309)
          end

          v16.OriginalCutscenesSettings = nil
        end

        v15.InstantRollPatchActive = nil
      end
    end)
  end)
end

function v21.RestoreAllPerformanceSettings()
  pcall(function()
    v21.UpdatePotatoGraphics(false)
    v21.UpdateInstantRoll(false)
    v21.UpdateFovWatchdog(false)
    v21.ApplyRollerSoundMute(false)
  end)
end

if not f17() then
  f9("Waiting for game loading", "Game is still loading - script will continue when ready", 6)
  log("Waiting for game ready (loading dismissed + plot assigned)...")
end

do
  local v1309 = os.clock() + 30

  while not f17() and not v6.Unloaded and os.clock() < v1309 do
    task.wait(0.5)
  end

  if not v15.GameReady then
    v15.GameReady = true
    log("Game ready timeout (30s): continuing anyway")
  end
end

if v6.Unloaded then
  return
end

if not v15.ExecCanScrape then
  v15.DataPartialNotified = true
  f28()
  f9("Executor Warning!", "This executor is WEAK, running in compatible mode!", 6)
  log("Limited executor: workspace mirrors initialized, data partial flags set synchronously")
else
  log("[Chain] Attempting ChainController (DataController:GetData)...")

  if not f31() then
    f33()
    local v1310 = os.clock() + 5

    while not v15.PlayerDataComplete and not v6.Unloaded and os.clock() < v1310 do
      task.wait(0.1)

      if f31() then
        break
      end
    end
  end

  if not v15.PlayerDataComplete then
    log("[Chain] ChainController incomplete. Falling back to ChainGcScan...")
    f33()
    local v1311 = os.clock() + 2

    while v15.GcScanInProgress and not v15.PlayerDataComplete and os.clock() < v1311 do
      task.wait(0.05)
    end
  end

  if not v15.PlayerDataComplete then
    v15.DataPartialNotified = true
    f28()
    f9("Notice", "Partial data mode active", 3)
    log("Capable executor: PlayerData incomplete, workspace mirrors activated as fallback")
  else
    log(
      "Capable executor: PlayerData fully loaded synchronously (%s)",
      tostring(v15.PlayerDataSource)
    )
  end
end

v19.Plant()
v19.Rarity()
v19.Grade()
v19.Mutation()
v19.GearShop()
v19.Fertilizer()
v19.Spray()
v19.PlotBuilding()
v19.Event()
v19.Compost()
v19.PetEgg()
v19.PetMerchant()
v19.Pet()
v19.PetTreat()
v19.Bee()
v19.BeeShop()
v19.Fishing()

local window = v6:CreateWindow({ Title = "Build A Ring Farm 2", SubTitle = "by Lamduck" })

local v1312 = {
  Farm = window:AddTab({ Title = "Farm", Icon = "sprout" }),
  Shop = window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
  FloorManager = window:AddTab({ Title = "Floor Manager", Icon = "layers" }),
  Pets = window:AddTab({ Title = "Animals", Icon = "paw-print" }),
  Events = window:AddTab({ Title = "Events & Rewards", Icon = "gift" }),
  Misc = window:AddTab({ Title = "Misc", Icon = "sparkles" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

function v20.Farm()
  if v15.DataPartialNotified then
    v18.PartialDataWarning = v1312.Farm:AddParagraph("Paragraph_Farm_PartialData", {
      Title = "<font color=\"#FF5252\">Executor warning!</font>",
      Content = [[
<font color="#FF5252">This executor is WEAK.</font>
<font color="#FF5252">Some features may be limited on this executor.</font>
<font color="#00E676">Recommendation: Turn OFF Compact Inventory for better compatibility.</font>]],
    })
  end

  local addSubTabBar = v1312.Farm:AddSubTabBar({
    SubTabs = { "Gacha", "Super Roller", "Compost", "Discard Seed" },
    Default = "Gacha",
  })

  local gacha = addSubTabBar.Gacha
  local superRoller2 = addSubTabBar["Super Roller"]
  local compost = addSubTabBar.Compost
  local discardSeed = addSubTabBar["Discard Seed"]

  gacha:AddSection("Seed Gacha (Roll & Buy)")

  gacha:AddSlider("Slider_Farm_SeedGachaRollDelay", {
    Title = "Roll Delay",
    Description = "(Second) Delay between rolls",
    Default = 2.5,
    Min = 1.5,
    Max = 10,
    Rounding = 1,
    Callback = function(value310) v15.FarmSeedGachaRollDelay = value310 end,
  })

  gacha:AddToggle("Toggle_Farm_SeedGachaPauseIfNotEnoughCash", {
    Title = "Pause If Not Enough Cash",
    Description = "Pause rolling if you cannot afford target seeds instead of rolling away, will continue when you have enough cash",
    Default = false,
    Callback = function(value311)
      v15.FarmSeedGachaPauseIfNotEnoughCash = value311

      if value311 and v6.Options.Toggle_Farm_SeedGachaPauseIfFound then
        v6.Options.Toggle_Farm_SeedGachaPauseIfFound:SetValue(false)
      end
    end,
  })

  gacha:AddToggle("Toggle_Farm_SeedGachaPauseIfFound", {
    Title = "Pause If Found",
    Description = "Stop auto roll immediately once any filtered target seed is found, use when you want to manual buy",
    Default = false,
    Callback = function(value312)
      v15.FarmSeedGachaPauseIfFound = value312

      if value312 and v6.Options.Toggle_Farm_SeedGachaPauseIfNotEnoughCash then
        v6.Options.Toggle_Farm_SeedGachaPauseIfNotEnoughCash:SetValue(false)
      end
    end,
  })

  gacha:AddToggle("Toggle_Farm_SeedGachaPauseOnHackerEvent", {
    Title = "Pause Buying On Hacker Event",
    Description = "Keep rolling during Hacker Invasion to farm Byte drops, but skip buying seeds to preserve Bytes",
    Default = false,
    Callback = function(value313) v15.FarmSeedGachaPauseOnHackerEvent = value313 end,
  })

  gacha:AddDivider()

  gacha:AddDropdown("Dropdown_Farm_SeedGachaTargetSeeds", {
    Title = "Target Seeds",
    Values = v14.PlantNames,
    Multi = true,
    Searchable = true,
    Default = {},
  })

  gacha:AddToggle("Toggle_Farm_SeedGachaAutoBuyTargetSeeds", {
    Title = "Auto Buy Selected Seeds",
    Default = false,
    Callback = function(value314)
      v15.FarmSeedGachaAutoBuyTargetSeeds = value314

      if value314 then
        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetRarities then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetRarities:SetValue(false)
        end

        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetGrades then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetGrades:SetValue(false)
        end

        if v6.Options.Toggle_Farm_SeedGachaAutoBuyUndiscovered then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyUndiscovered:SetValue(false)
        end

        f139()
      end
    end,
  })

  gacha:AddDivider()

  gacha:AddDropdown("Dropdown_Farm_SeedGachaTargetRarities", {
    Title = "Target Rarities",
    Values = v14.PlantRarities,
    Multi = true,
    Searchable = true,
    Default = {},
  })

  gacha:AddToggle("Toggle_Farm_SeedGachaAutoBuyTargetRarities", {
    Title = "Auto Buy Selected Rarity",
    Default = false,
    Callback = function(value315)
      v15.FarmSeedGachaAutoBuyTargetRarities = value315

      if value315 then
        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetSeeds then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetSeeds:SetValue(false)
        end

        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetGrades then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetGrades:SetValue(false)
        end

        if v6.Options.Toggle_Farm_SeedGachaAutoBuyUndiscovered then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyUndiscovered:SetValue(false)
        end

        f139()
      end
    end,
  })

  gacha:AddDivider()

  gacha:AddDropdown("Dropdown_Farm_SeedGachaTargetGrades", {
    Title = "Target Grades",
    Values = v14.PlantGrades,
    Multi = true,
    Searchable = true,
    Default = {},
  })

  gacha:AddToggle("Toggle_Farm_SeedGachaAutoBuyTargetGrades", {
    Title = "Auto Buy Selected Grade",
    Default = false,
    Callback = function(value316)
      v15.FarmSeedGachaAutoBuyTargetGrades = value316

      if value316 then
        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetSeeds then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetSeeds:SetValue(false)
        end

        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetRarities then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetRarities:SetValue(false)
        end

        if v6.Options.Toggle_Farm_SeedGachaAutoBuyUndiscovered then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyUndiscovered:SetValue(false)
        end

        f139()
      end
    end,
  })

  gacha:AddDivider()

  gacha:AddToggle("Toggle_Farm_SeedGachaAutoBuyUndiscovered", {
    Title = "Auto Buy Undiscovered Seeds",
    Description = "Buy seeds not unlocked in Index",
    Default = false,
    Callback = function(value317)
      v15.FarmSeedGachaAutoBuyUndiscovered = value317

      if value317 then
        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetSeeds then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetSeeds:SetValue(false)
        end

        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetRarities then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetRarities:SetValue(false)
        end

        if v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetGrades then
          v6.Options.Toggle_Farm_SeedGachaAutoBuyTargetGrades:SetValue(false)
        end

        f139()
      end
    end,
  })

  superRoller2:AddSection("Super Roller")

  superRoller2:AddToggle("Toggle_Farm_SuperRollerAutoStopLuck", {
    Title = "Auto Stop At Target Luck",
    Description = "Stop roll at target luck before crashing",
    Default = true,
    Callback = function(value318) v15.FarmSuperRollerAutoStopLuck = value318 end,
  })

  superRoller2:AddSlider("Slider_Farm_SuperRollerTargetStopLuck", {
    Title = "Target Stop Luck",
    Default = 7,
    Min = 2,
    Max = 10,
    Rounding = 1,
    Callback = function(value319) v15.FarmSuperRollerTargetStopLuck = value319 end,
  })

  superRoller2:AddDivider()

  superRoller2:AddToggle("Toggle_Farm_SuperRollerAutoInsertToken", {
    Title = "Auto Insert Token",
    Default = false,
    Callback = function(value320)
      v15.FarmSuperRollerAutoInsertToken = value320

      if value320 then
        f146()
      end
    end,
  })

  superRoller2:AddToggle("Toggle_Farm_SuperRollerAutoRoll", {
    Title = "Auto Roll",
    Default = false,
    Callback = function(value321)
      v15.FarmSuperRollerAutoRoll = value321

      if value321 then
        f147()
      end
    end,
  })

  superRoller2:AddToggle("Toggle_Farm_SuperRollerAutoBuySeed", {
    Title = "Auto Buy Seed",
    Description = "Automatically purchase the seed produced after rolling. <font color=\"#FF5252\">Warning: If disabled while Auto Roll is active, it will continuously roll and NOT BUY any seeds!</font>",
    Default = true,
    Callback = function(value322) v15.FarmSuperRollerAutoBuySeed = value322 end,
  })

  superRoller2:AddToggle("Toggle_Farm_SuperRollerPauseIfNotEnoughCash", {
    Title = "Pause If Not Enough Cash",
    Description = "Pause rolling if not enough cash",
    Default = true,
    Callback = function(value323) v15.FarmSuperRollerPauseIfNotEnoughCash = value323 end,
  })

  compost:AddSection("Overview")

  v18.CompostStatus = compost:AddParagraph("Paragraph_Farm_CompostStatus", {
    Title = "Compost Status",
    Content = "Scanning composter status...",
  })

  compost:AddSection("Lever")

  compost:AddToggle("Toggle_Farm_CompostAutoPullLever", {
    Title = "Auto Pull Lever",
    Description = "Disable to only insert seeds without pulling the lever",
    Default = true,
    Callback = function(value324)
      v15.FarmCompostAutoPullLever = value324

      if value324 then
        f118()
      end
    end,
  })

  compost:AddSection("Auto Compost")

  compost:AddDropdown("Dropdown_Farm_CompostTargetTier", {
    Title = "Target Compost Tier",
    Values = v14.CompostTierNames
      or { "Poor Compost", "Rich Compost", "Prime Compost", "Overgrown Compost" },
    Default = "Overgrown Compost",
    Callback = function(value325) v15.FarmCompostTargetTier = value325 end,
  })

  local v1313 = {}

  for index214, value326 in ipairs(v14.PlantFilterNames or {}) do
    if value326 ~= "Normal" then
      table.insert(v1313, value326)
    end
  end

  compost:AddDropdown("Dropdown_Farm_CompostIgnorePlantFilters", {
    Title = "Ignore Seed Types",
    Values = v14.PlantFilterNames or { "Normal" },
    Default = v1313,
    Multi = true,
    Searchable = true,
    Callback = function(value327) v15.FarmCompostIgnorePlantFilters = value327 end,
  })

  compost:AddToggle("Toggle_Farm_CompostIgnoreMutatedSeeds", {
    Title = "Ignore Mutated Seeds",
    Default = true,
    Callback = function(value328) v15.FarmCompostIgnoreMutatedSeeds = value328 end,
  })

  compost:AddDivider()

  compost:AddDropdown("Dropdown_Farm_CompostTargetSeeds", {
    Title = "Target Seeds",
    Values = v14.PlantNames,
    Multi = true,
    Searchable = true,
    Callback = function(value329) v15.FarmCompostTargetSeeds = value329 end,
  })

  compost:AddToggle("Toggle_Farm_CompostAutoCompostBySeed", {
    Title = "Auto Compost by Seed",
    Default = false,
    Callback = function(value330)
      v15.FarmCompostAutoCompostBySeed = value330

      if value330 then
        if v6.Options.Toggle_Farm_CompostAutoCompostByRarity then
          v6.Options.Toggle_Farm_CompostAutoCompostByRarity:SetValue(false)
        end

        f118()
      end
    end,
  })

  compost:AddDivider()

  compost:AddDropdown("Dropdown_Farm_CompostTargetRarities", {
    Title = "Target Rarities",
    Values = v14.PlantRarities,
    Multi = true,
    Searchable = true,
    Callback = function(value331) v15.FarmCompostTargetRarities = value331 end,
  })

  compost:AddToggle("Toggle_Farm_CompostAutoCompostByRarity", {
    Title = "Auto Compost by Rarity",
    Default = false,
    Callback = function(value332)
      v15.FarmCompostAutoCompostByRarity = value332

      if value332 then
        if v6.Options.Toggle_Farm_CompostAutoCompostBySeed then
          v6.Options.Toggle_Farm_CompostAutoCompostBySeed:SetValue(false)
        end

        f118()
      end
    end,
  })

  discardSeed:AddSection("Auto Discard Seeds")

  discardSeed:AddDropdown("Dropdown_Farm_DiscardTargetRarities", {
    Title = "Target Rarities",
    Values = v14.PlantRarities,
    Multi = true,
    Searchable = true,
    Default = {},
  })

  discardSeed:AddToggle("Toggle_Farm_DiscardAutoDiscardByRarity", {
    Title = "Auto Discard Selected Rarities",
    Confirm = "Discard ALL seeds matching this filter? This cannot be undone.",
    Default = false,
    Callback = function(value333)
      v15.FarmDiscardAutoDiscardByRarity = value333

      if value333 then
        f148()
      end
    end,
  })
end

function v20.Shop()
  local addSubTabBar2 = v1312.Shop:AddSubTabBar({
    SubTabs = { "General", "Gear" },
    Default = "General",
  })

  local general = addSubTabBar2.General
  local gear = addSubTabBar2.Gear

  general:AddSection("Auto Sell ~")

  general:AddSlider("Slider_Shop_FruitSellInterval", {
    Title = "Sell Fruits Interval",
    Description = "(Second) Delay between each fruit sell",
    Default = 10,
    Min = 3,
    Max = 60,
    Rounding = 0,
    Callback = function(value334) v15.ShopFruitSellInterval = value334 end,
  })

  general:AddToggle("Toggle_Shop_FruitAutoSellFruits", {
    Title = "Auto Sell Fruits",
    Default = false,
    Callback = function(value335)
      v15.ShopFruitAutoSellFruits = value335

      if value335 then
        f93()
      end
    end,
  })

  general:AddSection("Plot Upgrades")

  general:AddToggle("Toggle_Shop_PlotUpgradeAutoBuyExpansion", {
    Title = "Auto Buy Farm Expansion",
    Default = false,
    Callback = function(value336)
      v15.ShopPlotUpgradeAutoBuyExpansion = value336

      if value336 then
        f95()
      end
    end,
  })

  general:AddToggle("Toggle_Shop_PlotUpgradeAutoBuyRollLuck", {
    Title = "Auto Buy Roll Luck",
    Default = false,
    Callback = function(value337)
      v15.ShopPlotUpgradeAutoBuyRollLuck = value337

      if value337 then
        f95()
      end
    end,
  })

  general:AddToggle("Toggle_Shop_PlotUpgradeAutoBuyRollPodiums", {
    Title = "Auto Buy Roll Podiums (Seed Rolls)",
    Default = false,
    Callback = function(value338)
      v15.ShopPlotUpgradeAutoBuyRollPodiums = value338

      if value338 then
        f95()
      end
    end,
  })

  general:AddSection("Plot Buildings")

  local v1314 = {}

  if v14.PlotBuildings then
    for key117, value339 in pairs(v14.PlotBuildings) do
      table.insert(v1314, {
        Name = key117,
        DisplayName = value339.DisplayName or key117,
        Index = value339.Index or 99,
      })
    end

    table.sort(v1314, function(p301, p302) return p301.Index < p302.Index end)
  end

  if #v1314 == 0 then
    v1314 = {
      { Name = "PetBarn", DisplayName = "Pet Barn", Index = 1 },
      { Name = "TradingPost", DisplayName = "Trading Post", Index = 2 },
      { Name = "Composter", DisplayName = "Composter", Index = 3 },
      { Name = "BeeHive", DisplayName = "Bee Hive", Index = 4 },
      { Name = "Aquarium", DisplayName = "Aquarium", Index = 5 },
    }
  end

  for index215, value340 in ipairs(v1314) do
    general:AddToggle("Toggle_Shop_PlotBuildingAutoUpgrade" .. value340.Name, {
      Title = "Auto Upgrade " .. value340.DisplayName,
      Default = false,
      Callback = function(value341)
        if value341 then
          f97()
        end
      end,
    })
  end

  gear:AddSection("Gear Shop")

  v18.GearShopInfo = gear:AddParagraph("Paragraph_Shop_GearShopInfo", {
    Title = "Gear Shop Status",
    Content = "Loading...",
  })

  gear:AddDropdown("Dropdown_Shop_GearShopTargetGears", {
    Title = "Target Gears",
    Values = v14.GearShopNames,
    Multi = true,
    Searchable = true,
    Default = {},
  })

  gear:AddToggle("Toggle_Shop_GearShopAutoBuyTargetGears", {
    Title = "Auto Buy Gear",
    Default = false,
    Callback = function(value342)
      v15.ShopGearShopAutoBuyTargetGears = value342

      if value342 then
        f94()
      end
    end,
  })
end

function v20.FloorManager()
  local v1315 = { "Overview" }

  for i43 = 1, f60() do
    table.insert(v1315, "Floor " .. i43)
  end

  local addSubTabBar3 = v1312.FloorManager:AddSubTabBar({ SubTabs = v1315, Default = "Overview" })
  local overview = addSubTabBar3.Overview

  v18.FloorOverview = overview:AddParagraph("Paragraph_FloorManager_Overview", {
    Title = "Farm Floors Status",
    Content = "Scanning floor status...",
  })

  overview:AddToggle("Toggle_FloorManager_HonorPotAutoSetBestPlant", {
    Title = "Auto Set Best Plant to Honor Pot",
    Default = false,
    Callback = function(value343)
      v15.FloorManagerHonorPotAutoSetBestPlant = value343

      if value343 then
        f102()
      end
    end,
  })

  local v1316 = {}

  for i44 = 1, f60() do
    table.insert(v1316, "Floor " .. i44)
  end

  overview:AddSection("Auto Plant")

  overview:AddDropdown("Dropdown_FloorManager_AutoPlantTargetFloors", {
    Title = "Target Floors",
    Values = v1316,
    Multi = true,
    Searchable = false,
    Default = v1316,
    Callback = function(value344) v15.FloorManagerAutoPlantTargetFloors = value344 end,
  })

  overview:AddToggle("Toggle_FloorManager_AutoPlantIgnoreMutation", {
    Title = "Ignore Mutation Buff",
    Default = false,
    Callback = function(value345) v15.FloorManagerAutoPlantIgnoreMutation = value345 end,
  })

  overview:AddToggle("Toggle_FloorManager_AutoPlantBestAllFloors", {
    Title = "Auto Plant Best Seeds",
    Default = false,
    Callback = function(value346)
      v15.FloorManagerAutoPlantBestAllFloors = value346

      if value346 then
        for i45 = 1, f60() do
          if v6.Options["Toggle_FloorManager_F" .. i45 .. "AutoPlantTargetSeeds"] then
            v6.Options["Toggle_FloorManager_F" .. i45 .. "AutoPlantTargetSeeds"]:SetValue(false)
          end

          if v6.Options["Toggle_FloorManager_F" .. i45 .. "AutoPlantTargetRarities"] then
            v6.Options["Toggle_FloorManager_F" .. i45 .. "AutoPlantTargetRarities"]:SetValue(false)
          end
        end

        f103()
      end
    end,
  })

  overview:AddDivider()

  overview:AddButton({
    Title = "<font color=\"#58A6FF\">Trowel</font> All & Plant Best",
    Description = "Clear selected floor(s) & replant best seeds",
    Confirm = "Trowel all crops on selected floors and auto plant best seeds?",
    Callback = function() v29.TrowelAllAndPlantBest() end,
  })

  overview:AddDivider()

  overview:AddButton({
    Title = "Smart Replace (<font color=\"#58A6FF\">Trowel</font>)",
    Description = "Replace weak crops using <font color=\"#58A6FF\">Trowel</font> (Keeps seeds)",
    Confirm = "Use Trowel(s) to replace weaker crops with better seeds?",
    Callback = function() v29.SmartReplace("Trowel") end,
  })

  overview:AddButton({
    Title = "Smart Replace (<font color=\"#FF5252\">Shovel</font>)",
    Description = "<font color=\"#FF5252\">Replace weak crops using Shovel (Destroys)</font>",
    Confirm = "Permanently destroy weaker crops with Shovel and replant?",
    Callback = function() v29.SmartReplace("Shovel") end,
  })

  overview:AddSection("Quick Settings")

  overview:AddDropdown("Dropdown_FloorManager_QuickSettingsTargetFloors", {
    Title = "Target Floors",
    Values = v1316,
    Multi = true,
    Searchable = false,
    Default = v1316,
    Callback = function(value347) v15.FloorManagerQuickSettingsTargetFloors = value347 end,
  })

  overview:AddButton({
    Title = "Trowel Plants (Selected Floors)",
    Description = "Safely recover seeds using <font color=\"#58A6FF\">Trowel</font>",
    Confirm = "Are you sure you want to TROWEL crops on the selected floors? This will consume Trowels from your inventory to recover seeds.",
    Callback = function() v29.TrowelAll() end,
  })

  overview:AddButton({
    Title = "Shovel Plants (Selected Floors)",
    Description = "<font color=\"#FF5252\">PERMANENTLY destroy crops on selected floors (NO seeds recovered!)</font>",
    Confirm = "WARNING [Step 1/3]: Permanently destroy crops on the selected floors? NO seeds will be recovered!",
    Callback = function()
      if window and window.Dialog then
        window:Dialog({
          Title = "Confirm Shovel All [Step 2/3]",
          Content = "<font color=\"#FF4D4D\"><b>EXTREME DANGER:</b></font> You are about to permanently destroy crops on the selected floors. This action CANNOT be undone! Continue?",
          Buttons = {
            {
              Title = "Continue",
              Callback = function()
                window:Dialog({
                  Title = "Final Confirmation [Step 3/3]",
                  Content = "<font color=\"#FF4D4D\"><b>FINAL WARNING:</b></font> Crops on the selected floors will be deleted immediately. Are you ABSOLUTELY sure?",
                  Buttons = {
                    { Title = "Yes, Destroy Plants", Callback = function() v29.ShovelAll() end },
                    { Title = "Cancel", Callback = function() end },
                  },
                })
              end,
            },
            { Title = "Cancel", Callback = function() end },
          },
        })
      else
        v29.ShovelAll()
      end
    end,
  })

  v18.FloorStatus = v18.FloorStatus or {}

  for i46 = 1, f60() do
    local v1317 = addSubTabBar3["Floor " .. i46]

    if v1317 then
      v1317:AddSection("Floor Status")

      v18.FloorStatus[i46] = v1317:AddParagraph("Paragraph_FloorManager_F" .. i46 .. "Status", {
        Title = "Floor " .. i46 .. " Status",
        Content = "Scanning floor status...",
      })

      v1317:AddSection("Auto Plant")

      v1317:AddDropdown("Dropdown_FloorManager_F" .. i46 .. "TargetSeeds", {
        Title = "Target Seeds",
        Values = v14.PlantNames,
        Multi = true,
        Searchable = true,
        Default = {},
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoPlantTargetSeeds", {
        Title = "Auto Plant Selected Seeds",
        Default = false,
        Callback = function(value348)
          v15["FloorManagerF" .. i46 .. "AutoPlantTargetSeeds"] = value348

          if value348 then
            if v6.Options.Toggle_FloorManager_AutoPlantBestAllFloors
              and v6.Options.Toggle_FloorManager_AutoPlantBestAllFloors.Value then
              v6.Options.Toggle_FloorManager_AutoPlantBestAllFloors:SetValue(false)
            end

            if v6.Options["Toggle_FloorManager_F" .. i46 .. "AutoPlantTargetRarities"] then
              v6.Options["Toggle_FloorManager_F" .. i46 .. "AutoPlantTargetRarities"]:SetValue(false)
            end

            f103()
          end
        end,
      })

      v1317:AddDivider()

      v1317:AddDropdown("Dropdown_FloorManager_F" .. i46 .. "TargetRarities", {
        Title = "Target Rarities",
        Values = v14.PlantRarities,
        Multi = true,
        Searchable = true,
        Default = {},
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoPlantTargetRarities", {
        Title = "Auto Plant Selected Rarities",
        Default = false,
        Callback = function(value349)
          v15["FloorManagerF" .. i46 .. "AutoPlantTargetRarities"] = value349

          if value349 then
            if v6.Options.Toggle_FloorManager_AutoPlantBestAllFloors
              and v6.Options.Toggle_FloorManager_AutoPlantBestAllFloors.Value then
              v6.Options.Toggle_FloorManager_AutoPlantBestAllFloors:SetValue(false)
            end

            if v6.Options["Toggle_FloorManager_F" .. i46 .. "AutoPlantTargetSeeds"] then
              v6.Options["Toggle_FloorManager_F" .. i46 .. "AutoPlantTargetSeeds"]:SetValue(false)
            end

            f103()
          end
        end,
      })

      v1317:AddSection("Shovel & Trowel (Plant Removal)")

      v1317:AddDropdown("Dropdown_FloorManager_F" .. i46 .. "RemovalRarities", {
        Title = "Removal Rarities",
        Values = v14.PlantRarities,
        Multi = true,
        Searchable = true,
        Default = {},
      })

      v1317:AddButton({
        Title = "Destroy Plants (Shovel)",
        Description = "<font color=\"#FF5252\">Permanently remove crops matching selected rarities (NO seeds recovered)</font>",
        Confirm = "WARNING: Permanently destroy crops matching selected rarities on Floor "
          .. i46 .. "? This CANNOT be undone!",
        Callback = function() f86(i46) end,
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoTrowel", {
        Title = "Auto Trowel Plants (Recover Seeds)",
        Description = "Automatically use Trowel to remove crops matching selected rarities and recover seeds",
        Default = false,
        Callback = function(value350)
          v15["FloorManagerF" .. i46 .. "AutoTrowel"] = value350

          if value350 then
            f104()
          end
        end,
      })

      v1317:AddSection("Plant Maintenance (Water & Fertilizer)")

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoWater", {
        Title = "Auto Water Plants",
        Description = "Automatically use Watering Can or Super Watering Can",
        Default = false,
        Callback = function(value351)
          v15["FloorManagerF" .. i46 .. "AutoWater"] = value351

          if value351 then
            f105()
          end
        end,
      })

      v1317:AddDivider()

      v1317:AddDropdown("Dropdown_FloorManager_F" .. i46 .. "FertilizerTypes", {
        Title = "Fertilizer Types",
        Values = v14.FertilizerNames or {},
        Default = v14.FertilizerNames or {},
        Multi = true,
        Searchable = true,
        Callback = function(value352)
          v15["FloorManagerF" .. i46 .. "FertilizerTypes"] = value352
        end,
      })

      v1317:AddDropdown("Dropdown_FloorManager_F" .. i46 .. "FertilizePlants", {
        Title = "Fertilize Target Plants",
        Values = v14.PlantNames or {},
        Multi = true,
        Searchable = true,
        Default = {},
        Callback = function(value353)
          v15["FloorManagerF" .. i46 .. "FertilizePlants"] = value353
        end,
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoFertilize", {
        Title = "Auto Fertilize Plants",
        Description = "Automatically apply chosen fertilizer to maintain growth speed buff",
        Default = false,
        Callback = function(value354)
          v15["FloorManagerF" .. i46 .. "AutoFertilize"] = value354

          if value354 then
            f106()
          end
        end,
      })

      v1317:AddSection("Mutation Sprays")

      v1317:AddDropdown("Dropdown_FloorManager_F" .. i46 .. "SprayType", {
        Title = "Spray Types",
        Values = v14.MutationSprayNames or {},
        Multi = true,
        Searchable = true,
        Default = {},
        Callback = function(value355) v15["FloorManagerF" .. i46 .. "SprayType"] = value355 end,
      })

      v1317:AddDropdown("Dropdown_FloorManager_F" .. i46 .. "SprayPlants", {
        Title = "Spray Target Plants",
        Values = v14.PlantNames or {},
        Multi = true,
        Searchable = true,
        Default = {},
        Callback = function(value356)
          v15["FloorManagerF" .. i46 .. "SprayPlants"] = value356
        end,
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoSpray", {
        Title = "Auto Spray",
        Description = "Automatically use selected sprays on plants without mutations",
        Default = false,
        Callback = function(value357)
          v15["FloorManagerF" .. i46 .. "AutoSpray"] = value357

          if value357 then
            f108()
          end
        end,
      })

      v1317:AddDivider()

      v1317:AddDropdown("Dropdown_FloorManager_F" .. i46 .. "AcidSprayUnwantedMutations", {
        Title = "Unwanted Mutations (Acid Spray)",
        Values = v14.RemovableMutationNames or {},
        Multi = true,
        Searchable = true,
        Default = {},
        Callback = function(value358)
          v15["FloorManagerF" .. i46 .. "AcidSprayUnwantedMutations"] = value358
        end,
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoAcidSpray", {
        Title = "Auto Acid Spray",
        Description = "<font color=\"#FF4D4D\">Will permanently remove selected mutations!</font>",
        Confirm = "Enable Auto Acid Spray? Plants with selected mutations will permanently lose their mutations!",
        Default = false,
        Callback = function(value359)
          v15["FloorManagerF" .. i46 .. "AutoAcidSpray"] = value359

          if value359 then
            f109()
          end
        end,
      })

      v1317:AddSection("Tile Management")

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoUnlockTiles", {
        Title = "Auto Unlock Tiles",
        Default = false,
        Callback = function(value360)
          v15["FloorManagerF" .. i46 .. "AutoUnlockTiles"] = value360

          if value360 then
            f110()
          end
        end,
      })

      v1317:AddSection("Machine Upgrades")

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoUpgradeSawYield", {
        Title = "Auto Upgrade Saw Yield",
        Default = false,
        Callback = function(value361)
          v15["FloorManagerF" .. i46 .. "AutoUpgradeSawYield"] = value361

          if value361 then
            f111()
          end
        end,
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoUpgradeSprinkler", {
        Title = "Auto Upgrade Sprinkler Power",
        Default = false,
        Callback = function(value362)
          v15["FloorManagerF" .. i46 .. "AutoUpgradeSprinkler"] = value362

          if value362 then
            f111()
          end
        end,
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoUpgradeSawRange", {
        Title = "Auto Upgrade Saw Range",
        Default = false,
        Callback = function(value363)
          v15["FloorManagerF" .. i46 .. "AutoUpgradeSawRange"] = value363

          if value363 then
            f111()
          end
        end,
      })

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoUpgradeSprinklerRange", {
        Title = "Auto Upgrade Sprinkler Range",
        Default = false,
        Callback = function(value364)
          v15["FloorManagerF" .. i46 .. "AutoUpgradeSprinklerRange"] = value364

          if value364 then
            f111()
          end
        end,
      })

      v1317:AddSection("Conveyor Upgraders")

      v1317:AddToggle("Toggle_FloorManager_F" .. i46 .. "AutoUpgradeConveyor", {
        Title = "Auto Upgrade Conveyor",
        Default = false,
        Callback = function(value365)
          v15["FloorManagerF" .. i46 .. "AutoUpgradeConveyor"] = value365

          if value365 then
            f113()
          end
        end,
      })
    end
  end
end

function v20.Pets()
  local addSubTabBar4 = v1312.Pets:AddSubTabBar({
    SubTabs = { "Pets", "Bees", "Fish" },
    Default = "Pets",
  })

  local pets15 = addSubTabBar4.Pets
  local bees19 = addSubTabBar4.Bees
  pets15:AddSection("Overview")

  v18.PetsOverview = pets15:AddParagraph("Paragraph_Pets_Overview", {
    Title = "Pets & Merchant Overview",
    Content = "Loading pets data...",
  })

  pets15:AddSection("Pet Management")

  pets15:AddDropdown("Dropdown_Pets_PetEquipMode", {
    Title = "Equip Priority Mode",
    Values = {
      "Farm Income", "Earnings Multiplier", "Seed Discount", "Seed Roll", "Super Roller",
    },
    Default = "Farm Income",
    Callback = function(value366)
      v15.PetsPetEquipMode = value366

      if v15.PetsAutoEquipBestPets or f8("Toggle_Pets_AutoEquipBestPets") then
        f127()
      end
    end,
  })

  pets15:AddToggle("Toggle_Pets_AutoEquipBestPets", {
    Title = "Auto Equip Best Pets",
    Default = false,
    Callback = function(value367)
      v15.PetsAutoEquipBestPets = value367

      if value367 then
        f127()
      end
    end,
  })

  pets15:AddSection("Pet Teams")

  local addInput = pets15:AddInput("Input_Pets_TeamName", {
    Title = "Team Name",
    Default = "",
    Placeholder = "Best earning",
    Callback = function(value368) v15.PetsTeamNameInput = value368 end,
  })

  local v1318 = v28.Load()
  local v1319 = v28.GetNames(v1318)
  local addDropdown

  pets15:AddButton({
    Title = "Save Current Team",
    Callback = function()
      v28.SaveCurrent(v15.PetsTeamNameInput, addDropdown, addInput, window)
    end,
  })

  pets15:AddDivider()

  addDropdown = pets15:AddDropdown("Dropdown_Pets_SelectedTeam", {
    Title = "Select Team",
    Values = v1319,
    Multi = false,
    Default = v1319[1] or nil,
    Callback = function(value369) v15.PetsSelectedTeam = value369 end,
  })

  pets15:AddButton({
    Title = "Equip Selected Team",
    Callback = function()
      local petsSelectedTeam = v15.PetsSelectedTeam or addDropdown.Value
      v28.Equip(petsSelectedTeam)
    end,
  })

  pets15:AddButton({
    Title = "Delete Selected Team",
    Confirm = "Are you sure you want to delete this team from local file?",
    Callback = function()
      local petsSelectedTeam2 = v15.PetsSelectedTeam or addDropdown.Value
      v28.Delete(petsSelectedTeam2, addDropdown)
    end,
  })

  pets15:AddButton({
    Title = "Unequip All Pets",
    Confirm = "Are you sure you want to unequip all currently equipped pets?",
    Callback = function() v28.UnequipAll() end,
  })

  pets15:AddSection("Feeding")

  pets15:AddDropdown("Dropdown_Pets_TargetTreats", {
    Title = "Treat Preference",
    Values = v14.PetTreatNames,
    Multi = true,
    Default = {},
    Callback = function(value370) v15.PetsTargetTreats = value370 end,
  })

  pets15:AddToggle("Toggle_Pets_AutoFeedTargetTreats", {
    Title = "Auto Feed Equipped Pets",
    Default = false,
    Callback = function(value371)
      v15.PetsAutoFeedTargetTreats = value371

      if value371 then
        f126()
      end
    end,
  })

  pets15:AddSection("Pet Merchant")

  pets15:AddToggle("Toggle_Pets_PetMerchantAutoBuySlots", {
    Title = "Auto Buy Merchant Slots",
    Default = false,
    Callback = function(value372)
      v15.PetsPetMerchantAutoBuySlots = value372

      if value372 then
        f128()
      end
    end,
  })

  pets15:AddDivider()

  pets15:AddDropdown("Dropdown_Pets_PetMerchantTargetEggs", {
    Title = "Target Eggs",
    Values = v14.PetEggNames,
    Multi = true,
    Searchable = true,
    Default = {},
  })

  pets15:AddToggle("Toggle_Pets_PetMerchantAutoBuyTargetEggs", {
    Title = "Auto Buy Selected Eggs",
    Default = false,
    Callback = function(value373)
      v15.PetsPetMerchantAutoBuyTargetEggs = value373

      if value373 then
        f129()
      end
    end,
  })

  pets15:AddSection("Sell Pets")

  pets15:AddDropdown("Dropdown_Pets_SellPetTargetRarities", {
    Title = "Target Sell Rarities",
    Values = v14.PlantRarities,
    Multi = true,
    Default = {},
    Callback = function(value374) v15.PetsSellPetTargetRarities = value374 end,
  })

  pets15:AddToggle("Toggle_Pets_SellPetAutoSellByRarity", {
    Title = "Auto Sell Pets",
    Confirm = "Are you sure you want to enable Auto Sell Pets?",
    Default = false,
    Callback = function(value375)
      v15.PetsSellPetAutoSellByRarity = value375

      if value375 then
        f130()
      end
    end,
  })

  bees19:AddSection("Overview")

  v18.BeeHoneyStats = bees19:AddParagraph("Paragraph_Pets_BeeHoneyStats", {
    Title = "Bees & Shop Overview",
    Content = "Scanning bee data...",
  })

  bees19:AddSection("Bee Management")

  bees19:AddDropdown("Dropdown_Pets_BeeEquipMode", {
    Title = "Equip Priority Mode",
    Description = not v15.ExecCanScrape
        and "<font color=\"#FF5252\">Limited on this executor</font>"
      or nil,
    Values = { "Farm Income", "Honey / Min", "Bee Roll Luck", "Seed Roll" },
    Default = "Farm Income",
    Callback = function(value376)
      v15.PetsBeeEquipMode = value376

      if v15.PetsAutoEquipBestBees or f8("Toggle_Pets_AutoEquipBestBees") then
        f134()
      end
    end,
  })

  bees19:AddToggle("Toggle_Pets_AutoEquipBestBees", {
    Title = "Auto Equip Best Bees",
    Description = not v15.ExecCanScrape
        and "<font color=\"#FF5252\">Limited on this executor</font>"
      or nil,
    Default = false,
    Callback = function(value377)
      v15.PetsAutoEquipBestBees = value377

      if value377 then
        f134()
      end
    end,
  })

  bees19:AddSection("Bee Gacha")

  bees19:AddToggle("Toggle_Pets_BeeGachaPauseIfNotEnoughHoney", {
    Title = "Pause If Not Enough Honey",
    Default = false,
    Callback = function(value378) v15.PetsBeeGachaPauseIfNotEnoughHoney = value378 end,
  })

  bees19:AddDivider()

  bees19:AddDropdown("Dropdown_Pets_BeeGachaTargetBees", {
    Title = "Target Roll Bees",
    Values = v14.BeeNames or {},
    Multi = true,
    Searchable = true,
    Default = {},
    Callback = function(value379) v15.PetsBeeGachaTargetBees = value379 end,
  })

  bees19:AddToggle("Toggle_Pets_BeeGachaAutoBuyTargetBees", {
    Title = "Auto Buy Selected Bees",
    Default = false,
    Callback = function(value380)
      v15.PetsBeeGachaAutoBuyTargetBees = value380

      if value380 then
        if v6.Options.Toggle_Pets_BeeGachaAutoBuyTargetRarities then
          v6.Options.Toggle_Pets_BeeGachaAutoBuyTargetRarities:SetValue(false)
        end

        f133()
      end
    end,
  })

  bees19:AddDivider()

  bees19:AddDropdown("Dropdown_Pets_BeeGachaTargetRarities", {
    Title = "Target Rarities",
    Values = v14.BeeRarities or {},
    Multi = true,
    Default = {},
    Callback = function(value381) v15.PetsBeeGachaTargetRarities = value381 end,
  })

  bees19:AddToggle("Toggle_Pets_BeeGachaAutoBuyTargetRarities", {
    Title = "Auto Buy Selected Rarities",
    Default = false,
    Callback = function(value382)
      v15.PetsBeeGachaAutoBuyTargetRarities = value382

      if value382 then
        if v6.Options.Toggle_Pets_BeeGachaAutoBuyTargetBees then
          v6.Options.Toggle_Pets_BeeGachaAutoBuyTargetBees:SetValue(false)
        end

        f133()
      end
    end,
  })

  bees19:AddSection("Bee Shop")

  bees19:AddDropdown("Dropdown_Pets_BeeShopTargetItems", {
    Title = "Target Items",
    Values = v14.BeeShopItemNames,
    Multi = true,
    Searchable = true,
    Default = {},
    Callback = function(value383) v15.PetsBeeShopTargetItems = value383 end,
  })

  bees19:AddToggle("Toggle_Pets_BeeShopAutoEquipHaggler", {
    Title = "Auto Equip Haggler Bee",
    Description = not v15.ExecCanScrape
        and "<font color=\"#FF5252\">Limited on this executor</font>"
      or nil,
    Default = false,
    Callback = function(value384) v15.PetsBeeShopAutoEquipHaggler = value384 end,
  })

  bees19:AddToggle("Toggle_Pets_BeeShopAutoBuyItems", {
    Title = "Auto Buy Selected Items",
    Default = false,
    Callback = function(value385)
      v15.PetsBeeShopAutoBuyItems = value385

      if value385 then
        f135()
      end
    end,
  })

  bees19:AddSection("Sell Bees")

  bees19:AddDropdown("Dropdown_Pets_SellBeeTargetRarities", {
    Title = "Target Sell Rarities",
    Values = v14.BeeRarities or v14.PlantRarities,
    Multi = true,
    Default = {},
    Callback = function(value386) v15.PetsSellBeeTargetRarities = value386 end,
  })

  bees19:AddToggle("Toggle_Pets_SellBeeAutoSellByRarity", {
    Title = "Auto Sell Bees",
    Confirm = "Are you sure you want to enable Auto Sell Bees?",
    Default = false,
    Callback = function(value387)
      v15.PetsSellBeeAutoSellByRarity = value387

      if value387 then
        f136()
      end
    end,
  })

  local fish3 = addSubTabBar4.Fish
  fish3:AddSection("Overview")

  v18.FishOverview = fish3:AddParagraph("Paragraph_Pets_FishOverview", {
    Title = "Aquarium & Fishing Status",
    Content = "Loading fishing data...",
  })

  fish3:AddSection("Fishing Bot")

  fish3:AddToggle("Toggle_Pets_FishAutoTeleportToPond", {
    Title = "Auto Teleport to Fishing Pond",
    Description = "Teleports to the dock if too far away",
    Default = false,
  })

  fish3:AddToggle("Toggle_Pets_FishPauseDuringEvents", {
    Title = "Pause Teleport During Events",
    Default = true,
  })

  fish3:AddToggle("Toggle_Pets_FishAutoFish", {
    Title = "Auto Fish",
    Default = false,
    Callback = function(value388)
      if value388 then
        v31.StartAutoFishLoop()
      end
    end,
  })

  fish3:AddSection("Aquarium & Sell Fish")

  fish3:AddDropdown("Dropdown_Pets_FishEquipMode", {
    Title = "Equip Priority Mode",
    Description = not v15.ExecCanScrape
        and "<font color=\"#FF5252\">Limited on this executor</font>"
      or nil,
    Values = {
      "Fast Bite (Minnow)", "Pearls / Min", "Fishing Stats", "Farm Income", "Roll Luck",
    },
    Default = "Fast Bite (Minnow)",
    Callback = function(value389)
      if f8("Toggle_Pets_FishAutoEquipBestFish") then
        v31.StartAutoEquipBestFishLoop()
      end
    end,
  })

  fish3:AddToggle("Toggle_Pets_FishAutoEquipBestFish", {
    Title = "Auto Equip Best Fish",
    Description = not v15.ExecCanScrape
        and "<font color=\"#FF5252\">Limited on this executor</font>"
      or "Equips best fish up to max Aquarium slots based on priority",
    Default = false,
    Callback = function(value390)
      if value390 then
        v31.StartAutoEquipBestFishLoop()
      end
    end,
  })

  fish3:AddDivider()

  fish3:AddDropdown("Dropdown_Pets_FishSellTargetRarities", {
    Title = "Target Sell Rarities",
    Values = v14.FishRarities or v14.PlantRarities,
    Multi = true,
    Default = {},
  })

  fish3:AddToggle("Toggle_Pets_FishAutoSellFish", {
    Title = "Auto Sell Fish",
    Confirm = "Are you sure you want to enable Auto Sell Fish?",
    Default = false,
    Callback = function(value391)
      if value391 then
        v31.StartAutoSellFishLoop()
      end
    end,
  })

  fish3:AddSection("Upgrades & Pearl Shop")

  fish3:AddToggle("Toggle_Pets_FishAutoUpgradeRod", {
    Title = "Auto Upgrade Fishing Rod",
    Default = false,
    Callback = function(value392)
      if value392 then
        v31.StartAutoFishingUpgradesLoop()
      end
    end,
  })

  fish3:AddToggle("Toggle_Pets_FishAutoUpgradeLuck", {
    Title = "Auto Upgrade Fishing Luck",
    Default = false,
    Callback = function(value393)
      if value393 then
        v31.StartAutoFishingUpgradesLoop()
      end
    end,
  })

  fish3:AddDivider()

  fish3:AddDropdown("Dropdown_Pets_FishTargetPearlShopItems", {
    Title = "Target Pearl Shop Items",
    Values = v14.PearlShopItems or {},
    Multi = true,
    Searchable = true,
    Default = {},
    Callback = function(value394) v15.PetsFishTargetPearlShopItems = value394 end,
  })

  fish3:AddToggle("Toggle_Pets_FishAutoBuyPearlShop", {
    Title = "Auto Buy Pearl Shop Items",
    Default = false,
    Callback = function(value395)
      v15.PetsFishAutoBuyPearlShop = value395

      if value395 then
        v31.StartAutoFishingUpgradesLoop()
      end
    end,
  })

  fish3:AddDivider()

  fish3:AddDropdown("Dropdown_Pets_FishTargetBaits", {
    Title = "Target Baits",
    Values = v14.FishingBaitNames or { "Abyssal Bait", "Golden Bait", "Worm Bait" },
    Multi = true,
    Searchable = true,
    Default = {},
    Callback = function(value396) v15.PetsFishTargetBaits = value396 end,
  })

  fish3:AddToggle("Toggle_Pets_FishAutoUseTargetBaits", {
    Title = "Auto Use Baits",
    Default = false,
    Callback = function(value397)
      v15.PetsFishAutoUseTargetBaits = value397

      if value397 then
        v31.StartAutoUseBaitLoop()
      end
    end,
  })
end

function v20.Events()
  v18.EventsCurrentEvent = v1312.Events:AddParagraph("Paragraph_Events_CurrentEvent", {
    Title = "World Events Status",
    Content = "Loading events status...",
  })

  local addSubTabBar5 = v1312.Events:AddSubTabBar({
    SubTabs = { "General", "Hacker", "Admin", "Guild", "Rewards" },
    Default = "General",
  })

  local general2 = addSubTabBar5.General
  local hacker = addSubTabBar5.Hacker
  local admin = addSubTabBar5.Admin
  local guild2 = addSubTabBar5.Guild
  local rewards = addSubTabBar5.Rewards

  general2:AddSection("The Collector")

  general2:AddDropdown("Dropdown_Events_CollectorIgnoreRarities", {
    Title = "Ignore Rarities",
    Description = "Never submit seeds of these rarities",
    Values = v14.PlantRarities,
    Multi = true,
    Searchable = true,
    Default = { "Celestial", "Eternal" },
    Callback = function(value398) v15.EventsCollectorIgnoreRarities = value398 end,
  })

  general2:AddDropdown("Dropdown_Events_CollectorIgnoreGears", {
    Title = "Ignore Gears",
    Description = "Never submit these gears (sprays/treats/fertilizers)",
    Values = v14.CollectorGearNames or {},
    Multi = true,
    Searchable = true,
    Default = {
      "Gilded Spray", "Admin Spray", "Butterfly Spray", "Ironclad Spray", "Acid Spray",
      "Super Fertilizer", "Super Pet Treat",
    },
    Callback = function(value399) v15.EventsCollectorIgnoreGears = value399 end,
  })

  general2:AddToggle("Toggle_Events_AutoSubmitCollector", {
    Title = "Auto Submit Collector",
    Default = false,
    Callback = function(value400)
      v15.EventsAutoSubmitCollector = value400

      if value400 then
        v30.StartCollectorLoop()
      end
    end,
  })

  general2:AddSection("Train Voyage")

  general2:AddToggle("Toggle_Events_PauseAutoSellFruits", {
    Title = "Pause Auto Sell Fruits",
    Description = "Hold fruits until train cart is full",
    Default = true,
    Callback = function(value401) v15.EventsPauseAutoSellFruits = value401 end,
  })

  general2:AddToggle("Toggle_Events_AutoTrainVoyage", {
    Title = "Auto Train Voyage",
    Default = false,
    Callback = function(value402)
      v15.EventsAutoTrainVoyage = value402

      if value402 then
        v30.StartTrainVoyageLoop()
      end
    end,
  })

  general2:AddSection("Butterfly Bloom")

  general2:AddToggle("Toggle_Events_AutoClaimQueenMoth", {
    Title = "Auto Claim Queen Moth",
    Default = false,
    Callback = function(value403)
      v15.EventsAutoClaimQueenMoth = value403

      if value403 then
        pcall(function()
          local queenMoth2 = collectionService:GetTagged("QueenMoth")

          if #queenMoth2 > 0 then
            v30.ClaimQueenMoth(queenMoth2[1])
          end
        end)
      end
    end,
  })

  hacker:AddSection("Overview & Status")

  v18.EventsHackerStatus = hacker:AddParagraph("Paragraph_Events_HackerStatus", {
    Title = "Hacker Invasion Status",
    Content = "Loading hacker event status...",
  })

  hacker:AddSection("1x1x1x1 Boss Fight")

  hacker:AddToggle("Toggle_Events_HackerAutoBossFight", {
    Title = "Auto Fight 1x1x1x1 Boss",
    Default = false,
    Callback = function(value404)
      v15.EventsHackerAutoBossFight = value404

      if value404 then
        v30.StartHackerBossFightLoop()
      end
    end,
  })

  hacker:AddToggle("Toggle_Events_HackerAutoDeflect", {
    Title = "Auto Deflect Orbs",
    Default = true,
    Callback = function(value405) v15.EventsHackerAutoDeflect = value405 end,
  })

  hacker:AddToggle("Toggle_Events_HackerAutoUplink", {
    Title = "Auto Capture Uplinks",
    Default = true,
    Callback = function(value406) v15.EventsHackerAutoUplink = value406 end,
  })

  hacker:AddToggle("Toggle_Events_HackerAutoSmash", {
    Title = "Auto Hammer Smash When Down",
    Default = true,
    Callback = function(value407) v15.EventsHackerAutoSmash = value407 end,
  })

  hacker:AddSection("Bytes Gathering & Automation")

  hacker:AddToggle("Toggle_Events_HackerAutoCollectPiles", {
    Title = "Auto Collect Bolt Piles",
    Default = false,
    Callback = function(value408)
      v15.EventsHackerAutoCollectPiles = value408

      if value408 then
        v30.StartHackerGatheringLoop()
      end
    end,
  })

  hacker:AddToggle("Toggle_Events_HackerAutoStompBugs", {
    Title = "Auto Stomp Glitch Bugs",
    Default = false,
    Callback = function(value409)
      v15.EventsHackerAutoStompBugs = value409

      if value409 then
        v30.StartHackerGatheringLoop()
      end
    end,
  })

  hacker:AddToggle("Toggle_Events_HackerAutoSolveTerminals", {
    Title = "Auto Solve Hack Terminals",
    Description = "*BUGS*",
    Default = false,
    Callback = function(value410)
      v15.EventsHackerAutoSolveTerminals = value410

      if value410 then
        v30.StartHackerTerminalSolverLoop()
      end
    end,
  })

  hacker:AddToggle("Toggle_Events_HackerAutoCollectMiner", {
    Title = "Auto Collect Data Miner",
    Default = false,
    Callback = function(value411)
      v15.EventsHackerAutoCollectMiner = value411

      if value411 then
        v30.StartHackerDataMinerLoop()
      end
    end,
  })

  hacker:AddSection("Hacker Shop")

  hacker:AddDropdown("Dropdown_Events_HackerShopTargetItems", {
    Title = "Target Items",
    Values = v14.HackerShopItemNames or {},
    Multi = true,
    Default = {},
    Callback = function(value412) v15.EventsHackerShopTargetItems = value412 end,
  })

  hacker:AddToggle("Toggle_Events_HackerShopAutoBuy", {
    Title = "Auto Buy Target Items",
    Default = false,
    Callback = function(value413)
      v15.EventsHackerShopAutoBuy = value413

      if value413 then
        v30.StartHackerShopLoop()
      end
    end,
  })

  admin:AddSection("Admin Event Overview")

  v18.EventsAdminStatus = admin:AddParagraph("Paragraph_Events_AdminStatus", {
    Title = "Admin Event Status",
    Content = "Loading admin event status...",
  })

  admin:AddSection("Admin Automation")

  admin:AddToggle("Toggle_Events_AdminAutoUpgradeLuck", {
    Title = "Auto Upgrade Admin Seed Luck",
    Default = false,
    Callback = function(value414)
      v15.EventsAdminAutoUpgradeLuck = value414

      if value414 then
        v30.StartAdminEventLoop()
      end
    end,
  })

  admin:AddToggle("Toggle_Events_AdminAutoUpgradePodiums", {
    Title = "Auto Upgrade Admin Podiums",
    Default = false,
    Callback = function(value415)
      v15.EventsAdminAutoUpgradePodiums = value415

      if value415 then
        v30.StartAdminEventLoop()
      end
    end,
  })

  admin:AddToggle("Toggle_Events_AdminAutoBuyPodiumSpecials", {
    Title = "Auto Buy Admin Spray / Admin Egg",
    Default = true,
    Callback = function(value416)
      v15.EventsAdminAutoBuyPodiumSpecials = value416

      if value416 then
        v30.StartAdminEventLoop()
      end
    end,
  })

  guild2:AddSection("Guild Overview")

  v18.EventsGuildOverview = guild2:AddParagraph("Paragraph_Events_GuildOverview", {
    Title = "Guild Status",
    Content = "Fetching guild information...",
  })

  guild2:AddSection("Quests & Rewards")

  guild2:AddToggle("Toggle_Events_GuildAutoClaimDailyQuests", {
    Title = "Auto Claim Daily Quests",
    Default = false,
    Callback = function(value417)
      v15.EventsGuildAutoClaimDailyQuests = value417

      if value417 then
        v27.StartAutoClaimDailyQuestsLoop()
      end
    end,
  })

  guild2:AddToggle("Toggle_Events_GuildAutoClaimReward", {
    Title = "Auto Claim Weekly Reward",
    Default = false,
    Callback = function(value418)
      v15.EventsGuildAutoClaimReward = value418

      if value418 then
        v27.StartAutoClaimRewardLoop()
      end
    end,
  })

  rewards:AddSection("Free Rewards")

  rewards:AddToggle("Toggle_Events_AutoClaimDaily", {
    Title = "Auto Claim Daily Reward",
    Default = false,
    Callback = function(value419)
      v15.EventsAutoClaimDaily = value419

      if value419 then
        f151()
      end
    end,
  })

  rewards:AddToggle("Toggle_Events_AutoClaimGroup", {
    Title = "Auto Claim Group Reward",
    Default = false,
    Callback = function(value420)
      v15.EventsAutoClaimGroup = value420

      if value420 then
        f152()
      end
    end,
  })

  rewards:AddSection("Index Milestones")

  rewards:AddToggle("Toggle_Events_AutoClaimIndexRewards", {
    Title = "Auto Claim Index Rewards",
    Default = false,
    Callback = function(value421)
      v15.EventsAutoClaimIndexRewards = value421

      if value421 then
        v30.StartIndexRewardsLoop()
      end
    end,
  })

  rewards:AddSection("Promo Codes")

  rewards:AddInput("Input_Events_PromoCode", {
    Title = "Promo Code(s)",
    Description = "Separate codes with space, comma, or newline",
    Default = "",
    Placeholder = "Paste code(s) here...",
    Callback = function(value422) v15.EventsPromoCode = value422 end,
  })

  rewards:AddButton({
    Title = "Redeem Codes",
    Callback = function()
      local eventsPromoCode = v15.EventsPromoCode or f8("Input_Events_PromoCode")

      if not eventsPromoCode or type(eventsPromoCode) ~= "string"
        or string.match(eventsPromoCode, "%S") == nil then
        v22.Reward("Please enter at least one promo code!")
        return
      end

      local v1320 = {}

      for match in string.gmatch(eventsPromoCode, "[^%s,;]+") do
        table.insert(v1320, match)
      end

      if #v1320 == 0 then
        v22.Reward("No valid codes found!")
        return
      end

      task.spawn(function()
        local v1321 = f6()
        local redeemedCodes = v1321 and v1321.RedeemedCodes or {}

        for index216, value423 in ipairs(v1320) do
          if redeemedCodes[value423] or redeemedCodes[string.upper(value423)] then
            v22.Reward(string.format("Code '%s' already redeemed!", value423))
          elseif v23.InvokeServer("RedeemCode", value423) == true then
            v22.Reward(string.format("Code '%s': Redeemed successfully!", value423))
          else
            v22.Reward(string.format("Code '%s': Failed / Invalid!", value423))
          end

          task.wait(0.5)
        end
      end)
    end,
  })
end

function v20.Misc()
  v1312.Misc:AddSection("Unboxing")

  v1312.Misc:AddToggle("Toggle_Misc_AutoOpenEggs", {
    Title = "Auto Open Eggs",
    Default = false,
    Callback = function(value424)
      v15.MiscAutoOpenEggs = value424

      if value424 then
        f124()
      end
    end,
  })

  v1312.Misc:AddToggle("Toggle_Misc_AutoOpenCrates", {
    Title = "Auto Open Crates",
    Default = false,
    Callback = function(value425)
      v15.MiscAutoOpenCrates = value425

      if value425 then
        f124()
      end
    end,
  })

  v1312.Misc:AddToggle("Toggle_Misc_AutoOpenBeeCocoons", {
    Title = "Auto Open Bee Cocoons",
    Default = false,
    Callback = function(value426)
      v15.MiscAutoOpenBeeCocoons = value426

      if value426 then
        f124()
      end
    end,
  })

  v1312.Misc:AddToggle("Toggle_Misc_AutoOpenSeedPacks", {
    Title = "Auto Open Seed Packs",
    Default = false,
    Callback = function(value427)
      v15.MiscAutoOpenSeedPacks = value427

      if value427 then
        f124()
      end
    end,
  })

  v1312.Misc:AddToggle("Toggle_Misc_AutoOpenChests", {
    Title = "Auto Open Chests & Caches",
    Description = "Open Chests, Pails & Caches in inventory",
    Default = false,
    Callback = function(value428)
      v15.MiscAutoOpenChests = value428

      if value428 then
        f124()
      end
    end,
  })

  v1312.Misc:AddSection("Plots Interaction")

  v1312.Misc:AddToggle("Toggle_Misc_AutoLikePlots", {
    Title = "Auto Like Plots",
    Default = false,
    Callback = function(value429)
      v15.MiscAutoLikePlots = value429

      if value429 then
        f150()
      end
    end,
  })

  v1312.Misc:AddSection("Friend")

  v1312.Misc:AddToggle("Toggle_Misc_AutoFriendRequest", {
    Title = "Auto Send / Accept Friend Request",
    Description = "Send/Accept for friend boost",
    Default = false,
    Callback = function(value430) f90(value430) end,
  })

  v1312.Misc:AddSection("Teleport")

  v1312.Misc:AddKeybind("Keybind_Misc_Floor1Teleport", {
    Title = "Teleport to Floor 1",
    Description = "PC only",
    Mode = "Toggle",
    Default = "Q",
    Callback = function() pcall(function() f91(1) end) end,
  })

  v1312.Misc:AddToggle("Toggle_Misc_ShowFloorTeleport", {
    Title = "Show Floor Teleport Buttons",
    Description = "Top-left screen buttons",
    Default = true,
    Callback = function(value431)
      v15.MiscShowFloorTeleport = value431

      if v16.FloorTeleportGui then
        v16.FloorTeleportGui.Enabled = value431
      elseif value431 then
        f92()
      end
    end,
  })
end

function v20.Settings()
  v1312.Settings:AddSection("Notification")

  v1312.Settings:AddToggle("Toggle_Settings_FarmNotification", {
    Title = "Farm & Compost Notifications",
    Default = true,
    Callback = function(value432) v15.SettingsFarmNotification = value432 end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_SeedGachaNotification", {
    Title = "Seed Gacha Notifications",
    Default = true,
    Callback = function(value433) v15.SettingsSeedGachaNotification = value433 end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_ShopNotification", {
    Title = "Shop Notifications",
    Default = true,
    Callback = function(value434) v15.SettingsShopNotification = value434 end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_FloorManagerNotification", {
    Title = "Floor Manager Notifications",
    Default = true,
    Callback = function(value435) v15.SettingsFloorManagerNotification = value435 end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_AnimalsNotification", {
    Title = "Animals Notifications",
    Description = "Notifications for Pets, Bees, and Fishing",
    Default = true,
    Callback = function(value436) v15.SettingsAnimalsNotification = value436 end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_EventNotification", {
    Title = "World Event Notifications",
    Default = true,
    Callback = function(value437) v15.SettingsEventNotification = value437 end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_RewardNotification", {
    Title = "Reward Notifications",
    Default = true,
    Callback = function(value438) v15.SettingsRewardNotification = value438 end,
  })

  v1312.Settings:AddDivider()

  v1312.Settings:AddToggle("Toggle_Settings_MuteGameNotiSounds", {
    Title = "Mute Game Notification Sounds",
    Description = "Mute game notification and error sound effects",
    Default = false,
    Callback = function(value439)
      v15.SettingsMuteGameNotiSounds = value439
      f83(value439)
    end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_HideGameErrorPopups", {
    Title = "Hide Game Error Popups",
    Description = "Hide error popups (e.g. not enough money)",
    Default = false,
    Callback = function(value440) v15.SettingsHideGameErrorPopups = value440 end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_HideGameSuccessPopups", {
    Title = "Hide Game Success Popups",
    Description = "Hide success popups (e.g. compost inserted)",
    Default = false,
    Callback = function(value441) v15.SettingsHideGameSuccessPopups = value441 end,
  })

  v1312.Settings:AddSection("Performance")

  v1312.Settings:AddToggle("Toggle_Settings_DisableParagraphs", {
    Title = "Disable Paragraph Updates",
    Description = "Disable all status paragraph updates to minimize Lua memory & GUI overhead",
    Default = false,
    Callback = function(value442)
      v15.SettingsDisableParagraphs = value442

      if value442 then
        f12()
      end
    end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_PotatoGraphics", {
    Title = "Potato Graphics",
    Description = "Disable particles, beams, lights, shadows, terrain grass, event VFX & minimum quality",
    Default = false,
    Callback = function(value443)
      v15.SettingsPotatoGraphics = value443
      v21.UpdatePotatoGraphics(value443)
    end,
  })

  v1312.Settings:AddToggle("Toggle_Settings_DisableRollFov", {
    Title = "Disable Roll FOV & Sound Effects",
    Description = "Lock camera FOV and mute roller sound effects",
    Default = false,
    Callback = function(value444)
      v15.SettingsDisableRollFov = value444
      v21.UpdateFovWatchdog(value444)
      v21.ApplyRollerSoundMute(value444)
    end,
  })

  if v15.PlayerDataComplete then
    v1312.Settings:AddToggle("Toggle_Settings_InstantRoll", {
      Title = "Instant Roll (Disable All Effects)",
      Description = "Disable camera zoom, roll cycle, tier VFX, cutscenes and reveal seeds instantly",
      Default = false,
      Callback = function(value445)
        v15.SettingsInstantRoll = value445
        v21.UpdateInstantRoll(value445)
      end,
    })
  end

  v1312.Settings:AddSection("Debug")

  if type(appendfile) == "function" then
    v1312.Settings:AddToggle("Toggle_Settings_EnableFileLogging", {
      Title = "Save Logs To File",
      Description = "Save console logs to 'Lamduck/BuildARingFarm2' folder",
      Default = false,
      Callback = function(value446)
        v15.SettingsEnableFileLogging = value446

        if value446 and not v32.FilePath then
          v32.InitFile()
        end
      end,
    })
  end
end

v20.Farm()
v20.Shop()
v20.FloorManager()
v20.Pets()
v20.Events()
v20.Misc()
v20.Settings()

v7:SetLibrary(v6)
v9:SetLibrary(v6)
v7:SetFolder("Lamduck/BuildARingFarm2")
v9:SetFolder("Lamduck/BuildARingFarm2")
v7:SetIgnoreIndexes({})
v9:BuildExtraSection(v1312.Settings)
v7:BuildConfigSection(v1312.Settings)

v17.RollPodiums = v23.OnClientEvent("RollPodiums", function(lastRolledSeeds3)
  if v6.Unloaded then
    return
  end

  v16.LastRolledSeeds = lastRolledSeeds3

  v15.RollVersion = (v15.RollVersion or 0) + 1
  v15.RollPodiumsReceived = true
end)

v17.UseSuperRoller = v23.OnClientEvent("UseSuperRoller", function(p303, p304)
  if v6.Unloaded then
    return
  end

  v15.SuperRollerRollVersion = (v15.SuperRollerRollVersion or 0) + 1

  if p303 == 1 then
    v15.SuperRollerState = 1
    v15.SuperRollerStartTime = time()
    v15.SuperRollerStarted = true
    v15.SuperRollerFinished = false
    v15.SuperRollerResult = nil
    v15.SuperRollerStopSent = false
    v15.SuperRollerSeedBought = false
  elseif p303 == 2 then
    v15.SuperRollerState = 2
    v15.SuperRollerFinished = true
    v15.SuperRollerResult = p304

    v16.LastSuperRollerResult = p304
    v15.SuperRollerSeedBought = false
  end
end)

v17.BuySuperRollerSeed = v23.OnClientEvent("BuySuperRollerSeed", function()
  if v6.Unloaded then
    return
  end

  v15.SuperRollerSeedBought = true
end)

v17.RollBee = v23.OnClientEvent("RollBee", function(lastRolledBee2)
  if v6.Unloaded then
    return
  end

  v15.LastRolledBee = lastRolledBee2
  v15.RollBeeReceived = true
end)

v17.FishingCast = v23.OnClientEvent("FishingCast", function(p305, p306)
  if v6.Unloaded then
    return
  end

  v16.FishingCastAccepted = true
end)

v17.FishBite = v23.OnClientEvent("FishBite", function()
  if v6.Unloaded then
    return
  end

  v16.FishingBiteTriggered = true
  v16.FishingLastBiteTime = os.clock()
end)

v17.FishCaught = v23.OnClientEvent("FishCaught", function(p307)
  if v6.Unloaded then
    return
  end

  v16.FishingBiteTriggered = false
  v16.FishingCastAccepted = false

  if v16.ActiveBaits then
    v16.ActiveBaits["Abyssal Bait"] = nil
  end

  for index217, value447 in ipairs(type(p307) == "table" and (p307[1] and p307 or { p307 }) or {}) do
    if type(value447) == "table" and value447.Name then
      v16.LastCaughtFish = value447
      local fish4 = v14.Fish and v14.Fish[value447.Name]
      local rarity16 = value447.Rarity or fish4 and fish4.Rarity or "Common"
      local v1322 = string.format("%.2f kg", tonumber(value447.Weight) or 1)
      local v1323 = ""

      if fish4 then
        if fish4.PearlsPerMin and fish4.PearlsPerMin > 0 then
          v1323 = string.format(" | +%.1f Pearls/m", fish4.PearlsPerMin)
        elseif fish4.AbilityInfo and fish4.AbilityInfo.Boost then
          v1323 = string.format(" | %s Boost", tostring(fish4.AbilityInfo.Boost))
        end
      end

      v22.Fish(string.format("Caught %s (%s - %s)%s", value447.Name, rarity16, v1322, v1323), 4)
    end
  end
end)

v17.FishEscaped = v23.OnClientEvent("FishEscaped", function()
  if v6.Unloaded then
    return
  end

  v16.FishingBiteTriggered = false
  v16.FishingCastAccepted = false
end)

v17.UseComposter = v23.OnClientEvent("UseComposter", function(p308, p309, p310, p311)
  if v6.Unloaded then
    return
  end

  v22.Farm(string.format(
    "Composter reward: %dx %s (%s)", p311 or 1, tostring(p310), tostring(p309)
  ), 4)
end)

v17.QueenMothAdded = collectionService:GetInstanceAddedSignal("QueenMoth"):Connect(function(p312)
  if v6.Unloaded then
    return
  end

  if v15.EventsAutoClaimQueenMoth or f8("Toggle_Events_AutoClaimQueenMoth") then
    v30.ClaimQueenMoth(p312)
  end
end)

v17.QueenMothRemoved = collectionService:GetInstanceRemovedSignal("QueenMoth"):Connect(function()
  if v6.Unloaded then
    return
  end

  v16.QueenMothNotified = nil
end)

v17.GuildUpdated = v23.OnClientEvent("GuildUpdated", function(guildData)
  if v6.Unloaded then
    return
  end

  v16.GuildData = guildData
  pcall(v27.UpdateParagraph)
end)

v17.HackerBossOrbs = v23.OnClientEvent("HackerBossOrbs", function(p313)
  if v6.Unloaded then
    return
  end

  if not (v15.EventsHackerAutoDeflect or f8("Toggle_Events_HackerAutoDeflect")) then
    return
  end

  if type(p313) ~= "table" or type(p313.L) ~= "table" then
    return
  end

  local userId = localPlayer.UserId

  for index218, value448 in ipairs(p313.L) do
    if type(value448) == "table" and value448[2] == userId then
      local v1324 = value448[1]
      local v1325 = value448[4]

      if type(v1324) == "number" and type(v1325) == "number" then
        local v1326 = math.max(0, v1325 - workspace:GetServerTimeNow() - 0.01)

        task.delay(v1326, function()
          if v6.Unloaded then
            return
          end

          local getServerTimeNow11 = workspace:GetServerTimeNow()
          v23.FireServer("HackerBossDeflect", v1324, getServerTimeNow11)
          v30.TriggerHackerBossEvent()

          v50(
            "[Hacker/Boss] Network deflect sent for Orb %d at server time %.3f", v1324,
            getServerTimeNow11
          )

          v22.Event("Deflected Boss Orb (Perfect)!")
        end)
      end
    end
  end
end)

v17.HackStarted = v23.OnClientEvent("HackStarted", function(p314)
  if v6.Unloaded then
    return
  end

  if not (v15.EventsHackerAutoSolveTerminals or f8("Toggle_Events_HackerAutoSolveTerminals")) then
    return
  end

  if type(p314) ~= "table" or not p314.Id or not p314.Seed then
    return
  end

  v15.IsHacking = true
  v16.HackerTerminalLastStartedId = p314.Id
  v50("[Hacker/Terminals] HackStarted received: ID=%s, Seed=%d", tostring(p314.Id), p314.Seed)
  pcall(function() game:GetService("ContextActionService"):UnbindAction("HackTerminalLock") end)

  task.spawn(function()
    local v1327 = nil

    if v15.ExecCanScrape then
      local hackerBytes = replicatedStorage:FindFirstChild("Shared")
        and replicatedStorage.Shared:FindFirstChild("Services")
        and replicatedStorage.Shared.Services:FindFirstChild("Config")
        and replicatedStorage.Shared.Services.Config:FindFirstChild("HackerBytes")

      v1327 = hackerBytes and f1(hackerBytes)
    end

    local v1328

    if v1327 and v1327.CreateRounds then
      v1328 = v1327.CreateRounds(p314.Seed)
    else
      local v1329 = {
        { Speed = 0.75, Gap = 0.22 }, { Speed = 0.95, Gap = 0.18 },
        { Speed = 1.15, Gap = 0.15 }, { Speed = 1.4, Gap = 0.12 },
      }

      local random = Random.new(p314.Seed)
      v1328 = {}

      for index219, value449 in ipairs(v1329) do
        local v1330 = value449.Gap / 2 + 0.06

        v1328[index219] = {
          Speed = value449.Speed,
          Gap = value449.Gap,
          Center = random:NextNumber(v1330, 1 - v1330),
          Phase = random:NextNumber(0, 2),
        }
      end
    end

    local v1331 = {}

    for index220, value450 in ipairs(v1328) do
      local v1332 = nil
      local v1333 = {}

      for i47 = 0, 6 do
        local v1334 = (i47 * 2 + value450.Center - value450.Phase) / value450.Speed

        if v1334 >= 0.15 and v1334 <= 3.5 then
          table.insert(v1333, v1334)
        end

        local v1335 = (i47 * 2 + (2 - value450.Center) - value450.Phase) / value450.Speed

        if v1335 >= 0.15 and v1335 <= 3.5 then
          table.insert(v1333, v1335)
        end
      end

      table.sort(v1333)

      for index221, value451 in ipairs(v1333) do
        if not v1327 or v1327.JudgeLock(value450, value451) == "Perfect" then
          v1332 = value451
          break
        end
      end

      if not v1332 and v1327 then
        for i48 = 0.15, 4, 0.005 do
          if v1327.JudgeLock(value450, i48) == "Perfect" then
            v1332 = i48
            break
          end
        end
      end

      if not v1332 then
        local v1336 = value450.Phase > value450.Center and 2 or 0
        v1332 = math.max(0.15, (v1336 + value450.Center - value450.Phase) / value450.Speed)
      end

      v1331[index220] = v1332
    end

    local getServerTimeNow12 = workspace:GetServerTimeNow()
    local v1337 = math.max(0, (p314.StartAt or getServerTimeNow12) - getServerTimeNow12)

    if v1337 > 0 then
      task.wait(v1337)
    end

    local playerGui9 = localPlayer:FindFirstChild("PlayerGui")
    local mainUI10 = playerGui9 and playerGui9:FindFirstChild("MainUI")
    local hackTerminal = mainUI10 and mainUI10:FindFirstChild("HackTerminal")
    local window2 = hackTerminal and hackTerminal:FindFirstChild("Window")

    for i49 = 1, 4 do
      if v6.Unloaded or not v15.IsHacking then
        break
      end

      task.wait(v1331[i49])

      if v6.Unloaded or not v15.IsHacking then
        break
      end

      if window2 and window2.Visible then
        pcall(function()
          local digits = window2:FindFirstChild("Digits")
          local findFirstChild34 = digits and digits:FindFirstChild("Digit" .. tostring(i49))
          local label = findFirstChild34 and findFirstChild34:FindFirstChild("Label")

          local uiStroke2 = findFirstChild34
            and findFirstChild34:FindFirstChildOfClass("UIStroke")

          if label then
            label.Text = tostring(math.random(0, 9))
            label.TextColor3 = Color3.fromRGB(235, 255, 240)
          end

          if uiStroke2 then
            uiStroke2.Color = Color3.fromRGB(235, 255, 240)
          end
        end)
      end

      v50("[Hacker/Terminals] Digit %d Perfect timing: %.3fs", i49, v1331[i49])

      if i49 < 4 then
        task.wait(0.7)
      end
    end

    if v6.Unloaded or not v15.IsHacking then
      return
    end

    task.wait(0.15)
    v23.FireServer("FinishHack", p314.Id, v1331)
    v16.HackerTerminalLastCompletedId = p314.Id
    v50("[Hacker/Terminals] Fired FinishHack with 4 Perfect reaction times via Remote.")
  end)
end)

v17.HackFinished = v23.OnClientEvent("HackFinished", function(p315)
  if v6.Unloaded then
    return
  end

  v15.IsHacking = false

  if type(p315) ~= "table" then
    return
  end

  if p315.CooldownUntil then
    v16.HackerTerminalCooldownUntil = p315.CooldownUntil
  end

  if p315.Id then
    v16.HackerTerminalLastCompletedId = p315.Id
  end

  if p315.Bytes and p315.Bytes > 0 then
    v22.Event(string.format("Cracked Hack Terminal (+%d Bytes)!", p315.Bytes))

    v50(
      "[Hacker/Terminals] Hack Finished: Won %d Bytes! Cooldown until: %.0f", p315.Bytes,
      p315.CooldownUntil or 0
    )
  end
end)

v17.HackRefused = v23.OnClientEvent("HackRefused", function(p316, p317)
  if v6.Unloaded then
    return
  end

  v15.IsHacking = false

  if p316 == "Cooldown" and p317 then
    v16.HackerTerminalCooldownUntil = p317

    v50(
      "[Hacker/Terminals] Hack refused: Terminal rebooting (%ds left).",
      (math.max(0, math.ceil(p317 - workspace:GetServerTimeNow())))
    )
  elseif p316 == "Lockdown" then
    v50("[Hacker/Terminals] Hack refused: Terminals in lockdown during 1x1x1x1 Boss.")
    v16.HackerTerminalCooldownUntil = workspace:GetServerTimeNow() + 15
  end
end)

v23.FireServer("RequestGuildSnapshot")
f84()
f99()
f100()
f115()
f121()
f122()
f131()
f153()
v31.StartUpdateFishOverviewLoop()
v21.StartGCAssistantLoop()

if v15.MiscShowFloorTeleport ~= false then
  f92()
end

v6.OnUnload:Once(function()
  if v16.FloorTeleportGui then
    v16.FloorTeleportGui:Destroy()
    v16.FloorTeleportGui = nil
  end

  v21.RestoreAllPerformanceSettings()

  if v30.RemoveHover then
    pcall(v30.RemoveHover)
  end

  pcall(function()
    local v1338 = f3()
    local fishingGui4 = v1338 and v1338:FindFirstChild("FishingGui")

    local holdText2 = fishingGui4 and fishingGui4:FindFirstChild("CastBar")
      and fishingGui4.CastBar:FindFirstChild("HoldText")

    if holdText2 and holdText2.Text == "Auto Fishing Enabled" then
      holdText2.Text = "Hold To Cast"
    end
  end)

  for key118, value452 in pairs(v17) do
    if typeof(value452) == "RBXScriptConnection" and value452.Connected then
      value452:Disconnect()
    end
  end

  table.clear(v15)
  table.clear(v16)
  table.clear(v17)
  table.clear(v18)
end)

v7:LoadAutoloadConfig()
window:SelectTab(1)
