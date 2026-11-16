local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "mqXjh8zK" / (12638082 - "VNa" ^ 2955355) end) })[2]
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
          pcall(function() return "KJrSWx" / (3044957 - "CrpH8l" ^ 4061820) end),
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
rayVoid:SetScriptName("Roll-A-Gnome")

local window = rayVoid:CreateWindow({
  Name = "Roll-A-Gnome | AKkiwi HUB",
  LoadingTitle = "Roll-A-Gnome Script",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "Roll-A-Gnome" },
})

local autoRollTab = window:CreateTab("AutoRoll", "gamepad-2")
local mutationsTab = window:CreateTab("Mutations", "zap")
local petsTab = window:CreateTab("Pets", "target")
local shopTab = window:CreateTab("Shop", "shopping-cart")
local v12, v13

local function f1()
  v12 = false
  v13 = false
end

local miscTab = window:CreateTab("Misc", "wrench")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local v14, v15

local function f2()
  v14 = false
  v15 = false
end

local v16, v17

local function f3()
  v16 = false
  v17 = false
end

local localPlayer = players.LocalPlayer
local v18 = false
local v19 = false
local v20 = false

local function f4()
  v19 = false
  v20 = false
end

local v21 = false
local v22 = false
v12 = false
local v23

local function f5()
  local data = v23.Data
  local inventory = data and data.inventory or {}
  local total = 0

  for key, value in pairs(inventory) do
    local amount = 1

    if type(value) == "table" then
      amount = value.amount or 1
    end

    total = total + amount
  end

  return total
end

v13 = false
v16 = false
v17 = false
local v24 = 75
local network

local function f6()
  local v25, v26 = pcall(function() return network:InvokeServer("SellAll") end)

  if not v25 then
    warn("[AutoSell] fire failed:", v26)
  end
end

local v27 = false
local v28 = false
v14 = false
v15 = false
local gnomeSelection = {}
local mutationFilter = {}
local petSelection = {}

local function f7()
  local timedShop = v23.Data and v23.Data.timedShop
  return timedShop and timedShop.stock or {}
end

local shopSelection = {}

local function f8()
  v27 = false
  v28 = false
end

local function f9()
  v21 = false
  v22 = false
end

local farmers, v29, itemShop, waitForChild, preview, readyToCollect, pets

task.spawn(function()
  local v30, v31 = pcall(function()
    if not localPlayer.Character then
      localPlayer.CharacterAdded:Wait()
    end

    local v32 = require(replicatedStorage:WaitForChild("Library"))
    network = v32.get("Network")
    farmers = v32.get("Farmers")
    v32.get("Rarities")
    v23 = require(replicatedStorage:WaitForChild("Replication"))
    v29 = require(replicatedStorage.Library.Configs.Pets)
    itemShop = v32.get("ItemShop")
    waitForChild = workspace:WaitForChild("Plots"):WaitForChild("Plot_" .. localPlayer.UserId)
    preview = waitForChild:WaitForChild("RNG"):WaitForChild("Preview")
    readyToCollect = waitForChild:WaitForChild("ReadyToCollect")
    pets = workspace:WaitForChild("PetSpawns"):WaitForChild("Pets")
    v18 = true
  end)

  if not v30 then
    warn("[Init] failed:", v31)
  end
end)

local function f10(p1)
  if next(mutationFilter) == nil then
    return true
  else
    local overhead = p1:FindFirstChild("Overhead")
    local mutations = overhead and overhead:FindFirstChild("Mutations")

    if not mutations then
      return false
    end

    for index, value2 in ipairs(mutations:GetChildren()) do
      if mutationFilter[value2.Name] then
        return true
      end
    end

    return false
  end
end

local function f11()
  local character = localPlayer.Character

  if not character then
    return nil
  end

  return character:FindFirstChildWhichIsA("Humanoid")
end

local f12

local function f13()
  if v22 then
    return
  end

  v22 = true

  task.spawn(function()
    while v21 and v22 do
      if not v18 or not network then
        task.wait(0.5)
      else
        while true do
          if not localPlayer:GetAttribute("Rolling") then
            break
          end

          if not (v21 and v22) then
            break
          end

          task.wait(0.1)
        end

        if not (v21 and v22) then
          break
        else
          local v33, v34 = pcall(function() return network:InvokeServer("Roll") end)

          if not v33 then
            warn("[AutoRoll] fire failed:", v34)
            task.wait(0.5)
          elseif not v34 then
            warn("[AutoRoll] roll rejected by server")
            task.wait(0.5)
          end

          task.wait(0.2)
        end
      end
    end
  end)

  task.spawn(function()
    while v21 and v22 do
      if not v18 or not preview then
        task.wait(0.5)
      else
        local v35, v36 = pcall(function() return preview:GetChildren() end)

        if v35 then
          for index2, value3 in ipairs(v36) do
            if value3:IsA("Model") then
              f12(value3)
            end
          end
        end

        task.wait(0.3)
      end
    end

    v22 = false
  end)
end

function f12(p2)
  if not (p2 and p2.Parent) then
    return
  end

  local proximityPrompt

  if not gnomeSelection[p2:GetAttribute("FarmerName") or p2.Name] then
    return
  elseif not f10(p2) then
    return
  else
    local attachment = p2:FindFirstChild("Attachment")
    proximityPrompt = attachment and attachment:FindFirstChild("ProximityPrompt")

    if not proximityPrompt then
      return
    else
      local v37, v38 = pcall(function() fireproximityprompt(proximityPrompt) end)

      if not v37 then
        warn("[AutoBuy] fireproximityprompt failed:", v38)
      end

      return
    end
  end
end

local function f14(p3)
  if next(mutationFilter) == nil then
    return true
  else
    local overhead2 = p3:FindFirstChild("Overhead")
    local mutations2 = overhead2 and overhead2:FindFirstChild("Mutations")

    if not mutations2 then
      return false
    end

    for index3, value4 in ipairs(mutations2:GetChildren()) do
      if mutationFilter[value4.Name] then
        return true
      end
    end

    return false
  end
end

local walkSpeed, f15

local function f16()
  if v13 then
    return
  end

  v13 = true

  task.spawn(function()
    local v39 = f11()

    if v39 then
      walkSpeed = v39.WalkSpeed
      v39.WalkSpeed = 50
    end

    while v12 and v13 do
      if not v18 or not readyToCollect then
        task.wait(0.5)
      else
        local v40, v41 = pcall(function() return readyToCollect:GetChildren() end)

        if v40 then
          for index4, value5 in ipairs(v41) do
            if not (v12 and v13) then
              break
            elseif value5:IsA("Model") then
              f15(value5)
              task.wait(0.3)
            end
          end
        end

        task.wait(0.3)
      end
    end

    local v42 = f11()

    if v42 and walkSpeed then
      v42.WalkSpeed = walkSpeed
    end

    v13 = false
  end)
end

function f15(p4)
  local v43 = f11()

  if not v43 then
    return false
  end

  local v44

  if not (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")) then
    return false
  else
    local primaryPart = p4.PrimaryPart or p4:FindFirstChildWhichIsA("BasePart")

    if not primaryPart then
      return false
    else
      v43:MoveTo(primaryPart.Position)
      v44 = false
      local connect = v43.MoveToFinished:Connect(function(p5) v44 = true end)
      local v45 = os.clock()

      while not v44 and os.clock() - v45 < 5 do
        if not (v12 and v13) then
          break
        end

        task.wait(0.1)
      end

      if connect then
        connect:Disconnect()
      end

      return true
    end
  end
end

local function f17()
  if v17 then
    return
  end

  v17 = true

  task.spawn(function()
    local v46 = os.clock()

    while v16 and v17 do
      if not v18 or not network then
        task.wait(0.5)
      else
        local v47, v48 = pcall(f5)

        if os.clock() - v46 >= 20 or v47 and v48 >= v24 then
          f6()
          v46 = os.clock()
        end

        task.wait(1)
      end
    end

    v17 = false
  end)
end

local f18

local function f19()
  if v28 then
    return
  end

  v28 = true

  task.spawn(function()
    while v27 and v28 do
      if not v18 or not pets then
        task.wait(0.5)
      else
        local v49, v50 = pcall(function() return pets:GetChildren() end)

        if v49 then
          for index5, value6 in ipairs(v50) do
            if not (v27 and v28) then
              break
            elseif value6:IsA("Model") then
              f18(value6)
            end
          end
        end

        task.wait(1)
      end
    end

    v28 = false
  end)
end

function f18(p6)
  local overhead3 = p6:FindFirstChild("Overhead")
  local petName = overhead3 and overhead3:FindFirstChild("PetName")
  local text = petName and petName.Text
  local humanoidRootPart, humanoidRootPart2

  if not text or not petSelection[text] then
    return
  elseif not f14(p6) then
    return
  else
    humanoidRootPart = p6:FindFirstChild("HumanoidRootPart")
    local buyPetPrompt = humanoidRootPart and humanoidRootPart:FindFirstChild("BuyPetPrompt")

    if not (humanoidRootPart and buyPetPrompt) then
      return
    else
      local character2 = localPlayer.Character
      humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart2 then
        return
      else
        local cframe = humanoidRootPart2.CFrame

        local v51, v52 = pcall(function()
          humanoidRootPart2.CFrame = humanoidRootPart.CFrame
          task.wait(0.5)
          fireproximityprompt(buyPetPrompt)
          task.wait(0.2)
        end)

        if not v51 then
          warn("[AutoPet] fire failed:", v52)
        end

        local character3 = localPlayer.Character
        local humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart3 then
          humanoidRootPart3.CFrame = cframe
        end

        return
      end
    end
  end
end

local function f20(p7)
  local v53 = f7()

  if not (v53[p7] and v53[p7] > 0) then
    return
  else
    local v54, v55 = pcall(function() network:InvokeServer("Purchase", p7) end)

    if not v54 then
      warn("[AutoShop] fire failed:", v55)
    end

    return
  end
end

local function f21()
  if v15 then
    return
  end

  v15 = true

  task.spawn(function()
    while v14 and v15 do
      if not v18 or not network then
        task.wait(0.5)
      else
        for key2 in pairs(shopSelection) do
          if not (v14 and v15) then
            break
          end

          f20(key2)
          task.wait(0.2)
        end

        task.wait(1)
      end
    end

    v15 = false
  end)
end

local f22

local function f23()
  if v20 then
    return
  end

  v20 = true

  task.spawn(function()
    while v19 and v20 do
      local v56, v57 = pcall(f22)

      if not v56 then
        warn("[AntiAfk] mousemoverel failed:", v57)
      end

      task.wait(60)
    end

    v20 = false
  end)
end

function f22()
  mousemoverel(1, 0)
  mousemoverel(-1, 0)
end

autoRollTab:CreateToggle({
  Name = "Auto Roll + Buy",
  CurrentValue = false,
  Flag = "AutoRollToggle",
  Callback = function(value7)
    v21 = value7

    if value7 then
      f13()
    else
      f9()
    end
  end,
})

autoRollTab:CreateButton({
  Name = "Fast Roll",
  Callback = function() localPlayer:SetAttribute("RollSpeed", 3) end,
})

miscTab:CreateToggle({
  Name = "Auto Collect Plants",
  CurrentValue = false,
  Flag = "AutoCollectToggle",
  Callback = function(value8)
    v12 = value8

    if value8 then
      f16()
    else
      f1()
    end
  end,
})

miscTab:CreateToggle({
  Name = "Auto Sell",
  CurrentValue = false,
  Flag = "AutoSellToggle",
  Callback = function(value9)
    v16 = value9

    if value9 then
      f17()
    else
      f3()
    end
  end,
})

miscTab:CreateToggle({
  Name = "Anti-AFK",
  CurrentValue = false,
  Flag = "AntiAfkToggle",
  Callback = function(value10)
    v19 = value10

    if value10 then
      f23()
    else
      f4()
    end
  end,
})

miscTab:CreateInput({
  Name = "Inventory Threshold (sells when reached)",
  PlaceholderText = "75",
  CurrentValue = "75",
  RemoveTextAfterFocusLost = false,
  Flag = "SellThresholdInput",
  Callback = function(value11)
    local v58 = tonumber(value11)

    if v58 and v58 >= 1 then
      v24 = math.floor(v58)
    else
      warn("[AutoSell] invalid value, threshold unchanged:", v24)
    end
  end,
})

mutationsTab:CreateMultiToggle({
  Label = "Mutation Filter (empty = all)",
  Options = {
    "Golden", "Diamond", "Shiny", "Charged", "Solar", "Frozen", "Toxic", "Cursed", "Night",
    "Aurora", "Disco", "Rave", "Fiesta",
  },
  Flag = "MutationFilter",
  Callback = function(value12) mutationFilter = value12 end,
})

task.spawn(function()
  while not v18 do
    task.wait(0.2)
  end

  local v59 = {}
  local v60 = {}

  for key3, value13 in pairs(farmers) do
    local v61 = tostring(value13.real_rarity or "Unknown")

    if not v59[v61] then
      v59[v61] = {}
      table.insert(v60, v61)
    end
  end

  local v62 = {
    Common = 1,
    Uncommon = 2,
    Rare = 3,
    Epic = 4,
    Legendary = 5,
    Mythic = 6,
    Godly = 7,
    IMPOSSIBLE = 8,
  }

  table.sort(v60, function(p8, p9)
    local v63 = v62[p9]
    local v64 = v62[p8]

    if v64 and v63 then
      return v64 < v63
    elseif v64 then
      return true
    else
      if v63 then
        return false
      end

      return p8 < p9
    end
  end)

  local v65 = {}

  for index6, value14 in ipairs(v60) do
    table.insert(v65, { Label = value14, Items = v59[value14] })
  end

  if #v65 == 0 then
    return
  end

  autoRollTab:CreateFilteredCardGrid({
    Groups = v65,
    Columns = 3,
    Flag = "GnomeSelection",
    Callback = function(value15)
      local v66 = {}

      for key4, value16 in pairs(farmers) do
        if value15[value16.DisplayName or key4] then
          v66[key4] = true
        end
      end

      gnomeSelection = v66
    end,
  })
end)

petsTab:CreateToggle({
  Name = "Auto Pet (teleport + buy)",
  CurrentValue = false,
  Flag = "AutoPetToggle",
  Callback = function(value17)
    v27 = value17

    if value17 then
      f19()
    else
      f8()
    end
  end,
})

task.spawn(function()
  while not v18 do
    task.wait(0.2)
  end

  local v67 = {}
  local v68 = {}

  for key5, value18 in pairs(v29) do
    local v69 = tostring(value18.rarity or "Unknown")

    if not v67[v69] then
      v67[v69] = {}
      table.insert(v68, v69)
    end
  end

  local v70 = {
    Common = 1,
    Uncommon = 2,
    Rare = 3,
    Epic = 4,
    Legendary = 5,
    Mythic = 6,
    Godly = 7,
    IMPOSSIBLE = 8,
  }

  table.sort(v68, function(p10, p11)
    local v71 = v70[p11]
    local v72 = v70[p10]

    if v72 and v71 then
      return v72 < v71
    elseif v72 then
      return true
    else
      if v71 then
        return false
      end

      return p10 < p11
    end
  end)

  local v73 = {}

  for index7, value19 in ipairs(v68) do
    table.insert(v73, { Label = value19, Items = v67[value19] })
  end

  if #v73 == 0 then
    return
  end

  petsTab:CreateFilteredCardGrid({
    Groups = v73,
    Columns = 3,
    Flag = "PetSelection",
    Callback = function(value20) petSelection = value20 end,
  })
end)

shopTab:CreateToggle({
  Name = "Auto Shop",
  CurrentValue = false,
  Flag = "AutoShopToggle",
  Callback = function(value21)
    v14 = value21

    if value21 then
      f21()
    else
      f2()
    end
  end,
})

task.spawn(function()
  while not v18 do
    task.wait(0.2)
  end

  local function f24(p12)
    local v74, v75 = pcall(function()
      local findFirstChild = localPlayer.PlayerGui.Tabs.ItemShop.Menu.Frame.List:FindFirstChild(p12)

      if not findFirstChild then
        return ""
      else
        local icon = findFirstChild.Frame.Clipped:FindFirstChild("Icon")
        return icon and icon.Image or ""
      end
    end)

    return v74 and v75 or ""
  end

  local v76 = {}

  for key6, value22 in pairs(itemShop.Items) do
    table.insert(v76, { name = value22.name or key6, price = value22.price or 0 })
  end

  table.sort(v76, function(p13, p14) return p13.price < p14.price end)
  local v77 = {}

  for index8, value23 in ipairs(v76) do
    table.insert(v77, { Name = value23.name, Icon = f24(value23.name) })
  end

  if #v77 == 0 then
    return
  end

  shopTab:CreateCardGrid({
    Items = v77,
    Columns = 3,
    Flag = "ShopSelection",
    Callback = function(value24) shopSelection = value24 end,
  })
end)
