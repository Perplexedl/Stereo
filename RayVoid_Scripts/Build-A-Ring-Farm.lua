local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "P15esg" / (13804966 - "fDB5LybzH" ^ 1462829) end) })[2]
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
          pcall(function() return "HssMHe2iy" / (14209970 - "f4xfEaM2pp" ^ 700950) end),
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
rayVoid:SetScriptName("BARF")
rayVoid:ShowCredit()

local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local v12

for index, value in ipairs(workspace.Map.Plots:GetChildren()) do
  if value:IsA("Model") and value:GetAttribute("OwnerUserId") == localPlayer.UserId then
    v12 = value
    break
  end
end

local f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, v13, f13, f14, v14, v15,
  scrollingFrame, waitForChild, f15, f16, v16, f17, v17, v18, v19, v20, v21, v22, f18,
  upgradePlantsTab, toggle, f19, v23, v24, v25, v26, filteredCardGrid, v27, v28, v29, v30, v31,
  v32, v33, v34, v35, v36, v37, v38, v39, f20, v40, v41, v42, v43, v44, composter, f21, v45,
  filteredCardGrid2, f22, v46, v47, v48, f23, f24, f25, v49, v50, v51, f26, v52, v53

if not v12 then
  rayVoid:Notify({ Title = "Error", Content = "Could not find your plot!", Duration = 4 })
  return
else
  local seedRoller = v12:FindFirstChild("SeedRoller")
  v13 = {}

  for k = 1, 6 do
    local findFirstChild = seedRoller:FindFirstChild("Stand" .. k)

    if findFirstChild then
      v13[k] = { index = k, position = findFirstChild:GetPivot().Position }
    end
  end

  function f13()
    local v54 = {}

    for index2, value2 in ipairs(workspace:GetChildren()) do
      if value2:IsA("Model") and value2:FindFirstChild("BuySeed", true) then
        local position = value2:GetPivot().Position
        local huge = math.huge
        local v55 = nil

        for key, value3 in pairs(v13) do
          local magnitude = (Vector3.new(position.X, 0, position.Z)
            - Vector3.new(value3.position.X, 0, value3.position.Z)).Magnitude

          if magnitude < huge then
            v55 = value3
            huge = magnitude
          end
        end

        if v55 and huge < 15 then
          v54[value2.Name] = v55.index
        end
      end
    end

    return v54
  end

  function f14()
    local v56 = {}
    local farmPlot = v12:FindFirstChild("FarmPlot")

    if farmPlot then
      table.insert(v56, farmPlot)
    end

    for m = 2, 4 do
      local findFirstChild2 = v12:FindFirstChild("Floor" .. m)

      if findFirstChild2 then
        local farmPlot2 = findFirstChild2:FindFirstChild("FarmPlot")

        if farmPlot2 then
          table.insert(v56, farmPlot2)
        end
      end
    end

    return v56
  end

  v14 = { "Super Fertilizer", "Strong Fertilizer", "Normal Fertilizer" }

  function f2()
    for index3, value4 in ipairs(v14) do
      for index4, value5 in ipairs(localPlayer.Backpack:GetChildren()) do
        if string.find(value5.Name, value4, 1, true) then
          return value5
        end
      end
    end

    return nil
  end

  function f1()
    for index5, value6 in ipairs(f14()) do
      for index6, value7 in ipairs(value6:GetChildren()) do
        local dirt = value7:FindFirstChild("Dirt")

        if dirt and dirt:GetAttribute("PlantLevel") ~= nil then
          if not dirt:GetAttribute("Fertilized") then
            return dirt
          end
        end
      end
    end

    return nil
  end

  local plantsFrame = players.LocalPlayer.PlayerGui.MainUI.Menus.IndexFrame.Main.PlantsFrame:WaitForChild("PlantsFrame")

  local v57 = {
    "Common", "Uncommon", "Rare", "Epic", "Legendary", "Divine", "Prismatic", "Secret",
    "Exotic", "Transcended", "Celestial", "Eternal",
  }

  local v58 = {}

  for index7, value8 in ipairs(v57) do
    v58[value8] = {}
  end

  for index8, value9 in ipairs(plantsFrame:GetChildren()) do
    if value9:IsA("Frame") then
      value9:FindFirstChild("Icon")
      value9:FindFirstChild("RarityName")
      value9:FindFirstChild("SeedName")
    end
  end

  local v59 = {}

  for index9, value10 in ipairs(v57) do
    if #v58[value10] > 0 then
      table.insert(v59, { Label = value10, Items = v58[value10] })
    end
  end

  v15 = {}

  for index10, value11 in ipairs(plantsFrame:GetChildren()) do
    if value11:IsA("Frame") then
      local icon = value11:FindFirstChild("Icon")

      if icon then
        v15[value11.Name] = icon.Image
      end
    end
  end

  function f3(p1)
    local v60 = v16[p1]

    if v60 then
      v60.stop()
      v60.part:Destroy()
      v16[p1] = nil
    end
  end

  function f4(p2)
    if not p2 then
      return 0
    end

    return tonumber(p2.Text:match("%d+")) or 0
  end

  scrollingFrame = players.LocalPlayer.PlayerGui.MainUI.Menus.GearShopFrame.ScrollingFrame

  local function f27()
    local v61 = {}

    for index11, value12 in ipairs(scrollingFrame:GetChildren()) do
      if value12:IsA("ImageLabel") then
        local gearName = value12:FindFirstChild("GearName")
        local gearImage = value12:FindFirstChild("GearImage")

        local imageLabel = gearImage
        imageLabel = gearImage and gearImage:FindFirstChild("ImageLabel")

        local rarity = gearImage
        rarity = gearImage and gearImage:FindFirstChild("Rarity")

        if gearName and imageLabel then
          table.insert(v61, {
            Name = gearName.Text,
            Icon = imageLabel.Image,
            StockLabel = rarity,
          })
        end
      end
    end

    return v61
  end

  local v62 = workspace

  function f5()
    local v63 = {}

    for index12, value13 in ipairs(localPlayer.Backpack:GetChildren()) do
      if value13:IsA("Tool") and value13:GetAttribute("InventoryCategory") == "Pets" then
        table.insert(v63, {
          name = value13:GetAttribute("trueName") or value13.Name,
          petKey = value13:GetAttribute("petKey"),
          multiplier = value13:GetAttribute("EarningsMultiplier") or 1,
          tool = value13,
        })
      end
    end

    return v63
  end

  function f6()
    local v64 = {}

    for n = 1, 4 do
      if v12:FindFirstChild(n == 1 and "Floor" or "Floor" .. n) then
        table.insert(v64, n)
      end
    end

    return v64
  end

  waitForChild = v62:WaitForChild("PetMerchant", 10)

  function f15()
    local v65 = {}

    if not waitForChild then
      return v65
    end

    for i6 = 1, 5 do
      local findFirstChild3 = waitForChild:FindFirstChild("Podium" .. i6 .. "Lever")

      if findFirstChild3 then
        local promptAttachment = findFirstChild3:FindFirstChild("PromptAttachment")

        local eggShopPrompt = promptAttachment
          and promptAttachment:FindFirstChild("EggShopPrompt")

        if eggShopPrompt and eggShopPrompt.ObjectText ~= ""
          and not eggShopPrompt.ObjectText:find("Slot") then
          table.insert(v65, { podiumIdx = i6, name = eggShopPrompt.ObjectText })
        end
      end
    end

    return v65
  end

  local v66 = f15()

  function f9(p3)
    local plotUpgradeSign

    if p3 == 1 then
      plotUpgradeSign = v12:FindFirstChild("PlotUpgradeSign")
    else
      local findFirstChild4 = v12:FindFirstChild("Floor" .. p3)
      plotUpgradeSign = findFirstChild4 and findFirstChild4:FindFirstChild("PlotUpgradeSign")
    end

    return plotUpgradeSign and plotUpgradeSign:GetPivot()
  end

  function f7()
    local v67 = {}

    for index13, value14 in ipairs(v12:GetChildren()) do
      if value14:IsA("Model") and value14:GetAttribute("PetKey") ~= nil then
        if value14:GetAttribute("PetOwner") == localPlayer.Name then
          table.insert(v67, {
            name = value14:GetAttribute("PetName"),
            petKey = value14:GetAttribute("PetKey"),
            multiplier = value14:GetAttribute("EarningsMultiplier") or 1,
            floorIndex = value14:GetAttribute("FloorIndex") or 1,
          })
        end
      end
    end

    return v67
  end

  function f16()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then
      return
    else
      local v68 = f6()

      repeat
        local v69 = f7()
        local v70 = f5()

        table.sort(v69, function(p4, p5) return p4.multiplier > p5.multiplier end)
        table.sort(v70, function(p6, p7) return p6.multiplier > p7.multiplier end)

        if #v70 == 0 then
          break
        else
          local v71 = #v68
          local v72 = {}

          for index14, value15 in ipairs(v69) do
            table.insert(v72, { source = "equipped", data = value15 })
          end

          for index15, value16 in ipairs(v70) do
            table.insert(v72, { source = "inventory", data = value16 })
          end

          table.sort(v72, function(p8, p9) return p8.data.multiplier > p9.data.multiplier end)
          local v73 = {}

          for i7 = 1, math.min(v71, #v72) do
            table.insert(v73, v72[i7])
          end

          local v74 = {}

          for index16, value17 in ipairs(v73) do
            v74[value17.data.petKey] = true
          end

          local v75 = {}

          for index17, value18 in ipairs(v69) do
            if not v74[value18.petKey] then
              table.insert(v75, value18)
            end
          end

          local v76 = {}

          for index18, value19 in ipairs(v73) do
            if value19.source == "inventory" then
              table.insert(v76, value19.data)
            end
          end

          if #v75 == 0 and #v76 == 0 then
            break
          end

          for index19, value20 in ipairs(v75) do
            replicatedStorage.Remotes.Pets.UnequipPet:FireServer(value20.petKey)
            task.wait(0.5)
          end

          for index20, value21 in ipairs(v76) do
            local v77 = {}

            for index21, value22 in ipairs(f7()) do
              v77[value22.floorIndex] = true
            end

            local v78 = nil

            for index22, value23 in ipairs(v68) do
              if not v77[value23] then
                v78 = value23
                break
              end
            end

            if not v78 then
              break
            else
              local v79 = f9(v78)

              if v79 then
                humanoidRootPart.CFrame = v79 + Vector3.new(0, 3, 0)
                task.wait(0.5)
              end

              local findFirstChild5 = localPlayer.Backpack:FindFirstChild(value21.tool.Name)

              if not findFirstChild5 then
              else
                humanoid:EquipTool(findFirstChild5)
                task.wait(0.5)
                replicatedStorage.Remotes.Pets.EquipPet:FireServer()
                task.wait(0.3)
                humanoid:UnequipTools()
                task.wait(0.3)
              end
            end
          end
        end
      until false

      rayVoid:Notify({ Title = "Pets", Content = "Optimisation done.", Duration = 3 })
      return
    end
  end

  v16 = {}

  function f10(p10, p11)
    local voidUIHighlight, v80

    if v16[p10] then
      return
    else
      local getPivot = p11:GetPivot()

      voidUIHighlight = Instance.new("Part")
      voidUIHighlight.Name = "VoidUI_Highlight"
      voidUIHighlight.Shape = Enum.PartType.Ball
      voidUIHighlight.Size = Vector3.new(1.8, 1.8, 1.8)
      voidUIHighlight.CFrame = getPivot + Vector3.new(0, 9, 0)
      voidUIHighlight.Anchored = true
      voidUIHighlight.CanCollide = false
      voidUIHighlight.CastShadow = false
      voidUIHighlight.Material = Enum.Material.Neon
      voidUIHighlight.Color = Color3.fromRGB(130, 80, 255)
      voidUIHighlight.Parent = workspace

      v80 = true

      task.spawn(function()
        while v80 and voidUIHighlight and voidUIHighlight.Parent do
          for i8 = 1, 20 do
            if not v80 then
              break
            else
              local v81 = 1.5 + 0.75 * math.sin(i8 / 20 * math.pi)
              voidUIHighlight.Size = Vector3.new(v81, v81, v81)
              task.wait(0.05)
            end
          end

          for i9 = 1, 20 do
            if not v80 then
              break
            else
              local v82 = 2.25 - 0.75 * math.sin(i9 / 20 * math.pi)
              voidUIHighlight.Size = Vector3.new(v82, v82, v82)
              task.wait(0.05)
            end
          end
        end
      end)

      v16[p10] = { part = voidUIHighlight, stop = function() v80 = false end }
      return
    end
  end

  function f17()
    for key2 in pairs(v16) do
      f3(key2)
    end
  end

  v17 = {}
  v18 = {}
  v19 = {}
  v20 = {}
  v21 = {}
  v22 = {}

  function f8(p12)
    for i10 = #v18, 1, -1 do
      v18[i10] = nil
    end

    for key3 in pairs(v19) do
      v19[key3] = nil
    end

    for key4 in pairs(v20) do
      v20[key4] = nil
    end

    for key5 in pairs(v21) do
      v21[key5] = nil
    end

    for key6 in pairs(v22) do
      v22[key6] = nil
    end

    local v83 = {}

    if p12 then
      for key7 in pairs(v17) do
        v83[key7] = true
      end
    end

    f17()
    local v84 = {}
    local v85 = {}
    v17 = {}

    for index23, value24 in ipairs(f14()) do
      for index24, value25 in ipairs(value24:GetChildren()) do
        local dirt2 = value25:FindFirstChild("Dirt")

        local plantName = dirt2
        plantName = dirt2 and dirt2:GetAttribute("PlantName")

        if dirt2 and plantName then
          local plantLevel = dirt2:GetAttribute("PlantLevel")

          table.insert(v85, {
            pName = plantName,
            lvl = plantLevel or 0,
            dirt = dirt2,
            model = value25,
          })
        end
      end
    end

    table.sort(v85, function(p13, p14) return p13.pName < p14.pName end)

    for index25, value26 in ipairs(v85) do
      v84[value26.pName] = (v84[value26.pName] or 0) + 1
      local v86 = f18(value26.pName, value26.lvl, v84[value26.pName])
      v19[v86] = value26.dirt
      v20[v86] = value26.model
      v21[v86] = value26.pName
      table.insert(v18, { Name = v86, Icon = v15[value26.pName] or "" })
    end

    if p12 then
      local v87 = {}

      for index26, value27 in ipairs(v18) do
        local v88 = v21[value27.Name]

        if v88 and v83[v88] then
          v17[v88] = true

          if not v87[v88] then
            v87[v88] = true
            local v89 = v20[value27.Name]

            if v89 then
              f10(v88, v89)
            end
          end
        end
      end
    end
  end

  function f18(p15, p16, p17)
    return "[Lv." .. p16 .. "] " .. p15 .. " #" .. p17
  end

  upgradePlantsTab = nil
  toggle = nil

  local barfWindow = rayVoid:CreateWindow({
    Name = "BARF",
    LoadingTitle = "Build-A-Ring Farm",
    LoadingSubtitle = "by akkiwi",
    Theme = "Default",
    ConfigurationSaving = { Enabled = true, FolderName = "AkkiwiScripts", FileName = "BARF" },
  })

  v23 = {}
  v24 = {}
  v25 = false
  v26 = false
  local seedsTab = barfWindow:CreateTab("Seeds")

  filteredCardGrid = seedsTab:CreateFilteredCardGrid({
    Groups = v59,
    Columns = 4,
    Flag = "BARF_SelectedSeeds",
    Callback = function(value28) v23 = value28 end,
  })

  seedsTab:CreateButton({
    Name = "Select all (current rarity)",
    Callback = function()
      filteredCardGrid:SelectAll()

      rayVoid:Notify({
        Title = "Selection",
        Content = "All seeds in group selected.",
        Duration = 2,
      })
    end,
  })

  seedsTab:CreateButton({
    Name = "Deselect all",
    Callback = function()
      filteredCardGrid:DeselectAll()
      rayVoid:Notify({ Title = "Selection", Content = "Selection cleared.", Duration = 2 })
    end,
  })

  local shopTab = barfWindow:CreateTab("Shop")
  shopTab:CreateSection("Gear Shop - Auto-Buy")

  local v90 = f27()
  local v91 = {}

  for index27, value29 in ipairs(v90) do
    table.insert(v91, { Name = value29.Name, Icon = value29.Icon })
  end

  v27 = {}

  for index28, value30 in ipairs(v90) do
    v27[value30.Name] = value30.StockLabel
  end

  shopTab:CreateCardGrid({
    Items = v91,
    Columns = 4,
    Flag = "BARF_SelectedGear",
    Callback = function(value31) v24 = value31 end,
  })

  shopTab:CreateButton({
    Name = "Deselect all",
    Callback = function()
      v24 = {}
      rayVoid:Notify({ Title = "Selection", Content = "Shop selection cleared.", Duration = 2 })
    end,
  })

  local eggsTab = barfWindow:CreateTab("Eggs")
  v28 = {}
  v29 = false
  v30 = false
  eggsTab:CreateSection("Select eggs to buy")

  for index29, value32 in ipairs({
    "Common Egg", "Rare Egg", "Epic Egg", "Legendary Egg", "Secret Egg",
  }) do
    local v92 = value32

    eggsTab:CreateToggle({
      Name = v92,
      CurrentValue = false,
      Flag = "BARF_Egg_" .. v92:gsub(" ", "_"),
      Callback = function(value33) v28[v92] = value33 or nil end,
    })
  end

  eggsTab:CreateSection("Auto-Buy Eggs")

  eggsTab:CreateToggle({
    Name = "Enable Auto-Buy Eggs",
    CurrentValue = false,
    Flag = "BARF_AutoBuyEggs",
    Callback = function(value34)
      if value34 then
        if v29 then
          return
        end

        v29 = true
        v30 = false

        task.spawn(function()
          while not v30 do
            for index30, value35 in ipairs((f15())) do
              if v30 then
                break
              elseif v28[value35.name] then
                local findFirstChild6 = waitForChild:FindFirstChild("Podium" .. value35.podiumIdx
                  .. "Lever")

                local eggShopPrompt2 = findFirstChild6
                  and findFirstChild6:FindFirstChild("PromptAttachment")
                  and findFirstChild6.PromptAttachment:FindFirstChild("EggShopPrompt")

                if eggShopPrompt2 and not eggShopPrompt2.ObjectText:find("Slot") then
                  fireproximityprompt(eggShopPrompt2)

                  rayVoid:Notify({
                    Title = "Egg bought!",
                    Content = value35.name .. " (Podium " .. value35.podiumIdx .. ")",
                    Duration = 2,
                  })
                end

                task.wait(0.3)
              end
            end

            local count = 0

            while count < 120 and not v30 do
              task.wait(1)
              count = count + 1
            end
          end

          v29 = false
        end)

        return
      end

      v30 = true
      rayVoid:Notify({ Title = "Stopped", Content = "Auto-buy eggs stopped.", Duration = 3 })
    end,
  })

  eggsTab:CreateButton({
    Name = "Roll Now",
    Callback = function()
      for index31, value36 in ipairs((f15())) do
        if v28[value36.name] then
          local findFirstChild7 = waitForChild:FindFirstChild("Podium" .. value36.podiumIdx
            .. "Lever")

          local eggShopPrompt3 = findFirstChild7
            and findFirstChild7:FindFirstChild("PromptAttachment")
            and findFirstChild7.PromptAttachment:FindFirstChild("EggShopPrompt")

          if eggShopPrompt3 and not eggShopPrompt3.ObjectText:find("Slot") then
            fireproximityprompt(eggShopPrompt3)

            rayVoid:Notify({
              Title = "Egg bought!",
              Content = value36.name .. " (Podium " .. value36.podiumIdx .. ")",
              Duration = 2,
            })
          end

          task.wait(0.3)
        end
      end
    end,
  })

  local autoTab = barfWindow:CreateTab("Auto")
  autoTab:CreateSection("Auto-Buy Seeds")

  autoTab:CreateToggle({
    Name = "Enable Auto-Buy Seeds",
    CurrentValue = false,
    Flag = "BARF_AutoBuySeeds",
    Callback = function(value37)
      if value37 then
        if v25 then
          return
        end

        v25 = true
        v26 = false

        task.spawn(function()
          while not v26 do
            if next(v23) == nil then
              task.wait(1)
            else
              replicatedStorage.Remotes.RollSeeds:FireServer()
              task.wait(4)

              for key8, value38 in pairs(f13()) do
                if v26 then
                  break
                elseif v23[key8] then
                  replicatedStorage.Remotes.BuySeed:FireServer(value38)

                  rayVoid:Notify({
                    Title = "Purchased!",
                    Content = key8 .. " -> Stand " .. value38,
                    Duration = 3,
                  })

                  task.wait(0.5)
                end
              end

              task.wait(1)
            end
          end

          v25 = false
        end)

        return
      end

      v26 = true
      rayVoid:Notify({ Title = "Stopped", Content = "Auto-buy seeds stopped.", Duration = 3 })
    end,
  })

  autoTab:CreateSection("Auto-Buy Shop")

  v31 = 120
  v32 = false
  v33 = false

  autoTab:CreateSlider({
    Name = "Scan interval (sec)",
    Range = { 10, 300 },
    Increment = 1,
    CurrentValue = 120,
    Suffix = "s",
    Flag = "BARF_ShopInterval",
    Callback = function(value39) v31 = value39 end,
  })

  autoTab:CreateToggle({
    Name = "Enable Auto-Buy Shop",
    CurrentValue = false,
    Flag = "BARF_AutoBuyShop",
    Callback = function(value40)
      if value40 then
        if v32 then
          return
        end

        v32 = true
        v33 = false

        task.spawn(function()
          while not v33 do
            if next(v24) ~= nil then
              for key9 in pairs(v24) do
                local v93 = key9

                if v33 then
                  break
                else
                  local v94 = f4(v27[v93])

                  if v94 > 0 then
                    for i11 = 1, v94 do
                      if v33 then
                        break
                      end

                      if pcall(function()
                        replicatedStorage.Remotes.Gear.Transaction:InvokeServer(v93)
                      end) then
                        rayVoid:Notify({
                          Title = "Purchased!",
                          Content = v93 .. " (" .. i11 .. "/" .. v94 .. ")",
                          Duration = 3,
                        })

                        task.wait(0.1)
                      else
                        rayVoid:Notify({
                          Title = "Error",
                          Content = "Failed to buy " .. v93,
                          Duration = 3,
                        })

                        break
                      end
                    end
                  end
                end
              end
            end

            local count2 = 0

            while count2 < v31 and not v33 do
              task.wait(1)
              count2 = count2 + 1
            end
          end

          v32 = false
        end)

        return
      end

      v33 = true
      rayVoid:Notify({ Title = "Stopped", Content = "Auto-buy shop stopped.", Duration = 3 })
    end,
  })

  autoTab:CreateSection("Auto-Collect")

  v34 = false
  v35 = false

  autoTab:CreateToggle({
    Name = "Enable Auto-Collect",
    CurrentValue = false,
    Flag = "BARF_AutoCollect",
    Callback = function(value41)
      if value41 then
        if v34 then
          return
        end

        v34 = true
        v35 = false

        task.spawn(function()
          while not v35 do
            replicatedStorage.Remotes.SellCrates:FireServer()
            rayVoid:Notify({ Title = "Collected!", Content = "Crates sold.", Duration = 2 })
            task.wait(120)
          end

          v34 = false
        end)

        return
      end

      v35 = true
      rayVoid:Notify({ Title = "Stopped", Content = "Auto-collect stopped.", Duration = 3 })
    end,
  })

  autoTab:CreateSection("Auto-Upgrade Plants")

  v36 = 10

  autoTab:CreateSlider({
    Name = "Target level",
    Range = { 1, 200 },
    Increment = 1,
    CurrentValue = 10,
    Flag = "BARF_UpgradeTargetLevel",
    Callback = function(value42) v36 = value42 end,
  })

  autoTab:CreateButton({
    Name = "Upgrade all plants",
    Callback = function()
      local v95 = f14()

      if #v95 == 0 then
        rayVoid:Notify({ Title = "Error", Content = "FarmPlot not found!", Duration = 3 })
        return
      end

      task.spawn(function()
        local count3 = 0

        for index32, value43 in ipairs(v95) do
          for index33, value44 in ipairs(value43:GetChildren()) do
            local dirt3 = value44:FindFirstChild("Dirt")

            if dirt3 and dirt3:GetAttribute("PlantLevel") ~= nil then
              local plantLevel2 = dirt3:GetAttribute("PlantLevel") or 0

              while plantLevel2 < v36 do
                local v96, v97 = pcall(function()
                  return replicatedStorage.Remotes.UpgradePlant:InvokeServer(dirt3)
                end)

                if not v96 or type(v97) == "boolean" and v97 == false then
                  rayVoid:Notify({
                    Title = "Upgrade",
                    Content = "Refused - waiting 60s",
                    Duration = 5,
                  })

                  task.wait(60)
                else
                  task.wait(0.1)
                end

                plantLevel2 = dirt3:GetAttribute("PlantLevel") or 0
              end

              count3 = count3 + 1
            end
          end
        end

        rayVoid:Notify({
          Title = "Done!",
          Content = count3 .. " plant(s) upgraded to level " .. v36,
          Duration = 4,
        })
      end)
    end,
  })

  autoTab:CreateSection("Auto-Fertilizer")

  v37 = false
  v38 = false

  autoTab:CreateToggle({
    Name = "Enable Auto-Fertilizer",
    CurrentValue = false,
    Flag = "BARF_AutoFertilizer",
    Callback = function(value45)
      if value45 then
        if v37 then
          return
        end

        v37 = true
        v38 = false

        task.spawn(function()
          while not v38 do
            local v98 = f2()

            if v98 then
              local v99 = f1()

              if v99 then
                humanoid:EquipTool(v98)
                task.wait(0.5)
                replicatedStorage.Remotes.UseFertilizer:FireServer(v99)
                task.wait(0.5)
                humanoid:UnequipTools()
                task.wait(0.1)
              else
                task.wait(5)
              end
            else
              task.wait(5)
            end
          end

          v37 = false
        end)

        return
      end

      v38 = true
      rayVoid:Notify({ Title = "Stopped", Content = "Auto-fertilizer stopped.", Duration = 3 })
    end,
  })

  function f11()
    local v100 = {}

    for index34, value46 in ipairs(v12:GetDescendants()) do
      if value46:IsA("Model") and value46:GetAttribute("PetKey") ~= nil then
        if value46:GetAttribute("PetOwner") == localPlayer.Name then
          table.insert(v100, value46)
        end
      end
    end

    return v100
  end

  v39 = { "Super Pet Treat", "Strong Pet Treat", "Normal Pet Treat" }

  function f20()
    for index35, value47 in ipairs(v39) do
      for index36, value48 in ipairs(localPlayer.Backpack:GetChildren()) do
        if string.find(value48.Name, value47, 1, true) then
          return value48
        end
      end
    end

    return nil
  end

  autoTab:CreateSection("Auto-Pet Treat")
  v40 = false
  v41 = false

  autoTab:CreateToggle({
    Name = "Enable Auto-Pet Treat",
    CurrentValue = false,
    Flag = "BARF_AutoPetTreat",
    Callback = function(value49)
      if value49 then
        if v40 then
          return
        end

        v40 = true
        v41 = false

        task.spawn(function()
          while not v41 do
            local v101 = f11()

            if #v101 > 0 then
              for index37, value50 in ipairs(v101) do
                if v41 then
                  break
                elseif not value50:GetAttribute("PetBoosted") then
                  local v102 = f20()

                  if v102 then
                    humanoid:EquipTool(v102)
                    task.wait(0.5)
                    replicatedStorage.Remotes.UsePetTreat:FireServer(value50)
                    rayVoid:Notify({ Title = "Pet fed!", Content = value50.Name, Duration = 2 })
                    task.wait(0.5)
                    humanoid:UnequipTools()
                    task.wait(0.1)
                  else
                    task.wait(5)
                    break
                  end
                end
              end
            else
              task.wait(5)
            end

            task.wait(1)
          end

          v40 = false
        end)

        return
      end

      v41 = true
      rayVoid:Notify({ Title = "Stopped", Content = "Auto-pet treat stopped.", Duration = 3 })
    end,
  })

  upgradePlantsTab = barfWindow:CreateTab("Upgrade Plants")
  v42 = 10
  v43 = false
  v44 = false

  function f19()
    upgradePlantsTab:Clear()
    upgradePlantsTab:CreateSection("Per-plant upgrade - select below")

    upgradePlantsTab:CreateInput({
      Name = "Target level",
      PlaceholderText = tostring(v42),
      CurrentValue = "",
      RemoveTextAfterFocusLost = false,
      Flag = "BARF_PerPlantTargetLevel",
      Callback = function(value51)
        local v103 = tonumber(value51)

        if v103 then
          v42 = math.clamp(math.floor(v103), 1, 200)
        end
      end,
    })

    toggle = upgradePlantsTab:CreateToggle({
      Name = "Auto-Upgrade selected plants",
      CurrentValue = false,
      Flag = "BARF_AutoUpgradePlants",
      Callback = function(value52)
        if value52 then
          if v43 then
            return
          end

          if next(v17) == nil then
            rayVoid:Notify({ Title = "Upgrade", Content = "No plants selected.", Duration = 3 })

            if toggle then
              toggle:Set(false)
            end

            return
          end

          v43 = true
          v44 = false

          task.spawn(function()
            while not v44 do
              local v104 = true
              local v105 = {}

              for index38, value53 in ipairs(v18) do
                local v106 = v21[value53.Name]

                if v106 and v17[v106] then
                  local v107 = v19[value53.Name]

                  if v107 then
                    table.insert(v105, { dirt = v107, pName = v106 })
                  end
                end
              end

              for index39, value54 in ipairs(v105) do
                if v44 then
                  break
                else
                  local dirt4 = value54.dirt

                  if (dirt4:GetAttribute("PlantLevel") or 0) >= v42 then
                  else
                    v104 = false

                    local v108, v109 = pcall(function()
                      return replicatedStorage.Remotes.UpgradePlant:InvokeServer(dirt4)
                    end)

                    if not v108 or type(v109) == "boolean" and v109 == false then
                      rayVoid:Notify({
                        Title = "Upgrade",
                        Content = "Refused - waiting 60s",
                        Duration = 5,
                      })

                      f8(true)
                      local count4 = 0

                      while count4 < 60 and not v44 do
                        task.wait(1)
                        count4 = count4 + 1
                      end
                    else
                      task.wait(0.1)
                    end
                  end
                end
              end

              if not v44 and v104 then
                rayVoid:Notify({
                  Title = "Upgrade",
                  Content = "All plants reached level " .. v42,
                  Duration = 4,
                })

                v44 = true

                if toggle then
                  toggle:Set(false)
                end
              end
            end

            v43 = false
          end)

          rayVoid:Notify({
            Title = "Upgrade",
            Content = "Auto-upgrade started (target: Lv." .. v42 .. ")",
            Duration = 3,
          })

          return
        end

        v44 = true
        rayVoid:Notify({ Title = "Upgrade", Content = "Auto-upgrade stopped.", Duration = 3 })
      end,
    })

    upgradePlantsTab:CreateButton({
      Name = "Rescan plants",
      Callback = function()
        f8(false)
        upgradePlantsTab:Clear()
        rayVoid:Notify({ Title = "Upgrade Plants", Content = "Plants rescanned.", Duration = 2 })
      end,
    })

    upgradePlantsTab:CreateButton({
      Name = "Select all",
      Callback = function()
        local v110 = {}

        for index40, value55 in ipairs(v18) do
          local v111 = v21[value55.Name]

          if v111 and not v110[v111] then
            v110[v111] = true
            v17[v111] = true
            local v112 = v20[value55.Name]

            if v112 and not v16[v111] then
              f10(v111, v112)
            end
          end
        end

        rayVoid:Notify({ Title = "Selection", Content = "All plants selected.", Duration = 2 })
      end,
    })

    upgradePlantsTab:CreateButton({
      Name = "Deselect all",
      Callback = function()
        f17()
        v17 = {}
        rayVoid:Notify({ Title = "Selection", Content = "Selection cleared.", Duration = 2 })
      end,
    })

    upgradePlantsTab:CreateCardGrid({
      Items = v18,
      Columns = 4,
      Flag = "BARF_SelectedPlantsUpgrade",
      Callback = function(value56)
        local v113 = {}

        for key10 in pairs(value56) do
          local v114 = v21[key10]

          if v114 then
            v113[v114] = true
          end
        end

        for key11 in pairs(v17) do
          if not v113[key11] then
            v17[key11] = nil
            f3(key11)
          end
        end

        for key12 in pairs(value56) do
          local v115 = v21[key12]

          if v115 and not v17[v115] then
            v17[v115] = true
            local v116 = v20[key12]

            if v116 then
              f10(v115, v116)
            end
          end
        end
      end,
      OnCardCreated = function(p18, p19)
        v22[p18] = p19
        local v117 = v19[p18]

        if not v117 then
          return
        end

        v117:GetAttributeChangedSignal("PlantLevel"):Connect(function()
          local plantLevel3 = v117:GetAttribute("PlantLevel") or 0
          local v118 = v21[p18]
          local d = p18:match("#(%d+)$") or "?"
          local text = "[Lv." .. plantLevel3 .. "] " .. (v118 or "?") .. " #" .. d
          local v119 = v22[p18]

          if v119 and v119.Parent then
            v119.Text = text
          end
        end)
      end,
    })
  end

  task.spawn(function()
    local waitForChild2 = v12:WaitForChild("FarmPlot", 15)

    if waitForChild2 then
      local total = 0

      while #waitForChild2:GetChildren() == 0 and total < 10 do
        task.wait(0.5)
        total = total + 0.5
      end
    end

    task.wait(0.5)
    f8(false)
  end)

  composter = replicatedStorage.Remotes.Composter

  function f21(p20)
    if p20 >= 1000000000000 then
      return string.format("%.2fT", p20 / 1000000000000)
    elseif p20 >= 1000000000 then
      return string.format("%.2fB", p20 / 1000000000)
    else
      if p20 >= 1000000 then
        return string.format("%.2fM", p20 / 1000000)
      end

      return tostring(p20)
    end
  end

  local tab = barfWindow:CreateTab("Seeds to Compost")
  v45 = {}
  local v120 = {}

  for index41, value57 in ipairs(v57) do
    v120[value57] = {}
  end

  for index42, value58 in ipairs(plantsFrame:GetChildren()) do
    if value58:IsA("Frame") then
      value58:FindFirstChild("Icon")
      value58:FindFirstChild("RarityName")
      value58:FindFirstChild("SeedName")
    end
  end

  local v121 = {}

  for index43, value59 in ipairs(v57) do
    if #v120[value59] > 0 then
      table.insert(v121, { Label = value59, Items = v120[value59] })
    end
  end

  filteredCardGrid2 = tab:CreateFilteredCardGrid({
    Groups = v121,
    Columns = 4,
    Flag = "BARF_SelectedCompostSeeds",
    Callback = function(value60) v45 = value60 end,
  })

  tab:CreateButton({
    Name = "Select all (current rarity)",
    Callback = function()
      filteredCardGrid2:SelectAll()

      rayVoid:Notify({
        Title = "Selection",
        Content = "All seeds in group selected.",
        Duration = 2,
      })
    end,
  })

  tab:CreateButton({
    Name = "Deselect all",
    Callback = function()
      filteredCardGrid2:DeselectAll()
      rayVoid:Notify({ Title = "Selection", Content = "Selection cleared.", Duration = 2 })
    end,
  })

  function f22()
    local v122 = {}

    for index44, value61 in ipairs(localPlayer.Backpack:GetChildren()) do
      if value61:IsA("Tool") and value61:GetAttribute("InventoryCategory") == "Seeds" then
        local plant = value61:GetAttribute("Plant") or value61.Name

        if v45[plant] then
          local level = tostring(value61:GetAttribute("Level") or 1)
          local v123 = tostring

          table.insert(v122, {
            plantName = plant,
            level = level,
            mutation = v123(value61:GetAttribute("Mutation") or "Normal"),
          })
        end
      end
    end

    return v122
  end

  local composterTab = barfWindow:CreateTab("Composter")
  v46 = 3

  function f12(p21)
    return v12:FindFirstChild("Composter_" .. p21)
  end

  v47 = false
  v48 = false

  function f23(p22)
    local v124 = f12(p22)

    if not v124 then
      return false
    else
      local primaryPart = v124.PrimaryPart

      if not primaryPart then
        return false
      end

      return primaryPart:FindFirstChild("CompostCooldown") ~= nil
    end
  end

  function f24(p23)
    while f23(p23) and not v48 do
      local v125 = f12(p23)
      local text2 = "?"
      pcall(function() text2 = v125.PrimaryPart.CompostCooldown.TimeRemaining.Text end)

      rayVoid:Notify({
        Title = "Composter F" .. p23,
        Content = "Cooldown: " .. text2 .. "s - waiting...",
        Duration = 2,
      })

      task.wait(0.5)
    end
  end

  composterTab:CreateSection("Floor selection")

  composterTab:CreateDropdown({
    Name = "Composter floor",
    Options = { "Floor 2", "Floor 3", "Floor 4" },
    CurrentOption = { "Floor 3" },
    Flag = "BARF_ComposterFloor",
    Callback = function(value62)
      local v126 = value62[1] or value62

      if v126 == "Floor 2" then
        v46 = 2
      elseif v126 == "Floor 4" then
        v46 = 4
      else
        v46 = 3
      end

      rayVoid:Notify({ Title = "Composter", Content = "Now targeting " .. v126, Duration = 2 })
    end,
  })

  composterTab:CreateSection("Uses seeds selected in 'Seeds to Compost' tab")

  function f25()
    while not v48 do
      local v127 = f22()

      if #v127 == 0 then
        task.wait(5)
      else
        for index45, value63 in ipairs(v127) do
          if v48 then
            break
          end

          f24(v46)

          if v48 then
            break
          else
            local v128 = value63.plantName .. "_" .. value63.level .. "_" .. value63.mutation

            local v129, v130 = pcall(function()
              composter.InsertSeed:InvokeServer(v46, v128, 1)
            end)

            if not v129 then
              rayVoid:Notify({
                Title = "Error",
                Content = "InsertSeed failed: " .. tostring(v130),
                Duration = 3,
              })

              task.wait(0.5)
            else
              task.wait(0.2)
              local invokeServer
              pcall(function() invokeServer = composter.RequestState:InvokeServer(v46) end)

              if invokeServer then
                local v131 = false

                if invokeServer.TooRich then
                  v131 = true

                  rayVoid:Notify({
                    Title = "Composter F" .. v46,
                    Content = "TooRich! Pulling lever... (" .. f21(invokeServer.Value) .. ")",
                    Duration = 3,
                  })
                elseif v46 == 3 and invokeServer.Value >= 25000000000000 then
                  v131 = true

                  rayVoid:Notify({
                    Title = "Composter F3",
                    Content = "25T reached! Pulling lever... (" .. f21(invokeServer.Value)
                      .. ")",
                    Duration = 3,
                  })
                end

                if v131 then
                  pcall(function() composter.PullLever:InvokeServer(v46) end)
                  task.wait(1)
                  break
                end
              end

              task.wait(0.1)
            end
          end
        end
      end
    end

    v47 = false
  end

  composterTab:CreateSection("Auto-Compost")

  composterTab:CreateToggle({
    Name = "Enable Auto-Compost",
    CurrentValue = false,
    Flag = "BARF_AutoCompost",
    Callback = function(value64)
      if value64 then
        if v47 then
          return
        end

        v47 = true
        v48 = false
        task.spawn(f25)

        rayVoid:Notify({
          Title = "Composter",
          Content = "Auto-compost started on Floor " .. v46,
          Duration = 3,
        })

        return
      end

      v48 = true
      rayVoid:Notify({ Title = "Composter", Content = "Auto-compost stopped.", Duration = 3 })
    end,
  })

  composterTab:CreateButton({
    Name = "Insert once (all selected seeds)",
    Callback = function()
      task.spawn(function()
        local v132 = f22()

        if #v132 == 0 then
          rayVoid:Notify({
            Title = "Composter",
            Content = "No seeds selected/found in backpack.",
            Duration = 3,
          })

          return
        elseif f23(v46) then
          rayVoid:Notify({
            Title = "Composter",
            Content = "Cooldown active - wait before inserting.",
            Duration = 3,
          })

          return
        else
          local count5 = 0

          for index46, value65 in ipairs(v132) do
            local v133 = value65.plantName .. "_" .. value65.level .. "_" .. value65.mutation
            pcall(function() composter.InsertSeed:InvokeServer(v46, v133, 1) end)
            count5 = count5 + 1
            task.wait(0.15)
          end

          rayVoid:Notify({
            Title = "Composter",
            Content = count5 .. " seed(s) inserted into Floor " .. v46,
            Duration = 3,
          })

          return
        end
      end)
    end,
  })

  composterTab:CreateSection("Check state")

  composterTab:CreateButton({
    Name = "Request State (current floor)",
    Callback = function()
      task.spawn(function()
        local invokeServer2 = nil
        pcall(function() invokeServer2 = composter.RequestState:InvokeServer(v46) end)

        if invokeServer2 then
          rayVoid:Notify({
            Title = "Floor " .. v46 .. " State",
            Content = "Value: " .. f21(invokeServer2.Value or 0) .. " | TooRich: "
              .. tostring(invokeServer2.TooRich or false),
            Duration = 5,
          })
        else
          rayVoid:Notify({ Title = "Error", Content = "Could not get state.", Duration = 3 })
        end
      end)
    end,
  })

  local sellPetsTab = barfWindow:CreateTab("Sell Pets")
  v49 = {}
  local petsFrame = players.LocalPlayer.PlayerGui.MainUI.Menus.IndexFrame.Main.PetsFrame.PetsFrame
  local v134 = {}

  for index47, value66 in ipairs(petsFrame:GetChildren()) do
    if value66:IsA("Frame") then
      local icon2 = value66:FindFirstChild("Icon")
      local seedName = value66:FindFirstChild("SeedName")
      local text3 = seedName and seedName.Text ~= "???" and seedName.Text or value66.Name
      table.insert(v134, { Name = text3, Icon = icon2 and icon2.Image or "" })
    end
  end

  sellPetsTab:CreateSection("Select pets to sell")

  sellPetsTab:CreateCardGrid({
    Items = v134,
    Columns = 4,
    Flag = "BARF_SelectedPetsToSell",
    Callback = function(value67) v49 = value67 end,
  })

  sellPetsTab:CreateButton({
    Name = "Deselect all",
    Callback = function()
      v49 = {}
      rayVoid:Notify({ Title = "Selection", Content = "Selection cleared.", Duration = 2 })
    end,
  })

  v50 = false
  v51 = false

  function f26()
    local v135 = {}

    for index48, value68 in ipairs(localPlayer.Backpack:GetChildren()) do
      if value68:IsA("Tool") and value68:GetAttribute("InventoryCategory") == "Pets" then
        local trueName = value68:GetAttribute("trueName") or value68.Name
        local petKey = value68:GetAttribute("petKey")

        if v49[trueName] and petKey then
          table.insert(v135, { trueName = trueName, petKey = petKey })
        end
      end
    end

    return v135
  end

  sellPetsTab:CreateSection("Auto-Sell")

  sellPetsTab:CreateToggle({
    Name = "Enable Auto-Sell Pets",
    CurrentValue = false,
    Flag = "BARF_AutoSellPets",
    Callback = function(value69)
      if value69 then
        if v50 then
          return
        end

        v50 = true
        v51 = false

        task.spawn(function()
          while not v51 do
            for index49, value70 in ipairs((f26())) do
              local v136 = value70

              if v51 then
                break
              else
                local v137, v138 = pcall(function()
                  replicatedStorage.Remotes.SellPet:InvokeServer(v136.petKey)
                end)

                if v137 then
                  rayVoid:Notify({ Title = "Pet sold!", Content = v136.trueName, Duration = 2 })
                else
                  rayVoid:Notify({
                    Title = "Error",
                    Content = "SellPet failed: " .. tostring(v138),
                    Duration = 3,
                  })
                end

                task.wait(0.3)
              end
            end

            task.wait(2)
          end

          v50 = false
        end)

        rayVoid:Notify({ Title = "Sell Pets", Content = "Auto-sell started.", Duration = 3 })
        return
      end

      v51 = true
      rayVoid:Notify({ Title = "Sell Pets", Content = "Auto-sell stopped.", Duration = 3 })
    end,
  })

  sellPetsTab:CreateButton({
    Name = "Sell now (one shot)",
    Callback = function()
      task.spawn(function()
        local v139 = f26()

        if #v139 == 0 then
          rayVoid:Notify({
            Title = "Sell Pets",
            Content = "No matching pets in backpack.",
            Duration = 3,
          })

          return
        else
          local count6 = 0

          for index50, value71 in ipairs(v139) do
            local v140 = value71

            if pcall(function() replicatedStorage.Remotes.SellPet:InvokeServer(v140.petKey) end) then
              count6 = count6 + 1
            end

            task.wait(0.3)
          end

          rayVoid:Notify({
            Title = "Sell Pets",
            Content = count6 .. " pet(s) sold.",
            Duration = 3,
          })

          return
        end
      end)
    end,
  })

  local petsTab = barfWindow:CreateTab("Pets")
  v52 = false
  v53 = false

  petsTab:CreateSection("Auto-Optimize Pets")

  petsTab:CreateToggle({
    Name = "Enable Auto-Optimize",
    CurrentValue = false,
    Flag = "BARF_AutoOptimizePets",
    Callback = function(value72)
      if value72 then
        if v52 then
          return
        end

        v52 = true
        v53 = false

        task.spawn(function()
          while not v53 do
            f16()
            local count7 = 0

            while count7 < 30 and not v53 do
              task.wait(1)
              count7 = count7 + 1
            end
          end

          v52 = false
        end)

        rayVoid:Notify({ Title = "Pets", Content = "Auto-optimize started.", Duration = 3 })
        return
      end

      v53 = true
      rayVoid:Notify({ Title = "Pets", Content = "Auto-optimize stopped.", Duration = 3 })
    end,
  })

  petsTab:CreateButton({ Name = "Optimize now", Callback = function() task.spawn(f16) end })

  local infoTab = barfWindow:CreateTab("Info")
  infoTab:CreateSection("Detected plot")
  infoTab:CreateLabel(v12.Name)
  infoTab:CreateSection("Stands on startup")

  for key13, value73 in pairs(f13()) do
    infoTab:CreateLabel(key13 .. "  ->  Stand " .. value73)
  end

  infoTab:CreateSection("Eggs on startup")

  for index51, value74 in ipairs(v66) do
    infoTab:CreateLabel("Podium " .. value74.podiumIdx .. "  ->  " .. value74.name)
  end

  return
end
