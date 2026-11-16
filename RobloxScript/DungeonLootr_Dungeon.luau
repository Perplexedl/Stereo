local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local collectionService = game:GetService("CollectionService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer

local v5 = {
  Common = 1,
  Uncommon = 2,
  Rare = 3,
  Epic = 4,
  Legendary = 5,
  Mythic = 6,
  Celestial = 7,
  Impossible = 8,
  Exotic = 9,
}

local v6 = {
  DamagePct = 100,
  BonusDamage = 95,
  SkillDamagePct = 90,
  SkillCooldownPct = 85,
  CritRatePct = 80,
  SkillCritRatePct = 75,
  DamageReductionPct = 60,
  MaxHP = 50,
  MoveSpeed = 30,
}

local v7 = nil

pcall(function()
  v7 = require(replicatedStorage:WaitForChild("Modules", 5):WaitForChild("RigUtil", 5))
end)

local v8 = nil

pcall(function()
  v8 = require(replicatedStorage:WaitForChild("Modules", 5):WaitForChild("DropSpawner", 5))
end)

local v9 = {
  IsFarmAutoFarmRunning = false,
  IsActionAnimStripperRunning = false,
  IsEvading = false,
  FarmTargetLock = true,
  FarmMobLure = false,
  FarmAutoSkills = true,
  FarmSkills = {
    ["Skill 1"] = true,
    ["Skill 2"] = true,
    ["Skill 3"] = true,
    ["Skill 4"] = true,
    Ultimate = true,
  },
  FarmFlyMode = "Above",
  FarmFlyDistance = 15,
  FarmAutoDrops = true,
  FarmAutoChests = true,
  FarmAutoUnlockRooms = true,
  FarmAllowHigherTierKeys = false,
  FarmAutoPotion = true,
  FarmPotionThreshold = 40,
  FarmAutoEvade = false,
  FarmAutoRefillStation = true,
  FarmAutoBlessing = true,
  FarmAutoEndChests = true,
  FarmAutoSpecialBoss = false,
  PostRunWinAction = "None",
  PostRunActionDelay = 5,
  PostRunWaitForRewards = true,
  PostRunEndlessChoice = "None",
  SettingsDisableActionAnim = false,
  SettingsUltraLowGraphics = false,
}

local v10 = {}

local v11 = {
  LuredMobs = {},
  ActionLockUntil = 0,
  CurrentRoomIndex = 1,
  LastLoggedRoom = 0,
  LastLoggedAdvancing = 0,
  RoomEntryTime = 0,
  RoomCombatStarted = false,
  LastWaitSec = -1,
  InitialPotionCount = 0,
  UsedPotionThisRun = false,
  LastPotionUse = 0,
  EndChestsClaimed = false,
  PendingChestSelection = false,
  PostRunActionExecuted = false,
  ProcessedLockedRooms = {},
  ChestsSwept = false,
  LockedRoomsLogged = false,
  EvadeOriginY = nil,
  ProcessedTotems = {},
  PreviousGameSettings = {},
  ActiveAimTargetHrp = nil,
}

local v12 = {}

local function f1()
  local playerData = nil

  pcall(function()
    playerData = require(localPlayer.PlayerScripts.Client.Controllers.Registry):Get("PlayerData")
  end)

  return playerData
end

local function f2()
  local v13 = f1()
  return v13 and v13.Data and tonumber(v13.Data.PlayerLevel) or 0
end

local function f3()
  local v14 = f1()
  return v14 and v14.Data and tonumber(v14.Data.Currency or v14.Data.Coins) or 0
end

local function f4()
  local v15 = f1()
  return v15 and v15.Data and tonumber(v15.Data.Stars) or 0
end

local function f5(p1)
  local v16 = f1()
  local keys = v16 and v16.Data and v16.Data.Keys

  if not keys then
    return 0
  end

  if p1 then
    return tonumber(keys[p1]) or 0
  end

  local total = 0

  for key, value in pairs(keys) do
    total = total + (tonumber(value) or 0)
  end

  return total
end

local function f6(p2)
  if not p2 then
    return "0"
  end

  local v17 = tonumber(p2) or 0
  local v18 = tostring(math.floor(v17))

  while true do
    local v19
    v18, v19 = string.gsub(v18, "^(-?%d+)(%d%d%d)", "%1,%2")

    if v19 == 0 then
      break
    end
  end

  return v18
end

local function f7(p3, p4)
  if not p3 or type(p3) ~= "table" then
    return false
  end

  return p3[p4] == true
end

local function f8(p5)
  if v11.Remotes and v11.Remotes[p5] then
    return v11.Remotes[p5]
  end

  v11.Remotes = v11.Remotes or {}

  pcall(function()
    local player = replicatedStorage:FindFirstChild("Player")
    local remotes = player and player:FindFirstChild("Remotes")
    local inputs = remotes and remotes:FindFirstChild("Inputs")
    v11.Remotes[p5] = inputs and inputs:FindFirstChild(p5)
  end)

  return v11.Remotes[p5]
end

local function f9()
  for index, value2 in ipairs(workspace:GetChildren()) do
    if value2.Name:find("^Generated_") and value2:FindFirstChild("NPCs") then
      return value2
    end
  end

  local dungeons = workspace:FindFirstChild("Dungeons")

  if dungeons and dungeons:FindFirstChild("NPCs") then
    return dungeons
  end

  return nil
end

local function f10(p6)
  local v20 = {}

  if not p6 then
    return v20
  end

  for index2, value3 in ipairs(p6:GetChildren()) do
    local roomD = value3.Name:match("^Room_(%d+)$")

    if roomD and value3:IsA("Model") then
      local index3 = tonumber(roomD)
      local zone = value3:FindFirstChild("Zone")
      local tileAnchor = value3:FindFirstChild("TileAnchor")
      local position

      if zone and zone:IsA("BasePart") then
        position = zone.Position
      elseif tileAnchor and tileAnchor:IsA("BasePart") then
        position = tileAnchor.Position
      else
        position = value3:GetPivot().Position
      end

      local spawns = value3:FindFirstChild("Spawns")
      local count = 0
      local v21 = false

      if spawns then
        for index4, value4 in ipairs(spawns:GetChildren()) do
          if value4.Name == "Enemy_Spawn" or value4.Name == "Boss_Spawn" then
            v21 = true
            count = count + 1
          end
        end
      end

      local door = value3:FindFirstChild("Door") or value3:FindFirstChild("Gate")

      table.insert(v20, {
        Index = index3,
        Model = value3,
        Zone = zone,
        CenterPos = position,
        SpawnCount = count,
        HasEnemySpawn = v21,
        IsCombat = v21,
        Door = door,
      })
    end
  end

  table.sort(v20, function(p7, p8) return p7.Index < p8.Index end)
  return v20
end

local function f11(p9)
  if not p9 then
    return nil
  end

  if p9.Zone and p9.Zone:IsA("BasePart") then
    return p9.Zone.Position
  end

  if p9.CenterPos then
    return p9.CenterPos
  end

  if p9.Model then
    return p9.Model:GetPivot().Position
  end

  return nil
end

local function f12(p10, p11)
  if not p11 then
    return false
  end

  local pointToObjectSpace = p11.CFrame:PointToObjectSpace(p10)
  local v22 = p11.Size * 0.5

  return math.abs(pointToObjectSpace.X) <= v22.X + 2
    and math.abs(pointToObjectSpace.Z) <= v22.Z + 2
end

local function f13(p12, p13)
  if not p13 then
    return false
  end

  if p13.Zone and p13.Zone:IsA("BasePart") then
    return f12(p12, p13.Zone)
  end

  if p13.CenterPos then
    return (Vector3.new(p12.X, 0, p12.Z) - Vector3.new(p13.CenterPos.X, 0, p13.CenterPos.Z)).Magnitude
      <= 35
  end

  return false
end

local function f14(p14, p15)
  if not p14 or #p14 == 0 or not p15 then
    return nil
  end

  for index5, value5 in ipairs(p14) do
    if f13(p15, value5) then
      return value5
    end
  end

  local v23 = nil
  local huge = math.huge

  for index6, value6 in ipairs(p14) do
    local v24 = f11(value6)

    if v24 then
      local magnitude = (Vector3.new(p15.X, 0, p15.Z) - Vector3.new(v24.X, 0, v24.Z)).Magnitude

      if magnitude < huge then
        huge = magnitude
        v23 = value6
      end
    end
  end

  return v23
end

local function f15(p16)
  if not p16 or not p16.Parent or not p16:IsDescendantOf(workspace) then
    return false
  end

  if p16:GetAttribute("Dead") == true or p16:GetAttribute("State") == "Dead"
    or p16:HasTag("Ignore_Damage") then
    return false
  end

  local humanoid = p16:FindFirstChildOfClass("Humanoid")

  if humanoid and humanoid.Health <= 0 then
    return false
  end

  if v7 and typeof(v7.IsAlive) == "function" then
    local v25, v26 = pcall(v7.IsAlive, p16)

    if v25 and v26 == false then
      return false
    end
  end

  return true
end

local function f16(p17)
  if not f15(p17) then
    return false
  end

  local humanoidRootPart = p17:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart then
    return false
  end

  if humanoidRootPart.Position.Y < -500 or humanoidRootPart.Position.Magnitude < 100 then
    return false
  end

  return true
end

local function f17(p18)
  if not p18 then
    return false
  end

  if p18:GetAttribute("Boss") or p18:GetAttribute("MiniBoss") or p18:GetAttribute("IsBoss") then
    return true
  end

  local lower = p18.Name:lower()

  if lower:find("chief") or lower:find("boss") or lower:find("enforcer")
    or lower:find("valkskar") or lower:find("gatekeeper") or lower:find("devil")
    or lower:find("professor") then
    return true
  end

  return false
end

local function f18()
  local v27 = f9()

  if v27 and v27:FindFirstChild("NPCs") then
    local v28 = {}

    for index7, value7 in ipairs(v27.NPCs:GetChildren()) do
      if f16(value7) then
        table.insert(v28, value7)
      end
    end

    if #v28 > 0 then
      return v28
    end
  end

  local character = localPlayer.Character
  local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
  local position2 = humanoidRootPart2 and humanoidRootPart2.Position
  local enemy = collectionService:GetTagged("Enemy")
  local v29 = {}

  for index8, value8 in ipairs(enemy) do
    if f16(value8) then
      local humanoidRootPart3 = value8:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart3 and position2
        and (humanoidRootPart3.Position - position2).Magnitude <= 1000 then
        table.insert(v29, value8)
      end
    end
  end

  return v29
end

local function f19(p19, p20)
  local v30 = {}

  if not p19 then
    return v30
  end

  if not p20 then
    p20 = f9()
  end

  local npCs = p20 and p20:FindFirstChild("NPCs")

  if not npCs then
    return v30
  end

  local v31 = {}

  for index9, value9 in ipairs(npCs:GetChildren()) do
    if f16(value9) then
      table.insert(v31, value9)
    end
  end

  local v32 = nil

  for index10, value10 in ipairs(v31) do
    local roomIndex = value10:GetAttribute("RoomIndex")

    if roomIndex then
      if roomIndex == p19.Index then
        table.insert(v30, value10)
      end
    elseif f17(value10) then
      local humanoidRootPart4 = value10:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart4 and humanoidRootPart4.Position.Magnitude > 100 then
        if f13(humanoidRootPart4.Position, p19) then
          table.insert(v30, value10)
        else
          if not v32 then
            v32 = f10(p20)
          end

          local v33 = f14(v32, humanoidRootPart4.Position)

          if v33 and v33.Index == p19.Index then
            table.insert(v30, value10)
          end
        end
      end
    end
  end

  return v30
end

local function f20()
  local v34, v35 = pcall(function()
    local controllers = localPlayer:FindFirstChild("PlayerScripts")
      and localPlayer.PlayerScripts:FindFirstChild("Client")
      and localPlayer.PlayerScripts.Client:FindFirstChild("Controllers")

    local dungeonHUDController = controllers
      and controllers:FindFirstChild("DungeonHUDController")

    if dungeonHUDController then
      local v36 = require(dungeonHUDController)

      if v36 and v36.KnitStart then
        for index11, value11 in ipairs((debug.getupvalues(v36.KnitStart))) do
          if typeof(value11) == "table" and value11.Zones and typeof(value11.Zones) == "table"
            and #value11.Zones > 0 then
            local index12 = nil
            local allCleared = true

            for index13, value12 in ipairs(value11.Zones) do
              if value12.Done ~= true then
                allCleared = false

                if not index12 then
                  index12 = value12.Index
                end
              end
            end

            return {
              Success = true,
              Source = "Controller",
              FirstUnclearedRoomIndex = index12,
              AllCleared = allCleared,
              Zones = value11.Zones,
            }
          end
        end
      end
    end

    return nil
  end)

  if v34 and v35 and v35.Success then
    return v35
  end

  local v37, v38 = pcall(function()
    local playerGui = localPlayer:FindFirstChild("PlayerGui")

    local list = playerGui and playerGui:FindFirstChild("Main")
      and playerGui.Main:FindFirstChild("HUD")
      and playerGui.Main.HUD:FindFirstChild("Dungeon_Container")
      and playerGui.Main.HUD.Dungeon_Container:FindFirstChild("Completion_Progress")
      and playerGui.Main.HUD.Dungeon_Container.Completion_Progress:FindFirstChild("List")

    if list then
      local v39 = {}

      for index14, value13 in ipairs(list:GetChildren()) do
        if value13.Name == "ZoneSlot" and value13:IsA("GuiObject") then
          table.insert(v39, value13)
        end
      end

      table.sort(v39, function(p21, p22) return p21.LayoutOrder < p22.LayoutOrder end)

      if #v39 > 0 then
        local allCleared2 = true
        local v40 = nil

        for index15, value14 in ipairs(v39) do
          local completed = value14:FindFirstChild("Completed")

          if not (completed and completed.Visible == true) then
            allCleared2 = false

            if not v40 then
              v40 = index15
            end
          end
        end

        return {
          Success = true,
          Source = "UI",
          FirstUnclearedSlot = v40,
          AllCleared = allCleared2,
          TotalSlots = #v39,
        }
      end
    end

    return nil
  end)

  if v37 and v38 and v38.Success then
    return v38
  end

  return { Success = false, Source = "None" }
end

local function f21(p23, p24)
  if not p23 or #p23 == 0 then
    return nil
  end

  local v41 = f20()

  if v41.Success and v41.Source == "Controller" then
    if v41.AllCleared then
      return nil
    end

    if v41.FirstUnclearedRoomIndex then
      return v41.FirstUnclearedRoomIndex
    end
  end

  if not p24 then
    p24 = f9()
  end

  local npCs2 = p24 and p24:FindFirstChild("NPCs")

  if npCs2 then
    local huge2 = math.huge

    for index16, value15 in ipairs(npCs2:GetChildren()) do
      if f15(value15) then
        local roomIndex2 = value15:GetAttribute("RoomIndex")

        if not roomIndex2 and f17(value15) then
          local humanoidRootPart5 = value15:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart5 and humanoidRootPart5.Position.Magnitude > 100 then
            local v42 = f14(p23, humanoidRootPart5.Position)

            if v42 then
              roomIndex2 = v42.Index
            end
          end

          if not roomIndex2 then
            for index17, value16 in ipairs(p23) do
              if value16.Model and value16.Model:FindFirstChild("Spawns")
                and value16.Model.Spawns:FindFirstChild("Boss_Spawn") then
                roomIndex2 = value16.Index
                break
              end
            end
          end
        end

        if roomIndex2 and roomIndex2 < huge2 then
          huge2 = roomIndex2
        end
      end
    end

    if huge2 < math.huge then
      for index18, value17 in ipairs(p23) do
        if value17.Index == huge2 then
          return value17.Index
        end
      end

      return huge2
    end
  end

  return nil
end

local function f22(p25)
  local character2 = localPlayer.Character
  local humanoidRootPart6 = character2 and character2:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart6 then
    return nil
  end

  local v43 = p25 or f18()

  if #v43 == 0 then
    return nil
  end

  local v44 = nil
  local huge3 = math.huge
  local v45 = nil
  local huge4 = math.huge

  for index19, value18 in ipairs(v43) do
    local humanoidRootPart7 = value18:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart7 then
      local magnitude2 = (humanoidRootPart7.Position - humanoidRootPart6.Position).Magnitude

      if f17(value18) then
        if magnitude2 < huge3 then
          huge3 = magnitude2
          v44 = value18
        end
      elseif magnitude2 < huge4 then
        huge4 = magnitude2
        v45 = value18
      end
    end
  end

  return v44 or v45
end

local function f23(p26, p27)
  local v46 = nil
  local huge5 = math.huge

  for index20, value19 in ipairs(p26) do
    if not v11.LuredMobs[value19] then
      local humanoidRootPart8 = value19:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart8 then
        local magnitude3 = (humanoidRootPart8.Position - p27.Position).Magnitude

        if magnitude3 <= 120 and magnitude3 < huge5 then
          huge5 = magnitude3
          v46 = value19
        end
      end
    end
  end

  return v46
end

local function f24(p28, p29)
  local toggleFarmAutoSkills = v1.Options.Toggle_Farm_AutoSkills
  local value20

  if toggleFarmAutoSkills ~= nil and toggleFarmAutoSkills.Value ~= nil then
    value20 = toggleFarmAutoSkills.Value
  else
    value20 = v9.FarmAutoSkills
  end

  if not value20 then
    return false
  end

  if localPlayer:GetAttribute("Dead") then
    return false
  end

  local skill = f8("Skill")

  if not skill then
    return false
  end

  local dropdownFarmSkills = v1.Options.Dropdown_Farm_Skills
  local value21

  if dropdownFarmSkills and dropdownFarmSkills.Value then
    value21 = dropdownFarmSkills.Value
  else
    value21 = v9.FarmSkills
  end

  if not value21 then
    return false
  end

  if f7(value21, "Ultimate") and localPlayer:GetAttribute("HasUltimate")
    and localPlayer:GetAttribute("UltimateReady") then
    if pcall(function() skill:FireServer("E", "tap") end) then
      return true, 1.2
    end
  end

  for i = 1, 4 do
    if f7(value21, "Skill " .. i) then
      local v47 = "Skill" .. i
      local getAttribute = localPlayer:GetAttribute(v47 .. "_Charges")
      local getAttribute2 = localPlayer:GetAttribute(v47 .. "_MaxCharges")
      local getAttribute3 = localPlayer:GetAttribute(v47 .. "_OnCooldown")
      local v48 = false

      if getAttribute2 and getAttribute2 > 1 then
        v48 = getAttribute and getAttribute > 0
      else
        v48 = not getAttribute3
      end

      if v48 then
        if pcall(function() skill:FireServer(i, "tap") end) then
          return true, i == 4 and 1.2 or 0.55
        end
      end
    end
  end

  return false, 0
end

local function f25(p30)
  if not p30 or not p30.Enabled then
    return false
  end

  local holdDuration = p30.HoldDuration or 0

  if holdDuration > 0 then
    p30:InputHoldBegin()

    if typeof(fireproximityprompt) == "function" then
      pcall(function() fireproximityprompt(p30, holdDuration) end)
    end

    task.wait(holdDuration + 0.15)
    p30:InputHoldEnd()

    if typeof(fireproximityprompt) == "function" then
      pcall(function() fireproximityprompt(p30, 0) end)
      pcall(function() fireproximityprompt(p30) end)
    end
  else
    if typeof(fireproximityprompt) == "function" then
      pcall(function() fireproximityprompt(p30, 0) end)
      pcall(function() fireproximityprompt(p30) end)
    end

    if p30.InputHoldBegin and p30.InputHoldEnd then
      p30:InputHoldBegin()
      p30:InputHoldEnd()
    end
  end

  return true
end

local function f26(p31, p32, p33)
  if not p31 then
    return false
  end

  local findFirstChild = nil

  if p32 then
    findFirstChild = p31:FindFirstChild(p32, true)
  else
    findFirstChild = p31:FindFirstChildWhichIsA("ProximityPrompt", true)
  end

  if not findFirstChild or not findFirstChild.Enabled then
    return false
  end

  local parent = findFirstChild.Parent

  local position3 = parent and parent:IsA("BasePart") and parent.Position
    or p31:IsA("BasePart") and p31.Position or p31:GetPivot().Position

  if not position3 then
    return false
  end

  local character3 = localPlayer.Character
  local humanoidRootPart9 = character3 and character3:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart9 then
    return false
  end

  local v49 = position3 + Vector3.new(0, 1.5, 0)
  local v50 = os.clock()

  while os.clock() - v50 < (p33 or 3.5) do
    if not findFirstChild or not findFirstChild.Parent or not findFirstChild.Enabled then
      break
    end

    if parent and parent:GetAttribute("Fire") == true then
      break
    end

    humanoidRootPart9.CFrame = CFrame.new(v49, position3)
    humanoidRootPart9.AssemblyLinearVelocity = Vector3.zero
    humanoidRootPart9.AssemblyAngularVelocity = Vector3.zero

    f25(findFirstChild)
    task.wait(0.2)
  end

  return true
end

local function f27()
  if v8 then
    pcall(function()
      local toggleFarmAutoDrops = v1.Options.Toggle_Farm_AutoDrops

      if toggleFarmAutoDrops and toggleFarmAutoDrops.Value ~= nil and toggleFarmAutoDrops.Value
        or v9.FarmAutoDrops then
        v8.SetMagneticRange(150)
        v8.SetCollectDistance(25)
      else
        v8.SetMagneticRange(15)
        v8.SetCollectDistance(2)
      end
    end)
  end
end

local function f28()
  local v51 = 0

  pcall(function()
    local v52 = f1()
    local data = v52 and v52.Data
    local equippedPotion = data and data.EquippedPotion
    local potions = data and data.Potions

    if equippedPotion and potions and potions[equippedPotion] then
      v51 = tonumber(potions[equippedPotion]) or 0
    end
  end)

  return v51
end

local function f29()
  local toggleFarmAutoPotion = v1.Options.Toggle_Farm_AutoPotion

  if not (toggleFarmAutoPotion and toggleFarmAutoPotion.Value ~= nil and toggleFarmAutoPotion.Value
    or v9.FarmAutoPotion) then
    return
  end

  local character4 = localPlayer.Character
  local humanoid2 = character4 and character4:FindFirstChildOfClass("Humanoid")

  if not humanoid2 or humanoid2.Health <= 0 then
    return
  end

  local sliderFarmPotionThreshold = v1.Options.Slider_Farm_PotionThreshold

  local value22 = sliderFarmPotionThreshold and sliderFarmPotionThreshold.Value
    or v9.FarmPotionThreshold or 40

  if humanoid2.Health / humanoid2.MaxHealth * 100 <= value22 then
    local v53 = os.clock()

    if v53 - (v11.LastPotionUse or 0) >= 1.5 then
      v11.LastPotionUse = v53

      pcall(function()
        local findFirstChild2 = replicatedStorage:FindFirstChild("PotionService", true)
        local rf = findFirstChild2 and findFirstChild2:FindFirstChild("RF")
        local usePotion = rf and rf:FindFirstChild("UsePotion")

        if usePotion then
          usePotion:InvokeServer(1)
          v11.UsedPotionThisRun = true
        end
      end)
    end
  end
end

local function f30(p34)
  local toggleFarmAutoChests = v1.Options.Toggle_Farm_AutoChests

  if not (toggleFarmAutoChests and toggleFarmAutoChests.Value ~= nil and toggleFarmAutoChests.Value
    or v9.FarmAutoChests) then
    return
  end

  if not p34 then
    p34 = f9()
  end

  if not p34 then
    return
  end

  local v54 = {}

  for index21, value23 in ipairs(p34:GetChildren()) do
    if value23.Name:find("^DungeonChest_") and value23:IsA("Model") then
      local findFirstChild3 = value23:FindFirstChild("ChestPrompt", true)
        or value23:FindFirstChildWhichIsA("ProximityPrompt", true)

      if findFirstChild3 and findFirstChild3.Enabled then
        table.insert(v54, value23)
      end
    end
  end

  for index22, value24 in ipairs(v54) do
    local findFirstChild4 = value24:FindFirstChild("ChestPrompt", true)
      or value24:FindFirstChildWhichIsA("ProximityPrompt", true)

    if findFirstChild4 and findFirstChild4.Enabled then
      print(string.format("[AutoChests] Sweeping remaining chest: %s", value24.Name))
      f26(value24, nil, 2.5)
      task.wait(1)
    end
  end
end

local function f31(p35)
  local toggleFarmAutoRefillStation = v1.Options.Toggle_Farm_AutoRefillStation

  if not (toggleFarmAutoRefillStation and toggleFarmAutoRefillStation.Value ~= nil
        and toggleFarmAutoRefillStation.Value
      or v9.FarmAutoRefillStation)
    or not p35
    or not p35.Zone then
    return
  end

  local v55 = f9()

  if not v55 then
    return
  end

  for index23, value25 in ipairs(v55:GetChildren()) do
    local v56 = false

    repeat
      if value25.Name == "Potion_Station" and value25:IsA("Model") then
        if f12(value25:GetPivot().Position, p35.Zone) then
          local part = value25:FindFirstChild("Part")

          if part and part:GetAttribute("Fire") == true then
            v56 = true
            break
          end

          local findFirstChildWhichIsA = value25:FindFirstChildWhichIsA("ProximityPrompt", true)

          if findFirstChildWhichIsA and findFirstChildWhichIsA.Enabled then
            f26(value25, nil, 3.5)
            task.wait(1)

            v11.InitialPotionCount = f28()
            v11.UsedPotionThisRun = false

            break
          end
        end
      end

      v56 = true
    until true

    if not v56 then
      break
    end
  end
end

local function f32(p36)
  local toggleFarmAutoBlessing = v1.Options.Toggle_Farm_AutoBlessing

  if not (toggleFarmAutoBlessing and toggleFarmAutoBlessing.Value ~= nil
        and toggleFarmAutoBlessing.Value
      or v9.FarmAutoBlessing)
    or not p36
    or not p36.Zone then
    return
  end

  local v57 = f9()

  if not v57 then
    return
  end

  for index24, value26 in ipairs(v57:GetChildren()) do
    if value26.Name == "Blessing_Altar" and value26:IsA("Model") then
      if f12(value26:GetPivot().Position, p36.Zone) then
        local findFirstChildWhichIsA2 = value26:FindFirstChildWhichIsA("ProximityPrompt", true)

        if findFirstChildWhichIsA2 and findFirstChildWhichIsA2.Enabled then
          f26(value26, nil, 2)
          task.wait(1)
          break
        end
      end
    end
  end
end

local function f33(p37)
  if not p37 or type(p37) ~= "table" or #p37 == 0 then
    return 1
  end

  local v58 = 1
  local v59 = -1

  for index25, value27 in ipairs(p37) do
    local v60 = v6[value27.EffectType or value27.StatKey or value27.Id or ""] or 10

    if v60 > v59 then
      v59 = v60
      v58 = index25
    end
  end

  return v58
end

local function f34(p38, p39)
  if not p38 or type(p38) ~= "table" or #p38 == 0 then
    return { 1, 2 }
  end

  if p39 then
    local v61 = {}

    for j = 1, #p38 do
      table.insert(v61, j)
    end

    return v61
  end

  local v62 = {}

  for index26, value28 in ipairs(p38) do
    local score = v5[value28.Rarity or "Common"] or 0
    table.insert(v62, { Index = index26, Score = score })
  end

  table.sort(v62, function(p40, p41) return p40.Score > p41.Score end)
  local v63 = {}

  for k = 1, math.min(2, #v62) do
    table.insert(v63, v62[k].Index)
  end

  return v63
end

local function f35(p42, p43, p44)
  local toggleFarmAutoEndChests = v1.Options.Toggle_Farm_AutoEndChests

  if not (toggleFarmAutoEndChests and toggleFarmAutoEndChests.Value ~= nil
      and toggleFarmAutoEndChests.Value
    or v9.FarmAutoEndChests) then
    return
  end

  local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

  local hud = playerGui2 and playerGui2:FindFirstChild("Main")
    and playerGui2.Main:FindFirstChild("HUD")

  local chestSelection = hud and hud:FindFirstChild("Chest_Selection")

  if chestSelection then
    chestSelection.Visible = false

    if chestSelection:IsA("CanvasGroup") then
      chestSelection.GroupTransparency = 1
    end
  end

  local v64 = f34(p42, p43)

  pcall(function()
    local findFirstChild5 = replicatedStorage:FindFirstChild("DungeonRunService", true)
    local rf2 = findFirstChild5 and findFirstChild5:FindFirstChild("RF")

    if p44 then
      local selectMidRunChests = rf2 and rf2:FindFirstChild("SelectMidRunChests")

      if selectMidRunChests then
        selectMidRunChests:InvokeServer(v64)
      end
    else
      v11.PendingChestSelection = true
      local selectChests = rf2 and rf2:FindFirstChild("SelectChests")

      if selectChests then
        selectChests:InvokeServer(v64)
      end

      v11.PendingChestSelection = false
      v11.EndChestsClaimed = true
    end
  end)

  task.spawn(function()
    for m = 1, 8 do
      if chestSelection then
        chestSelection.Visible = false

        if chestSelection:IsA("CanvasGroup") then
          chestSelection.GroupTransparency = 1
        end
      end

      task.wait(0.1)
    end
  end)
end

local function f36(p45, p46)
  pcall(function()
    local v65 = require(replicatedStorage.Packages.Knit)

    if p45 == "Replay" then
      if p46 == "BossRush" then
        v65.GetService("BossRushService"):RequestReplay()
        return
      end

      if p46 == "Challenge" then
        v65.GetService("ChallengeRunService"):RequestReplay()
        return
      end

      v65.GetService("DungeonRunService"):RequestReplay()
    elseif p45 == "Return Lobby" then
      if p46 == "BossRush" then
        v65.GetService("BossRushService"):RequestReturn()
        return
      end

      if p46 == "Challenge" then
        v65.GetService("ChallengeRunService"):RequestReturn()
        return
      end

      if p46 == "Raids" then
        v65.GetService("RaidRunService"):RequestReturn()
        return
      end

      v65.GetService("DungeonRunService"):RequestReturn()
    end
  end)
end

local function f37(p47)
  if v11.PostRunActionExecuted then
    return
  end

  v11.PostRunActionExecuted = true

  task.spawn(function()
    local dropdownPostRunWinAction = v1.Options.Dropdown_PostRun_WinAction

    local value29 = dropdownPostRunWinAction and dropdownPostRunWinAction.Value
      or v9.PostRunWinAction or "None"

    if value29 == "None" then
      return
    end

    local status = p47 and p47.Status or "Completed"
    local source = p47 and p47.Source
    local v66 = status == "Completed" or status == "Cleared" or status == "Extracted"

    if v66 then
      f30()
    end

    local togglePostRunWaitForRewards = v1.Options.Toggle_PostRun_WaitForRewards

    if (togglePostRunWaitForRewards and togglePostRunWaitForRewards.Value ~= nil
          and togglePostRunWaitForRewards.Value
        or v9.PostRunWaitForRewards)
      and v66 then
      local toggleFarmAutoEndChests2 = v1.Options.Toggle_Farm_AutoEndChests

      if toggleFarmAutoEndChests2 and toggleFarmAutoEndChests2.Value ~= nil
          and toggleFarmAutoEndChests2.Value
        or v9.FarmAutoEndChests then
        local v67 = os.clock()

        while os.clock() - v67 < 8 do
          if v11.EndChestsClaimed then
            break
          end

          task.wait(0.2)
        end
      end
    end

    local sliderPostRunDelay = v1.Options.Slider_PostRun_Delay

    local postRunActionDelay = sliderPostRunDelay and tonumber(sliderPostRunDelay.Value)
      or v9.PostRunActionDelay or 5

    if postRunActionDelay > 0 then
      task.wait(postRunActionDelay)
    end

    f36(value29, source)
  end)
end

local function f38()
  local dropdownPostRunEndlessChoice = v1.Options.Dropdown_PostRun_EndlessChoice

  local value30 = dropdownPostRunEndlessChoice and dropdownPostRunEndlessChoice.Value
    or v9.PostRunEndlessChoice or "None"

  if value30 == "None" then
    return
  end

  task.spawn(function()
    local v68 = os.clock()

    while os.clock() - v68 < 5 do
      local v69 = false

      pcall(function()
        local chestSelectionController = require(replicatedStorage.Packages.Knit).GetController("ChestSelectionController")

        if chestSelectionController and chestSelectionController.IsActive
          and chestSelectionController:IsActive() then
          v69 = true
        end
      end)

      if not v69 and not v11.PendingChestSelection then
        break
      end

      task.wait(0.2)
    end

    pcall(function()
      local warningController = require(replicatedStorage.Packages.Knit).GetController("WarningController")

      if warningController then
        pcall(function() warningController:Dismiss() end)
      end

      local findFirstChild6 = replicatedStorage:FindFirstChild("DungeonRunService", true)
      local rf3 = findFirstChild6 and findFirstChild6:FindFirstChild("RF")
      local submitEndlessChoice = rf3 and rf3:FindFirstChild("SubmitEndlessChoice")

      if submitEndlessChoice then
        if value30 == "Continue" then
          submitEndlessChoice:InvokeServer(true)
        elseif value30 == "Extract" then
          submitEndlessChoice:InvokeServer(false)
        end
      end
    end)
  end)
end

local function f39(p48)
  if p48 then
    if v12.NoClip then
      return
    end

    v12.NoClip = runService.Stepped:Connect(function()
      if not (v1.Options.Toggle_Farm_AutoFarm and v1.Options.Toggle_Farm_AutoFarm.Value) then
        return
      end

      local character5 = localPlayer.Character
      local humanoid3 = character5 and character5:FindFirstChildOfClass("Humanoid")

      if character5 and humanoid3 and humanoid3.Health > 0 then
        for index27, value31 in ipairs(character5:GetDescendants()) do
          if value31:IsA("BasePart") and value31.CanCollide then
            value31.CanCollide = false
          end
        end
      end
    end)
  else
    if v12.NoClip then
      v12.NoClip:Disconnect()
      v12.NoClip = nil
    end

    local character6 = localPlayer.Character

    if character6 then
      for index28, value32 in ipairs(character6:GetDescendants()) do
        if value32:IsA("BasePart") then
          if value32.Name == "HumanoidRootPart" or value32.Name == "UpperTorso"
            or value32.Name == "LowerTorso" or value32.Name == "Torso" or value32.Name == "Head" then
            value32.CanCollide = true
          end
        end
      end
    end
  end
end

local function f40(p49, p50)
  if p50 then
    local humanoidRootPart10 = p49 and p49:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart10 then
      return
    end

    if not v11.BodyVelocityInstance or v11.BodyVelocityInstance.Parent ~= humanoidRootPart10 then
      if v11.BodyVelocityInstance then
        pcall(function() v11.BodyVelocityInstance:Destroy() end)
      end

      local antiFall = Instance.new("BodyVelocity")
      antiFall.Name = "AntiFall"
      antiFall.MaxForce = Vector3.new(100000, 100000, 100000)
      antiFall.Velocity = Vector3.zero
      antiFall.Parent = humanoidRootPart10

      v11.BodyVelocityInstance = antiFall
    else
      v11.BodyVelocityInstance.Velocity = Vector3.zero
    end
  else
    if v11.BodyVelocityInstance then
      pcall(function() v11.BodyVelocityInstance:Destroy() end)
      v11.BodyVelocityInstance = nil
    end

    local humanoidRootPart11 = p49 and p49:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart11 then
      humanoidRootPart11.AssemblyLinearVelocity = Vector3.zero
      humanoidRootPart11.AssemblyAngularVelocity = Vector3.zero
    end
  end
end

local function f41(p51, p52)
  local toggleFarmAutoPotion2 = v1.Options.Toggle_Farm_AutoPotion

  if not (toggleFarmAutoPotion2 and toggleFarmAutoPotion2.Value ~= nil
      and toggleFarmAutoPotion2.Value
    or v9.FarmAutoPotion) then
    v9.IsEvading = false
    v11.EvadeOriginY = nil
    return false
  end

  local toggleFarmAutoEvade = v1.Options.Toggle_Farm_AutoEvade

  if not (toggleFarmAutoEvade and toggleFarmAutoEvade.Value ~= nil and toggleFarmAutoEvade.Value
    or v9.FarmAutoEvade) then
    v9.IsEvading = false
    v11.EvadeOriginY = nil
    return false
  end

  if not p52 or p52.Health <= 0 or not p51 then
    v9.IsEvading = false
    v11.EvadeOriginY = nil
    return false
  end

  local sliderFarmPotionThreshold2 = v1.Options.Slider_Farm_PotionThreshold

  local value33 = sliderFarmPotionThreshold2 and sliderFarmPotionThreshold2.Value
    or v9.FarmPotionThreshold or 40

  local v70 = p52.Health / p52.MaxHealth * 100

  if not v9.IsEvading then
    if v70 <= value33 and f28() <= 0 then
      v9.IsEvading = true
      v11.EvadeOriginY = p51.Position.Y
    end
  elseif v70 >= 90 then
    v9.IsEvading = false
    v11.EvadeOriginY = nil
  end

  if v9.IsEvading then
    f40(localPlayer.Character, true)
    local v71 = (v11.EvadeOriginY or p51.Position.Y) + 50

    p51.CFrame = CFrame.new(p51.Position.X, v71, p51.Position.Z)
    p51.AssemblyLinearVelocity = Vector3.zero
    p51.AssemblyAngularVelocity = Vector3.zero

    return true
  end

  return false
end

local function f42(p53, p54)
  local position4 = p53.Position

  local v72 = tonumber(v1.Options.Slider_Farm_FlyDistance
        and v1.Options.Slider_Farm_FlyDistance.Value
      or v9.FarmFlyDistance)
    or 15

  local value34 = v1.Options.Dropdown_Farm_FlyMode and v1.Options.Dropdown_Farm_FlyMode.Value
    or v9.FarmFlyMode

  local lookVector = p53.CFrame.LookVector
  local vector = Vector3.new(lookVector.X, 0, lookVector.Z)

  if vector.Magnitude < 0.001 then
    vector = -Vector3.zAxis
  else
    vector = vector.Unit
  end

  if value34 == "Below" then
    local v73 = position4 - Vector3.new(0, v72, 0)
    return CFrame.lookAt(v73, position4, -vector)
  elseif value34 == "Behind" then
    local v74 = position4 - vector * v72 + Vector3.new(0, 1, 0)
    return CFrame.lookAt(v74, position4 + Vector3.new(0, 1, 0), Vector3.yAxis)
  else
    local v75 = position4 + Vector3.new(0, v72, 0)
    return CFrame.lookAt(v75, position4, vector)
  end
end

local function f43()
  if not v9.IsFarmAutoFarmRunning then
    return
  end

  local activeAimTargetHrp = v11.ActiveAimTargetHrp

  if not activeAimTargetHrp or not activeAimTargetHrp.Parent
    or activeAimTargetHrp.Position.Y <= -500 then
    return
  end

  local character7 = localPlayer.Character
  local humanoidRootPart12 = character7 and character7:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart12 and humanoidRootPart12.Parent then
    humanoidRootPart12.CFrame = f42(activeAimTargetHrp, humanoidRootPart12)
    humanoidRootPart12.AssemblyLinearVelocity = activeAimTargetHrp.AssemblyLinearVelocity
    humanoidRootPart12.AssemblyAngularVelocity = Vector3.zero
  end
end

local function f44(p55, p56, p57)
  if not p55 or not p56 then
    return
  end

  local humanoidRootPart13 = p55:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart13 or humanoidRootPart13.Position.Y <= -500 then
    return
  end

  v11.ActiveAimTargetHrp = humanoidRootPart13

  local humanoid4 = localPlayer.Character
    and localPlayer.Character:FindFirstChildOfClass("Humanoid")

  if humanoid4 and humanoid4.AutoRotate then
    humanoid4.AutoRotate = false
  end

  f39(true)

  if (p56.Position - humanoidRootPart13.Position).Magnitude > 30 then
    p56.CFrame = f42(humanoidRootPart13, p56)
    p56.AssemblyLinearVelocity = Vector3.zero
    p56.AssemblyAngularVelocity = Vector3.zero
  end

  local value35 = v1.Options.Toggle_Farm_AutoSkills and v1.Options.Toggle_Farm_AutoSkills.Value

  if value35 == nil then
    value35 = v9.FarmAutoSkills
  end

  local v76 = os.clock()

  if not v11.ActionLockUntil then
    v11.ActionLockUntil = 0
  end

  if v76 >= v11.ActionLockUntil then
    local v77, v78 = false, 0

    if value35 and p57 ~= false then
      v77, v78 = f24(humanoidRootPart13, p56)
    end

    if v77 then
      v11.ActionLockUntil = v76 + (v78 or 0.55)
    else
      local attack = f8("Attack")

      if attack then
        local unit = humanoidRootPart13.Position - p56.Position

        if unit.Magnitude > 0 then
          unit = unit.Unit
        else
          unit = p56.CFrame.LookVector
        end

        pcall(function() attack:FireServer(unit) end)
      end

      v11.ActionLockUntil = v76 + 0.25
    end
  end
end

local function f45(p58, p59, p60)
  local toggleFarmAutoChests2 = v1.Options.Toggle_Farm_AutoChests

  if not (toggleFarmAutoChests2 and toggleFarmAutoChests2.Value ~= nil
        and toggleFarmAutoChests2.Value
      or v9.FarmAutoChests)
    or not p58 then
    return
  end

  if not p60 then
    p60 = f9()
  end

  if not p60 then
    return
  end

  while not v1.Unloaded and v1.Options.Toggle_Farm_AutoFarm
    and v1.Options.Toggle_Farm_AutoFarm.Value do
    local v79 = false

    repeat
      local character8 = localPlayer.Character
      local humanoidRootPart14 = character8 and character8:FindFirstChild("HumanoidRootPart")
      local humanoid5 = character8 and character8:FindFirstChildOfClass("Humanoid")

      if not humanoidRootPart14 or not humanoid5 or humanoid5.Health <= 0 then
        break
      end

      if f41(humanoidRootPart14, humanoid5) then
        task.wait(0.2)
        v79 = true
        break
      end

      local v80 = f18()
      local v81 = {}

      for index29, value36 in ipairs(v80) do
        local humanoidRootPart15 = value36:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart15 and f12(humanoidRootPart15.Position, p58) then
          table.insert(v81, value36)
        end
      end

      if #v81 > 0 then
        if p59 then
          print(string.format(
            "[Loot] %d ambush/mimic mob(s) detected in %s. Fighting...", #v81, p59
          ))
        end

        local v82 = v81[1]

        if v82 and humanoidRootPart14 then
          f44(v82, humanoidRootPart14)
        end

        task.wait(0.1)
      else
        f39(false)
        local v83 = nil

        for index30, value37 in ipairs(p60:GetChildren()) do
          if value37.Name:find("^DungeonChest_") and value37:IsA("Model") then
            if f12(value37:GetPivot().Position, p58) then
              local findFirstChild7 = value37:FindFirstChild("ChestPrompt", true)
                or value37:FindFirstChildWhichIsA("ProximityPrompt", true)

              if findFirstChild7 and findFirstChild7.Enabled then
                v83 = value37
                break
              end
            end
          end
        end

        if v83 then
          f26(v83, nil, 2.5)
          task.wait(2)
        else
          break
        end
      end

      v79 = true
    until true

    if not v79 then
      break
    end
  end

  f39(false)
end

local function f46(p61, p62)
  if not p61 or not p62 then
    return nil
  end

  local connectors = p61:FindFirstChild("Connectors")

  if not connectors then
    return nil
  end

  for index31, value38 in ipairs(connectors:GetChildren()) do
    if value38.Name == "Side" and value38:IsA("BasePart") then
      for index32, value39 in ipairs(p62:GetChildren()) do
        if value39.Name:find("^Locked_") and value39:IsA("Model") then
          local connectors2 = value39:FindFirstChild("Connectors")
          local entry = connectors2 and connectors2:FindFirstChild("Entry")

          if entry and entry:IsA("BasePart") then
            if (value38.Position - entry.Position).Magnitude < 1 then
              return value39
            end
          end
        end
      end
    end
  end

  return nil
end

local function f47()
  if v10.KeyData then
    return v10.KeyData
  end

  pcall(function()
    local v84 = require(replicatedStorage.GameInfo.KeyData)

    if v84 then
      v10.KeyData = v84
    end
  end)

  return v10.KeyData
end

local function f48(p63)
  if not p63 then
    return false
  end

  local v85 = false

  pcall(function()
    local playerData2 = require(localPlayer.PlayerScripts.Client.Controllers.Registry):Get("PlayerData")
    local keys2 = playerData2 and playerData2.Data and playerData2.Data.Keys

    if not keys2 then
      v85 = true
      return
    end

    local v86 = f47()

    if not v86 then
      v85 = true
      return
    end

    local v87 = tostring(p63.ObjectText or "")
    local v88 = nil

    if v86.Tiers then
      for index33, value40 in ipairs(v86.Tiers) do
        if value40.Name and v87:find(value40.Name) then
          v88 = index33
          break
        end
      end
    end

    if not v88 then
      v85 = true
      return
    end

    if (tonumber(keys2["T" .. v88]) or 0) > 0 then
      v85 = true
      return
    end

    local toggleFarmAllowHigherTierKeys = v1.Options.Toggle_Farm_AllowHigherTierKeys

    if not (toggleFarmAllowHigherTierKeys and toggleFarmAllowHigherTierKeys.Value ~= nil
        and toggleFarmAllowHigherTierKeys.Value
      or v9.FarmAllowHigherTierKeys) then
      return
    end

    if (tonumber(keys2[v86.MASTER_KEY_ID or "Master"]) or 0) > 0 then
      v85 = true
      return
    end

    for n = v88 + 1, v86.MAX_TIER or 5 do
      if (tonumber(keys2["T" .. n]) or 0) > 0 then
        if v86.CanOpenDoor then
          if v86.CanOpenDoor(n, v88) then
            v85 = true
            break
          end
        elseif n >= v88 then
          v85 = true
          break
        end
      end
    end
  end)

  return v85
end

local function f49(p64, p65)
  if not p64 then
    return
  end

  local toggleFarmAutoUnlockRooms = v1.Options.Toggle_Farm_AutoUnlockRooms

  if not (toggleFarmAutoUnlockRooms and toggleFarmAutoUnlockRooms.Value ~= nil
      and toggleFarmAutoUnlockRooms.Value
    or v9.FarmAutoUnlockRooms) then
    return
  end

  v11.ProcessedLockedRooms = v11.ProcessedLockedRooms or {}

  if v11.ProcessedLockedRooms[p64.Name] then
    return
  end

  v11.ProcessedLockedRooms[p64.Name] = true

  print(string.format(
    "[LockedRoom] Detected connected room %s. Checking lock prompt...", p64.Name
  ))

  local keyModel = p64:FindFirstChild("KeyModel")

  local findFirstChildWhichIsA3 = keyModel
    and keyModel:FindFirstChildWhichIsA("ProximityPrompt", true)

  if findFirstChildWhichIsA3 and findFirstChildWhichIsA3.Enabled then
    if not f48(findFirstChildWhichIsA3) then
      print(string.format(
        "[LockedRoom] Skipped %s: 0 keys available (%s).", p64.Name,
        tostring(findFirstChildWhichIsA3.ObjectText)
      ))

      return
    end

    print(string.format(
      "[LockedRoom] Interacting with key prompt for %s (%s - %s)...", p64.Name,
      tostring(findFirstChildWhichIsA3.ActionText), tostring(findFirstChildWhichIsA3.ObjectText)
    ))

    f26(keyModel, nil, 2.5)
    task.wait(0.3)
  end

  local findFirstChildWhichIsA4 = keyModel
    and keyModel:FindFirstChildWhichIsA("ProximityPrompt", true)

  if findFirstChildWhichIsA4 and findFirstChildWhichIsA4.Enabled then
    print(string.format(
      "[LockedRoom] %s still locked (no key or prompt failed). Skipping.", p64.Name
    ))

    return
  end

  local zone2 = p64:FindFirstChild("Zone")

  if not zone2 or not zone2:IsA("BasePart") then
    return
  end

  local character9 = localPlayer.Character
  local humanoidRootPart16 = character9 and character9:FindFirstChild("HumanoidRootPart")
  local humanoid6 = character9 and character9:FindFirstChildOfClass("Humanoid")

  if not humanoidRootPart16 or not humanoid6 or humanoid6.Health <= 0 then
    return
  end

  print(string.format(
    "[LockedRoom] Unlocked %s successfully! Teleporting to loot chests.", p64.Name
  ))

  humanoidRootPart16.CFrame = CFrame.new(zone2.Position + Vector3.new(0, 1, 0))
  humanoidRootPart16.AssemblyLinearVelocity = Vector3.zero
  humanoidRootPart16.AssemblyAngularVelocity = Vector3.zero

  task.wait(0.1)
  f45(zone2, p64.Name, p65)
  print(string.format("[LockedRoom] Finished %s. Resuming main route.", p64.Name))
end

local function f50(p66)
  if not p66 then
    return false
  end

  local v89 = false

  pcall(function()
    local playerData3 = require(localPlayer.PlayerScripts.Client.Controllers.Registry):Get("PlayerData")
    local keys3 = playerData3 and playerData3.Data and playerData3.Data.Keys

    if not keys3 then
      v89 = true
      return
    end

    local v90 = f47()
    local v91, v92 = tostring(p66.ObjectText or ""):match("(%d+)x%s*(.+)")
    local v93 = tonumber(v91) or 1
    local v94 = nil

    if v90 and v90.Tiers then
      for index34, value41 in ipairs(v90.Tiers) do
        if value41.Name and v92 and v92:find(value41.Name) then
          v94 = index34
          break
        end
      end
    end

    if not v94 then
      if v92 and v92:find("Platinum") then
        v94 = 4
      elseif v92 and v92:find("Celestial") then
        v94 = 5
      elseif v92 and v92:find("Gold") then
        v94 = 3
      elseif v92 and v92:find("Silver") then
        v94 = 2
      elseif v92 and v92:find("Bronze") then
        v94 = 1
      end
    end

    if not v94 then
      v89 = true
      return
    end

    local v95 = tonumber(keys3["T" .. v94]) or 0

    if v95 >= v93 then
      v89 = true
      return
    end

    if v95 + (tonumber(keys3[v90 and v90.MASTER_KEY_ID or "Master"]) or 0) >= v93 then
      v89 = true
      return
    end
  end)

  return v89
end

local function f51(p67, p68)
  local toggleFarmAutoSpecialBoss = v1.Options.Toggle_Farm_AutoSpecialBoss

  if not (toggleFarmAutoSpecialBoss and toggleFarmAutoSpecialBoss.Value ~= nil
        and toggleFarmAutoSpecialBoss.Value
      or v9.FarmAutoSpecialBoss)
    or not p67 then
    return
  end

  if not p68 then
    p68 = f9()
  end

  if not p68 then
    return
  end

  v11.ProcessedTotems = v11.ProcessedTotems or {}

  for index35, value42 in ipairs(p68:GetChildren()) do
    if value42.Name == "Skull_Totem" and value42:IsA("Model")
      and not v11.ProcessedTotems[value42] then
      local position5 = value42:GetPivot().Position
      local v96 = false

      if p67.Zone and p67.Zone:IsA("BasePart") then
        v96 = f12(position5, p67.Zone)
      else
        v96 = f13(position5, p67)
      end

      if v96 then
        local findFirstChildWhichIsA5 = value42:FindFirstChildWhichIsA("ProximityPrompt", true)

        if findFirstChildWhichIsA5
          and findFirstChildWhichIsA5.ActionText == "Summon Special Boss"
          and findFirstChildWhichIsA5.Enabled then
          if f50(findFirstChildWhichIsA5) then
            v11.ProcessedTotems[value42] = true

            print(string.format(
              "[SpecialBoss] Detected Skull_Totem in %s (%s). Interacting...",
              p67.Name or "Room", tostring(findFirstChildWhichIsA5.ObjectText)
            ))

            f26(value42, nil, 3)
            task.wait(0.5)

            v11.RoomCombatStarted = false
            v11.RoomEntryTime = os.clock()

            break
          end

          print(string.format(
            "[SpecialBoss] Skipped Skull_Totem in %s: Insufficient keys (%s).",
            p67.Name or "Room", tostring(findFirstChildWhichIsA5.ObjectText)
          ))
        end
      end
    end
  end
end

local function f52()
  if v9.IsFarmAutoFarmRunning
    or not (v1.Options.Toggle_Farm_AutoFarm and v1.Options.Toggle_Farm_AutoFarm.Value) then
    return
  end

  v9.IsFarmAutoFarmRunning = true

  task.spawn(function()
    local character10 = localPlayer.Character

    if character10 then
      f40(character10, true)
    end

    pcall(sethiddenproperty, localPlayer, "SimulationRadius", math.huge)
    pcall(sethiddenproperty, localPlayer, "MaximumSimulationRadius", math.huge)

    local v97 = f10((f9()))
    local humanoidRootPart17 = character10 and character10:FindFirstChild("HumanoidRootPart")

    if v97 and #v97 > 0 and humanoidRootPart17 then
      local v98 = nil
      local v99 = f20()

      if v99.Success and v99.FirstUnclearedRoomIndex then
        for index36, value43 in ipairs(v97) do
          if value43.Index == v99.FirstUnclearedRoomIndex then
            v98 = value43
            break
          end
        end
      end

      if not v98 then
        v98 = f14(v97, humanoidRootPart17.Position) or v97[1]
      end

      if v98 then
        v11.CurrentRoomIndex = v98.Index
        v11.RoomCombatStarted = false
        v11.RoomEntryTime = os.clock()
        v11.LastWaitSec = -1

        print(string.format(
          "[AutoFarm] Started/Resumed at Room_%d (Total rooms: %d).", v98.Index, #v97
        ))
      end
    end

    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoFarm
      and v1.Options.Toggle_Farm_AutoFarm.Value do
      local v100 = false

      repeat
        local character11 = localPlayer.Character

        local humanoidRootPart18 = character11
          and character11:FindFirstChild("HumanoidRootPart")

        local humanoid7 = character11 and character11:FindFirstChildOfClass("Humanoid")

        if character11 and humanoidRootPart18 and humanoid7 and humanoid7.Health > 0 then
          pcall(sethiddenproperty, localPlayer, "SimulationRadius", math.huge)
          f40(character11, true)
          f29()

          if f41(humanoidRootPart18, humanoid7) then
            task.wait(0.2)
            v100 = true
            break
          end

          local v101 = f9()

          if v101 and not v11.LockedRoomsLogged then
            v11.LockedRoomsLogged = true
            local v102 = {}

            for index37, value44 in ipairs(v101:GetChildren()) do
              if value44.Name:find("^Locked_") and value44:IsA("Model") then
                local parentRoomIndex = value44:GetAttribute("ParentRoomIndex")

                if parentRoomIndex then
                  table.insert(
                    v102, string.format("%s (Room_%d)", value44.Name, parentRoomIndex)
                  )
                else
                  table.insert(v102, value44.Name)
                end
              end
            end

            if #v102 > 0 then
              print(string.format(
                "[LockedRoom] Map generated with %d locked room(s): %s", #v102,
                table.concat(v102, ", ")
              ))
            else
              print("[LockedRoom] Map generated with 0 locked rooms.")
            end
          end

          local v103 = f10(v101)
          local v104 = f18()

          if #v103 > 0 then
            local v105 = f21(v103, v101)

            if v105 and v105 < (v11.CurrentRoomIndex or 0) and not v11.RoomCombatStarted then
              local v106 = nil

              for index38, value45 in ipairs(v103) do
                if value45.Index == v105 then
                  v106 = value45
                  break
                end
              end

              if v106 then
                print(string.format(
                  "[AutoRescue] Detected uncleared Room_%d with living mobs. Returning...", v105
                ))

                v11.CurrentRoomIndex = v105
                v11.RoomEntryTime = os.clock()
                v11.RoomCombatStarted = false
                v11.LastWaitSec = -1

                local v107 = f11(v106)

                if v107 then
                  humanoidRootPart18.CFrame = CFrame.new(v107 + Vector3.new(0, 1, 0))
                  humanoidRootPart18.AssemblyLinearVelocity = Vector3.zero
                  humanoidRootPart18.AssemblyAngularVelocity = Vector3.zero
                end

                task.wait(0.2)
                v100 = true
                break
              end
            end

            local v108 = nil

            for index39, value46 in ipairs(v103) do
              if value46.Index == v11.CurrentRoomIndex then
                v108 = value46
                break
              end
            end

            if not v108 then
              local v109 = f21(v103, v101)

              if v109 then
                for index40, value47 in ipairs(v103) do
                  if value47.Index == v109 then
                    v108 = value47
                    break
                  end
                end
              end

              if not v108 then
                v108 = f14(v103, humanoidRootPart18.Position) or v103[1]
              end

              v11.CurrentRoomIndex = v108.Index
              v11.RoomEntryTime = os.clock()
              v11.RoomCombatStarted = false
              v11.LastWaitSec = -1
            end

            v104 = f19(v108, v101)

            if #v104 > 0 then
              v11.RoomCombatStarted = true
            end

            if v11.LastLoggedRoom ~= v11.CurrentRoomIndex then
              v11.LastLoggedRoom = v11.CurrentRoomIndex
              v11.RoomEntryTime = os.clock()
              v11.RoomCombatStarted = #v104 > 0
              v11.LastWaitSec = -1

              print(string.format(
                "[AutoFarm] Entered Room_%d (Combat: %s, Enemies: %d).", v11.CurrentRoomIndex,
                tostring(v108.IsCombat), #v104
              ))
            end

            local v110 = false

            if v108.IsCombat then
              local v111 = false
              local v112 = f20()

              if v112.Success and v112.Zones then
                for index41, value48 in ipairs(v112.Zones) do
                  if value48.Index == v108.Index then
                    v111 = value48.Done == true
                    break
                  end
                end
              end

              if v111 then
                v110 = true
              elseif v11.RoomCombatStarted then
                v110 = #v104 == 0
              else
                v110 = os.clock() - (v11.RoomEntryTime or 0) >= 3.5 and #v104 == 0
              end
            else
              v110 = #v104 == 0
            end

            if #v104 == 0 then
              f39(false)

              if v110 then
                print(string.format(
                  "[AutoFarm] Room_%d cleared. Running post-combat interactions...", v108.Index
                ))

                if v108.Zone then
                  f45(v108.Zone, v108.Model and v108.Model.Name, v101)
                end

                f31(v108)
                f32(v108)
                f51(v108, v101)
                local v113 = f46(v108.Model, v101)

                if v113 then
                  f49(v113, v101)
                end

                local v114 = nil

                for index42, value49 in ipairs(v103) do
                  if value49.Index > (v11.CurrentRoomIndex or 0) then
                    v114 = value49
                    break
                  end
                end

                if v114 then
                  if v11.LastLoggedAdvancing ~= v114.Index then
                    v11.LastLoggedAdvancing = v114.Index
                  end

                  print(string.format(
                    "[AutoFarm] Advancing from Room_%d to Room_%d...", v11.CurrentRoomIndex,
                    v114.Index
                  ))

                  v11.CurrentRoomIndex = v114.Index
                  v11.RoomEntryTime = os.clock()
                  v11.RoomCombatStarted = false
                  v11.LastWaitSec = -1

                  local v115 = f11(v114)

                  if v115 then
                    humanoidRootPart18.CFrame = CFrame.new(v115 + Vector3.new(0, 1, 0))
                    humanoidRootPart18.AssemblyLinearVelocity = Vector3.zero
                    humanoidRootPart18.AssemblyAngularVelocity = Vector3.zero
                  end
                else
                  local v116 = f21(v103, v101)

                  if v116 and v116 <= (v11.CurrentRoomIndex or 0) then
                    print(string.format(
                      "[SafeProgression] Rescue: Room_%d has living mobs. Returning to clear...",
                      v116
                    ))

                    v11.CurrentRoomIndex = v116
                    v11.RoomEntryTime = os.clock()
                    v11.RoomCombatStarted = false

                    local v117 = nil

                    for index43, value50 in ipairs(v103) do
                      if value50.Index == v116 then
                        v117 = value50
                        break
                      end
                    end

                    local v118 = v117 and f11(v117)

                    if v118 then
                      humanoidRootPart18.CFrame = CFrame.new(v118 + Vector3.new(0, 1, 0))
                      humanoidRootPart18.AssemblyLinearVelocity = Vector3.zero
                      humanoidRootPart18.AssemblyAngularVelocity = Vector3.zero
                    end
                  else
                    local v119 = f20()
                    local v120 = false

                    if v119.Success and v119.AllCleared then
                      v120 = true
                    elseif not v119.Success and not v116 then
                      v120 = true
                    end

                    if v120 then
                      if v11.LastLoggedAdvancing ~= -1 then
                        v11.LastLoggedAdvancing = -1
                        print("[AutoFarm] All rooms cleared. Boss defeated! Sweeping remaining chests...")
                      end

                      if not v11.ChestsSwept then
                        v11.ChestsSwept = true
                        f30(v101)
                      end
                    elseif v119.FirstUnclearedRoomIndex then
                      v11.CurrentRoomIndex = v119.FirstUnclearedRoomIndex
                      v11.RoomEntryTime = os.clock()
                      v11.RoomCombatStarted = false
                    end
                  end
                end
              else
                local v121 = f11(v108)

                if v121 and (humanoidRootPart18.Position - v121).Magnitude > 4 then
                  humanoidRootPart18.CFrame = CFrame.new(v121 + Vector3.new(0, 1, 0))
                  humanoidRootPart18.AssemblyLinearVelocity = Vector3.zero
                  humanoidRootPart18.AssemblyAngularVelocity = Vector3.zero
                end
              end
            end
          end

          for key2 in pairs(v11.LuredMobs) do
            if not f15(key2) then
              v11.LuredMobs[key2] = nil
            end
          end

          local value51 = v1.Options.Toggle_Farm_MobLure
            and v1.Options.Toggle_Farm_MobLure.Value

          if value51 == nil then
            value51 = v9.FarmMobLure
          end

          local v122 = nil

          if value51 and #v104 > 1 then
            v122 = f23(v104, humanoidRootPart18)
          end

          local currentTarget = v122

          if currentTarget then
            if v11.CurrentLureMob ~= currentTarget then
              v11.CurrentLureMob = currentTarget
              v11.LureStartTime = os.clock()
            end
          else
            v11.CurrentLureMob = nil

            local value52 = v1.Options.Toggle_Farm_TargetLock
              and v1.Options.Toggle_Farm_TargetLock.Value

            if value52 == nil then
              value52 = v9.FarmTargetLock
            end

            if not value52 or not v11.CurrentTarget or not f15(v11.CurrentTarget)
              or not table.find(v104, v11.CurrentTarget) then
              v11.CurrentTarget = f22(v104)
            end

            currentTarget = v11.CurrentTarget
          end

          local humanoidRootPart19 = currentTarget
            and currentTarget:FindFirstChild("HumanoidRootPart")

          if currentTarget and humanoidRootPart19 and humanoidRootPart19.Position.Y > -500 then
            f44(currentTarget, humanoidRootPart18, not (v122 and currentTarget == v122))

            if v122 and currentTarget == v122 then
              local v123 = os.clock()

              if v123 - (v11.LureStartTime or v123) >= 0.7 then
                v11.LuredMobs[v122] = true
                v11.CurrentLureMob = nil
              end
            end
          end
        else
          f39(false)

          v11.CurrentTarget = nil
          v11.CurrentLureMob = nil
          v11.ActiveAimTargetHrp = nil
          v11.ActionLockUntil = 0

          local v124 = f9()
          local v125 = f21(f10(v124), v124)

          if v125 then
            v11.CurrentRoomIndex = v125
          end

          v11.LastLoggedRoom = 0
          v11.LastLoggedAdvancing = 0
          v11.RoomEntryTime = 0
          v11.RoomCombatStarted = false
          v11.LastWaitSec = -1
          v11.ProcessedLockedRooms = {}
          v11.ChestsSwept = false
          v11.LockedRoomsLogged = false

          v9.IsEvading = false

          v11.EvadeOriginY = nil
          v11.ProcessedTotems = {}

          if v11.BodyVelocityInstance then
            pcall(function() v11.BodyVelocityInstance:Destroy() end)
            v11.BodyVelocityInstance = nil
          end
        end

        task.wait(0.15)
        v100 = true
      until true

      if not v100 then
        break
      end
    end

    f39(false)
    local character12 = localPlayer.Character

    if character12 then
      f40(character12, false)
      local humanoid8 = character12:FindFirstChildOfClass("Humanoid")

      if humanoid8 then
        humanoid8.AutoRotate = true
      end
    end

    v11.CurrentTarget = nil
    v11.CurrentLureMob = nil
    v11.ActiveAimTargetHrp = nil
    v11.ActionLockUntil = 0

    local v126 = f10((f9()))

    if v126 and #v126 > 0 then
      local character13 = localPlayer.Character
      local humanoidRootPart20 = character13 and character13:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart20 then
        local v127 = f14(v126, humanoidRootPart20.Position)

        if v127 then
          v11.CurrentRoomIndex = v127.Index
          print(string.format("[AutoFarm] Stopped at Room_%d.", v127.Index))
        end
      end
    end

    v11.LastLoggedRoom = 0
    v11.LastLoggedAdvancing = 0
    v11.RoomEntryTime = 0
    v11.RoomCombatStarted = false
    v11.LastWaitSec = -1
    v11.ProcessedLockedRooms = {}
    v11.ChestsSwept = false
    v11.LockedRoomsLogged = false
    v11.ProcessedTotems = {}

    if type(v11.LuredMobs) == "table" then
      table.clear(v11.LuredMobs)
    end

    v9.IsFarmAutoFarmRunning = false
  end)
end

local function f53(p69)
  local humanoid9 = p69 and p69:FindFirstChildOfClass("Humanoid")
  local animator = humanoid9 and humanoid9:FindFirstChildOfClass("Animator")

  if not animator then
    return
  end

  if v12.AnimPlayed then
    v12.AnimPlayed:Disconnect()
    v12.AnimPlayed = nil
  end

  v12.AnimPlayed = animator.AnimationPlayed:Connect(function(p70)
    local toggleSettingsDisableActionAnim = v1.Options.Toggle_Settings_DisableActionAnim

    if not (toggleSettingsDisableActionAnim and toggleSettingsDisableActionAnim.Value ~= nil
        and toggleSettingsDisableActionAnim.Value
      or v9.SettingsDisableActionAnim) then
      return
    end

    local priority = p70.Priority

    if priority == Enum.AnimationPriority.Action or priority == Enum.AnimationPriority.Action2
      or priority == Enum.AnimationPriority.Action3
      or priority == Enum.AnimationPriority.Action4 then
      pcall(function()
        p70:AdjustWeight(0, 0)
        p70:Stop(0)
      end)
    end
  end)

  for index44, value53 in ipairs(animator:GetPlayingAnimationTracks()) do
    local priority2 = value53.Priority

    if priority2 == Enum.AnimationPriority.Action or priority2 == Enum.AnimationPriority.Action2
      or priority2 == Enum.AnimationPriority.Action3
      or priority2 == Enum.AnimationPriority.Action4 then
      pcall(function()
        value53:AdjustWeight(0, 0)
        value53:Stop(0)
      end)
    end
  end
end

local function f54(p71, p72)
  pcall(function()
    local findFirstChild8 = replicatedStorage:FindFirstChild("SettingsService", true)
    local rf4 = findFirstChild8 and findFirstChild8:FindFirstChild("RF")
    local setSetting = rf4 and rf4:FindFirstChild("SetSetting")

    if setSetting then
      setSetting:InvokeServer(p71, p72)
    end
  end)
end

local function f55(p73)
  local v128 = {
    HideSelfVFX = true,
    HideOtherVFX = true,
    DisableBloom = true,
    DisableSunrays = true,
    DisableDepth = true,
    DisableShadows = true,
    HidePlayerAccessories = true,
    HideWeaponCosmetic = true,
    DisableSprintZoom = true,
    ReduceMotion = true,
  }

  if p73 then
    pcall(function()
      local findFirstChild9 = replicatedStorage:FindFirstChild("SettingsService", true)
      local rf5 = findFirstChild9 and findFirstChild9:FindFirstChild("RF")
      local getSettings = rf5 and rf5:FindFirstChild("GetSettings")

      if getSettings then
        local invokeServer = getSettings:InvokeServer()

        if type(invokeServer) == "table" then
          v11.PreviousGameSettings = {}

          for key3 in pairs(v128) do
            if invokeServer[key3] ~= nil then
              v11.PreviousGameSettings[key3] = invokeServer[key3]
            end
          end

          if invokeServer.ShowHitbox ~= nil then
            v11.PreviousGameSettings.ShowHitbox = invokeServer.ShowHitbox
          end
        end
      end
    end)

    for key4, value54 in pairs(v128) do
      f54(key4, value54)
    end

    pcall(function()
      local v129 = require(localPlayer.PlayerScripts.Client.Controllers.SettingsController)
      local playerGui3 = localPlayer:FindFirstChild("PlayerGui")
      local settings = playerGui3 and playerGui3:FindFirstChild("Settings")
      local findFirstChild10 = settings and settings:FindFirstChild("Potato", true)

      local findFirstChild11 = findFirstChild10
        and findFirstChild10:FindFirstChild("CheckBox", true)

      if findFirstChild11 then
        local v130 = getconnections(findFirstChild11.MouseButton1Click)
        local v131 = v130[1] and v130[1].Function

        if v131 then
          local v132 = getupvalues(v131)
          local v133 = v132[3]
          local v134 = v132[4]

          if type(v133) == "function" then
            v133()
          end

          if v132[1] and type(v132[1]) == "table" then
            v132[1]._potatoActive = true
          end

          if type(v134) == "function" and findFirstChild10 then
            v134(findFirstChild10, true, false)
          end
        end
      end
    end)

    f54("ShowHitbox", true)
  elseif v11.PreviousGameSettings and next(v11.PreviousGameSettings) then
    for key5, value55 in pairs(v11.PreviousGameSettings) do
      f54(key5, value55)
    end

    table.clear(v11.PreviousGameSettings)
  else
    for key6 in pairs(v128) do
      f54(key6, false)
    end

    f54("ShowHitbox", false)
  end
end

local function f56()
  pcall(function()
    local findFirstChild12 = replicatedStorage:FindFirstChild("DungeonRunService", true)
    local re = findFirstChild12 and findFirstChild12:FindFirstChild("RE")

    if re then
      local zoneEntered = re:FindFirstChild("ZoneEntered")

      if zoneEntered and zoneEntered:IsA("RemoteEvent") then
        v12.ZoneEntered = zoneEntered.OnClientEvent:Connect(function(p74)
          local v135 = tonumber(p74)

          if v135 and v135 > (v11.CurrentRoomIndex or 0) then
            print(string.format("[SafeProgression] Server ZoneEntered: Room_%d", v135))
            v11.CurrentRoomIndex = v135
            v11.CurrentTarget = nil
          end
        end)
      end

      local stateUpdate = re:FindFirstChild("StateUpdate")

      if stateUpdate and stateUpdate:IsA("RemoteEvent") then
        v12.StateUpdate = stateUpdate.OnClientEvent:Connect(function(p75, p76, p77, p78, p79)
          local v136 = tonumber(p78)

          if v136 and v136 > (v11.CurrentRoomIndex or 0) then
            v11.CurrentRoomIndex = v136
            v11.CurrentTarget = nil
          end
        end)
      end

      local chestSelection2 = re:FindFirstChild("ChestSelection")

      if chestSelection2 and chestSelection2:IsA("RemoteEvent") then
        v12.ChestSelection = chestSelection2.OnClientEvent:Connect(function(p80, p81)
          f35(p80, p81, false)
        end)
      end

      local midRunChestSelection = re:FindFirstChild("MidRunChestSelection")

      if midRunChestSelection and midRunChestSelection:IsA("RemoteEvent") then
        v12.MidChestSelection = midRunChestSelection.OnClientEvent:Connect(function(p82, p83)
          f35(p82, p83, true)
        end)
      end

      local dungeonComplete = re:FindFirstChild("DungeonComplete")

      if dungeonComplete and dungeonComplete:IsA("RemoteEvent") then
        v12.DungeonComplete = dungeonComplete.OnClientEvent:Connect(function(p84) f37(p84) end)
      end

      local endlessDecision = re:FindFirstChild("EndlessDecision")

      if endlessDecision and endlessDecision:IsA("RemoteEvent") then
        v12.EndlessDecision = endlessDecision.OnClientEvent:Connect(function() f38() end)
      end

      local replayStarting = re:FindFirstChild("ReplayStarting")

      if replayStarting and replayStarting:IsA("RemoteEvent") then
        v12.ReplayStarting = replayStarting.OnClientEvent:Connect(function()
          v11.EndChestsClaimed = false
          v11.PendingChestSelection = false
          v11.PostRunActionExecuted = false
          v11.CurrentRoomIndex = 1
          v11.LastLoggedRoom = 0
          v11.LastLoggedAdvancing = 0
          v11.RoomEntryTime = 0
          v11.RoomCombatStarted = false
          v11.LastWaitSec = -1
          v11.CurrentTarget = nil

          table.clear(v11.LuredMobs)

          v11.ProcessedLockedRooms = {}
          v11.ChestsSwept = false
          v11.LockedRoomsLogged = false
          v11.ProcessedTotems = {}
          v11.PendingDungeonReady = true
        end)
      end
    end

    for index45, value56 in ipairs({ "BossRushService", "ChallengeRunService" }) do
      local findFirstChild13 = replicatedStorage:FindFirstChild(value56, true)
      local re2 = findFirstChild13 and findFirstChild13:FindFirstChild("RE")
      local dungeonComplete2 = re2 and re2:FindFirstChild("DungeonComplete")

      if dungeonComplete2 and dungeonComplete2:IsA("RemoteEvent") then
        v12[value56 .. "_DungeonComplete"] = dungeonComplete2.OnClientEvent:Connect(function(p85)
          f37(p85)
        end)
      end

      local replayStarting2 = re2 and re2:FindFirstChild("ReplayStarting")

      if replayStarting2 and replayStarting2:IsA("RemoteEvent") then
        v12[value56 .. "_ReplayStarting"] = replayStarting2.OnClientEvent:Connect(function()
          v11.EndChestsClaimed = false
          v11.PendingChestSelection = false
          v11.PostRunActionExecuted = false
          v11.CurrentRoomIndex = 1
          v11.LastLoggedRoom = 0
          v11.LastLoggedAdvancing = 0
          v11.RoomEntryTime = 0
          v11.RoomCombatStarted = false
          v11.LastWaitSec = -1
          v11.CurrentTarget = nil

          table.clear(v11.LuredMobs)

          v11.ProcessedLockedRooms = {}
          v11.ChestsSwept = false
          v11.LockedRoomsLogged = false
          v11.ProcessedTotems = {}
          v11.PendingDungeonReady = true
        end)
      end
    end

    local findFirstChild14 = replicatedStorage:FindFirstChild("DungeonRunService", true)
    local re3 = findFirstChild14 and findFirstChild14:FindFirstChild("RE")
    local specialBossSummonPrompt = re3 and re3:FindFirstChild("SpecialBossSummonPrompt")

    if specialBossSummonPrompt and specialBossSummonPrompt:IsA("RemoteEvent") then
      v12.SpecialBossSummonPrompt = specialBossSummonPrompt.OnClientEvent:Connect(function(p86)
        local toggleFarmAutoSpecialBoss2 = v1.Options.Toggle_Farm_AutoSpecialBoss

        if (toggleFarmAutoSpecialBoss2 and toggleFarmAutoSpecialBoss2.Value ~= nil
              and toggleFarmAutoSpecialBoss2.Value
            or v9.FarmAutoSpecialBoss)
          and p86
          and p86.CanAfford then
          pcall(function()
            local rf6 = findFirstChild14:FindFirstChild("RF")

            local confirmSpecialBossSummon = rf6
              and rf6:FindFirstChild("ConfirmSpecialBossSummon")

            if confirmSpecialBossSummon then
              confirmSpecialBossSummon:InvokeServer(true)

              print(string.format(
                "[SpecialBoss] Auto confirmed Special Boss summon: %s.",
                tostring(p86.BossName or "Boss")
              ))
            end
          end)
        end
      end)
    end

    local findFirstChild15 = replicatedStorage:FindFirstChild("DungeonBuffService", true)
    local re4 = findFirstChild15 and findFirstChild15:FindFirstChild("RE")
    local buffSelection = re4 and re4:FindFirstChild("BuffSelection")

    if buffSelection and buffSelection:IsA("RemoteEvent") then
      v12.BuffSelection = buffSelection.OnClientEvent:Connect(function(p87)
        local toggleFarmAutoBlessing2 = v1.Options.Toggle_Farm_AutoBlessing

        if not (toggleFarmAutoBlessing2 and toggleFarmAutoBlessing2.Value ~= nil
            and toggleFarmAutoBlessing2.Value
          or v9.FarmAutoBlessing) then
          return
        end

        local playerGui4 = localPlayer:FindFirstChild("PlayerGui")

        local hud2 = playerGui4 and playerGui4:FindFirstChild("Main")
          and playerGui4.Main:FindFirstChild("HUD")

        local boostSelection = hud2 and hud2:FindFirstChild("Boost_Selection")

        if boostSelection then
          boostSelection.Visible = false

          if boostSelection:IsA("CanvasGroup") then
            boostSelection.GroupTransparency = 1
          end
        end

        local v137 = f33(p87)

        pcall(function()
          local rf7 = findFirstChild15:FindFirstChild("RF")
          local selectBuff = rf7 and rf7:FindFirstChild("SelectBuff")

          if selectBuff then
            selectBuff:InvokeServer(v137)
          end
        end)

        task.spawn(function()
          for i6 = 1, 8 do
            if boostSelection then
              boostSelection.Visible = false

              if boostSelection:IsA("CanvasGroup") then
                boostSelection.GroupTransparency = 1
              end
            end

            task.wait(0.1)
          end
        end)
      end)
    end
  end)

  v12.InDungeon = localPlayer:GetAttributeChangedSignal("InDungeon"):Connect(function()
    v11.CurrentRoomIndex = 1
    v11.LastLoggedRoom = 0
    v11.LastLoggedAdvancing = 0
    v11.RoomEntryTime = 0
    v11.RoomCombatStarted = false
    v11.LastWaitSec = -1
    v11.CurrentTarget = nil
    v11.InitialPotionCount = f28()
    v11.UsedPotionThisRun = false
    v11.EndChestsClaimed = false
    v11.PendingChestSelection = false
    v11.PostRunActionExecuted = false

    f27()
    table.clear(v11.LuredMobs)
  end)

  v12.MobSync = runService.RenderStepped:Connect(f43)
end

local window = v1:CreateWindow({ Title = "[Gameplay] Dungeon Lootr", SubTitle = "by Lamduck" })

local v138 = {
  Farm = window:AddTab({ Title = "Farm", Icon = "swords" }),
  PostRun = window:AddTab({ Title = "Post-Run", Icon = "rotate-cw" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

v138.Farm:AddSection("Auto Farm")

v138.Farm:AddToggle("Toggle_Farm_AutoFarm", {
  Title = "Auto Farm",
  Default = false,
  Callback = function(value57)
    if value57 then
      task.spawn(function()
        while v9.IsFarmAutoFarmRunning do
          task.wait(0.05)
        end

        if v1.Options.Toggle_Farm_AutoFarm and v1.Options.Toggle_Farm_AutoFarm.Value then
          f52()
        end
      end)
    end
  end,
})

v138.Farm:AddToggle("Toggle_Farm_TargetLock", {
  Title = "Target Lock",
  Default = true,
  Callback = function(value58) v9.FarmTargetLock = value58 end,
})

v138.Farm:AddToggle("Toggle_Farm_MobLure", {
  Title = "Mob Lure (Aggro)",
  Default = false,
  Callback = function(value59)
    v9.FarmMobLure = value59

    if not value59 then
      table.clear(v11.LuredMobs)
    end
  end,
})

v138.Farm:AddDropdown("Dropdown_Farm_FlyMode", {
  Title = "Fly Mode",
  Values = { "Above", "Below", "Behind" },
  Default = "Above",
  Callback = function(value60) v9.FarmFlyMode = value60 end,
})

v138.Farm:AddSlider("Slider_Farm_FlyDistance", {
  Title = "Fly Distance",
  Min = 0,
  Max = 30,
  Default = 15,
  Rounding = 0,
  Callback = function(value61) v9.FarmFlyDistance = value61 end,
})

v138.Farm:AddSection("Skills")

v138.Farm:AddToggle("Toggle_Farm_AutoSkills", {
  Title = "Auto Skills",
  Default = true,
  Callback = function(value62) v9.FarmAutoSkills = value62 end,
})

v138.Farm:AddDropdown("Dropdown_Farm_Skills", {
  Title = "Select Skills",
  Values = { "Skill 1", "Skill 2", "Skill 3", "Skill 4", "Ultimate" },
  Multi = true,
  Default = {
    ["Skill 1"] = true,
    ["Skill 2"] = true,
    ["Skill 3"] = true,
    ["Skill 4"] = true,
    Ultimate = true,
  },
  Callback = function(value63) v9.FarmSkills = value63 end,
})

v138.Farm:AddSection("Health & Potion")

v138.Farm:AddToggle("Toggle_Farm_AutoPotion", {
  Title = "Auto Potion",
  Default = true,
  Callback = function(value64) v9.FarmAutoPotion = value64 end,
})

v138.Farm:AddSlider("Slider_Farm_PotionThreshold", {
  Title = "Health Percent",
  Min = 10,
  Max = 70,
  Default = 40,
  Rounding = 0,
  Callback = function(value65) v9.FarmPotionThreshold = value65 end,
})

v138.Farm:AddDivider()

v138.Farm:AddToggle("Toggle_Farm_AutoEvade", {
  Title = "Emergency Evade",
  Description = "Requires Auto Potion. Flies up when out of potions & HP is low",
  Default = false,
  Callback = function(value66)
    v9.FarmAutoEvade = value66

    if not value66 then
      v9.IsEvading = false
      v11.EvadeOriginY = nil
    end
  end,
})

v138.Farm:AddSection("Loot & Interact")

v138.Farm:AddToggle("Toggle_Farm_AutoDrops", {
  Title = "Auto Collect Drops",
  Default = true,
  Callback = function(value67)
    v9.FarmAutoDrops = value67
    f27()
  end,
})

v138.Farm:AddToggle("Toggle_Farm_AutoChests", {
  Title = "Auto Open Room Chests",
  Default = true,
  Callback = function(value68) v9.FarmAutoChests = value68 end,
})

v138.Farm:AddToggle("Toggle_Farm_AutoUnlockRooms", {
  Title = "Auto Unlock Locked Rooms",
  Description = "Automatically uses keys to unlock treasure rooms",
  Default = true,
  Callback = function(value69) v9.FarmAutoUnlockRooms = value69 end,
})

v138.Farm:AddToggle("Toggle_Farm_AllowHigherTierKeys", {
  Title = "Allow Higher Tier Keys",
  Description = "Uses higher tier or master keys if exact key is missing",
  Default = false,
  Callback = function(value70) v9.FarmAllowHigherTierKeys = value70 end,
})

v138.Farm:AddToggle("Toggle_Farm_AutoRefillStation", {
  Title = "Auto Refill Potion Station",
  Default = true,
  Callback = function(value71) v9.FarmAutoRefillStation = value71 end,
})

v138.Farm:AddToggle("Toggle_Farm_AutoBlessing", {
  Title = "Auto Blessing Altar",
  Default = true,
  Callback = function(value72) v9.FarmAutoBlessing = value72 end,
})

v138.Farm:AddToggle("Toggle_Farm_AutoEndChests", {
  Title = "Auto Claim End Chests",
  Default = true,
  Callback = function(value73) v9.FarmAutoEndChests = value73 end,
})

v138.Farm:AddToggle("Toggle_Farm_AutoSpecialBoss", {
  Title = "Auto Summon Special Boss",
  Default = false,
  Callback = function(value74) v9.FarmAutoSpecialBoss = value74 end,
})

v138.PostRun:AddSection("Win Action")

v138.PostRun:AddDropdown("Dropdown_PostRun_WinAction", {
  Title = "Win Action",
  Values = { "None", "Replay", "Return Lobby" },
  Default = "None",
  Callback = function(value75) v9.PostRunWinAction = value75 end,
})

v138.PostRun:AddSlider("Slider_PostRun_Delay", {
  Title = "Action Delay (s)",
  Default = 5,
  Min = 5,
  Max = 15,
  Rounding = 0,
  Callback = function(value76) v9.PostRunActionDelay = value76 end,
})

v138.PostRun:AddToggle("Toggle_PostRun_WaitForRewards", {
  Title = "Wait For Rewards",
  Default = true,
  Callback = function(value77) v9.PostRunWaitForRewards = value77 end,
})

v138.PostRun:AddSection("Endless Mode")

v138.PostRun:AddDropdown("Dropdown_PostRun_EndlessChoice", {
  Title = "Endless Checkpoint Action",
  Values = { "None", "Continue", "Extract" },
  Default = "None",
  Callback = function(value78) v9.PostRunEndlessChoice = value78 end,
})

v138.Settings:AddSection("Performance & Display")

v138.Settings:AddToggle("Toggle_Settings_DisableActionAnim", {
  Title = "Disable Action Animations",
  Description = "Stops attack/skill/parry animations for smoother performance",
  Default = false,
  Callback = function(value79)
    v9.SettingsDisableActionAnim = value79

    if value79 then
      f53(localPlayer.Character)

      if not v12.AnimCharAdded then
        v12.AnimCharAdded = localPlayer.CharacterAdded:Connect(f53)
      end
    else
      if v12.AnimPlayed then
        v12.AnimPlayed:Disconnect()
        v12.AnimPlayed = nil
      end

      if v12.AnimCharAdded then
        v12.AnimCharAdded:Disconnect()
        v12.AnimCharAdded = nil
      end
    end
  end,
})

v138.Settings:AddToggle("Toggle_Settings_UltraLowGraphics", {
  Title = "Ultra Low Graphics",
  Description = "Applies lowest in-game display settings and Potato Mode",
  Default = false,
  Callback = function(value80)
    v9.SettingsUltraLowGraphics = value80
    f55(value80)
  end,
})

f56()
v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/DungeonLootr")
v4:SetFolder("Lamduck/DungeonLootr")
v2:SetIgnoreIndexes({})

v4:BuildExtraSection(v138.Settings)
v4:SetAFKInfo("Level", function() return "Level", tostring(f2()) end)
v4:SetAFKInfo("Gold", function() return "Gold", f6(f3()) end)
v4:SetAFKInfo("Stars", function() return "Stars", f6(f4()) end)
v4:SetAFKInfo("Keys", function() return "Keys", f6(f5()) end)

v3:BuildInterfaceSection(v138.Settings)
v2:BuildConfigSection(v138.Settings)

v1.OnUnload:Once(function()
  f39(false)
  local character14 = localPlayer.Character

  if character14 then
    f40(character14, false)
    local humanoid10 = character14:FindFirstChildOfClass("Humanoid")

    if humanoid10 then
      humanoid10.AutoRotate = true
    end
  end

  if v8 then
    pcall(function()
      v8.SetMagneticRange(15)
      v8.SetCollectDistance(2)
    end)
  end

  for key7, value81 in pairs(v12) do
    if typeof(value81) == "RBXScriptConnection" and value81.Connected then
      value81:Disconnect()
    elseif type(value81) == "table" then
      for key8, value82 in pairs(value81) do
        if typeof(value82) == "RBXScriptConnection" and value82.Connected then
          pcall(function() value82:Disconnect() end)
        end
      end

      table.clear(value81)
    end
  end

  table.clear(v12)

  if type(v11.LuredMobs) == "table" then
    table.clear(v11.LuredMobs)
  end

  table.clear(v11)
end)

v2:LoadAutoloadConfig()
window:SelectTab(1)
