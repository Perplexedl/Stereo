local ui = loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/lamduck2005/RobloxScript/master/ui.lua", true
))()

local pickaxeTycoonWindow = ui:CreateWindow({ Title = "Pickaxe Tycoon" })
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer

_G.AutoPickupLoot = false
_G.AutoDepositOres = false
_G.AutoCollectCash = false
_G.AutoUpgradeSystem = false
_G.AutoBuyPickaxes = false
_G.SelectedBuyQuantity = "1"
_G.AutoMerge = false
_G.AutoLootChests = false
_G.TargetLootChests = {}
_G.AutoUnlockChest = false
_G.AutoDiscardChest = false
_G.AutoCollectOfflineIncome = false

local autoLoot = false
local v1 = false
local v2 = false
local v3 = false
local v4 = false
local autoMerge = false
local v5 = false
local v6 = false
local v7 = false
local v8 = false

local v9 = {
  K = 1000,
  M = 1000000,
  B = 1000000000,
  T = 1000000000000,
  QA = 1000000000000000,
  QD = 1000000000000000,
  QI = 1000000000000000000,
  QN = 1000000000000000000,
  SX = 1e+21,
  SP = 1e+24,
  OC = 1e+27,
  O = 1e+27,
  NO = 1e+30,
  N = 1e+30,
  DE = 1e+33,
  D = 1e+33,
  UN = 1e+36,
  UD = 1e+36,
  DD = 1e+39,
  TD = 1e+42,
  QAD = 1e+45,
  QID = 1e+48,
  SXD = 1e+51,
  SPD = 1e+54,
  OCD = 1e+57,
  NOD = 1e+60,
  VG = 1e+63,
}

local function f1(p1)
  if type(p1) == "number" then
    return p1
  end

  if type(p1) ~= "string" or p1 == "" then
    return 0
  end

  local gsub = string.upper(p1):gsub("[^%d%.%a]", "")
  local v10, v11 = string.match(gsub, "^([%d%.]+)(%a*)$")

  if not v10 then
    return 0
  end

  local v12 = 1

  if v11 and v11 ~= "" then
    v12 = v9[v11]

    if not v12 then
      warn("[Lamduck] Unknown money suffix not in dictionary: " .. v11)
      v12 = 1
    end
  end

  return (tonumber(v10) or 0) * v12
end

local function f2()
  local playerGui = localPlayer:FindFirstChild("PlayerGui")

  local cashText = playerGui and playerGui:FindFirstChild("CurrencyGui")
    and playerGui.CurrencyGui:FindFirstChild("Frame")
    and playerGui.CurrencyGui.Frame:FindFirstChild("CashText")

  if cashText then
    local contentText = cashText.ContentText or cashText.Text

    if contentText and contentText ~= "" then
      return f1(contentText)
    end
  end

  return 0
end

local function f3()
  local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
  local chestGui = playerGui2 and playerGui2:FindFirstChild("ChestGui")

  if chestGui and chestGui.Enabled then
    local chestInfo = chestGui:FindFirstChild("ChestInfo")

    if chestInfo and chestInfo.Visible then
      local findFirstChild = chestInfo:FindFirstChild("UnlockMenu", true)
        and chestInfo.UnlockMenu:FindFirstChild("PriceFrame", true)
        and chestInfo.UnlockMenu.PriceFrame:FindFirstChild("ItemPrice", true)

      if findFirstChild then
        local contentText2 = findFirstChild.ContentText or findFirstChild.Text

        if contentText2 and contentText2 ~= "" then
          return f1(contentText2)
        end
      end
    end
  end

  return nil
end

local v13 = nil

local function f4()
  local plots = workspace:FindFirstChild("Plots")

  if not plots then
    return nil
  end

  for index, value in ipairs(plots:GetChildren()) do
    for key, value2 in pairs(value:GetAttributes()) do
      if tostring(value2) == tostring(localPlayer.UserId) then
        return value
      end
    end

    for index2, value3 in ipairs(value:GetDescendants()) do
      for key2, value4 in pairs(value3:GetAttributes()) do
        if tostring(value4) == tostring(localPlayer.UserId) then
          return value
        end
      end
    end
  end

  return nil
end

local function f5(p2)
  if not v13 then
    return nil
  end

  local collectButton

  if p2 == "CollectButton" then
    local sell = v13:FindFirstChild("Sell")
    collectButton = sell and sell:FindFirstChild("CollectButton")
  end

  if not collectButton then
    collectButton = v13:FindFirstChild(p2, true)
  end

  if collectButton then
    if collectButton:IsA("BasePart") then
      return collectButton
    end

    return collectButton:FindFirstChild("Button")
      or collectButton:FindFirstChildWhichIsA("BasePart") or collectButton
  end

  return nil
end

local function f6(p3)
  if p3 and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
    firetouchinterest(localPlayer.Character.HumanoidRootPart, p3, 0)
    task.wait(0.05)
    firetouchinterest(localPlayer.Character.HumanoidRootPart, p3, 1)
  end
end

local function f7()
  local v14 = { Names = {}, Lookup = {} }
  local waitForChild = replicatedStorage:WaitForChild("ChestImages", 5)

  if waitForChild then
    for index3, value5 in ipairs(waitForChild:GetChildren()) do
      local chestNameText = value5:FindFirstChild("ChestNameText")

      if chestNameText
        and (chestNameText:IsA("TextLabel") or chestNameText:IsA("TextButton")
          or chestNameText:IsA("TextBox")) then
        local contentText3 = chestNameText.ContentText or chestNameText.Text

        if contentText3 and contentText3 ~= "" then
          v14.Lookup[value5.Name:lower()] = contentText3
          table.insert(v14.Names, contentText3)
        end
      end
    end
  end

  if #v14.Names == 0 then
    v14.Names = { "Chest1", "Chest2", "Chest3", "Chest4", "Chest5", "Chest6" }

    for index4, value6 in ipairs(v14.Names) do
      v14.Lookup[value6:lower()] = value6
    end
  end

  table.sort(v14.Names)
  return v14
end

local function f8()
  local findFirstChild2 = workspace:FindFirstChild(localPlayer.Name)

  if findFirstChild2 then
    for index5, value7 in ipairs(findFirstChild2:GetChildren()) do
      if string.match(value7.Name:lower(), "chest%d+") then
        if value7:IsA("Folder") or value7:IsA("Model") then
          if #value7:GetChildren() > 0 then
            return true
          end
        elseif value7:IsA("BasePart") then
          return true
        end
      end
    end
  end

  return false
end

local v15 = f7()
local informationTab = pickaxeTycoonWindow:Tab({ Title = "Information", Icon = "info" })
local autoFarmingTab = pickaxeTycoonWindow:Tab({ Title = "Auto Farming", Icon = "zap" })
local autoUpgradeTab = pickaxeTycoonWindow:Tab({ Title = "Auto Upgrade", Icon = "trending-up" })
v13 = f4()

local paragraph = informationTab:Paragraph({
  Title = "Plot Detection Data",
  Desc = string.format([[
Player Name: %s
User ID: %d
Plot Status: %s]], localPlayer.Name, localPlayer.UserId, v13 and v13.Name or "Scanning..."),
})

task.spawn(function()
  while task.wait(2) do
    if not v13 then
      v13 = f4()

      if v13 then
        paragraph:SetDesc(string.format([[
Player Name: %s
User ID: %d
Plot Status: %s]], localPlayer.Name, localPlayer.UserId, v13.Name))
      end
    end
  end
end)

local waitForChild2 = replicatedStorage:WaitForChild("RemoteEvents", 5)

if waitForChild2 then
  waitForChild2 = waitForChild2:WaitForChild("LootPickup", 5)
end

autoFarmingTab:Section({ Title = "FARMING FEATURES" })

local autoLootToggle = autoFarmingTab:Toggle({
  Title = "Auto Loot",
  Desc = "Automatically loot",
  Value = false,
  Callback = function(value8)
    _G.AutoPickupLoot = value8

    if value8 and not autoLoot then
      autoLoot = true

      task.spawn(function()
        while _G.AutoPickupLoot do
          task.wait(0.5)
          local v16 = {}
          local v17 = {}
          local v18 = 1

          for index6, value9 in ipairs(workspace:GetChildren()) do
            if string.find(value9.Name, "Loot") then
              local v19 = tonumber(string.match(value9.Name, "%d+"))

              if v19 then
                v16[v18] = v19
                table.insert(v17, value9)
                v18 = v18 + 1
              end
            end
          end

          if v18 > 1 and waitForChild2 then
            if pcall(function() waitForChild2:FireServer(v16) end) then
              for index7, value10 in ipairs(v17) do
                pcall(function() end)
              end
            end
          end
        end

        autoLoot = false
      end)
    end
  end,
})

local toggle = autoFarmingTab:Toggle({
  Title = "Auto Deposit Ores",
  Desc = "Automatically Deposit Ores",
  Value = false,
  Callback = function(value11)
    _G.AutoDepositOres = value11

    if value11 and not v1 then
      v1 = true

      task.spawn(function()
        while _G.AutoDepositOres do
          task.wait(0.5)
          local depositButton = f5("DepositButton")

          if depositButton then
            f6(depositButton)
          end
        end

        v1 = false
      end)
    end
  end,
})

local toggle2 = autoFarmingTab:Toggle({
  Title = "Auto Collect Cash",
  Desc = "Automatically Collect Cash",
  Value = false,
  Callback = function(value12)
    _G.AutoCollectCash = value12

    if value12 and not v2 then
      v2 = true

      task.spawn(function()
        while _G.AutoCollectCash do
          task.wait(0.5)
          local collectButton2 = f5("CollectButton")

          if collectButton2 then
            f6(collectButton2)
          end
        end

        v2 = false
      end)
    end
  end,
})

local toggle3 = autoFarmingTab:Toggle({
  Title = "Auto Offline Income",
  Desc = "Automatically collects offline income every 10 seconds",
  Value = false,
  Callback = function(value13)
    _G.AutoCollectOfflineIncome = value13

    if value13 and not v8 then
      v8 = true

      task.spawn(function()
        while _G.AutoCollectOfflineIncome do
          local offlineIncome = v13 and v13:FindFirstChild("OfflineIncome")

          if offlineIncome then
            local button = offlineIncome:FindFirstChild("Button")
              or offlineIncome:FindFirstChildWhichIsA("BasePart") or offlineIncome

            if button and (not button:IsA("BasePart") or button.Transparency < 1) then
              f6(button)
            end
          end

          task.wait(10)
        end

        v8 = false
      end)
    end
  end,
})

autoFarmingTab:Section({ Title = "CHEST FEATURES" })

local dropdown = autoFarmingTab:Dropdown({
  Title = "Select Chests to Loot",
  Values = v15.Names,
  Value = { v15.Names[1] or "" },
  Multi = true,
  AllowNone = true,
  Callback = function(value14)
    _G.TargetLootChests = {}

    if type(value14) == "table" then
      for key3, value15 in pairs(value14) do
        _G.TargetLootChests[value15] = true
      end
    elseif value14 and value14 ~= "" then
      _G.TargetLootChests[value14] = true
    end
  end,
})

local toggle4 = autoFarmingTab:Toggle({
  Title = "Auto Loot Chests",
  Desc = "Automatically collects selected chests in your plot",
  Value = false,
  Callback = function(value16)
    _G.AutoLootChests = value16

    if value16 and not v5 then
      v5 = true

      task.spawn(function()
        while _G.AutoLootChests do
          local v20 = false

          repeat
            task.wait(0.1)

            if f8() then
              task.wait(0.4)
              v20 = true
              break
            end

            local lootSpawned = v13 and v13:FindFirstChild("LootSpawned")

            local chestPickup = replicatedStorage:FindFirstChild("RemoteEvents")
              and replicatedStorage.RemoteEvents:FindFirstChild("ChestPickup")

            if lootSpawned and chestPickup then
              for index8, value17 in ipairs(lootSpawned:GetChildren()) do
                if not _G.AutoLootChests then
                  break
                end

                local chestName = v15.Lookup[value17.Name:lower()]
                  or value17:GetAttribute("ChestName") or value17.Name

                if _G.TargetLootChests[chestName] then
                  if pcall(function() chestPickup:FireServer(value17.Name) end) then
                    pcall(function() value17:Destroy() end)
                  end
                end
              end
            end

            v20 = true
          until true

          if not v20 then
            break
          end
        end

        v5 = false
      end)
    end
  end,
})

local toggle5 = autoFarmingTab:Toggle({
  Title = "Auto Unlock Chest",
  Desc = "Automatically unlocks chest if have enough cash",
  Value = false,
  Callback = function(value18)
    _G.AutoUnlockChest = value18

    if value18 and not v6 then
      v6 = true

      task.spawn(function()
        while _G.AutoUnlockChest do
          task.wait(1)
          local v21 = f3()

          if v21 and v21 < f2() then
            local unlockChest = replicatedStorage:FindFirstChild("RemoteEvents")
              and replicatedStorage.RemoteEvents:FindFirstChild("UnlockChest")

            if unlockChest then
              pcall(function() unlockChest:FireServer() end)
            end
          end
        end

        v6 = false
      end)
    end
  end,
})

local toggle6 = autoFarmingTab:Toggle({
  Title = "Auto Discard Chest",
  Desc = "Automatically discards chest if not enough cash",
  Value = false,
  Callback = function(value19)
    _G.AutoDiscardChest = value19

    if value19 and not v7 then
      v7 = true

      task.spawn(function()
        while _G.AutoDiscardChest do
          task.wait(0.5)
          local v22 = f3()

          if v22 and f2() < v22 then
            local discardChest = replicatedStorage:FindFirstChild("RemoteEvents")
              and replicatedStorage.RemoteEvents:FindFirstChild("DiscardChest")

            if discardChest then
              pcall(function() discardChest:FireServer() end)
            end
          end
        end

        v7 = false
      end)
    end
  end,
})

autoUpgradeTab:Section({ Title = "UPGRADES" })

local toggle7 = autoUpgradeTab:Toggle({
  Title = "Auto Upgrade System",
  Desc = "Automatically upgrades ores/sec",
  Value = false,
  Callback = function(value20)
    _G.AutoUpgradeSystem = value20

    if value20 and not v3 then
      v3 = true

      task.spawn(function()
        while _G.AutoUpgradeSystem do
          task.wait(0.5)
          local upgradeButton = f5("UpgradeButton")

          if upgradeButton then
            f6(upgradeButton)
          end
        end

        v3 = false
      end)
    end
  end,
})

autoUpgradeTab:Section({ Title = "PICKAXE UPGRADES" })

local buyQuantityDropdown = autoUpgradeTab:Dropdown({
  Title = "Buy Quantity",
  Values = { "1", "5", "25", "100" },
  Value = "1",
  Callback = function(value21) _G.SelectedBuyQuantity = value21 end,
})

local toggle8 = autoUpgradeTab:Toggle({
  Title = "Auto Buy Pickaxes",
  Desc = "Automatically buys pickaxes of the selected quantity",
  Value = false,
  Callback = function(value22)
    _G.AutoBuyPickaxes = value22

    if value22 and not v4 then
      v4 = true

      task.spawn(function()
        while _G.AutoBuyPickaxes do
          task.wait(0.5)
          local v23 = f5("ButtonBuy" .. tostring(_G.SelectedBuyQuantity))

          if v23 then
            f6(v23)
          end
        end

        v4 = false
      end)
    end
  end,
})

local autoMergeToggle = autoUpgradeTab:Toggle({
  Title = "Auto Merge",
  Desc = "Automatically merges pickaxes",
  Value = false,
  Callback = function(value23)
    _G.AutoMerge = value23

    if value23 and not autoMerge then
      autoMerge = true

      task.spawn(function()
        while _G.AutoMerge do
          task.wait(0.5)
          local buttonMerge = f5("ButtonMerge")

          if buttonMerge then
            f6(buttonMerge)
          end
        end

        autoMerge = false
      end)
    end
  end,
})

local configTab = pickaxeTycoonWindow:Tab({ Title = "Config", Icon = "settings" })

local function f9(p4)
  local v24 = {}

  for key4, value24 in pairs(p4) do
    if value24 then
      table.insert(v24, key4)
    end
  end

  return v24
end

local function f10()
  local v25 = {
    AutoPickupLoot = _G.AutoPickupLoot,
    AutoDepositOres = _G.AutoDepositOres,
    AutoCollectCash = _G.AutoCollectCash,
    AutoCollectOfflineIncome = _G.AutoCollectOfflineIncome,
    AutoLootChests = _G.AutoLootChests,
    AutoUnlockChest = _G.AutoUnlockChest,
    AutoDiscardChest = _G.AutoDiscardChest,
    AutoUpgradeSystem = _G.AutoUpgradeSystem,
    AutoBuyPickaxes = _G.AutoBuyPickaxes,
    AutoMerge = _G.AutoMerge,
    TargetLootChests = f9(_G.TargetLootChests),
    SelectedBuyQuantity = _G.SelectedBuyQuantity,
  }

  if writefile then
    if makefolder then
      pcall(function() makefolder("Lamduck") end)
    end

    local httpService = game:GetService("HttpService")
    pcall(function() writefile("Lamduck/pickage-tycoon.json", httpService:JSONEncode(v25)) end)
  end
end

configTab:Section({ Title = "CONFIGURATION" })

configTab:Button({
  Title = "Save Current Config",
  Callback = function()
    pickaxeTycoonWindow:Dialog({
      Title = "Confirm Save",
      Content = "Are you sure you want to save the current configuration?",
      Buttons = {
        {
          Title = "Confirm",
          Callback = function()
            f10()

            ui:Notify({
              Title = "Success",
              Content = "Configuration saved to device!",
              Duration = 3,
            })
          end,
        },
        { Title = "Cancel" },
      },
    })
  end,
})

configTab:Button({
  Title = "Delete & Reset Config",
  Callback = function()
    pickaxeTycoonWindow:Dialog({
      Title = "Confirm Reset",
      Content = "Are you sure you want to delete all saved configs and reset?",
      Buttons = {
        {
          Title = "Confirm",
          Callback = function()
            if isfile and isfile("Lamduck/pickage-tycoon.json") and delfile then
              delfile("Lamduck/pickage-tycoon.json")
            end

            pcall(function()
              autoLootToggle:Set(false)
              toggle:Set(false)
              toggle2:Set(false)
              toggle3:Set(false)
              toggle4:Set(false)
              toggle5:Set(false)
              toggle6:Set(false)
              toggle7:Set(false)
              toggle8:Set(false)
              autoMergeToggle:Set(false)
            end)

            pcall(function()
              dropdown:Select({})
              buyQuantityDropdown:Select("1")
            end)

            ui:Notify({
              Title = "Success",
              Content = "All previous configs deleted!",
              Duration = 3,
            })
          end,
        },
        { Title = "Cancel" },
      },
    })
  end,
})

local httpService2 = game:GetService("HttpService")

if isfile and isfile("Lamduck/pickage-tycoon.json") then
  local v26, v27 = pcall(function()
    return httpService2:JSONDecode(readfile("Lamduck/pickage-tycoon.json"))
  end)

  if v26 and v27 then
    pcall(function()
      if v27.AutoPickupLoot ~= nil then
        autoLootToggle:Set(v27.AutoPickupLoot)
      end

      if v27.AutoDepositOres ~= nil then
        toggle:Set(v27.AutoDepositOres)
      end

      if v27.AutoCollectCash ~= nil then
        toggle2:Set(v27.AutoCollectCash)
      end

      if v27.AutoCollectOfflineIncome ~= nil then
        toggle3:Set(v27.AutoCollectOfflineIncome)
      end

      if v27.AutoLootChests ~= nil then
        toggle4:Set(v27.AutoLootChests)
      end

      if v27.AutoUnlockChest ~= nil then
        toggle5:Set(v27.AutoUnlockChest)
      end

      if v27.AutoDiscardChest ~= nil then
        toggle6:Set(v27.AutoDiscardChest)
      end

      if v27.AutoUpgradeSystem ~= nil then
        toggle7:Set(v27.AutoUpgradeSystem)
      end

      if v27.AutoBuyPickaxes ~= nil then
        toggle8:Set(v27.AutoBuyPickaxes)
      end

      if v27.AutoMerge ~= nil then
        autoMergeToggle:Set(v27.AutoMerge)
      end

      if v27.TargetLootChests and type(v27.TargetLootChests) == "table" then
        dropdown:Select(v27.TargetLootChests)
      end

      if v27.SelectedBuyQuantity ~= nil then
        buyQuantityDropdown:Select(tostring(v27.SelectedBuyQuantity))
      end
    end)

    ui:Notify({ Title = "Success", Content = "Loaded config successfully!", Duration = 3 })
  end
end
