local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "V8MXG" / (3311206 - "1zi2" ^ 2554958) end) })[2]
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
          pcall(function() return "8jAsELvC8b" / (9939760 - "PlCWXzpZ" ^ 2239045) end),
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
rayVoid:SetScriptName("Roll-An-Army")

local window = rayVoid:CreateWindow({
  Name = "Roll-An-Army | AKkiwi HUB",
  LoadingTitle = "Roll-An-Army Script",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "Roll-An-Army" },
})

local autoRollTab = window:CreateTab("AutoRoll", "gamepad-2")
local autoPlaceTab = window:CreateTab("AutoPlace", "swords")
local upgradesTab = window:CreateTab("Upgrades", "trending-up")
local shopTab = window:CreateTab("Shop", "shopping-cart")
local eventTab = window:CreateTab("Event", "skull")
local miscTab = window:CreateTab("Misc", "wrench")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local v12 = false
local v13 = false
local v14 = false
local v15 = false
local v16 = false
local v17 = false
local v18 = false
local v19 = false
local v20 = false
local v21 = false
local v22 = false
local v23 = false
local v24 = false
local v25 = 15
local v26 = {}
local v27 = {}
local v28 = {}
local v29 = {}
local v30 = true
local v31 = true

local v32 = {
  "Money Multiplier", "Damage Upgrade", "Roll Luck", "Number Rolls", "Zombie Tier Upgrade",
  "PlotExpansion",
}

local function f1(p1, p2)
  if p1 then
    pcall(function() p1:Set(p2) end)
  end
end

local function f2()
  return localPlayer.Parent ~= nil
end

local v33 = {
  "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Exotic", "Divine", "Secret",
  "Omega", "Godly", "Limited",
}

local function f3()
  local character = localPlayer.Character
  return character and character:FindFirstChildWhichIsA("Humanoid")
end

local function f4()
  local character2 = localPlayer.Character
  return character2 and character2:FindFirstChild("HumanoidRootPart")
end

local plots

local function f5()
  if not plots then
    return nil
  end

  for index, value in ipairs(plots:GetChildren()) do
    if value:GetAttribute("OwnerId") == localPlayer.UserId then
      return value
    end
  end

  return nil
end

local v34, rollRequest, buyUnit, interactPlot, purchaseGemShop, updateStocks, interactQuest,
  skullShop, v35, v36, v37, v38, v39

task.spawn(function()
  local v40, v41 = pcall(function()
    if not localPlayer.Character then
      localPlayer.CharacterAdded:Wait()
    end

    local remotes = replicatedStorage:WaitForChild("Remotes")
    rollRequest = remotes:WaitForChild("RollRequest")
    buyUnit = remotes:WaitForChild("Buy Unit")
    interactPlot = remotes:WaitForChild("InteractPlot")
    purchaseGemShop = remotes:WaitForChild("PurchaseGemShop")
    updateStocks = remotes:WaitForChild("UpdateStocks")
    interactQuest = remotes:WaitForChild("InteractQuest")
    skullShop = remotes:WaitForChild("SkullShop")
    v35 = require(replicatedStorage.Utility.Info.Rarities)
    v36 = require(replicatedStorage.Utility.Info.UnitInfo)
    v37 = require(replicatedStorage.Utility.Info.BoardInfo)
    v38 = require(replicatedStorage.Utility.Info.MutationInfo)
    v39 = require(replicatedStorage.Utility.Info.CrateInfo)
    plots = workspace:WaitForChild("Plots")
    local v42 = os.clock() + 30

    repeat
      v34 = f5()

      if v34 then
        break
      end

      task.wait(0.5)
    until os.clock() > v42

    if not v34 then
      error("could not resolve player plot (OwnerId never matched)")
    end

    v12 = true
  end)

  if not v40 then
    warn("[Init] failed:", v41)
  end
end)

local function f6()
  local count = 0

  for key in pairs(v26) do
    count = count + 1
  end

  return count
end

local function f7(p3, p4)
  return v26[p4] == true
end

local function f8(p5)
  local v43 = v35 and v35[p5]
  return v43 and v43.Order or 0
end

local function f9()
  local count2 = 0
  local v44 = 0
  local count3 = 0
  local v45 = {}
  local v46 = {}
  local count4 = 0
  local v47 = "—"
  local v48

  local function f10()
    if not v48 then
      local v49, v50 = pcall(function()
        return require(replicatedStorage.Data.DataService).client
      end)

      v48 = v49 and v50 or nil
    end

    if not v48 then
      return 0
    else
      local v51, v52 = pcall(function() return v48:get({ "Money" }) end)
      return v51 and tonumber(v52) or 0
    end
  end

  local function f11(p6)
    local v53 = v36 and v36[p6]
    return v53 and tonumber(v53.Cost) or 0
  end

  local lastRollParagraph = autoRollTab:CreateParagraph({ Title = "Last Roll", Content = "—" })
  local sessionParagraph = autoRollTab:CreateParagraph({ Title = "Session", Content = "0 rolls" })
  local autoBuyParagraph = autoRollTab:CreateParagraph({ Title = "Auto Buy", Content = "idle" })
  local v54

  local function f12()
    if v54 then
      local v55 = {}

      for index2, value2 in ipairs(v54) do
        local format = string.format
        local v56 = #v55 + 1

        v55[v56] = format(
          "%s  %s  %s", value2.PodiumName or "?", value2.Rarity or "?", value2.Unit or "?"
        )
      end

      f1(lastRollParagraph, { Title = "Last Roll", Content = table.concat(v55, "\n") })
    end

    local v57 = {}

    for key2 in pairs(v45) do
      v57[#v57 + 1] = key2
    end

    table.sort(v57, function(p7, p8) return f8(p7) > f8(p8) end)
    local v58 = {}

    for index3, value3 in ipairs(v57) do
      v58[#v58 + 1] = string.format("%s x%d", value3, v45[value3])
    end

    f1(sessionParagraph, {
      Title = "Session",
      Content = string.format([[
%d rolls
%s]], count3, #v58 > 0 and table.concat(v58, "  ·  ") or "—"),
    })
  end

  local function f13()
    f1(autoBuyParagraph, {
      Title = "Auto Buy",
      Content = string.format(
        "%s  ·  %d unit(s) picked  ·  %d bought this session  ·  last: %s",
        v14 and "ON" or "off", f6(), count4, v47
      ),
    })
  end

  task.spawn(function()
    while not v12 do
      task.wait(0.2)
    end

    rollRequest.OnClientEvent:Connect(function(p9)
      v44 = os.clock()

      if type(p9) ~= "table" then
        return
      end

      v54 = p9

      for index4, value4 in ipairs(p9) do
        count3 = count3 + 1

        if value4.Rarity then
          v45[value4.Rarity] = (v45[value4.Rarity] or 0) + 1
        end

        if value4.Unit then
          v46[value4.Unit] = (v46[value4.Unit] or 0) + 1
        end
      end

      f12()

      if v14 and buyUnit then
        task.spawn(function()
          for index5, value5 in ipairs(p9) do
            local v59 = value5

            if v59.Unit and v59.PodiumName and f7(v59.Rarity, v59.Unit) then
              local v60 = f11(v59.Unit)

              if f10() < v60 then
                v47 = string.format("skip %s (need $%d)", v59.Unit, v60)
              else
                local v61, v62 = pcall(function()
                  return buyUnit:InvokeServer(v59.Unit, v59.PodiumName)
                end)

                v47 = v61 and tostring(v62) or "ERR " .. tostring(v62)

                if v61 and v62 == "Success" then
                  count4 = count4 + 1
                end
              end
            end
          end

          f13()
        end)
      end
    end)
  end)

  local function f14()
    count2 = count2 + 1
  end

  local function f15()
    f14()
    local v63 = count2

    if not v13 then
      return
    end

    task.spawn(function()
      while v13 and v63 == count2 and f2() do
        if not v12 or not rollRequest then
          task.wait(0.5)
        else
          local v64 = os.clock()
          pcall(function() rollRequest:FireServer() end)

          while v13 and v63 == count2 and f2() do
            if v44 >= v64 then
              break
            end

            if os.clock() - v64 > 6 then
              break
            end

            task.wait(0.1)
          end

          task.wait(0.15)
        end
      end
    end)
  end

  autoRollTab:CreateToggle({
    Name = "Auto Roll",
    CurrentValue = v13,
    Flag = "RAA_AutoRoll",
    Callback = function(value6)
      v13 = value6

      if value6 then
        f15()
      else
        f14()
      end
    end,
  })

  autoRollTab:CreateToggle({
    Name = "Auto Buy rolled units (pick units in the grid below)",
    CurrentValue = v14,
    Flag = "RAA_AutoBuy",
    Callback = function(value7)
      v14 = value7
      f13()
    end,
  })

  return {
    StartFromConfig = function()
      f13()

      if v13 then
        f15()
      end
    end,
    Stop = function()
      v13 = false
      v14 = false
      f14()
    end,
    GetLastRoll = function() return v54 end,
    GetTally = function() return count3, v45, v46 end,
  }
end

local v65 = f9()

local function f16()
  local count5 = 0
  local total = 0
  local v66 = "—"
  local v67

  local function f17()
    if not v67 then
      local v68, v69 = pcall(function()
        return require(replicatedStorage.Data.DataService).client
      end)

      v67 = v68 and v69 or nil
    end

    return v67
  end

  local getUnitDPS

  local function f18()
    if getUnitDPS == nil then
      local v70, v71 = pcall(function()
        return require(replicatedStorage.Utility.Prices.getUnitDps)
      end)

      getUnitDPS = v70 and type(v71) == "table" and v71.getUnitDPS or false
    end

    return getUnitDPS or nil
  end

  local function f19()
    local v72 = f17()

    if not v72 then
      return {}
    else
      local v73, v74 = pcall(function() return v72:get({ "Slots" }) end)
      return v73 and type(v74) == "table" and v74 or {}
    end
  end

  local function f20()
    local v75 = f17()

    if not v75 then
      return {}
    else
      local v76, v77 = pcall(function() return v75:get({ "units" }) end)
      return v76 and type(v77) == "table" and v77 or {}
    end
  end

  local function f21(p10, p11)
    local v78 = f18()

    if v78 then
      local v79, v80 = pcall(v78, p10.BaseDPS, p11.level or 1, nil, p11.mutation, p11.Trait)

      if v79 and type(v80) == "number" then
        return v80
      end

      return p10.BaseDPS or 0
    end

    return p10.BaseDPS or 0
  end

  local function f22()
    local v81 = 0

    for index6, value8 in ipairs(f20()) do
      local v82 = v36 and v36[value8.UnitName]

      if v82 and not v82.Better then
        local v83 = f21(v82, value8)

        if v83 > v81 then
          v81 = v83
        end
      end
    end

    return v81
  end

  local function f23(p12)
    local v84 = v36 and v36[p12.UnitName]

    if not v84 then
      return 0
    end

    if v84.Better then
      local damageMultiplier = 1
      local v85 = v38 and v38[p12.mutation]

      if v85 and v85.DamageMultiplier then
        damageMultiplier = v85.DamageMultiplier
      end

      return f22() * (v84.BaseDPS or 0) * damageMultiplier
    end

    return f21(v84, p12)
  end

  local function f24(p13)
    for index7, value9 in ipairs(f19()) do
      if value9.slotName == p13 then
        return value9.unitPlaced ~= nil
      end
    end

    return false
  end

  local function f25(p14)
    local plotLayers = v34 and v34:FindFirstChild("Plot Layers")

    if not plotLayers then
      return nil
    end

    for index8, value10 in ipairs(plotLayers:GetChildren()) do
      local slots = value10:FindFirstChild("Slots")

      local findFirstChild = slots
      findFirstChild = slots and slots:FindFirstChild(p14)

      if findFirstChild then
        return findFirstChild
      end
    end

    return nil
  end

  local function f26(p15)
    local backpack = localPlayer:FindFirstChild("Backpack")

    if not backpack then
      return nil
    end

    for index9, value11 in ipairs(backpack:GetChildren()) do
      if value11:IsA("Tool") and (value11.Name == p15 or value11:GetAttribute("UnitId") == p15) then
        return value11
      end
    end

    return nil
  end

  local function f27(p16, p17)
    if not (p17 and interactPlot) then
      return nil
    else
      local v86, v87 = pcall(function() return interactPlot:InvokeServer(p16, p17) end)
      return v86 and v87 or nil
    end
  end

  local function f28(p18, p19, p20, p21)
    local v88

    for k = 1, 10 do
      v88 = f27(p18, p19)

      if v88 == "Success" then
        return v88
      end

      if p20 and f24(p20) == p21 then
        return v88 or "Success"
      elseif v88 == "Cooldown" then
        task.wait(0.4)
      else
        return v88
      end
    end

    return v88
  end

  local function f29()
    local v89 = {}

    for index10, value12 in ipairs(f19()) do
      if value12.purchased then
        v89[#v89 + 1] = value12.slotName
      end
    end

    return v89
  end

  local function f30()
    local v90 = {}

    for index11, value13 in ipairs(f20()) do
      if value13.unitId then
        v90[#v90 + 1] = { row = value13, dps = f23(value13) }
      end
    end

    table.sort(v90, function(p22, p23) return p22.dps > p23.dps end)
    return v90
  end

  local function f31()
    local v91 = f29()
    local v92 = f30()
    local v93 = {}

    for m = 1, math.min(#v91, #v92) do
      v93[v92[m].row.unitId] = true
    end

    return v93
  end

  local function f32()
    local v94 = {}

    for index12, value14 in ipairs(f19()) do
      if value14.unitPlaced ~= nil then
        v94[value14.unitPlaced] = true
      end
    end

    return v94
  end

  local function f33()
    local v95 = f31()
    local v96 = f32()

    for key3 in pairs(v95) do
      if not v96[key3] then
        return true
      end
    end

    for key4 in pairs(v96) do
      if not v95[key4] then
        return true
      end
    end

    return false
  end

  local function f34()
    for index13, value15 in ipairs(f19()) do
      if value15.unitPlaced ~= nil then
        local v97 = f25(value15.slotName)

        if v97 then
          f28("RemoveUnit", v97, value15.slotName, false)
          task.wait(0.25)
        end
      end
    end
  end

  local f35

  local function f36(p24)
    local v98 = f29()
    local v99 = f30()
    local count6 = 0

    for index14, value16 in ipairs(v98) do
      if not (v15 and p24 == count5 and f2()) then
        break
      else
        local v100 = v99[index14]
        local v101 = v100 and f26(v100.row.unitId)
        local v102 = f25(value16)
        local v103 = f3()

        if v100 and v101 and v102 and v103 then
          v103:EquipTool(v101)
          task.wait(0.1)
          local v104 = f28("PlaceUnit", v102, value16, true)

          v66 = string.format(
            "%s L%d (%s DPS) → %s", v100.row.UnitName, v100.row.level or 1,
            tostring(math.floor(v100.dps or 0)), tostring(v104)
          )

          if v104 == "Success" or f24(value16) then
            count6 = count6 + 1
          end

          f35()
          task.wait(0.25)
        end
      end
    end

    total = total + count6
  end

  local function f37(p25)
    f34()
    task.wait(0.4)
    f36(p25)
  end

  local function f38()
    count5 = count5 + 1
    local v105 = count5

    if not v15 then
      return
    end

    task.spawn(function()
      while v15 and v105 == count5 and f2() do
        if not v12 then
          task.wait(0.5)
        else
          if f33() then
            f37(v105)
            f35()
          end

          local count7 = 0

          while v15 and v105 == count5 and f2() and count7 < 300 do
            task.wait(1)
            count7 = count7 + 1
          end
        end
      end
    end)
  end

  local paragraph = autoPlaceTab:CreateParagraph({
    Title = "Auto Place (best DPS)",
    Content = "idle",
  })

  function f35()
    f1(paragraph, {
      Title = "Auto Place (best DPS)",
      Content = string.format(
        "%s  ·  re-pass every 5 min  ·  %d placed this session  ·  last: %s",
        v15 and "ON" or "off", total, v66
      ),
    })
  end

  autoPlaceTab:CreateToggle({
    Name = "Auto Place — best DPS first (re-checks every 5 min)",
    CurrentValue = v15,
    Flag = "RAA_AutoPlace",
    Callback = function(value17)
      v15 = value17

      if value17 then
        f38()
      else
        count5 = count5 + 1
      end

      f35()
    end,
  })

  autoPlaceTab:CreateButton({
    Name = "Remove ALL placed units (→ backpack)",
    Callback = function()
      task.spawn(function()
        for index15, value18 in ipairs(f19()) do
          if value18.unitPlaced ~= nil then
            local v106 = f25(value18.slotName)

            if v106 then
              v66 = "RemoveUnit → "
                .. tostring(f28("RemoveUnit", v106, value18.slotName, false))

              f35()
              task.wait(0.25)
            end
          end
        end
      end)
    end,
  })

  return {
    StartFromConfig = function()
      f35()

      if v15 then
        f38()
      end
    end,
    Stop = function()
      v15 = false
      count5 = count5 + 1
    end,
  }
end

local v107 = f16()

local function f39()
  local count8 = 0
  local v108 = "—"
  local v109

  local function f40()
    if not v109 then
      local v110, v111 = pcall(function()
        return require(replicatedStorage.Data.DataService).client
      end)

      v109 = v110 and v111 or nil
    end

    return v109
  end

  local function f41(p26)
    local v112 = f40()

    if not v112 then
      return 1
    else
      local v113, v114 = pcall(function() return v112:get({ "UpgradeBoardLevels", p26 }) end)
      return v113 and tonumber(v114) or 1
    end
  end

  local function f42(p27)
    local v115, v116 = pcall(function() return v37.GetBoardInfo(p27) end)
    return v115 and v116 and v116.upgradeMax or math.huge
  end

  local function f43(p28)
    return f41(p28) >= f42(p28)
  end

  local function f44()
    local v117 = f40()

    if not v117 then
      return 0
    else
      local v118, v119 = pcall(function() return v117:get({ "Money" }) end)
      return v118 and tonumber(v119) or 0
    end
  end

  local function f45(p29)
    local v120, v121 = pcall(function() return v37.GetBoardInfo(p29) end)

    if not (v120 and v121 and type(v121.ValueFunction) == "function") then
      return 0
    else
      local v122, v123 = pcall(v121.ValueFunction, f41(p29))
      return v122 and tonumber(v123) or 0
    end
  end

  local function f46()
    local v124 = next(v27) ~= nil
    local v125 = {}

    for index16, value19 in ipairs(v32) do
      if not v124 or v27[value19] then
        v125[#v125 + 1] = value19
      end
    end

    return v125
  end

  local paragraph2

  local function f47()
    local v126 = {}

    for index17, value20 in ipairs(v32) do
      local v127 = f42(value20)
      local v128 = #v126 + 1

      v126[v128] = string.format(
        "%s %s/%s", value20, tostring(f41(value20)), v127 == math.huge and "?" or tostring(v127)
      )
    end

    f1(paragraph2, {
      Title = "Auto Upgrade  (" .. (v16 and "ON" or "off") .. ")",
      Content = table.concat(v126, "\n") .. "\nlast: " .. v108,
    })
  end

  local function f48()
    count8 = count8 + 1
    local v129 = count8

    if not v16 then
      return
    end

    task.spawn(function()
      while v16 and v129 == count8 and f2() do
        if not v12 or not interactPlot then
          task.wait(0.5)
        else
          local v130 = v30 and "PurchaseMaxUpgrade" or "PurchaseUpgrade"
          local v131 = false

          for index18, value21 in ipairs(f46()) do
            local v132 = value21

            if not (v16 and v129 == count8 and f2()) then
              break
            elseif not f43(v132) then
              local v133 = f45(v132)

              if f44() < v133 then
                v108 = string.format("skip %s (need $%d)", v132, v133)
              else
                local v134, v135 = pcall(function()
                  return interactPlot:InvokeServer(v130, v132)
                end)

                v108 = string.format(
                  "%s %s → %s", v130, v132, v134 and tostring(v135) or "err"
                )

                if v134 and v135 == "Success" then
                  v131 = true
                end
              end

              f47()
              task.wait(0.25)
            end
          end

          task.wait(v131 and 0.75 or 4)
        end
      end
    end)
  end

  paragraph2 = upgradesTab:CreateParagraph({ Title = "Auto Upgrade  (off)", Content = "…" })

  upgradesTab:CreateToggle({
    Name = "Auto Upgrade boards",
    CurrentValue = v16,
    Flag = "RAA_AutoUpgrade",
    Callback = function(value22)
      v16 = value22

      if value22 then
        f48()
      else
        count8 = count8 + 1
      end

      f47()
    end,
  })

  upgradesTab:CreateToggle({
    Name = "Buy \"Max\" each pass (off = one level at a time)",
    CurrentValue = v30,
    Flag = "RAA_UpgradeUseMax",
    Callback = function(value23) v30 = value23 end,
  })

  upgradesTab:CreateMultiToggle({
    Label = "Boards to upgrade (empty = all)",
    Options = v32,
    Flag = "RAA_UpgradeBoards",
    Callback = function(value24) v27 = value24 end,
  })

  upgradesTab:CreateButton({
    Name = "Upgrade selected once (manual pass)",
    Callback = function()
      task.spawn(function()
        local v136 = v30 and "PurchaseMaxUpgrade" or "PurchaseUpgrade"

        for index19, value25 in ipairs(f46()) do
          local v137 = value25

          if not f43(v137) then
            local v138, v139 = pcall(function() return interactPlot:InvokeServer(v136, v137) end)
            v108 = string.format("%s %s → %s", v136, v137, v138 and tostring(v139) or "err")
            f47()
            task.wait(0.25)
          end
        end
      end)
    end,
  })

  return {
    StartFromConfig = function()
      f47()

      if v16 then
        f48()
      end
    end,
    Stop = function()
      v16 = false
      count8 = count8 + 1
    end,
  }
end

local v140 = f39()

local function f49()
  local count9 = 0
  local v141 = "—"
  local v142

  local function f50()
    if not v142 then
      local v143, v144 = pcall(function()
        return require(replicatedStorage.Data.DataService).client
      end)

      v142 = v143 and v144 or nil
    end

    return v142
  end

  local getUpgradeCost

  local function f51()
    if getUpgradeCost == nil then
      local v145, v146 = pcall(function()
        return require(replicatedStorage.Utility.Prices.getUpgradeCost)
      end)

      getUpgradeCost = v145 and type(v146) == "table" and v146.GetUpgradeCost or false
    end

    return getUpgradeCost or nil
  end

  local function f52()
    local v147 = f50()

    if not v147 then
      return 0
    else
      local v148, v149 = pcall(function() return v147:get({ "Money" }) end)
      return v148 and tonumber(v149) or 0
    end
  end

  local function f53(p30)
    local v150 = f50()

    if not v150 then
      return nil
    else
      local v151, v152 = pcall(function() return v150:get(p30) end)
      return v151 and v152 or nil
    end
  end

  local function f54(p31)
    local plotLayers2 = v34 and v34:FindFirstChild("Plot Layers")

    if not plotLayers2 then
      return nil
    end

    for index20, value26 in ipairs(plotLayers2:GetChildren()) do
      local slots2 = value26:FindFirstChild("Slots")

      local findFirstChild2 = slots2
      findFirstChild2 = slots2 and slots2:FindFirstChild(p31)

      if findFirstChild2 then
        return findFirstChild2
      end
    end

    return nil
  end

  local function f55(p32, p33)
    local v153 = f54(p32)

    if not (v153 and interactPlot) then
      return 0
    else
      local count10 = 0

      for n = 1, 200 do
        if not (v17 and f2()) then
          break
        else
          local v154 = f53({ "units" }) or {}
          local v155 = nil

          for index21, value27 in ipairs(v154) do
            if value27.unitId == p33 then
              v155 = value27
              break
            end
          end

          if not v155 then
            break
          else
            local v156 = v36 and v36[v155.UnitName]

            if not v156 or v156.Better then
              break
            else
              local v157 = v29[v156.Rarity or ""]

              if (v155.level or 1) >= (v157 or 1) then
                break
              else
                local v158 = f51()
                local v159 = v158 and v158(v156.BaseUpgradeCost or 0, v155.level or 1) or 0

                if f52() < v159 then
                  v141 = string.format("%s L%d: need $%d", v155.UnitName, v155.level or 1, v159)
                  break
                else
                  local v160, v161 = pcall(function()
                    return interactPlot:InvokeServer("UpgradeUnit", v153)
                  end)

                  local v162 = v160 and v161 or "err"

                  if v162 ~= "Success" then
                    v141 = string.format(
                      "%s L%d → %s", v155.UnitName, v155.level or 1, tostring(v162)
                    )

                    if v162 == "Cooldown" then
                      task.wait(0.4)
                    else
                      break
                    end
                  else
                    count10 = count10 + 1
                    v141 = string.format("%s → L%d", v155.UnitName, (v155.level or 1) + 1)
                    task.wait(0.1)
                  end
                end
              end
            end
          end
        end
      end

      return count10
    end
  end

  local paragraph3

  local function f56()
    f1(paragraph3, {
      Title = "Auto Unit Upgrade  (" .. (v17 and "ON" or "off") .. ")",
      Content = [[
per-rarity target levels below
last: ]] .. v141,
    })
  end

  local function f57()
    count9 = count9 + 1
    local v163 = count9

    if not v17 then
      return
    end

    task.spawn(function()
      while v17 and v163 == count9 and f2() do
        if not v12 or not interactPlot then
          task.wait(0.5)
        else
          for index22, value28 in ipairs(f53({ "Slots" }) or {}) do
            if not (v17 and v163 == count9 and f2()) then
              break
            elseif value28.unitPlaced then
              f55(value28.slotName, value28.unitPlaced)
            end
          end

          f56()
          task.wait(2)
        end
      end
    end)
  end

  paragraph3 = upgradesTab:CreateParagraph({
    Title = "Auto Unit Upgrade  (off)",
    Content = "…",
  })

  upgradesTab:CreateToggle({
    Name = "Auto Upgrade placed units (to per-rarity level)",
    CurrentValue = v17,
    Flag = "RAA_AutoUnitUpgrade",
    Callback = function(value29)
      v17 = value29

      if value29 then
        f57()
      else
        count9 = count9 + 1
      end

      f56()
    end,
  })

  for index23, value30 in ipairs(v33) do
    local v164 = value30

    upgradesTab:CreateInput({
      Name = v164 .. " → target level",
      PlaceholderText = "1 = off",
      CurrentValue = "1",
      RemoveTextAfterFocusLost = false,
      Flag = "RAA_UpgLvl_" .. v164,
      Callback = function(value31)
        local v165 = tonumber(value31)
        v29[v164] = v165 and v165 >= 1 and math.floor(v165) or 1
      end,
    })
  end

  return {
    StartFromConfig = function()
      f56()

      if v17 then
        f57()
      end
    end,
    Stop = function()
      v17 = false
      count9 = count9 + 1
    end,
  }
end

local v166 = f49()

local function f58()
  local count11 = 0
  local v167 = "—"
  local v168 = {}
  local v169

  local function f59()
    if not v169 then
      local v170, v171 = pcall(function()
        return require(replicatedStorage.Data.DataService).client
      end)

      v169 = v170 and v171 or nil
    end

    return v169
  end

  local function f60()
    local v172 = f59()

    if not v172 then
      return 0
    else
      local v173, v174 = pcall(function() return v172:get({ "Gems" }) end)
      return v173 and tonumber(v174) or 0
    end
  end

  local function f61()
    local v175 = {}

    if v38 then
      for key5, value32 in pairs(v38) do
        if value32.GemShop == true then
          v175[key5] = { icon = value32.Image or "", cost = value32.Cost or 0, isCrate = false }
        end
      end
    end

    if v39 then
      for key6, value33 in pairs(v39) do
        if value33.GemShop == true then
          v175[key6] = { icon = value33.Image or "", cost = value33.Cost or 0, isCrate = true }
        end
      end
    end

    return v175
  end

  local paragraph4

  local function f62()
    local v176 = {}

    for key7, value34 in pairs(f61()) do
      local v177 = v168[key7]
      local v178 = #v176 + 1
      v176[v178] = string.format("%s: %s", key7, v177 and v177 > 0 and v177 .. "x" or "—")
    end

    table.sort(v176)

    f1(paragraph4, {
      Title = "Auto Shop  (" .. (v18 and "ON" or "off") .. ")  ·  " .. f60() .. " Gems",
      Content = table.concat(v176, "\n") .. "\nlast: " .. v167,
    })
  end

  task.spawn(function()
    while not v12 do
      task.wait(0.2)
    end

    updateStocks.OnClientEvent:Connect(function(p34)
      if type(p34) == "table" then
        v168 = p34
        f62()
      end
    end)
  end)

  local function f63()
    count11 = count11 + 1
    local v179 = count11

    if not v18 then
      return
    end

    task.spawn(function()
      while v18 and v179 == count11 and f2() do
        if not v12 or not purchaseGemShop then
          task.wait(0.5)
        else
          pcall(function() updateStocks:FireServer() end)
          task.wait(0.6)
          local v180 = f61()

          for key8 in pairs(v28) do
            local v181 = key8

            if not (v18 and v179 == count11 and f2()) then
              break
            else
              local v182 = v180[v181]

              if v182 and (v168[v181] or 0) > 0 and f60() >= v182.cost then
                local v183, v184 = pcall(function()
                  return purchaseGemShop:InvokeServer("Purchase", v181)
                end)

                v167 = string.format(
                  "Purchase %s → %s", v181, v183 and tostring(v184) or "err"
                )

                if v183 and v184 == "Success" and v182.isCrate and v31 then
                  task.wait(0.2)
                  pcall(function() purchaseGemShop:InvokeServer("Use", v181) end)
                  v167 = v167 .. " + opened"
                end

                f62()
                task.wait(0.35)
              end
            end
          end

          task.wait(3)
        end
      end
    end)
  end

  paragraph4 = shopTab:CreateParagraph({ Title = "Auto Shop  (off)", Content = "…" })

  shopTab:CreateToggle({
    Name = "Auto Shop (buy selected when in stock)",
    CurrentValue = v18,
    Flag = "RAA_AutoShop",
    Callback = function(value35)
      v18 = value35

      if value35 then
        f63()
      else
        count11 = count11 + 1
      end

      f62()
    end,
  })

  shopTab:CreateToggle({
    Name = "Open crates right after buying",
    CurrentValue = v31,
    Flag = "RAA_ShopOpenCrates",
    Callback = function(value36) v31 = value36 end,
  })

  task.spawn(function()
    while not v12 do
      task.wait(0.2)
    end

    local v185 = {}

    for key9, value37 in pairs(f61()) do
      v185[#v185 + 1] = { Name = key9, Icon = value37.icon, _cost = value37.cost }
    end

    table.sort(v185, function(p35, p36) return p35._cost < p36._cost end)

    if #v185 == 0 then
      return
    end

    shopTab:CreateCardGrid({
      Items = v185,
      Columns = 3,
      Flag = "RAA_ShopSelection",
      Callback = function(value38) v28 = value38 end,
    })

    f62()
  end)

  return {
    StartFromConfig = function()
      f62()

      if v18 then
        f63()
      end
    end,
    Stop = function()
      v18 = false
      count11 = count11 + 1
    end,
  }
end

local v186 = f58()

local function f64()
  local count12 = 0
  local v187 = "—"
  local v188

  local function f65()
    if not v188 then
      local v189, v190 = pcall(function()
        return require(replicatedStorage.Data.DataService).client
      end)

      v188 = v189 and v190 or nil
    end

    return v188
  end

  local function f66()
    local v191 = f65()

    if not v191 then
      return 0
    else
      local v192, v193 = pcall(function() return v191:get({ "ClaimableMoney" }) end)
      return v192 and tonumber(v193) or 0
    end
  end

  local function f67()
    local moneyClaim = v34 and v34:FindFirstChild("Money Claim")
    return moneyClaim and moneyClaim:FindFirstChild("Hitbox")
  end

  local function f68()
    local v194 = f67()
    local v195 = f4()
    local v196 = v194 and v195
    local cframe, v197

    if not v196 then
      return false
    else
      local v198 = f66()
      cframe = v195.CFrame
      pcall(function() v195.CFrame = v194.CFrame + Vector3.new(0, 3, 0) end)
      task.wait(1.5)
      v197 = f4()

      if v197 then
        pcall(function()
          v197.CFrame = cframe
          v197.AssemblyLinearVelocity = Vector3.zero
        end)
      end

      v187 = string.format("collected ~%s", tostring(math.floor(v198 - f66())))
      return true
    end
  end

  local paragraph5

  local function f69()
    f1(paragraph5, {
      Title = "Auto Collect  (" .. (v19 and "ON" or "off") .. ")",
      Content = string.format(
        "claimable now: %s\nevery %ds  ·  last: %s", tostring(math.floor(f66())), v25, v187
      ),
    })
  end

  local function f70()
    count12 = count12 + 1
    local v199 = count12

    if not v19 then
      return
    end

    task.spawn(function()
      while v19 and v199 == count12 and f2() do
        if not v12 then
          task.wait(0.5)
        else
          if f66() > 0 then
            f68()
            f69()
          end

          local total2 = 0

          while v19 and v199 == count12 and f2() and total2 < v25 do
            task.wait(0.5)
            total2 = total2 + 0.5
          end
        end
      end
    end)
  end

  paragraph5 = miscTab:CreateParagraph({ Title = "Auto Collect  (off)", Content = "…" })

  miscTab:CreateToggle({
    Name = "Auto Collect money",
    CurrentValue = v19,
    Flag = "RAA_AutoCollect",
    Callback = function(value39)
      v19 = value39

      if value39 then
        f70()
      else
        count12 = count12 + 1
      end

      f69()
    end,
  })

  miscTab:CreateSlider({
    Name = "Collect interval",
    Range = { 5, 120 },
    Increment = 5,
    CurrentValue = v25,
    Suffix = "s",
    Flag = "RAA_CollectInterval",
    Callback = function(value40)
      v25 = math.floor(tonumber(value40) or 15)
      f69()
    end,
  })

  miscTab:CreateButton({
    Name = "Collect money now",
    Callback = function()
      task.spawn(function()
        f68()
        f69()
      end)
    end,
  })

  return {
    StartFromConfig = function()
      f69()

      if v19 then
        f70()
      end
    end,
    Stop = function()
      v19 = false
      count12 = count12 + 1
    end,
  }
end

local v200 = f64()

local function f71()
  local count13 = 0
  local v201 = "—"
  local v202

  local function f72()
    if not v202 then
      local v203, v204 = pcall(function()
        return require(replicatedStorage.Data.DataService).client
      end)

      v202 = v203 and v204 or nil
    end

    if not v202 then
      return nil
    else
      local v205, v206 = pcall(function() return v202:get({ "Quests" }) end)
      return v205 and type(v206) == "table" and v206 or nil
    end
  end

  local function f73(p37, entry)
    if not interactQuest then
      return nil
    else
      local v207, v208 = pcall(function()
        return interactQuest:InvokeServer("Claim", { Type = p37, Entry = entry })
      end)

      return v207 and v208 or nil
    end
  end

  local function f74(p38, p39)
    if type(p39) ~= "table" then
      return 0
    else
      local count14 = 0

      for index24, value41 in ipairs(p39.Quests or {}) do
        if value41.Completed and not value41.Claimed then
          v201 = string.format(
            "%s #%d (%s) → %s", p38, index24, value41.Name or "?", tostring(f73(p38, index24))
          )

          count14 = count14 + 1
          task.wait(0.3)
        end
      end

      local meta = p39.Meta

      if type(meta) == "table" and meta.Completed and not meta.Claimed then
        v201 = string.format("%s Meta → %s", p38, tostring(f73(p38, "Meta")))
        count14 = count14 + 1
        task.wait(0.3)
      end

      return count14
    end
  end

  local function f75(p40)
    if type(p40) ~= "table" then
      return 0, 0
    else
      local count15 = 0
      local count16 = 0

      for index25, value42 in ipairs(p40.Quests or {}) do
        count15 = count15 + 1

        if value42.Completed and not value42.Claimed then
          count16 = count16 + 1
        end
      end

      if type(p40.Meta) == "table" and p40.Meta.Completed and not p40.Meta.Claimed then
        count16 = count16 + 1
      end

      return count16, count15
    end
  end

  local paragraph6

  local function f76()
    local v209 = f72()
    local v210, v211 = f75(v209 and v209.Daily)
    local v212, v213 = f75(v209 and v209.Weekly)

    f1(paragraph6, {
      Title = "Auto Quest  (" .. (v20 and "ON" or "off") .. ")",
      Content = string.format([[
Daily: %d claimable / %d
Weekly: %d claimable / %d
last: %s]], v210, v211, v212, v213, v201),
    })
  end

  local function f77()
    count13 = count13 + 1
    local v214 = count13

    if not v20 then
      return
    end

    task.spawn(function()
      while v20 and v214 == count13 and f2() do
        if not v12 or not interactQuest then
          task.wait(0.5)
        else
          local v215 = f72()

          if v215 then
            f74("Daily", v215.Daily)
            f74("Weekly", v215.Weekly)
            f76()
          end

          local count17 = 0

          while v20 and v214 == count13 and f2() and count17 < 30 do
            task.wait(1)
            count17 = count17 + 1
          end
        end
      end
    end)
  end

  paragraph6 = miscTab:CreateParagraph({ Title = "Auto Quest  (off)", Content = "…" })

  miscTab:CreateToggle({
    Name = "Auto Claim quests (Daily + Weekly)",
    CurrentValue = v20,
    Flag = "RAA_AutoQuest",
    Callback = function(value43)
      v20 = value43

      if value43 then
        f77()
      else
        count13 = count13 + 1
      end

      f76()
    end,
  })

  miscTab:CreateButton({
    Name = "Claim quests now",
    Callback = function()
      task.spawn(function()
        local v216 = f72()

        if v216 then
          f74("Daily", v216.Daily)
          f74("Weekly", v216.Weekly)
        end

        f76()
      end)
    end,
  })

  return {
    StartFromConfig = function()
      f76()

      if v20 then
        f77()
      end
    end,
    Stop = function()
      v20 = false
      count13 = count13 + 1
    end,
  }
end

local v217 = f71()

local function f78()
  local virtualUser = game:GetService("VirtualUser")
  local connect

  local function f79()
    if connect then
      return
    end

    connect = localPlayer.Idled:Connect(function()
      if not v21 then
        return
      end

      pcall(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
      end)
    end)
  end

  local function f80()
    if connect then
      connect:Disconnect()
      connect = nil
    end
  end

  miscTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = v21,
    Flag = "RAA_AntiAfk",
    Callback = function(value44)
      v21 = value44

      if value44 then
        f79()
      else
        f80()
      end
    end,
  })

  return {
    StartFromConfig = function()
      if v21 then
        f79()
      end
    end,
    Stop = function()
      v21 = false
      f80()
    end,
  }
end

local v218 = f78()

local function f81()
  local count18 = 0
  local v219 = "—"
  local v220

  local function f82()
    if not v220 then
      local v221, v222 = pcall(function()
        return require(replicatedStorage.Data.DataService).client
      end)

      v220 = v221 and v222 or nil
    end

    return v220
  end

  local function f83(p41, p42)
    local v223 = f82()

    if not v223 then
      return p42
    else
      local v224, v225 = pcall(function() return v223:get(p41) end)

      if v224 and v225 ~= nil then
        return v225
      end

      return p42
    end
  end

  local function f84()
    return tonumber(f83({ "SkeletonEvent", "Skulls" }, 0)) or 0
  end

  local function f85()
    return tonumber(f83({ "SkeletonEvent", "Cost" }, 200)) or 200
  end

  local function f86()
    return tonumber(f83({ "item_inventory", "Crates", "Skeletal Crate" }, 0)) or 0
  end

  local function f87()
    return tonumber(f83({ "SkeletonEvent", "Skull_Multiplier" }, 1)) or 1
  end

  local function f88()
    return 2 ^ (f87() - 1) * 25
  end

  local function f89(...)
    if not skullShop then
      return nil
    else
      local v226 = { ... }

      local v227, v228, v229 = pcall(function()
        return skullShop:InvokeServer(table.unpack(v226))
      end)

      if not v227 then
        return "err"
      end

      return v228, v229
    end
  end

  local eventParagraph

  local function f90()
    f1(eventParagraph, {
      Title = "Event  ·  " .. f84() .. " skulls",
      Content = string.format("Skeletal Crates: %d   ·   Skull mult: x%d/5\nweather: %s\nlast: %s", f86(), f87(), tostring(workspace:FindFirstChild("Current Weather")
          and workspace["Current Weather"].Value
        or "?"), v219),
    })
  end

  local function f91()
    count18 = count18 + 1
    local v230 = count18

    if not (v22 or v23 or v24) then
      return
    end

    task.spawn(function()
      while (v22 or v23 or v24) and v230 == count18 and f2() do
        if not v12 or not skullShop then
          task.wait(0.5)
        else
          if v24 and f87() < 5 and f84() >= f88() then
            v219 = "Upgrade → " .. tostring(f89("Upgrade"))
            f90()
            task.wait(0.3)
          end

          if v22 and f84() >= f85() then
            v219 = "BuyCrate → " .. tostring(f89("BuyCrate", "Skeletal Crate"))
            f90()
            task.wait(0.3)
          end

          if v23 and f86() > 0 then
            local v231, v232 = f89("UseCrate", "Skeletal Crate")
            v219 = string.format("UseCrate → %s (%s)", tostring(v231), tostring(v232))
            f90()
            task.wait(0.3)
          end

          task.wait(1.5)
        end
      end
    end)
  end

  local function f92()
    if v22 or v23 or v24 then
      f91()
    else
      count18 = count18 + 1
    end

    f90()
  end

  eventParagraph = eventTab:CreateParagraph({ Title = "Event", Content = "…" })

  eventTab:CreateToggle({
    Name = "Auto Buy Skeletal Crates (while skulls ≥ cost)",
    CurrentValue = v22,
    Flag = "RAA_EventAutoBuy",
    Callback = function(value45)
      v22 = value45
      f92()
    end,
  })

  eventTab:CreateToggle({
    Name = "Auto Open Skeletal Crates",
    CurrentValue = v23,
    Flag = "RAA_EventAutoOpen",
    Callback = function(value46)
      v23 = value46
      f92()
    end,
  })

  eventTab:CreateToggle({
    Name = "Auto Upgrade Skull Multiplier (→ x5)",
    CurrentValue = v24,
    Flag = "RAA_EventAutoUpgrade",
    Callback = function(value47)
      v24 = value47
      f92()
    end,
  })

  eventTab:CreateButton({
    Name = "Buy 1 Skeletal Crate",
    Callback = function()
      task.spawn(function()
        v219 = "BuyCrate → " .. tostring(f89("BuyCrate", "Skeletal Crate"))
        f90()
      end)
    end,
  })

  eventTab:CreateButton({
    Name = "Open 1 Skeletal Crate",
    Callback = function()
      task.spawn(function()
        local v233, v234 = f89("UseCrate", "Skeletal Crate")
        v219 = string.format("UseCrate → %s (%s)", tostring(v233), tostring(v234))
        f90()
      end)
    end,
  })

  eventTab:CreateButton({
    Name = "Open ALL Skeletal Crates",
    Callback = function()
      task.spawn(function()
        while f86() > 0 and f2() do
          local v235, v236 = f89("UseCrate", "Skeletal Crate")
          v219 = string.format("UseCrate → %s (%s)", tostring(v235), tostring(v236))
          f90()

          if v235 ~= "Success" then
            break
          end

          task.wait(0.3)
        end
      end)
    end,
  })

  return {
    StartFromConfig = function()
      f90()

      if v22 or v23 or v24 then
        f91()
      end
    end,
    Stop = function()
      v22 = false
      v23 = false
      v24 = false
      count18 = count18 + 1
    end,
  }
end

local v237 = f81()

task.spawn(function()
  while not v12 do
    task.wait(0.2)
  end

  local v238 = {}
  local v239 = {}

  for key10, value48 in pairs(v36) do
    local v240 = tostring(value48.Rarity or "Unknown")

    if not v238[v240] then
      v238[v240] = {}
      table.insert(v239, v240)
    end

    local v241 = v238[v240]

    table.insert(v241, {
      Name = value48.Name or key10,
      Icon = value48.Image or "",
      _cost = value48.Cost or 0,
    })
  end

  table.sort(v239, function(p43, p44) return f8(p43) < f8(p44) end)
  local v242 = {}

  for index26, value49 in ipairs(v239) do
    local v243 = v238[value49]
    table.sort(v243, function(p45, p46) return p45._cost < p46._cost end)
    table.insert(v242, { Label = value49, Items = v243 })
  end

  if #v242 == 0 then
    return
  end

  autoRollTab:CreateFilteredCardGrid({
    Groups = v242,
    Columns = 3,
    Flag = "RAA_UnitSelection",
    Callback = function(value50) v26 = value50 end,
  })
end)

local plotParagraph = miscTab:CreateParagraph({ Title = "Plot", Content = "Resolving..." })

task.spawn(function()
  while f2() do
    if v12 and v34 then
      f1(plotParagraph, {
        Title = "Plot — " .. v34.Name,
        Content = ("OwnerId %d · %s"):format(v34:GetAttribute("OwnerId") or -1, v34:FindFirstChild("UpgradeBoards")
            and "own plot confirmed"
          or "no UpgradeBoards (?)"),
      })

      return
    end

    task.wait(0.5)
  end
end)

task.spawn(function()
  while not v12 do
    task.wait(0.2)
  end

  v65.StartFromConfig()
  v107.StartFromConfig()
  v140.StartFromConfig()
  v166.StartFromConfig()
  v186.StartFromConfig()
  v200.StartFromConfig()
  v217.StartFromConfig()
  v218.StartFromConfig()
  v237.StartFromConfig()
end)
