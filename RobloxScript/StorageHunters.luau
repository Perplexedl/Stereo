local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local httpService = game:GetService("HttpService")
local tweenService = game:GetService("TweenService")
local localPlayer = players.LocalPlayer
local v5 = {}

local v6 = {
  SettingsEnableFileLogging = true,
  SettingsUseTweenSafeMode = false,
  FarmVehicleCargoMaxPercent = 90,
  FarmVehicleCargoMinPercent = 10,
  FarmAuctionMaxSpendPercent = 5,
  IsSellingActive = false,
  RewardsAutoClaimDaily = false,
  RewardsAutoClaimAchievements = false,
  RewardsAutoClaimCollections = false,
  ShopAutoUpgrade = false,
  ShopAutoEquipBestAccessories = false,
  ShopAccessoryPreset = "Balanced",
  ShopAutoBuyAndEquipVehicle = false,
  ShopStaffMinOfferPercent = 105,
  ShopAutoHireStaff = false,
  ShopAutoUpgradeStaff = false,
  ShopAutoUnlockStationSlots = false,
  ShopAutoBuyBestWrench = false,
  ShopAutoBuyBestLockpick = false,
  FarmAutoUpgrade = false,
  FarmStaffMinOfferPercent = 105,
  FarmAutoHireStaff = false,
  FarmAutoUpgradeStaff = false,
  FarmAuctionAutoClaimLostItems = false,
  FarmClearInventoryBeforeAuction = true,
  FarmMinigamesBudgetSecs = 60,
  ServicesAutoTimeCapsule = false,
  QuestsAutoStory = false,
  QuestsProtectItems = true,
  QuestsSelectedBranch = "Story Progression",
}

local v7 = {}
local v8 = {}
local v9 = {}
local v10 = { FilePath = nil, LastMsg = nil }
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
local v23 = {}
local v24 = {}
local v25 = {}
local v26 = {}
local v27 = {}
local v28 = {}
local v29 = {}

local function f1(p1)
  local options = v1 and v1.Options
  local v30 = options and options[p1]
  return v30 and v30.Value
end

function v10.InitFile()
  local v31, v32 = pcall(function()
    if type(makefolder) == "function" then
      if type(isfolder) == "function" then
        if not isfolder("Lamduck") then
          pcall(makefolder, "Lamduck")
        end

        if not isfolder("Lamduck/StorageHunters") then
          pcall(makefolder, "Lamduck/StorageHunters")
        end
      else
        pcall(makefolder, "Lamduck")
        pcall(makefolder, "Lamduck/StorageHunters")
      end
    end

    if type(listfiles) == "function" then
      local v33, v34 = pcall(listfiles, "Lamduck/StorageHunters")

      if v33 and type(v34) == "table" then
        local v35 = {}

        for index, value in ipairs(v34) do
          local v36 = string.match(value, "[^/\\]+$") or value

          if string.sub(v36, 1, 15) == "StorageHunters_" and string.sub(v36, -4) == ".log" then
            table.insert(v35, { path = value, name = v36 })
          end
        end

        table.sort(v35, function(p2, p3)
          return (string.match(p2.name, "(%d%d%d%d%-%d%d%-%d%d_%d%d%-%d%d%-%d%d)") or p2.name)
            < (string.match(p3.name, "(%d%d%d%d%-%d%d%-%d%d_%d%d%-%d%d%-%d%d)") or p3.name)
        end)

        while #v35 >= 10 do
          local v37 = table.remove(v35, 1)

          if type(delfile) == "function" then
            pcall(delfile, v37.path)
          end
        end
      end
    end

    local toLocalTime = DateTime.now():ToLocalTime()

    local v38 = string.format(
      "%04d-%02d-%02d_%02d-%02d-%02d", toLocalTime.Year, toLocalTime.Month, toLocalTime.Day,
      toLocalTime.Hour, toLocalTime.Minute, toLocalTime.Second
    )

    local gsub = "Unknown"

    if type(identifyexecutor) == "function" then
      local v39, v40 = pcall(identifyexecutor)

      if v39 and type(v40) == "string" and v40 ~= "" then
        gsub = v40:gsub("[%c%p%s]+", "_")
      end
    end

    local v41 = string.format(
      "%s/StorageHunters_%s_%s.log", "Lamduck/StorageHunters", gsub, v38
    )

    local v42 = string.format([[
========================================
StorageHunters Log Session
Executor: %s
Start Time: %s
========================================
]], gsub, DateTime.now():ToIsoDate())

    if type(writefile) == "function" then
      local v43 = pcall(writefile, v41, v42)

      if not v43 then
        v41 = string.format("StorageHunters_%s_%s.log", gsub, v38)
        v43 = pcall(writefile, v41, v42)
      end

      if v43 then
        v10.FilePath = v41
      end
    end
  end)

  if not v31 then
    warn("[Logger] Failed to initialize file logger: " .. tostring(v32))
  end
end

function v10.AppendFile(p4)
  if not v10.FilePath then
    v10.InitFile()
  end

  if not v10.FilePath then
    return
  end

  if type(appendfile) == "function" then
    pcall(appendfile, v10.FilePath, p4 .. "\n")
  elseif type(writefile) == "function" and type(readfile) == "function" then
    pcall(function()
      local v44 = readfile(v10.FilePath) or ""
      writefile(v10.FilePath, v44 .. p4 .. "\n")
    end)
  end
end

function v10.IsFileEnabled()
  local settingsEnableFileLogging = v6.SettingsEnableFileLogging

  if settingsEnableFileLogging == nil then
    settingsEnableFileLogging = f1("Toggle_Settings_EnableFileLogging")
  end

  if settingsEnableFileLogging == nil then
    return true
  end

  return settingsEnableFileLogging == true
end

function v10.Log(p5, ...)
  local v45 = select("#", ...) > 0 and string.format(tostring(p5), ...) or tostring(p5)

  if v45 == v10.LastMsg then
    return
  end

  v10.LastMsg = v45
  local toLocalTime2 = DateTime.now():ToLocalTime()

  local v46 = string.format(
    "[%02d:%02d:%02d.%03d] %s", toLocalTime2.Hour, toLocalTime2.Minute, toLocalTime2.Second,
    toLocalTime2.Millisecond, v45
  )

  print(v46)

  if v10.IsFileEnabled() then
    v10.AppendFile(v46)
  end
end

function v10.Debug(p6, ...)
  if not v10.IsFileEnabled() then
    return
  end

  local v47 = select("#", ...) > 0 and string.format(tostring(p6), ...) or tostring(p6)

  if v47 == v10.LastMsg then
    return
  end

  v10.LastMsg = v47
  local toLocalTime3 = DateTime.now():ToLocalTime()

  local v48 = string.format(
    "[%02d:%02d:%02d.%03d] %s", toLocalTime3.Hour, toLocalTime3.Minute, toLocalTime3.Second,
    toLocalTime3.Millisecond, v47
  )

  print(v48)
  v10.AppendFile(v48)
end

local debug = v10.Debug
v10.InitFile()

local function f2(p7, p8)
  if not p7 then
    return
  end

  p8 = p8 or ""

  if p7._LastContent == p8 then
    return
  end

  p7._LastContent = p8

  if p7.SetContent then
    p7:SetContent(p8)
  elseif p7.SetDesc then
    p7:SetDesc(p8)
  elseif p7.SetValue then
    p7:SetValue(p8)
  end
end

function v17.Send(p9, p10, p11, subTitle)
  pcall(function()
    if v1 and type(v1.Notify) == "function" then
      v1:Notify({
        Title = p9 or "Notification",
        Content = p10 or "",
        SubTitle = subTitle,
        Duration = p11 or 5,
      })
    end
  end)
end

function v17.Farm(p12, p13, p14)
  v17.Send(p12, p13, p14, "Farm")
end

function v17.Shop(p15, p16, p17)
  v17.Send(p15, p16, p17, "Shop")
end

v29.Gui = nil
v29.Frame = nil
v29.MainLabel = nil
v29.SubLabel = nil
v29.LastTag = "Farm"
v29.LastMain = "Idle: Ready for auction"
v29.LastSub = ""

function v29.NormalizeTag(p18)
  if not p18 then
    return "Farm"
  end

  local v49 = string.lower(string.gsub(p18, "[%[%]]", ""))

  if string.find(v49, "fish") then
    return "Fishing"
  elseif string.find(v49, "power") or string.find(v49, "plant") then
    return "Power Plant"
  elseif string.find(v49, "bobby") or string.find(v49, "terry") then
    return "Bobby & Terry"
  elseif string.find(v49, "story") then
    return "Story"
  elseif string.find(v49, "quest") then
    return "Quest"
  elseif string.find(v49, "pawn") then
    return "Pawn Shop"
  elseif string.find(v49, "player") or string.find(v49, "shelf") or string.find(v49, "plot")
    or string.find(v49, "shopper") then
    return "Player Shop"
  elseif string.find(v49, "auction") or string.find(v49, "bid") or string.find(v49, "loot")
    or string.find(v49, "pickup") then
    return "Auction"
  elseif string.find(v49, "service") or string.find(v49, "wash") or string.find(v49, "repair")
    or string.find(v49, "grade") or string.find(v49, "safe") then
    return "Services"
  elseif string.find(v49, "reward") or string.find(v49, "badge")
    or string.find(v49, "achievement") then
    return "Rewards"
  elseif string.find(v49, "setting") then
    return "Settings"
  else
    return "Farm"
  end
end

function v29.GetDefaultSub()
  local getInventoryCount = v11 and v11.GetInventoryCount and v11.GetInventoryCount() or 0
  local getInventoryMax = v11 and v11.GetInventoryMax and v11.GetInventoryMax() or 0
  local getVehicleItemCount = v11 and v11.GetVehicleItemCount and v11.GetVehicleItemCount() or 0

  local getVehicleCargoWeight = v11 and v11.GetVehicleCargoWeight
      and v11.GetVehicleCargoWeight()
    or 0

  local getVehicleCargoWeightLimit = v11 and v11.GetVehicleCargoWeightLimit
      and v11.GetVehicleCargoWeightLimit()
    or 0

  return string.format(
    "Inv: %d/%d | Veh: %d (%.0f/%.0f kg)", getInventoryCount, getInventoryMax,
    getVehicleItemCount, getVehicleCargoWeight, getVehicleCargoWeightLimit
  )
end

function v29.Init()
  pcall(function()
    local playerGui

    if type(gethui) == "function" then
      playerGui = gethui()
    elseif runService:IsStudio() then
      playerGui = localPlayer:WaitForChild("PlayerGui")
    else
      local coreGui = game:GetService("CoreGui")

      playerGui = pcall(function() return coreGui.Name end) and coreGui
        or localPlayer:WaitForChild("PlayerGui")
    end

    if not playerGui then
      return
    end

    local storageHuntersHUD = playerGui:FindFirstChild("StorageHuntersHUD")

    if storageHuntersHUD then
      storageHuntersHUD:Destroy()
    end

    local storageHuntersHUD2 = Instance.new("ScreenGui")
    storageHuntersHUD2.Name = "StorageHuntersHUD"
    storageHuntersHUD2.ResetOnSpawn = false
    storageHuntersHUD2.IgnoreGuiInset = true
    storageHuntersHUD2.DisplayOrder = 1000

    local statusFrame = Instance.new("Frame")
    statusFrame.Name = "StatusFrame"
    statusFrame.AnchorPoint = Vector2.new(0.5, 0)
    statusFrame.Position = UDim2.new(0.5, 0, 0.1, 0)
    statusFrame.Size = UDim2.new(0.85, 0, 0, 56)
    statusFrame.BackgroundColor3 = Color3.fromRGB(16, 20, 26)
    statusFrame.BackgroundTransparency = 0.2
    statusFrame.BorderSizePixel = 0
    statusFrame.ClipsDescendants = true
    statusFrame.Parent = storageHuntersHUD2

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = statusFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(50, 70, 95)
    uiStroke.Thickness = 1.2
    uiStroke.Transparency = 0.25
    uiStroke.Parent = statusFrame

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 14)
    uiPadding.PaddingRight = UDim.new(0, 14)
    uiPadding.PaddingTop = UDim.new(0, 6)
    uiPadding.PaddingBottom = UDim.new(0, 6)
    uiPadding.Parent = statusFrame

    local uiSizeConstraint = Instance.new("UISizeConstraint")
    uiSizeConstraint.MinSize = Vector2.new(340, 54)
    uiSizeConstraint.MaxSize = Vector2.new(580, 60)
    uiSizeConstraint.Parent = statusFrame

    local mainStatus = Instance.new("TextLabel")
    mainStatus.Name = "MainStatus"
    mainStatus.BackgroundTransparency = 1
    mainStatus.Size = UDim2.new(1, 0, 0, 24)
    mainStatus.Position = UDim2.new(0, 0, 0, 0)
    mainStatus.Font = Enum.Font.GothamBold
    mainStatus.TextSize = 16
    mainStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainStatus.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    mainStatus.TextStrokeTransparency = 0.2
    mainStatus.TextXAlignment = Enum.TextXAlignment.Center
    mainStatus.TextYAlignment = Enum.TextYAlignment.Center
    mainStatus.TextTruncate = Enum.TextTruncate.AtEnd
    mainStatus.RichText = true

    mainStatus.Text = string.format(
      "<font color=\"#81D4FA\">[%s]</font> <font color=\"#FFFFFF\">%s</font>", v29.LastTag,
      v29.LastMain
    )

    mainStatus.Parent = statusFrame

    local subStatus = Instance.new("TextLabel")
    subStatus.Name = "SubStatus"
    subStatus.BackgroundTransparency = 1
    subStatus.Size = UDim2.new(1, 0, 0, 18)
    subStatus.Position = UDim2.new(0, 0, 0, 24)
    subStatus.Font = Enum.Font.Gotham
    subStatus.TextSize = 13
    subStatus.TextColor3 = Color3.fromRGB(200, 215, 225)
    subStatus.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    subStatus.TextStrokeTransparency = 0.3
    subStatus.TextXAlignment = Enum.TextXAlignment.Center
    subStatus.TextYAlignment = Enum.TextYAlignment.Center
    subStatus.TextTruncate = Enum.TextTruncate.AtEnd
    subStatus.RichText = true
    subStatus.Text = v29.GetDefaultSub()
    subStatus.Parent = statusFrame

    storageHuntersHUD2.Parent = playerGui

    v29.Gui = storageHuntersHUD2
    v29.Frame = statusFrame
    v29.MainLabel = mainStatus
    v29.SubLabel = subStatus
  end)
end

function v29.SetStatus(p19, lastMain, p20)
  local v50 = v29.NormalizeTag(p19)
  lastMain = lastMain or v29.LastMain or ""
  local questsAutoStory = v6.QuestsAutoStory or f1 and f1("Toggle_Quests_AutoStoryQuests")

  if v50 == "Quest" then
    local questsSelectedBranch = v6.QuestsSelectedBranch
      or f1 and f1("Dropdown_Quests_SelectedBranch") or "Story Progression"

    if questsSelectedBranch == "Story Progression" then
      v50 = "Story"
    elseif questsSelectedBranch == "Bobby & Terry" then
      v50 = "Bobby & Terry"
    elseif questsSelectedBranch == "Power Plant" then
      v50 = "Power Plant"
    elseif questsSelectedBranch == "Fishing" then
      v50 = "Fishing"
    else
      v50 = questsSelectedBranch
    end
  end

  local v51 = p20

  if (questsAutoStory or v50 == "Story" or v50 == "Fishing" or v50 == "Power Plant"
      or v50 == "Bobby & Terry" or v50 == "Quest")
    and (not v51 or v51 == "") then
    local getCurrentTaskSummary = v27.GetCurrentTaskSummary and v27.GetCurrentTaskSummary()

    if getCurrentTaskSummary and getCurrentTaskSummary ~= "" then
      v51 = getCurrentTaskSummary
    end
  end

  if v51 == nil or v51 == "" then
    v51 = v29.GetDefaultSub()
  end

  v29.LastTag = v50
  v29.LastMain = lastMain
  v29.LastSub = v51

  local v52 = string.format(
    "<font color=\"#81D4FA\">[%s]</font> <font color=\"#FFFFFF\">%s</font>", v50, lastMain
  )

  if v29.MainLabel and v29.MainLabel.Text ~= v52 then
    v29.MainLabel.Text = v52
  end

  local v53 = tostring(v51)

  if v29.SubLabel and v29.SubLabel.Text ~= v53 then
    v29.SubLabel.Text = v53
  end
end

function v29.SetSub(p21)
  local questsAutoStory2 = v6.QuestsAutoStory or f1 and f1("Toggle_Quests_AutoStoryQuests")
  local v54 = p21

  if questsAutoStory2 then
    if not v54 or v54 == "" then
      local getCurrentTaskSummary2 = v27.GetCurrentTaskSummary and v27.GetCurrentTaskSummary()

      if getCurrentTaskSummary2 and getCurrentTaskSummary2 ~= "" then
        v54 = getCurrentTaskSummary2
      end
    end
  end

  if v54 == nil or v54 == "" then
    v54 = v29.GetDefaultSub()
  end

  local v55 = tostring(v54)
  v29.LastSub = v55

  if v29.SubLabel and v29.SubLabel.Text ~= v55 then
    v29.SubLabel.Text = v55
  end
end

function v29.SetVisible(p22)
  if v29.Gui then
    v29.Gui.Enabled = p22 ~= false
  end
end

function v29.Destroy()
  if v29.Gui then
    v29.Gui:Destroy()
    v29.Gui = nil
    v29.Frame = nil
    v29.MainLabel = nil
    v29.SubLabel = nil
  end
end

function v14.Number(p23)
  return tostring(math.floor(p23 or 0)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub(
    "^,", ""
  )
end

function v14.ParseMoney(p24)
  if typeof(p24) == "number" then
    return p24
  end

  if typeof(p24) ~= "string" then
    return 0
  end

  local v56 = string.gsub(p24, "[,%s%$]", "")
  local v57, v58 = string.match(v56, "^([%d%.]+)%s*([kKmMbBtT]?)$")

  if not v57 then
    v57 = string.match(v56, "[%d%.]+")
  end

  local v59 = tonumber(v57) or 0

  if v58 then
    local v60 = string.lower(v58)

    if v60 == "k" then
      v59 = v59 * 1000
    elseif v60 == "m" then
      v59 = v59 * 1000000
    elseif v60 == "b" then
      v59 = v59 * 1000000000
    elseif v60 == "t" then
      v59 = v59 * 1000000000000
    end
  end

  return math.floor(v59 + 0.5)
end

function v14.Money(p25)
  return "$" .. v14.Number(p25)
end

function v14.Percent(p26)
  return tostring(math.floor(p26 or 0)) .. "%"
end

function v18.IsSelected(p27, p28)
  if type(p27) ~= "table" then
    return false
  end

  if p27[p28] == true then
    return true
  end

  for key, value2 in pairs(p27) do
    if value2 == p28 then
      return true
    end
  end

  return false
end

function v13.GetRemote(p29, p30)
  local v61 = p29 .. "/" .. p30

  if v7[v61] then
    return v7[v61]
  end

  local events = replicatedStorage:FindFirstChild("Events")
    or replicatedStorage:WaitForChild("Events", 2)

  if not events then
    return nil
  end

  local findFirstChild = events:FindFirstChild(p29) or events:WaitForChild(p29, 0.3)

  if not findFirstChild then
    return nil
  end

  local findFirstChild2 = findFirstChild:FindFirstChild(p30)
    or findFirstChild:WaitForChild(p30, 0.2)

  if findFirstChild2 then
    v7[v61] = findFirstChild2
  end

  return findFirstChild2
end

function v13.InvokeServer(p31, p32, ...)
  local v62 = v13.GetRemote(p31, p32)

  if not v62 or not v62:IsA("RemoteFunction") then
    return false, "RemoteNotFound"
  end

  return pcall(v62.InvokeServer, v62, ...)
end

function v13.FireServer(p33, p34, ...)
  local v63 = v13.GetRemote(p33, p34)

  if not v63 or not v63:IsA("RemoteEvent") then
    return false
  end

  v63:FireServer(...)
  return true
end

v15.CurrentTween = nil
v15.DefaultSpeed = 65

function v15.Stop()
  if v15.CurrentTween then
    pcall(function() v15.CurrentTween:Cancel() end)
    v15.CurrentTween = nil
  end

  local character = localPlayer.Character
  local humanoid = character and character:FindFirstChildOfClass("Humanoid")

  if humanoid then
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
  end

  local v64 = v16.GetPlayerVehicle()

  if v64 then
    for index2, value3 in ipairs(v64:GetDescendants()) do
      if (value3:IsA("Seat") or value3:IsA("VehicleSeat")) and value3.Disabled then
        value3.Disabled = false
      end
    end
  end
end

function v15.TweenTo(p35, p36)
  local character2 = localPlayer.Character
  local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart or not humanoid2 then
    return false
  end

  local v65 = v16.GetPlayerVehicle()
  local v66 = {}

  if v65 then
    for index3, value4 in ipairs(v65:GetDescendants()) do
      if value4:IsA("Seat") or value4:IsA("VehicleSeat") then
        if not value4.Disabled then
          value4.Disabled = true
          table.insert(v66, value4)
        end
      end
    end
  end

  humanoid2:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

  if humanoid2.Sit or humanoid2.SeatPart then
    humanoid2.Sit = false
    humanoid2.Jump = true
    humanoid2:ChangeState(Enum.HumanoidStateType.Running)

    task.wait(0.05)
  end

  local cframe

  if typeof(p35) == "Vector3" then
    cframe = CFrame.new(p35)
  elseif typeof(p35) == "CFrame" then
    cframe = p35
  else
    humanoid2:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    return false
  end

  local position = humanoidRootPart.Position
  local position2 = cframe.Position
  local magnitude = (position2 - position).Magnitude

  if magnitude <= 1.5 then
    humanoid2:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    return true
  end

  v15.Stop()
  local settingsUseTweenSafeMode = v6.SettingsUseTweenSafeMode

  if settingsUseTweenSafeMode == nil then
    settingsUseTweenSafeMode = f1("Toggle_Settings_UseTweenSafeMode")
  end

  if not settingsUseTweenSafeMode then
    humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
    humanoidRootPart.AssemblyAngularVelocity = Vector3.zero

    if character2.PrimaryPart then
      character2:PivotTo(cframe)
    else
      humanoidRootPart.CFrame = cframe
    end

    task.wait(0.05)

    humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
    humanoidRootPart.AssemblyAngularVelocity = Vector3.zero

    for index4, value5 in ipairs(v66) do
      if value5 and value5.Parent then
        value5.Disabled = false
      end
    end

    humanoid2:SetStateEnabled(Enum.HumanoidStateType.Seated, true)

    if magnitude > 15 then
      task.wait(0.25)
    end

    return true
  end

  local v67 = p36 or 65
  local v68 = math.clamp(magnitude / v67, 0.05, 30)

  local create = tweenService:Create(
    humanoidRootPart, TweenInfo.new(v68, Enum.EasingStyle.Linear), { CFrame = cframe }
  )

  v15.CurrentTween = create
  local v69 = false

  local connect = runService.Stepped:Connect(function()
    if not v69 and character2 then
      for index5, value6 in ipairs(character2:GetDescendants()) do
        if value6:IsA("BasePart") and value6.CanCollide then
          value6.CanCollide = false
        end
      end

      if humanoid2 and (humanoid2.Sit or humanoid2.SeatPart) then
        humanoid2.Sit = false
        humanoid2:ChangeState(Enum.HumanoidStateType.Running)
      end
    end

    if not v69 and humanoidRootPart then
      humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
    end
  end)

  create:Play()
  local v70 = os.clock()
  local v71 = v68 + 1.5

  while not v69 and os.clock() - v70 < v71 do
    task.wait(0.08)

    if (humanoidRootPart.Position - position2).Magnitude <= 2 then
      break
    end
  end

  v69 = true
  connect:Disconnect()
  v15.CurrentTween = nil

  for index6, value7 in ipairs(v66) do
    if value7 and value7.Parent then
      value7.Disabled = false
    end
  end

  if humanoid2 then
    humanoid2:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
  end

  return true
end

function v15.StartGPS(p37, p38)
  local startGPSNavigation = localPlayer:FindFirstChild("StartGPSNavigation")

  if startGPSNavigation and startGPSNavigation:IsA("BindableEvent") then
    startGPSNavigation:Fire(p37, p38)
    debug("[GPS] Started route navigation to %s", tostring(p37))
  end
end

function v15.StopGPS()
  local stopGPSNavigation = localPlayer:FindFirstChild("StopGPSNavigation")

  if stopGPSNavigation and stopGPSNavigation:IsA("BindableEvent") then
    stopGPSNavigation:Fire()
    debug("[GPS] Route navigation stopped")
  end
end

v16.LastSpawnTime = 0

function v16.GetPlayerVehicle()
  local userId = localPlayer.UserId

  for index7, value8 in ipairs(workspace:GetChildren()) do
    if value8:IsA("Model") and value8:GetAttribute("OwnerUserId") == userId then
      return value8
    end
  end

  return nil
end

function v16.GetDistanceToPlayer()
  local character3 = localPlayer.Character
  local humanoidRootPart2 = character3 and character3:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart2 then
    return math.huge
  end

  local v72 = v16.GetPlayerVehicle()

  if not v72 then
    return math.huge
  end

  local primaryPart = v72.PrimaryPart or v72:FindFirstChildWhichIsA("BasePart")

  if not primaryPart then
    return math.huge
  end

  return (primaryPart.Position - humanoidRootPart2.Position).Magnitude
end

function v16.IsSeated()
  local character4 = localPlayer.Character
  local humanoid3 = character4 and character4:FindFirstChildOfClass("Humanoid")
  return humanoid3 ~= nil and (humanoid3.Sit == true or humanoid3.SeatPart ~= nil)
end

function v16.Exit()
  local character5 = localPlayer.Character
  local humanoid4 = character5 and character5:FindFirstChildOfClass("Humanoid")

  if humanoid4 and (humanoid4.Sit or humanoid4.SeatPart) then
    humanoid4.Sit = false
    humanoid4.Jump = true
    task.wait(0.15)
  end
end

function v16.Enter()
  local v73 = v16.GetPlayerVehicle()

  if not v73 then
    return false
  end

  local findFirstChildWhichIsA = v73:FindFirstChildWhichIsA("VehicleSeat", true)
  local character6 = localPlayer.Character
  local humanoid5 = character6 and character6:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart3 = character6 and character6:FindFirstChild("HumanoidRootPart")

  if findFirstChildWhichIsA and humanoid5 and humanoidRootPart3 then
    humanoid5:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    humanoidRootPart3.CFrame = findFirstChildWhichIsA.CFrame + Vector3.new(0, 1, 0)
    task.wait(0.08)
    findFirstChildWhichIsA:Sit(humanoid5)
    return true
  end

  return false
end

function v16.DriveTo(p39)
  local v74 = v16.GetPlayerVehicle()

  if not v74 then
    v16.Spawn(false)
    task.wait(0.5)
    v74 = v16.GetPlayerVehicle()
  end

  if not v74 then
    return false
  end

  local findFirstChildWhichIsA2 = v74:FindFirstChildWhichIsA("VehicleSeat", true)

  if not findFirstChildWhichIsA2 then
    return false
  end

  if not v16.IsSeated() then
    v16.Enter()
    task.wait(0.2)
  end

  local primaryPart2 = v74.PrimaryPart or findFirstChildWhichIsA2
  local magnitude2 = (p39 - primaryPart2.Position).Magnitude
  local v75 = math.max(0.2, magnitude2 / 65)
  local tweenService2 = game:GetService("TweenService")

  local create2 = tweenService2:Create(
    primaryPart2, TweenInfo.new(v75, Enum.EasingStyle.Linear), { CFrame = CFrame.new(p39) }
  )

  create2:Play()
  create2.Completed:Wait()

  task.wait(0.15)
  return true
end

function v16.TeleportTo(p40)
  return v16.DriveTo(p40)
end

function v16.GetBestVehicleGuid()
  local v76, v77 = v13.InvokeServer("Vehicles", "GetOwnedVehicles")

  if v76 and type(v77) == "table" and type(v77.vehicles) == "table" then
    local equippedGuid = v77.equippedGuid or localPlayer:GetAttribute("EquippedVehicle")
    local v78 = 0
    local vehicleConfigs = v5.VehicleConfigs

    if not vehicleConfigs then
      pcall(function() v5.VehicleConfigs = require(replicatedStorage.Modules.Vehicles) end)
      vehicleConfigs = v5.VehicleConfigs
    end

    for key2, value9 in pairs(v77.vehicles) do
      local v79 = vehicleConfigs and vehicleConfigs[value9.Name]
      local maxWeightCapacity = v79 and v79.MaxWeightCapacity or 0

      if maxWeightCapacity > v78 then
        v78 = maxWeightCapacity
        equippedGuid = key2
      end
    end

    return equippedGuid
  end

  return localPlayer:GetAttribute("EquippedVehicle")
end

function v16.Spawn(p41)
  local v80 = os.clock()
  local v81 = v16.GetDistanceToPlayer()
  local v82 = (not v16.GetPlayerVehicle() or v81 > 45) and 1.2 or 2.5

  if v80 - v16.LastSpawnTime < v82 then
    return false
  end

  v16.LastSpawnTime = v80
  local v83 = v16.GetBestVehicleGuid()

  if typeof(v83) == "string" and v83 ~= "" then
    v13.FireServer("Vehicles", "RequestSpawn", v83)

    if p41 ~= false then
      task.spawn(function()
        for i = 1, 15 do
          task.wait(0.1)

          if v16.IsSeated() then
            v16.Exit()
            break
          end
        end
      end)
    end

    return true
  end

  return false
end

function v16.EnsureNearPlayer(p42)
  if v15.CurrentTween ~= nil then
    return
  end

  if v20.IsAuctionActive() then
    return
  end

  local character7 = localPlayer.Character

  if not (character7 and character7:FindFirstChild("HumanoidRootPart")) then
    return
  end

  if v16.GetDistanceToPlayer() > (p42 or 40) then
    v16.Spawn(true)
    task.wait(0.35)
  end
end

function v16.UnloadAtPlot()
  while v20.IsAuctionActive() or v6.IsPickupActive do
    f2(v9.PlayerShopStatus, "Paused: Auction in progress...")
    debug("[Vehicle/Unload] In active auction or loot pickup, waiting before unloading...")
    task.wait(2)
  end

  local v84 = v11.GetPlotUnpackPosition()

  if not v84 then
    debug("[Vehicle/Unload] Plot unpack position not found")
    return false, "NoPlotPos"
  end

  f2(v9.PlayerShopStatus, "Unloading: Traveling to Plot parking zone...")
  v15.TweenTo(v84 + Vector3.new(0, 1.5, 0), 65)
  task.wait(0.3)

  if v6.FarmPlayerShopAutoStockShelves or f1("Toggle_Farm_PlayerShopAutoStockShelves") then
    v22.StockShelves()
    task.wait(0.3)
  end

  local v85 = math.max(0, v11.GetInventoryMax() - v11.GetInventoryCount())

  if v85 <= 0 then
    if not v7.LastInvFullWarn or os.clock() - v7.LastInvFullWarn > 15 then
      v7.LastInvFullWarn = os.clock()

      debug(
        "[Vehicle/Unload] Personal inventory is full (%d/%d) and shelves are full",
        v11.GetInventoryCount(), v11.GetInventoryMax()
      )
    end

    f2(v9.PlayerShopStatus, "Paused: Inventory & Shelves full at Plot.")
    return false, "InventoryFull"
  end

  v7.LastInvFullWarn = nil
  v16.EnsureNearPlayer(30)
  task.wait(0.4)
  v16.Enter()
  task.wait(0.3)
  local equippedVehicle = localPlayer:GetAttribute("EquippedVehicle")
  local v86, v87 = v13.InvokeServer("Vehicles", "GetVehicleItems", equippedVehicle)
  local v88 = {}

  if v86 and type(v87) == "table" then
    for key3, value10 in pairs(v87) do
      local v89 = 0

      if type(value10) == "table" then
        if v5.Mutators and v5.Mutators.GetEntryWeight then
          local v90, v91 = pcall(function() return v5.Mutators:GetEntryWeight(value10) end)

          if v90 and type(v91) == "number" then
            v89 = v91
          end
        end

        if v89 == 0 then
          v89 = tonumber(value10.Weight) or tonumber(value10.weight) or 0
        end
      end

      table.insert(v88, { guid = key3, weight = v89 })
    end
  end

  if #v88 == 0 then
    v6.IsVehicleFull = false
    v7.IgnoredHeavyPrompts = nil
    v16.Exit()
    debug("[Vehicle/Unload] Vehicle is already empty")
    return true, "AlreadyEmpty"
  end

  table.sort(v88, function(p43, p44) return p43.weight > p44.weight end)
  local v92 = {}

  for j = 1, math.min(#v88, v85) do
    table.insert(v92, v88[j].guid)
  end

  v13.FireServer("Vehicles", "TransferVehicleItemsToInventory", v92)
  task.wait(0.4)

  pcall(function()
    local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
    local uiControllerGui = playerGui2 and playerGui2:FindFirstChild("UIControllerGui")

    local unloadVehiclePanel = uiControllerGui
      and uiControllerGui:FindFirstChild("UnloadVehiclePanel")

    if unloadVehiclePanel and unloadVehiclePanel.Visible then
      local findFirstChild3 = unloadVehiclePanel:FindFirstChild("UnloadSelectedBtn", true)

      if findFirstChild3 and findFirstChild3.Visible and firesignal then
        firesignal(findFirstChild3.MouseButton1Click or findFirstChild3.Activated)
      end

      require(replicatedStorage.Modules.UIController):Close("UnloadVehicle")
    end
  end)

  v16.Exit()
  local v93, v94 = v13.InvokeServer("Vehicles", "GetVehicleItemCount", equippedVehicle)
  local v95 = v94 or 0

  if v95 < #v88 then
    debug(
      "[Vehicle/Unload] Transferred %d items to inventory. Vehicle has %d remaining.", #v92, v95
    )

    if v95 == 0 then
      v6.IsVehicleFull = false
      v7.IgnoredHeavyPrompts = nil
    end

    return true, "Success"
  end

  debug(
    "[Vehicle/Unload] Transfer was not processed by server. Vehicle still has %d items.", #v88
  )

  return false, "Rejected"
end

function v16.EquipBestVehicle()
  local v96, v97 = v13.InvokeServer("Vehicles", "GetOwnedVehicles")

  if not v96 or type(v97) ~= "table" or type(v97.vehicles) ~= "table" then
    return false
  end

  local vehicles = v5.Vehicles or v5.VehicleConfigs

  if not vehicles and replicatedStorage:FindFirstChild("Modules") then
    pcall(function() v5.Vehicles = require(replicatedStorage.Modules.Vehicles) end)
    vehicles = v5.Vehicles
  end

  if not vehicles then
    return false
  end

  local v98 = nil
  local v99 = 0
  local equippedGuid2 = v97.equippedGuid or localPlayer:GetAttribute("EquippedVehicle")

  for key4, value11 in pairs(v97.vehicles) do
    local v100 = vehicles[value11.Name]
    local maxWeightCapacity2 = v100 and v100.MaxWeightCapacity or 0

    if maxWeightCapacity2 > v99 then
      v99 = maxWeightCapacity2
      v98 = key4
    end
  end

  if v98 and v98 ~= equippedGuid2 then
    if v16.IsSeated() then
      v16.Exit()
      task.wait(0.2)
    end

    v13.FireServer("Vehicles", "RequestSpawn", v98)
    debug("[Vehicle] Equipped best vehicle: %s (Cap: %d)", tostring(v98), v99)
    return true
  end

  return false
end

function v16.AutoBuyAndEquipBestVehicle()
  if localPlayer:GetAttribute("InAuction") == true then
    return
  end

  local getCash = v11.GetCash and v11.GetCash() or localPlayer:GetAttribute("Cash") or 0

  local getNetWorth = v11.GetNetWorth and v11.GetNetWorth()
    or localPlayer:GetAttribute("NetWorth") or 0

  local v101, v102 = v13.InvokeServer("Vehicles", "GetOwnedVehicles")

  if not v101 or type(v102) ~= "table" or type(v102.vehicles) ~= "table" then
    return
  end

  local vehicles2 = v5.Vehicles or v5.VehicleConfigs

  if not vehicles2 and replicatedStorage:FindFirstChild("Modules") then
    pcall(function() v5.Vehicles = require(replicatedStorage.Modules.Vehicles) end)
    vehicles2 = v5.Vehicles
  end

  if not vehicles2 then
    return
  end

  local v103 = {}
  local v104 = 0

  for key5, value12 in pairs(v102.vehicles) do
    if value12 and value12.Name then
      v103[value12.Name] = key5
      local v105 = vehicles2[value12.Name]
      local maxWeightCapacity3 = v105 and v105.MaxWeightCapacity or 0

      if maxWeightCapacity3 > v104 then
        v104 = maxWeightCapacity3
      end
    end
  end

  local v106 = nil
  local v107 = v104
  local v108 = 0

  for key6, value13 in pairs(vehicles2) do
    if type(value13) == "table" and not v103[key6] and value13.CashPrice
      and not value13.ShopHidden and not value13.AdminOnly and not value13.RewardSource
      and not value13.RobuxPrice then
      local v109 = tonumber(value13.CashPrice) or 0
      local v110 = tonumber(value13.MinNetWorth) or 0
      local v111 = tonumber(value13.MaxWeightCapacity) or 0

      if v111 > v107 and getCash >= v109 and getNetWorth >= v110 then
        v106 = key6
        v107 = v111
        v108 = v109
      end
    end
  end

  if v106 then
    local v112, v113 = v13.InvokeServer("VehicleShop", "BuyFromCatalog", v106)

    if v112 and v113 then
      debug("[Vehicle] Purchased superior vehicle: %s (Cap: %d, Price: %d)", v106, v107, v108)
      v17.Shop("Purchased Vehicle", string.format("Acquired %s with %d capacity.", v106, v107))
      task.wait(0.5)
    end
  end

  v16.EquipBestVehicle()
end

function v11.GetCash()
  local leaderstats = localPlayer:FindFirstChild("leaderstats")
  local cash = leaderstats and leaderstats:FindFirstChild("Cash")

  if cash then
    local rawValue = cash:GetAttribute("RawValue")

    if typeof(rawValue) == "number" and rawValue > 0 then
      return rawValue
    end

    if cash.Value then
      local v114 = v14.ParseMoney(cash.Value)

      if v114 > 0 then
        return v114
      end
    end
  end

  local cash2 = localPlayer:GetAttribute("Cash")

  if typeof(cash2) == "number" then
    return cash2
  end

  return 0
end

function v11.GetNetWorth()
  local leaderstats2 = localPlayer:FindFirstChild("leaderstats")
  local netWorth = leaderstats2 and leaderstats2:FindFirstChild("Net Worth")

  if netWorth then
    local rawValue2 = netWorth:GetAttribute("RawValue")

    if typeof(rawValue2) == "number" and rawValue2 > 0 then
      return rawValue2
    end

    if netWorth.Value then
      local v115 = v14.ParseMoney(netWorth.Value)

      if v115 > 0 then
        return v115
      end
    end
  end

  local netWorth2 = localPlayer:GetAttribute("NetWorth")

  if typeof(netWorth2) == "number" then
    return netWorth2
  end

  return 0
end

function v11.GetDiamonds()
  local leaderstats3 = localPlayer:FindFirstChild("leaderstats")
  local diamonds = leaderstats3 and leaderstats3:FindFirstChild("Diamonds")

  if diamonds then
    local rawValue3 = diamonds:GetAttribute("RawValue")

    if typeof(rawValue3) == "number" and rawValue3 > 0 then
      return rawValue3
    end

    if diamonds.Value then
      local v116 = v14.ParseMoney(diamonds.Value)

      if v116 > 0 then
        return v116
      end
    end
  end

  local diamonds2 = localPlayer:GetAttribute("Diamonds")

  if typeof(diamonds2) == "number" then
    return diamonds2
  end

  local playerGui3 = localPlayer:FindFirstChild("PlayerGui")
  local currencyHud = playerGui3 and playerGui3:FindFirstChild("CurrencyHud")
  local findFirstChild4 = currencyHud and currencyHud:FindFirstChild("DiamondBar", true)

  if findFirstChild4 then
    local findFirstChildWhichIsA3 = findFirstChild4:FindFirstChildWhichIsA("TextLabel", true)

    if findFirstChildWhichIsA3 and findFirstChildWhichIsA3.Text ~= "" then
      return v14.ParseMoney(findFirstChildWhichIsA3.Text)
    end
  end

  return 0
end

function v11.GetCandy()
  local candy = localPlayer:GetAttribute("Candy") or localPlayer:GetAttribute("HalloweenCandy")

  if typeof(candy) == "number" then
    return candy
  end

  local leaderstats4 = localPlayer:FindFirstChild("leaderstats")

  local candy2 = leaderstats4
    and (leaderstats4:FindFirstChild("Candy") or leaderstats4:FindFirstChild("Halloween Candy")
      or leaderstats4:FindFirstChild("HalloweenCandy"))

  if candy2 and candy2.Value then
    return v14.ParseMoney(candy2.Value)
  end

  local playerGui4 = localPlayer:FindFirstChild("PlayerGui")
  local currencyHud2 = playerGui4 and playerGui4:FindFirstChild("CurrencyHud")

  local findFirstChild5 = currencyHud2
    and (currencyHud2:FindFirstChild("CandyBar", true)
      or currencyHud2:FindFirstChild("HalloweenBar", true))

  if findFirstChild5 then
    local findFirstChildWhichIsA4 = findFirstChild5:FindFirstChildWhichIsA("TextLabel", true)

    if findFirstChildWhichIsA4 and findFirstChildWhichIsA4.Text ~= "" then
      return v14.ParseMoney(findFirstChildWhichIsA4.Text)
    end
  end

  return 0
end

function v11.GetLuck()
  local luck = localPlayer:GetAttribute("Luck") or localPlayer:GetAttribute("TotalLuck")
    or localPlayer:GetAttribute("AuctionLuck")

  if typeof(luck) == "number" then
    return string.format("+%.1f%%", luck)
  elseif typeof(luck) == "string" then
    return luck
  end

  local playerGui5 = localPlayer:FindFirstChild("PlayerGui")
  local currencyHud3 = playerGui5 and playerGui5:FindFirstChild("CurrencyHud")
  local findFirstChild6 = currencyHud3 and currencyHud3:FindFirstChild("LuckBar", true)

  if findFirstChild6 then
    for index8, value14 in ipairs(findFirstChild6:GetDescendants()) do
      if value14:IsA("TextLabel") and value14.Text ~= ""
        and (string.find(value14.Text, "%%") or string.find(value14.Text, "%d")) then
        return value14.Text
      end
    end
  end

  return "+0%"
end

function v11.GetInventoryCount()
  return localPlayer:GetAttribute("InventoryCount") or 0
end

function v11.GetInventoryMax()
  local inventoryCap = localPlayer:GetAttribute("InventoryCap")

  if typeof(inventoryCap) == "number" and inventoryCap > 0 then
    return inventoryCap
  end

  return localPlayer:GetAttribute("InventoryBoost") == true and 45 or 30
end

function v11.IsInAuction()
  return v6.IsInAuction == true
end

function v11.GetInventoryItems(p45)
  local v117 = os.clock()

  if not p45 and v7.PlayerInventoryItems and v117 - (v7.LastInventoryFetchTime or 0) < 3 then
    return true, v7.PlayerInventoryItems
  end

  local v118, v119 = v13.InvokeServer("Inventory", "GetPlayerInventory")

  if v118 and type(v119) == "table" then
    v7.PlayerInventoryItems = v119
    v7.LastInventoryFetchTime = v117
    return true, v119
  end

  return false, v7.PlayerInventoryItems or {}
end

function v11.InvalidateInventoryCache()
  v7.LastInventoryFetchTime = 0
  v7.PlayerInventoryItems = nil
end

function v11.GetVehicleItems(p46)
  local v120 = os.clock()

  if not p46 and v7.PlayerVehicleItems and v120 - (v7.LastVehicleItemsFetchTime or 0) < 3 then
    return true, v7.PlayerVehicleItems
  end

  local equippedVehicle2 = localPlayer:GetAttribute("EquippedVehicle")

  if not equippedVehicle2 or equippedVehicle2 == "" then
    return false, {}
  end

  local v121, v122 = v13.InvokeServer("Vehicles", "GetVehicleItems", equippedVehicle2)

  if v121 and type(v122) == "table" then
    v7.PlayerVehicleItems = v122
    v7.LastVehicleItemsFetchTime = v120
    return true, v122
  end

  return false, v7.PlayerVehicleItems or {}
end

function v11.InvalidateVehicleItemsCache()
  v7.LastVehicleItemsFetchTime = 0
  v7.PlayerVehicleItems = nil
end

function v11.IsInventoryFull(p47)
  local v123 = v11.GetInventoryCount()
  return v11.GetInventoryMax() - v123 <= (p47 or 2)
end

function v11.GetVehicleItemCount()
  local equippedVehicle3 = localPlayer:GetAttribute("EquippedVehicle")

  if not equippedVehicle3 or equippedVehicle3 == "" then
    return 0
  end

  local v124, v125 = v13.InvokeServer("Vehicles", "GetVehicleItemCount", equippedVehicle3)

  if v124 and type(v125) == "number" then
    return v125
  end

  return 0
end

function v11.GetVehicleCargoWeight()
  local v126 = v16.GetPlayerVehicle()

  if v126 then
    return tonumber(v126:GetAttribute("CargoWeight")) or 0
  end

  return 0
end

function v11.GetVehicleCargoWeightLimit()
  local v127 = v16.GetPlayerVehicle()

  if v127 then
    return tonumber(v127:GetAttribute("CargoWeightLimit")) or 100
  end

  return 100
end

function v11.IsVehicleNearCapacity(p48)
  local v128 = v11.GetVehicleCargoWeightLimit()

  if v128 <= 0 then
    return false
  end

  return v11.GetVehicleCargoWeight() / v128 > (p48 or 0.9)
end

function v11.GetPlayerPlot()
  local plots = workspace:FindFirstChild("_Plots") or workspace:FindFirstChild("Plots")

  if not plots then
    return nil
  end

  local userId2 = localPlayer.UserId
  local name = localPlayer.Name

  for index9, value15 in ipairs(plots:GetChildren()) do
    local ownerUserId = value15:GetAttribute("OwnerUserId")
    local ownerName = value15:GetAttribute("OwnerName")

    if ownerUserId and ownerUserId == userId2 or ownerName and ownerName == name then
      return value15
    end
  end

  return nil
end

function v11.GetStoreShelvesCount()
  local v129 = v11.GetPlayerPlot()
  local stock = v129 and v129:FindFirstChild("Stock")

  if not stock then
    return 0
  end

  local count = 0

  for index10, value16 in ipairs(stock:GetChildren()) do
    if value16:GetAttribute("IsStockDecor") ~= true
      and (value16:GetAttribute("IsStockItem") == true
        or value16:GetAttribute("Category") == "Stock") then
      count = count + 1
    end
  end

  return count
end

function v11.GetStoreShelvesCap()
  local v130 = os.clock()

  if v7.ShelvesCap and v130 - (v7.LastShelvesCapCheck or 0) < 15 then
    return v7.ShelvesCap
  end

  v7.LastShelvesCapCheck = v130

  local v131, v132 = pcall(function()
    return v13.InvokeServer("Plot", "ShelfAutoStock", "preview")
  end)

  if v131 and type(v132) == "table" and v132.Ok == true then
    local v133 = tonumber(v132.FreeSlots) or 0
    local v134 = v11.GetStoreShelvesCount()
    v7.ShelvesCap = math.max(1, v133 + v134)
    return v7.ShelvesCap
  end

  return v7.ShelvesCap or 12
end

function v11.GetPlotUnpackPosition()
  if v7.PlotUnpackPosition then
    return v7.PlotUnpackPosition
  end

  local v135 = v11.GetPlayerPlot()

  if not v135 and v22.EnsurePlotSelected then
    v22.EnsurePlotSelected()
    v135 = v11.GetPlayerPlot()
  end

  if v135 then
    local furniture = v135:FindFirstChild("Furniture")
    local parkingSpace = furniture and furniture:FindFirstChild("Parking Space")

    if parkingSpace then
      local pad = parkingSpace:FindFirstChild("Pad") or parkingSpace:FindFirstChild("Base")
        or parkingSpace.PrimaryPart or parkingSpace:FindFirstChildWhichIsA("BasePart")

      if pad then
        v7.PlotUnpackPosition = pad.Position
        return pad.Position
      end
    end

    local base = v135:FindFirstChild("Base")
    local basePart = base and base:FindFirstChildWhichIsA("BasePart")

    if basePart then
      v7.PlotUnpackPosition = basePart.Position + Vector3.new(0, 3, 0)
      return v7.PlotUnpackPosition
    end

    local originX = v135:GetAttribute("OriginX")
    local originY = v135:GetAttribute("OriginY")
    local originZ = v135:GetAttribute("OriginZ")

    if originX and originY and originZ then
      v7.PlotUnpackPosition = Vector3.new(originX, originY + 3, originZ)
      return v7.PlotUnpackPosition
    end
  end

  local v136, v137 = v13.InvokeServer("Plot", "RequestPlotData")

  if v136 and type(v137) == "table" and v137.OriginX then
    local vector = Vector3.new(v137.OriginX, (v137.OriginY or 0) + 3, v137.OriginZ)
    v7.PlotUnpackPosition = vector
    return vector
  end

  return nil
end

function v11.GetGarageConfig(p49)
  if not v5.Garages then
    return nil
  end

  local v138 = string.gsub(p49, "%s*%(.-%)", "")

  if type(v5.Garages[v138]) == "table" then
    return v5.Garages[v138]
  end

  if type(v5.Garages[p49]) == "table" then
    return v5.Garages[p49]
  end

  for key7, value17 in pairs(v5.Garages) do
    if type(value17) == "table" and value17.Name then
      if value17.Name == v138 or value17.Name == p49 or string.find(key7, v138, 1, true)
        or string.find(v138, value17.Name, 1, true) then
        return value17
      end
    end
  end

  return nil
end

function v11.IsEligibleForGarage(p50)
  local v139 = v11.GetGarageConfig(p50)

  if not v139 then
    if string.find(p50, "Scrap", 1, true) then
      return true
    end

    return false, "Garage config not found"
  end

  if v139.EventOnly then
    return false, "Event Only"
  end

  if v139.EntryCurrency and v139.EntryCurrency ~= "Cash" then
    return false, "Requires " .. tostring(v139.EntryCurrency)
  end

  local v140 = v11.GetNetWorth()

  if v139.MinNetWorth and v140 < v139.MinNetWorth then
    return false, string.format(
      "Need $%s Net Worth (have $%s)", v14.Number(v139.MinNetWorth), v14.Number(v140)
    )
  end

  local v141 = v11.GetCash()

  if v139.EntryCost and v139.EntryCost.Min and v141 < v139.EntryCost.Min then
    return false, string.format(
      "Need $%s Entry Cash (have $%s)", v14.Number(v139.EntryCost.Min), v14.Number(v141)
    )
  end

  return true
end

function v12.StaticConfigs()
  local v142 = os.clock()
  debug("[LoadData] Loading static game configs...")
  local waitForChild = replicatedStorage:WaitForChild("Modules", 10)

  if waitForChild then
    pcall(function()
      local garages = waitForChild:FindFirstChild("Garages")

      if garages then
        v5.Garages = require(garages)
      end

      local vehicles3 = waitForChild:FindFirstChild("Vehicles")

      if vehicles3 then
        local v143, v144 = pcall(require, vehicles3)

        if v143 and type(v144) == "table" then
          v5.Vehicles = v144
          v5.VehicleConfigs = v144
        end
      end

      local trailers = waitForChild:FindFirstChild("Trailers")

      if trailers then
        local v145, v146 = pcall(require, trailers)

        if v145 and type(v146) == "table" then
          v5.Trailers = v146
        end
      end

      local quests = waitForChild:FindFirstChild("Quests")

      if quests then
        local v147, v148 = pcall(require, quests)

        if v147 and type(v148) == "table" then
          v5.Quests = v148
        end
      end

      v5.LostFoundPositions = {
        ["Junk Yard"] = Vector3.new(-33.9, 1722.7, 65.9),
        ["Back Alley"] = Vector3.new(-609.9, 1722.3, -351.8),
        Farmyard = Vector3.new(-57.7, 1721.9, -1155.2),
        Shipyard = Vector3.new(-605.4, 1721.8, 641.8),
        ["Cargo Ship"] = Vector3.new(-772.1, 1723.2, 592.3),
        ["Cargo Train"] = Vector3.new(771.4, 1731.1, -1453.9),
        ["Lucky Beach"] = Vector3.new(-233.7, 1699.1, -1761.8),
        ["Power Plant"] = Vector3.new(-2672.9, 1723.3, -802.4),
        ["Business Bay"] = Vector3.new(2051.1, 1723.2, -3945.8),
        ["The Mines"] = Vector3.new(-3155.5, 1577.5, -1954.2),
        ["Military Base"] = Vector3.new(355.3, 1799.1, -5521.4),
      }

      local v149 = v13.GetRemote("GPS", "GetPOIs")
      local v150 = {}

      if v149 then
        local v151, v152 = pcall(function() return v149:InvokeServer() end)

        if v151 and v152 and v152.pois then
          local v153 = {}

          for index11, value18 in ipairs(v152.pois) do
            v153[value18.name] = value18.position

            if value18.category == "Area" and value18.position then
              v150[value18.name] = value18.position
            end
          end

          v7.POIMap = v153
          v7.AreaPOIs = v150
        end
      end

      local v154 = {}

      if v5.Garages then
        for key8, value19 in pairs(v5.Garages) do
          if type(value19) == "table" then
            local name2 = value19.Name or key8

            if not v154[name2] or (value19.MinNetWorth or 0) > v154[name2].minNW then
              v154[name2] = {
                name = name2,
                minNW = value19.MinNetWorth or 0,
                entryCost = value19.EntryCost and value19.EntryCost.Min or 0,
                eventOnly = value19.EventOnly == true,
              }
            end
          end
        end
      end

      local v155 = {}

      for key9, value20 in pairs(v154) do
        table.insert(v155, value20)
      end

      table.sort(v155, function(p51, p52)
        if p51.minNW ~= p52.minNW then
          return p51.minNW < p52.minNW
        end

        return p51.name < p52.name
      end)

      local v156 = {}

      for index12, value21 in ipairs(v155) do
        table.insert(v156, value21.name)
      end

      v5.GarageNames = v156
      v6.AuctionTargetGarages = table.clone(v156)

      debug(
        "[LoadData] Loaded %d garages directly from ReplicatedStorage.Modules.Garages", #v156
      )
    end)

    pcall(function()
      local items = waitForChild:FindFirstChild("Items")

      if items then
        v5.Items = require(items)
        v5.ItemByName = {}

        for key10, value22 in pairs(v5.Items) do
          if type(value22) == "table" and value22.Name then
            v5.ItemByName[value22.Name] = value22
            v5.ItemByName[string.lower(value22.Name)] = value22
          end
        end
      end
    end)

    pcall(function()
      local mutatorModule = waitForChild:FindFirstChild("MutatorModule")

      if mutatorModule then
        v5.Mutators = require(mutatorModule)
      end
    end)

    pcall(function()
      local rarities = waitForChild:FindFirstChild("Rarities")

      if rarities then
        local v157, v158 = pcall(require, rarities)

        if v157 and type(v158) == "table" then
          v5.Rarities = v158
          local v159 = {}

          for key11 in pairs(v158) do
            table.insert(v159, key11)
          end

          local v160 = {
            Junk = 1,
            Common = 2,
            Uncommon = 3,
            Rare = 4,
            Epic = 5,
            Legendary = 6,
            Mythical = 7,
            Lost = 8,
            Trophy = 9,
            Limited = 10,
          }

          table.sort(v159, function(p53, p54)
            local v161 = v160[p53] or 99
            local v162 = v160[p54] or 99

            if v161 ~= v162 then
              return v161 < v162
            end

            return p53 < p54
          end)

          v5.RarityNames = v159
        end
      end

      if not v5.RarityNames or #v5.RarityNames == 0 then
        v5.RarityNames = {
          "Junk", "Uncommon", "Rare", "Epic", "Legendary", "Mythical", "Lost", "Trophy",
          "Limited",
        }
      end
    end)

    pcall(function()
      local shopUpgradesConfig = waitForChild:FindFirstChild("ShopUpgradesConfig")

      if shopUpgradesConfig then
        local v163, v164 = pcall(require, shopUpgradesConfig)

        if v163 and type(v164) == "table" and type(v164.Upgrades) == "table" then
          v25.RawConfig = v164
          debug("[LoadData] Loaded ShopUpgradesConfig successfully.")
        end
      end
    end)

    pcall(function()
      v5.Minigames = {}
      local bankHeistConfig = waitForChild:FindFirstChild("BankHeistConfig")

      if bankHeistConfig then
        local v165, v166 = pcall(require, bankHeistConfig)

        if v165 and type(v166) == "table" then
          v5.Minigames.BankHeist = v166
        end
      end

      local trainConductorConfig = waitForChild:FindFirstChild("TrainConductorConfig")

      if trainConductorConfig then
        local v167, v168 = pcall(require, trainConductorConfig)

        if v167 and type(v168) == "table" then
          v5.Minigames.TrainConductor = v168
        end
      end

      local miningConfig = waitForChild:FindFirstChild("MiningConfig")

      if miningConfig then
        local v169, v170 = pcall(require, miningConfig)

        if v169 and type(v170) == "table" then
          v5.Minigames.Mining = v170
        end
      end
    end)

    debug("[LoadData] Static configs finished loading in %.3fs.", os.clock() - v142)
  end
end

function v12.GetPawnRate()
  local v171, v172 = v13.InvokeServer("Pawn", "GetPawnState")

  if v171 and type(v172) == "table" then
    return v172.rate or v172.Rate or 1
  end

  return 1
end

function v12.GetQuests()
  if v5.Quests then
    return v5.Quests
  end

  local modules = replicatedStorage:FindFirstChild("Modules")
  local quests2 = modules and modules:FindFirstChild("Quests")

  if quests2 then
    local v173, v174 = pcall(require, quests2)

    if v173 and type(v174) == "table" then
      v5.Quests = v174
      return v174
    end
  end

  return nil
end

function v20.GetContainer()
  local playerGui6 = localPlayer:FindFirstChild("PlayerGui")
  local uiControllerGui2 = playerGui6 and playerGui6:FindFirstChild("UIControllerGui")
  return uiControllerGui2 and uiControllerGui2:FindFirstChild("AuctionBiddingContainer")
end

function v20.GetBidBarElements()
  local v175 = v20.GetContainer()

  if not v175 or not v175.Visible then
    return nil
  end

  local bidBarRow = v175:FindFirstChild("BidBarRow")

  if not bidBarRow or not bidBarRow.Visible then
    return nil
  end

  local track = bidBarRow:FindFirstChild("Track")

  if not track then
    return nil
  end

  local bidZone = track:FindFirstChild("BidZone")
  local cursor = track:FindFirstChild("Cursor")
  local bidButton = v175:FindFirstChild("BidButton")

  if bidZone and cursor then
    return {
      Container = v175,
      Row = bidBarRow,
      Track = track,
      BidZone = bidZone,
      Cursor = cursor,
      BidButton = bidButton,
    }
  end

  return nil
end

function v20.IsAuctionActive()
  if v6.IsInAuction then
    if os.clock() - (v6.LastAuctionStartTime or 0) < 90 then
      return true
    end

    v6.IsInAuction = false
  end

  if v6.IsEnteringAuction then
    if os.clock() - (v20.LastPromptTriggerTime or v6.LastAuctionStartTime or 0) < 5 then
      return true
    end

    v6.IsEnteringAuction = false
  end

  local v176 = v20.GetContainer()
  return v176 ~= nil and v176.Visible == true
end

function v20.IsCursorInZone(p55)
  if not p55 or not p55.BidZone or not p55.Cursor then
    return false
  end

  local scale = p55.BidZone.Position.X.Scale
  local scale2 = p55.BidZone.Size.X.Scale
  local scale3 = p55.Cursor.Position.X.Scale

  if scale2 <= 0 and p55.Track then
    local x = p55.Track.AbsoluteSize.X

    if x > 0 then
      scale = p55.BidZone.AbsolutePosition.X / x
      scale2 = p55.BidZone.AbsoluteSize.X / x
      scale3 = (p55.Cursor.AbsolutePosition.X + p55.Cursor.AbsoluteSize.X / 2) / x
    end
  end

  return scale3 >= scale and scale3 <= scale + scale2
end

function v20.GetCurrentNextBid(p56)
  if not p56 then
    return 0
  end

  local bidPriceLabel = p56:FindFirstChild("BidPriceLabel")

  if bidPriceLabel and bidPriceLabel.Text and bidPriceLabel.Text ~= "" then
    local v177 = string.match(bidPriceLabel.Text, "NEXT%s*%$(%d+[,%d*]*)")

    if v177 then
      return v14.ParseMoney(v177)
    end
  end

  return 0
end

function v20.LeaveAuction(p57)
  if v6.IsWinningAuction then
    debug("[Auction/Leave] Blocked: Player is currently winning the auction. Cannot leave!")
    return false
  end

  local v178 = v13.GetRemote("Auction", "LeaveAuction")
  local v179, v180 = false, nil

  if v178 and v178:IsA("RemoteFunction") then
    v179, v180 = pcall(function() return v178:InvokeServer() end)
  end

  pcall(function()
    local v181 = require(replicatedStorage.Modules.UIController)
    v181:Close("AuctionBidding")
    v181:Close("AuctionPowers")
    v181:Close("AuctionWinningBid")
    v181:Close("AuctionWarning")
    v181:Close("AuctionKickNPC")
  end)

  local currentAuctionGarageModel = v7.CurrentAuctionGarageModel

  if currentAuctionGarageModel then
    v7.IgnoredGaragePrompts = v7.IgnoredGaragePrompts or {}
    v7.IgnoredGaragePrompts[currentAuctionGarageModel] = os.clock() + 35
  end

  v6.IsInAuction = false
  v6.IsEnteringAuction = false
  v6.IsWinningAuction = false

  v7.LastDisplayedStatusKey = nil
  v7.CurrentAuctionGarageModel = nil
  v7.CurrentAuctionZone = nil

  local v182 = p57 or "Over budget"
  debug("[Auction] Left auction (%s)", v182)
  v29.SetStatus("Auction", string.format("Left auction: %s", v182), "Seeking next garage...")
  return v179 and v180
end

function v20.CalculateMaxBid()
  local v183 = v11.GetCash()

  local v184 = (v6.FarmAuctionMaxSpendPercent or v6.AuctionMaxSpendPercent
      or f1("Slider_Farm_AuctionMaxSpendPercent") or 5)
    / 100

  return math.max(100, math.floor(v183 * v184))
end

function v20.GetLostFoundBoxPosition(p58)
  local lostAndFoundBox = nil
  local areas = workspace:FindFirstChild("Areas")

  if areas and areas:FindFirstChild(p58) then
    lostAndFoundBox = areas[p58]:FindFirstChild("Lost and Found Box")
  elseif p58 == "Cargo Ship" then
    local cargoShip = workspace:FindFirstChild("CargoShip")
    lostAndFoundBox = cargoShip and cargoShip:FindFirstChild("Lost and Found Box")
  elseif p58 == "Cargo Train" then
    local cargoTrainStop = workspace:FindFirstChild("CargoTrainStop")
    lostAndFoundBox = cargoTrainStop and cargoTrainStop:FindFirstChild("Lost and Found Box")
  end

  if lostAndFoundBox then
    local findFirstChildWhichIsA5 = lostAndFoundBox:FindFirstChildWhichIsA("BasePart", true)

    if findFirstChildWhichIsA5 then
      return findFirstChildWhichIsA5.Position
    end

    local v185, v186 = pcall(function() return lostAndFoundBox:GetPivot().Position end)

    if v185 and v186 then
      return v186
    end
  end

  local lostFoundPositions = v5.LostFoundPositions
  return lostFoundPositions and lostFoundPositions[p58]
end

function v20.ClaimAllLostItems(p59)
  local v187 = {
    "Junk Yard", "Back Alley", "Farmyard", "Shipyard", "Lucky Beach", "Power Plant",
    "Business Bay", "The Mines", "Military Base", "Cargo Ship", "Cargo Train", "Wild West",
    "Halloween", "Jurassic", "Alien Invasion",
  }

  local v188 = {}

  for index13, value23 in ipairs(v187) do
    local v189, v190 = pcall(function()
      return v13.InvokeServer("UI", "GetLostItems", value23)
    end)

    if v189 and type(v190) == "table" and v190.items and next(v190.items) then
      v188[value23] = v190.items
    end
  end

  if not next(v188) then
    return 0
  end

  local count2 = 0

  for key12, value24 in pairs(v188) do
    if v1.Unloaded then
      break
    end

    if v11.IsVehicleNearCapacity(0.95) then
      debug("[Lost&Found] Vehicle near capacity, pausing claim for area %s", key12)
      break
    end

    if p59 ~= false then
      local v191 = v20.GetLostFoundBoxPosition(key12)

      if v191 then
        v29.SetStatus(
          "Auction", string.format("Traveling to %s Lost Box", key12),
          "Moving to Lost & Found..."
        )

        debug("[Lost&Found] Moving to %s Lost & Found box...", key12)
        v15.TweenTo(v191 + Vector3.new(0, 1.5, 0))
        task.wait(0.3)

        if v16.GetDistanceToPlayer() > 25 then
          v16.Spawn(true)
          task.wait(0.5)
        end
      end
    end

    v29.SetStatus("Auction", "Claiming lost items", string.format("Area: %s", key12))

    for key13 in pairs(value24) do
      if v1.Unloaded then
        break
      end

      if v11.IsVehicleNearCapacity(0.95) then
        break
      end

      local v192, v193 = pcall(function()
        return v13.InvokeServer("UI", "ClaimLostItem", key12, key13)
      end)

      if v192 and v193 and v193.success then
        count2 = count2 + 1
        task.wait(0.25)
      end
    end
  end

  if count2 > 0 then
    debug("[Lost&Found] Recovered %d items from Lost & Found boxes", count2)
    v29.SetStatus("Auction", "Lost items recovered", string.format("Total: %d items", count2))
    task.wait(0.6)
  end

  return count2
end

function v20.PerformBid(p60)
  v20.LastBidTime = os.clock()
  v6.IsWinningAuction = true
  v13.FireServer("Auction", "Bid")

  if p60 and p60.BidButton and firesignal then
    pcall(firesignal, p60.BidButton.MouseButton1Down)
  end
end

local function f3(p61)
  if not p61 or not p61:IsA("GuiObject") then
    return false
  end

  local parent = p61

  while parent and parent:IsA("GuiObject") do
    if not parent.Visible then
      return false
    end

    parent = parent.Parent
  end

  if parent and parent:IsA("ScreenGui") and not parent.Enabled then
    return false
  end

  return true
end

local function f4(p62)
  if not p62 or not p62:IsA("GuiButton") or not f3(p62) then
    return false
  end

  if getconnections then
    pcall(function()
      for index14, value25 in ipairs(getconnections(p62.MouseButton1Click)) do
        if value25.Fire then
          pcall(value25.Fire, value25)
        end
      end

      for index15, value26 in ipairs(getconnections(p62.Activated)) do
        if value26.Fire then
          pcall(value26.Fire, value26)
        end
      end
    end)
  end

  if firesignal then
    pcall(firesignal, p62.MouseButton1Click)
    pcall(firesignal, p62.Activated)
    pcall(firesignal, p62.MouseButton1Down)
    pcall(firesignal, p62.MouseButton1Up)
  end

  return true
end

v20.LastDismissLogTimes = {}

local function f5(p63, p64, ...)
  local v194 = os.clock()

  if not v20.LastDismissLogTimes[p63] or v194 - v20.LastDismissLogTimes[p63] >= 3 then
    v20.LastDismissLogTimes[p63] = v194
    debug(p64, ...)
  end
end

function v20.CheckAndDismissPopups()
  local settingsAutoDismissTips = v6.SettingsAutoDismissTips

  if settingsAutoDismissTips == nil then
    settingsAutoDismissTips = f1("Toggle_Settings_AutoDismissTips")
  end

  if settingsAutoDismissTips == false then
    return
  end

  local confirmPromptHost = localPlayer.PlayerGui:FindFirstChild("ConfirmPromptHost")
  local confirmPrompt = confirmPromptHost and confirmPromptHost:FindFirstChild("ConfirmPrompt")

  if confirmPrompt and confirmPrompt.Visible then
    local dialog = confirmPrompt:FindFirstChild("Dialog")

    if dialog then
      local title = dialog:FindFirstChild("Title")
      local body = dialog:FindFirstChild("Body")
      local v195 = title and string.lower(title.Text) or ""
      local v196 = body and string.lower(body.Text) or ""
      local buttonRow = dialog:FindFirstChild("ButtonRow")
      local cancelButton = buttonRow and buttonRow:FindFirstChild("CancelButton")
      local confirmButton = buttonRow and buttonRow:FindFirstChild("ConfirmButton")

      if string.find(v195, "overweight") or string.find(v196, "max capacity") then
        v6.IsVehicleFull = true
        f4(cancelButton)
        confirmPrompt.Visible = false

        f5(
          "Overweight",
          "[Popup] Vehicle Overweight dismissed via 'Not now'. IsVehicleFull = true"
        )

        return
      end

      if string.find(v195, "before you start") or string.find(v196, "lost & found") then
        local farmAuctionAutoConfirmLostFound = v6.FarmAuctionAutoConfirmLostFound

        if farmAuctionAutoConfirmLostFound == nil then
          farmAuctionAutoConfirmLostFound = true
        end

        if farmAuctionAutoConfirmLostFound then
          f4(confirmButton)
          confirmPrompt.Visible = false
          f5("LostFound", "[Popup] Lost & Found warning auto-confirmed ('Yes, Start Auction')")
        else
          f4(cancelButton)
          confirmPrompt.Visible = false
          f5("LostFound", "[Popup] Lost & Found warning declined ('No')")
        end

        return
      end

      local settingsAutoDismissTips2 = v6.SettingsAutoDismissTips

      if settingsAutoDismissTips2 == nil then
        settingsAutoDismissTips2 = f1("Toggle_Settings_AutoDismissTips")
      end

      if settingsAutoDismissTips2 then
        if not (string.find(v196, "💎") or string.find(v196, "robux") or string.find(v196, "r%$"))
          and (string.find(v195, "tip") or string.find(v195, "tutorial")
            or string.find(v195, "info") or string.find(v196, "tip:")) then
          f4(confirmButton or cancelButton)
          confirmPrompt.Visible = false
          f5("Tip", "[Popup] Auto-dismissed informational tip: %s", title and title.Text or "")
        end
      end
    end
  end

  pcall(function()
    local v197 = require(replicatedStorage.Modules.UIController)

    if v197:IsOpen("ToolRewardPopup") then
      v197:Close("ToolRewardPopup")
      f5("ToolReward", "[Popup] Auto-closed ToolRewardPopup modal via UIController")
    end
  end)

  local uiControllerGui3 = localPlayer.PlayerGui:FindFirstChild("UIControllerGui")

  if uiControllerGui3 then
    local newDiscoveryOuter = uiControllerGui3:FindFirstChild("NewDiscoveryOuter")

    if newDiscoveryOuter and newDiscoveryOuter.Visible then
      local discoveryPopup = newDiscoveryOuter:FindFirstChild("DiscoveryPopup")

      local repairContinueButton = discoveryPopup
          and (discoveryPopup:FindFirstChild("RepairContinueButton")
            or discoveryPopup:FindFirstChild("ContinueButton")
            or discoveryPopup:FindFirstChildWhichIsA("GuiButton", true))
        or newDiscoveryOuter:FindFirstChild("RepairRevealBackdrop")
        or newDiscoveryOuter:FindFirstChildWhichIsA("GuiButton", true)

      if repairContinueButton and f3(repairContinueButton) then
        f4(repairContinueButton)
      end

      newDiscoveryOuter.Visible = false
    end

    local findFirstChild7 = uiControllerGui3:FindFirstChild("ToolRewardPopupPanel", true)

    if findFirstChild7 and findFirstChild7.Visible then
      local findFirstChild8 = findFirstChild7:FindFirstChild("ThankYouButton", true)
        or findFirstChild7:FindFirstChildWhichIsA("GuiButton", true)

      if findFirstChild8 and f3(findFirstChild8) then
        f4(findFirstChild8)
      end

      findFirstChild7.Visible = false
    end

    local findFirstChild9 = uiControllerGui3:FindFirstChild("QuestRewardPopupPanel", true)

    if findFirstChild9 and findFirstChild9.Visible then
      local findFirstChild10 = findFirstChild9:FindFirstChild("DismissButton", true)
        or findFirstChild9:FindFirstChildWhichIsA("GuiButton", true)

      if findFirstChild10 and f3(findFirstChild10) then
        f4(findFirstChild10)
      end

      findFirstChild9.Visible = false
    end
  end

  local trophyInfoBannerGui = localPlayer.PlayerGui:FindFirstChild("TrophyInfoBannerGui")

  if trophyInfoBannerGui and trophyInfoBannerGui.Enabled then
    local trophyInfoBannerBar = trophyInfoBannerGui:FindFirstChild("TrophyInfoBannerBar")

    if trophyInfoBannerBar and trophyInfoBannerBar.Visible then
      local continueButton = trophyInfoBannerBar:FindFirstChild("ContinueButton")

      if continueButton and f3(continueButton) then
        f4(continueButton)
        trophyInfoBannerBar.Visible = false

        f5("TrophyBanner", "[Popup] Auto-clicked Continue on TrophyInfoBannerGui (%s)", trophyInfoBannerBar:FindFirstChild("Header") and trophyInfoBannerBar.Header.Text
          or "Banner")
      end

      pcall(function()
        require(replicatedStorage.Modules.UIController):Close("TrophyInfoBanner")
      end)
    end
  end
end

function v20.DismissDiscoveryPopup()
  v20.CheckAndDismissPopups()
end

function v20.RefreshStatsContent()
  local v198 = v21.GetPawnState()
  local rate = v198.rate or v198.Rate or v7.CurrentPawnRate or 1

  local secondsUntilNext = v198.secondsUntilNext or v198.SecondsUntilNext
    or v7.PawnSecondsUntilNext or 0

  local v199 = v11.GetInventoryCount()
  local v200 = v11.GetInventoryMax()
  local v201 = v11.GetVehicleItemCount()
  local v202 = v11.GetVehicleCargoWeight()
  local v203 = v11.GetVehicleCargoWeightLimit()
  local v204, v205 = v13.InvokeServer("Plot", "ShelfAutoStock", "preview")
  local v206 = v204 and type(v205) == "table" and tonumber(v205.FreeSlots) or 0
  local count3 = 0
  local v207 = v11.GetPlayerPlot()

  if v207 then
    local stock2 = v207:FindFirstChild("Stock")

    if stock2 then
      for index16, value27 in ipairs(stock2:GetChildren()) do
        if value27:GetAttribute("IsStockItem") == true
          or value27:IsA("Model") and not value27:GetAttribute("TrophyId") then
          count3 = count3 + 1
        end
      end
    end
  end

  local v208 = count3 + v206

  v7.FarmStatsContent = string.format([[
Pawn Multiplier: <font color="#4CAF50"><b>%.2fx</b></font> (<font color="#FFA726">%ds</font>)
Inventory: <font color="#00E5FF">%d/%d</font> | Store Shelves: <font color="#AB47BC">%d/%d</font>
Vehicle Cargo: <font color="#FFA726">%d items - %.0f/%.0f kg</font>]], rate, secondsUntilNext, v199, v200, count3, v208, v201, v202, v203)

  if v9.FarmOverview then
    f2(v9.FarmOverview, v7.FarmStatsContent)
  end
end

function v20.UpdateStatusParagraph(p65, p66)
  if not p65 then
    return
  end

  v7.AuctionStatusText = p65
  local v209, v210 = string.match(p65, "^%[([^%]]+)%]%s*(.*)$")

  if v209 and v210 then
    v29.SetStatus(v209, v210, p66)
    return
  end

  local v211, v212 = string.match(p65, "^([^:!]+)[:!]%s*(.*)$")

  if v211 and v212 and #v211 <= 16 then
    v29.SetStatus(v211, v212, p66)
    return
  end

  v29.SetStatus("Farm", p65, p66)
end

function v20.CollectNearbyLoot()
  if v15.CurrentTween ~= nil then
    return 0
  end

  if v20.IsAuctionActive() then
    return 0
  end

  local character8 = localPlayer.Character
  local humanoidRootPart4 = character8 and character8:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart4 then
    return
  end

  v20.CheckAndDismissPopups()
  local v213 = v16.GetPlayerVehicle()
  local v214 = v16.GetDistanceToPlayer()

  if not v213 or v214 > 35 then
    v16.EnsureNearPlayer(35)
    task.wait(0.4)
    v213 = v16.GetPlayerVehicle()
    v214 = v16.GetDistanceToPlayer()
  end

  local v215 = v213 ~= nil and v214 <= 40
  local userId3 = localPlayer.UserId
  local currentAuctionZone = v7.CurrentAuctionZone

  if not currentAuctionZone then
    local garages2 = workspace:FindFirstChild("_Debris")
      and workspace._Debris:FindFirstChild("Garages")

    if garages2 then
      local v216 = 35

      for index17, value28 in ipairs(garages2:GetChildren()) do
        local findFirstChild11 = value28:FindFirstChild("AuctionZone", true)

        if findFirstChild11 and findFirstChild11:IsA("BasePart") then
          local magnitude3 = (findFirstChild11.Position - humanoidRootPart4.Position).Magnitude

          if magnitude3 < v216 then
            v216 = magnitude3
            currentAuctionZone = findFirstChild11
            v7.CurrentAuctionZone = findFirstChild11
          end
        end
      end
    end
  end

  local collectionService = game:GetService("CollectionService")

  local function f6(p67)
    if not (p67 and p67:IsA("ProximityPrompt") and p67.Enabled) then
      return false
    end

    if p67.Name ~= "PickupPrompt" and p67.Name ~= "OpenBoxPrompt" then
      return false
    end

    local actionText = p67.ActionText or ""
    local v217 = string.find(actionText, "Vehicle") ~= nil

    if (v6.IsVehicleFull or not v215) and v217 then
      return false
    end

    if not v217 and v11.GetInventoryCount() >= v11.GetInventoryMax() then
      return false
    end

    if v7.IgnoredHeavyPrompts and v7.IgnoredHeavyPrompts[p67] then
      return false
    end

    local model = p67:FindFirstAncestorWhichIsA("Model")
    local owner = p67:GetAttribute("Owner")
    local owner2 = model and model:GetAttribute("Owner")

    local lostOwnerId = p67:GetAttribute("LostOwnerId")
      or model and model:GetAttribute("LostOwnerId")

    if lostOwnerId ~= nil and tonumber(lostOwnerId) ~= userId3 then
      return false
    end

    local v218 = tonumber(owner) or tonumber(owner2)

    if v218 ~= nil and v218 > 0 and v218 ~= userId3 then
      return false
    end

    local v219 = (p67.Parent:IsA("BasePart") and { p67.Parent } or {
      (p67.Parent:IsA("Attachment") and p67.Parent.Parent:IsA("BasePart") and { p67.Parent.Parent } or { (p67:FindFirstAncestorWhichIsA("BasePart")) })[1],
    })[1]

    if not v219 then
      return false
    end

    if currentAuctionZone then
      if (v219.Position - currentAuctionZone.Position).Magnitude > 40 then
        return false
      end
    elseif (v219.Position - humanoidRootPart4.Position).Magnitude > 30 then
      return false
    end

    return true, v219, actionText
  end

  local gamePrompt = collectionService:GetTagged("GamePrompt")
  local v220 = {}

  for index18, value29 in ipairs(gamePrompt) do
    local v221, v222, v223 = f6(value29)

    if v221 and v222 then
      local magnitude4 = (v222.Position - humanoidRootPart4.Position).Magnitude

      if magnitude4 <= 120 then
        table.insert(v220, {
          prompt = value29,
          part = v222,
          dist = magnitude4,
          isRepair = v223 == "Repair",
        })
      end
    end
  end

  table.sort(v220, function(p68, p69) return p68.dist < p69.dist end)
  local count4 = 0
  local v224 = {}
  local v225 = {}

  for index19, value30 in ipairs(v220) do
    local v226 = false

    repeat
      if v1.Unloaded
        or not (v6.FarmAuctionAutoPickupLoot or v6.AuctionAutoPickupLoot
          or f1("Toggle_Farm_AuctionAutoPickupLoot")) then
        break
      end

      if not v6.IsPickupActive then
        break
      end

      local prompt = value30.prompt
      local part = value30.part

      if v224[prompt] then
        v226 = true
        break
      end

      if not (prompt and prompt.Parent and prompt.Enabled) then
        v226 = true
        break
      end

      if (part.Position - humanoidRootPart4.Position).Magnitude > 6 then
        local v227 = part.Position + Vector3.new(0, 1.5, 0)
        v15.TweenTo(v227)
        task.wait(0.25)
      end

      local position3 = part.Position
      local v228 = os.clock()
      local count5 = 0

      while os.clock() - v228 < 3.5 and count5 < 8 do
        if v1.Unloaded or not v6.IsPickupActive then
          break
        end

        local v229 = nil
        local v230 = ""
        local v231 = -1

        for index20, value31 in ipairs((collectionService:GetTagged("GamePrompt"))) do
          local v232 = false

          repeat
            if not v224[value31] then
              local v233, v234, v235 = f6(value31)

              if v233 and v234 and (v234.Position - position3).Magnitude <= 10 then
                local v236 = 1

                if v235 == "Open" or string.find(v235, "Open") then
                  v236 = 3
                elseif v235 == "Repair" or string.find(v235, "Repair") then
                  if v225[value31] then
                    v232 = true
                    break
                  end

                  v236 = 2
                end

                if v236 > v231 then
                  v231 = v236
                  v229 = value31
                  v230 = v235
                end
              end
            end

            v232 = true
          until true

          if not v232 then
            break
          end
        end

        if not v229 then
          break
        end

        pcall(function()
          v229.HoldDuration = 0
          v229.MaxActivationDistance = 25
        end)

        fireproximityprompt(v229, 0)
        count4 = count4 + 1
        count5 = count5 + 1
        v20.DismissDiscoveryPopup()

        if string.find(v230, "Open") then
          v224[v229] = true
          task.wait(0.4)
          v20.DismissDiscoveryPopup()
          local v237 = os.clock()

          while os.clock() - v237 < 0.4 do
            local v238 = false

            for index21, value32 in ipairs(collectionService:GetTagged("GamePrompt")) do
              if not v224[value32] then
                local v239, v240 = f6(value32)

                if v239 and v240 and (v240.Position - position3).Magnitude <= 10 then
                  v238 = true
                  break
                end
              end
            end

            if v238 then
              break
            end

            task.wait(0.08)
          end
        elseif string.find(v230, "Repair") then
          v225[v229] = true
          task.wait(0.4)
          v20.CheckAndDismissPopups()
        else
          v224[v229] = true
          task.wait(0.55)
        end
      end

      v226 = true
    until true

    if not v226 then
      break
    end
  end

  if count4 > 0 then
    v6.PickupStartTime = os.clock()
    v20.EmptySweepCounter = 0
    v11.InvalidateInventoryCache()
  elseif #v220 == 0 then
    v6.IsPickupActive = false
    v6.PickupStartTime = nil

    v20.EmptySweepCounter = 0

    v7.CurrentAuctionZone = nil
    v7.CurrentAuctionPos = nil
    v7.CurrentAuctionGarageModel = nil

    v29.SetStatus("Auction", "Loot collected!", "Ready for next auction")
  end
end

function v20.IsGarageSeized(p70)
  if not p70 then
    return false
  end

  local parent2 = p70.Parent
  local v241 = nil

  while parent2 and parent2 ~= workspace do
    if parent2.Parent and parent2.Parent.Name == "Garages" then
      v241 = parent2
      break
    end

    parent2 = parent2.Parent
  end

  if v241 then
    if v241:FindFirstChild("SeizedDressing") then
      return true
    end

    local findFirstChild12 = v241:FindFirstChild("PoliceWarning", true)

    if findFirstChild12 and findFirstChild12:IsA("GuiObject") and findFirstChild12.Visible then
      return true
    end
  end

  local v242 = string.lower(p70.ObjectText or v241 and v241.Name or "")

  if string.find(v242, "seized") or string.find(v242, "police") then
    return true
  end

  return false
end

function v20.FindNearestGaragePrompt()
  local character9 = localPlayer.Character
  local humanoidRootPart5 = character9 and character9:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart5 then
    return nil, math.huge
  end

  local collectionService2 = game:GetService("CollectionService")
  local gamePrompt2 = collectionService2:GetTagged("GamePrompt")
  local v243 = v11.GetNetWorth()
  local v244 = v11.GetCash()
  local auctionTargetGarages = v6.AuctionTargetGarages

  if auctionTargetGarages == nil then
    auctionTargetGarages = f1("Dropdown_Farm_AuctionTargetGarages")
  end

  local farmAuctionAvoidSeizedGarages = v6.FarmAuctionAvoidSeizedGarages

  if farmAuctionAvoidSeizedGarages == nil then
    farmAuctionAvoidSeizedGarages = f1("Toggle_Farm_AuctionAvoidSeizedGarages")
  end

  if farmAuctionAvoidSeizedGarages == nil then
    farmAuctionAvoidSeizedGarages = true
  end

  local v245 = {}
  local v246 = -1

  for index22, value33 in ipairs(gamePrompt2) do
    local v247 = false

    repeat
      if value33:IsA("ProximityPrompt") and value33.Name == "EnterAuction" and value33.Enabled then
        local objectText = value33.ObjectText or ""
        local parent3 = value33.Parent

        while parent3 and parent3.Parent and parent3.Parent.Name ~= "Garages" do
          parent3 = parent3.Parent
        end

        if v7.IgnoredGaragePrompts and parent3 and v7.IgnoredGaragePrompts[parent3]
          and os.clock() < v7.IgnoredGaragePrompts[parent3] then
          v247 = true
          break
        end

        if farmAuctionAvoidSeizedGarages and v20.IsGarageSeized(value33) then
          v247 = true
          break
        end

        if v11.IsEligibleForGarage(objectText) then
          local v248 = false

          if auctionTargetGarages and type(auctionTargetGarages) == "table" then
            for key14, value34 in pairs(auctionTargetGarages) do
              local v249 = nil

              if type(value34) == "boolean" and value34 == true then
                v249 = key14
              elseif type(value34) == "string" and value34 ~= "" then
                v249 = value34
              end

              if v249 then
                local v250 = string.gsub(v249, "%s*%(.-%)", "")

                if v250 == objectText or string.find(objectText, v250, 1, true)
                  or string.find(v250, objectText, 1, true) then
                  v248 = true
                  break
                end
              end
            end
          end

          if v248 then
            local parent4 = value33.Parent

            if parent4 and parent4:IsA("BasePart") then
              local magnitude5 = (parent4.Position - humanoidRootPart5.Position).Magnitude
              local v251 = v11.GetGarageConfig(objectText)
              local minNetWorth = v251 and v251.MinNetWorth or 0

              if minNetWorth > v246 then
                v246 = minNetWorth
              end

              table.insert(v245, {
                prompt = value33,
                dist = magnitude5,
                tier = minNetWorth,
                name = objectText,
              })
            end
          end
        end
      end

      v247 = true
    until true

    if not v247 then
      break
    end
  end

  local tier = -1

  for index23, value35 in ipairs(v245) do
    if value35.tier > tier then
      tier = value35.tier
    end
  end

  local prompt2 = nil
  local huge = math.huge

  for index24, value36 in ipairs(v245) do
    if value36.tier == tier then
      if value36.dist < huge then
        huge = value36.dist
        prompt2 = value36.prompt
      end
    end
  end

  if prompt2 then
    debug(
      "[Auction/Find] Selected best eligible garage: %s (Tier MinNW=$%s, dist=%.1f studs)",
      prompt2.ObjectText or "Unknown", v14.Number(v246), huge
    )
  else
    debug(
      "[Auction/Find] No eligible garage found! (NetWorth=$%s, Cash=$%s, candidates=%d)",
      v14.Number(v243), v14.Number(v244), #v245
    )
  end

  return prompt2, huge
end

v21.PawnShopPos = Vector3.new(367.2, 1723.6, -15.2)

function v21.GetPawnState()
  local v252, v253 = v13.InvokeServer("Pawn", "GetPawnState")

  if v252 and type(v253) == "table" then
    local rate2 = v253.rate or v253.Rate or 1
    local secondsUntilNext2 = v253.secondsUntilNext or v253.SecondsUntilNext or 0

    v7.CurrentPawnRate = rate2
    v7.PawnSecondsUntilNext = secondsUntilNext2

    return v253
  end

  return { rate = v7.CurrentPawnRate or 1, secondsUntilNext = 0 }
end

function v21.GetSellableItems()
  local v254, v255 = v13.InvokeServer("Pawn", "GetSellableItems")

  if v254 and type(v255) == "table" then
    return v255
  end

  return {}
end

function v21.TravelToShop()
  local count6 = 0

  while (v20.IsAuctionActive() or v6.IsPickupActive) and count6 < 8 do
    v29.SetStatus(
      "Pawn Shop", "Paused: In auction/pickup", "Waiting before traveling to shop..."
    )

    debug("[Shop] In active auction or loot pickup, waiting before traveling to Pawn Shop...")
    task.wait(1.5)
    count6 = count6 + 1
  end

  if count6 >= 8 and not v20.IsAuctionActive() then
    v6.IsPickupActive = false
  end

  v29.SetStatus("Pawn Shop", "Traveling to Pawn Shop", "Moving to shop counter...")
  debug("[Shop] Traveling to Pawn Shop...")
  return (v15.TweenTo(v21.PawnShopPos + Vector3.new(0, 1.5, 0)))
end

function v21.SellAll(p71, p72)
  local v256 = v21.GetPawnState()
  local rate3 = v256.rate or v256.Rate or v7.CurrentPawnRate or 1

  local farmPawnMinMultiplier = v6.FarmPawnMinMultiplier or f1("Slider_Farm_PawnMinMultiplier")
    or 1

  local v257 = math.floor(rate3 * 100 + 0.5) / 100

  if p72 ~= true and v257 < farmPawnMinMultiplier then
    debug(
      "[Shop] SellAll skipped: Current rate %.2fx < target min %.2fx", v257,
      farmPawnMinMultiplier
    )

    return false, "RateTooLow"
  end

  local v258 = localPlayer:GetAttribute("QuickSell") == true
  local character10 = localPlayer.Character
  local humanoidRootPart6 = character10 and character10:FindFirstChild("HumanoidRootPart")

  local magnitude6 = humanoidRootPart6
      and (humanoidRootPart6.Position - v21.PawnShopPos).Magnitude
    or math.huge

  if not v258 and magnitude6 > 25 then
    local farmAuctionAutoStartAuction = v6.FarmAuctionAutoStartAuction

    if farmAuctionAutoStartAuction == nil then
      farmAuctionAutoStartAuction = f1("Toggle_Farm_AuctionAutoStartAuction")
    end

    if farmAuctionAutoStartAuction and not v6.IsSellingActive and p72 ~= true then
      return false, "AuctionActive"
    end

    v21.TravelToShop()
    task.wait(0.5)
  end

  local v259 = v21.GetSellableItems()
  local v260 = {}
  local farmPawnSellSources = p71 or v6.FarmPawnSellSources or { "Inventory", "Vehicle" }
  local v261 = false
  local v262 = false

  if type(farmPawnSellSources) == "table" then
    if farmPawnSellSources.Inventory == true or farmPawnSellSources[1] == "Inventory"
      or farmPawnSellSources[2] == "Inventory" then
      v261 = true
    end

    if farmPawnSellSources.Vehicle == true or farmPawnSellSources[1] == "Vehicle"
      or farmPawnSellSources[2] == "Vehicle" then
      v262 = true
    end

    for key15, value37 in pairs(farmPawnSellSources) do
      if key15 == "Inventory" and value37 == true or value37 == "Inventory" then
        v261 = true
      end

      if key15 == "Vehicle" and value37 == true or value37 == "Vehicle" then
        v262 = true
      end
    end
  else
    v261 = true
    v262 = true
  end

  local questsProtectItems = v6.QuestsProtectItems

  if questsProtectItems == nil then
    questsProtectItems = f1("Toggle_Quests_ProtectItems")
  end

  if questsProtectItems == nil then
    questsProtectItems = true
  end

  local v263 = false

  if questsProtectItems and v27.GetActiveQuests then
    for key16, value38 in pairs(v27.GetActiveQuests() or {}) do
      if value38.Data and value38.Data.Tasks then
        for index25, value39 in ipairs(value38.Data.Tasks) do
          if (value39.Current or 0) < (value39.Required or 1) then
            local v264 = tostring(value39.Id or "")
            local v265 = tostring(value39.Type or "")
            local v266 = string.lower(value39.Text or "")

            if v264 == "unlock_safes" or v265 == "unlock_safe" or string.find(v266, "safe") then
              v263 = true
              break
            end
          end
        end
      end

      if v263 then
        break
      end
    end
  end

  for key17, value40 in pairs(v259) do
    local v267 = false

    repeat
      if value40.Favorited == true or value40.Data and value40.Data.Favorited == true then
        v267 = true
        break
      end

      local isQuestRelatedItem = questsProtectItems and v27.IsQuestRelatedItem
        and v27.IsQuestRelatedItem(value40)

      if not isQuestRelatedItem and questsProtectItems then
        local v268 = tostring(value40.ItemId or value40.itemId
          or value40.Data and value40.Data.ItemId or "")

        if v7.QuestRequiredItemIds and v7.QuestRequiredItemIds[v268] then
          isQuestRelatedItem = true
        elseif v263 then
          local category = value40.Category or value40.Data and value40.Data.Category
          local safeId = value40.SafeId or value40.Data and value40.Data.SafeId
          local v269 = string.lower(value40.Name or value40.Data and value40.Data.Name or "")

          if category == "Safe" or safeId ~= nil or v268 == "117" or string.find(v269, "safe") then
            isQuestRelatedItem = true
          end
        end
      end

      if not isQuestRelatedItem then
        local v270 = value40._source == "Vehicle" or value40.SourceType == "Vehicle"
          or value40.VehicleGuid ~= nil

        if v270 and v262 or not v270 and v261 then
          table.insert(v260, key17)
        end
      end

      v267 = true
    until true

    if not v267 then
      break
    end
  end

  if #v260 == 0 then
    debug("[Shop] No items available to sell matching sources")
    return false
  end

  debug("[Shop] Selling %d items to Pawn Shop...", #v260)
  local v271, v272 = v13.InvokeServer("Pawn", "SellItems", v260)

  if v271 and type(v272) == "table" and v272.success then
    v6.IsVehicleFull = false
    v7.IgnoredHeavyPrompts = nil
    v11.InvalidateInventoryCache()

    debug(
      "[Shop] Sold %d items successfully! Total payout: $%s", #v260,
      v14.Number(v272.totalEarned or 0)
    )

    return true
  end

  debug("[Shop] Failed to sell items: %s", tostring(v272 and v272.error or "Unknown error"))
  return false
end

v22.LastStockTime = 0

local function f7(p73)
  if not p73 or not p73:IsA("GuiButton") then
    return false
  end

  if type(firesignal) == "function" then
    pcall(firesignal, p73.MouseButton1Click)
    pcall(firesignal, p73.Activated)
    pcall(firesignal, p73.MouseButton1Down)
    pcall(firesignal, p73.MouseButton1Up)
  end

  if type(getconnections) == "function" then
    pcall(function()
      for index26, value41 in ipairs(getconnections(p73.MouseButton1Click)) do
        if value41.Fire then
          pcall(value41.Fire, value41)
        end
      end

      for index27, value42 in ipairs(getconnections(p73.Activated)) do
        if value42.Fire then
          pcall(value42.Fire, value42)
        end
      end
    end)
  end

  pcall(function()
    local virtualInputManager = game:GetService("VirtualInputManager")
    local absolutePosition = p73.AbsolutePosition
    local absoluteSize = p73.AbsoluteSize
    local v273 = absolutePosition.X + absoluteSize.X / 2
    local v274 = absolutePosition.Y + absoluteSize.Y / 2

    if v273 > 0 and v274 > 0 then
      virtualInputManager:SendMouseButtonEvent(v273, v274, 0, true, game, 1)
      task.wait(0.05)
      virtualInputManager:SendMouseButtonEvent(v273, v274, 0, false, game, 1)
    end
  end)

  return true
end

function v22.EnsurePlotSelected(p74)
  local v275 = v11.GetPlayerPlot()

  if v275 then
    return true, v275
  end

  p74 = p74 or 3
  local playerGui7 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui7 then
    return false
  end

  for k = 1, p74 do
    v275 = v11.GetPlayerPlot()

    if v275 then
      return true, v275
    end

    local splashScreen = playerGui7:FindFirstChild("SplashScreen")
    local findFirstChild13 = splashScreen and splashScreen:FindFirstChild("PlayButton", true)

    if findFirstChild13 and findFirstChild13:IsA("GuiButton") and findFirstChild13.Visible then
      local v276 = os.clock()

      while findFirstChild13 and findFirstChild13.Parent
        and findFirstChild13.Text == "Loading..." and os.clock() - v276 < 5 do
        task.wait(0.2)
      end

      f7(findFirstChild13)
      task.wait(1)
    end

    v275 = v11.GetPlayerPlot()

    if v275 then
      return true, v275
    end

    local uiControllerGui4 = playerGui7:FindFirstChild("UIControllerGui")

    local plotSelectionFrame = uiControllerGui4
      and uiControllerGui4:FindFirstChild("PlotSelectionFrame")

    local findFirstChild14 = plotSelectionFrame
      and plotSelectionFrame:FindFirstChild("ClaimButton", true)

    local v277 = os.clock()

    while (not findFirstChild14 or not findFirstChild14.Visible) and os.clock() - v277 < 3 do
      v275 = v11.GetPlayerPlot()

      if v275 then
        return true, v275
      end

      uiControllerGui4 = playerGui7:FindFirstChild("UIControllerGui")

      plotSelectionFrame = uiControllerGui4
        and uiControllerGui4:FindFirstChild("PlotSelectionFrame")

      findFirstChild14 = plotSelectionFrame
        and plotSelectionFrame:FindFirstChild("ClaimButton", true)

      task.wait(0.2)
    end

    if findFirstChild14 and findFirstChild14:IsA("GuiButton") and findFirstChild14.Visible then
      f7(findFirstChild14)
      task.wait(1.5)
      v275 = v11.GetPlayerPlot()

      if v275 then
        debug("[PlayerShop] Plot claimed successfully!")
        return true, v275
      end
    end

    if k < p74 then
      task.wait(1)
    end
  end

  return v275 ~= nil, v275
end

function v22.TeleportToPlot()
  while v20.IsAuctionActive() or v6.IsPickupActive do
    f2(v9.PlayerShopStatus, "Paused: Auction/Pickup in progress...")
    debug("[PlayerShop] In active auction or loot pickup, waiting before traveling to Plot...")
    task.wait(2)
  end

  local v278 = v11.GetPlotUnpackPosition()

  if not v278 then
    debug("[PlayerShop] Plot unpack position not found")
    return false
  end

  f2(v9.PlayerShopStatus, "Traveling to My Plot...")
  debug("[PlayerShop] Traveling to My Plot...")
  return (v15.TweenTo(v278 + Vector3.new(0, 1.5, 0)))
end

function v22.StockShelves()
  local v279 = os.clock()

  if v279 - (v22.LastStockTime or 0) < 3 then
    return false
  end

  v22.LastStockTime = v279
  local v280, v281 = v13.InvokeServer("Plot", "ShelfAutoStock", "preview")

  if not v280 or type(v281) ~= "table" or v281.Ok ~= true then
    debug("[PlayerShop] ShelfAutoStock preview failed or no shelves available")
    return false
  end

  local v282 = tonumber(v281.FreeSlots) or 0
  local v283 = tonumber(v281.SpaceLeft) or 0
  local v284 = math.max(0, math.min(v282, v283))

  if v284 <= 0 then
    if not v7.LastShelfFullWarn or os.clock() - v7.LastShelfFullWarn > 30 then
      v7.LastShelfFullWarn = os.clock()
      debug("[PlayerShop] No available shelf capacity (freeSlots=%d, spaceLeft=%d)", v282, v283)
    end

    return false
  end

  v7.LastShelfFullWarn = nil
  local v285, v286 = v13.InvokeServer("Inventory", "GetPlayerInventory")

  if not v285 or type(v286) ~= "table" then
    debug("[PlayerShop] Could not fetch player inventory for stocking")
    return false
  end

  local farmPlayerShopStockPriority = v6.FarmPlayerShopStockPriority
    or f1("Dropdown_Farm_PlayerShopStockPriority") or "Highest Value First"

  local v287 = {}
  local fits = v281.Fits or {}

  for key18, value43 in pairs(v286) do
    if value43
      and not (value43
        and (value43.Favorited == true or value43.Data and value43.Data.Favorited == true))
      and fits[key18] == true then
      local v288 = tostring(value43.ItemId or value43.itemId or "")

      if not (v6.QuestsProtectItems
        and (v27.IsQuestRelatedItem and v27.IsQuestRelatedItem(value43)
          or v7.QuestRequiredItemIds and v7.QuestRequiredItemIds[v288])) then
        local items2 = v5.Items and v5.Items[v288]
        local basePrice = items2 and items2.BasePrice or 0

        if value43.Price or value43.price then
          basePrice = tonumber(value43.Price or value43.price) or basePrice
        end

        table.insert(v287, { guid = key18, value = basePrice })
      end
    end
  end

  if farmPlayerShopStockPriority == "Lowest Value First" then
    table.sort(v287, function(p75, p76) return p75.value < p76.value end)
  else
    table.sort(v287, function(p77, p78) return p77.value > p78.value end)
  end

  local v289 = {}

  for m = 1, math.min(#v287, v284) do
    table.insert(v289, v287[m].guid)
  end

  if #v289 == 0 then
    debug("[PlayerShop] No eligible inventory items to stock on shelves")
    return false
  end

  debug("[PlayerShop] Stocking %d items onto display shelves...", #v289)
  local v290, v291 = v13.InvokeServer("Plot", "ShelfAutoStock", "apply", v289)

  if v290 and type(v291) == "table" and v291.Ok == true then
    debug(
      "[PlayerShop] Successfully stocked %d items onto shelves!", tonumber(v291.Placed) or #v289
    )

    return true
  end

  debug(
    "[PlayerShop] Failed to stock shelves: %s", tostring(v291 and v291.Error or "Unknown error")
  )

  return false
end

function v22.ProcessPendingShopperOffers()
  local playerGui8 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui8 then
    return 0
  end

  local farmPlayerShopMinOfferMultiplier = v6.FarmPlayerShopMinOfferMultiplier
    or f1("Slider_Farm_PlayerShopMinOfferMultiplier") or 1

  local count7 = 0

  for index28, value44 in ipairs(playerGui8:GetChildren()) do
    if value44:IsA("BillboardGui") and string.sub(value44.Name, 1, 16) == "NPCShopperOffer_" then
      local v292 = string.sub(value44.Name, 17)
      local findFirstChild15 = value44:FindFirstChild("OfferText", true)
      local findFirstChild16 = value44:FindFirstChild("Accept", true)
      local findFirstChild17 = value44:FindFirstChild("Decline", true)
      local v293 = 1

      if findFirstChild15 and findFirstChild15.Text then
        local v294, v295 = string.match(findFirstChild15.Text, "%[([%+%-])(%d+)%%%]")

        if v294 and v295 then
          local v296 = tonumber(v295) or 0

          if v294 == "-" then
            v293 = 1 - v296 / 100
          else
            v293 = 1 + v296 / 100
          end
        end
      end

      local v297 = v13.GetRemote("NPCShopper", "RespondOffer")

      if v293 >= farmPlayerShopMinOfferMultiplier then
        if firesignal and findFirstChild16 then
          pcall(firesignal, findFirstChild16.MouseButton1Click)
        elseif v297 then
          v297:FireServer(v292, true)
        end

        count7 = count7 + 1

        debug(
          "[PlayerShop] Processed pending offer %s: Accepted (mult=%.2fx >= %.2fx)", v292, v293,
          farmPlayerShopMinOfferMultiplier
        )
      else
        if firesignal and findFirstChild17 then
          pcall(firesignal, findFirstChild17.MouseButton1Click)
        elseif v297 then
          v297:FireServer(v292, false)
        end

        count7 = count7 + 1

        debug(
          "[PlayerShop] Processed pending offer %s: Declined (mult=%.2fx < %.2fx)", v292, v293,
          farmPlayerShopMinOfferMultiplier
        )
      end
    end
  end

  return count7
end

v23.StationSlots = {
  Wash = { total = 1, items = {} },
  Repair = { total = 1, items = {} },
  Grading = { total = 1, items = {} },
  Locksmith = { total = 1, items = {} },
  TimeCapsule = { total = 1, items = {} },
}

function v23.GetSlotItemName(p79)
  if not p79 then
    return "Item"
  end

  local itemData = p79.ItemData or p79.itemData or p79.data or p79

  if type(itemData) == "table" then
    if type(itemData.Name) == "string" and itemData.Name ~= "" then
      return itemData.Name
    end

    local itemId = itemData.ItemId or itemData.itemId or itemData.id

    if itemId and v5.Items then
      local v298 = v5.Items[itemId] or v5.Items[tostring(itemId)]

      if v298 and v298.Name then
        return v298.Name
      end
    end
  end

  if p79.SafeId and v5.Items then
    for key19, value45 in pairs(v5.Items) do
      if value45.SafeId == p79.SafeId then
        return value45.Name
      end
    end
  end

  return "Item"
end

function v23.FormatStationLine(p80, p81)
  local items3 = p81 and p81.items or {}

  if #items3 == 0 then
    return string.format("• <b>%s</b>: <font color=\"#8A9AA8\">Empty</font>", p80)
  end

  local v299 = {}

  for index29, value46 in ipairs(items3) do
    local v300 = value46.status == "Ready" and "#00E676" or "#00E5FF"

    table.insert(v299, string.format(
      "<font color=\"#FFFFFF\">%s</font> (<font color=\"%s\">%s</font>)", value46.name, v300,
      value46.status
    ))
  end

  return string.format("• <b>%s</b>: %s", p80, table.concat(v299, " | "))
end

function v23.GetItemPrice(p82)
  local data = p82 and (p82.data or p82.ItemData or p82)

  if not data then
    return 0
  end

  local itemId2 = data.ItemId or data.itemId or data.id
  local items4 = itemId2 and v5.Items and (v5.Items[itemId2] or v5.Items[tostring(itemId2)])
  local v301 = items4 and tonumber(items4.BasePrice) or 0

  if v5.Mutators and v5.Mutators.CalculatePriceForEntry then
    local v302, v303 = pcall(function() return v5.Mutators:CalculatePriceForEntry(v301, data) end)

    if v302 and tonumber(v303) then
      return tonumber(v303)
    end
  end

  return v301
end

function v23.IsUtilityItem(p83)
  local data2 = p83 and (p83.data or p83.ItemData or p83)

  if not data2 then
    return false
  end

  if data2.SafeId or p83.SafeId then
    return true
  end

  if data2.EnergyDrinkId or p83.EnergyDrinkId then
    return true
  end

  local itemId3 = data2.ItemId or data2.itemId or data2.id
  local items5 = itemId3 and v5.Items and (v5.Items[itemId3] or v5.Items[tostring(itemId3)])

  if items5 then
    if items5.SafeId or items5.EnergyDrinkId then
      return true
    end

    local name3 = items5.Name or ""

    if string.find(name3, "Fishing Rod") or string.find(name3, "Certificate")
      or string.find(name3, "Safe") or string.find(name3, "Drink")
      or string.find(name3, "Potion") then
      return true
    end
  end

  return false
end

function v23.RunWash(p84)
  local v304, v305 = v13.InvokeServer("Wash", "GetSlotState")

  if not v304 or type(v305) ~= "table" then
    return 0, 0, false
  end

  local v306 = tonumber(v305.unlockedCount) or 1
  local slots = v305.slots or {}
  local getServerTimeNow = workspace:GetServerTimeNow()
  local v307 = {}
  local v308 = v11.GetInventoryCount()
  local v309 = v11.GetInventoryMax()
  local v310 = v309 > 0 and v308 >= v309

  for n = 1, v306 do
    local v311 = slots[tostring(n)]

    if v311 then
      if v311.Washed == true then
        if not v310 then
          local v312, v313 = v13.InvokeServer("Wash", "ClaimWashedItem", n)

          if v312 and v313 and v313.success ~= false then
            debug("[ServiceHub] Wash: Claimed washed item at slot %d", n)
            slots[tostring(n)] = nil
            table.insert(v307, n)
            v308 = v308 + 1
            v310 = v309 > 0 and v308 >= v309
          end
        end
      elseif (v311.StartTime or 0) + (v311.Duration or 0) <= getServerTimeNow then
        if not v310 then
          local v314, v315 = v13.InvokeServer("Wash", "CollectWash", n)

          if v314 and v315 and v315.success ~= false then
            v311.Washed = true
            task.wait(0.8)
            local v316, v317 = v13.InvokeServer("Wash", "ClaimWashedItem", n)

            if v316 and v317 and v317.success ~= false then
              debug("[ServiceHub] Wash: Completed & claimed item at slot %d", n)
              slots[tostring(n)] = nil
              table.insert(v307, n)
              v308 = v308 + 1
              v310 = v309 > 0 and v308 >= v309
            end
          end
        end
      end
    else
      table.insert(v307, n)
    end
  end

  local servicesAutoWash = v6.ServicesAutoWash

  if servicesAutoWash == nil then
    servicesAutoWash = f1("Toggle_Services_AutoWash")
  end

  local v318 = false

  if (p84 or servicesAutoWash) and #v307 > 0 then
    local v319, v320 = v13.InvokeServer("Wash", "GetWashableItems")

    if v319 and type(v320) == "table" and type(v320.items) == "table" and #v320.items > 0 then
      local v321 = {}

      for index30, value47 in ipairs(v320.items) do
        local v322 = tostring(value47.ItemId or value47.itemId
          or value47.data and value47.data.ItemId or "")

        if not (v7.QuestRequiredItemIds and v7.QuestRequiredItemIds[v322]) then
          local price = v23.GetItemPrice(value47)
          table.insert(v321, { item = value47, price = price })
        end
      end

      local servicesPrioritizeHighValue = v6.ServicesPrioritizeHighValue

      if servicesPrioritizeHighValue == nil then
        servicesPrioritizeHighValue = f1("Toggle_Services_PrioritizeHighValue")
      end

      if servicesPrioritizeHighValue ~= false then
        table.sort(v321, function(p85, p86) return p85.price > p86.price end)
      end

      for index31, value48 in ipairs(v307) do
        if #v321 == 0 then
          break
        end

        local v323 = table.remove(v321, 1)
        local item = v323.item

        local v324, v325 = v13.InvokeServer(
          "Wash", "StartWash", value48, item.guid, item.source, item.vehicleGUID
        )

        if v324 and (not v325 or v325.success ~= false) then
          slots[tostring(value48)] = v325 and v325.slotData or {
            ItemData = item.data or item,
            StartTime = getServerTimeNow,
            Duration = 15,
          }

          debug(
            "[ServiceHub] Wash: Started washing item %s ($%s) at slot %d", tostring(item.guid),
            v14.Number(v323.price), value48
          )
        end

        task.wait(0.25)
      end

      v318 = #v321 > 0
    end
  end

  local count8 = 0
  local v326 = {}

  for i6 = 1, v306 do
    local v327 = slots[tostring(i6)]

    if v327 then
      count8 = count8 + 1
      local name4 = v23.GetSlotItemName(v327)
      local v328 = (v327.StartTime or 0) + (v327.Duration or 0)
      local v329 = math.max(0, math.ceil(v328 - workspace:GetServerTimeNow()))
      local washed = (v327.Washed or v329 <= 0) and "Ready" or v329 .. "s"
      table.insert(v326, { slot = i6, name = name4, status = washed })
    end
  end

  v23.StationSlots.Wash = { total = v306, items = v326 }
  return count8, #v307, v318
end

function v23.RunRepair(p87)
  local v330, v331 = v13.InvokeServer("Repair", "GetSlotState")

  if not v330 or type(v331) ~= "table" then
    return 0, 0, false
  end

  local v332 = tonumber(v331.unlockedCount) or 1
  local slots2 = v331.slots or {}
  local getServerTimeNow2 = workspace:GetServerTimeNow()
  local v333 = {}
  local v334 = v11.GetInventoryCount()
  local v335 = v11.GetInventoryMax()
  local v336 = v335 > 0 and v334 >= v335

  for i7 = 1, v332 do
    local v337 = slots2[tostring(i7)]

    if v337 then
      if v337.Repaired == true then
        if not v336 then
          local v338, v339 = v13.InvokeServer("Repair", "ClaimRepairedItem", i7)

          if v338 and v339 and v339.success ~= false then
            debug("[ServiceHub] Repair: Claimed repaired item at slot %d", i7)
            slots2[tostring(i7)] = nil
            table.insert(v333, i7)
            v334 = v334 + 1
            v336 = v335 > 0 and v334 >= v335
          end
        end
      elseif (v337.StartTime or 0) + (v337.Duration or 0) <= getServerTimeNow2 then
        if not v336 then
          local v340, v341 = v13.InvokeServer("Repair", "CollectRepair", i7)

          if v340 and v341 and v341.success ~= false then
            v337.Repaired = true
            task.wait(0.8)
            local v342, v343 = v13.InvokeServer("Repair", "ClaimRepairedItem", i7)

            if v342 and v343 and v343.success ~= false then
              debug("[ServiceHub] Repair: Completed & claimed item at slot %d", i7)
              slots2[tostring(i7)] = nil
              table.insert(v333, i7)
              v334 = v334 + 1
              v336 = v335 > 0 and v334 >= v335
            end
          end
        end
      end
    else
      table.insert(v333, i7)
    end
  end

  local servicesAutoRepair = v6.ServicesAutoRepair

  if servicesAutoRepair == nil then
    servicesAutoRepair = f1("Toggle_Services_AutoRepair")
  end

  local v344 = false

  if (p87 or servicesAutoRepair) and #v333 > 0 then
    local v345, v346 = v13.InvokeServer("Repair", "GetRepairableItems")

    if v345 and type(v346) == "table" and type(v346.items) == "table" and #v346.items > 0 then
      local v347 = {}

      for index32, value49 in ipairs(v346.items) do
        local v348 = tostring(value49.ItemId or value49.itemId
          or value49.data and value49.data.ItemId or "")

        if not (v7.QuestRequiredItemIds and v7.QuestRequiredItemIds[v348]) then
          local price2 = v23.GetItemPrice(value49)
          table.insert(v347, { item = value49, price = price2 })
        end
      end

      local servicesPrioritizeHighValue2 = v6.ServicesPrioritizeHighValue

      if servicesPrioritizeHighValue2 == nil then
        servicesPrioritizeHighValue2 = f1("Toggle_Services_PrioritizeHighValue")
      end

      if servicesPrioritizeHighValue2 ~= false then
        table.sort(v347, function(p88, p89) return p88.price > p89.price end)
      end

      for index33, value50 in ipairs(v333) do
        if #v347 == 0 then
          break
        end

        local v349 = table.remove(v347, 1)
        local item2 = v349.item

        local v350, v351 = v13.InvokeServer(
          "Repair", "StartRepair", value50, item2.guid, item2.source, item2.vehicleGUID
        )

        if v350 and (not v351 or v351.success ~= false) then
          slots2[tostring(value50)] = v351 and v351.slotData or {
            ItemData = item2.data or item2,
            StartTime = getServerTimeNow2,
            Duration = 30,
          }

          debug(
            "[ServiceHub] Repair: Started repairing item %s ($%s) at slot %d",
            tostring(item2.guid), v14.Number(v349.price), value50
          )
        end

        task.wait(0.25)
      end

      v344 = #v347 > 0
    end
  end

  local count9 = 0
  local v352 = {}

  for i8 = 1, v332 do
    local v353 = slots2[tostring(i8)]

    if v353 then
      count9 = count9 + 1
      local name5 = v23.GetSlotItemName(v353)
      local v354 = (v353.StartTime or 0) + (v353.Duration or 0)
      local v355 = math.max(0, math.ceil(v354 - workspace:GetServerTimeNow()))
      local repaired = (v353.Repaired or v355 <= 0) and "Ready" or v355 .. "s"
      table.insert(v352, { slot = i8, name = name5, status = repaired })
    end
  end

  v23.StationSlots.Repair = { total = v332, items = v352 }
  return count9, #v333, v344
end

function v23.RunGrading(p90)
  local v356, v357 = v13.InvokeServer("Grading", "GetSlotState")

  if not v356 or type(v357) ~= "table" then
    return
  end

  local v358 = tonumber(v357.unlockedCount) or 1
  local slots3 = v357.slots or {}
  local getServerTimeNow3 = workspace:GetServerTimeNow()
  local v359 = {}
  local v360 = v11.GetInventoryCount()
  local v361 = v11.GetInventoryMax()
  local v362 = v361 > 0 and v360 >= v361

  for i9 = 1, v358 do
    local v363 = slots3[tostring(i9)]

    if v363 then
      if v363.Grade then
        if not v362 then
          v13.InvokeServer("Grading", "ClaimGradedItem", i9)

          debug(
            "[ServiceHub] Grading: Claimed graded item (%s) at slot %d", tostring(v363.Grade),
            i9
          )

          slots3[tostring(i9)] = nil
          table.insert(v359, i9)
          v360 = v360 + 1
          v362 = v361 > 0 and v360 >= v361
        end
      elseif (v363.StartTime or 0) + (v363.Duration or 0) <= getServerTimeNow3 then
        if not v362 then
          v13.InvokeServer("Grading", "CollectGrade", i9)
          task.wait(0.2)
          v13.InvokeServer("Grading", "ClaimGradedItem", i9)
          debug("[ServiceHub] Grading: Completed & claimed item at slot %d", i9)
          slots3[tostring(i9)] = nil
          table.insert(v359, i9)
          v360 = v360 + 1
          v362 = v361 > 0 and v360 >= v361
        end
      end
    else
      table.insert(v359, i9)
    end
  end

  local servicesAutoGrade = v6.ServicesAutoGrade

  if servicesAutoGrade == nil then
    servicesAutoGrade = f1("Toggle_Services_AutoGrade")
  end

  if (p90 or servicesAutoGrade) and #v359 > 0 then
    local v364, v365 = v13.InvokeServer("Grading", "GetGradableItems")

    if v364 and type(v365) == "table" and type(v365.items) == "table" and #v365.items > 0 then
      local v366 = {}

      for index34, value51 in ipairs(v365.items) do
        local price3 = v23.GetItemPrice(value51)
        local isUtility = v23.IsUtilityItem(value51)
        table.insert(v366, { item = value51, price = price3, isUtility = isUtility })
      end

      local servicesPrioritizeUtilityGrading = v6.ServicesPrioritizeUtilityGrading

      if servicesPrioritizeUtilityGrading == nil then
        servicesPrioritizeUtilityGrading = f1("Toggle_Services_PrioritizeUtilityGrading")
      end

      local servicesPrioritizeHighValue3 = v6.ServicesPrioritizeHighValue

      if servicesPrioritizeHighValue3 == nil then
        servicesPrioritizeHighValue3 = f1("Toggle_Services_PrioritizeHighValue")
      end

      table.sort(v366, function(p91, p92)
        if servicesPrioritizeUtilityGrading ~= false and p91.isUtility ~= p92.isUtility then
          return p91.isUtility and not p92.isUtility
        end

        if servicesPrioritizeHighValue3 ~= false and p91.price ~= p92.price then
          return p91.price > p92.price
        end

        return false
      end)

      for index35, value52 in ipairs(v359) do
        if #v366 == 0 then
          break
        end

        local v367 = table.remove(v366, 1)
        local item3 = v367.item

        local v368, v369 = v13.InvokeServer(
          "Grading", "StartGrading", value52, item3.guid, item3.source, item3.vehicleGUID
        )

        if v368 and (not v369 or v369.success ~= false) then
          slots3[tostring(value52)] = v369 and v369.slotData or {
            ItemData = item3.data or item3,
            StartTime = getServerTimeNow3,
            Duration = 60,
          }

          debug(
            "[ServiceHub] Grading: Started grading item %s ($%s, utility=%s) at slot %d",
            tostring(item3.guid), v14.Number(v367.price), tostring(v367.isUtility), value52
          )
        end

        task.wait(0.25)
      end
    end
  end

  local v370 = {}

  for i10 = 1, v358 do
    local v371 = slots3[tostring(i10)]

    if v371 then
      local name6 = v23.GetSlotItemName(v371)
      local v372 = (v371.StartTime or 0) + (v371.Duration or 0)
      local v373 = math.max(0, math.ceil(v372 - workspace:GetServerTimeNow()))
      local grade = (v371.Grade or v373 <= 0) and "Ready" or v373 .. "s"
      table.insert(v370, { slot = i10, name = name6, status = grade })
    end
  end

  v23.StationSlots.Grading = { total = v358, items = v370 }
end

function v23.RunLocksmith(p93)
  local v374, v375 = v13.InvokeServer("Locksmith", "GetSlotState")

  if not v374 or type(v375) ~= "table" then
    return
  end

  local v376 = tonumber(v375.unlockedCount) or 1
  local slots4 = v375.slots or {}
  local getServerTimeNow4 = workspace:GetServerTimeNow()
  local v377 = {}
  local v378 = v11.GetInventoryCount()
  local v379 = v11.GetInventoryMax()
  local v380 = v379 > 0 and v378 >= v379

  for i11 = 1, v376 do
    local v381 = slots4[tostring(i11)]

    if v381 then
      if v381.RewardItemId or v381.RewardDiamonds and v381.RewardDiamonds > 0
        or v381.RewardGoldNuggets and v381.RewardGoldNuggets > 0 then
        if not v380 then
          v13.InvokeServer("Locksmith", "ClaimItem", i11)
          debug("[ServiceHub] Locksmith: Claimed cracked safe rewards at slot %d", i11)
          slots4[tostring(i11)] = nil
          table.insert(v377, i11)
          v378 = v378 + 1
          v380 = v379 > 0 and v378 >= v379
        end
      elseif (v381.StartTime or 0) + (v381.Duration or 0) <= getServerTimeNow4 then
        if not v380 then
          v13.InvokeServer("Locksmith", "OpenSafe", i11)
          task.wait(0.25)
          v13.InvokeServer("Locksmith", "ClaimItem", i11)
          debug("[ServiceHub] Locksmith: Opened safe & claimed rewards at slot %d", i11)
          slots4[tostring(i11)] = nil
          table.insert(v377, i11)
          v378 = v378 + 1
          v380 = v379 > 0 and v378 >= v379
        end
      end
    else
      table.insert(v377, i11)
    end
  end

  local servicesAutoCrackSafes = v6.ServicesAutoCrackSafes

  if servicesAutoCrackSafes == nil then
    servicesAutoCrackSafes = f1("Toggle_Services_AutoCrackSafes")
  end

  if (p93 or servicesAutoCrackSafes) and #v377 > 0 then
    local v382, v383 = v13.InvokeServer("Locksmith", "GetLockableItems")

    if v382 and type(v383) == "table" and type(v383.items) == "table" and #v383.items > 0 then
      local toggleServicesCrackOnlyGradedSafes = (p93 and { false }
        or { v6.ServicesCrackOnlyGradedSafes ~= false })[1]

      if not p93 and toggleServicesCrackOnlyGradedSafes == nil then
        toggleServicesCrackOnlyGradedSafes = f1("Toggle_Services_CrackOnlyGradedSafes")
      end

      local v384 = {}

      for index36, value53 in ipairs(v383.items) do
        local data3 = value53.data or value53.ItemData or value53

        local v385 = data3 and data3.Grade ~= nil and data3.Grade ~= ""
          or value53.Grade ~= nil and value53.Grade ~= ""

        if not (toggleServicesCrackOnlyGradedSafes ~= false and not v385) then
          local price4 = v23.GetItemPrice(value53)
          table.insert(v384, { item = value53, price = price4, hasGrade = v385 })
        end
      end

      table.sort(v384, function(p94, p95)
        if p94.hasGrade ~= p95.hasGrade then
          return p94.hasGrade and not p95.hasGrade
        end

        return p94.price > p95.price
      end)

      for index37, value54 in ipairs(v377) do
        if #v384 == 0 then
          break
        end

        local item4 = table.remove(v384, 1).item

        local v386, v387 = v13.InvokeServer(
          "Locksmith", "StartLocksmith", value54, item4.guid, item4.source, item4.vehicleGUID
        )

        if v386 and (not v387 or v387.success ~= false) then
          slots4[tostring(value54)] = v387 and v387.slotData or {
            ItemData = item4.data or item4,
            SafeId = item4.data and item4.data.SafeId,
            StartTime = getServerTimeNow4,
            Duration = 45,
          }

          debug(
            "[ServiceHub] Locksmith: Started cracking safe %s at slot %d", tostring(item4.guid),
            value54
          )
        end

        task.wait(0.25)
      end
    end
  end

  local v388 = {}

  for i12 = 1, v376 do
    local v389 = slots4[tostring(i12)]

    if v389 then
      local name7 = v23.GetSlotItemName(v389)
      local v390 = (v389.StartTime or 0) + (v389.Duration or 0)
      local v391 = math.max(0, math.ceil(v390 - workspace:GetServerTimeNow()))
      local rewardItemId = (v389.RewardItemId or v391 <= 0) and "Ready" or v391 .. "s"
      table.insert(v388, { slot = i12, name = name7, status = rewardItemId })
    end
  end

  v23.StationSlots.Locksmith = { total = v376, items = v388 }
end

function v23.RunTimeCapsule()
  local v392, v393 = v13.InvokeServer("TimeCapsule", "GetSlotStates")

  if not v392 or type(v393) ~= "table" then
    return
  end

  local v394 = {}
  local v395 = {}
  local v396 = 0

  for key20, value55 in pairs(v393) do
    local v397 = tonumber(key20) or 1

    if v397 > v396 then
      v396 = v397
    end

    if type(value55) == "table" then
      local v398 = tonumber(value55.TimeLeft or value55.timeLeft) or 0

      if value55.Guid or value55.guid then
        if v398 <= 0 or value55.Completed or value55.completed then
          v13.InvokeServer("TimeCapsule", "CollectItem", v397)
          table.insert(v394, v397)
          table.insert(v395, { slot = v397, name = "Claimed", status = "Ready" })
        else
          local name8 = v23.GetSlotItemName(value55)
          local v399 = string.format("%ds", math.max(0, math.floor(v398)))
          table.insert(v395, { slot = v397, name = name8, status = v399 })
        end
      else
        table.insert(v394, v397)
      end
    else
      table.insert(v394, v397)
    end
  end

  v23.StationSlots.TimeCapsule = { total = math.max(1, v396), items = v395 }

  if #v394 > 0 then
    local v400, v401 = v13.InvokeServer("TimeCapsule", "GetCapsuleableItems")

    if v400 and type(v401) == "table" and #v401 > 0 then
      local v402 = {}

      for index38, value56 in ipairs(v401) do
        local guid = value56.Guid or value56.guid
        local data4 = value56.Data or value56.data or value56

        if guid and not (data4 and (data4.Mutator or data4.mutator)) then
          local price5 = v23.GetItemPrice(value56)
          table.insert(v402, { guid = guid, price = price5 })
        end
      end

      table.sort(v402, function(p96, p97) return p96.price > p97.price end)

      for i13 = 1, math.min(#v394, #v402) do
        v13.InvokeServer("TimeCapsule", "PlaceItem", v394[i13], v402[i13].guid)
        task.wait(0.2)
      end
    end
  end
end

function v23.ProcessLoop()
  local servicesAutoWash2 = v6.ServicesAutoWash

  if servicesAutoWash2 == nil then
    servicesAutoWash2 = f1("Toggle_Services_AutoWash")
  end

  local servicesAutoRepair2 = v6.ServicesAutoRepair

  if servicesAutoRepair2 == nil then
    servicesAutoRepair2 = f1("Toggle_Services_AutoRepair")
  end

  local servicesAutoGrade2 = v6.ServicesAutoGrade

  if servicesAutoGrade2 == nil then
    servicesAutoGrade2 = f1("Toggle_Services_AutoGrade")
  end

  local servicesAutoCrackSafes2 = v6.ServicesAutoCrackSafes

  if servicesAutoCrackSafes2 == nil then
    servicesAutoCrackSafes2 = f1("Toggle_Services_AutoCrackSafes")
  end

  local servicesAutoTimeCapsule = v6.ServicesAutoTimeCapsule

  if servicesAutoTimeCapsule == nil then
    servicesAutoTimeCapsule = f1("Toggle_Services_AutoTimeCapsule")
  end

  if servicesAutoWash2 then
    pcall(v23.RunWash)
  end

  if servicesAutoRepair2 then
    pcall(v23.RunRepair)
  end

  if servicesAutoGrade2 then
    pcall(v23.RunGrading)
  end

  if servicesAutoCrackSafes2 then
    pcall(v23.RunLocksmith)
  end

  if servicesAutoTimeCapsule then
    pcall(v23.RunTimeCapsule)
  end

  v23.UpdateStatusParagraph()
end

function v23.UpdateStatusParagraph()
  if not v9.ServicesStatus then
    return
  end

  local v403 = v23.FormatStationLine("Wash", v23.StationSlots.Wash)
  local v404 = v23.FormatStationLine("Repair", v23.StationSlots.Repair)
  local v405 = v23.FormatStationLine("Grading", v23.StationSlots.Grading)
  local v406 = v23.FormatStationLine("Locksmith", v23.StationSlots.Locksmith)
  local v407 = v23.FormatStationLine("Time Capsule", v23.StationSlots.TimeCapsule)

  local v408 = string.format([[
%s
%s
%s
%s
%s]], v403, v404, v405, v406, v407)

  f2(v9.ServicesStatus, v408)
end

function v24.GetDailyRewardStatus()
  return localPlayer:GetAttribute("DailyRewardDay") or 1, localPlayer:GetAttribute("DailyRewardClaimable") == true
end

function v24.ClaimDailyReward()
  local v409, v410 = v24.GetDailyRewardStatus()

  if not v410 then
    return false
  end

  local v411, v412 = v13.InvokeServer("DailyReward", "ClaimDailyReward")

  if v411 and type(v412) == "table" and v412.success ~= false then
    debug(
      "[Rewards] Successfully claimed Day %s daily login reward", tostring(v412.day or v409)
    )

    return true
  end

  return false
end

function v24.ClaimAchievements()
  local v413, v414 = v13.InvokeServer("Achievements", "GetAchievementStatus")

  if not v413 or type(v414) ~= "table" then
    return 0
  end

  local count10 = 0

  for key21, value57 in pairs(v414) do
    if type(value57) == "table" and value57.Status == "claimable" then
      local v415, v416 = v13.InvokeServer("Achievements", "ClaimAchievementReward", key21)

      if v415 and type(v416) == "table" and v416.ok then
        count10 = count10 + 1

        debug(
          "[Rewards] Claimed achievement: %s (Reward: %s)", tostring(key21),
          tostring(v416.reward or "?")
        )
      end

      task.wait(0.25)
    end
  end

  return count10
end

function v24.ClaimCollections()
  local v417, v418 = v13.InvokeServer("Collections", "GetCollectionState")

  if not v417 or type(v418) ~= "table" then
    return 0
  end

  local discovered = v418.discovered or {}
  local areaCatalog = v418.areaCatalog or {}
  local milestones = v418.milestones or {}
  local v419 = nil
  pcall(function() v419 = require(replicatedStorage.Modules.Collections) end)
  local count11 = 0

  for key22, value58 in pairs(areaCatalog) do
    if type(value58) == "table" and #value58 > 0 then
      local v420 = #value58
      local count12 = 0

      for index39, value59 in ipairs(value58) do
        if discovered[value59] then
          count12 = count12 + 1
        end
      end

      local v421 = key22 .. ":Base"
      local newClaimedCount = milestones[v421] or 0
      local v422 = 0

      if v419 and v419.GetEligibleMilestoneCount then
        v422 = v419.GetEligibleMilestoneCount(count12, v420, key22) or 0
      elseif count12 >= 5 then
        v422 = (count12 < 55 and { math.floor((count12 - 5) / 10) + 1 }
          or { math.floor((count12 - 55) / 15) + 6 })[1]
      end

      while newClaimedCount < v422 do
        local v423, v424 = v13.InvokeServer("Collections", "ClaimMilestoneReward", key22)

        if v423 and type(v424) == "table" and v424.success then
          newClaimedCount = v424.newClaimedCount or newClaimedCount + 1
          milestones[v421] = newClaimedCount
          count11 = count11 + 1

          debug(
            "[Rewards] Claimed collection milestone: %s (Count: %s)", tostring(key22),
            tostring(newClaimedCount)
          )

          task.wait(0.2)
        else
          break
        end
      end
    end
  end

  return count11
end

v25.UpgradeDisplayNames = {
  "Inventory Space", "Selling Space", "Advertising", "Tip Jar", "Price Tags", "Trophy Capacity",
  "Storage Box Space", "Plot Capacity", "Shop Floors", "Celebrity Customers",
}

local v425 = {
  ["Inventory Space"] = { "InventorySpace" },
  ["Selling Space"] = { "SellingSlots" },
  Advertising = { "Advertising" },
  ["Tip Jar"] = { "TipJar" },
  ["Price Tags"] = { "PriceTags" },
  ["Trophy Capacity"] = { "TrophyCapacity" },
  ["Storage Box Space"] = { "StorageBoxCapacity" },
  ["Plot Capacity"] = { "PlotItemLimit" },
  ["Shop Floors"] = { "SecondFloor", "ThirdFloor", "FourthFloor", "FifthFloor" },
  ["Celebrity Customers"] = { "CelebritySpawns" },
}

v25.FallbackCatalog = {
  InventorySpace = {
    name = "Inventory Space",
    tiers = {
      { cost = 5 }, { cost = 10 }, { cost = 20 }, { cost = 35 }, { cost = 50 }, { cost = 60 },
      { cost = 75 }, { cost = 100 }, { cost = 125 }, { cost = 150 }, { cost = 175 },
      { cost = 200 }, { cost = 200 }, { cost = 200 }, { cost = 200 }, { cost = 200 },
      { cost = 200 }, { cost = 200 },
    },
  },
  SellingSlots = {
    name = "Selling Space",
    tiers = {
      { cost = 10 }, { cost = 20 }, { cost = 30 }, { cost = 45 }, { cost = 60 }, { cost = 75 },
      { cost = 90 }, { cost = 110 }, { cost = 140 }, { cost = 170 }, { cost = 200 },
      { cost = 200 }, { cost = 200 }, { cost = 250 }, { cost = 250 }, { cost = 250 },
      { cost = 300 }, { cost = 300 },
    },
  },
  Advertising = {
    name = "Advertising",
    minNetWorth = 3000,
    tiers = { { cost = 20 }, { cost = 40 }, { cost = 90 }, { cost = 180 }, { cost = 280 } },
  },
  TipJar = {
    name = "Tip Jar",
    tiers = { { cost = 15 }, { cost = 60 }, { cost = 125 }, { cost = 225 } },
  },
  PriceTags = { name = "Price Tags", tiers = { { cost = 45 }, { cost = 100 } } },
  TrophyCapacity = {
    name = "Trophy Capacity",
    minNetWorth = 5000,
    tiers = { { cost = 45 }, { cost = 95 } },
  },
  StorageBoxCapacity = {
    name = "Storage Box Space",
    minNetWorth = 5000,
    tiers = {
      { cost = 10 }, { cost = 20 }, { cost = 45 }, { cost = 70 }, { cost = 100 },
      { cost = 125 }, { cost = 150 }, { cost = 200 }, { cost = 225 }, { cost = 250 },
      { cost = 250 }, { cost = 250 }, { cost = 250 }, { cost = 250 }, { cost = 250 },
      { cost = 250 }, { cost = 250 }, { cost = 250 }, { cost = 250 }, { cost = 250 },
      { cost = 250 }, { cost = 250 }, { cost = 250 },
    },
  },
  PlotItemLimit = {
    name = "Plot Capacity",
    tiers = {
      { cost = 25, minNetWorth = 10000 }, { cost = 50, minNetWorth = 25000 },
      { cost = 75, minNetWorth = 50000 }, { cost = 100, minNetWorth = 100000 },
      { cost = 125, minNetWorth = 150000 }, { cost = 150, minNetWorth = 250000 },
      { cost = 250, minNetWorth = 400000 }, { cost = 250, minNetWorth = 600000 },
      { cost = 250, minNetWorth = 800000 }, { cost = 250, minNetWorth = 1000000 },
      { cost = 250, minNetWorth = 1000000 }, { cost = 250, minNetWorth = 1000000 },
      { cost = 250, minNetWorth = 1000000 }, { cost = 250, minNetWorth = 1000000 },
      { cost = 250, minNetWorth = 1000000 }, { cost = 250, minNetWorth = 1000000 },
      { cost = 250, minNetWorth = 1000000 }, { cost = 250, minNetWorth = 1000000 },
      { cost = 250, minNetWorth = 1000000 }, { cost = 250, minNetWorth = 1000000 },
      { cost = 250, minNetWorth = 1000000 }, { cost = 250, minNetWorth = 1000000 },
      { cost = 250, minNetWorth = 1000000 }, { cost = 250, minNetWorth = 1000000 },
      { cost = 250, minNetWorth = 1000000 }, { cost = 250, minNetWorth = 1000000 },
    },
  },
  SecondFloor = {
    name = "Second Floor",
    floorLimit = 2,
    minNetWorth = 25000,
    tiers = { { cost = 250 } },
  },
  ThirdFloor = {
    name = "Third Floor",
    floorLimit = 3,
    minNetWorth = 25000,
    requiresUpgrade = "SecondFloor",
    tiers = { { cost = 250 } },
  },
  FourthFloor = {
    name = "Fourth Floor",
    floorLimit = 4,
    minNetWorth = 25000,
    requiresUpgrade = "ThirdFloor",
    tiers = { { cost = 250 } },
  },
  FifthFloor = {
    name = "Fifth Floor",
    floorLimit = 5,
    minNetWorth = 25000,
    requiresUpgrade = "FourthFloor",
    tiers = { { cost = 250 } },
  },
  CelebritySpawns = {
    name = "Celebrity Customers",
    minNetWorth = 1000,
    tiers = { { cost = 25 }, { cost = 50 }, { cost = 150 }, { cost = 250 }, { cost = 350 } },
  },
}

function v25.GetUpgradeInfo(p98, p99)
  p99 = p99 or {}
  local v426 = p99[p98] or 0
  local v427 = nil

  if v25.RawConfig and v25.RawConfig.Upgrades then
    for index40, value60 in ipairs(v25.RawConfig.Upgrades) do
      if value60.id == p98 then
        v427 = value60
        break
      end
    end
  end

  if not v427 then
    v427 = v25.FallbackCatalog[p98]
  end

  if not v427 then
    return nil
  end

  local maxLevel = v427.maxLevel or v427.tiers and #v427.tiers or 1

  if v426 >= maxLevel then
    return { isMaxed = true, name = v427.name or p98 }
  end

  if p98 == "CelebritySpawns" and localPlayer:GetAttribute("CelebrityCustomers") == true then
    return { isMaxed = true, name = v427.name or p98 }
  end

  if v427.requiresUpgrade then
    if (p99[v427.requiresUpgrade] or 0) < 1 then
      return {
        isLocked = true,
        reason = "Requires " .. tostring(v427.requiresUpgrade),
        name = v427.name or p98,
      }
    end
  end

  local v428 = v426 + 1
  local tiers = v427.tiers and v427.tiers[v428]

  if not tiers and not v427.floorLimit then
    return { isMaxed = true, name = v427.name or p98 }
  end

  local cost = tiers and tiers.cost or v427.floorLimit and 250 or 0
  local minNetWorth2 = tiers and tiers.minNetWorth or v427.minNetWorth or 0

  return {
    id = p98,
    name = v427.name or p98,
    cost = cost,
    minNetWorth = minNetWorth2,
    currentTier = v426,
    nextTier = v428,
    maxTier = maxLevel,
  }
end

function v25.GetUpgradesState()
  local v429, v430 = v13.InvokeServer("Upgrades", "GetUpgrades")

  if v429 and type(v430) == "table" then
    v7.UserUpgrades = v430
    return v430
  end

  return v7.UserUpgrades or {}
end

function v25.RunAutoUpgrade()
  local shopTargetUpgrades = v6.ShopTargetUpgrades

  if shopTargetUpgrades == nil then
    shopTargetUpgrades = f1("Dropdown_Shop_TargetUpgrades")
  end

  if shopTargetUpgrades == nil then
    shopTargetUpgrades = v6.FarmUpgradesTargetUpgrades
      or f1("Dropdown_Farm_UpgradesTargetUpgrades")
  end

  if type(shopTargetUpgrades) ~= "table" then
    return 0
  end

  local v431 = v11.GetDiamonds()

  if v431 <= 0 then
    return 0
  end

  local v432 = v11.GetNetWorth()
  local v433 = v25.GetUpgradesState()
  local count13 = 0

  for index41, value61 in ipairs(v25.UpgradeDisplayNames) do
    if v18.IsSelected(shopTargetUpgrades, value61) then
      for index42, value62 in ipairs(v425[value61] or { value61 }) do
        if v431 <= 0 then
          break
        end

        local v434 = v25.GetUpgradeInfo(value62, v433)

        if v434 and not v434.isMaxed and not v434.isLocked then
          if v432 >= v434.minNetWorth and v431 >= v434.cost then
            debug(
              "[Upgrades] Purchasing %s (Tier %d/%d) for %d Diamonds...", v434.name,
              v434.nextTier, v434.maxTier, v434.cost
            )

            local v435, v436 = v13.InvokeServer("Upgrades", "BuyUpgrade", value62)

            if v435 and type(v436) == "table" and v436.success then
              count13 = count13 + 1
              v431 = v431 - v434.cost
              v433[value62] = v436.level or v434.nextTier

              debug(
                "[Upgrades] Successfully bought %s! New level: %d, Remaining diamonds: %d",
                v434.name, v433[value62], v431
              )

              v1:Notify({
                Title = "Upgrade Purchased",
                Content = string.format(
                  "Upgraded %s to Tier %d (%d Diamonds)", v434.name, v433[value62], v434.cost
                ),
                Duration = 4,
              })

              task.wait(0.3)
            else
              debug(
                "[Upgrades] Failed to buy %s: %s", v434.name,
                tostring(v436 and v436.error or v436)
              )
            end
          end
        end
      end
    end
  end

  return count13
end

function v25.GetStaffData()
  local v437, v438 = v13.InvokeServer("Staff", "GetStaffData")

  if v437 and type(v438) == "table" then
    v7.StaffData = v438
    return v438
  end

  return v7.StaffData or {}
end

function v25.RunStaffAutomation()
  local shopAutoHireStaff = v6.ShopAutoHireStaff

  if shopAutoHireStaff == nil then
    shopAutoHireStaff = f1("Toggle_Shop_AutoHireStaff")
  end

  if shopAutoHireStaff == nil then
    shopAutoHireStaff = v6.FarmAutoHireStaff or f1("Toggle_Farm_AutoHireStaff")
  end

  local shopAutoUpgradeStaff = v6.ShopAutoUpgradeStaff

  if shopAutoUpgradeStaff == nil then
    shopAutoUpgradeStaff = f1("Toggle_Shop_AutoUpgradeStaff")
  end

  if shopAutoUpgradeStaff == nil then
    shopAutoUpgradeStaff = v6.FarmAutoUpgradeStaff or f1("Toggle_Farm_AutoUpgradeStaff")
  end

  local v439 = v11.GetDiamonds()
  local v440 = v25.GetStaffData()
  local count14 = 0
  local v441, v442 = nil, nil

  for key23, value63 in pairs(v440) do
    if value63.Type == "ShopAssistant" then
      v441 = key23
      v442 = value63
      break
    end
  end

  if not v441 and shopAutoHireStaff then
    if v439 >= 100 then
      debug("[Staff] Hiring Shop Assistant for %d Diamonds...", 100)
      local v443, v444 = v13.InvokeServer("Staff", "HireStaff", "ShopAssistant")

      if v443 and v444 ~= false then
        count14 = count14 + 1
        v439 = v439 - 100
        debug("[Staff] Successfully hired Shop Assistant!")

        v1:Notify({
          Title = "Staff Hired",
          Content = "Hired Shop Assistant (100 Diamonds)",
          Duration = 4,
        })

        task.wait(0.5)
        v440 = v25.GetStaffData()

        for key24, value64 in pairs(v440) do
          if value64.Type == "ShopAssistant" then
            v441 = key24
            v442 = value64
            break
          end
        end
      end
    end
  end

  if v441 and v442 then
    local shopStaffMinOfferPercent = v6.ShopStaffMinOfferPercent

    if shopStaffMinOfferPercent == nil then
      shopStaffMinOfferPercent = f1("Slider_Shop_StaffMinOfferPercent")
    end

    if shopStaffMinOfferPercent == nil then
      shopStaffMinOfferPercent = v6.FarmStaffMinOfferPercent
        or f1("Slider_Farm_StaffMinOfferPercent") or 105
    end

    shopStaffMinOfferPercent = tonumber(shopStaffMinOfferPercent) or 105

    if v442.MinOfferPercent ~= shopStaffMinOfferPercent then
      v13.FireServer("Staff", "UpdateStaffConfig", v441, {
        MinOfferPercent = shopStaffMinOfferPercent,
      })

      v442.MinOfferPercent = shopStaffMinOfferPercent
    end
  end

  if v441 and v442 and shopAutoUpgradeStaff then
    local v445 = { 5, 5, 5, 10, 10 }
    local v446 = { 15, 20, 25, 30, 35 }
    local speedLevel = v442.SpeedLevel or 0

    if speedLevel < 5 then
      local v447 = v445[speedLevel + 1] or 10

      if v439 >= v447 then
        debug(
          "[Staff] Upgrading Walk Speed (Lv %d -> %d) for %d Diamonds...", speedLevel,
          speedLevel + 1, v447
        )

        local v448, v449 = v13.InvokeServer("Staff", "UpgradeStaff", v441, "WalkSpeed")

        if v448 and v449 ~= false then
          count14 = count14 + 1
          v439 = v439 - v447
          v442.SpeedLevel = speedLevel + 1

          v1:Notify({
            Title = "Staff Upgraded",
            Content = string.format(
              "Upgraded Walk Speed to Lv %d (%d Diamonds)", speedLevel + 1, v447
            ),
            Duration = 3,
          })

          task.wait(0.3)
        end
      end
    end

    local negotiationLevel = v442.NegotiationLevel or 0

    if negotiationLevel < 5 then
      local v450 = v446[negotiationLevel + 1] or 35

      if v439 >= v450 then
        debug(
          "[Staff] Upgrading Negotiation (Lv %d -> %d) for %d Diamonds...", negotiationLevel,
          negotiationLevel + 1, v450
        )

        local v451, v452 = v13.InvokeServer("Staff", "UpgradeStaff", v441, "Negotiation")

        if v451 and v452 ~= false then
          count14 = count14 + 1
          v439 = v439 - v450
          v442.NegotiationLevel = negotiationLevel + 1

          v1:Notify({
            Title = "Staff Upgraded",
            Content = string.format(
              "Upgraded Negotiation to Lv %d (%d Diamonds)", negotiationLevel + 1, v450
            ),
            Duration = 3,
          })

          task.wait(0.3)
        end
      end
    end
  end

  return count14
end

function v25.RunStationSlotsAutomation()
  local shopAutoUnlockStationSlots = v6.ShopAutoUnlockStationSlots

  if shopAutoUnlockStationSlots == nil then
    shopAutoUnlockStationSlots = f1("Toggle_Shop_AutoUnlockStationSlots")
  end

  if not shopAutoUnlockStationSlots then
    return 0
  end

  local v453 = v11.GetDiamonds()

  if v453 <= 0 then
    return 0
  end

  local v454 = v11.GetNetWorth()
  local count15 = 0

  for index43, value65 in ipairs({
    {
      name = "Wash",
      max = 3,
      costs = { [2] = 30, [3] = 90 },
      nwReq = { [2] = 10000, [3] = 50000 },
    },
    {
      name = "Repair",
      max = 3,
      costs = { [2] = 50, [3] = 150 },
      nwReq = {},
    },
    {
      name = "Locksmith",
      max = 3,
      costs = { [2] = 50, [3] = 150 },
      nwReq = { [2] = 10000, [3] = 50000 },
    },
    {
      name = "Grading",
      max = 3,
      costs = { [2] = 50, [3] = 150 },
      nwReq = { [2] = 10000, [3] = 50000 },
    },
  }) do
    local v455, v456 = v13.InvokeServer(value65.name, "GetSlotState")
    local v457 = v455 and type(v456) == "table" and tonumber(v456.unlockedCount) or 1

    if v457 < value65.max then
      local v458 = v457 + 1
      local v459 = value65.costs[v458] or 0

      if v454 >= (value65.nwReq[v458] or 0) and v453 >= v459 then
        debug("[Upgrades] Unlocking %s Slot %d for %d Diamonds...", value65.name, v458, v459)
        local v460, v461 = v13.InvokeServer(value65.name, "UnlockSlot", v458)

        if v460 and (v461 == true or type(v461) == "table" and v461.success) then
          count15 = count15 + 1
          v453 = v453 - v459
          debug("[Upgrades] Successfully unlocked %s Slot %d!", value65.name, v458)

          v1:Notify({
            Title = "Station Slot Unlocked",
            Content = string.format(
              "Unlocked %s Slot %d (%d Diamonds)", value65.name, v458, v459
            ),
            Duration = 4,
          })

          task.wait(0.3)
        end
      end
    end
  end

  return count15
end

local v462 = {
  {
    id = "Wrench1",
    name = "Basic Wrench",
    price = 75,
    minNw = 500,
  },
  {
    id = "Wrench2",
    name = "Steel Wrench",
    price = 750,
    minNw = 5000,
  },
  {
    id = "Wrench3",
    name = "Precision Wrench",
    price = 10000,
    minNw = 75000,
  },
  {
    id = "Wrench4",
    name = "Master Wrench",
    price = 100000,
    minNw = 550000,
  },
  {
    id = "Wrench5",
    name = "Turbo Wrench",
    price = 500000,
    minNw = 1250000,
  },
  {
    id = "Wrench6",
    name = "Ratchet Wrench",
    price = 2500000,
    minNw = 6000000,
  },
  {
    id = "Wrench7",
    name = "Carbon Wrench",
    price = 12500000,
    minNw = 30000000,
  },
  {
    id = "Wrench8",
    name = "Pneumatic Wrench",
    price = 60000000,
    minNw = 150000000,
  },
}

function v25.RunWrenchAutomation()
  local shopAutoBuyBestWrench = v6.ShopAutoBuyBestWrench

  if shopAutoBuyBestWrench == nil then
    shopAutoBuyBestWrench = f1("Toggle_Shop_AutoBuyBestWrench")
  end

  if not shopAutoBuyBestWrench then
    return false
  end

  local v463, v464 = v13.InvokeServer("WrenchShop", "GetState")
  local owned = v463 and type(v464) == "table" and v464.owned or {}
  local equipped = v463 and type(v464) == "table" and v464.equipped or nil
  local v465 = v11.GetCash()
  local v466 = v11.GetNetWorth()
  local v467 = nil

  for index44, value66 in ipairs(v462) do
    if v466 >= value66.minNw and (owned[value66.id] or v465 >= value66.price) then
      v467 = value66
    end
  end

  if not v467 then
    return false
  end

  if not owned[v467.id] then
    if v465 >= v467.price then
      debug("[Upgrades] Buying best wrench: %s ($%s)...", v467.name, v14.Number(v467.price))
      local v468, v469 = v13.InvokeServer("WrenchShop", "BuyWrench", v467.id)

      if v468 and (v469 == true or type(v469) == "table" and v469.success) then
        debug("[Upgrades] Successfully bought %s!", v467.name)

        v1:Notify({
          Title = "Wrench Purchased",
          Content = string.format("Bought %s ($%s)", v467.name, v14.Number(v467.price)),
          Duration = 4,
        })

        task.wait(0.3)
        v13.InvokeServer("WrenchShop", "EquipWrench", v467.id)
        return true
      end
    end
  elseif equipped ~= v467.id then
    v13.InvokeServer("WrenchShop", "EquipWrench", v467.id)
    return true
  end

  return false
end

local v470 = {
  {
    id = "Picklock1",
    name = "Basic Lockpick",
    price = 250,
    minNw = 500,
  },
  {
    id = "Picklock2",
    name = "Steel Lockpick",
    price = 1000,
    minNw = 3500,
  },
  {
    id = "Picklock3",
    name = "Precision Lockpick",
    price = 15000,
    minNw = 95000,
  },
  {
    id = "Picklock4",
    name = "Master Lockpick",
    price = 150000,
    minNw = 450000,
  },
}

function v25.RunLockpickAutomation()
  local shopAutoBuyBestLockpick = v6.ShopAutoBuyBestLockpick

  if shopAutoBuyBestLockpick == nil then
    shopAutoBuyBestLockpick = f1("Toggle_Shop_AutoBuyBestLockpick")
  end

  if not shopAutoBuyBestLockpick then
    return false
  end

  local v471, v472 = v13.InvokeServer("LockpickShop", "GetState")
  local owned2 = v471 and type(v472) == "table" and v472.owned or {}
  local equipped2 = v471 and type(v472) == "table" and v472.equipped or nil
  local v473 = v11.GetCash()
  local v474 = v11.GetNetWorth()
  local v475 = nil

  for index45, value67 in ipairs(v470) do
    if v474 >= value67.minNw and (owned2[value67.id] or v473 >= value67.price) then
      v475 = value67
    end
  end

  if not v475 then
    return false
  end

  if not owned2[v475.id] then
    if v473 >= v475.price then
      debug("[Upgrades] Buying best lockpick: %s ($%s)...", v475.name, v14.Number(v475.price))
      local v476, v477 = v13.InvokeServer("LockpickShop", "BuyLockpick", v475.id)

      if v476 and (v477 == true or type(v477) == "table" and v477.success) then
        debug("[Upgrades] Successfully bought %s!", v475.name)

        v1:Notify({
          Title = "Lockpick Purchased",
          Content = string.format("Bought %s ($%s)", v475.name, v14.Number(v475.price)),
          Duration = 4,
        })

        task.wait(0.3)
        v13.InvokeServer("LockpickShop", "EquipLockpick", v475.id)
        return true
      end
    end
  elseif equipped2 ~= v475.id then
    v13.InvokeServer("LockpickShop", "EquipLockpick", v475.id)
    return true
  end

  return false
end

function v25.UpdateShopOverview()
  if not v9.ShopOverview then
    return
  end

  local v478 = v25.GetUpgradesState()
  local v479 = 10 + (tonumber(v478.InventorySpace) or 0) * 5
  local v480 = 4 + (tonumber(v478.SellingSlots) or 0) * 2
  local v481 = 1

  if v478.FifthFloor and v478.FifthFloor > 0 then
    v481 = 5
  elseif v478.FourthFloor and v478.FourthFloor > 0 then
    v481 = 4
  elseif v478.ThirdFloor and v478.ThirdFloor > 0 then
    v481 = 3
  elseif v478.SecondFloor and v478.SecondFloor > 0 then
    v481 = 2
  end

  local v482 = v25.GetStaffData()
  local v483 = nil

  for key25, value68 in pairs(v482) do
    if value68.Type == "ShopAssistant" then
      v483 = value68
      break
    end
  end

  local v484 = v483 and "#4CAF50" or "#8A9AA8"
  local v485 = v483 and "Active" or "Not Hired"
  local speedLevel2 = 0
  local negotiationLevel2 = 0
  local minOfferPercent = 105

  if v483 then
    speedLevel2 = v483.SpeedLevel or 0
    negotiationLevel2 = v483.NegotiationLevel or 0
    minOfferPercent = v483.MinOfferPercent or 105
  end

  local wash = v23.StationSlots.Wash and 1 or 1
  local repair = v23.StationSlots.Repair and 1 or 1
  local locksmith = v23.StationSlots.Locksmith and 1 or 1
  local grading = v23.StationSlots.Grading and 1 or 1

  local v486 = string.format([[
Capacity: Inv <font color="#00E5FF">%d</font> | Selling <font color="#FFD54F">%d</font> | Floor <font color="#FFA726">%d</font>
Staff: <font color="%s"><b>%s</b></font> | Speed <font color="#00E5FF">Lv %d/5</font> | Negot <font color="#FFD54F">Lv %d/5</font> | Min Offer <font color="#FFA726">%d%%</font>
Stations: Wash <font color="#00E5FF">%d/3</font> | Repair <font color="#FFA726">%d/3</font> | Locksmith <font color="#FFD54F">%d/3</font> | Grading <font color="#AB47BC">%d/3</font>]], v479, v480, v481, v484, v485, speedLevel2, negotiationLevel2, minOfferPercent, wash, repair, locksmith, grading)

  f2(v9.ShopOverview, v486)
end

function v25.AutoEquipBestAccessories()
  if localPlayer:GetAttribute("InAuction") == true then
    return
  end

  local v487, v488 = v13.InvokeServer("Inventory", "GetPlayerInventory")

  if not v487 or type(v488) ~= "table" then
    return
  end

  local items6 = v5.Items

  if not items6 and replicatedStorage:FindFirstChild("Modules") then
    pcall(function() v5.Items = require(replicatedStorage.Modules.Items) end)
    items6 = v5.Items
  end

  if not items6 then
    return
  end

  local shopAccessoryPreset = v6.ShopAccessoryPreset or f1("Dropdown_Shop_AccessoryPreset")
    or "Balanced"

  local v489 = {
    Head = { guid = nil, score = -1 },
    Back = { guid = nil, score = -1 },
    Wrist = { guid = nil, score = -1 },
  }

  for key26, value69 in pairs(v488) do
    if type(value69) == "table" and value69.ItemId then
      local v490 = items6[tostring(value69.ItemId)]

      if v490 and v490.Category == "Accessories" and v490.SlotType and v489[v490.SlotType] then
        local slotType = v490.SlotType
        local v491 = tonumber(v490.BasePrice or v490.Price) or 50
        local v492 = 1
        local rarity = v490.Rarity or "Common"

        if rarity == "Uncommon" then
          v492 = 1.2
        elseif rarity == "Rare" then
          v492 = 1.5
        elseif rarity == "Epic" then
          v492 = 2
        elseif rarity == "Legendary" then
          v492 = 3
        elseif rarity == "Mythical" or rarity == "Lost" or rarity == "Trophy" then
          v492 = 5
        end

        local v493 = v491 * v492

        if type(value69.Roll) == "table" then
          local v494 = tonumber(value69.Roll.Luck) or 0
          local v495 = tonumber(value69.Roll.BiddingZoneWidth) or 0
          local v496 = tonumber(value69.Roll.BiddingArrowSpeed) or 0
          local v497 = tonumber(value69.Roll.Resilience) or 0
          local v498 = tonumber(value69.Roll.NPCOffersBonus) or 0
          local v499 = tonumber(value69.Roll.TipChance) or 0
          local v500 = tonumber(value69.Roll.Walkspeed) or 0

          if shopAccessoryPreset == "Luck Focus" then
            v493 = v493 + v494 * 100 + v495 * 5 + v496 * 5 + v498 * 5 + v500 * 2
          elseif shopAccessoryPreset == "Bidding Focus" then
            v493 = v493 + v495 * 50 + v496 * 50 + v497 * 30 + v494 * 10 + v500 * 2
          elseif shopAccessoryPreset == "Trader Focus" then
            v493 = v493 + v498 * 60 + v499 * 40 + v494 * 10 + v500 * 2
          elseif shopAccessoryPreset == "Speed Focus" then
            v493 = v493 + v500 * 80 + v494 * 15 + v495 * 10 + v496 * 10
          else
            v493 = v493 + v494 * 25 + v495 * 15 + v496 * 15 + v498 * 12 + v499 * 8 + v497 * 8
              + v500 * 10
          end
        end

        if v493 > v489[slotType].score then
          v489[slotType].score = v493
          v489[slotType].guid = key26
        end
      end
    end
  end

  for key27, value70 in pairs(v489) do
    if value70.guid then
      v13.FireServer("Accessories", "EquipAccessory", key27, value70.guid)
      task.wait(0.1)
    end
  end
end

v7.MinigameCooldowns = {}

function v26.GetCooldown(p100)
  local v501 = v7.MinigameCooldowns[p100]

  if v501 and os.clock() < v501 then
    return v501 - os.clock()
  end

  return 0
end

function v26.SetCooldown(p101, p102)
  v7.MinigameCooldowns[p101] = os.clock() + (p102 or 0)
end

function v26.ProcessCycle(p103)
  v6.IsMinigamesActive = true
  v6.IsMinigamesActive = false
end

v27.ProgressionOrder = {
  "Billy", "Sal", "Ted", "Mining Supervisor", "Steve", "Sam", "Michael", "General Commander",
  "Bobby", "Mayor", "Headless Horseman", "Alien Boss",
}

function v27.GetActiveQuests()
  local questSystem = v7.QuestSystem

  if not questSystem then
    local v502, v503 = pcall(
      require, replicatedStorage:WaitForChild("Modules"):WaitForChild("QuestSystem")
    )

    if v502 and v503 then
      v7.QuestSystem = v503
      questSystem = v503
    end
  end

  if questSystem and questSystem.GetActiveQuests then
    local v504, v505 = pcall(questSystem.GetActiveQuests, questSystem)

    if v504 and type(v505) == "table" then
      return v505
    end
  end

  return {}
end

function v27.IsQuestComplete(p104)
  local questSystem2 = v7.QuestSystem

  if not questSystem2 then
    local v506, v507 = pcall(
      require, replicatedStorage:WaitForChild("Modules"):WaitForChild("QuestSystem")
    )

    if v506 and v507 then
      v7.QuestSystem = v507
      questSystem2 = v507
    end
  end

  if questSystem2 and questSystem2.IsQuestComplete then
    local v508, v509 = pcall(questSystem2.IsQuestComplete, questSystem2, p104)

    if v508 then
      return v509 == true
    end
  end

  return false
end

function v27.GetQuestMetadata(p105)
  if not p105 then
    return nil
  end

  local title2 = p105.Data and p105.Data.Title
  local v510 = tostring(p105.Id or "")
  local v511 = "QuestMeta_" .. v510 .. "_" .. tostring(title2 or "")

  if v7[v511] then
    return v7[v511]
  end

  local v512 = v12.GetQuests()
  local v513 = string.match(v510, "^(.-)_quest$") or string.match(v510, "^quest_reward_(.+)$")

  if not v513 and v512 then
    if v512[v510] then
      v513 = v510
    else
      for key28, value71 in pairs(v512) do
        if value71.Levels then
          for index46, value72 in ipairs(value71.Levels) do
            if title2 and value72.QuestName == title2 then
              v513 = key28
              break
            end
          end
        end

        if v513 then
          break
        end
      end
    end
  end

  if v512 and v513 and v512[v513] and v512[v513].Levels then
    for index47, value73 in ipairs(v512[v513].Levels) do
      if title2 and value73.QuestName == title2 or not title2 and index47 == 1 then
        local luckQuest = value73.LuckQuest

        local handInNPC = luckQuest and luckQuest.HandInNPC or value73.HandInNPC
          or value73.RequiresTurnIn and v513 or v513

        local v514 = {
          NPCName = v513,
          Level = index47,
          QuestName = value73.QuestName,
          HandInNPC = handInNPC,
          RequireClean = luckQuest and luckQuest.RequireClean == true
            or value73.RequireClean == true,
          GrantItems = luckQuest and luckQuest.GrantItems,
          RequiredItems = value73.RequiredItems,
          Tasks = value73.RequiredTasks,
        }

        v7[v511] = v514
        return v514
      end
    end
  end

  local v515 = { NPCName = v513, HandInNPC = v513, RequireClean = false }
  v7[v511] = v515
  return v515
end

function v27.GetQuestOwnerNPC(p106)
  if not p106 then
    return nil
  end

  local v516 = tostring(p106.Id or "")
  local v517 = string.match(v516, "^(.-)_quest$") or string.match(v516, "^quest_reward_(.+)$")

  if v517 then
    return v517
  end

  local v518 = v27.GetQuestMetadata(p106)

  if v518 and v518.NPCName then
    return v518.NPCName
  end

  return nil
end

function v27.GetQuestHandInNPC(p107)
  if not p107 then
    return nil
  end

  local v519 = v27.GetQuestMetadata(p107)

  if v519 and v519.HandInNPC then
    return v519.HandInNPC
  end

  return v27.GetQuestOwnerNPC(p107)
end

function v27.FindNPCFromQuest(p108)
  return v27.GetQuestOwnerNPC(p108)
end

function v27.UpdateRequiredItemsBlacklist()
  local v520 = v27.GetActiveQuests()
  local v521 = {}

  for key29, value74 in pairs(v520) do
    local v522 = v27.GetQuestMetadata(value74)

    if v522 then
      if v522.RequiredItems then
        for key30, value75 in pairs(v522.RequiredItems) do
          v521[tostring(key30)] = true
        end
      end

      if v522.GrantItems then
        for index48, value76 in ipairs(v522.GrantItems) do
          if value76.ItemId then
            v521[tostring(value76.ItemId)] = true
          end
        end
      end
    end

    if value74.Data and value74.Data.Tasks then
      for index49, value77 in ipairs(value74.Data.Tasks) do
        local v523 = tostring(value77.Id or "")

        if tonumber(v523) then
          v521[v523] = true
        end
      end
    end
  end

  v7.QuestRequiredItemIds = v521
  return v521
end

function v27.IsQuestRelatedItem(p109)
  if not p109 then
    return false
  end

  local v524 = ""
  local v525 = nil

  if type(p109) == "table" then
    v525 = p109
    v524 = tostring(p109.ItemId or p109.itemId or p109.Data and p109.Data.ItemId or "")
  else
    v524 = tostring(p109)
  end

  if v7.QuestRequiredItemIds and v7.QuestRequiredItemIds[v524] then
    return true
  end

  local v526 = v524 == "374" or v524 == "330" or v524 == "375" or v524 == "328" or v524 == "329"

  if not v526 and v525 then
    local v527 = string.lower(v525.Name or v525.Data and v525.Data.Name or "")

    if string.find(v527, "fishing rod") then
      v526 = true
    end
  end

  local items7 = v5.Items and v5.Items[v524]

  if not v526 and items7 then
    if items7.Interactive == "FishingRod"
      or string.find(string.lower(items7.Name or ""), "fishing rod") then
      v526 = true
    end
  end

  if v526 then
    local v528 = false

    if v525 then
      local condition = v525.Condition or v525.Data and v525.Data.Condition

      if condition and tonumber(condition) == 0 then
        v528 = true
      end

      local mutators = v525.Mutators or v525.Data and v525.Data.Mutators

      if mutators and type(mutators) == "table" then
        for index50, value78 in ipairs(mutators) do
          if type(value78) == "table" and value78.name == "Broken" then
            v528 = true
            break
          end
        end
      elseif type(mutators) == "string" and string.find(mutators, "Broken") then
        v528 = true
      end
    end

    if v528 then
      return false
    end

    return true
  end

  if v524 == "355" or v524 == "356" or v524 == "357" or v524 == "358" then
    return true
  end

  if v524 == "158" or v524 == "359" or v524 == "360" then
    return true
  end

  if v524 == "117" then
    return true
  end

  if v525 then
    if v525.SafeId or v525.Data and v525.Data.SafeId then
      return true
    end

    if (v525.Category or v525.Data and v525.Data.Category) == "Safe" then
      return true
    end

    local v529 = string.lower(v525.Name or v525.Data and v525.Data.Name or "")

    if string.find(v529, "tier") or string.find(v529, "safe") then
      return true
    end
  end

  if items7 then
    if items7.Category and items7.Category == "Safe" or items7.SafeId ~= nil then
      return true
    end

    local v530 = string.lower(items7.Name or "")

    if string.find(v530, "power plant")
      or string.find(v530, "tier") and string.find(v530, "part") then
      return true
    end
  end

  return false
end

function v27.IsValidFishingRod(p110)
  if not p110 then
    return false
  end

  if typeof(p110) == "Instance" then
    local v531 = string.lower(p110.Name or "")

    if not ((p110:GetAttribute("Interactive") or "") == "FishingRod" or string.find(v531, "fish")
      or string.find(v531, "rod")) then
      return false
    end

    local v532 = tostring(p110:GetAttribute("Mutators") or "")

    if string.find(v532, "Broken") then
      return false
    end

    local condition2 = p110:GetAttribute("Condition")

    if condition2 and tonumber(condition2) == 0 then
      return false
    end

    return true
  elseif type(p110) == "table" then
    local v533 = tostring(p110.ItemId or p110.id or p110.Data and p110.Data.ItemId or "")
    local v534 = (v5.Items or {})[v533]

    if not (v533 == "374"
      or v533 == "330"
      or v533 == "375"
      or v533 == "328"
      or v533 == "329"
      or v534
        and (v534.Interactive == "FishingRod"
          or string.find(string.lower(v534.Name or ""), "fish")
          or string.find(string.lower(v534.Name or ""), "rod"))) then
      return false
    end

    if p110.Condition and tonumber(p110.Condition) == 0 then
      return false
    end

    if p110.Mutators and type(p110.Mutators) == "table" then
      for index51, value79 in ipairs(p110.Mutators) do
        if type(value79) == "table" and value79.name == "Broken" then
          return false
        end
      end
    end

    return true
  end

  return false
end

function v27.RunFishingSession(p111, p112, p113, p114, p115)
  if v6.IsFishingSessionRunning then
    return true
  end

  v6.IsFishingSessionRunning = true
  local v535 = false
  local v536 = false
  local v537 = false

  local misc = replicatedStorage:FindFirstChild("Events")
    and replicatedStorage.Events:FindFirstChild("Misc")

  local fishingState = misc and misc:FindFirstChild("FishingState")
  local fishingFX = misc and misc:FindFirstChild("FishingFX")
  local connect2

  if fishingState and fishingState:IsA("RemoteEvent") then
    connect2 = fishingState.OnClientEvent:Connect(function(p116, p117)
      if p116 == "reel" then
        v537 = true
      elseif p116 == "done" then
        v536 = true

        if p117 and p117.reason == "caught" then
          v535 = true
        end
      end
    end)
  end

  local connect3

  if fishingFX and fishingFX:IsA("RemoteEvent") then
    connect3 = fishingFX.OnClientEvent:Connect(function(p118, p119, p120)
      if p118 == "break" and p119 == localPlayer then
        v536 = true
      end
    end)
  end

  v29.SetStatus("Fishing", string.format("Casting line (%d/%d)", p113, p114), p115)
  v13.FireServer("Misc", "FishingCast", p112, p111)
  local v538 = os.clock()

  while not v1.Unloaded and not v536 and not v537 and os.clock() - v538 < 12 do
    v29.SetStatus("Fishing", string.format("Waiting for bite... (%d/%d)", p113, p114), p115)
    task.wait(0.2)
  end

  if v537 and not v536 then
    v29.SetStatus(
      "Fishing", string.format("Reeling catch! (%d/%d)", p113, p114), "Reeling in catch..."
    )

    local v539 = 2.2 + math.random() * 0.6
    local total = 0

    while not v1.Unloaded and not v536 and total < v539 do
      task.wait(0.2)
      total = total + 0.2
    end

    if not v536 then
      v13.FireServer("Misc", "FishingResult", "caught")

      pcall(function()
        local playerGui9 = localPlayer:FindFirstChild("PlayerGui")
        local fishingReelGui = playerGui9 and playerGui9:FindFirstChild("FishingReelGui")

        if fishingReelGui then
          fishingReelGui:Destroy()
        end

        game:GetService("ContextActionService"):UnbindAction("FishingReelHold")
        local v540 = require(replicatedStorage.Modules.Screens.Hotbar)

        if v540 and v540.SetSuppressed then
          v540.SetSuppressed("FishingReel", false)
        end
      end)
    end
  end

  local v541 = os.clock()

  while not v1.Unloaded and not v536 and os.clock() - v541 < 3 do
    task.wait(0.2)
  end

  if connect2 then
    connect2:Disconnect()
  end

  if connect3 then
    connect3:Disconnect()
  end

  if v535 then
    v29.SetStatus("Fishing", string.format("Caught item! (%d/%d)", p113 + 1, p114), p115)
  end

  task.wait(1.5)
  v6.IsFishingSessionRunning = false
  return true
end

function v27.EnsureInventorySpace(p121)
  local v542 = v11.GetInventoryCount()
  local v543 = v11.GetInventoryMax()
  local v544 = v11.GetVehicleCargoWeight()
  local v545 = v11.GetVehicleCargoWeightLimit()
  local v546 = v545 > 0 and v544 / v545 >= 0.85

  if not (v543 > 0 and v542 >= v543 - 2 or v546) then
    return false
  end

  local v547 = false

  for key31, value80 in pairs(p121 and { p121 } or v27.GetActiveQuests()) do
    if value80 and value80.Data and value80.Data.Tasks then
      for index52, value81 in ipairs(value80.Data.Tasks) do
        if (value81.Id == "sell_items" or value81.Type == "sell_item"
            or string.find(string.lower(value81.Text or ""), "shop"))
          and (value81.Current or 0) < (value81.Required or 1) then
          v547 = true
          break
        end
      end
    end

    if v547 then
      break
    end
  end

  if v547 and v11.GetPlotUnpackPosition() then
    v29.SetStatus(
      "Quest", "Relieving storage for Shop quest", "Unloading cargo to Plot shelves..."
    )

    debug(
      "[QuestBot] Storage near limit (Inv: %d/%d, Veh: %.1f/%.1f kg). Quest requires Player Shop sells, redirecting to Plot...",
      v542, v543, v544, v545
    )

    v16.UnloadAtPlot()
    v22.StockShelves()
    task.wait(0.5)
    return true
  else
    pcall(v23.RunWash, true)
    pcall(v23.RunRepair, true)

    v29.SetStatus(
      "Quest", "Inventory Full",
      string.format("Selling non-quest items at Pawn Shop (%d/%d)...", v542, v543)
    )

    debug(
      "[QuestBot] Storage near limit (Inv: %d/%d, Veh: %.1f/%.1f kg). Force selling non-quest items at Pawn Shop...",
      v542, v543, v544, v545
    )

    local v548 = v21.SellAll({ "Inventory", "Vehicle" }, true)
    task.wait(0.5)
    local v549 = v11.GetVehicleCargoWeight()

    if v545 > 0 and v549 / v545 >= 0.85 and v11.GetPlotUnpackPosition() then
      v29.SetStatus(
        "Quest", "Unloading at Plot",
        string.format("Veh: %.1f/%.1f kg. Unloading at Plot...", v549, v545)
      )

      debug(
        "[QuestBot] Vehicle still near limit after Pawn sale (%.1f/%.1f kg). Unloading at Plot...",
        v549, v545
      )

      v16.UnloadAtPlot()
      v22.StockShelves()
      task.wait(0.5)
    end

    return v548
  end
end

function v27.ProcessPlayerShopSelling(p122, p123)
  local v550 = v11.GetVehicleItemCount()
  local v551 = v11.GetInventoryCount()
  local v552 = v11.GetStoreShelvesCount()
  local v553 = v11.GetStoreShelvesCap()
  local v554 = false

  if v550 > 0 then
    v29.SetStatus(
      "Quest", "Unloading for shop quest",
      string.format("Moving %d vehicle items to Plot...", v550)
    )

    debug("[QuestBot] Quest needs shop sales. Unloading %d vehicle items at Plot...", v550)
    v16.UnloadAtPlot()
    task.wait(0.5)
    v554 = true
  end

  v551 = v11.GetInventoryCount()
  v552 = v11.GetStoreShelvesCount()

  if v551 > 0 and v552 < v553 then
    v29.SetStatus("Quest", "Stocking shelves for quest", "Placing items on shelves...")

    debug(
      "[QuestBot] Stocking shelves for shop quest (Inv: %d, Shelves: %d/%d)...", v551, v552,
      v553
    )

    if v22.StockShelves() then
      v554 = true
    end

    task.wait(0.5)
  end

  if v22.ProcessPendingShopperOffers() > 0 then
    v554 = true
  end

  local v555 = v11.GetVehicleCargoWeightLimit()
  local v556 = v11.GetVehicleCargoWeight()
  local v557 = v555 > 0 and v556 / v555 >= 0.85
  local v558 = v11.GetInventoryCount() >= v11.GetInventoryMax()
  local v559 = v552 >= v553

  if (v557 or v558) and v559 then
    v29.SetStatus("Quest", "Serving NPC shoppers", string.format(
      "Shelves & Storage full (%d/%d). Waiting for shoppers...", v552, v553
    ))

    debug("[QuestBot] Storage and shelves full. Waiting for NPC shoppers...")
    local v560 = os.clock()

    while not v1.Unloaded and os.clock() - v560 < 8 do
      v22.ProcessPendingShopperOffers()

      if p123 and (p123.Current or 0) >= (p123.Required or 1) then
        break
      end

      task.wait(1.5)
    end

    return true
  end

  return v554
end

function v27.FindNPCModel(p124)
  if p124 == "Collector" then
    local npcShoppers = workspace:FindFirstChild("_NPCShoppers")

    if npcShoppers then
      for index53, value82 in ipairs(npcShoppers:GetChildren()) do
        if value82:IsA("Model") and value82.Name == p124
          and value82:GetAttribute("CollectorOwnerUserId") == localPlayer.UserId
          and value82:GetAttribute("CollectorCanTalk") == true then
          return value82
        end
      end
    end

    return nil
  end

  for index54, value83 in ipairs(game:GetService("CollectionService"):GetTagged(p124)) do
    local model2 = value83:IsA("Model") and value83 or value83:FindFirstAncestorOfClass("Model")

    if model2 and model2:IsDescendantOf(workspace) then
      return model2
    end
  end

  local luckQuests = workspace:FindFirstChild("_LuckQuests")

  if luckQuests then
    local findFirstChild18 = luckQuests:FindFirstChild(p124)

    if findFirstChild18 and findFirstChild18:IsA("Model") then
      return findFirstChild18
    end
  end

  local areas2 = workspace:FindFirstChild("Areas")

  if areas2 then
    for index55, value84 in ipairs(areas2:GetChildren()) do
      local findFirstChild19 = value84:FindFirstChild(p124)

      if findFirstChild19 and findFirstChild19:IsA("Model") then
        return findFirstChild19
      end
    end
  end

  local mallShopNPCs = workspace:FindFirstChild("Mall - Shop NPCs")

  if mallShopNPCs then
    local questNPC = mallShopNPCs:FindFirstChild("Quest NPC")

    if questNPC then
      local findFirstChild20 = questNPC:FindFirstChild(p124)

      if findFirstChild20 and findFirstChild20:IsA("Model") then
        return findFirstChild20
      end
    end

    local findFirstChild21 = mallShopNPCs:FindFirstChild(p124)

    if findFirstChild21 and findFirstChild21:IsA("Model") then
      return findFirstChild21
    end
  end

  for index56, value85 in ipairs({
    "NPC", "NPCs", "_NPCs", "Ferry Terminal NPC", "Toll Booth NPC",
  }) do
    local findFirstChild22 = workspace:FindFirstChild(value85)

    if findFirstChild22 then
      local findFirstChild23 = findFirstChild22:FindFirstChild(p124)

      if findFirstChild23 and findFirstChild23:IsA("Model") then
        return findFirstChild23
      end
    end
  end

  local bbowBuilderAssets = workspace:FindFirstChild("BBOW Builder Assets")

  if bbowBuilderAssets then
    local otherBuildingsAndDecoration = bbowBuilderAssets:FindFirstChild("Other Buildings and  Decoration")

    local policeStation = otherBuildingsAndDecoration
      and otherBuildingsAndDecoration:FindFirstChild("Police Station")

    if policeStation and policeStation:FindFirstChild(p124) then
      return policeStation[p124]
    end
  end

  for index57, value86 in ipairs(workspace:GetChildren()) do
    if value86:IsA("Model") and value86.Name == p124 then
      return value86
    end
  end

  return nil
end

function v27.FindNPCPosition(p125)
  if p125 == "Collector" then
    local collector = v27.FindNPCModel("Collector")

    if collector then
      local humanoidRootPart7 = collector:FindFirstChild("HumanoidRootPart")
        or collector.PrimaryPart or collector:FindFirstChildWhichIsA("BasePart")

      if humanoidRootPart7 then
        return humanoidRootPart7.Position
      end
    end

    return nil
  end

  v7.NPCFixedPositions = v7.NPCFixedPositions or {}

  if v7.NPCFixedPositions[p125] then
    return v7.NPCFixedPositions[p125]
  end

  local v561, v562 = v13.InvokeServer("Quest", "GetQuestNPCPosition", p125)

  if v561 and typeof(v562) == "Vector3" then
    v7.NPCFixedPositions[p125] = v562
    return v562
  end

  if v7.POIMap and v7.POIMap[p125] then
    v7.NPCFixedPositions[p125] = v7.POIMap[p125]
    return v7.POIMap[p125]
  end

  local v563 = v27.FindNPCModel(p125)

  if v563 then
    local humanoidRootPart8 = v563:FindFirstChild("HumanoidRootPart") or v563.PrimaryPart
      or v563:FindFirstChildWhichIsA("BasePart")

    if humanoidRootPart8 then
      v7.NPCFixedPositions[p125] = humanoidRootPart8.Position
      return humanoidRootPart8.Position
    end
  end

  return nil
end

function v27.InteractNPC(p126, p127, p128, p129)
  p128 = p128 or "accept"
  local v564 = v27.FindNPCModel(p126)

  if not v564 then
    debug("[QuestBot] Could not find NPC model in workspace for: %s", p126)
    return false
  end

  local character11 = localPlayer.Character
  local humanoid6 = character11 and character11:FindFirstChild("Humanoid")

  if humanoid6 and humanoid6.Sit then
    humanoid6.Sit = false
    task.wait(0.2)
  end

  local humanoidRootPart9 = character11 and character11:FindFirstChild("HumanoidRootPart")

  local humanoidRootPart10 = v564:FindFirstChild("HumanoidRootPart") or v564.PrimaryPart
    or v564:FindFirstChildWhichIsA("BasePart")

  if humanoidRootPart9 and humanoidRootPart10 then
    if (humanoidRootPart9.Position - humanoidRootPart10.Position).Magnitude > 4.5 then
      local v565 = humanoidRootPart10.Position + humanoidRootPart10.CFrame.LookVector * 2.5

      character11:PivotTo(CFrame.lookAt(
        Vector3.new(v565.X, humanoidRootPart10.Position.Y, v565.Z), humanoidRootPart10.Position
      ))

      task.wait(0.35)
    else
      character11:PivotTo(CFrame.lookAt(humanoidRootPart9.Position, Vector3.new(
        humanoidRootPart10.Position.X, humanoidRootPart9.Position.Y,
        humanoidRootPart10.Position.Z
      )))

      task.wait(0.15)
    end
  end

  local v566, v567 = v13.InvokeServer("UI", "QuestPromptTriggered", v564)

  if not v566 or v567 == false then
    local findFirstChild24 = v564:FindFirstChild("NPCQuestPrompt", true)

    if findFirstChild24 and findFirstChild24:IsA("ProximityPrompt")
      and typeof(fireproximityprompt) == "function" then
      pcall(fireproximityprompt, findFirstChild24, 0)
      task.wait(0.2)
    else
      debug("[QuestBot] Server rejected QuestPromptTriggered for %s", p126)
      return false
    end
  end

  task.wait(0.25)
  v13.FireServer("UI", "SendQuestDialogResult", v564, p127 or "", p128)

  debug(
    "[QuestBot] Handshake completed with %s (quest=%s, response=%s, turnInOnly=%s)", p126,
    p127 or "", p128, tostring(p129)
  )

  task.delay(0.15, function()
    pcall(function()
      local playerGui10 = localPlayer:FindFirstChild("PlayerGui")

      local questDialogPrompts = playerGui10
        and playerGui10:FindFirstChild("QuestDialogPrompts")

      if questDialogPrompts and questDialogPrompts.Enabled then
        for index58, value87 in ipairs(questDialogPrompts:GetDescendants()) do
          if value87:IsA("TextButton") and value87.Visible and value87.Active then
            local v568 = string.lower(value87.Text or "")

            if p129 then
              if not (string.find(v568, "accept") or string.find(v568, "in%.")
                or string.find(v568, "castin") or string.find(v568, "easy money")
                or string.find(v568, "on it")) then
                pcall(value87.MouseButton1Click)
              end
            else
              pcall(value87.MouseButton1Click)
            end
          end
        end
      end
    end)
  end)

  task.delay(0.5, function()
    pcall(function()
      local playerGui11 = localPlayer:FindFirstChild("PlayerGui")
      local uiControllerGui5 = playerGui11 and playerGui11:FindFirstChild("UIControllerGui")

      local findFirstChild25 = uiControllerGui5
        and uiControllerGui5:FindFirstChild("QuestRewardPopupPanel", true)

      if findFirstChild25 and findFirstChild25.Visible then
        local findFirstChild26 = findFirstChild25:FindFirstChild("DismissButton", true)
          or findFirstChild25:FindFirstChildWhichIsA("GuiButton", true)

        if findFirstChild26 and findFirstChild26.Visible then
          pcall(findFirstChild26.MouseButton1Click)
        end

        findFirstChild25.Visible = false
      end
    end)
  end)

  return true
end

function v27.CancelQuest(p130)
  if not p130 then
    return false
  end

  local events2 = replicatedStorage:FindFirstChild("Events")
  local quest = events2 and events2:FindFirstChild("Quest")
  local cancelQuest = quest and quest:FindFirstChild("CancelQuest")

  if cancelQuest and cancelQuest:IsA("RemoteFunction") then
    local v569, v570 = pcall(function() return cancelQuest:InvokeServer(p130) end)

    if v569 and type(v570) == "table" and v570.Success then
      pcall(function()
        local questSystem3 = v7.QuestSystem

        if questSystem3 and questSystem3.RemoveQuest then
          questSystem3:RemoveQuest(p130)
        end
      end)

      return true
    end
  end

  return false
end

function v27.GetProgressionNPCs()
  local questsSelectedBranch2 = v6.QuestsSelectedBranch
    or f1 and f1("Dropdown_Quests_SelectedBranch") or "Story Progression"

  if questsSelectedBranch2 == "Bobby & Terry" then
    return { "Bobby", "Terry" }
  elseif questsSelectedBranch2 == "Fishing" then
    return { "Fisherman" }
  elseif questsSelectedBranch2 == "Power Plant" then
    return { "Engineer", "Mad Scientist" }
  end

  return v27.ProgressionOrder
end

function v27.FindEligibleNPC()
  local v571 = v27.GetActiveQuests()

  local questsSelectedBranch3 = v6.QuestsSelectedBranch
    or f1 and f1("Dropdown_Quests_SelectedBranch") or "Story Progression"

  local v572 = v27.GetProgressionNPCs()
  local v573 = v12.GetQuests()

  if questsSelectedBranch3 ~= "Story Progression" then
    for key32, value88 in pairs(v571) do
      local v574 = v27.FindNPCFromQuest(value88)

      if v574 and table.find(v572, v574) then
        return nil
      end
    end
  else
    local count16 = 0

    for key33, value89 in pairs(v571) do
      local v575 = v27.FindNPCFromQuest(value89)

      if v575 and table.find(v572, v575) then
        count16 = count16 + 1
      end
    end

    if count16 >= 2 then
      return nil
    end
  end

  local v576 = {}

  for key34, value90 in pairs(v571) do
    local v577 = v27.GetQuestMetadata(value90)

    if v577 and v577.NPCName then
      v576[v577.NPCName] = true
    end

    local v578 = v27.FindNPCFromQuest(value90)

    if v578 then
      v576[v578] = true
    end
  end

  local v579 = v11.GetNetWorth()

  if not v7.LastNPCInteractAttempt then
    v7.LastNPCInteractAttempt = {}
  end

  local v580 = os.clock()
  local v581 = {}

  for index59, value91 in ipairs(v572) do
    table.insert(v581, value91)
  end

  for index60, value92 in ipairs(v581) do
    if not v576[value92] then
      if v580 - (v7.LastNPCInteractAttempt[value92] or 0) >= 45 then
        local v582 = v573 and v573[value92]
        local minimumNetWorth = v582 and v582.MinimumNetWorth or 0

        if v579 >= minimumNetWorth then
          if v27.FindNPCPosition(value92) then
            return value92, minimumNetWorth
          end
        end
      end
    end
  end

  return nil
end

function v27.GetNextProgressionTarget()
  local v583 = v27.GetActiveQuests()
  local v584 = v27.GetProgressionNPCs()

  local questsSelectedBranch4 = v6.QuestsSelectedBranch
    or f1 and f1("Dropdown_Quests_SelectedBranch") or "Story Progression"

  for index61, value93 in ipairs(v584) do
    for key35, value94 in pairs(v583) do
      if v27.FindNPCFromQuest(value94) == value93 then
        return value93, value94, "Active"
      end
    end
  end

  local v585 = v12.GetQuests()
  local v586 = v11.GetNetWorth()

  if not v7.LastNPCInteractAttempt then
    v7.LastNPCInteractAttempt = {}
  end

  local v587 = os.clock()

  for index62, value95 in ipairs(v584) do
    if v587 - (v7.LastNPCInteractAttempt[value95] or 0) >= 8 then
      local v588 = v585 and v585[value95]
      local minimumNetWorth2 = v588 and v588.MinimumNetWorth or 0

      if v586 < minimumNetWorth2 then
        return value95, nil, "NeedNetWorth", minimumNetWorth2
      end

      local v589 = questsSelectedBranch4 == "Story Progression" and 2 or 1

      if #v583 >= v589 then
        return value95, nil, "QuestLogFull", minimumNetWorth2
      end

      return value95, nil, "Eligible", minimumNetWorth2
    end
  end

  return nil, nil, "None"
end

function v27.GetCurrentTaskSummary()
  local v590 = os.clock()

  if v7.LastQuestTaskSummary and v590 - (v7.LastQuestTaskSummaryTime or 0) < 0.3 then
    return v7.LastQuestTaskSummary
  end

  local v591, v592, v593, v594 = v27.GetNextProgressionTarget()
  local v595 = nil

  if (v593 == "Active" or v593 == "ActiveWaitingSlot") and v592 then
    local title3 = v592.Data and v592.Data.Title or "Quest"
    local v596 = nil

    if v592.Data and v592.Data.Tasks and #v592.Data.Tasks > 0 then
      for index63, value96 in ipairs(v592.Data.Tasks) do
        if (value96.Current or 0) < (value96.Required or 1) then
          v596 = value96
          break
        end
      end
    end

    local text = v596 and (v596.Text or v596.DisplayName or v596.Id or "Task")
      or "Ready to turn in"

    local current = v596 and (v596.Current or 0) or 1
    local required = v596 and (v596.Required or v596.Target or 1) or 1

    if v593 == "ActiveWaitingSlot" then
      local questsSelectedBranch5 = v6.QuestsSelectedBranch
        or f1 and f1("Dropdown_Quests_SelectedBranch") or "Quest"

      v595 = string.format(
        "<font color=\"#FF9800\">[Freeing Slot for %s]</font> <font color=\"#FFFFFF\">%s: %s</font> <font color=\"#81D4FA\">(%d/%d)</font>",
        questsSelectedBranch5, v591 or "Quest", text, current, required
      )
    elseif v596 then
      v595 = string.format(
        "<font color=\"#FFD54F\">[%s - %s]</font> <font color=\"#FFFFFF\">%s</font> <font color=\"#81D4FA\">(%d/%d)</font>",
        v591 or "Quest", title3, text, current, required
      )
    else
      v595 = string.format(
        "<font color=\"#00E676\">[%s - %s] Ready to turn in!</font>", v591 or "Quest", title3
      )
    end
  elseif v593 == "NeedNetWorth" and v591 then
    local v597 = v11.GetNetWorth()

    v595 = string.format(
      "<font color=\"#FFB74D\">[%s] Farming NW: $%s / $%s</font>", v591, v14.Number(v597),
      v14.Number(v594 or 0)
    )
  elseif v593 == "QuestLogFull" and v591 then
    local v598 = (v6.QuestsSelectedBranch or f1 and f1("Dropdown_Quests_SelectedBranch")
            or "Quest")
          == "Story Progression"
        and "2/2"
      or "1/1"

    v595 = string.format(
      "<font color=\"#FF5252\">[%s] Branch Slot Full (%s). Freeing slot with active quests...</font>",
      v591, v598
    )
  elseif v593 == "Eligible" and v591 then
    v595 = string.format("<font color=\"#00E5FF\">[%s] Ready to accept new Quest</font>", v591)
  elseif v593 == "None" then
    local questsSelectedBranch6 = v6.QuestsSelectedBranch
      or f1 and f1("Dropdown_Quests_SelectedBranch") or "Quest"

    v595 = string.format(
      "<font color=\"#00E676\">[%s] All Quests Completed!</font>", questsSelectedBranch6
    )
  end

  v7.LastQuestTaskSummary = v595
  v7.LastQuestTaskSummaryTime = v590

  return v595
end

function v27.GetAreaForGarage(p131)
  if not p131 then
    return ""
  end

  local areasModule = v7.AreasModule

  if not areasModule then
    local v599, v600 = pcall(
      require, replicatedStorage:WaitForChild("Modules"):WaitForChild("Areas")
    )

    if v599 and v600 then
      v7.AreasModule = v600
      areasModule = v600
    end
  end

  if areasModule and areasModule.GetGarageAreaName then
    local v601, v602 = pcall(areasModule.GetGarageAreaName, p131)

    if v601 and v602 then
      return v602
    end
  end

  if string.find(p131, "Scrap Garage") then
    return "Junk Yard"
  end

  if string.find(p131, "Stable") or string.find(p131, "Barn") then
    return "Farmyard"
  end

  if string.find(p131, "Shop Front") then
    return "Back Alley"
  end

  if string.find(p131, "Container") or string.find(p131, "Warehouse") then
    return "Shipyard"
  end

  if string.find(p131, "Military") then
    return "Military Base"
  end

  if string.find(p131, "Power Plant") then
    return "Power Plant"
  end

  if string.find(p131, "Beach") or string.find(p131, "Surf") or string.find(p131, "Boat") then
    return "Lucky Beach"
  end

  if string.find(p131, "Apartment") or string.find(p131, "Hotel")
    or string.find(p131, "Pointer") then
    return "Business Bay"
  end

  if string.find(p131, "Mine") or string.find(p131, "Prospector") or string.find(p131, "Drill")
    or string.find(p131, "Depot") then
    return "The Mines"
  end

  if string.find(p131, "Wild West") then
    return "Wild West"
  end

  if string.find(p131, "Train") then
    return "Cargo Train"
  end

  return ""
end

function v27.FindQuestGaragePrompt(p132)
  local collectionService3 = game:GetService("CollectionService")
  local gamePrompt3 = collectionService3:GetTagged("GamePrompt")
  local character12 = localPlayer.Character
  local humanoidRootPart11 = character12 and character12:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart11 then
    return nil, math.huge, nil
  end

  local garages3 = v5.Garages or {}
  local v603 = v11.GetNetWorth()
  local v604 = v11.GetCash()
  local v605 = nil
  local huge2 = math.huge
  local v606 = nil

  for index64, value97 in ipairs(gamePrompt3) do
    if value97.Name == "EnterAuction" and value97.Enabled and value97.Parent then
      local parent5 = value97.Parent

      while parent5 and parent5.Parent and parent5.Parent.Name ~= "Garages" do
        parent5 = parent5.Parent
      end

      if parent5 then
        local name9 = parent5.Name
        local v607 = v27.GetAreaForGarage(name9)

        if not p132 or p132 == "" or v607 == p132 then
          local v608 = garages3[name9]
          local minNetWorth3 = v608 and v608.MinNetWorth or 0

          local entranceFee = v608 and v608.EntranceFee
            or v608 and v608.EntryCost
              and (type(v608.EntryCost) == "table" and v608.EntryCost.Min or v608.EntryCost)
            or 0

          if v603 >= minNetWorth3 and v604 >= entranceFee then
            local magnitude7 = (humanoidRootPart11.Position - value97.Parent.Position).Magnitude

            if magnitude7 < huge2 then
              huge2 = magnitude7
              v605 = value97
              v606 = parent5
            end
          end
        end
      end
    end
  end

  return v605, huge2, v606
end

function v27.FindGaragePromptByName(p133)
  local collectionService4 = game:GetService("CollectionService")
  local gamePrompt4 = collectionService4:GetTagged("GamePrompt")
  local character13 = localPlayer.Character
  local humanoidRootPart12 = character13 and character13:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart12 then
    return nil, math.huge, nil
  end

  local garages4 = v5.Garages or {}
  local v609 = v11.GetNetWorth()
  local v610 = v11.GetCash()
  local v611 = nil
  local huge3 = math.huge
  local v612 = nil

  for index65, value98 in ipairs(gamePrompt4) do
    if value98.Name == "EnterAuction" and value98.Enabled and value98.Parent then
      local parent6 = value98.Parent

      while parent6 and parent6.Parent and parent6.Parent.Name ~= "Garages" do
        parent6 = parent6.Parent
      end

      if parent6 and string.find(parent6.Name, p133) then
        local v613 = garages4[parent6.Name]
        local minNetWorth4 = v613 and v613.MinNetWorth or 0

        local entranceFee2 = v613 and v613.EntranceFee
          or v613 and v613.EntryCost
            and (type(v613.EntryCost) == "table" and v613.EntryCost.Min or v613.EntryCost)
          or 0

        if v609 >= minNetWorth4 and v610 >= entranceFee2 then
          local magnitude8 = (humanoidRootPart12.Position - value98.Parent.Position).Magnitude

          if magnitude8 < huge3 then
            huge3 = magnitude8
            v611 = value98
            v612 = parent6
          end
        end
      end
    end
  end

  return v611, huge3, v612
end

function v27.FindHighestNWGaragePrompt()
  local collectionService5 = game:GetService("CollectionService")
  local gamePrompt5 = collectionService5:GetTagged("GamePrompt")
  local character14 = localPlayer.Character
  local humanoidRootPart13 = character14 and character14:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart13 then
    return nil, math.huge, nil
  end

  local garages5 = v5.Garages or {}
  local v614 = v11.GetNetWorth()
  local v615 = v11.GetCash()
  local v616 = nil
  local huge4 = math.huge
  local v617 = nil
  local v618 = -1

  for index66, value99 in ipairs(gamePrompt5) do
    if value99.Name == "EnterAuction" and value99.Enabled and value99.Parent then
      local parent7 = value99.Parent

      while parent7 and parent7.Parent and parent7.Parent.Name ~= "Garages" do
        parent7 = parent7.Parent
      end

      if parent7 then
        local v619 = garages5[parent7.Name]
        local minNetWorth5 = v619 and v619.MinNetWorth or 0
        local entranceFee3 = v619 and v619.EntranceFee or 0

        if v614 >= minNetWorth5 and v615 >= entranceFee3 then
          if minNetWorth5 > v618 then
            v618 = minNetWorth5
            v616 = value99
            huge4 = (humanoidRootPart13.Position - value99.Parent.Position).Magnitude
            v617 = parent7
          elseif minNetWorth5 == v618 then
            local magnitude9 = (humanoidRootPart13.Position - value99.Parent.Position).Magnitude

            if magnitude9 < huge4 then
              huge4 = magnitude9
              v616 = value99
              v617 = parent7
            end
          end
        end
      end
    end
  end

  return v616, huge4, v617
end

function v27.RunAuctionCycle(p134, p135, p136)
  if not p134 or not p134.Parent then
    return false
  end

  local v620 = v11.GetInventoryCount()
  local v621 = v11.GetInventoryMax()
  local v622 = v11.GetVehicleCargoWeight()
  local v623 = v11.GetVehicleCargoWeightLimit()
  local v624 = v623 > 0 and v622 / v623 >= 0.85

  if v621 > 0 and v620 >= v621 - 2 or v624 then
    v27.EnsureInventorySpace()
    v620 = v11.GetInventoryCount()
    v622 = v11.GetVehicleCargoWeight()

    if v621 > 0 and v620 >= v621 - 2 or v623 > 0 and v622 / v623 >= 0.85 then
      v29.SetStatus("Quest", "Paused: Storage Full", "Free storage to continue quest auctions")

      debug(
        "[QuestBot] Cannot enter auction: Storage full (Inv: %d/%d, Veh: %.1f/%.1f kg)", v620,
        v621, v622, v623
      )

      task.wait(2)
      return false
    end
  end

  local objectText2 = p134.ObjectText or p135 and p135.Name or "Garage"
  local position4 = p134.Parent.Position
  local v625 = position4 + Vector3.new(0, 1.5, 0)
  local findFirstChild27 = p135 and p135:FindFirstChild("AuctionZone", true)
  local character15 = localPlayer.Character
  local humanoidRootPart14 = character15 and character15:FindFirstChild("HumanoidRootPart")

  local magnitude10 = humanoidRootPart14 and (humanoidRootPart14.Position - position4).Magnitude
    or 999

  if magnitude10 > 5 then
    v29.SetStatus(
      "Quest", string.format("Traveling to %s (%.0f studs)", objectText2, magnitude10), p136
    )

    v15.TweenTo(v625)
  end

  v15.Stop()
  task.wait(0.2)
  local character16 = localPlayer.Character
  local humanoidRootPart15 = character16 and character16:FindFirstChild("HumanoidRootPart")

  local magnitude11 = humanoidRootPart15 and (humanoidRootPart15.Position - position4).Magnitude
    or 999

  if magnitude11 > 15 then
    v15.TweenTo(v625)
    task.wait(0.3)
    character16 = localPlayer.Character
    humanoidRootPart15 = character16 and character16:FindFirstChild("HumanoidRootPart")

    magnitude11 = humanoidRootPart15 and (humanoidRootPart15.Position - position4).Magnitude
      or 999

    if magnitude11 > 15 then
      debug(
        "[QuestBot] Could not reach %s (still %.1f studs away), aborting cycle.", objectText2,
        magnitude11
      )

      return false
    end
  end

  if findFirstChild27 then
    v7.CurrentAuctionZone = findFirstChild27
  end

  v7.CurrentAuctionGarageModel = p135

  v7.CurrentAuctionPos = findFirstChild27 and findFirstChild27.Position + Vector3.new(0, 1.5, 0)
    or v625

  v6.IsInAuction = false
  v6.IsEnteringAuction = true
  v6.LastAuctionStartTime = os.clock()

  v20.LastPromptTriggerTime = os.clock()
  v29.SetStatus("Quest", string.format("Entering %s", objectText2), p136)

  for i14 = 1, 3 do
    local v626 = v20.GetContainer()

    if v6.IsInAuction or v626 and v626.Visible then
      break
    end

    if not p134.Parent or not p134.Enabled then
      break
    end

    pcall(function() p134.HoldDuration = 0 end)

    if typeof(fireproximityprompt) == "function" then
      fireproximityprompt(p134, 0)
    end

    pcall(function()
      local playerGui12 = localPlayer:FindFirstChild("PlayerGui")
      local uiControllerGui6 = playerGui12 and playerGui12:FindFirstChild("UIControllerGui")

      local confirmPrompt2 = uiControllerGui6
        and uiControllerGui6:FindFirstChild("ConfirmPrompt")

      if confirmPrompt2 and confirmPrompt2.Visible then
        local findFirstChild28 = confirmPrompt2:FindFirstChild("ConfirmButton", true)
          or confirmPrompt2:FindFirstChild("YesButton", true)

        if findFirstChild28 and typeof(firesignal) == "function" then
          firesignal(findFirstChild28.MouseButton1Down)
        end
      end
    end)

    task.wait(0.5)
  end

  local v627 = os.clock()

  while not v1.Unloaded and os.clock() - v627 < 15 do
    local v628 = v20.GetContainer()

    if v6.IsInAuction or v628 and v628.Visible then
      break
    end

    task.wait(0.2)
  end

  local v629 = v20.GetContainer()

  if not (v6.IsInAuction or v629 and v629.Visible) then
    v6.IsEnteringAuction = false
    debug("[QuestBot] Auction did not start within 15s at %s", objectText2)
    return false
  end

  v29.SetStatus("Quest", string.format("In Auction: %s (Waiting countdown)", objectText2))
  local v630 = os.clock()

  while not v1.Unloaded and os.clock() - v630 < 20 do
    local v631 = v20.GetContainer()

    if v631 and v631.Visible then
      break
    end

    if not v6.IsInAuction and os.clock() - v630 > 5 then
      break
    end

    pcall(function()
      local character17 = localPlayer.Character
      local humanoidRootPart16 = character17 and character17:FindFirstChild("HumanoidRootPart")

      if findFirstChild27 and humanoidRootPart16
        and (humanoidRootPart16.Position - findFirstChild27.Position).Magnitude > 25 then
        v15.TweenTo(findFirstChild27.Position + Vector3.new(0, 1.5, 0), 25)
      end
    end)

    task.wait(0.2)
  end

  local v632 = v20.GetContainer()

  if not (v632 and v632.Visible) then
    debug("[QuestBot] Bidding UI did not open at %s", objectText2)

    v6.IsEnteringAuction = false
    v6.IsInAuction = false

    return false
  end

  local v633 = 0
  local v634 = 0

  local connect4 = runService.Heartbeat:Connect(function()
    local v635 = v20.GetContainer()

    if not (v6.IsInAuction or v635 and v635.Visible) then
      return
    end

    if os.clock() - v634 < 0.25 then
      return
    end

    local v636 = v20.GetBidBarElements()

    if v636 and v20.IsCursorInZone(v636) then
      local v637 = v20.GetCurrentNextBid(v636.Container)
      local v638 = math.max(100, v20.CalculateMaxBid())

      if v637 <= v638 or v637 == 0 then
        v634 = os.clock()
        v20.PerformBid(v636)
      elseif not v6.IsWinningAuction then
        v20.LeaveAuction(string.format(
          "Next $%s > Max Budget $%s", v14.Number(v637), v14.Number(v638)
        ))
      end
    end
  end)

  while not v1.Unloaded do
    local v639 = v20.GetContainer()

    if not (v639 and v639.Visible == true) and not v6.IsInAuction then
      break
    end

    if v6.IsPickupActive then
      break
    end

    local v640 = false

    pcall(function()
      local character18 = localPlayer.Character
      local humanoidRootPart17 = character18 and character18:FindFirstChild("HumanoidRootPart")

      if findFirstChild27 and humanoidRootPart17
        and (humanoidRootPart17.Position - findFirstChild27.Position).Magnitude > 25 then
        v15.TweenTo(findFirstChild27.Position + Vector3.new(0, 1.5, 0), 25)
      end

      local v641 = v20.GetBidBarElements()

      if v641 then
        local v642 = v20.GetCurrentNextBid(v641.Container)
        local v643 = math.max(100, v20.CalculateMaxBid())

        if os.clock() - v633 > 0.8 then
          v633 = os.clock()

          v29.SetStatus("Quest", string.format(
            "Bidding in %s: $%s (Max: $%s)", objectText2, v14.Number(v642), v14.Number(v643)
          ), p136)
        end

        if v642 > v643 and not v6.IsWinningAuction then
          v20.LeaveAuction(string.format(
            "Next $%s > Max Budget $%s", v14.Number(v642), v14.Number(v643)
          ))

          v640 = true
        end
      end
    end)

    if v640 then
      break
    end

    task.wait(0.1)
  end

  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end

  v6.IsEnteringAuction = false
  v6.IsInAuction = false

  task.wait(0.5)
  local v644 = os.clock()

  while not v1.Unloaded and os.clock() - v644 < 3 do
    if v6.IsPickupActive then
      break
    end

    local playerGui13 = localPlayer:FindFirstChild("PlayerGui")
    local uiControllerGui7 = playerGui13 and playerGui13:FindFirstChild("UIControllerGui")

    local auctionPickupHUD = uiControllerGui7
      and uiControllerGui7:FindFirstChild("AuctionPickupHUD")

    if auctionPickupHUD and auctionPickupHUD.Visible then
      v6.IsPickupActive = true
      break
    end

    task.wait(0.2)
  end

  if v6.IsPickupActive or v6.IsWinningAuction then
    v29.SetStatus("Quest", "Collecting won auction loot", p136)
    v16.EnsureNearPlayer(35)
    local v645 = os.clock()
    local count17 = 0

    while not v1.Unloaded and os.clock() - v645 < 25 do
      if not v6.IsPickupActive and os.clock() - v645 > 2 then
        count17 = count17 + 1

        if count17 >= 2 then
          break
        end
      end

      pcall(v20.CollectNearbyLoot)
      task.wait(0.3)
    end

    v6.IsPickupActive = false
    v11.InvalidateInventoryCache()
    pcall(v27.CheckSpecialTasks, v27.GetActiveQuests())
  else
    v29.SetStatus("Quest", "Auction ended", p136 or "Preparing next quest action...")
  end

  task.wait(0.5)
  return true
end

function v27.TurnInQuest(p137, p138)
  local v646 = tostring(p137 and p137.Id or "")
  local v647 = true

  if p137.Data and p137.Data.Tasks and #p137.Data.Tasks > 0 then
    for index67, value100 in ipairs(p137.Data.Tasks) do
      if (value100.Current or 0) < (value100.Required or 1) then
        v647 = false
        break
      end
    end
  end

  if not (v27.IsQuestComplete(v646) or v647 or string.match(v646, "^quest_reward_") ~= nil) then
    return false
  end

  local lastClaimCooldown = v7.LastClaimCooldown and v7.LastClaimCooldown[v646] or 0

  if os.clock() <= lastClaimCooldown then
    return false
  end

  local v648 = v27.GetQuestHandInNPC(p137) or v646
  local title4 = p137.Data and p137.Data.Title or "Quest"
  local v649 = v648 and v27.FindNPCPosition(v648)

  if not v649 then
    return false
  end

  local cframe2 = CFrame.new(v649 + Vector3.new(0, 1.5, 0))
  local v650 = v27.FindNPCModel(v648)

  if v650 then
    local humanoidRootPart18 = v650:FindFirstChild("HumanoidRootPart") or v650.PrimaryPart
      or v650:FindFirstChildWhichIsA("BasePart")

    if humanoidRootPart18 then
      local v651 = humanoidRootPart18.Position + humanoidRootPart18.CFrame.LookVector * 2.5

      cframe2 = CFrame.lookAt(
        Vector3.new(v651.X, humanoidRootPart18.Position.Y, v651.Z), humanoidRootPart18.Position
      )
    end
  end

  v29.SetStatus(
    "Quest", string.format("Claiming: %s from %s", title4, v648),
    string.format("Traveling to %s...", v648)
  )

  v15.TweenTo(cframe2)
  task.wait(0.4)
  local v652 = p138 and "decline" or "accept"
  local v653 = v27.InteractNPC(v648, title4, v652, p138)
  task.wait(0.8)

  v7.LastClaimCooldown = v7.LastClaimCooldown or {}
  v7.LastClaimCooldown[v646] = os.clock() + (v653 and 10 or 15)

  return v653
end

function v27.AcceptQuestFromNPC(p139)
  if not p139 then
    return false
  end

  local v654 = v27.FindNPCPosition(p139)

  if not v654 then
    return false
  end

  local cframe3 = CFrame.new(v654 + Vector3.new(0, 1.5, 0))
  local v655 = v27.FindNPCModel(p139)

  if v655 then
    local humanoidRootPart19 = v655:FindFirstChild("HumanoidRootPart") or v655.PrimaryPart
      or v655:FindFirstChildWhichIsA("BasePart")

    if humanoidRootPart19 then
      local v656 = humanoidRootPart19.Position + humanoidRootPart19.CFrame.LookVector * 2.5

      cframe3 = CFrame.lookAt(
        Vector3.new(v656.X, humanoidRootPart19.Position.Y, v656.Z), humanoidRootPart19.Position
      )
    end
  end

  v7.LastNPCInteractAttempt = v7.LastNPCInteractAttempt or {}
  v7.LastNPCInteractAttempt[p139] = os.clock()

  v29.SetStatus(
    "Quest", string.format("Accepting quest from %s", p139),
    string.format("Traveling to %s...", p139)
  )

  v15.TweenTo(cframe3)
  task.wait(0.4)
  local v657 = v27.InteractNPC(p139, "", "accept")
  task.wait(1)
  return v657
end

function v27.CheckItemsDelivery(p140)
  local v658 = v27.GetQuestMetadata(p140)

  if not v658 then
    return false
  end

  local questRequiredItemIds = v7.QuestRequiredItemIds or {}
  local v659, v660 = v11.GetInventoryItems()

  if not (v659 and type(v660) == "table") then
    return false
  end

  local v661 = false

  if p140.Data and p140.Data.Tasks then
    for index68, value101 in ipairs(p140.Data.Tasks) do
      if (value101.Current or 0) < (value101.Required or 1) then
        v661 = true
        break
      end
    end
  end

  if not v661 then
    return false
  end

  local v662 = false
  local v663 = true

  for key36, value102 in pairs(v660) do
    local v664 = tostring(value102.ItemId or value102.itemId or "")
    local v665 = false

    if v658.RequiredItems and v658.RequiredItems[v664] then
      v665 = true
    end

    if not v665 and v658.GrantItems then
      for index69, value103 in ipairs(v658.GrantItems) do
        if tostring(value103.ItemId or "") == v664 then
          v665 = true
          break
        end
      end
    end

    if not v665 and questRequiredItemIds[v664] == true then
      v665 = true
    end

    if v665 then
      v662 = true

      if v658.RequireClean then
        local mutators2 = value102.Mutators

        if type(mutators2) == "table" then
          for index70, value104 in ipairs(mutators2) do
            if (type(value104) == "table" and (value104.name or value104.Name)
                or tostring(value104))
              == "Dirty" then
              v663 = false
              break
            end
          end
        end
      end
    end
  end

  if v662 and v663 then
    local id = v27.GetQuestHandInNPC(p140) or p140.Id
    local title5 = p140.Data and p140.Data.Title or "Quest"
    local v666 = id and v27.FindNPCPosition(id)

    if v666 then
      local cframe4 = CFrame.new(v666 + Vector3.new(0, 1.5, 0))
      local v667 = v27.FindNPCModel(id)

      if v667 then
        local humanoidRootPart20 = v667:FindFirstChild("HumanoidRootPart") or v667.PrimaryPart
          or v667:FindFirstChildWhichIsA("BasePart")

        if humanoidRootPart20 then
          local v668 = humanoidRootPart20.Position + humanoidRootPart20.CFrame.LookVector * 2.5

          cframe4 = CFrame.lookAt(
            Vector3.new(v668.X, humanoidRootPart20.Position.Y, v668.Z),
            humanoidRootPart20.Position
          )
        end
      end

      v29.SetStatus(
        "Quest", string.format("Delivering items for %s", title5),
        string.format("Traveling to %s...", id)
      )

      v15.TweenTo(cframe4)
      task.wait(0.4)
      local v669 = v27.InteractNPC(id, title5, "accept")
      task.wait(0.8)
      return v669
    end
  end

  return false
end

function v27.CheckGeneralServiceTasks(p141)
  local v670 = tostring(p141.Id or "")
  local v671 = tostring(p141.Type or "")

  if (p141.Current or 0) >= (p141.Required or 1) then
    return false
  end

  if v670 == "enter_vehicle" or v671 == "enter_vehicle" then
    v29.SetStatus("Quest", "Entering vehicle for quest", "Mounting driver seat...")
    pcall(v16.MountDriverSeat)
    task.wait(0.5)
    return true
  end

  if v670 == "use_drink" or v671 == "use_energy_drink" then
    local v672, v673 = v11.GetInventoryItems()

    if v672 and type(v673) == "table" then
      local items8 = v5.Items or {}

      for key37, value105 in pairs(v673) do
        local v674 = items8[tostring(value105.ItemId)]
        local guid2 = value105.Guid or value105.guid or key37

        if (tostring(value105.ItemId) == "359" or v674 and v674.EnergyDrinkId) and guid2 then
          v29.SetStatus("Quest", "Drinking Energy Drink", v674 and v674.Name or "Energy Drink")
          debug("[QuestBot] Consuming energy drink for quest (Guid=%s)...", tostring(guid2))
          v13.FireServer("UI", "UseEnergyDrink", guid2)
          task.wait(0.8)
          return true
        end
      end
    end
  end

  if v670 == "repair_items" or v671 == "repair_item" or v671 == "repair_limited"
    or string.find(string.lower(p141.Text or ""), "repair") then
    v29.SetStatus("Quest", "Repairing items at Repair Station")
    pcall(v23.RunRepair, true)
    return true
  end

  if v670 == "clean_items" or v671 == "clean_item"
    or string.find(string.lower(p141.Text or ""), "clean") then
    v29.SetStatus("Quest", "Cleaning items at Wash Station")
    pcall(v23.RunWash, true)
    return true
  end

  if v670 == "grade_items" or v671 == "grade_threestar" or v671 == "grade_min_stars"
    or string.find(string.lower(p141.Text or ""), "grade") then
    v29.SetStatus("Quest", "Grading items at Grading Station")
    pcall(v23.RunGrading, true)
    return true
  end

  if v670 == "unlock_safes" or v671 == "unlock_safe"
    or string.find(string.lower(p141.Text or ""), "safe") then
    v29.SetStatus("Quest", "Cracking safes at Locksmith")
    pcall(v23.RunLocksmith, true)
    return true
  end

  return false
end

v27.Branches = {}

v27.Branches["Story Progression"] = {
  Tag = "Story",
  MaxSlots = 2,
  NPCs = v27.ProgressionOrder,
  Execute = function(p142)
    local progressionOrder = v27.ProgressionOrder
    local v675 = v12.GetQuests()

    for key38, value106 in pairs(p142) do
      local v676 = v27.FindNPCFromQuest(value106)

      if v676 and table.find(progressionOrder, v676) then
        if v27.TurnInQuest(value106, false) then
          return true
        end
      end
    end

    for key39, value107 in pairs(p142) do
      local v677 = v27.FindNPCFromQuest(value107)

      if v677 and table.find(progressionOrder, v677) then
        if v27.CheckItemsDelivery(value107) then
          return true
        end
      end
    end

    for key40, value108 in pairs(p142) do
      local v678 = v27.FindNPCFromQuest(value108)

      if v678 and table.find(progressionOrder, v678) and value108.Data and value108.Data.Tasks then
        for index71, value109 in ipairs(value108.Data.Tasks) do
          if v27.CheckGeneralServiceTasks(value109) then
            return true
          end

          local v679 = tostring(value109.Id or "")
          local v680 = tostring(value109.Type or "")
          local current2 = value109.Current or 0
          local required2 = value109.Required or 1

          if current2 < required2 and v680 == "jailbreak_dig" then
            local bbowBuilderAssets2 = workspace:FindFirstChild("BBOW Builder Assets")

            local otherBuildingsAndDecoration2 = bbowBuilderAssets2
              and bbowBuilderAssets2:FindFirstChild("Other Buildings and  Decoration")

            local policeStation2 = otherBuildingsAndDecoration2
              and otherBuildingsAndDecoration2:FindFirstChild("Police Station")

            local findFirstChild29 = policeStation2
              and policeStation2:FindFirstChild("Tunnel", true)

            if findFirstChild29 then
              local findFirstChildWhichIsA6 = findFirstChild29:FindFirstChildWhichIsA(
                "ProximityPrompt", true
              )

              if findFirstChildWhichIsA6 and findFirstChildWhichIsA6.Enabled
                and typeof(fireproximityprompt) == "function" then
                local parent8 = findFirstChildWhichIsA6.Parent

                local position5 = parent8 and parent8:IsA("BasePart") and parent8.Position
                  or Vector3.new(176.1, 1721.2, -198.1)

                v29.SetStatus(
                  "Story", "Digging Jailbreak Tunnel",
                  string.format("Progress: %d/%d", current2, required2)
                )

                v15.TweenTo(position5 + Vector3.new(0, 1.5, 0))
                task.wait(0.3)
                pcall(fireproximityprompt, findFirstChildWhichIsA6, 0)
                task.wait(1)
                return true
              end
            end
          end

          if current2 < required2
            and (v679 == "sell_items" or v680 == "sell_item"
              or string.find(string.lower(value109.Text or ""), "shop")) then
            if v27.ProcessPlayerShopSelling(value108, value109) then
              return true
            end
          end
        end
      end
    end

    local count18 = 0

    for key41, value110 in pairs(p142) do
      local v681 = v27.FindNPCFromQuest(value110)

      if v681 and table.find(progressionOrder, v681) then
        count18 = count18 + 1
      end
    end

    if count18 < 2 and #p142 < 3 then
      local v682 = v27.FindEligibleNPC()

      if v682 then
        if v27.AcceptQuestFromNPC(v682) then
          return true
        end
      end
    end

    local v683, v684, v685, v686 = v27.GetNextProgressionTarget()

    if (v685 == "Active" or v685 == "ActiveWaitingSlot") and v684 then
      local title6 = v684.Data and v684.Data.Title or "Story Quest"
      local v687 = v675 and v675[v683]
      local area = v687 and v687.Area
      local v688 = ""

      if v684.Data and v684.Data.Tasks then
        for index72, value111 in ipairs(v684.Data.Tasks) do
          if (value111.Current or 0) < (value111.Required or 1) then
            v688 = string.format(
              "%s (%d/%d)", value111.Text or value111.Id or "Task", value111.Current or 0,
              value111.Required or 0
            )

            break
          end
        end
      end

      v29.SetStatus("Story", string.format("[%s] %s", v683, title6), v688)
      v27.EnsureInventorySpace(v684)

      if area and area ~= "" then
        local v689, v690, v691 = v27.FindQuestGaragePrompt(area)

        if v689 and v691 then
          return v27.RunAuctionCycle(v689, v691, v688, "Story")
        end

        v29.SetStatus(
          "Story", string.format("Waiting for %s garages...", area),
          "All target garages on cooldown"
        )

        task.wait(2.5)
        return false
      end

      local v692, v693, v694 = v27.FindHighestNWGaragePrompt()

      if v692 and v694 then
        return v27.RunAuctionCycle(v692, v694, nil, "Story")
      end

      v29.SetStatus("Story", "Waiting for garages...", "All garages on cooldown")
      task.wait(2.5)
      return false
    elseif v685 == "NeedNetWorth" then
      local v695 = v11.GetNetWorth()

      v29.SetStatus("Story", string.format(
        "Farming NW for %s ($%s / $%s)", v683, v14.Number(v695), v14.Number(v686 or 0)
      ), "Running highest NW garage auction...")

      local v696, v697, v698 = v27.FindHighestNWGaragePrompt()

      if v696 and v698 then
        v27.RunAuctionCycle(v696, v698, nil, "Story")
        v27.EnsureInventorySpace()
        return true
      end

      task.wait(2)
      return false
    elseif v685 == "Eligible" and v683 then
      return v27.AcceptQuestFromNPC(v683)
    end

    return false
  end,
}

v27.Branches.Fishing = {
  Tag = "Fishing",
  MaxSlots = 1,
  NPCs = { "Fisherman" },
  Execute = function(p143)
    for key42, value112 in pairs(p143) do
      if v27.FindNPCFromQuest(value112) == "Fisherman" then
        if v27.TurnInQuest(value112, false) then
          return true
        end
      end
    end

    for key43, value113 in pairs(p143) do
      if v27.FindNPCFromQuest(value113) == "Fisherman" and value113.Data and value113.Data.Tasks then
        for index73, value114 in ipairs(value113.Data.Tasks) do
          local v699 = tostring(value114.Id or "")
          local v700 = tostring(value114.Type or "")
          local current3 = value114.Current or 0
          local required3 = value114.Required or 1

          local v701 = v699 == "fish_items" or v699 == "fish_value" or string.find(v699, "fish")
            or string.find(v700, "fish")
            or string.find(string.lower(value114.Text or ""), "fish")

          if current3 < required3 and v701 then
            local character19 = localPlayer.Character
            local humanoid7 = character19 and character19:FindFirstChild("Humanoid")
            local tool = character19 and character19:FindFirstChildWhichIsA("Tool")
            local v702 = v27.IsValidFishingRod(tool)

            if tool and not v702 and humanoid7 then
              humanoid7:UnequipTools()
              tool = nil
            end

            if not v702 and humanoid7 then
              for index74, value115 in ipairs(localPlayer.Backpack:GetChildren()) do
                if value115:IsA("Tool") and v27.IsValidFishingRod(value115) then
                  humanoid7:EquipTool(value115)
                  task.wait(0.3)
                  v702 = true
                  tool = value115
                  break
                end
              end
            end

            if not v702 then
              local v703, v704 = v11.GetInventoryItems()

              if v703 and type(v704) == "table" then
                for key44, value116 in pairs(v704) do
                  if v27.IsValidFishingRod(value116) then
                    local guid3 = value116.Guid or value116.guid or key44

                    if guid3 then
                      local v705 = tostring(value116.ItemId or value116.id or "")
                      local items9 = v5.Items and v5.Items[v705]

                      v29.SetStatus(
                        "Fishing", "Equipping Fishing Rod",
                        items9 and items9.Name or "Fishing Rod"
                      )

                      v13.FireServer("Inventory", "EquipItem", guid3)
                      task.wait(0.8)
                      local tool2 = character19 and character19:FindFirstChildWhichIsA("Tool")

                      if tool2 and v27.IsValidFishingRod(tool2) then
                        v702 = true
                        tool = tool2
                      end

                      break
                    end
                  end
                end
              end
            end

            if not v702 then
              local v706, v707 = v11.GetVehicleItems()

              if v706 and type(v707) == "table" then
                for key45, value117 in pairs(v707) do
                  if v27.IsValidFishingRod(value117) then
                    local guid4 = value117.Guid or value117.guid or key45

                    if guid4 then
                      v29.SetStatus(
                        "Fishing", "Retrieving Fishing Rod from vehicle",
                        "Moving to inventory..."
                      )

                      v13.InvokeServer("Vehicles", "TransferVehicleToInventory", guid4)
                      task.wait(0.6)
                      v13.FireServer("Inventory", "EquipItem", guid4)
                      task.wait(0.8)
                      local tool3 = character19 and character19:FindFirstChildWhichIsA("Tool")

                      if tool3 and v27.IsValidFishingRod(tool3) then
                        v702 = true
                        tool = tool3
                      end

                      break
                    end
                  end
                end
              end
            end

            if not v702 then
              v29.SetStatus(
                "Fishing", "Hunting Fishing Rod in Farmyard",
                "[Fisherman] Hunting Fishing Rod in Farmyard garages"
              )

              local v708, v709, v710 = v27.FindQuestGaragePrompt("Farmyard")

              if v708 and v710 then
                return v27.RunAuctionCycle(
                  v708, v710, "[Fisherman] Hunting Fishing Rod in Farmyard garages", "Fishing"
                )
              end

              v29.SetStatus(
                "Fishing", "Waiting for Farmyard garages...",
                "[Fisherman] Need Fishing Rod - Waiting for Barn/Stable Garage"
              )

              task.wait(2.5)
              return true
            else
              local findFirstChild30 = workspace:FindFirstChild("Mall - Shop NPCs", true) and workspace["Mall - Shop NPCs"]:FindFirstChild(
                "Fisherman", true
              )

              local position6 = findFirstChild30 and findFirstChild30:GetPivot().Position
                or Vector3.new(514.34, 1719.52, -931.83)

              local humanoidRootPart21 = character19
                and character19:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart21 and (humanoidRootPart21.Position - position6).Magnitude > 5 then
                v29.SetStatus(
                  "Fishing", "Moving to Fishing Spot", "Positioning next to Fisherman..."
                )

                v15.TweenTo(position6)
                task.wait(0.4)
              end

              if humanoidRootPart21 then
                humanoidRootPart21.CFrame = CFrame.new(humanoidRootPart21.Position, humanoidRootPart21.Position
                  + Vector3.new(1, 0, 0))
              end

              local findFirstChild31 = workspace:FindFirstChild("BBOW Builder Assets", true) and workspace["BBOW Builder Assets"]:FindFirstChild(
                "Grass and Water", true
              )

              local findFirstChild32 = findFirstChild31
                and findFirstChild31:FindFirstChild("Water", true)

              local vector2 = Vector3.new(525, 1712.33, -930)
              local terrain = findFirstChild32 or workspace:FindFirstChildWhichIsA("Terrain")

              return v27.RunFishingSession(vector2, terrain, current3, required3, string.format(
                "[Fisherman] %s", value114.Text or "Fishing"
              ))
            end
          end
        end
      end
    end

    local v711 = false

    for key46, value118 in pairs(p143) do
      if v27.FindNPCFromQuest(value118) == "Fisherman" then
        v711 = true
        break
      end
    end

    if not v711 and #p143 < 3 then
      local v712 = v11.GetNetWorth()
      local v713 = v12.GetQuests()

      local minimumNetWorth3 = v713 and v713.Fisherman and v713.Fisherman.MinimumNetWorth
        or 10000

      if v712 >= minimumNetWorth3 then
        return v27.AcceptQuestFromNPC("Fisherman")
      else
        local v714 = string.format(
          "Need NW for Fisherman ($%s / $%s)", v14.Number(v712), v14.Number(minimumNetWorth3)
        )

        v29.SetStatus("Fishing", v714, "Farming NW...")
        local v715, v716, v717 = v27.FindHighestNWGaragePrompt()

        if v715 and v717 then
          return v27.RunAuctionCycle(v715, v717, v714, "Fishing")
        end
      end
    end

    return false
  end,
}

v27.Branches["Power Plant"] = {
  Tag = "Power Plant",
  MaxSlots = 1,
  NPCs = { "Engineer", "Mad Scientist" },
  Execute = function(p144)
    local v718 = { "Engineer", "Mad Scientist" }

    for key47, value119 in pairs(p144) do
      local v719 = v27.FindNPCFromQuest(value119)

      if v719 and table.find(v718, v719) then
        if v27.TurnInQuest(value119, false) then
          return true
        end
      end
    end

    for key48, value120 in pairs(p144) do
      local v720 = v27.FindNPCFromQuest(value120)

      if v720 and table.find(v718, v720) and value120.Data and value120.Data.Tasks then
        for index75, value121 in ipairs(value120.Data.Tasks) do
          local v721 = tostring(value121.Id or "")
          local v722 = tostring(value121.Type or "")
          local current4 = value121.Current or 0
          local required4 = value121.Required or 1

          local v723 = string.find(v721, "^install_t%d") or string.find(v721, "power_plant")
            or string.find(v722, "power_plant")
            or string.find(string.lower(value121.Text or ""), "tier%s*%d")
            or string.find(string.lower(value121.Text or ""), "install")

          if current4 < required4 and v723 then
            local v724 = tonumber(string.match(v721, "t(%d+)"))
              or tonumber(string.match(v722, "%d+$"))
              or tonumber(string.match(string.lower(value121.Text or ""), "tier%s*(%d+)")) or 1

            local v725 = v724 == 5 and "Weather Machine" or "Tier" .. v724

            local powerPlant = workspace:FindFirstChild("Areas")
              and workspace.Areas:FindFirstChild("Power Plant")

            local partsToFind = powerPlant and powerPlant:FindFirstChild("PartsToFind")
            local findFirstChild33 = partsToFind and partsToFind:FindFirstChild(v725)
            local v726, v727 = v11.GetInventoryItems()
            local v728 = {}

            if v726 and type(v727) == "table" then
              local items10 = v5.Items or {}

              for key49, value122 in pairs(v727) do
                local v729 = items10[tostring(value122.ItemId or value122.id or "")]
                local name10 = v729 and v729.Name or value122.Name

                if name10 then
                  v728[name10] = (v728[name10] or 0) + 1
                end
              end
            end

            local v730 = nil

            if findFirstChild33 then
              for index76, value123 in ipairs(findFirstChild33:GetChildren()) do
                local findFirstChildWhichIsA7 = value123:FindFirstChildWhichIsA(
                  "ProximityPrompt", true
                )

                if findFirstChildWhichIsA7 and findFirstChildWhichIsA7.Enabled
                  and (v728[value123.Name] or 0) > 0
                  and typeof(fireproximityprompt) == "function" then
                  v730 = { model = value123, prompt = findFirstChildWhichIsA7 }
                  break
                end
              end
            end

            if v730 then
              v29.SetStatus(
                "Power Plant", string.format("Installing Part (%d/%d)", current4, required4),
                string.format("Tier %d: %s", v724, v730.model.Name)
              )

              v15.TweenTo(v730.model:GetPivot().Position + Vector3.new(0, 1.5, 0))
              task.wait(0.3)
              pcall(fireproximityprompt, v730.prompt, 0)
              task.wait(0.8)
              return true
            else
              local v731 = "Power Plant Tier " .. v724 .. " Garage"
              local v732 = (v5.Garages or {})[v731]

              local minNetWorth6 = v732 and v732.MinNetWorth or v724 == 1 and 7500
                or v724 == 2 and 65000 or v724 == 3 and 600000 or 3500000

              local v733 = v11.GetNetWorth()

              if v733 < minNetWorth6 then
                v29.SetStatus("Power Plant", string.format("Need NW for Tier %d Garage", v724), string.format(
                  "Need $%s NW for %s (Have $%s) - Farming NW", v14.Number(minNetWorth6), v731,
                  v14.Number(v733)
                ))

                local v734, v735, v736 = v27.FindHighestNWGaragePrompt()

                if v734 and v736 then
                  local v737 = string.format(
                    "Farming %s to reach $%s Net Worth", v736.Name, v14.Number(minNetWorth6)
                  )

                  return v27.RunAuctionCycle(v734, v736, v737, "Power Plant")
                end

                task.wait(2.5)
                return true
              else
                local v738, v739, v740 = v27.FindGaragePromptByName(v731)

                if v738 and v740 then
                  local v741 = string.format(
                    "[Engineer] Farming %s for Tier %d parts", v740.Name, v724
                  )

                  return v27.RunAuctionCycle(v738, v740, v741, "Power Plant")
                end

                v29.SetStatus(
                  "Power Plant", string.format("Waiting for %s...", v731),
                  string.format("Waiting for %s to open...", v731)
                )

                task.wait(2.5)
                return true
              end
            end
          end
        end
      end
    end

    local v742 = false

    for key50, value124 in pairs(p144) do
      local v743 = v27.FindNPCFromQuest(value124)

      if v743 and table.find(v718, v743) then
        v742 = true
        break
      end
    end

    if not v742 and #p144 < 3 then
      local v744 = v11.GetNetWorth()
      local v745 = v12.GetQuests()
      local minimumNetWorth4 = v745 and v745.Engineer and v745.Engineer.MinimumNetWorth or 7500

      if v744 >= minimumNetWorth4 then
        return v27.AcceptQuestFromNPC("Engineer")
      else
        v29.SetStatus("Power Plant", string.format(
          "Need NW for Engineer ($%s / $%s)", v14.Number(v744), v14.Number(minimumNetWorth4)
        ), "Farming NW...")

        local v746, v747, v748 = v27.FindHighestNWGaragePrompt()

        if v746 and v748 then
          return v27.RunAuctionCycle(v746, v748, nil, "Power Plant")
        end
      end
    end

    return false
  end,
}

v27.Branches["Bobby & Terry"] = {
  Tag = "Bobby & Terry",
  MaxSlots = 1,
  NPCs = { "Bobby", "Terry" },
  Execute = function(p145)
    local v749 = { "Bobby", "Terry" }

    for key51, value125 in pairs(p145) do
      local v750 = v27.FindNPCFromQuest(value125)

      if v750 and table.find(v749, v750) then
        if v27.TurnInQuest(value125, false) then
          return true
        end
      end
    end

    for key52, value126 in pairs(p145) do
      local v751 = v27.FindNPCFromQuest(value126)

      if v751 and table.find(v749, v751) and value126.Data and value126.Data.Tasks then
        for index77, value127 in ipairs(value126.Data.Tasks) do
          if v27.CheckGeneralServiceTasks(value127) then
            return true
          end

          local v752 = tostring(value127.Type or "")
          local current5 = value127.Current or 0
          local required5 = value127.Required or 1

          if current5 < required5 and v752 == "luckquest_food_bobby0" then
            local v753, v754 = v11.GetInventoryItems()
            local count19 = 0
            local items11 = v5.Items or {}

            if v753 and type(v754) == "table" then
              for key53, value128 in pairs(v754) do
                local v755 = items11[tostring(value128.ItemId)]

                if v755 and v755.Category == "Food"
                  and (v755.Rarity == "Junk" or v755.Rarity == "Uncommon") then
                  count19 = count19 + 1
                end
              end
            end

            if count19 >= required5 then
              local bobby = v27.FindNPCPosition("Bobby")

              if bobby then
                v29.SetStatus(
                  "Bobby & Terry", "Delivering Food to Bobby",
                  string.format("Have %d/%d food items", count19, required5)
                )

                v15.TweenTo(bobby + Vector3.new(0, 1.5, 0))
                task.wait(0.3)
                v27.InteractNPC("Bobby", "Feed Bobby", "accept")
                task.wait(0.8)
                return true
              end
            else
              v29.SetStatus("Bobby & Terry", "Need Food for Bobby", string.format(
                "Have %d/%d (Collect in Junk Yard)", count19, required5
              ))
            end
          end

          if current5 < required5 and v752 == "luckquest_delivery_bobby1" then
            local v756, v757 = v11.GetInventoryItems()
            local v758 = false
            local count20 = 0

            if v756 and type(v757) == "table" then
              for key54, value129 in pairs(v757) do
                if tostring(value129.ItemId) == "158" then
                  count20 = count20 + 1
                  local mutators3 = value129.Mutators or value129.mutators or {}

                  if table.find(mutators3, "Dirty") or value129.Dirty then
                    v758 = true
                  end
                end
              end
            end

            if v758 then
              v29.SetStatus(
                "Bobby & Terry", "Washing Water Tanks", "RequireClean: Running wash station"
              )

              pcall(v23.RunWash, true)
              return true
            elseif count20 >= required5 then
              local terry = v27.FindNPCPosition("Terry")

              if terry then
                v29.SetStatus("Bobby & Terry", "Delivering Tanks to Terry", "All tanks clean")
                v15.TweenTo(terry + Vector3.new(0, 1.5, 0))
                task.wait(0.3)
                v27.InteractNPC("Terry", "Water Tank Delivery", "accept")
                task.wait(0.8)
                return true
              end
            elseif count20 < required5 then
              local bobby2 = v27.FindNPCPosition("Bobby")

              if bobby2 then
                v29.SetStatus(
                  "Bobby & Terry", "Regranting Tanks from Bobby",
                  string.format("Have %d/%d tanks", count20, required5)
                )

                v15.TweenTo(bobby2 + Vector3.new(0, 1.5, 0))
                task.wait(0.3)
                v27.InteractNPC("Bobby", "Water Tank Delivery", "accept")
                task.wait(0.8)
                return true
              end
            end
          end

          if current5 < required5 and v752 == "luckquest_delivery_bobby2" then
            pcall(v16.EquipBestVehicle, 420)

            local greenZone = workspace:FindFirstChild("_LuckQuests")
              and workspace._LuckQuests:FindFirstChild("Bobby_2")
              and workspace._LuckQuests.Bobby_2:FindFirstChild("GreenZone")

            local position7 = greenZone and greenZone.Position
              or Vector3.new(141.4, 1720.3, -660.5)

            v29.SetStatus(
              "Bobby & Terry", "Towing Bobby's Truck", "Traveling to Terry's GreenZone..."
            )

            v15.TweenTo(position7 + Vector3.new(0, 2, 0))
            task.wait(2.5)
            local terry2 = v27.FindNPCPosition("Terry")

            if terry2 then
              v29.SetStatus(
                "Bobby & Terry", "Reporting to Terry", "Bobby dropped off successfully"
              )

              v15.TweenTo(terry2 + Vector3.new(0, 1.5, 0))
              task.wait(0.3)
              v27.InteractNPC("Terry", "Truck Trouble", "accept")
              task.wait(0.8)
              return true
            end
          end
        end
      end
    end

    local v759 = false

    for key55, value130 in pairs(p145) do
      local v760 = v27.FindNPCFromQuest(value130)

      if v760 and table.find(v749, v760) then
        v759 = true
        break
      end
    end

    if not v759 and #p145 < 3 then
      return v27.AcceptQuestFromNPC("Bobby")
    end

    return false
  end,
}

function v27.CheckSpecialTasks(p146)
  local questsSelectedBranch7 = v6.QuestsSelectedBranch
    or f1 and f1("Dropdown_Quests_SelectedBranch") or "Story Progression"

  local v761 = v27.Branches[questsSelectedBranch7]

  if v761 and v761.Execute then
    return v761.Execute(p146 or v27.GetActiveQuests())
  end

  return false
end

function v27.AutoAbandonNonBranch(p147, p148)
  local v762 = v27.Branches[p147]
  local npCs = v762 and v762.NPCs or v27.ProgressionOrder
  local maxSlots = v762 and v762.MaxSlots or 1
  local v763 = {}
  local v764 = {}

  for key56, value131 in pairs(p148) do
    local v765 = v27.FindNPCFromQuest(value131)

    if (v765 and table.find(npCs, v765)) ~= nil then
      table.insert(v763, value131)
    else
      table.insert(v764, value131)
    end
  end

  local v766 = math.max(0, 3 - #p148)
  local v767 = math.max(0, maxSlots - #v763)
  local v768 = 0

  if v767 > 0 and v766 < v767 then
    v768 = v767 - v766
  end

  if v768 > 0 and #v764 > 0 then
    local function f8(p149)
      local v769 = 0
      local v770 = 0

      if p149.Data and p149.Data.Tasks and #p149.Data.Tasks > 0 then
        for index78, value132 in ipairs(p149.Data.Tasks) do
          local current6 = value132.Current or 0
          local required6 = value132.Required or 1

          if current6 < required6 then
            v769 = v769 + 1
            v770 = v770 + (required6 - current6)
          end
        end
      else
        v769 = 1
        v770 = 1
      end

      return v769, v770
    end

    table.sort(v764, function(p150, p151)
      local v771, v772 = f8(p150)
      local v773, v774 = f8(p151)

      if v771 ~= v773 then
        return v771 > v773
      end

      return v772 > v774
    end)

    local v775 = math.min(v768, #v764)
    local v776 = false

    for i15 = 1, v775 do
      local v777 = v764[i15]
      local v778 = tostring(v777.Id or "")

      debug(
        "[QuestBot] Auto-abandoning non-branch quest '%s' (%s) with %d unfinished task(s)",
        v777.Data and v777.Data.Title or v778, v778, (f8(v777))
      )

      if v27.CancelQuest(v778) then
        v776 = true
      end
    end

    if v776 then
      task.wait(0.4)
      return true
    end
  end

  return false
end

function v27.ProcessCycle()
  if not (v6.QuestsAutoStory or f1("Toggle_Quests_AutoStoryQuests")) then
    return false
  end

  local questsSelectedBranch8 = v6.QuestsSelectedBranch or f1("Dropdown_Quests_SelectedBranch")
    or "Story Progression"

  local storyProgression = v27.Branches[questsSelectedBranch8]
    or v27.Branches["Story Progression"]

  v27.UpdateRequiredItemsBlacklist()
  v27.EnsureInventorySpace()

  local v779 = v27.GetActiveQuests()
  local questsAutoAbandonNonBranch = v6.QuestsAutoAbandonNonBranch

  if questsAutoAbandonNonBranch == nil then
    questsAutoAbandonNonBranch = f1("Toggle_Quests_AutoAbandonNonBranch")
  end

  if questsAutoAbandonNonBranch then
    if v27.AutoAbandonNonBranch(questsSelectedBranch8, v779) then
      return true
    end
  end

  if storyProgression and storyProgression.Execute then
    return storyProgression.Execute(v779)
  end

  return false
end

function v27.StartLoop()
  if v6.IsQuestBotLoopRunning then
    return
  end

  v6.IsQuestBotLoopRunning = true

  v7.QuestBotThread = task.spawn(function()
    debug("[QuestBot] Auto Story Quests loop started.")

    while not v1.Unloaded and (v6.QuestsAutoStory or f1("Toggle_Quests_AutoStoryQuests")) do
      local v780, v781 = pcall(v27.ProcessCycle)

      if not v780 then
        debug("[QuestBot] ProcessCycle error: %s", tostring(v781))
      end

      task.wait(1)
    end

    v6.IsQuestBotLoopRunning = false
    v29.SetStatus("Quest", "Auto Story Quests paused", "Standby")
    debug("[QuestBot] Auto Story Quests loop stopped.")
  end)
end

function v27.StopLoop()
  v6.QuestsAutoStory = false
  local v782 = v7.QuestBotThread ~= nil

  if v7.QuestBotThread then
    pcall(task.cancel, v7.QuestBotThread)
    v7.QuestBotThread = nil
  end

  v15.Stop()

  v6.IsQuestBotLoopRunning = false
  v6.IsInAuction = false
  v6.IsEnteringAuction = false
  v6.IsPickupActive = false

  if v782 then
    v29.SetStatus("Quest", "Auto Story Quests stopped", "Standby")
    debug("[QuestBot] Auto Story Quests loop stopped.")
  end
end

function v27.StartProtectQuestItemsLoop()
  if v6.IsProtectQuestItemsLoopRunning then
    return
  end

  v6.IsProtectQuestItemsLoopRunning = true

  local function f9(p152)
    if type(p152) ~= "table" then
      return
    end

    for key57, value133 in pairs(p152) do
      local v783 = false

      repeat
        local guid5 = value133.Guid or value133.guid or key57

        if not guid5 then
          v783 = true
          break
        end

        local data5 = value133.Favorited == true
          or value133.Data and value133.Data.Favorited == true

        local v784 = v27.IsQuestRelatedItem(value133)

        if v784 and not data5 then
          v13.InvokeServer("Inventory", "ToggleFavoriteItem", guid5)
          task.wait(0.15)
        elseif not v784 and data5 then
          local v785 = tostring(value133.ItemId or value133.id
            or value133.Data and value133.Data.ItemId or "")

          local v786 = v785 == "374" or v785 == "330" or v785 == "375" or v785 == "328"
            or v785 == "329"

          local condition3 = value133.Condition or value133.Data and value133.Data.Condition

          local v787 = tostring(value133.Mutators or value133.Data and value133.Data.Mutators
            or "")

          if v786 and (condition3 and tonumber(condition3) == 0 or string.find(v787, "Broken")) then
            v13.InvokeServer("Inventory", "ToggleFavoriteItem", guid5)
            task.wait(0.15)
          end
        end

        v783 = true
      until true

      if not v783 then
        break
      end
    end
  end

  task.spawn(function()
    while not v1.Unloaded do
      local questsProtectItems2 = v6.QuestsProtectItems

      if questsProtectItems2 == nil then
        questsProtectItems2 = f1("Toggle_Quests_ProtectQuestItems")
      end

      if questsProtectItems2 == nil then
        questsProtectItems2 = true
      end

      if questsProtectItems2 then
        pcall(function()
          local v788, v789 = v11.GetInventoryItems()

          if v788 then
            f9(v789)
          end

          local v790, v791 = v11.GetVehicleItems()

          if v790 then
            f9(v791)
          end
        end)
      end

      task.wait(3)
    end

    v6.IsProtectQuestItemsLoopRunning = false
  end)
end

local function f10()
  if v6.IsAutoPickupLoopRunning then
    return
  end

  v6.IsAutoPickupLoopRunning = true

  task.spawn(function()
    v16.EnsureNearPlayer(35)
    local v792 = 0

    while not v1.Unloaded
      and (v6.FarmAuctionAutoPickupLoot or f1("Toggle_Farm_AuctionAutoPickupLoot")) do
      if v6.IsPickupActive and v15.CurrentTween == nil and not v20.IsAuctionActive() then
        if os.clock() - v792 > 3 then
          v792 = os.clock()

          if v16.GetDistanceToPlayer() > 35 then
            v16.EnsureNearPlayer(35)
            task.wait(0.2)
          end
        end

        pcall(function() v20.CollectNearbyLoot() end)
        task.wait(0.2)
      else
        task.wait(0.5)
      end
    end

    v6.IsAutoPickupLoopRunning = false
  end)
end

local function f11()
  if v6.IsFarmMasterLoopRunning then
    return
  end

  v6.IsFarmMasterLoopRunning = true

  v7.FarmMasterThread = task.spawn(function()
    while not v1.Unloaded do
      pcall(function()
        if v6.IsNavigatingManualGPS then
          task.wait(1)
          return
        end

        if v6.QuestsAutoStory or f1("Toggle_Quests_AutoStoryQuests") then
          task.wait(1)
          return
        end

        if localPlayer:GetAttribute("InJail") == true then
          v15.Stop()
          local v793 = tonumber(localPlayer:GetAttribute("JailReleaseAt")) or 0
          local v794 = math.max(0, math.ceil(v793 - os.clock()))

          if v794 > 0 then
            v29.SetStatus(
              "Farm", "Serving sentence",
              string.format("Releasing in %ds (Saving diamonds)", v794)
            )
          else
            v29.SetStatus("Farm", "Serving sentence", "Serving 60s sentence (Saving diamonds)")
          end

          task.wait(2)
          return
        end

        if v6.IsEnteringAuction and os.clock() - (v6.LastAuctionStartTime or 0) > 5 then
          v6.IsEnteringAuction = false
        end

        if v6.IsPickupActive and v6.PickupStartTime and os.clock() - v6.PickupStartTime > 30 then
          debug("[Watchdog] Pickup phase exceeded 30s timeout. Resetting IsPickupActive.")
          v6.IsPickupActive = false
          v6.PickupStartTime = nil
        end

        if not v6.IsPickupActive and not v20.IsAuctionActive() then
          v7.CurrentAuctionZone = nil
          v7.CurrentAuctionPos = nil
          v7.CurrentAuctionGarageModel = nil
        end

        if v20.IsAuctionActive() then
          v15.Stop()
          task.wait(1)
          return
        end

        if v6.IsPickupActive then
          local v795 = v11.GetInventoryCount() >= v11.GetInventoryMax()
          local v796 = v11.GetVehicleCargoWeight()
          local v797 = v11.GetVehicleCargoWeightLimit()

          if not (v795 and v797 > 0 and v796 / v797 > 0.9) then
            v6.IsSellingActive = false
            local currentAuctionZone2 = v7.CurrentAuctionZone

            local position8 = currentAuctionZone2 and currentAuctionZone2.Position
              or v7.CurrentAuctionPos

            local character20 = localPlayer.Character

            local humanoidRootPart22 = character20
              and character20:FindFirstChild("HumanoidRootPart")

            if position8 and humanoidRootPart22 then
              local magnitude12 = (humanoidRootPart22.Position - position8).Magnitude

              if magnitude12 > 6 and v15.CurrentTween == nil then
                v29.SetStatus(
                  "Auction", "Returning to auction garage",
                  string.format("Distance: %.0f studs", magnitude12)
                )

                debug(
                  "[Auction/Pickup] Returning to auction garage (dist=%.1f studs) to finish collecting loot...",
                  magnitude12
                )

                v15.TweenTo(position8 + Vector3.new(0, 1.5, 0))
                task.wait(0.3)
              elseif magnitude12 <= 6 and v15.CurrentTween == nil then
                v29.SetStatus(
                  "Auction", "Collecting loot at garage", "Searching garage area..."
                )
              end
            end

            if v6.FarmAuctionAutoPickupLoot or f1("Toggle_Farm_AuctionAutoPickupLoot") then
              f10()
            end

            task.wait(0.8)
            return
          end
        end

        local v798 = v11.GetVehicleCargoWeight()
        local v799 = v11.GetVehicleCargoWeightLimit()
        local v800 = v799 > 0 and v798 / v799 or 0
        local v801 = v11.GetInventoryCount()
        local v802 = v11.GetInventoryMax()
        local v803 = v802 > 0 and v801 >= v802
        local farmClearInventoryBeforeAuction = v6.FarmClearInventoryBeforeAuction

        if farmClearInventoryBeforeAuction == nil then
          farmClearInventoryBeforeAuction = f1("Toggle_Farm_ClearInventoryBeforeAuction")
        end

        if farmClearInventoryBeforeAuction == nil then
          farmClearInventoryBeforeAuction = true
        end

        local farmAuctionAutoStartAuction2 = v6.FarmAuctionAutoStartAuction

        if farmAuctionAutoStartAuction2 == nil then
          farmAuctionAutoStartAuction2 = f1("Toggle_Farm_AuctionAutoStartAuction")
        end

        local farmPawnAutoSell = v6.FarmPawnAutoSell

        if farmPawnAutoSell == nil then
          farmPawnAutoSell = f1("Toggle_Farm_PawnAutoSell")
        end

        local farmPlayerShopAutoSell = v6.FarmPlayerShopAutoSell

        if farmPlayerShopAutoSell == nil then
          farmPlayerShopAutoSell = f1("Toggle_Farm_PlayerShopAutoSell")
        end

        local farmPlayerShopAutoUnloadAtPlot = v6.FarmPlayerShopAutoUnloadAtPlot

        if farmPlayerShopAutoUnloadAtPlot == nil then
          farmPlayerShopAutoUnloadAtPlot = f1("Toggle_Farm_PlayerShopAutoUnloadAtPlot")
        end

        local v804 = (farmPawnAutoSell or farmPlayerShopAutoSell
            or farmPlayerShopAutoUnloadAtPlot)
          == true

        local v805 = v11.GetVehicleItemCount()
        local v806 = v799 > 0 and v800 >= 0.1 or v805 > 0 or v798 > 0
        local v807 = v801 > 0

        local isVehicleFull = v799 > 0 and v800 > 0.9 or v6.IsVehicleFull and v800 >= 0.4
          or v803 and v800 >= 0.3 or farmClearInventoryBeforeAuction and v803

        local v808 = isVehicleFull or not farmAuctionAutoStartAuction2 and (v806 or v807)

        if not v804 then
          v6.IsSellingActive = false

          if farmAuctionAutoStartAuction2 and (isVehicleFull or v6.IsVehicleFull) then
            v29.SetStatus(
              "Auction", "Vehicle cargo full", "Paused: Free up space or enable Auto Sell"
            )

            task.wait(3)
            return
          end
        elseif v808 then
          if (v799 <= 0 or v800 < 0.1 or v805 == 0)
            and (not farmClearInventoryBeforeAuction and farmAuctionAutoStartAuction2
              or v801 <= 0) then
            v6.IsSellingActive = false
            v6.IsVehicleFull = false

            v7.IgnoredHeavyPrompts = nil

            debug(
              "[Shop/Cycle] Selling phase complete (Vehicle cargo %.1f%% < min 10%%, Inv %d/%d). Resuming tasks.",
              v800 * 100, v801, v802
            )

            v29.SetStatus("Farm", "Storage cleared successfully", "Resuming next tasks...")
          else
            local farmPawnAutoSell2 = v6.FarmPawnAutoSell

            if farmPawnAutoSell2 == nil then
              farmPawnAutoSell2 = f1("Toggle_Farm_PawnAutoSell")
            end

            local farmPlayerShopAutoSell2 = v6.FarmPlayerShopAutoSell

            if farmPlayerShopAutoSell2 == nil then
              farmPlayerShopAutoSell2 = f1("Toggle_Farm_PlayerShopAutoSell")
            end

            local farmPlayerShopAutoUnloadAtPlot2 = v6.FarmPlayerShopAutoUnloadAtPlot

            if farmPlayerShopAutoUnloadAtPlot2 == nil then
              farmPlayerShopAutoUnloadAtPlot2 = f1("Toggle_Farm_PlayerShopAutoUnloadAtPlot")
            end

            local v809 = false
            local v810 = 1

            local farmPawnMinMultiplier2 = v6.FarmPawnMinMultiplier
              or f1("Slider_Farm_PawnMinMultiplier") or 1

            if farmPawnAutoSell2 then
              local v811 = v21.GetPawnState()
              local rate4 = v811.rate or v811.Rate or v7.CurrentPawnRate or 1
              v810 = math.floor(rate4 * 100 + 0.5) / 100

              if v810 >= farmPawnMinMultiplier2 then
                v809 = true
              end
            end

            if farmPawnAutoSell2 and v809 then
              v6.IsSellingActive = true
              v7.PawnRateWaitStartTime = nil

              v29.SetStatus("Pawn Shop", "Selling storage items", string.format(
                "Rate: %.2fx >= Min: %.2fx", v810, farmPawnMinMultiplier2
              ))

              debug("[Auction/Travel] Selling items at Pawn Shop (cargo=%.1f kg)...", v798)
              v21.SellAll({ "Vehicle", "Inventory" })
              task.wait(1.5)
              local v812 = v11.GetVehicleCargoWeight()
              local v813 = v799 > 0 and v812 / v799 or 0
              local v814 = v799 <= 0 or v813 < 0.1 or v11.GetVehicleItemCount() == 0
              local v815 = v11.GetInventoryCount()

              if v814 and (not farmClearInventoryBeforeAuction or v815 <= 0) then
                v6.IsSellingActive = false
                v6.IsVehicleFull = false

                v7.IgnoredHeavyPrompts = nil

                debug(
                  "[Auction/Travel] Items sold at Pawn Shop (cargo %.1f%%, inv %d/%d). Resuming tasks.",
                  v813 * 100, v815, v11.GetInventoryMax()
                )

                v29.SetStatus(
                  "Pawn Shop", "Storage cleared at Pawn Shop", "Resuming next tasks..."
                )

                local farmAuctionAutoClaimLostItems = v6.FarmAuctionAutoClaimLostItems

                if farmAuctionAutoClaimLostItems == nil then
                  farmAuctionAutoClaimLostItems = f1("Toggle_Farm_AuctionAutoClaimLostItems")
                end

                if farmAuctionAutoClaimLostItems == true then
                  v20.ClaimAllLostItems(true)
                end
              end

              return
            elseif farmPlayerShopAutoSell2 or farmPlayerShopAutoUnloadAtPlot2 then
              v6.IsSellingActive = true
              v7.PawnRateWaitStartTime = nil

              v29.SetStatus(
                "Player Shop", "Traveling to Plot to unload",
                string.format("Cargo: %.0f/%.0f kg", v798, v799)
              )

              debug("[Auction/Travel] Pawn Shop condition not met (or disabled). Moving to Plot to unload/sell...")
              local v816, v817 = v16.UnloadAtPlot()

              if not v816 then
                if v817 == "InventoryFull" then
                  v29.SetStatus("Player Shop", "Inventory full at Plot", string.format(
                    "Waiting for shoppers (%d/%d)", v11.GetInventoryCount(),
                    v11.GetInventoryMax()
                  ))

                  if farmPlayerShopAutoSell2 then
                    debug("[Auction/Travel] Shelves/Inventory full at Plot. Waiting for NPC shoppers to purchase items...")
                    local v818 = os.clock()

                    while not v1.Unloaded and os.clock() - v818 < 15 do
                      v22.ProcessPendingShopperOffers()

                      if v6.FarmPlayerShopAutoStockShelves
                        or f1("Toggle_Farm_PlayerShopAutoStockShelves") then
                        v22.StockShelves()
                      end

                      task.wait(2)
                    end
                  else
                    v6.IsSellingActive = false

                    v29.SetStatus(
                      "Player Shop", "Inventory & Shelves full",
                      "Paused: Free up space at Plot!"
                    )

                    task.wait(10)
                  end

                  return
                end

                v6.IsSellingActive = false
                v29.SetStatus("Player Shop", "Unload failed at Plot", "Retrying in 3s...")
                task.wait(3)
                return
              else
                if v6.FarmPlayerShopAutoStockShelves
                  or f1("Toggle_Farm_PlayerShopAutoStockShelves") then
                  task.wait(0.4)
                  v22.StockShelves()
                end

                if farmPlayerShopAutoSell2 then
                  v29.SetStatus(
                    "Player Shop", "Waiting for NPC shoppers", "Serving visiting shoppers..."
                  )

                  debug("[Auction/Travel] Waiting at Plot for visiting NPC shoppers to buy items...")
                  local v819 = os.clock()

                  while not v1.Unloaded and os.clock() - v819 < 8 do
                    v22.ProcessPendingShopperOffers()
                    task.wait(1.5)
                  end
                end

                local v820 = v11.GetVehicleCargoWeight()
                local v821 = v799 > 0 and v820 / v799 or 0
                local v822 = v799 <= 0 or v821 < 0.1 or v11.GetVehicleItemCount() == 0
                local v823 = v11.GetInventoryCount()

                if v822 and (not farmClearInventoryBeforeAuction or v823 <= 0) then
                  v6.IsSellingActive = false
                  v6.IsVehicleFull = false

                  v7.IgnoredHeavyPrompts = nil

                  debug(
                    "[Auction/Travel] Storage cleared at Plot (cargo %.1f%% < min 10%%, inv %d/%d). Resuming tasks.",
                    v821 * 100, v823, v11.GetInventoryMax()
                  )

                  v29.SetStatus("Player Shop", "Storage cleared at Plot", string.format(
                    "Veh: %.0f%% | Inv: %d/%d items", v821 * 100, v823, v11.GetInventoryMax()
                  ))

                  local farmAuctionAutoClaimLostItems2 = v6.FarmAuctionAutoClaimLostItems

                  if farmAuctionAutoClaimLostItems2 == nil then
                    farmAuctionAutoClaimLostItems2 = f1("Toggle_Farm_AuctionAutoClaimLostItems")
                  end

                  if farmAuctionAutoClaimLostItems2 == true then
                    v20.ClaimAllLostItems(true)
                  end
                else
                  debug(
                    "[Auction/Travel] Vehicle unloaded (cargo %.1f%%) but inventory remaining (%d/%d). Continuing Plot sale...",
                    v821 * 100, v823, v11.GetInventoryMax()
                  )
                end

                task.wait(1)
                return
              end
            else
              v6.IsSellingActive = false

              if farmPawnAutoSell2 and not v809 then
                if farmPlayerShopAutoSell2 or v6.FarmPlayerShopAutoStockShelves
                  or farmPlayerShopAutoUnloadAtPlot2 then
                  v7.PawnRateWaitStartTime = nil

                  debug(
                    "[Auction/Travel] Pawn rate low (%.2fx < %.2fx), redirecting to Plot to unload instead...",
                    v810, farmPawnMinMultiplier2
                  )

                  v29.SetStatus(
                    "Pawn Shop", "Pawn rate low, redirecting to Plot",
                    string.format("Rate: %.2fx. Moving to Plot...", v810)
                  )

                  v16.UnloadAtPlot()
                  task.wait(1)
                  return
                end

                if not v7.PawnRateWaitStartTime then
                  v7.PawnRateWaitStartTime = os.clock()
                end

                local v824 = os.clock() - v7.PawnRateWaitStartTime

                v29.SetStatus("Pawn Shop", "Waiting for higher Pawn rate", string.format(
                  "Rate: %.2fx < %.2fx [%ds remaining]", v810, farmPawnMinMultiplier2,
                  math.floor(v824)
                ))

                debug(
                  "[Auction/Travel] Vehicle near capacity (%.1f/%.1f kg), Pawn rate %.2fx < %.2fx (waiting %ds)...",
                  v798, v799, v810, farmPawnMinMultiplier2, math.floor(v824)
                )

                task.wait(4)
                return
              end

              v7.PawnRateWaitStartTime = nil

              v29.SetStatus(
                "Farm", "Vehicle cargo full", "Paused: Enable Auto Sell in Pawn or Player Shop"
              )

              debug("[Auction/Travel] Paused: Vehicle full. Enable Auto Sell or Player Shop Unload.")
              task.wait(3)
              return
            end
          end
        else
          v6.IsSellingActive = false
        end

        if farmAuctionAutoStartAuction2 and v804 and farmClearInventoryBeforeAuction
          and v11.GetInventoryCount() > 0 then
          v6.IsSellingActive = true
          v29.SetStatus("Farm", "Clearing personal inventory", "Selling inventory items...")
          task.wait(1)
          return
        end

        local farmMinigamesEnabled = v6.FarmMinigamesEnabled or false

        if farmMinigamesEnabled then
          v26.ProcessCycle(function()
            return v20.IsAuctionActive() or v6.IsPickupActive or v6.IsNavigatingManualGPS
          end)
        end

        local farmAuctionAutoStartAuction3 = v6.FarmAuctionAutoStartAuction

        if farmAuctionAutoStartAuction3 == nil then
          farmAuctionAutoStartAuction3 = f1("Toggle_Farm_AuctionAutoStartAuction")
        end

        if farmAuctionAutoStartAuction3 then
          local v825 = os.clock()

          if not v20.LastPromptTriggerTime or v825 - v20.LastPromptTriggerTime >= 5 then
            local v826, v827 = v20.FindNearestGaragePrompt()

            if v826 and v826.Parent then
              local objectText3 = v826.ObjectText or "Garage"
              local parent9 = v826.Parent
              local position9 = parent9.Position
              local parent10 = parent9

              while parent10 and parent10.Parent and parent10.Parent.Name ~= "Garages" do
                parent10 = parent10.Parent
              end

              local v828 = parent10
              local auctionZone = v828 and v828:FindFirstChild("AuctionZone")
              local v829 = position9 + Vector3.new(0, 1.5, 0)

              if v827 > 5 then
                v29.SetStatus(
                  "Auction", string.format("Traveling to %s", objectText3),
                  string.format("Distance: %.0f studs", v827)
                )

                debug("[Auction/Travel] Moving to %s (dist=%.1f studs)...", objectText3, v827)
                v15.TweenTo(v829)
              end

              v15.Stop()

              if auctionZone then
                v7.CurrentAuctionZone = auctionZone
              end

              v7.CurrentAuctionGarageModel = v828

              v7.CurrentAuctionPos = auctionZone
                  and auctionZone.Position + Vector3.new(0, 1.5, 0)
                or v829

              v6.IsEnteringAuction = true
              v6.LastAuctionStartTime = os.clock()

              v20.LastPromptTriggerTime = os.clock()

              v29.SetStatus(
                "Auction", string.format("Entering %s auction", objectText3),
                "Triggering auction prompt..."
              )

              StartAutoBidLoop()

              for i16 = 1, 3 do
                if v6.IsInAuction or not v6.IsEnteringAuction then
                  break
                end

                if not v826.Parent or not v826.Enabled then
                  break
                end

                pcall(function() v826.HoldDuration = 0 end)
                fireproximityprompt(v826, 0)

                debug(
                  "[Auction/Start] Triggered EnterAuction prompt at %s (attempt %d)",
                  objectText3, i16
                )

                task.wait(0.4)
              end

              task.wait(1.5)
              return
            end

            v29.SetStatus(
              "Auction", "No eligible garages found", "Waiting for garage refresh..."
            )

            debug(
              "[Auction/Travel] No eligible garage found for current Net Worth ($%s) and Cash ($%s)",
              v14.Number(v11.GetNetWorth()), v14.Number(v11.GetCash())
            )

            task.wait(2)
            return
          end
        end

        if not farmAuctionAutoStartAuction3 and not farmMinigamesEnabled
          and not (v6.QuestsAutoStory or v6.IsQuestBotLoopRunning) then
          v29.SetStatus("Farm", "Idle: Standing by", "Awaiting tasks...")
          task.wait(2)
        else
          task.wait(1)
        end
      end)

      task.wait(0.5)
    end

    v6.IsFarmMasterLoopRunning = false
  end)
end

local function f12(p153)
  local farmAuctionAutoStartAuction4 = v6.FarmAuctionAutoStartAuction
    or f1("Toggle_Farm_AuctionAutoStartAuction")

  local farmPawnAutoSell3 = v6.FarmPawnAutoSell or f1("Toggle_Farm_PawnAutoSell")

  local farmPlayerShopAutoSell3 = v6.FarmPlayerShopAutoSell
    or f1("Toggle_Farm_PlayerShopAutoSell")

  local farmPlayerShopAutoStockShelves = v6.FarmPlayerShopAutoStockShelves
    or f1("Toggle_Farm_PlayerShopAutoStockShelves")

  if p153
    or not (farmAuctionAutoStartAuction4 or farmPawnAutoSell3 or farmPlayerShopAutoSell3
      or farmPlayerShopAutoStockShelves) then
    if v7.FarmMasterThread then
      pcall(task.cancel, v7.FarmMasterThread)
      v7.FarmMasterThread = nil
    end

    v15.Stop()

    v6.IsFarmMasterLoopRunning = false
    v6.IsInAuction = false
    v6.IsEnteringAuction = false
    v6.IsPickupActive = false
    v6.IsSellingActive = false

    v29.SetStatus("Farm", "Auto Farm stopped", "Standby")
  else
    v15.Stop()
    v6.IsInAuction = false
    v6.IsEnteringAuction = false
  end
end

local function f13()
  if v6.IsAutoBidLoopRunning then
    return
  end

  v6.IsAutoBidLoopRunning = true

  task.spawn(function()
    local v830 = 0

    while not v1.Unloaded and (v6.FarmAuctionAutoBid or f1("Toggle_Farm_AuctionAutoBid")) do
      pcall(function()
        local settingsAutoDismissTips3 = v6.SettingsAutoDismissTips

        if settingsAutoDismissTips3 == nil then
          settingsAutoDismissTips3 = f1("Toggle_Settings_AutoDismissTips")
        end

        if settingsAutoDismissTips3 and v20.IsAuctionActive() then
          local playerGui14 = localPlayer:FindFirstChild("PlayerGui")
          local uiControllerGui8 = playerGui14 and playerGui14:FindFirstChild("UIControllerGui")
          local shopPanel = uiControllerGui8 and uiControllerGui8:FindFirstChild("ShopPanel")

          if shopPanel and shopPanel.Visible then
            pcall(function()
              require(replicatedStorage.Modules.UIController):Close("Shop")
              debug("[Auction] Auto-closed Shop modal")
            end)
          end
        end

        pcall(function()
          local character21 = localPlayer.Character

          local humanoidRootPart23 = character21
            and character21:FindFirstChild("HumanoidRootPart")

          local findFirstChild34 = ui and ui:FindFirstChild("AuctionWarningBar", true)
          local v831 = findFirstChild34 and findFirstChild34.Visible == true
          local auctionWarning = false

          pcall(function()
            auctionWarning = require(replicatedStorage.Modules.UIController):IsOpen("AuctionWarning")
          end)

          if (v831 or auctionWarning) and humanoidRootPart23 then
            local currentAuctionZone3 = v7.CurrentAuctionZone

            if not currentAuctionZone3 or not currentAuctionZone3.Parent then
              local garages6 = workspace:FindFirstChild("_Debris")
                and workspace._Debris:FindFirstChild("Garages")

              if garages6 then
                local v832 = 50

                for index79, value134 in ipairs(garages6:GetChildren()) do
                  local findFirstChild35 = value134:FindFirstChild("AuctionZone", true)

                  if findFirstChild35 and findFirstChild35:IsA("BasePart") then
                    local magnitude13 = (findFirstChild35.Position - humanoidRootPart23.Position).Magnitude

                    if magnitude13 < v832 then
                      v832 = magnitude13
                      currentAuctionZone3 = findFirstChild35
                    end
                  end
                end
              end
            end

            if currentAuctionZone3 and currentAuctionZone3:IsA("BasePart") then
              v15.TweenTo(currentAuctionZone3.Position + Vector3.new(0, 1.5, 0), 25)
              debug("[Auction] Restored player to AuctionZone center (prevented auction timeout kick)")
            end
          end
        end)

        local v833 = v20.GetBidBarElements()

        if not v833 then
          if not v6.IsPickupActive and not v6.IsFarmMasterLoopRunning then
            if os.clock() - v830 > 1 then
              v830 = os.clock()
              v29.SetStatus("Auction", "Waiting for auction to start", "Auto Bid active")
            end
          end

          task.wait(0.2)
          return
        end

        local v834 = v20.GetCurrentNextBid(v833.Container)
        local v835 = v20.CalculateMaxBid()

        if v834 > 0 then
          local v836 = string.format("%d_%d", v834, v835)

          if v834 > v835 then
            if v7.LastDisplayedStatusKey ~= v836 then
              v7.LastDisplayedStatusKey = v836

              v29.SetStatus("Auction", "Budget exceeded", string.format(
                "Next $%s > Max Budget $%s", v14.Number(v834), v14.Number(v835)
              ))
            end

            if not v6.IsWinningAuction then
              v20.LeaveAuction(string.format(
                "Next $%s > Max Budget $%s", v14.Number(v834), v14.Number(v835)
              ))
            end

            task.wait(0.2)
            return
          end

          if v7.LastDisplayedStatusKey ~= v836 then
            v7.LastDisplayedStatusKey = v836

            v29.SetStatus(
              "Auction", string.format("Bidding: Next $%s", v14.Number(v834)),
              string.format("Max Budget: $%s", v14.Number(v835))
            )
          end
        end

        if v20.IsCursorInZone(v833) then
          v20.PerformBid(v833)
          task.wait(0.2)
        end
      end)

      task.wait(0.01)
    end

    v6.IsAutoBidLoopRunning = false

    if not v6.IsPickupActive and not v6.IsFarmMasterLoopRunning then
      v29.SetStatus("Auction", "Auto Bid disabled", "Standby")
    end
  end)
end

local function f14()
  if v6.IsAutoServicesLoopRunning then
    return
  end

  v6.IsAutoServicesLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded do
      local servicesAutoWash3 = v6.ServicesAutoWash

      if servicesAutoWash3 == nil then
        servicesAutoWash3 = f1("Toggle_Services_AutoWash")
      end

      local servicesAutoRepair3 = v6.ServicesAutoRepair

      if servicesAutoRepair3 == nil then
        servicesAutoRepair3 = f1("Toggle_Services_AutoRepair")
      end

      local servicesAutoGrade3 = v6.ServicesAutoGrade

      if servicesAutoGrade3 == nil then
        servicesAutoGrade3 = f1("Toggle_Services_AutoGrade")
      end

      local servicesAutoCrackSafes3 = v6.ServicesAutoCrackSafes

      if servicesAutoCrackSafes3 == nil then
        servicesAutoCrackSafes3 = f1("Toggle_Services_AutoCrackSafes")
      end

      if not (servicesAutoWash3 or servicesAutoRepair3 or servicesAutoGrade3
        or servicesAutoCrackSafes3) then
        break
      end

      pcall(v23.ProcessLoop)
      task.wait(3)
    end

    v6.IsAutoServicesLoopRunning = false
    v23.UpdateStatusParagraph()
  end)
end

local function f15()
  if v6.IsUpdateParagraphsLoopRunning then
    return
  end

  v6.IsUpdateParagraphsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded do
      pcall(function()
        if v9.FarmOverview or v9.AuctionStatus then
          v20.RefreshStatsContent()
          v20.UpdateStatusParagraph()
        end

        if v9.ShopOverview then
          pcall(v25.UpdateShopOverview)
        end

        if v9.ServicesStatus then
          v23.UpdateStatusParagraph()
        end

        local settingsAutoDismissTips4 = v6.SettingsAutoDismissTips

        if settingsAutoDismissTips4 == nil then
          settingsAutoDismissTips4 = f1("Toggle_Settings_AutoDismissTips")
        end

        if settingsAutoDismissTips4 then
          v20.DismissDiscoveryPopup()
          local playerGui15 = localPlayer:FindFirstChild("PlayerGui")

          if playerGui15 then
            for index80, value135 in ipairs(playerGui15:GetChildren()) do
              if value135:IsA("ScreenGui")
                and (string.find(value135.Name, "Tip") or string.find(value135.Name, "Tutorial")) then
                local findFirstChild36 = value135:FindFirstChild("CloseButton", true)
                  or value135:FindFirstChild("OkButton", true)

                if findFirstChild36 and findFirstChild36:IsA("GuiButton") and firesignal then
                  pcall(firesignal, findFirstChild36.Activated)
                end
              end
            end
          end
        end
      end)

      task.wait(3)
    end

    v6.IsUpdateParagraphsLoopRunning = false
  end)
end

local function f16()
  if v6.IsAutoClaimRewardsLoopRunning then
    return
  end

  v6.IsAutoClaimRewardsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded do
      local rewardsAutoClaimDaily = v6.RewardsAutoClaimDaily

      if rewardsAutoClaimDaily == nil then
        rewardsAutoClaimDaily = f1("Toggle_Rewards_AutoClaimDaily")
      end

      local rewardsAutoClaimAchievements = v6.RewardsAutoClaimAchievements

      if rewardsAutoClaimAchievements == nil then
        rewardsAutoClaimAchievements = f1("Toggle_Rewards_AutoClaimAchievements")
      end

      local rewardsAutoClaimCollections = v6.RewardsAutoClaimCollections

      if rewardsAutoClaimCollections == nil then
        rewardsAutoClaimCollections = f1("Toggle_Rewards_AutoClaimCollections")
      end

      if not (rewardsAutoClaimDaily or rewardsAutoClaimAchievements or rewardsAutoClaimCollections) then
        break
      end

      pcall(function()
        if rewardsAutoClaimDaily then
          local v837, v838 = v24.GetDailyRewardStatus()

          if v838 then
            v24.ClaimDailyReward()
          end
        end

        if rewardsAutoClaimAchievements then
          v24.ClaimAchievements()
        end

        if rewardsAutoClaimCollections then
          v24.ClaimCollections()
        end
      end)

      task.wait(10)
    end

    v6.IsAutoClaimRewardsLoopRunning = false
  end)
end

local function f17()
  if v6.IsAutoUpgradeLoopRunning then
    return
  end

  v6.IsAutoUpgradeLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded do
      local shopAutoUpgrade = v6.ShopAutoUpgrade

      if shopAutoUpgrade == nil then
        shopAutoUpgrade = f1("Toggle_Shop_AutoUpgrade")
      end

      if shopAutoUpgrade == nil then
        shopAutoUpgrade = v6.FarmAutoUpgrade or f1("Toggle_Farm_AutoUpgrade")
      end

      local shopAutoHireStaff2 = v6.ShopAutoHireStaff

      if shopAutoHireStaff2 == nil then
        shopAutoHireStaff2 = f1("Toggle_Shop_AutoHireStaff")
      end

      if shopAutoHireStaff2 == nil then
        shopAutoHireStaff2 = v6.FarmAutoHireStaff or f1("Toggle_Farm_AutoHireStaff")
      end

      local shopAutoUpgradeStaff2 = v6.ShopAutoUpgradeStaff

      if shopAutoUpgradeStaff2 == nil then
        shopAutoUpgradeStaff2 = f1("Toggle_Shop_AutoUpgradeStaff")
      end

      if shopAutoUpgradeStaff2 == nil then
        shopAutoUpgradeStaff2 = v6.FarmAutoUpgradeStaff or f1("Toggle_Farm_AutoUpgradeStaff")
      end

      local shopAutoUnlockStationSlots2 = v6.ShopAutoUnlockStationSlots

      if shopAutoUnlockStationSlots2 == nil then
        shopAutoUnlockStationSlots2 = f1("Toggle_Shop_AutoUnlockStationSlots")
      end

      local shopAutoBuyBestWrench2 = v6.ShopAutoBuyBestWrench

      if shopAutoBuyBestWrench2 == nil then
        shopAutoBuyBestWrench2 = f1("Toggle_Shop_AutoBuyBestWrench")
      end

      local shopAutoBuyBestLockpick2 = v6.ShopAutoBuyBestLockpick

      if shopAutoBuyBestLockpick2 == nil then
        shopAutoBuyBestLockpick2 = f1("Toggle_Shop_AutoBuyBestLockpick")
      end

      local shopAutoEquipBestAccessories = v6.ShopAutoEquipBestAccessories

      if shopAutoEquipBestAccessories == nil then
        shopAutoEquipBestAccessories = f1("Toggle_Shop_AutoEquipBestAccessories")
      end

      local shopAutoBuyAndEquipVehicle = v6.ShopAutoBuyAndEquipVehicle

      if shopAutoBuyAndEquipVehicle == nil then
        shopAutoBuyAndEquipVehicle = f1("Toggle_Shop_AutoBuyAndEquipVehicle")
      end

      if not (shopAutoUpgrade or shopAutoHireStaff2 or shopAutoUpgradeStaff2
        or shopAutoUnlockStationSlots2 or shopAutoBuyBestWrench2 or shopAutoBuyBestLockpick2
        or shopAutoEquipBestAccessories or shopAutoBuyAndEquipVehicle) then
        break
      end

      pcall(function()
        if shopAutoUpgrade then
          v25.RunAutoUpgrade()
        end

        if shopAutoHireStaff2 or shopAutoUpgradeStaff2 then
          v25.RunStaffAutomation()
        end

        if shopAutoUnlockStationSlots2 then
          v25.RunStationSlotsAutomation()
        end

        if shopAutoBuyBestWrench2 then
          v25.RunWrenchAutomation()
        end

        if shopAutoBuyBestLockpick2 then
          v25.RunLockpickAutomation()
        end

        if shopAutoEquipBestAccessories then
          v25.AutoEquipBestAccessories()
        end

        if shopAutoBuyAndEquipVehicle then
          v16.AutoBuyAndEquipBestVehicle()
        end
      end)

      task.wait(10)
    end

    v6.IsAutoUpgradeLoopRunning = false
  end)
end

function v19.Toggle3DVisuals(p154)
end

v7.InitStartTime = os.clock()
debug("[Init] Starting initialization sequence...")
v12.StaticConfigs()
task.spawn(function() pcall(v22.EnsurePlotSelected) end)
debug("[Init] Creating Fluent Window...")
local v839 = os.clock()

local storageHuntersWindow = v1:CreateWindow({
  Title = "Storage Hunters",
  SubTitle = "by Lamduck",
})

local v840 = {
  Quests = storageHuntersWindow:AddTab({ Title = "Quests", Icon = "scroll" }),
  Farm = storageHuntersWindow:AddTab({ Title = "Farm", Icon = "sprout" }),
  Shop = storageHuntersWindow:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
  Services = storageHuntersWindow:AddTab({ Title = "Services", Icon = "wrench" }),
  Rewards = storageHuntersWindow:AddTab({ Title = "Rewards", Icon = "gift" }),
  Settings = storageHuntersWindow:AddTab({ Title = "Settings", Icon = "settings" }),
}

function v28.Quests()
  local questBranchAutomation = v840.Quests:AddSection("Quest Branch & Automation")

  v840.Quests:AddDropdown("Dropdown_Quests_SelectedBranch", {
    Title = "Quest Branch",
    Values = { "Story Progression", "Bobby & Terry", "Fishing", "Power Plant" },
    Default = "Story Progression",
    Callback = function(value136) v6.QuestsSelectedBranch = value136 end,
  })

  v840.Quests:AddToggle("Toggle_Quests_ProtectQuestItems", {
    Title = "Protect Quest Items",
    Default = true,
    Callback = function(value137)
      v6.QuestsProtectItems = value137

      if value137 then
        v27.StartProtectQuestItemsLoop()
      end
    end,
  })

  v840.Quests:AddToggle("Toggle_Quests_AutoAbandonNonBranch", {
    Title = "Auto Abandon Non-Branch Quests",
    Description = "Frees only needed slot(s) by canceling the quest with the most unfinished tasks.",
    Default = false,
    Callback = function(value138) v6.QuestsAutoAbandonNonBranch = value138 end,
  })

  v840.Quests:AddDivider()

  v840.Quests:AddToggle("Toggle_Quests_AutoStoryQuests", {
    Title = "Auto Quests",
    Default = false,
    Callback = function(value139)
      v6.QuestsAutoStory = value139

      if value139 then
        v27.StartLoop()
      else
        v27.StopLoop()
      end
    end,
  })

  local manualActions = v840.Quests:AddSection("Manual Actions")

  v840.Quests:AddButton({
    Title = "Abandon Non-Branch Quests",
    Description = "Cancels all active quests that do not belong to the selected branch.",
    Callback = function()
      storageHuntersWindow:Dialog({
        Title = "Abandon Non-Branch Quests",
        Content = "Are you sure you want to cancel all active quests that do not belong to the selected branch? You can start them again anytime from their original NPCs.",
        Buttons = {
          {
            Title = "Confirm",
            Callback = function()
              task.spawn(function()
                local v841 = v27.GetActiveQuests()
                local v842 = v27.GetProgressionNPCs()
                local v843 = v12.GetQuests()
                local count21 = 0

                for key58, value140 in pairs(v841) do
                  local v844 = tostring(value140.Id or "")
                  local v845 = v27.GetQuestMetadata(value140)
                  local npcName = v845 and v845.NPCName or v27.FindNPCFromQuest(value140)

                  if not ((npcName and table.find(v842, npcName)) ~= nil) then
                    if v27.CancelQuest(v844) then
                      count21 = count21 + 1

                      debug(
                        "[QuestBot] Cancelled quest %s (%s) to free slot", v844,
                        npcName or "Unknown"
                      )
                    end
                  end
                end

                v29.SetStatus(
                  "Quest", string.format("Freed %d quest slot(s)", count21),
                  "Ready for branch quests"
                )
              end)
            end,
          },
          { Title = "Cancel", Callback = function() end },
        },
      })
    end,
  })

  v840.Quests:AddButton({
    Title = "Travel to Current Quest NPC",
    Callback = function()
      task.spawn(function()
        local v846 = v27.GetNextProgressionTarget()

        if v846 then
          local v847 = v27.FindNPCPosition(v846)

          if v847 then
            v29.SetStatus("Quest", "Traveling to " .. v846 .. "...", "Manual travel triggered")
            v15.TweenTo(v847 + Vector3.new(0, 1.5, 0))
          else
            v29.SetStatus("Quest", "Could not locate NPC: " .. v846, "")
          end
        else
          v29.SetStatus("Quest", "No active quest NPC found", "")
        end
      end)
    end,
  })

  v840.Quests:AddButton({
    Title = "Claim Completed Quests Now",
    Callback = function()
      task.spawn(function()
        local v848 = v27.GetActiveQuests()
        local v849 = false

        for index81, value141 in ipairs(v848) do
          if v27.IsQuestComplete(value141.Id) then
            local v850 = string.match(value141.Id, "^(.+)_quest$") or value141.Id
            local v851 = v27.FindNPCPosition(v850)

            if v851 then
              v29.SetStatus(
                "Quest", "Claiming: " .. (value141.Data and value141.Data.Title or "Quest"),
                "Manual claim"
              )

              v15.TweenTo(v851 + Vector3.new(0, 1.5, 0))
              v27.InteractNPC(v850, value141.Data and value141.Data.Title, "accept")
              v849 = true
            end
          end
        end

        if not v849 then
          v29.SetStatus("Quest", "No completed quests ready to claim", "")
        end
      end)
    end,
  })
end

function v28.Farm()
  local capacityStats = v840.Farm:AddSection("Capacity & Stats")

  v9.FarmOverview = v840.Farm:AddParagraph("Paragraph_Farm_Overview", {
    Title = "Capacity & Stats",
    Content = "Loading capacity stats...",
  })

  v840.Farm:AddToggle("Toggle_Farm_ClearInventoryBeforeAuction", {
    Title = "Clear Inventory Before Next Auction",
    Default = true,
    Callback = function(value142) v6.FarmClearInventoryBeforeAuction = value142 end,
  })

  local addSubTabBar = v840.Farm:AddSubTabBar({
    SubTabs = { "Auction", "Pawn Shop", "Player Shop" },
    Default = "Auction",
  })

  local auction = addSubTabBar.Auction
  local pawnShop = addSubTabBar["Pawn Shop"]
  local playerShop = addSubTabBar["Player Shop"]
  local auctionConfigurations = auction:AddSection("Auction Configurations")

  auction:AddSlider("Slider_Farm_AuctionMaxSpendPercent", {
    Title = "Max Spend (% of Cash)",
    Default = 5,
    Min = 5,
    Max = 100,
    Rounding = 0,
    Callback = function(value143)
      v6.FarmAuctionMaxSpendPercent = value143
      v6.AuctionMaxSpendPercent = value143
    end,
  })

  auction:AddDropdown("Dropdown_Farm_AuctionTargetGarages", {
    Title = "Target Garages",
    Values = v5.GarageNames or {},
    Multi = true,
    Searchable = true,
    Default = table.clone(v5.GarageNames or {}),
    Callback = function(value144)
      v6.FarmAuctionTargetGarages = value144
      v6.AuctionTargetGarages = value144
    end,
  })

  auction:AddToggle("Toggle_Farm_AuctionAvoidSeizedGarages", {
    Title = "Avoid Police Seized Garages",
    Default = true,
    Callback = function(value145) v6.FarmAuctionAvoidSeizedGarages = value145 end,
  })

  auction:AddDivider()

  auction:AddToggle("Toggle_Farm_AuctionAutoStartAuction", {
    Title = "Auto Travel & Start Auction",
    Default = false,
    Callback = function(value146)
      v6.FarmAuctionAutoStartAuction = value146

      if value146 then
        f11()
      else
        f12()
      end
    end,
  })

  auction:AddToggle("Toggle_Farm_AuctionAutoBid", {
    Title = "Auto Bid on Garages",
    Default = false,
    Callback = function(value147)
      v6.FarmAuctionAutoBid = value147

      if value147 then
        f13()
      end
    end,
  })

  auction:AddToggle("Toggle_Farm_AuctionAutoPickupLoot", {
    Title = "Auto Pickup Won Loot",
    Default = true,
    Callback = function(value148)
      v6.FarmAuctionAutoPickupLoot = value148

      if value148 then
        f10()
      else
        v15.Stop()
      end
    end,
  })

  auction:AddToggle("Toggle_Farm_AuctionAutoClaimLostItems", {
    Title = "Auto Claim Lost & Found",
    Default = true,
    Callback = function(value149) v6.FarmAuctionAutoClaimLostItems = value149 end,
  })

  local pawnShop2 = pawnShop:AddSection("Pawn Shop")

  pawnShop:AddSlider("Slider_Farm_PawnMinMultiplier", {
    Title = "Min Multiplier",
    Default = 1,
    Min = 0.1,
    Max = 2,
    Rounding = 2,
    Callback = function(value150) v6.FarmPawnMinMultiplier = value150 end,
  })

  pawnShop:AddDropdown("Dropdown_Farm_PawnSellSources", {
    Title = "Sell Sources",
    Values = { "Inventory", "Vehicle" },
    Multi = true,
    Default = { "Inventory", "Vehicle" },
    Callback = function(value151) v6.FarmPawnSellSources = value151 end,
  })

  pawnShop:AddDivider()

  pawnShop:AddToggle("Toggle_Farm_PawnAutoSell", {
    Title = "Auto Sell on Multiplier",
    Default = false,
    Callback = function(value152)
      v6.FarmPawnAutoSell = value152

      if value152 then
        f11()
      end
    end,
  })

  pawnShop:AddButton({
    Title = "Sell All Eligible Items",
    Callback = function() task.spawn(function() v21.SellAll(nil, true) end) end,
  })

  pawnShop:AddButton({
    Title = "Travel to Pawn Shop",
    Callback = function() task.spawn(function() v21.TravelToShop() end) end,
  })

  local storeShelvesStocking = playerShop:AddSection("Store Shelves & Stocking")

  playerShop:AddDropdown("Dropdown_Farm_PlayerShopStockPriority", {
    Title = "Shelf Stock Priority",
    Values = { "Highest Value First", "Lowest Value First" },
    Default = "Highest Value First",
    Callback = function(value153) v6.FarmPlayerShopStockPriority = value153 end,
  })

  playerShop:AddToggle("Toggle_Farm_PlayerShopAutoStockShelves", {
    Title = "Auto Stock Display Shelves",
    Default = false,
    Callback = function(value154)
      v6.FarmPlayerShopAutoStockShelves = value154

      if value154 then
        f11()
      end
    end,
  })

  playerShop:AddToggle("Toggle_Farm_PlayerShopAutoUnloadAtPlot", {
    Title = "Auto Unload Vehicle to Plot",
    Default = false,
    Callback = function(value155) v6.FarmPlayerShopAutoUnloadAtPlot = value155 end,
  })

  local shopperOffersPricing = playerShop:AddSection("Shopper Offers & Pricing")

  playerShop:AddSlider("Slider_Farm_PlayerShopMinOfferMultiplier", {
    Title = "Min Shopper Offer Multiplier",
    Default = 1,
    Min = 0.7,
    Max = 2,
    Rounding = 2,
    Callback = function(value156) v6.FarmPlayerShopMinOfferMultiplier = value156 end,
  })

  playerShop:AddToggle("Toggle_Farm_PlayerShopAutoSell", {
    Title = "Auto Sell to NPC Shoppers",
    Default = false,
    Callback = function(value157)
      v6.FarmPlayerShopAutoSell = value157

      if value157 then
        task.spawn(function() v22.ProcessPendingShopperOffers() end)
        f11()
      end
    end,
  })

  local quickAction = playerShop:AddSection("Quick Action")

  playerShop:AddButton({
    Title = "Unload Vehicle Now",
    Callback = function() task.spawn(function() v16.UnloadAtPlot() end) end,
  })

  playerShop:AddButton({
    Title = "Clear & Sell Storage Now",
    Callback = function()
      v6.IsSellingActive = true
      f11()

      v1:Notify({
        Title = "Storage Clearing",
        Content = "Triggered immediate selling phase for vehicle and inventory.",
        Duration = 3,
      })
    end,
  })

  playerShop:AddButton({
    Title = "Stock Shelves Now",
    Callback = function() task.spawn(function() v22.StockShelves() end) end,
  })

  playerShop:AddButton({
    Title = "Sell to Current NPC Shoppers",
    Callback = function()
      task.spawn(function()
        local v852 = v22.ProcessPendingShopperOffers()

        v1:Notify({
          Title = "Player Shop",
          Content = string.format("Processed %d pending shopper offers.", v852),
          Duration = 3,
        })
      end)
    end,
  })

  playerShop:AddButton({
    Title = "Teleport to My Plot",
    Callback = function() task.spawn(function() v22.TeleportToPlot() end) end,
  })
end

function v28.Shop()
  local overview = v840.Shop:AddSection("Overview")

  v9.ShopOverview = v840.Shop:AddParagraph("Paragraph_Shop_Overview", {
    Title = "Shop & Upgrades Overview",
    Content = "Loading overview...",
  })

  local addSubTabBar2 = v840.Shop:AddSubTabBar({
    SubTabs = { "Upgrades", "Staff", "Stations", "Tools" },
    Default = "Upgrades",
  })

  local upgrades = addSubTabBar2.Upgrades
  local staff = addSubTabBar2.Staff
  local stations = addSubTabBar2.Stations
  local tools = addSubTabBar2.Tools
  local shopUpgrades = upgrades:AddSection("Shop Upgrades")

  upgrades:AddDropdown("Dropdown_Shop_TargetUpgrades", {
    Title = "Target Upgrades",
    Values = v25.UpgradeDisplayNames,
    Multi = true,
    Searchable = true,
    Default = { "Inventory Space", "Selling Space", "Advertising", "Price Tags", "Tip Jar" },
    Callback = function(value158)
      v6.ShopTargetUpgrades = value158
      v6.FarmUpgradesTargetUpgrades = value158
    end,
  })

  upgrades:AddToggle("Toggle_Shop_AutoUpgrade", {
    Title = "Auto Buy Upgrades",
    Default = false,
    Callback = function(value159)
      v6.ShopAutoUpgrade = value159
      v6.FarmAutoUpgrade = value159

      if value159 then
        f17()
      end
    end,
  })

  local accessories = upgrades:AddSection("Accessories")

  upgrades:AddDropdown("Dropdown_Shop_AccessoryPreset", {
    Title = "Build Preset",
    Values = { "Balanced", "Luck Focus", "Bidding Focus", "Trader Focus", "Speed Focus" },
    Default = "Balanced",
    Callback = function(value160)
      v6.ShopAccessoryPreset = value160

      if v6.ShopAutoEquipBestAccessories or f1("Toggle_Shop_AutoEquipBestAccessories") then
        task.spawn(v25.AutoEquipBestAccessories)
      end
    end,
  })

  upgrades:AddToggle("Toggle_Shop_AutoEquipBestAccessories", {
    Title = "Auto Equip Best Accessories",
    Default = false,
    Callback = function(value161)
      v6.ShopAutoEquipBestAccessories = value161

      if value161 then
        task.spawn(v25.AutoEquipBestAccessories)
        f17()
      end
    end,
  })

  local vehicle = upgrades:AddSection("Vehicle")

  upgrades:AddToggle("Toggle_Shop_AutoBuyAndEquipVehicle", {
    Title = "Auto Buy & Equip Best Vehicle",
    Default = false,
    Callback = function(value162)
      v6.ShopAutoBuyAndEquipVehicle = value162

      if value162 then
        task.spawn(v16.AutoBuyAndEquipBestVehicle)
        f17()
      end
    end,
  })

  local staffManagement = staff:AddSection("Staff Management")

  staff:AddSlider("Slider_Shop_StaffMinOfferPercent", {
    Title = "Min Offer (%)",
    Default = 105,
    Min = 50,
    Max = 200,
    Rounding = 0,
    Callback = function(value163)
      v6.ShopStaffMinOfferPercent = value163
      v6.FarmStaffMinOfferPercent = value163

      task.spawn(function()
        for key59, value164 in pairs((v25.GetStaffData())) do
          if value164.Type == "ShopAssistant" then
            v13.FireServer("Staff", "UpdateStaffConfig", key59, { MinOfferPercent = value163 })
          end
        end
      end)
    end,
  })

  staff:AddToggle("Toggle_Shop_AutoHireStaff", {
    Title = "Auto Hire Assistant",
    Default = false,
    Callback = function(value165)
      v6.ShopAutoHireStaff = value165
      v6.FarmAutoHireStaff = value165

      if value165 then
        task.spawn(v25.RunStaffAutomation)
        f17()
      end
    end,
  })

  staff:AddToggle("Toggle_Shop_AutoUpgradeStaff", {
    Title = "Auto Upgrade Skills",
    Default = false,
    Callback = function(value166)
      v6.ShopAutoUpgradeStaff = value166
      v6.FarmAutoUpgradeStaff = value166

      if value166 then
        task.spawn(v25.RunStaffAutomation)
        f17()
      end
    end,
  })

  local stationSlots = stations:AddSection("Station Slots")

  stations:AddToggle("Toggle_Shop_AutoUnlockStationSlots", {
    Title = "Auto Unlock Station Slots",
    Default = false,
    Callback = function(value167)
      v6.ShopAutoUnlockStationSlots = value167

      if value167 then
        f17()
      end
    end,
  })

  local workstationTools = tools:AddSection("Workstation Tools")

  tools:AddToggle("Toggle_Shop_AutoBuyBestWrench", {
    Title = "Auto Buy Best Wrench",
    Default = false,
    Callback = function(value168)
      v6.ShopAutoBuyBestWrench = value168

      if value168 then
        f17()
      end
    end,
  })

  tools:AddToggle("Toggle_Shop_AutoBuyBestLockpick", {
    Title = "Auto Buy Best Lockpick",
    Default = false,
    Callback = function(value169)
      v6.ShopAutoBuyBestLockpick = value169

      if value169 then
        f17()
      end
    end,
  })

  task.spawn(function() pcall(v25.UpdateShopOverview) end)
end

function v28.Services()
  local overview2 = v840.Services:AddSection("Overview")

  v9.ServicesStatus = v840.Services:AddParagraph("Paragraph_Services_Status", {
    Title = "Services Status",
    Content = "• Wash: Empty\n• Repair: Empty\n• Grading: Empty\n• Locksmith: Empty",
  })

  local strategyPreferences = v840.Services:AddSection("Strategy & Preferences")

  v840.Services:AddToggle("Toggle_Services_PrioritizeHighValue", {
    Title = "Prioritize High Value",
    Default = true,
    Callback = function(value170) v6.ServicesPrioritizeHighValue = value170 end,
  })

  v840.Services:AddToggle("Toggle_Services_CrackOnlyGradedSafes", {
    Title = "Only Crack Graded Safes",
    Default = true,
    Callback = function(value171) v6.ServicesCrackOnlyGradedSafes = value171 end,
  })

  v840.Services:AddToggle("Toggle_Services_PrioritizeUtilityGrading", {
    Title = "Prioritize Utility Items in Grading",
    Description = "Safes, drinks, rods & certificates",
    Default = true,
    Callback = function(value172) v6.ServicesPrioritizeUtilityGrading = value172 end,
  })

  local automationStations = v840.Services:AddSection("Automation Stations")

  v840.Services:AddToggle("Toggle_Services_AutoWash", {
    Title = "Auto Wash",
    Default = false,
    Callback = function(value173)
      v6.ServicesAutoWash = value173
      v23.UpdateStatusParagraph()

      if value173 then
        f14()
      end
    end,
  })

  v840.Services:AddToggle("Toggle_Services_AutoRepair", {
    Title = "Auto Repair",
    Default = false,
    Callback = function(value174)
      v6.ServicesAutoRepair = value174
      v23.UpdateStatusParagraph()

      if value174 then
        f14()
      end
    end,
  })

  v840.Services:AddToggle("Toggle_Services_AutoGrade", {
    Title = "Auto Grade",
    Default = false,
    Callback = function(value175)
      v6.ServicesAutoGrade = value175
      v23.UpdateStatusParagraph()

      if value175 then
        f14()
      end
    end,
  })

  v840.Services:AddToggle("Toggle_Services_AutoCrackSafes", {
    Title = "Auto Crack Safes",
    Default = false,
    Callback = function(value176)
      v6.ServicesAutoCrackSafes = value176
      v23.UpdateStatusParagraph()

      if value176 then
        f14()
      end
    end,
  })

  v840.Services:AddToggle("Toggle_Services_AutoTimeCapsule", {
    Title = "Auto Time Capsule",
    Description = "Bury items to mutate and collect when ready",
    Default = false,
    Callback = function(value177)
      v6.ServicesAutoTimeCapsule = value177
      v23.UpdateStatusParagraph()

      if value177 then
        f14()
      end
    end,
  })
end

function v28.Rewards()
  local autoRewards = v840.Rewards:AddSection("Auto Rewards")

  v840.Rewards:AddToggle("Toggle_Rewards_AutoClaimDaily", {
    Title = "Auto Claim Daily Reward",
    Default = false,
    Callback = function(value178)
      v6.RewardsAutoClaimDaily = value178

      if value178 then
        task.spawn(v24.ClaimDailyReward)
        f16()
      end
    end,
  })

  v840.Rewards:AddToggle("Toggle_Rewards_AutoClaimAchievements", {
    Title = "Auto Claim Achievements",
    Default = false,
    Callback = function(value179)
      v6.RewardsAutoClaimAchievements = value179

      if value179 then
        task.spawn(v24.ClaimAchievements)
        f16()
      end
    end,
  })

  v840.Rewards:AddToggle("Toggle_Rewards_AutoClaimCollections", {
    Title = "Auto Claim Collection Milestones",
    Default = false,
    Callback = function(value180)
      v6.RewardsAutoClaimCollections = value180

      if value180 then
        task.spawn(v24.ClaimCollections)
        f16()
      end
    end,
  })
end

v28.Quests()
v28.Farm()
v28.Shop()
v28.Services()
v28.Rewards()

debug("[Init] Fluent Window & UI built in %.3fs.", os.clock() - v839)
v29.Init()

pcall(function()
  local waitForChild2 = replicatedStorage:WaitForChild("Modules", 5)
  local waitForChild3 = waitForChild2 and waitForChild2:WaitForChild("Screens", 5)
  local waitForChild4 = waitForChild3 and waitForChild3:WaitForChild("Toasts", 5)

  if waitForChild4 then
    local v853, v854 = pcall(require, waitForChild4)

    if v853 and type(v854) == "table" then
      local show = v854.Show

      if typeof(show) == "function" then
        v7.OrigToastsShow = show

        function v854.Show(p155, p156, ...)
          local v855 = type(p155) == "string" and p155 or type(p156) == "string" and p156
            or tostring(p155 or p156 or "")

          if v855 ~= "" and not string.find(v855, "table:") then
            debug(string.format("[Game/Toast] %s", v855))
          end

          return show(p155, p156, ...)
        end
      end

      local showCentered = v854.ShowCentered

      if typeof(showCentered) == "function" then
        v7.OrigToastsShowCentered = showCentered

        function v854.ShowCentered(p157, p158, ...)
          local v856 = type(p157) == "string" and p157 or type(p158) == "string" and p158
            or tostring(p157 or p158 or "")

          if v856 ~= "" and not string.find(v856, "table:") then
            debug(string.format("[Game/ToastCentered] %s", v856))
          end

          return showCentered(p157, p158, ...)
        end
      end
    end
  end
end)

task.spawn(function()
  task.wait(1)
  v22.EnsurePlotSelected()
end)

local v857 = v13.GetRemote("Achievements", "BadgeStatusChanged")

if v857 and v857:IsA("RemoteEvent") then
  v8.BadgeStatusChanged = v857.OnClientEvent:Connect(function()
    local rewardsAutoClaimAchievements2 = v6.RewardsAutoClaimAchievements

    if rewardsAutoClaimAchievements2 == nil then
      rewardsAutoClaimAchievements2 = f1("Toggle_Rewards_AutoClaimAchievements")
    end

    if rewardsAutoClaimAchievements2 then
      task.spawn(function() v24.ClaimAchievements() end)
    end
  end)
end

local v858 = v13.GetRemote("Auction", "AuctionPickupStart")

if v858 and v858:IsA("RemoteEvent") then
  v8.AuctionPickupStart = v858.OnClientEvent:Connect(function(p159, p160)
    v6.IsPickupActive = true
    v6.PickupStartTime = os.clock()
    v6.IsInAuction = false
    v6.IsEnteringAuction = false
    v6.IsVehicleFull = false

    v7.IgnoredHeavyPrompts = nil
    v16.EnsureNearPlayer(35)
    debug("[Pickup] Collecting loot started (%d items)", p160 or 0)
    v29.SetStatus("Auction", "Collecting won loot", string.format("Loot: %d items", p160 or 0))

    if v6.FarmAuctionAutoPickupLoot or f1("Toggle_Farm_AuctionAutoPickupLoot") then
      f10()
    end
  end)
end

local v859 = v13.GetRemote("Auction", "AuctionPickupItem")

if v859 and v859:IsA("RemoteEvent") then
  v8.AuctionPickupItem = v859.OnClientEvent:Connect(function(p161, p162)
    v6.PickupStartTime = os.clock()
    local v860 = tonumber(p162) or 0

    if v860 == 0 then
      v6.IsPickupActive = false
      v6.PickupStartTime = nil

      v7.CurrentAuctionZone = nil
      v7.CurrentAuctionPos = nil
      v7.CurrentAuctionGarageModel = nil

      v29.SetStatus("Auction", "Loot collected!", "Ready for next auction")
    else
      v29.SetStatus(
        "Auction", "Collecting won loot", string.format("Remaining: %d items", v860)
      )
    end
  end)
end

local v861 = v13.GetRemote("Auction", "AuctionPickupEnd")

if v861 and v861:IsA("RemoteEvent") then
  v8.AuctionPickupEnd = v861.OnClientEvent:Connect(function()
    v6.IsPickupActive = false
    v6.PickupStartTime = nil

    if not v6.IsEnteringAuction and not v6.IsInAuction then
      v7.CurrentAuctionZone = nil
      v7.CurrentAuctionPos = nil
      v7.CurrentAuctionGarageModel = nil

      v29.SetStatus("Auction", "Idle: Ready for auction", "Pickup phase complete")
    end
  end)
end

local v862 = v13.GetRemote("Auction", "ToggleBiddingUI")

if v862 and v862:IsA("RemoteEvent") then
  v8.ToggleBiddingUI = v862.OnClientEvent:Connect(function(p163)
    v6.IsInAuction = p163 == true
    v6.IsEnteringAuction = false

    if p163 then
      v15.Stop()
      debug("[Auction] Bidding started")
      v29.SetStatus("Auction", "Bidding in progress...", "Auction active")

      if v6.FarmAuctionAutoBid or f1("Toggle_Farm_AuctionAutoBid") then
        f13()
      end
    else
      v6.IsWinningAuction = false
      v7.LastDisplayedStatusKey = nil

      if not v6.IsPickupActive then
        v29.SetStatus("Auction", "Bidding ended", "Preparing next auction...")
      end
    end
  end)
end

local v863 = v13.GetRemote("Auction", "UpdateCurrentWinningBid")

if v863 and v863:IsA("RemoteEvent") then
  v8.UpdateCurrentWinningBid = v863.OnClientEvent:Connect(function(p164, p165, p166, p167, p168)
    v6.IsWinningAuction = p165 == localPlayer.Name

    if p168 and p168:IsA("Model") then
      local parent11 = p168

      while parent11 and parent11.Parent and parent11.Parent.Name ~= "Garages" do
        parent11 = parent11.Parent
      end

      v7.CurrentAuctionGarageModel = parent11
      local findFirstChild37 = parent11:FindFirstChild("AuctionZone", true)

      if findFirstChild37 then
        v7.CurrentAuctionZone = findFirstChild37
      end
    end
  end)
end

local v864 = v13.GetRemote("Auction", "ToggleAuctionArea")

if v864 and v864:IsA("RemoteEvent") then
  v8.ToggleAuctionArea = v864.OnClientEvent:Connect(function(p169, p170)
    if p169 then
      v6.IsInAuction = true
      v6.IsEnteringAuction = false

      v15.Stop()

      if p170 then
        v7.CurrentAuctionGarageModel = p170
        local findFirstChild38 = p170:FindFirstChild("AuctionZone", true)

        if findFirstChild38 then
          v7.CurrentAuctionZone = findFirstChild38
        end
      end
    elseif p170 and v6.IsInAuction then
      local findFirstChild39 = p170:FindFirstChild("AuctionZone", true)

      if findFirstChild39 then
        local character22 = localPlayer.Character

        if character22 and character22:FindFirstChild("HumanoidRootPart") then
          v15.TweenTo(findFirstChild39.Position + Vector3.new(0, 1.5, 0), 25)
          debug("[Auction/Boundary] Out of zone detected! Restored player to AuctionZone center.")
        end
      end
    end
  end)
end

local v865 = v13.GetRemote("Auction", "LostFoundOverride")

if v865 and v865:IsA("RemoteEvent") then
  v8.LostFoundOverride = v865.OnClientEvent:Connect(function(p171)
    local farmAuctionAutoConfirmLostFound2 = v6.FarmAuctionAutoConfirmLostFound

    if farmAuctionAutoConfirmLostFound2 == nil then
      farmAuctionAutoConfirmLostFound2 = true
    end

    if farmAuctionAutoConfirmLostFound2 ~= false then
      v865:FireServer(true)
      debug("[Auction] Auto-confirmed Lost & Found warning to start auction")

      task.defer(function()
        local playerGui16 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui16 then
          for index82, value181 in ipairs(playerGui16:GetDescendants()) do
            if value181:IsA("TextLabel") and value181.Text == "Before you start" then
              local parent12 = value181.Parent
              local parent13 = parent12 and parent12.Parent

              if parent13 then
                parent13.Visible = false
              end
            end
          end
        end
      end)
    end
  end)
end

local v866 = v13.GetRemote("UI", "OfferOverweightAdd")

if v866 and v866:IsA("RemoteEvent") then
  v8.OfferOverweightAdd = v866.OnClientEvent:Connect(function()
    v6.IsVehicleFull = true
    debug("[Vehicle] Overweight limit reached! Stopping vehicle loot sweeps.")

    task.defer(function()
      local playerGui17 = localPlayer:FindFirstChild("PlayerGui")

      if playerGui17 then
        for index83, value182 in ipairs(playerGui17:GetDescendants()) do
          if value182:IsA("TextLabel") and value182.Text == "Vehicle Overweight" then
            local parent14 = value182.Parent
            local buttonRow2 = parent14 and parent14:FindFirstChild("ButtonRow")
            local cancelButton2 = buttonRow2 and buttonRow2:FindFirstChild("CancelButton")

            if cancelButton2 and cancelButton2:IsA("GuiButton") and firesignal then
              firesignal(cancelButton2.Activated)
            end

            local parent15 = parent14 and parent14.Parent

            if parent15 then
              parent15.Visible = false
            end
          end
        end
      end
    end)
  end)
end

local v867 = v13.GetRemote("Misc", "Jail")

if v867 and v867:IsA("RemoteEvent") then
  v8.Jail = v867.OnClientEvent:Connect(function(p172, p173)
    if p172 == "Busted" or p172 == "Jailed" then
      v15.Stop()
      debug("[Jail] Arrested by police! Serving sentence in cell (saving diamonds).")
      v29.SetStatus("Farm", "Serving 60s sentence", "Arrested by police (Saving diamonds)")
    elseif p172 == "Released" then
      debug("[Jail] Released from jail! Resuming farm loops.")
      v29.SetStatus("Farm", "Released from jail!", "Resuming auction...")
    end
  end)
end

v8.InJail = localPlayer:GetAttributeChangedSignal("InJail"):Connect(function()
  if localPlayer:GetAttribute("InJail") == true then
    v15.Stop()
    debug("[Jail] InJail attribute active. Pausing movement until release.")
  end
end)

local v868 = v13.GetRemote("Pawn", "RateChanged")

if v868 and v868:IsA("RemoteEvent") then
  v8.PawnRateChanged = v868.OnClientEvent:Connect(function(p174)
    v7.CurrentPawnRate = type(p174) == "table" and (p174.rate or p174.Rate) or tonumber(p174)
      or 1

    v21.GetPawnState()
  end)
end

local v869 = v13.GetRemote("NPCShopper", "ShowOffer")

if v869 and v869:IsA("RemoteEvent") then
  v8.ShowOffer = v869.OnClientEvent:Connect(function(p175, p176, p177, p178, p179)
    local farmPlayerShopAutoSell4 = v6.FarmPlayerShopAutoSell

    if farmPlayerShopAutoSell4 == nil then
      farmPlayerShopAutoSell4 = f1("Toggle_Farm_PlayerShopAutoSell")
    end

    if not farmPlayerShopAutoSell4 then
      return
    end

    local farmPlayerShopMinOfferMultiplier2 = v6.FarmPlayerShopMinOfferMultiplier
      or f1("Slider_Farm_PlayerShopMinOfferMultiplier") or 1

    local v870 = tonumber(p179) or tonumber(p178) or 1

    if v870 <= 0 then
      v870 = 1
    end

    local v871 = tonumber(p178) or 0
    local v872 = math.floor(v871 / v870 * 100 + 0.5) / 100
    local v873 = v13.GetRemote("NPCShopper", "OfferPresented")

    if v873 and v873:IsA("RemoteEvent") then
      v873:FireServer(p175, v871, p176)
    end

    task.wait(0.1)
    local v874 = v13.GetRemote("NPCShopper", "RespondOffer")

    if v874 and v874:IsA("RemoteEvent") then
      if v872 >= farmPlayerShopMinOfferMultiplier2 then
        v874:FireServer(p175, true)

        debug(
          "[PlayerShop] Accepted NPC offer for %s: $%s (%.2fx base $%s >= %.2fx)",
          tostring(p177 or "Item"), v14.Number(v871), v872, v14.Number(v870),
          farmPlayerShopMinOfferMultiplier2
        )
      else
        v874:FireServer(p175, false)

        debug(
          "[PlayerShop] Declined NPC offer for %s: $%s (%.2fx base $%s < %.2fx)",
          tostring(p177 or "Item"), v14.Number(v871), v872, v14.Number(v870),
          farmPlayerShopMinOfferMultiplier2
        )
      end
    end
  end)
end

local v875 = 0

local function f18(p180, p181)
  if os.clock() - v875 < 0.4 then
    return
  end

  v875 = os.clock()
  local settingsAutoFlyToGPS = v6.SettingsAutoFlyToGPS

  if settingsAutoFlyToGPS == nil then
    settingsAutoFlyToGPS = f1("Toggle_Settings_AutoFlyToGPS")
  end

  if settingsAutoFlyToGPS == nil then
    settingsAutoFlyToGPS = true
  end

  if not settingsAutoFlyToGPS then
    return
  end

  local vector3 = p181

  if typeof(vector3) == "table" then
    if vector3.X and vector3.Y and vector3.Z then
      vector3 = Vector3.new(vector3.X, vector3.Y, vector3.Z)
    elseif vector3[1] and vector3[2] and vector3[3] then
      vector3 = Vector3.new(vector3[1], vector3[2], vector3[3])
    end
  elseif typeof(vector3) == "CFrame" then
    vector3 = vector3.Position
  end

  if not vector3 or typeof(vector3) ~= "Vector3" then
    local gpsTrailAnchor = workspace:FindFirstChild("GPSTrailAnchor")

    if gpsTrailAnchor then
      local v876 = {}

      for index84, value183 in ipairs(gpsTrailAnchor:GetChildren()) do
        if value183:IsA("Attachment") and string.find(value183.Name, "WP_") then
          local idx = tonumber(string.match(value183.Name, "%d+")) or 0
          table.insert(v876, { idx = idx, pos = value183.WorldPosition })
        end
      end

      table.sort(v876, function(p182, p183) return p182.idx < p183.idx end)

      if #v876 > 0 then
        vector3 = v876[#v876].pos
      end
    end
  end

  if not vector3 or typeof(vector3) ~= "Vector3" then
    if p180 and v7.POIMap and v7.POIMap[p180] then
      vector3 = v7.POIMap[p180]
    else
      local v877 = v13.GetRemote("GPS", "GetPOIs")

      if v877 then
        local v878, v879 = pcall(function() return v877:InvokeServer() end)

        if v878 and v879 and v879.pois then
          v7.POIMap = v7.POIMap or {}

          for index85, value184 in ipairs(v879.pois) do
            v7.POIMap[value184.name] = value184.position
          end

          vector3 = p180 and v7.POIMap[p180]
        end
      end
    end
  end

  if not vector3 or typeof(vector3) ~= "Vector3" then
    debug("[GPS] Destination coordinates not resolved for: %s", tostring(p180))
    return
  end

  if v20.IsAuctionActive() or v6.IsPickupActive or v6.IsSellingActive or v6.IsEnteringAuction then
    v1:Notify({
      Title = "GPS Navigation",
      Content = "Auto task in progress! Navigation fly paused to protect items.",
      Duration = 4,
    })

    debug(
      "[GPS] Fly to %s deferred: Auto task active (Auction=%s, Pickup=%s, Selling=%s, Entering=%s)",
      tostring(p180), tostring(v20.IsAuctionActive()), tostring(v6.IsPickupActive),
      tostring(v6.IsSellingActive), tostring(v6.IsEnteringAuction)
    )

    return
  end

  task.spawn(function()
    v6.IsNavigatingManualGPS = true
    v15.Stop()

    v1:Notify({
      Title = "GPS Navigation",
      Content = string.format("Flying to %s...", tostring(p180 or "Waypoint")),
      Duration = 3,
    })

    debug(
      "[GPS] Flying to player navigation waypoint: %s at %s", tostring(p180), tostring(vector3)
    )

    local v880 = v15.TweenTo(vector3 + Vector3.new(0, 2, 0))
    v6.IsNavigatingManualGPS = false

    if v880 then
      v1:Notify({
        Title = "GPS Navigation",
        Content = string.format("Arrived at %s!", tostring(p180 or "Waypoint")),
        Duration = 3,
      })
    end
  end)
end

local startGPSNavigation2 = localPlayer:FindFirstChild("StartGPSNavigation")
  or localPlayer:WaitForChild("StartGPSNavigation", 5)

if startGPSNavigation2 and startGPSNavigation2:IsA("BindableEvent") then
  v8.StartGPSNavigation = startGPSNavigation2.Event:Connect(function(p184, p185)
    f18(p184, p185)
  end)
end

v8.GPSDestinationChanged = localPlayer:GetAttributeChangedSignal("GPSDestination"):Connect(function()
  local gpsDestination = localPlayer:GetAttribute("GPSDestination")

  if not gpsDestination or gpsDestination == "" then
    return
  end

  task.wait(0.1)
  f18(gpsDestination, nil)
end)

v8.GPSMenuHook = localPlayer.PlayerGui.ChildAdded:Connect(function(child)
  if child.Name == "GPSMenu" then
    task.spawn(function()
      local waitForChild5 = child:WaitForChild("Panel", 3)
        and child.Panel:WaitForChild("List", 3)

      if waitForChild5 then
        for index86, value185 in ipairs(waitForChild5:GetChildren()) do
          if value185:IsA("TextButton") then
            value185.Activated:Connect(function()
              local textLabel = value185:FindFirstChildWhichIsA("TextLabel")
              local text2 = textLabel and textLabel.Text

              task.delay(0.2, function()
                if text2 then
                  f18(text2, nil)
                end
              end)
            end)
          end
        end
      end
    end)
  end
end)

task.spawn(function()
  while not v1.Unloaded do
    pcall(v20.CheckAndDismissPopups)
    task.wait(1.5)
  end
end)

f15()
f11()

if v6.QuestsProtectItems or f1("Toggle_Quests_ProtectQuestItems") then
  v27.StartProtectQuestItemsLoop()
end

debug(
  "[Init] StorageHunters loaded in %.3fs. Player=%s, Cash=$%s, NetWorth=$%s, Inventory=%d/%d",
  os.clock() - (v7.InitStartTime or os.clock()), localPlayer.Name, v14.Number(v11.GetCash()),
  v14.Number(v11.GetNetWorth()), v11.GetInventoryCount(), v11.GetInventoryMax()
)

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/StorageHunters")
v4:SetFolder("Lamduck/StorageHunters")
v2:SetIgnoreIndexes({})
local navigationGPS = v840.Settings:AddSection("Navigation & GPS")

v840.Settings:AddToggle("Toggle_Settings_UseTweenSafeMode", {
  Title = "Use Tween (Safe Mode)",
  Description = "Smooth tween instead of instant teleport",
  Default = false,
  Callback = function(value186) v6.SettingsUseTweenSafeMode = value186 end,
})

v840.Settings:AddToggle("Toggle_Settings_AutoFlyToGPS", {
  Title = "Auto Fly to In-Game Navigation",
  Description = "Fly to clicked map waypoint",
  Default = true,
  Callback = function(value187) v6.SettingsAutoFlyToGPS = value187 end,
})

local debugLogs = v840.Settings:AddSection("Debug & Logs")

v840.Settings:AddToggle("Toggle_Settings_EnableFileLogging", {
  Title = "Enable File Logging",
  Description = "Writes logs to Lamduck/StorageHunters/",
  Default = true,
  Callback = function(value188) v6.SettingsEnableFileLogging = value188 end,
})

v840.Settings:AddToggle("Toggle_Settings_AutoDismissTips", {
  Title = "Auto Dismiss Tips & Popups",
  Default = true,
  Callback = function(value189) v6.SettingsAutoDismissTips = value189 end,
})

v840.Settings:AddToggle("Toggle_Settings_ShowStatusHUD", {
  Title = "Show Status HUD (Top-Mid)",
  Default = true,
  Callback = function(value190)
    v6.SettingsShowStatusHUD = value190
    v29.SetVisible(value190)
  end,
})

v4:BuildExtraSection(v840.Settings)
v3:BuildInterfaceSection(v840.Settings)
v2:BuildConfigSection(v840.Settings)

v1.OnUnload:Once(function()
  v15.Stop()
  v29.Destroy()

  if v7.OrigToastsShow or v7.OrigToastsShowCentered then
    pcall(function()
      local modules2 = replicatedStorage:FindFirstChild("Modules")
      local screens = modules2 and modules2:FindFirstChild("Screens")
      local toasts = screens and screens:FindFirstChild("Toasts")

      if toasts then
        local v881 = require(toasts)

        if v881 and v7.OrigToastsShow then
          v881.Show = v7.OrigToastsShow
        end

        if v881 and v7.OrigToastsShowCentered then
          v881.ShowCentered = v7.OrigToastsShowCentered
        end
      end
    end)
  end

  for key60, value191 in pairs(v8) do
    if typeof(value191) == "RBXScriptConnection" and value191.Connected then
      value191:Disconnect()
    end
  end

  table.clear(v8)
  table.clear(v6)
  table.clear(v7)
  table.clear(v9)
end)

v2:LoadAutoloadConfig()
storageHuntersWindow:SelectTab(1)
debug("[Init] Script startup complete in %.3fs.", os.clock() - (v7.InitStartTime or os.clock()))
