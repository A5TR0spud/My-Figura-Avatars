vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

local t = 0
local s = 1
local r = 0
local rs = 0.5

function events.entity_init()
end

function events.tick()
  t = (t + s) % 20
  r = (r + rs) % 4
  models.model.root.Head.Face:setUVPixels(5 * math.floor(r), 0)
end

function events.render(delta, context)
  models.model.root.Head.Ring:setUVPixels(t + delta * s, 0)
end
