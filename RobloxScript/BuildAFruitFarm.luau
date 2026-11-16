local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local localPlayer = players.LocalPlayer
local waitForChild = replicatedStorage:WaitForChild("Remotes", 5)
local v5, v6

pcall(function()
  v5 = require(replicatedStorage:WaitForChild("GameConfig", 5))
  v6 = require(replicatedStorage:WaitForChild("CrateConfig", 5))
  require(replicatedStorage:WaitForChild("PackConfig", 5))
end)

local v7 = {
  IsAutoCollectSnackLoopRunning = false,
  IsAutoDepositLoopRunning = false,
  IsAutoCollectMoneyLoopRunning = false,
  IsAutoUpgradeBlenderLoopRunning = false,
  IsAutoMergeLoopRunning = false,
  IsAutoBuyFruitLoopRunning = false,
  IsAutoPickupCrateLoopRunning = false,
  IsAutoOpenCrateLoopRunning = false,
  IsAutoDiscardCrateLoopRunning = false,
}

local v8 = { Money = 0, AppleValue = 0 }
local v9 = { CrateList = {}, FruitBuyOptions = { "Buy1", "Buy5", "Buy25", "Buy100" } }
local v10 = { PlayerTycoon = nil }
local v11 = {}

local function f1()
  if v10.PlayerTycoon and v10.PlayerTycoon.Parent then
    return v10.PlayerTycoon
  end

  if waitForChild then
    local getMyTycoon = waitForChild:FindFirstChild("GetMyTycoon")

    if getMyTycoon then
      local v12, v13 = pcall(function() return getMyTycoon:InvokeServer() end)

      if v12 and v13 then
        local findFirstChild = workspace:FindFirstChild(v13)

        if findFirstChild then
          v10.PlayerTycoon = findFirstChild
          return findFirstChild
        end
      end
    end
  end

  for index, value in ipairs(workspace:GetChildren()) do
    if value:IsA("Model") or value:IsA("Folder") then
      local ownerUserId = value:GetAttribute("OwnerUserId") or value:GetAttribute("Owner")

      if ownerUserId == localPlayer.UserId or ownerUserId == localPlayer.Name then
        v10.PlayerTycoon = value
        return value
      end
    end
  end

  return nil
end

local function f2()
  local v14, v15 = pcall(function()
    local getMoney = waitForChild and waitForChild:FindFirstChild("GetMoney")

    if getMoney then
      return getMoney:InvokeServer()
    end
  end)

  if v14 and typeof(v15) == "number" then
    v8.Money = v15
    return v15
  end

  local leaderstats = localPlayer:FindFirstChild("leaderstats")
    or localPlayer:FindFirstChild("Leaderstats")

  local money = leaderstats
    and (leaderstats:FindFirstChild("Money") or leaderstats:FindFirstChild("Cash"))

  if money and typeof(money.Value) == "number" then
    v8.Money = money.Value
    return money.Value
  end

  return v8.Money or 0
end

local function f3(p1)
  if not p1 then
    return
  end

  local cframe

  if p1:IsA("BasePart") then
    cframe = p1.CFrame
  elseif p1:IsA("Model") then
    cframe = p1:GetPivot()
  end

  if not cframe then
    return
  end

  local character = localPlayer.Character
  local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart then
    humanoidRootPart.CFrame = cframe

    if typeof(firetouchinterest) == "function" and p1:IsA("BasePart") then
      firetouchinterest(humanoidRootPart, p1, 0)
      task.wait(0.05)
      firetouchinterest(humanoidRootPart, p1, 1)
    end
  end
end

local function f4(p2)
  local v16 = f1()

  if not v16 then
    return nil
  end

  local interactiveButtons = v16:FindFirstChild("InteractiveButtons")

  if not interactiveButtons then
    return nil
  end

  local findFirstChild2 = interactiveButtons:FindFirstChild(p2)

  if not findFirstChild2 then
    return nil
  end

  return findFirstChild2:FindFirstChild("TouchPart")
    or findFirstChild2:IsA("BasePart") and findFirstChild2
    or findFirstChild2:FindFirstChildWhichIsA("BasePart", true) or findFirstChild2
end

local function f5(p3)
  for key, value2 in pairs(p3 or {}) do
    if value2 == true or type(key) == "number" and type(value2) == "string" then
      return true
    end
  end

  return false
end

local function f6(p4, ...)
  local v17 = { ... }

  for key2, value3 in pairs(p4 or {}) do
    if value3 == true or type(key2) == "number" and type(value3) == "string" then
      local v18 = value3 == true and key2 or value3

      for index2, value4 in ipairs(v17) do
        if v18 == value4 then
          return true
        end
      end
    end
  end

  return false
end

local function f7()
  local v19 = {}

  if v6 and v6.ByToolName then
    for key3, value5 in pairs(v6.ByToolName) do
      local displayName = value5.displayName or key3

      if not table.find(v19, displayName) then
        table.insert(v19, displayName)
      end
    end
  end

  if #v19 == 0 then
    warn("[BuildAFruitFarm] No crate names found from CrateConfig, falling back to default crate list")

    v19 = {
      "Common Crate", "Uncommon Crate", "Rare Crate", "Epic Crate", "Legendary Crate",
      "Mythic Crate",
    }
  end

  table.sort(v19)
  return v19
end

local function f8()
  if v7.IsAutoDepositLoopRunning
    or not (v1.Options.Toggle_Farm_AutoDeposit and v1.Options.Toggle_Farm_AutoDeposit.Value) then
    return
  end

  v7.IsAutoDepositLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoDeposit
      and v1.Options.Toggle_Farm_AutoDeposit.Value do
      pcall(function()
        local depositButton = f4("DepositButton")

        if depositButton then
          f3(depositButton)
        end
      end)

      task.wait(2)
    end

    v7.IsAutoDepositLoopRunning = false
  end)
end

local function f9()
  if v7.IsAutoCollectMoneyLoopRunning
    or not (v1.Options.Toggle_Farm_AutoCollectMoney and v1.Options.Toggle_Farm_AutoCollectMoney.Value) then
    return
  end

  v7.IsAutoCollectMoneyLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoCollectMoney
      and v1.Options.Toggle_Farm_AutoCollectMoney.Value do
      pcall(function()
        local collectMoney = f4("CollectMoney") or f4("CollectButton") or f4("Collect")
          or f4("Collector") or f4("MoneyButton")

        if collectMoney then
          f3(collectMoney)
        else
          local v20 = f1()
          local offlineCrate = v20 and v20:FindFirstChild("OfflineCrate")
          local main = offlineCrate and offlineCrate:FindFirstChild("Main")

          if main then
            f3(main)
          end
        end
      end)

      task.wait(2)
    end

    v7.IsAutoCollectMoneyLoopRunning = false
  end)
end

local function f10()
  if v7.IsAutoUpgradeBlenderLoopRunning
    or not (v1.Options.Toggle_Farm_AutoUpgradeBlender
      and v1.Options.Toggle_Farm_AutoUpgradeBlender.Value) then
    return
  end

  v7.IsAutoUpgradeBlenderLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoUpgradeBlender
      and v1.Options.Toggle_Farm_AutoUpgradeBlender.Value do
      pcall(function()
        local upgradeBlender = f4("UpgradeBlender")

        if upgradeBlender then
          f3(upgradeBlender)
        end
      end)

      task.wait(2)
    end

    v7.IsAutoUpgradeBlenderLoopRunning = false
  end)
end

local function f11()
  if v7.IsAutoMergeLoopRunning
    or not (v1.Options.Toggle_Farm_AutoMerge and v1.Options.Toggle_Farm_AutoMerge.Value) then
    return
  end

  v7.IsAutoMergeLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoMerge
      and v1.Options.Toggle_Farm_AutoMerge.Value do
      pcall(function()
        local mergeButton = f4("MergeButton")

        if mergeButton then
          f3(mergeButton)
        end
      end)

      task.wait(2)
    end

    v7.IsAutoMergeLoopRunning = false
  end)
end

local function f12()
  if v7.IsAutoBuyFruitLoopRunning
    or not (v1.Options.Toggle_Farm_AutoBuyFruit and v1.Options.Toggle_Farm_AutoBuyFruit.Value) then
    return
  end

  v7.IsAutoBuyFruitLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoBuyFruit
      and v1.Options.Toggle_Farm_AutoBuyFruit.Value do
      pcall(function()
        local v21 = f4(v1.Options.Dropdown_Farm_SelectFruitBuyOption
            and v1.Options.Dropdown_Farm_SelectFruitBuyOption.Value
          or "Buy1")

        if v21 then
          f3(v21)
        end
      end)

      task.wait(2)
    end

    v7.IsAutoBuyFruitLoopRunning = false
  end)
end

local function f13(p5)
  pcall(function()
    localPlayer:SetAttribute("HasAutoPickup", p5)
    local snackPickupDetector = workspace:FindFirstChild("SnackPickupDetector")

    if snackPickupDetector and snackPickupDetector:IsA("BasePart") then
      snackPickupDetector.Size = p5 and Vector3.new(300, 300, 300) or Vector3.new(10, 10, 10)
    end
  end)
end

local function f14()
  if v7.IsAutoCollectSnackLoopRunning then
    return
  end

  v7.IsAutoCollectSnackLoopRunning = true
  f13(true)

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoCollectSnack
      and v1.Options.Toggle_Farm_AutoCollectSnack.Value do
      f13(true)
      task.wait(2)
    end

    f13(false)
    v7.IsAutoCollectSnackLoopRunning = false
  end)
end

local function f15()
  f13(false)
  v7.IsAutoCollectSnackLoopRunning = false
end

local connect = nil

local function f16(p6)
  pcall(function()
    local cratePickupDetector = workspace:FindFirstChild("CratePickupDetector")

    if cratePickupDetector and cratePickupDetector:IsA("BasePart") then
      cratePickupDetector.Size = p6 and Vector3.new(300, 300, 300) or Vector3.new(6, 6, 6)
    end
  end)
end

local function f17()
  if v7.IsAutoPickupCrateLoopRunning then
    return
  end

  v7.IsAutoPickupCrateLoopRunning = true
  f16(true)
  local pickupCrate = waitForChild and waitForChild:FindFirstChild("PickupCrate")

  if not connect then
    connect = workspace.ChildAdded:Connect(function(child)
      if not (v1.Options.Toggle_Farm_AutoPickupCrate and v1.Options.Toggle_Farm_AutoPickupCrate.Value) then
        return
      end

      pcall(function()
        local toolName = child:GetAttribute("ToolName") or child.Name

        if v6 and v6.ByToolName and v6.ByToolName[toolName] then
          if pickupCrate then
            pickupCrate:FireServer(toolName)
          end

          f3(child)
        end
      end)
    end)

    table.insert(v11, connect)
  end

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoPickupCrate
      and v1.Options.Toggle_Farm_AutoPickupCrate.Value do
      f16(true)

      pcall(function()
        if typeof(_G.RetryPendingCratePickups) == "function" then
          _G.RetryPendingCratePickups()
        end
      end)

      task.wait(2)
    end

    f16(false)
    v7.IsAutoPickupCrateLoopRunning = false
  end)
end

local function f18()
  f16(false)
  v7.IsAutoPickupCrateLoopRunning = false
end

local function f19()
  if v7.IsAutoOpenCrateLoopRunning
    or not (v1.Options.Toggle_Farm_AutoOpenCrate and v1.Options.Toggle_Farm_AutoOpenCrate.Value) then
    return
  end

  v7.IsAutoOpenCrateLoopRunning = true

  task.spawn(function()
    local openCrate = waitForChild and waitForChild:FindFirstChild("OpenCrate")

    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoOpenCrate
      and v1.Options.Toggle_Farm_AutoOpenCrate.Value do
      pcall(function()
        local value6 = v1.Options.Dropdown_Farm_SelectCrateNames
            and v1.Options.Dropdown_Farm_SelectCrateNames.Value
          or {}

        if not f5(value6) then
          return
        end

        local backpack = localPlayer:FindFirstChild("Backpack")
        local character2 = localPlayer.Character
        local v22 = {}

        if character2 then
          for index3, value7 in ipairs(character2:GetChildren()) do
            if value7:IsA("Tool") then
              table.insert(v22, value7)
            end
          end
        end

        if backpack then
          for index4, value8 in ipairs(backpack:GetChildren()) do
            if value8:IsA("Tool") then
              table.insert(v22, value8)
            end
          end
        end

        for index5, value9 in ipairs(v22) do
          if not (v1.Options.Toggle_Farm_AutoOpenCrate and v1.Options.Toggle_Farm_AutoOpenCrate.Value) then
            break
          end

          local name = value9.Name
          local byToolName = v6 and v6.ByToolName and v6.ByToolName[name]

          if f6(value6, byToolName and byToolName.displayName or name, name) then
            if openCrate then
              openCrate:FireServer("unlock", name)
              task.wait(0.5)
            end
          end
        end
      end)

      task.wait(2)
    end

    v7.IsAutoOpenCrateLoopRunning = false
  end)
end

local function f20(p7)
  if v6 and v6.ByToolName then
    local v23 = v6.ByToolName[p7]

    if v23 and v23.priceMultiplier then
      local appleValue = localPlayer:GetAttribute("AppleValue") or 0
      local v24 = 0

      if v5 and typeof(v5.GetBuy1Cost) == "function" then
        v24 = v5.GetBuy1Cost(appleValue)
      end

      return v23.priceMultiplier * v24
    end
  end

  return 0
end

local function f21()
  if v7.IsAutoDiscardCrateLoopRunning
    or not (v1.Options.Toggle_Farm_AutoDiscardCrate and v1.Options.Toggle_Farm_AutoDiscardCrate.Value) then
    return
  end

  v7.IsAutoDiscardCrateLoopRunning = true

  task.spawn(function()
    local openCrate2 = waitForChild and waitForChild:FindFirstChild("OpenCrate")

    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoDiscardCrate
      and v1.Options.Toggle_Farm_AutoDiscardCrate.Value do
      pcall(function()
        local backpack2 = localPlayer:FindFirstChild("Backpack")
        local character3 = localPlayer.Character
        local v25 = {}

        if character3 then
          for index6, value10 in ipairs(character3:GetChildren()) do
            if value10:IsA("Tool") then
              table.insert(v25, value10)
            end
          end
        end

        if backpack2 then
          for index7, value11 in ipairs(backpack2:GetChildren()) do
            if value11:IsA("Tool") then
              table.insert(v25, value11)
            end
          end
        end

        for index8, value12 in ipairs(v25) do
          if not (v1.Options.Toggle_Farm_AutoDiscardCrate
            and v1.Options.Toggle_Farm_AutoDiscardCrate.Value) then
            break
          end

          local name2 = value12.Name

          if v6 and v6.ByToolName and v6.ByToolName[name2] then
            local v26 = f20(name2)
            local v27 = f2()

            if v26 > 0 and v27 < v26 then
              if openCrate2 then
                openCrate2:FireServer("discard", name2)
                task.wait(0.5)
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v7.IsAutoDiscardCrateLoopRunning = false
  end)
end

local function f22(p8)
  local v28 = tonumber(p8) or p8
  local claimOfflineCrate = waitForChild and waitForChild:FindFirstChild("ClaimOfflineCrate")

  if claimOfflineCrate then
    pcall(function() claimOfflineCrate:FireServer(v28) end)
  end
end

local function f23(p9)
  local v29 = tonumber(p9) or p9
  local name3 = "Apple"

  if v5 and v5.Tiers and #v5.Tiers > 0 then
    name3 = v5.Tiers[#v5.Tiers].name or name3
  end

  local collectSnack = waitForChild and waitForChild:FindFirstChild("CollectSnack")

  if collectSnack then
    pcall(function() collectSnack:FireServer(v29, name3) end)
  end
end

v9.CrateList = f7()
local window = v1:CreateWindow({ Title = "Build A Fruit Farm", SubTitle = "by Lamduck" })

local v30 = {
  Farm = window:AddTab({ Title = "Farm", Icon = "sprout" }),
  Hack = window:AddTab({ Title = "Hack", Icon = "terminal" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local addSubTabBar = v30.Farm:AddSubTabBar({ SubTabs = { "Farm", "Crates" }, Default = "Farm" })
local farm = addSubTabBar.Farm
local crates = addSubTabBar.Crates

farm:AddSection("Farm Automation")

farm:AddToggle("Toggle_Farm_AutoCollectSnack", {
  Title = "Auto Collect Fruit Snacks",
  Description = "Collects dropped fruit snacks",
  Default = false,
  Callback = function(value13)
    if value13 then
      f14()
    else
      f15()
    end
  end,
})

farm:AddToggle("Toggle_Farm_AutoDeposit", {
  Title = "Auto Deposit",
  Default = false,
  Callback = function(value14)
    if value14 then
      f8()
    end
  end,
})

farm:AddToggle("Toggle_Farm_AutoCollectMoney", {
  Title = "Auto Collect Money",
  Default = false,
  Callback = function(value15)
    if value15 then
      f9()
    end
  end,
})

farm:AddToggle("Toggle_Farm_AutoUpgradeBlender", {
  Title = "Auto Upgrade Snack / Second",
  Default = false,
  Callback = function(value16)
    if value16 then
      f10()
    end
  end,
})

farm:AddToggle("Toggle_Farm_AutoMerge", {
  Title = "Auto Merge",
  Default = false,
  Callback = function(value17)
    if value17 then
      f11()
    end
  end,
})

farm:AddSection("Buy Fruit Automation")

farm:AddDropdown("Dropdown_Farm_SelectFruitBuyOption", {
  Title = "Select Buy Fruit Option",
  Values = v9.FruitBuyOptions,
  Multi = false,
  Default = "Buy1",
})

farm:AddToggle("Toggle_Farm_AutoBuyFruit", {
  Title = "Auto Buy Fruit",
  Default = false,
  Callback = function(value18)
    if value18 then
      f12()
    end
  end,
})

crates:AddSection("Auto Pickup & Open Crates")

crates:AddToggle("Toggle_Farm_AutoPickupCrate", {
  Title = "Auto Pickup Crates",
  Description = "Automatically collects crate drops on your plot",
  Default = false,
  Callback = function(value19)
    if value19 then
      f17()
    else
      f18()
    end
  end,
})

crates:AddDivider()

crates:AddDropdown("Dropdown_Farm_SelectCrateNames", {
  Title = "Select Crates to Open",
  Values = v9.CrateList,
  Multi = true,
  Searchable = true,
  Default = {},
})

crates:AddToggle("Toggle_Farm_AutoOpenCrate", {
  Title = "Auto Open Selected Crates",
  Default = false,
  Callback = function(value20)
    if value20 then
      f19()
    end
  end,
})

crates:AddToggle("Toggle_Farm_AutoDiscardCrate", {
  Title = "Auto Discard Unaffordable Crates",
  Description = "Automatically discards held crates if you don't have enough money to open them",
  Default = false,
  Callback = function(value21)
    if value21 then
      f21()
    end
  end,
})

v30.Hack:AddSection("HACK FRUIT SNACK")

v30.Hack:AddInput("Input_Hack_ClaimOfflineAmount", {
  Title = "Fruit Snack Amount",
  Default = "1e10",
  Numeric = true,
  Finished = false,
  Placeholder = "Enter amount...",
})

v30.Hack:AddButton({
  Title = "Try method 1",
  Callback = function()
    f22(v1.Options.Input_Hack_ClaimOfflineAmount
      and v1.Options.Input_Hack_ClaimOfflineAmount.Value)
  end,
})

v30.Hack:AddButton({
  Title = "Try method 2",
  Callback = function()
    f23(v1.Options.Input_Hack_ClaimOfflineAmount
      and v1.Options.Input_Hack_ClaimOfflineAmount.Value)
  end,
})

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/BuildAFruitFarm")
v4:SetFolder("Lamduck/BuildAFruitFarm")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v30.Settings)
v3:BuildInterfaceSection(v30.Settings)
v2:BuildConfigSection(v30.Settings)

v1.OnUnload:Once(function()
  for index9, value22 in ipairs(v11) do
    if typeof(value22) == "RBXScriptConnection" and value22.Connected then
      value22:Disconnect()
    end
  end

  table.clear(v11)
end)

v2:LoadAutoloadConfig()
window:SelectTab(1)
