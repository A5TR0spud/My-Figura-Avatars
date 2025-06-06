vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

function events.entity_init()
  --models.model.root.Head.Face.RightEye:setParentType("CAMERA")
  --models.model.root.Head.Face.LeftEye:setParentType("CAMERA")
  --models.model.root.Head.Endo.RightEye2:setParentType("CAMERA")
  --models.model.root.Head.Endo.LeftEye2:setParentType("CAMERA")
  models.model.root.Head.Face.LeftEyelid:setUVPixels(0, -0.5)
  models.model.root.Head.Face.RightEyelid:setUVPixels(0, -0.5)
end

function events.tick()
end

function events.render(delta, context)
end


local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

function pings.faceless(x)
  models.model.root.Head.Face:setVisible(not x)
end

local action_FacelessToggle = mainPage:newAction()
  :title("Faced")
  :item("minecraft:rabbit_spawn_egg")
  :setToggleItem("minecraft:skeleton_skull")
  :setToggleTitle("Defaced")
  :onToggle(pings.faceless)
  :setColor(0.0, 0.0, 0.0)
  :setHoverColor(0.0, 0.0, 0.0)
  :setToggleColor(0.0, 0.0, 0.0)
--