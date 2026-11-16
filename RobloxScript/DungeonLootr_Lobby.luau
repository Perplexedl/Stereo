local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local players = game:GetService("Players")
local collectionService = game:GetService("CollectionService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local v5 = require(replicatedStorage.Packages.Knit)
local dungeonQueueService = v5.GetService("DungeonQueueService")
local equipmentService = v5.GetService("EquipmentService")
local bankService = v5.GetService("BankService")
local statService = v5.GetService("StatService")
local shopService = v5.GetService("ShopService")
local questService = v5.GetService("QuestService")
local battlepassService = v5.GetService("BattlepassService")
local summoningService = v5.GetService("SummoningService")
local packageService = v5.GetService("PackageService")
local codesService = v5.GetService("CodesService")
local achievementService = v5.GetService("AchievementService")
local chestService = v5.GetService("ChestService")
local inventoryService = v5.GetService("InventoryService")
local bossRushService = v5.GetService("BossRushService")
local challengeRewardService = v5.GetService("ChallengeRewardService")
local buffService = v5.GetService("BuffService")
local potionService = v5.GetService("PotionService")

local v6 = {
  "UPDATE1", "WEEKENDBUFFS", "15KCCU", "COURAGE", "LOVETHISGAME", "RAIDTIME", "FORGESKIP",
  "8KLIKE", "10KFAV", "FULLRELEASE", "LOOTRISBACK", "JACKPOT", "20KPLAYERS", "GIVEMEGEMSPLEASE",
  "LOOTR",
}

local v7 = { IsStarting = false, StartSessionId = 0 }
local v8 = { ClassSlotInfo = nil }
local v9 = {}
local v10 = {}

local v11 = {
  Lobby = {
    {
      Section = "Main Areas",
      Items = {
        {
          Title = "Spawn",
          Description = "Default Lobby Spawn point",
          Finder = function() return workspace:FindFirstChild("SpawnLocation") end,
          Fallback = Vector3.new(10213.5, 1181.1, 1106.1),
        },
        {
          Title = "Forge Archon",
          Description = "Master Blacksmith for forging and upgrading gear",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Forge Archon") end,
          Fallback = Vector3.new(10086.8, 1184.1, 1086.8),
        },
        {
          Title = "Classes & Summoning",
          Description = "Area to summon and change character classes",
          Finder = function()
            return workspace.Areas.Areas_Model:FindFirstChild("Classes")
              or workspace.Prompts:FindFirstChild("Classes")
          end,
          Fallback = Vector3.new(10274.5, 1185.4, 1192),
        },
        {
          Title = "Quest Board",
          Description = "Daily and Weekly quests board",
          Finder = function() return workspace.Prompts:FindFirstChild("Quests") end,
          Fallback = Vector3.new(10341.3, 1185.7, 1168.8),
        },
        {
          Title = "Group Reward",
          Description = "Roblox group exclusive aura and chest",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Group") end,
          Fallback = Vector3.new(10280.4, 1180.8, 1165.5),
        },
        {
          Title = "Tavern",
          Description = "Social area and tavern",
          Finder = function()
            return workspace.Dialogue_NPCS:FindFirstChild("Monkedeus")
              or workspace.Dialogue_NPCS:FindFirstChild("ElyzaKat")
          end,
          Fallback = Vector3.new(11639, 1152, 1223),
        },
      },
    },
    {
      Section = "Shops & Utilities",
      Items = {
        {
          Title = "Personal Storage",
          Description = "Item storage chest",
          Finder = function() return workspace.Prompts:FindFirstChild("Storage") end,
          Fallback = Vector3.new(10014.1, 1186.4, 1127),
        },
        {
          Title = "Buy Shop",
          Description = "Item purchase shop",
          Finder = function() return workspace.Prompts:FindFirstChild("BuyShop") end,
          Fallback = Vector3.new(10183, 1185.9, 1208.7),
        },
        {
          Title = "Sell Shop",
          Description = "Sell items for gold",
          Finder = function() return workspace.Prompts:FindFirstChild("SellShop") end,
          Fallback = Vector3.new(10164, 1185.9, 1208.7),
        },
        {
          Title = "Weapon Shop",
          Description = "Weapons and gear vendor",
          Finder = function() return workspace.Prompts:FindFirstChild("WeaponShop") end,
          Fallback = Vector3.new(10076.2, 1159.1, 1143.1),
        },
        {
          Title = "Key Shop",
          Description = "Dungeon and challenge keys merchant",
          Finder = function() return workspace.Prompts:FindFirstChild("Key_Shop") end,
          Fallback = Vector3.new(2367.2, 602.3, -2095.5),
        },
        {
          Title = "Item Traits (Reroll)",
          Description = "Reroll equipment traits and bonuses",
          Finder = function() return workspace.Prompts:FindFirstChild("Traits") end,
          Fallback = Vector3.new(10064.2, 1132.1, 1138.1),
        },
        {
          Title = "Item Identifier",
          Description = "Identify unidentified items",
          Finder = function() return workspace.Prompts:FindFirstChild("Identifier") end,
          Fallback = Vector3.new(10204.5, 972.8, 1031.1),
        },
        {
          Title = "Title Index",
          Description = "Character titles and requirements",
          Finder = function() return workspace.Prompts:FindFirstChild("TitleIndex") end,
          Fallback = Vector3.new(10227.4, 962.7, 1016.8),
        },
        {
          Title = "Stars Shop",
          Description = "Star currency exchange shop",
          Finder = function() return workspace.Prompts:FindFirstChild("Stars_Shop") end,
          Fallback = Vector3.new(10273.2, 1185.4, 1020.3),
        },
      },
    },
  },
  Dungeons = {
    {
      Section = "Dungeon Pods",
      Items = {
        {
          Title = "Normal Dungeon Pods",
          Description = "Lobby pods for standard dungeon runs",
          Finder = function()
            return workspace.pods:FindFirstChildWhichIsA("Model")
              or workspace.Areas.Areas_Model:FindFirstChild("Play")
          end,
          Fallback = Vector3.new(10383.5, 1183.7, 1166.1),
        },
        {
          Title = "Challenge Dungeon Pods",
          Description = "Endless and challenge mode pods",
          Finder = function()
            return workspace.pods_challenge:FindFirstChildWhichIsA("Model")
          end,
          Fallback = Vector3.new(10403.5, 1183.7, 1046.2),
        },
      },
    },
    {
      Section = "Portals & Arenas",
      Items = {
        {
          Title = "Boss Rush Portal",
          Description = "Warp portal to Boss Rush",
          Finder = function()
            return workspace.Areas.Areas_Model:FindFirstChild("BossRush")
              or workspace.Portals:FindFirstChild("Boss")
          end,
          Fallback = Vector3.new(3099, 602, -2079),
        },
        {
          Title = "Raid Portal",
          Description = "Large portal to Raid challenges",
          Finder = function() return workspace.Portals:FindFirstChild("Big Portal") end,
          Fallback = Vector3.new(2229.8, 605.9, -2387.5),
        },
        {
          Title = "PVP Arena",
          Description = "Player versus Player combat grounds",
          Finder = function()
            return workspace.Portals:FindFirstChild("PVP")
              or workspace:FindFirstChild("PVP_AREA")
          end,
          Fallback = Vector3.new(10179.4, 1187.1, 221.2),
        },
        {
          Title = "Training Dummies",
          Description = "Damage testing dummies area",
          Finder = function() return workspace.Areas.Areas_Model:FindFirstChild("Training") end,
          Fallback = Vector3.new(10143.5, 1185.2, 160.8),
        },
        {
          Title = "Event Area",
          Description = "Seasonal and limited-time events area",
          Finder = function() return workspace.Portals:FindFirstChild("ToEvent") end,
          Fallback = Vector3.new(10283.1, 1187.2, 1046.1),
        },
      },
    },
  },
  NPCs = {
    {
      Section = "Class Mentors & Weapons",
      Items = {
        {
          Title = "Jetstream",
          Description = "Cybernetic Katana master",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Jetstream") end,
          Fallback = Vector3.new(10590.2, 1160.8, 1357.5),
        },
        {
          Title = "Cursed King",
          Description = "Curse power mentor (Sukuna)",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Cursed King") end,
          Fallback = Vector3.new(10251.2, 1184.7, 999.5),
        },
        {
          Title = "Unrestricted",
          Description = "Heavenly Restriction mentor (Toji)",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Unrestricted") end,
          Fallback = Vector3.new(10431.7, 1164, 1113.8),
        },
        {
          Title = "Kage",
          Description = "Shadow blade assassin master on the cliffs",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Kage") end,
          Fallback = Vector3.new(9998, 1185.1, 1033.1),
        },
        {
          Title = "Valen",
          Description = "Ancient blade master at the peak",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Valen") end,
          Fallback = Vector3.new(10737.3, 1187.6, 1337.3),
        },
        {
          Title = "Great Mage",
          Description = "Great Mage Staff master",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Great Mage") end,
          Fallback = Vector3.new(10191.3, 1184.7, 987.4),
        },
      },
    },
    {
      Section = "Quests & Special NPCs",
      Items = {
        {
          Title = "Hitman",
          Description = "Assassination contract missions",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Hitman") end,
          Fallback = Vector3.new(10135.7, 1181.8, 977.5),
        },
        {
          Title = "Bounty Hunter",
          Description = "Player and monster bounty hunting",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("BountyHunter") end,
          Fallback = Vector3.new(11638.5, 1077.8, 1176.5),
        },
        {
          Title = "Galran",
          Description = "Combat survival tips and dungeon insights",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Galran") end,
          Fallback = Vector3.new(10353.6, 1180.8, 1023),
        },
        {
          Title = "Ogge",
          Description = "Lost hat secret easter egg NPC",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("Ogge") end,
          Fallback = Vector3.new(10016.5, 1185.1, 1133.3),
        },
        {
          Title = "ElyzaKat (Neko Dance)",
          Description = "Easter egg dance NPC",
          Finder = function() return workspace.Dialogue_NPCS:FindFirstChild("ElyzaKat") end,
          Fallback = Vector3.new(10259.3, 1185.4, 1125.2),
        },
      },
    },
  },
}

local function f1()
  if v9.DungeonList and #v9.DungeonList > 0 then
    return v9.DungeonList
  end

  local v12 = {}

  pcall(function()
    local v13 = require(replicatedStorage.GameInfo.DungeonData)

    for index, value in ipairs(v13.DisplayOrder or {}) do
      local v14 = v13.GetDungeon(value)
      local isChallengeMode = v13.IsChallengeMode and v13.IsChallengeMode(value)

      if v14 and not v14.HideFromSelect and not isChallengeMode then
        table.insert(v12, value)
      end
    end
  end)

  if #v12 == 0 then
    warn("[Config] GetDungeonsConfig: Failed to load from DungeonData, using fallback.")

    v12 = {
      "Bandits Den", "Goblin's Stronghold", "Forgotten Ruins", "The Catacombs",
      "Frostspire Bastion", "Underworld Gate", "City of Mages", "Double Dungeon", "Throne Room",
    }
  end

  v9.DungeonList = v12
  return v12
end

local function f2()
  if v9.DifficultyList and #v9.DifficultyList > 0 then
    return v9.DifficultyList
  end

  local v15 = {}

  pcall(function()
    local v16 = require(replicatedStorage.GameInfo.EquipmentData)
    local difficultyLEVELWINDOWS = v16 and v16.DIFFICULTY_LEVEL_WINDOWS

    if difficultyLEVELWINDOWS then
      for index2, value2 in ipairs({ "Easy", "Normal", "Hard", "Nightmare", "Endless" }) do
        if difficultyLEVELWINDOWS[value2] ~= nil then
          table.insert(v15, value2)
        end
      end
    end
  end)

  if #v15 == 0 then
    warn("[Config] GetDifficultiesConfig: Failed to load from EquipmentData, using fallback.")
    v15 = { "Easy", "Normal", "Hard", "Nightmare", "Endless" }
  end

  v9.DifficultyList = v15
  return v15
end

local function f3()
  if v9.RarityList and #v9.RarityList > 0 then
    return v9.RarityList
  end

  local v17 = {}

  pcall(function()
    local v18 = require(replicatedStorage.GameInfo.RarityData)
    local gearRarityTabs = v18 and v18.GearRarityTabs

    if gearRarityTabs and #gearRarityTabs > 0 then
      for index3, value3 in ipairs(gearRarityTabs) do
        table.insert(v17, value3)
      end
    end
  end)

  if #v17 == 0 then
    warn("[Config] GetRaritiesConfig: Failed to load from RarityData, using fallback.")
    v17 = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Celestial", "Exotic" }
  end

  v9.RarityList = v17
  return v17
end

local function f4()
  if v9.BossRushFinalBosses and #v9.BossRushFinalBosses > 0 then
    return v9.BossRushFinalBosses
  end

  local v19 = {}

  pcall(function()
    local v20 = require(replicatedStorage.GameInfo.BossRushData)

    if v20 and v20.FINAL_BOSS_ORDER then
      for index4, value4 in ipairs(v20.FINAL_BOSS_ORDER) do
        table.insert(v19, value4)
      end
    end
  end)

  if #v19 == 0 then
    warn("[Config] GetBossRushFinalBossesConfig: Failed to load from BossRushData, using fallback.")
    v19 = { "Cursed King", "Satori", "Anti Mage", "Great Mage" }
  end

  v9.BossRushFinalBosses = v19
  return v19
end

local function f5()
  if v9.BossRushSkipFloors and #v9.BossRushSkipFloors > 0 then
    return v9.BossRushSkipFloors
  end

  local v21 = { "None (Floor 0)" }

  pcall(function()
    local v22 = require(replicatedStorage.GameInfo.BossRushData)

    if v22 and v22.MIN_SKIP_FLOOR and v22.MAX_SKIP_FLOOR and v22.SKIP_STEP then
      for i = v22.MIN_SKIP_FLOOR, v22.MAX_SKIP_FLOOR, v22.SKIP_STEP do
        table.insert(v21, string.format("Floor %d", i))
      end
    end
  end)

  if #v21 == 1 then
    warn("[Config] GetBossRushSkipFloorsConfig: Failed to load from BossRushData, using fallback.")
    v21 = { "None (Floor 0)", "Floor 10", "Floor 20", "Floor 30", "Floor 40", "Floor 50" }
  end

  v9.BossRushSkipFloors = v21
  return v21
end

local function f6()
  local featuredDUNGEON = nil

  pcall(function()
    local v23 = require(replicatedStorage.GameInfo.ChallengeData)

    if v23 and v23.FEATURED_DUNGEON then
      featuredDUNGEON = v23.FEATURED_DUNGEON
    end
  end)

  if not featuredDUNGEON or featuredDUNGEON == "" then
    warn("[Config] GetChallengeFeaturedDungeon: Failed to load from ChallengeData, using fallback.")
    featuredDUNGEON = "Forest Challenge"
  end

  return featuredDUNGEON
end

local function f7()
  if v9.ClassList and #v9.ClassList > 0 then
    return v9.ClassList
  end

  local v24 = {}

  pcall(function()
    local classes = replicatedStorage:FindFirstChild("Classes")

    if classes then
      for index5, value5 in ipairs(classes:GetChildren()) do
        if value5:IsA("Folder") then
          table.insert(v24, value5.Name)
        end
      end
    end
  end)

  table.sort(v24)

  if #v24 == 0 then
    warn("[Config] GetClassListConfig: Failed to load from Classes folder, using fallback.")

    v24 = {
      "Archer", "Artemis", "Assassin", "Azure Devil", "Bowman", "Boxer", "Cursed Child",
      "Divergent", "Flame Bastion", "Forge Archon", "Greatsword", "Kage", "Ronin", "Shinobi",
      "Sinister Trigger", "Vacio", "Wanderer", "Witch Gunner",
    }
  end

  v9.ClassList = v24
  return v24
end

local function f8()
  if v9.ClassRarityList and #v9.ClassRarityList > 0 then
    return v9.ClassRarityList
  end

  local v25 = {}

  pcall(function()
    local rarityData = replicatedStorage:FindFirstChild("GameInfo")
      and replicatedStorage.GameInfo:FindFirstChild("RarityData")

    if rarityData then
      local v26 = require(rarityData)
      local v27 = { "Rare", "Epic", "Legendary", "Mythic", "Celestial", "Exotic" }

      if v26 and v26.RarityOrder then
        for index6, value6 in ipairs(v26.RarityOrder) do
          if table.find(v27, value6) then
            table.insert(v25, value6)
          end
        end
      end
    end
  end)

  if #v25 == 0 then
    warn("[Config] GetClassRarityListConfig: Failed to load from RarityData, using fallback.")
    v25 = { "Rare", "Epic", "Legendary", "Mythic", "Celestial", "Exotic" }
  end

  v9.ClassRarityList = v25
  return v25
end

local function f9()
  if v9.BuffPotionList and #v9.BuffPotionList > 0 then
    return v9.BuffPotionList
  end

  local v28 = {}
  local v29 = {}

  pcall(function()
    local v30 = require(replicatedStorage.GameInfo.BuffPotionData)

    if v30 and v30.Potions then
      for index7, value7 in ipairs(v30.Potions) do
        if value7.Id and value7.Name then
          table.insert(v28, value7.Name)
          v29[value7.Name] = value7.Id
          v29[value7.Id] = value7.Name
        end
      end
    end
  end)

  if #v28 == 0 then
    warn("[Config] GetBuffPotionsConfig: Failed to load from BuffPotionData, using fallback.")

    v28 = {
      "Minor Drop Potion", "Major Drop Potion", "Minor Luck Potion", "Major Luck Potion",
      "Minor Speed Potion", "Major Speed Potion", "Minor Cash Potion", "Major Cash Potion",
      "Swift Potion", "Lucky Potion", "EXP Potion", "Damage Potion", "Class EXP Potion",
      "Double EXP Potion", "Loot Luck Potion", "Luck Potion I", "Luck Potion II",
      "Luck Potion III",
    }

    for key, value8 in pairs({
      ["Minor Drop Potion"] = "MinorDropRate",
      ["Major Drop Potion"] = "MajorDropRate",
      ["Minor Luck Potion"] = "MinorLuckRate",
      ["Major Luck Potion"] = "MajorLuckRate",
      ["Minor Speed Potion"] = "MinorMoveSpeed",
      ["Major Speed Potion"] = "MajorMoveSpeed",
      ["Minor Cash Potion"] = "MinorCashRate",
      ["Major Cash Potion"] = "MajorCashRate",
      ["Swift Potion"] = "SwiftPotion",
      ["Lucky Potion"] = "LuckyPotion",
      ["EXP Potion"] = "EXPPotion",
      ["Damage Potion"] = "DamagePotion",
      ["Class EXP Potion"] = "ClassXPPotion",
      ["Double EXP Potion"] = "DoubleEXPPotion",
      ["Loot Luck Potion"] = "LootLuckPotion",
      ["Luck Potion I"] = "LuckPotionT1",
      ["Luck Potion II"] = "LuckPotionT2",
      ["Luck Potion III"] = "LuckPotionT3",
    }) do
      v29[key] = value8
      v29[value8] = key
    end
  end

  v9.BuffPotionList = v28
  v9.BuffPotionMapping = v29

  return v28
end

local function f10()
  if v9.InstantUsePotionList and #v9.InstantUsePotionList > 0 then
    return v9.InstantUsePotionList
  end

  local v31 = {}
  local v32 = {}

  pcall(function()
    local v33 = require(replicatedStorage.GameInfo.PotionData)

    if v33 and v33.Potions then
      for index8, value9 in ipairs(v33.Potions) do
        if value9.InstantUse == true and value9.Id and value9.Name then
          table.insert(v31, value9.Name)
          v32[value9.Name] = value9.Id
          v32[value9.Id] = value9.Name
        end
      end
    end
  end)

  if #v31 == 0 then
    warn("[Config] GetInstantUsePotionsConfig: Failed to load from PotionData, using fallback.")

    v31 = {
      "Class XP Essence", "Warrior's Elixir", "Swift Elixir", "Fortifying Draught",
      "Mystery Elixir",
    }

    for key2, value10 in pairs({
      ["Class XP Essence"] = "ClassXPEssence",
      ["Warrior's Elixir"] = "WarriorsElixir",
      ["Swift Elixir"] = "SwiftElixir",
      ["Fortifying Draught"] = "FortifyingDraught",
      ["Mystery Elixir"] = "MysteryElixir",
    }) do
      v32[key2] = value10
      v32[value10] = key2
    end
  end

  v9.InstantUsePotionList = v31
  v9.InstantUsePotionMapping = v32

  return v31
end

local function f11(p1)
  if not p1 or p1 == "Empty" then
    return nil
  end

  if not v9.ClassRarities then
    v9.ClassRarities = {}
  end

  if v9.ClassRarities[p1] then
    return v9.ClassRarities[p1]
  end

  pcall(function()
    local findFirstChild = replicatedStorage:FindFirstChild("Classes")
      and replicatedStorage.Classes:FindFirstChild(p1)

    if findFirstChild then
      local definition = findFirstChild:FindFirstChild("Definition")

      if definition then
        local v34 = require(definition)

        if v34 and v34.Rarity then
          v9.ClassRarities[p1] = v34.Rarity
          return
        end
      end
    end

    local v35 = require(replicatedStorage.Classes.Class_Data)

    if v35 and v35.GetRarity then
      v9.ClassRarities[p1] = v35.GetRarity(p1)
    end
  end)

  return v9.ClassRarities[p1]
end

local function f12()
  local playerData = nil

  pcall(function()
    playerData = require(localPlayer.PlayerScripts.Client.Controllers.Registry):Get("PlayerData")
  end)

  return playerData
end

local function f13()
  local v36 = f12()
  return v36 and v36.Data and (v36.Data.Currency or v36.Data.Coins) or 0
end

local function f14()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Character_AutoEquipBest
      and v1.Options.Toggle_Character_AutoEquipBest.Value do
      pcall(function()
        local v37 = require(localPlayer.PlayerScripts.Client.UI.Inventory)

        if v37 and typeof(v37.OnEquipBestClicked) == "function" then
          v37.OnEquipBestClicked()
        end
      end)

      task.wait(3)
    end
  end)
end

local function f15()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Character_AutoUpgradeStats
      and v1.Options.Toggle_Character_AutoUpgradeStats.Value do
      local v38 = f12()

      if (v38 and v38.Data and v38.Data.UnspentSkillPoints or 0) > 0 then
        pcall(function()
          local statController = v5.GetController("StatController")

          if statController then
            statController:AutoAllocate()
            return
          end

          statService:AutoAllocate():await()
        end)
      end

      task.wait(3)
    end
  end)
end

local function f16()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Character_AutoLock
      and v1.Options.Toggle_Character_AutoLock.Value do
      pcall(function()
        local v39 = f12()
        local equipmentInventory = v39 and v39.Data and v39.Data.EquipmentInventory

        local value11 = v1.Options.Dropdown_Character_LockRarities
          and v1.Options.Dropdown_Character_LockRarities.Value

        if equipmentInventory and type(value11) == "table" then
          for key3, value12 in pairs(equipmentInventory) do
            if type(value12) == "table" and value12.GUID and value12.Rarity
              and not value12.Locked then
              if value11[value12.Rarity] == true then
                equipmentService:ToggleLock(value12.GUID):await()
                task.wait(0.1)
              end
            end
          end
        end
      end)

      task.wait(2)
    end
  end)
end

local function f17()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Character_AutoDelete
      and v1.Options.Toggle_Character_AutoDelete.Value do
      pcall(function()
        local v40 = f12()
        local equipmentInventory2 = v40 and v40.Data and v40.Data.EquipmentInventory
        local equipment = v40 and v40.Data and v40.Data.Equipment or {}

        local value13 = v1.Options.Dropdown_Character_DeleteRarities
          and v1.Options.Dropdown_Character_DeleteRarities.Value

        if equipmentInventory2 and type(value13) == "table" then
          for key4, value14 in pairs(equipmentInventory2) do
            if v1.Unloaded
              or not (v1.Options.Toggle_Character_AutoDelete
                and v1.Options.Toggle_Character_AutoDelete.Value) then
              break
            end

            if type(value14) == "table" and value14.GUID and value14.Rarity
              and not value14.Locked then
              local v41 = false

              for key5, value15 in pairs(equipment) do
                if type(value15) == "table" and value15.GUID == value14.GUID then
                  v41 = true
                  break
                end
              end

              if not v41 then
                if value13[value14.Rarity] == true then
                  equipmentService:DeleteItem(value14.GUID):await()
                  task.wait(0.2)
                end
              end
            end
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f18()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Character_AutoUseBuffPotions
      and v1.Options.Toggle_Character_AutoUseBuffPotions.Value do
      pcall(function()
        local value16 = v1.Options.Dropdown_Character_SelectBuffPotions
          and v1.Options.Dropdown_Character_SelectBuffPotions.Value

        if type(value16) ~= "table" then
          return
        end

        local v42 = f12()
        local buffPotions = v42 and v42.Data and v42.Data.BuffPotions

        if not buffPotions or type(buffPotions) ~= "table" then
          return
        end

        local activeBuffs = v42 and v42.Data and v42.Data.ActiveBuffs
        local v43 = {}

        if type(activeBuffs) == "table" then
          for key6, value17 in pairs(activeBuffs) do
            if type(value17) == "table" then
              local potionId = value17.PotionId or value17.Id

              if potionId then
                if (tonumber(value17.RemainingSeconds) or 0) > 5 then
                  v43[potionId] = true
                end
              end
            end
          end
        end

        local buffPotionMapping = v9.BuffPotionMapping or {}

        for key7, value18 in pairs(value16) do
          if v1.Unloaded
            or not (v1.Options.Toggle_Character_AutoUseBuffPotions
              and v1.Options.Toggle_Character_AutoUseBuffPotions.Value) then
            break
          end

          if value18 == true then
            local v44 = buffPotionMapping[key7] or key7

            if not v43[v44] then
              local v45 = buffPotions[v44] or 0

              if v45 > 0 then
                local v46, v47 = buffService:UseBuff(v44):await()

                if v46 then
                  v1:Notify({
                    Title = "Auto Buff",
                    Content = string.format("Used %s (%d left).", tostring(key7), v45 - 1),
                    Duration = 3,
                  })

                  v43[v44] = true
                  task.wait(0.5)
                end
              end
            end
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f19()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Character_AutoConsumeInstantPotions
      and v1.Options.Toggle_Character_AutoConsumeInstantPotions.Value do
      pcall(function()
        local value19 = v1.Options.Dropdown_Character_SelectInstantPotions
          and v1.Options.Dropdown_Character_SelectInstantPotions.Value

        if type(value19) ~= "table" then
          return
        end

        local v48 = f12()
        local potions = v48 and v48.Data and v48.Data.Potions

        if not potions or type(potions) ~= "table" then
          return
        end

        local instantUsePotionMapping = v9.InstantUsePotionMapping or {}

        for key8, value20 in pairs(value19) do
          if v1.Unloaded
            or not (v1.Options.Toggle_Character_AutoConsumeInstantPotions
              and v1.Options.Toggle_Character_AutoConsumeInstantPotions.Value) then
            break
          end

          if value20 == true then
            local v49 = instantUsePotionMapping[key8] or key8
            local v50 = potions[v49] or 0

            if v50 > 0 then
              local v51, v52 = potionService:ConsumePotion(v49):await()

              if v51 and v52 then
                v1:Notify({
                  Title = "Auto Consume",
                  Content = string.format("Consumed %s (%d left).", tostring(key8), v50 - 1),
                  Duration = 3,
                })

                task.wait(0.2)
              end
            end
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f20()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoExpandInventory
      and v1.Options.Toggle_Shop_AutoExpandInventory.Value do
      pcall(function()
        local v53, v54 = shopService:GetExpansionInfo():await()

        if v53 and v54 and v54.NextCoinCost then
          if f13() >= v54.NextCoinCost then
            local v55, v56 = shopService:PurchaseExpansion():await()

            if v55 and v56 then
              v1:Notify({
                Title = "Inventory Expanded",
                Content = string.format(
                  "Expanded to %d slots.", v54.CurrentMax + v54.NextCoinSlots
                ),
                Duration = 3,
              })
            end
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f21()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Shop_AutoSell
      and v1.Options.Toggle_Shop_AutoSell.Value do
      pcall(function()
        local v57 = f12()
        local equipmentInventory3 = v57 and v57.Data and v57.Data.EquipmentInventory
        local equipment2 = v57 and v57.Data and v57.Data.Equipment or {}

        local value21 = v1.Options.Dropdown_Shop_SellRarities
          and v1.Options.Dropdown_Shop_SellRarities.Value

        if equipmentInventory3 and type(value21) == "table" then
          local v58 = {}

          for key9, value22 in pairs(equipmentInventory3) do
            if v1.Unloaded
              or not (v1.Options.Toggle_Shop_AutoSell and v1.Options.Toggle_Shop_AutoSell.Value) then
              break
            end

            if type(value22) == "table" and value22.GUID and value22.Rarity
              and not value22.Locked then
              local v59 = false

              for key10, value23 in pairs(equipment2) do
                if type(value23) == "table" and value23.GUID == value22.GUID then
                  v59 = true
                  break
                end
              end

              if not v59 then
                if value21[value22.Rarity] == true then
                  table.insert(v58, value22.GUID)

                  if #v58 >= 50 then
                    break
                  end
                end
              end
            end
          end

          if #v58 > 0 then
            local v60, v61, v62 = shopService:SellEquipment(v58):await()

            if v60 and v61 then
              v1:Notify({
                Title = "Auto Sell",
                Content = string.format(
                  "Sold %d item(s) for %d Coins.", #v58, tonumber(v62) or 0
                ),
                Duration = 3,
              })
            end
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f22()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Quest_AutoClaimQuests
      and v1.Options.Toggle_Quest_AutoClaimQuests.Value do
      pcall(function()
        local v63 = f12()
        local quests = v63 and v63.Data and v63.Data.Quests

        if not quests then
          return
        end

        for key11, value24 in pairs(quests) do
          if type(value24) == "table" and type(value24.Active) == "table" then
            for index9, value25 in ipairs(value24.Active) do
              if type(value25) == "table" and value25.Completed == true and not value25.Claimed then
                local v64, v65 = questService:ClaimQuest(key11, index9):await()

                if v64 and v65 then
                  v1:Notify({
                    Title = "Quest Claimed",
                    Content = string.format(
                      "Claimed %s quest (Slot %d).", tostring(key11), index9
                    ),
                    Duration = 3,
                  })
                end

                task.wait(0.2)
              end
            end
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f23()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Quest_AutoClaimBattlepassTiers
      and v1.Options.Toggle_Quest_AutoClaimBattlepassTiers.Value do
      pcall(function()
        local v66 = f12()
        local battlepass = v66 and v66.Data and v66.Data.Battlepass

        if not battlepass or not battlepass.Tier then
          return
        end

        local v67 = math.min(tonumber(battlepass.Tier) or 0, 50)
        local claimedFree = battlepass.ClaimedFree or {}
        local claimedPremium = battlepass.ClaimedPremium or {}
        local v68 = battlepass.HasPremium == true

        for j = 1, v67 do
          if not table.find(claimedFree, j) then
            battlepassService:ClaimReward(j, "Free"):await()
            task.wait(0.1)
          end

          if v68 and not table.find(claimedPremium, j) then
            battlepassService:ClaimReward(j, "Premium"):await()
            task.wait(0.1)
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f24()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Quest_AutoClaimBattlepassQuests
      and v1.Options.Toggle_Quest_AutoClaimBattlepassQuests.Value do
      pcall(function()
        local v69 = f12()
        local battlepass2 = v69 and v69.Data and v69.Data.Battlepass
        local quests2 = battlepass2 and battlepass2.Quests

        if not quests2 or type(quests2) ~= "table" then
          return
        end

        for index10, value26 in ipairs(quests2) do
          if type(value26) == "table" and value26.Completed == true and not value26.Claimed then
            local v70, v71 = battlepassService:ClaimQuest(index10):await()

            if v70 and v71 then
              v1:Notify({
                Title = "Battlepass Quest Claimed",
                Content = string.format("Claimed Battlepass quest (Slot %d).", index10),
                Duration = 3,
              })
            end

            task.wait(0.2)
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f25()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimFreeChests
      and v1.Options.Toggle_Reward_AutoClaimFreeChests.Value do
      local v72 = f12()

      if v72 and v72.Data then
        local rebirths = v72.Data.Rebirths or 0
        local claimedIds = (v72.Data.FreeChests or {}).ClaimedIds or {}
        local v73

        pcall(function()
          local gameInfo = replicatedStorage:FindFirstChild("GameInfo")

          if gameInfo and gameInfo:FindFirstChild("ChestData") then
            v73 = require(gameInfo.ChestData)
          end
        end)

        local freeChests = v73 and v73.FreeChests

        if freeChests then
          for index11, value27 in ipairs(freeChests) do
            if rebirths >= (value27.RequiredRebirth or 0)
              and not table.find(claimedIds, index11) then
              if chestService:ClaimFreeChest(index11):await() then
                table.insert(claimedIds, index11)
              end

              task.wait(0.3)
            end
          end
        else
          for k = 1, 10 do
            if not table.find(claimedIds, k) then
              if chestService:ClaimFreeChest(k):await() then
                table.insert(claimedIds, k)
              end

              task.wait(0.3)
            end
          end
        end
      end

      task.wait(3)
    end
  end)
end

local function f26()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoOpenPacks
      and v1.Options.Toggle_Reward_AutoOpenPacks.Value do
      local v74 = f12()

      if v74 and v74.Data and v74.Data.Packs then
        for key12, value28 in pairs(v74.Data.Packs or {}) do
          if value28 and value28 > 0 then
            for m = 1, value28 do
              if v1.Unloaded
                or not (v1.Options.Toggle_Reward_AutoOpenPacks
                  and v1.Options.Toggle_Reward_AutoOpenPacks.Value) then
                break
              end

              local v75, v76 = packageService:OpenPackage(key12):await()

              if v75 and v76 then
                chestService:ConfirmRewards():await()
              end

              task.wait(0.2)
            end
          end
        end
      end

      task.wait(3)
    end
  end)
end

local function f27()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimAchievements
      and v1.Options.Toggle_Reward_AutoClaimAchievements.Value do
      pcall(function() achievementService:ClaimAll():await() end)
      task.wait(3)
    end
  end)
end

local function f28()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Reward_AutoClaimIndex
      and v1.Options.Toggle_Reward_AutoClaimIndex.Value do
      pcall(function() inventoryService:ClaimAllIndexRewards():await() end)
      task.wait(3)
    end
  end)
end

local function f29(p2)
  task.spawn(function()
    local count = 0

    pcall(function()
      local v77 = f12()
      local equipmentInventory4 = v77 and v77.Data and v77.Data.EquipmentInventory

      if equipmentInventory4 then
        for key13, value29 in pairs(equipmentInventory4) do
          if type(value29) == "table" and value29.GUID and value29.Rarity
            and value29.Locked == true then
            local v78 = false

            if type(p2) == "table" then
              v78 = p2[value29.Rarity] == true
            elseif type(p2) == "string" then
              v78 = p2 == value29.Rarity
            end

            if v78 then
              equipmentService:ToggleLock(value29.GUID):await()
              count = count + 1
              task.wait(0.1)
            end
          end
        end
      end
    end)

    v1:Notify({
      Title = "Unlock Equipment",
      Content = string.format("Unlocked %d item(s).", count),
      Duration = 3,
    })
  end)
end

local function f30()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Character_AutoStorage
      and v1.Options.Toggle_Character_AutoStorage.Value do
      pcall(function()
        local v79 = f12()
        local equipmentInventory5 = v79 and v79.Data and v79.Data.EquipmentInventory

        local value30 = v1.Options.Dropdown_Character_StorageRarities
            and v1.Options.Dropdown_Character_StorageRarities.Value
          or {}

        if equipmentInventory5 then
          local v80 = {}

          for key14, value31 in pairs(equipmentInventory5) do
            if type(value31) == "table" and value31.GUID and value31.Rarity
              and value30[value31.Rarity] == true then
              table.insert(v80, value31.GUID)
            end
          end

          if #v80 > 0 then
            bankService:DepositEquipmentBatch(v80):await()
          end
        end
      end)

      task.wait(3)
    end
  end)
end

local function f31()
  local v81 = f12()

  if v81 and v81.Data and v81.Data.ClassSlots and v1.Options.Dropdown_Class_SelectSlot then
    local v82 = {}

    for n = 1, #v81.Data.ClassSlots do
      table.insert(v82, "Slot " .. n)
    end

    v1.Options.Dropdown_Class_SelectSlot:SetValues(v82)

    if #v82 > 0
      and (not v1.Options.Dropdown_Class_SelectSlot.Value
        or not table.find(v82, v1.Options.Dropdown_Class_SelectSlot.Value)) then
      local activeSlotIndex = v81.Data.ActiveSlotIndex or 1
      v1.Options.Dropdown_Class_SelectSlot:SetValue(v82[activeSlotIndex] or v82[1])
    end
  end
end

local function f32()
  task.spawn(function()
    while not v1.Unloaded do
      pcall(function()
        if v8.ClassSlotInfo then
          local v83 = f12()

          if not v83 or not v83.Data then
            v8.ClassSlotInfo:SetContent("Unable to fetch class slot data.")
            return
          end

          local activeSlotIndex2 = v83.Data.ActiveSlotIndex or 1
          local classSlots = v83.Data.ClassSlots or {}
          local slotLocks = v83.Data.SlotLocks or {}
          local normalSpins = v83.Data.NormalSpins or 0
          local luckySpins = v83.Data.LuckySpins or 0
          local v84 = {}

          table.insert(v84, string.format(
            "<b>Active Slot:</b> <font color=\"#00E676\">Slot %d</font>", activeSlotIndex2
          ))

          table.insert(v84, string.format(
            "<b>Spins:</b> Normal <font color=\"#40C4FF\">%d</font> | Lucky <font color=\"#FFD700\">%d</font>",
            normalSpins, luckySpins
          ))

          table.insert(v84, "<b>Slots:</b>")

          for i6 = 1, #classSlots do
            local v85 = classSlots[i6]
            local className = v85 and v85.ClassName or "Empty"

            local v86 = slotLocks[i6] == true and "<font color=\"#FF5252\">[Locked]</font>"
              or "<font color=\"#69F0AE\">[Unlocked]</font>"

            local v87 = i6 == activeSlotIndex2 and " <font color=\"#00E676\">(Active)</font>"
              or ""

            local v88 = f11(className)
            local v89 = v88 and "[" .. v88 .. "] " or ""

            table.insert(v84, string.format(
              "  Slot %d: <font color=\"#FFFFFF\">%s%s</font> %s%s", i6, v89, className, v86,
              v87
            ))
          end

          v8.ClassSlotInfo:SetContent(table.concat(v84, "\n"))
        end
      end)

      task.wait(3)
    end
  end)
end

local function f33(p3)
  task.spawn(function()
    local v90, v91 = summoningService:SwitchSlot(p3):await()

    if v90 and type(v91) == "table" and v91.Success then
      v1:Notify({
        Title = "Switch Slot",
        Content = string.format("Switched to Slot %d (%s)", p3, tostring(v91.ClassName or "")),
        Duration = 3,
      })

      f31()
    else
      v1:Notify({
        Title = "Switch Slot Failed",
        Content = "Could not switch to slot " .. tostring(p3),
        Duration = 3,
      })
    end
  end)
end

local function f34(p4)
  task.spawn(function()
    local v92, v93 = summoningService:ToggleSlotLock(p4):await()

    if v92 and type(v93) == "table" and v93.Success then
      local locked = v93.Locked and "Locked" or "Unlocked"

      v1:Notify({
        Title = "Slot Lock",
        Content = string.format("Slot %d is now %s.", p4, locked),
        Duration = 3,
      })

      f31()
    else
      v1:Notify({
        Title = "Slot Lock Failed",
        Content = "Failed to toggle lock for slot " .. tostring(p4),
        Duration = 3,
      })
    end
  end)
end

local function f35()
  task.spawn(function()
    while not v1.Unloaded and v1.Options.Toggle_Class_AutoPurchaseSlot
      and v1.Options.Toggle_Class_AutoPurchaseSlot.Value do
      local v94, v95 = summoningService:PurchaseSlot():await()

      if v94 and v95 then
        f31()
      end

      task.wait(3)
    end
  end)
end

local function f36()
  task.spawn(function()
    while not v1.Unloaded
      and (v1.Options.Toggle_Class_AutoRollTargetClass
          and v1.Options.Toggle_Class_AutoRollTargetClass.Value
        or v1.Options.Toggle_Class_AutoRollTargetRarity
          and v1.Options.Toggle_Class_AutoRollTargetRarity.Value) do
      local v96 = false

      repeat
        local value32 = v1.Options.Toggle_Class_AutoRollTargetClass
          and v1.Options.Toggle_Class_AutoRollTargetClass.Value

        local value33 = v1.Options.Toggle_Class_AutoRollTargetRarity
          and v1.Options.Toggle_Class_AutoRollTargetRarity.Value

        local v97 = f12()

        if not v97 or not v97.Data then
          task.wait(1)
          v96 = true
          break
        end

        local value34 = v1.Options.Dropdown_Class_SelectSlot
          and v1.Options.Dropdown_Class_SelectSlot.Value

        local activeSlotIndex3 = value34 and tonumber(value34:match("%d+"))
          or v97.Data.ActiveSlotIndex or 1

        if v97.Data.ActiveSlotIndex ~= activeSlotIndex3 then
          summoningService:SwitchSlot(activeSlotIndex3):await()
          task.wait(0.5)
          v97 = f12()

          if not v97 or not v97.Data or v97.Data.ActiveSlotIndex ~= activeSlotIndex3 then
            task.wait(1)
            v96 = true
            break
          end
        end

        if (v97.Data.SlotLocks or {})[activeSlotIndex3] == true then
          task.wait(2)
          v96 = true
          break
        end

        local value35 = v1.Options.Toggle_Class_UseLuckySpin
          and v1.Options.Toggle_Class_UseLuckySpin.Value

        local luckySpins2 = v97.Data.LuckySpins or 0
        local normalSpins2 = v97.Data.NormalSpins or 0
        local v98 = false

        if value35 and luckySpins2 > 0 then
          v98 = true
        elseif normalSpins2 > 0 then
          v98 = false
        else
          task.wait(3)
          v96 = true
          break
        end

        local v99 = (v97.Data.ClassSlots or {})[activeSlotIndex3]
        local className2 = v99 and v99.ClassName

        if not className2 or className2 == "" then
          task.wait(1)
          v96 = true
          break
        end

        if value32 then
          local value36 = v1.Options.Dropdown_Class_RollTargetClass
            and v1.Options.Dropdown_Class_RollTargetClass.Value

          if not value36 or value36 == "" then
            task.wait(2)
            v96 = true
            break
          end

          if string.lower(className2) == string.lower(value36) then
            if v1.Options.Toggle_Class_AutoLockOnTarget
              and v1.Options.Toggle_Class_AutoLockOnTarget.Value then
              if (v97.Data.SlotLocks or {})[activeSlotIndex3] ~= true then
                local v100, v101 = summoningService:ToggleSlotLock(activeSlotIndex3):await()

                if v100 and type(v101) == "table" and v101.Success then
                  v1:Notify({
                    Title = "Auto Lock Slot",
                    Content = string.format(
                      "Slot %d (%s) has been locked!", activeSlotIndex3, className2
                    ),
                    Duration = 3,
                  })

                  f31()
                end
              end
            end

            task.wait(2)
            v96 = true
            break
          end
        elseif value33 then
          local value37 = v1.Options.Dropdown_Class_RollTargetRarity
            and v1.Options.Dropdown_Class_RollTargetRarity.Value

          if not value37 or value37 == "" then
            task.wait(2)
            v96 = true
            break
          end

          local v102 = f11(className2)
          local rarityIndex = nil

          pcall(function()
            rarityIndex = require(replicatedStorage.GameInfo.RarityData).RarityIndex
          end)

          if v102 and rarityIndex then
            local v103 = rarityIndex[v102] or 0
            local v104 = rarityIndex[value37] or 0

            local value38 = v1.Options.Toggle_Class_KeepHigherRarity
              and v1.Options.Toggle_Class_KeepHigherRarity.Value

            local v105 = false

            if value38 then
              v105 = v103 >= v104
            else
              v105 = v103 == v104
            end

            if v105 then
              if v1.Options.Toggle_Class_AutoLockOnTarget
                and v1.Options.Toggle_Class_AutoLockOnTarget.Value then
                if (v97.Data.SlotLocks or {})[activeSlotIndex3] ~= true then
                  local v106, v107 = summoningService:ToggleSlotLock(activeSlotIndex3):await()

                  if v106 and type(v107) == "table" and v107.Success then
                    v1:Notify({
                      Title = "Auto Lock Slot",
                      Content = string.format(
                        "Slot %d (%s) has been locked!", activeSlotIndex3, className2
                      ),
                      Duration = 3,
                    })

                    f31()
                  end
                end
              end

              task.wait(2)
              v96 = true
              break
            end
          end
        end

        local v108 = v98 and "Lucky" or "Normal"

        local v109, v110, v111 = pcall(function()
          return summoningService:Spin(v108, false):await()
        end)

        if v109 and v110 then
          f31()
        end

        task.wait(1.5)
        v96 = true
      until true

      if not v96 then
        break
      end
    end
  end)
end

local function f37()
  local v112 = f1()
  local v113 = v112[1] or "Bandits Den"
  local v114 = "Easy"

  pcall(function()
    for i7 = #v112, 1, -1 do
      local v115 = v112[i7]

      local v116, v117, v118 = pcall(function()
        return dungeonQueueService:GetDungeonAccessState(v115):await()
      end)

      if v116 and v117 and type(v118) == "table" and v118.Unlocked == true then
        v113 = v115
        break
      end
    end

    local v119, v120, v121 = pcall(function()
      return dungeonQueueService:GetUnlockedDifficulties(v113):await()
    end)

    if v119 and v120 and type(v121) == "table" then
      for index12, value39 in ipairs({ "Nightmare", "Hard", "Normal", "Easy" }) do
        if v121[value39] and v121[value39].Unlocked == true then
          v114 = value39
          break
        end
      end
    end
  end)

  return v113, v114
end

local function f38(p5)
  for index13, value40 in ipairs({
    "Toggle_Dungeon_AutoStart", "Toggle_Dungeon_AutoBestDungeon", "Toggle_Challenge_AutoStart",
    "Toggle_BossRush_AutoStart",
  }) do
    if value40 ~= p5 and v1.Options[value40] and v1.Options[value40].Value then
      v1.Options[value40]:SetValue(false)
    end
  end

  v7.StartSessionId = (v7.StartSessionId or 0) + 1
  v7.IsStarting = false
end

local function f39(p6)
  local value41 = p6 == "Dungeon" and v1.Options.Toggle_Dungeon_AutoBestDungeon
    and v1.Options.Toggle_Dungeon_AutoBestDungeon.Value

  local v122 = "Toggle_Dungeon_AutoStart"

  if p6 == "Dungeon" then
    v122 = value41 and "Toggle_Dungeon_AutoBestDungeon" or "Toggle_Dungeon_AutoStart"
  elseif p6 == "Challenge" then
    v122 = "Toggle_Challenge_AutoStart"
  elseif p6 == "BossRush" then
    v122 = "Toggle_BossRush_AutoStart"
  end

  f38(v122)
  v7.IsStarting = true
  local startSessionId = v7.StartSessionId

  task.spawn(function()
    local sliderDungeonStartDelay = 10
    local title = "Auto Start Solo"
    local v123 = ""
    local v124, v125, v126, v127

    if p6 == "Dungeon" then
      sliderDungeonStartDelay = v1.Options.Slider_Dungeon_StartDelay
          and tonumber(v1.Options.Slider_Dungeon_StartDelay.Value)
        or 10

      if value41 then
        v124, v125 = f37()
        title = "Auto Start Best Dungeon"
      else
        v124 = tostring(v1.Options.Dropdown_Dungeon_SelectMap
            and v1.Options.Dropdown_Dungeon_SelectMap.Value
          or "Bandits Den")

        v125 = tostring(v1.Options.Dropdown_Dungeon_SelectDifficulty
            and v1.Options.Dropdown_Dungeon_SelectDifficulty.Value
          or "Easy")
      end

      local displayName = v124

      pcall(function()
        local v128 = require(replicatedStorage.GameInfo.DungeonData).GetDungeon(v124)

        if v128 and v128.DisplayName then
          displayName = v128.DisplayName
        end
      end)

      v123 = string.format(
        "Starting %s (%s) in %ds. Disable toggle to cancel.", displayName, v125,
        sliderDungeonStartDelay
      )
    elseif p6 == "Challenge" then
      sliderDungeonStartDelay = v1.Options.Slider_Challenge_StartDelay
          and tonumber(v1.Options.Slider_Challenge_StartDelay.Value)
        or 10

      v124 = f6()
      title = "Auto Start Solo Challenge"

      v123 = string.format(
        "Starting Challenge (%s) in %ds. Disable toggle to cancel.", v124,
        sliderDungeonStartDelay
      )
    elseif p6 == "BossRush" then
      sliderDungeonStartDelay = v1.Options.Slider_BossRush_StartDelay
          and tonumber(v1.Options.Slider_BossRush_StartDelay.Value)
        or 10

      v126 = tostring(v1.Options.Dropdown_BossRush_SelectBoss
          and v1.Options.Dropdown_BossRush_SelectBoss.Value
        or "Cursed King")

      v127 = tonumber(tostring(v1.Options.Dropdown_BossRush_SelectSkipFloor
            and v1.Options.Dropdown_BossRush_SelectSkipFloor.Value
          or "None (Floor 0)"):match("%d+"))
        or 0

      title = "Auto Enter Boss Rush"

      v123 = string.format(
        "Entering Boss Rush (Boss: %s, Skip: %d) in %ds. Disable toggle to cancel.", v126, v127,
        sliderDungeonStartDelay
      )
    end

    v1:Notify({ Title = title, Content = v123, Duration = sliderDungeonStartDelay })
    local v129 = sliderDungeonStartDelay

    while v129 > 0 do
      local value42 = v1.Options[v122] and v1.Options[v122].Value

      if v1.Unloaded or not value42 or v7.StartSessionId ~= startSessionId then
        print(string.format("[AutoStart] %s countdown cancelled.", p6))
        v7.IsStarting = false
        return
      end

      print(string.format("[AutoStart] %s countdown: %ds...", p6, v129))
      task.wait(1)
      v129 = v129 - 1
    end

    local value43 = v1.Options[v122] and v1.Options[v122].Value

    if v1.Unloaded or not value43 or v7.StartSessionId ~= startSessionId then
      print(string.format("[AutoStart] %s start aborted.", p6))
      v7.IsStarting = false
      return
    end

    if p6 == "Dungeon" then
      print(string.format("[AutoStart] Starting solo run for dungeon: %s (%s)", v124, v125))

      pcall(function()
        dungeonQueueService:RequestSelectMode("Dungeon"):await()
        task.wait(0.1)
        dungeonQueueService:RequestSelectDungeon(v124):await()
        task.wait(0.1)
        dungeonQueueService:RequestSelectDifficulty(v125):await()
        local v130, v131, v132 = dungeonQueueService:RequestStartSoloRun():await()

        print(string.format(
          "[AutoStart] RPC Result: success=%s, started=%s, reason=%s", tostring(v130),
          tostring(v131), tostring(v132)
        ))

        if not v131 then
          v1:Notify({
            Title = "Auto Start Failed",
            Content = tostring(v132 or "Unknown reason"),
            Duration = 6,
          })
        end
      end)
    elseif p6 == "Challenge" then
      print(string.format("[AutoStart] Starting Challenge solo run: %s", v124))

      pcall(function()
        dungeonQueueService:RequestSelectMode("Challenge"):await()
        task.wait(0.1)
        dungeonQueueService:RequestSelectDungeon(v124):await()
        task.wait(0.1)
        local v133, v134, v135 = dungeonQueueService:RequestStartSoloRun():await()

        if not v134 then
          v1:Notify({
            Title = "Auto Start Failed",
            Content = tostring(v135 or "Unknown reason"),
            Duration = 6,
          })
        end
      end)
    elseif p6 == "BossRush" then
      print(string.format("[AutoStart] Entering Boss Rush: Boss=%s, SkipFloor=%d", v126, v127))

      pcall(function()
        dungeonQueueService:RequestSelectMode("BossRush"):await()
        task.wait(0.1)
        dungeonQueueService:RequestSelectFinalBoss(v126):await()
        task.wait(0.1)

        if v127 > 0 then
          dungeonQueueService:RequestSelectSkipFloor(v127):await()
          task.wait(0.1)
        end

        local v136, v137, v138 = dungeonQueueService:RequestEnter():await()

        if not v136 or type(v137) == "boolean" and not v137 then
          v1:Notify({
            Title = "Auto Enter Failed",
            Content = tostring(v138 or v137 or "Unknown reason"),
            Duration = 6,
          })
        end
      end)
    end

    v7.IsStarting = false
  end)
end

local function f40()
  task.spawn(function()
    while not v1.Unloaded do
      if not (v1.Options.Toggle_Challenge_AutoClaimRewards
        and v1.Options.Toggle_Challenge_AutoClaimRewards.Value) then
        break
      end

      pcall(function()
        local v139, v140 = challengeRewardService:GetProgress():await()

        if v139 and type(v140) == "table" then
          local highestFloor = v140.HighestFloor or 0
          local claimedRewards = v140.ClaimedRewards or {}
          local v141 = {}

          for index14, value44 in ipairs(claimedRewards) do
            v141[value44] = true
          end

          local v142 = require(replicatedStorage.GameInfo.ChallengeRewardData)

          for index15, value45 in ipairs(v142 and v142.MILESTONES or {}) do
            local floor = value45.Floor

            if floor and floor <= highestFloor and not v141[floor] then
              pcall(function() challengeRewardService:ClaimReward(floor):await() end)
              task.wait(0.3)
            end
          end
        end
      end)

      task.wait(5)
    end
  end)
end

local function f41()
  task.spawn(function()
    while not v1.Unloaded do
      if not (v1.Options.Toggle_BossRush_AutoClaimRewards
        and v1.Options.Toggle_BossRush_AutoClaimRewards.Value) then
        break
      end

      pcall(function()
        local v143, v144 = bossRushService:GetProgress():await()

        if v143 and type(v144) == "table" then
          local highestFloor2 = v144.HighestFloor or 0
          local claimedRewards2 = v144.ClaimedRewards or {}
          local v145 = {}

          for index16, value46 in ipairs(claimedRewards2) do
            v145[value46] = true
          end

          local v146 = require(replicatedStorage.GameInfo.BossRushData)

          for index17, value47 in ipairs(v146 and v146.MILESTONES or {}) do
            local floor2 = value47.Floor

            if floor2 and floor2 <= highestFloor2 and not v145[floor2] then
              pcall(function() bossRushService:ClaimMilestoneReward(floor2):await() end)
              task.wait(0.3)
            end
          end
        end
      end)

      task.wait(5)
    end
  end)
end

local function f42(p7)
  local character = localPlayer.Character

  if not character then
    return
  end

  local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart then
    return
  end

  humanoidRootPart.CFrame = CFrame.new(p7 + Vector3.new(0, 3, 0))
end

local function f43(p8)
  if p8.Finder then
    local v147, v148 = pcall(p8.Finder)

    if v147 and v148 then
      if v148:IsA("Model") then
        return v148:GetPivot().Position
      elseif v148:IsA("BasePart") then
        return v148.Position
      end
    end
  end

  return p8.Fallback
end

local window = v1:CreateWindow({ Title = "[Lobby] Dungeon Lootr", SubTitle = "by Lamduck" })

local v149 = {
  Dungeon = window:AddTab({ Title = "Dungeon", Icon = "swords" }),
  Class = window:AddTab({ Title = "Class", Icon = "shield" }),
  Character = window:AddTab({ Title = "Character", Icon = "user" }),
  Shop = window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
  Quest = window:AddTab({ Title = "Quest & Battlepass", Icon = "scroll" }),
  Teleport = window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local addSubTabBar = v149.Dungeon:AddSubTabBar({
  SubTabs = { "Standard", "Challenge / Endless", "Boss Rush" },
  Default = "Standard",
})

local standard = addSubTabBar.Standard
local challengeEndless = addSubTabBar["Challenge / Endless"]
local bossRush = addSubTabBar["Boss Rush"]

standard:AddSection("Standard Dungeon")

standard:AddParagraph("Paragraph_Dungeon_Notice", {
  Title = "Notice",
  Content = "Selected map or difficulty must be unlocked on your character. If locked, the start request will fail.",
})

standard:AddDropdown("Dropdown_Dungeon_SelectMap", { Title = "Select Dungeon", Values = f1() })

standard:AddDropdown("Dropdown_Dungeon_SelectDifficulty", {
  Title = "Select Difficulty",
  Values = f2(),
})

standard:AddSlider("Slider_Dungeon_StartDelay", {
  Title = "Start Delay (s)",
  Default = 20,
  Min = 10,
  Max = 30,
  Rounding = 0,
})

standard:AddToggle("Toggle_Dungeon_AutoStart", {
  Title = "Auto Start Solo",
  Default = false,
  Callback = function(value48)
    if value48 then
      f39("Dungeon")
    end
  end,
})

standard:AddDivider()

standard:AddToggle("Toggle_Dungeon_AutoBestDungeon", {
  Title = "Auto Start Best Dungeon",
  Default = false,
  Callback = function(value49)
    if value49 then
      f39("Dungeon")
    end
  end,
})

challengeEndless:AddSection("Challenge / Endless")

challengeEndless:AddSlider("Slider_Challenge_StartDelay", {
  Title = "Start Delay (s)",
  Default = 20,
  Min = 10,
  Max = 30,
  Rounding = 0,
})

challengeEndless:AddToggle("Toggle_Challenge_AutoStart", {
  Title = "Auto Start Solo Challenge",
  Default = false,
  Callback = function(value50)
    if value50 then
      f39("Challenge")
    end
  end,
})

challengeEndless:AddDivider()

challengeEndless:AddToggle("Toggle_Challenge_AutoClaimRewards", {
  Title = "Auto Claim Challenge Rewards",
  Default = false,
  Callback = function(value51)
    if value51 then
      f40()
    end
  end,
})

bossRush:AddSection("Boss Rush")

bossRush:AddDropdown("Dropdown_BossRush_SelectBoss", {
  Title = "Select Final Boss",
  Values = f4(),
  Default = "Cursed King",
})

bossRush:AddDropdown("Dropdown_BossRush_SelectSkipFloor", {
  Title = "Select Skip Floor",
  Values = f5(),
  Default = "None (Floor 0)",
})

bossRush:AddSlider("Slider_BossRush_StartDelay", {
  Title = "Start Delay (s)",
  Default = 20,
  Min = 10,
  Max = 30,
  Rounding = 0,
})

bossRush:AddToggle("Toggle_BossRush_AutoStart", {
  Title = "Auto Enter Boss Rush",
  Default = false,
  Callback = function(value52)
    if value52 then
      f39("BossRush")
    end
  end,
})

bossRush:AddDivider()

bossRush:AddToggle("Toggle_BossRush_AutoClaimRewards", {
  Title = "Auto Claim Boss Rush Rewards",
  Default = false,
  Callback = function(value53)
    if value53 then
      f41()
    end
  end,
})

v149.Class:AddSection("Class Slots")

v8.ClassSlotInfo = v149.Class:AddParagraph("Paragraph_Class_SlotInfo", {
  Title = "Slots Information",
  Content = "Loading...",
})

v149.Class:AddDropdown("Dropdown_Class_SelectSlot", { Title = "Select Slot", Values = {} })
v149.Class:AddButton({ Title = "Refresh Slot Info", Callback = function() f31() end })

v149.Class:AddButton({
  Title = "Switch Slot",
  Description = "Switch active class to selected slot",
  Callback = function()
    local value54 = v1.Options.Dropdown_Class_SelectSlot
      and v1.Options.Dropdown_Class_SelectSlot.Value

    local v150 = value54 and tonumber(value54:match("%d+"))

    if v150 then
      f33(v150)
    end
  end,
})

v149.Class:AddButton({
  Title = "Toggle Lock Slot",
  Description = "Toggle lock or unlock for selected slot",
  Callback = function()
    local value55 = v1.Options.Dropdown_Class_SelectSlot
      and v1.Options.Dropdown_Class_SelectSlot.Value

    local v151 = value55 and tonumber(value55:match("%d+"))

    if v151 then
      f34(v151)
    end
  end,
})

v149.Class:AddToggle("Toggle_Class_AutoPurchaseSlot", {
  Title = "Auto Purchase Slot (Coins)",
  Default = false,
  Callback = function(value56)
    if value56 then
      f35()
    end
  end,
})

v149.Class:AddSection("Auto Roll Class")

v149.Class:AddParagraph("Paragraph_Class_RollNotice", {
  Title = "Important Notice",
  Content = [[
Auto roll will only target the slot selected in <font color="#40C4FF"><b>Select Slot</b></font>.
Please make sure you select the correct slot, and <font color="#FF5252"><b>Lock</b></font> any slots containing classes you do not want to overwrite.]],
})

v149.Class:AddToggle("Toggle_Class_UseLuckySpin", {
  Title = "Use Lucky Spin If Available",
  Description = "Prioritize using lucky spin if available, otherwise use normal spin",
  Default = false,
})

v149.Class:AddToggle("Toggle_Class_KeepHigherRarity", {
  Title = "Keep If Rarity >= Target",
  Description = "Keeps the class if rolled rarity is equal or higher than target (Auto Roll Rarity only)",
  Default = true,
})

v149.Class:AddToggle("Toggle_Class_AutoLockOnTarget", {
  Title = "Auto Lock Slot When Found",
  Description = "Automatically locks the slot upon rolling the target class or matching rarity",
  Default = true,
})

v149.Class:AddDivider()

v149.Class:AddDropdown("Dropdown_Class_RollTargetClass", {
  Title = "Target Class",
  Values = f7(),
  Searchable = true,
})

v149.Class:AddToggle("Toggle_Class_AutoRollTargetClass", {
  Title = "Auto Roll Target Class",
  Default = false,
  Callback = function(value57)
    if value57 then
      if v1.Options.Toggle_Class_AutoRollTargetRarity
        and v1.Options.Toggle_Class_AutoRollTargetRarity.Value then
        v1.Options.Toggle_Class_AutoRollTargetRarity:SetValue(false)
      end

      f36()
    end
  end,
})

v149.Class:AddDivider()

v149.Class:AddDropdown("Dropdown_Class_RollTargetRarity", {
  Title = "Target Rarity",
  Values = f8(),
})

v149.Class:AddToggle("Toggle_Class_AutoRollTargetRarity", {
  Title = "Auto Roll Target Rarity",
  Default = false,
  Callback = function(value58)
    if value58 then
      if v1.Options.Toggle_Class_AutoRollTargetClass
        and v1.Options.Toggle_Class_AutoRollTargetClass.Value then
        v1.Options.Toggle_Class_AutoRollTargetClass:SetValue(false)
      end

      f36()
    end
  end,
})

local addSubTabBar2 = v149.Character:AddSubTabBar({
  SubTabs = { "Equipment & Stats", "Inventory", "Potions" },
  Default = "Equipment & Stats",
})

local equipmentStats = addSubTabBar2["Equipment & Stats"]
local inventory = addSubTabBar2.Inventory
local potions2 = addSubTabBar2.Potions

equipmentStats:AddSection("Equipment & Stats")

equipmentStats:AddToggle("Toggle_Character_AutoEquipBest", {
  Title = "Auto Equip Best Equipment",
  Default = false,
  Callback = function(value59)
    if value59 then
      f14()
    end
  end,
})

equipmentStats:AddToggle("Toggle_Character_AutoUpgradeStats", {
  Title = "Auto Upgrade Stats",
  Default = false,
  Callback = function(value60)
    if value60 then
      f15()
    end
  end,
})

equipmentStats:AddButton({
  Title = "Reset Skill Points",
  Description = "Refunds all allocated skill points",
  Confirm = [[
Reset all allocated Skill Points?
Every point will be refunded.]],
  Callback = function()
    pcall(function()
      local statController2 = v5.GetController("StatController")
      local v152, v153

      if statController2 then
        v152, v153 = statController2:Respec()
      else
        v152, v153 = statService:Respec():await()
      end

      if v152 then
        v1:Notify({
          Title = "Skill Points",
          Content = "Skill points reset successfully.",
          Duration = 3,
        })
      else
        local content = "Could not reset points."

        if v153 == "NotEnoughGold" then
          content = "Not enough Coins to reset."
        elseif v153 == "NothingToRespec" then
          content = "No points to reset."
        end

        v1:Notify({ Title = "Reset Failed", Content = content, Duration = 4 })
      end
    end)
  end,
})

inventory:AddSection("Auto Lock")

inventory:AddDropdown("Dropdown_Character_LockRarities", {
  Title = "Select Rarities to Lock",
  Values = f3(),
  Multi = true,
  Default = {},
})

inventory:AddToggle("Toggle_Character_AutoLock", {
  Title = "Auto Lock Items",
  Default = false,
  Callback = function(value61)
    if value61 then
      f16()
    end
  end,
})

inventory:AddDivider()

inventory:AddDropdown("Dropdown_Character_UnlockRarities", {
  Title = "Select Rarities to Unlock",
  Values = f3(),
  Multi = true,
  Default = {},
})

inventory:AddButton({
  Title = "Unlock Equipment",
  Description = "Unlocks all locked equipment of selected rarities",
  Confirm = "Unlock all equipment of selected rarities?",
  Callback = function()
    f29(v1.Options.Dropdown_Character_UnlockRarities
        and v1.Options.Dropdown_Character_UnlockRarities.Value
      or {})
  end,
})

inventory:AddSection("Auto Storage")

inventory:AddDropdown("Dropdown_Character_StorageRarities", {
  Title = "Select Rarities to Store",
  Values = f3(),
  Multi = true,
  Default = {},
})

inventory:AddToggle("Toggle_Character_AutoStorage", {
  Title = "Auto Store Items",
  Default = false,
  Callback = function(value62)
    if value62 then
      f30()
    end
  end,
})

inventory:AddDivider()

inventory:AddButton({
  Title = "Store All Equipment",
  Description = "Deposits all inventory equipment into storage",
  Confirm = "Deposit all inventory equipment into storage?",
  Callback = function()
    task.spawn(function()
      pcall(function()
        local v154 = f12()
        local equipmentInventory6 = v154 and v154.Data and v154.Data.EquipmentInventory

        if equipmentInventory6 then
          local v155 = {}

          for key15, value63 in pairs(equipmentInventory6) do
            if type(value63) == "table" and value63.GUID then
              table.insert(v155, value63.GUID)
            end
          end

          if #v155 > 0 then
            local v156, v157 = bankService:DepositEquipmentBatch(v155):await()

            if v156 and v157 then
              v1:Notify({
                Title = "Storage",
                Content = string.format("Deposited %d item(s) to storage.", #v155),
                Duration = 3,
              })
            else
              v1:Notify({
                Title = "Storage Failed",
                Content = "Could not deposit items (bank may be full).",
                Duration = 4,
              })
            end
          else
            v1:Notify({
              Title = "Storage",
              Content = "No eligible items to deposit.",
              Duration = 3,
            })
          end
        end
      end)
    end)
  end,
})

inventory:AddButton({
  Title = "Withdraw All Equipment",
  Description = "Withdraws all equipment from storage into inventory",
  Confirm = "Withdraw all equipment from storage into inventory?",
  Callback = function()
    task.spawn(function()
      pcall(function()
        local v158 = f12()
        local bankEquipment = v158 and v158.Data and v158.Data.BankEquipment

        if bankEquipment then
          local v159 = {}

          for key16, value64 in pairs(bankEquipment) do
            if type(value64) == "table" and value64.GUID then
              table.insert(v159, value64.GUID)
            end
          end

          if #v159 > 0 then
            local v160, v161 = bankService:WithdrawEquipmentBatch(v159):await()

            if v160 and v161 then
              v1:Notify({
                Title = "Storage",
                Content = string.format("Withdrew %d item(s) from storage.", #v159),
                Duration = 3,
              })
            else
              v1:Notify({
                Title = "Withdraw Failed",
                Content = "Could not withdraw items (inventory may be full).",
                Duration = 4,
              })
            end
          else
            v1:Notify({
              Title = "Storage",
              Content = "No items in storage to withdraw.",
              Duration = 3,
            })
          end
        end
      end)
    end)
  end,
})

inventory:AddSection("Auto Delete")

inventory:AddParagraph("Paragraph_Character_DeleteWarning", {
  Title = "Warning",
  Content = "<font color=\"#FF4D4D\"><b>WARNING:</b></font> Deleting items gives <b>NO</b> coins. We highly recommend using <b>Auto Sell</b> in the Shop tab instead!",
})

inventory:AddDropdown("Dropdown_Character_DeleteRarities", {
  Title = "Select Rarities to Delete",
  Values = f3(),
  Multi = true,
  Default = {},
})

inventory:AddToggle("Toggle_Character_AutoDelete", {
  Title = "Auto Delete Items",
  Default = false,
  Confirm = [[
Are you sure you want to enable Auto Delete?
Selected rarities will be PERMANENTLY deleted for NO coins.]],
  Callback = function(value65)
    if value65 then
      f17()
    end
  end,
})

potions2:AddSection("Buff Potions")

potions2:AddDropdown("Dropdown_Character_SelectBuffPotions", {
  Title = "Select Buff Potions",
  Values = f9(),
  Multi = true,
  Default = {},
  Searchable = true,
})

potions2:AddToggle("Toggle_Character_AutoUseBuffPotions", {
  Title = "Auto Use Buff Potions",
  Default = false,
  Callback = function(value66)
    if value66 then
      f18()
    end
  end,
})

potions2:AddSection("Instant Use Potions (Lobby)")

potions2:AddDropdown("Dropdown_Character_SelectInstantPotions", {
  Title = "Select Instant Potions",
  Values = f10(),
  Multi = true,
  Default = {},
  Searchable = true,
})

potions2:AddToggle("Toggle_Character_AutoConsumeInstantPotions", {
  Title = "Auto Consume Instant Potions",
  Default = false,
  Callback = function(value67)
    if value67 then
      f19()
    end
  end,
})

potions2:AddDivider()

potions2:AddButton({
  Title = "Consume All Instant Potions",
  Description = "Consumes all selected (or all owned) instant potions in your inventory",
  Confirm = "Consume all instant potions in inventory?",
  Callback = function()
    task.spawn(function()
      local value68 = v1.Options.Dropdown_Character_SelectInstantPotions
        and v1.Options.Dropdown_Character_SelectInstantPotions.Value

      local v162 = false

      if type(value68) == "table" then
        for key17, value69 in pairs(value68) do
          if value69 == true then
            v162 = true
            break
          end
        end
      end

      local v163 = f12()
      local potions3 = v163 and v163.Data and v163.Data.Potions

      if not potions3 or type(potions3) ~= "table" then
        v1:Notify({
          Title = "Instant Potions",
          Content = "No potions found in inventory.",
          Duration = 3,
        })

        return
      end

      local instantUsePotionMapping2 = v9.InstantUsePotionMapping or {}
      local v164 = {}

      if v162 then
        for key18, value70 in pairs(value68) do
          if value70 == true then
            local v165 = instantUsePotionMapping2[key18] or key18
            local v166 = potions3[v165] or 0

            if v166 > 0 then
              table.insert(v164, { Id = v165, Name = key18, Count = v166 })
            end
          end
        end
      else
        for index18, value71 in ipairs((f10())) do
          local v167 = instantUsePotionMapping2[value71] or value71
          local v168 = potions3[v167] or 0

          if v168 > 0 then
            table.insert(v164, { Id = v167, Name = value71, Count = v168 })
          end
        end
      end

      if #v164 == 0 then
        v1:Notify({
          Title = "Instant Potions",
          Content = "No matching instant potions available to consume.",
          Duration = 3,
        })

        return
      end

      local count2 = 0

      for index19, value72 in ipairs(v164) do
        for i8 = 1, value72.Count do
          if v1.Unloaded then
            break
          end

          local v169, v170 = potionService:ConsumePotion(value72.Id):await()

          if v169 and v170 then
            count2 = count2 + 1
          else
            break
          end

          task.wait(0.05)
        end
      end

      v1:Notify({
        Title = "Instant Potions",
        Content = string.format("Consumed %d instant potion(s).", count2),
        Duration = 3,
      })
    end)
  end,
})

v149.Shop:AddSection("Inventory Expansion")

v149.Shop:AddToggle("Toggle_Shop_AutoExpandInventory", {
  Title = "Auto Expand Inventory",
  Default = false,
  Callback = function(value73)
    if value73 then
      f20()
    end
  end,
})

v149.Shop:AddSection("Auto Sell")

v149.Shop:AddDropdown("Dropdown_Shop_SellRarities", {
  Title = "Select Rarities to Sell",
  Values = f3(),
  Multi = true,
  Default = {},
})

v149.Shop:AddToggle("Toggle_Shop_AutoSell", {
  Title = "Auto Sell Items",
  Default = false,
  Callback = function(value74)
    if value74 then
      f21()
    end
  end,
})

local addSubTabBar3 = v149.Quest:AddSubTabBar({
  SubTabs = { "Quest & Battlepass", "Reward" },
  Default = "Quest & Battlepass",
})

local questBattlepass = addSubTabBar3["Quest & Battlepass"]
local reward = addSubTabBar3.Reward

questBattlepass:AddParagraph("Paragraph_Quest_Notice", {
  Title = "Notice",
  Content = "<font color=\"#FFA500\"><b>Warning:</b></font> This feature only <b>claims completed rewards</b>. It does <b>NOT</b> auto-complete or do quests for you.",
})

questBattlepass:AddSection("Quests")

questBattlepass:AddToggle("Toggle_Quest_AutoClaimQuests", {
  Title = "Auto Claim Quests",
  Description = "Automatically claims completed Daily, Weekly, and Limited quest rewards.",
  Default = false,
  Callback = function(value75)
    if value75 then
      f22()
    end
  end,
})

questBattlepass:AddSection("Battlepass")

questBattlepass:AddToggle("Toggle_Quest_AutoClaimBattlepassTiers", {
  Title = "Auto Claim Battlepass Tiers",
  Description = "Automatically claims all reached Free and Premium Battlepass tier rewards.",
  Default = false,
  Callback = function(value76)
    if value76 then
      f23()
    end
  end,
})

questBattlepass:AddToggle("Toggle_Quest_AutoClaimBattlepassQuests", {
  Title = "Auto Claim Battlepass Quests",
  Description = "Automatically claims completed Battlepass quest XP rewards.",
  Default = false,
  Callback = function(value77)
    if value77 then
      f24()
    end
  end,
})

reward:AddSection("Daily Free Chests")

reward:AddToggle("Toggle_Reward_AutoClaimFreeChests", {
  Title = "Auto Claim Free Chests",
  Description = "Automatically checks and claims daily free chests whenever off cooldown",
  Default = false,
  Callback = function(value78)
    if value78 then
      f25()
    end
  end,
})

reward:AddSection("Inventory Packs & Chests")

reward:AddToggle("Toggle_Reward_AutoOpenPacks", {
  Title = "Auto Open Inventory Packs",
  Description = "Automatically opens any new packs or chests appearing in your inventory",
  Default = false,
  Callback = function(value79)
    if value79 then
      f26()
    end
  end,
})

reward:AddSection("Achievements & Index")

reward:AddToggle("Toggle_Reward_AutoClaimAchievements", {
  Title = "Auto Claim Achievements",
  Description = "Automatically claims achievements whenever they are completed",
  Default = false,
  Callback = function(value80)
    if value80 then
      f27()
    end
  end,
})

reward:AddToggle("Toggle_Reward_AutoClaimIndex", {
  Title = "Auto Claim Item Index",
  Description = "Automatically claims available gem rewards from Item Index",
  Default = false,
  Callback = function(value81)
    if value81 then
      f28()
    end
  end,
})

reward:AddSection("Giftcodes")

reward:AddButton({
  Title = "Redeem All Giftcodes",
  Callback = function()
    task.spawn(function()
      v1:Notify({ Title = "Giftcodes", Content = "Submitting all giftcodes...", Duration = 3 })
      local v171 = f12()
      local redeemedCodes = v171 and v171.Data and v171.Data.RedeemedCodes or {}

      for index20, value82 in ipairs(v6) do
        if not table.find(redeemedCodes, value82) then
          task.spawn(function()
            pcall(function() codesService:RedeemCode(value82):await() end)
          end)

          task.wait(0.3)
        end
      end

      v1:Notify({
        Title = "Giftcodes",
        Content = "All giftcodes have been submitted.",
        Duration = 4,
      })
    end)
  end,
})

local addSubTabBar4 = v149.Teleport:AddSubTabBar({
  SubTabs = { "Lobby", "Dungeons", "NPCs", "Custom" },
  Default = "Lobby",
})

local lobby = addSubTabBar4.Lobby
local dungeons = addSubTabBar4.Dungeons
local npCs = addSubTabBar4.NPCs
local custom = addSubTabBar4.Custom

local function f44(p9, p10)
  for index21, value83 in ipairs(p10) do
    p9:AddSection(value83.Section)

    for index22, value84 in ipairs(value83.Items) do
      p9:AddButton({
        Title = value84.Title,
        Description = value84.Description,
        Callback = function()
          local v172 = f43(value84)

          if v172 then
            f42(v172)
          end
        end,
      })
    end
  end
end

f44(lobby, v11.Lobby)
f44(dungeons, v11.Dungeons)
f44(npCs, v11.NPCs)

custom:AddSection("Custom Waypoint")

custom:AddInput("Input_CustomWaypoint", {
  Title = "Saved Position",
  Default = "",
  Placeholder = "X, Y, Z",
  Numeric = false,
  Finished = false,
})

custom:AddButton({
  Title = "Save Current Position",
  Description = "Saves current character coordinates",
  Callback = function()
    local character2 = localPlayer.Character
    local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart2 then
      local position = humanoidRootPart2.Position
      local v173 = string.format("%.1f, %.1f, %.1f", position.X, position.Y, position.Z)

      if v1.Options.Input_CustomWaypoint then
        v1.Options.Input_CustomWaypoint:SetValue(v173)
      end

      v1:Notify({ Title = "Position Saved", Content = v173, Duration = 3 })
    else
      v1:Notify({ Title = "Save Position Failed", Content = "Character not found", Duration = 3 })
    end
  end,
})

custom:AddButton({
  Title = "Teleport to Position",
  Description = "Teleports character to the saved coordinates",
  Callback = function()
    local value85 = v1.Options.Input_CustomWaypoint and v1.Options.Input_CustomWaypoint.Value

    if not value85 or value85 == "" then
      v1:Notify({ Title = "Teleport Failed", Content = "No coordinates saved", Duration = 3 })
      return
    end

    local v174, v175, v176 = value85:match("([^,]+),%s*([^,]+),%s*([^,]+)")
    local v177, v178, v179 = tonumber(v174), tonumber(v175), tonumber(v176)

    if v177 and v178 and v179 then
      f42(Vector3.new(v177, v178, v179))

      v1:Notify({
        Title = "Teleported",
        Content = string.format("Teleported to %.1f, %.1f, %.1f", v177, v178, v179),
        Duration = 3,
      })
    else
      v1:Notify({
        Title = "Teleport Failed",
        Content = "Invalid coordinates format",
        Duration = 3,
      })
    end
  end,
})

task.spawn(function()
  f31()
  f32()
end)

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/DungeonLootr_Lobby")
v4:SetFolder("Lamduck/DungeonLootr_Lobby")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v149.Settings)
v3:BuildInterfaceSection(v149.Settings)
v2:BuildConfigSection(v149.Settings)

v1.OnUnload:Once(function()
  for key19, value86 in pairs(v10) do
    if typeof(value86) == "RBXScriptConnection" and value86.Connected then
      value86:Disconnect()
    end
  end

  table.clear(v10)
end)

v2:LoadAutoloadConfig()
window:SelectTab(1)
