vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)


local c = models.model.root:getChildren()
for i, k in pairs(c) do
    k:setParentType("CAMERA")
end

function events.render(delta, context)
    local c = models.model:getChildren()
    for i, k in pairs(c) do
        k:setPos((math.random() - 0.5) * 0.1, (math.random() - 0.5) * 0.1, (math.random() - 0.5) * 0.1)
    end
end