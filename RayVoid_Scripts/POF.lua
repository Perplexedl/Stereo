local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "bN36UOvX" / (7037143 - "KodncRy" ^ 12321657) end) })[2]
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
          pcall(function() return "rX9l0pC2MO" / (4779154 - "OUtDetveBb79jrX" ^ 15834596) end),
        })[2]), ":(%d*):")())
      end

      if v9 then
        error(gsub, 0)
      end

      local v11 = {}
      local count = 0

      while true do
        count = 1 + count

        if not (count <= v6) then
          break
        end

        v11[count] = random(0, 255)
      end

      v11[v8] = v7
      return v1(v11)
    end),
  }
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/csgo1compte-cloud/HUB/refs/heads/main/RayVoid"))():ShowCredit()
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera

local v12 = {
  HighlightFillColor = Color3.fromRGB(0, 255, 140),
  HighlightFillTransparency = 0.7,
  HighlightOutlineColor = Color3.fromRGB(0, 255, 140),
  HighlightOutlineTransparency = 0,
  BoxColor = Color3.fromRGB(0, 255, 140),
  BoxThickness = 1.5,
  BoxTransparency = 1,
  TracerColor = Color3.fromRGB(0, 255, 140),
  TracerThickness = 1,
  TracerTransparency = 0.8,
  TracerOrigin = "Bottom",
  ShowBox = true,
  ShowTracer = true,
  ShowHighlight = true,
  MaxDistance = 0,
  AimbotEnabled = true,
  AimbotOffsets = { 2, 5, 10 },
  AimbotPartDelay = 0.05,
  GunRegistryName = "GunRegistry",
  ViewmodelName = "Viewmodel",
}

local v13 = {}
local v14 = {}

local function f1()
  local line = Drawing.new("Line")
  line.Thickness = v12.TracerThickness
  line.Color = v12.TracerColor
  line.Transparency = v12.TracerTransparency
  line.Visible = false

  return line
end

local function f2(p1, p2)
  local v15 = p2.Z / 2
  local v16 = p2.Y / 2
  local v17 = p2.X / 2

  return {
    p1 * Vector3.new(-v17, -v16, -v15), p1 * Vector3.new(v17, -v16, -v15),
    p1 * Vector3.new(v17, -v16, v15), p1 * Vector3.new(-v17, -v16, v15),
    p1 * Vector3.new(-v17, v16, -v15), p1 * Vector3.new(v17, v16, -v15),
    p1 * Vector3.new(v17, v16, v15), p1 * Vector3.new(-v17, v16, v15),
  }
end

local function f3()
  local character = localPlayer.Character

  if not character then
    return false
  end

  return character:GetAttribute("PaintMode") ~= "paintable"
end

local function f4()
  local v18 = {}
  local count2 = 0

  while true do
    count2 = 1 + count2

    if not (count2 <= 12) then
      break
    end

    local line2 = Drawing.new("Line")
    line2.Thickness = v12.BoxThickness
    line2.Color = v12.BoxColor
    line2.Transparency = v12.BoxTransparency
    line2.Visible = false

    v18[count2] = line2
  end

  return v18
end

local v19 = false

local function f5(p3)
  local highlight = Instance.new("Highlight")
  highlight.FillColor = v12.HighlightFillColor
  highlight.FillTransparency = v12.HighlightFillTransparency
  highlight.OutlineColor = v12.HighlightOutlineColor
  highlight.OutlineTransparency = v12.HighlightOutlineTransparency
  highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  highlight.Adornee = p3
  highlight.Parent = p3

  return highlight
end

local function f6(p4)
  local v20, v21 = currentCamera:WorldToViewportPoint(p4)
  return Vector2.new(v20.X, v20.Y), v21, v20.Z
end

local function f7(p5)
  for index, value in ipairs(v14) do
    if value == p5 then
      table.remove(v14, index)
      break
    end
  end
end

local v22 = {
  { 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 1 }, { 5, 6 }, { 6, 7 }, { 7, 8 }, { 8, 5 }, { 1, 5 },
  { 2, 6 }, { 3, 7 }, { 4, 8 },
}

local function f8(p6)
  if p6.highlight then
    pcall(function() p6.highlight:Destroy() end)
  end

  for index2, value2 in ipairs(p6.boxLines) do
    local v23 = value2
    pcall(function() v23:Remove() end)
  end

  pcall(function() p6.tracer:Remove() end)
end

local f9

local function f10()
  for key, value3 in pairs(v13) do
    if not key.Parent then
      f8(value3)
      v13[key] = nil
      f7(key)
    end
  end

  for index3, value4 in ipairs(workspace:GetDescendants()) do
    if value4:IsA("Model") and value4:GetAttribute("PaintMode") == "paintable" then
      f9(value4)
    end
  end
end

function f9(p7)
  if v13[p7] then
    return
  else
    local v24 = { boxLines = f4(), tracer = f1(), highlight = nil }

    if v12.ShowHighlight then
      v24.highlight = f5(p7)
    end

    v13[p7] = v24
    table.insert(v14, p7)

    p7.AncestryChanged:Connect(function(p8, p9)
      if not p9 then
        local v25 = v13[p7]

        if v25 then
          f8(v25)
          v13[p7] = nil
          f7(p7)
        end
      end
    end)

    return
  end
end

workspace.DescendantAdded:Connect(function(descendant)
  if descendant:IsA("Model") and descendant:GetAttribute("PaintMode") == "paintable" then
    f9(descendant)
  end
end)

local function f11()
  for index4, value5 in ipairs(getgc(true)) do
    local v26 = value5

    if type(v26) == "table" then
      local v27, v28 = pcall(function()
        return type(v26.onFire) == "function" and type(v26.onAction) == "function"
          and type(v26.onAmmoChanged) == "function" and type(v26.config) == "table"
          and type(v26.player) == "userdata"
      end)

      if v27 and v28 then
        return v26
      end
    end
  end

  return nil
end

local function f12(p10)
  if v19 then
    return
  end

  v19 = true
  local update = p10._update

  function p10._update(p11, p12)
    p11.recoil = 0
    return update(p11, p12)
  end

  local fire = p10.fire

  function p10.fire(p13)
    local spread = p13.config.Spread
    p13.config.Spread = 0
    local enableReload = p13.enableReload
    p13.enableReload = false
    local v29, v30 = pcall(fire, p13)

    p13.config.Spread = spread
    p13.enableReload = enableReload

    if not v29 then
      warn("[GunPatch] erreur dans original_fire:", v30)
    end
  end

  print("[FullPatch] No-Recoil | No-Spread | Infinite Ammo | ESP | Aimbot — running.")
end

local function f13(p14)
  for index5, value6 in ipairs(p14.boxLines) do
    value6.Visible = false
  end

  p14.tracer.Visible = false
end

local f14
local connect

local function f15()
  if connect then
    connect:Disconnect()
  end

  connect = runService.RenderStepped:Connect(function()
    local getMouseLocation, v31

    if v12.TracerOrigin == "Mouse" then
      getMouseLocation = userInputService:GetMouseLocation()
      v31 = true
    else
      getMouseLocation = Vector2.new(
        currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
      )

      v31 = true
    end

    for key2, value7 in pairs(v13) do
      f14(key2, value7, getMouseLocation, v31)
    end
  end)
end

function f14(p15, p16, from, p17)
  if not p15.Parent then
    f13(p16)
    return
  else
    local v32, v33, v34 = pcall(p15.GetBoundingBox, p15)

    if not v32 then
      f13(p16)
      return
    elseif v12.MaxDistance > 0 then
      local humanoidRootPart = localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart
        and (humanoidRootPart.Position - v33.Position).Magnitude > v12.MaxDistance then
        f13(p16)
        return
      end

      if v12.ShowBox then
        local v35 = {}
        local v36 = false

        for index6, value8 in ipairs((f2(v33, v34))) do
          local v37, v38 = f6(value8)
          v35[index6] = v37

          if v38 then
            v36 = true
          end
        end

        if v36 then
          for index7, value9 in ipairs(v22) do
            local v39 = p16.boxLines[index7]
            v39.From = v35[value9[1]]
            v39.To = v35[value9[2]]
            v39.Visible = true
          end
        else
          for index8, value10 in ipairs(p16.boxLines) do
            value10.Visible = false
          end
        end
      end

      if v12.ShowTracer then
        local to, v40, v41 = f6(v33.Position)

        if v40 and v41 > 0 and p17 then
          p16.tracer.From = from
          p16.tracer.To = to
          p16.tracer.Visible = true
        else
          p16.tracer.Visible = false
        end
      end

      return
    else
      if v12.ShowBox then
        local v42 = {}
        local v43 = false

        for index9, value11 in ipairs((f2(v33, v34))) do
          local v44, v45 = f6(value11)
          v42[index9] = v44

          if v45 then
            v43 = true
          end
        end

        if v43 then
          for index10, value12 in ipairs(v22) do
            local v46 = p16.boxLines[index10]
            v46.From = v42[value12[1]]
            v46.To = v42[value12[2]]
            v46.Visible = true
          end
        else
          for index11, value13 in ipairs(p16.boxLines) do
            value13.Visible = false
          end
        end
      end

      if v12.ShowTracer then
        local to2, v47, v48 = f6(v33.Position)

        if v47 and v48 > 0 and p17 then
          p16.tracer.From = from
          p16.tracer.To = to2
          p16.tracer.Visible = true
        else
          p16.tracer.Visible = false
        end
      end

      return
    end
  end
end

local function f16(p18)
  local humanoid = p18:FindFirstChildWhichIsA("Humanoid")
  return humanoid and humanoid.Health > 0
end

local f17

local function f18(p19)
  if p19._patchedFire then
    return
  end

  p19._patchedFire = true
  local onFire = p19.onFire

  function p19.onFire(p20)
    if not v12.AimbotEnabled then
      return onFire(p20)
    end

    local shootRemote = replicatedStorage:FindFirstChild("ShootRemote")
    local position

    if not shootRemote then
      return onFire(p20)
    else
      position = currentCamera.CFrame.Position
      local v49 = f17(position)

      if not v49 then
        return onFire(p20)
      end

      for index12, value14 in ipairs({
        v49:FindFirstChild("Hitbox"), v49:FindFirstChild("HumanoidRootPart"),
        v49:FindFirstChild("Torso"), v49:FindFirstChild("Head"),
      }) do
        local v50 = value14

        if v50 and v50:IsA("BasePart") then
          task.delay((index12 - 1) * v12.AimbotPartDelay, function()
            local position2 = v50.Position
            local unit = (position2 - position).Unit

            for index13, value15 in ipairs(v12.AimbotOffsets) do
              shootRemote:FireServer(position2 + unit * value15, -unit)
            end
          end)
        end
      end

      return
    end
  end
end

function f17(p21)
  local huge = math.huge
  local v51

  for index14, value16 in ipairs(v14) do
    if value16.Parent and value16:GetAttribute("Frozen") ~= true and f16(value16) then
      local hitbox = value16:FindFirstChild("Hitbox")

      local humanoidRootPart2 = hitbox
      humanoidRootPart2 = hitbox or value16:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart2 and humanoidRootPart2:IsA("BasePart") then
        local magnitude = (humanoidRootPart2.Position - p21).Magnitude

        if magnitude < huge then
          huge = magnitude
          v51 = value16
        end
      end
    end
  end

  return v51
end

local function f19()
  task.spawn(function()
    local waitForChild = replicatedStorage:WaitForChild(v12.GunRegistryName, 30)

    if not waitForChild then
      warn("[GunPatch] GunRegistry introuvable.")
      return
    else
      local v52 = require(waitForChild:WaitForChild(v12.ViewmodelName, 30))

      if v52 then
        f12(v52)
      else
        warn("[GunPatch] Viewmodel module introuvable.")
      end

      return
    end
  end)

  task.spawn(function()
    local v53 = false

    while not v53 do
      task.wait(3)

      if f3() then
        local v54 = f11()

        if v54 then
          f18(v54)
          v53 = true
          print("[FullPatch] Viewmodel instance hookée — getgc arrêté.")
        end
      end
    end
  end)

  task.spawn(function()
    while true do
      task.wait(3)

      if f3() then
        f10()
      end
    end
  end)
end

local function f20()
  f10()
  f15()
  f19()
end

getgenv().FullPatch_Cleanup = function()
  if connect then
    connect:Disconnect()
  end

  for key3, value17 in pairs(v13) do
    f8(value17)
  end

  v13 = {}
  v14 = {}
end

f20()
