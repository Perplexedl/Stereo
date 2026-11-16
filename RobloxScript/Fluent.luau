local gmatch = string.gmatch
local random = math.random
local v1 = table and table.unpack or unpack
local v2 = random(3, 65)
local v3 = ({ pcall(function() return "4X" / (12574621 - "pLlk7ckE" ^ 12063018) end) })[2]
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
          pcall(function() return "45L2zBP" / (878567 - "WomN" ^ 7156566) end),
        })[2]), ":(%d*):")())
      end

      if v9 then
        error(gsub, 0)
      end

      local v11 = {}
      local count2 = 0

      while true do
        count2 = 1 + count2

        if not (v6 >= count2) then
          break
        end

        v11[count2] = random(0, 255)
      end

      v11[v8] = v7
      return v1(v11)
    end),
  }
end

if not isfolder("Lamduck") then
  pcall(makefolder, "Lamduck")
end

local function f1(p1, p2, p3, p4)
  local v12, v13

  if p4 then
    v12 = p3
    v13 = p4
  elseif typeof(p3) == "string" and (p3:sub(1, 7) == "http://" or p3:sub(1, 8) == "https://") then
    v13 = nil
    v12 = p3
  else
    v12 = nil
    v13 = p3
  end

  local v14 = false
  local v15, v16

  if v13 then
    v16 = "Lamduck" .. "/" .. p1 .. "_Cache_" .. v13 .. ".luau"

    if isfile(v16) then
      pcall(function() v15 = readfile(v16) end)

      if typeof(v15) == "string" and #v15 > 100 then
        v14 = true
      end
    end
  else
    local v17 = {}
    local v18 = 0

    if type(listfiles) == "function" and isfolder("Lamduck") then
      local v19, v20 = pcall(listfiles, "Lamduck")

      if v19 and type(v20) == "table" then
        for index, value in ipairs(v20) do
          local v21 = tonumber((value:match(p1 .. "_Cache_(%d+)%.lua[u]?$")))

          if v21 then
            if v21 > v18 then
              if v16 then
                table.insert(v17, v16)
              end

              v18 = v21
              v16 = value
            else
              table.insert(v17, value)
            end
          end
        end
      end
    end

    if type(delfile) == "function" then
      for index2, value2 in ipairs(v17) do
        pcall(delfile, value2)
      end

      local v22 = "Lamduck" .. "/" .. p1 .. "_Cache.luau"

      if isfile(v22) then
        pcall(delfile, v22)
      end
    end

    if v16 and isfile(v16) then
      pcall(function() v15 = readfile(v16) end)

      if typeof(v15) == "string" and #v15 > 100 then
        if os.time() - v18 < 86400 then
          v14 = true
        end
      end
    end
  end

  if v14 and v15 then
    local v23, v24 = pcall(loadstring, v15)

    if v23 and type(v24) == "function" then
      local v25, v26 = pcall(v24)

      if v25 and (type(v26) == "table" or type(v26) == "userdata") then
        print("[Lamduck] Loaded " .. p1 .. " from local cache"
          .. (v13 and " (" .. v13 .. ")" or ""))

        return v26
      end
    end
  end

  local f2

  function f2(p5)
    if not p5 then
      return nil
    else
      local v27, v28 = pcall(game.HttpGet, game, p5, true)

      if v27 and typeof(v28) == "string" and #v28 > 100 then
        return v28
      end

      return nil
    end
  end

  print("[Lamduck] Downloading " .. p1 .. (v13 and " (" .. v13 .. ")" or "") .. "...")
  local v29 = f2(p2)

  if not v29 and v12 then
    print("[Lamduck] Downloading " .. p1 .. " from fallback URL...")
    v29 = f2(v12)
  end

  if v29 then
    local v30, v31 = pcall(loadstring, v29)

    if v30 and type(v31) == "function" then
      local v32, v33 = pcall(v31)

      if v32 and (type(v33) == "table" or type(v33) == "userdata") then
        local v34 = v13 and "Lamduck" .. "/" .. p1 .. "_Cache_" .. v13 .. ".luau"

        local v35 = v34
        v35 = v34 or "Lamduck" .. "/" .. p1 .. "_Cache_" .. os.time() .. ".luau"

        pcall(writefile, v35, v29)

        if not v13 and v16 and v16 ~= v35 and type(delfile) == "function" then
          pcall(delfile, v16)
        end

        print("[Lamduck] " .. p1 .. " saved to cache")
        return v33
      end
    end
  end

  if v15 then
    local v36, v37 = pcall(loadstring, v15)

    if v36 and type(v37) == "function" then
      local v38, v39 = pcall(v37)

      if v38 and (type(v39) == "table" or type(v39) == "userdata") then
        warn("[Lamduck] Failed to download " .. p1 .. ", loaded from expired cache")
        return v39
      end

      return nil
    end

    return nil
  end

  return nil
end

local v40 = f1(
  "Fluent",
  "https://github.com/lamduck2005/Fluent-Renewed-Plus/releases/download/v0.4.4.20/Fluent.luau",
  "https://github.com/lamduck2005/Fluent-Renewed-Plus/releases/latest/download/Fluent.luau",
  "v0.4.4.20"
)

local v41 = f1(
  "SaveManager", "https://lamduck2005.github.io/Fluent-Renewed-Plus/Addons/SaveManager.luau",
  "https://raw.githubusercontent.com/lamduck2005/Fluent-Renewed-Plus/main/Addons/SaveManager.luau"
)

local v42 = f1(
  "InterfaceManager",
  "https://lamduck2005.github.io/Fluent-Renewed-Plus/Addons/InterfaceManager.luau",
  "https://raw.githubusercontent.com/lamduck2005/Fluent-Renewed-Plus/main/Addons/InterfaceManager.luau"
)

local v43 = f1(
  "ExtraSetting", "https://lamduck2005.github.io/Fluent-Renewed-Plus/Addons/ExtraSetting.luau",
  "https://raw.githubusercontent.com/lamduck2005/Fluent-Renewed-Plus/main/Addons/ExtraSetting.luau"
)

if v43 then
  v43.Discord = "https://discord.gg/N3uxkAHYtM"
  v43.AutoExecuteUrl = "https://lamduck2005.github.io/RobloxScript/loader.lua"
end

v40.SaveManager = v41
v40.InterfaceManager = v42
v40.ExtraSetting = v43

local window = v40.Window

function v40.Window(p6, p7)
  local v44 = p7 or {}

  if not v44.KeySystem then
    v44.KeySystem = {
      Title = "Lamduck Key System",
      Note = "• One key works for all Lamduck scripts.\n• Try another option if you cannot pass the key system.",
      SaveKey = true,
      KeyFolder = "Lamduck",
      AllowWhitelist = true,
      API = {
        {
          Type = "lamduck",
          Title = "LamDuck",
          BaseUrl = "https://lamduck.vercel.app",
          VerifySecret = "Lam692@5",
        },
        {
          Type = "pandadevelopment",
          Title = "Panda Auth",
          Icon = "rbxthumb://type=Asset&id=121094820649150&w=150&h=150",
          ServiceId = "lamduck",
        },
      },
    }
  end

  if v44.SubTitle == nil then
    v44.SubTitle = "by Lamduck"
  end

  if v44.TabWidth == nil then
    v44.TabWidth = 140
  end

  if v44.Size == nil then
    v44.Size = UDim2.fromOffset(1200, 700)
  end

  if v44.Resize == nil then
    v44.Resize = true
  end

  if v44.HideButton == nil then
    v44.HideButton = true
  end

  return window(p6, v44)
end

return v40, v41, v42, v43
