local vanilla_model = vanilla_model
local models = models
local events = events

vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

local blink_time = 0

local function save_part(part)
  if type(part) ~= "VanillaModelPart" then
    do return end
  end
  part:setRot(part:getOriginRot())
  part:setScale(part:getOriginScale())
  part:setPos(part:getOriginPos())
end

local function save_state()
  if player:isLoaded() then
    models.model.root:setPos(player:getPos() * 16)
    models.model.root:setOffsetRot(0, 180-player:getBodyYaw(), 0)
  end

  save_part(vanilla_model.ALL)
  save_part(vanilla_model.ARMOR)
  save_part(vanilla_model.BODY)
  save_part(vanilla_model.BOOTS)
  save_part(vanilla_model.BOOTS_LEFT_LEG)
  save_part(vanilla_model.BOOTS_RIGHT_LEG)
  save_part(vanilla_model.CAPE)
  save_part(vanilla_model.CAPE_MODEL)
  save_part(vanilla_model.CHESTPLATE)
  save_part(vanilla_model.CHESTPLATE_BODY)
  save_part(vanilla_model.CHESTPLATE_LEFT_ARM)
  save_part(vanilla_model.CHESTPLATE_RIGHT_ARM)
  save_part(vanilla_model.ELYTRA)
  save_part(vanilla_model.FAKE_CAPE)
  save_part(vanilla_model.HAT)
  save_part(vanilla_model.HEAD)
  save_part(vanilla_model.HELD_ITEMS)
  save_part(vanilla_model.HELMET)
  save_part(vanilla_model.HELMET_HAT)
  save_part(vanilla_model.HELMET_HEAD)
  save_part(vanilla_model.HELMET_ITEM)
  save_part(vanilla_model.INNER_LAYER)
  save_part(vanilla_model.JACKET)
  save_part(vanilla_model.LEFT_ARM)
  save_part(vanilla_model.LEFT_ELYTRA)
  save_part(vanilla_model.LEFT_ITEM)
  save_part(vanilla_model.LEFT_LEG)
  save_part(vanilla_model.LEFT_PANTS)
  save_part(vanilla_model.LEFT_PARROT)
  save_part(vanilla_model.LEFT_SLEEVE)
  save_part(vanilla_model.LEGGINGS)
  save_part(vanilla_model.LEGGINGS_BODY)
  save_part(vanilla_model.LEGGINGS_LEFT_LEG)
  save_part(vanilla_model.LEGGINGS_RIGHT_LEG)
  save_part(vanilla_model.OUTER_LAYER)
  save_part(vanilla_model.PARROTS)
  save_part(vanilla_model.PLAYER)
  save_part(vanilla_model.RIGHT_ARM)
  save_part(vanilla_model.RIGHT_ELYTRA)
  save_part(vanilla_model.RIGHT_ITEM)
  save_part(vanilla_model.RIGHT_LEG)
  save_part(vanilla_model.RIGHT_PANTS)
  save_part(vanilla_model.RIGHT_PARROT)
  save_part(vanilla_model.RIGHT_SLEEVE)
end

events.ENTITY_INIT:register(function ()
  models.model.root:setParentType("WORLD")
  save_state()
end)

local g = 0

events.TICK:register(function ()
  blink_time = blink_time + 1
  models.model:setColor(1, 1, 1)
  if blink_time > 6 * 20 or g <= 2 then
    blink_time = 0
    save_state()
    models.model:setColor(0, 0, 0)
  end
  if player:isOnGround() then
    g = g + 1
  else
    g = 0
  end
end)

function events.render(delta, context)
end