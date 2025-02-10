vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)
models.model.root:setSecondaryRenderType("EYES")

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()
  --player functions goes here
end

--tick event, called 20 times per second
local particleCounter = 0
local position
local volume
local boundingBox
local offset
function events.tick()
  if (not user:isOnGround()) then
    position = user:getPos()
    boundingBox = user:getBoundingBox()
    volume = boundingBox.x^2 * boundingBox.y
    offset = vectors.vec3(math.random() * boundingBox.x, math.random() * boundingBox.y, math.random() * boundingBox.z) - vectors.vec3(boundingBox.x/2, 0, boundingBox.z/2)
    while (particleCounter > 0) do
      particles:newParticle("minecraft:electric_spark", position + offset, 0, (math.random(0,2) * 2 - 1), 0)
      particleCounter = particleCounter - 1
    end
    particleCounter=particleCounter+volume
  end
end

--render event, called every time your avatar is rendered
--it have two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
  --code goes here
end
