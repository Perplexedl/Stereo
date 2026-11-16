local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "YlSsB" / (8238332 - "XMHFRXuQ" ^ 15905766) end) })[2]
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
          pcall(function() return "wCfaOELh" / (13884840 - "1SV" ^ 7556327) end),
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

local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = game:GetService("Players").LocalPlayer

local rayVoid = loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/RayVoidUi/refs/heads/main/RayVoid"))()
rayVoid:MainCredit()
rayVoid:SetScriptName("Unbox-ASMR")

local v12, v13 = pcall(function()
  return require(replicatedStorage:WaitForChild("CrateConfig", 10))
end)

if not v12 or not v13 then
  warn("[UnboxASMR] CrateConfig not found, the crate selector will be empty.")
  v13 = { ByRarity = {} }
end

local v14, v15 = pcall(function()
  return require(replicatedStorage:WaitForChild("InventoryToolConfig", 10))
end)

if not v14 or not v15 then
  warn("[UnboxASMR] InventoryToolConfig not found, cards won't have an icon.")
  v15 = { ImageLabels = { Crates = {} } }
end

local function f1(p1)
  if not p1 then
    return ""
  else
    local crates = v15.ImageLabels and v15.ImageLabels.Crates

    if not crates then
      return ""
    else
      local v16 = crates[p1]

      if typeof(v16) == "string" and v16 ~= "" then
        return v16
      end

      return ""
    end
  end
end

local v17 = {
  "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Divine", "Exotic", "Godly",
  "Celestial", "Transcendant", "Rebirth ASMR", "Exclusive", "Limited",
}

local function f2()
  local v18 = {}

  for index, value in ipairs(v17) do
    local byRarity = v13.ByRarity and v13.ByRarity[value]

    if byRarity and #byRarity > 0 then
      local v19 = {}

      for index2, value2 in ipairs(byRarity) do
        table.insert(v19, { Name = value2.DisplayName, Icon = f1(value2.TemplateName) })
      end

      table.insert(v18, { Label = value, Items = v19 })
    end
  end

  return v18
end

local function f3(p2)
  local buttonPart = p2:FindFirstChild("ButtonPart")
  local humanoidRootPart

  if not buttonPart then
    return false
  else
    local character = localPlayer.Character

    if not character then
      return false
    end

    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then
      return false
    end

    return pcall(function()
      firetouchinterest(humanoidRootPart, buttonPart, 0)
      task.wait(0.1)
      firetouchinterest(humanoidRootPart, buttonPart, 1)
    end)
  end
end

local window = rayVoid:CreateWindow({
  Name = "Unbox-ASMR | AKkiwi",
  LoadingTitle = "Unbox-ASMR",
  LoadingSubtitle = "by AKkiwi",
  ConfigurationSaving = { Enabled = true, FileName = "UnboxASMR" },
})

local autoRollTab = window:CreateTab("AutoRoll", "gamepad-2")
local levelUpTab = window:CreateTab("Level Up", "heart-pulse")
local autoTab = window:CreateTab("AUTO", "zap")
local autoRoll = false
local v20 = false
local v21 = {}

autoRollTab:CreateFilteredCardGrid({
  Groups = f2(),
  Columns = 3,
  Callback = function(value3) v21 = value3 end,
})

local v22 = false
local waitForChild

task.spawn(function()
  if pcall(function()
    waitForChild = replicatedStorage:WaitForChild("PlotSystemRemotes", 15):WaitForChild(
      "ConveyorButtonPress", 15
    )
  end) and waitForChild then
    v22 = true
  else
    warn("[UnboxASMR] Could not resolve ConveyorButtonPress (WaitForChild timeout).")
  end
end)

local v23 = false

local function f4(p3)
  return p3:FindFirstChild("UpgradeConveyorButton")
end

local function f5(p4)
  if typeof(p4) ~= "string" then
    return nil
  else
    local v24, v25 = p4:gsub("[%$,%s]", ""):match("^([%d%.]+)([KMBT]?)$")

    if not v24 then
      return nil
    else
      local v26 = tonumber(v24)

      if not v26 then
        return nil
      else
        local v27 = {
          K = 1000,
          M = 1000000,
          B = 1000000000,
          T = 1000000000000,
        }

        if v25 ~= "" and v27[v25] then
          v26 = v26 * v27[v25]
        end

        return math.floor(v26)
      end
    end
  end
end

local waitForChild2, waitForChild3, waitForChild4

task.spawn(function()
  if pcall(function()
    local waitForChild5 = replicatedStorage:WaitForChild("CratePlacementRemotes", 15)
    waitForChild2 = waitForChild5:WaitForChild("RequestPlaceCrate", 15)
    waitForChild3 = waitForChild5:WaitForChild("PlacementResult", 15)
    waitForChild4 = replicatedStorage:WaitForChild("CratePlacementPreviews", 15)
  end) and waitForChild2 and waitForChild3 and waitForChild4 then
    v23 = true
  else
    warn("[UnboxASMR] Could not resolve CratePlacementRemotes/CratePlacementPreviews.")
  end
end)

local function f6()
  local plots = workspace:FindFirstChild("Plots")

  if not plots then
    return nil
  else
    local activePlots = plots:FindFirstChild("ActivePlots")

    if not activePlots then
      return nil
    end

    for index3, value4 in ipairs(activePlots:GetChildren()) do
      if value4:IsA("Model") and value4:GetAttribute("OwnerUserId") == localPlayer.UserId then
        return value4
      end
    end

    return nil
  end
end

local function f7(p5)
  local conveyor = p5:FindFirstChild("Conveyor")

  if not conveyor then
    return nil, nil, false
  else
    local activeCrates = conveyor:FindFirstChild("ActiveCrates")

    if not activeCrates then
      return nil, nil, false
    else
      local getChildren = activeCrates:GetChildren()

      if #getChildren == 0 then
        return nil, nil, false
      end

      for index4, value5 in ipairs(getChildren) do
        local main = value5:FindFirstChild("Main")

        if main then
          local crateBuyPrompt = main:FindFirstChild("CrateBuyPrompt")

          if crateBuyPrompt and crateBuyPrompt:IsA("ProximityPrompt") and crateBuyPrompt.Enabled then
            return value5, crateBuyPrompt, true
          end
        end
      end

      return nil, nil, true
    end
  end
end

local function f8(p6)
  local placement = p6:FindFirstChild("Placement")

  if not placement then
    return nil
  else
    local bounds = placement:FindFirstChild("Bounds")

    if bounds and bounds:IsA("BasePart") then
      return bounds
    end

    return nil
  end
end

local f9

local function f10()
  if v20 then
    return
  end

  v20 = true

  while autoRoll do
    local v28, v29 = pcall(function()
      local v30

      if not v22 then
        task.wait(0.5)
        return
      else
        local v31 = f6()

        if not v31 then
          warn("[UnboxASMR] Plot not found, retrying...")
          task.wait(1)
          return
        else
          local v32, v33
          v33, v30, v32 = f7(v31)

          if not v33 then
            if not v32 then
              pcall(function() waitForChild:FireServer() end)
            end

            task.wait(0.25)
            return
          else
            local displayName = v33:GetAttribute("DisplayName")
            local price = v33:GetAttribute("Price") or 0
            local cash = localPlayer:GetAttribute("Cash") or 0

            if displayName and v21[displayName] and cash >= price then
              f9(v33)
              task.wait(0.3)

              if not pcall(function() fireproximityprompt(v30) end) then
                warn("[UnboxASMR] fireproximityprompt failed on " .. tostring(v33.Name))
              end

              task.wait(0.4)
            else
              if displayName and v21[displayName] and cash < price then
                warn("[UnboxASMR] Not enough cash for " .. displayName .. " (" .. tostring(price)
                  .. ", have: " .. tostring(cash) .. ")")
              end

              pcall(function() waitForChild:FireServer() end)
              task.wait(0.25)
            end

            return
          end
        end
      end
    end)

    if not v28 then
      warn("[UnboxASMR] Loop error: " .. tostring(v29))
      task.wait(1)
    end
  end

  v20 = false
end

function f9(p7)
  local character2 = localPlayer.Character

  if not character2 then
    return false
  else
    local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart2 then
      return false
    else
      local main2 = p7:FindFirstChild("Main")

      if not main2 then
        return false
      end

      humanoidRootPart2.CFrame = main2.CFrame + Vector3.new(0, 3, 0)
      return true
    end
  end
end

local function f11(p8)
  local attachment = p8:FindFirstChild("Attachment")

  if not attachment then
    return nil
  else
    local billboardGui = attachment:FindFirstChild("BillboardGui")

    if not billboardGui then
      return nil
    else
      local frame = billboardGui:FindFirstChild("Frame")

      if not frame then
        return nil
      else
        local cashLabel = frame:FindFirstChild("CashLabel")

        if not cashLabel or not cashLabel:IsA("TextLabel") then
          return nil
        end

        return f5(cashLabel.Text)
      end
    end
  end
end

local v34 = false
local v35 = false

local function f12()
  if v35 then
    return
  end

  v35 = true

  while v34 do
    local v36, v37 = pcall(function()
      local v38 = f6()

      if not v38 then
        warn("[UnboxASMR] Plot not found (upgrade), retrying...")
        task.wait(5)
        return
      else
        local v39 = f4(v38)

        if not v39 then
          task.wait(5)
          return
        else
          local v40 = f11(v39)

          if v40 and (localPlayer:GetAttribute("Cash") or 0) >= v40 then
            if not f3(v39) then
              warn("[UnboxASMR] firetouchinterest failed on UpgradeConveyorButton")
            end

            task.wait(1)
          else
            task.wait(5)
          end

          return
        end
      end
    end)

    if not v36 then
      warn("[UnboxASMR] Upgrade loop error: " .. tostring(v37))
      task.wait(5)
    end
  end

  v35 = false
end

local v41 = false
local waitForChild6, waitForChild7, waitForChild8

task.spawn(function()
  if pcall(function()
    waitForChild6 = replicatedStorage:WaitForChild("ASMRRewardRemotes", 15)
    waitForChild7 = waitForChild6:WaitForChild("RequestInteraction", 15)
    waitForChild8 = waitForChild6:WaitForChild("RequestUpgrade", 15)
  end) and waitForChild7 and waitForChild8 then
    v41 = true
  else
    warn("[UnboxASMR] Could not resolve ASMRRewardRemotes.RequestInteraction/RequestUpgrade.")
  end
end)

local function f13(p9, p10)
  local v42 = {}

  if p10.effect == "wax" then
    local normalKeys = p9:FindFirstChild("NormalKeys")

    if normalKeys then
      for index5, value6 in ipairs(normalKeys:GetChildren()) do
        if value6:IsA("BasePart") then
          table.insert(v42, value6)
        end
      end
    end
  elseif p10.effect == "typewriter" then
    for index6, value7 in ipairs(p9:GetDescendants()) do
      if value7:IsA("Model") and value7.Name == "Key" then
        local v43 = 0
        local v44 = nil

        for index7, value8 in ipairs(value7:GetDescendants()) do
          if value8:IsA("BasePart") then
            local v45 = value8.Size.X * value8.Size.Z

            if v45 > v43 then
              v44 = value8
              v43 = v45
            end
          end
        end

        if v44 then
          table.insert(v42, v44)
        end
      end
    end
  else
    for index8, value9 in ipairs(p9:GetDescendants()) do
      if value9:IsA("MeshPart") and value9.Name == (p10.keyName or "Key") then
        table.insert(v42, value9)
      end
    end
  end

  return v42
end

local v46 = {
  ["Candy Keyboard"] = { keyName = "Key" },
  ["67 Keyboard"] = { keyName = "Key" },
  ["Chocolate Keyboard"] = { keyName = "Key" },
  ["Stone Keyboard"] = { keyName = "Key" },
  ["Wood Keyboard"] = { keyName = "Key" },
  ["Rainbow Keyboard"] = { keyName = "Key" },
  ["Prismwave Keyboard"] = { keyName = "Key" },
  ["RGB Keyboard"] = { keyName = "Key" },
  ["Lightning Keyboard"] = { keyName = "Key" },
  ["Chroma Keyboard"] = { keyName = "Key" },
  ["Honey Keyboard"] = { keyName = "Key" },
  ["Honeycomb Keyboard"] = { keyName = "Key" },
  ["Slime Keyboard"] = { keyName = "Key" },
  ["Water Keyboard"] = { keyName = "Key" },
  ["Typewriter Keyboard"] = { effect = "typewriter" },
  ["Dumpling Keyboard"] = { keyName = "DumplingKey" },
  ["Squishy Dumpling Keyboard"] = { keyName = "DumplingKey" },
  ["Wax Keyboard"] = { effect = "wax" },
}

local function f14(p11)
  local asmr = p11:FindFirstChild("ASMR")

  if not asmr then
    return {}
  else
    local v47 = {}

    for index9, value10 in ipairs(asmr:GetChildren()) do
      if value10:IsA("Model") then
        local asmrDisplayName = value10:GetAttribute("ASMRDisplayName")
        local v48 = asmrDisplayName and v46[asmrDisplayName]

        if v48 then
          table.insert(v47, { model = value10, config = v48 })
        end
      end
    end

    return v47
  end
end

local function f15(p12, p13)
  local lower = p13:lower()

  for index10, value11 in ipairs(p12:GetDescendants()) do
    if value11.Name:lower() == lower then
      return value11
    end
  end

  return nil
end

local function f16(p14)
  if not p14 or not waitForChild4 then
    return nil
  else
    local findFirstChild = waitForChild4:FindFirstChild(p14)

    if not findFirstChild or not findFirstChild:IsA("Model") then
      return nil
    else
      local v49 = { findFirstChild:GetBoundingBox() }
      return v49[2]
    end
  end
end

local function f17(p15, p16, p17)
  local cframe = CFrame.new(0, p15.Size.Y / 2, 0)
  local cframe2 = CFrame.new(Vector3.new(p17.X, (p15.CFrame * cframe).Position.Y, p17.Z))
  local v50 = math.max(p16.X * 0.92, 0.5)
  local v51 = math.max(p16.Z * 0.92, 0.5)
  return cframe2 * (p15.CFrame - p15.CFrame.Position), Vector3.new(v50, 1.4, v51)
end

local v52 = false

local function f18(p18, p19)
  local cframe3 = CFrame.new(0, p18.Size.Y / 2, 0)

  return CFrame.new(Vector3.new(p19.X, (p18.CFrame * cframe3).Position.Y, p19.Z))
    * (p18.CFrame - p18.CFrame.Position)
end

local function f19(filterDescendantsInstances, p20, p21)
  local overlapParams = OverlapParams.new()
  overlapParams.FilterType = Enum.RaycastFilterType.Include
  overlapParams.FilterDescendantsInstances = filterDescendantsInstances
  overlapParams.RespectCanCollide = false

  return workspace:GetPartBoundsInBox(p20, p21, overlapParams)
end

local function f20(p22, p23)
  local character3 = localPlayer.Character
  local humanoid

  if not character3 then
    return false
  else
    humanoid = character3:FindFirstChildOfClass("Humanoid")
    local v53 = not humanoid
    local humanoidRootPart3 = character3:FindFirstChild("HumanoidRootPart")

    if v53 or not humanoidRootPart3 then
      return false
    elseif p22.Parent ~= character3 then
      if not pcall(function() humanoid:EquipTool(p22) end) then
        return false
      end

      humanoidRootPart3.CFrame = p23 + Vector3.new(0, 3, 0)
      return true
    else
      humanoidRootPart3.CFrame = p23 + Vector3.new(0, 3, 0)
      return true
    end
  end
end

local v54 = false

local function f21()
  if v54 then
    return
  end

  v54 = true

  while v52 do
    local v55, v56 = pcall(function()
      if not v41 then
        task.wait(1)
        return
      else
        local v57 = f6()

        if not v57 then
          warn("[UnboxASMR] Plot not found (farm ASMR), retrying...")
          task.wait(1)
          return
        else
          local v58 = f14(v57)

          if #v58 == 0 then
            task.wait(2)
            return
          end

          for index11, value12 in ipairs(v58) do
            local v59 = value12

            if not v52 then
              break
            end

            for index12, value13 in ipairs((f13(v59.model, v59.config))) do
              local v60 = value13

              if not v52 then
                break
              end

              pcall(function()
                waitForChild7:FireServer(v59.model, v60, "Keyboard", v60.Position)
              end)

              task.wait(0.15)
            end
          end

          return
        end
      end
    end)

    if not v55 then
      warn("[UnboxASMR] Farm ASMR loop error: " .. tostring(v56))
      task.wait(1)
    end
  end

  v54 = false
end

local function f22(p24, p25, p26, p27, p28)
  local placement2 = p24:FindFirstChild("Placement")

  if not placement2 then
    return false
  else
    local unlocked = placement2:FindFirstChild("Unlocked")
    local locked = placement2:FindFirstChild("Locked")

    if not unlocked then
      return false
    else
      local v61, v62 = f17(p25, p26, p27)
      local v63 = false

      for index13, value14 in ipairs(f19({ unlocked }, v61, v62)) do
        if value14:IsA("BasePart") and value14:GetAttribute("Placeable") == true then
          v63 = true
          break
        end
      end

      if not v63 then
        return false
      end

      if locked then
        for index14, value15 in ipairs(f19({ locked }, v61, v62)) do
          if value15:IsA("BasePart") and value15:GetAttribute("Placeable") ~= true then
            return false
          end
        end
      end

      for index15, value16 in ipairs(p28) do
        local findFirstChild2 = p24:FindFirstChild(value16)

        if findFirstChild2 then
          for index16, value17 in ipairs(f19({ findFirstChild2 }, v61, v62)) do
            if value17:IsA("BasePart") then
              return false
            end
          end
        end
      end

      return true
    end
  end
end

local function f23()
  local backpack = localPlayer:FindFirstChild("Backpack")

  if backpack then
    for index17, value18 in ipairs(backpack:GetChildren()) do
      if value18:IsA("Tool") and value18:GetAttribute("IsCrateTool") == true then
        return value18
      end
    end
  end

  local character4 = localPlayer.Character

  if character4 then
    for index18, value19 in ipairs(character4:GetChildren()) do
      if value19:IsA("Tool") and value19:GetAttribute("IsCrateTool") == true then
        return value19
      end
    end

    return nil
  end

  return nil
end

local function f24(p29)
  local v64 = false
  local v65 = false

  local connect = waitForChild3.OnClientEvent:Connect(function(p30)
    v64 = true
    v65 = p30 and true or false
  end)

  if not pcall(function() waitForChild2:FireServer(p29) end) then
    connect:Disconnect()
    return false
  else
    local total = 0

    while not v64 and total < 2 do
      task.wait(0.05)
      total = total + 0.05
    end

    connect:Disconnect()
    return v65
  end
end

local function f25(p31, p32, p33, p34, p35, p36)
  local v66 = math.max(p32.Size.X / 2 - p33.X / 2 - 0.5, 0)
  local v67 = math.max(p32.Size.Z / 2 - p33.Z / 2 - 0.5, 0)
  local v68 = p32.CFrame * CFrame.new(0, p32.Size.Y / 2, 0)
  local v69 = {}
  local v70 = -v66

  while v70 <= v66 do
    local v71 = -v67

    while v71 <= v67 do
      table.insert(v69, v68:PointToWorldSpace(Vector3.new(v70, 0, v71)))
      v71 = v71 + p34
    end

    v70 = v70 + p34
  end

  local position = v68.Position

  table.sort(v69, function(p37, p38)
    return (p37 - position).Magnitude < (p38 - position).Magnitude
  end)

  for index19, value20 in ipairs(v69) do
    local v72 = false

    if p35 then
      for index20, value21 in ipairs(p35) do
        if (value20 - value21).Magnitude < 0.75 then
          v72 = true
          break
        end
      end
    end

    if not v72 and f22(p31, p32, p33, value20, p36) then
      return f18(p32, value20)
    end
  end

  return nil
end

local function f26(p39, p40, p41, p42, p43)
  return f25(p39, p40, p41, p42, p43, { "PlacedCrates" })
end

local function f27(p44)
  local character5 = localPlayer.Character

  if not character5 then
    return false
  else
    local humanoidRootPart4 = character5:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart4 then
      return false
    else
      local main3 = p44:FindFirstChild("Main")

      if not main3 then
        return false
      end

      humanoidRootPart4.CFrame = main3.CFrame + Vector3.new(0, 3, 0)
      return true
    end
  end
end

local v73 = false
local v74 = false
local v75 = {}
local v76 = 30

local function f28()
  if v74 then
    return
  end

  v74 = true

  while v73 do
    local v77, v78 = pcall(function()
      if not v23 then
        task.wait(0.5)
        return
      else
        local v79 = f23()

        if not v79 then
          task.wait(0.5)
          return
        else
          local v80 = f6()

          if not v80 then
            warn("[UnboxASMR] Plot not found (placement), retrying...")
            task.wait(1)
            return
          else
            local v81 = f8(v80)

            if not v81 then
              warn("[UnboxASMR] Bounds not found (placement), retrying...")
              task.wait(1)
              return
            else
              local crateTemplateName = v79:GetAttribute("CrateTemplateName")
              local v82 = f16(crateTemplateName)

              if not v82 then
                warn("[UnboxASMR] Footprint not found for " .. tostring(crateTemplateName))
                task.wait(0.5)
                return
              else
                local v83 = f26(v80, v81, v82, 1.5, v75)

                if not v83 then
                  warn("[UnboxASMR] No valid spot found to place the crate (plot full?).")
                  task.wait(2)
                  return
                end

                if not f20(v79, v83) then
                  warn("[UnboxASMR] Could not equip the Tool or teleport the player.")
                  task.wait(0.5)
                  return
                end

                task.wait(0.15)

                if not f24(v83) then
                  warn("[UnboxASMR] Crate placement rejected by the server.")
                  table.insert(v75, v83.Position)

                  if #v75 > v76 then
                    table.remove(v75, 1)
                  end
                end

                task.wait(0.5)
                return
              end
            end
          end
        end
      end
    end)

    if not v77 then
      warn("[UnboxASMR] Placement loop error: " .. tostring(v78))
      task.wait(1)
    end
  end

  v74 = false
end

local function f29(p45)
  local placedCrates = p45:FindFirstChild("PlacedCrates")

  if not placedCrates then
    return nil, nil
  end

  for index21, value22 in ipairs(placedCrates:GetChildren()) do
    if value22:GetAttribute("Ready") == true then
      local main4 = value22:FindFirstChild("Main")

      if main4 then
        local openCratePrompt = main4:FindFirstChild("OpenCratePrompt")

        if openCratePrompt and openCratePrompt:IsA("ProximityPrompt")
          and openCratePrompt.Enabled then
          return value22, openCratePrompt
        end
      end
    end
  end

  return nil, nil
end

local v84 = false
local v85 = false

local function f30()
  if v85 then
    return
  end

  v85 = true

  while v84 do
    local v86, v87 = pcall(function()
      local v88 = f6()
      local v89

      if not v88 then
        warn("[UnboxASMR] Plot not found (unbox), retrying...")
        task.wait(1)
        return
      else
        local v90
        v90, v89 = f29(v88)

        if not v90 then
          task.wait(0.5)
          return
        end

        if not f27(v90) then
          warn("[UnboxASMR] Teleport failed to open " .. tostring(v90.Name))
          task.wait(0.5)
          return
        end

        task.wait(0.15)

        if not pcall(function() fireproximityprompt(v89) end) then
          warn("[UnboxASMR] fireproximityprompt failed on " .. tostring(v90.Name))
        end

        task.wait(0.4)
        return
      end
    end)

    if not v86 then
      warn("[UnboxASMR] Unbox loop error: " .. tostring(v87))
      task.wait(1)
    end
  end

  v85 = false
end

local function f31(p46)
  local v91 = f15(p46, "UpgradeStand")

  if not v91 then
    return nil
  else
    local v92 = f15(v91, "Cost")

    if not v92 or not v92:IsA("TextLabel") then
      return nil
    end

    return f5(v92.Text)
  end
end

local color = Color3.fromRGB(180, 60, 255)

local function f32(p47, p48)
  local unboxASMRSelectMarker = p47:FindFirstChild("UnboxASMR_SelectMarker")

  if not p48 then
    if unboxASMRSelectMarker then
      unboxASMRSelectMarker:Destroy()
    end

    return
  elseif unboxASMRSelectMarker then
    return
  else
    local v93, v94, v95 = pcall(function() return p47:GetBoundingBox() end)
    local v96 = 4

    if v93 and v95 then
      v96 = v95.Y / 2 + 1.5
    end

    local unboxASMRSelectMarker2 = Instance.new("BillboardGui")
    unboxASMRSelectMarker2.Name = "UnboxASMR_SelectMarker"
    unboxASMRSelectMarker2.Adornee = p47.PrimaryPart or p47:FindFirstChildWhichIsA("BasePart")
    unboxASMRSelectMarker2.Size = UDim2.fromOffset(20, 20)
    unboxASMRSelectMarker2.StudsOffsetWorldSpace = Vector3.new(0, v96, 0)
    unboxASMRSelectMarker2.AlwaysOnTop = true
    unboxASMRSelectMarker2.Parent = p47

    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.fromScale(1, 1)
    frame2.BackgroundColor3 = color
    frame2.BorderSizePixel = 0
    frame2.Parent = unboxASMRSelectMarker2

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = frame2

    return
  end
end

local function f33()
  local v97 = {}
  local v98 = {}
  local v99, v100 = pcall(function() return game:GetService("CoreGui") end)

  if v99 and v100 then
    table.insert(v98, v100)
  end

  local playerGui = localPlayer:FindFirstChild("PlayerGui")

  if playerGui then
    table.insert(v98, playerGui)
  end

  for index22, value23 in ipairs(v98) do
    local v101 = value23
    local v102, v103 = pcall(function() return v101:GetDescendants() end)

    if v102 then
      for index23, value24 in ipairs(v103) do
        if value24.Name == "CardGrid" then
          table.insert(v97, value24)
        end
      end
    end
  end

  return v97
end

local v104 = {}
local v105 = {}
local v106 = {}
local v107 = 100
local cardGrid, f34

local function f35()
  local items = f34((f6()))

  for index24, value25 in ipairs((f33())) do
    value25:Destroy()
  end

  cardGrid = levelUpTab:CreateCardGrid({
    Items = items,
    Columns = 3,
    Callback = function(value26)
      local v108 = {}

      for key, value27 in pairs(value26) do
        local v109 = v106[key]

        if v109 and value27 then
          v108[v109] = true
        end
      end

      v104 = v108

      for key2, value28 in pairs(v105) do
        f32(value28.model, v104[key2] == true)
      end
    end,
  })

  if cardGrid and next(v104) then
    local v110 = {}

    for key3, value29 in pairs(v105) do
      if v104[key3] then
        v110[value29.name] = true
      end
    end

    if next(v110) then
      cardGrid:SetSelected(v110)
    end
  end
end

function f34(p49)
  local asmr2 = p49
  local v111 = {}
  v105 = {}
  v106 = {}
  asmr2 = p49 and p49:FindFirstChild("ASMR")

  if not asmr2 then
    return v111
  end

  for index25, value30 in ipairs(asmr2:GetChildren()) do
    if value30:IsA("Model") then
      local placedASMRId = value30:GetAttribute("PlacedASMRId")
      local asmrDisplayName2 = value30:GetAttribute("ASMRDisplayName")
      local asmrTemplateName = value30:GetAttribute("ASMRTemplateName")

      if placedASMRId and asmrDisplayName2 and asmrTemplateName
        and value30:GetAttribute("OwnerUserId") == localPlayer.UserId then
        local v112 = asmrDisplayName2 .. " Lvl " .. (value30:GetAttribute("ASMRLevel") or 0)
          .. " #" .. string.sub(placedASMRId, 1, 6)

        local icon = ""

        if v15 and v15.ImageLabels and v15.ImageLabels.ASMR then
          local v113 = v15.ImageLabels.ASMR[asmrTemplateName]

          if typeof(v113) == "string" then
            icon = v113
          end
        end

        table.insert(v111, { Name = v112, Icon = icon })
        v105[placedASMRId] = { model = value30, name = v112 }
        v106[v112] = placedASMRId
      end
    end
  end

  return v111
end

task.spawn(function()
  local v114

  while not v114 do
    v114 = f6()

    if not v114 then
      task.wait(1)
    end
  end

  local asmr3 = v114:FindFirstChild("ASMR")

  local waitForChild9 = asmr3
  waitForChild9 = asmr3 or v114:WaitForChild("ASMR", 30)

  f35()

  if waitForChild9 then
    waitForChild9.ChildAdded:Connect(function()
      task.wait(0.2)
      f35()
    end)

    waitForChild9.ChildRemoved:Connect(function()
      task.wait(0.2)
      f35()
    end)
  end
end)

local v115 = false
local v116 = false
local v117 = {}

local function f36()
  if v116 then
    return
  end

  v116 = true

  while v115 do
    local v118, v119 = pcall(function()
      if not v41 then
        task.wait(1)
        return
      else
        local v120 = false
        local v121 = false

        for key4, value31 in pairs(v104) do
          if value31 then
            local v122 = v105[key4]

            if v122 and v122.model.Parent then
              v120 = true
              local asmrLevel = v122.model:GetAttribute("ASMRLevel") or 0
              local asmrMaxLevel = v122.model:GetAttribute("ASMRMaxLevel") or math.huge

              if asmrLevel < math.min(asmrMaxLevel, v107) then
                v117[key4] = nil
                local v123 = f31(v122.model)

                if v123 and (localPlayer:GetAttribute("Cash") or 0) >= v123 then
                  pcall(function() waitForChild8:FireServer(v122.model) end)
                  task.wait(0.3)
                end
              elseif not v117[key4] then
                v117[key4] = true
                v121 = true
              end
            end
          end
        end

        if v121 then
          f35()
        end

        task.wait(v120 and 0.5 or 3)
        return
      end
    end)

    if not v118 then
      warn("[UnboxASMR] LevelUp loop error: " .. tostring(v119))
      task.wait(3)
    end
  end

  v116 = false
end

local v124 = false
local waitForChild10

task.spawn(function()
  if pcall(function()
    waitForChild10 = replicatedStorage:WaitForChild("RebirthRemotes", 15):WaitForChild(
      "RequestRebirth", 15
    )
  end) and waitForChild10 then
    v124 = true
  else
    warn("[UnboxASMR] Could not resolve RebirthRemotes.RequestRebirth (WaitForChild timeout).")
  end
end)

local autoRebirth = false
local v125 = false
local v126 = 60

local function f37()
  if v125 then
    return
  end

  v125 = true

  while autoRebirth do
    local v127, v128 = pcall(function()
      if not v124 then
        task.wait(1)
        return
      end

      pcall(function() waitForChild10:InvokeServer() end)
      task.wait(v126)
    end)

    if not v127 then
      warn("[UnboxASMR] Rebirth loop error: " .. tostring(v128))
      task.wait(v126)
    end
  end

  v125 = false
end

autoRollTab:CreateToggle({
  Name = "Auto Roll",
  CurrentValue = false,
  Flag = "UnboxASMR_AutoRoll",
  Callback = function(value32)
    autoRoll = value32

    if autoRoll then
      task.spawn(f10)
    end
  end,
})

autoTab:CreateToggle({
  Name = "Auto Upgrade Conveyor",
  CurrentValue = false,
  Flag = "UnboxASMR_AutoUpgradeConveyor",
  Callback = function(value33)
    v34 = value33

    if v34 then
      task.spawn(f12)
    end
  end,
})

autoTab:CreateToggle({
  Name = "Auto Rebirth",
  CurrentValue = false,
  Flag = "UnboxASMR_AutoRebirth",
  Callback = function(value34)
    autoRebirth = value34

    if autoRebirth then
      task.spawn(f37)
    end
  end,
})

autoTab:CreateToggle({
  Name = "Auto Press Keyboards",
  CurrentValue = false,
  Flag = "UnboxASMR_AutoFarmASMR",
  Callback = function(value35)
    v52 = value35

    if v52 then
      task.spawn(f21)
    end
  end,
})

autoTab:CreateToggle({
  Name = "Auto Place Crates",
  CurrentValue = false,
  Flag = "UnboxASMR_AutoPlaceCrates",
  Callback = function(value36)
    v73 = value36

    if v73 then
      task.spawn(f28)
    end
  end,
})

autoTab:CreateToggle({
  Name = "Auto Unbox Crates",
  CurrentValue = false,
  Flag = "UnboxASMR_AutoUnboxCrates",
  Callback = function(value37)
    v84 = value37

    if v84 then
      task.spawn(f30)
    end
  end,
})

levelUpTab:CreateInput({
  Name = "Target Level",
  CurrentValue = tostring(v107),
  PlaceholderText = "e.g. 50",
  RemoveTextAfterFocusLost = false,
  Flag = "UnboxASMR_TargetLevel",
  Callback = function(value38)
    local v129 = tonumber(value38)

    if v129 then
      v107 = math.floor(math.clamp(v129, 1, 100))
      v117 = {}
    end
  end,
})

levelUpTab:CreateToggle({
  Name = "Auto Level Up",
  CurrentValue = false,
  Flag = "UnboxASMR_AutoLevelUp",
  Callback = function(value39)
    v115 = value39

    if v115 then
      task.spawn(f36)
    end
  end,
})
