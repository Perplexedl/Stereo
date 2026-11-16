local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local collectionService = game:GetService("CollectionService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local remotes = replicatedStorage:FindFirstChild("Remotes")
  or replicatedStorage:WaitForChild("Remotes", 5)

local v5, v6, eggs, v7

pcall(function()
  local waitForChild = replicatedStorage:WaitForChild("Content", 5)

  if waitForChild then
    v5 = require(waitForChild:WaitForChild("Stackables", 5))
    v7 = require(waitForChild:WaitForChild("Missions", 5))

    local catalog = waitForChild:FindFirstChild("Catalog")
      or waitForChild:WaitForChild("Catalog", 5)

    if catalog then
      v6 = require(catalog)
      eggs = v6.eggs or require(catalog:WaitForChild("Eggs", 5))
    end
  end
end)

local v8 = firetouchinterest or fire_touch_interest or firetouch or firetouchtransmitter

local v9 = {
  IsAutoCollectNestEggRunning = false,
  IsAutoPetChickenRunning = false,
  IsAutoCollectScrapRunning = false,
  IsAutoEventRunning = false,
  ShouldPauseScrapForHotEggEvent = false,
  IsAutoHatchEggsRunning = false,
  IsAutoSellChickensRunning = false,
  IsAutoEquipBestChickenRunning = false,
  IsAutoFuseChickensRunning = false,
  IsAutoClaimDailyRewardsRunning = false,
  IsAutoClaimMissionsRunning = false,
  IsAutoExpandCoopRunning = false,
  IsAutoBuyGeneratorsRunning = false,
  IsAutoUpgradeGeneratorsRunning = false,
  IsAutoUpgradeRecyclerRunning = false,
  IsAutoRebirthRunning = false,
  IsAutoTowerRunning = false,
  IsTowerRunInProgress = false,
  ShouldPauseTowerForGooseEvent = false,
  IsGooseEventActive = false,
}

local v10 = {
  StackableBases = {},
  StackableTiers = {},
  EggsList = {},
  EggsNameList = {},
  EggNameToId = {},
  ChickenRarities = {},
  ChickenTypesList = {},
  ChickenNameToId = {},
}

local v11 = {}
local v12 = {}

local function f1()
  local v13 = {}
  local v14 = {}
  local v15 = {}

  for key, value in pairs(eggs or {
    barn = { id = "barn", name = "Nest Egg" },
    feed = { id = "feed", name = "Scratch Egg" },
    storm = { id = "storm", name = "Thunder Egg" },
    crown = { id = "crown", name = "Royal Egg" },
    golden = { id = "golden", name = "Fortune Egg" },
    ordnance = { id = "ordnance", name = "Ordnance Egg" },
    arena = { id = "arena", name = "Arena Egg" },
    fang = { id = "fang", name = "Fang Egg" },
    charm = { id = "charm", name = "Charm Egg" },
  }) do
    if typeof(value) == "table" and value.name then
      local v16 = tostring(value.name)

      table.insert(v13, { id = key, name = v16 })
      table.insert(v14, v16)

      v15[v16] = key
    end
  end

  table.sort(v14)
  return v13, v14, v15
end

local function f2()
  local v17 = {}
  local v18 = {}

  if v5 and typeof(v5) == "table" then
    for key2, value2 in pairs(v5) do
      if typeof(value2) == "table" then
        if value2.value and value2.value.base then
          v17[key2] = value2.value.base
        end

        if value2.tiers and typeof(value2.tiers) == "table" then
          for index, value3 in ipairs(value2.tiers) do
            if typeof(value3) == "table" and value3.id and value3.mult then
              v18[tostring(value3.id):lower()] = value3.mult
            end
          end
        end
      end
    end
  end

  return v17, v18
end

local function f3()
  local v19 = {}

  if v6 and v6.rarity and v6.rarity.rank then
    for key3, value4 in pairs(v6.rarity.rank) do
      table.insert(v19, {
        name = tostring(key3):sub(1, 1):upper() .. tostring(key3):sub(2),
        raw = tostring(key3):lower(),
        rank = tonumber(value4) or 1,
      })
    end

    table.sort(v19, function(p1, p2) return p1.rank < p2.rank end)
  else
    warn("[GrowAChickenFighter] Failed to load rarity config from catalog, using fallback")
  end

  if #v19 == 0 then
    v19 = {
      { name = "Common", raw = "common", rank = 1 },
      { name = "Uncommon", raw = "uncommon", rank = 2 },
      { name = "Rare", raw = "rare", rank = 3 }, { name = "Epic", raw = "epic", rank = 4 },
      { name = "Legendary", raw = "legendary", rank = 5 },
      { name = "Mythic", raw = "mythic", rank = 6 },
      { name = "Divine", raw = "divine", rank = 7 },
      { name = "Celestial", raw = "celestial", rank = 8 },
      { name = "Cosmic", raw = "cosmic", rank = 9 },
      { name = "Secret", raw = "secret", rank = 10 },
    }
  end

  return v19
end

local function f4()
  local v20 = {}
  local v21 = {}

  if v6 and v6.chickenTypes then
    for key4, value5 in pairs(v6.chickenTypes) do
      if typeof(value5) == "table" and value5.name then
        local v22 = tostring(value5.name)

        table.insert(v20, {
          id = key4,
          name = v22,
          rarity = tostring(value5.rarity or "common"):lower(),
        })

        v21[v22] = key4
      end
    end

    table.sort(v20, function(p3, p4) return p3.name < p4.name end)
  else
    warn("[GrowAChickenFighter] Failed to load chicken types config from catalog")
  end

  return v20, v21
end

local function f5()
  if v11.DataServiceRemote and v11.DataServiceRemote.Parent then
    return v11.DataServiceRemote
  end

  pcall(function()
    for index2, value6 in ipairs(replicatedStorage:GetDescendants()) do
      if value6:IsA("RemoteFunction") and value6.Name == "RemoteFunction" and value6.Parent
        and value6.Parent.Name == "DataService" then
        v11.DataServiceRemote = value6
        break
      end
    end
  end)

  return v11.DataServiceRemote
end

local function f6(p5, ...)
  if remotes then
    local findFirstChild = remotes:FindFirstChild(p5)

    if findFirstChild and findFirstChild:IsA("RemoteEvent") then
      pcall(function(...) findFirstChild:FireServer(...) end, ...)
    end
  end
end

local function f7(p6, ...)
  if remotes then
    local findFirstChild2 = remotes:FindFirstChild(p6)

    if findFirstChild2 and findFirstChild2:IsA("RemoteFunction") then
      local v23, v24 = pcall(function(...) return findFirstChild2:InvokeServer(...) end, ...)

      if v23 then
        return v24
      end
    end
  end

  return nil
end

local function f8(p7, p8)
  local v25 = {}
  local v26 = {}

  for index3, value7 in ipairs(p7 or {}) do
    if type(value7) == "table" then
      local v27 = value7[p8]

      if v27 and type(v27) == "string" and v27 ~= "" and not v25[v27] then
        v25[v27] = true
        table.insert(v26, v27)
      end
    end
  end

  return v26
end

local function f9(p9)
  local character = localPlayer.Character
  local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

  if not (humanoidRootPart and p9 and p9:IsA("BasePart") and p9.Parent) then
    return false
  end

  if typeof(v8) == "function" then
    pcall(function()
      v8(humanoidRootPart, p9, 0)
      task.wait(0.01)
      v8(humanoidRootPart, p9, 1)
    end)

    return true
  else
    local cframe = humanoidRootPart.CFrame
    humanoidRootPart.CFrame = CFrame.new(p9.Position + Vector3.new(0, 1.5, 0))
    task.wait(0.03)
    humanoidRootPart.CFrame = cframe
    return true
  end
end

local function f10()
  local plot = localPlayer:GetAttribute("Plot") or localPlayer:GetAttribute("PlotIndex")
    or localPlayer:GetAttribute("PlotNumber")

  if tonumber(plot) then
    return tonumber(plot)
  end

  local dataService = replicatedStorage:FindFirstChild("Packages")
    and replicatedStorage.Packages:FindFirstChild("DataService")

  if dataService then
    local v28, v29 = pcall(require, dataService)

    if v28 and v29 and v29.client then
      local get = v29.client:get({ "Plot" }) or v29.client:get({ "plot" })

      if tonumber(get) then
        return tonumber(get)
      end
    end
  end

  return 1
end

local function f11()
  local v30 = f10()
  local recyclers = workspace:FindFirstChild("Recyclers")

  if recyclers then
    local findFirstChild3 = recyclers:FindFirstChild("Recycler" .. tostring(v30))

    if findFirstChild3 then
      return findFirstChild3
    end

    for index4, value8 in ipairs(recyclers:GetChildren()) do
      if value8:GetAttribute("OwnerUserId") == localPlayer.UserId
        or value8:GetAttribute("Owner") == localPlayer.UserId then
        return value8
      end
    end

    return recyclers:FindFirstChild("Recycler1")
  end

  return nil
end

local function f12()
  local v31 = {}

  for index5, value9 in ipairs(collectionService:GetTagged("NestEgg")) do
    if value9:IsA("BasePart") and value9.Parent then
      local owner = value9:GetAttribute("owner")

      if not owner or owner == localPlayer.UserId then
        table.insert(v31, value9)
      end
    end
  end

  return v31
end

local function f13(p10)
  local parent = p10.Parent

  local stackKind = p10:GetAttribute("StackKind") or p10:GetAttribute("stackKind")
    or p10:GetAttribute("kind")

  if not stackKind and parent then
    stackKind = parent:GetAttribute("StackKind") or parent:GetAttribute("stackKind")
      or parent:GetAttribute("kind")
  end

  return tostring(stackKind or "scrap")
end

local function f14(p11)
  local parent2 = p11.Parent

  local stackTier = p11:GetAttribute("StackTier") or p11:GetAttribute("stackTier")
    or p11:GetAttribute("tier")

  if not stackTier and parent2 then
    stackTier = parent2:GetAttribute("StackTier") or parent2:GetAttribute("stackTier")
      or parent2:GetAttribute("tier")
  end

  return stackTier
end

local function f15(p12)
  local v32 = f13(p12)
  local v33 = f14(p12)

  return (v10.StackableBases[v32] or 6.67)
    * (v33 and v10.StackableTiers[tostring(v33):lower()] or 1)
end

local function f16()
  local v34 = {}

  local pitScrap = workspace:FindFirstChild("PitScrap") or workspace:FindFirstChild("Pit_Scrap")
    or workspace:FindFirstChild("Scrap")

  if pitScrap then
    for index6, value10 in ipairs(pitScrap:GetChildren()) do
      if value10:IsA("BasePart") then
        table.insert(v34, value10)
      elseif value10:IsA("Model") then
        local primaryPart = value10.PrimaryPart or value10:FindFirstChildWhichIsA("BasePart")

        if primaryPart then
          table.insert(v34, primaryPart)
        end
      elseif value10:IsA("Folder") then
        for index7, value11 in ipairs(value10:GetChildren()) do
          if value11:IsA("BasePart") then
            table.insert(v34, value11)
          elseif value11:IsA("Model") then
            local primaryPart2 = value11.PrimaryPart
              or value11:FindFirstChildWhichIsA("BasePart")

            if primaryPart2 then
              table.insert(v34, primaryPart2)
            end
          end
        end
      end
    end
  end

  if #v34 == 0 then
    for index8, value12 in ipairs(collectionService:GetTagged("Scrap")) do
      if value12:IsA("BasePart") and value12.Parent then
        table.insert(v34, value12)
      end
    end
  end

  table.sort(v34, function(p13, p14) return f15(p13) > f15(p14) end)
  return v34
end

local function f17(cframe2)
  local character2 = localPlayer.Character
  local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart2 then
    humanoidRootPart2.CFrame = cframe2
  end
end

local function f18()
  local v35 = f5()

  if v35 then
    local v36, v37 = pcall(function() return v35:InvokeServer("get", { "roster" }) end)

    if v36 and typeof(v37) == "table" then
      return v37
    end

    warn("[GrowAChickenFighter] Failed to fetch roster data from DataService RemoteFunction")
  else
    warn("[GrowAChickenFighter] Failed to locate DataService RemoteFunction")
  end

  return nil
end

local function f19(p15)
  local v38 = 1
  local lower = tostring(p15.rarity or "common"):lower()

  if v6 and v6.rarity and v6.rarity.rank then
    v38 = tonumber(v6.rarity.rank[lower]) or 1
  end

  local genome = p15.genome or {}

  local v39 = (tonumber(genome.vigor) or 0) + (tonumber(genome.furia) or 0)
    + (tonumber(genome.velocidad) or 0) + (tonumber(genome.impetu) or 0)
    + (tonumber(genome.fertility) or 0)

  local v40 = tonumber(p15.level) or 1
  return v38 * 1000000 + v40 * 1000 + v39
end

local function f20()
  if v9.IsAutoCollectNestEggRunning
    or not (v1.Options.Toggle_Farm_AutoCollectEggs and v1.Options.Toggle_Farm_AutoCollectEggs.Value) then
    return
  end

  v9.IsAutoCollectNestEggRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoCollectEggs
      and v1.Options.Toggle_Farm_AutoCollectEggs.Value do
      pcall(function()
        for index9, value13 in ipairs((f12())) do
          if not (v1.Options.Toggle_Farm_AutoCollectEggs
            and v1.Options.Toggle_Farm_AutoCollectEggs.Value) then
            break
          end

          f9(value13)
          task.wait(0.05)
        end
      end)

      task.wait(5)
    end

    v9.IsAutoCollectNestEggRunning = false
  end)
end

local function f21(p16, p17)
  if not p16 then
    return
  end

  for index10, value14 in ipairs(p16:GetDescendants()) do
    if value14:IsA("BasePart") then
      if p17 then
        if value14.CanCollide then
          value14.CanCollide = false
        end
      elseif value14.Name == "HumanoidRootPart" or value14.Name == "UpperTorso"
        or value14.Name == "LowerTorso" or value14.Name == "Torso" or value14.Name == "Head" then
        value14.CanCollide = true
      end
    end
  end
end

local function f22()
  local pit = workspace:FindFirstChild("Pit") or workspace:FindFirstChild("PitCenter")
    or workspace:FindFirstChild("ChaosCenter")

  if pit and pit:IsA("BasePart") then
    return pit.Position
  end

  return Vector3.new(0, 0, 0)
end

local function f23()
  if v9.IsGooseEventActive then
    return true
  end

  local goldenGoose = workspace:FindFirstChild("GoldenGoose")
    or workspace:FindFirstChild("Goose")

  if goldenGoose then
    return goldenGoose
  end

  for index11, value15 in ipairs(collectionService:GetTagged("ChickenBody")) do
    if tostring(value15:GetAttribute("ovName") or value15:GetAttribute("ovNameKey")
      or value15.Name):lower():find("goose") then
      return value15
    end
  end

  for index12, value16 in ipairs(workspace:GetChildren()) do
    if value16.Name:lower():find("goose") then
      return value16
    end
  end

  return nil
end

local function f24()
  return v9.IsGooseEventActive or v9.ShouldPauseScrapForHotEggEvent or f23() ~= nil
    or workspace:FindFirstChild("HotEgg") ~= nil
    or workspace:FindFirstChild("GoldenGoose") ~= nil
    or workspace:FindFirstChild("Goose") ~= nil or workspace:FindFirstChild("UFO") ~= nil
    or workspace:FindFirstChild("Ufo") ~= nil
end

local function f25()
  if v10.GooseConnections then
    for index13, value17 in ipairs(v10.GooseConnections) do
      if typeof(value17) == "RBXScriptConnection" and value17.Connected then
        value17:Disconnect()
      end
    end

    table.clear(v10.GooseConnections)
  end
end

local function f26()
  if v9.IsAutoEventRunning
    or not (v1.Options.Toggle_Farm_AutoEvent and v1.Options.Toggle_Farm_AutoEvent.Value) then
    return
  end

  v9.IsAutoEventRunning = true
  f25()
  v10.GooseConnections = v10.GooseConnections or {}

  if remotes then
    local gooseEntrance = remotes:FindFirstChild("GooseEntrance")
    local gooseDamage = remotes:FindFirstChild("GooseDamage")
    local gooseFinale = remotes:FindFirstChild("GooseFinale")

    local function f27()
      print("[GrowAChickenFighter Debug] Remote signal: Golden Goose event started!")

      v9.IsGooseEventActive = true
      v9.ShouldPauseTowerForGooseEvent = true

      if v9.IsTowerRunInProgress then
        print("[GrowAChickenFighter Debug] Surrendering Tower for Golden Goose event...")
        pcall(function() f7("TowerSurrender") end)
        v9.IsTowerRunInProgress = false
      end

      f6("SetChickenOrder", "chaos")
    end

    local function f28()
      print("[GrowAChickenFighter Debug] Remote signal: Golden Goose event ended.")
      v9.IsGooseEventActive = false
      v9.ShouldPauseTowerForGooseEvent = false
    end

    if gooseEntrance then
      local connect = gooseEntrance.OnClientEvent:Connect(f27)
      table.insert(v10.GooseConnections, connect)
      table.insert(v12, connect)
    end

    if gooseDamage then
      local connect2 = gooseDamage.OnClientEvent:Connect(function(p18)
        if typeof(p18) == "table" and p18.gooseId then
          f27()
        else
          f28()
        end
      end)

      table.insert(v10.GooseConnections, connect2)
      table.insert(v12, connect2)
    end

    if gooseFinale then
      local connect3 = gooseFinale.OnClientEvent:Connect(f28)
      table.insert(v10.GooseConnections, connect3)
      table.insert(v12, connect3)
    end
  end

  task.spawn(function()
    local v41 = false

    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoEvent
      and v1.Options.Toggle_Farm_AutoEvent.Value do
      pcall(function()
        local character3 = localPlayer.Character
        local humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart3 then
          return
        end

        local hotEgg = workspace:FindFirstChild("HotEgg")
        local isGooseEventActive = f23() or v9.IsGooseEventActive and true or nil
        local ufo = workspace:FindFirstChild("UFO") or workspace:FindFirstChild("Ufo")

        if isGooseEventActive and not v41 then
          print("[GrowAChickenFighter Debug] Golden Goose detected in Workspace / CollectionService! Activating Chaos order...")
          v41 = true
        elseif not isGooseEventActive and v41 then
          print("[GrowAChickenFighter Debug] Golden Goose no longer detected.")
          v41 = false
        end

        if hotEgg then
          v9.ShouldPauseScrapForHotEggEvent = true

          if hotEgg:GetAttribute("Carrier") == localPlayer.UserId then
            f21(character3, true)
            local v42 = f22()
            local v43 = tick() * 2 % (math.pi * 2)
            local v44 = math.cos(v43) * 18
            local v45 = math.sin(v43) * 18

            humanoidRootPart3.CFrame = CFrame.new(v42.X + v44, -14, v42.Z + v45)
              * CFrame.Angles(0, -v43 + math.pi / 2, 0)

            humanoidRootPart3.AssemblyLinearVelocity = Vector3.zero
            humanoidRootPart3.AssemblyAngularVelocity = Vector3.zero
            humanoidRootPart3.Anchored = true
          else
            humanoidRootPart3.Anchored = false
            f21(character3, false)
            f17(CFrame.new(hotEgg.Position + Vector3.new(0, 1.5, 0)))
          end
        elseif isGooseEventActive then
          humanoidRootPart3.Anchored = false
          f21(character3, false)

          v9.ShouldPauseScrapForHotEggEvent = false
          v9.ShouldPauseTowerForGooseEvent = true

          if v9.IsTowerRunInProgress then
            print("[GrowAChickenFighter Debug] Active Goose Event -> Surrendering Tower run immediately...")
            pcall(function() f7("TowerSurrender") end)
            v9.IsTowerRunInProgress = false
          end

          f6("SetChickenOrder", "chaos")
        elseif ufo then
          humanoidRootPart3.Anchored = false
          f21(character3, false)

          v9.ShouldPauseScrapForHotEggEvent = false
          v9.ShouldPauseTowerForGooseEvent = false
        else
          humanoidRootPart3.Anchored = false
          f21(character3, false)

          v9.ShouldPauseScrapForHotEggEvent = false
          v9.ShouldPauseTowerForGooseEvent = false
        end
      end)

      task.wait(0.2)
    end

    local character4 = localPlayer.Character
    local humanoidRootPart4 = character4 and character4:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart4 then
      humanoidRootPart4.Anchored = false
    end

    if character4 then
      f21(character4, false)
    end

    v9.ShouldPauseScrapForHotEggEvent = false
    v9.ShouldPauseTowerForGooseEvent = false
    v9.IsGooseEventActive = false
    v9.IsAutoEventRunning = false

    f25()
  end)
end

local function f29()
  if f24() then
    return true, "World Event"
  end

  if v9.IsTowerRunInProgress
    or v1.Options.Toggle_Tower_AutoTower and v1.Options.Toggle_Tower_AutoTower.Value then
    return true, "Tower Run"
  end

  return false, nil
end

local function f30()
  if v9.IsAutoPetChickenRunning
    or not (v1.Options.Toggle_Farm_AutoPetChicken and v1.Options.Toggle_Farm_AutoPetChicken.Value) then
    return
  end

  v9.IsAutoPetChickenRunning = true

  task.spawn(function()
    local v46 = nil

    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoPetChicken
      and v1.Options.Toggle_Farm_AutoPetChicken.Value do
      local v47, v48 = f29()

      if v47 then
        if v46 ~= v48 then
          print("[GrowAChickenFighter Debug] " .. v48 .. " active -> Pausing Auto Pet Chicken")
          v46 = v48
        end

        task.wait(1)
      else
        if v46 then
          print("[GrowAChickenFighter Debug] " .. v46 .. " finished -> Resuming Auto Pet Chicken")
          v46 = nil
        end

        f6("PetChicken")
        task.wait(1)
      end
    end

    v9.IsAutoPetChickenRunning = false
  end)
end

local function f31(p19, p20, p21)
  p20 = p20 or 3.5
  p21 = p21 or 6
  local character5 = localPlayer.Character
  local humanoid = character5 and character5:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart5 = character5 and character5:FindFirstChild("HumanoidRootPart")

  if not (humanoid and humanoidRootPart5) then
    return false
  end

  local value18 = v1.Options.Toggle_Farm_AutoCollectScrapFastMode
    and v1.Options.Toggle_Farm_AutoCollectScrapFastMode.Value

  local function f32()
    if typeof(p19) == "Instance" then
      if not p19.Parent then
        return nil
      end

      return p19:IsA("BasePart") and p19.Position or p19:GetPivot().Position
    elseif typeof(p19) == "Vector3" then
      return p19
    end

    return nil
  end

  local v49 = f32()

  if not v49 then
    return false
  end

  humanoid:MoveTo(v49)
  local v50 = os.clock()

  while os.clock() - v50 < p21 do
    if not (humanoid.Parent and humanoidRootPart5.Parent) then
      break
    end

    if not (v1.Options.Toggle_Farm_AutoCollectScrap and v1.Options.Toggle_Farm_AutoCollectScrap.Value)
      or f24() then
      break
    end

    local v51 = f32()

    if not v51 then
      break
    end

    if value18 and humanoid and humanoid.Parent then
      humanoid.WalkSpeed = 20
    end

    f21(character5, true)
    local humanoidRootPart6 = character5:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart6
      and (Vector3.new(humanoidRootPart6.Position.X, 0, humanoidRootPart6.Position.Z)
          - Vector3.new(v51.X, 0, v51.Z)).Magnitude
        <= p20 then
      return true
    end

    humanoid:MoveTo(v51)
    task.wait(0.1)
  end

  return false
end

local function f33()
  if v9.IsAutoCollectScrapRunning
    or not (v1.Options.Toggle_Farm_AutoCollectScrap and v1.Options.Toggle_Farm_AutoCollectScrap.Value) then
    return
  end

  v9.IsAutoCollectScrapRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoCollectScrap
      and v1.Options.Toggle_Farm_AutoCollectScrap.Value do
      if f24() then
        task.wait(1)
      else
        pcall(function()
          local character6 = localPlayer.Character
          local humanoidRootPart7 = character6 and character6:FindFirstChild("HumanoidRootPart")
          local humanoid2 = character6 and character6:FindFirstChildOfClass("Humanoid")

          if not (humanoidRootPart7 and humanoid2) then
            return
          end

          local value19 = v1.Options.Toggle_Farm_AutoCollectScrapFastMode
            and v1.Options.Toggle_Farm_AutoCollectScrapFastMode.Value

          if value19 then
            humanoid2.WalkSpeed = 20
          end

          local value20 = v1.Options.Slider_Farm_AutoCollectScrapMaxItems
              and v1.Options.Slider_Farm_AutoCollectScrapMaxItems.Value
            or 3

          local count = 0

          while count < value20 do
            if not (v1.Options.Toggle_Farm_AutoCollectScrap
                and v1.Options.Toggle_Farm_AutoCollectScrap.Value)
              or f24() then
              break
            end

            local humanoidRootPart8 = character6:FindFirstChild("HumanoidRootPart")

            if not humanoidRootPart8 then
              break
            end

            local v52 = f16()

            if #v52 == 0 then
              task.wait(0.5)
            else
              local v53, huge = nil, math.huge

              for index14, value21 in ipairs(v52) do
                if value21 and value21.Parent then
                  local magnitude = (humanoidRootPart8.Position - value21.Position).Magnitude

                  if magnitude < huge then
                    huge = magnitude
                    v53 = value21
                  end
                end
              end

              if v53 then
                f21(character6, true)

                if f31(v53, 3.5, 6) then
                  task.wait(0.2)
                  count = count + 1
                end
              end
            end
          end

          if count >= value20 and not f24() then
            local v54 = f11()

            if v54 then
              local origin = v54:GetAttribute("Origin")

              local position = typeof(origin) == "CFrame" and origin.Position
                or v54:GetPivot().Position

              f21(character6, true)
              f31(position, 5, 8)
              task.wait(1)
            end
          end

          f21(character6, false)

          if value19 and humanoid2 and humanoid2.Parent then
            humanoid2.WalkSpeed = 16
          end
        end)

        task.wait(1)
      end
    end

    local character7 = localPlayer.Character

    if character7 then
      f21(character7, false)
    end

    v9.IsAutoCollectScrapRunning = false
  end)
end

local function f34()
  if v9.IsAutoHatchEggsRunning
    or not (v1.Options.Toggle_Flock_AutoHatchEggs and v1.Options.Toggle_Flock_AutoHatchEggs.Value) then
    return
  end

  v9.IsAutoHatchEggsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Flock_AutoHatchEggs
      and v1.Options.Toggle_Flock_AutoHatchEggs.Value do
      pcall(function()
        local value22 = v1.Options.Dropdown_Flock_HatchEggTypes
          and v1.Options.Dropdown_Flock_HatchEggTypes.Value

        if value22 then
          for key5, value23 in pairs(value22) do
            if not (v1.Options.Toggle_Flock_AutoHatchEggs
              and v1.Options.Toggle_Flock_AutoHatchEggs.Value) then
              break
            end

            local v55 = value23 == true and key5 or type(key5) == "number" and value23 or key5

            if typeof(v55) == "string" then
              f7("HatchEgg", v10.EggNameToId[v55] or v55)
            end
          end
        end
      end)

      task.wait(0.5)
    end

    v9.IsAutoHatchEggsRunning = false
  end)
end

local function f35()
  local value24 = v1.Options.Toggle_Flock_AutoSellChickensByRarities
    and v1.Options.Toggle_Flock_AutoSellChickensByRarities.Value

  local value25 = v1.Options.Toggle_Flock_AutoSellChickensByName
    and v1.Options.Toggle_Flock_AutoSellChickensByName.Value

  if v9.IsAutoSellChickensRunning or not (value24 or value25) then
    return
  end

  v9.IsAutoSellChickensRunning = true

  task.spawn(function()
    while not v1.Unloaded do
      local value26 = v1.Options.Toggle_Flock_AutoSellChickensByRarities
        and v1.Options.Toggle_Flock_AutoSellChickensByRarities.Value

      local value27 = v1.Options.Toggle_Flock_AutoSellChickensByName
        and v1.Options.Toggle_Flock_AutoSellChickensByName.Value

      if not (value26 or value27) then
        break
      end

      pcall(function()
        local v56 = f18()

        if v56 and v56.chickens then
          local activeId = v56.activeId
          local v57 = {}

          if value27 then
            local value28 = v1.Options.Dropdown_Flock_SellChickenTypes
              and v1.Options.Dropdown_Flock_SellChickenTypes.Value

            if value28 then
              local v58 = {}

              for key6, value29 in pairs(value28) do
                local v59 = value29 == true and key6 or type(key6) == "number" and value29
                  or key6

                if typeof(v59) == "string" then
                  local v60 = v10.ChickenNameToId[v59] or v59
                  v58[v60] = true
                end
              end

              for index15, value30 in ipairs(v56.chickens) do
                if value30.id ~= activeId and not value30.favorite then
                  if v58[value30.typeId] == true then
                    table.insert(v57, value30.id)
                  end
                end
              end
            end
          elseif value26 then
            local value31 = v1.Options.Dropdown_Flock_SellChickenRarities
              and v1.Options.Dropdown_Flock_SellChickenRarities.Value

            if value31 then
              local v61 = {}

              for key7, value32 in pairs(value31) do
                local v62 = value32 == true and key7 or type(key7) == "number" and value32
                  or key7

                if typeof(v62) == "string" then
                  v61[v62:lower()] = true
                end
              end

              for index16, value33 in ipairs(v56.chickens) do
                if value33.id ~= activeId and not value33.favorite then
                  local typeId = value33.typeId
                  local chickenTypes = v6 and v6.chickenTypes and v6.chickenTypes[typeId]

                  if v61[(value33.rarity or chickenTypes and chickenTypes.rarity or "common"):lower()]
                    == true then
                    table.insert(v57, value33.id)
                  end
                end
              end
            end
          end

          if #v57 > 0 then
            f7("SellChickens", v57)
          end
        end
      end)

      task.wait(5)
    end

    v9.IsAutoSellChickensRunning = false
  end)
end

local function f36()
  if v9.IsAutoEquipBestChickenRunning
    or not (v1.Options.Toggle_Flock_AutoEquipBestChicken
      and v1.Options.Toggle_Flock_AutoEquipBestChicken.Value) then
    return
  end

  v9.IsAutoEquipBestChickenRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Flock_AutoEquipBestChicken
      and v1.Options.Toggle_Flock_AutoEquipBestChicken.Value do
      pcall(function()
        local v63 = f18()

        if v63 and v63.chickens and #v63.chickens > 0 then
          local activeId2 = v63.activeId
          local v64 = nil
          local v65 = -1

          for index17, value34 in ipairs(v63.chickens) do
            local v66 = f19(value34)

            if v66 > v65 then
              v65 = v66
              v64 = value34
            end
          end

          if v64 and v64.id and v64.id ~= activeId2 then
            f7("SetActiveChicken", v64.id)
          end
        end
      end)

      task.wait(5)
    end

    v9.IsAutoEquipBestChickenRunning = false
  end)
end

local function f37()
  if v9.IsAutoFuseChickensRunning
    or not (v1.Options.Toggle_Flock_AutoFuseChickens
      and v1.Options.Toggle_Flock_AutoFuseChickens.Value) then
    return
  end

  v9.IsAutoFuseChickensRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Flock_AutoFuseChickens
      and v1.Options.Toggle_Flock_AutoFuseChickens.Value do
      pcall(function()
        local value35 = v1.Options.Dropdown_Flock_FuseRarities
          and v1.Options.Dropdown_Flock_FuseRarities.Value

        if value35 then
          local v67 = {}

          for key8, value36 in pairs(value35) do
            local v68 = value36 == true and key8 or type(key8) == "number" and value36 or key8

            if typeof(v68) == "string" then
              v67[v68:lower()] = true
            end
          end

          local v69 = f18()

          if v69 and v69.chickens and #v69.chickens > 1 then
            local activeId3 = v69.activeId
            local v70 = {}

            for index18, value37 in ipairs(v69.chickens) do
              if value37.id ~= activeId3 and not value37.favorite then
                local chickenTypes2 = v6 and v6.chickenTypes and v6.chickenTypes[value37.typeId]

                local lower2 = (value37.rarity or chickenTypes2 and chickenTypes2.rarity
                  or "common"):lower()

                if v67[lower2] == true then
                  if not v70[lower2] then
                    v70[lower2] = {}
                  end

                  table.insert(v70[lower2], value37)
                end
              end
            end

            for key9, value38 in pairs(v70) do
              while #value38 >= 2 do
                if not (v1.Options.Toggle_Flock_AutoFuseChickens
                  and v1.Options.Toggle_Flock_AutoFuseChickens.Value) then
                  break
                end

                local v71 = table.remove(value38, 1)
                local v72 = table.remove(value38, 1)

                if v71 and v72 then
                  f7("FuseChickens", v71.id, v72.id)
                  task.wait(1)
                end
              end
            end
          end
        end
      end)

      task.wait(3)
    end

    v9.IsAutoFuseChickensRunning = false
  end)
end

local function f38()
  if v9.IsAutoClaimDailyRewardsRunning
    or not (v1.Options.Toggle_Rewards_AutoClaimDaily
      and v1.Options.Toggle_Rewards_AutoClaimDaily.Value) then
    return
  end

  v9.IsAutoClaimDailyRewardsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Rewards_AutoClaimDaily
      and v1.Options.Toggle_Rewards_AutoClaimDaily.Value do
      pcall(function()
        f7("DailyClaim", "day", nil)

        for i = 1, 6 do
          if not (v1.Options.Toggle_Rewards_AutoClaimDaily
            and v1.Options.Toggle_Rewards_AutoClaimDaily.Value) then
            break
          end

          f7("DailyClaim", "session", i)
          task.wait(0.2)
        end
      end)

      task.wait(60)
    end

    v9.IsAutoClaimDailyRewardsRunning = false
  end)
end

local function f39()
  if v9.IsAutoClaimMissionsRunning
    or not (v1.Options.Toggle_Rewards_AutoClaimMissions
      and v1.Options.Toggle_Rewards_AutoClaimMissions.Value) then
    return
  end

  v9.IsAutoClaimMissionsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Rewards_AutoClaimMissions
      and v1.Options.Toggle_Rewards_AutoClaimMissions.Value do
      pcall(function()
        for index19, value39 in ipairs(v7 or {}) do
          if not (v1.Options.Toggle_Rewards_AutoClaimMissions
            and v1.Options.Toggle_Rewards_AutoClaimMissions.Value) then
            break
          end

          if typeof(value39) == "table" and value39.id then
            f7("MissionClaim", value39.id)
            task.wait(0.1)
          end
        end
      end)

      task.wait(60)
    end

    v9.IsAutoClaimMissionsRunning = false
  end)
end

local function f40()
  if v9.IsAutoExpandCoopRunning
    or not (v1.Options.Toggle_Shop_AutoExpandCoop and v1.Options.Toggle_Shop_AutoExpandCoop.Value) then
    return
  end

  v9.IsAutoExpandCoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoExpandCoop
      and v1.Options.Toggle_Shop_AutoExpandCoop.Value do
      pcall(function() f7("ExpandCoop") end)
      task.wait(3)
    end

    v9.IsAutoExpandCoopRunning = false
  end)
end

local function f41()
  if v9.IsAutoBuyGeneratorsRunning
    or not (v1.Options.Toggle_Shop_AutoBuyGenerators
      and v1.Options.Toggle_Shop_AutoBuyGenerators.Value) then
    return
  end

  v9.IsAutoBuyGeneratorsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoBuyGenerators
      and v1.Options.Toggle_Shop_AutoBuyGenerators.Value do
      pcall(function()
        for j = 1, 6 do
          if not (v1.Options.Toggle_Shop_AutoBuyGenerators
            and v1.Options.Toggle_Shop_AutoBuyGenerators.Value) then
            break
          end

          f7("BuyGenerator", j)
          task.wait(0.3)
        end
      end)

      task.wait(5)
    end

    v9.IsAutoBuyGeneratorsRunning = false
  end)
end

local function f42()
  if v9.IsAutoUpgradeGeneratorsRunning
    or not (v1.Options.Toggle_Shop_AutoUpgradeGenerators
      and v1.Options.Toggle_Shop_AutoUpgradeGenerators.Value) then
    return
  end

  v9.IsAutoUpgradeGeneratorsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoUpgradeGenerators
      and v1.Options.Toggle_Shop_AutoUpgradeGenerators.Value do
      pcall(function()
        for k = 1, 6 do
          if not (v1.Options.Toggle_Shop_AutoUpgradeGenerators
            and v1.Options.Toggle_Shop_AutoUpgradeGenerators.Value) then
            break
          end

          f7("UpgradeGenerator", k)
          task.wait(0.3)
        end
      end)

      task.wait(5)
    end

    v9.IsAutoUpgradeGeneratorsRunning = false
  end)
end

local function f43()
  if v9.IsAutoUpgradeRecyclerRunning
    or not (v1.Options.Toggle_Shop_AutoUpgradeRecycler
      and v1.Options.Toggle_Shop_AutoUpgradeRecycler.Value) then
    return
  end

  v9.IsAutoUpgradeRecyclerRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoUpgradeRecycler
      and v1.Options.Toggle_Shop_AutoUpgradeRecycler.Value do
      pcall(function() f7("UpgradeRecycler") end)
      task.wait(5)
    end

    v9.IsAutoUpgradeRecyclerRunning = false
  end)
end

local function f44()
  if v9.IsAutoRebirthRunning
    or not (v1.Options.Toggle_Shop_AutoRebirth and v1.Options.Toggle_Shop_AutoRebirth.Value) then
    return
  end

  v9.IsAutoRebirthRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoRebirth
      and v1.Options.Toggle_Shop_AutoRebirth.Value do
      pcall(function() f7("Rebirth") end)
      task.wait(10)
    end

    v9.IsAutoRebirthRunning = false
  end)
end

local function f45()
  local v73 = f5()

  if not v73 then
    return nil, nil
  end

  local invokeServer, invokeServer2

  pcall(function()
    invokeServer = v73:InvokeServer("get", { "tower" })
    invokeServer2 = v73:InvokeServer("get", { "money" })
  end)

  return typeof(invokeServer) == "table" and invokeServer.best or 0, typeof(invokeServer2) == "table" and invokeServer2.amount
    or typeof(invokeServer2) == "number" and invokeServer2 or 0
end

local function f46()
  if v10.TowerConnections then
    for index20, value40 in ipairs(v10.TowerConnections) do
      if typeof(value40) == "RBXScriptConnection" and value40.Connected then
        value40:Disconnect()
      end
    end

    table.clear(v10.TowerConnections)
  end
end

local function f47()
  if v9.IsAutoTowerRunning
    or not (v1.Options.Toggle_Tower_AutoTower and v1.Options.Toggle_Tower_AutoTower.Value) then
    return
  end

  v9.IsAutoTowerRunning = true
  f46()
  v10.TowerConnections = v10.TowerConnections or {}

  local function f48()
    if not v9.IsAutoTowerRunning then
      return
    end

    task.wait(0.5)
    local towerContinueDecline = remotes and remotes:FindFirstChild("TowerContinueDecline")

    if towerContinueDecline then
      pcall(function() towerContinueDecline:FireServer() end)
    end

    task.wait(0.5)
    pcall(function() f7("TowerSurrender") end)
    v9.IsTowerRunInProgress = false
  end

  if remotes then
    local towerContinueOffer = remotes:FindFirstChild("TowerContinueOffer")
    local towerDefeat = remotes:FindFirstChild("TowerDefeat")
    local towerRunEnded = remotes:FindFirstChild("TowerRunEnded")

    if towerContinueOffer then
      local connect4 = towerContinueOffer.OnClientEvent:Connect(function(p22)
        if typeof(p22) == "table" and p22.paid then
          f48()
        end
      end)

      table.insert(v10.TowerConnections, connect4)
      table.insert(v12, connect4)
    end

    if towerDefeat then
      local connect5 = towerDefeat.OnClientEvent:Connect(f48)
      table.insert(v10.TowerConnections, connect5)
      table.insert(v12, connect5)
    end

    if towerRunEnded then
      local connect6 = towerRunEnded.OnClientEvent:Connect(f48)
      table.insert(v10.TowerConnections, connect6)
      table.insert(v12, connect6)
    end
  end

  task.spawn(function()
    local v74 = 0

    while not v1.Unloaded and v1.Options.Toggle_Tower_AutoTower
      and v1.Options.Toggle_Tower_AutoTower.Value do
      if v9.ShouldPauseTowerForGooseEvent or f24() then
        if v9.IsTowerRunInProgress then
          print("[GrowAChickenFighter Debug] Auto Tower: World Event active -> Surrendering Tower run!")
          pcall(function() f7("TowerSurrender") end)
          v9.IsTowerRunInProgress = false
        end

        f6("SetChickenOrder", "chaos")
      else
        if v9.IsTowerRunInProgress and os.clock() - v74 > 45 then
          v9.IsTowerRunInProgress = false
        end

        if not v9.IsTowerRunInProgress then
          pcall(function()
            if v1.Options.Toggle_Tower_UseElevator and v1.Options.Toggle_Tower_UseElevator.Value then
              local v75 = f45()

              if v75 and v75 > 1 then
                f7("TowerElevator", v75)
                task.wait(0.2)
              end
            end

            f6("SetChickenOrder", "tower")
            task.wait(0.1)
            f7("TowerStart")
            v74 = os.clock()
            v9.IsTowerRunInProgress = true
          end)
        end
      end

      task.wait(3)
    end

    v9.IsAutoTowerRunning = false
    v9.IsTowerRunInProgress = false

    f46()
  end)
end

v10.StackableBases, v10.StackableTiers = f2()
v10.EggsList, v10.EggsNameList, v10.EggNameToId = f1()
v10.ChickenRarities = f3()
v10.ChickenTypesList, v10.ChickenNameToId = f4()

local window = v1:CreateWindow({ Title = "Grow A Chicken Fighter", SubTitle = "by Lamduck" })

local v76 = {
  Farm = window:AddTab({ Title = "Farm", Icon = "sprout" }),
  Flock = window:AddTab({ Title = "Flock", Icon = "egg" }),
  Shop = window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
  Tower = window:AddTab({ Title = "Tower", Icon = "sword" }),
  Rewards = window:AddTab({ Title = "Rewards", Icon = "gift" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

v76.Farm:AddSection("Auto Farm")

v76.Farm:AddToggle("Toggle_Farm_AutoCollectEggs", {
  Title = "Auto Collect Eggs",
  Default = false,
  Callback = function(value41)
    if value41 then
      f20()
    end
  end,
})

v76.Farm:AddToggle("Toggle_Farm_AutoPetChicken", {
  Title = "Auto Pet Active Chicken",
  Default = false,
  Callback = function(value42)
    if value42 then
      f30()
    end
  end,
})

v76.Farm:AddSection("Auto Event")

v76.Farm:AddToggle("Toggle_Farm_AutoEvent", {
  Title = "Auto Event (Goose / Hot Egg / UFO)",
  Description = "*kinda bug, better use private server*",
  Default = false,
  Callback = function(value43)
    if value43 then
      if v1.Options.Toggle_Farm_AutoCollectScrap then
        v1.Options.Toggle_Farm_AutoCollectScrap:SetValue(true)
      end

      f26()
    else
      v9.IsAutoEventRunning = false
      v9.IsGooseEventActive = false
      v9.ShouldPauseTowerForGooseEvent = false

      f25()
    end
  end,
})

v76.Farm:AddSection("Auto Scrap (HIGH RISK)")

v76.Farm:AddToggle("Toggle_Farm_AutoCollectScrap", {
  Title = "Auto Collect & Deposit Scrap",
  Default = false,
  Callback = function(value44)
    if value44 then
      f33()
    end
  end,
})

v76.Farm:AddSlider("Slider_Farm_AutoCollectScrapMaxItems", {
  Title = "Max Items Per Trip",
  Description = "Limit scrap items collected before depositing",
  Default = 3,
  Min = 1,
  Max = 20,
  Rounding = 0,
})

v76.Farm:AddToggle("Toggle_Farm_AutoCollectScrapFastMode", {
  Title = "Fast Mode (Risky)",
  Default = false,
  Callback = function(value45) end,
})

v76.Flock:AddSection("Auto Hatch Eggs")

v76.Flock:AddDropdown("Dropdown_Flock_HatchEggTypes", {
  Title = "Select Egg Types",
  Description = "Choose egg types to hatch",
  Values = v10.EggsNameList,
  Multi = true,
  Searchable = true,
  Default = v10.EggsNameList,
})

v76.Flock:AddToggle("Toggle_Flock_AutoHatchEggs", {
  Title = "Auto Hatch Selected Eggs",
  Default = false,
  Callback = function(value46)
    if value46 then
      f34()
    end
  end,
})

v76.Flock:AddSection("Auto Sell Chickens")

v76.Flock:AddDropdown("Dropdown_Flock_SellChickenTypes", {
  Title = "Select Chicken Names",
  Values = f8(v10.ChickenTypesList, "name"),
  Multi = true,
  Searchable = true,
})

v76.Flock:AddToggle("Toggle_Flock_AutoSellChickensByName", {
  Title = "Auto Sell By Names",
  Default = false,
  Callback = function(value47)
    if value47 then
      if v1.Options.Toggle_Flock_AutoSellChickensByRarities
        and v1.Options.Toggle_Flock_AutoSellChickensByRarities.Value then
        v1.Options.Toggle_Flock_AutoSellChickensByRarities:SetValue(false)
      end

      f35()
    end
  end,
})

v76.Flock:AddDivider()

v76.Flock:AddDropdown("Dropdown_Flock_SellChickenRarities", {
  Title = "Select Chicken Rarities",
  Values = f8(v10.ChickenRarities, "name"),
  Multi = true,
  Searchable = true,
  Default = { "Common", "Uncommon" },
})

v76.Flock:AddToggle("Toggle_Flock_AutoSellChickensByRarities", {
  Title = "Auto Sell By Rarities",
  Default = false,
  Callback = function(value48)
    if value48 then
      if v1.Options.Toggle_Flock_AutoSellChickensByName
        and v1.Options.Toggle_Flock_AutoSellChickensByName.Value then
        v1.Options.Toggle_Flock_AutoSellChickensByName:SetValue(false)
      end

      f35()
    end
  end,
})

v76.Flock:AddSection("Deploy & Fuse Chickens")

v76.Flock:AddToggle("Toggle_Flock_AutoEquipBestChicken", {
  Title = "Auto Equip Best Chicken",
  Default = false,
  Callback = function(value49)
    if value49 then
      f36()
    end
  end,
})

v76.Flock:AddDivider()

v76.Flock:AddDropdown("Dropdown_Flock_FuseRarities", {
  Title = "Select Rarities to Fuse",
  Description = "*Not recommend*",
  Values = f8(v10.ChickenRarities, "name"),
  Multi = true,
  Searchable = true,
  Default = { "Common", "Uncommon" },
})

v76.Flock:AddToggle("Toggle_Flock_AutoFuseChickens", {
  Title = "Auto Fuse Same-Rarity Chickens",
  Default = false,
  Callback = function(value50)
    if value50 then
      f37()
    end
  end,
})

v76.Shop:AddSection("Coop")

v76.Shop:AddToggle("Toggle_Shop_AutoExpandCoop", {
  Title = "Auto Expand Coop",
  Default = false,
  Callback = function(value51)
    if value51 then
      f40()
    end
  end,
})

v76.Shop:AddDivider()

v76.Shop:AddToggle("Toggle_Shop_AutoBuyGenerators", {
  Title = "Auto Buy All Generators",
  Default = false,
  Callback = function(value52)
    if value52 then
      f41()
    end
  end,
})

v76.Shop:AddToggle("Toggle_Shop_AutoUpgradeGenerators", {
  Title = "Auto Upgrade All Generators",
  Default = false,
  Callback = function(value53)
    if value53 then
      f42()
    end
  end,
})

v76.Shop:AddSection("Recycler")

v76.Shop:AddToggle("Toggle_Shop_AutoUpgradeRecycler", {
  Title = "Auto Upgrade Recycler",
  Default = false,
  Callback = function(value54)
    if value54 then
      f43()
    end
  end,
})

v76.Shop:AddSection("Rebirth")

v76.Shop:AddToggle("Toggle_Shop_AutoRebirth", {
  Title = "Auto Rebirth (when eligible)",
  Default = false,
  Callback = function(value55)
    if value55 then
      f44()
    end
  end,
})

v76.Rewards:AddSection("Daily & Playtime Rewards")

v76.Rewards:AddToggle("Toggle_Rewards_AutoClaimDaily", {
  Title = "Auto Claim Daily & Online Rewards",
  Default = false,
  Callback = function(value56)
    if value56 then
      f38()
    end
  end,
})

v76.Rewards:AddSection("Missions & Quests")

v76.Rewards:AddToggle("Toggle_Rewards_AutoClaimMissions", {
  Title = "Auto Claim Completed Missions",
  Default = false,
  Callback = function(value57)
    if value57 then
      f39()
    end
  end,
})

v76.Tower:AddSection("Auto Tower")

v76.Tower:AddToggle("Toggle_Tower_AutoTower", {
  Title = "Auto Farm Tower (Loop)",
  Default = false,
  Callback = function(value58)
    if value58 then
      f47()
    else
      v9.IsAutoTowerRunning = false
      v9.IsTowerRunInProgress = false
      f46()
    end
  end,
})

v76.Tower:AddToggle("Toggle_Tower_UseElevator", {
  Title = "Start From Last Floor (costs money)",
  Default = false,
  Callback = function(value59) end,
})

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/GrowAChickenFighter")
v4:SetFolder("Lamduck/GrowAChickenFighter")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v76.Settings)
v3:BuildInterfaceSection(v76.Settings)
v2:BuildConfigSection(v76.Settings)

v1.OnUnload:Once(function()
  for index21, value60 in ipairs(v12) do
    if typeof(value60) == "RBXScriptConnection" and value60.Connected then
      value60:Disconnect()
    end
  end

  table.clear(v12)
end)

v2:LoadAutoloadConfig()
window:SelectTab(1)
