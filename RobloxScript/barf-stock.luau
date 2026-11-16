local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local httpService = game:GetService("HttpService")
local localPlayer = game.Players.LocalPlayer

local v5 = {
  Data = { GearItems = {}, EggItems = {}, BeeMerchantItems = {} },
  Cache = {
    LastGearKey = "",
    LastEggKey = "",
    LastBeeMerchantKey = "",
    GearCooldown = 0,
    EggCooldown = 0,
    BeeMerchantCooldown = 0,
  },
}

local function f1()
  local v6, v7 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("Registry", 5):WaitForChild(
      "Gear", 5
    ))
  end)

  if v6 and type(v7) == "table" and type(v7[2]) == "table" then
    for key, value in pairs(v7[2]) do
      v5.Data.GearItems[key] = {
        Cost = value.Cost,
        MaxStock = value.MaxStock,
        DisplayName = value.DisplayName,
        Chance = value.Chance,
      }
    end
  end
end

local function f2()
  local v8, v9 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild("EggConfig", 5))
  end)

  if v8 and type(v9) == "table" and v9.Prices then
    for key2, value2 in pairs(v9.Prices) do
      v5.Data.EggItems[key2] = {
        Price = tonumber(value2) or 0,
        RestockChance = v9.RestockChances and v9.RestockChances[key2] or 0,
      }
    end
  end
end

local function f3()
  local v10, v11 = pcall(function()
    return require(replicatedStorage:WaitForChild("Shared", 5):WaitForChild(
      "BeeHiveEventConfig", 5
    ))
  end)

  if v10 and type(v11) == "table" and v11.Merchant and v11.Merchant.Items then
    for index, value3 in ipairs(v11.Merchant.Items) do
      v5.Data.BeeMerchantItems[value3.Id] = {
        DisplayName = value3.DisplayName or value3.Id,
        HoneyCost = value3.HoneyCost or 0,
        Stock = value3.Stock or 0,
      }
    end
  end
end

local v12 = { "", "K", "M", "B", "T", "QA", "QI", "SX", "SP", "OC", "NO", "DE" }

local function f4(p1)
  if not p1 or p1 == 0 then
    return "?"
  end

  local v13 = math.floor(math.log10(math.abs(p1)) / 3)

  if v13 < 1 then
    return "$" .. tostring(math.floor(p1))
  end

  local v14 = v12[math.min(v13 + 1, #v12)] or "??"
  local v15 = p1 / 10 ^ (v13 * 3)
  local v16 = v15 == math.floor(v15) and "$%.0f%s" or "$%.2f%s"
  return string.format(v16, v15, v14)
end

local v17 = tonumber("57F287", 16)

local function f5(p2)
  return {
    {
      color = p2.color or v17,
      title = p2.title,
      description = p2.description,
      footer = { text = "BARF Monitor | " .. os.date("%H:%M:%S") },
      timestamp = DateTime.now():ToIsoDate(),
    },
  }
end

local function f6(p3, embeds)
  if not p3 or p3 == "" then
    return false
  end

  local jsonEncode = httpService:JSONEncode({ embeds = embeds })
  local headers = { ["Content-Type"] = "application/json" }
  local v18 = syn and syn.request or http_request or request

  if v18 then
    if pcall(v18, {
      Url = p3,
      Method = "POST",
      Headers = headers,
      Body = jsonEncode,
    }) then
      return true
    end
  end

  return (pcall(httpService.PostAsync, httpService, p3, jsonEncode, "application/json", false))
end

local v19 = nil

pcall(function()
  v19 = require(replicatedStorage:WaitForChild("Packages", 5):WaitForChild("DataReplicator", 5)).GetReplicator()
end)

local function f7()
  local findFirstChild = replicatedStorage:FindFirstChild("GearStocks")
    and replicatedStorage.GearStocks:FindFirstChild(localPlayer.Name)

  if not findFirstChild then
    return {
      title = "Gear Restock!",
      color = v17,
      description = "No gear data",
      _plain = "No gear data",
    }
  end

  local v20 = {}
  local v21 = {}

  for key3, value4 in pairs(v5.Data.GearItems) do
    local findFirstChild2 = findFirstChild:FindFirstChild(key3)
    local value5 = findFirstChild2 and findFirstChild2.Value or 0

    if value5 > 0 then
      local displayName = value4.DisplayName or key3
      local v22 = f4(value4.Cost)

      table.insert(v20, string.format("` %sx ` **%s** — %s", value5, displayName, v22))
      table.insert(v21, string.format("%dx %s (%s)", value5, displayName, v22))
    end
  end

  table.sort(v20)
  table.sort(v21)

  return {
    title = "Gear Restock!",
    color = v17,
    description = #v20 > 0 and table.concat(v20, "\n") or "No gear in stock",
    _plain = #v21 > 0 and table.concat(v21, "\n") or "No gear in stock",
  }
end

local function f8()
  local petMerchant = workspace:FindFirstChild("PetMerchant")

  if not petMerchant then
    return {
      title = "Egg Restock!",
      color = v17,
      description = "No egg shop found",
      _plain = "No egg shop found",
    }
  end

  local v23 = {}
  local v24 = {}

  for i = 1, 5 do
    local findFirstChild3 = petMerchant:FindFirstChild("Podium" .. i .. "Stock")
      or petMerchant:FindFirstChild("Podium" .. i)

    if findFirstChild3 then
      local findFirstChild4 = findFirstChild3:FindFirstChild("EggLabel", true)

      if findFirstChild4 and findFirstChild4.Text and findFirstChild4.Text ~= "" then
        local text = findFirstChild4.Text
        local v25 = text

        for key4 in pairs(v5.Data.EggItems) do
          local v26 = string.gsub(string.lower(text), " ", "")
          local v27 = string.gsub(string.lower(key4), " ", "")

          if string.find(v26, v27, 1, true) then
            v25 = key4
            break
          end
        end

        local v28 = f4(v5.Data.EggItems[v25] and v5.Data.EggItems[v25].Price or 0)

        table.insert(v23, string.format("` Slot %d ` **%s** — %s", i, v25, v28))
        table.insert(v24, string.format("Slot %d: %s (%s)", i, v25, v28))
      end
    end
  end

  return {
    title = "Egg Restock!",
    color = v17,
    description = #v23 > 0 and table.concat(v23, "\n") or "No eggs available",
    _plain = #v24 > 0 and table.concat(v24, "\n") or "No eggs available",
  }
end

local function f9()
  local getSnapshot = v19 and v19:GetSnapshot()

  local merchantStock = getSnapshot and getSnapshot.BeeHiveEvent
      and getSnapshot.BeeHiveEvent.MerchantStock
    or {}

  local v29 = {}
  local v30 = {}

  for key5, value6 in pairs(v5.Data.BeeMerchantItems) do
    local stock = merchantStock[key5]

    if stock == nil then
      stock = value6.Stock
    end

    if stock > 0 then
      local displayName2 = value6.DisplayName or key5
      local honeyCost = value6.HoneyCost

      local v31 = honeyCost >= 1000 and string.format("%.0fK", honeyCost / 1000)
        or tostring(honeyCost)

      table.insert(v29, string.format("` %sx ` **%s** — 🍯 %s", stock, displayName2, v31))
      table.insert(v30, string.format("%dx %s (🍯 %s)", stock, displayName2, v31))
    end
  end

  table.sort(v29)
  table.sort(v30)

  return {
    title = "Bee Merchant Restock!",
    color = v17,
    description = #v29 > 0 and table.concat(v29, "\n") or "No bee merchant items in stock",
    _plain = #v30 > 0 and table.concat(v30, "\n") or "No bee merchant items in stock",
  }
end

local barfStockWindow = v1:Window({
  Title = "BARF Stock",
  SubTitle = "[Lamduck]",
  TabWidth = 140,
  Size = UDim2.fromOffset(580, 400),
  Acrylic = false,
  Transparency = false,
  Theme = "Vynixu",
  MinimizeKey = Enum.KeyCode.RightControl,
  MinimizeButton = true,
  MinimizeButtonIcon = "bone",
})

local v32 = {
  Gear = barfStockWindow:Tab({ Title = "Gear Watch", Icon = "shopping-cart" }),
  Egg = barfStockWindow:Tab({ Title = "Egg Watch", Icon = "egg" }),
  BeeMerchant = barfStockWindow:Tab({ Title = "Bee Merchant", Icon = "hexagon" }),
  Settings = barfStockWindow:Tab({ Title = "Settings", Icon = "settings" }),
}

local function f10(p4)
  local v33 = f7()
  local value7 = v1.Options.GearWebhookURL.Value

  if value7 ~= "" then
    f6(value7, f5(v33))
  end

  if p4 then
    v1:Notify({ Title = "Gear", Content = "Snapshot sent!", Duration = 5 })
  end
end

local function f11(p5)
  local v34 = f8()
  local value8 = v1.Options.EggWebhookURL.Value

  if value8 ~= "" then
    f6(value8, f5(v34))
  end

  if p5 then
    v1:Notify({ Title = "Egg", Content = "Snapshot sent!", Duration = 5 })
  end
end

local function f12(p6)
  local v35 = f9()
  local value9 = v1.Options.BeeMerchantWebhookURL.Value

  if value9 ~= "" then
    f6(value9, f5(v35))
  end

  if p6 then
    v1:Notify({ Title = "Bee Merchant", Content = "Snapshot sent!", Duration = 5 })
  end
end

v32.Gear:Input("GearWebhookURL", {
  Title = "Gear Webhook URL",
  Placeholder = "https://discord.com/api/webhooks/...",
  Default = "",
})

v32.Gear:Toggle("EnableGearWatch", { Title = "Enable Gear Watch", Default = true })

v32.Gear:Button({
  Title = "Send Current Gear Stock",
  Callback = function()
    if v1.Options.GearWebhookURL.Value == "" then
      v1:Notify({ Title = "Error", Content = "No gear webhook URL set", Duration = 5 })
      return
    end

    f10(true)
  end,
})

v32.Gear:Paragraph("GearLog", { Title = "Gear Status", Content = "Waiting for gear data..." })

v32.Egg:Input("EggWebhookURL", {
  Title = "Egg Webhook URL",
  Placeholder = "https://discord.com/api/webhooks/...",
  Default = "",
})

v32.Egg:Toggle("EnableEggWatch", { Title = "Enable Egg Watch", Default = true })

v32.Egg:Button({
  Title = "Send Current Egg Stock",
  Callback = function()
    if v1.Options.EggWebhookURL.Value == "" then
      v1:Notify({ Title = "Error", Content = "No egg webhook URL set", Duration = 5 })
      return
    end

    f11(true)
  end,
})

v32.Egg:Paragraph("EggLog", { Title = "Egg Status", Content = "Waiting for egg data..." })

v32.BeeMerchant:Input("BeeMerchantWebhookURL", {
  Title = "Bee Merchant Webhook URL",
  Placeholder = "https://discord.com/api/webhooks/...",
  Default = "",
})

v32.BeeMerchant:Toggle("EnableBeeMerchantWatch", {
  Title = "Enable Bee Merchant Watch",
  Default = true,
})

v32.BeeMerchant:Button({
  Title = "Send Current Bee Merchant Stock",
  Callback = function()
    if v1.Options.BeeMerchantWebhookURL.Value == "" then
      v1:Notify({ Title = "Error", Content = "No bee merchant webhook URL set", Duration = 5 })
      return
    end

    f12(true)
  end,
})

v32.BeeMerchant:Paragraph("BeeMerchantLog", {
  Title = "Bee Merchant Status",
  Content = "Waiting for bee merchant data...",
})

v2:SetLibrary(v1)
v2:BuildConfigSection(v32.Settings)

local function f13(p7)
  local v36 = string.format([[
Gear Restock (%s)
%s]], os.date("%H:%M:%S"), p7._plain)

  local nextRestockTime = replicatedStorage:FindFirstChild("GearStocks")
    and replicatedStorage.GearStocks:FindFirstChild(localPlayer.Name)
    and replicatedStorage.GearStocks[localPlayer.Name]:FindFirstChild("NextRestockTime")

  if nextRestockTime and nextRestockTime.Value > 0 then
    local v37 = math.max(0, nextRestockTime.Value - workspace:GetServerTimeNow())
    local v38 = math.floor(v37 / 60)
    local v39 = math.floor(v37 % 60)
    v36 = v36 .. string.format("\nNext Restock In: %dm %ds", v38, v39)
  end

  v1.Options.GearLog:SetValue(v36)
end

local function f14(p8)
  local getServerTimeNow = workspace:GetServerTimeNow()
  local v40 = math.max(0, getServerTimeNow - getServerTimeNow % 300 + 300 - getServerTimeNow)
  local v41 = math.floor(v40 / 60)
  local v42 = math.floor(v40 % 60)

  local v43 = string.format([[
Egg Restock (%s)
%s
Next Restock In: %dm %ds]], os.date("%H:%M:%S"), p8._plain, v41, v42)

  v1.Options.EggLog:SetValue(v43)
end

local function f15(p9)
  local v44 = string.format([[
Bee Merchant Restock (%s)
%s]], os.date("%H:%M:%S"), p9._plain)

  if next(v5.Data.BeeMerchantItems) ~= nil then
    local getServerTimeNow2 = workspace:GetServerTimeNow()

    local v45 = math.max(
      0, getServerTimeNow2 - getServerTimeNow2 % 3600 + 3600 - getServerTimeNow2
    )

    local v46 = math.floor(v45 / 60)
    local v47 = math.floor(v45 % 60)
    v44 = v44 .. string.format("\nNext Restock In: %dm %ds", v46, v47)
  end

  v1.Options.BeeMerchantLog:SetValue(v44)
end

local function f16(p10)
  return p10._plain
end

local function f17()
  if not v1.Options.EnableGearWatch.Value then
    return
  end

  if next(v5.Data.GearItems) == nil then
    return
  end

  local v48 = os.clock()

  if v48 - v5.Cache.GearCooldown < 3 then
    return
  end

  v5.Cache.GearCooldown = v48
  local v49 = f7()
  local v50 = f16(v49)

  if v50 == v5.Cache.LastGearKey then
    return
  end

  v5.Cache.LastGearKey = v50
  f10(false)
  f13(v49)
end

local function f18()
  if not v1.Options.EnableEggWatch.Value then
    return
  end

  if next(v5.Data.EggItems) == nil then
    return
  end

  local v51 = os.clock()

  if v51 - v5.Cache.EggCooldown < 3 then
    return
  end

  v5.Cache.EggCooldown = v51
  local v52 = f8()
  local v53 = f16(v52)

  if v53 == v5.Cache.LastEggKey then
    return
  end

  v5.Cache.LastEggKey = v53
  f11(false)
  f14(v52)
end

local function f19()
  if not v1.Options.EnableBeeMerchantWatch.Value then
    return
  end

  if next(v5.Data.BeeMerchantItems) == nil then
    return
  end

  local v54 = os.clock()

  if v54 - v5.Cache.BeeMerchantCooldown < 3 then
    return
  end

  v5.Cache.BeeMerchantCooldown = v54
  local v55 = f9()
  local v56 = f16(v55)

  if v56 == v5.Cache.LastBeeMerchantKey then
    return
  end

  v5.Cache.LastBeeMerchantKey = v56
  f12(false)
  f15(v55)
end

local function f20()
  local findFirstChild5 = replicatedStorage:FindFirstChild("GearStocks")
    and replicatedStorage.GearStocks:FindFirstChild(localPlayer.Name)

  if not findFirstChild5 then
    task.wait(5)
    f20()
    return
  end

  v5.Cache.LastGearKey = f16(f7())

  findFirstChild5.ChildAdded:Connect(function(child)
    task.wait(1)
    f17()

    if child:IsA("IntValue") then
      child:GetPropertyChangedSignal("Value"):Connect(function()
        task.wait(0.5)
        f17()
      end)
    end
  end)

  findFirstChild5.ChildRemoved:Connect(function()
    task.wait(1)
    f17()
  end)

  for index2, value10 in ipairs(findFirstChild5:GetChildren()) do
    if value10:IsA("IntValue") then
      value10:GetPropertyChangedSignal("Value"):Connect(function()
        task.wait(0.5)
        f17()
      end)
    end
  end
end

task.spawn(f20)

task.spawn(function()
  while true do
    task.wait(3)
    f18()
  end
end)

task.spawn(function()
  while true do
    task.wait(5)
    f19()
  end
end)

task.spawn(function()
  if not game:IsLoaded() then
    game.Loaded:Wait()
  end

  f1()
  f2()
  f3()
  local v57 = f7()
  v5.Cache.LastGearKey = f16(v57)
  f13(v57)
  local v58 = f8()
  v5.Cache.LastEggKey = f16(v58)
  f14(v58)
  local v59 = f9()
  v5.Cache.LastBeeMerchantKey = f16(v59)
  f15(v59)
end)

barfStockWindow:SelectTab(1)
v2:LoadAutoloadConfig()
