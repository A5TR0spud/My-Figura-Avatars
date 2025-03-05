vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

function pings.techno(b)
    models.model.root:setUV(0, b and 0.5 or 0)
    models.model.Skull:setUV(0, b and 0.5 or 0)
end

local action_Techno = mainPage:newAction()
  :title("Pig")
  :item("minecraft:pig_spawn_egg")
  :setToggleItem("minecraft:red_carpet")
  :setToggleTitle("Mechasword")
  :onToggle(pings.techno)
  :hoverColor(0.8, 0.8, 0.8)
  :setToggleColor(0,0,0)
--