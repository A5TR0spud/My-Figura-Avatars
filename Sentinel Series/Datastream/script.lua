vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
local antenna_on = true
local c_a_ticks = 0
local rec_on = true
local t_r_ticks = 0
local has_sent_death_receipt = false

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
  if (math.random() < 0.45 or c_a_ticks > 12) and c_a_ticks > 1 then
    antenna_on = not antenna_on
    c_a_ticks = 0
    models.model.root.Head.Antenna:setUVPixels(antenna_on and 0 or 1, 0)
    models.model.root.Body.BigAntenna:setUVPixels(math.random(0, 1), 0)
    models.model.root.Body.BodyAntenna:setUVPixels(math.random(0, 1), 0)
  end
  if t_r_ticks % 20 == 0 then
    rec_on = not rec_on
    models.model.root.Head.RecLight:setUVPixels(rec_on and 0 or 1, 0)
  end
  t_r_ticks = t_r_ticks + 1
  
end
