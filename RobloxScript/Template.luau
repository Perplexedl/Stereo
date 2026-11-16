local v1, v2, v3, v4 = loadstring(game:HttpGet("https://lamduck2005.github.io/RobloxScript/Fluent.luau"))()
local v5 = {}
local window = v1:CreateWindow({ Title = "Build A Fruit Farm", SubTitle = "by Lamduck" })

local v6 = {
  Main = window:AddTab({ Title = "Main", Icon = "sprout" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local addParagraph = v6.Main:AddParagraph("Paragraph_Example", {
  Title = "Example Status",
  Content = "Loading...",
})

v3:SetLibrary(v1)
v2:SetLibrary(v1)
v4:SetLibrary(v1)
v3:SetFolder("Lamduck")
v2:SetFolder("Lamduck/BuildAFruitFarm")
v4:SetFolder("Lamduck/BuildAFruitFarm")
v2:SetIgnoreIndexes({})
v4:BuildExtraSection(v6.Settings)
v3:BuildInterfaceSection(v6.Settings)
v2:BuildConfigSection(v6.Settings)

v1.OnUnload:Once(function()
  for index, value in ipairs(v5) do
    if typeof(value) == "RBXScriptConnection" and value.Connected then
      value:Disconnect()
    end
  end

  table.clear(v5)
end)

v2:LoadAutoloadConfig()
window:SelectTab(1)
