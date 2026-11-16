local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local v5, v6, v7

pcall(function()
  v5 = require(replicatedStorage:WaitForChild("ASMRConfig", 5))
  v6 = require(replicatedStorage:WaitForChild("WorkerUtil", 5))
  require(replicatedStorage:WaitForChild("ConveyorUpgradeConfig", 5))
  v7 = require(replicatedStorage:WaitForChild("RebirthConfig", 5))
end)

local v8 = {
  Sp = 1e+24,
  Sx = 1e+21,
  Qi = 1000000000000000000,
  Qa = 1000000000000000,
  T = 1000000000000,
  B = 1000000000,
  M = 1000000,
  K = 1000,
}

local v9 = { "Popits", "Keys", "Bubbles", "Balls", "Parts", "Buttons" }

local v10 = {
  IsAutoSpawnBuyCrateLoopRunning = false,
  IsAutoFarmHighestRewardASMRRunning = false,
  IsAutoSellInventoryLoopRunning = false,
  IsAutoSellThisLoopRunning = false,
  IsAutoUpgradeASMRLoopRunning = false,
  IsAutoPlaceCrateLoopRunning = false,
  IsAutoUnboxCrateLoopRunning = false,
  IsAutoPlaceASMRLoopRunning = false,
  IsAutoUnlockPlotExpansionLoopRunning = false,
  IsAutoBuyWorkerLoopRunning = false,
  IsAutoAssignWorkerLoopRunning = false,
  IsAutoUpgradeConveyorLoopRunning = false,
  IsAutoRebirthLoopRunning = false,
  IsAutoClaimDailyRewardLoopRunning = false,
  IsAutoClaimOfflineEarningsLoopRunning = false,
  IsAutoWheelSpinLoopRunning = false,
  IsAutoCollectFireIceEventCratesLoopRunning = false,
  IsAutoCollectGalaxyEventCratesLoopRunning = false,
}

local v11 = { ConveyorUnlockedLevel = nil }
local v12 = { RebirthInfo = nil }

local v13 = {
  Products = {},
  Rarities = {},
  ConveyorLevels = {},
  ProductByProductId = {},
  ProductByASMRTemplateName = {},
  ProductByCrateTemplateName = {},
  ProductByASMRDisplayName = {},
  ProductByCrateDisplayName = {},
}

local v14 = { PlayerPlot = nil, PlacementCFrame = {} }
local v15 = {}

local function f1()
  local v16 = {}
  local v17 = {}

  local function f2(p1)
    for index, value in ipairs(p1 or {}) do
      if type(value) == "table"
        and (value.DisplayName or value.ASMRDisplayName or value.CrateTemplateName
          or value.ASMRTemplateName) then
        local v18 = (value.ProductId or "") .. "_"
          .. (value.ASMRTemplateName or value.CrateTemplateName or value.DisplayName or "")

        if not v17[v18] then
          v17[v18] = true
          table.insert(v16, value)
        end
      end
    end
  end

  pcall(function()
    local v19 = require(replicatedStorage:WaitForChild("ProductCatalogConfig", 5))

    if v19 then
      f2(v19.Products)
      f2(v19.LimitedProducts)
    end
  end)

  pcall(function()
    local v20 = require(replicatedStorage:WaitForChild("RebirthConfig", 5))

    if v20 then
      f2(v20.RebirthASMRItems)
    end
  end)

  return v16
end

local function f3()
  local v21 = {
    "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Divine", "Exotic", "Godly",
    "Honey", "Rebirth ASMR", "Exclusive", "Limited",
  }

  local v22 = {}
  local v23 = {}

  for index2, value2 in ipairs(v21) do
    if not v23[value2] then
      v23[value2] = true
      table.insert(v22, value2)
    end
  end

  pcall(function()
    local v24 = require(replicatedStorage:WaitForChild("RarityConfig", 5))

    if v24 and v24.Styles then
      for key in pairs(v24.Styles) do
        if type(key) == "string" and not v23[key] then
          v23[key] = true
          table.insert(v22, key)
        end
      end
    end
  end)

  return v22
end

local function f4()
  local v25, v26 = pcall(function()
    return require(replicatedStorage:WaitForChild("ConveyorUpgradeConfig", 5))
  end)

  if not v25 or not v26 then
    return {}
  end

  return v26.Levels or {}
end

local function f5(p2, p3, p4)
  return p2 and v13.ProductByProductId[p2]
    or p3 and (v13.ProductByASMRTemplateName[p3] or v13.ProductByProductId[p3])
    or v13.ProductByASMRDisplayName[p4]
end

local function f6(p5, p6, p7)
  return p5 and v13.ProductByProductId[p5]
    or p6 and (v13.ProductByCrateTemplateName[p6] or v13.ProductByProductId[p6])
    or v13.ProductByCrateDisplayName[p7]
end

local function f7(p8, p9)
  local v27 = {}
  local v28 = {}

  for index3, value3 in ipairs(p8 or {}) do
    if type(value3) == "table" then
      local v29 = value3[p9]

      if v29 and type(v29) == "string" and v29 ~= "" and not v27[v29] then
        v27[v29] = true
        table.insert(v28, v29)
      end
    end
  end

  table.sort(v28)
  return v28
end

local function f8()
  if v14.PlayerPlot and v14.PlayerPlot.Parent then
    return v14.PlayerPlot
  end

  local v30 = tonumber(localPlayer:GetAttribute("PlotNumber"))
  local plots = workspace:FindFirstChild("Plots")
  local activePlots = plots and plots:FindFirstChild("ActivePlots")

  if activePlots then
    if v30 then
      local findFirstChild = activePlots:FindFirstChild("Plot" .. v30)

      if findFirstChild then
        v14.PlayerPlot = findFirstChild
        return findFirstChild
      end
    end

    for index4, value4 in ipairs(activePlots:GetChildren()) do
      if value4:GetAttribute("OwnerUserId") == localPlayer.UserId then
        v14.PlayerPlot = value4
        return value4
      end
    end
  end

  return nil
end

local function f9(p10)
  if not p10 then
    return 0
  end

  if type(p10) == "number" then
    return p10
  end

  local v31, v32 = tostring(p10):match("%$?([%d%.%-]+)%s*([A-Za-z]*)")
  local v33 = tonumber(v31) or 0

  if v32 and v32 ~= "" and v8[v32] then
    v33 = v33 * v8[v32]
  end

  return v33
end

local function f10()
  local v34, v35 = pcall(function()
    local leaderstats = localPlayer:FindFirstChild("leaderstats")
      or localPlayer:FindFirstChild("Leaderstats")

    local cash = leaderstats
      and (leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Money"))

    return cash and cash.Value
  end)

  if v34 and typeof(v35) == "number" then
    return v35
  end

  if v34 and v35 ~= nil then
    local v36 = f9(v35)

    if v36 > 0 then
      return v36
    end
  end

  local cash2 = localPlayer:GetAttribute("Cash") or localPlayer:GetAttribute("Money")

  if typeof(cash2) == "number" then
    return cash2
  elseif cash2 ~= nil then
    return f9(cash2)
  end

  return 0
end

local function f11(p11)
  if not p11 then
    return nil
  end

  return p11:GetAttribute("CrateTemplateName") or p11:GetAttribute("TemplateName")
    or p11:GetAttribute("CrateId") or p11.Name
end

local function f12()
  local v37 = f8()

  if not v37 then
    return {}
  end

  local conveyor = v37:FindFirstChild("Conveyor")
  local activeCrates = conveyor and conveyor:FindFirstChild("ActiveCrates")

  if not activeCrates then
    return {}
  end

  local v38 = {}

  for index5, value5 in ipairs(activeCrates:GetChildren()) do
    local ownerUserId = value5:GetAttribute("OwnerUserId")

    if not ownerUserId or ownerUserId == localPlayer.UserId then
      table.insert(v38, value5)
    end
  end

  return v38
end

local function f13()
  local v39 = f8()

  if not v39 then
    return {}
  end

  local asmr = v39:FindFirstChild("ASMR")

  if not asmr then
    return {}
  end

  local v40 = {}

  for index6, value6 in ipairs(asmr:GetChildren()) do
    if value6:IsA("Model") then
      local ownerUserId2 = value6:GetAttribute("OwnerUserId")

      if not ownerUserId2 or ownerUserId2 == localPlayer.UserId then
        table.insert(v40, value6)
      end
    end
  end

  return v40
end

local function f14()
  local v41 = f8()

  if not v41 then
    return {}
  end

  local placedCrates = v41:FindFirstChild("PlacedCrates")

  if not placedCrates then
    return {}
  end

  local v42 = {}

  for index7, value7 in ipairs(placedCrates:GetChildren()) do
    if value7:IsA("Model") then
      local ownerUserId3 = value7:GetAttribute("OwnerUserId")

      if not ownerUserId3 or ownerUserId3 == localPlayer.UserId then
        table.insert(v42, value7)
      end
    end
  end

  return v42
end

local function f15()
  local v43 = f8()

  if not v43 then
    return {}
  end

  local placement = v43:FindFirstChild("Placement")
  local locked = placement and placement:FindFirstChild("Locked")

  if not locked then
    return {}
  end

  local v44 = {}

  for index8, value8 in ipairs(locked:GetChildren()) do
    if value8:IsA("BasePart") or value8:IsA("Model") then
      local findFirstChild2 = value8:FindFirstChild("ExpansionPurchasePrompt", true)
        or value8:FindFirstChildWhichIsA("ProximityPrompt", true)

      if findFirstChild2 and findFirstChild2:IsA("ProximityPrompt") then
        table.insert(v44, {
          Part = value8,
          Prompt = findFirstChild2,
          ExpansionId = findFirstChild2:GetAttribute("ExpansionId")
            or value8:GetAttribute("ExpansionId") or "",
        })
      end
    end
  end

  return v44
end

local function f16(p12, p13)
  if p13 then
    local price = p13:GetAttribute("Price") or p13:GetAttribute("ExpansionPrice")

    if tonumber(price) then
      return tonumber(price)
    end
  end

  if PlotExpansionConfig and PlotExpansionConfig.Prices then
    local v45 = tonumber(string.match(tostring(p12), "%d+"))

    if v45 and PlotExpansionConfig.Prices[v45] then
      return PlotExpansionConfig.Prices[v45]
    end
  end

  return 500
end

local function f17()
  if v11.ConveyorUnlockedLevel and type(v11.ConveyorUnlockedLevel) == "number"
    and v11.ConveyorUnlockedLevel > 0 then
    return v11.ConveyorUnlockedLevel
  end

  local v46 = f8()

  if v46 then
    local conveyorLevel = v46:GetAttribute("ConveyorLevel")
      or v46:GetAttribute("ConveyorUnlockedLevel") or v46:GetAttribute("Conveyor")

    if tonumber(conveyorLevel) then
      return tonumber(conveyorLevel)
    end

    local conveyor2 = v46:FindFirstChild("Conveyor")

    if conveyor2 then
      local level = conveyor2:GetAttribute("Level") or conveyor2:GetAttribute("ConveyorLevel")
        or conveyor2:GetAttribute("UnlockedLevel")

      if tonumber(level) then
        return tonumber(level)
      end
    end

    local findFirstChild3 = v46:FindFirstChild("UpgradeConveyorButton", true)

    if findFirstChild3 then
      local level2 = findFirstChild3:GetAttribute("Level")
        or findFirstChild3:GetAttribute("ConveyorLevel")
        or findFirstChild3:GetAttribute("NextLevel")

      if tonumber(level2) then
        return tonumber(level2)
      end

      for index9, value9 in ipairs(findFirstChild3:GetDescendants()) do
        if value9:IsA("TextLabel") and value9.Text and value9.Text ~= "" then
          local v47 = f9(value9.Text)

          if v47 > 0 and v13.ConveyorLevels then
            for index10, value10 in ipairs(v13.ConveyorLevels) do
              if value10.Cost == v47 then
                return index10 - 1
              end
            end
          end
        end
      end
    end
  end

  local conveyorLevel2 = localPlayer:GetAttribute("ConveyorLevel")
    or localPlayer:GetAttribute("ConveyorUnlockedLevel")

  if tonumber(conveyorLevel2) then
    return tonumber(conveyorLevel2)
  end

  return 1
end

local function f18()
  local v48 = f17()
  local v49 = v48 + 1

  if v13.ConveyorLevels and v13.ConveyorLevels[v49] then
    return v13.ConveyorLevels[v49].Cost, v48, v49
  end

  return 0, v48, v49
end

local function f19(p14)
  if not p14 then
    return
  end

  local v50 = 1

  if v13.ConveyorLevels then
    for index11, value11 in ipairs(v13.ConveyorLevels) do
      if value11.Name == p14 or tostring(index11) == tostring(p14) then
        v50 = index11
        break
      end
    end
  end

  local plotSystemRemotes = replicatedStorage:FindFirstChild("PlotSystemRemotes")
    or replicatedStorage:WaitForChild("PlotSystemRemotes", 5)

  local changeConveyorRequest = plotSystemRemotes
    and (plotSystemRemotes:FindFirstChild("ChangeConveyorRequest")
      or plotSystemRemotes:WaitForChild("ChangeConveyorRequest", 5))

  if changeConveyorRequest then
    pcall(function() changeConveyorRequest:FireServer(v50) end)
  end
end

local function f20(p15, p16)
  if not p15 then
    return Vector3.new(3.5, 1.4, 3.5)
  end

  local findFirstChild4 = replicatedStorage:FindFirstChild(p16 and "CratePlacementPreviews"
    or "ASMRPlacementPreviews")

  local findFirstChild5 = findFirstChild4 and findFirstChild4:FindFirstChild(p15)

  if findFirstChild5 and findFirstChild5:IsA("Model") then
    local primaryPart = findFirstChild5.PrimaryPart
      or findFirstChild5:FindFirstChild("Main", true)
      or findFirstChild5:FindFirstChild("Hitbox", true)
      or findFirstChild5:FindFirstChild("Base", true)

    local size = primaryPart and primaryPart.Size or findFirstChild5:GetExtentsSize()
    return Vector3.new(math.max(size.X * 0.92, 0.5), 1.4, math.max(size.Z * 0.92, 0.5))
  end

  return Vector3.new(3.5, 1.4, 3.5)
end

local function f21(p17, p18)
  local parent = p17

  while parent and parent ~= p18 do
    if parent.Name == "Grass" then
      return true
    end

    parent = parent.Parent
  end

  return false
end

local function f22(p19, p20, fn)
  local v51 = fn(p20.Position)
end

local function f23(p21, p22)
  local placement2 = p21:FindFirstChild("Placement")

  if not placement2 then
    return nil
  end

  local v52 = { unlocked = {}, blocking = {}, requireUnlocked = false }

  local overlapParams = OverlapParams.new()
  overlapParams.RespectCanCollide = false

  local getPartBoundsInBox = workspace:GetPartBoundsInBox(p22.CFrame, p22.Size, overlapParams)

  local function f24(p23)
    return p22.CFrame:PointToObjectSpace(p23)
  end

  local unlocked = placement2:FindFirstChild("Unlocked")
  local locked2 = placement2:FindFirstChild("Locked")
  local placedCrates2 = p21:FindFirstChild("PlacedCrates")
  local asmr2 = p21:FindFirstChild("ASMR")
  v52.requireUnlocked = unlocked ~= nil

  for index12, value12 in ipairs(getPartBoundsInBox) do
    if value12:IsA("BasePart") then
      if placedCrates2 and value12:IsDescendantOf(placedCrates2)
        or asmr2 and value12:IsDescendantOf(asmr2) then
        f22(v52.blocking, value12, f24)
      elseif unlocked and value12:IsDescendantOf(unlocked)
        and value12:GetAttribute("Placeable") == true then
        f22(v52.unlocked, value12, f24)
      elseif locked2 and value12:IsDescendantOf(locked2)
        and value12:GetAttribute("Placeable") == false and not f21(value12, placement2) then
        f22(v52.blocking, value12, f24)
      end
    end
  end

  return v52
end

local function f25(p24, p25, p26, p27, p28)
  local v53, v54 = p26.X * 0.5, p26.Z * 0.5
  local v55, v56 = p24 - v53, p25 - v54
  local v57, v58 = p24 + v53, p25 + v54
  local v59 = not p28.requireUnlocked

  for i = 1, #p28.unlocked do
    local v60 = p28.unlocked[i]

    if v60[1] < v57 and v60[3] > v55 and v60[2] < v58 and v60[4] > v56 then
      v59 = true
      break
    end
  end

  if not v59 then
    return false
  end

  for j = 1, #p28.blocking do
    local v61 = p28.blocking[j]

    if v61[1] < v57 and v61[3] > v55 and v61[2] < v58 and v61[4] > v56 then
      return false
    end
  end

  if p27 then
    local v62 = math.max(p26.X, p26.Z) / 2

    for index13, value13 in ipairs(p27) do
      local pos = value13.Pos
      local v63 = p24 - pos.X
      local v64 = p25 - pos.Z
      local v65 = v62 + (value13.Radius or 2) + 0.5

      if v63 * v63 + v64 * v64 < v65 * v65 then
        return false
      end
    end
  end

  return true
end

local function f26(p29, p30, p31)
  local v66 = f8()

  if not v66 then
    return nil
  end

  local placement3 = v66:FindFirstChild("Placement")
  local bounds = placement3 and placement3:FindFirstChild("Bounds")

  if not bounds or not bounds:IsA("BasePart") then
    return v66:GetPivot()
  end

  local v67 = f23(v66, bounds)

  if not v67 then
    return v66:GetPivot()
  end

  local crateTemplateName = nil
  local v68 = false

  if p29 then
    if p29:GetAttribute("IsCrateTool") == true or p29:GetAttribute("CrateTemplateName") ~= nil then
      crateTemplateName = p29:GetAttribute("CrateTemplateName") or p29.Name
      v68 = true
    else
      crateTemplateName = p29:GetAttribute("ASMRTemplateName") or p29.Name
      v68 = false
    end
  end

  local v69 = f20(crateTemplateName, v68)
  local v70 = {}

  if p30 then
    for index14, value14 in ipairs(p30) do
      local pointToObjectSpace = bounds.CFrame:PointToObjectSpace(value14.Pos)
      table.insert(v70, { Pos = pointToObjectSpace, Radius = value14.Radius or 2 })
    end
  end

  if p31 then
    for index15, value15 in ipairs(p31) do
      local pointToObjectSpace2 = bounds.CFrame:PointToObjectSpace(value15.Pos)
      table.insert(v70, { Pos = pointToObjectSpace2, Radius = value15.Radius or 2 })
    end
  end

  local v71 = crateTemplateName .. (v68 and ":crate" or ":asmr")
  local v72 = v14.PlacementCFrame[v66]

  if v72 then
    local v73 = v72[v71]

    if v73 and v73.footprintSize == v69 then
      local pointToObjectSpace3 = bounds.CFrame:PointToObjectSpace(v73.cframe.Position)

      if f25(pointToObjectSpace3.X, pointToObjectSpace3.Z, v69, v70, v67) then
        return v73.cframe, v73.radius
      end
    end

    v72[v71] = nil
  end

  local v74 = bounds.CFrame * CFrame.new(0, bounds.Size.Y / 2, 0)
  local v75 = math.max(v69.X / 2 + 6, 8)
  local v76 = math.max(v69.Z / 2 + 6, 8)
  local v77 = math.max(bounds.Size.X / 2 - v75, 0)
  local v78 = math.max(bounds.Size.Z / 2 - v76, 0)
  local count = 0

  for k = -v77, v77, 5 do
    for m = -v78, v78, 5 do
      count = count + 1

      if count % 50 == 0 then
        task.wait()
      end

      local v79 = v74 * CFrame.new(k, 0, m)

      if f25(k, m, v69, v70, v67) then
        local v80 = math.max(v69.X, v69.Z) / 2

        if not v72 then
          v72 = {}
          v14.PlacementCFrame[v66] = v72
        end

        v72[v71] = { cframe = v79, footprintSize = v69, radius = v80 }
        return v79, v80
      end
    end
  end

  return nil, math.max(v69.X, v69.Z) / 2
end

local function f27(p32)
  if not p32 then
    return
  end

  local asmrPlacementRemotes = replicatedStorage:FindFirstChild("ASMRPlacementRemotes")
    or replicatedStorage:WaitForChild("ASMRPlacementRemotes", 5)

  local requestPickupASMR = asmrPlacementRemotes
    and (asmrPlacementRemotes:FindFirstChild("RequestPickupASMR")
      or asmrPlacementRemotes:WaitForChild("RequestPickupASMR", 5))

  if requestPickupASMR then
    pcall(function() requestPickupASMR:FireServer(p32) end)
  end
end

local function f28(p33)
  if not p33 then
    return {}
  end

  local v81 = {}

  for index16, value16 in ipairs(v9) do
    local findFirstChild6 = p33:FindFirstChild(value16)

    if findFirstChild6 then
      for index17, value17 in ipairs(findFirstChild6:GetChildren()) do
        if value17:IsA("BasePart") then
          table.insert(v81, value17)
        end
      end
    end
  end

  if #v81 == 0 then
    for index18, value18 in ipairs(p33:GetDescendants()) do
      if value18:IsA("BasePart") then
        local lower = value18.Name:lower()

        if not (lower == "base" or lower == "floor" or lower == "plate" or lower == "stand"
            or lower == "pedestal" or lower == "bounds")
          and (lower == "key" or lower:find("key") or lower:find("popit") or lower:find("ball")
            or lower:find("bubble") or lower:find("button") or lower == "soundpart"
            or lower == "hitbox" or lower:find("squishy") or lower:find("pudding")
            or lower:find("butter") or lower:find("slime") or lower == "mesh" or lower == "main") then
          table.insert(v81, value18)
        end
      end
    end
  end

  if #v81 == 0 then
    for index19, value19 in ipairs(p33:GetChildren()) do
      if value19:IsA("BasePart") and value19.Size.X > 0.3 then
        local lower2 = value19.Name:lower()

        if lower2 ~= "base" and lower2 ~= "floor" and lower2 ~= "plate" and lower2 ~= "stand" then
          table.insert(v81, value19)
        end
      end
    end
  end

  if #v81 == 0 then
    for index20, value20 in ipairs(p33:GetDescendants()) do
      if value20:IsA("BasePart") and value20.Size.X > 0.3 and value20.Transparency < 1 then
        local lower3 = value20.Name:lower()

        if lower3 ~= "base" and lower3 ~= "floor" and lower3 ~= "plate" and lower3 ~= "stand" then
          table.insert(v81, value20)
        end
      end
    end
  end

  if #v81 == 0 and p33.PrimaryPart then
    table.insert(v81, p33.PrimaryPart)
  end

  return v81
end

local function f29(p34)
  if not p34 then
    return 1
  end

  local v82 = tonumber(p34:GetAttribute("ASMRCurrentReward"))
    or tonumber(p34:GetAttribute("ASMRBaseReward"))

  if v82 and v82 > 0 then
    return v82
  end

  if v6 and typeof(v6.GetRewardForModel) == "function" then
    local v83, v84 = pcall(function() return v6.GetRewardForModel(p34) end)

    if v83 and type(v84) == "number" and v84 > 0 then
      return v84
    end
  end

  local asmrTemplateName = p34:GetAttribute("ASMRTemplateName") or ""
  local v85 = math.max(1, tonumber(p34:GetAttribute("ASMRLevel")) or 1)

  if v5 and typeof(v5.GetRewardAtLevel) == "function" then
    local v86, v87 = pcall(function() return v5.GetRewardAtLevel(asmrTemplateName, v85) end)

    if v86 and type(v87) == "number" and v87 > 0 then
      return v87
    end
  end

  local v88 = f5(nil, asmrTemplateName, nil)

  if v88 then
    local v89 = tonumber(v88.BaseReward) or 1
    return math.floor(v89 * 1.1 ^ (v85 - 1))
  end

  return 1
end

local function f30(p35)
  local v90 = f11(p35)
  local v91 = f6(nil, v90, p35.Name)

  if v91 then
    return v91, v90
  end

  return nil, v90
end

local function f31(p36)
  for key2, value21 in pairs(p36 or {}) do
    if value21 == true or type(key2) == "number" and type(value21) == "string" then
      return true
    end
  end

  return false
end

local function f32(p37, ...)
  local v92 = { ... }

  for key3, value22 in pairs(p37 or {}) do
    if value22 == true or type(key3) == "number" and type(value22) == "string" then
      local v93 = value22 == true and key3 or value22

      for index21, value23 in ipairs(v92) do
        if v93 == value23 then
          return true
        end
      end
    end
  end

  return false
end

local function f33()
  local v94 = {}
  local character = localPlayer.Character

  if character then
    for index22, value24 in ipairs(character:GetChildren()) do
      if value24:IsA("Tool")
        and (value24:GetAttribute("IsASMRTool") == true
          or value24:GetAttribute("ASMRTemplateName") ~= nil) then
        table.insert(v94, value24)
      end
    end
  end

  local backpack = localPlayer:FindFirstChild("Backpack")

  if backpack then
    for index23, value25 in ipairs(backpack:GetChildren()) do
      if value25:IsA("Tool")
        and (value25:GetAttribute("IsASMRTool") == true
          or value25:GetAttribute("ASMRTemplateName") ~= nil) then
        table.insert(v94, value25)
      end
    end
  end

  return v94
end

local function f34()
  local v95 = {}
  local character2 = localPlayer.Character

  if character2 then
    for index24, value26 in ipairs(character2:GetChildren()) do
      if value26:IsA("Tool")
        and (value26:GetAttribute("IsCrateTool") == true
          or value26:GetAttribute("CrateTemplateName") ~= nil) then
        table.insert(v95, value26)
      end
    end
  end

  local backpack2 = localPlayer:FindFirstChild("Backpack")

  if backpack2 then
    for index25, value27 in ipairs(backpack2:GetChildren()) do
      if value27:IsA("Tool")
        and (value27:GetAttribute("IsCrateTool") == true
          or value27:GetAttribute("CrateTemplateName") ~= nil) then
        table.insert(v95, value27)
      end
    end
  end

  return v95
end

local function f35()
  local v96 = {}
  local character3 = localPlayer.Character

  if character3 then
    for index26, value28 in ipairs(character3:GetChildren()) do
      if value28:IsA("Tool")
        and (value28:GetAttribute("WorkerId") ~= nil
          or value28:GetAttribute("IsWorkerTool") == true or value28.Name:lower():find("worker")) then
        table.insert(v96, value28)
      end
    end
  end

  local backpack3 = localPlayer:FindFirstChild("Backpack")

  if backpack3 then
    for index27, value29 in ipairs(backpack3:GetChildren()) do
      if value29:IsA("Tool")
        and (value29:GetAttribute("WorkerId") ~= nil
          or value29:GetAttribute("IsWorkerTool") == true or value29.Name:lower():find("worker")) then
        table.insert(v96, value29)
      end
    end
  end

  return v96
end

local function f36()
  local v97 = {}
  local v98 = {}

  for index28, value30 in ipairs(f13()) do
    local ownerUserId4 = value30:GetAttribute("OwnerUserId")
    local v99 = value30:GetAttribute("WorkerAssigned") == true

    local lower4 = tostring(value30:GetAttribute("ASMRRarity") or value30:GetAttribute("Rarity")
      or ""):lower()

    local lower5 = tostring(value30:GetAttribute("ASMRTemplateName")
      or value30:GetAttribute("TemplateName") or value30.Name):lower()

    local v100 = not (value30:GetAttribute("DisallowWorker") == true
        or value30:GetAttribute("NoWorker") == true
        or value30:GetAttribute("AllowWorker") == false)
      and not lower4:find("fire & ice")
      and not lower4:find("fire")
      and not lower4:find("cosmic")
      and not lower5:find("cosmic")

    if (not ownerUserId4 or ownerUserId4 == localPlayer.UserId) and not v99 and v100 then
      table.insert(v97, value30)
      v98[value30] = f29(value30)
    end
  end

  table.sort(v97, function(p38, p39) return (v98[p38] or 0) > (v98[p39] or 0) end)
  return v97
end

local function f37(p40)
  if not p40 then
    return nil
  end

  local asmrTemplateName2 = p40:GetAttribute("ASMRTemplateName")
    or p40:GetAttribute("TemplateName") or p40.Name

  local productId = p40:GetAttribute("ProductId")
  local v101 = f5(productId, asmrTemplateName2, p40.Name)

  return {
    ASMRDisplayName = p40:GetAttribute("ASMRDisplayName")
      or v101 and (v101.ASMRDisplayName or v101.LobbyASMRName) or p40.Name,
    ASMRRarity = p40:GetAttribute("ASMRRarity") or p40:GetAttribute("Rarity")
      or v101 and v101.Rarity or "",
    ASMRTemplateName = asmrTemplateName2,
    ProductId = productId or v101 and v101.ProductId or "",
    ASMRBasePrice = p40:GetAttribute("ASMRBasePrice") or v101 and v101.Price or 0,
    ASMRBaseReward = p40:GetAttribute("ASMRBaseReward") or 0,
    ASMRBaseUpgradeCost = p40:GetAttribute("ASMRBaseUpgradeCost") or 0,
    ASMRCurrentReward = p40:GetAttribute("ASMRCurrentReward") or 0,
    ASMRInteractionType = p40:GetAttribute("ASMRInteractionType")
      or v101 and v101.InteractionType or "",
    ASMRItemId = p40:GetAttribute("ASMRItemId") or "",
    ASMRLevel = p40:GetAttribute("ASMRLevel") or 1,
    ASMRMaxLevel = p40:GetAttribute("ASMRMaxLevel") or 100,
    ASMRRewardSuffix = p40:GetAttribute("ASMRRewardSuffix") or "",
    IsASMRTool = p40:GetAttribute("IsASMRTool") == true,
    Config = v101,
  }
end

local function f38(p41)
  if not p41 then
    return nil
  end

  local crateTemplateName2 = p41:GetAttribute("CrateTemplateName")
    or p41:GetAttribute("TemplateName") or p41.Name

  local productId2 = p41:GetAttribute("ProductId")
  local v102 = f6(productId2, crateTemplateName2, p41.Name)

  return {
    CrateDisplayName = p41:GetAttribute("CrateDisplayName")
      or v102 and (v102.DisplayName or v102.LobbyCrateTitle or v102.LobbyCrateName)
      or crateTemplateName2,
    CrateRarity = p41:GetAttribute("CrateRarity") or p41:GetAttribute("Rarity")
      or v102 and v102.Rarity or "",
    CrateTemplateName = crateTemplateName2,
    CrateItemId = p41:GetAttribute("CrateItemId") or "",
    IsCrateTool = p41:GetAttribute("IsCrateTool") == true,
    ProductId = productId2 or v102 and v102.ProductId or "",
    ToolHeight = p41:GetAttribute("ToolHeight") or 0,
    Config = v102,
  }
end

local function f39(p42)
  if not p42 then
    return nil
  end

  local asmrTemplateName3 = p42:GetAttribute("ASMRTemplateName")
    or p42:GetAttribute("TemplateName") or p42.Name

  local productId3 = p42:GetAttribute("ProductId")
  local v103 = f5(productId3, asmrTemplateName3, p42.Name)

  return {
    ASMRDisplayName = p42:GetAttribute("ASMRDisplayName") or p42:GetAttribute("DisplayName")
      or v103 and (v103.ASMRDisplayName or v103.LobbyASMRName) or p42.Name,
    ASMRRarity = p42:GetAttribute("ASMRRarity") or p42:GetAttribute("Rarity")
      or v103 and v103.Rarity or "",
    ASMRTemplateName = asmrTemplateName3,
    ProductId = productId3 or v103 and v103.ProductId or "",
    ASMRBasePrice = p42:GetAttribute("ASMRBasePrice") or p42:GetAttribute("Price")
      or v103 and v103.Price or 0,
    ASMRBaseReward = p42:GetAttribute("ASMRBaseReward") or 0,
    ASMRBaseUpgradeCost = p42:GetAttribute("ASMRBaseUpgradeCost") or 0,
    ASMRCurrentReward = p42:GetAttribute("ASMRCurrentReward") or 0,
    ASMRInteractionType = p42:GetAttribute("ASMRInteractionType")
      or v103 and v103.InteractionType or "",
    ASMRLevel = p42:GetAttribute("ASMRLevel") or 1,
    ASMRMaxLevel = p42:GetAttribute("ASMRMaxLevel") or 100,
    ASMRRewardSuffix = p42:GetAttribute("ASMRRewardSuffix") or "",
    AssignedWorkerId = p42:GetAttribute("AssignedWorkerId") or "",
    AtomicPlotVisual = p42:GetAttribute("AtomicPlotVisual") == true,
    ClientPlotVisible = p42:GetAttribute("ClientPlotVisible") == true,
    ClientVisualActive = p42:GetAttribute("ClientVisualActive") == true,
    OwnerUserId = p42:GetAttribute("OwnerUserId"),
    PlacedASMRId = p42:GetAttribute("PlacedASMRId") or "",
    RollWeight = p42:GetAttribute("RollWeight") or v103 and v103.RollWeight or 1,
    Tier = p42:GetAttribute("Tier") or v103 and v103.Tier or 1,
    WorkerAssigned = p42:GetAttribute("WorkerAssigned") == true,
    Config = v103,
  }
end

local function f40(p43)
  if not p43 then
    return 0
  end

  local asmrTemplateName4 = p43:GetAttribute("ASMRTemplateName") or p43.Name
  local v104 = math.max(1, tonumber(p43:GetAttribute("ASMRLevel")) or 1)

  if v5 and typeof(v5.GetUpgradeCost) == "function" then
    local v105, v106 = pcall(function() return v5.GetUpgradeCost(asmrTemplateName4, v104) end)

    if v105 and type(v106) == "number" then
      return v106
    end
  end

  local v107 = tonumber(p43:GetAttribute("ASMRBaseUpgradeCost")) or 180000
  return math.floor(v107 * 1.12 ^ (v104 - 1) + 0.5)
end

local function f41()
  local v108 = tonumber(localPlayer:GetAttribute("RebirthCount")) or 0
  local maxRebirths = v7 and v7.MaxRebirths or 10
  local cashRequirement = 0
  local requiredCrateDisplayName = "None"
  local requiredCrateTemplate = ""
  local requiredASMRDisplayName = "None"
  local requiredASMRTemplate = ""
  local rewardTemplate = ""
  local cashBonusPerRebirth = v7 and v7.CashBonusPerRebirth or 0.1
  local v109 = math.floor(v108 * (cashBonusPerRebirth * 100))
  local hasMoney = false
  local hasASMR = false
  local canRebirth = false
  local invokeServer = nil

  pcall(function()
    local rebirthRemotes = replicatedStorage:FindFirstChild("RebirthRemotes")
      or replicatedStorage:WaitForChild("RebirthRemotes", 2)

    local getRebirthState = rebirthRemotes
      and (rebirthRemotes:FindFirstChild("GetRebirthState")
        or rebirthRemotes:WaitForChild("GetRebirthState", 2))

    if getRebirthState then
      invokeServer = getRebirthState:InvokeServer()
    end
  end)

  local v110 = (v7 and v7.Requirements or {})[v108 + 1]

  if invokeServer and typeof(invokeServer) == "table" then
    if invokeServer.RebirthCount ~= nil then
      v108 = tonumber(invokeServer.RebirthCount) or v108
    end

    if invokeServer.MaxRebirths ~= nil then
      maxRebirths = tonumber(invokeServer.MaxRebirths) or maxRebirths
    end

    if invokeServer.CashRequirement ~= nil then
      cashRequirement = invokeServer.CashRequirement
    end

    if invokeServer.RequiredCrateDisplayName and invokeServer.RequiredCrateDisplayName ~= "" then
      requiredCrateDisplayName = invokeServer.RequiredCrateDisplayName
    elseif invokeServer.RequiredCrateTemplate and invokeServer.RequiredCrateTemplate ~= "" then
      requiredCrateDisplayName = invokeServer.RequiredCrateTemplate
    elseif v110 then
      requiredCrateDisplayName = v110.RequiredCrateDisplayName or v110.RequiredCrateTemplate
        or "None"
    end

    if invokeServer.RequiredCrateTemplate then
      requiredCrateTemplate = invokeServer.RequiredCrateTemplate
    end

    if invokeServer.RequiredASMRDisplayName and invokeServer.RequiredASMRDisplayName ~= "" then
      requiredASMRDisplayName = invokeServer.RequiredASMRDisplayName
    elseif invokeServer.RequiredASMRTemplate and invokeServer.RequiredASMRTemplate ~= "" then
      requiredASMRDisplayName = invokeServer.RequiredASMRTemplate
    elseif v110 then
      requiredASMRDisplayName = v110.RequiredASMRDisplayName or v110.RequiredASMRTemplate
        or "None"
    end

    if invokeServer.RequiredASMRTemplate then
      requiredASMRTemplate = invokeServer.RequiredASMRTemplate
    end

    if invokeServer.RewardTemplate then
      rewardTemplate = invokeServer.RewardTemplate
    end

    if invokeServer.CashBonusPercent ~= nil then
      v109 = tonumber(invokeServer.CashBonusPercent) or v109
    end

    if invokeServer.HasMoney ~= nil then
      hasMoney = invokeServer.HasMoney == true
    end

    if invokeServer.HasASMR ~= nil then
      hasASMR = invokeServer.HasASMR == true
    end

    if invokeServer.CanRebirth ~= nil then
      canRebirth = invokeServer.CanRebirth == true
    end
  else
    if v110 then
      cashRequirement = v110.Cash or 0

      requiredCrateDisplayName = v110.RequiredCrateDisplayName or v110.RequiredCrateTemplate
        or "None"

      requiredCrateTemplate = v110.RequiredCrateTemplate or ""

      requiredASMRDisplayName = v110.RequiredASMRDisplayName or v110.RequiredASMRTemplate
        or "None"

      requiredASMRTemplate = v110.RequiredASMRTemplate or ""
      rewardTemplate = v110.RewardTemplate or ""
    else
      cashRequirement = "MAX"
      requiredCrateDisplayName = "MAX"
      requiredASMRDisplayName = "MAX"
    end

    if type(cashRequirement) == "number" then
      hasMoney = f10() >= cashRequirement
    end
  end

  local v111 = "$" .. tostring(f10())

  if v5 and typeof(v5.FormatCompact) == "function" then
    v111 = "$" .. v5.FormatCompact(f10())
  end

  local cashRequirementFormatted = "N/A"

  if cashRequirement == "MAX" then
    cashRequirementFormatted = v111 .. " / MAX"
  elseif type(cashRequirement) == "number" then
    local v112 = "$" .. tostring(cashRequirement)

    if v5 and typeof(v5.FormatCompact) == "function" then
      v112 = "$" .. v5.FormatCompact(cashRequirement)
    end

    cashRequirementFormatted = v111 .. " / " .. v112
  elseif cashRequirement ~= nil then
    cashRequirementFormatted = v111 .. " / $" .. tostring(cashRequirement)
  end

  return {
    RebirthCount = v108,
    MaxRebirths = maxRebirths,
    CashRequirement = cashRequirement,
    CashRequirementFormatted = cashRequirementFormatted,
    RequiredCrateDisplayName = requiredCrateDisplayName,
    RequiredCrateTemplate = requiredCrateTemplate,
    RequiredASMRDisplayName = requiredASMRDisplayName,
    RequiredASMRTemplate = requiredASMRTemplate,
    RewardTemplate = rewardTemplate,
    CashBonusPercent = v109,
    HasMoney = hasMoney,
    HasASMR = hasASMR,
    CanRebirth = canRebirth,
  }
end

local function f42(p44, p45, p46)
end

local function f43(p47, p48, p49)
  if not (p47 and p48) then
    return false
  end

  if (p47.Position - p48).Magnitude > 15 then
    p47.CFrame = CFrame.new(p48 + Vector3.new(0, p49 or 3, 0))
    return true
  end

  return false
end

local function f44(p50)
  if typeof(fireproximityprompt) == "function" then
    fireproximityprompt(p50, 0)
  else
    p50:InputHoldBegin()
    p50:InputHoldEnd()
  end
end

local function f45()
  pcall(function()
    local plotSystemRemotes2 = replicatedStorage:FindFirstChild("PlotSystemRemotes")
      or replicatedStorage:WaitForChild("PlotSystemRemotes", 5)

    local conveyorSelectionState = plotSystemRemotes2
      and plotSystemRemotes2:FindFirstChild("ConveyorSelectionState")

    if conveyorSelectionState then
      table.insert(v15, conveyorSelectionState.OnClientEvent:Connect(function(p51)
        if typeof(p51) == "table" and p51.UnlockedLevel then
          v11.ConveyorUnlockedLevel = tonumber(p51.UnlockedLevel)
        end
      end))
    end
  end)
end

local function f46(p52)
  local v113 = f30(p52)
  local price2 = v113 and v113.Price or 0

  if price2 > 0 and f10() < price2 then
    return v1.Options.Toggle_Shop_PauseIfNotEnoughMoney
      and v1.Options.Toggle_Shop_PauseIfNotEnoughMoney.Value
  end

  local findFirstChild7 = p52:FindFirstChild("CrateBuyPrompt", true)
    or p52:FindFirstChildWhichIsA("ProximityPrompt", true)

  if findFirstChild7 and findFirstChild7:IsA("ProximityPrompt") then
    findFirstChild7.HoldDuration = 0

    if f43(
      localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart"),
      p52:GetPivot().Position, 3
    ) then
      task.wait(0.2)
    end

    f44(findFirstChild7)
  end

  return true
end

local function f47()
  local value31 = v1.Options.Toggle_Shop_AutoSpawnBuyCrate
    and v1.Options.Toggle_Shop_AutoSpawnBuyCrate.Value

  local value32 = v1.Options.Toggle_Shop_AutoSpawnBuyCrateByRarity
    and v1.Options.Toggle_Shop_AutoSpawnBuyCrateByRarity.Value

  if v10.IsAutoSpawnBuyCrateLoopRunning or not value31 and not value32 then
    return
  end

  v10.IsAutoSpawnBuyCrateLoopRunning = true

  task.spawn(function()
    local plotSystemRemotes3 = replicatedStorage:FindFirstChild("PlotSystemRemotes")
      or replicatedStorage:WaitForChild("PlotSystemRemotes", 5)

    local conveyorButtonPress = plotSystemRemotes3
      and (plotSystemRemotes3:FindFirstChild("ConveyorButtonPress")
        or plotSystemRemotes3:WaitForChild("ConveyorButtonPress", 5))

    local function f48()
      return v1.Options.Toggle_Shop_AutoSpawnBuyCrate
          and v1.Options.Toggle_Shop_AutoSpawnBuyCrate.Value
        or v1.Options.Toggle_Shop_AutoSpawnBuyCrateByRarity
          and v1.Options.Toggle_Shop_AutoSpawnBuyCrateByRarity.Value
    end

    while not v1.Unloaded and f48() do
      local v114 = false

      pcall(function()
        local value33 = v1.Options.Toggle_Shop_AutoSpawnBuyCrate
            and v1.Options.Toggle_Shop_AutoSpawnBuyCrate.Value
            and v1.Options.Dropdown_Shop_BuyCrateNames
            and v1.Options.Dropdown_Shop_BuyCrateNames.Value
          or {}

        local value34 = v1.Options.Toggle_Shop_AutoSpawnBuyCrateByRarity
            and v1.Options.Toggle_Shop_AutoSpawnBuyCrateByRarity.Value
            and v1.Options.Dropdown_Shop_BuyCrateRarities
            and v1.Options.Dropdown_Shop_BuyCrateRarities.Value
          or {}

        if not f31(value33) and not f31(value34) then
          return
        end

        for index29, value35 in ipairs(f12()) do
          local v115, v116 = f30(value35)

          local displayName = v115
              and (v115.DisplayName or v115.LobbyCrateTitle or v115.LobbyCrateName)
            or v116

          local rarity = v115 and v115.Rarity or value35:GetAttribute("Rarity")

          if f32(value33, displayName, v116, value35.Name) or f32(value34, rarity) then
            v114 = f46(value35)
            break
          end
        end

        if not v114 and conveyorButtonPress then
          conveyorButtonPress:FireServer()
        end
      end)

      if v114 then
        task.wait(2)
      else
        task.wait(localPlayer:GetAttribute("HasFastConveyor") == true and 0.25 or 0.5)
      end
    end

    v10.IsAutoSpawnBuyCrateLoopRunning = false
  end)
end

local function f49(p53)
  if not (p53 and p53.Parent) then
    return nil, nil
  end

  local asmrInteractionType = p53:GetAttribute("ASMRInteractionType") or "Press"
  local lower6 = tostring(p53:GetAttribute("ASMRTemplateName") or p53.Name):lower()
  local lower7 = tostring(p53.Name):lower()

  if asmrInteractionType == "Keyboard" or lower6:find("keyboard") or lower7:find("keyboard")
    or lower6:find("key") then
    for index30, value36 in ipairs(p53:GetDescendants()) do
      if value36:IsA("BasePart") then
        if value36.Name:lower():find("key") or value36:GetAttribute("Key") ~= nil
          or value36:GetAttribute("IsKey") == true then
          return value36, "Keyboard"
        end
      end
    end
  end

  if asmrInteractionType == "Slime" or lower6:find("slime") or lower7:find("slime") then
    for index31, value37 in ipairs(p53:GetDescendants()) do
      if value37:IsA("BasePart") then
        local lower8 = value37.Name:lower()

        if lower8:find("slime") or lower8 == "mesh" or lower8 == "large_slime" then
          return value37, "Slime"
        end
      end
    end

    local findFirstChildWhichIsA = p53:FindFirstChildWhichIsA("BasePart", true)

    if findFirstChildWhichIsA then
      return findFirstChildWhichIsA, "Slime"
    end
  end

  if asmrInteractionType == "Foam" or lower6:find("foam") or lower7:find("foam") then
    for index32, value38 in ipairs(p53:GetDescendants()) do
      if value38:IsA("BasePart") then
        local lower9 = value38.Name:lower()

        if lower9:find("sphere") or lower9:find("ball") or lower9:find("foam") then
          return value38, "FoamTick1"
        end
      end
    end

    local findFirstChildWhichIsA2 = p53:FindFirstChildWhichIsA("BasePart", true)

    if findFirstChildWhichIsA2 then
      return findFirstChildWhichIsA2, "FoamTick1"
    end
  end

  if asmrInteractionType == "PopIt" or lower6:find("popit") or lower6:find("pop_it")
    or lower7:find("popit") then
    for index33, value39 in ipairs(p53:GetDescendants()) do
      if value39:IsA("BasePart") then
        local lower10 = value39.Name:lower()

        if lower10:find("bubble") or lower10:find("pop") or lower10:find("button") then
          return value39, "PopIt"
        end
      end
    end
  end

  local v117 = f28(p53)

  if #v117 > 0 then
    return v117[1], asmrInteractionType
  end

  local findFirstChildWhichIsA3 = p53:FindFirstChildWhichIsA("BasePart", true)

  if findFirstChildWhichIsA3 then
    return findFirstChildWhichIsA3, asmrInteractionType
  end

  return nil, asmrInteractionType
end

local v118 = {
  Keyboard = 0.12,
  Press = 0.2,
  PopIt = 0.2,
  Slime = 0.7,
  Step = 1.25,
  Squishy = 0.42,
}

local function f50(p54)
  local lower11 = (p54 or ""):lower()

  return lower11 == "base" or lower11 == "floor" or lower11 == "plate" or lower11 == "stand"
    or lower11 == "pedestal" or lower11 == "bounds" or lower11 == "upgradestand"
    or lower11 == "hitbox" or lower11 == "rootpart" or lower11 == "support"
    or lower11:sub(1, 5) == "point"
end

local function f51(p55)
  local v119, v120 = nil, -1

  for index34, value40 in ipairs(p55:GetDescendants()) do
    if value40:IsA("BasePart") and value40.Transparency < 0.9 and not f50(value40.Name) then
      local v121 = value40.Size.X * value40.Size.Z

      if v121 > v120 then
        v119, v120 = value40, v121
      end
    end
  end

  return v119
end

local function f52(p56, p57, p58)
  for index35, value41 in ipairs(p56:GetDescendants()) do
    if value41:IsA("BasePart") and (not p58 or value41:IsA("MeshPart")) then
      local lower12 = value41.Name:lower()

      for index36, value42 in ipairs(p57) do
        if lower12:find(value42) then
          return value41
        end
      end
    end
  end

  return nil
end

local function f53(p59)
  for index37, value43 in ipairs(p59:GetDescendants()) do
    if value43:IsA("MeshPart") then
      local lower13 = value43.Name:lower()

      if lower13 == "key" or lower13:match("^key%.") or lower13 == "waxkey"
        or lower13 == "dumplingkey" or lower13 == "honeykey" then
        return value43
      end
    end
  end

  return f52(p59, { "key" }, false)
end

local function f54(p60)
  local v122 = {}

  for index38, value44 in ipairs(p60:GetDescendants()) do
    if value44:IsA("MeshPart") then
      local lower14 = value44.Name:lower()

      if lower14 == "key" or lower14:match("^key%.") or lower14 == "waxkey"
        or lower14 == "dumplingkey" or lower14 == "honeykey" then
        table.insert(v122, value44)
      end
    end
  end

  if #v122 == 0 then
    for index39, value45 in ipairs(p60:GetDescendants()) do
      if value45:IsA("BasePart") then
        local lower15 = value45.Name:lower()

        if lower15 == "key" or lower15:find("key") or lower15 == "circle"
          or lower15:match("^circle%.") then
          table.insert(v122, value45)
        end
      end
    end
  end

  return v122
end

local function f55(p61)
  if not (p61 and p61.Parent) then
    return nil
  end

  local v123 = {
    method = "fire",
    fireType = "Press",
    cycle = nil,
    firePart = nil,
    walk = nil,
  }

  local asmrInteractionType2 = p61:GetAttribute("ASMRInteractionType") or "Press"
  local lower16 = tostring(p61:GetAttribute("ASMRTemplateName") or p61.Name):lower()
  local upper = tostring(p61:GetAttribute("ProductId") or ""):upper()
  local v124 = upper:find("FOAM") ~= nil or lower16:find("foam") ~= nil

  local v125 = asmrInteractionType2 == "Keyboard" or lower16:find("keyboard") ~= nil
    or lower16:find("key") ~= nil

  local v126 = asmrInteractionType2 == "Slime" or lower16:find("slime") ~= nil

  local v127 = asmrInteractionType2 == "PopIt" or lower16:find("popit") ~= nil
    or lower16:find("pop_it") ~= nil

  local v128 = asmrInteractionType2 == "Squishy"

  if v125 then
    v123.fireType = "Keyboard"
    v123.firePart = f53(p61)
  elseif v127 then
    v123.fireType = "PopIt"

    if upper:find("BUBBLE_WRAP") then
      v123.cycle = { "PopItSmall", "PopItMedium", "PopItBig" }
    end

    v123.firePart = f52(p61, { "bubble", "pop", "button" }, false)

    if not v123.firePart then
      for index40, value46 in ipairs(p61:GetDescendants()) do
        if value46:IsA("BasePart") then
          v123.firePart = value46
          break
        end
      end
    end
  elseif v126 then
    v123.fireType = "Slime"
    v123.firePart = f52(p61, { "^cube" }, true)

    if not v123.firePart then
      v123.firePart = f52(p61, { "slime" }, true)
    end

    if not v123.firePart then
      v123.firePart = f51(p61)
    end
  elseif v124 then
    v123.fireType = "FoamTick1"

    v123.cycle = {
      "FoamTick1", "FoamTick2", "FoamTick3", "FoamTick4", "FoamTick5", "FoamTick6",
    }

    v123.firePart = f52(p61, { "sphere", "ball", "foam" }, false)

    if not v123.firePart then
      v123.firePart = f51(p61)
    end
  elseif v128 then
    v123.fireType = "Squishy"
    v123.firePart = f52(p61, { "pudding", "flake", "squishy", "cheese" }, false)

    if not v123.firePart then
      v123.firePart = f51(p61)
    end

    if not v123.firePart then
      v123.firePart = f52(p61, { "hitbox" }, false)
    end
  else
    v123.fireType = asmrInteractionType2
    v123.firePart = f51(p61)

    if not v123.firePart then
      for index41, value47 in ipairs(p61:GetDescendants()) do
        if value47:IsA("BasePart") then
          v123.firePart = value47
          break
        end
      end
    end
  end

  if not v123.firePart and p61.PrimaryPart then
    v123.firePart = p61.PrimaryPart
  end

  local v129, v130 = pcall(function()
    local primaryPart2 = f52(p61, { "hitbox" }, false)

    if not primaryPart2 then
      primaryPart2 = f51(p61)
    end

    if not primaryPart2 then
      primaryPart2 = p61.PrimaryPart
    end

    if primaryPart2 and primaryPart2:IsA("BasePart") then
      local cframe = primaryPart2.CFrame
      local size2 = primaryPart2.Size
      local surfaceY = cframe.Position.Y + size2.Y * 0.5
      local v131 = math.max(1, size2.X * 0.5)
      local v132 = math.max(1, size2.Z * 0.5)
      local v133 = math.max(1, 2)
      local v134, v135, v136, v137

      if size2.X >= size2.Z then
        v134, v135, v136, v137 = -v131 + v133, 0, v131 - v133, 0
      else
        v134, v135, v136, v137 = 0, -v132 + v133, 0, v132 - v133
      end

      local position = cframe.Position
      local rightVector = cframe.RightVector
      local lookVector = cframe.LookVector

      v123.method = "walk"

      v123.walk = {
        hitbox = primaryPart2,
        surfaceY = surfaceY,
        pointA = position + rightVector * v134 + lookVector * v135,
        pointB = position + rightVector * v136 + lookVector * v137,
      }
    end
  end)

  if not v129 then
    warn("[ASMR] walk plan error: " .. tostring(v130))
  end

  if not v123.firePart then
    local v138 = f49(p61)

    if v138 then
      v123.firePart = v138
    end
  end

  return v123
end

local function f56(p62)
  return f29(p62) / (v118[p62:GetAttribute("ASMRInteractionType") or "Press"] or 0.2)
end

local function f57(p63)
  local v139, v140 = nil, -1

  for index42, value48 in ipairs(p63 or {}) do
    local v141 = f56(value48)

    if v141 > v140 then
      v140, v139 = v141, value48
    end
  end

  return v139
end

local function f58(p64, p65, p66, fn2)
  if not (p66 and p64 and p64.firePart) then
    return
  end

  local cycle = p64.cycle or { p64.fireType }
  local v142 = 0

  while fn2() do
    v142 = v142 % #cycle + 1

    if p64.firePart.Parent then
      p66:FireServer(p65, p64.firePart, cycle[v142], p64.firePart.Position)
    end

    task.wait(0.05)
  end
end

local function f59(p67, p68, p69, fn3)
  local character4 = localPlayer.Character
  local humanoid = character4 and character4:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart = character4 and character4:FindFirstChild("HumanoidRootPart")

  if not (character4 and humanoid and humanoidRootPart and p67 and p67.walk) then
    return
  end

  local surfaceY2 = p67.walk.surfaceY
  local pointA = p67.walk.pointA
  local pointB = p67.walk.pointB
  local v143 = pointB
  local v144 = (pointA.X + pointB.X) * 0.5
  local v145 = (pointA.Z + pointB.Z) * 0.5
  local v146 = 0
  local v147 = os.clock()
  local position2 = humanoidRootPart.Position
  local v148 = os.clock()
  local v149 = v118[p67.fireType] or 0.2
  local cycle2 = p67.cycle or { p67.fireType }
  local v150 = 0
  local v151 = p67.fireType == "Keyboard" and f54(p68) or nil
  local v152 = 0

  local function f60(p70)
    humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
    humanoidRootPart.CFrame = CFrame.new(p70.X, surfaceY2 + 3, p70.Z)

    position2 = p70
    v147 = os.clock()
    v148 = os.clock()
  end

  f60(pointA)

  task.wait(0.4)

  while fn3() do
    local v153 = false

    repeat
      local v154 = os.clock()
      local position3 = humanoidRootPart.Position
      local v155 = position3.X - v144
      local v156 = position3.Z - v145

      if v155 * v155 + v156 * v156 > 225 then
        position2 = position3
        v147 = os.clock()
        task.wait(0.5)
        v153 = true
        break
      end

      if math.abs(position3.Y - surfaceY2) > 8 or v154 - v147 > 8 then
        f60(v143 == pointB and pointA or pointB)
      end

      if (position3 - position2).Magnitude < 0.2 then
        if v154 - v148 > 1.2 then
          f60(v143 == pointB and pointA or pointB)
        end
      else
        v148 = v154
      end

      position2 = position3
      local v157 = v143.X - position3.X
      local v158 = v143.Z - position3.Z
      local v159 = math.sqrt(v157 * v157 + v158 * v158)

      if v159 < 1 then
        v143 = v143 == pointA and pointB or pointA
      else
        local v160 = math.min(0.5, v159)
        local v161, v162 = v157 / v159, v158 / v159

        humanoidRootPart.CFrame = CFrame.new(
          position3.X + v161 * v160, surfaceY2 + 3, position3.Z + v162 * v160
        )

        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(v161 * 8, 0, v162 * 8)
      end

      if p69 and p67.firePart and p67.firePart.Parent and v154 - v146 >= v149 then
        v146 = v154
        v150 = v150 % #cycle2 + 1
        p69:FireServer(p68, p67.firePart, cycle2[v150], p67.firePart.Position)
      end

      if p69 and v151 and #v151 > 0 then
        v152 = v152 % #v151 + 1
        local v163 = v151[v152]

        if v163.Parent then
          p69:FireServer(p68, v163, "Keyboard", v163.Position)
        end
      end

      task.wait(0.05)
      v153 = true
    until true

    if not v153 then
      break
    end
  end
end

local function f61(p71, p72)
  local asmrInteractionType3 = p71:GetAttribute("ASMRInteractionType") or p72 or "Press"
  local lower17 = tostring(p71:GetAttribute("ASMRTemplateName") or p71.Name):lower()

  if tostring(p71:GetAttribute("ProductId") or ""):upper():find("FOAM") or lower17:find("foam") then
    return "FoamTick1"
  end

  return asmrInteractionType3
end

local function f62()
  if v10.IsAutoFarmHighestRewardASMRRunning then
    return
  end

  v10.IsAutoFarmHighestRewardASMRRunning = true

  task.spawn(function()
    local asmrRewardRemotes = replicatedStorage:FindFirstChild("ASMRRewardRemotes")
      or replicatedStorage:WaitForChild("ASMRRewardRemotes", 5)

    local requestInteraction = asmrRewardRemotes
      and (asmrRewardRemotes:FindFirstChild("RequestInteraction")
        or asmrRewardRemotes:WaitForChild("RequestInteraction", 5))

    local v164 = nil

    task.spawn(function()
      while not v1.Unloaded and v1.Options.Toggle_Farm_AutoFarmHighestRewardASMR
        and v1.Options.Toggle_Farm_AutoFarmHighestRewardASMR.Value do
        pcall(function()
          local v165 = f57((f13()))

          if not v164 or not v164.Parent then
            if v165 then
              v164 = v165
            end
          elseif v165 and v165 ~= v164 then
            if f56(v165) > f56(v164) * 1.1 then
              v164 = v165
            end
          end

          if v164 and v164.Parent then
            local character5 = localPlayer.Character

            local humanoidRootPart2 = character5
              and character5:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart2 then
              local position4 = v164:GetPivot().Position

              if (humanoidRootPart2.Position - position4).Magnitude > 15 then
                humanoidRootPart2.CFrame = CFrame.new(position4 + Vector3.new(0, 6, 0))
              end
            end
          end
        end)

        task.wait(5)
      end
    end)

    local gravity = workspace.Gravity
    workspace.Gravity = 0

    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoFarmHighestRewardASMR
      and v1.Options.Toggle_Farm_AutoFarmHighestRewardASMR.Value do
      pcall(function()
        if v164 and v164.Parent then
          local v166 = v164

          local function f63()
            return v164 == v166 and v166.Parent ~= nil and not v1.Unloaded
              and v1.Options.Toggle_Farm_AutoFarmHighestRewardASMR
              and v1.Options.Toggle_Farm_AutoFarmHighestRewardASMR.Value
          end

          local v167 = f55(v164)

          if v167 and requestInteraction then
            if v167.method == "walk" and v167.walk then
              f59(v167, v164, requestInteraction, f63)
            elseif v167.firePart then
              f58(v167, v164, requestInteraction, f63)
            else
              local v168, v169 = f49(v164)
              local v170 = f61(v164, v169)

              if v168 and v168:IsA("BasePart") then
                requestInteraction:FireServer(v164, v168, v170, v168.Position)
              end

              task.wait(0.05)
            end

            task.wait(0.05)
          else
            task.wait(1)
          end
        else
          task.wait(1)
        end
      end)

      task.wait(0.05)
    end

    workspace.Gravity = gravity
    v10.IsAutoFarmHighestRewardASMRRunning = false
  end)
end

local function f64()
  local value49 = v1.Options.Toggle_Shop_AutoUpgradeASMRNames
    and v1.Options.Toggle_Shop_AutoUpgradeASMRNames.Value

  local value50 = v1.Options.Toggle_Shop_AutoUpgradeASMRRarities
    and v1.Options.Toggle_Shop_AutoUpgradeASMRRarities.Value

  if v10.IsAutoUpgradeASMRLoopRunning or not value49 and not value50 then
    return
  end

  v10.IsAutoUpgradeASMRLoopRunning = true

  task.spawn(function()
    local asmrRewardRemotes2 = replicatedStorage:FindFirstChild("ASMRRewardRemotes")
      or replicatedStorage:WaitForChild("ASMRRewardRemotes", 5)

    local requestUpgrade = asmrRewardRemotes2
      and (asmrRewardRemotes2:FindFirstChild("RequestUpgrade")
        or asmrRewardRemotes2:WaitForChild("RequestUpgrade", 5))

    local function f65()
      return v1.Options.Toggle_Shop_AutoUpgradeASMRNames
          and v1.Options.Toggle_Shop_AutoUpgradeASMRNames.Value
        or v1.Options.Toggle_Shop_AutoUpgradeASMRRarities
          and v1.Options.Toggle_Shop_AutoUpgradeASMRRarities.Value
    end

    while not v1.Unloaded and f65() do
      local v171 = false

      pcall(function()
        local value51 = v1.Options.Toggle_Shop_AutoUpgradeASMRNames
            and v1.Options.Toggle_Shop_AutoUpgradeASMRNames.Value
            and v1.Options.Dropdown_Shop_UpgradeASMRNames
            and v1.Options.Dropdown_Shop_UpgradeASMRNames.Value
          or {}

        local value52 = v1.Options.Toggle_Shop_AutoUpgradeASMRRarities
            and v1.Options.Toggle_Shop_AutoUpgradeASMRRarities.Value
            and v1.Options.Dropdown_Shop_UpgradeASMRRarities
            and v1.Options.Dropdown_Shop_UpgradeASMRRarities.Value
          or {}

        if not f31(value51) and not f31(value52) then
          return
        end

        local sliderShopMaxUpgradeLevel = v1.Options.Slider_Shop_MaxUpgradeLevel

        local v172 = sliderShopMaxUpgradeLevel and tonumber(sliderShopMaxUpgradeLevel.Value)
          or 100

        for index43, value53 in ipairs((f13())) do
          local v173 = false

          repeat
            if not f65() then
              break
            end

            if value53:GetAttribute("NoUpgrades") == true then
              v173 = true
              break
            end

            local v174 = tonumber(value53:GetAttribute("ASMRLevel")) or 1

            if v174 >= (tonumber(value53:GetAttribute("ASMRMaxLevel")) or 100) or v174 >= v172 then
              v173 = true
              break
            end

            local v175 = f39(value53)

            if v175
              and (f32(value51, v175.ASMRDisplayName, v175.ASMRTemplateName, value53.Name)
                or f32(value52, v175.ASMRRarity)) then
              local v176 = f40(value53)

              if v176 > 0 and f10() < v176 then
                v173 = true
                break
              end

              if requestUpgrade then
                requestUpgrade:FireServer(value53)
                v171 = true
              end

              task.wait(0.1)
            end

            v173 = true
          until true

          if not v173 then
            break
          end
        end
      end)

      if v171 then
        task.wait(0.5)
      else
        task.wait(5)
      end
    end

    v10.IsAutoUpgradeASMRLoopRunning = false
  end)
end

local function f66()
  local value54 = v1.Options.Toggle_Placement_AutoPlaceCrateNames
    and v1.Options.Toggle_Placement_AutoPlaceCrateNames.Value

  local value55 = v1.Options.Toggle_Placement_AutoPlaceCrateRarities
    and v1.Options.Toggle_Placement_AutoPlaceCrateRarities.Value

  if v10.IsAutoPlaceCrateLoopRunning or not value54 and not value55 then
    return
  end

  v10.IsAutoPlaceCrateLoopRunning = true

  task.spawn(function()
    local cratePlacementRemotes = replicatedStorage:FindFirstChild("CratePlacementRemotes")
      or replicatedStorage:WaitForChild("CratePlacementRemotes", 5)

    local requestPlaceCrate = cratePlacementRemotes
      and (cratePlacementRemotes:FindFirstChild("RequestPlaceCrate")
        or cratePlacementRemotes:WaitForChild("RequestPlaceCrate", 5))

    local function f67()
      return v1.Options.Toggle_Placement_AutoPlaceCrateNames
          and v1.Options.Toggle_Placement_AutoPlaceCrateNames.Value
        or v1.Options.Toggle_Placement_AutoPlaceCrateRarities
          and v1.Options.Toggle_Placement_AutoPlaceCrateRarities.Value
    end

    local v177 = {}

    while not v1.Unloaded and f67() do
      local v178 = false

      local v179, v180 = pcall(function()
        local value56 = v1.Options.Toggle_Placement_AutoPlaceCrateNames
            and v1.Options.Toggle_Placement_AutoPlaceCrateNames.Value
            and v1.Options.Dropdown_Placement_PlaceCrateNames
            and v1.Options.Dropdown_Placement_PlaceCrateNames.Value
          or {}

        local value57 = v1.Options.Toggle_Placement_AutoPlaceCrateRarities
            and v1.Options.Toggle_Placement_AutoPlaceCrateRarities.Value
            and v1.Options.Dropdown_Placement_PlaceCrateRarities
            and v1.Options.Dropdown_Placement_PlaceCrateRarities.Value
          or {}

        if not f31(value56) and not f31(value57) then
          return
        end

        local v181 = f34()
        local character6 = localPlayer.Character
        local humanoid2 = character6 and character6:FindFirstChildOfClass("Humanoid")
        local v182 = {}

        for index44, value58 in ipairs(v181) do
          local v183 = false

          repeat
            if not f67() then
              break
            end

            local v184 = f38(value58)

            if v184
                and f32(value56, v184.CrateDisplayName, v184.CrateTemplateName, value58.Name)
              or v184 and f32(value57, v184.CrateRarity) then
              local v185, v186 = f26(value58, v182, v177)

              if not v185 then
                v183 = true
                break
              end

              table.insert(v182, { Pos = v185.Position, Radius = v186 or 2 })

              if f43(
                character6 and character6:FindFirstChild("HumanoidRootPart"), v185.Position, 3
              ) then
                task.wait(0.3)
              end

              if humanoid2 and value58.Parent ~= character6 then
                humanoid2:EquipTool(value58)
                task.wait(0.2)
              end

              if requestPlaceCrate then
                requestPlaceCrate:FireServer(v185)
                task.wait(1)

                if value58.Parent
                  and (value58.Parent == character6 or value58.Parent == localPlayer.Backpack) then
                  f42(v177, v185.Position, v186 or 2)
                else
                  v178 = true
                end
              end
            end

            v183 = true
          until true

          if not v183 then
            break
          end
        end
      end)

      if v178 then
        task.wait(4)
      else
        task.wait(5)
      end
    end

    v10.IsAutoPlaceCrateLoopRunning = false
  end)
end

local function f68()
  if v10.IsAutoUnboxCrateLoopRunning
    or not (v1.Options.Toggle_Placement_AutoUnboxCrate
      and v1.Options.Toggle_Placement_AutoUnboxCrate.Value) then
    return
  end

  v10.IsAutoUnboxCrateLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Placement_AutoUnboxCrate
      and v1.Options.Toggle_Placement_AutoUnboxCrate.Value do
      local v187 = false

      pcall(function()
        for index45, value59 in ipairs((f14())) do
          local v188 = value59:GetAttribute("Ready") == true

          local findFirstChild8 = value59:FindFirstChild("OpenCratePrompt", true)
            or value59:FindFirstChildWhichIsA("ProximityPrompt", true)

          if findFirstChild8 and findFirstChild8:IsA("ProximityPrompt")
            and findFirstChild8.Enabled and v188 then
            findFirstChild8.HoldDuration = 0
            local character7 = localPlayer.Character

            if f43(
              character7 and character7:FindFirstChild("HumanoidRootPart"),
              value59:GetPivot().Position, 3
            ) then
              task.wait(0.5)
            end

            f44(findFirstChild8)
            v187 = true
            task.wait(1)
          end
        end
      end)

      if v187 then
        task.wait(4)
      else
        task.wait(8)
      end
    end

    v10.IsAutoUnboxCrateLoopRunning = false
  end)
end

local function f69()
  local value60 = v1.Options.Toggle_Placement_AutoPlaceASMRNames
    and v1.Options.Toggle_Placement_AutoPlaceASMRNames.Value

  local value61 = v1.Options.Toggle_Placement_AutoPlaceASMRRarities
    and v1.Options.Toggle_Placement_AutoPlaceASMRRarities.Value

  if v10.IsAutoPlaceASMRLoopRunning or not value60 and not value61 then
    return
  end

  v10.IsAutoPlaceASMRLoopRunning = true

  task.spawn(function()
    local asmrPlacementRemotes2 = replicatedStorage:FindFirstChild("ASMRPlacementRemotes")
      or replicatedStorage:WaitForChild("ASMRPlacementRemotes", 5)

    local requestPlaceASMR = asmrPlacementRemotes2
      and (asmrPlacementRemotes2:FindFirstChild("RequestPlaceASMR")
        or asmrPlacementRemotes2:WaitForChild("RequestPlaceASMR", 5))

    local function f70()
      return v1.Options.Toggle_Placement_AutoPlaceASMRNames
          and v1.Options.Toggle_Placement_AutoPlaceASMRNames.Value
        or v1.Options.Toggle_Placement_AutoPlaceASMRRarities
          and v1.Options.Toggle_Placement_AutoPlaceASMRRarities.Value
    end

    local v189 = {}

    while not v1.Unloaded and f70() do
      local v190 = false

      local v191, v192 = pcall(function()
        local value62 = v1.Options.Toggle_Placement_AutoPlaceASMRNames
            and v1.Options.Toggle_Placement_AutoPlaceASMRNames.Value
            and v1.Options.Dropdown_Placement_PlaceASMRNames
            and v1.Options.Dropdown_Placement_PlaceASMRNames.Value
          or {}

        local value63 = v1.Options.Toggle_Placement_AutoPlaceASMRRarities
            and v1.Options.Toggle_Placement_AutoPlaceASMRRarities.Value
            and v1.Options.Dropdown_Placement_PlaceASMRRarities
            and v1.Options.Dropdown_Placement_PlaceASMRRarities.Value
          or {}

        if not f31(value62) and not f31(value63) then
          return
        end

        local v193 = f33()
        local character8 = localPlayer.Character
        local humanoid3 = character8 and character8:FindFirstChildOfClass("Humanoid")
        local v194 = {}

        for index46, value64 in ipairs(v193) do
          local v195 = false

          repeat
            if not f70() then
              break
            end

            local v196 = f37(value64)

            if v196 and f32(value62, v196.ASMRDisplayName, v196.ASMRTemplateName, value64.Name)
              or v196 and f32(value63, v196.ASMRRarity) then
              local v197, v198 = f26(value64, v194, v189)

              if not v197 then
                v195 = true
                break
              end

              table.insert(v194, { Pos = v197.Position, Radius = v198 or 2 })

              if f43(
                character8 and character8:FindFirstChild("HumanoidRootPart"), v197.Position, 3
              ) then
                task.wait(0.3)
              end

              if humanoid3 and value64.Parent ~= character8 then
                humanoid3:EquipTool(value64)
                task.wait(0.2)
              end

              if requestPlaceASMR then
                requestPlaceASMR:FireServer(v197)
                task.wait(1)

                if value64.Parent
                  and (value64.Parent == character8 or value64.Parent == localPlayer.Backpack) then
                  f42(v189, v197.Position, v198 or 2)
                else
                  v190 = true
                end
              end
            end

            v195 = true
          until true

          if not v195 then
            break
          end
        end
      end)

      if v190 then
        task.wait(4)
      else
        task.wait(5)
      end
    end

    v10.IsAutoPlaceASMRLoopRunning = false
  end)
end

local function f71()
  if v10.IsAutoUnlockPlotExpansionLoopRunning
    or not (v1.Options.Toggle_Shop_AutoUnlockPlotExpansion
      and v1.Options.Toggle_Shop_AutoUnlockPlotExpansion.Value) then
    return
  end

  v10.IsAutoUnlockPlotExpansionLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoUnlockPlotExpansion
      and v1.Options.Toggle_Shop_AutoUnlockPlotExpansion.Value do
      local v199 = false

      pcall(function()
        for index47, value65 in ipairs((f15())) do
          local v200 = false

          repeat
            if not (v1.Options.Toggle_Shop_AutoUnlockPlotExpansion
              and v1.Options.Toggle_Shop_AutoUnlockPlotExpansion.Value) then
              break
            end

            local prompt = value65.Prompt
            local v201 = f16(value65.ExpansionId, prompt)

            if v201 > 0 and f10() < v201 then
              v200 = true
              break
            end

            local parent2 = prompt.Parent:IsA("BasePart") and prompt.Parent or value65.Part
            local position5 = parent2 and parent2:GetPivot().Position

            if f43(localPlayer.Character
              and localPlayer.Character:FindFirstChild("HumanoidRootPart"), position5, 3) then
              task.wait(0.35)
            end

            prompt.HoldDuration = 0
            f44(prompt)
            v199 = true
            task.wait(0.35)
            v200 = true
          until true

          if not v200 then
            break
          end
        end
      end)

      if v199 then
        task.wait(2)
      else
        task.wait(5)
      end
    end

    v10.IsAutoUnlockPlotExpansionLoopRunning = false
  end)
end

local function f72()
  if v10.IsAutoBuyWorkerLoopRunning
    or not (v1.Options.Toggle_Shop_AutoBuyWorker and v1.Options.Toggle_Shop_AutoBuyWorker.Value) then
    return
  end

  v10.IsAutoBuyWorkerLoopRunning = true

  task.spawn(function()
    local workerRemotes = replicatedStorage:FindFirstChild("WorkerRemotes")
      or replicatedStorage:WaitForChild("WorkerRemotes", 5)

    local buyWorker = workerRemotes
      and (workerRemotes:FindFirstChild("BuyWorker")
        or workerRemotes:WaitForChild("BuyWorker", 5))

    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoBuyWorker
      and v1.Options.Toggle_Shop_AutoBuyWorker.Value do
      local v202 = false

      pcall(function()
        local v203 = 0

        if v6 and typeof(v6.GetOwnedWorkerCount) == "function" then
          v203 = v6.GetOwnedWorkerCount(localPlayer)
        else
          v203 = #f35()
        end

        local v204 = 100

        if v6 and typeof(v6.GetMaxWorkerSlots) == "function" then
          local v205 = tonumber(localPlayer:GetAttribute("RebirthCount")) or 0
          v204 = v6.GetMaxWorkerSlots(v205) or 100
        end

        if v203 < v204 then
          local v206 = 500

          if v6 and typeof(v6.GetWorkerPrice) == "function" then
            v206 = v6.GetWorkerPrice(v203) or 500
          end

          if f10() >= v206 and buyWorker then
            if buyWorker:IsA("RemoteEvent") then
              buyWorker:FireServer()
            elseif buyWorker:IsA("RemoteFunction") then
              buyWorker:InvokeServer()
            end

            v202 = true
          end
        end
      end)

      if v202 then
        task.wait(1)
      else
        task.wait(5)
      end
    end

    v10.IsAutoBuyWorkerLoopRunning = false
  end)
end

local function f73()
  if v10.IsAutoAssignWorkerLoopRunning
    or not (v1.Options.Toggle_Farm_AutoAssignWorker and v1.Options.Toggle_Farm_AutoAssignWorker.Value) then
    return
  end

  v10.IsAutoAssignWorkerLoopRunning = true

  task.spawn(function()
    local workerRemotes2 = replicatedStorage:FindFirstChild("WorkerRemotes")
      or replicatedStorage:WaitForChild("WorkerRemotes", 5)

    local assignWorker = workerRemotes2
      and (workerRemotes2:FindFirstChild("AssignWorker")
        or workerRemotes2:WaitForChild("AssignWorker", 5))

    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoAssignWorker
      and v1.Options.Toggle_Farm_AutoAssignWorker.Value do
      local v207 = false

      pcall(function()
        local v208 = f35()

        if #v208 > 0 then
          local v209 = f36()
          local character9 = localPlayer.Character
          local humanoid4 = character9 and character9:FindFirstChildOfClass("Humanoid")

          for index48, value66 in ipairs(v208) do
            local v210 = v209[index48]

            if not v210 then
              break
            end

            if humanoid4 and value66.Parent ~= character9 then
              humanoid4:EquipTool(value66)
              task.wait(0.2)
            end

            if assignWorker then
              assignWorker:FireServer(v210, value66)
              v207 = true
              task.wait(0.35)
            end
          end
        end
      end)

      if v207 then
        task.wait(1.5)
      else
        task.wait(5)
      end
    end

    v10.IsAutoAssignWorkerLoopRunning = false
  end)
end

local function f74()
  if v10.IsAutoUpgradeConveyorLoopRunning
    or not (v1.Options.Toggle_Shop_AutoUpgradeConveyor
      and v1.Options.Toggle_Shop_AutoUpgradeConveyor.Value) then
    return
  end

  v10.IsAutoUpgradeConveyorLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoUpgradeConveyor
      and v1.Options.Toggle_Shop_AutoUpgradeConveyor.Value do
      local v211 = false

      pcall(function()
        local v212 = f8()

        if not v212 then
          return
        end

        local findFirstChild9 = v212:FindFirstChild("UpgradeConveyorButton", true)

        if not findFirstChild9 then
          return
        end

        local v213, v214, v215 = f18()

        if v213 > 0 and f10() < v213 then
          return
        end

        local character10 = localPlayer.Character
        local humanoidRootPart3 = character10 and character10:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart3 then
          local position6 = findFirstChild9:GetPivot().Position
          humanoidRootPart3.CFrame = CFrame.new(position6 + Vector3.new(0, 2.5, 0))

          local findFirstChildWhichIsA4 = findFirstChild9:FindFirstChildWhichIsA(
            "ProximityPrompt", true
          )

          if findFirstChildWhichIsA4 and findFirstChildWhichIsA4.Enabled then
            findFirstChildWhichIsA4.HoldDuration = 0
            f44(findFirstChildWhichIsA4)
          end

          v211 = true
        end
      end)

      if v211 then
        task.wait(1)
      else
        task.wait(5)
      end
    end

    v10.IsAutoUpgradeConveyorLoopRunning = false
  end)
end

local function f75()
  task.spawn(function()
    while not v1.Unloaded do
      pcall(function()
        if v12.RebirthInfo then
          local v216 = f41()

          local v217 = string.format([[
<b>Rebirth:</b> <font color="#00E5FF"><b>%d / %d</b></font>
<b>Next Cash Requirement:</b> <font color="#00E5FF"><b>%s</b></font>
<b>Required Crate:</b> <font color="#00E5FF"><b>%s</b></font>
<b>Required ASMR:</b> <font color="#00E5FF"><b>%s</b></font>
<b>Current Bonus:</b> <font color="#00E5FF"><b>+%d%% Cash</b></font>]], v216.RebirthCount, v216.MaxRebirths, v216.CashRequirementFormatted, v216.RequiredCrateDisplayName, v216.RequiredASMRDisplayName, v216.CashBonusPercent)

          v12.RebirthInfo:SetContent(v217)
        end
      end)

      task.wait(10)
    end
  end)
end

local function f76()
  if v10.IsAutoRebirthLoopRunning
    or not (v1.Options.Toggle_Shop_AutoRebirth and v1.Options.Toggle_Shop_AutoRebirth.Value) then
    return
  end

  v10.IsAutoRebirthLoopRunning = true

  task.spawn(function()
    local rebirthRemotes2 = replicatedStorage:FindFirstChild("RebirthRemotes")
      or replicatedStorage:WaitForChild("RebirthRemotes", 5)

    local requestRebirth = rebirthRemotes2
      and (rebirthRemotes2:FindFirstChild("RequestRebirth")
        or rebirthRemotes2:WaitForChild("RequestRebirth", 5))

    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoRebirth
      and v1.Options.Toggle_Shop_AutoRebirth.Value do
      pcall(function()
        local v218 = f41()

        if v218 and v218.CanRebirth and requestRebirth then
          requestRebirth:InvokeServer()
        end
      end)

      task.wait(10)
    end

    v10.IsAutoRebirthLoopRunning = false
  end)
end

local function f77()
  local workerRemotes3 = replicatedStorage:FindFirstChild("WorkerRemotes")
    or replicatedStorage:WaitForChild("WorkerRemotes", 5)

  local removeWorker = workerRemotes3
    and (workerRemotes3:FindFirstChild("RemoveWorker")
      or workerRemotes3:WaitForChild("RemoveWorker", 5))

  if not removeWorker then
    return
  end

  for index49, value67 in ipairs((f13())) do
    if value67:GetAttribute("WorkerAssigned") == true
      or value67:GetAttribute("AssignedWorkerId") ~= nil then
      pcall(function()
        if removeWorker:IsA("RemoteEvent") then
          removeWorker:FireServer(value67)
        elseif removeWorker:IsA("RemoteFunction") then
          removeWorker:InvokeServer(value67)
        end
      end)

      task.wait(0.3)
    end
  end
end

local function f78()
  if v10.IsAutoSellInventoryLoopRunning
    or not (v1.Options.Toggle_Shop_AutoSellInventory
      and v1.Options.Toggle_Shop_AutoSellInventory.Value) then
    return
  end

  v10.IsAutoSellInventoryLoopRunning = true

  task.spawn(function()
    local asmrSellRemotes = replicatedStorage:FindFirstChild("ASMRSellRemotes")
      or replicatedStorage:WaitForChild("ASMRSellRemotes", 5)

    local sellASMRRequest = asmrSellRemotes
      and (asmrSellRemotes:FindFirstChild("SellASMRRequest")
        or asmrSellRemotes:WaitForChild("SellASMRRequest", 5))

    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoSellInventory
      and v1.Options.Toggle_Shop_AutoSellInventory.Value do
      if sellASMRRequest then
        pcall(function() sellASMRRequest:InvokeServer("SellInventory") end)
      end

      task.wait(5)
    end

    v10.IsAutoSellInventoryLoopRunning = false
  end)
end

local function f79()
  local value68 = v1.Options.Toggle_Shop_AutoSellASMRNames
    and v1.Options.Toggle_Shop_AutoSellASMRNames.Value

  local value69 = v1.Options.Toggle_Shop_AutoSellASMRRarities
    and v1.Options.Toggle_Shop_AutoSellASMRRarities.Value

  if v10.IsAutoSellThisLoopRunning or not value68 and not value69 then
    return
  end

  v10.IsAutoSellThisLoopRunning = true

  task.spawn(function()
    local asmrSellRemotes2 = replicatedStorage:FindFirstChild("ASMRSellRemotes")
      or replicatedStorage:WaitForChild("ASMRSellRemotes", 5)

    local sellASMRRequest2 = asmrSellRemotes2
      and (asmrSellRemotes2:FindFirstChild("SellASMRRequest")
        or asmrSellRemotes2:WaitForChild("SellASMRRequest", 5))

    local function f80()
      return v1.Options.Toggle_Shop_AutoSellASMRNames
          and v1.Options.Toggle_Shop_AutoSellASMRNames.Value
        or v1.Options.Toggle_Shop_AutoSellASMRRarities
          and v1.Options.Toggle_Shop_AutoSellASMRRarities.Value
    end

    while not v1.Unloaded and f80() do
      pcall(function()
        local value70 = v1.Options.Toggle_Shop_AutoSellASMRNames
            and v1.Options.Toggle_Shop_AutoSellASMRNames.Value
            and v1.Options.Dropdown_Shop_AutoSellASMRNames
            and v1.Options.Dropdown_Shop_AutoSellASMRNames.Value
          or {}

        local value71 = v1.Options.Toggle_Shop_AutoSellASMRRarities
            and v1.Options.Toggle_Shop_AutoSellASMRRarities.Value
            and v1.Options.Dropdown_Shop_AutoSellASMRRarities
            and v1.Options.Dropdown_Shop_AutoSellASMRRarities.Value
          or {}

        if not f31(value70) and not f31(value71) then
          return
        end

        local v219 = f33()
        local character11 = localPlayer.Character
        local humanoid5 = character11 and character11:FindFirstChildOfClass("Humanoid")

        for index50, value72 in ipairs(v219) do
          if not f80() then
            break
          end

          local v220 = f37(value72)

          if v220
            and (f32(value70, v220.ASMRDisplayName, v220.ASMRTemplateName, value72.Name)
              or f32(value71, v220.ASMRRarity)) then
            if humanoid5 and value72.Parent ~= character11 then
              humanoid5:EquipTool(value72)
              task.wait(0.1)
            end

            if sellASMRRequest2 then
              sellASMRRequest2:InvokeServer("SellThis")
            end

            task.wait(0.1)
          end
        end
      end)

      task.wait(5)
    end

    v10.IsAutoSellThisLoopRunning = false
  end)
end

local function f81()
  if v10.IsAutoClaimDailyRewardLoopRunning
    or not (v1.Options.Toggle_Reward_AutoClaimDailyReward
      and v1.Options.Toggle_Reward_AutoClaimDailyReward.Value) then
    return
  end

  v10.IsAutoClaimDailyRewardLoopRunning = true

  task.spawn(function()
    local dailyRewardRemotes = replicatedStorage:FindFirstChild("DailyRewardRemotes")
      or replicatedStorage:WaitForChild("DailyRewardRemotes", 5)

    local getDailyRewardState = dailyRewardRemotes
      and (dailyRewardRemotes:FindFirstChild("GetDailyRewardState")
        or dailyRewardRemotes:WaitForChild("GetDailyRewardState", 5))

    local claimDailyReward = dailyRewardRemotes
      and (dailyRewardRemotes:FindFirstChild("ClaimDailyReward")
        or dailyRewardRemotes:WaitForChild("ClaimDailyReward", 5))

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimDailyReward
      and v1.Options.Toggle_Reward_AutoClaimDailyReward.Value do
      pcall(function()
        if getDailyRewardState and claimDailyReward then
          local invokeServer2 = getDailyRewardState:InvokeServer()

          if typeof(invokeServer2) == "table" and invokeServer2.CanClaim == true then
            claimDailyReward:FireServer()
          end
        end
      end)

      task.wait(60)
    end

    v10.IsAutoClaimDailyRewardLoopRunning = false
  end)
end

local function f82()
  if v10.IsAutoClaimOfflineEarningsLoopRunning
    or not (v1.Options.Toggle_Reward_AutoClaimOfflineEarnings
      and v1.Options.Toggle_Reward_AutoClaimOfflineEarnings.Value) then
    return
  end

  v10.IsAutoClaimOfflineEarningsLoopRunning = true

  task.spawn(function()
    local workerRemotes4 = replicatedStorage:FindFirstChild("WorkerRemotes")
      or replicatedStorage:WaitForChild("WorkerRemotes", 5)

    local claimOfflineEarnings = workerRemotes4
      and (workerRemotes4:FindFirstChild("ClaimOfflineEarnings")
        or workerRemotes4:WaitForChild("ClaimOfflineEarnings", 5))

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimOfflineEarnings
      and v1.Options.Toggle_Reward_AutoClaimOfflineEarnings.Value do
      pcall(function()
        if claimOfflineEarnings then
          if claimOfflineEarnings:IsA("RemoteEvent") then
            claimOfflineEarnings:FireServer("Sync")
          elseif claimOfflineEarnings:IsA("RemoteFunction") then
            claimOfflineEarnings:InvokeServer("Sync")
          end

          task.wait(0.5)
          local v221 = tonumber(localPlayer:GetAttribute("PendingOfflineEarnings")) or 0
          local v222 = localPlayer:GetAttribute("HasPendingOfflineEarnings") == true

          if v221 > 0 or v222 then
            if claimOfflineEarnings:IsA("RemoteEvent") then
              claimOfflineEarnings:FireServer("Claim")
            elseif claimOfflineEarnings:IsA("RemoteFunction") then
              claimOfflineEarnings:InvokeServer("Claim")
            end
          end
        end
      end)

      task.wait(60)
    end

    v10.IsAutoClaimOfflineEarningsLoopRunning = false
  end)
end

local function f83()
  if v10.IsAutoWheelSpinLoopRunning
    or not (v1.Options.Toggle_Reward_AutoWheelSpin and v1.Options.Toggle_Reward_AutoWheelSpin.Value) then
    return
  end

  v10.IsAutoWheelSpinLoopRunning = true

  task.spawn(function()
    local wheelRemotes = replicatedStorage:FindFirstChild("WheelRemotes")
      or replicatedStorage:WaitForChild("WheelRemotes", 5)

    local getState = wheelRemotes
      and (wheelRemotes:FindFirstChild("GetState") or wheelRemotes:WaitForChild("GetState", 5))

    local requestSpin = wheelRemotes
      and (wheelRemotes:FindFirstChild("RequestSpin")
        or wheelRemotes:WaitForChild("RequestSpin", 5))

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoWheelSpin
      and v1.Options.Toggle_Reward_AutoWheelSpin.Value do
      pcall(function()
        if getState and requestSpin then
          local invokeServer3 = getState:InvokeServer()

          if typeof(invokeServer3) == "table" then
            local v223 = tonumber(invokeServer3.Spins) or 0
            local v224 = tonumber(invokeServer3.SecondsUntilFreeSpin) or 999

            if v223 > 0 or v224 <= 0 then
              if requestSpin:IsA("RemoteFunction") then
                requestSpin:InvokeServer()
              elseif requestSpin:IsA("RemoteEvent") then
                requestSpin:FireServer()
              end
            end
          end
        end
      end)

      task.wait(15)
    end

    v10.IsAutoWheelSpinLoopRunning = false
  end)
end

local function f84()
  if v10.IsAutoCollectFireIceEventCratesLoopRunning
    or not (v1.Options.Toggle_Reward_AutoCollectFireIceEventCrates
      and v1.Options.Toggle_Reward_AutoCollectFireIceEventCrates.Value) then
    return
  end

  v10.IsAutoCollectFireIceEventCratesLoopRunning = true

  task.spawn(function()
    local v225 = nil

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoCollectFireIceEventCrates
      and v1.Options.Toggle_Reward_AutoCollectFireIceEventCrates.Value do
      pcall(function()
        local activeEvent = replicatedStorage:GetAttribute("ActiveEvent") or "None"
        local eventPhase = replicatedStorage:GetAttribute("EventPhase") or "None"
        local v226 = tostring(activeEvent) .. " | Phase: " .. tostring(eventPhase)

        if v226 ~= v225 then
          v225 = v226
          print("[Event] Current Event: " .. v226)
        end

        if (activeEvent == "FireIce"
            or replicatedStorage:GetAttribute("FireIceEventActive") == true)
          and (eventPhase == "Active" or eventPhase == "Running") then
          local fireIceCrates = workspace:FindFirstChild("FireIceCrates")

          if fireIceCrates then
            local getChildren = fireIceCrates:GetChildren()

            if #getChildren > 0 then
              local character12 = localPlayer.Character

              local humanoidRootPart4 = character12
                and character12:FindFirstChild("HumanoidRootPart")

              for index51, value73 in ipairs(getChildren) do
                if not (v1.Options.Toggle_Reward_AutoCollectFireIceEventCrates
                  and v1.Options.Toggle_Reward_AutoCollectFireIceEventCrates.Value) then
                  break
                end

                if value73:IsA("Model") and value73.Parent then
                  character12 = localPlayer.Character

                  humanoidRootPart4 = character12
                    and character12:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart4 then
                    local position7 = value73:GetPivot().Position
                    humanoidRootPart4.CFrame = CFrame.new(position7 + Vector3.new(0, 2, 0))

                    local findFirstChildWhichIsA5 = value73:FindFirstChildWhichIsA(
                      "ProximityPrompt", true
                    )

                    if findFirstChildWhichIsA5
                      and findFirstChildWhichIsA5:IsA("ProximityPrompt") then
                      findFirstChildWhichIsA5.HoldDuration = 0

                      if typeof(fireproximityprompt) == "function" then
                        fireproximityprompt(findFirstChildWhichIsA5, 0)
                      else
                        findFirstChildWhichIsA5:InputHoldBegin()
                        findFirstChildWhichIsA5:InputHoldEnd()
                      end
                    end

                    task.wait(0.05)
                  end
                end
              end
            end
          end

          task.wait(0.5)
        else
          task.wait(2)
        end
      end)
    end

    v10.IsAutoCollectFireIceEventCratesLoopRunning = false
  end)
end

local function f85()
  if v10.IsAutoCollectGalaxyEventCratesLoopRunning
    or not (v1.Options.Toggle_Reward_AutoCollectGalaxyEventCrates
      and v1.Options.Toggle_Reward_AutoCollectGalaxyEventCrates.Value) then
    return
  end

  v10.IsAutoCollectGalaxyEventCratesLoopRunning = true

  task.spawn(function()
    local v227 = nil

    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoCollectGalaxyEventCrates
      and v1.Options.Toggle_Reward_AutoCollectGalaxyEventCrates.Value do
      pcall(function()
        local activeEvent2 = replicatedStorage:GetAttribute("ActiveEvent") or "None"
        local eventPhase2 = replicatedStorage:GetAttribute("EventPhase") or "None"
        local v228 = tostring(activeEvent2) .. " | Phase: " .. tostring(eventPhase2)

        if v228 ~= v227 then
          v227 = v228
          print("[Event] Current Event: " .. v228)
        end

        if (activeEvent2 == "Galaxy"
            or replicatedStorage:GetAttribute("GalaxyEventActive") == true)
          and (eventPhase2 == "Active" or eventPhase2 == "Running") then
          local galaxyCrates = workspace:FindFirstChild("GalaxyCrates")

          if galaxyCrates then
            local getChildren2 = galaxyCrates:GetChildren()

            if #getChildren2 > 0 then
              local character13 = localPlayer.Character

              local humanoidRootPart5 = character13
                and character13:FindFirstChild("HumanoidRootPart")

              for index52, value74 in ipairs(getChildren2) do
                if not (v1.Options.Toggle_Reward_AutoCollectGalaxyEventCrates
                  and v1.Options.Toggle_Reward_AutoCollectGalaxyEventCrates.Value) then
                  break
                end

                if value74:IsA("Model") and value74.Parent then
                  character13 = localPlayer.Character

                  humanoidRootPart5 = character13
                    and character13:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart5 then
                    local position8 = value74:GetPivot().Position
                    humanoidRootPart5.CFrame = CFrame.new(position8 + Vector3.new(0, 2, 0))

                    local findFirstChildWhichIsA6 = value74:FindFirstChildWhichIsA(
                      "ProximityPrompt", true
                    )

                    if findFirstChildWhichIsA6
                      and findFirstChildWhichIsA6:IsA("ProximityPrompt") then
                      findFirstChildWhichIsA6.HoldDuration = 0

                      if typeof(fireproximityprompt) == "function" then
                        fireproximityprompt(findFirstChildWhichIsA6, 0)
                      else
                        findFirstChildWhichIsA6:InputHoldBegin()
                        findFirstChildWhichIsA6:InputHoldEnd()
                      end
                    end

                    task.wait(0.05)
                  end
                end
              end
            end
          end

          task.wait(0.5)
        else
          task.wait(1.5)
        end
      end)
    end

    v10.IsAutoCollectGalaxyEventCratesLoopRunning = false
  end)
end

v13.Products = f1()
v13.Rarities = f3()
v13.ConveyorLevels = f4()

for index53, value75 in ipairs(v13.Products) do
  if value75.ProductId then
    v13.ProductByProductId[value75.ProductId] = value75
  end

  if value75.ASMRTemplateName then
    v13.ProductByASMRTemplateName[value75.ASMRTemplateName] = value75
  end

  if value75.CrateTemplateName then
    v13.ProductByCrateTemplateName[value75.CrateTemplateName] = value75
  end

  if value75.ASMRDisplayName then
    v13.ProductByASMRDisplayName[value75.ASMRDisplayName] = value75
  end

  if value75.LobbyASMRName then
    v13.ProductByASMRDisplayName[value75.LobbyASMRName] = value75
  end

  if value75.DisplayName then
    v13.ProductByCrateDisplayName[value75.DisplayName] = value75
  end

  if value75.LobbyCrateName then
    v13.ProductByCrateDisplayName[value75.LobbyCrateName] = value75
  end
end

local unboxASMRWindow = v1:CreateWindow({ Title = "Unbox ASMR", SubTitle = "by Lamduck" })

local v229 = {
  Farm = unboxASMRWindow:AddTab({ Title = "Farm", Icon = "sprout" }),
  Shop = unboxASMRWindow:AddTab({ Title = "Shop", Icon = "shopping-bag" }),
  Placement = unboxASMRWindow:AddTab({ Title = "Placement", Icon = "box" }),
  Reward = unboxASMRWindow:AddTab({ Title = "Event & Reward", Icon = "gift" }),
  Settings = unboxASMRWindow:AddTab({ Title = "Settings", Icon = "settings" }),
}

local addSubTabBar = v229.Shop:AddSubTabBar({
  SubTabs = { "Crate", "Sell", "Upgrade", "Rebirth", "Other" },
  Default = "Crate",
})

local crate = addSubTabBar.Crate
local sell = addSubTabBar.Sell
local upgrade = addSubTabBar.Upgrade
local rebirth = addSubTabBar.Rebirth
local other = addSubTabBar.Other

local addSubTabBar2 = v229.Placement:AddSubTabBar({
  SubTabs = { "Crate", "ASMR" },
  Default = "Crate",
})

local crate2 = addSubTabBar2.Crate
local asmr3 = addSubTabBar2.ASMR

v229.Farm:AddSection("Auto Farm")

v229.Farm:AddToggle("Toggle_Farm_AutoFarmHighestRewardASMR", {
  Title = "Auto Farm Highest $/use",
  Description = "May have bug :v",
  Default = false,
  Callback = function(value76)
    if value76 then
      f62()
    end
  end,
})

v229.Farm:AddSection("Worker Automation")

v229.Farm:AddToggle("Toggle_Farm_AutoAssignWorker", {
  Title = "Auto Assign Worker to Best ASMR",
  Default = false,
  Callback = function(value77)
    if value77 then
      f73()
    end
  end,
})

v229.Farm:AddButton({
  Title = "Remove All Workers",
  Description = "Removes all assigned workers",
  Confirm = "Are you sure you want to remove all workers?",
  Callback = function() f77() end,
})

crate:AddSection("Auto Buy Crates")

crate:AddToggle("Toggle_Shop_PauseIfNotEnoughMoney", {
  Title = "Pause If Not Enough Money",
  Default = false,
  Callback = function(value78) end,
})

crate:AddDivider()

crate:AddDropdown("Dropdown_Shop_BuyCrateNames", {
  Title = "Select Crates",
  Values = f7(v13.Products, "DisplayName"),
  Multi = true,
  Searchable = true,
  Default = {},
})

crate:AddToggle("Toggle_Shop_AutoSpawnBuyCrate", {
  Title = "Auto Spawn & Buy Crate",
  Default = false,
  Callback = function(value79)
    if value79 then
      v1.Options.Toggle_Shop_AutoSpawnBuyCrateByRarity:SetValue(false)
      f47()
    end
  end,
})

crate:AddDivider()

crate:AddDropdown("Dropdown_Shop_BuyCrateRarities", {
  Title = "Select Rarities",
  Values = v13.Rarities,
  Multi = true,
  Searchable = true,
  Default = {},
})

crate:AddToggle("Toggle_Shop_AutoSpawnBuyCrateByRarity", {
  Title = "Auto Spawn & Buy Crate By Rarity",
  Default = false,
  Callback = function(value80)
    if value80 then
      v1.Options.Toggle_Shop_AutoSpawnBuyCrate:SetValue(false)
      f47()
    end
  end,
})

sell:AddSection("Auto Sell ASMR")

sell:AddToggle("Toggle_Shop_AutoSellInventory", {
  Title = "Auto Sell All Inventory",
  Description = "Automatically sells all ASMR items in your inventory",
  Confirm = "Are you sure you want to enable Auto Sell All Inventory? This will sell all ASMR items in your inventory!",
  Default = false,
  Callback = function(value81)
    if value81 then
      v1.Options.Toggle_Shop_AutoSellASMRNames:SetValue(false)
      v1.Options.Toggle_Shop_AutoSellASMRRarities:SetValue(false)
      f78()
    end
  end,
})

sell:AddDivider()

sell:AddDropdown("Dropdown_Shop_AutoSellASMRNames", {
  Title = "Select ASMR Names",
  Values = f7(v13.Products, "ASMRDisplayName"),
  Multi = true,
  Searchable = true,
  Default = {},
})

sell:AddToggle("Toggle_Shop_AutoSellASMRNames", {
  Title = "Auto Sell Selected ASMR Names",
  Default = false,
  Callback = function(value82)
    if value82 then
      v1.Options.Toggle_Shop_AutoSellInventory:SetValue(false)
      v1.Options.Toggle_Shop_AutoSellASMRRarities:SetValue(false)
      f79()
    end
  end,
})

sell:AddDivider()

sell:AddDropdown("Dropdown_Shop_AutoSellASMRRarities", {
  Title = "Select ASMR Rarities",
  Values = v13.Rarities,
  Multi = true,
  Searchable = true,
  Default = {},
})

sell:AddToggle("Toggle_Shop_AutoSellASMRRarities", {
  Title = "Auto Sell Selected ASMR Rarities",
  Default = false,
  Callback = function(value83)
    if value83 then
      v1.Options.Toggle_Shop_AutoSellInventory:SetValue(false)
      v1.Options.Toggle_Shop_AutoSellASMRNames:SetValue(false)
      f79()
    end
  end,
})

upgrade:AddSection("Auto Upgrade ASMR")

upgrade:AddSlider("Slider_Shop_MaxUpgradeLevel", {
  Title = "Max Upgrade Level",
  Default = 100,
  Min = 1,
  Max = 100,
  Rounding = 0,
})

upgrade:AddDivider()

upgrade:AddDropdown("Dropdown_Shop_UpgradeASMRNames", {
  Title = "Select ASMR",
  Values = f7(v13.Products, "ASMRDisplayName"),
  Multi = true,
  Searchable = true,
  Default = {},
})

upgrade:AddToggle("Toggle_Shop_AutoUpgradeASMRNames", {
  Title = "Auto Upgrade ASMR",
  Default = false,
  Callback = function(value84)
    if value84 then
      v1.Options.Toggle_Shop_AutoUpgradeASMRRarities:SetValue(false)
      f64()
    end
  end,
})

upgrade:AddDivider()

upgrade:AddDropdown("Dropdown_Shop_UpgradeASMRRarities", {
  Title = "Select ASMR Rarities",
  Values = v13.Rarities,
  Multi = true,
  Searchable = true,
  Default = {},
})

upgrade:AddToggle("Toggle_Shop_AutoUpgradeASMRRarities", {
  Title = "Auto Upgrade ASMR Rarities",
  Default = false,
  Callback = function(value85)
    if value85 then
      v1.Options.Toggle_Shop_AutoUpgradeASMRNames:SetValue(false)
      f64()
    end
  end,
})

upgrade:AddSection("Conveyor Luck Upgrade")

upgrade:AddToggle("Toggle_Shop_AutoUpgradeConveyor", {
  Title = "Auto Upgrade Conveyor (Luck)",
  Default = false,
  Callback = function(value86)
    if value86 then
      f74()
    end
  end,
})

upgrade:AddDivider()

upgrade:AddDropdown("Dropdown_Shop_SelectConveyorLevel", {
  Title = "Select Conveyor Level",
  Values = f7(v13.ConveyorLevels, "Name"),
  Multi = false,
})

upgrade:AddButton({
  Title = "Set Selected Conveyor Level",
  Callback = function()
    f19(v1.Options.Dropdown_Shop_SelectConveyorLevel
      and v1.Options.Dropdown_Shop_SelectConveyorLevel.Value)
  end,
})

rebirth:AddSection("Rebirth Info")

v12.RebirthInfo = rebirth:AddParagraph("Paragraph_Shop_RebirthInfo", {
  Title = "Rebirth Status",
  Content = "Loading...",
})

rebirth:AddToggle("Toggle_Shop_AutoRebirth", {
  Title = "Auto Rebirth",
  Default = false,
  Callback = function(value87)
    if value87 then
      f76()
    end
  end,
})

other:AddSection("Worker")

other:AddToggle("Toggle_Shop_AutoBuyWorker", {
  Title = "Auto Buy Worker",
  Default = false,
  Callback = function(value88)
    if value88 then
      f72()
    end
  end,
})

other:AddSection("Plot Expansion")

other:AddToggle("Toggle_Shop_AutoUnlockPlotExpansion", {
  Title = "Auto Unlock Plot Expansions",
  Default = false,
  Callback = function(value89)
    if value89 then
      f71()
    end
  end,
})

crate2:AddSection("Crate Placement & Unbox")

crate2:AddDropdown("Dropdown_Placement_PlaceCrateNames", {
  Title = "Select Crates",
  Values = f7(v13.Products, "DisplayName"),
  Multi = true,
  Searchable = true,
  Default = {},
})

crate2:AddToggle("Toggle_Placement_AutoPlaceCrateNames", {
  Title = "Auto Place Crates",
  Default = false,
  Callback = function(value90)
    if value90 then
      v1.Options.Toggle_Placement_AutoPlaceCrateRarities:SetValue(false)
      f66()
    end
  end,
})

crate2:AddDivider()

crate2:AddDropdown("Dropdown_Placement_PlaceCrateRarities", {
  Title = "Select Rarities",
  Values = v13.Rarities,
  Multi = true,
  Searchable = true,
  Default = {},
})

crate2:AddToggle("Toggle_Placement_AutoPlaceCrateRarities", {
  Title = "Auto Place Crate Rarities",
  Default = false,
  Callback = function(value91)
    if value91 then
      v1.Options.Toggle_Placement_AutoPlaceCrateNames:SetValue(false)
      f66()
    end
  end,
})

crate2:AddDivider()

crate2:AddToggle("Toggle_Placement_AutoUnboxCrate", {
  Title = "Auto Unbox Placed Crates",
  Default = false,
  Callback = function(value92)
    if value92 then
      f68()
    end
  end,
})

asmr3:AddSection("ASMR Placement & Pickup")

asmr3:AddDropdown("Dropdown_Placement_PlaceASMRNames", {
  Title = "Select ASMR",
  Values = f7(v13.Products, "ASMRDisplayName"),
  Multi = true,
  Searchable = true,
  Default = {},
})

asmr3:AddToggle("Toggle_Placement_AutoPlaceASMRNames", {
  Title = "Auto Place ASMR",
  Default = false,
  Callback = function(value93)
    if value93 then
      v1.Options.Toggle_Placement_AutoPlaceASMRRarities:SetValue(false)
      f69()
    end
  end,
})

asmr3:AddDivider()

asmr3:AddDropdown("Dropdown_Placement_PlaceASMRRarities", {
  Title = "Select ASMR Rarities",
  Values = v13.Rarities,
  Multi = true,
  Searchable = true,
  Default = {},
})

asmr3:AddToggle("Toggle_Placement_AutoPlaceASMRRarities", {
  Title = "Auto Place ASMR Rarities",
  Default = false,
  Callback = function(value94)
    if value94 then
      v1.Options.Toggle_Placement_AutoPlaceASMRNames:SetValue(false)
      f69()
    end
  end,
})

asmr3:AddDivider()

asmr3:AddButton({
  Title = "Pickup All ASMR",
  Description = "Collect all placed ASMR items on your plot back to inventory",
  Confirm = "Are you sure you want to pickup ALL ASMR items from your plot?",
  Callback = function()
    for index54, value95 in ipairs(f13()) do
      f27(value95)
      task.wait(0.1)
    end
  end,
})

v229.Reward:AddSection("Events")

v229.Reward:AddToggle("Toggle_Reward_AutoCollectFireIceEventCrates", {
  Title = "Auto Collect Fire & Ice Event Crates",
  Default = false,
  Callback = function(value96)
    if value96 then
      f84()
    end
  end,
})

v229.Reward:AddToggle("Toggle_Reward_AutoCollectGalaxyEventCrates", {
  Title = "Auto Collect Galaxy Event Crates",
  Default = false,
  Callback = function(value97)
    if value97 then
      f85()
    end
  end,
})

v229.Reward:AddSection("Rewards")

v229.Reward:AddToggle("Toggle_Reward_AutoClaimDailyReward", {
  Title = "Auto Claim Daily Reward",
  Description = "Auto claims 7-day daily streak reward",
  Default = false,
  Callback = function(value98)
    if value98 then
      f81()
    end
  end,
})

v229.Reward:AddToggle("Toggle_Reward_AutoClaimOfflineEarnings", {
  Title = "Auto Claim Offline Earnings",
  Description = "Auto claims offline earnings",
  Default = false,
  Callback = function(value99)
    if value99 then
      f82()
    end
  end,
})

v229.Reward:AddToggle("Toggle_Reward_AutoWheelSpin", {
  Title = "Auto Wheel Spin",
  Description = "Auto spins free and earned wheel spins",
  Default = false,
  Callback = function(value100)
    if value100 then
      f83()
    end
  end,
})

v229.Settings:AddSection("Movement")

v229.Settings:AddSlider("Slider_Settings_WalkSpeed", {
  Title = "WalkSpeed",
  Default = 20,
  Min = 20,
  Max = 150,
  Rounding = 0,
  Callback = function(value101)
    pcall(function()
      local character14 = localPlayer.Character
      local humanoid6 = character14 and character14:FindFirstChildWhichIsA("Humanoid")

      if humanoid6 then
        humanoid6.WalkSpeed = value101
      end
    end)
  end,
})

table.insert(v15, localPlayer.CharacterAdded:Connect(function(character15)
  local waitForChild = character15:WaitForChild("Humanoid", 5)

  if waitForChild then
    waitForChild.WalkSpeed = v1.Options.Slider_Settings_WalkSpeed
        and v1.Options.Slider_Settings_WalkSpeed.Value
      or 20
  end
end))

f75()
f45()
v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/UnboxASMR")
v4:SetFolder("Lamduck/UnboxASMR")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v229.Settings)
v3:BuildInterfaceSection(v229.Settings)
v2:BuildConfigSection(v229.Settings)

v1.OnUnload:Once(function()
  for index55, value102 in ipairs(v15) do
    if typeof(value102) == "RBXScriptConnection" and value102.Connected then
      value102:Disconnect()
    end
  end

  table.clear(v15)
end)

v2:LoadAutoloadConfig()
unboxASMRWindow:SelectTab(1)
