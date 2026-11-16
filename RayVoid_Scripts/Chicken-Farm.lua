local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "rnF" / (10727240 - "rBazGfEDw" ^ 15044556) end) })[2]
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
          pcall(function() return "rmtiB7n" / (1292328 - "OZZqxWJaKyMM" ^ 9229594) end),
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

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/HUB/refs/heads/main/RayVoid"))()
rayVoid:SetScriptName("Egg Collector")
rayVoid:ShowCredit()

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local remotefunction = replicatedStorage.Paper.Remotes.__remotefunction

local mainTab = rayVoid:CreateWindow({
  Name = "Egg Collector",
  LoadingTitle = "Egg Collector",
  LoadingSubtitle = "by AKkiwi",
  Theme = "Default",
  ConfigurationSaving = { Enabled = true, FolderName = nil, FileName = "EggCollector" },
}):CreateTab(
  "Main", "egg"
)

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
local minMultiplier = 1
local v22 = false
local v23 = false
local v24 = false
local v25 = false
local v26 = false
local v27 = false
local v28 = false
local v29 = false
local v30 = false
local v31 = false
local v32 = false
local v33 = false

local humanoidRootPart = players.LocalPlayer.Character
  and players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

players.LocalPlayer.CharacterAdded:Connect(function(character)
  humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)

local function f1(p1)
  local gsub2 = p1:gsub("[$,%s]", "")
  local v34, v35 = string.match(gsub2, "^([%d%.]+)([KMBTkmbt]?)$")

  if not v34 then
    return 0
  end

  return (tonumber(v34) or 0) * (({
    K = 1000,
    M = 1000000,
    B = 1000000000,
    T = 1000000000000,
  })[v35:upper()] or 1)
end

local function f2(p2)
  local v36, v37 = pcall(function()
    local v38 = f1(workspace.Plots[players.LocalPlayer.Name].Buttons.BuyChickens[p2].Button.UI.Cost.Text)
    return f1(players.LocalPlayer.PlayerGui.Main.Currencies.Cash.List.Amount.Text) >= v38
  end)

  return v36 and v37
end

local function f3()
  local v39, v40 = pcall(function()
    local v41 = f1(workspace.Plots[players.LocalPlayer.Name].Buttons.UpgradeBuyTier.Button.UI.Cost.Text)
    return f1(players.LocalPlayer.PlayerGui.Main.Currencies.Cash.List.Amount.Text) >= v41
  end)

  return v39 and v40
end

mainTab:CreateToggle({
  Name = "Auto Collect Eggs",
  CurrentValue = false,
  Flag = "AutoCollect",
  Callback = function(value)
    v12 = value

    if v12 and not v13 then
      v13 = true

      task.spawn(function()
        while v12 do
          for index, value2 in ipairs(workspace.Eggs:GetChildren()) do
            if not v12 then
              break
            else
              local part = value2:FindFirstChild("Part")

              if part and humanoidRootPart then
                pcall(function()
                  firetouchinterest(humanoidRootPart, part, 0)
                  task.wait(0.1)
                  firetouchinterest(humanoidRootPart, part, 1)
                end)
              end

              task.wait(0.05)
            end
          end

          task.wait(0.05)
        end

        v13 = false
      end)
    end
  end,
})

mainTab:CreateInput({
  Name = "Min Multiplier (Auto Sell)",
  CurrentValue = "1.0",
  PlaceholderText = "Ex: 1.5",
  Flag = "MinMultiplier",
  Callback = function(value3)
    local v42 = tonumber(value3)

    if v42 then
      minMultiplier = v42
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Sell Eggs",
  CurrentValue = false,
  Flag = "AutoSell",
  Callback = function(value4)
    v14 = value4

    if v14 and not v15 then
      v15 = true

      task.spawn(function()
        while v14 do
          pcall(function()
            local v43 = tonumber(string.match(
              workspace.Map.EggMultiplierPart.UI.Multi.Text, "([%d%.]+)x$"
            ))

            if v43 and v43 >= minMultiplier then
              remotefunction:InvokeServer("Deposit Eggs")
            end
          end)

          task.wait(1)
        end

        v15 = false
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Collect Cash",
  CurrentValue = false,
  Flag = "AutoCash",
  Callback = function(value5)
    v16 = value5

    if v16 and not v17 then
      v17 = true

      task.spawn(function()
        while v16 do
          pcall(function() remotefunction:InvokeServer("Collect Cash") end)
          task.wait(10)
        end

        v17 = false
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Upgrade Process Level",
  CurrentValue = false,
  Flag = "AutoUpgrade",
  Callback = function(value6)
    v18 = value6

    if v18 and not v19 then
      v19 = true

      task.spawn(function()
        while v18 do
          pcall(function() remotefunction:InvokeServer("Upgrade Process Level") end)
          task.wait(1)
        end

        v19 = false
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Upgrade Buy Tier",
  CurrentValue = false,
  Flag = "AutoUpgradeBuyTier",
  Callback = function(value7)
    v20 = value7

    if v20 and not v21 then
      v21 = true

      task.spawn(function()
        while v20 do
          if f3() then
            pcall(function() remotefunction:InvokeServer("Upgrade Buy Tier Level") end)
          end

          task.wait(1)
        end

        v21 = false
      end)
    end
  end,
})

mainTab:CreateSection("Auto Buy Chickens")

mainTab:CreateToggle({
  Name = "Auto Buy Chicken x1",
  CurrentValue = false,
  Flag = "AutoBuy1",
  Callback = function(value8)
    v22 = value8

    if v22 and not v23 then
      v23 = true

      task.spawn(function()
        while v22 do
          if f2("Buy1") then
            pcall(function() remotefunction:InvokeServer("Buy Chickens", 1) end)
          end

          task.wait(1)
        end

        v23 = false
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Buy Chicken x5",
  CurrentValue = false,
  Flag = "AutoBuy5",
  Callback = function(value9)
    v24 = value9

    if v24 and not v25 then
      v25 = true

      task.spawn(function()
        while v24 do
          if f2("Buy5") then
            pcall(function() remotefunction:InvokeServer("Buy Chickens", 5) end)
          end

          task.wait(1)
        end

        v25 = false
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Buy Chicken x25",
  CurrentValue = false,
  Flag = "AutoBuy25",
  Callback = function(value10)
    v26 = value10

    if v26 and not v27 then
      v27 = true

      task.spawn(function()
        while v26 do
          if f2("Buy25") then
            pcall(function() remotefunction:InvokeServer("Buy Chickens", 25) end)
          end

          task.wait(1)
        end

        v27 = false
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Buy Chicken x100",
  CurrentValue = false,
  Flag = "AutoBuy100",
  Callback = function(value11)
    v28 = value11

    if v28 and not v29 then
      v29 = true

      task.spawn(function()
        while v28 do
          if f2("Buy100") then
            pcall(function() remotefunction:InvokeServer("Buy Chickens", 100) end)
          end

          task.wait(1)
        end

        v29 = false
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Merge Chickens",
  CurrentValue = false,
  Flag = "AutoMerge",
  Callback = function(value12)
    v30 = value12

    if v30 and not v31 then
      v31 = true

      task.spawn(function()
        while v30 do
          pcall(function() remotefunction:InvokeServer("Merge Chickens") end)
          task.wait(1)
        end

        v31 = false
      end)
    end
  end,
})

mainTab:CreateSection("Lucky Blocks")

mainTab:CreateToggle({
  Name = "Auto Collect Lucky Blocks",
  CurrentValue = false,
  Flag = "AutoLucky",
  Callback = function(value13)
    v32 = value13

    if v32 and not v33 then
      v33 = true

      task.spawn(function()
        while v32 do
          for index2, value14 in ipairs(workspace.Objects:GetChildren()) do
            if not v32 then
              break
            elseif value14:IsA("Model") then
              local claim = value14:FindFirstChild("Main")
                and value14.Main:FindFirstChild("Claim")

              if claim then
                pcall(function() fireproximityprompt(claim) end)
                task.wait(0.1)
                pcall(function() remotefunction:InvokeServer("Open Lucky Block") end)
                task.wait(5)
              end
            end
          end
        end

        v33 = false
      end)
    end
  end,
})
