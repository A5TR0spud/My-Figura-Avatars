vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

local oldTarget
local target
local rotVel = 0
local rot = 0
local oldRot = 0
local time = 0

function events.entity_init()
  models.model.HandLantern:setParentType("WORLD")
  target = user:getPos() * 16
  oldTarget = user:getPos() * 16
  rotVel = 0
end

local function rotateVec3ByYaw(vector, theta)
  local cos = math.cos(theta)
  local sin = math.sin(theta)
  return vectors:vec3(vector.x * cos - vector.z * sin, vector.y, vector.x * sin + vector.z * cos)
end

function events.tick()
  local theta = 0.0174532925199 * (180 - player:getRot(delta).y)
  local scale = user:getBoundingBox().x / 0.6
  oldTarget = target
  target = user:getPos() * 16 + rotateVec3ByYaw(vectors:vec3(user:getBoundingBox().x / 0.6 * -9, (12 + math.sin(0.1 * time)) * user:getBoundingBox().y, user:getBoundingBox().z / 0.6 * 5), -theta)
  target = (target * 0.25 + oldTarget * 0.75)
  models.model.HandLantern:setScale(scale)
  
  oldRot = rot
  local distXY = vectors.vec2(target.x - oldTarget.x, target.z - oldTarget.z):length() / scale
  local distY = (target.y - oldTarget.y) / scale
  rotVel = rotVel + -1.33 * distXY
  rotVel = rotVel + -rot * 0.16
  if distY > 0 then
    rotVel = rotVel - rot * 0.2 * math.abs(distY)
    rotVel = rotVel * 0.9
  end
  if distY < 0 then
    rotVel = rotVel + rot * 0.16 * math.abs(distY)
  end
  rotVel = rotVel * 0.9
  rot = math.min(math.max(rot + rotVel, -90), 90)
  if rot > 89 or rot < -89 then
    rotVel = -0.1 * rot
  end
  time = time + 1
end

function events.render(delta, context)
  models.model.HandLantern:setPos(delta * target + (1 - delta) * oldTarget)
  models.model.HandLantern:setRot(0, 180 - player:getRot(delta).y, 0)
  models.model.HandLantern.Handle:setRot(0.2 * (delta * rot + (1 - delta) * oldRot), 0, 0)
  models.model.HandLantern.Handle.Lantern:setRot(delta * rot + (1 - delta) * oldRot, 0, 0)
end
