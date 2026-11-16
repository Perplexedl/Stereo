local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local v5 = { IsAutoCollectAndSellBoxesLoopRunning = false }
local v6 = { Remotes = {} }
local v7 = {}

local function f1(p1)
  if v6.Remotes[p1] then
    return v6.Remotes[p1]
  end

  local remotes = replicatedStorage:FindFirstChild("Remotes")

  if remotes then
    local findFirstChild = remotes:FindFirstChild(p1)

    if findFirstChild then
      v6.Remotes[p1] = findFirstChild
      return findFirstChild
    end
  end

  local findFirstChild2 = replicatedStorage:FindFirstChild(p1, true)

  if findFirstChild2
    and (findFirstChild2:IsA("RemoteEvent") or findFirstChild2:IsA("RemoteFunction")) then
    v6.Remotes[p1] = findFirstChild2
    return findFirstChild2
  end

  return nil
end

local function f2(p2, ...)
  local v8 = f1(p2)

  if not v8 then
    return
  end

  if v8:IsA("RemoteEvent") then
    pcall(v8.FireServer, v8, ...)
  elseif v8:IsA("RemoteFunction") then
    pcall(v8.InvokeServer, v8, ...)
  end
end

local function f3()
  local v9 = tonumber(localPlayer:GetAttribute("PlotNumber")
    or localPlayer:FindFirstChild("PlotNumber") and localPlayer.PlotNumber.Value)

  if not v9 or v9 == 0 then
    return nil
  end

  local map = workspace:FindFirstChild("MAP")
  local plots = map and map:FindFirstChild("Plots")
  local findFirstChild3 = plots and plots:FindFirstChild(tostring(v9))

  if findFirstChild3 then
    return findFirstChild3:FindFirstChild("Plot_N0")
  end

  return nil
end

local function f4(p3)
  local character = localPlayer.Character
  local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart and p3 then
    humanoidRootPart.CFrame = p3
  end
end

local function f5(p4)
  local character2 = localPlayer.Character
  local humanoid = character2 and character2:FindFirstChildOfClass("Humanoid")

  if humanoid and p4 and p4:IsA("Tool") and p4.Parent ~= character2 then
    humanoid:EquipTool(p4)
  end
end

local function f6(p5)
  if not p5 or not p5:IsA("ProximityPrompt") or not p5.Enabled then
    return
  end

  if typeof(fireproximityprompt) == "function" then
    pcall(fireproximityprompt, p5)
  else
    pcall(function()
      p5:InputHoldBegin()
      task.wait(p5.HoldDuration or 0.1)
      p5:InputHoldEnd()
    end)
  end
end

local function f7()
  local v10 = {}
  local backpack = localPlayer:FindFirstChild("Backpack")
  local character3 = localPlayer.Character

  if character3 then
    for index, value in ipairs(character3:GetChildren()) do
      if value:IsA("Tool") and (value:GetAttribute("BoxValue") ~= nil or value.Name:find("Box")) then
        table.insert(v10, value)
      end
    end
  end

  if backpack then
    for index2, value2 in ipairs(backpack:GetChildren()) do
      if value2:IsA("Tool")
        and (value2:GetAttribute("BoxValue") ~= nil or value2.Name:find("Box")) then
        table.insert(v10, value2)
      end
    end
  end

  return v10
end

local function f8()
  if v5.IsAutoCollectAndSellBoxesLoopRunning
    or not (v1.Options.Toggle_Farm_AutoCollectAndSellBoxes
      and v1.Options.Toggle_Farm_AutoCollectAndSellBoxes.Value) then
    return
  end

  v5.IsAutoCollectAndSellBoxesLoopRunning = true

  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Farm_AutoCollectAndSellBoxes
      and v1.Options.Toggle_Farm_AutoCollectAndSellBoxes.Value do
      pcall(function()
        local v11 = f3()

        if v11 then
          local proxiBox = v11:FindFirstChild("ProxiBox")
            or v11:FindFirstChild("BoxBaseModel")
              and v11.BoxBaseModel:FindFirstChild("ProxiBox")

          if proxiBox then
            local proximityPrompt = proxiBox:FindFirstChildOfClass("ProximityPrompt")

            if proximityPrompt and proximityPrompt.Enabled then
              f4(proxiBox.CFrame * CFrame.new(0, 3, 0))
              task.wait(0.2)
              f6(proximityPrompt)
              task.wait(0.5)
            end
          end

          local sellPart = v11:FindFirstChild("SellPart")

          if sellPart then
            f4(sellPart.CFrame * CFrame.new(0, 3, 0))
            task.wait(0.1)
            local proximityPrompt2 = sellPart:FindFirstChildOfClass("ProximityPrompt")

            if proximityPrompt2 then
              f6(proximityPrompt2)
            end
          end

          for index3, value3 in ipairs((f7())) do
            if not (v1.Options.Toggle_Farm_AutoCollectAndSellBoxes
              and v1.Options.Toggle_Farm_AutoCollectAndSellBoxes.Value) then
              break
            end

            if value3 and value3.Parent then
              f5(value3)
              task.wait(0.3)

              if sellPart then
                local proximityPrompt3 = sellPart:FindFirstChildOfClass("ProximityPrompt")

                if proximityPrompt3 then
                  f6(proximityPrompt3)
                end
              end

              f2("SellRE", "SellHand")
              task.wait(0.3)
            end
          end
        end
      end)

      task.wait(10)
    end

    v5.IsAutoCollectAndSellBoxesLoopRunning = false
  end)
end

local window = v1:CreateWindow({ Title = "Anime Card Farm", SubTitle = "by Lamduck" })

local v12 = {
  Farm = window:AddTab({ Title = "Farm", Icon = "sprout" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

v12.Farm:AddSection("Card Box Farming")

v12.Farm:AddToggle("Toggle_Farm_AutoCollectAndSellBoxes", {
  Title = "Auto Collect & Sell Card Boxes",
  Default = false,
  Callback = function(value4)
    if value4 then
      f8()
    end
  end,
})

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/AnimeCardFarm")
v4:SetFolder("Lamduck/AnimeCardFarm")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v12.Settings)
v3:BuildInterfaceSection(v12.Settings)
v2:BuildConfigSection(v12.Settings)

v1.OnUnload:Once(function()
  for index4, value5 in ipairs(v7) do
    if typeof(value5) == "RBXScriptConnection" and value5.Connected then
      value5:Disconnect()
    end
  end

  table.clear(v7)
end)

v2:LoadAutoloadConfig()
window:SelectTab(1)
