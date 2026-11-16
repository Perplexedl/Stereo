local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "Squn2XMk" / (14174129 - "HUd5j" ^ 16616444) end) })[2]
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
          pcall(function() return "8Y" / (11572066 - "JFN" ^ 8879375) end),
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

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:MainCredit()
rayVoid:SetScriptName("Blow-up-Lucky-Blocks-For-Cars")

local window = rayVoid:CreateWindow({
  Name = "Blow-up-Lucky-Blocks-For-Cars | AKkiwi HUB",
  LoadingTitle = "Blow-up-Lucky-Blocks-For-Cars Script",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "Blow-up-Lucky-Blocks-For-Cars" },
})

local v12 = game

local function f1(p1, p2)
  if p1.isPercent ~= p2.isPercent then
    return p1.isPercent
  end

  return p1.value > p2.value
end

local players = v12:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local v13 = game

local function f2(p3)
  local floors = p3:FindFirstChild("Floors")

  if not floors then
    return nil
  end

  for index, value in ipairs(floors:GetChildren()) do
    for index2, value2 in ipairs(value:GetChildren()) do
      if value2.Name:match("^CarPlot") then
        local placedBlock = value2:FindFirstChild("PlacedBlock")

        local placedCar = placedBlock
        placedCar = placedBlock or value2:FindFirstChild("PlacedCar")

        local buySlotPrice = value2:GetAttribute("BuySlotPrice")
        local v14 = buySlotPrice ~= nil and buySlotPrice == 0

        if not placedCar and v14 then
          local carLocation = value2:FindFirstChild("CarLocation")

          local place = carLocation
          place = carLocation and carLocation:FindFirstChild("Place")

          if place then
            return carLocation, place
          end
        end
      end
    end
  end

  return nil
end

local collectionService = v13:GetService("CollectionService")
local localPlayer = players.LocalPlayer
local gameRemotes = replicatedStorage:WaitForChild("GameRemotes")
local crateBuy = gameRemotes:WaitForChild("Crate:Buy")
local confirmAccept = gameRemotes:WaitForChild("Confirm:Accept")
local rebirthDo = gameRemotes:WaitForChild("Rebirth:Do")
local rocketShopBuy = gameRemotes:WaitForChild("RocketShop:Buy")
local rocketShopEquip = gameRemotes:WaitForChild("RocketShop:Equip")
local rocketShopSync = gameRemotes:WaitForChild("RocketShop:Sync")
local wheelSpin = gameRemotes:WaitForChild("Wheel:Spin")
local shared = replicatedStorage:WaitForChild("Shared")
local v15 = require(shared.Config.LuckyBlocks)
local v16 = require(shared.Config.LuckyBlockIcons)
local v17 = require(shared.Config.Mutations)
local v18 = require(shared.Config.Cars)
local v19 = require(shared.Config.Rebirth)

local function f3(p4)
  local carId = p4:GetAttribute("CarId")
  local v20 = v18.percentOf(carId)

  if v20 then
    return { isPercent = true, value = v20 }
  else
    local rarity = p4:GetAttribute("Rarity")
    local level = p4:GetAttribute("Level")
    local mutation = p4:GetAttribute("Mutation")

    return {
      isPercent = false,
      value = v18.cps(rarity, level or 0, carId) * v17.cashMult(mutation),
    }
  end
end

local function f4(p5)
  local floors2 = p5:FindFirstChild("Floors")

  if not floors2 then
    return {}
  else
    local v21 = {}

    for index3, value3 in ipairs(floors2:GetChildren()) do
      local v22 = tonumber(value3.Name:match("^floor(%d+)$"))

      if v22 then
        table.insert(v21, { n = v22, floor = value3 })
      end
    end

    table.sort(v21, function(p6, p7) return p6.n < p7.n end)
    local v23 = {}

    for index4, value4 in ipairs(v21) do
      local v24 = {}

      for index5, value5 in ipairs(value4.floor:GetChildren()) do
        local v25 = tonumber(value5.Name:match("^CarPlot(%d+)$"))

        if v25 then
          table.insert(v24, { n = v25, carPlot = value5 })
        end
      end

      table.sort(v24, function(p8, p9) return p8.n < p9.n end)

      for index6, value6 in ipairs(v24) do
        table.insert(v23, value6.carPlot)
      end
    end

    return v23
  end
end

local v26 = require(shared.Config.Rockets)
local v27 = require(shared.Number)
local v28 = { [v26.DefaultKey] = true }
local defaultKey = v26.DefaultKey

rocketShopSync.OnClientEvent:Connect(function(p10, p11)
  if type(p10) == "table" then
    v28 = p10
  end

  if type(p11) == "string" then
    defaultKey = p11
  end
end)

local function f5()
  return localPlayer.Parent ~= nil
end

rocketShopSync:FireServer()

local function f6()
  for index7, value7 in ipairs(workspace.Plots:GetChildren()) do
    if value7:GetAttribute("Owner") == localPlayer.UserId then
      return value7
    end
  end

  return nil
end

local function f7()
  local leaderstats = localPlayer:FindFirstChild("leaderstats")
  local cash = leaderstats and leaderstats:FindFirstChild("Cash")
  return cash and v27.parse(cash.Value) or 0
end

local v29 = {}

local function f8()
  local v30 = {}

  for index8, value8 in ipairs(v15.Order) do
    local v31 = v15.Tiers[value8]

    if v31 then
      v29[value8] = v31
      table.insert(v30, { Name = value8, Icon = v16.image(value8) })
    end
  end

  table.sort(v30, function(p12, p13)
    return (v29[p12.Name].Price or 0) < (v29[p13.Name].Price or 0)
  end)

  return v30
end

local autoTab = window:CreateTab("Auto", "home")
local shopTab = window:CreateTab("Shop", "shopping-cart")
local mutationsTab = window:CreateTab("Mutations", "zap")
local f9

local function f10(p14, p15)
  if not p14 or not p14.Parent or not p15 or not p15.Parent then
    return false
  else
    local v32 = f9()

    if not v32 then
      return false
    else
      local v33 = pcall(v32, p14, p15, 0)
      task.wait(0.1)
      return v33 and pcall(v32, p14, p15, 1)
    end
  end
end

function f9()
  if typeof(getgenv) == "function" then
    local v34, v35 = pcall(getgenv)

    if v34 and type(v35) == "table" and typeof(v35.firetouchinterest) == "function" then
      return v35.firetouchinterest
    end

    if typeof(firetouchinterest) == "function" then
      return firetouchinterest
    end

    return nil
  end

  if typeof(firetouchinterest) == "function" then
    return firetouchinterest
  end

  return nil
end

local v36 = 0.3

local function f11(p16, p17, p18, p19, p20)
  p16:UnequipTools()
  task.wait(v36)
  p17.CFrame = p18.CFrame + Vector3.new(0, 3, 0)
  task.wait(0.15)

  if p20 then
    p16:EquipTool(p20)
    task.wait(0.1)
  end

  local v37 = false

  if p19.Enabled then
    v37 = pcall(fireproximityprompt, p19, p19.HoldDuration)
    task.wait(p19.HoldDuration + 0.3)
  end

  p16:UnequipTools()
  return v37
end

local function f12()
  local v38 = false
  local count = 0

  local function f13()
    count = count + 1
  end

  local function f14(p21)
    local v39 = {}
    local floors3 = p21:FindFirstChild("Floors")

    if not floors3 then
      return v39
    end

    for index9, value9 in ipairs(floors3:GetChildren()) do
      for index10, value10 in ipairs(value9:GetChildren()) do
        if value10.Name:match("^CarPlot") and value10:FindFirstChild("PlacedCar") then
          local claim = value10:FindFirstChild("Claim")

          if claim then
            table.insert(v39, claim)
          end
        end
      end
    end

    return v39
  end

  local function f15()
    f13()
    local v40 = count

    if not v38 then
      return
    end

    task.spawn(function()
      while v38 and v40 == count and f5() do
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        local v41 = f6()

        if humanoidRootPart and v41 then
          for index11, value11 in ipairs(f14(v41)) do
            if not (v38 and v40 == count) then
              break
            end

            f10(humanoidRootPart, value11)
          end
        end

        task.wait(2)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Collect Cash",
    CurrentValue = false,
    Flag = "AutoCollectCashEnabled",
    Callback = function(value12)
      v38 = value12

      if v38 then
        f15()
      else
        f13()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v38 then
        f15()
      end
    end,
    Stop = function()
      v38 = false
      f13()
    end,
  }
end

local v42 = f12()

local function f16()
  local v43 = false
  local count2 = 0

  local function f17()
    count2 = count2 + 1
  end

  local function f18()
    local backpack = localPlayer:FindFirstChildOfClass("Backpack")

    if not backpack then
      return nil
    end

    for index12, value13 in ipairs(backpack:GetChildren()) do
      if value13:IsA("Tool") and value13:GetAttribute("ItemType") == "LuckyBlock" then
        return value13
      end
    end

    return nil
  end

  local function f19()
    f17()
    local v44 = count2

    if not v43 then
      return
    end

    task.spawn(function()
      while v43 and v44 == count2 and f5() do
        local character2 = localPlayer.Character
        local humanoid = character2 and character2:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
        local v45 = f6()
        local v46 = humanoid and humanoidRootPart2 and v45 and f18() or nil

        if not v46 then
          task.wait(60)
        else
          local v47, v48 = f2(v45)

          if not v47 then
            task.wait(5)
          else
            f11(humanoid, humanoidRootPart2, v47, v48, v46)
          end
        end
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Place Lucky Blocks",
    CurrentValue = false,
    Flag = "AutoPlaceLuckyBlocksEnabled",
    Callback = function(value14)
      v43 = value14

      if v43 then
        f19()
      else
        f17()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v43 then
        f19()
      end
    end,
    Stop = function()
      v43 = false
      f17()
    end,
  }
end

local v49 = f16()

local function f20()
  local v50 = false
  local count3 = 0

  local function f21()
    count3 = count3 + 1
  end

  local function f22(p22)
    for index13, value15 in ipairs(p22:GetDescendants()) do
      if value15:IsA("Model") and value15.Name == "PlacedBlock" then
        return true
      end
    end

    return false
  end

  local function f23()
    local backpack2 = localPlayer:FindFirstChildOfClass("Backpack")

    if not backpack2 then
      return nil
    end

    for index14, value16 in ipairs(backpack2:GetChildren()) do
      if value16:IsA("Tool") and value16:GetAttribute("ItemType") == "Rocket" then
        return value16
      end
    end

    return nil
  end

  local function f24()
    f21()
    local v51 = count3

    if not v50 then
      return
    end

    task.spawn(function()
      while v50 and v51 == count3 and f5() do
        local character3 = localPlayer.Character
        local humanoid2 = character3 and character3:FindFirstChildOfClass("Humanoid")
        local v52 = f6()

        if humanoid2 and v52 and not (v52 and f2(v52) ~= nil) and f22(v52) then
          local tool = character3:FindFirstChildOfClass("Tool")

          if not (tool and tool:GetAttribute("ItemType") == "Rocket") then
            local v53 = f23()

            if v53 then
              humanoid2:EquipTool(v53)
            end
          end
        end

        task.wait(1)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Equip Launcher",
    CurrentValue = false,
    Flag = "AutoEquipLauncherEnabled",
    Callback = function(value17)
      v50 = value17

      if v50 then
        f24()
      else
        f21()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v50 then
        f24()
      end
    end,
    Stop = function()
      v50 = false
      f21()
    end,
  }
end

local v54 = f20()

autoTab:CreateButton({
  Name = "Auto Place Best",
  Callback = function()
    task.spawn(function()
      local v55 = f6()
      local character4 = localPlayer.Character
      local humanoid3 = character4 and character4:FindFirstChildOfClass("Humanoid")
      local humanoidRootPart3 = character4 and character4:FindFirstChild("HumanoidRootPart")

      if not (v55 and humanoid3 and humanoidRootPart3) then
        return
      else
        local v56 = f4(v55)

        for index15, value18 in ipairs(v56) do
          if value18:FindFirstChild("PlacedCar") then
            local carLocation2 = value18:FindFirstChild("CarLocation")

            local remove = carLocation2
            remove = carLocation2 and carLocation2:FindFirstChild("Remove")

            if remove then
              f11(humanoid3, humanoidRootPart3, carLocation2, remove)
            end
          end
        end

        local v57 = {}

        for index16, value19 in ipairs(v56) do
          local buySlotPrice2 = value19:GetAttribute("BuySlotPrice")

          if buySlotPrice2 ~= nil and buySlotPrice2 == 0 then
            local carLocation3 = value19:FindFirstChild("CarLocation")

            local place2 = carLocation3
            place2 = carLocation3 and carLocation3:FindFirstChild("Place")

            if place2 then
              table.insert(v57, { carLocation = carLocation3, prompt = place2 })
            end
          end
        end

        for index17, value20 in ipairs(v57) do
          local backpack3 = localPlayer:FindFirstChildOfClass("Backpack")
          local v58 = nil
          local v59 = nil

          if backpack3 then
            for index18, value21 in ipairs(backpack3:GetChildren()) do
              if value21:IsA("Tool") and value21:GetAttribute("ItemType") == "Car" then
                local v60 = f3(value21)

                if not v58 or f1(v60, v58) then
                  v58 = v60
                  v59 = value21
                end
              end
            end
          end

          if not v59 then
            break
          end

          f11(humanoid3, humanoidRootPart3, value20.carLocation, value20.prompt, v59)
        end

        return
      end
    end)
  end,
})

local v61 = {}

for index19, value22 in ipairs(v17.Order) do
  local v62 = value22

  mutationsTab:CreateToggle({
    Name = v62 .. " (x" .. tostring(v17.Multipliers[v62] or v17.DefaultMultiplier) .. ")",
    CurrentValue = false,
    Flag = "Mutation_" .. v62,
    Callback = function(value23) v61[v62] = value23 or nil end,
  })
end

local function f25()
  local v63 = false
  local count4 = 0
  local v64 = {}

  local function f26()
    count4 = count4 + 1
  end

  local function f27()
    f26()
    local v65 = count4

    if not v63 then
      return
    end

    task.spawn(function()
      while v63 and v65 == count4 and f5() do
        if next(v64) then
          local v66 = f6()

          if v66 then
            local v67 = f7()
            local character5 = localPlayer.Character
            local humanoid4 = character5 and character5:FindFirstChildOfClass("Humanoid")

            for index20, value24 in ipairs(collectionService:GetTagged("ConveyorCrate")) do
              if not (v63 and v65 == count4) then
                break
              elseif value24:IsDescendantOf(v66) then
                local tier = value24:GetAttribute("Tier")
                local v68 = tier and v29[tier]
                local v69 = not next(v61)

                local v70 = v69
                v70 = v69 or v61[value24:GetAttribute("Mutation")]

                if v68 and v64[tier] and v70 and v67 >= (v68.Price or 0) then
                  crateBuy:FireServer(value24)
                  v67 = v67 - (v68.Price or 0)
                  task.wait(0.2)

                  if humanoid4 then
                    humanoid4:UnequipTools()
                  end
                end
              end
            end
          end
        end

        task.wait(1)
      end
    end)
  end

  shopTab:CreateToggle({
    Name = "Auto Buy Lucky Blocks",
    CurrentValue = false,
    Flag = "AutoBuyLuckyBlocksEnabled",
    Callback = function(value25)
      v63 = value25

      if v63 then
        f27()
      else
        f26()
      end
    end,
  })

  shopTab:CreateCardGrid({
    Items = f8(),
    Columns = 3,
    Flag = "AutoBuyLuckyBlockSelection",
    Callback = function(value26) v64 = value26 end,
  })

  return {
    StartFromConfig = function()
      if v63 then
        f27()
      end
    end,
    Stop = function()
      v63 = false
      f26()
    end,
  }
end

local v71 = f25()

local function f28()
  local v72 = false
  local count5 = 0

  local function f29()
    count5 = count5 + 1
  end

  local function f30(p23)
    local upgrades = p23:FindFirstChild("Upgrades")
    local upgradeluck = upgrades and upgrades:FindFirstChild("upgradeluck")
    local buy = upgradeluck and upgradeluck:FindFirstChild("buy")
    local cost = buy and buy:FindFirstChild("cost")
    local frame = cost and cost:FindFirstChild("Frame")

    local name = frame
    name = frame and frame:FindFirstChild("Name")

    local v73 = not buy
    local v74 = name

    if v73 or not v74 then
      return nil, nil
    end

    return buy, v27.parse(v74.Text)
  end

  local function f31()
    f29()
    local v75 = count5

    if not v72 then
      return
    end

    task.spawn(function()
      while v72 and v75 == count5 and f5() do
        local v76 = f6()
        local character6 = localPlayer.Character
        local humanoidRootPart4 = character6 and character6:FindFirstChild("HumanoidRootPart")

        if v76 and humanoidRootPart4 then
          local v77, v78 = f30(v76)

          if v77 and v78 and f7() >= v78 then
            f10(humanoidRootPart4, v77)
            task.wait(0.5)
            confirmAccept:FireServer()
          end
        end

        task.wait(2)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Upgrade Conveyor Luck",
    CurrentValue = false,
    Flag = "AutoUpgradeConveyorLuckEnabled",
    Callback = function(value27)
      v72 = value27

      if v72 then
        f31()
      else
        f29()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v72 then
        f31()
      end
    end,
    Stop = function()
      v72 = false
      f29()
    end,
  }
end

local v79 = f28()

local function f32()
  local v80 = false
  local count6 = 0

  local function f33()
    count6 = count6 + 1
  end

  local function f34()
    f33()
    local v81 = count6

    if not v80 then
      return
    end

    task.spawn(function()
      while v80 and v81 == count6 and f5() do
        local v82 = f7()

        for index21, value28 in ipairs(v26.Order) do
          if not (v80 and v81 == count6) then
            break
          else
            local v83 = v26.Items[value28]

            if v83 and v83.Price > 0 and not v28[value28] and v82 >= v83.Price then
              rocketShopBuy:FireServer(value28)
              v82 = v82 - v83.Price
              task.wait(0.2)
            end
          end
        end

        task.wait(2)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Buy Launchers",
    CurrentValue = false,
    Flag = "AutoBuyLaunchersEnabled",
    Callback = function(value29)
      v80 = value29

      if v80 then
        f34()
      else
        f33()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v80 then
        f34()
      end
    end,
    Stop = function()
      v80 = false
      f33()
    end,
  }
end

local v84 = f32()

local function f35()
  local v85 = false
  local count7 = 0

  local function f36()
    count7 = count7 + 1
  end

  local function f37()
    local damage = -1
    local v86

    for key, value30 in pairs(v28) do
      if value30 then
        local v87 = v26.Items[key]

        if v87 and (v87.Damage or 0) > damage then
          damage = v87.Damage
          v86 = key
        end
      end
    end

    return v86
  end

  local function f38()
    f36()
    local v88 = count7

    if not v85 then
      return
    end

    task.spawn(function()
      while v85 and v88 == count7 and f5() do
        local v89 = f37()

        if v89 and v89 ~= defaultKey then
          rocketShopEquip:FireServer(v89)
        end

        task.wait(2)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Equip Best Launcher",
    CurrentValue = false,
    Flag = "AutoEquipBestLauncherEnabled",
    Callback = function(value31)
      v85 = value31

      if v85 then
        f38()
      else
        f36()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v85 then
        f38()
      end
    end,
    Stop = function()
      v85 = false
      f36()
    end,
  }
end

local v90 = f35()

local function f39()
  local v91 = false
  local count8 = 0

  local function f40()
    count8 = count8 + 1
  end

  local function f41()
    local leaderstats2 = localPlayer:FindFirstChild("leaderstats")
    local rebirths = leaderstats2 and leaderstats2:FindFirstChild("Rebirths")
    return rebirths and rebirths.Value or 0
  end

  local function f42()
    f40()
    local v92 = count8

    if not v91 then
      return
    end

    task.spawn(function()
      while v91 and v92 == count8 and f5() do
        local v93 = v19.cost(f41())

        if f7() >= v93 then
          rebirthDo:FireServer()
          task.wait(3)
        else
          task.wait(2)
        end
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirthEnabled",
    Callback = function(value32)
      v91 = value32

      if v91 then
        f42()
      else
        f40()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v91 then
        f42()
      end
    end,
    Stop = function()
      v91 = false
      f40()
    end,
  }
end

local v94 = f39()

local function f43()
  local v95 = false
  local count9 = 0

  local function f44()
    count9 = count9 + 1
  end

  local function f45()
    f44()
    local v96 = count9

    if not v95 then
      return
    end

    task.spawn(function()
      while v95 and v96 == count9 and f5() do
        wheelSpin:FireServer()
        task.wait(300)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Spin Wheel",
    CurrentValue = false,
    Flag = "AutoSpinWheelEnabled",
    Callback = function(value33)
      v95 = value33

      if v95 then
        f45()
      else
        f44()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v95 then
        f45()
      end
    end,
    Stop = function()
      v95 = false
      f44()
    end,
  }
end

local v97 = f43()
v42.StartFromConfig()
v54.StartFromConfig()
v49.StartFromConfig()
v71.StartFromConfig()
v79.StartFromConfig()
v84.StartFromConfig()
v90.StartFromConfig()
v94.StartFromConfig()
v97.StartFromConfig()
