local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local v5, network, v6, v7

pcall(function()
  v5 = require(replicatedStorage:WaitForChild("Paper", 5))

  if v5 then
    if typeof(v5.Stats) == "table" and typeof(v5.Stats.LoadedAsync) == "function" then
      pcall(v5.Stats.LoadedAsync)
    end

    network = v5.Network
  end

  pcall(function()
    v7 = require(replicatedStorage:WaitForChild("Tables", 5):WaitForChild("Luckyblocks", 5))
  end)

  if not v7 then
    pcall(function()
      v7 = require(replicatedStorage:WaitForChild("Folder", 5):WaitForChild("Luckyblocks", 5))
    end)
  end

  pcall(function()
    v6 = require(replicatedStorage:WaitForChild("Modules", 5):WaitForChild("Shared", 5):WaitForChild(
      "Chickens", 5
    ))
  end)

  if not v6 then
    pcall(function()
      v6 = require(replicatedStorage:WaitForChild("Folder", 5):WaitForChild("Folder", 5):WaitForChild(
        "Chickens", 5
      ))
    end)
  end
end)

local v8 = {
  IsAutoCollectEggRunning = false,
  IsAutoCollectCashRunning = false,
  IsAutoDepositEggsRunning = false,
  IsAutoBuyChickenRunning = false,
  IsAutoMergeChickensRunning = false,
  IsAutoUpgradeProcessRunning = false,
  IsAutoUpgradeBuyTierRunning = false,
  IsAutoRebirthRunning = false,
  IsAutoClaimGroupRewardRunning = false,
  IsAutoClaimOfflineEarningsRunning = false,
  IsAutoCollectLuckyBlockRunning = false,
}

local v9 = {}

local function f1(p1)
  for key, value in pairs(p1 or {}) do
    if value == true or type(key) == "number" and type(value) == "string" then
      return true
    end
  end

  return false
end

local function f2(p2, ...)
  local v10 = { ... }

  for key2, value2 in pairs(p2 or {}) do
    if value2 == true or type(key2) == "number" and type(value2) == "string" then
      local v11 = value2 == true and key2 or value2

      for index, value3 in ipairs(v10) do
        if v11 == value3 then
          return true
        end
      end
    end
  end

  return false
end

local function f3()
  if v5 and v5.Stats and typeof(v5.Stats.GetValue) == "function" then
    local cash = v5.Stats.GetValue("Cash")

    if typeof(cash) == "number" then
      return cash
    end
  end

  local leaderstats = localPlayer:FindFirstChild("leaderstats")
    or localPlayer:FindFirstChild("Leaderstats")

  local cash2 = leaderstats
    and (leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Money"))

  if cash2 and typeof(cash2.Value) == "number" then
    return cash2.Value
  end

  local cash3 = localPlayer:GetAttribute("Cash") or localPlayer:GetAttribute("Money")

  if typeof(cash3) == "number" then
    return cash3
  end

  return 0
end

local function f4(p3, ...)
  if network and typeof(network.FireServer) == "function" then
    pcall(network.FireServer, p3, ...)
  else
    pcall(function(...)
      local remotes = replicatedStorage:FindFirstChild("Paper")
        and replicatedStorage.Paper:FindFirstChild("Remotes")

      local remoteevent = remotes and remotes:FindFirstChild("__remoteevent")

      if remoteevent then
        remoteevent:FireServer(p3, ...)
      end
    end, ...)
  end
end

local function f5(p4, ...)
  if network and typeof(network.InvokeServer) == "function" then
    local v12, v13, v14 = pcall(network.InvokeServer, p4, ...)

    if v12 then
      return v13, v14
    end
  else
    local v15, v16, v17 = pcall(function(...)
      local remotes2 = replicatedStorage:FindFirstChild("Paper")
        and replicatedStorage.Paper:FindFirstChild("Remotes")

      local remotefunction = remotes2 and remotes2:FindFirstChild("__remotefunction")

      if remotefunction then
        return remotefunction:InvokeServer(p4, ...)
      end
    end, ...)

    if v15 then
      return v16, v17
    end
  end

  return nil, nil
end

local function f6(p5)
  if not p5 then
    return
  end

  f4("Collect Egg", p5.Name)
  pcall(function() p5:Destroy() end)
end

local function f7()
  local v18 = {}
  local blocks = type(v7) == "table" and v7.Blocks or nil

  if blocks then
    for index2, value4 in ipairs(blocks) do
      if type(value4) == "table" and value4.Name then
        table.insert(v18, value4.Name)
      end
    end
  end

  if #v18 == 0 then
    v18 = {
      "Basic", "Blue", "Red", "Gummy", "Rainbow", "Royal", "Magma", "Angel", "Galaxy", "Hacker",
      "Ice", "Tech", "Nature",
    }
  end

  return v18
end

local function f8()
  if v8.IsAutoCollectEggRunning
    or not (v1.Options.Toggle_Farm_AutoCollectEgg and v1.Options.Toggle_Farm_AutoCollectEgg.Value) then
    return
  end

  v8.IsAutoCollectEggRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoCollectEgg
      and v1.Options.Toggle_Farm_AutoCollectEgg.Value do
      local eggs = workspace:FindFirstChild("Eggs")

      if eggs then
        for index3, value5 in ipairs(eggs:GetChildren()) do
          if not (v1.Options.Toggle_Farm_AutoCollectEgg
            and v1.Options.Toggle_Farm_AutoCollectEgg.Value) then
            break
          end

          if not value5:GetAttribute("LuckyBlock") then
            f6(value5)
          end
        end
      end

      task.wait(3)
    end

    v8.IsAutoCollectEggRunning = false
  end)
end

local function f9()
  if v8.IsAutoCollectCashRunning
    or not (v1.Options.Toggle_Farm_AutoCollectCash and v1.Options.Toggle_Farm_AutoCollectCash.Value) then
    return
  end

  v8.IsAutoCollectCashRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoCollectCash
      and v1.Options.Toggle_Farm_AutoCollectCash.Value do
      f5("Collect Cash")
      task.wait(3)
    end

    v8.IsAutoCollectCashRunning = false
  end)
end

local function f10()
  if v8.IsAutoDepositEggsRunning
    or not (v1.Options.Toggle_Farm_AutoDepositEggs and v1.Options.Toggle_Farm_AutoDepositEggs.Value) then
    return
  end

  v8.IsAutoDepositEggsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoDepositEggs
      and v1.Options.Toggle_Farm_AutoDepositEggs.Value do
      f5("Deposit Eggs")
      task.wait(3)
    end

    v8.IsAutoDepositEggsRunning = false
  end)
end

local function f11()
  if v8.IsAutoBuyChickenRunning
    or not (v1.Options.Toggle_Farm_AutoBuyChickens and v1.Options.Toggle_Farm_AutoBuyChickens.Value) then
    return
  end

  v8.IsAutoBuyChickenRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoBuyChickens
      and v1.Options.Toggle_Farm_AutoBuyChickens.Value do
      f5("Buy Chickens", tonumber(v1.Options.Dropdown_Farm_BuyChickenAmount
          and v1.Options.Dropdown_Farm_BuyChickenAmount.Value)
        or 5)

      task.wait(1)
    end

    v8.IsAutoBuyChickenRunning = false
  end)
end

local function f12()
  if v8.IsAutoMergeChickensRunning
    or not (v1.Options.Toggle_Farm_AutoMergeChickens
      and v1.Options.Toggle_Farm_AutoMergeChickens.Value) then
    return
  end

  v8.IsAutoMergeChickensRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoMergeChickens
      and v1.Options.Toggle_Farm_AutoMergeChickens.Value do
      f5("Merge Chickens")
      task.wait(3)
    end

    v8.IsAutoMergeChickensRunning = false
  end)
end

local function f13()
  if v8.IsAutoUpgradeProcessRunning
    or not (v1.Options.Toggle_Farm_AutoUpgradeProcess
      and v1.Options.Toggle_Farm_AutoUpgradeProcess.Value) then
    return
  end

  v8.IsAutoUpgradeProcessRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoUpgradeProcess
      and v1.Options.Toggle_Farm_AutoUpgradeProcess.Value do
      pcall(function()
        local processingLevel = v5 and v5.Stats and typeof(v5.Stats.GetValue) == "function"
            and v5.Stats.GetValue("ProcessingLevel")
          or 0

        local v19 = v6 and typeof(v6.GetProcessCost) == "function"
            and v6.GetProcessCost(processingLevel)
          or 0

        if v19 <= 0 or f3() >= v19 then
          f5("Upgrade Process Level")
        end
      end)

      task.wait(3)
    end

    v8.IsAutoUpgradeProcessRunning = false
  end)
end

local function f14()
  if v8.IsAutoUpgradeBuyTierRunning
    or not (v1.Options.Toggle_Farm_AutoUpgradeBuyTier
      and v1.Options.Toggle_Farm_AutoUpgradeBuyTier.Value) then
    return
  end

  v8.IsAutoUpgradeBuyTierRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoUpgradeBuyTier
      and v1.Options.Toggle_Farm_AutoUpgradeBuyTier.Value do
      pcall(function()
        local buyTierLevel = v5 and v5.Stats and typeof(v5.Stats.GetValue) == "function"
            and v5.Stats.GetValue("BuyTierLevel")
          or 1

        local v20 = v6 and typeof(v6.GetUpgTierCost) == "function"
            and v6.GetUpgTierCost(buyTierLevel)
          or 0

        if v20 <= 0 or f3() >= v20 then
          f5("Upgrade Buy Tier Level")
        end
      end)

      task.wait(3)
    end

    v8.IsAutoUpgradeBuyTierRunning = false
  end)
end

local function f15()
  if v8.IsAutoRebirthRunning
    or not (v1.Options.Toggle_Farm_AutoRebirth and v1.Options.Toggle_Farm_AutoRebirth.Value) then
    return
  end

  v8.IsAutoRebirthRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoRebirth
      and v1.Options.Toggle_Farm_AutoRebirth.Value do
      pcall(function()
        local rebirth = v5 and v5.Stats and typeof(v5.Stats.GetValue) == "function"
            and v5.Stats.GetValue("Rebirth")
          or 0

        local v21 = v6 and typeof(v6.GetRebirthReq) == "function" and v6.GetRebirthReq(rebirth)
          or 0

        if v21 <= 0 or f3() >= v21 then
          if f5("Rebirth") then
            task.wait(0.5)
            f5("Buy Chickens", 1)
          end
        end
      end)

      task.wait(3)
    end

    v8.IsAutoRebirthRunning = false
  end)
end

local function f16()
  if v8.IsAutoClaimGroupRewardRunning
    or not (v1.Options.Toggle_Reward_AutoClaimGroupReward
      and v1.Options.Toggle_Reward_AutoClaimGroupReward.Value) then
    return
  end

  v8.IsAutoClaimGroupRewardRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimGroupReward
      and v1.Options.Toggle_Reward_AutoClaimGroupReward.Value do
      f5("Claim Group Reward")
      task.wait(60)
    end

    v8.IsAutoClaimGroupRewardRunning = false
  end)
end

local function f17()
  if v8.IsAutoClaimOfflineEarningsRunning
    or not (v1.Options.Toggle_Reward_AutoClaimOfflineEarnings
      and v1.Options.Toggle_Reward_AutoClaimOfflineEarnings.Value) then
    return
  end

  v8.IsAutoClaimOfflineEarningsRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimOfflineEarnings
      and v1.Options.Toggle_Reward_AutoClaimOfflineEarnings.Value do
      f5("Claim Offline Earnings")
      task.wait(60)
    end

    v8.IsAutoClaimOfflineEarningsRunning = false
  end)
end

local function f18(p6)
  if not p6 then
    return false
  end

  if f5("Collect Lucky Block", p6.Name) then
    pcall(function() p6:Destroy() end)
    return true
  end

  return false
end

local function f19()
  local equippedLuckyBlock = v5 and v5.Stats and typeof(v5.Stats.GetValue) == "function"
      and v5.Stats.GetValue("EquippedLuckyBlock")
    or 0

  if equippedLuckyBlock == 0 then
    return false
  end

  local isCurrentLuckyBlockFree = v5 and v5.Stats and typeof(v5.Stats.GetValue) == "function"
    and v5.Stats.GetValue("IsCurrentLuckyBlockFree")

  local totalChickens = v5 and v5.Stats and typeof(v5.Stats.GetValue) == "function"
      and v5.Stats.GetValue("TotalChickens")
    or 0

  local v22 = v6 and typeof(v6.GetLuckyBlockCost) == "function"
      and v6.GetLuckyBlockCost(totalChickens, equippedLuckyBlock)
    or 0

  if isCurrentLuckyBlockFree or f3() >= v22 then
    local v23, v24 = f5("Open Lucky Block")

    if v23 then
      f4("Claim Opened Chicken")
    end

    return true
  elseif v1.Options.Toggle_Event_AutoDiscardIfNotEnoughMoney
    and v1.Options.Toggle_Event_AutoDiscardIfNotEnoughMoney.Value then
    f4("Discard Lucky Block")
    return true
  end

  return false
end

local function f20()
  if v8.IsAutoCollectLuckyBlockRunning
    or not (v1.Options.Toggle_Event_AutoCollectLuckyBlock
      and v1.Options.Toggle_Event_AutoCollectLuckyBlock.Value) then
    return
  end

  v8.IsAutoCollectLuckyBlockRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Event_AutoCollectLuckyBlock
      and v1.Options.Toggle_Event_AutoCollectLuckyBlock.Value do
      pcall(function()
        if (v5 and v5.Stats and typeof(v5.Stats.GetValue) == "function"
              and v5.Stats.GetValue("EquippedLuckyBlock")
            or 0)
          == 0 then
          local value6 = v1.Options.Dropdown_Event_SelectLuckyBlocks
              and v1.Options.Dropdown_Event_SelectLuckyBlocks.Value
            or {}

          local v25 = f1(value6)
          local eggs2 = workspace:FindFirstChild("Eggs")

          if eggs2 then
            for index4, value7 in ipairs(eggs2:GetChildren()) do
              if not (v1.Options.Toggle_Event_AutoCollectLuckyBlock
                and v1.Options.Toggle_Event_AutoCollectLuckyBlock.Value) then
                break
              end

              local luckyBlock = value7:GetAttribute("LuckyBlock")
              local name = value7.Name

              if luckyBlock then
                local blocks2 = v7 and v7.Blocks and v7.Blocks[luckyBlock]
                local name2 = blocks2 and blocks2.Name

                if not v25 or name2 and f2(value6, name2) or f2(value6, name) then
                  if f18(value7) then
                    task.wait(0.2)
                    f19()
                    break
                  end
                end
              end
            end
          end
        else
          f19()
        end
      end)

      task.wait(1)
    end

    v8.IsAutoCollectLuckyBlockRunning = false
  end)
end

local chickenFarmWindow = v1:CreateWindow({ Title = "Chicken Farm", SubTitle = "by Lamduck" })

local v26 = {
  Farm = chickenFarmWindow:AddTab({ Title = "Farm", Icon = "sprout" }),
  Event = chickenFarmWindow:AddTab({ Title = "Event", Icon = "sparkles" }),
  Reward = chickenFarmWindow:AddTab({ Title = "Reward", Icon = "gift" }),
  Settings = chickenFarmWindow:AddTab({ Title = "Settings", Icon = "settings" }),
}

v26.Farm:AddSection("Collect & Deposit")

v26.Farm:AddToggle("Toggle_Farm_AutoCollectEgg", {
  Title = "Auto Collect Egg",
  Default = false,
  Callback = function(value8)
    if value8 then
      f8()
    end
  end,
})

v26.Farm:AddToggle("Toggle_Farm_AutoCollectCash", {
  Title = "Auto Collect Cash",
  Default = false,
  Callback = function(value9)
    if value9 then
      f9()
    end
  end,
})

v26.Farm:AddToggle("Toggle_Farm_AutoDepositEggs", {
  Title = "Auto Deposit Eggs",
  Default = false,
  Callback = function(value10)
    if value10 then
      f10()
    end
  end,
})

v26.Farm:AddSection("Chicken")

v26.Farm:AddDropdown("Dropdown_Farm_BuyChickenAmount", {
  Title = "Buy Chicken Amount",
  Values = { 1, 5, 25, 100 },
  Default = 5,
  Multi = false,
})

v26.Farm:AddToggle("Toggle_Farm_AutoBuyChickens", {
  Title = "Auto Buy Chickens",
  Default = false,
  Callback = function(value11)
    if value11 then
      f11()
    end
  end,
})

v26.Farm:AddToggle("Toggle_Farm_AutoMergeChickens", {
  Title = "Auto Merge Chickens",
  Default = false,
  Callback = function(value12)
    if value12 then
      f12()
    end
  end,
})

v26.Farm:AddSection("Upgrade & Rebirth")

v26.Farm:AddToggle("Toggle_Farm_AutoUpgradeProcess", {
  Title = "Auto Upgrade Process Level",
  Default = false,
  Callback = function(value13)
    if value13 then
      f13()
    end
  end,
})

v26.Farm:AddToggle("Toggle_Farm_AutoUpgradeBuyTier", {
  Title = "Auto Upgrade Buy Tier Level",
  Default = false,
  Callback = function(value14)
    if value14 then
      f14()
    end
  end,
})

v26.Farm:AddToggle("Toggle_Farm_AutoRebirth", {
  Title = "Auto Rebirth",
  Default = false,
  Callback = function(value15)
    if value15 then
      f15()
    end
  end,
})

v26.Event:AddSection("Lucky Block")

v26.Event:AddDropdown("Dropdown_Event_SelectLuckyBlocks", {
  Title = "Select Lucky Blocks",
  Values = f7(),
  Multi = true,
  Searchable = true,
  Default = f7(),
})

v26.Event:AddToggle("Toggle_Event_AutoCollectLuckyBlock", {
  Title = "Auto Collect & Open Lucky Block",
  Default = false,
  Callback = function(value16)
    if value16 then
      f20()
    end
  end,
})

v26.Event:AddToggle("Toggle_Event_AutoDiscardIfNotEnoughMoney", {
  Title = "Discard Block If Not Enough Money",
  Default = false,
})

v26.Reward:AddToggle("Toggle_Reward_AutoClaimGroupReward", {
  Title = "Auto Claim Group Reward",
  Default = false,
  Callback = function(value17)
    if value17 then
      f16()
    end
  end,
})

v26.Reward:AddToggle("Toggle_Reward_AutoClaimOfflineEarnings", {
  Title = "Auto Claim Offline Earnings",
  Default = false,
  Callback = function(value18)
    if value18 then
      f17()
    end
  end,
})

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/ChickenFarm")
v4:SetFolder("Lamduck/ChickenFarm")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v26.Settings)
v3:BuildInterfaceSection(v26.Settings)
v2:BuildConfigSection(v26.Settings)

v1.OnUnload:Once(function()
  for index5, value19 in ipairs(v9) do
    if typeof(value19) == "RBXScriptConnection" and value19.Connected then
      value19:Disconnect()
    end
  end

  table.clear(v9)
end)

v2:LoadAutoloadConfig()
chickenFarmWindow:SelectTab(1)
