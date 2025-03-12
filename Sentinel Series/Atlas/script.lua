vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
local has_sent_death_receipt = false

local scan_rot = vectors:vec3(0, 0, 0)

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

  local t = vanilla_model.Head:getOriginRot() - vanilla_model.Body:getOriginRot()
  scan_rot = scan_rot * 0.9 + 0.1 * vectors:vec3(0.5 * t.x, t.y, 0)
end

function events.render(delta, context)
  models.model.root.Body.Scanner:setRot(scan_rot)
  models.model.root.FaceStand:setPos(-vanilla_model.Head:getOriginPos())
  models.model.root.FaceStand:setRot(0, vanilla_model.Head:getOriginRot().y, 0)
  models.model.root.FaceStand.Face:setRot(vanilla_model.Head:getOriginRot().x, 0, 0)
  models.model.root.FaceStand.Face.Lens:setRot(0, 0, vanilla_model.Head:getOriginRot().z)
end