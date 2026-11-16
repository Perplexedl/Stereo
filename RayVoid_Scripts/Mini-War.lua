local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "hjV" / (1254439 - "Med9GZd2CZoU" ^ 3740275) end) })[2]
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
          pcall(function() return "uC79TIXfzG6r7" / (3294821 - "da43SaYdidvUf7" ^ 12043120) end),
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
rayVoid:SetScriptName("Military Map")

local localPlayer = game:GetService("Players").LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local v12 = require(replicatedStorage.util.GetBridge)
local v13 = require(replicatedStorage.shared.config.BuildingsConfig)
local v14 = require(replicatedStorage.client.modules.ClientData)
local v15 = require(replicatedStorage.shared.config.ShopsConfig)
local v16 = require(replicatedStorage.util.getPreviousCustomInterval)
local v17 = require(replicatedStorage.shared.config.SkillsConfig)
local v18 = require(replicatedStorage.shared.config.GameConfig)
local v19 = require(replicatedStorage.util.getSkillsData)
local v20 = require(replicatedStorage.util.GetDictionaryLength)
local v21 = require(replicatedStorage.util.getAmountOfSpecifiedBuildingThatPlayerOwns)

local v22 = {
  Farm = true,
  House = true,
  Military = true,
  Decor = true,
}

local v23 = { "Farm", "House", "Military", "Decor" }

local v24 = {
  Farm = true,
  GemMine = true,
  CloneFacility = true,
  Storage = true,
}

local v25 = { Vault = true, Vault2 = true }
local v26 = { "Bandit", "Wooden", "MilitaryBase" }
local v27 = {}

local v28 = {
  Farm = {},
  House = {},
  Military = {},
  Decor = {},
}

for key, value in pairs(v13) do
  local type = value.Type

  if type and v22[type] then
    v27[key] = type
    table.insert(v28[type], key)
  end
end

for key2, value2 in pairs(v28) do
end

local v29 = { CloneFacilityV2 = true, PrototypeFacility = true }
local v30 = {}
local v31 = {}

for index, value3 in ipairs(v15.BlackMarket) do
  local name = value3.name
  local v32 = v13[name]

  if v32 then
    if v32.requiredBuildingsData and not v29[name] then
      table.insert(v31, name)
    else
      table.insert(v30, name)
    end
  end
end

table.sort(v30, function(p1, p2)
  local gemPrice = v13[p1] and (v13[p1].gemPrice or v13[p1].Price)
  local v33 = v13[p2]
  local gemPrice2 = v33
  local v34 = gemPrice or 0

  if v33 then
    gemPrice2 = v13[p2].gemPrice or v13[p2].Price
  end

  return v34 < (gemPrice2 or 0)
end)

if #v31 > 0 then
  warn(
    "[BlackMarket] Excluded items (requiredBuildingsData, building sacrifice):",
    table.concat(v31, ", ")
  )
end

local v35 = {}
local v36 = {}
local v37 = {}

for index2, value4 in ipairs(v15.AlienShop or {}) do
  local name2 = value4.name
  local v38 = v13[name2]

  if v38 then
    if v38.requiredBuildingsData then
      table.insert(v36, name2)
    else
      table.insert(v35, name2)
      v37[name2] = value4.alienCorePrice or v38.alienCorePrice or 50
    end
  end
end

table.sort(v35, function(p3, p4) return v37[p3] < v37[p4] end)

if #v36 > 0 then
  warn(
    "[AlienShop] Excluded items (requiredBuildingsData, building sacrifice):",
    table.concat(v36, ", ")
  )
end

local v39 = {}

for key3, value5 in pairs(v17) do
  if value5.NextSkills then
    for index3, value6 in ipairs(value5.NextSkills) do
      v39[value6] = key3
    end
  end
end

local function f1(p5, p6)
  local d = p5:match("%d+$")
  return d ~= nil and tonumber(d) == p6
end

local f2

local function f3()
  local v40 = f2()

  if not v40 then
    return
  end

  for index4, value7 in ipairs(v40.Plot.Buildings:GetChildren()) do
    local v41 = value7
    local type2 = v41:GetAttribute("type")

    if type2 and v24[type2] or v25[v41.Name] then
      local v42, v43 = pcall(function() v12("CollectResources"):Fire(v41) end)

      if not v42 then
        warn("[AutoCollect] Fire failed:", v43)
      end

      task.wait(0.1)
    end
  end
end

local function f4()
  local v44 = f2()

  if not v44 then
    warn("[AutoConquere] Plot not found for", localPlayer.Name)
    return nil
  else
    local d2 = v44.Name:match("%d+$")

    if not d2 then
      warn("[AutoConquere] Could not extract number from:", v44.Name)
      return nil
    end

    return tonumber(d2)
  end
end

function f2()
  for index5, value8 in ipairs(workspace.MilitaryMap.PlayerPlots:GetChildren()) do
    local playerName = value8:FindFirstChild("UI") and value8.UI:FindFirstChild("BillboardGui")
      and value8.UI.BillboardGui:FindFirstChild("Holder")
      and value8.UI.BillboardGui.Holder:FindFirstChild("PlayerName")

    if playerName and playerName.Text:find(localPlayer.Name) then
      return value8
    end
  end
end

local f5

local function f6(p7)
  local v45 = v27[p7]

  if not v45 then
    return
  else
    local v46 = f5(p7)

    if v46 <= 0 then
      return
    end

    for k = 1, v46 do
      local v47, v48 = pcall(function() v12("BuyFromShop"):Fire({ shop = v45, item = p7 }) end)

      if not v47 then
        warn("[AutoBuy] Fire failed:", v48)
      end

      task.wait(0.15)
    end

    return
  end
end

local function f7(p8)
  local blackMarket = v14.playerProducer:getState().player.shopsStock.BlackMarket

  if not (blackMarket and blackMarket.stock) then
    return 0
  end

  return blackMarket.stock[p8] or 0
end

local function f8(armyIndex, p9)
  if not p9 or not p9:IsA("Instance") then
    warn("[DeployArmy] Invalid capturePoint")
    return
  else
    local v49, v50 = pcall(function()
      v12("SendTroopsToPoint"):Fire({ armyIndex = armyIndex, capturePoint = p9 })
    end)

    if not v49 then
      warn("[DeployArmy] Fire failed:", v50)
    end

    return
  end
end

function f5(p10)
  local findFirstChild = localPlayer.PlayerGui.MainUI.Fullscreen.BuyUI.ItemsGrid:FindFirstChild(p10)

  if not findFirstChild then
    return 0
  else
    local stock = findFirstChild:FindFirstChild("Stock")

    if not stock then
      return 0
    end

    if stock.Text == "Out of Stock!" then
      return 0
    end

    return tonumber((stock.Text:match("Stock x(%d+)"))) or 0
  end
end

local function f9(p11)
  local v51, v52 = pcall(function() v12("TryToBuySkill"):Fire(p11) end)

  if not v51 then
    warn("[AutoSkillTree] Fire failed:", v52)
  end
end

local function f10(p12)
  if not p12 then
    return nil
  else
    local dD = p12:match("(-?%d+%.?%d*)")
    return dD and tonumber(dD) or nil
  end
end

local function f11(p13)
  local character = localPlayer.Character

  if not character then
    warn("[AutoSellByPrice] No character found")
    return false
  end

  local humanoid = character:FindFirstChildOfClass("Humanoid")

  if not humanoid then
    warn("[AutoSellByPrice] No Humanoid found on character")
    return false
  else
    local v53, v54 = pcall(function() humanoid:EquipTool(p13) end)

    if not v53 then
      warn("[AutoSellByPrice] EquipTool failed:", v54)
      return false
    end

    return true
  end
end

local function f12()
  local v55, v56 = pcall(function() v12("SellSingularItem"):Fire() end)

  if not v55 then
    warn("[AutoSellByPrice] Fire failed:", v56)
    return false
  end

  return true
end

local v57 = {
  K = 1000,
  M = 1000000,
  B = 1000000000,
  T = 1000000000000,
}

local function f13(p14)
  if not p14 then
    return 0
  else
    local gsub2 = p14:gsub("[,%s]", "")
    local v58, v59 = gsub2:match("^([%d%.]+)(%a?)$")

    if not v58 then
      return tonumber(gsub2) or 0
    else
      local upper = v59:upper()
      return (tonumber(v58) or 0) * (v57[upper] or 1)
    end
  end
end

local function f14()
  local player = v14.playerProducer:getState().player
  return player.skills.unlockedSkills, player.skills.currentlyUnlockingSkills, tonumber(player.money) or 0
end

local function f15()
  local v60, v61 = pcall(function()
    return localPlayer.PlayerGui.MainUI.HUD.CurrencyUI.Gems.Gems.Text
  end)

  if not v60 then
    warn("[BlackMarket] Could not read gem balance, invalid UI path")
    return 0
  end

  return f13(v61)
end

local function f16()
  local v62, v63 = pcall(function() v12("SellAll"):Fire() end)

  if not v62 then
    warn("[AutoSell] Fire failed:", v63)
  end
end

local function f17()
  local character2 = localPlayer.Character

  if not character2 then
    return
  end

  local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

  if not humanoid2 then
    return
  else
    local v64, v65 = pcall(function() humanoid2:UnequipTools() end)

    if not v64 then
      warn("[AutoSellByPrice] UnequipTools failed:", v65)
    end

    return
  end
end

local function f18()
  local v66, v67 = pcall(function() return localPlayer.PlayerGui.MarketUI.Leaderboard.List end)

  if not v66 or not v67 then
    warn("[AutoSellByPrice] MarketUI.Leaderboard.List not found")
    return nil
  end

  return v67
end

local f19

local function f20(p15)
  if not f19() then
    return
  else
    local v68 = v13[p15]

    if not v68 then
      return
    else
      local v69 = f7(p15)

      if v69 <= 0 then
        return
      else
        local gemPrice3 = v68.gemPrice
        local v70 = v68.gemPrice ~= nil
        local price = gemPrice3 or v68.Price or 0

        for m = 1, v69 do
          if v70 then
            local v71 = f15()

            if v71 < price then
              warn(("[AutoBlackMarket] Not enough gems for %s (%d < %d), stopping"):format(
                p15, v71, price
              ))

              break
            end
          end

          local v72, v73 = pcall(function()
            v12("BuyFromBlackMarketShop"):Fire({ shop = "BlackMarket", item = p15 })
          end)

          if not v72 then
            warn("[AutoBlackMarket] Fire failed:", v73)
          end

          task.wait(0.15)
        end

        return
      end
    end
  end
end

local function f21()
  local v74 = v19(localPlayer)
  return v18.game.MaxSkillResearchAmount + (v74.moreResearch or 0)
end

local function f22()
  for index6, value9 in ipairs(workspace:GetChildren()) do
    local v75 = value9

    if v75.Name == "BATTLEPASS_POINT_PICKUP" then
      local pickupId = v75:GetAttribute("PickupId")

      if pickupId then
        local v76, v77 = pcall(function() v12("CollectBPPickup"):Fire(pickupId) end)

        if v76 then
          pcall(function() v75:Destroy() end)
        else
          warn("[AutoBattlepass] Fire failed:", v77)
        end
      end

      task.wait(0.1)
    end
  end
end

function f19()
  return workspace:GetServerTimeNow() - v16(3600) < 1200
end

local function f23(p16)
  local alienShop = v14.playerProducer:getState().player.shopsStock.AlienShop

  if not (alienShop and alienShop.stock) then
    return 0
  end

  return alienShop.stock[p16] or 0
end

local function f24()
  local v78, v79 = pcall(function() v12("ExtractAllAlienCores"):Fire() end)

  if not v78 then
    warn("[AutoExtract] Fire failed:", v79)
  end
end

local function f25(p17, p18, fn, fn2)
  local findFirstChild2 = workspace.MilitaryMap.Object:FindFirstChild(p18)

  if not findFirstChild2 then
    warn("[" .. p17 .. "] Folder not found:", p18)
    return
  else
    local getChildren = findFirstChild2:GetChildren()

    if #getChildren == 0 then
      return
    end

    for index7, value10 in ipairs(getChildren) do
      local v80 = value10

      if not fn() then
        return
      elseif not v80:IsDescendantOf(workspace) then
      else
        local v81, v82, v83 = pcall(function()
          return v80:GetAttribute("ClaimProgress"), v80:GetAttribute("Owner"), v80:GetAttribute("Claiming")
        end)

        if not v81 then
          warn("[" .. p17 .. "] GetAttribute failed on", v80.Name, "-> skipping")
        elseif v82 == -1 and v83 == localPlayer.Name then
        else
          fn2(v80)

          while fn() and v80:IsDescendantOf(workspace)
            and v80:GetAttribute("Owner") ~= localPlayer.Name do
            task.wait(0.3)
          end

          if not fn() then
            return
          elseif not v80:IsDescendantOf(workspace) then
          end
        end
      end
    end

    return
  end
end

local function f26()
  local v84 = f18()

  if not v84 then
    return {}
  else
    local v85 = {}

    for index8, value11 in ipairs(v84:GetChildren()) do
      if value11:IsA("Frame") then
        local itemName = value11:FindFirstChild("ItemName")
        local percents = value11:FindFirstChild("Percents")

        if itemName and percents then
          local v86 = f10(percents.Text)

          if v86 then
            v85[itemName.Text] = v86
          else
            warn(
              "[AutoSellByPrice] Could not parse percent for", itemName.Text, "-> raw text:",
              percents.Text
            )
          end
        end
      end
    end

    return v85
  end
end

local f27

local function f28(p19)
  local v87 = v13[p19]

  if not v87 then
    return
  end

  if v87.maxAmount then
    local v88, v89 = pcall(function() return v21(localPlayer, p19) end)

    if v88 and v89 and v89 >= v87.maxAmount then
      return
    end
  end

  local v90 = f23(p19)

  if v90 <= 0 then
    return
  else
    local v91 = v37[p19] or 50

    for n = 1, v90 do
      local v92 = f27()

      if v92 < v91 then
        warn(("[AutoAlienShop] Not enough alien cores for %s (%d < %d), stopping"):format(
          p19, v92, v91
        ))

        break
      else
        local v93, v94 = pcall(function()
          v12("BuyFromShop"):Fire({ shop = "AlienShop", item = p19 })
        end)

        if not v93 then
          warn("[AutoAlienShop] Fire failed:", v94)
        end

        task.wait(0.15)
      end
    end

    return
  end
end

function f27()
  local v95, v96 = pcall(function() return v14.playerProducer:getState().player.alienCore end)

  if not v95 then
    return 0
  end

  return tonumber(v96) or 0
end

local function f29(fn3)
  local v97 = f4()

  if not v97 then
    warn("[ConquestRoad] Stopping scan: plot not found")
    return
  end

  for index9, value12 in ipairs(v26) do
    if not fn3() then
      return
    else
      local findFirstChild3 = workspace.MilitaryMap.Object:FindFirstChild(value12)

      if not findFirstChild3 then
        warn("[ConquestRoad] Folder not found:", value12, "-> moving to next")
      else
        local v98 = false

        for index10, value13 in ipairs(findFirstChild3:GetChildren()) do
          if f1(value13.Name, v97) then
            v98 = true

            if not fn3() then
              return
            else
              local claimProgress = value13:GetAttribute("ClaimProgress")
              local owner = value13:GetAttribute("Owner")
              value13:GetAttribute("Claiming")

              if claimProgress == -1 and owner == localPlayer.Name then
              else
                f8(1, value13)

                while fn3() and value13:GetAttribute("Owner") ~= localPlayer.Name do
                  task.wait(0.3)
                end

                if not fn3() then
                  return
                end
              end
            end
          end
        end

        if not v98 then
          warn("[ConquestRoad] No objective found in", value12, "for plot", v97)
        end
      end
    end
  end
end

local v99 = {}
local v100 = false
local v101 = false
local v102 = false
local v103 = false
local v104 = false
local v105 = false
local v106 = {}
local v107 = false
local v108 = false
local v109 = false
local v110 = false
local options = { "Military", "Economy", "Civilian" }
local v111 = false
local v112 = false
local skillBranch = "All"

local function f30(p20, p21)
  if p20[p21] then
    return p20[p21]
  else
    local lower = p21:gsub("%s+", ""):lower()

    for key4, value14 in pairs(p20) do
      if key4:gsub("%s+", ""):lower() == lower then
        return value14
      end
    end

    return nil
  end
end

local v113 = { "Military", "Economy", "Civilian" }
local v114 = {}
local v115 = false

local function f31(p22, p23)
  local v116 = {}

  for key5, value15 in pairs(v17) do
    if not p22[key5] and not p23[key5] then
      local v117 = v39[key5]

      if v117 == nil or p22[v117] then
        if skillBranch == "All" or value15.Type == skillBranch then
          table.insert(v116, key5)
        end
      end
    end
  end

  local v118 = {}

  for index11, value16 in ipairs(v113) do
    v118[value16] = index11
  end

  table.sort(v116, function(p24, p25)
    local v119 = v17[p24]
    local v120 = v17[p25]

    if skillBranch == "All" then
      local v121 = v118[v119.Type] or 99
      local v122 = v118[v120.Type] or 99

      if v121 ~= v122 then
        return v121 < v122
      end

      return v119.Cost < v120.Cost
    end

    return v119.Cost < v120.Cost
  end)

  return v116
end

local v123 = false
local v124 = {}
local v125 = 0
local v126 = false
local v127 = false
local v128 = false
local v129 = false
local v130 = false
local v131 = {}
local v132 = false

local function f32(p26)
  local findFirstChild4 = workspace.MilitaryMap.Object:FindFirstChild(p26)

  if not findFirstChild4 then
    warn("[ClosestObjective] Folder not found:", p26)
    return nil
  end

  local v133 = f2()

  if not v133 then
    warn("[ClosestObjective] Plot not found for", localPlayer.Name)
    return nil
  else
    local v134, v135 = pcall(function() return v133:GetPivot().Position end)

    if not v134 or not v135 then
      warn("[ClosestObjective] Could not read plot position")
      return nil
    else
      local huge = math.huge
      local v136 = nil

      for index12, value17 in ipairs(findFirstChild4:GetChildren()) do
        local v137 = value17

        if v137:IsA("Model") or v137:IsA("BasePart") then
          local v138, v139 = pcall(function()
            if v137:IsA("Model") then
              return v137:GetPivot().Position
            end

            return v137.Position
          end)

          if v138 and v139 then
            local claimProgress2 = v137:GetAttribute("ClaimProgress")
            local owner2 = v137:GetAttribute("Owner")

            if not (claimProgress2 == -1 and owner2 == localPlayer.Name) then
              local magnitude = (v139 - v135).Magnitude

              if magnitude < huge then
                huge = magnitude
                v136 = v137
              end
            end
          end
        end
      end

      return v136, huge
    end
  end
end

local v140 = false

local function f33(p27, p28, fn4, fn5)
  local v141, v142 = f32(p28)

  if not v141 then
    return
  elseif not fn4() then
    return
  else
    if not pcall(function()
      return v141:GetAttribute("ClaimProgress"), v141:GetAttribute("Owner"), v141:GetAttribute("Claiming")
    end) then
      warn("[" .. p27 .. "] GetAttribute failed -> skipping")
      return
    end

    fn5(v141)

    while fn4() and v141:IsDescendantOf(workspace)
      and v141:GetAttribute("Owner") ~= localPlayer.Name do
      task.wait(0.3)
    end

    if not fn4() then
      return
    end

    if not v141:IsDescendantOf(workspace) then
    end

    return
  end
end

local function f34()
  local backpack = localPlayer:FindFirstChild("Backpack")

  if not backpack then
    warn("[AutoSellByPrice] No Backpack found")
    return
  else
    local v143 = f26()

    for index13, value18 in ipairs(backpack:GetChildren()) do
      if not v127 then
        return
      elseif value18:IsA("Tool") then
        local v144 = f30(v143, value18.Name)

        if not v144 then
          warn("[AutoSellByPrice] No market price found for", value18.Name, "-> skipping")
        elseif v144 >= v125 then
          if f11(value18) then
            task.wait(0.3)

            if f12() then
            end

            task.wait(0.3)
            f17()
          end

          task.wait(0.3)
        end
      end
    end

    return
  end
end

local window = rayVoid:CreateWindow({
  Name = "Military Map | AKkiwi HUB",
  LoadingTitle = "Military Map Script",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "Military Map" },
})

local mainTab = window:CreateTab("Main")

local conquestTab = window:CreateTab("Conquest")
conquestTab:CreateSection("Auto Conquest")

conquestTab:CreateToggle({
  Name = "Auto Conquest",
  CurrentValue = false,
  Flag = "AutoConquest",
  Callback = function(value19)
    v115 = value19

    if not value19 then
      return
    end

    if v123 then
      return
    end

    v123 = true

    task.spawn(function()
      while v115 do
        if v124.ConquestRoad then
          f29(function() return v115 and v124.ConquestRoad end)
        end

        if v124.AllLaboratory then
          f25("AllLaboratory", "Laboratory", function() return v115 and v124.AllLaboratory end, function(p29)
            f8(1, p29)
          end)
        end

        if v124.ClosestLaboratory then
          f33(
            "ClosestLaboratory", "Laboratory",
            function() return v115 and v124.ClosestLaboratory end, function(p30) f8(1, p30) end
          )
        end

        if v124.AllWaterRig then
          f25("AllWaterRig", "WaterRigs", function() return v115 and v124.AllWaterRig end, function(p31)
            f8(1, p31)
          end)
        end

        if v124.ClosestWaterRig then
          f33(
            "ClosestWaterRig", "WaterRigs", function() return v115 and v124.ClosestWaterRig end,
            function(p32) f8(1, p32) end
          )
        end

        if v124.AllSpecial then
          f25("AllSpecial", "Special", function() return v115 and v124.AllSpecial end, function(p33)
            f8(1, p33)
          end)
        end

        task.wait(1)
      end

      v123 = false
    end)
  end,
})

conquestTab:CreateSection("Conquest Targets")

conquestTab:CreateToggle({
  Name = "Conquest Road",
  CurrentValue = false,
  Flag = "ConquestTargetRoad",
  Callback = function(value20) v124.ConquestRoad = value20 or nil end,
})

conquestTab:CreateToggle({
  Name = "All Laboratory",
  CurrentValue = false,
  Flag = "ConquestTargetAllLaboratory",
  Callback = function(value21) v124.AllLaboratory = value21 or nil end,
})

conquestTab:CreateToggle({
  Name = "Closest Laboratory",
  CurrentValue = false,
  Flag = "ConquestTargetClosestLaboratory",
  Callback = function(value22) v124.ClosestLaboratory = value22 or nil end,
})

conquestTab:CreateToggle({
  Name = "All WaterRig",
  CurrentValue = false,
  Flag = "ConquestTargetAllWaterRig",
  Callback = function(value23) v124.AllWaterRig = value23 or nil end,
})

conquestTab:CreateToggle({
  Name = "Closest WaterRig",
  CurrentValue = false,
  Flag = "ConquestTargetClosestWaterRig",
  Callback = function(value24) v124.ClosestWaterRig = value24 or nil end,
})

conquestTab:CreateToggle({
  Name = "All Special",
  CurrentValue = false,
  Flag = "ConquestTargetAllSpecial",
  Callback = function(value25) v124.AllSpecial = value25 or nil end,
})

mainTab:CreateSection("Collect")

mainTab:CreateToggle({
  Name = "Auto Collect",
  CurrentValue = false,
  Flag = "AutoCollect",
  Callback = function(value26)
    v102 = value26

    if not value26 then
      return
    end

    if v103 then
      return
    end

    v103 = true

    task.spawn(function()
      while v102 do
        f3()
        task.wait(5)
      end

      v103 = false
    end)
  end,
})

mainTab:CreateToggle({
  Name = "Auto Battlepass",
  CurrentValue = false,
  Flag = "AutoBattlepass",
  Callback = function(value27)
    v109 = value27

    if not value27 then
      return
    end

    if v110 then
      return
    end

    v110 = true

    task.spawn(function()
      while v109 do
        f22()
        task.wait(1)
      end

      v110 = false
    end)
  end,
})

mainTab:CreateSection("Sell")

mainTab:CreateToggle({
  Name = "Auto Sell",
  CurrentValue = false,
  Flag = "AutoSell",
  Callback = function(value28)
    v104 = value28

    if not value28 then
      return
    end

    if v105 then
      return
    end

    v105 = true

    task.spawn(function()
      while v104 do
        f16()
        task.wait(5)
      end

      v105 = false
    end)
  end,
})

mainTab:CreateInput({
  Name = "Min Sell Percent",
  PlaceholderText = "e.g. 50",
  RemoveTextAfterFocusLost = false,
  Flag = "MinSellPercent",
  Callback = function(value29)
    local v145 = tonumber(value29)

    if not v145 then
      warn("[AutoSellByPrice] Invalid input for Min Sell Percent:", value29)
      return
    end

    v125 = v145
    v126 = true
  end,
})

mainTab:CreateToggle({
  Name = "Auto Sell By Price",
  CurrentValue = false,
  Flag = "AutoSellByPrice",
  Callback = function(value30)
    if value30 and not v126 then
      warn("[AutoSellByPrice] Min Sell Percent not set -> enter a value before enabling this toggle")
      return
    end

    v127 = value30

    if not value30 then
      return
    end

    if v128 then
      return
    end

    v128 = true

    task.spawn(function()
      while v127 do
        f34()
        task.wait(30)
      end

      v128 = false
    end)
  end,
})

mainTab:CreateSection("Buy")

mainTab:CreateToggle({
  Name = "Auto Buy",
  CurrentValue = false,
  Flag = "AutoBuy",
  Callback = function(value31)
    v100 = value31

    if not value31 then
      return
    end

    if v101 then
      return
    end

    v101 = true

    task.spawn(function()
      while v100 do
        for key6, value32 in pairs(v99) do
          f6(key6)
          task.wait(0.1)
        end

        task.wait(5)
      end

      v101 = false
    end)
  end,
})

mainTab:CreateSection("Skill Tree")

mainTab:CreateDropdown({
  Name = "Skill Branch",
  Options = { "All", "Military", "Economy", "Civilian" },
  CurrentOption = { "All" },
  MultipleOptions = false,
  Flag = "SkillBranchMode",
  Callback = function(value33) skillBranch = value33[1] or value33 end,
})

mainTab:CreateDropdown({
  Name = "Priority 1st",
  Options = options,
  CurrentOption = { "Military" },
  MultipleOptions = false,
  Flag = "SkillPriority1",
  Callback = function(value34) v113[1] = value34[1] or value34 end,
})

mainTab:CreateDropdown({
  Name = "Priority 2nd",
  Options = options,
  CurrentOption = { "Economy" },
  MultipleOptions = false,
  Flag = "SkillPriority2",
  Callback = function(value35) v113[2] = value35[1] or value35 end,
})

mainTab:CreateDropdown({
  Name = "Priority 3rd",
  Options = options,
  CurrentOption = { "Civilian" },
  MultipleOptions = false,
  Flag = "SkillPriority3",
  Callback = function(value36) v113[3] = value36[1] or value36 end,
})

mainTab:CreateToggle({
  Name = "Auto Skill Tree",
  CurrentValue = false,
  Flag = "AutoSkillTree",
  Callback = function(value37)
    v111 = value37

    if not value37 then
      return
    end

    if v112 then
      return
    end

    v112 = true

    task.spawn(function()
      while v111 do
        local v146, v147, v148 = f14()

        if v20(v147) < f21() then
          for index14, value38 in ipairs((f31(v146, v147))) do
            local v149 = v17[value38]
            local v150 = v114[value38]
            local v151 = v150 and tick() - v150 < 5

            if v149.Cost <= v148 and not v151 then
              f9(value38)
              v114[value38] = tick()
              task.wait(0.3)
              break
            end
          end
        end

        task.wait(3)
      end

      v112 = false
    end)
  end,
})

mainTab:CreateSection("Alien Extractor")

mainTab:CreateToggle({
  Name = "Auto Extract Cores",
  CurrentValue = false,
  Flag = "AutoExtract",
  Callback = function(value39)
    v129 = value39

    if not value39 then
      return
    end

    if v130 then
      return
    end

    v130 = true

    task.spawn(function()
      while v129 do
        f24()
        task.wait(5)
      end

      v130 = false
    end)
  end,
})

for index15, value40 in ipairs(v23) do
  local v152 = v28[value40]

  if #v152 > 0 then
    local tab = window:CreateTab(value40)
    tab:CreateSection("Item selection")

    local v153 = {}

    for index16, value41 in ipairs(v152) do
      local v154 = v13[value41]
      local renderImage = v154 and v154.renderImage or ""
      table.insert(v153, { Name = value41, Icon = renderImage })
    end

    tab:CreateCardGrid({
      Items = v153,
      Columns = 3,
      Flag = "SelectedItems_" .. value40,
      Callback = function(value42)
        for index17, value43 in ipairs(v152) do
          v99[value43] = nil
        end

        for key7, value44 in pairs(value42) do
          if value44 then
            v99[key7] = true
          end
        end
      end,
    })
  end
end

if #v30 > 0 then
  local blackMarketTab = window:CreateTab("Black Market")
  blackMarketTab:CreateSection("Auto Buy")

  blackMarketTab:CreateToggle({
    Name = "Auto Buy Black Market",
    CurrentValue = false,
    Flag = "AutoBlackMarket",
    Callback = function(value45)
      v107 = value45

      if not value45 then
        return
      end

      if v108 then
        return
      end

      v108 = true

      task.spawn(function()
        while v107 do
          for key8, value46 in pairs(v106) do
            f20(key8)
            task.wait(0.1)
          end

          task.wait(5)
        end

        v108 = false
      end)
    end,
  })

  blackMarketTab:CreateSection("Item selection")

  local v155 = {}

  for index18, value47 in ipairs(v30) do
    local v156 = v13[value47]
    local renderImage2 = v156 and v156.renderImage or ""
    table.insert(v155, { Name = value47, Icon = renderImage2 })
  end

  blackMarketTab:CreateCardGrid({
    Items = v155,
    Columns = 3,
    Flag = "SelectedItems_BlackMarket",
    Callback = function(value48)
      v106 = {}

      for key9, value49 in pairs(value48) do
        if value49 then
          v106[key9] = true
        end
      end
    end,
  })
end

if #v35 > 0 then
  local alienShopTab = window:CreateTab("Alien Shop")
  alienShopTab:CreateSection("Auto Buy")

  alienShopTab:CreateToggle({
    Name = "Auto Buy Alien Shop",
    CurrentValue = false,
    Flag = "AutoAlienShop",
    Callback = function(value50)
      v132 = value50

      if not value50 then
        return
      end

      if v140 then
        return
      end

      v140 = true

      task.spawn(function()
        while v132 do
          for key10, value51 in pairs(v131) do
            f28(key10)
            task.wait(0.1)
          end

          task.wait(5)
        end

        v140 = false
      end)
    end,
  })

  alienShopTab:CreateSection("Item selection")

  local v157 = {}

  for index19, value52 in ipairs(v35) do
    local v158 = v13[value52]
    local renderImage3 = v158 and v158.renderImage or ""
    table.insert(v157, { Name = value52, Icon = renderImage3 })
  end

  alienShopTab:CreateCardGrid({
    Items = v157,
    Columns = 3,
    Flag = "SelectedItems_AlienShop",
    Callback = function(value53)
      v131 = {}

      for key11, value54 in pairs(value53) do
        if value54 then
          v131[key11] = true
        end
      end
    end,
  })
end
