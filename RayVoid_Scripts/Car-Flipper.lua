local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)

local v3 = ({
  pcall(function() return "iVCPTswOCkqmP" / (4798611 - "bMSb53mKd6Bf" ^ 11640164) end),
})[2]

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
          pcall(function() return "aBiG39Bcb" / (3400808 - "w1JOSmU7tj4L42P" ^ 12484990) end),
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

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:ShowCredit()
rayVoid:MainCredit()
rayVoid:SetScriptName("Car-Flipper")

local window = rayVoid:CreateWindow({
  Name = "Car-Flipper | AKkiwi HUB",
  LoadingTitle = "Car-Flipper Script",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "Car-Flipper" },
})

local automationTab = window:CreateTab("Automation")

local v12 = {
  worldReady = false,
  PlayerData = nil,
  CarsData = nil,
  RarityData = nil,
  CarModule = nil,
  Const = nil,
  FixCar = nil,
  SellCar = nil,
  BuyCar = nil,
  DefaultCarId = nil,
  targetRarities = {},
  singleCarMode = false,
  rarityThrottle = false,
  PlayerBase = nil,
  ResourceBoxPrompt = nil,
  CashBoxPrompt = nil,
  FireProximityPrompt = nil,
  TuningForParts = nil,
  targetTuningTiers = {},
  targetSellRarities = {
    Common = true,
    Uncommon = true,
    Rare = true,
    Epic = true,
    Legendary = true,
    Mythical = true,
  },
  autoRepair = false,
  autoRepairLoop = false,
  autoSell = false,
  autoSellLoop = false,
  autoBuy = false,
  autoBuyLoop = false,
  autoCollect = false,
  autoCollectLoop = false,
  autoTuning = false,
  autoTuningLoop = false,
}

local v13 = {
  {
    productId = 3604163369,
    partsName = "Common",
    partsAmount = 1000,
    robux = 29,
  },
  {
    productId = 3558166522,
    partsName = "Uncommon",
    partsAmount = 1000,
    robux = 49,
  },
  {
    productId = 3558166704,
    partsName = "Rare",
    partsAmount = 1000,
    robux = 99,
  },
  {
    productId = 3558166907,
    partsName = "Epic",
    partsAmount = 1000,
    robux = 299,
  },
  {
    productId = 3558167063,
    partsName = "Legendary",
    partsAmount = 1000,
    robux = 499,
  },
  {
    productId = 3606819701,
    partsName = "Mythical",
    partsAmount = 1000,
    robux = 699,
  },
}

local v14 = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical" }
local f1

automationTab:CreateToggle({
  Name = "Auto Repair (all cars)",
  CurrentValue = false,
  Flag = "CarFlipper_AutoRepair",
  Callback = function(value)
    v12.autoRepair = value

    if value and not v12.autoRepairLoop and v12.worldReady then
      v12.autoRepairLoop = true
      task.spawn(f1)
    end
  end,
})

local f2

automationTab:CreateToggle({
  Name = "Auto Sell (except favorites/default)",
  CurrentValue = false,
  Flag = "CarFlipper_AutoSell",
  Callback = function(value2)
    v12.autoSell = value2

    if value2 and not v12.autoSellLoop and v12.worldReady then
      v12.autoSellLoop = true
      task.spawn(f2)
    end
  end,
})

automationTab:CreateDropdown({
  Name = "Rarities to sell",
  Options = v14,
  CurrentOption = v14,
  MultipleOptions = true,
  Flag = "CarFlipper_SellRarities",
  Callback = function(value3)
    local v15 = {}

    for index, value4 in ipairs(value3) do
      v15[value4] = true
    end

    v12.targetSellRarities = v15
  end,
})

local f3

automationTab:CreateToggle({
  Name = "Auto Buy (targeted rarities)",
  CurrentValue = false,
  Flag = "CarFlipper_AutoBuy",
  Callback = function(value5)
    v12.autoBuy = value5

    if value5 and not v12.autoBuyLoop and v12.worldReady then
      v12.autoBuyLoop = true
      task.spawn(f3)
    end
  end,
})

automationTab:CreateDropdown({
  Name = "Rarities to buy",
  Options = v14,
  CurrentOption = {},
  MultipleOptions = true,
  Flag = "CarFlipper_TargetRarities",
  Callback = function(value6)
    local v16 = {}

    for index2, value7 in ipairs(value6) do
      v16[value7] = true
    end

    v12.targetRarities = v16
  end,
})

automationTab:CreateToggle({
  Name = "Single Car Mode (only 1 car total, index 1 excluded)",
  CurrentValue = false,
  Flag = "CarFlipper_SingleCarMode",
  Callback = function(value8) v12.singleCarMode = value8 end,
})

automationTab:CreateToggle({
  Name = "Rarity Throttle (1 in-flight car per rarity)",
  CurrentValue = false,
  Flag = "CarFlipper_RarityThrottle",
  Callback = function(value9) v12.rarityThrottle = value9 end,
})

local f4

automationTab:CreateToggle({
  Name = "Auto Collect (Resource Box)",
  CurrentValue = false,
  Flag = "CarFlipper_AutoCollect",
  Callback = function(value10)
    v12.autoCollect = value10

    if value10 and not v12.autoCollectLoop and v12.worldReady then
      v12.autoCollectLoop = true
      task.spawn(f4)
    end
  end,
})

local tuningShopTab = window:CreateTab("Tuning Shop")
local f5

tuningShopTab:CreateToggle({
  Name = "Auto Buy Tuning Kits",
  CurrentValue = false,
  Flag = "CarFlipper_AutoTuning",
  Callback = function(value11)
    v12.autoTuning = value11

    if value11 and not v12.autoTuningLoop and v12.worldReady then
      v12.autoTuningLoop = true
      task.spawn(f5)
    end
  end,
})

tuningShopTab:CreateDivider()

for index3, value12 in ipairs(v13) do
  local v17 = value12

  tuningShopTab:CreateToggle({
    Name = string.format("%s (%d parts)", v17.partsName, v17.partsAmount),
    CurrentValue = false,
    Flag = "CarFlipper_TuningTier_" .. v17.partsName,
    Callback = function(value13) v12.targetTuningTiers[v17.productId] = value13 or nil end,
  })
end

task.spawn(function()
  local v18, v19 = pcall(function()
    local v20 = require(localPlayer.PlayerGui:WaitForChild("RuntimeGui", 15):WaitForChild("Gui"))

    assert(
      debug and debug.getupvalue,
      "executor has no debug.getupvalue - cannot retrieve PlayerData"
    )

    local v21 = debug.getupvalue(v20.update, 4)

    assert(
      type(v21) == "table" and v21.cars ~= nil,
      "upvalue #4 doesn't match PlayerData (the game may have updated)"
    )

    v12.PlayerData = v21
    v12.CarsData = require(replicatedStorage:WaitForChild("CarsData"))
    v12.RarityData = require(replicatedStorage:WaitForChild("RarityData"))
    v12.CarModule = require(replicatedStorage:WaitForChild("CarModule"))
    v12.Const = require(replicatedStorage:WaitForChild("Config"):WaitForChild("Const"))
    v12.DefaultCarId = v12.Const.DEFFAULT_CAR_ID

    local remotes = replicatedStorage:WaitForChild("Remotes")

    v12.FixCar = remotes:WaitForChild("Repair"):WaitForChild("FixCar")
    v12.SellCar = remotes:WaitForChild("Garage"):WaitForChild("SellCar")
    v12.BuyCar = remotes:WaitForChild("Merchant"):WaitForChild("BuyCar")
    v12.TuningForParts = remotes:WaitForChild("TuningShop"):WaitForChild("TuningForParts")

    v12.PlayerBase = workspace:WaitForChild("PlayerBases", 15):WaitForChild("base_"
      .. tostring(localPlayer.UserId), 15)

    v12.ResourceBoxPrompt = v12.PlayerBase:WaitForChild("ResourceBox", 15):WaitForChild(
      "Box", 15
    ):WaitForChild(
      "CollectPrompt", 15
    )

    v12.CashBoxPrompt = v12.PlayerBase:WaitForChild("CashBox", 15):WaitForChild("Box", 15):WaitForChild(
      "CollectPrompt", 15
    )
  end)

  if not v18 then
    warn("[Car-Flipper] World resolution failed: " .. tostring(v19))
    return
  end

  v12.worldReady = true

  if typeof(fireproximityprompt) == "function" then
    v12.FireProximityPrompt = fireproximityprompt
  else
    local v22 = rawget(_G, "getgenv")

    if v22 then
      local v23, v24 = pcall(v22)

      if v23 and v24 and typeof(v24.fireproximityprompt) == "function" then
        v12.FireProximityPrompt = v24.fireproximityprompt
      end
    end
  end

  if not v12.FireProximityPrompt then
    warn("[Car-Flipper] fireproximityprompt unavailable on this executor - Auto Collect will not work")
  end

  if v12.autoRepair and not v12.autoRepairLoop then
    v12.autoRepairLoop = true
    task.spawn(f1)
  end

  if v12.autoSell and not v12.autoSellLoop then
    v12.autoSellLoop = true
    task.spawn(f2)
  end

  if v12.autoBuy and not v12.autoBuyLoop then
    v12.autoBuyLoop = true
    task.spawn(f3)
  end

  if v12.autoCollect and not v12.autoCollectLoop then
    v12.autoCollectLoop = true
    task.spawn(f4)
  end

  if v12.autoTuning and not v12.autoTuningLoop then
    v12.autoTuningLoop = true
    task.spawn(f5)
  end
end)

local function f6(p1)
  local v25 = v12.CarsData[p1]

  if not v25 then
    return nil
  else
    local v26 = v12.RarityData[v25.rarity]

    if not v26 then
      return nil
    end

    return v26.name
  end
end

local function f7()
  local count = 0

  for key in pairs(v12.PlayerData.cars) do
    if key ~= "1" then
      count = count + 1
    end
  end

  return count
end

local function f8()
  local baseData = v12.PlayerData.baseData
  return baseData and baseData.values and baseData.values.GarageSize or nil
end

local function f9()
  local count2 = 0

  for key2 in pairs(v12.PlayerData.cars) do
    count2 = count2 + 1
  end

  return count2
end

local function f10(p2)
  return v12.PlayerData.inventory.resources[p2] or 0
end

local function f11()
  local v27 = {}

  for key3, value14 in pairs(v12.PlayerData.cars) do
    if key3 ~= "1" then
      local v28 = f6(value14.carId)

      if v28 then
        v27[v28] = true
      end
    end
  end

  return v27
end

local function f12(p3, p4)
  if not p3 or not p3.Enabled then
    return
  else
    local parent = p3.Parent

    if not parent or not parent:IsA("BasePart") then
      warn("[Car-Flipper] CollectPrompt.Parent is not a BasePart, cannot compute distance")
      return
    end

    if (p4.Position - parent.Position).Magnitude > p3.MaxActivationDistance then
      p4.CFrame = CFrame.new(parent.Position)
      task.wait(0.15)
    end

    if not pcall(function() v12.FireProximityPrompt(p3) end) then
      warn("[Car-Flipper] fireproximityprompt failed on " .. parent:GetFullName())
    end

    return
  end
end

function f1()
  while v12.autoRepair do
    local v29 = false

    for key4, value15 in pairs(v12.PlayerData.cars) do
      local v30 = key4

      if not v12.autoRepair then
        break
      end

      if value15.health ~= nil and value15.health < 1 then
        local v31 = f6(value15.carId)

        if v31 then
          local v32, v33 = pcall(v12.CarModule.calculatePartsForFix, value15)

          if v32 and type(v33) == "number" then
            if f10(v31) >= v33 then
              if pcall(function() v12.FixCar:FireServer(v30) end) then
                v29 = true
              else
                warn("[Car-Flipper] FireServer FixCar failed for car " .. tostring(v30))
              end
            end
          else
            warn("[Car-Flipper] calculatePartsForFix failed for car " .. tostring(v30))
          end
        end
      end
    end

    if v29 then
      task.wait(0.35)
    else
      task.wait(1.5)
    end
  end

  v12.autoRepairLoop = false
end

function f2()
  while v12.autoSell do
    local v34 = false

    for key5, value16 in pairs(v12.PlayerData.cars) do
      local v35 = key5

      if not v12.autoSell then
        break
      else
        local v36 = v35 ~= "1" and value16.health ~= nil and value16.health >= 1
          and value16.isFavorite ~= true and value16.carId ~= v12.DefaultCarId

        if v36 then
          local v37 = f6(value16.carId)
          v36 = v37 ~= nil and v12.targetSellRarities[v37] == true
        end

        if v36 then
          if pcall(function() v12.SellCar:FireServer(v35) end) then
            v34 = true
          else
            warn("[Car-Flipper] FireServer SellCar failed for car " .. tostring(v35))
          end
        end
      end
    end

    if v34 then
      task.wait(0.35)
    else
      task.wait(1.5)
    end
  end

  v12.autoSellLoop = false
end

function f3()
  while v12.autoBuy do
    local v38 = false
    local money = v12.PlayerData.money
    local v39 = f8()
    local v40 = f9()
    local v41 = f7()
    local v42 = f11()

    for key6, value17 in pairs(v12.PlayerData.merchants) do
      local v43 = key6

      if not v12.autoBuy then
        break
      end

      for key7, value18 in pairs(value17) do
        local v44 = key7

        if not v12.autoBuy then
          break
        else
          local carId = value18.carData and value18.carData.carId
          local v45 = carId and f6(carId)
          local v46 = v39 ~= nil and v40 >= v39
          local singleCarMode = v12.singleCarMode and v41 >= 1
          local rarityThrottle = v12.rarityThrottle and v45 ~= nil and v42[v45] == true

          if not v46 and not singleCarMode and not rarityThrottle and v45
            and v12.targetRarities[v45] and value18.price and value18.price <= money then
            if pcall(function() v12.BuyCar:FireServer(v43, v44) end) then
              v38 = true
              money = money - value18.price
              v40 = v40 + 1
              v41 = v41 + 1
              v42[v45] = true
            else
              warn("[Car-Flipper] FireServer BuyCar failed for " .. tostring(v43) .. "/"
                .. tostring(v44))
            end
          end
        end
      end
    end

    if v38 then
      task.wait(0.35)
    else
      task.wait(1.5)
    end
  end

  v12.autoBuyLoop = false
end

function f4()
  while v12.autoCollect do
    if v12.FireProximityPrompt then
      local character = localPlayer.Character
      local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart then
        local cframe = humanoidRootPart.CFrame

        f12(v12.ResourceBoxPrompt, humanoidRootPart)
        f12(v12.CashBoxPrompt, humanoidRootPart)

        if humanoidRootPart.CFrame ~= cframe then
          task.wait(0.15)
          humanoidRootPart.CFrame = cframe
        end
      end
    end

    task.wait(300)
  end

  v12.autoCollectLoop = false
end

function f5()
  while v12.autoTuning do
    local v47 = false

    for index4, value19 in ipairs(v13) do
      local v48 = value19

      if not v12.autoTuning then
        break
      elseif v12.targetTuningTiers[v48.productId] then
        if f10(v48.partsName) >= v48.partsAmount then
          if pcall(function() v12.TuningForParts:FireServer(v48.productId) end) then
            v47 = true
          else
            warn("[Car-Flipper] FireServer TuningForParts failed for " .. tostring(v48.productId))
          end
        end
      end
    end

    if v47 then
      task.wait(0.35)
    else
      task.wait(1.5)
    end
  end

  v12.autoTuningLoop = false
end

function _G.CarFlipperUnload()
  v12.autoRepair = false
  v12.autoSell = false
  v12.autoBuy = false
  v12.autoCollect = false
  v12.autoTuning = false
end
