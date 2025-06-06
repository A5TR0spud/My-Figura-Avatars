vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
local antenna_on = true
local c_a_ticks = 0
local has_sent_death_receipt = false
local u = 0
local v = 0


function events.tick()
  if not has_sent_death_receipt and player:getHealth() <= 0 then
    has_sent_death_receipt = true
    print("\n",
      "***************************************************************************\n",
      "[AUTOMATED DECOMMISSION RECEIPT]\n",
      player:getName(), "was decommissioned on day", world:getDay(), "at time", world:getDayTime(), "\n",
      "Coordinates:", math.floor(player:getPos().x), math.floor(player:getPos().y), math.floor(player:getPos().z), "\n",
      "Equipment:", player:getItem(1):getName(), player:getItem(2):getName(), player:getItem(6):getName(), player:getItem(5):getName(), player:getItem(4):getName(), player:getItem(3):getName(), "\n",
      "\n ***************************************************************************"
    )
  end
  if player:getHealth() > 0 then
    has_sent_death_receipt = false
  else
    do return end
  end

  c_a_ticks = c_a_ticks + 1
  if (math.random() < 0.5 or c_a_ticks > 7) and c_a_ticks > 0 then
    antenna_on = not antenna_on
    c_a_ticks = 0
    models.model.root.Head.Antenna:setUVPixels(antenna_on and 0 or 1, 0)
  end

  u = (u + math.random(1, 7)) % 8
  v = (v + math.random(1, 12)) % 12

  models.model.root.Head.Screen:setUVPixels(u, v)
  models.model.root.Head.Screen:setRot(0, 0, math.random(0, 3) * 90)
end
