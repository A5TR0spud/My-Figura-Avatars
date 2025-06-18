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
    local percentText = math.floor(value[2] / SAMPLE_SIZE * 1000) / 10 .. "%"
    models.model.HUD:newBlock("b1_".. index)
      :setPos(-18, -0.22 * client.getWindowSize().y - 8 - index * 16, 0)
      :setBlock(value[1])
      :setScale(1)
      :setVisible(true)
    models.model.HUD:newText("t1_".. index)
      :setPos(-22, -0.22 * client.getWindowSize().y + 5 - index * 16, 0)
      :setText(client.getTranslatedString("block.".. string.gsub(value[1], ":", ".")).. ": ")
      :setWidth(150)
      :setWrap(false)
      :setBackground(true)
      :setScale(1)
      :setVisible(true)
    models.model.HUD:newText("t2_".. index)
      :setPos(-180, -0.22 * client.getWindowSize().y + 5 - index * 16, 0)
      :setText(percentText)
      :setScale(1)
      :setBackground(true)
      :setAlignment("RIGHT")
      :setVisible(true)
  end

  
end)

end