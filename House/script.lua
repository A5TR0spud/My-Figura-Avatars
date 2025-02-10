vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()
  --player functions goes here
end

local rollRot = vectors:vec3(0, 0, 0)
local rollDir = vectors:vec3(0, 0, 0)
local rollSpd = 90/20
local t = 0
local i = 1

function events.tick()
  if t % 20 == 0 then
    rollDir = vectors:vec3(0, 0, 0)
    rollDir[math.random(3)] = 2 * (math.random(2) - 1.5)
    t = 0
  end
  rollRot = rollRot + rollDir * rollSpd
  t = t + 1
end

function events.render(delta, context)
  if t % 20 == 0 then
    models.model.root.Head.Roller:setRot(rollRot)
  else
    models.model.root.Head.Roller:setRot(rollRot + rollDir * rollSpd * delta)
  end
end
