local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local collectionService = game:GetService("CollectionService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local starterGui = game:GetService("StarterGui")
local teleportService = game:GetService("TeleportService")
local userInputService = game:GetService("UserInputService")
local v5 = game:GetService("Workspace")
local localPlayer = players.LocalPlayer
local v6 = require(replicatedStorage.Modules.Huge)
local v7 = require(replicatedStorage.Modules.Tycoon.Tycoon)
local v8 = require(replicatedStorage.Modules.Tycoon.Component.TycoonRebirth)
local v9 = require(replicatedStorage.Modules.Tycoon.Component.TycoonEvolution)
local v10 = require(replicatedStorage.Modules.Tycoon.Component.TycoonBalances)
local v11 = require(replicatedStorage.Balance)
local v12 = require(replicatedStorage.Modules.Tycoon.Component.TycoonValues)
local v13 = require(replicatedStorage.Config.Orchard)
local v14 = require(replicatedStorage.Config)
local v15 = require(replicatedStorage.Modules.Tycoon.Orchard.Orchard)
local v16 = require(replicatedStorage.Modules.Tycoon.Orchard.OrchardFruit)
local v17 = require(replicatedStorage.Modules.Tycoon.Orchard.OrchardFruits)
local v18 = require(replicatedStorage.Modules.Tycoon.Orchard.Client.ClientOrchardFruitEffectApplier)
local v19 = require(replicatedStorage.Modules.Tycoon.Component.Client.ClientTycoonOfflineIncome)

local v20 = {
  {
    Label = "Tycoon Spawn",
    Path = "MyTycoon/Locations/Spawn",
    FallbackPath = "MyTycoon/Spawn",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Lemon Stand",
    Path = "MyTycoon/Locations/Lemon Stand",
    FallbackPath = "MyTycoon/Purchases/Lemon Stand",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Orchard",
    Path = "MyTycoon/Orchard/Teleport",
    FallbackPath = "MyTycoon/Locations/Orchard",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Minigame Race",
    Path = "MyTycoon/Locations/MinigameRace",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Void Evolution",
    Path = "Workspace/Map/Void/Functional/Altar/Part",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Space Rocket",
    Paths = {
      "MyTycoon/Locations/LemonX", "MyTycoon/Locations/Lemon X",
      "MyTycoon/Locations/Space Station", "MyTycoon/Locations/Space",
      "MyTycoon/Purchases/LemonX/Structure/XFloor", "MyTycoon/Purchases/LemonX/Structure/Floor",
      "MyTycoon/Purchases/LemonX/Structure", "MyTycoon/Purchases/LemonX",
      "MyTycoon/Purchases/LemonX Ground/Structure/X Launch Surface",
      "MyTycoon/Purchases/LemonX Ground/Structure", "MyTycoon/Purchases/LemonX Ground",
    },
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Sewer Entrance",
    Path = "Workspace/Map/Sewer/Build/Entrances/SewerEntrance",
    Offset = Vector3.new(0, -32, 0),
    FallbackPath = "Workspace/Locations/SewerExitLeft",
  },
  {
    Label = "Leaderboards",
    Path = "Workspace/Map/Sewer/Build/Leaderboard/Part",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Cash Vine",
    Path = "Workspace/Map/Sewer/CashVine/CashVine/CashVine",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Sewer Key",
    Path = "Workspace/Map/Sewer/CashVine/VineKey",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Ghost Hunter Bo",
    Path = "Workspace/Map/Sewer/Bo/Ghost Hunter Bo/HumanoidRootPart",
    FallbackPath = "Workspace/Map/Sewer/Bo/Prompt",
    Offset = Vector3.new(0, 3, 0),
  },
  {
    Label = "Stargate",
    Path = "MyTycoon/Locations/Stargate",
    FallbackPath = "MyTycoon/Purchases/Stargate/Interior/Stargate/Stargate Portal/Enter",
    Offset = Vector3.new(0, 3, 0),
  },
}

local v21 = {}
local v22 = {}
local v23 = {}
local v24 = {}
local v25 = {}

local function f1(p1)
  local v26 = v1.Options[p1]
  return v26 and v26.Value
end

local function f2(title, p2, p3)
  if not pcall(function()
    starterGui:SetCore("SendNotification", {
      Title = title,
      Text = p2,
      Icon = "rbxthumb://type=Asset&id=81215685023875&w=150&h=150",
      Duration = p3 or 4,
    })
  end) then
    task.defer(function()
      pcall(function() v1:Notify({ Title = title, Content = p2, Duration = p3 or 4 }) end)
    end)
  end
end

local function f3()
  local v27 = v7.getLocal()

  if not v27 then
    return nil
  end

  return {
    tycoon = v27,
    rebirth = v27:GetComponent(v8),
    evolution = v27:GetComponent(v9),
    balances = v27:GetComponent(v10),
  }
end

local function f4(p4)
  local values = p4 and p4:FindFirstChild("Values")
  local purchases = values and values:FindFirstChild("Purchases")

  if not purchases then
    return 0
  end

  local count = 0

  for key, value in pairs(purchases:GetAttributes()) do
    if value == true then
      count = count + 1
    end
  end

  return count
end

local function f5()
  if v23.PlayerTycoon and v23.PlayerTycoon.Parent then
    return v23.PlayerTycoon
  end

  for index, value2 in ipairs(v5:GetChildren()) do
    if string.find(value2.Name, "Tycoon") then
      local owner = value2:FindFirstChild("Owner")

      if owner then
        if owner:IsA("ObjectValue") and owner.Value == localPlayer then
          v23.PlayerTycoon = value2
          return value2
        elseif tostring(owner.Value) == localPlayer.Name
          or tostring(owner.Value) == localPlayer.DisplayName then
          v23.PlayerTycoon = value2
          return value2
        end
      end
    end
  end

  return nil
end

local function f6(p5)
  local category = p5:GetAttribute("Category")

  if typeof(category) == "string" and category ~= "" then
    if category == "???" then
      return "Special"
    end

    return category
  end

  local parent = p5.Parent

  while parent and parent.Name ~= "Buttons" and parent.Name ~= "Purchases" and parent ~= v5 do
    category = parent.Name
    parent = parent.Parent
  end

  if category == "???" then
    return "Special"
  end

  return category or "Other"
end

local function f7(p6, p7)
  if not p6 or not p7 then
    return false
  end

  if p6[p7] == true then
    return true
  end

  local lower = p7:gsub("%s+", ""):lower()

  for key2, value3 in pairs(p6) do
    local v28 = type(key2) == "string" and key2 or type(value3) == "string" and value3

    if v28 then
      if v28 == p7 or v28:gsub("%s+", ""):lower() == lower then
        if type(key2) == "number" or value3 == true then
          return true
        end
      end
    end
  end

  return false
end

local function f8(p8, p9)
  if not p9 or next(p9) == nil then
    return false
  end

  if p8 == nil or p8.IsBasic and p8:IsBasic() or next(p8:GetMutations() or {}) == nil then
    return f7(p9, "None")
  end

  for key3, value4 in pairs(p8:GetMutations() or {}) do
    local mutations = v21.Mutations and v21.Mutations[key3]

    if f7(p9, mutations and mutations.DisplayName or key3) then
      return true
    end
  end

  return false
end

local function f9(p10)
  if not p10 then
    return 1
  end

  local v29, v30 = pcall(function()
    local value5 = p10:GetMutationEffects("Value")
    return value5 and value5.Value or 1
  end)

  return v29 and typeof(v30) == "number" and v30 or 1
end

local function f10()
  local v31 = f5()

  if not v31 then
    return nil
  end

  for index2, value6 in ipairs(v31:GetChildren()) do
    if value6:HasTag("Tycoon.Orchard") or value6.Name == "Orchard" then
      return value6
    end
  end

  return nil
end

local function f11()
  local v32 = v7.getLocal()

  if v32 then
    local v33, v34 = pcall(function() return v32:GetComponent(v12) end)

    if v33 and v34 then
      local orchardUnlocked = v34:GetValue("OrchardUnlocked")

      if orchardUnlocked ~= nil then
        return orchardUnlocked == true
      end
    end
  end

  local v35 = f5()
  local values2 = v35 and v35:FindFirstChild("Values")

  if values2 then
    local orchardUnlocked2 = values2:GetAttribute("OrchardUnlocked")

    if orchardUnlocked2 ~= nil then
      return orchardUnlocked2 == true
    end

    local orchardUnlocked3 = values2:FindFirstChild("OrchardUnlocked")

    if orchardUnlocked3 and orchardUnlocked3:IsA("ValueBase") then
      return orchardUnlocked3.Value == true
    end
  end

  local v36 = f10()

  if v36 then
    local unlocked = v36:GetAttribute("Unlocked")

    if unlocked ~= nil then
      return unlocked == true
    end
  end

  return false
end

local function f12()
  local v37 = v7.getLocal()

  if not v37 then
    return 0
  end

  local v38, v39 = pcall(function() return v37:GetComponent(v12) end)

  if not v38 or not v39 then
    return 0
  end

  local totalRebirths = v39:GetValue("TotalRebirths")

  return typeof(totalRebirths) == "number" and totalRebirths
    or tonumber(tostring(totalRebirths)) or 0
end

local function f13()
  local v40 = v7.getLocal()

  if not v40 then
    return false
  end

  local v41, v42 = pcall(function() return v40:GetComponent(v12) end)

  if not v41 or not v42 then
    return false
  end

  return not not v42:GetValue("ExtraInvestorBoost")
end

local function f14()
  local v43, v44 = pcall(function()
    local v45 = require(replicatedStorage.Core.Player)
    local v46 = require(replicatedStorage.Modules.Player.TempItemInventory)
    local v47 = v45.getLocal()

    if not v47 then
      return false
    end

    local getComponent = v47:GetComponent(v46)
    return getComponent ~= nil and getComponent:Has("AlienUFOKey")
  end)

  return v43 and v44 or false
end

local function f15()
  local v48 = f3()

  if v48 and v48.balances then
    return v48.balances:GetCash()
  end

  return v6.zero
end

local function f16()
  local v49 = f3()

  if v49 and v49.balances then
    local v50, v51 = pcall(function() return v49.balances:GetTokens() end)

    if v50 and v51 then
      return v51
    end
  end

  local v52 = f5()
  local values3 = v52 and v52:FindFirstChild("Values")

  if values3 then
    local tokens = values3:GetAttribute("Tokens")

    if tokens then
      return tokens
    end

    local tokens2 = values3:FindFirstChild("Tokens")

    if tokens2 and tokens2:IsA("ValueBase") then
      return tokens2.Value
    end
  end

  return 0
end

local function f17(p11)
  local v53 = f5()
  local values4 = v53 and v53:FindFirstChild("Values")
  local orchardItems = values4 and values4:FindFirstChild("OrchardItems")

  if orchardItems then
    return orchardItems:GetAttribute(p11) or 0
  end

  return 0
end

local function f18()
  local v54 = v7.getLocal()

  if not v54 then
    return nil
  end

  local v55 = v15.getFromTycoon(v54)

  if not v55 then
    return nil
  end

  return v55:GetComponent(v17)
end

local function f19(p12)
  if not p12 then
    return
  end

  local character = localPlayer.Character
  local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart then
    humanoidRootPart.CFrame = p12 + Vector3.new(0, 3, 0)
  end
end

local function f20(p13)
  if not p13 then
    return nil
  end

  if p13:IsA("BasePart") then
    return p13.CFrame
  elseif p13:IsA("Model") then
    if p13:FindFirstChildWhichIsA("BasePart", true) then
      return p13:GetPivot()
    end

    return nil
  elseif p13:IsA("Folder") or p13:IsA("Configuration") then
    local findFirstChildWhichIsA = p13:FindFirstChildWhichIsA("BasePart", true)

    if findFirstChildWhichIsA then
      return findFirstChildWhichIsA.CFrame
    end

    local findFirstChildWhichIsA2 = p13:FindFirstChildWhichIsA("Model", true)

    if findFirstChildWhichIsA2
      and findFirstChildWhichIsA2:FindFirstChildWhichIsA("BasePart", true) then
      return findFirstChildWhichIsA2:GetPivot()
    end
  end

  return nil
end

local function f21(p14)
  if not p14 then
    return nil
  end

  if typeof(p14) == "string" then
    p14 = { Path = p14 }
  end

  if typeof(p14) == "CFrame" then
    return p14
  end

  if typeof(p14) == "Vector3" then
    return CFrame.new(p14)
  end

  for index3, value7 in ipairs(p14.Paths or { p14.Path, p14.FallbackPath }) do
    if value7 then
      local v56 = string.split(value7, "/")
      local findFirstChild = v56[1] == "MyTycoon" and f5() or v5

      if v56[1] == "MyTycoon" or v56[1] == "Workspace" then
        table.remove(v56, 1)
      end

      for index4, value8 in ipairs(v56) do
        findFirstChild = findFirstChild and findFirstChild:FindFirstChild(value8)
      end

      local v57 = f20(findFirstChild)

      if v57 then
        return v57 + (p14.Offset or Vector3.new(0, 3, 0))
      end
    end
  end

  if p14.Position then
    return CFrame.new(p14.Position) + (p14.Offset or Vector3.new(0, 3, 0))
  end

  return nil
end

local function f22()
  local v58, v59 = pcall(function()
    local v60 = require(replicatedStorage.Core.Player)
    local v61 = require(replicatedStorage.Core.PlayerValues)
    local v62 = v60.getLocal()

    if v62 then
      local getComponent2 = v62:GetComponent(v61)

      if getComponent2 then
        local cashVineAvailable = getComponent2:Get("CashVineAvailable")

        if typeof(cashVineAvailable) == "number" then
          return cashVineAvailable
        end
      end
    end

    return require(replicatedStorage.Modules.Entity.CashVine).GetAvailableTime()
  end)

  if v58 and typeof(v59) == "number" then
    return v59
  end

  return 0
end

local function f23()
  local v63 = {}
  local v64 = {}

  pcall(function()
    local v65 = f5()
    local purchases2 = v65 and v65:FindFirstChild("Purchases")

    if purchases2 then
      for index5, value9 in ipairs(purchases2:GetDescendants()) do
        if value9:IsA("RemoteFunction") and value9.Name == "Purchase" then
          local parent2 = value9.Parent

          if parent2 and parent2:IsA("Model") then
            local v66 = f6(parent2)

            if not v64[v66] then
              v64[v66] = true
              table.insert(v63, v66)
            end
          end
        end
      end
    end
  end)

  if #v63 == 0 then
    v63 = {
      "Decor", "Expansion", "Infrastructure", "Minigame", "Multiplier", "Other", "Special",
      "Structure",
    }
  else
    table.sort(v63)
  end

  v21.PurchaseCategories = v63
end

local function f24()
  local v67 = {}
  local v68 = {}

  pcall(function()
    if v11 and v11.EarnerIncomes then
      for key4, value10 in pairs(v11.EarnerIncomes) do
        if not v68[key4] then
          v68[key4] = true
          table.insert(v67, key4)
        end
      end
    end
  end)

  if #v67 == 0 then
    v67 = {
      "LemonDash", "LemonDepot", "LemonLabs", "LemonRepublic", "LemonRobotics", "LemonStand",
      "LemonTrading", "LemonX",
    }
  else
    table.sort(v67)
  end

  v21.StandNames = v67
end

local function f25()
  local v69 = {}
  local v70 = {}

  pcall(function()
    local v71 = v14

    if not v71 then
      local v72, v73 = pcall(function() return require(replicatedStorage.Config) end)

      if v72 then
        v71 = v73
      end
    end

    if v71 and v71.Powers then
      for key5, value11 in pairs(v71.Powers) do
        table.insert(v69, key5)
        v70[key5] = value11.Prices and #value11.Prices or 1
      end
    end
  end)

  if #v69 == 0 then
    v69 = {
      "AutoFruit", "BuyNext", "ClickFruitValue", "Jetpack", "Manage", "UpgradeStack",
      "WalkSpeed",
    }

    v70 = {}
  else
    table.sort(v69)
  end

  v21.PowerNames = v69
  v21.PowerMaxLevels = v70
end

local function f26()
  local v74 = {}
  local v75 = {}

  pcall(function()
    local v76 = v13

    if not v76 then
      local v77, v78 = pcall(function() return require(replicatedStorage.Config.Orchard) end)

      if v77 then
        v76 = v78
      end
    end

    if v76 and v76.PlotUpgrades and v76.Items then
      for key6, value12 in pairs(v76.PlotUpgrades) do
        local v79 = v76.Items[key6]
        table.insert(v74, { Name = key6, Cost = v79 and v79.Price or 0 })
      end

      table.sort(v74, function(p15, p16) return p15.Cost < p16.Cost end)

      for index6, value13 in ipairs(v74) do
        table.insert(v75, value13.Name)
      end
    end
  end)

  if #v74 == 0 then
    v74 = {
      { Name = "Irrigation", Cost = 500 }, { Name = "Enricher", Cost = 5000 },
      { Name = "Radioactive", Cost = 10000 }, { Name = "Clover", Cost = 20000 },
    }

    v75 = { "Irrigation", "Enricher", "Radioactive", "Clover" }
  end

  v21.PlotUpgrades = v74
  v21.PlotUpgradeNames = v75
end

local function f27()
  local v80 = {}
  local v81 = {}

  pcall(function()
    local v82 = v13

    if not v82 then
      local v83, v84 = pcall(function() return require(replicatedStorage.Config.Orchard) end)

      if v83 then
        v82 = v84
      end
    end

    if v82 and v82.Items then
      for key7, value14 in pairs(v82.Items) do
        if key7:find("Fertilizer") or value14.MutationConfig ~= nil then
          table.insert(v80, {
            Name = key7,
            Cost = value14.Price or 0,
            HasMutation = value14.MutationConfig ~= nil,
            Order = value14.Order or 0,
          })
        end
      end

      table.sort(v80, function(p17, p18) return p17.Cost < p18.Cost end)

      for index7, value15 in ipairs(v80) do
        table.insert(v81, value15.Name)
      end
    end
  end)

  if #v80 == 0 then
    v80 = {
      { Name = "FertilizerMutate", Cost = 20, HasMutation = true },
      { Name = "FertilizerQuickGrow", Cost = 100, HasMutation = false },
      { Name = "FertilizerCleanse", Cost = 500, HasMutation = true },
      { Name = "FertilizerAscend", Cost = 77777, HasMutation = true },
    }

    v81 = { "FertilizerMutate", "FertilizerQuickGrow", "FertilizerCleanse", "FertilizerAscend" }
  end

  v21.Fertilizers = v80
  v21.FertilizerNames = v81
end

local function f28()
  local v85 = {}

  pcall(function()
    for index8, value16 in ipairs(v21.PlotUpgrades or {}) do
      table.insert(v85, value16.Name)
    end

    for index9, value17 in ipairs(v21.Fertilizers or {}) do
      table.insert(v85, value17.Name)
    end
  end)

  v21.OrchardItemNames = v85
end

local function f29()
  local v86 = {}
  local v87 = {}

  pcall(function()
    local v88 = v13

    if not v88 then
      local v89, v90 = pcall(function() return require(replicatedStorage.Config.Orchard) end)

      if v89 then
        v88 = v90
      end
    end

    if v88 and v88.Decorations then
      for key8, value18 in pairs(v88.Decorations) do
        table.insert(v86, key8)
        v87[key8] = value18.Price or 0
      end

      table.sort(v86, function(p19, p20) return (v87[p19] or 0) < (v87[p20] or 0) end)
    end
  end)

  if #v86 == 0 then
    v86 = { "Archway", "OldTrees", "WorkBenches", "Tractor" }

    v87 = {
      Archway = 0,
      OldTrees = 25,
      WorkBenches = 75,
      Tractor = 200,
    }
  end

  v21.DecorationNames = v86
  v21.DecorationPrices = v87
end

local function f30()
  local v91 = {}

  pcall(function()
    local v92 = v14

    if not v92 then
      local v93, v94 = pcall(function() return require(replicatedStorage.Config) end)

      if v93 then
        v92 = v94
      end
    end

    if v92 and v92.Evolutions then
      for index10, value19 in ipairs(v92.Evolutions) do
        if value19.Name then
          table.insert(v91, value19.Name)
        end
      end
    end
  end)

  if #v91 == 0 then
    v91 = {
      "Lemon", "Orange", "Lime", "Grapefruit", "Tangerine", "Pomelo", "Abyssalime", "Nullfruit",
      "Voidlemon", "Purity",
    }
  end

  v21.TreeNames = v91
end

local function f31()
  local v95 = {}
  local v96 = {}
  local v97 = {}

  pcall(function()
    local v98 = v13

    if not v98 then
      local v99, v100 = pcall(function() return require(replicatedStorage.Config.Orchard) end)

      if v99 then
        v98 = v100
      end
    end

    if v98 and v98.Mutations then
      for key9, value20 in pairs(v98.Mutations) do
        local v101 = {
          Key = key9,
          DisplayName = value20.DisplayName or key9,
          Good = value20.Good ~= false,
          Effect = value20.Effect,
          EffectValue = value20.EffectValue or 1,
          SoftMax = value20.SoftMax or 1,
          TokenValue = value20.TokenValue or 1,
          Weight = value20.Weight or 1,
          Order = value20.Order or 999,
        }

        v95[key9] = v101
        v97[v101.DisplayName] = v101
        table.insert(v96, v101.DisplayName)
      end
    end
  end)

  table.sort(v96, function(p21, p22)
    local order = v97[p21] and v97[p21].Order or 999
    local order2 = v97[p22] and v97[p22].Order or 999

    if order ~= order2 then
      return order < order2
    end

    return p21 < p22
  end)

  table.insert(v96, 1, "None")

  v97.None = {
    Key = "None",
    DisplayName = "None",
    Good = true,
    Effect = "None",
    EffectValue = 0,
    SoftMax = 0,
    TokenValue = 1,
    Weight = 0,
    Order = 0,
  }

  v21.Mutations = v95
  v21.MutationNames = v96
  v21.MutationsByName = v97
end

local function f32()
  local v102 = {}
  local v103 = {}
  local v104 = {}
  local v105 = {}

  for index11, value21 in ipairs(v21.MutationNames or {}) do
    if value21 ~= "None" then
      local mutationsByName = v21.MutationsByName and v21.MutationsByName[value21]

      if mutationsByName then
        if not mutationsByName.Good then
          local v106 = mutationsByName.EffectValue < 1
              and string.format("%sx", mutationsByName.EffectValue)
            or string.format("-%sx", mutationsByName.EffectValue)

          table.insert(v105, string.format("%s (%s)", value21, v106))
        elseif mutationsByName.Effect == "Value" then
          table.insert(
            v102, string.format("<b>%s</b> (+%sx)", value21, mutationsByName.EffectValue)
          )
        elseif mutationsByName.Effect == "Rate" then
          table.insert(
            v103, string.format("<b>%s</b> (+%sx)", value21, mutationsByName.EffectValue)
          )
        else
          table.insert(
            v104, string.format("<b>%s</b> (+%sx)", value21, mutationsByName.EffectValue)
          )
        end
      end
    end
  end

  local v107 = {
    string.format(
      "• <b>Cash Boost:</b> <font color=\"#00FF88\">%s</font>", table.concat(v102, ", ")
    ),
    string.format(
      "• <b>Speed Boost:</b> <font color=\"#00E5FF\">%s</font>", table.concat(v103, ", ")
    ),
    string.format(
      "• <b>Perks:</b> <font color=\"#FFAA00\">%s</font>", table.concat(v104, ", ")
    ),
    string.format(
      "• <b>Bad (Penalties):</b> <font color=\"#FF5555\">%s</font>", table.concat(v105, ", ")
    ),
    "• <b>Basic:</b> <font color=\"#AAAAAA\">None (No Mutation)</font>",
  }

  return table.concat(v107, "\n")
end

local function f33()
  for index12, value22 in ipairs({ "LamduckFloatingTP", "LamduckTeleportGui" }) do
    local findFirstChild2 = coreGui:FindFirstChild(value22)

    if findFirstChild2 then
      findFirstChild2:Destroy()
    end

    local findFirstChild3 = localPlayer:FindFirstChild("PlayerGui")
      and localPlayer.PlayerGui:FindFirstChild(value22)

    if findFirstChild3 then
      findFirstChild3:Destroy()
    end
  end

  local lamduckFloatingTP = Instance.new("ScreenGui")
  lamduckFloatingTP.Name = "LamduckFloatingTP"
  lamduckFloatingTP.ResetOnSpawn = false
  lamduckFloatingTP.Enabled = false

  pcall(function() lamduckFloatingTP.Parent = gethui and gethui() or coreGui end)

  if not lamduckFloatingTP.Parent then
    lamduckFloatingTP.Parent = localPlayer:WaitForChild("PlayerGui")
  end

  local udim = UDim2.new(0.85, 0, 0.2, 0)

  local textButton = Instance.new("TextButton")
  textButton.Size = UDim2.new(0, 48, 0, 32)
  textButton.Position = udim
  textButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
  textButton.Text = "TP"
  textButton.Font = Enum.Font.GothamBold
  textButton.TextSize = 14
  textButton.Parent = lamduckFloatingTP

  Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)

  local scrollingFrame = Instance.new("ScrollingFrame")
  scrollingFrame.Position = UDim2.new(0, 54, 0, 0)
  scrollingFrame.Size = UDim2.new(0, 160, 0, 360)
  scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
  scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
  scrollingFrame.ScrollBarThickness = 2
  scrollingFrame.BorderSizePixel = 0
  scrollingFrame.BackgroundTransparency = 1
  scrollingFrame.Visible = false
  scrollingFrame.Parent = textButton

  local instance = Instance.new("UIListLayout", scrollingFrame)
  instance.Padding = UDim.new(0, 4)
  instance.SortOrder = Enum.SortOrder.LayoutOrder

  for index13, value23 in ipairs(v20) do
    local textButton2 = Instance.new("TextButton")
    textButton2.Size = UDim2.new(1, 0, 0, 32)
    textButton2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    textButton2.TextColor3 = Color3.fromRGB(200, 200, 200)
    textButton2.Text = value23.Label
    textButton2.Font = Enum.Font.GothamSemibold
    textButton2.TextSize = 13
    textButton2.LayoutOrder = index13
    textButton2.Parent = scrollingFrame

    Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 6)

    textButton2.MouseButton1Click:Connect(function()
      scrollingFrame.Visible = false

      pcall(function()
        local v108 = f21(value23)

        if v108 then
          f19(v108)
        else
          v1:Notify({
            Title = "Teleport",
            Content = value23.Label .. " is not unlocked yet",
            Duration = 3,
          })
        end
      end)
    end)
  end

  local v109, position, position2 = false, nil, nil

  textButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
      or input.UserInputType == Enum.UserInputType.Touch then
      v109 = true
      position = input.Position
      position2 = textButton.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
          v109 = false
        end
      end)
    end
  end)

  local v110 = nil

  textButton.InputChanged:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseMovement
      or input2.UserInputType == Enum.UserInputType.Touch then
      v110 = input2
    end
  end)

  if v24.FloatingTPUISConn then
    v24.FloatingTPUISConn:Disconnect()
    v24.FloatingTPUISConn = nil
  end

  v24.FloatingTPUISConn = userInputService.InputChanged:Connect(function(input3)
    if input3 == v110 and v109 and position then
      local v111 = input3.Position - position

      textButton.Position = UDim2.new(
        position2.X.Scale, position2.X.Offset + v111.X, position2.Y.Scale,
        position2.Y.Offset + v111.Y
      )
    end
  end)

  local v112 = nil

  textButton.InputBegan:Connect(function(input4)
    if input4.UserInputType == Enum.UserInputType.MouseButton1
      or input4.UserInputType == Enum.UserInputType.Touch then
      v112 = tick()
    end
  end)

  textButton.InputEnded:Connect(function(input5)
    if (input5.UserInputType == Enum.UserInputType.MouseButton1
        or input5.UserInputType == Enum.UserInputType.Touch)
      and v112
      and tick() - v112 < 0.2 then
      scrollingFrame.Visible = not scrollingFrame.Visible
    end
  end)

  v23.FloatingTPGui = lamduckFloatingTP
  return lamduckFloatingTP
end

local function f34()
  local v113 = f5()

  if not v113 then
    return
  end

  local remotes = v113:FindFirstChild("Remotes")
  local phoneOffer = remotes and remotes:FindFirstChild("PhoneOffer")

  if phoneOffer and phoneOffer:IsA("RemoteEvent") then
    pcall(function() phoneOffer:FireServer("Accept") end)
  end
end

local function f35()
  pcall(function()
    local offlineCash = localPlayer:FindFirstChild("PlayerGui")
      and localPlayer.PlayerGui:FindFirstChild("Prompt")
      and localPlayer.PlayerGui.Prompt:FindFirstChild("OfflineCash")

    if offlineCash and offlineCash.Visible then
      local confirm = offlineCash:FindFirstChild("Body")
        and offlineCash.Body:FindFirstChild("Buttons")
        and offlineCash.Body.Buttons:FindFirstChild("Confirm")

      if confirm then
        local v114, v115 = pcall(function() return require(replicatedStorage.Core.UIButton) end)

        if v114 and v115 and v115.get then
          local get = v115:get(confirm)

          if get and get.Clicked then
            get.Clicked:Fire(true)
            return
          end
        end
      end

      offlineCash.Visible = false
    end

    local v116 = v7.getLocal()

    if v116 then
      local getComponent3 = v116:GetComponent(v19)

      if getComponent3 and getComponent3.FlagOfflineAsClaimedAsync then
        getComponent3:FlagOfflineAsClaimedAsync()
        return
      end
    end

    local v117 = f5()
    local remotes2 = v117 and v117:FindFirstChild("Remotes")
    local playerClaimed = remotes2 and remotes2:FindFirstChild("PlayerClaimed")

    if playerClaimed and playerClaimed:IsA("RemoteFunction") then
      playerClaimed:InvokeServer()
    end
  end)
end

local function f36(p23, p24)
  if not p23 or not p23.Parent then
    return
  end

  if not p24 and getconnections then
    local v118 = getconnections(p23.Touched)
    local v119 = v118 and v118[1] and v118[1].Function
    local v120 = v119 and debug.getupvalues(v119)
    p24 = v120 and v120[3]
  end

  if p24 and p24.Pop then
    pcall(function() p24:Pop() end)
  else
    pcall(function() p23:Destroy() end)
  end
end

local function f37(p25)
  if not p25 or not getconnections then
    return nil
  end

  local v121 = getconnections(p25.Touched)

  if not v121 or #v121 == 0 then
    return nil
  end

  local v122 = v121[1].Function
  local v123 = v122 and debug.getupvalues(v122)
  local v124 = v123 and v123[3]
  local pickedUp = v124 and v124.PickedUp
  local connListHead = pickedUp and pickedUp.ConnListHead
  local callback = connListHead and connListHead._Callback
  local v125 = callback and debug.getupvalues(callback)
  local v126 = v125 and v125[2]
  local v127 = v126 and debug.getupvalues(v126)
  return v127 and v127[3], v127 and v127[5], v124
end

local function f38(p26, p27)
  local core = replicatedStorage:FindFirstChild("Core")
  local remoteRequest = core and core:FindFirstChild("RemoteRequest")
  local dropServiceRedeem = remoteRequest and remoteRequest:FindFirstChild("DropService.Redeem")

  if not dropServiceRedeem or not dropServiceRedeem:IsA("RemoteFunction") then
    return
  end

  pcall(function() dropServiceRedeem:InvokeServer(p26) end)
end

local function f39()
  local drops = v5:FindFirstChild("Drops")

  if not drops then
    return
  end

  for index14, value24 in ipairs(drops:GetChildren()) do
    local v128, v129, v130 = f37(value24)

    if v128 then
      f38(v128, v129)
    end

    f36(value24, v130)
  end
end

local function f40()
  local v131 = f10()

  if v131 then
    local orchardUnlockPrice = v131:GetAttribute("OrchardUnlockPrice")

    if orchardUnlockPrice then
      return v6.toHuge(orchardUnlockPrice)
    end
  end

  if v13 and v13.UnlockCashPrice then
    return v6.toHuge(v13.UnlockCashPrice)
  end

  return v6.toHuge(1e+25)
end

local function f41()
  local v132 = f10()
  local plotsUnlocked = v132 and v132:GetAttribute("PlotsUnlocked") or 0

  if v13 and v13.PlotPriceFunction then
    return v13.PlotPriceFunction(plotsUnlocked)
  end

  if plotsUnlocked <= 5 then
    return plotsUnlocked * 5
  end

  return (plotsUnlocked - 5) * 50 + 25
end

local function f42()
  local v133 = f5()

  if not v133 then
    return {}
  end

  local v134 = {}

  for index15, value25 in ipairs(collectionService:GetTagged("Tycoon.OrchardPlot")) do
    if value25:IsDescendantOf(v133) then
      local v135 = value25:GetAttribute("Enabled") == true
      local v136 = value25:GetAttribute("Available") == true
      local id = value25:GetAttribute("ID")

      if not v135 and v136 and id then
        table.insert(v134, { Instance = value25, ID = id })
      end
    end
  end

  table.sort(v134, function(p28, p29) return p28.ID < p29.ID end)
  return v134
end

local function f43()
  local v137 = f5()

  if not v137 then
    return {}
  end

  local v138 = {}

  for index16, value26 in ipairs(collectionService:GetTagged("Tycoon.OrchardPlot")) do
    if value26:IsDescendantOf(v137) then
      if value26:GetAttribute("Enabled") == true and value26:GetAttribute("State") == 3 then
        table.insert(v138, value26)
      end
    end
  end

  return v138
end

local function f44()
  local v139 = f5()

  if not v139 then
    return {}
  end

  local v140 = {}

  for index17, value27 in ipairs(collectionService:GetTagged("Tycoon.OrchardPlot")) do
    if value27:IsDescendantOf(v139) and value27:GetAttribute("Enabled") == true then
      table.insert(v140, value27)
    end
  end

  table.sort(v140, function(p30, p31)
    return (p30:GetAttribute("ID") or 0) < (p31:GetAttribute("ID") or 0)
  end)

  return v140
end

local function f45()
  local v141 = f5()

  if not v141 then
    return {}
  end

  local v142 = {}

  for index18, value28 in ipairs(collectionService:GetTagged("Tycoon.OrchardPlot")) do
    if value28:IsDescendantOf(v141) and value28:GetAttribute("Enabled") == true then
      local state = value28:GetAttribute("State")

      if state == 0 or state == nil then
        table.insert(v142, value28)
      end
    end
  end

  table.sort(v142, function(p32, p33)
    return (p32:GetAttribute("ID") or 0) < (p33:GetAttribute("ID") or 0)
  end)

  return v142
end

local function f46()
  local v143 = f5()

  if not v143 then
    return {}
  end

  local v144 = {}

  for index19, value29 in ipairs(collectionService:GetTagged("Tycoon.OrchardPlot")) do
    if value29:IsDescendantOf(v143) and value29:GetAttribute("Enabled") == true then
      local state2 = value29:GetAttribute("State")

      if state2 and state2 ~= 0 then
        table.insert(v144, value29)
      end
    end
  end

  table.sort(v144, function(p34, p35)
    return (p34:GetAttribute("ID") or 0) < (p35:GetAttribute("ID") or 0)
  end)

  return v144
end

local function f47(p36, p37)
  if not p36 or next(p36) == nil then
    return nil
  end

  if not p37 or next(p37) == nil then
    return nil
  end

  local v145 = f18()

  if not v145 then
    return nil
  end

  local v146 = nil
  local v147 = -1

  for index20, value30 in ipairs(v145:GetAll()) do
    if value30.Count and value30.Count > 0 then
      local fruit = value30.Fruit
      local getFruitName = fruit and fruit:GetFruitName()

      if getFruitName and f7(p36, getFruitName) and f8(fruit, p37) then
        local v148 = f9(fruit)

        if v148 > v147 then
          v147 = v148
          v146 = fruit
        end
      end
    end
  end

  if v146 then
    return v146
  end

  if f7(p37, "None") then
    local v149 = f3()
    local evolution = v149 and v149.evolution
    local getEvolution = evolution and evolution:GetEvolution() or 0

    for index21, value31 in ipairs((v16.getBasicFruits(getEvolution))) do
      local getFruitName2 = value31:GetFruitName()

      if getFruitName2 and f7(p36, getFruitName2) then
        return value31
      end
    end
  end

  return nil
end

local function f48()
  local v150 = v7.getLocal()
  local getComponent4 = v150 and v150:GetComponent(v15)
  return getComponent4 and getComponent4:GetComponent(v18)
end

local function f49()
  local v151 = f48()

  if v151 then
    if v151:GetCurrentFruit() ~= nil then
      return true
    end

    local getTimeLeft = v151:GetTimeLeft()

    if getTimeLeft and getTimeLeft > 0 then
      return true
    end
  end

  return false
end

local function f50(p38, p39)
  if not p38 or next(p38) == nil then
    return nil
  end

  if not p39 or next(p39) == nil then
    return nil
  end

  local v152 = f18()

  if not v152 then
    return nil
  end

  local v153 = nil
  local v154 = -1

  for index22, value32 in ipairs(v152:GetAll()) do
    if value32.Count and value32.Count > 0 then
      local fruit2 = value32.Fruit
      local getFruitName3 = fruit2 and fruit2:GetFruitName()

      if getFruitName3 and f7(p38, getFruitName3) and f8(fruit2, p39) then
        local v155 = f9(fruit2)

        if v155 > v154 then
          v154 = v155
          v153 = fruit2
        end
      end
    end
  end

  return v153
end

local function f51()
  print("[Sewer Secret] Starting ClaimSewerAlienBoost...")
  local v156 = f13()
  print("[Sewer Secret] Check ExtraInvestorBoost:", v156)

  if v156 then
    warn("[Sewer Secret] Already have x2 Investor Bonus!")
    f2("Sewer Secret", "Already have x2 Investor Bonus!", 4)
    return
  end

  local v157 = f12()
  print("[Sewer Secret] Check TotalRebirths:", v157)

  if v157 < 1 then
    warn("[Sewer Secret] Need at least 1 Rebirth, currently:", v157)
    f2("Sewer Secret", "Need at least 1 Rebirth to unlock this bonus.", 4)
    return
  end

  local character2 = localPlayer.Character
  print("[Sewer Secret] Character:", character2 and character2.Name or "nil")

  if not character2 then
    warn("[Sewer Secret] Character not ready.")
    f2("Sewer Secret", "Character not ready.", 3)
    return
  end

  local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")
    or character2:WaitForChild("HumanoidRootPart", 3)

  if not humanoidRootPart2 then
    warn("[Sewer Secret] HumanoidRootPart not found.")
    f2("Sewer Secret", "HumanoidRootPart not found.", 3)
    return
  end

  local cframe = humanoidRootPart2.CFrame
  local v158 = f14()
  print("[Sewer Secret] Has UFOKey:", v158)

  if not v158 then
    print("[Sewer Secret] Searching for all UFOKey candidates in Workspace...")
    local v159 = {}

    for index23, value33 in ipairs(v5:GetDescendants()) do
      if value33:GetAttribute("Item") == "AlienUFOKey" then
        local basePart = value33:IsA("BasePart") and value33
          or value33:FindFirstChildWhichIsA("BasePart")

        if basePart then
          table.insert(v159, basePart)
        end
      elseif value33:IsA("BasePart") and value33.Name == "UFOKey" then
        table.insert(v159, value33)
      end
    end

    print(string.format("[Sewer Secret] Found %d candidate key part(s)", #v159))

    for index24, value34 in ipairs(v159) do
      print(string.format(
        "[Sewer Secret] Candidate #%d: %s at Pos: %s", index24, value34:GetFullName(),
        tostring(value34.Position)
      ))

      for key10, value35 in pairs(value34:GetAttributes()) do
        print("   [Attribute]", key10, "=", tostring(value35))
      end

      print("[Sewer Secret] Teleporting directly to candidate for physical touch...")
      humanoidRootPart2.CFrame = value34.CFrame + Vector3.new(0, 1, 0)
      task.wait(0.3)

      pcall(function()
        firetouchinterest(value34, humanoidRootPart2, 0)
        firetouchinterest(humanoidRootPart2, value34, 0)

        task.wait(0.1)

        firetouchinterest(value34, humanoidRootPart2, 1)
        firetouchinterest(humanoidRootPart2, value34, 1)
      end)

      for i = 1, 5 do
        task.wait(0.2)

        if f14() then
          v158 = true
          break
        end
      end

      if v158 then
        print("[Sewer Secret] Successfully acquired UFOKey from candidate #" .. index24)
        break
      end
    end

    if not v158 then
      print("[Sewer Secret] Fallback: Teleporting to maze key coordinate Vector3(204, -42, 285)...")
      local vector = Vector3.new(204, -42, 285)
      humanoidRootPart2.CFrame = CFrame.new(vector + Vector3.new(0, 3, 0))
      task.wait(0.5)

      for index25, value36 in ipairs(v5:GetDescendants()) do
        if value36:IsA("BasePart") and (value36.Position - vector).Magnitude < 25 then
          pcall(function()
            firetouchinterest(value36, humanoidRootPart2, 0)
            firetouchinterest(humanoidRootPart2, value36, 0)

            task.wait(0.05)

            firetouchinterest(value36, humanoidRootPart2, 1)
            firetouchinterest(humanoidRootPart2, value36, 1)
          end)
        end
      end

      for j = 1, 5 do
        task.wait(0.2)

        if f14() then
          v158 = true
          break
        end
      end
    end

    print("[Sewer Secret] Final Key check:", v158)
  end

  print("[Sewer Secret] Searching for SewerAlien...")
  local sewerAlien = nil
  local map = v5:FindFirstChild("Map")
  local sewer = map and map:FindFirstChild("Sewer")

  if sewer then
    sewerAlien = sewer:FindFirstChild("SewerAlien")
  end

  if not sewerAlien then
    for index26, value37 in ipairs(v5:GetDescendants()) do
      if value37.Name == "SewerAlien" then
        sewerAlien = value37
        break
      end
    end
  end

  local primaryPart = nil

  if sewerAlien then
    print(
      "[Sewer Secret] Found SewerAlien:", sewerAlien:GetFullName(), "Class:",
      sewerAlien.ClassName
    )

    for index27, value38 in ipairs(sewerAlien:GetChildren()) do
      print("   Child:", value38.Name, "Class:", value38.ClassName)
    end

    if sewerAlien:IsA("Model") and sewerAlien.PrimaryPart then
      primaryPart = sewerAlien.PrimaryPart
    else
      for index28, value39 in ipairs(sewerAlien:GetDescendants()) do
        if value39:IsA("BasePart") and value39.Name ~= "UFOKey" then
          primaryPart = value39
          break
        end
      end

      if not primaryPart then
        primaryPart = sewerAlien:FindFirstChildWhichIsA("BasePart", true)
      end
    end
  end

  local vector2 = Vector3.new(-39.5, -42.2, 176.9)

  local cframe2 = primaryPart and primaryPart.CFrame + Vector3.new(0, 2, 3)
    or CFrame.new(vector2 + Vector3.new(0, 3, 0))

  print(
    "[Sewer Secret] Moving directly in front of Sewer Alien at:", tostring(cframe2.Position)
  )

  humanoidRootPart2.CFrame = cframe2
  task.wait(0.5)
  local getDescendants = sewerAlien and sewerAlien:GetDescendants() or {}

  for index29, value40 in ipairs(getDescendants) do
    if value40:IsA("ProximityPrompt") then
      print("[Sewer Secret] Firing ProximityPrompt:", value40:GetFullName())

      if typeof(fireproximityprompt) == "function" then
        pcall(fireproximityprompt, value40)
      end
    end
  end

  local findFirstChild4 = sewerAlien and sewerAlien:FindFirstChild("Trigger", true)

  if not findFirstChild4 then
    for index30, value41 in ipairs(getDescendants) do
      if value41:IsA("RemoteFunction") or value41:IsA("RemoteEvent") then
        findFirstChild4 = value41
        break
      end
    end
  end

  local v160 = nil

  if findFirstChild4 then
    print(
      "[Sewer Secret] Found remote:", findFirstChild4:GetFullName(), "Class:",
      findFirstChild4.ClassName
    )

    if findFirstChild4:IsA("RemoteFunction") then
      local v161, v162 = pcall(function() return findFirstChild4:InvokeServer() end)
      v160 = v161 and v162
      print("[Sewer Secret] RemoteFunction result:", v161, tostring(v160))
    elseif findFirstChild4:IsA("RemoteEvent") then
      pcall(function() findFirstChild4:FireServer() end)
      print("[Sewer Secret] RemoteEvent fired")
    end
  end

  for index31, value42 in ipairs(getDescendants) do
    if value42:IsA("BasePart") and value42.Name ~= "UFOKey" then
      pcall(function()
        firetouchinterest(value42, humanoidRootPart2, 0)
        firetouchinterest(humanoidRootPart2, value42, 0)

        task.wait(0.05)

        firetouchinterest(value42, humanoidRootPart2, 1)
        firetouchinterest(humanoidRootPart2, value42, 1)
      end)
    end
  end

  local v163 = false

  for k = 1, 6 do
    task.wait(0.5)

    if f13() then
      v163 = true
      break
    end
  end

  humanoidRootPart2.CFrame = cframe
  print("[Sewer Secret] ExtraInvestorBoost check:", v163)

  if v163 or v160 then
    print("[Sewer Secret] Successfully claimed x2 Investor Bonus!")
    f2("Sewer Secret", "x2 Investor Bonus activated! (ExtraInvestorBoost unlocked)", 6)
  else
    warn("[Sewer Secret] Could not activate bonus yet. Recheck maze / key requirements.")
    f2("Sewer Secret", "Failed to activate bonus. Check console for details.", 5)
  end
end

local function f52()
  local v164 = f3()

  if not v164 or not v164.rebirth or not v164.balances then
    return false
  end

  local getPotentialInvestors = v164.rebirth:GetPotentialInvestors()

  if getPotentialInvestors <= v6.one then
    return false
  end

  local v165 = {
    Immediately = 1,
    x1 = 1,
    x2 = 2,
    x5 = 5,
    x10 = 10,
    x50 = 50,
    x100 = 100,
    x500 = 500,
    x1000 = 1000,
  }

  local v166 = v165[f1("Dropdown_Prestige_RebirthMode") or "x2"] or 1

  if v166 <= 1 then
    return true
  end

  local getInvestors = v164.balances:GetInvestors()

  if getInvestors <= v6.one then
    return true
  end

  return getPotentialInvestors >= v6.multiply(getInvestors, v6.toHuge(v166))
end

local function f53()
  local v167 = f3()

  if not v167 or not v167.evolution then
    return false
  end

  return v167.evolution:GetEvolutionProgress() >= 1
end

local function f54()
  local v168 = f3()

  if not v168 then
    return false
  end

  local instance2 = v168.tycoon.Instance
  local v169 = #v11.PurchaseOrder
  return f4(instance2) >= v169
end

local function f55()
  local v170 = f3()

  if not v170 or not v170.rebirth or not v170.balances then
    return nil
  end

  local getInvestors2 = v170.balances:GetInvestors()
  local getPotentialInvestors2 = v170.rebirth:GetPotentialInvestors()
  local getEvolutionProgress = v170.evolution and v170.evolution:GetEvolutionProgress() or 0
  local instance3 = v170.tycoon.Instance
  local v171 = #v11.PurchaseOrder
  local v172 = f4(instance3)
  local v173 = math.clamp(v172 / v171, 0, 1)
  local v174 = v6.formatAbbreviated(getInvestors2)
  local v175 = v6.formatAbbreviated(getPotentialInvestors2)
  local v176 = " (x0.0)"

  if getPotentialInvestors2 > v6.zero then
    local one = getInvestors2 > v6.one and getInvestors2 or v6.one
    local v177 = v6.toNumber(v6.divide(getPotentialInvestors2, one))

    if v177 then
      v176 = string.format(" (x%.1f)", v177)
    end
  end

  local v178 = math.floor(getEvolutionProgress * 1000) / 10
  local v179 = math.floor(v173 * 1000) / 10

  local v180 = f13() and "<font color=\"#00FF88\">x2 Active (Sewer Alien)</font>"
    or "<font color=\"#FFAA00\">x1 (Not Claimed)</font>"

  local v181 = f12()

  local v182 = {
    string.format("<b>Total Rebirths:</b> <font color=\"#00FF88\">%d</font>", v181),
    string.format("<b>Current Investors:</b> <font color=\"#00FF88\">%s</font>", v174),
    string.format("<b>Potential Gain:</b> <font color=\"#FFFF55\">+%s</font>%s", v175, v176),
    string.format("<b>Investor Boost:</b> %s", v180),
    string.format("<b>Evolve Progress:</b> <font color=\"#55AAFF\">%.1f%%</font>", v178),
    string.format(
      "<b>Ascend Progress:</b> <font color=\"#FFAAFF\">%.1f%%</font> <i>(%d/%d)</i>", v179,
      v172, v171
    ),
  }

  return table.concat(v182, "\n")
end

local function f56()
  if v22.IsAutoCollectIncomeLoopRunning then
    return
  end

  v22.IsAutoCollectIncomeLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Main_AutoCollectIncome") do
      local v183 = f5()
      local remotes3 = v183 and v183:FindFirstChild("Remotes")
      local wakeIncomeStream = remotes3 and remotes3:FindFirstChild("WakeIncomeStream")

      if wakeIncomeStream and wakeIncomeStream:IsA("RemoteFunction") then
        pcall(function() wakeIncomeStream:InvokeServer("LemonStand") end)
      end

      task.wait(1)
    end

    v22.IsAutoCollectIncomeLoopRunning = false
  end)
end

local function f57()
  if v22.IsAutoClaimOfflineEarningsLoopRunning then
    return
  end

  v22.IsAutoClaimOfflineEarningsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Main_AutoClaimOfflineEarnings") do
      f35()
      task.wait(2)
    end

    v22.IsAutoClaimOfflineEarningsLoopRunning = false
  end)
end

local function f58()
  if v22.IsAutoBuyPurchasesLoopRunning then
    return
  end

  v22.IsAutoBuyPurchasesLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Main_AutoBuyPurchases") do
      local v184 = f5()
      local purchases3 = v184 and v184:FindFirstChild("Purchases")

      if purchases3 then
        local dropdownMainPurchaseCategories = f1("Dropdown_Main_PurchaseCategories")

        for index32, value43 in ipairs(purchases3:GetDescendants()) do
          if v1.Unloaded or not f1("Toggle_Main_AutoBuyPurchases") then
            break
          end

          if value43:IsA("RemoteFunction") and value43.Name == "Purchase" then
            local parent3 = value43.Parent

            if parent3 and parent3:IsA("Model") and parent3:GetAttribute("Enabled")
              and not parent3:GetAttribute("Purchased") then
              if f7(dropdownMainPurchaseCategories, (f6(parent3))) then
                pcall(function() value43:InvokeServer(false, false) end)
              end
            end
          end
        end
      end

      task.wait(0.5)
    end

    v22.IsAutoBuyPurchasesLoopRunning = false
  end)
end

local function f59()
  if v22.IsAutoUpgradeStandsLoopRunning then
    return
  end

  v22.IsAutoUpgradeStandsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Main_AutoUpgradeStands") do
      local v185 = f5()
      local purchases4 = v185 and v185:FindFirstChild("Purchases")

      if purchases4 then
        local dropdownMainUpgradeStands = f1("Dropdown_Main_UpgradeStands")

        for index33, value44 in ipairs(purchases4:GetDescendants()) do
          if v1.Unloaded or not f1("Toggle_Main_AutoUpgradeStands") then
            break
          end

          if value44:IsA("RemoteFunction") and value44.Name == "Upgrade" then
            local parent4 = value44.Parent

            if parent4 and f7(dropdownMainUpgradeStands, parent4.Name) then
              for index34, value45 in ipairs({ 100, 25, 5, 1 }) do
                if pcall(function() value44:InvokeServer(value45) end) then
                  break
                end
              end
            end
          end
        end
      end

      task.wait(0.5)
    end

    v22.IsAutoUpgradeStandsLoopRunning = false
  end)
end

local function f60()
  if v22.IsAutoUpgradePowersLoopRunning then
    return
  end

  v22.IsAutoUpgradePowersLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Main_AutoUpgradePowers") do
      local v186 = f5()
      local remotes4 = v186 and v186:FindFirstChild("Remotes")
      local upgradePowerLevel = remotes4 and remotes4:FindFirstChild("UpgradePowerLevel")
      local values5 = v186 and v186:FindFirstChild("Values")
      local powers = values5 and values5:FindFirstChild("Powers")

      if upgradePowerLevel and upgradePowerLevel:IsA("RemoteFunction") then
        local dropdownMainUpgradePowers = f1("Dropdown_Main_UpgradePowers")

        for index35, value46 in ipairs(v21.PowerNames or {}) do
          if v1.Unloaded or not f1("Toggle_Main_AutoUpgradePowers") then
            break
          end

          if f7(dropdownMainUpgradePowers, value46) then
            local getAttribute = powers and powers:GetAttribute(value46) or 0
            local powerMaxLevels = v21.PowerMaxLevels and v21.PowerMaxLevels[value46]

            if not powerMaxLevels or getAttribute < powerMaxLevels then
              pcall(function() upgradePowerLevel:InvokeServer(value46, 1) end)
              task.wait(0.1)
            end
          end
        end
      end

      task.wait(1.5)
    end

    v22.IsAutoUpgradePowersLoopRunning = false
  end)
end

local function f61(p40)
  if not p40 then
    return false
  end

  pcall(function() p40.MaxActivationDistance = math.huge end)

  if typeof(fireclickdetector) == "function" then
    if pcall(fireclickdetector, p40) then
      return true
    end

    if pcall(fireclickdetector, p40, 0, "MouseClick") then
      return true
    end

    if pcall(fireclickdetector, p40, 0) then
      return true
    end
  end

  if typeof(firesignal) == "function" and p40.MouseClick then
    if pcall(firesignal, p40.MouseClick, localPlayer) then
      return true
    end
  end

  return false
end

local function f62()
  if v22.IsAutoClickFruitsLoopRunning then
    return
  end

  v22.IsAutoClickFruitsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Event_AutoClickFruits") do
      pcall(function()
        local character3 = localPlayer.Character
        local humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart3 then
          return
        end

        local v187 = {}

        for index36, value47 in ipairs(collectionService:GetTagged("ClickFruit")) do
          if value47:IsA("BasePart") and value47.Transparency == 0 then
            local findFirstChildWhichIsA3 = value47:FindFirstChildWhichIsA(
              "ClickDetector", true
            )

            if findFirstChildWhichIsA3 then
              local magnitude = (value47.Position - humanoidRootPart3.Position).Magnitude

              if magnitude <= 200 then
                table.insert(v187, { detector = findFirstChildWhichIsA3, dist = magnitude })
              end
            end
          end
        end

        if #v187 == 0 and f1("Toggle_Event_TeleportIfTooFar") then
          local v188 = f5()
          local v189 = nil

          if v188 then
            for index37, value48 in ipairs(collectionService:GetTagged("ClickFruit")) do
              if value48:IsDescendantOf(v188) and value48:IsA("BasePart")
                and value48.Transparency == 0 then
                v189 = value48
                break
              end
            end
          end

          if not v189 then
            for index38, value49 in ipairs(collectionService:GetTagged("ClickFruit")) do
              if value49:IsA("BasePart") and value49.Transparency == 0 then
                v189 = value49
                break
              end
            end
          end

          if v189 then
            f19(v189.CFrame)
            task.wait(0.5)
            character3 = localPlayer.Character
            humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart3 then
              for index39, value50 in ipairs(collectionService:GetTagged("ClickFruit")) do
                if value50:IsA("BasePart") and value50.Transparency == 0 then
                  local findFirstChildWhichIsA4 = value50:FindFirstChildWhichIsA(
                    "ClickDetector", true
                  )

                  if findFirstChildWhichIsA4 then
                    local magnitude2 = (value50.Position - humanoidRootPart3.Position).Magnitude

                    if magnitude2 <= 200 then
                      table.insert(v187, {
                        detector = findFirstChildWhichIsA4,
                        dist = magnitude2,
                      })
                    end
                  end
                end
              end
            end
          end
        end

        table.sort(v187, function(p41, p42) return p41.dist < p42.dist end)
        local count2 = 0

        for index40, value51 in ipairs(v187) do
          if v1.Unloaded or not f1("Toggle_Event_AutoClickFruits") or count2 >= 50 then
            break
          end

          f61(value51.detector)
          count2 = count2 + 1
          task.wait(0.03)
        end
      end)

      task.wait(3)
    end

    v22.IsAutoClickFruitsLoopRunning = false
  end)
end

local function f63()
  if v22.IsAutoRaceLoopRunning then
    return
  end

  v22.IsAutoRaceLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Event_AutoRace") do
      pcall(function()
        if v22.MinigameBusy then
          return
        end

        local core2 = replicatedStorage:FindFirstChild("Core")
        local remoteRequest2 = core2 and core2:FindFirstChild("RemoteRequest")

        local minigameRaceServiceStart = remoteRequest2
          and remoteRequest2:FindFirstChild("MinigameRaceService.Start")

        local minigameRaceServiceEnd = remoteRequest2
          and remoteRequest2:FindFirstChild("MinigameRaceService.End")

        if not (minigameRaceServiceStart and minigameRaceServiceEnd) then
          return
        end

        v22.MinigameBusy = true

        if minigameRaceServiceStart:InvokeServer() == nil then
          v22.MinigameBusy = false
          return
        end

        local invokeServer = minigameRaceServiceEnd:InvokeServer(1)
        v22.MinigameBusy = false
        local v190 = tostring(invokeServer)
        pcall(function() v190 = "$" .. v6.formatAbbreviated(invokeServer) end)
        f2("Minigame", "Lemon Dash - Race 1st place! +" .. v190 .. " cash", 4)
      end)

      task.wait(5)
    end

    v22.IsAutoRaceLoopRunning = false
  end)
end

local function f64()
  if v22.IsAutoTradeLoopRunning then
    return
  end

  v22.IsAutoTradeLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Event_AutoTrade") do
      pcall(function()
        if v22.MinigameBusy then
          return
        end

        local core3 = replicatedStorage:FindFirstChild("Core")
        local remoteRequest3 = core3 and core3:FindFirstChild("RemoteRequest")

        local minigameTradeServiceStart = remoteRequest3
          and remoteRequest3:FindFirstChild("MinigameTradeService.Start")

        local minigameTradeServiceEnd = remoteRequest3
          and remoteRequest3:FindFirstChild("MinigameTradeService.End")

        if not (minigameTradeServiceStart and minigameTradeServiceEnd) then
          return
        end

        v22.MinigameBusy = true
        local invokeServer2 = minigameTradeServiceStart:InvokeServer()

        if type(invokeServer2) ~= "table" then
          v22.MinigameBusy = false
          return
        end

        local invokeServer3 = minigameTradeServiceEnd:InvokeServer(invokeServer2.MaxEarnings)
        v22.MinigameBusy = false
        local v191 = tostring(invokeServer3)
        pcall(function() v191 = "$" .. v6.formatAbbreviated(invokeServer3) end)
        f2("Minigame", "Lemon Trading - Trade max win! +" .. v191 .. " cash", 4)
      end)

      task.wait(5)
    end

    v22.IsAutoTradeLoopRunning = false
  end)
end

local function f65()
  if v22.IsAutoRebirthLoopRunning then
    return
  end

  v22.IsAutoRebirthLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Prestige_AutoRebirth") do
      pcall(function()
        if f52() then
          local v192 = f5()
          local remotes5 = v192 and v192:FindFirstChild("Remotes")
          local rebirth = remotes5 and remotes5:FindFirstChild("Rebirth")

          if rebirth and rebirth:IsA("RemoteFunction") then
            if rebirth:InvokeServer(false) then
              v1:Notify({
                Title = "Prestige",
                Content = "Successfully Rebirthed Tycoon!",
                Duration = 3,
              })
            end
          end
        end
      end)

      task.wait(2)
    end

    v22.IsAutoRebirthLoopRunning = false
  end)
end

local function f66()
  if v22.IsAutoEvolveLoopRunning then
    return
  end

  v22.IsAutoEvolveLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Prestige_AutoEvolve") do
      pcall(function()
        if f53() then
          local v193 = f5()
          local remotes6 = v193 and v193:FindFirstChild("Remotes")
          local evolve = remotes6 and remotes6:FindFirstChild("Evolve")

          if evolve and evolve:IsA("RemoteFunction") then
            if evolve:InvokeServer(false) then
              v1:Notify({
                Title = "Prestige",
                Content = "Successfully Evolved Tycoon!",
                Duration = 3,
              })
            end
          end
        end
      end)

      task.wait(3)
    end

    v22.IsAutoEvolveLoopRunning = false
  end)
end

local function f67()
  if v22.IsAutoAscendLoopRunning then
    return
  end

  v22.IsAutoAscendLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Prestige_AutoAscend") do
      pcall(function()
        if f54() then
          local v194 = f5()
          local remotes7 = v194 and v194:FindFirstChild("Remotes")
          local ascend = remotes7 and remotes7:FindFirstChild("Ascend")

          if ascend and ascend:IsA("RemoteFunction") then
            if ascend:InvokeServer() then
              v1:Notify({
                Title = "Prestige",
                Content = "Successfully Ascended Tycoon!",
                Duration = 3,
              })
            end
          end
        end
      end)

      task.wait(3)
    end

    v22.IsAutoAscendLoopRunning = false
  end)
end

local function f68()
  if v22.IsAutoCollectSewerLoopRunning then
    return
  end

  v22.IsAutoCollectSewerLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Prestige_AutoCollectSewer") do
      pcall(function()
        local v195 = f22()
        local getServerTimeNow = workspace:GetServerTimeNow()

        if not (v195 == 0 or getServerTimeNow >= v195) then
          return
        end

        local map2 = v5:FindFirstChild("Map")

        local findFirstChild5 = map2 and map2:FindFirstChild("Sewer")
          and map2.Sewer:FindFirstChild("CashVine", true)

        if not findFirstChild5 then
          return
        end

        local findFirstChild6 = findFirstChild5:FindFirstChild("Use", true)

        local findFirstChildWhichIsA5 = findFirstChild5:FindFirstChildWhichIsA(
          "ProximityPrompt", true
        )

        local v196 = false

        if findFirstChild6 and findFirstChild6:IsA("RemoteFunction") then
          local v197, v198 = pcall(function() return findFirstChild6:InvokeServer() end)

          if v197 and v198 then
            v196 = true
          end
        end

        if not v196 then
          local character4 = localPlayer.Character
          local humanoidRootPart4 = character4 and character4:FindFirstChild("HumanoidRootPart")
          local humanoid = character4 and character4:FindFirstChildWhichIsA("Humanoid")

          if humanoidRootPart4 and humanoid and humanoid.Health > 0 then
            local v199 = f20(findFirstChild5)

            if v199 then
              local cframe3 = humanoidRootPart4.CFrame
              humanoidRootPart4.CFrame = v199 + Vector3.new(0, 3, 0)
              task.wait(0.2)

              if findFirstChildWhichIsA5 then
                findFirstChildWhichIsA5.Enabled = true

                if typeof(fireproximityprompt) == "function" then
                  fireproximityprompt(findFirstChildWhichIsA5)
                end
              end

              if findFirstChild6 and findFirstChild6:IsA("RemoteFunction") then
                local v200, v201 = pcall(function() return findFirstChild6:InvokeServer() end)

                if v200 and v201 then
                  v196 = true
                end
              end

              task.wait(0.3)
              humanoidRootPart4.CFrame = cframe3
            end
          end
        end

        if v196 or f22() > getServerTimeNow then
          f2("Cash Vine", "Collected Cash Vine reward!", 4)
        end
      end)

      task.wait(5)
    end

    v22.IsAutoCollectSewerLoopRunning = false
  end)
end

local function f69()
  if v22.IsPrestigeStatsLoopRunning then
    return
  end

  v22.IsPrestigeStatsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded do
      local v202 = f55()

      if v202 then
        v23.PrestigeStatsText = v202
      end

      task.wait(5)
    end
  end)

  task.spawn(function()
    while not v1.Unloaded do
      if v25.PrestigeStats and v23.PrestigeStatsText then
        v25.PrestigeStats:SetContent(v23.PrestigeStatsText)
      end

      task.wait(5)
    end

    v22.IsPrestigeStatsLoopRunning = false
  end)
end

local function f70()
  if v22.IsAutoUnlockOrchardLoopRunning then
    return
  end

  v22.IsAutoUnlockOrchardLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoUnlockOrchard") do
      pcall(function()
        if not f11() then
          local v203 = f15()
          local v204 = f40()

          if v203 and v204 and v203 >= v204 then
            local v205 = f5()
            local remotes8 = v205 and v205:FindFirstChild("Remotes")
            local unlockOrchard = remotes8 and remotes8:FindFirstChild("UnlockOrchard")

            if unlockOrchard and unlockOrchard:IsA("RemoteFunction") then
              unlockOrchard:InvokeServer()
            end
          end
        end
      end)

      task.wait(3)
    end

    v22.IsAutoUnlockOrchardLoopRunning = false
  end)
end

local function f71()
  if v22.IsAutoUnlockPlotsLoopRunning then
    return
  end

  v22.IsAutoUnlockPlotsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoUnlockPlots") do
      pcall(function()
        if not f11() then
          return
        end

        local v206 = f41()

        if f16() >= v206 then
          local v207 = f42()
          local v208 = f5()
          local remotes9 = v208 and v208:FindFirstChild("Remotes")
          local unlockPlot = remotes9 and remotes9:FindFirstChild("UnlockPlot")

          if unlockPlot and unlockPlot:IsA("RemoteFunction") then
            for index41, value52 in ipairs(v207) do
              if unlockPlot:InvokeServer(value52.ID) then
                break
              end
            end
          end
        end
      end)

      task.wait(2)
    end

    v22.IsAutoUnlockPlotsLoopRunning = false
  end)
end

local function f72()
  if v22.IsAutoUpgradePlotsLoopRunning then
    return
  end

  v22.IsAutoUpgradePlotsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoUpgradePlots") do
      pcall(function()
        if not f11() then
          return
        end

        local dropdownOrchardUpgradeTypes = f1("Dropdown_Orchard_UpgradeTypes")

        if not dropdownOrchardUpgradeTypes or next(dropdownOrchardUpgradeTypes) == nil then
          return
        end

        local core4 = replicatedStorage:FindFirstChild("Core")
        local remoteRequest4 = core4 and core4:FindFirstChild("RemoteRequest")

        local orchardPlotUseItem = remoteRequest4
          and remoteRequest4:FindFirstChild("OrchardPlot.UseItem")

        local v209 = f5()
        local remotes10 = v209 and v209:FindFirstChild("Remotes")
        local buyOrchardItems = remotes10 and remotes10:FindFirstChild("BuyOrchardItems")

        if not (orchardPlotUseItem and buyOrchardItems and buyOrchardItems:IsA("RemoteFunction")) then
          return
        end

        local v210 = f44()

        for index42, value53 in ipairs(v21.PlotUpgrades or {}) do
          if v1.Unloaded or not f1("Toggle_Orchard_AutoUpgradePlots") then
            break
          end

          if f7(dropdownOrchardUpgradeTypes, value53.Name) and f17(value53.Name) > 0 then
            for index43, value54 in ipairs(v210) do
              if value54:GetAttribute(value53.Name .. "Unlocked") ~= true then
                if orchardPlotUseItem:InvokeServer(value54, value53.Name) then
                  task.wait(0.2)
                  break
                end
              end
            end
          end
        end

        local v211 = f16()

        for index44, value55 in ipairs(v21.PlotUpgrades or {}) do
          if v1.Unloaded or not f1("Toggle_Orchard_AutoUpgradePlots") then
            break
          end

          if f7(dropdownOrchardUpgradeTypes, value55.Name) and v211 >= value55.Cost then
            for index45, value56 in ipairs(v210) do
              if value56:GetAttribute(value55.Name .. "Unlocked") ~= true then
                if buyOrchardItems:InvokeServer(value55.Name, 1) then
                  task.wait(0.1)
                  orchardPlotUseItem:InvokeServer(value56, value55.Name)
                  v211 = v211 - value55.Cost
                end

                break
              end
            end
          end
        end
      end)

      task.wait(2)
    end

    v22.IsAutoUpgradePlotsLoopRunning = false
  end)
end

local function f73()
  if v22.IsAutoFertilizerLoopRunning then
    return
  end

  v22.IsAutoFertilizerLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoFertilizer") do
      pcall(function()
        if not f11() then
          return
        end

        local dropdownOrchardFertilizerTypes = f1("Dropdown_Orchard_FertilizerTypes")

        if not dropdownOrchardFertilizerTypes or next(dropdownOrchardFertilizerTypes) == nil then
          return
        end

        local core5 = replicatedStorage:FindFirstChild("Core")
        local remoteRequest5 = core5 and core5:FindFirstChild("RemoteRequest")

        local orchardPlotUseItem2 = remoteRequest5
          and remoteRequest5:FindFirstChild("OrchardPlot.UseItem")

        if not orchardPlotUseItem2 then
          return
        end

        local v212 = f44()

        for index46, value57 in ipairs(v21.Fertilizers or {}) do
          if v1.Unloaded or not f1("Toggle_Orchard_AutoFertilizer") then
            break
          end

          if f7(dropdownOrchardFertilizerTypes, value57.Name) and f17(value57.Name) > 0 then
            for index47, value58 in ipairs(v212) do
              local state3 = value58:GetAttribute("State")

              if (state3 == 1
                    and (not value57.HasMutation
                      or value58:GetAttribute("PendingMutationItem") == nil)
                  or state3 == 2 and not value57.HasMutation)
                and orchardPlotUseItem2:InvokeServer(value58, value57.Name) then
                task.wait(0.2)
                break
              end
            end
          end
        end
      end)

      task.wait(3)
    end

    v22.IsAutoFertilizerLoopRunning = false
  end)
end

local function f74()
  if v22.IsAutoHarvestOrchardLoopRunning then
    return
  end

  v22.IsAutoHarvestOrchardLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoHarvest") do
      pcall(function()
        if not f11() then
          return
        end

        local core6 = replicatedStorage:FindFirstChild("Core")
        local remoteRequest6 = core6 and core6:FindFirstChild("RemoteRequest")

        local orchardPlotHarvest = remoteRequest6
          and remoteRequest6:FindFirstChild("OrchardPlot.Harvest")

        if orchardPlotHarvest and orchardPlotHarvest:IsA("RemoteFunction") then
          for index48, value59 in ipairs((f43())) do
            if v1.Unloaded or not f1("Toggle_Orchard_AutoHarvest") then
              break
            end

            orchardPlotHarvest:InvokeServer(value59)
            task.wait(0.1)
          end
        end
      end)

      task.wait(5)
    end

    v22.IsAutoHarvestOrchardLoopRunning = false
  end)
end

local function f75()
  if v22.IsAutoSellFruitsLoopRunning then
    return
  end

  v22.IsAutoSellFruitsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoSellFruits") do
      pcall(function()
        if not f11() then
          return
        end

        local dropdownOrchardSellFruitTypes = f1("Dropdown_Orchard_SellFruitTypes")
        local dropdownOrchardSellFruitMutations = f1("Dropdown_Orchard_SellFruitMutations")

        if not dropdownOrchardSellFruitTypes or next(dropdownOrchardSellFruitTypes) == nil then
          return
        end

        if not dropdownOrchardSellFruitMutations
          or next(dropdownOrchardSellFruitMutations) == nil then
          return
        end

        local v213 = f18()

        if not v213 then
          return
        end

        local sliderOrchardSellFruitsKeep = f1("Slider_Orchard_SellFruitsKeep") or 1
        local v214 = {}

        for index49, value60 in ipairs(v213:GetAll()) do
          local fruit3 = value60.Fruit
          local count3 = value60.Count or 0
          local getFruitName4 = fruit3 and fruit3:GetFruitName()

          if getFruitName4 and count3 > sliderOrchardSellFruitsKeep
            and f7(dropdownOrchardSellFruitTypes, getFruitName4)
            and f8(fruit3, dropdownOrchardSellFruitMutations) then
            v214[fruit3] = count3 - sliderOrchardSellFruitsKeep
          end
        end

        if next(v214) ~= nil then
          v213:SellFruitsAsync(v214)
        end
      end)

      task.wait(5)
    end

    v22.IsAutoSellFruitsLoopRunning = false
  end)
end

local function f76()
  if v22.IsAutoEatFruitsLoopRunning then
    return
  end

  v22.IsAutoEatFruitsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoEatFruits") do
      pcall(function()
        if not f11() then
          return
        end

        local dropdownOrchardEatFruitTypes = f1("Dropdown_Orchard_EatFruitTypes")
        local dropdownOrchardEatFruitMutations = f1("Dropdown_Orchard_EatFruitMutations")

        if not dropdownOrchardEatFruitTypes or next(dropdownOrchardEatFruitTypes) == nil then
          return
        end

        if not dropdownOrchardEatFruitMutations or next(dropdownOrchardEatFruitMutations) == nil then
          return
        end

        if f49() then
          return
        end

        local v215 = f50(dropdownOrchardEatFruitTypes, dropdownOrchardEatFruitMutations)

        if not v215 then
          return
        end

        local v216 = f48()
        local v217 = false

        if v216 then
          local v218, v219 = pcall(function() return v216:EatFruitAsync(v215) end)
          v217 = v218 and v219
        end

        if not v217 then
          local v220 = f5()
          local remotes11 = v220 and v220:FindFirstChild("Remotes")
          local eatFruit = remotes11 and remotes11:FindFirstChild("EatFruit")

          if eatFruit and eatFruit:IsA("RemoteFunction") then
            eatFruit:InvokeServer({ v215:Serialize() })
          end
        end
      end)

      task.wait(3)
    end

    v22.IsAutoEatFruitsLoopRunning = false
  end)
end

local function f77()
  if v22.IsAutoPlantOrchardLoopRunning then
    return
  end

  v22.IsAutoPlantOrchardLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoPlant") do
      pcall(function()
        if not f11() then
          return
        end

        local dropdownOrchardPlantTrees = f1("Dropdown_Orchard_PlantTrees")
        local dropdownOrchardPlantMutations = f1("Dropdown_Orchard_PlantMutations")

        if not dropdownOrchardPlantTrees or next(dropdownOrchardPlantTrees) == nil then
          return
        end

        if not dropdownOrchardPlantMutations or next(dropdownOrchardPlantMutations) == nil then
          return
        end

        local v221 = f45()

        if #v221 == 0 then
          return
        end

        local core7 = replicatedStorage:FindFirstChild("Core")
        local remoteRequest7 = core7 and core7:FindFirstChild("RemoteRequest")

        local orchardPlotPlant = remoteRequest7
          and remoteRequest7:FindFirstChild("OrchardPlot.Plant")

        if not (orchardPlotPlant and orchardPlotPlant:IsA("RemoteFunction")) then
          return
        end

        for index50, value61 in ipairs(v221) do
          if v1.Unloaded or not f1("Toggle_Orchard_AutoPlant") then
            break
          end

          local v222 = f47(dropdownOrchardPlantTrees, dropdownOrchardPlantMutations)

          if not v222 then
            break
          end

          local v223, v224 = pcall(function()
            return orchardPlotPlant:InvokeServer(value61, { v222:Serialize() })
          end)

          if v223 and v224 then
            task.wait(0.2)
          else
            break
          end
        end
      end)

      task.wait(3)
    end

    v22.IsAutoPlantOrchardLoopRunning = false
  end)
end

local function f78()
  if v22.IsAutoDestroyTreesLoopRunning then
    return
  end

  v22.IsAutoDestroyTreesLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoDestroyTrees") do
      pcall(function()
        if not f11() then
          return
        end

        local dropdownOrchardDestroyTrees = f1("Dropdown_Orchard_DestroyTrees")
        local dropdownOrchardDestroyMutations = f1("Dropdown_Orchard_DestroyMutations")

        if not dropdownOrchardDestroyTrees or next(dropdownOrchardDestroyTrees) == nil then
          return
        end

        if not dropdownOrchardDestroyMutations or next(dropdownOrchardDestroyMutations) == nil then
          return
        end

        local sliderOrchardDestroyMinCashMultiplier = f1("Slider_Orchard_DestroyMinCashMultiplier")
          or 0

        local core8 = replicatedStorage:FindFirstChild("Core")
        local remoteRequest8 = core8 and core8:FindFirstChild("RemoteRequest")

        local orchardPlotDestroyTree = remoteRequest8
          and remoteRequest8:FindFirstChild("OrchardPlot.DestroyTree")

        if not (orchardPlotDestroyTree and orchardPlotDestroyTree:IsA("RemoteFunction")) then
          return
        end

        local v225 = f18()

        if not v225 then
          return
        end

        for index51, value62 in ipairs((f46())) do
          if v1.Unloaded or not f1("Toggle_Orchard_AutoDestroyTrees") then
            break
          end

          local state4 = value62:GetAttribute("State")

          if state4 and state4 >= 2 then
            local getPlotFruit = v225:GetPlotFruit((value62:GetAttribute("ID")))
            local getFruitName5 = getPlotFruit and getPlotFruit:GetFruitName()

            if getFruitName5 and f7(dropdownOrchardDestroyTrees, getFruitName5)
              and f8(getPlotFruit, dropdownOrchardDestroyMutations) then
              local v226 = true

              if sliderOrchardDestroyMinCashMultiplier > 0 then
                if f9(getPlotFruit) >= sliderOrchardDestroyMinCashMultiplier then
                  v226 = false
                end
              end

              if v226 then
                orchardPlotDestroyTree:InvokeServer(value62)
                task.wait(0.3)
              end
            end
          end
        end
      end)

      task.wait(3)
    end

    v22.IsAutoDestroyTreesLoopRunning = false
  end)
end

local function f79()
  if v22.IsAutoBuyOrchardItemsLoopRunning then
    return
  end

  v22.IsAutoBuyOrchardItemsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoBuyOrchardItems") do
      pcall(function()
        if not f11() then
          return
        end

        local dropdownOrchardOrchardItems = f1("Dropdown_Orchard_OrchardItems")
        local sliderOrchardOrchardItemsMaxCount = f1("Slider_Orchard_OrchardItemsMaxCount") or 5

        if not dropdownOrchardOrchardItems or next(dropdownOrchardOrchardItems) == nil then
          return
        end

        local v227 = f5()
        local remotes12 = v227 and v227:FindFirstChild("Remotes")
        local buyOrchardItems2 = remotes12 and remotes12:FindFirstChild("BuyOrchardItems")

        if not (buyOrchardItems2 and buyOrchardItems2:IsA("RemoteFunction")) then
          return
        end

        local v228 = f16()
        local v229 = {}

        for index52, value63 in ipairs(v21.PlotUpgrades or {}) do
          table.insert(v229, value63)
        end

        for index53, value64 in ipairs(v21.Fertilizers or {}) do
          table.insert(v229, value64)
        end

        for index54, value65 in ipairs(v229) do
          if v1.Unloaded or not f1("Toggle_Orchard_AutoBuyOrchardItems") then
            break
          end

          if f7(dropdownOrchardOrchardItems, value65.Name) then
            local v230 = sliderOrchardOrchardItemsMaxCount - f17(value65.Name)

            if v230 > 0 then
              local v231 = value65.Cost > 0 and math.floor(v228 / value65.Cost) or v230
              local v232 = math.min(v230, v231)

              if v232 > 0 then
                if buyOrchardItems2:InvokeServer(value65.Name, v232) then
                  v228 = v228 - value65.Cost * v232
                  task.wait(0.2)
                end
              end
            end
          end
        end
      end)

      task.wait(5)
    end

    v22.IsAutoBuyOrchardItemsLoopRunning = false
  end)
end

local function f80()
  if v22.IsAutoBuyDecorationsLoopRunning then
    return
  end

  v22.IsAutoBuyDecorationsLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and f1("Toggle_Orchard_AutoBuyDecorations") do
      pcall(function()
        if not f11() then
          return
        end

        local dropdownOrchardDecorations = f1("Dropdown_Orchard_Decorations")

        if not dropdownOrchardDecorations or next(dropdownOrchardDecorations) == nil then
          return
        end

        local v233 = f5()
        local values6 = v233 and v233:FindFirstChild("Values")
        local orchardDecorations = values6 and values6:FindFirstChild("OrchardDecorations")
        local remotes13 = v233 and v233:FindFirstChild("Remotes")

        local purchaseOrchardDecoration = remotes13
          and remotes13:FindFirstChild("PurchaseOrchardDecoration")

        if not (purchaseOrchardDecoration and purchaseOrchardDecoration:IsA("RemoteFunction")) then
          return
        end

        local v234 = f16()

        for index55, value66 in ipairs(v21.DecorationNames or {}) do
          if v1.Unloaded or not f1("Toggle_Orchard_AutoBuyDecorations") then
            break
          end

          if f7(dropdownOrchardDecorations, value66) then
            local v235 = orchardDecorations and orchardDecorations:GetAttribute(value66) == true
            local decorationPrices = v21.DecorationPrices and v21.DecorationPrices[value66] or 0

            if not v235 and v234 >= decorationPrices then
              if purchaseOrchardDecoration:InvokeServer(value66) then
                v234 = v234 - decorationPrices
                task.wait(0.3)
              end
            end
          end
        end
      end)

      task.wait(5)
    end

    v22.IsAutoBuyDecorationsLoopRunning = false
  end)
end

f23()
f24()
f25()
f26()
f27()
f28()
f29()
f30()
f31()
local sellLemonWindow = v1:CreateWindow({ Title = "Sell Lemon", SubTitle = "by Lamduck" })

local v236 = {
  Main = sellLemonWindow:AddTab({ Title = "Main", Icon = "house" }),
  Event = sellLemonWindow:AddTab({ Title = "Event", Icon = "party-popper" }),
  Prestige = sellLemonWindow:AddTab({ Title = "Prestige", Icon = "rotate-cw" }),
  Orchard = sellLemonWindow:AddTab({ Title = "Orchard", Icon = "tree-pine" }),
  Teleports = sellLemonWindow:AddTab({ Title = "Teleports", Icon = "map-pin" }),
  Settings = sellLemonWindow:AddTab({ Title = "Settings", Icon = "settings" }),
}

v236.Main:AddSection("Income")

v236.Main:AddToggle("Toggle_Main_AutoCollectIncome", {
  Title = "Auto Collect Income",
  Default = false,
  Callback = function(value67)
    if value67 then
      f56()
    end
  end,
})

v236.Main:AddSection("Purchases")

v236.Main:AddDropdown("Dropdown_Main_PurchaseCategories", {
  Title = "Purchase Categories",
  Values = v21.PurchaseCategories or {},
  Default = table.clone(v21.PurchaseCategories or {}),
  Multi = true,
})

v236.Main:AddToggle("Toggle_Main_AutoBuyPurchases", {
  Title = "Auto Buy Purchases",
  Default = false,
  Callback = function(value68)
    if value68 then
      f58()
    end
  end,
})

v236.Main:AddSection("Upgrades")

v236.Main:AddDropdown("Dropdown_Main_UpgradeStands", {
  Title = "Upgrade Stands",
  Values = v21.StandNames or {},
  Default = table.clone(v21.StandNames or {}),
  Multi = true,
})

v236.Main:AddToggle("Toggle_Main_AutoUpgradeStands", {
  Title = "Auto Upgrade Stands",
  Default = false,
  Callback = function(value69)
    if value69 then
      f59()
    end
  end,
})

v236.Main:AddSection("Powers")

v236.Main:AddDropdown("Dropdown_Main_UpgradePowers", {
  Title = "Powers to Upgrade",
  Values = v21.PowerNames or {},
  Default = table.clone(v21.PowerNames or {}),
  Multi = true,
})

v236.Main:AddToggle("Toggle_Main_AutoUpgradePowers", {
  Title = "Auto Upgrade Powers",
  Default = false,
  Callback = function(value70)
    if value70 then
      f60()
    end
  end,
})

v236.Main:AddSection("Phone & Offline Earnings")

v236.Main:AddToggle("Toggle_Main_AutoPhoneOffer", {
  Title = "Auto Accept Phone Offers",
  Description = "Auto accepts all incoming phone offers",
  Default = false,
  Callback = function(value71)
    if value71 then
      f34()
    end
  end,
})

v236.Main:AddToggle("Toggle_Main_AutoClaimOfflineEarnings", {
  Title = "Auto Claim Offline Earnings",
  Description = "Automatically claims offline earnings and closes the popup",
  Default = false,
  Callback = function(value72)
    if value72 then
      f35()
      f57()
    end
  end,
})

v236.Event:AddSection("Drops")

v236.Event:AddToggle("Toggle_Event_AutoRedeemDrops", {
  Title = "Auto Instant Redeem Drops",
  Description = "Instantly redeems all map drops (Cash, Tokens, Investors, Companions)",
  Default = false,
  Callback = function(value73)
    if value73 then
      f39()
    end
  end,
})

v236.Event:AddSection("Clicker")

v236.Event:AddToggle("Toggle_Event_AutoClickFruits", {
  Title = "Auto Click Lemons/Fruits",
  Description = "Clicks fruits within 200 studs",
  Default = false,
  Callback = function(value74)
    if value74 then
      f62()
    end
  end,
})

v236.Event:AddToggle("Toggle_Event_TeleportIfTooFar", {
  Title = "Teleport If Too Far",
  Description = "Teleports near lemon trees if fruits are out of range",
  Default = false,
})

v236.Event:AddSection("Minigames")

v236.Event:AddToggle("Toggle_Event_AutoRace", {
  Title = "Auto Race (Lemon Dash)",
  Description = "Instantly finishes Race with 1st place when ready",
  Default = false,
  Callback = function(value75)
    if value75 then
      f63()
    end
  end,
})

v236.Event:AddToggle("Toggle_Event_AutoTrade", {
  Title = "Auto Trade (Lemon Trading)",
  Description = "Instantly finishes Trade with max earnings when ready",
  Default = false,
  Callback = function(value76)
    if value76 then
      f64()
    end
  end,
})

v236.Prestige:AddSection("Stats")

v25.PrestigeStats = v236.Prestige:AddParagraph("Paragraph_Prestige_Stats", {
  Title = "Prestige Overview",
  Content = "Loading stats...",
})

v236.Prestige:AddSection("Rebirth")

v236.Prestige:AddDropdown("Dropdown_Prestige_RebirthMode", {
  Title = "Rebirth Condition",
  Description = "Condition to trigger Auto Rebirth:\n• x1: Rebirth as soon as Potential > 1\n• x2 and above: Wait until Potential >= Current * N\n\nExample: If Current Investors = 10, Condition = 2x, it will Rebirth when Potential >= 20",
  Values = { "x1", "x2", "x5", "x10", "x50", "x100", "x500", "x1000" },
  Default = "x2",
})

v236.Prestige:AddToggle("Toggle_Prestige_AutoRebirth", {
  Title = "Auto Rebirth",
  Description = "Automatically rebirths tycoon when the selected condition is met",
  Default = false,
  Callback = function(value77)
    if value77 then
      f65()
    end
  end,
})

v236.Prestige:AddSection("Evolution & Ascension")

v236.Prestige:AddToggle("Toggle_Prestige_AutoEvolve", {
  Title = "Auto Evolve",
  Description = "Automatically evolves tycoon when evolution progress reaches 100%",
  Default = false,
  Callback = function(value78)
    if value78 then
      f66()
    end
  end,
})

v236.Prestige:AddToggle("Toggle_Prestige_AutoAscend", {
  Title = "Auto Ascend",
  Description = "Automatically ascends tycoon when all purchases are complete",
  Default = false,
  Callback = function(value79)
    if value79 then
      f67()
    end
  end,
})

v236.Prestige:AddSection("Sewer Secret")

v236.Prestige:AddButton({
  Title = "Claim x2 Investor Bonus",
  Description = "Automatically skips sewer puzzle and claims permanent x2 Investor Bonus from Sewer Alien (requires 1+ Rebirth)",
  Callback = function()
    print("[Sewer Secret] Button clicked in UI!")

    task.spawn(function()
      local v237, v238 = xpcall(f51, function(p43) return debug.traceback(tostring(p43)) end)

      if not v237 then
        warn("[Sewer Secret] Fatal error in ClaimSewerAlienBoost:", v238)
      end
    end)
  end,
})

v236.Prestige:AddToggle("Toggle_Prestige_AutoCollectSewer", {
  Title = "Auto Collect Sewer",
  Description = "Automatically collects secret Cash Vine reward in the sewer when ready",
  Default = false,
  Callback = function(value80)
    if value80 then
      f68()
    end
  end,
})

v25.OrchardMutationsInfo = v236.Orchard:AddParagraph("Paragraph_Orchard_MutationsInfo", {
  Title = "Orchard Mutations Overview",
  Content = f32(),
})

local addSubTabBar = v236.Orchard:AddSubTabBar({
  SubTabs = { "Plots", "Trees", "Market", "Buffs" },
  Default = "Plots",
})

local plots = addSubTabBar.Plots
local trees = addSubTabBar.Trees
local market = addSubTabBar.Market
local buffs = addSubTabBar.Buffs

plots:AddSection("Unlock")

plots:AddToggle("Toggle_Orchard_AutoUnlockOrchard", {
  Title = "Auto Unlock Orchard",
  Default = false,
  Callback = function(value81)
    if value81 then
      f70()
    end
  end,
})

plots:AddToggle("Toggle_Orchard_AutoUnlockPlots", {
  Title = "Auto Unlock Plots",
  Default = false,
  Callback = function(value82)
    if value82 then
      f71()
    end
  end,
})

plots:AddSection("Upgrades")

plots:AddDropdown("Dropdown_Orchard_UpgradeTypes", {
  Title = "Plot Upgrades",
  Values = v21.PlotUpgradeNames or {},
  Default = table.clone(v21.PlotUpgradeNames or {}),
  Multi = true,
})

plots:AddToggle("Toggle_Orchard_AutoUpgradePlots", {
  Title = "Auto Upgrade Plots",
  Default = false,
  Callback = function(value83)
    if value83 then
      f72()
    end
  end,
})

plots:AddSection("Fertilizer")

plots:AddDropdown("Dropdown_Orchard_FertilizerTypes", {
  Title = "Fertilizers",
  Values = v21.FertilizerNames or {},
  Default = {},
  Multi = true,
})

plots:AddToggle("Toggle_Orchard_AutoFertilizer", {
  Title = "Auto Apply Fertilizer",
  Default = false,
  Callback = function(value84)
    if value84 then
      f73()
    end
  end,
})

trees:AddSection("Plant")

trees:AddDropdown("Dropdown_Orchard_PlantTrees", {
  Title = "Trees to Plant",
  Values = v21.TreeNames or {},
  Default = {},
  Multi = true,
  Searchable = true,
})

trees:AddDropdown("Dropdown_Orchard_PlantMutations", {
  Title = "Plant Mutations",
  Description = "MUST SELECT!",
  Values = v21.MutationNames or {},
  Default = {
    "None", "Perfect", "Exotic", "Juicy", "Tasty", "Blessed", "Wild", "Zesty", "Tart", "Lucky",
    "Voided", "Slimy", "Giant", "Fast", "Stimulating",
  },
  Multi = true,
  Searchable = true,
})

trees:AddToggle("Toggle_Orchard_AutoPlant", {
  Title = "Auto Plant",
  Description = "Prefer highest cash multiple",
  Default = false,
  Callback = function(value85)
    if value85 then
      f77()
    end
  end,
})

trees:AddSection("Harvest")

trees:AddToggle("Toggle_Orchard_AutoHarvest", {
  Title = "Auto Harvest",
  Default = false,
  Callback = function(value86)
    if value86 then
      f74()
    end
  end,
})

trees:AddSection("Cleanup")

trees:AddDropdown("Dropdown_Orchard_DestroyTrees", {
  Title = "Trees to Destroy",
  Values = v21.TreeNames or {},
  Default = {},
  Multi = true,
  Searchable = true,
})

trees:AddDropdown("Dropdown_Orchard_DestroyMutations", {
  Title = "Mutations to Destroy",
  Description = "MUST SELECT!",
  Values = v21.MutationNames or {},
  Default = { "Draining", "Lazy", "Slow", "Dense", "Heavy" },
  Multi = true,
  Searchable = true,
})

trees:AddSlider("Slider_Orchard_DestroyMinCashMultiplier", {
  Title = "Min Cash Multiplier",
  Description = [[
Destroy if tree multiplier < value 
Set 0 to skip this filter]],
  Default = 1,
  Min = 0,
  Max = 25,
  Rounding = 1,
})

trees:AddToggle("Toggle_Orchard_AutoDestroyTrees", {
  Title = "Auto Destroy Trees",
  Default = false,
  Callback = function(value87)
    if value87 then
      f78()
    end
  end,
})

market:AddSection("Sell")

market:AddDropdown("Dropdown_Orchard_SellFruitTypes", {
  Title = "Fruit Types to Sell",
  Values = v21.TreeNames or {},
  Default = {},
  Multi = true,
  Searchable = true,
})

market:AddDropdown("Dropdown_Orchard_SellFruitMutations", {
  Title = "Mutations to Sell",
  Description = "MUST SELECT!",
  Values = v21.MutationNames or {},
  Default = { "None", "Draining", "Lazy", "Slow", "Dense", "Heavy" },
  Multi = true,
  Searchable = true,
})

market:AddSlider("Slider_Orchard_SellFruitsKeep", {
  Title = "Keep Minimum",
  Description = [[
Set to 0 to sell all
Set >1 to keep fruit for Auto Plant]],
  Default = 0,
  Min = 0,
  Max = 20,
  Rounding = 0,
})

market:AddToggle("Toggle_Orchard_AutoSellFruits", {
  Title = "Auto Sell Fruits",
  Default = false,
  Callback = function(value88)
    if value88 then
      f75()
    end
  end,
})

market:AddSection("Buy")

market:AddDropdown("Dropdown_Orchard_OrchardItems", {
  Title = "Orchard Items",
  Values = v21.OrchardItemNames or {},
  Default = {},
  Multi = true,
})

market:AddSlider("Slider_Orchard_OrchardItemsMaxCount", {
  Title = "Max Item Count",
  Description = "Maximum amount of each item to hold in inventory",
  Default = 5,
  Min = 1,
  Max = 20,
  Rounding = 0,
})

market:AddToggle("Toggle_Orchard_AutoBuyOrchardItems", {
  Title = "Auto Buy Orchard Items",
  Default = false,
  Callback = function(value89)
    if value89 then
      f79()
    end
  end,
})

market:AddDivider()

market:AddDropdown("Dropdown_Orchard_Decorations", {
  Title = "Decorations to Buy",
  Values = v21.DecorationNames or {},
  Default = {},
  Multi = true,
})

market:AddToggle("Toggle_Orchard_AutoBuyDecorations", {
  Title = "Auto Buy Decorations",
  Default = false,
  Callback = function(value90)
    if value90 then
      f80()
    end
  end,
})

buffs:AddSection("Fruit Buffs")

buffs:AddDropdown("Dropdown_Orchard_EatFruitTypes", {
  Title = "Fruit Types to Eat",
  Values = v21.TreeNames or {},
  Default = {},
  Multi = true,
  Searchable = true,
})

buffs:AddDropdown("Dropdown_Orchard_EatFruitMutations", {
  Title = "Mutations to Eat",
  Description = "MUST SELECT!",
  Values = v21.MutationNames or {},
  Default = {
    "None", "Perfect", "Exotic", "Juicy", "Tasty", "Blessed", "Wild", "Zesty", "Tart", "Lucky",
    "Voided", "Slimy", "Giant", "Fast", "Stimulating",
  },
  Multi = true,
  Searchable = true,
})

buffs:AddToggle("Toggle_Orchard_AutoEatFruits", {
  Title = "Auto Eat Fruits",
  Description = "Prefer highest cash multiple",
  Default = false,
  Callback = function(value91)
    if value91 then
      f76()
    end
  end,
})

v236.Teleports:AddSection("Floating Button")

v236.Teleports:AddToggle("Toggle_Teleports_ShowFloatingTP", {
  Title = "Show Floating Teleport Button",
  Description = "Displays a draggable floating button on screen",
  Default = false,
  Callback = function(value92)
    if value92 and not v23.FloatingTPGui then
      f33()
    end

    if v23.FloatingTPGui then
      v23.FloatingTPGui.Enabled = value92
    end
  end,
})

v236.Teleports:AddKeybind("Keybind_Teleports_TeleportToTycoon", {
  Title = "Teleport to Tycoon",
  Description = "Quick keybind to return to tycoon spawn",
  Mode = "Toggle",
  Default = "P",
  Callback = function()
    pcall(function()
      local v239 = f21(v20[1])

      if v239 then
        f19(v239)
      end
    end)
  end,
})

v236.Teleports:AddKeybind("Keybind_Teleports_TeleportToOrchard", {
  Title = "Teleport to Orchard",
  Description = "Quick keybind to return to orchard",
  Mode = "Toggle",
  Default = "O",
  Callback = function()
    pcall(function()
      local v240 = f21(v20[3])

      if v240 then
        f19(v240)
      end
    end)
  end,
})

local function f81()
  local v241 = f5()

  if not v241 then
    return
  end

  local remotes14 = v241:FindFirstChild("Remotes")
  local phoneOffer2 = remotes14 and remotes14:FindFirstChild("PhoneOffer")

  if phoneOffer2 and phoneOffer2:IsA("RemoteEvent") then
    v24.PhoneOffer = phoneOffer2.OnClientEvent:Connect(function(p44)
      if v1.Unloaded then
        return
      end

      if f1("Toggle_Main_AutoPhoneOffer") and typeof(p44) == "number" then
        pcall(function() phoneOffer2:FireServer("Accept") end)
      end
    end)
  end
end

local function f82()
  local core9 = replicatedStorage:FindFirstChild("Core")
  local remoteSignal = core9 and core9:FindFirstChild("RemoteSignal")
  local dropServiceNew = remoteSignal and remoteSignal:FindFirstChild("DropService.New")

  if dropServiceNew and dropServiceNew:IsA("RemoteEvent") then
    v24.DropServiceNew = dropServiceNew.OnClientEvent:Connect(function(p45, p46, ...)
      if v1.Unloaded then
        return
      end

      if f1("Toggle_Event_AutoRedeemDrops") and p45 then
        task.spawn(f38, p45, p46)
      end
    end)
  end

  local drops2 = v5:FindFirstChild("Drops")

  if drops2 then
    v24.EventDropsChildAdded = drops2.ChildAdded:Connect(function(child)
      if v1.Unloaded then
        return
      end

      if f1("Toggle_Event_AutoRedeemDrops") then
        task.defer(f36, child)
      end
    end)
  end
end

local function f83()
  task.spawn(function()
    local waitForChild = localPlayer:WaitForChild("PlayerGui", 5)
      and localPlayer.PlayerGui:WaitForChild("Prompt", 5)

    local waitForChild2 = waitForChild and waitForChild:WaitForChild("OfflineCash", 5)

    if waitForChild2 then
      v24.OfflineCashVisible = waitForChild2:GetPropertyChangedSignal("Visible"):Connect(function()
        if v1.Unloaded then
          return
        end

        if f1("Toggle_Main_AutoClaimOfflineEarnings") and waitForChild2.Visible then
          task.wait(0.2)
          f35()
        end
      end)
    end
  end)
end

f81()
f82()
f83()
f69()
v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/SellLemon")
v4:SetFolder("Lamduck/SellLemon")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v236.Settings)
v3:BuildInterfaceSection(v236.Settings)
v2:BuildConfigSection(v236.Settings)

v1.OnUnload:Once(function()
  if v23.FloatingTPGui then
    v23.FloatingTPGui:Destroy()
  end

  for key11, value93 in pairs(v24) do
    if typeof(value93) == "RBXScriptConnection" and value93.Connected then
      value93:Disconnect()
    end
  end

  table.clear(v22)
  table.clear(v23)
  table.clear(v24)
  table.clear(v25)
end)

v2:LoadAutoloadConfig()
sellLemonWindow:SelectTab(1)
