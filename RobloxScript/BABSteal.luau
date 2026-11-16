local fluent = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local remoteEvent = replicatedStorage:WaitForChild("Framework"):WaitForChild("Features"):WaitForChild("HoneySystem"):WaitForChild("BeeUtil"):WaitForChild("RemoteEvent")
local v1 = { IsStealLoopRunning = false }

local function f1()
  if v1.IsStealLoopRunning then
    return
  end

  v1.IsStealLoopRunning = true

  task.spawn(function()
    while not fluent.Unloaded and fluent.Options.Toggle_Steal_AllBees
      and fluent.Options.Toggle_Steal_AllBees.Value do
      pcall(function()
        local plots = workspace:FindFirstChild("Plots")

        if not plots then
          return
        end

        for index, value in ipairs(players:GetPlayers()) do
          if fluent.Unloaded
            or not (fluent.Options.Toggle_Steal_AllBees and fluent.Options.Toggle_Steal_AllBees.Value) then
            break
          end

          if value ~= localPlayer then
            for index2, value2 in ipairs(plots:GetChildren()) do
              local owner = value2:FindFirstChild("Owner")

              if owner and tostring(owner.Value) == value.Name then
                local flowers = value2:FindFirstChild("Flowers")

                if flowers then
                  for index3, value3 in ipairs(flowers:GetChildren()) do
                    if fluent.Unloaded
                      or not (fluent.Options.Toggle_Steal_AllBees
                        and fluent.Options.Toggle_Steal_AllBees.Value) then
                      break
                    end

                    local uniqueId = value3:GetAttribute("UniqueId")

                    if uniqueId and value3:GetAttribute("BeeId") then
                      remoteEvent:FireServer("PickUpBee", value, uniqueId)
                      task.wait(0.05)
                    end
                  end
                end

                break
              end
            end
          end
        end
      end)

      task.wait(1)
    end

    v1.IsStealLoopRunning = false
  end)
end

local window = fluent:CreateWindow({ Title = "BAB - Steal Bee" })

local mainAddTab = window:AddTab({ Title = "Main", Icon = "user" })

mainAddTab:AddParagraph("Paragraph_Steal_Warning", {
  Title = "<b><font color=\"#FF4444\">IMPORTANT WARNING & DISCLAIMER</font></b>",
  Content = "• <b><font color=\"#FFCC00\">FOR FUN ONLY:</font></b> Stealing bees has no actual gameplay benefit. <b><font color=\"#FF2222\">ONLY RUN THIS ON AN ALT / CLONE ACCOUNT</font></b> because it will permanently clutter your backpack—stolen bees will <b><font color=\"#FF4444\">NEVER DISAPPEAR</font></b> even after rejoining!\n\n• <b><font color=\"#55FF55\">NO HARM TO OTHERS:</font></b> The target player will <b><font color=\"#55FF55\">NOT be affected</font></b> (this is purely a client-side visual glitch; on their screen, their bees remain completely intact).\n\n• <b><font color=\"#FF88FF\">VISIBLE TO EVERYONE:</font></b> Other players <b><font color=\"#FFFF00\">CAN SEE</font></b> the stolen bees you hold in your hand (great for flexing/trolling)!\n\n• <b><font color=\"#00FFFF\">USELESS IN YOUR GARDEN:</font></b> Stolen bees do <b><font color=\"#FF8888\">NOT produce honey or boost your garden</font></b>. They <b><font color=\"#FF4444\">CANNOT be placed, traded, gifted, or dropped/deleted</font></b>.",
})

mainAddTab:AddDivider()

mainAddTab:AddToggle("Toggle_Steal_AllBees", {
  Title = "Steal All Bees",
  Default = false,
  Callback = function(value4)
    if value4 then
      f1()
    end
  end,
})

window:SelectTab(1)
