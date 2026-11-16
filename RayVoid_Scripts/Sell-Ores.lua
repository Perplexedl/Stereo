local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "Akt" / (8584454 - "cjMT" ^ 16507896) end) })[2]
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
          pcall(function() return "tiJbc9G7C515" / (7459556 - "V5ay1MtxAuyL9" ^ 10278202) end),
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
local playerGui = localPlayer:WaitForChild("PlayerGui")

local function f1()
  return localPlayer.Parent ~= nil
end

local rollerPurchaseEvent = replicatedStorage:WaitForChild("RollerPurchaseEvent")
local baseBuildTunnelAction = replicatedStorage:WaitForChild("Remotes"):WaitForChild("BaseBuildTunnelAction")

local function f2()
  local assignedBaseName = localPlayer:GetAttribute("AssignedBaseName")

  if type(assignedBaseName) ~= "string" or assignedBaseName == "" then
    return false
  else
    local v12, v13 = pcall(function()
      return baseBuildTunnelAction:InvokeServer(assignedBaseName, 1, "Tunnel1", "EquipBest")
    end)

    return v12 and type(v13) == "table" and v13.success == true
  end
end

local baseUpgradeDrillSpeed = replicatedStorage.Remotes:WaitForChild("BaseUpgradeDrillSpeed")
local baseUpgradeDrillYield = replicatedStorage.Remotes:WaitForChild("BaseUpgradeDrillYield")
local remotes = replicatedStorage.Remotes

local function f3(p1)
  local baseUpgradesBoards = p1:FindFirstChild("BaseUpgradesBoards")

  if not baseUpgradesBoards then
    return {}
  else
    local v14 = {}

    for index, value in ipairs(baseUpgradesBoards:GetChildren()) do
      local v15 = tonumber(value.Name:match("^BaseUpgradesBoardFloor(%d+)$"))

      if v15 then
        table.insert(v14, v15)
      end
    end

    table.sort(v14)
    return v14
  end
end

local baseUpgradeOreRegenSpeed = remotes:WaitForChild("BaseUpgradeOreRegenSpeed")
local rollerUpgradePedestal = replicatedStorage:WaitForChild("RollerUpgradePedestal")
local rollerUpgradeOreLuck = replicatedStorage:WaitForChild("RollerUpgradeOreLuck")
local v16 = { 2000, 15000, 100000, 1000000, 25000000 }
local v17 = require(replicatedStorage:WaitForChild("OreLuckConfig"))
local baseBuildPurchaseFloor = replicatedStorage.Remotes:WaitForChild("BaseBuildPurchaseFloor")

local function f4(p2)
  local v18, v19 = pcall(function()
    return baseBuildPurchaseFloor:InvokeServer("GetFloorPrice", p2)
  end)

  if v18 and type(v19) == "table" and v19.success == true and type(v19.price) == "number" then
    return v19.price
  end

  return nil
end

local baseBuildPurchaseTunnel = replicatedStorage.Remotes:WaitForChild("BaseBuildPurchaseTunnel")

local function f5(p3)
  local floors = p3:FindFirstChild("Floors")

  if not floors then
    return {}
  else
    local v20 = {}

    for index2, value2 in ipairs(floors:GetChildren()) do
      if value2:IsA("Model") then
        for index3, value3 in ipairs(value2:GetChildren()) do
          local purchaseModel = value3:FindFirstChild("PurchaseModel")

          if purchaseModel then
            table.insert(v20, purchaseModel)
          end
        end
      end
    end

    return v20
  end
end

local baseCrateAction = replicatedStorage.Remotes:WaitForChild("BaseCrateAction")
local v21 = require(replicatedStorage:WaitForChild("FurnaceConfig"))

local function f6(p4)
  local v22, v23 = pcall(function() return baseCrateAction:InvokeServer(p4, "GetState") end)

  if v22 and type(v23) == "table" and v23.success == true and type(v23.result) == "table" then
    return v23.result.Furnace
  end

  return nil
end

local requestGearPurchase = replicatedStorage.Remotes:WaitForChild("RequestGearPurchase")
local v24 = require(replicatedStorage:WaitForChild("GearMetadata"))
local v25 = {}

local function f7()
  local v26, v27 = pcall(function() return v24.List() end)

  if not v26 or type(v27) ~= "table" then
    warn("Sell-Ores: GearMetadata.List() unavailable, GearShop empty")
    return {}
  else
    table.sort(v27, function(p5, p6) return (p5.Price or 0) < (p6.Price or 0) end)
    local v28 = {}

    for index4, value4 in ipairs(v27) do
      v25[value4.DisplayName] = value4
      local displayName = value4.DisplayName
      table.insert(v28, { Name = displayName, Icon = value4.Icon or "" })
    end

    return v28
  end
end

local requestLuckyBlockPurchase = replicatedStorage.Remotes:WaitForChild("RequestLuckyBlockPurchase")

local function f8()
  local v29, v30 = pcall(function()
    local waitForChild = playerGui:WaitForChild("MainFrames", 10):WaitForChild("Frames", 10):WaitForChild(
      "OreIndexPanel", 10
    ):WaitForChild(
      "ScrollingFrame", 10
    )

    local v31 = {}
    local v32 = {}

    for index5, value5 in ipairs(waitForChild:GetChildren()) do
      if value5:IsA("GuiObject") then
        local rarity = value5:FindFirstChild("Rarity")
        value5:FindFirstChild("OreIcon")
        local text = rarity and rarity.Text or "Unknown"

        if not v32[text] then
          v32[text] = {}
          table.insert(v31, text)
        end
      end
    end

    local v33 = {}

    for index6, value6 in ipairs(v31) do
      table.insert(v33, { Label = value6, Items = v32[value6] })
    end

    return v33
  end)

  if not v29 or #v30 == 0 then
    warn("Sell-Ores: OreIndexPanel not found, ore selection empty")
    return {}
  end

  return v30
end

local function f9(p7, p8, p9)
  if not p9 then
    return false
  end

  task.wait(0.1)
  p7.CFrame = CFrame.new(p8)
  task.wait(0.15)

  if not p9.Enabled then
    return false
  else
    local v34 = pcall(function() fireproximityprompt(p9, p9.HoldDuration) end)
    task.wait(p9.HoldDuration + 0.3)
    return v34
  end
end

local function f10(p10)
  local orePedestals = p10:FindFirstChild("OrePedestals")

  if not orePedestals then
    return {}
  else
    local v35 = {}

    for index7, value7 in ipairs(orePedestals:GetChildren()) do
      if value7.Name:match("^RolledOrePedestal") then
        table.insert(v35, value7)
      end
    end

    return v35
  end
end

local function f11()
  local character = localPlayer.Character
  local carriedOreCrateStack = character and character:FindFirstChild("CarriedOreCrateStack")
  return carriedOreCrateStack and #carriedOreCrateStack:GetChildren() or 0
end

local v36 = require(replicatedStorage:WaitForChild("PetMetadata"))

local function f12()
  local bases = workspace:FindFirstChild("Bases")

  if not bases then
    return nil
  end

  for index8, value8 in ipairs(bases:GetChildren()) do
    if value8:GetAttribute("OwnerUserId") == localPlayer.UserId then
      return value8
    end
  end

  return nil
end

local v37 = {}

local function f13()
  local v38, v39 = pcall(function() return v36.ListLuckyBlocks() end)

  if not v38 or type(v39) ~= "table" then
    warn("Sell-Ores: PetMetadata.ListLuckyBlocks() unavailable, PetShop empty")
    return {}
  else
    table.sort(v39, function(p11, p12) return (p11.Price or 0) < (p12.Price or 0) end)
    local v40 = {}

    for index9, value9 in ipairs(v39) do
      v37[value9.DisplayName] = value9
      local displayName2 = value9.DisplayName
      table.insert(v40, { Name = displayName2, Icon = value9.Icon or "" })
    end

    return v40
  end
end

local function f14(p13, p14)
  if not pcall(function() rollerPurchaseEvent:FireServer(p13.Name, p14) end) then
    return false
  else
    local total = 0

    while total < 2 do
      if not p13:FindFirstChild("RolledOreDisplay") then
        return true
      end

      task.wait(0.1)
      total = total + 0.1
    end

    return false
  end
end

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:MainCredit()
rayVoid:SetScriptName("Sell-Ores")

local window = rayVoid:CreateWindow({
  Name = "Sell-Ores | AKkiwi HUB",
  LoadingTitle = "Sell-Ores Script",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "Sell-Ores" },
})

local autoRollTab = window:CreateTab("AutoRoll")
local autoUpgradesTab = window:CreateTab("AutoUpgrades")
local autoTab = window:CreateTab("Auto")
local gearShopTab = window:CreateTab("GearShop")
local petShopTab = window:CreateTab("PetShop")
local miscTab = window:CreateTab("Misc")

local function f15()
  local v41 = false
  local count = 0
  local v42 = {}

  local function f16()
    count = count + 1
  end

  local function f17(p15)
    local rolledOreDisplay = p15:FindFirstChild("RolledOreDisplay")

    if not rolledOreDisplay then
      return false
    else
      local oreName = rolledOreDisplay:GetAttribute("OreName")

      if not oreName or not v42[oreName] then
        return false
      else
        local v43 = f14(p15, oreName)

        if v43 then
          rayVoid:Notify({
            Title = "Auto Roll",
            Message = "Bought: " .. oreName,
            Type = "success",
            Duration = 2,
          })
        end

        return v43
      end
    end
  end

  local function f18(p16)
    local v44 = f12()

    if not v44 then
      return
    else
      local character2 = localPlayer.Character
      local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart then
        return
      else
        local roller = v44:FindFirstChild("Roller")
        local lever = roller and roller:FindFirstChild("Lever")

        local proximityPrompt = lever
        proximityPrompt = lever and lever:FindFirstChild("ProximityPrompt")

        local v45 = not lever
        local v46 = proximityPrompt

        if v45 or not v46 then
          return
        else
          f9(humanoidRootPart, lever.Position, v46)
          local v47 = f10(v44)
          local total2 = 0

          while total2 < 8 and p16 == count do
            local v48 = false

            for index10, value10 in ipairs(v47) do
              if value10:FindFirstChild("RolledOreDisplay") then
                v48 = true
                break
              end
            end

            if v48 then
              break
            end

            task.wait(0.25)
            total2 = total2 + 0.25
          end

          local v49 = false

          for index11, value11 in ipairs(v47) do
            if p16 ~= count then
              break
            elseif f17(value11) then
              v49 = true
            end
          end

          if v49 and p16 == count then
            f2()
          end

          return
        end
      end
    end
  end

  local function f19()
    f16()
    local v50 = count

    if not v41 then
      return
    end

    task.spawn(function()
      while v41 and v50 == count and f1() do
        local v51, v52 = pcall(f18, v50)

        if not v51 then
          warn("Sell-Ores AutoRoll: cycle failed - " .. tostring(v52))
        end

        task.wait(0.5)
      end
    end)
  end

  autoRollTab:CreateSection("Auto Roll")

  autoRollTab:CreateToggle({
    Name = "Auto Roll",
    CurrentValue = v41,
    Flag = "AutoRollEnabled",
    Callback = function(value12)
      v41 = value12

      if value12 then
        f19()
      else
        f16()
      end
    end,
  })

  autoRollTab:CreateFilteredCardGrid({
    Groups = f8(),
    Columns = 3,
    Flag = "AutoRollOreSelection",
    Callback = function(value13) v42 = value13 end,
  })

  autoRollTab:CreateButton({
    Name = "Equip Best",
    Callback = function()
      local v53 = f2()

      rayVoid:Notify({
        Title = "Equip Best",
        Message = v53 and "Tunnels updated." or "Request failed.",
        Type = v53 and "success" or "error",
        Duration = 2,
      })
    end,
  })

  return {
    StartFromConfig = function()
      if v41 then
        f19()
      end
    end,
    Stop = function()
      v41 = false
      f16()
    end,
  }
end

local v54 = f15()

local function f20(p17)
  local v55 = false
  local count2 = 0

  local function f21()
    count2 = count2 + 1
  end

  local function f22(p18)
    local v56 = p17.GetLevel()
    local v57 = p17.GetPrice(v56)

    if not v57 or v57 <= 0 then
      return
    elseif v57 > (tonumber(localPlayer:GetAttribute("Money")) or 0) then
      return
    else
      local v58, v59 = pcall(function() return p17.Remote:InvokeServer(p18) end)

      if v58 and type(v59) == "table" and v59.success == true then
        rayVoid:Notify({
          Title = "Auto Upgrade",
          Message = string.format("%s level %d → %d", p17.NotifyLabel, v56, v56 + 1),
          Type = "success",
          Duration = 2,
        })
      end

      return
    end
  end

  local function f23()
    local assignedBaseName2 = localPlayer:GetAttribute("AssignedBaseName")

    if type(assignedBaseName2) ~= "string" or assignedBaseName2 == "" then
      return
    end

    f22(assignedBaseName2)
  end

  local function f24()
    f21()
    local v60 = count2

    if not v55 then
      return
    end

    task.spawn(function()
      while v55 and v60 == count2 and f1() do
        local v61, v62 = pcall(f23)

        if not v61 then
          warn("Sell-Ores " .. p17.Flag .. ": cycle failed - " .. tostring(v62))
        end

        task.wait(1)
      end
    end)
  end

  autoUpgradesTab:CreateToggle({
    Name = p17.ToggleName,
    CurrentValue = v55,
    Flag = p17.Flag,
    Callback = function(value14)
      v55 = value14

      if v55 then
        f24()
      else
        f21()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v55 then
        f24()
      end
    end,
    Stop = function()
      v55 = false
      f21()
    end,
  }
end

local function f25(p19)
  local v63 = false
  local count3 = 0

  local function f26()
    count3 = count3 + 1
  end

  local function f27(p20, p21)
    local getAttribute = localPlayer:GetAttribute(p19.LevelAttributePrefix .. p21)

    if getAttribute == nil then
      getAttribute = localPlayer:GetAttribute(p19.FallbackAttribute)
    end

    local v64 = math.max(1, math.floor(tonumber(getAttribute) or 1))

    if p19.MaxLevel and v64 >= p19.MaxLevel then
      return
    elseif p19.GetPrice(p21, v64) > (tonumber(localPlayer:GetAttribute("Money")) or 0) then
      return
    else
      local v65, v66 = pcall(function() return p19.Remote:InvokeServer(p20, p21) end)

      if v65 and type(v66) == "table" and v66.success == true then
        rayVoid:Notify({
          Title = "Auto Upgrade",
          Message = string.format(
            "Floor %d: %s level %d → %d", p21, p19.NotifyLabel, v64, v64 + 1
          ),
          Type = "success",
          Duration = 2,
        })
      end

      return
    end
  end

  local function f28()
    local assignedBaseName3 = localPlayer:GetAttribute("AssignedBaseName")

    local findFirstChild = assignedBaseName3
      and workspace.Bases:FindFirstChild(assignedBaseName3)

    if not findFirstChild then
      return
    end

    for index12, value15 in ipairs(f3(findFirstChild)) do
      f27(assignedBaseName3, value15)
    end
  end

  local function f29()
    f26()
    local v67 = count3

    if not v63 then
      return
    end

    task.spawn(function()
      while v63 and v67 == count3 and f1() do
        local v68, v69 = pcall(f28)

        if not v68 then
          warn("Sell-Ores " .. p19.Flag .. ": cycle failed - " .. tostring(v69))
        end

        task.wait(1)
      end
    end)
  end

  autoUpgradesTab:CreateToggle({
    Name = p19.ToggleName,
    CurrentValue = v63,
    Flag = p19.Flag,
    Callback = function(value16)
      v63 = value16

      if v63 then
        f29()
      else
        f26()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v63 then
        f29()
      end
    end,
    Stop = function()
      v63 = false
      f26()
    end,
  }
end

autoUpgradesTab:CreateSection("Base (per floor)")

local v70 = f25({
  ToggleName = "Auto Upgrade Drill Speed",
  Flag = "AutoUpgradeDrillSpeedEnabled",
  Remote = baseUpgradeDrillSpeed,
  LevelAttributePrefix = "DrillSpeedLevel_Floor",
  FallbackAttribute = "DrillSpeedLevel",
  GetPrice = function(p22, p23)
    if p23 >= 10 then
      return 0
    end

    return math.floor(10000 * 5 ^ (p22 - 1) * 20 ^ (p23 - 1))
  end,
  MaxLevel = 10,
  NotifyLabel = "Drill Speed",
})

local v71 = f25({
  ToggleName = "Auto Upgrade Drill Yield",
  Flag = "AutoUpgradeDrillYieldEnabled",
  Remote = baseUpgradeDrillYield,
  LevelAttributePrefix = "DrillYieldLevel_Floor",
  FallbackAttribute = "DrillYieldLevel",
  GetPrice = function(p24, p25) return math.floor(80 * 5 ^ (p24 - 1) * 1.45 ^ (p25 - 1)) end,
  NotifyLabel = "Drill Yield",
})

local v72 = f25({
  ToggleName = "Auto Upgrade Ore Regen Speed",
  Flag = "AutoUpgradeOreRegenSpeedEnabled",
  Remote = baseUpgradeOreRegenSpeed,
  LevelAttributePrefix = "OreRegenSpeedLevel_Floor",
  FallbackAttribute = "OreRegenSpeedLevel",
  GetPrice = function(p26, p27) return math.floor(80 * 5 ^ (p26 - 1) * 1.35 ^ (p27 - 1)) end,
  NotifyLabel = "Ore Regen Speed",
})

autoUpgradesTab:CreateSection("Roller")

local v73 = f20({
  ToggleName = "Auto Upgrade Pedestal Count",
  Flag = "AutoUpgradePedestalEnabled",
  Remote = rollerUpgradePedestal,
  GetLevel = function()
    return math.clamp(math.floor(tonumber(localPlayer:GetAttribute("NumberOfRollingPedestals"))
      or 1), 1, 6)
  end,
  GetPrice = function(p28)
    if p28 >= 6 then
      return 0
    end

    return v16[p28]
  end,
  NotifyLabel = "Rolling Pedestals",
})

local v74 = f20({
  ToggleName = "Auto Upgrade Ore Luck",
  Flag = "AutoUpgradeOreLuckEnabled",
  Remote = rollerUpgradeOreLuck,
  GetLevel = function()
    return math.max(1, math.floor(tonumber(localPlayer:GetAttribute("RollingLuck")) or 1))
  end,
  GetPrice = function(p29) return v17.GetUpgradeCost(p29) end,
  NotifyLabel = "Ore Luck",
})

local function f30()
  local v75 = false
  local count4 = 0

  local function f31()
    count4 = count4 + 1
  end

  local function f32(p30, p31)
    local v76 = math.max(
      1, math.floor(tonumber(localPlayer:GetAttribute("MaxFloorUnlocked")) or 1)
    ) + 1

    local floors2 = p31:FindFirstChild("Floors")

    if not (floors2 and floors2:FindFirstChild("Floor" .. v76)) then
      return
    else
      local v77 = f4(v76)

      if not v77 then
        return
      elseif v77 > (tonumber(localPlayer:GetAttribute("Money")) or 0) then
        return
      else
        local v78, v79 = pcall(function()
          return baseBuildPurchaseFloor:InvokeServer(p30, v76)
        end)

        if v78 and type(v79) == "table" and v79.success == true then
          rayVoid:Notify({
            Title = "Auto Buy Floor",
            Message = string.format("Floor %d unlocked!", v76),
            Type = "success",
            Duration = 3,
          })
        end

        return
      end
    end
  end

  local function f33()
    local assignedBaseName4 = localPlayer:GetAttribute("AssignedBaseName")

    local findFirstChild2 = assignedBaseName4
      and workspace.Bases:FindFirstChild(assignedBaseName4)

    if not findFirstChild2 then
      return
    end

    f32(assignedBaseName4, findFirstChild2)
  end

  local function f34()
    f31()
    local v80 = count4

    if not v75 then
      return
    end

    task.spawn(function()
      while v75 and v80 == count4 and f1() do
        local v81, v82 = pcall(f33)

        if not v81 then
          warn("Sell-Ores AutoBuyFloor: cycle failed - " .. tostring(v82))
        end

        task.wait(1)
      end
    end)
  end

  autoUpgradesTab:CreateSection("Floors")

  autoUpgradesTab:CreateToggle({
    Name = "Auto Buy Next Floor",
    CurrentValue = v75,
    Flag = "AutoBuyFloorEnabled",
    Callback = function(value17)
      v75 = value17

      if v75 then
        f34()
      else
        f31()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v75 then
        f34()
      end
    end,
    Stop = function()
      v75 = false
      f31()
    end,
  }
end

local v83 = f30()

local function f35()
  local v84 = false
  local count5 = 0

  local function f36()
    count5 = count5 + 1
  end

  local function f37(p32, p33)
    local floorNumber, tunnelName

    if p33:GetAttribute("Purchased") == true then
      return
    else
      local v85 = tonumber(p33:GetAttribute("PurchasePrice"))
      floorNumber = p33:GetAttribute("FloorNumber")
      local v86 = not v85
      tunnelName = p33:GetAttribute("TunnelName")

      if v86 or not floorNumber or type(tunnelName) ~= "string" then
        return
      elseif v85 > (tonumber(localPlayer:GetAttribute("Money")) or 0) then
        return
      else
        local v87, v88 = pcall(function()
          return baseBuildPurchaseTunnel:InvokeServer(p32, floorNumber, tunnelName)
        end)

        if v87 and type(v88) == "table" and v88.success == true then
          rayVoid:Notify({
            Title = "Auto Buy Tunnel",
            Message = string.format("Floor %d %s unlocked!", floorNumber, tunnelName),
            Type = "success",
            Duration = 2,
          })
        end

        return
      end
    end
  end

  local function f38()
    local assignedBaseName5 = localPlayer:GetAttribute("AssignedBaseName")

    local findFirstChild3 = assignedBaseName5
      and workspace.Bases:FindFirstChild(assignedBaseName5)

    if not findFirstChild3 then
      return
    end

    for index13, value18 in ipairs(f5(findFirstChild3)) do
      f37(assignedBaseName5, value18)
    end
  end

  local function f39()
    f36()
    local v89 = count5

    if not v84 then
      return
    end

    task.spawn(function()
      while v84 and v89 == count5 and f1() do
        local v90, v91 = pcall(f38)

        if not v90 then
          warn("Sell-Ores AutoBuyTunnel: cycle failed - " .. tostring(v91))
        end

        task.wait(1)
      end
    end)
  end

  autoUpgradesTab:CreateSection("Tunnels")

  autoUpgradesTab:CreateToggle({
    Name = "Auto Buy Tunnels",
    CurrentValue = v84,
    Flag = "AutoBuyTunnelEnabled",
    Callback = function(value19)
      v84 = value19

      if v84 then
        f39()
      else
        f36()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v84 then
        f39()
      end
    end,
    Stop = function()
      v84 = false
      f36()
    end,
  }
end

local v92 = f35()

local function f40()
  local v93 = false
  local count6 = 0

  local function f41()
    count6 = count6 + 1
  end

  local function f42()
    local assignedBaseName6 = localPlayer:GetAttribute("AssignedBaseName")
    local v94 = type(assignedBaseName6) ~= "string" or assignedBaseName6 == ""
    local v95

    if v94 then
      return
    else
      local v96 = f6(assignedBaseName6)

      if not v96 or v96.Purchased ~= true then
        return
      else
        v95 = math.max(1, math.floor(tonumber(v96.Level) or 1))
        local v97, v98 = pcall(function() return v21.GetUpgradePrice(v95) end)
        local v99 = v97 and tonumber(v98)

        if not v99 then
          return
        elseif v99 > (tonumber(localPlayer:GetAttribute("Money")) or 0) then
          return
        else
          local v100, v101 = pcall(function()
            return baseCrateAction:InvokeServer(assignedBaseName6, "UpgradeFurnace")
          end)

          if v100 and type(v101) == "table" and v101.success == true then
            rayVoid:Notify({
              Title = "Auto Upgrade",
              Message = string.format("Furnace level %d → %d", v95, v95 + 1),
              Type = "success",
              Duration = 2,
            })
          end

          return
        end
      end
    end
  end

  local function f43()
    f41()
    local v102 = count6

    if not v93 then
      return
    end

    task.spawn(function()
      while v93 and v102 == count6 and f1() do
        local v103, v104 = pcall(f42)

        if not v103 then
          warn("Sell-Ores AutoUpgradeFurnace: cycle failed - " .. tostring(v104))
        end

        task.wait(1)
      end
    end)
  end

  autoUpgradesTab:CreateSection("Furnace")

  autoUpgradesTab:CreateToggle({
    Name = "Auto Upgrade Furnace",
    CurrentValue = v93,
    Flag = "AutoUpgradeFurnaceEnabled",
    Callback = function(value20)
      v93 = value20

      if v93 then
        f43()
      else
        f41()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v93 then
        f43()
      end
    end,
    Stop = function()
      v93 = false
      f41()
    end,
  }
end

local v105 = f40()
local v106 = 1
autoTab:CreateSection("Collect & Sell")

local function f44()
  mousemoverel(1, 0)
  mousemoverel(-1, 0)
end

autoTab:CreateSlider({
  Name = "Collect Loop Interval",
  Range = { 1, 300 },
  Increment = 1,
  CurrentValue = v106,
  Suffix = "s",
  Flag = "AutoCollectLoopInterval",
  Callback = function(value21) v106 = value21 end,
})

local function f45()
  local v107 = false
  local count7 = 0

  local function f46()
    count7 = count7 + 1
  end

  local function f47()
    local v108 = f12()

    if not v108 then
      return
    else
      local character3 = localPlayer.Character
      local humanoidRootPart2 = character3 and character3:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart2 then
        return
      elseif f11() > 0 then
        return
      else
        local droneCrateStack = v108:FindFirstChild("DroneCrateStack")

        if not droneCrateStack or #droneCrateStack:GetChildren() == 0 then
          return
        else
          local crateMaker = v108:FindFirstChild("CrateMaker")
          local crateSpawnPoint = crateMaker and crateMaker:FindFirstChild("CrateSpawnPoint")

          local pickUpOresPrompt = crateSpawnPoint
            and crateSpawnPoint:FindFirstChild("PickUpOresPrompt")

          if not crateSpawnPoint or not pickUpOresPrompt then
            return
          end

          f9(humanoidRootPart2, crateSpawnPoint.Position, pickUpOresPrompt)
          return
        end
      end
    end
  end

  local function f48()
    f46()
    local v109 = count7

    if not v107 then
      return
    end

    task.spawn(function()
      while v107 and v109 == count7 and f1() do
        local v110, v111 = pcall(f47)

        if not v110 then
          warn("Sell-Ores AutoPickupOres: cycle failed - " .. tostring(v111))
        end

        task.wait(v106)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Pickup Ores",
    CurrentValue = v107,
    Flag = "AutoPickupOresEnabled",
    Callback = function(value22)
      v107 = value22

      if v107 then
        f48()
      else
        f46()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v107 then
        f48()
      end
    end,
    Stop = function()
      v107 = false
      f46()
    end,
  }
end

local v112 = f45()

local function f49()
  local v113 = false
  local count8 = 0

  local function f50()
    count8 = count8 + 1
  end

  local function f51()
    if f11() == 0 then
      return
    else
      local v114 = f12()

      if not v114 then
        return
      else
        local character4 = localPlayer.Character
        local humanoidRootPart3 = character4 and character4:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart3 then
          return
        else
          local sellerTable = v114:FindFirstChild("SellerTable")

          local meshesSellerTableTableBoard1 = sellerTable
            and sellerTable:FindFirstChild("Meshes/SellerTable_TableBoard (1)")

          local sellOresPrompt = meshesSellerTableTableBoard1
            and meshesSellerTableTableBoard1:FindFirstChild("SellOresPrompt")

          if not meshesSellerTableTableBoard1 or not sellOresPrompt then
            return
          else
            local v115 = tonumber(localPlayer:GetAttribute("Money")) or 0
            f9(humanoidRootPart3, meshesSellerTableTableBoard1.Position, sellOresPrompt)
            task.wait(0.3)
            local v116 = tonumber(localPlayer:GetAttribute("Money")) or 0

            if v116 > v115 then
              rayVoid:Notify({
                Title = "Auto Sell",
                Message = string.format("Sold: +%d$", v116 - v115),
                Type = "success",
                Duration = 2,
              })
            end

            return
          end
        end
      end
    end
  end

  local function f52()
    f50()
    local v117 = count8

    if not v113 then
      return
    end

    task.spawn(function()
      while v113 and v117 == count8 and f1() do
        local v118, v119 = pcall(f51)

        if not v118 then
          warn("Sell-Ores AutoSellOres: cycle failed - " .. tostring(v119))
        end

        task.wait(v106)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Sell (Direct)",
    CurrentValue = v113,
    Flag = "AutoSellOresEnabled",
    Callback = function(value23)
      v113 = value23

      if v113 then
        f52()
      else
        f50()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v113 then
        f52()
      end
    end,
    Stop = function()
      v113 = false
      f50()
    end,
  }
end

local v120 = f49()

local function f53()
  local v121 = false
  local count9 = 0

  local function f54()
    count9 = count9 + 1
  end

  local function f55(p34)
    local v122 = f12()
    local metalCratePlacementPart, proximityPrompt2, v123

    if not v122 then
      return
    else
      local character5 = localPlayer.Character
      local humanoidRootPart4 = character5 and character5:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart4 then
        return
      else
        local furnace = v122:FindFirstChild("Furnace")

        if not furnace then
          return
        else
          local v124 = false

          if f11() > 0 then
            local placeCratesPromptPart = furnace:FindFirstChild("PlaceCratesPromptPart")

            local proximityPrompt3 = placeCratesPromptPart
              and placeCratesPromptPart:FindFirstChildWhichIsA("ProximityPrompt")

            if placeCratesPromptPart and proximityPrompt3 then
              f9(humanoidRootPart4, placeCratesPromptPart.Position, proximityPrompt3)
              local total3 = 0
              v124 = true

              while f11() > 0 and total3 < 5 do
                task.wait(0.5)
                total3 = total3 + 0.5
              end
            end
          end

          if f11() > 0 then
            return
          else
            local furnaceMetalCrateStack = furnace:FindFirstChild("FurnaceMetalCrateStack")

            if not furnaceMetalCrateStack then
              return
            elseif #furnaceMetalCrateStack:GetChildren() == 0 then
              if not v124 then
                return
              else
                local total4 = 0

                while #furnaceMetalCrateStack:GetChildren() == 0 and total4 < 180
                  and p34 == count9 and f1() do
                  task.wait(3)
                  total4 = total4 + 3
                end

                if #furnaceMetalCrateStack:GetChildren() == 0 then
                  return
                end

                metalCratePlacementPart = furnace:FindFirstChild("MetalCratePlacementPart")

                proximityPrompt2 = metalCratePlacementPart

                proximityPrompt2 = metalCratePlacementPart
                  and metalCratePlacementPart:FindFirstChildWhichIsA("ProximityPrompt")

                v123 = not metalCratePlacementPart

                if v123 or not proximityPrompt2 then
                  return
                end

                f9(humanoidRootPart4, metalCratePlacementPart.Position, proximityPrompt2)

                if f11() == 0 then
                  return
                else
                  local sellerTable2 = v122:FindFirstChild("SellerTable")

                  local meshesSellerTableTableBoard12 = sellerTable2

                  meshesSellerTableTableBoard12 = sellerTable2
                    and sellerTable2:FindFirstChild("Meshes/SellerTable_TableBoard (1)")

                  local sellOresPrompt2 = meshesSellerTableTableBoard12

                  sellOresPrompt2 = meshesSellerTableTableBoard12
                    and meshesSellerTableTableBoard12:FindFirstChild("SellOresPrompt")

                  if not meshesSellerTableTableBoard12 or not sellOresPrompt2 then
                    return
                  else
                    local v125 = tonumber(localPlayer:GetAttribute("Money")) or 0

                    f9(
                      humanoidRootPart4, meshesSellerTableTableBoard12.Position, sellOresPrompt2
                    )

                    task.wait(0.3)
                    local v126 = tonumber(localPlayer:GetAttribute("Money")) or 0

                    if v126 > v125 then
                      rayVoid:Notify({
                        Title = "Auto Furnace",
                        Message = string.format("Metal crates sold: +%d$", v126 - v125),
                        Type = "success",
                        Duration = 2,
                      })
                    end

                    return
                  end
                end
              end
            else
              metalCratePlacementPart = furnace:FindFirstChild("MetalCratePlacementPart")

              proximityPrompt2 = metalCratePlacementPart

              proximityPrompt2 = metalCratePlacementPart
                and metalCratePlacementPart:FindFirstChildWhichIsA("ProximityPrompt")

              v123 = not metalCratePlacementPart

              if v123 or not proximityPrompt2 then
                return
              end

              f9(humanoidRootPart4, metalCratePlacementPart.Position, proximityPrompt2)

              if f11() == 0 then
                return
              else
                local sellerTable3 = v122:FindFirstChild("SellerTable")

                local meshesSellerTableTableBoard13 = sellerTable3

                meshesSellerTableTableBoard13 = sellerTable3
                  and sellerTable3:FindFirstChild("Meshes/SellerTable_TableBoard (1)")

                local sellOresPrompt3 = meshesSellerTableTableBoard13

                sellOresPrompt3 = meshesSellerTableTableBoard13
                  and meshesSellerTableTableBoard13:FindFirstChild("SellOresPrompt")

                if not meshesSellerTableTableBoard13 or not sellOresPrompt3 then
                  return
                else
                  local v127 = tonumber(localPlayer:GetAttribute("Money")) or 0
                  f9(humanoidRootPart4, meshesSellerTableTableBoard13.Position, sellOresPrompt3)
                  task.wait(0.3)
                  local v128 = tonumber(localPlayer:GetAttribute("Money")) or 0

                  if v128 > v127 then
                    rayVoid:Notify({
                      Title = "Auto Furnace",
                      Message = string.format("Metal crates sold: +%d$", v128 - v127),
                      Type = "success",
                      Duration = 2,
                    })
                  end

                  return
                end
              end
            end
          end
        end
      end
    end
  end

  local function f56()
    f54()
    local v129 = count9

    if not v121 then
      return
    end

    task.spawn(function()
      while v121 and v129 == count9 and f1() do
        local v130, v131 = pcall(f55, v129)

        if not v130 then
          warn("Sell-Ores AutoFurnace: cycle failed - " .. tostring(v131))
        end

        task.wait(v106)
      end
    end)
  end

  autoTab:CreateToggle({
    Name = "Auto Furnace",
    CurrentValue = v121,
    Flag = "AutoFurnaceEnabled",
    Callback = function(value24)
      v121 = value24

      if v121 then
        f56()
      else
        f54()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v121 then
        f56()
      end
    end,
    Stop = function()
      v121 = false
      f54()
    end,
  }
end

local v132 = f53()

local function f57()
  local v133 = false
  local count10 = 0
  local v134 = {}

  local function f58()
    count10 = count10 + 1
  end

  local function f59(p35)
    local v135 = v25[p35]

    if not v135 or not v135.Id or not v135.Price then
      return
    else
      local v136 = tonumber(localPlayer:GetAttribute("Money"))

      if v135.Price > (v136 or 0) then
        return
      else
        local v137, v138 = pcall(function() return requestGearPurchase:InvokeServer(v135.Id) end)

        if v137 and type(v138) == "table" and v138.success == true then
          rayVoid:Notify({
            Title = "Auto Shop",
            Message = "Bought: " .. p35,
            Type = "success",
            Duration = 2,
          })
        end

        return
      end
    end
  end

  local function f60()
    for key in pairs(v134) do
      f59(key)
    end
  end

  local function f61()
    f58()
    local v139 = count10

    if not v133 then
      return
    end

    task.spawn(function()
      while v133 and v139 == count10 and f1() do
        local v140, v141 = pcall(f60)

        if not v140 then
          warn("Sell-Ores AutoBuyGear: cycle failed - " .. tostring(v141))
        end

        task.wait(1)
      end
    end)
  end

  gearShopTab:CreateSection("Gear Shop")

  gearShopTab:CreateToggle({
    Name = "Auto Buy Gear",
    CurrentValue = v133,
    Flag = "AutoBuyGearEnabled",
    Callback = function(value25)
      v133 = value25

      if v133 then
        f61()
      else
        f58()
      end
    end,
  })

  gearShopTab:CreateCardGrid({
    Items = f7(),
    Columns = 3,
    Flag = "AutoBuyGearSelection",
    Callback = function(value26) v134 = value26 end,
  })

  return {
    StartFromConfig = function()
      if v133 then
        f61()
      end
    end,
    Stop = function()
      v133 = false
      f58()
    end,
  }
end

local v142 = f57()

local function f62()
  local v143 = false
  local count11 = 0
  local v144 = {}

  local function f63()
    count11 = count11 + 1
  end

  local function f64(p36)
    local v145 = v37[p36]

    if not v145 or not v145.Id or not v145.Price then
      return
    else
      local v146 = tonumber(localPlayer:GetAttribute("Money"))

      if v145.Price > (v146 or 0) then
        return
      else
        local v147, v148 = pcall(function()
          return requestLuckyBlockPurchase:InvokeServer(v145.Id)
        end)

        if v147 and type(v148) == "table" and v148.success == true then
          rayVoid:Notify({
            Title = "Pet Shop",
            Message = "Bought: " .. p36,
            Type = "success",
            Duration = 2,
          })
        end

        return
      end
    end
  end

  local function f65()
    for key2 in pairs(v144) do
      f64(key2)
    end
  end

  local function f66()
    f63()
    local v149 = count11

    if not v143 then
      return
    end

    task.spawn(function()
      while v143 and v149 == count11 and f1() do
        local v150, v151 = pcall(f65)

        if not v150 then
          warn("Sell-Ores AutoBuyLuckyBlock: cycle failed - " .. tostring(v151))
        end

        task.wait(1)
      end
    end)
  end

  petShopTab:CreateSection("Pet Shop")

  petShopTab:CreateToggle({
    Name = "Auto Buy Lucky Blocks",
    CurrentValue = v143,
    Flag = "AutoBuyLuckyBlockEnabled",
    Callback = function(value27)
      v143 = value27

      if v143 then
        f66()
      else
        f63()
      end
    end,
  })

  petShopTab:CreateCardGrid({
    Items = f13(),
    Columns = 3,
    Flag = "AutoBuyLuckyBlockSelection",
    Callback = function(value28) v144 = value28 end,
  })

  return {
    StartFromConfig = function()
      if v143 then
        f66()
      end
    end,
    Stop = function()
      v143 = false
      f63()
    end,
  }
end

local v152 = f62()

local function f67()
  local v153 = false
  local count12 = 0

  local function f68()
    count12 = count12 + 1
  end

  local function f69()
    f68()
    local v154 = count12

    if not v153 then
      return
    end

    task.spawn(function()
      while v153 and v154 == count12 and f1() do
        local v155, v156 = pcall(f44)

        if not v155 then
          warn("Sell-Ores AntiAfk: mousemoverel failed - " .. tostring(v156))
        end

        task.wait(60)
      end
    end)
  end

  miscTab:CreateSection("Anti-AFK")

  miscTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = v153,
    Flag = "AntiAfkEnabled",
    Callback = function(value29)
      v153 = value29

      if v153 then
        f69()
      else
        f68()
      end
    end,
  })

  miscTab:CreateLabel("Simulates a tiny mouse movement every 60s to avoid the AFK kick (never a click, so it can't risk hitting a button).")

  return {
    StartFromConfig = function()
      if v153 then
        f69()
      end
    end,
    Stop = function()
      v153 = false
      f68()
    end,
  }
end

local v157 = f67()
v54:StartFromConfig()
v70:StartFromConfig()
v71:StartFromConfig()
v72:StartFromConfig()
v73:StartFromConfig()
v74:StartFromConfig()
v83:StartFromConfig()
v92:StartFromConfig()
v105:StartFromConfig()
v112:StartFromConfig()
v120:StartFromConfig()
v132:StartFromConfig()
v142:StartFromConfig()
v152:StartFromConfig()
v157:StartFromConfig()
