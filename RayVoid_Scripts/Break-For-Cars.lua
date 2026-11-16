local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "F3Pzeuhoxs" / (3837558 - "fC" ^ 9060629) end) })[2]
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
          pcall(function() return "6it6H3Uj3QRmU" / (10716488 - "N7YhzZNK2" ^ 15009739) end),
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
rayVoid:SetScriptName("Break-For-Cars")
rayVoid:MainCredit()

local replicatedStorage = game:GetService("ReplicatedStorage")
local collectCash = replicatedStorage.Remotes.Plot.CollectCash
local buyBlock = replicatedStorage.Remotes.Block.BuyBlock
local getPlot = replicatedStorage.Remotes.Plot.GetPlot
local placeItem = replicatedStorage.Remotes.Plot.PlaceItem
local removeItem = replicatedStorage.Remotes.Plot.RemoveItem
local buyUpgrade = replicatedStorage.Remotes.BuyUpgrade
local upgradeCar = replicatedStorage.Remotes.Car.UpgradeCar
local pickaxeRemote = replicatedStorage.Remotes.Pickaxe.PickaxeRemote
local v12 = require(replicatedStorage.Libraries.PlayerState.PlayerStateClient)
local v13 = require(replicatedStorage.Shared.Configurations.Upgrade)
local v14 = workspace.Plots[tostring(getPlot:InvokeServer())]
local autoCollect = false
local autoUpgrade = false
local autoPlace = false
local autoBuy = false
local autoOpen = false
local v15 = {}
local v16 = {}
local v17 = {}
local v18 = false
local targetLevel = 0
local collectFrequency = 30

local v19 = {
  ["Immortal Lucky Block"] = 12,
  ["Exclusive Lucky Block"] = 11,
  ["Godly Lucky Block"] = 10,
  ["Celestial Lucky Block"] = 9,
  ["Secret Lucky Block"] = 8,
  ["Cosmic Lucky Block"] = 7,
  ["Mythic Lucky Block"] = 6,
  ["Legendary Lucky Block"] = 5,
  ["Epic Lucky Block"] = 4,
  ["Rare Lucky Block"] = 3,
  ["Uncommon Lucky Block"] = 2,
  ["Lucky Block"] = 1,
}

local v20 = {
  "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Cosmic", "Secret", "Celestial",
  "Godly", "Exclusive", "Immortal",
}

local v21 = {
  { Name = "Normal", Mult = 1 }, { Name = "Golden", Mult = 2 },
  { Name = "Radioactive", Mult = 2.5 }, { Name = "Diamond", Mult = 3 },
  { Name = "Ruby", Mult = 3.5 }, { Name = "Emerald", Mult = 4 },
  { Name = "Infernal", Mult = 4.5 }, { Name = "Rainbow", Mult = 5 },
  { Name = "Divine", Mult = 4.5 }, { Name = "Galaxy", Mult = 5 },
  { Name = "Yin Yang", Mult = 3.5 }, { Name = "Admin", Mult = 2.5 },
  { Name = "Hacker", Mult = 5 },
}

local function f1(p1)
  local v22 = v14.Slots[tostring(p1)]

  if not v22 then
    return false
  end

  for index, value in ipairs(v22:GetChildren()) do
    local uiAttachment = value:FindFirstChild("UIAttachment")

    if uiAttachment then
      local placedBlockUI = uiAttachment:FindFirstChild("PlacedBlockUI")

      if placedBlockUI and placedBlockUI:FindFirstChild("BlockName") then
        return true
      end
    end
  end

  return false
end

local window = rayVoid:CreateWindow({
  Name = "Break-For-Cars",
  LoadingTitle = "Break-For-Cars",
  LoadingSubtitle = "by Akkiwi",
})

local mainTab = window:CreateTab("Main", 0)

mainTab:CreateToggle({
  Name = "Auto Open Blocks",
  CurrentValue = false,
  Flag = "AutoOpen",
  Callback = function(value2)
    autoOpen = value2

    if value2 then
      task.spawn(function()
        while autoOpen do
          local character = game:GetService("Players").LocalPlayer.Character
          local humanoid = character and character:FindFirstChild("Humanoid")
          local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

          if character and humanoid and humanoidRootPart then
            local v23 = nil
            local position = nil

            for k = 1, 30 do
              if f1(k) then
                local v24 = v14.Slots[tostring(k)]

                if v24 then
                  v23 = k
                  position = v24:GetPivot().Position
                  break
                end
              end
            end

            if v23 and position then
              local tool = character:FindFirstChildWhichIsA("Tool")

              local v25 = tool
              v25 = tool and tool:GetAttribute("ItemType") == "Pickaxe"

              if not v25 then
                for index2, value3 in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                  if value3:IsA("Tool") and value3:GetAttribute("ItemType") == "Pickaxe" then
                    humanoid:EquipTool(value3)
                    task.wait(0.3)
                    v25 = true
                    break
                  end
                end
              end

              if not v25 then
                task.wait(5)
              else
                humanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
                task.wait(0.3)

                while autoOpen and f1(v23) do
                  pickaxeRemote:FireServer("Damage")
                  task.wait(0.8)
                end
              end
            else
              task.wait(5)
            end
          else
            task.wait(0.5)
          end
        end
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Collect",
  CurrentValue = false,
  Flag = "AutoCollect",
  Callback = function(value4)
    autoCollect = value4

    if value4 then
      task.spawn(function()
        while autoCollect do
          for m = 1, 30 do
            local v26 = v12.GetFromDict("Plot.Slots", m)

            if v26 and v26.Occupied and v26.Type == "Car" and v26.Cash and v26.Cash > 0 then
              collectCash:FireServer(m)
              task.wait(0.1)
            end
          end

          task.wait(collectFrequency)
        end
      end)
    end
  end,
})

mainTab:CreateSlider({
  Name = "Collect Frequency",
  Range = { 30, 120 },
  Increment = 5,
  Suffix = "sec",
  CurrentValue = 30,
  Flag = "CollectFrequency",
  Callback = function(value5) collectFrequency = value5 end,
})

mainTab:CreateToggle({
  Name = "Auto Upgrade Plot",
  CurrentValue = false,
  Flag = "AutoUpgrade",
  Callback = function(value6)
    autoUpgrade = value6

    if value6 then
      task.spawn(function()
        while autoUpgrade do
          local v27 = (v12.GetPath("UpgradeLevel") or 0) + 1
          local v28 = v13.GetUpgradeCost(v27)

          if v28 and (v12.Get("Cash") or 0) >= v28 then
            buyUpgrade:FireServer(v27)
            task.wait(1)
          else
            task.wait(120)
          end
        end
      end)
    end
  end,
})

mainTab:CreateToggle({
  Name = "Auto Place",
  CurrentValue = false,
  Flag = "AutoPlace",
  Callback = function(value7)
    autoPlace = value7

    if value7 then
      task.spawn(function()
        while autoPlace do
          local v29 = {}

          for index3, value8 in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if value8:GetAttribute("ItemType") == "Block" then
              local itemName = value8:GetAttribute("ItemName")
              local uuid = value8:GetAttribute("UUID")
              table.insert(v29, { uuid = uuid, priority = v19[itemName] or 0 })
            end
          end

          table.sort(v29, function(p2, p3) return p2.priority > p3.priority end)
          local v30 = 1

          for n = 1, 30 do
            if not autoPlace then
              break
            elseif v30 > #v29 then
              break
            else
              local v31 = v12.GetFromDict("Plot.Slots", n)

              if v31 and not v31.Occupied and not v31.Pending then
                placeItem:FireServer(n, "Block", v29[v30].uuid)
                v30 = v30 + 1
                task.wait(0.2)
              end
            end
          end

          task.wait(5)
        end
      end)
    end
  end,
})

mainTab:CreateButton({
  Name = "Auto Place Best",
  Callback = function()
    task.spawn(function()
      local localPlayer = game:GetService("Players").LocalPlayer

      for i6 = 1, 40 do
        local v32 = i6
        local v33 = v12.GetFromDict("Plot.Slots", v32)

        if v33 and v33.Occupied and v33.Type == "Car" then
          local v34, v35 = pcall(function() removeItem:FireServer("Car", v32) end)

          if not v34 then
            warn("RemoveItem failed on slot " .. v32 .. ": " .. tostring(v35))
          end

          task.wait(0.2)
        end
      end

      task.wait(0.5)
      local v36 = {}

      for index4, value9 in ipairs(localPlayer.Backpack:GetChildren()) do
        if value9:GetAttribute("ItemType") == "Car" then
          table.insert(v36, {
            uuid = value9:GetAttribute("UUID"),
            income = value9:GetAttribute("Income") or 0,
          })
        end
      end

      table.sort(v36, function(p4, p5) return p4.income > p5.income end)
      local v37 = {}

      for i7 = 1, 40 do
        local v38 = v12.GetFromDict("Plot.Slots", i7)

        if v38 and not v38.Occupied and not v38.Pending then
          table.insert(v37, i7)
        end
      end

      local v39 = 1

      for index5, value10 in ipairs(v37) do
        local v40 = value10

        if v39 > #v36 then
          break
        else
          local v41, v42 = pcall(function() placeItem:FireServer(v40, "Car", v36[v39].uuid) end)

          if not v41 then
            warn("PlaceItem failed on slot " .. v40 .. ": " .. tostring(v42))
          end

          v39 = v39 + 1
          task.wait(0.2)
        end
      end
    end)
  end,
})

mainTab:CreateSection("Auto Buy")

mainTab:CreateToggle({
  Name = "Auto Buy",
  CurrentValue = false,
  Flag = "AutoBuy",
  Callback = function(value11)
    autoBuy = value11

    if value11 then
      task.spawn(function()
        while autoBuy do
          if next(v15) then
            for index6, value12 in ipairs(v14.SpawnedBlocks:GetChildren()) do
              if not autoBuy then
                break
              else
                local uiAttachment2 = value12:FindFirstChild("UIAttachment")

                if uiAttachment2 then
                  local blockUI = uiAttachment2:FindFirstChild("BlockUI")

                  if blockUI then
                    local rarity = blockUI:FindFirstChild("Rarity")
                    local mutation = blockUI:FindFirstChild("Mutation")
                    local text = rarity and rarity.Text or ""
                    local text2 = mutation and mutation.Text or ""
                    local v43 = not next(v17) or v17[text2]

                    if v15[text] and v43 then
                      buyBlock:FireServer(value12.Name)
                      task.wait(0.1)
                    end
                  end
                end
              end
            end
          end

          task.wait(0.5)
        end
      end)
    end
  end,
})

mainTab:CreateSection("Auto LvlUp")

mainTab:CreateInput({
  Name = "Target Level",
  CurrentValue = "",
  PlaceholderText = "Enter target level...",
  RemoveTextAfterFocusLost = false,
  Flag = "TargetLevel",
  Callback = function(value13) targetLevel = tonumber(value13) or 0 end,
})

mainTab:CreateToggle({
  Name = "Auto LvlUp",
  CurrentValue = false,
  Flag = "AutoLvlUp",
  Callback = function(value14)
    v18 = value14

    if value14 then
      task.spawn(function()
        while v18 do
          if targetLevel > 0 and next(v16) then
            for i8 = 1, 30 do
              if not v18 then
                break
              else
                local v44 = v12.GetFromDict("Plot.Slots", i8)

                if v44 and v44.Occupied and v44.Type == "Car" then
                  local text3 = ""
                  local v45 = v14.Slots[tostring(i8)]

                  if v45 then
                    local findFirstChild = v45:FindFirstChild(v44.Name)

                    if findFirstChild then
                      local uiAttachment3 = findFirstChild:FindFirstChild("UIAttachment")

                      if uiAttachment3 then
                        local carUI = uiAttachment3:FindFirstChild("CarUI")

                        if carUI then
                          local rarity2 = carUI:FindFirstChild("Rarity")

                          if rarity2 then
                            text3 = rarity2.Text
                          end
                        end
                      end
                    end
                  end

                  if v16[text3] and (v44.Level or 1) < targetLevel then
                    upgradeCar:FireServer(i8)
                    task.wait(0.2)
                  end
                end
              end
            end
          end

          task.wait(1)
        end
      end)
    end
  end,
})

local tab = window:CreateTab("LvlUp Rarities", 0)

for index7, value15 in ipairs(v20) do
  local v46 = value15

  tab:CreateToggle({
    Name = v46,
    CurrentValue = false,
    Flag = "CarRarity_" .. v46,
    Callback = function(value16) v16[v46] = value16 or nil end,
  })
end

local raritiesTab = window:CreateTab("Rarities", 0)

for index8, value17 in ipairs(v20) do
  local v47 = value17

  raritiesTab:CreateToggle({
    Name = v47,
    CurrentValue = false,
    Flag = "Rarity_" .. v47,
    Callback = function(value18) v15[v47] = value18 or nil end,
  })
end

local mutationsTab = window:CreateTab("Mutations", 0)

for index9, value19 in ipairs(v21) do
  local v48 = value19

  mutationsTab:CreateToggle({
    Name = v48.Name .. " (x" .. v48.Mult .. ")",
    CurrentValue = false,
    Flag = "Mutation_" .. v48.Name,
    Callback = function(value20) v17[v48.Name] = value20 or nil end,
  })
end
