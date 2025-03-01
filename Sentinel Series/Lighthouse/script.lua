vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
local antenna_on = true
local c_a_ticks = 0
local has_sent_death_receipt = false

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
  if (math.random() < 0.3 or c_a_ticks > 20) and c_a_ticks > 1 then
    antenna_on = not antenna_on
    c_a_ticks = 0
    models.model.root.Head.Antenna:setUVPixels(antenna_on and 0 or 1, 0)
  end

  models.model.root.Body.Lighthouse.Light:setUVPixels(v, 0)
  local hp = player:getHealth() / player:getMaxHealth() * 0.9
  models.model.root.Head.Visor:setColor(math.random() * (1.0 - hp) + hp)
  v = (v + 0.05) % 4
end
