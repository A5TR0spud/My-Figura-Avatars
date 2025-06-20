if host:isHost() then
events.ENTITY_INIT:register(function ()
  models.model.HUD:setParentType("GUI")
end)

local rolling_average = {}
local list = {}

local RANGE = 10
local SPEED = 3
local SAMPLE_SIZE = 180

local function compare(a,b)
  return a[2] > b[2]
end

events.TICK:register(function ()
  for i = 1, SPEED, 1 do
    table.insert(rolling_average, 1, world.getBlockState(user:getPos() + vectors:vec3(math.random(-RANGE, RANGE), math.random(-RANGE, RANGE), math.random(-RANGE, RANGE))):getID())
    if #rolling_average > SAMPLE_SIZE then
      table.remove(rolling_average)
    end
  end

  list = {}

  for index, value in ipairs(rolling_average) do
    local listIndex = -1
    for index1, value1 in ipairs(list) do
      if value1[1] == value then
        listIndex = index1
        break
      end
    end
    if listIndex > 0 then
      local num = list[listIndex][2]
      list[listIndex] = {value, num + 1}
    else
      table.insert(list, {value, 1})
    end
  end

  table.sort(list, compare)

  for key, value in pairs(models.model.HUD:getTask()) do
    value:setVisible(false)
  end
  for index, value in ipairs(list) do
    models.model.HUD:newSprite("landsurvey_s1_".. index)
      :setPos(1, -50 + 11 - index * 20, 64)
      :setTexture(textures["outline"], 22, 22)
      :setSize(22, 22)
      :setScale(1)
      :setVisible(true)
    models.model.HUD:newSprite("landsurvey_s2_".. index)
      :setPos(0, -50 + 10 - index * 20, 32)
      :setTexture(textures["back"], 20, 20)
      :setSize(20, 20)
      :setScale(1)
      :setVisible(true)
    if world.newBlock(value[1]):asItem() == nil then
      models.model.HUD:newBlock("landsurvey_b1_".. index)
        :setPos(-10, -50 - 8 - index * 20, 0)
        :setBlock(value[1])
        :setScale(0.625)
        :setRot(-39.2315, -37.7612, 26.5651)
        --:setRot(-140.7685, -37.7612, 153.4349)
        :setVisible(true)
    else
      models.model.HUD:newItem("landsurvey_b1_".. index)
        :setPos(-10, -50 - index * 20, 0)
        :setItem(world.newBlock(value[1]):asItem())
        :setDisplayMode("gui")
        --:setRot(-140.7685, -37.7612, 153.4349)
        :setVisible(true)
    end
    models.model.HUD:newText("landsurvey_t1_".. index)
      :setPos(-24, -50 + 7 - index * 20, -64)
      :setText(client.getTranslatedString("block.".. string.gsub(value[1], ":", ".")))
      :setWidth(125)
      :setWrap(false)
      :setBackground(true)
      :setScale(1)
      :setVisible(true)
    models.model.HUD:newText("landsurvey_t2_".. index)
      :setPos(-180, -50 + 7 - index * 20, -65)
      :setText(math.floor(value[2] / SAMPLE_SIZE * 100 + 0.5) .. "%")--math.floor(value[2] / SAMPLE_SIZE * 100 + 0.5))--math.floor(value[2] / SAMPLE_SIZE * 1000) / 10 .. "%")
      :setScale(1)
      :setWrap(false)
      :setBackground(true)
      :setAlignment("RIGHT")
      :setVisible(true)
  end

  
end)

end