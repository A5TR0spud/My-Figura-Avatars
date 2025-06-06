vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

function events.entity_init()
  models.model.root:setPrimaryRenderType("CUTOUT_CULL")
  models.model.root:setSecondaryRenderType("EYES")
end


models.model.Skull:setPrimaryRenderType("CUTOUT_CULL")
models.model.Skull:setSecondaryRenderType("EYES")

local v = 0
local u = 0
local s = 0.5

function events.tick()
  v = v + s
end

function events.render(delta, context)
  local r = vectors:vec3(0, v + s * delta, 0)
  models.model.root.Head.Ring:setRot(r)
end