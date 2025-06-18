if host:isHost() then

events.ENTITY_INIT:register(function ()
  models.model.HUD:setParentType("GUI")

end)

textures:fromVanilla("coal", "textures/item/coal.png")
textures:fromVanilla("raw_iron", "textures/item/raw_iron.png")
textures:fromVanilla("raw_iron", "textures/item/raw_iron.png")
textures:fromVanilla("raw_copper", "textures/item/raw_copper.png")
textures:fromVanilla("raw_gold", "textures/item/raw_gold.png")
textures:fromVanilla("redstone", "textures/item/redstone.png")
textures:fromVanilla("emerald", "textures/item/emerald.png")
textures:fromVanilla("lapis_lazuli", "textures/item/lapis_lazuli.png")
textures:fromVanilla("diamond", "textures/item/diamond.png")
textures:fromVanilla("gold_nugget", "textures/item/gold_nugget.png")
textures:fromVanilla("quartz", "textures/item/quartz.png")

local trackedBlocks = {}
local seedBlock = nil

local map = {
  {"minecraft:coal_ore", "coal"},
  {"minecraft:deepslate_coal_ore", "coal"},

  {"minecraft:iron_ore", "raw_iron"},
  {"minecraft:deepslate_iron_ore", "raw_iron"},

  {"minecraft:copper_ore", "raw_copper"},
  {"minecraft:deepslate_copper_ore", "raw_copper"},

  {"minecraft:gold_ore", "raw_gold"},
  {"minecraft:deepslate_gold_ore", "raw_gold"},

  {"minecraft:redstone_ore", "redstone"},
  {"minecraft:deepslate_redstone_ore", "redstone"},

  {"minecraft:emerald_ore", "emerald"},
  {"minecraft:deepslate_emerald_ore", "emerald"},

  {"minecraft:lapis_ore", "lapis_lazuli"},
  {"minecraft:deepslate_lapis_ore", "lapis_lazuli"},

  {"minecraft:diamond_ore", "diamond"},
  {"minecraft:deepslate_diamond_ore", "diamond"},

  {"minecraft:nether_gold_ore", "gold_nugget"},

  {"minecraft:nether_quartz_ore", "quartz"}
}

local function tryAddBlock(pos, dist)
  if dist > 16 and #trackedBlocks > 24 then do return nil end end
  if dist > 48 or #trackedBlocks > 496 then do return nil end end
  local id = world.getBlockState(pos):getID()
  for index, value in ipairs(trackedBlocks) do
    if value[2].x == pos.x and value[2].y == pos.y and value[2].z == pos.z then
      do return value end
    end
  end
  local blockStore = {id, pos, math.floor(-dist / 6), nil, nil, dist}
  if seedBlock ~= nil then
    blockStore[5] = seedBlock[2]
  end
  local blockValid = false
  for i, value in ipairs(map) do
    if id == value[1] then
      blockValid = true
      local tex = textures:get(value[2])
      blockStore[4] = models.model.HUD:newSprite("s_".. pos.x.. "_".. pos.y.. "_".. pos.z)
        :setTexture(tex, tex:getDimensions().x, tex:getDimensions().y)
        :setSize(16, 16)
        --:setRenderType("TRANSLUCENT")
      table.insert(trackedBlocks, blockStore)
      break
    end
  end
  if not blockValid then
    blockStore = nil
  end
  return blockStore
end

events.TICK:register(function ()
  local block = player:getTargetedBlock(true)
  --print(block)
  --print(#trackedBlocks)
  --print(trackedBlocks[1])
  -- blockLocation = block[2]
  seedBlock = tryAddBlock(block:getPos(), 0)

  for _index, value in ipairs(trackedBlocks) do
    if seedBlock == nil or seedBlock[2] ~= value[5] or world.getBlockState(seedBlock[2]):getID() ~= seedBlock[1] or value[1] ~= world.getBlockState(value[2]):getID() then
      value[4]:remove()
      table.remove(trackedBlocks, _index)
    elseif seedBlock ~= nil then
      value[3] = value[3] + 1
      local dist = value[6]
      if value[3] == 1 then
        tryAddBlock(value[2] + vectors:vec3(0, 0, -1), dist + 3)
        tryAddBlock(value[2] + vectors:vec3(0, 0, 1), dist + 3)
        tryAddBlock(value[2] + vectors:vec3(0, -1, 0), dist + 3)
        tryAddBlock(value[2] + vectors:vec3(0, 1, 0), dist + 3)
        tryAddBlock(value[2] + vectors:vec3(-1, 0, 0), dist + 3)
        tryAddBlock(value[2] + vectors:vec3(1, 0, 0), dist + 3)
      elseif value[3] == 2 then
        tryAddBlock(value[2] + vectors:vec3(0, -1, -1), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(0, -1, 1), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(0, 1, -1), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(0, 1, 1), dist + 4)

        tryAddBlock(value[2] + vectors:vec3(-1, -1, 0), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(-1, 1, 0), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(1, -1, 0), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(1, 1, 0), dist + 4)

        tryAddBlock(value[2] + vectors:vec3(-1, 0, -1), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(-1, 0, 1), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(1, 0, -1), dist + 4)
        tryAddBlock(value[2] + vectors:vec3(1, 0, 1), dist + 4)
      elseif value[3] == 3 then
        tryAddBlock(value[2] + vectors:vec3(-1, -1, -1), dist + 5)
        tryAddBlock(value[2] + vectors:vec3(-1, -1, 1), dist + 5)
        tryAddBlock(value[2] + vectors:vec3(-1, 1, -1), dist + 5)
        tryAddBlock(value[2] + vectors:vec3(-1, 1, 1), dist + 5)
        tryAddBlock(value[2] + vectors:vec3(1, -1, -1), dist + 5)
        tryAddBlock(value[2] + vectors:vec3(1, -1, 1), dist + 5)
        tryAddBlock(value[2] + vectors:vec3(1, 1, -1), dist + 5)
        tryAddBlock(value[2] + vectors:vec3(1, 1, 1), dist + 5)
      end
    end
  end
end)

events.POST_WORLD_RENDER:register(function (delta)
  for index, value in ipairs(trackedBlocks) do
    local p = vectors.worldToScreenSpace(value[2] + vectors:vec3(0.5, 0.5, 0.5))
    p.x = (p.x * 0.5 + 0.5) * client.getWindowSize().x * -0.5
    p.y = (p.y * 0.5 + 0.5) * client.getWindowSize().y * -0.5
    local s = 5 * p.z / p.w
    value[4]:setPos(p.x + s * 8, p.y + s * 8, p.w)
    value[4]:setVisible(p.z > 1)
    value[4]:setScale(s)
  end
end)

end