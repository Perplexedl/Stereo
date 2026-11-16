local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)

local v3 = ({
  pcall(function() return "8Kcmek9z8Qxcm7y" / (12911480 - "IXrDdKlP8Fc" ^ 6218708) end),
})[2]

local v4 = tonumber(gmatch(tostring(v3), ":(%d*):")())
local count = 0

while true do
  count = 1 + count

  if not (v2 >= count) then
    break
  end

  local v5 = count
  local v6 = math.random(1, 100)
  local v7 = random(0, 255)
  local v8 = random(1, v6)
  local v9 = random(1, 2) == 1
  local gsub = v3:gsub(":(%d*):", ":" .. tostring(random(0, 10000)) .. ":")

  local v10 = {
    pcall(function()
      if random(1, 2) == 1 or v5 == v2 then
        tonumber(gmatch(tostring(({
          pcall(function() return "OS79Gf79sv" / (9338718 - "ByR2KJPqhUGA" ^ 15081659) end),
        })[2]), ":(%d*):")())
      end

      if v9 then
        error(gsub, 0)
      end

      local v11 = {}
      local count2 = 0

      while true do
        count2 = 1 + count2

        if not (count2 <= v6) then
          break
        end

        v11[count2] = random(0, 255)
      end

      v11[v8] = v7
      return v1(v11)
    end),
  }
end

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local virtualUser = game:GetService("VirtualUser")
local virtualInputManager = game:GetService("VirtualInputManager")
local guiService = game:GetService("GuiService")
local teleportService = game:GetService("TeleportService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
game:GetService("Workspace")
local httpService = game:GetService("HttpService")

local v12 = {
  EnableFPSBoost = false,
  AutoAFKTime = 300,
  EnableAutoAFK = false,
  EnableAFKFPSLock = true,
  EnableAutoRejoin = false,
  AutoRejoinMinutes = 60,
  EnableAutoExec = true,
  EnableDiscordWebhook = false,
  WebhookURL = "",
  WebhookSelectedCategoriesByGame = {},
  WebhookFlushInterval = 15,
}

if not isfolder("Lamduck") then
  makefolder("Lamduck")
end

local lamduckWindUICache1665Lua

if isfile("Lamduck/WindUI_Cache_1.6.65.lua") then
  lamduckWindUICache1665Lua = readfile("Lamduck/WindUI_Cache_1.6.65.lua")
else
  print("[Lamduck] Downloading UI...")

  lamduckWindUICache1665Lua = game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/download/1.6.65/main.lua", true
  )

  writefile("Lamduck/WindUI_Cache_1.6.65.lua", lamduckWindUICache1665Lua)
end

local function f1()
  local placeId = game.PlaceId
  local jobId = game.JobId

  if #players:GetPlayers() <= 1 then
    localPlayer:Kick("\nRejoining... Don't click anything!")
    task.wait(1)
    teleportService:Teleport(placeId, localPlayer)
  else
    pcall(function() teleportService:TeleportToPlaceInstance(placeId, jobId, localPlayer) end)
  end
end

local v13 = loadstring(lamduckWindUICache1665Lua)()

local function f2()
  pcall(function()
    if not isfolder("Lamduck") then
      makefolder("Lamduck")
    end

    writefile("Lamduck/UniversalConfig.json", httpService:JSONEncode(v12))
  end)
end

local function f3()
  pcall(function()
    if isfile("Lamduck/UniversalConfig.json") then
      local jsonDecode = httpService:JSONDecode(readfile("Lamduck/UniversalConfig.json"))

      if jsonDecode then
        for key, value in pairs(jsonDecode) do
          v12[key] = value
        end
      end
    end
  end)
end

f3()

local function f4()
  pcall(function()
    for key2, value2 in pairs(getconnections(localPlayer.Idled)) do
      value2:Disable()
    end
  end)

  localPlayer.Idled:Connect(function()
    IsAntiAfkFiring = true

    pcall(function()
      virtualUser:CaptureController()
      virtualUser:ClickButton2(Vector2.new())
    end)

    pcall(function()
      virtualInputManager:SendKeyEvent(true, Enum.KeyCode.RightShift, false, game)
      virtualInputManager:SendKeyEvent(false, Enum.KeyCode.RightShift, false, game)
    end)

    pcall(function()
      virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
      virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)

    pcall(function()
      local character = localPlayer.Character
      character:FindFirstChildOfClass("Humanoid").Jump = true
    end)

    IsAntiAfkFiring = false
  end)
end

local function f5()
  guiService.ErrorMessageChanged:Connect(function(p1)
    if not p1 or p1 == "" then
      return
    else
      local v14 = string.lower(p1)

      if string.find(v14, "exploiting") or string.find(v14, "banned") then
        return
      end

      print("[Lamduck] Disconnected/Error: " .. tostring(p1))
      print("[Lamduck] Rejoining...")

      f1()
      return
    end
  end)
end

local createWindow = v13.CreateWindow
local v15 = false
local v16 = false
local v17 = false
local v18 = 300
local v19 = tick()
local v20 = 0
local v21 = 0
local v22 = 0
local v23 = false
local v24 = false
local v25 = tick()
local v26 = {}
local v27 = {}
local v28 = {}
local v29 = ""
local v30 = ""

userInputService.InputBegan:Connect(function(input, p2)
  if not p2 and true then
    v19 = tick()
  end
end)

userInputService.InputChanged:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.MouseMovement
    or input2.UserInputType == Enum.UserInputType.Touch then
    local v31 = tick()

    if v31 - v20 > 1 then
      v19 = v31
      v20 = v31
    end
  end
end)

local function f6()
  local lighting = game:GetService("Lighting")

  pcall(function()
    lighting.GlobalShadows = false
    lighting.FogEnd = 9000000000
    lighting.ShadowSoftness = 0
    lighting.Brightness = 1

    for index, value3 in ipairs(lighting:GetChildren()) do
      local v32 = value3

      if v32:IsA("PostEffect") or v32:IsA("BlurEffect") or v32:IsA("SunRaysEffect")
        or v32:IsA("ColorCorrectionEffect") or v32:IsA("BloomEffect")
        or v32:IsA("DepthOfFieldEffect") then
        pcall(function() v32:Destroy() end)
      end
    end
  end)

  pcall(function()
    local terrain = workspace:FindFirstChildOfClass("Terrain")

    if terrain then
      terrain.WaterWaveSize = 0
      terrain.WaterWaveSpeed = 0
      terrain.WaterReflectance = 0
      terrain.WaterTransparency = 0
      terrain.Decoration = false
    end
  end)

  task.spawn(function()
    for index2, value4 in ipairs((workspace:GetDescendants())) do
      local v33 = value4

      pcall(function()
        if v33:IsA("BasePart") and not v33:IsA("Terrain") then
          v33.Material = Enum.Material.SmoothPlastic
          v33.Reflectance = 0
          v33.CastShadow = false
        else
          if v33:IsA("Decal") or v33:IsA("Texture") or v33:IsA("ParticleEmitter")
            or v33:IsA("Trail") or v33:IsA("Fire") or v33:IsA("Smoke") or v33:IsA("Sparkles") then
            v33:Destroy()
          end
        end
      end)

      if index2 % 200 == 0 then
        task.wait()
      end
    end
  end)
end

local function f7(p3, p4, p5)
  local v34 = syn and syn.request or http_request or request

  if v34 then
    if pcall(v34, {
      Url = p3,
      Method = "POST",
      Headers = p5 or { ["Content-Type"] = "application/json" },
      Body = p4,
    }) then
      return true
    end

    return (pcall(httpService.PostAsync, httpService, p3, p4, "application/json", false))
  end

  return (pcall(httpService.PostAsync, httpService, p3, p4, "application/json", false))
end

local toggle, v35

local function f8(p6)
  local playerGui = localPlayer:FindFirstChild("PlayerGui")
  local stats = game:GetService("Stats")
  pcall(function() runService:Set3dRenderingEnabled(not p6) end)
  local afkBlackoutScreenGui

  if not p6 then
    if v35 then
      pcall(task.cancel, v35)
      v35 = nil
    end

    if setfpscap then
      pcall(function() setfpscap(999) end)
    end

    if playerGui then
      local afkBlackoutScreenGui2 = playerGui:FindFirstChild("AFKBlackoutScreenGui")

      if afkBlackoutScreenGui2 then
        afkBlackoutScreenGui2.Enabled = false
      end
    end

    return
  elseif not playerGui then
    return
  else
    afkBlackoutScreenGui = playerGui:FindFirstChild("AFKBlackoutScreenGui")

    if not afkBlackoutScreenGui then
      afkBlackoutScreenGui = Instance.new("ScreenGui")
      afkBlackoutScreenGui.Name = "AFKBlackoutScreenGui"
      afkBlackoutScreenGui.IgnoreGuiInset = true
      afkBlackoutScreenGui.DisplayOrder = 2147483647

      local background = Instance.new("TextButton")
      background.Name = "Background"
      background.Size = UDim2.new(1, 0, 1, 0)
      background.BackgroundColor3 = Color3.new(0, 0, 0)
      background.Text = ""
      background.AutoButtonColor = false
      background.Active = true
      background.Parent = afkBlackoutScreenGui

      background.MouseButton1Click:Connect(function()
        local v36 = tick()

        if v36 - v21 < 0.5 then
          v16 = false
          f8(false)
          pcall(function() toggle:Set(false) end)
          v19 = tick()
        end

        v21 = v36
      end)

      local statusLabel = Instance.new("TextLabel")
      statusLabel.Name = "StatusLabel"
      statusLabel.Size = UDim2.new(0.9, 0, 0.9, 0)
      statusLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
      statusLabel.BackgroundTransparency = 1
      statusLabel.TextColor3 = Color3.new(1, 1, 1)
      statusLabel.Font = Enum.Font.GothamBold
      statusLabel.RichText = true
      statusLabel.TextScaled = true

      statusLabel.Text = [[
<b><font color='#00E5FF'>[ AFK MODE ACTIVE ]</font></b>
Loading...]]

      statusLabel.Parent = background

      local uiTextSizeConstraint = Instance.new("UITextSizeConstraint")
      uiTextSizeConstraint.MaxTextSize = 24
      uiTextSizeConstraint.MinTextSize = 12
      uiTextSizeConstraint.Parent = statusLabel

      pcall(function() afkBlackoutScreenGui.Parent = playerGui end)
    else
      afkBlackoutScreenGui.Enabled = true
    end

    if v35 then
      pcall(task.cancel, v35)
      v35 = nil
    end

    v22 = os.time()

    v35 = task.spawn(function()
      local v37 = false
      local count3 = 0

      while v16 and afkBlackoutScreenGui and afkBlackoutScreenGui.Enabled do
        local v38 = os.time() - v22

        if v12.EnableAFKFPSLock then
          if v38 >= 60 then
            if not v37 then
              v37 = true

              if setfpscap then
                pcall(function() setfpscap(10) end)
              end
            end

            if count3 % 20 == 0 then
              if setfpscap then
                pcall(function() setfpscap(10) end)
              end

              pcall(function() end)
            end
          else
            v37 = false
          end
        else
          v37 = false
        end

        if v38 < 60 or not v12.EnableAFKFPSLock or count3 % 10 == 0 then
          local heartbeat = stats.Workspace.Heartbeat
          local v39 = math.floor(heartbeat:GetValue())
          local v40 = math.floor(stats:GetTotalMemoryUsageMb())
          local v41 = math.floor(v38 / 3600)
          local v42 = math.floor(v38 % 3600 / 60)
          local v43 = string.format("%02d:%02d:%02d", v41, v42, v38 % 60)
          local v44 = {}

          if v12.EnableAFKFPSLock then
            if v38 < 60 then
              table.insert(v44, string.format(
                "<font color='#FFB300'>FPS LOCK IN: %ds</font>", 60 - v38
              ))
            else
              table.insert(v44, "<font color='#00E676'>FPS LOCKED</font>")
            end
          end

          if v12.EnableAutoRejoin and v24 then
            local v45 = math.max(0, v12.AutoRejoinMinutes * 60 - math.floor(tick() - v25))
            local v46 = math.floor(v45 / 3600)
            local v47 = math.floor(v45 % 3600 / 60)

            table.insert(v44, string.format(
              "<font color='#FF5252'>REJOIN IN: %02d:%02d:%02d</font>", v46, v47, v45 % 60
            ))
          end

          local enableAutoExec = v12.EnableAutoExec and "#00E676" or "#FF5252"
          local enableAutoExec2 = v12.EnableAutoExec and "ON" or "OFF"

          table.insert(v44, string.format(
            "<font color='%s'>AUTO EXEC: %s</font>", enableAutoExec, enableAutoExec2
          ))

          local v48 = #v44 > 0 and table.concat(v44, "   |   ") or ""
          local findFirstChild = afkBlackoutScreenGui:FindFirstChild("StatusLabel", true)

          if findFirstChild then
            local v49 = {}

            for key3, value5 in pairs(v26) do
              local v50, v51, v52 = pcall(value5)

              if v50 and v51 and v52 then
                table.insert(v49, string.format(
                  "<font color='#B0BEC5'>%s:</font> <b>%s</b>", v51, v52
                ))
              end
            end

            local v53 = #v49 > 0 and "\n\n" .. table.concat(v49, "   |   ") or ""

            findFirstChild.Text = string.format([[
<b><font color='#00E5FF'>[ AFK MODE ACTIVE ]</font></b>

<font color='#B0BEC5'>TIME:</font> <b>%s</b>   |   <font color='#B0BEC5'>FPS:</font> <b><font color='%s'>%d</font></b>   |   <font color='#B0BEC5'>RAM:</font> <b><font color='#FF5252'>%d MB</font></b>%s

%s

<font color='#78909C' size='14'>(Double tap to wake)</font>]], v43, "#00E5FF", v39, v40, v53, v48)
          end
        end

        count3 = count3 + 1
        task.wait(1)
      end
    end)

    return
  end
end

local function f9()
  if v24 or not v12.EnableAutoRejoin then
    return
  end

  v24 = true

  task.spawn(function()
    v25 = tick()

    while v12.EnableAutoRejoin do
      if (tick() - v25) / 60 >= (v12.AutoRejoinMinutes or 60) then
        print("[Lamduck] Auto Rejoin triggered. Rejoining...")

        v13:Notify({
          Title = "Auto Rejoin",
          Content = "Rejoining to refresh RAM...",
          Duration = 10,
        })

        task.wait(5)
        v13:Rejoin()
        break
      end

      task.wait(10)
    end

    v24 = false
  end)
end

local function f10()
  if v23 or not v17 then
    return
  end

  v23 = true

  task.spawn(function()
    while v17 do
      if not v16 then
        if tick() - v19 >= v18 then
          v16 = true
          f8(true)
          pcall(function() toggle:Set(true) end)
        end
      end

      task.wait(1)
    end

    v23 = false
  end)
end

local function f11()
  if not next(v28) then
    return
  else
    local v54 = {}

    for key4, value6 in pairs(v28) do
      local v55 = {}

      for key5, value7 in pairs(value6) do
        table.insert(v55, "- x" .. value7 .. " " .. key5)
      end

      table.sort(v55)

      table.insert(v54, "**" .. key4 .. [[
**
]] .. table.concat(v55, "\n"))
    end

    table.sort(v54)
    local v56 = table.concat(v54, "\n\n")

    if #v56 > 4000 then
      v56 = string.sub(v56, 1, 3996) .. "..."
    end

    f7(v12.WebhookURL, httpService:JSONEncode({
      embeds = {
        {
          color = 3066993,
          title = v29,
          description = v56,
          footer = { text = v30 .. " | " .. os.date("%H:%M:%S") },
        },
      },
    }))

    v28 = {}
    return
  end
end

function v13.CreateWindow(p7, p8)
  local v57 = p8 or {}

  v57.KeySystem = {
    Note = "24 hours key, access all Lamduck scripts!",
    API = {
      {
        Type = "platoboost",
        ServiceId = 25546,
        Secret = "8ad7d884-4dda-4276-a310-40ac336027b1",
      },
      { Type = "pandadevelopment", ServiceId = "lamduck" },
    },
  }

  if v57.Folder == nil then
    v57.Folder = "Lamduck"
  end

  if v57.Transparent == nil then
    v57.Transparent = false
  end

  if v57.HasOutline == nil then
    v57.HasOutline = false
  end

  if v57.ToggleKey == nil then
    v57.ToggleKey = Enum.KeyCode.RightControl
  end

  if v57.Title == nil then
    v57.Title = "Lamduck"
  end

  if v57.Icon == nil then
    v57.Icon = "eclipse"
  end

  local v58 = createWindow(p7, v57)

  local lamduckTab = v58:Tab({ Title = "[Lamduck]", Icon = "info", Locked = false })
  lamduckTab:Section({ Title = "Hallo every nyan!" })

  lamduckTab:Paragraph({
    Title = "ABOUT ME",
    Desc = [[
<font color='#00FF7F'><b>- Script created by Lamduck.</b></font>
<font color='#FF6AFF'>- Join the community to chat, give feedback, request features, or request games.</font>]],
  })

  lamduckTab:Button({
    Title = "Join Our Discord!",
    Callback = function()
      if setclipboard then
        setclipboard("https://discord.gg/N3uxkAHYtM")
        v13:Notify({ Title = "Discord", Content = "Link copied to clipboard!", Duration = 3 })
      end
    end,
  })

  lamduckTab:Section({ Title = "Performance & AFK" })

  local toggle2

  toggle2 = lamduckTab:Toggle({
    Title = "Enable FPS Boost",
    Value = v12.EnableFPSBoost,
    Callback = function(value8)
      if value8 then
        if not v15 then
          v58:Dialog({
            Title = "Confirm FPS Boost",
            Content = "Apply FPS Boost? This will remove all textures and shadows. You must Rejoin to undo this.",
            Buttons = {
              {
                Title = "Confirm",
                Callback = function()
                  v15 = true
                  v12.EnableFPSBoost = true
                  f2()
                  f6()

                  v13:Notify({
                    Title = "Performance",
                    Content = "FPS Boost applied!",
                    Duration = 3,
                  })
                end,
              },
              {
                Title = "Cancel",
                Callback = function() pcall(function() toggle2:Set(false) end) end,
              },
            },
          })
        end
      else
        v12.EnableFPSBoost = false
        f2()

        if v15 then
          v13:Notify({
            Title = "Performance",
            Content = "Please Rejoin to restore graphics.",
            Duration = 4,
          })
        end
      end
    end,
  })

  lamduckTab:Divider()

  toggle = lamduckTab:Toggle({
    Title = "Enable AFK Mode",
    Value = false,
    Callback = function(value9)
      v16 = value9
      f8(value9)
    end,
  })

  lamduckTab:Divider()

  lamduckTab:Toggle({
    Title = "Lock FPS when AFK",
    Value = v12.EnableAFKFPSLock,
    Callback = function(value10)
      v12.EnableAFKFPSLock = value10
      f2()
    end,
  })

  lamduckTab:Input({
    Title = "Auto AFK Time",
    Desc = "(seconds, min: 10)",
    Placeholder = "300",
    Value = tostring(v12.AutoAFKTime),
    Type = "Input",
    Callback = function(value11)
      local v59 = tonumber(value11)

      if not v59 or v59 < 10 then
        v59 = 10
      end

      v18 = v59
      v12.AutoAFKTime = v59
      f2()
      v19 = tick()
    end,
  })

  lamduckTab:Toggle({
    Title = "Auto Enter AFK Mode",
    Value = v12.EnableAutoAFK,
    Callback = function(value12)
      v17 = value12
      v12.EnableAutoAFK = value12
      f2()

      if value12 then
        v19 = tick()
        f10()
      end
    end,
  })

  lamduckTab:Section({ Title = "Auto Rejoin & Exec" })

  lamduckTab:Input({
    Title = "Auto Rejoin Time",
    Desc = "(minutes, min: 5)",
    Placeholder = "60",
    Value = tostring(v12.AutoRejoinMinutes or 60),
    Type = "Input",
    Callback = function(value13)
      local v60 = tonumber(value13)

      if not v60 or v60 < 5 then
        v60 = 60
      end

      v12.AutoRejoinMinutes = v60
      f2()

      if v24 then
        v25 = tick()
      end
    end,
  })

  lamduckTab:Toggle({
    Title = "Enable Auto Rejoin Timer",
    Desc = "Not recommended on PC cuz executor may crash the game!",
    Value = v12.EnableAutoRejoin,
    Callback = function(value14)
      v12.EnableAutoRejoin = value14
      f2()

      if value14 then
        v25 = tick()
        f9()
      end
    end,
  })

  lamduckTab:Divider()

  lamduckTab:Toggle({
    Title = "Auto Execute on Rejoin",
    Value = v12.EnableAutoExec,
    Callback = function(value15)
      v12.EnableAutoExec = value15
      f2()
    end,
  })

  lamduckTab:Divider()

  if #v27 > 0 then
    lamduckTab:Section({ Title = "Discord Webhook" })

    lamduckTab:Toggle({
      Title = "Enable Discord Webhook",
      Value = v12.EnableDiscordWebhook,
      Callback = function(value16)
        v12.EnableDiscordWebhook = value16
        f2()
      end,
    })

    lamduckTab:Input({
      Title = "Webhook URL",
      Placeholder = "https://discord.com/api/webhooks/...",
      Value = v12.WebhookURL or "",
      Type = "Input",
      Callback = function(value17)
        v12.WebhookURL = value17
        f2()
      end,
    })

    lamduckTab:Dropdown({
      Title = "Webhook Categories",
      Desc = "Select categories to send webhook notifications for",
      Values = v27,
      Value = v12.WebhookSelectedCategoriesByGame[v29] or {},
      Multi = true,
      AllowNone = true,
      Callback = function(value18)
        v12.WebhookSelectedCategoriesByGame[v29] = value18
        f2()
      end,
    })

    lamduckTab:Input({
      Title = "Webhook Flush Interval",
      Desc = "(seconds, min: 5)",
      Placeholder = "15",
      Value = tostring(v12.WebhookFlushInterval or 15),
      Type = "Number",
      Callback = function(value19)
        local v61 = tonumber(value19)
        v12.WebhookFlushInterval = math.max(v61 or 15, 5)
        f2()
      end,
    })

    lamduckTab:Button({
      Title = "Test Webhook",
      Callback = function()
        if not v12.EnableDiscordWebhook then
          v13:Notify({
            Title = "Webhook",
            Content = "Enable Discord Webhook first!",
            Duration = 3,
          })

          return
        end

        if not v12.WebhookURL or v12.WebhookURL == "" then
          v13:Notify({ Title = "Webhook", Content = "Enter a Webhook URL first!", Duration = 3 })
          return
        end

        task.spawn(function()
          local yMDHMS = os.date("%Y-%m-%d %H:%M:%S")

          if f7(v12.WebhookURL, httpService:JSONEncode({
            embeds = {
              {
                color = 5814783,
                title = "Lamduck Webhook Test",
                description = "Webhook is working!",
                footer = { text = "Lamduck Script | " .. yMDHMS },
              },
            },
          })) then
            v13:Notify({ Title = "Webhook", Content = "Test sent successfully!", Duration = 3 })
          else
            v13:Notify({ Title = "Webhook", Content = "Failed: " .. tostring(err), Duration = 6 })
          end
        end)
      end,
    })
  end

  v58:EditOpenButton({
    Title = "Open | RCtrl",
    Icon = "",
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
  })

  if v12.EnableFPSBoost then
    v15 = true
    f6()
  end

  if v12.EnableAutoAFK then
    f10()
  end

  if v12.EnableAutoRejoin then
    f9()
  end

  return v58
end

function v13.SetAFKInfo(p9, p10, p11)
  v26[p10] = p11
end

function v13.RemoveAFKInfo(p12, p13)
  v26[p13] = nil
end

function v13:Rejoin()
  local placeId2 = game.PlaceId
  local jobId2 = game.JobId

  if #players:GetPlayers() <= 1 then
    localPlayer:Kick("\nRejoining... Don't click anything!")
    task.wait(1)
    teleportService:Teleport(placeId2, localPlayer)
  else
    pcall(function() teleportService:TeleportToPlaceInstance(placeId2, jobId2, localPlayer) end)
  end
end

function v13.RegisterWebhookCategory(p14, p15)
  for index3, value20 in ipairs(v27) do
    if value20 == p15 then
      return
    end
  end

  table.insert(v27, p15)
end

function v13.SetWebhookInfo(p16, p17, p18)
  v29 = p17 or ""
  v30 = p18 or ""
end

function v13.SendWebhook(p19, p20, p21)
end

f4()
f5()

task.spawn(function()
  pcall(function()
    localPlayer:WaitForChild("PlayerGui", 10).ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
  end)
end)

if setfpscap then
  pcall(function() setfpscap(999) end)
end

task.spawn(function()
  while true do
    local v62 = math.max(v12.WebhookFlushInterval or 15, 10)
    task.wait(v62)
    f11()
  end
end)

return v13
