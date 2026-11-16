local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "LnY4WU3u6" / (15440344 - "BZgUQWP" ^ 13644705) end) })[2]
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
          pcall(function() return "iDpPQ3pXd" / (6626507 - "9ZCVBeR" ^ 14233523) end),
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

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local v12 = require(localPlayer.PlayerScripts.TS.network)
local events = v12.events
local functions = v12.functions
local sharedNetworkGlobalFunctions = replicatedStorage:WaitForChild("shared/network@globalFunctions")
local equipInventoryItem = sharedNetworkGlobalFunctions:WaitForChild("equipInventoryItem")
local sellFishItems = sharedNetworkGlobalFunctions:WaitForChild("sellFishItems")
local purchaseShopItem = sharedNetworkGlobalFunctions:WaitForChild("purchaseShopItem")
local performRebirth = sharedNetworkGlobalFunctions:WaitForChild("performRebirth")
local collectPlotMoney = sharedNetworkGlobalFunctions:WaitForChild("collectPlotMoney")
local apexSkillCheckAtom = require(localPlayer.PlayerScripts.TS:WaitForChild("fishing-phase-atom")).apexSkillCheckAtom
local v13 = require(localPlayer.PlayerScripts.TS.reflex.producer)

local function f1()
  local character = localPlayer.Character

  if not character then
    return nil
  end

  return character:FindFirstChild("HumanoidRootPart")
end

local clientProducer = v13.clientProducer
local v14 = require(replicatedStorage.TS.slices["player-data"].selectors)
local selectPlayerInventory = v14.selectPlayerInventory
local selectEquippedInventoryItem = v14.selectEquippedInventoryItem
local v15 = tostring(localPlayer.UserId)
local v16 = selectPlayerInventory(v15)
local v17 = selectEquippedInventoryItem(v15)
local v18 = require(replicatedStorage.TS.data["training-weights"])
local trainingIntervalSeconds = v18.trainingIntervalSeconds
local trainingWeightOrder = v18.trainingWeightOrder
local trainingWeightsData = v18.trainingWeightsData
local v19 = require(replicatedStorage.TS.data.shops)

local function f2()
  local v20 = {}
  local v21, v22 = pcall(function() return v16(clientProducer:getState()) end)

  if v21 and type(v22) == "table" then
    for key, value in pairs(v22) do
      if type(value) == "table" and value.itemType == "trainingWeight" then
        v20[value.itemName] = true
      end
    end
  end

  return v20
end

local weightRebirthRequirements = v19.weightRebirthRequirements
local rodRebirthRequirements = v19.rodRebirthRequirements
local v23 = require(replicatedStorage.TS.data["fishing-rods"])
local fishingRodsData = v23.fishingRodsData

local function f3()
  local v24 = {}
  local v25, v26 = pcall(function() return v16(clientProducer:getState()) end)

  if v25 and type(v26) == "table" then
    for key2, value2 in pairs(v26) do
      if type(value2) == "table" and value2.itemType == "fishingRod" then
        v24[value2.itemName] = true
      end
    end
  end

  return v24
end

local fishingRodOrder = v23.fishingRodOrder
local selectPlayerStat = v14.selectPlayerStat
local selectPlayerRebirthCount = v14.selectPlayerRebirthCount
local v27 = selectPlayerStat(v15, "money")
local v28 = selectPlayerStat(v15, "power")
local v29 = selectPlayerRebirthCount(v15)
local v30, v31

local function f4()
  if v31 then
    return
  end

  v31 = true

  task.spawn(function()
    while v30 do
      local v32, v33 = pcall(function() collectPlotMoney:FireServer(0, v15) end)

      if not v32 then
        warn("[AutoCollect] collectPlotMoney failed: " .. tostring(v33))
      end

      task.wait(5)
    end

    v31 = false
  end)
end

local v34 = require(replicatedStorage.TS.data["rebirth-utils"])
local connect

local function f5()
  if connect then
    connect:disconnect()
  end

  connect = events.hookQteMutationRolled:connect(function(p1)
    task.delay(0.05, function() pcall(function() events.hookQteTapResult:fire(true) end) end)
  end)
end

local getRebirthEntry = v34.getRebirthEntry
local isMaxRebirth = v34.isMaxRebirth
local v35 = require(replicatedStorage.TS.data.fish)

local function f6()
  local v36, v37 = pcall(function() return v16(clientProducer:getState()) end)

  if not v36 or type(v37) ~= "table" then
    return nil
  else
    local count = 0

    for key3 in pairs(v37) do
      count = count + 1
    end

    return count
  end
end

local function f7()
  local v38, v39 = pcall(function() return v16(clientProducer:getState()) end)

  if not v38 or type(v39) ~= "table" then
    return nil
  else
    local v40 = {}

    for index, value3 in ipairs(trainingWeightOrder) do
      v40[value3] = index
    end

    local v41 = nil
    local v42 = -1

    for key4, value4 in pairs(v39) do
      if type(value4) == "table" and value4.itemType == "trainingWeight" then
        local v43 = v40[value4.itemName]

        if v43 and v43 > v42 then
          v41 = key4
          v42 = v43
        end
      end
    end

    return v41
  end
end

local fishDataByName = v35.fishDataByName

local function f8()
  local v44, v45 = pcall(function() return v17(clientProducer:getState()) end)

  if v44 and type(v45) == "table" then
    return v45.itemType == "trainingWeight"
  end

  return false
end

local fishMutations = require(replicatedStorage.TS.data.mutations).fishMutations
local v46 = 500
local autoSell = false
local v47 = false
local autoFish = false
local v48 = false
local autoTrain = false
local v49 = false

local function f9(p2)
  if type(p2) ~= "table" then
    warn("[AutoFish] apexSkillCheckAtom state is not a table, structure unexpected: "
      .. tostring(p2))

    return false
  end

  print("[AutoFish][DEBUG] apexState content:")

  for key5, value5 in pairs(p2) do
    print("  " .. tostring(key5) .. " = " .. tostring(value5))
  end

  if type(p2.onComplete) ~= "function" then
    warn("[AutoFish] apexState.onComplete is not a function, cannot auto-resolve boss")
    return false
  else
    task.wait(1)
    local v50, v51 = pcall(function() p2.onComplete(true) end)

    if not v50 then
      warn("[AutoFish] onComplete call failed: " .. tostring(v51))
      return false
    end

    return true
  end
end

local f10

local function f11()
  local v52 = f1()
  local v53

  if not v52 then
    warn("[AutoFish] No HumanoidRootPart found")
    task.wait(1)
    return
  else
    local v54 = f6()

    if v54 == nil then
      warn("[AutoFish] Could not read inventory count, retrying")
      task.wait(1)
      return
    else
      v53 = {
        direction = v52.CFrame.LookVector,
        peakBias = 0.35,
        skillCheckStrength = 100,
        startPosition = v52.Position,
        utilizedPowerFraction = 1,
      }

      task.wait(1)
      local v55, v56 = pcall(function() events.castFishingHook:fire(v53) end)

      if not v55 then
        warn("[AutoFish] castFishingHook failed: " .. tostring(v56))
        task.wait(1)
        return
      end

      if f10(v54) ~= "caught" then
        warn("[AutoFish] No inventory increase within timeout, retrying")
        pcall(function() events.stopFishing:fire() end)
        task.wait(1)
        return
      end

      task.wait(0.2)
      return
    end
  end
end

function f10(p3)
  local v57 = 0
  local v58 = "timeout"

  while v57 < 60 do
    local v59 = f6()

    if v59 ~= nil and p3 ~= nil and v59 > p3 then
      v58 = "caught"
      break
    else
      local v60, v61 = pcall(apexSkillCheckAtom)

      if v60 and v61 ~= nil then
        warn("[AutoFish] Boss fight detected, attempting auto-complete...")
        f9(v61)
        local total = 0

        while total < 180 do
          local v62 = f6()

          if v62 ~= nil and p3 ~= nil and v62 > p3 then
            v58 = "caught"
            break
          else
            local v63, v64 = pcall(apexSkillCheckAtom)

            if v63 and v64 == nil then
              break
            end

            task.wait(0.2)
            total = total + 0.2
          end
        end

        if v58 == "caught" then
          break
        end

        v57 = 0
      end

      task.wait(0.2)
      v57 = v57 + 0.2
    end
  end

  return v58
end

connect = nil

local function f12(p4)
  local v65 = fishDataByName[p4.itemName]

  if not v65 then
    return nil
  else
    local moneyPerSecond = v65.moneyPerSecond or 0

    if type(p4.mutations) == "table" then
      for key6, value6 in pairs(p4.mutations) do
        local v66 = fishMutations[value6]

        if v66 and v66.mutationCashMultiplier then
          moneyPerSecond = moneyPerSecond * v66.mutationCashMultiplier
        end
      end
    end

    return moneyPerSecond
  end
end

local function f13()
  if v48 then
    return
  end

  v48 = true
  f5()

  task.spawn(function()
    while autoFish do
      local v67, v68 = pcall(f11)

      if not v67 then
        warn("[AutoFish] Cycle error: " .. tostring(v68))
        task.wait(1)
      end
    end

    v48 = false
  end)
end

local function f14()
  if f8() then
    return true
  end

  local v69 = f7()

  if not v69 then
    warn("[AutoTrain] No training weight found in inventory")
    return false
  else
    local v70, v71 = pcall(function() equipInventoryItem:FireServer(7, v69) end)

    if not v70 then
      warn("[AutoTrain] equipInventoryItem failed: " .. tostring(v71))
      return false
    end

    task.wait(0.3)
    return true
  end
end

local v72 = false

local function f15()
  if not v49 then
    v49 = true

    task.spawn(function()
      while autoTrain do
        if f14() then
          local v73, v74 = pcall(function() functions.trainingTick() end)

          if not v73 then
            warn("[AutoTrain] trainingTick failed: " .. tostring(v74))
          end
        else
          warn("[AutoTrain] No training weight equipped, equip one manually")
        end

        task.wait(trainingIntervalSeconds)
      end

      v49 = false
    end)
  end

  if not v72 then
    v72 = true

    task.spawn(function()
      while autoTrain do
        if f8() then
          local v75, v76 = pcall(function()
            functions.trainingSkillcheckBonus(10)
            events.analyticsBoostButtonClicked:fire()
          end)

          if not v75 then
            warn("[AutoTrain] trainingSkillcheckBonus failed: " .. tostring(v76))
          end
        end

        task.wait(1)
      end

      v72 = false
    end)
  end
end

local f16

local function f17()
  if v47 then
    return
  end

  v47 = true

  task.spawn(function()
    while autoSell do
      f16()
      task.wait(5)
    end

    v47 = false
  end)
end

function f16()
  local v77, v78 = pcall(function() return v16(clientProducer:getState()) end)

  if not v77 or type(v78) ~= "table" then
    warn("[AutoSell] Failed to read inventory")
    return
  end

  local v79 = {}

  for key7, value7 in pairs(v78) do
    if type(value7) == "table" and value7.itemType == "fish" then
      local v80 = f12(value7)

      if v80 ~= nil and v80 < v46 then
        table.insert(v79, key7)
      end
    end
  end

  if #v79 == 0 then
    print("[AutoSell] Nothing to sell")
    return
  else
    local v81, v82 = pcall(function() sellFishItems:FireServer(0, v79) end)

    if v81 then
      print("[AutoSell] Sold " .. #v79 .. " fish")
    else
      warn("[AutoSell] sellFishItems failed: " .. tostring(v82))
    end

    return
  end
end

local v83 = false
local v84 = false

local function f18()
  local v85 = f2()
  local v86 = 0
  pcall(function() v86 = v27(clientProducer:getState()) or 0 end)
  local v87 = 0
  pcall(function() v87 = v29(clientProducer:getState()) or 0 end)

  for index2, value8 in ipairs(trainingWeightOrder) do
    local v88 = value8

    if not v85[v88] then
      if index2 > 1 and not v85[trainingWeightOrder[index2 - 1]] then
        return
      else
        local v89 = trainingWeightsData[v88]

        if not v89 then
          warn("[AutoShop] No data for weight " .. tostring(v88))
          return
        else
          local v90 = weightRebirthRequirements[v88]

          if v90 and v87 < v90 then
            warn("[AutoShop] Rebirth requirement not met for " .. v88 .. " (need "
              .. tostring(v90) .. ", have " .. v87 .. ")")

            return
          elseif v86 < v89.price then
            return
          else
            local v91, v92 = pcall(function()
              purchaseShopItem:FireServer(0, "weightsShop", v88)
            end)

            if v91 then
              print("[AutoShop] Purchased " .. v88)
            else
              warn("[AutoShop] purchaseShopItem failed: " .. tostring(v92))
            end

            return
          end
        end
      end
    end
  end

  print("[AutoShop] All weights owned")
end

local function f19()
  if v84 then
    return
  end

  v84 = true

  task.spawn(function()
    while v83 do
      f18()
      task.wait(2)
    end

    v84 = false
  end)
end

local v93 = false
local v94 = false
local v95 = false
local v96 = false

local function f20()
  if v96 then
    return
  end

  v96 = true

  task.spawn(function()
    while v95 do
      local v97, v98 = pcall(function() functions.equipBestAquariumFish(10) end)

      if not v97 then
        warn("[AutoEquipBest] equipBestAquariumFish failed: " .. tostring(v98))
      end

      task.wait(10)
    end

    v96 = false
  end)
end

local function f21()
  local v99 = f3()
  local v100 = 0
  pcall(function() v100 = v27(clientProducer:getState()) or 0 end)
  local v101 = 0
  pcall(function() v101 = v29(clientProducer:getState()) or 0 end)

  for index3, value9 in ipairs(fishingRodOrder) do
    local v102 = value9

    if not v99[v102] then
      if index3 > 1 and not v99[fishingRodOrder[index3 - 1]] then
        return
      else
        local v103 = fishingRodsData[v102]

        if not v103 then
          warn("[AutoShop] No data for rod " .. tostring(v102))
          return
        else
          local v104 = rodRebirthRequirements[v102]

          if v104 and v101 < v104 then
            warn("[AutoShop] Rebirth requirement not met for " .. v102 .. " (need "
              .. tostring(v104) .. ", have " .. v101 .. ")")

            return
          elseif v100 < v103.price then
            return
          else
            local v105, v106 = pcall(function()
              purchaseShopItem:FireServer(0, "rodsShop", v102)
            end)

            if v105 then
              print("[AutoShop] Purchased " .. v102)
            else
              warn("[AutoShop] purchaseShopItem failed: " .. tostring(v106))
            end

            return
          end
        end
      end
    end
  end

  print("[AutoShop] All rods owned")
end

local function f22()
  if v94 then
    return
  end

  v94 = true

  task.spawn(function()
    while v93 do
      f21()
      task.wait(2)
    end

    v94 = false
  end)
end

local autoRebirth = false
local v107 = false
local f23

local function f24()
  if v107 then
    return
  end

  v107 = true

  task.spawn(function()
    while autoRebirth do
      f23()
      task.wait(5)
    end

    v107 = false
  end)
end

function f23()
  local v108 = 0
  pcall(function() v108 = v29(clientProducer:getState()) or 0 end)
  local v109

  if isMaxRebirth(v108) then
    return
  else
    local v110 = getRebirthEntry(v108)

    if not v110 or not v110.powerCost then
      warn("[AutoRebirth] Could not get rebirth entry for count " .. v108)
      return
    end

    v109 = 0
    pcall(function() v109 = v28(clientProducer:getState()) or 0 end)

    if v109 < v110.powerCost then
      return
    else
      local v111, v112 = pcall(function() performRebirth:FireServer(0) end)

      if v111 then
        print("[AutoRebirth] Rebirth triggered (count was " .. v108 .. ")")
      else
        warn("[AutoRebirth] performRebirth failed: " .. tostring(v112))
      end

      return
    end
  end
end

v30 = false
v31 = false

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:SetScriptName("Be A Fish Bait")
rayVoid:ShowCredit()

local mainTab = rayVoid:CreateWindow({
  Name = "Be A Fish Bait",
  ConfigurationSaving = { Enabled = true, FileName = "BeAFishBait" },
}):CreateTab("Main")

mainTab:CreateToggle({
  Name = "Auto Fish",
  CurrentValue = false,
  Flag = "AutoFishToggle",
  Callback = function(value10)
    autoFish = value10

    if autoFish then
      f13()
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Train",
  CurrentValue = false,
  Flag = "AutoTrainToggle",
  Callback = function(value11)
    autoTrain = value11

    if autoTrain then
      f15()
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Equip Best Fish",
  CurrentValue = false,
  Flag = "AutoEquipBestToggle",
  Callback = function(value12)
    v95 = value12

    if v95 then
      f20()
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Rebirth",
  CurrentValue = false,
  Flag = "AutoRebirthToggle",
  Callback = function(value13)
    autoRebirth = value13

    if autoRebirth then
      f24()
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Collect Plot Money",
  CurrentValue = false,
  Flag = "AutoCollectToggle",
  Callback = function(value14)
    v30 = value14

    if v30 then
      f4()
    end
  end,
})

mainTab:CreateButton({
  Name = "Equip Best Fish",
  Callback = function() pcall(function() functions.equipBestAquariumFish(10) end) end,
})

mainTab:CreateToggle({
  Name = "Auto Buy Weights",
  CurrentValue = false,
  Flag = "AutoShopToggle",
  Callback = function(value15)
    v83 = value15

    if v83 then
      f19()
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Buy Rods",
  CurrentValue = false,
  Flag = "AutoRodShopToggle",
  Callback = function(value16)
    v93 = value16

    if v93 then
      f22()
    end
  end,
})

mainTab:CreateInput({
  Name = "Min Income to Keep",
  PlaceholderText = tostring(v46),
  RemoveTextAfterFocusLost = false,
  Callback = function(value17)
    local v113 = tonumber(value17)

    if v113 then
      v46 = v113
      print("[AutoSell] Threshold set to " .. v113)
    else
      warn("[AutoSell] Invalid number: " .. tostring(value17))
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Sell",
  CurrentValue = false,
  Flag = "AutoSellToggle",
  Callback = function(value18)
    autoSell = value18

    if autoSell then
      f17()
    end
  end,
})

mainTab:CreateButton({ Name = "Sell Low Income Fish", Callback = function() f16() end })
