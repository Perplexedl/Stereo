local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "zktOfl" / (1271335 - "yCZWsB1buzeVh9" ^ 5265569) end) })[2]
local v4 = tonumber(gmatch(tostring(v3), ":(%d*):")())

for i = 1, v2 do
  local v5 = i
  local v6 = math.random(1, 100)
  local v7 = random(0, 255)
  local v8 = random(1, v6)
  local v9 = random(1, 2) == 1
  local gsub = v3:gsub(":(%d*):", ":" .. tostring(random(0, 10000)) .. ":")

  local v10 = {
    pcall(function()
      if random(1, 2) == 1 or v5 == v2 then
        tonumber(gmatch(tostring(({
          pcall(function() return "sdIEaj7" / (215559 - "l1ZNX" ^ 11197270) end),
        })[2]), ":(%d*):")())
      end

      if v9 then
        error(gsub, 0)
      end

      local v11 = {}

      for j = 1, v6 do
        v11[j] = random(0, 255)
      end

      v11[v8] = v7
      return v1(v11)
    end),
  }
end

local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = game:GetService("Players").LocalPlayer
local stockByItemId = {}
local stockByItemId2 = {}

local v12, v13 = pcall(function()
  local waitForChild = localPlayer:WaitForChild("PlayerScripts", 10):WaitForChild(
    "Controllers", 10
  )

  local v14 = require(waitForChild:WaitForChild("GearShopController", 10))
  local v15 = require(waitForChild:WaitForChild("AlienPetShopController", 10))
  local v16 = require(waitForChild:WaitForChild("PanelHub", 10)).get()
  local v17 = require(replicatedStorage:WaitForChild("Net", 10):WaitForChild("Remotes", 10))
  local gearShopSync = v17.get("GearShopSync")

  if gearShopSync then
    gearShopSync.OnClientEvent:Connect(function(p1)
      if type(p1) == "table" and type(p1.stockByItemId) == "table" then
        stockByItemId = p1.stockByItemId
      end
    end)
  end

  local alienPetShopSync = v17.get("AlienPetShopSync")

  if alienPetShopSync then
    alienPetShopSync.OnClientEvent:Connect(function(p2)
      if type(p2) == "table" and type(p2.stockByItemId) == "table" then
        stockByItemId2 = p2.stockByItemId
      end
    end)
  end

  local function f1(fn, p3)
    local v18 = -1
    local v19 = os.clock()
    local v20 = os.clock()

    while os.clock() - v20 < p3 do
      local v21 = fn()

      if v21 then
        local v22 = #v21:GetChildren()

        if v22 == v18 then
          if os.clock() - v19 > 0.5 then
            return
          end
        else
          v18 = v22
          v19 = os.clock()
        end
      end

      task.wait(0.2)
    end
  end

  pcall(function() v14.start() end)
  v14.openGearShop()

  f1(function()
    local playerGui = localPlayer:FindFirstChild("PlayerGui")
    local fsGearShopPanel = playerGui and playerGui:FindFirstChild("FS_GearShopPanel")
    local gearShopStack = fsGearShopPanel and fsGearShopPanel:FindFirstChild("GearShopStack")
    local gearShopModal = gearShopStack and gearShopStack:FindFirstChild("GearShopModal")
    local box = gearShopModal and gearShopModal:FindFirstChild("Box")
    return box and box:FindFirstChild("ItemList")
  end, 5)

  pcall(function() v16:close() end)
  task.wait(0.2)
  pcall(function() v15.start() end)
  v15.openAlienPetShop()

  f1(function()
    local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
    local fsAlienPetShopPanel = playerGui2 and playerGui2:FindFirstChild("FS_AlienPetShopPanel")

    local alienPetShopStack = fsAlienPetShopPanel
      and fsAlienPetShopPanel:FindFirstChild("AlienPetShopStack")

    local alienPetShopModal = alienPetShopStack
      and alienPetShopStack:FindFirstChild("AlienPetShopModal")

    local box2 = alienPetShopModal and alienPetShopModal:FindFirstChild("Box")
    return box2 and box2:FindFirstChild("ItemList")
  end, 5)

  pcall(function() v16:close() end)
end)

if not v12 then
  warn("[AutoFarm] Shop panels preload failed: " .. tostring(v13))
end

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:SetScriptName("AutoFarm")
rayVoid:MainCredit()

local function f2(p4)
  if type(p4) ~= "string" then
    return nil
  else
    local gsub2 = p4:gsub("[,%s%$]", "")
    local v23, v24 = gsub2:match("^(%-?%d+%.?%d*)([KkMmBbTt]?)$")

    if not v23 then
      return tonumber(gsub2)
    else
      local v25 = tonumber(v23)

      if not v25 then
        return nil
      else
        local v26 = {
          K = 1000,
          M = 1000000,
          B = 1000000000,
          T = 1000000000000,
        }

        local v27 = string.upper(v24 or "")

        if v27 ~= "" then
          v25 = v25 * (v26[v27] or 1)
        end

        return v25
      end
    end
  end
end

local function f3()
  local v28, v29 = pcall(function()
    return localPlayer.PlayerGui:WaitForChild("FS_HudChrome", 5):WaitForChild("BottomPills", 5):WaitForChild(
      "CashRow", 5
    ):WaitForChild(
      "CashValue", 5
    )
  end)

  if not v28 or v29 == nil then
    warn("[AutoFarm] Could not find CashValue label")
    return nil
  end

  return f2(v29.Text)
end

local window = rayVoid:CreateWindow({
  Name = "Mine-a-Planet",
  LoadingTitle = "Mine-a-Planet script",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "MineAPlanet" },
})

local dronesTab = window:CreateTab("Drones")
local upgradesTab = window:CreateTab("Upgrades")
local docksTab = window:CreateTab("Docks")
local levelUpTab = window:CreateTab("LevelUp")
local shopTab = window:CreateTab("Shop")
local alienShopTab = window:CreateTab("AlienShop")
local v30 = {}
local v31 = false
local v32 = false
local v33 = {}
local v34 = false
local v35 = false
local v36 = {}
local v37 = {}
local v38 = { 3, 4, 4 }
local v39 = false
local v40 = false
local v41 = false
local v42 = 30
local items = {}
local v43 = {}
local v44 = {}
local v45 = {}

local function f4()
  v34 = false
end

local v46 = 10
local v47 = false
local v48 = false
local v49 = {}
local v50 = {}
local intervalleS = 30
local v51 = false
local v52 = false
local v53 = {}
local v54 = {}
local intervalleS2 = 30
local v55 = false
local v56 = false
local v57 = {}
local v58 = {}
local v59 = {}
local v60 = false
local v61 = false
local v62 = false
local v63 = false
local v64 = false
local v65 = false
local v66 = false
local v67 = false
local waitForChild2

local function f5(p5)
  local v68 = v30[p5]

  if v68 == nil then
    warn(("[AutoFarm] No pickup prompt reference for slot %d"):format(p5))
    return
  else
    local total = 0

    while not v68.Enabled and total < 5 do
      task.wait(0.1)
      total = total + 0.1
    end

    if not v68.Enabled then
      warn(("[AutoFarm] Slot %d pickup prompt never became enabled; skipping"):format(p5))
      return
    end

    task.wait(0.5)

    if not v68.Enabled then
      warn(("[AutoFarm] Slot %d prompt became disabled during safety wait; skipping"):format(p5))
      return
    else
      local v69, v70 = pcall(function() waitForChild2:FireServer({ slotIndex = p5 }) end)

      if not v69 then
        warn(("[AutoFarm] Pickup slot %d failed: %s"):format(p5, tostring(v70)))
      end

      return
    end
  end
end

local waitForChild3, f6

local function f7()
  local rollEpoch = v33.rollEpoch
  local v71, v72 = pcall(function() waitForChild3:FireServer({}) end)

  if not v71 then
    warn("[AutoFarm] FireServer failed: " .. tostring(v72))
    return
  else
    local total2 = 0

    while v33.rollEpoch == rollEpoch and total2 < 10 do
      task.wait(0.1)
      total2 = total2 + 0.1
    end

    if v33.rollEpoch == rollEpoch then
      warn("[AutoFarm] Timeout: no RNGSync received for this roll")
      return
    end

    f6()
    return
  end
end

function f6()
  for index, value in ipairs(v33.slots) do
    if v36[value] == true then
      f5(index)
      task.wait(0.1)
    end
  end
end

local fsRollDronesPrompt

local function f8()
  if v35 then
    return
  end

  v35 = true
  v34 = true

  task.spawn(function()
    while v34 do
      if not v31 then
        task.wait(0.2)
      elseif fsRollDronesPrompt.Enabled then
        task.wait(0.5)

        if fsRollDronesPrompt.Enabled and v34 then
          f7()
        end

        task.wait(0.2)
      else
        task.wait(0.1)
      end
    end

    v35 = false
  end)
end

dronesTab:CreateToggle({
  Name = "AutoBuy",
  CurrentValue = false,
  Flag = "AutoBuyToggle",
  Callback = function(value2)
    if value2 then
      f8()
    else
      f4()
    end
  end,
})

local waitForChild4

local v73 = {
  {
    name = "Floor Unlock",
    flag = "UpgradeFloorUnlock",
    remote = "RequestFloorUnlock",
    args = function() return {} end,
    priceLabel = function()
      return waitForChild4.Board4.BoardSurface.FS_UpgradeBoardGui.UpgradeBoard.Card.Content.PillRow.Pill.PillText
    end,
  },
  {
    name = "Luck",
    flag = "UpgradeLuck",
    remote = "RequestUpgradeLuck",
    args = function() return {} end,
    priceLabel = function()
      return waitForChild4.Board3.BoardSurface.FS_UpgradeBoardGui.UpgradeBoard.Card.Content.RightBlock.BottomRow.Pill.PillText
    end,
  },
  {
    name = "Drone Rolls",
    flag = "UpgradeDroneRolls",
    remote = "RequestUpgradeDroneRolls",
    args = function() return {} end,
    priceLabel = function()
      return waitForChild4.Board3.BoardSurface.FS_UpgradeBoardGui.UpgradeBoard:GetChildren()[4].Content.RightBlock.BottomRow.Pill.PillText
    end,
  },
  {
    name = "Planet",
    flag = "UpgradePlanet",
    remote = "RequestUpgradePlanet",
    args = function() return {} end,
    priceLabel = function()
      return waitForChild4.Board7.BoardSurface.FS_UpgradeBoardGui.UpgradeBoard.Card.Content.TextStack.PillRow.Pill.PillText
    end,
  },
}

for index2, value3 in ipairs(v73) do
  value3.enabled = false
  value3.remoteInstance = nil
  value3.maxed = false
end

local function f9(p6)
  if not p6.enabled or p6.remoteInstance == nil then
    return false
  elseif p6.maxed then
    return false
  else
    local v74, v75 = pcall(p6.priceLabel)

    if not v74 or v75 == nil then
      return false
    else
      local text = v75.Text

      if type(text) == "string" and text:gsub("%s+", ""):upper() == "MAX" then
        p6.maxed = true
        return false
      else
        local v76 = f2(text)

        if v76 == nil then
          return false
        else
          local v77 = f3()

          if v77 == nil then
            return false
          elseif v77 < v76 then
            return false
          else
            local v78, v79 = pcall(function() p6.remoteInstance:FireServer(p6.args()) end)

            if not v78 then
              warn(("[AutoFarm] Failed to fire %s: %s"):format(p6.remote, tostring(v79)))
              return false
            end

            return true
          end
        end
      end
    end
  end
end

local v80 = false

local function f10()
  if v80 then
    return
  end

  v80 = true

  task.spawn(function()
    while true do
      local v81 = false

      if v32 then
        for index3, value4 in ipairs(v73) do
          if value4.enabled then
            v81 = true

            if f9(value4) then
              task.wait(0.3)
            end
          end
        end
      else
        for index4, value5 in ipairs(v73) do
          if value5.enabled then
            v81 = true
            break
          end
        end
      end

      if not v81 then
        v80 = false
        return
      end

      task.wait(1)
    end
  end)
end

for index5, value6 in ipairs(v73) do
  local v82 = value6

  upgradesTab:CreateToggle({
    Name = "Auto " .. v82.name,
    CurrentValue = false,
    Flag = v82.flag,
    Callback = function(value7)
      v82.enabled = value7

      if value7 then
        f10()
      end
    end,
  })
end

local function f11(fn2, p7, fn3)
  task.spawn(function()
    while fn2() do
      local v83, v84 = pcall(p7)

      if not v83 then
        warn("[AutoFarm] Multi-floor upgrade loop error: " .. tostring(v84))
      end

      task.wait(1)
    end

    fn3()
  end)
end

local floorLevel

local function f12(p8, p9, p10)
  local v85 = p9 == nil or floorLevel == nil
  local v86

  if v85 then
    return false
  else
    v86 = nil
    local v87 = nil

    for k = 1, floorLevel do
      local v88 = p8[k]

      if v88 and type(v88.nextCost) == "number" then
        if v87 == nil or v88.nextCost < v87 then
          local nextCost = v88.nextCost
          v86 = k
          v87 = nextCost
        end
      end
    end

    if v86 == nil then
      return false
    else
      local v89 = f3()

      if v89 and v89 >= v87 then
        local v90, v91 = pcall(function() p9:FireServer({ floor = v86 }) end)

        if not v90 then
          warn(("[AutoFarm] %s floor %d failed: %s"):format(p10, v86, tostring(v91)))
        end
      end

      return true
    end
  end
end

local function f13(p11)
  if type(p11) == "number" then
    return p11
  end

  if type(p11) == "table" and type(p11.m) == "number" and type(p11.e) == "number" then
    return p11.m * 10 ^ p11.e
  end

  return nil
end

local function f14(p12, p13, p14)
  if p13 == nil or floorLevel == nil then
    return false
  end

  for m = 1, floorLevel do
    local v92 = m
    local v93 = p12[v92]

    if v93 == nil then
      return false
    elseif v93.level < v93.maxLevel then
      local v94 = f3()

      if v94 and v93.nextCost and v94 >= v93.nextCost then
        local v95, v96 = pcall(function() p13:FireServer({ floor = v92 }) end)

        if not v95 then
          warn(("[AutoFarm] %s floor %d failed: %s"):format(p14, v92, tostring(v96)))
        end
      end

      return true
    end
  end

  return false
end

local dpLevelByFloor, waitForChild5, maxDpLevel, dpRevealCost

local function f15()
  if waitForChild5 == nil or floorLevel == nil or dpLevelByFloor == nil or maxDpLevel == nil then
    return false
  end

  for n = 1, floorLevel do
    local v97 = n

    if (dpLevelByFloor[v97] or 0) < maxDpLevel then
      local v98 = f13(dpRevealCost and dpRevealCost[v97])

      if v98 then
        local v99 = f3()

        if v99 and v99 >= v98 then
          local v100, v101 = pcall(function() waitForChild5:FireServer({ floor = v97 }) end)

          if not v100 then
            warn("[AutoFarm] RequestPlatformUpgrade (dpReveal) floor " .. v97 .. " failed: "
              .. tostring(v101))
          end
        end
      end

      return true
    end
  end

  return false
end

local waitForChild6

upgradesTab:CreateToggle({
  Name = "Auto Cargo (multi-floor)",
  CurrentValue = false,
  Flag = "AutoCargoMultiFloor",
  Callback = function(value8)
    v60 = value8

    if value8 and not v61 then
      v61 = true

      f11(
        function() return v60 end,
        function() f14(v57, waitForChild6, "RequestUpgradeCargo") end,
        function() v61 = false end
      )
    end
  end,
})

local waitForChild7

upgradesTab:CreateToggle({
  Name = "Auto Laser Power (cheapest floor)",
  CurrentValue = false,
  Flag = "AutoLaserMultiFloor",
  Callback = function(value9)
    v62 = value9

    if value9 and not v63 then
      v63 = true

      f11(
        function() return v62 end,
        function() f12(v58, waitForChild7, "RequestUpgradeLaserPower") end,
        function() v63 = false end
      )
    end
  end,
})

local waitForChild8

upgradesTab:CreateToggle({
  Name = "Auto Dock Storage (multi-floor)",
  CurrentValue = false,
  Flag = "AutoDockStorageMultiFloor",
  Callback = function(value10)
    v64 = value10

    if value10 and not v65 then
      v65 = true

      f11(
        function() return v64 end,
        function() f14(v59, waitForChild8, "RequestUpgradeDockStorage") end,
        function() v65 = false end
      )
    end
  end,
})

local function f16()
  v40 = false
end

upgradesTab:CreateToggle({
  Name = "Auto Dock Platforms (multi-floor)",
  CurrentValue = false,
  Flag = "AutoDockPlatformsMultiFloor",
  Callback = function(value11)
    v66 = value11

    if value11 and not v67 then
      v67 = true
      f11(function() return v66 end, f15, function() v67 = false end)
    end
  end,
})

local f17

local function f18(p15, p16)
  local v102 = {}

  if floorLevel == nil or dpLevelByFloor == nil then
    v37 = v102
    return
  end

  for i6 = 1, p16.MAX_FLOOR do
    if i6 <= floorLevel then
      local v103 = f17(p15, i6)
      local v104 = dpLevelByFloor[i6] or 0

      if v103 then
        local docks = v103:FindFirstChild("Docks")

        if docks then
          for i7 = 1, math.min(v104, 3) do
            local findFirstChild = docks:FindFirstChild("DockPlatform" .. i7)

            if findFirstChild then
              for i8 = 1, v38[i7] or 0 do
                local findFirstChild2 = findFirstChild:FindFirstChild(tostring(i8))

                if findFirstChild2 then
                  local v105 = p16.globalDockId(i6, i7, i8)

                  if v105 then
                    table.insert(v102, { model = findFirstChild2, dockIndex = v105 })
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  v37 = v102
end

function f17(p17, p18)
  local platform = p17:FindFirstChild("Platform")

  if not platform then
    return nil
  end

  if p18 == 1 then
    return platform
  end

  return platform:FindFirstChild("Platform" .. p18)
end

local function f19(p19, p20, p21)
  local v106 = os.clock()

  while os.clock() - v106 < p21 do
    local character = localPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and (humanoidRootPart.Position - p19).Magnitude <= p20 then
      return true
    end

    task.wait(0.1)
  end

  return false
end

local f20

local function f21()
  if v41 then
    return
  end

  v41 = true
  v40 = true

  task.spawn(function()
    local v107 = 0

    while v40 do
      task.wait(1)
      v107 = v107 + 1

      if v107 >= v42 then
        local v108 = v39
        v107 = 0

        if v108 and #v37 > 0 then
          local v109, v110 = pcall(f20)

          if not v109 then
            warn("[AutoFarm] AutoCollect cycle failed: " .. tostring(v110))
          end
        end
      end
    end

    v41 = false
  end)
end

local waitForChild9, waitForChild10, waitForChild11

function f20()
  local v111 = waitForChild10 == nil or waitForChild11 == nil
  local parent, rng

  if v111 then
    return
  else
    local character2 = localPlayer.Character
    local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart2 == nil then
      warn("[AutoFarm] No HumanoidRootPart, cannot teleport to shop")
      return
    else
      parent = waitForChild11.Parent

      local v112, v113 = pcall(function()
        if parent:IsA("BasePart") then
          return parent.CFrame
        end

        return parent:GetPivot()
      end)

      if not v112 or v113 == nil then
        warn("[AutoFarm] Could not get SellPromptAnchor position: " .. tostring(v113))
        return
      end

      humanoidRootPart2.CFrame = v113 + Vector3.new(0, 3, 0)

      if not f19(v113.Position, 10, 3) then
        warn("[AutoFarm] Player never settled within 10 studs of the shop anchor, aborting collect cycle")
        return
      end

      for index6, value12 in ipairs(v37) do
        local v114 = value12
        local count = 0
        local v115 = nil

        while count < 20 do
          local v116, v117 = pcall(function() return v114.model:GetAttribute("FS_OreCount") end)

          if not v116 or type(v117) ~= "number" or v117 <= 0 then
            break
          end

          if v115 ~= nil and v117 >= v115 then
            warn(("[AutoFarm] dockIndex %d: FS_OreCount ne diminue plus (%s), on passe au suivant"):format(
              v114.dockIndex, tostring(v117)
            ))

            break
          else
            v115 = v117

            local v118, v119 = pcall(function()
              waitForChild9:FireServer({ dockIndex = v114.dockIndex })
            end)

            if not v118 then
              warn(("[AutoFarm] Collect dockIndex %d failed: %s"):format(
                v114.dockIndex, tostring(v119)
              ))

              break
            else
              task.wait(0.1)
              local v120, v121 = pcall(function() fireproximityprompt(waitForChild11) end)

              if not v120 then
                warn("[AutoFarm] fireproximityprompt on SellPrompt failed: " .. tostring(v121))
              end

              task.wait(0.1)
              count = count + 1
            end
          end
        end
      end

      rng = waitForChild4 and waitForChild4:FindFirstChild("RNG")
      rng = rng and rng:FindFirstChild("Button")

      if rng then
        local v122, v123 = pcall(function()
          if rng:IsA("BasePart") then
            return rng.CFrame
          end

          return rng:GetPivot()
        end)

        if v122 and v123 then
          local character3 = localPlayer.Character

          local humanoidRootPart3 = character3
          humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart3 then
            humanoidRootPart3.CFrame = v123 + Vector3.new(0, 3, 0)
          end
        else
          warn("[AutoFarm] Could not get RNG.Button position: " .. tostring(v123))
        end
      else
        warn("[AutoFarm] plot.RNG.Button not found, no TP back")
      end

      return
    end
  end
end

docksTab:CreateSlider({
  Name = "Collect Interval (s)",
  Range = { 5, 120 },
  Increment = 5,
  CurrentValue = 30,
  Flag = "CollectIntervalSlider",
  Callback = function(value13) v42 = value13 end,
})

docksTab:CreateToggle({
  Name = "AutoCollect",
  CurrentValue = false,
  Flag = "AutoCollectToggle",
  Callback = function(value14)
    if value14 then
      f21()
    else
      f16()
    end
  end,
})

local v124

local function f22(p22)
  if not v124 or not waitForChild4 then
    return nil
  else
    local v125 = v124.floorOfDock(p22)
    local v126 = v124.dpOfDock(p22)
    local v127 = not v125
    local v128 = v124.localOfDock(p22)

    if v127 or not v126 or not v128 then
      return nil
    else
      local v129 = f17(waitForChild4, v125)

      if not v129 then
        return nil
      else
        local docks2 = v129:FindFirstChild("Docks")

        if not docks2 then
          return nil
        else
          local findFirstChild3 = docks2:FindFirstChild("DockPlatform" .. v126)

          if not findFirstChild3 then
            return nil
          end

          return findFirstChild3:FindFirstChild(tostring(v128))
        end
      end
    end
  end
end

local function f23(p23)
  local v130 = {}

  for index7, value15 in ipairs(p23) do
    local hotbarD = tostring(value15.location):match("^hotbar:(%d+)$")

    if hotbarD then
      v130[tonumber(hotbarD)] = true
    end
  end

  for i9 = 1, 9 do
    if not v130[i9] then
      return i9
    end
  end

  return nil
end

local function f24(p24)
  local v131 = {}

  for index8, value16 in ipairs(p24) do
    if value16.kind == "drone" then
      local dockD = tostring(value16.location):match("^dock:(%d+)$")

      if dockD then
        v131[tonumber(dockD)] = true
      end
    end
  end

  return v131
end

local v132, v133

local function f25(p25)
  local v134 = 0
  local v135, v136 = pcall(function() return v132.rarity(p25.droneType) end)

  if v135 and v136 then
    local v137, v138 = pcall(function() return v133.rank(v136) end)

    if v137 and type(v138) == "number" then
      v134 = v138
    end
  end

  local v139 = 0
  local v140, v141 = pcall(function() return v132.costScale(p25.droneType) end)

  if v140 and type(v141) == "number" then
    v139 = v141
  end

  return v134, v139, p25.level and p25.level.value or 0
end

local function f26(p26)
  local v142 = f22(p26)

  if not v142 then
    return false
  else
    local v143, v144 = pcall(function() return v142.Transparency end)

    if not v143 then
      return false
    end

    return v144 == 0
  end
end

local function f27(p27, p28)
  local v145, v146, v147, v148

  for index9, value17 in ipairs(p27) do
    if value17.kind == "drone" and value17.location == "bag" and not p28[value17.uid] then
      local v149, v150, v151 = f25(value17)

      if v146 == nil or v149 > v147 or v149 == v147 and v150 > v148
        or v149 == v147 and v150 == v148 and v151 > v145 then
        v146 = value17
        v148 = v150
        v147 = v149
        v145 = v151
      end
    end
  end

  return v146
end

local inventorySync, waitForChild12, waitForChild13, waitForChild14, waitForChild15,
  waitForChild16

local function f28()
  if not inventorySync or not waitForChild12 or not waitForChild13 or not waitForChild14
    or not waitForChild15 or not waitForChild16 then
    warn("[AutoFarm] AutoPlace: required remotes not resolved")
    return
  else
    local v152 = items

    if #v152 == 0 then
      warn("[AutoFarm] AutoPlace: inventory empty/not received yet")
      return
    else
      local v153 = {}

      for index10, value18 in ipairs(v152) do
        if value18.kind == "drone" and tostring(value18.location):match("^dock:%d+$") then
          table.insert(v153, value18)
        end
      end

      for index11, value19 in ipairs(v153) do
        local v154 = value19
        local v155, v156 = pcall(function() waitForChild15:FireServer({ droneId = v154.uid }) end)

        if not v155 then
          warn(("[AutoFarm] AutoPlace: removing %s failed: %s"):format(v154.uid, tostring(v156)))
        end

        v154.location = "bag"
        task.wait(0.15)
      end

      task.wait(0.3)
      local v157 = items
      local v158 = {}

      for index12, value20 in ipairs(v157) do
        local hotbarD2 = tostring(value20.location):match("^hotbar:(%d+)$")

        if hotbarD2 then
          v158[tonumber(hotbarD2)] = value20.uid
        end
      end

      local count2 = 0

      for key, value21 in pairs(v158) do
        local v159 = key
        local v160 = value21

        local v161, v162 = pcall(function()
          waitForChild16:FireServer({ uid = v160, slot = v159 })
        end)

        if not v161 then
          warn(("[AutoFarm] AutoPlace: unassign slot %d failed: %s"):format(v159, tostring(v162)))
        else
          count2 = count2 + 1
        end

        for index13, value22 in ipairs(v157) do
          if value22.uid == v160 then
            value22.location = "bag"
          end
        end

        for index14, value23 in ipairs(v152) do
          if value23.uid == v160 then
            value23.location = "bag"
          end
        end

        task.wait(0.1)
      end

      if count2 > 0 then
        task.wait(0.2)
      end

      local v163 = f24(v152)
      local v164 = {}
      local maxFLOOR = v124 and v124.MAX_FLOOR
      local v165 = v124
      local v166 = maxFLOOR or 5
      local maxDPLEVEL = v165 and v124.MAX_DP_LEVEL or 3

      for i10 = 1, v166 do
        for i11 = 1, maxDPLEVEL do
          for i12 = 1, v38[i11] or 0 do
            local v167 = v124.globalDockId(i10, i11, i12)

            if v167 and f26(v167) and not v163[v167] then
              table.insert(v164, v167)
            end
          end
        end
      end

      table.sort(v164)

      if #v164 == 0 then
        warn("[AutoFarm] AutoPlace: no free dock found")
        return
      else
        local v168 = {}

        for index15, value24 in ipairs(v164) do
          local v169 = value24
          local v170 = f27(v152, v168)

          if not v170 then
            break
          else
            v168[v170.uid] = true
            local v171 = f23(v152)

            if not v171 then
              warn("[AutoFarm] AutoPlace: no more free hotbar slots, stopping")
              break
            else
              local v172, v173 = pcall(function()
                waitForChild12:FireServer({
                  expectedLocation = "bag",
                  uid = v170.uid,
                  replaceOccupied = false,
                  slot = v171,
                })
              end)

              if not v172 then
                warn("[AutoFarm] AutoPlace assign failed: " .. tostring(v173))
              end

              task.wait(0.2)

              local v174, v175 = pcall(function()
                waitForChild13:FireServer({ slot = v171, uid = v170.uid })
              end)

              if not v174 then
                warn("[AutoFarm] AutoPlace select failed: " .. tostring(v175))
              end

              task.wait(0.2)

              local v176, v177 = pcall(function()
                waitForChild14:FireServer({ dockIndex = v169 })
              end)

              if not v176 then
                warn("[AutoFarm] AutoPlace place failed: " .. tostring(v177))
              end

              task.wait(0.2)
              v170.location = "dock:" .. v169
            end
          end
        end

        return
      end
    end
  end
end

docksTab:CreateButton({
  Name = "AutoPlace (retrieve and re-place the best)",
  Callback = function()
    task.spawn(function()
      local v178, v179 = pcall(f28)

      if not v178 then
        warn("[AutoFarm] AutoPlace failed: " .. tostring(v179))
      end
    end)
  end,
})

local v180 = false
local v181 = false
local v182 = {}

local function f29()
  for key2, value25 in pairs(v182) do
    local v183 = value25
    pcall(function() v183:Destroy() end)
  end

  v182 = {}
end

local function f30()
  v180 = false
end

local function f31(p29, p30)
  local v184 = f22(p29)
  local format, color, v185

  if not v184 then
    v185 = v182[p29]

    if v185 then
      pcall(function() v185:Destroy() end)
      v182[p29] = nil
    end

    return
  else
    local v186 = p30[p29] == true

    if not f26(p29) then
      format = ("%d locked"):format(p29)
      color = Color3.fromRGB(255, 80, 80)
    elseif v186 then
      format = ("%d occupied"):format(p29)
      color = Color3.fromRGB(80, 160, 255)
    else
      format = ("%d free"):format(p29)
      color = Color3.fromRGB(80, 255, 120)
    end

    local autoFarmDockESP = v182[p29]

    if not autoFarmDockESP or autoFarmDockESP.Parent == nil then
      autoFarmDockESP = Instance.new("BillboardGui")
      autoFarmDockESP.Name = "AutoFarm_DockESP"
      autoFarmDockESP.Size = UDim2.fromOffset(160, 40)
      autoFarmDockESP.StudsOffset = Vector3.new(0, 4, 0)
      autoFarmDockESP.AlwaysOnTop = true
      autoFarmDockESP.Adornee = v184

      local label = Instance.new("TextLabel")
      label.Name = "Label"
      label.Size = UDim2.fromScale(1, 1)
      label.BackgroundTransparency = 1
      label.Font = Enum.Font.GothamBold
      label.TextScaled = true
      label.TextStrokeTransparency = 0
      label.TextStrokeColor3 = Color3.new(0, 0, 0)
      label.Parent = autoFarmDockESP

      autoFarmDockESP.Parent = v184
      v182[p29] = autoFarmDockESP
    end

    local label2 = autoFarmDockESP:FindFirstChild("Label")

    if label2 then
      label2.Text = format
      label2.TextColor3 = color
    end

    return
  end
end

local function f32()
  local v187 = f24(items)
  local maxFLOOR2 = v124 and v124.MAX_FLOOR
  local v188 = v124
  local v189 = maxFLOOR2 or 5
  local maxDPLEVEL2 = v188 and v124.MAX_DP_LEVEL or 3

  for i13 = 1, v189 do
    for i14 = 1, maxDPLEVEL2 do
      for i15 = 1, v38[i14] or 0 do
        local v190 = v124.globalDockId(i13, i14, i15)

        if v190 then
          f31(v190, v187)
        end
      end
    end
  end
end

local function f33()
  if v181 then
    return
  end

  v181 = true
  v180 = true

  task.spawn(function()
    while v180 do
      local v191, v192 = pcall(f32)

      if not v191 then
        warn("[AutoFarm] Docks ESP refresh failed: " .. tostring(v192))
      end

      task.wait(2)
    end

    f29()
    v181 = false
  end)
end

docksTab:CreateToggle({
  Name = "Docks ESP",
  CurrentValue = false,
  Flag = "DocksEspToggle",
  Callback = function(value26)
    if value26 then
      f33()
    else
      f30()
    end
  end,
})

local function f34(p31)
  local v193 = {}
  local v194, v195 = pcall(function() return gethui and gethui() end)

  if v194 and v195 then
    table.insert(v193, v195)
  end

  local v196, v197 = pcall(function() return game:GetService("CoreGui") end)

  if v196 and v197 then
    table.insert(v193, v197)
  end

  table.insert(v193, localPlayer.PlayerGui)

  for index16, value27 in ipairs(v193) do
    local v198 = value27

    local v199, v200 = pcall(function()
      for index17, value28 in ipairs(v198:GetDescendants()) do
        if value28.Name == "CardGrid" and value28:FindFirstAncestor(p31) then
          value28:Destroy()
        end
      end
    end)

    if not v199 then
      warn(("[AutoFarm] CardGrid cleanup (%s / %s) failed: %s"):format(
        p31, v198.Name, tostring(v200)
      ))
    end
  end
end

local v201, cardGrid

local function f35()
  local v202 = items
  local v203 = {}
  v44 = {}
  local v204 = {}

  for index18, value29 in ipairs(v202) do
    if value29.kind == "drone" then
      local dockD2 = tostring(value29.location):match("^dock:(%d+)$")

      if dockD2 then
        table.insert(v204, { item = value29, dockIndex = tonumber(dockD2) })
      end
    end
  end

  table.sort(v204, function(p32, p33) return p32.dockIndex < p33.dockIndex end)

  for index19, value30 in ipairs(v204) do
    local item = value30.item
    local value31 = item.level and item.level.value or 0

    local format2 = ("dock:%d | %s | lvl %d"):format(
      value30.dockIndex, tostring(item.droneType), value31
    )

    if v44[format2] then
      format2 = format2 .. " (" .. item.uid .. ")"
    end

    v44[format2] = item.uid
    local icon = ""
    local v205, v206 = pcall(function() return v201.get(item.droneType) end)

    if v205 and v206 then
      icon = v206
    end

    table.insert(v203, { Name = format2, Icon = icon })
  end

  f34("LevelUp")
  v45 = {}

  cardGrid = levelUpTab:CreateCardGrid({
    Items = v203,
    Columns = 3,
    Flag = "LevelUpDroneSelection",
    Callback = function(value32)
      v45 = {}

      for key3 in pairs(value32) do
        local v207 = v44[key3]

        if v207 then
          v45[v207] = true
        end
      end
    end,
  })
end

local waitForChild17

local function f36()
  if not waitForChild17 then
    return
  end

  for key4 in pairs(v45) do
    local v208 = key4
    local v209 = v43[v208]

    if v209 then
      if (v209.level and v209.level.value or 0) < v46 then
        local v210 = f13(v209.nextValueCost)
        local v211 = f3()

        if v210 and v211 and v211 >= v210 then
          local v212, v213 = pcall(function() waitForChild17:FireServer({ droneId = v208 }) end)

          if not v212 then
            warn(("[AutoFarm] AutoLevelUp: upgrade %s failed: %s"):format(v208, tostring(v213)))
          end
        end
      end
    end
  end
end

local function f37()
  v47 = false
end

local function f38()
  if v48 then
    return
  end

  v48 = true
  v47 = true

  task.spawn(function()
    while v47 do
      local v214, v215 = pcall(f36)

      if not v214 then
        warn("[AutoFarm] AutoLevelUp cycle failed: " .. tostring(v215))
      end

      task.wait(0.5)
    end

    v48 = false
  end)
end

levelUpTab:CreateButton({ Name = "Refresh drone list", Callback = function() f35() end })

levelUpTab:CreateButton({
  Name = "Select All",
  Callback = function()
    if not cardGrid then
      warn("[AutoFarm] AutoLevelUp: refresh the list before selecting all")
      return
    else
      local v216 = {}

      for key5 in pairs(v44) do
        v216[key5] = true
      end

      cardGrid:SetSelected(v216)
      return
    end
  end,
})

levelUpTab:CreateInput({
  Name = "Niveau cible",
  PlaceholderText = "ex: 10",
  CurrentValue = tostring(v46),
  Flag = "TargetLevelInput",
  Callback = function(value33)
    local v217 = tonumber(value33)

    if v217 and v217 >= 1 then
      v46 = math.floor(v217)
    else
      warn("[AutoFarm] Niveau cible invalide: " .. tostring(value33))
    end
  end,
})

levelUpTab:CreateToggle({
  Name = "AutoLevelUp",
  CurrentValue = false,
  Flag = "AutoLevelUpToggle",
  Callback = function(value34)
    if value34 then
      f38()
    else
      f37()
    end
  end,
})

local function f39()
  local playerGui3 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui3 then
    return nil
  else
    local fsGearShopPanel2 = playerGui3:FindFirstChild("FS_GearShopPanel")

    if not fsGearShopPanel2 then
      return nil
    else
      local gearShopStack2 = fsGearShopPanel2:FindFirstChild("GearShopStack")

      if not gearShopStack2 then
        return nil
      else
        local gearShopModal2 = gearShopStack2:FindFirstChild("GearShopModal")

        if not gearShopModal2 then
          return nil
        else
          local box3 = gearShopModal2:FindFirstChild("Box")

          if not box3 then
            return nil
          end

          return box3:FindFirstChild("ItemList")
        end
      end
    end
  end
end

local function f40()
  v51 = false
end

local function f41()
  if f39() then
    return true
  end

  pcall(function()
    local waitForChild18 = localPlayer:WaitForChild("PlayerScripts", 10):WaitForChild(
      "Controllers", 10
    )

    local v218 = require(waitForChild18:WaitForChild("GearShopController", 10))
    local v219 = require(waitForChild18:WaitForChild("PanelHub", 10)).get()
    pcall(function() v218.start() end)
    v218.openGearShop()
    task.wait(0.5)
    pcall(function() v219:close() end)
  end)

  task.wait(0.5)
  return f39() ~= nil
end

local function f42()
  if not f41() then
    warn("[AutoFarm] AutoShop: FS_GearShopPanel not found even after preload")
    return
  else
    local v220 = f39()

    if not v220 then
      warn("[AutoFarm] AutoShop: ItemList not found")
      return
    else
      v49 = {}
      local v221 = {}

      for index20, value35 in ipairs(v220:GetChildren()) do
        if value35:IsA("Frame") and value35.Name:match("^ItemCard_") then
          local gsub3 = value35.Name:gsub("^ItemCard_", "")
          local iconBox = value35:FindFirstChild("IconBox")
          local icon2 = ""

          if iconBox then
            local itemIcon = iconBox:FindFirstChild("ItemIcon")

            if itemIcon then
              local v222, v223 = pcall(function() return itemIcon.Image end)

              if v222 then
                icon2 = v223
              end
            end
          end

          local v224 = gsub3
          local displayName = value35:FindFirstChild("DisplayName")

          if displayName then
            local v225, v226 = pcall(function() return displayName.Text end)

            if v225 and v226 and v226 ~= "" then
              v224 = v226
            end
          end

          local v227 = v224

          if v49[v227] then
            v227 = v227 .. " (" .. gsub3 .. ")"
          end

          v49[v227] = gsub3
          table.insert(v221, { Name = v227, Icon = icon2 })
        end
      end

      shopTab:CreateCardGrid({
        Items = v221,
        Columns = 3,
        Flag = "ShopItemSelection",
        Callback = function(value36)
          v50 = {}

          for key6 in pairs(value36) do
            local v228 = v49[key6]

            if v228 then
              v50[v228] = true
            end
          end
        end,
      })

      return
    end
  end
end

local f43

local function f44()
  if v52 then
    return
  end

  v52 = true
  v51 = true

  task.spawn(function()
    local v229 = 0

    while v51 do
      task.wait(1)
      v229 = v229 + 1

      if v229 >= intervalleS then
        v229 = 0
        local v230, v231 = pcall(f43)

        if not v230 then
          warn("[AutoFarm] AutoShop cycle failed: " .. tostring(v231))
        end
      end
    end

    v52 = false
  end)
end

function f43()
  local waitForChild19 = replicatedStorage:WaitForChild("Net", 10):WaitForChild(
    "RequestGearShopCashPurchase", 10
  )

  if not waitForChild19 then
    warn("[AutoFarm] AutoShop: RequestGearShopCashPurchase not found")
    return
  end

  for key7 in pairs(v50) do
    local v232 = key7
    local v233 = stockByItemId[v232]

    if type(v233) == "number" and v233 > 0 then
      for i16 = 1, v233 do
        local v234, v235 = pcall(function()
          waitForChild19:FireServer({ consumableId = v232 })
        end)

        if not v234 then
          warn(("[AutoFarm] AutoShop: purchase %s failed: %s"):format(v232, tostring(v235)))
        end

        task.wait(0.2)
      end
    end
  end
end

shopTab:CreateSlider({
  Name = "Intervalle (s)",
  Range = { 10, 300 },
  Increment = 5,
  CurrentValue = 30,
  Flag = "ShopIntervalSlider",
  Callback = function(value37) intervalleS = value37 end,
})

local function f45()
  v55 = false
end

shopTab:CreateToggle({
  Name = "AutoShop",
  CurrentValue = false,
  Flag = "AutoShopToggle",
  Callback = function(value38)
    if value38 then
      f44()
    else
      f40()
    end
  end,
})

local function f46()
  local playerGui4 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui4 then
    return nil
  else
    local fsAlienPetShopPanel2 = playerGui4:FindFirstChild("FS_AlienPetShopPanel")

    if not fsAlienPetShopPanel2 then
      return nil
    else
      local alienPetShopStack2 = fsAlienPetShopPanel2:FindFirstChild("AlienPetShopStack")

      if not alienPetShopStack2 then
        return nil
      else
        local alienPetShopModal2 = alienPetShopStack2:FindFirstChild("AlienPetShopModal")

        if not alienPetShopModal2 then
          return nil
        else
          local box4 = alienPetShopModal2:FindFirstChild("Box")

          if not box4 then
            return nil
          end

          return box4:FindFirstChild("ItemList")
        end
      end
    end
  end
end

local function f47()
  local waitForChild20 = replicatedStorage:WaitForChild("Net", 10):WaitForChild(
    "RequestAlienPetShopCashPurchase", 10
  )

  if not waitForChild20 then
    warn("[AutoFarm] AutoAlienShop: RequestAlienPetShopCashPurchase not found")
    return
  end

  for key8 in pairs(v54) do
    local v236 = key8
    local v237 = stockByItemId2[v236]

    if type(v237) == "number" and v237 > 0 then
      for i17 = 1, v237 do
        local v238, v239 = pcall(function()
          waitForChild20:FireServer({ consumableId = v236 })
        end)

        if not v238 then
          warn(("[AutoFarm] AutoAlienShop: purchase %s failed: %s"):format(v236, tostring(v239)))
        end

        task.wait(0.2)
      end
    end
  end
end

local f48

local function f49()
  if not f48() then
    warn("[AutoFarm] AutoAlienShop: FS_AlienPetShopPanel not found even after preload")
    return
  else
    local v240 = f46()

    if not v240 then
      warn("[AutoFarm] AutoAlienShop: ItemList not found")
      return
    else
      v53 = {}
      local v241 = {}

      for index21, value39 in ipairs(v240:GetChildren()) do
        if value39:IsA("Frame") and value39.Name:match("^ItemCard_") then
          local gsub4 = value39.Name:gsub("^ItemCard_", "")
          local iconBox2 = value39:FindFirstChild("IconBox")
          local icon3 = ""

          if iconBox2 then
            local itemIcon2 = iconBox2:FindFirstChild("ItemIcon")

            if itemIcon2 then
              local v242, v243 = pcall(function() return itemIcon2.Image end)

              if v242 then
                icon3 = v243
              end
            end
          end

          local v244 = gsub4
          local displayName2 = value39:FindFirstChild("DisplayName")

          if displayName2 then
            local v245, v246 = pcall(function() return displayName2.Text end)

            if v245 and v246 and v246 ~= "" then
              v244 = v246
            end
          end

          local v247 = v244

          if v53[v247] then
            v247 = v247 .. " (" .. gsub4 .. ")"
          end

          v53[v247] = gsub4
          table.insert(v241, { Name = v247, Icon = icon3 })
        end
      end

      alienShopTab:CreateCardGrid({
        Items = v241,
        Columns = 3,
        Flag = "AlienShopItemSelection",
        Callback = function(value40)
          v54 = {}

          for key9 in pairs(value40) do
            local v248 = v53[key9]

            if v248 then
              v54[v248] = true
            end
          end
        end,
      })

      return
    end
  end
end

function f48()
  if f46() then
    return true
  end

  pcall(function()
    local waitForChild21 = localPlayer:WaitForChild("PlayerScripts", 10):WaitForChild(
      "Controllers", 10
    )

    local v249 = require(waitForChild21:WaitForChild("AlienPetShopController", 10))
    local v250 = require(waitForChild21:WaitForChild("PanelHub", 10)).get()
    pcall(function() v249.start() end)
    v249.openAlienPetShop()
    task.wait(0.5)
    pcall(function() v250:close() end)
  end)

  task.wait(0.5)
  return f46() ~= nil
end

local function f50()
  if v56 then
    return
  end

  v56 = true
  v55 = true

  task.spawn(function()
    local v251 = 0

    while v55 do
      task.wait(1)
      v251 = v251 + 1

      if v251 >= intervalleS2 then
        v251 = 0
        local v252, v253 = pcall(f47)

        if not v252 then
          warn("[AutoFarm] AutoAlienShop cycle failed: " .. tostring(v253))
        end
      end
    end

    v56 = false
  end)
end

alienShopTab:CreateSlider({
  Name = "Intervalle (s)",
  Range = { 10, 300 },
  Increment = 5,
  CurrentValue = 30,
  Flag = "AlienShopIntervalSlider",
  Callback = function(value41) intervalleS2 = value41 end,
})

alienShopTab:CreateToggle({
  Name = "AutoAlienShop",
  CurrentValue = false,
  Flag = "AutoAlienShopToggle",
  Callback = function(value42)
    if value42 then
      f50()
    else
      f45()
    end
  end,
})

local function f51()
  local v254 = {}

  for index22, value43 in ipairs(v133.order) do
    local v255 = {}

    for index23, value44 in ipairs(v132.order) do
      local v256 = value44
      local v257, v258 = pcall(function() return v132.rarity(v256) end)

      if v257 and v258 == value43 then
        local icon4 = ""
        local v259, v260 = pcall(function() return v201.get(v256) end)

        if v259 and v260 then
          icon4 = v260
        end

        table.insert(v255, { Name = v256, Icon = icon4 })
      end
    end

    if #v255 > 0 then
      table.insert(v254, { Label = value43, Items = v255 })
    end
  end

  return v254
end

local v261, rngSync, rng2, dockUnlockSync, droneSync

task.spawn(function()
  local v262, v263 = pcall(function()
    local waitForChild22 = replicatedStorage:WaitForChild("Net", 10)
    v261 = require(waitForChild22:WaitForChild("Remotes", 10))
    rngSync = v261.get("RNGSync")
    waitForChild3 = waitForChild22:WaitForChild("RequestRollDrones", 10)
    waitForChild2 = waitForChild22:WaitForChild("RequestPickUpDrone", 10)
    local waitForChild23 = replicatedStorage:WaitForChild("Config", 10)
    v132 = require(waitForChild23:WaitForChild("DroneCatalog", 10))
    v201 = require(waitForChild23:WaitForChild("DroneSpriteMap", 10))
    v133 = require(waitForChild23:WaitForChild("RarityConfig", 10))
    waitForChild4 = workspace:WaitForChild("FarmStar"):WaitForChild("Platforms"):WaitForChild(tostring(localPlayer.UserId))
    rng2 = waitForChild4:WaitForChild("RNG")
    fsRollDronesPrompt = rng2:WaitForChild("Button"):WaitForChild("FS_RollDronesPrompt")

    for i18 = 1, 6 do
      local waitForChild24 = rng2:WaitForChild("Slot" .. i18, 10)

      if waitForChild24 then
        local waitForChild25 = waitForChild24:WaitForChild("FS_PickUpDronePrompt", 10)

        if waitForChild25 then
          v30[i18] = waitForChild25
        else
          warn(("[AutoFarm] Slot%d pickup prompt not found"):format(i18))
        end
      end
    end

    rngSync.OnClientEvent:Connect(function(p34)
      if type(p34) ~= "table" or type(p34.slots) ~= "table" then
        return
      end

      v33 = {
        rollEpoch = p34.rollEpoch,
        slots = p34.slots,
        pitySlots = p34.pitySlots or {},
        auto = p34.auto == true,
      }
    end)

    v31 = true
    local groups = f51()
    task.wait(0.5)

    dronesTab:CreateFilteredCardGrid({
      Groups = groups,
      Columns = 4,
      Flag = "AutoBuyDroneSelection",
      Callback = function(value45) v36 = value45 end,
    })
  end)

  local waitForChild26

  if not v262 then
    warn("[AutoFarm] World resolution (drones) failed: " .. tostring(v263))
    return
  else
    waitForChild26 = replicatedStorage:WaitForChild("Net", 10)

    for index24, value46 in ipairs(v73) do
      local waitForChild27 = waitForChild26:WaitForChild(value46.remote, 10)

      if waitForChild27 == nil then
        warn(("[AutoFarm] Remote %s not found"):format(value46.remote))
      end

      value46.remoteInstance = waitForChild27
    end

    v32 = true

    local v264, v265 = pcall(function()
      v124 = require(replicatedStorage:WaitForChild("Core", 10):WaitForChild("DockMath", 10))
      waitForChild9 = waitForChild26:WaitForChild("RequestCollectDockOre", 10)
      local waitForChild28 = waitForChild4:WaitForChild("Shops", 10):WaitForChild("Shop", 10)
      waitForChild10 = waitForChild28:WaitForChild("ShopBuild", 10):WaitForChild("Shop", 10)

      waitForChild11 = waitForChild28:WaitForChild("FS_SellPromptAnchor", 10):WaitForChild(
        "FS_SellPrompt", 10
      )

      dockUnlockSync = v261.get("DockUnlockSync")
      local requestStateSync = v261.get("RequestStateSync")

      dockUnlockSync.OnClientEvent:Connect(function(p35)
        if type(p35) ~= "table" then
          return
        end

        floorLevel = p35.floorLevel
        dpLevelByFloor = p35.dpLevelByFloor
        maxDpLevel = p35.maxDpLevel
        dpRevealCost = p35.dpRevealCost
        f18(waitForChild4, v124)
      end)

      v39 = true
      waitForChild6 = waitForChild26:WaitForChild("RequestUpgradeCargo", 10)
      waitForChild7 = waitForChild26:WaitForChild("RequestUpgradeLaserPower", 10)
      waitForChild8 = waitForChild26:WaitForChild("RequestUpgradeDockStorage", 10)
      waitForChild5 = waitForChild26:WaitForChild("RequestPlatformUpgrade", 10)
      local cargoSync = v261.get("CargoSync")
      local laserSync = v261.get("LaserSync")
      local dockStorageSync = v261.get("DockStorageSync")

      if cargoSync then
        cargoSync.OnClientEvent:Connect(function(p36)
          if type(p36) == "table" and type(p36.floor) == "number" then
            v57[p36.floor] = {
              level = p36.level,
              maxLevel = p36.maxLevel,
              nextCost = p36.nextCost,
            }
          end
        end)
      else
        warn("[AutoFarm] CargoSync not found")
      end

      if laserSync then
        laserSync.OnClientEvent:Connect(function(p37)
          if type(p37) == "table" and type(p37.floor) == "number" then
            v58[p37.floor] = {
              level = p37.level,
              maxLevel = p37.maxLevel,
              nextCost = p37.nextCost,
            }
          end
        end)
      else
        warn("[AutoFarm] LaserSync not found")
      end

      if dockStorageSync then
        dockStorageSync.OnClientEvent:Connect(function(p38)
          if type(p38) == "table" and type(p38.floor) == "number" then
            v59[p38.floor] = {
              level = p38.level,
              maxLevel = p38.maxLevel,
              nextCost = p38.nextCost,
            }
          end
        end)
      else
        warn("[AutoFarm] DockStorageSync not found")
      end

      inventorySync = v261.get("InventorySync")
      waitForChild12 = waitForChild26:WaitForChild("RequestAssignHotbar", 10)
      waitForChild13 = waitForChild26:WaitForChild("RequestSelectHotbar", 10)
      waitForChild14 = waitForChild26:WaitForChild("RequestPlaceDrone", 10)
      waitForChild16 = waitForChild26:WaitForChild("RequestUnassignHotbar", 10)
      waitForChild15 = waitForChild26:WaitForChild("RequestRemoveDrone", 10)
      local v266 = false

      if inventorySync then
        inventorySync.OnClientEvent:Connect(function(p39)
          if type(p39) == "table" and type(p39.items) == "table" then
            items = p39.items
            v266 = true
          end
        end)
      else
        warn("[AutoFarm] InventorySync not found")
      end

      droneSync = v261.get("DroneSync")
      waitForChild17 = waitForChild26:WaitForChild("RequestUpgradeDrone", 10)

      if droneSync then
        droneSync.OnClientEvent:Connect(function(p40)
          if type(p40) ~= "table" or type(p40.updates) ~= "table" then
            return
          end

          for index25, value47 in ipairs(p40.updates) do
            if type(value47) == "table" and type(value47.id) == "string"
              and value47.level ~= nil then
              local v267 = v43[value47.id] or {}
              v267.level = value47.level

              if value47.nextValueCost ~= nil then
                v267.nextValueCost = value47.nextValueCost
              end

              v43[value47.id] = v267
            end
          end
        end)
      else
        warn("[AutoFarm] DroneSync not found")
      end

      if requestStateSync then
        pcall(function() requestStateSync:FireServer({ upgradeBoardReady = true }) end)
        pcall(function() requestStateSync:FireServer({}) end)
      end

      if requestStateSync and inventorySync then
        task.spawn(function()
          local count3 = 0

          while not v266 and count3 < 15 do
            task.wait(2)
            count3 = count3 + 1

            if not v266 then
              pcall(function() requestStateSync:FireServer({}) end)
            end
          end

          if not v266 then
            warn("[AutoFarm] InventorySync never received after " .. count3 .. " attempts")
          end
        end)
      end
    end)

    if not v264 then
      warn("[AutoFarm] World resolution (docks) failed: " .. tostring(v265))
    end

    return
  end
end)

task.spawn(function()
  local v268, v269 = pcall(f42)

  if not v268 then
    warn("[AutoFarm] AutoShop initial build failed: " .. tostring(v269))
  end
end)

task.spawn(function()
  local v270, v271 = pcall(f49)

  if not v270 then
    warn("[AutoFarm] AutoAlienShop initial build failed: " .. tostring(v271))
  end
end)
