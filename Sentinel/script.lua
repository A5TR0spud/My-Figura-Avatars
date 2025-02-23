vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

--whether the antenna should be glowing
local antenna_on = true
--consecutive ticks antenna_on has not been changed
local c_a_ticks = 0



function events.tick()
  c_a_ticks = c_a_ticks + 1
  if (math.random() < 0.3 or c_a_ticks > 20) and c_a_ticks > 1 then
    antenna_on = not antenna_on
    c_a_ticks = 0
    models.model.root.Head.Antenna:setUVPixels(antenna_on and 1 or 0, 0)
  end
end
