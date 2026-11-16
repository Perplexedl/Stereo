local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "Yuqk7A7X" / (9329437 - "o2wvyBy0bzBivM" ^ 13356952) end) })[2]
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
        tonumber(gmatch(
          tostring(({ pcall(function() return "Ws" / (16699902 - "4k" ^ 195078) end) })[2]),
          ":(%d*):"
        )())
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

local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = game:GetService("Players").LocalPlayer

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:SetScriptName("Bomb Fishing Script")
rayVoid:ShowCredit()

local autoTab = rayVoid:CreateWindow({
  Name = "Bomb Fishing Script",
  LoadingTitle = "Bomb Fishing Script",
  LoadingSubtitle = "by AKkiwi",
  Theme = "Default",
  ConfigurationSaving = { Enabled = true, FileName = "BombAutoFarm" },
}):CreateTab(
  "Auto", 0
)

local v12 = require(replicatedStorage.src.Modules.KnitClient)
local v13 = require(replicatedStorage.Config)
local bombService = v12.GetService("BombService")
local playerController = v12.GetController("PlayerController")
local baseController = v12.GetController("BaseController")
local baseService = v12.GetService("BaseService")
local eventService = v12.GetService("EventService")
local eventController = v12.GetController("EventController")
local dataController = v12.GetController("DataController")
local bombShopController = v12.GetController("BombShopController")
local bombShopService = v12.GetService("BombShopService")
local rebirthService = v12.GetService("RebirthService")

local function f1()
  local v14, v15 = pcall(function()
    return playerController:getClass("player", localPlayer, true)
  end)

  if v14 and v15 and v15.CharacterClass then
    return v15.CharacterClass.UniqueId
  end

  return nil
end

local function f2()
  return eventController.currentEventClass ~= nil
end

local f3

local function f4()
  local v16 = f3()

  if not v16 then
    return nil
  else
    local v17, v18 = pcall(function() return workspace.Bases[v16] end)

    if v17 then
      return v18
    end

    return nil
  end
end

function f3()
  local v19, v20 = pcall(function()
    return baseController:getClass("player", localPlayer, true)
  end)

  if v19 and v20 then
    return v20.UniqueId
  end

  return nil
end

local v21 = nil
local f5

local function f6()
  local v22 = f5()

  if v22 and v22.Data then
    return v22.Data.Cash or 0
  end

  return 0
end

function f5()
  if v21 then
    return v21
  else
    local v23, v24 = pcall(function() return dataController:getDataReplica(true) end)

    if v23 then
      v21 = v24
      return v24
    end

    return nil
  end
end

autoTab:CreateSection("Auto Fish")
local autoFish = false
local v25 = false
local bindableEvent = Instance.new("BindableEvent")

local function f7()
  v25 = false
end

local f8

local function f9()
  if v25 then
    return
  end

  v25 = true
  f8()

  task.spawn(function()
    while autoFish and v25 do
      local v26 = f1()

      if v26 then
        local v27, v28 = pcall(function() bombService.Start:Fire(v26) end)

        if not v27 then
          warn("Start:Fire failed: " .. tostring(v28))
        end

        task.wait(0.15)
        local v29, v30 = pcall(function() bombService.Throw:Fire(1) end)

        if not v29 then
          warn("Throw:Fire failed: " .. tostring(v30))
        end

        task.wait(3)
        local v31, v32 = pcall(function() bombService.Skip:Fire() end)

        if not v31 then
          warn("Skip:Fire failed: " .. tostring(v32))
        end

        local v33 = false

        local v34 = task.spawn(function()
          bindableEvent.Event:Wait()
          v33 = true
        end)

        local total = 0

        while not v33 and total < 5 do
          task.wait(0.1)
          total = total + 0.1
        end

        if not v33 then
          task.cancel(v34)
        end
      else
        warn("CharacterClass/UniqueId not found, retrying in 1s")
        task.wait(1)
      end
    end
  end)
end

local connect

function f8()
  if connect then
    return
  else
    local v35, v36 = pcall(function()
      connect = bombService.Finished:Connect(function() bindableEvent:Fire() end)
    end)

    if not v35 then
      warn("Failed to connect BombService.Finished: " .. tostring(v36))
    end

    return
  end
end

autoTab:CreateToggle({
  Name = "Auto Fish",
  CurrentValue = false,
  Flag = "AutoBombToggle",
  Callback = function(value)
    autoFish = value

    if value then
      f9()
    else
      f7()
    end
  end,
})

autoTab:CreateSection("Auto Collect")

local function f10(p1, p2, p3, p4)
  local v37 = false
  local v38 = false

  return function()
    if v37 then
      return
    end

    v37 = true
    v38 = true

    task.spawn(function()
      while v38 do
        local v39 = f4()

        if v39 then
          local v40, v41 = pcall(function() return v39.Floor1.Interactables[p2] end)

          if v40 and v41 then
            local v42, v43 = pcall(function() baseService.SendTagData:Fire(p1, v41, p3) end)

            if not v42 then
              warn(p3 .. " failed: " .. tostring(v43))
            end
          else
            warn(p2 .. " not found in Floor1.Interactables")
          end
        else
          warn("Base not found, retrying")
        end

        task.wait(p4)
      end

      v37 = false
    end)
  end, function() v38 = false end
end

local v44, v45 = f10("Collect", "Collect", "collectCash", 5)
local v46, v47 = f10("CageBridge", "CageBridge", "claimFishes", 60)
local v48, v49 = f10("Aquarium", "Aquarium", "equipBest", 5)

autoTab:CreateToggle({
  Name = "Auto Collect Cash (5s)",
  CurrentValue = false,
  Flag = "AutoCollectCashToggle",
  Callback = function(value2)
    if value2 then
      v44()
    else
      v45()
    end
  end,
})

autoTab:CreateToggle({
  Name = "Auto Claim Fishes (60s)",
  CurrentValue = false,
  Flag = "AutoClaimFishesToggle",
  Callback = function(value3)
    if value3 then
      v46()
    else
      v47()
    end
  end,
})

autoTab:CreateToggle({
  Name = "Auto Equip Best (5s)",
  CurrentValue = false,
  Flag = "AutoEquipBestToggle",
  Callback = function(value4)
    if value4 then
      v48()
    else
      v49()
    end
  end,
})

autoTab:CreateSection("Auto Buy Events")

local options = { "Gold", "Diamond", "Galaxy", "Sandstorm", "Candy" }

local function f11(fn)
  local v50 = false
  local v51 = false

  return function()
    if v50 then
      return
    end

    v50 = true
    v51 = true

    task.spawn(function()
      while v51 do
        local v52 = fn()

        if v52 then
          local v53, v54 = pcall(f2)

          if v53 and not v54 then
            local v55 = v13.Event.Actives[v52]
            local v56 = f6()

            if v55 and v55.Price and v55.Price <= v56 then
              local v57, v58 = pcall(function() eventService.Purchase:Fire(v52) end)

              if not v57 then
                warn("EventService.Purchase(" .. v52 .. ") failed: " .. tostring(v58))
              end
            end
          elseif not v53 then
            warn("isEventRunning check failed: " .. tostring(v54))
          end
        end

        task.wait(5)
      end

      v50 = false
    end)
  end, function() v51 = false end
end

local v59 = "Candy"

autoTab:CreateDropdown({
  Name = "Event to buy",
  Options = options,
  CurrentOption = { v59 },
  MultipleOptions = false,
  Flag = "EventChoiceDropdown",
  Callback = function(value5) v59 = value5[1] end,
})

local v60, v61 = f11(function() return v59 end)

autoTab:CreateToggle({
  Name = "Auto Buy Event",
  CurrentValue = false,
  Flag = "AutoBuySelectedEventToggle",
  Callback = function(value6)
    if value6 then
      v60()
    else
      v61()
    end
  end,
})

autoTab:CreateSection("Bomb Shop")

local function f12()
  for key, value7 in pairs(bombShopController.classes) do
    local fullName = value7.Config and value7.Config.FullName or "?"

    if value7.Equipped then
      print("[EQUIPPED] " .. key .. " (" .. fullName .. ")")
    elseif value7.Purchased then
      print("[OWNED]    " .. key .. " (" .. fullName .. ")")
    else
      print("[NOT OWNED] " .. key .. " (" .. fullName .. ") - Price: "
        .. tostring(value7.Config and value7.Config.Price))
    end
  end
end

local v62 = false
local v63 = false

local function f13()
  v63 = false
end

local function f14()
  if v62 then
    return
  end

  v62 = true
  v63 = true

  task.spawn(function()
    while v63 do
      local v64 = f6()

      for key2, value8 in pairs(bombShopController.classes) do
        local v65 = key2

        if v63 and not value8.Equipped and not value8.Purchased then
          local price = value8.Config and value8.Config.Price

          if price and price <= v64 then
            local v66, v67 = pcall(function() bombShopService.Purchase:Fire(v65) end)

            if v66 then
              print("Purchase attempted: " .. v65)
              v64 = v64 - price
            else
              warn("Purchase failed for " .. v65 .. ": " .. tostring(v67))
            end

            task.wait(0.3)
          end
        end
      end

      task.wait(5)
    end

    v62 = false
  end)
end

autoTab:CreateButton({ Name = "Print Bomb Status (console)", Callback = function() f12() end })

autoTab:CreateToggle({
  Name = "Auto Buy All Bombs",
  CurrentValue = false,
  Flag = "AutoBuyBombsToggle",
  Callback = function(value9)
    if value9 then
      f14()
    else
      f13()
    end
  end,
})

autoTab:CreateSection("Auto Rebirth")

local function f15()
  local v68 = f5()

  if not v68 then
    return false
  else
    local v69 = v13.Rebirth.Rebirths[v68.Data.Rebirth + 1]

    if not v69 then
      return false
    end

    return v68.Data.Cash >= v69.Requirements.Cash
  end
end

local v70 = false
local v71 = false

local function f16()
  v71 = false
end

local function f17()
  if v70 then
    return
  end

  v70 = true
  v71 = true

  task.spawn(function()
    while v71 do
      local v72, v73 = pcall(f15)

      if v72 and v73 then
        local v74, v75 = pcall(function() rebirthService.Rebirth:Fire() end)

        if v74 then
          print("Rebirth triggered")
        else
          warn("Rebirth:Fire failed: " .. tostring(v75))
        end
      elseif not v72 then
        warn("canRebirthNow check failed: " .. tostring(v73))
      end

      task.wait(5)
    end

    v70 = false
  end)
end

autoTab:CreateToggle({
  Name = "Auto Rebirth",
  CurrentValue = false,
  Flag = "AutoRebirthToggle",
  Callback = function(value10)
    if value10 then
      f17()
    else
      f16()
    end
  end,
})
