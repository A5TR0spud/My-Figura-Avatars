vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)


events.ENTITY_INIT:register(function ()
    models.model.Censor:setPrimaryRenderType("CUTOUT_CULL")
    models.model.Censor:setParentType("WORLD")
end)


events.POST_RENDER:register(function (delta)
    local boxCorners = {}

    local headCorners = models.model.root.Head:getChildren()
    for i = 1, #headCorners do
        local part = headCorners[i]
        if part:getVisible() then
            table.insert(boxCorners, part:partToWorldMatrix():apply())
        end
    end
    local bodyCorners = models.model.root.Body:getChildren()
    for i = 1, #bodyCorners do
        local part = bodyCorners[i]
        if part:getVisible() then
            table.insert(boxCorners, part:partToWorldMatrix():apply())
        end
    end
    local rightArmCorners = models.model.root.RightArm:getChildren()
    for i = 1, #rightArmCorners do
        local part = rightArmCorners[i]
        if part:getVisible() then
            table.insert(boxCorners, part:partToWorldMatrix():apply())
        end
    end
    local leftArmCorners = models.model.root.LeftArm:getChildren()
    for i = 1, #leftArmCorners do
        local part = leftArmCorners[i]
        if part:getVisible() then
            table.insert(boxCorners, part:partToWorldMatrix():apply())
        end
    end
    local rightLegCorners = models.model.root.RightLeg:getChildren()
    for i = 1, #rightLegCorners do
        local part = rightLegCorners[i]
        if part:getVisible() then
            table.insert(boxCorners, part:partToWorldMatrix():apply())
        end
    end
    local leftLegCorners = models.model.root.LeftLeg:getChildren()
    for i = 1, #leftLegCorners do
        local part = leftLegCorners[i]
        if part:getVisible() then
            table.insert(boxCorners, part:partToWorldMatrix():apply())
        end
    end

    local rightMostX = -1
    local rightMostIndex = 1
    local leftMostX = 1
    local leftMostIndex = 1
    local topMostY = 1
    local topMostIndex = 1
    local bottomMostY = -1
    local bottomMostIndex = 1
    local closest = -1

    for i = 1, #boxCorners do
        local screenPos = vectors.worldToScreenSpace(boxCorners[i])
        local x = screenPos.x
        local y = screenPos.y
        local depth = screenPos.w
        if (x > rightMostX) then
            rightMostX = x
            rightMostIndex = i
        end
        if (x < leftMostX) then
            leftMostX = x
            leftMostIndex = i
        end
        if (y > bottomMostY) then
            bottomMostY = y
            bottomMostIndex = i
        end
        if (y < topMostY) then
            topMostY = y
            topMostIndex = i
        end
        if depth > 0 and (depth < closest or closest <= 0) then
            closest = depth
        end
    end

    local top = vectors.toCameraSpace(boxCorners[topMostIndex])
    local right = vectors.toCameraSpace(boxCorners[rightMostIndex])
    local bottom = vectors.toCameraSpace(boxCorners[bottomMostIndex])
    local left = vectors.toCameraSpace(boxCorners[leftMostIndex])
    top.x = -top.x
    right.x = -right.x
    bottom.x = -bottom.x
    left.x = -left.x

    local width = math.abs(right.x - left.x)
    local height = math.abs(bottom.y - top.y)

    local topLeftCorner = vectors:vec3(left.x - width/2, top.y - height/2, closest)

    topLeftCorner = vectors.rotateAroundAxis(client:getCameraRot().x, topLeftCorner, vectors:vec3(1, 0, 0))
    topLeftCorner = vectors.rotateAroundAxis(-client:getCameraRot().y, topLeftCorner, vectors:vec3(0, 1, 0))
    topLeftCorner = vectors.rotateAroundAxis(client:getCameraRot().z, topLeftCorner, vectors:vec3(0, 1, 1))

    topLeftCorner = topLeftCorner + client:getCameraPos()

    models.model.Censor:setPos(topLeftCorner * 16)
    models.model.Censor.Censor:setScale(width * 16, height * 16, 0)
    models.model.Censor.Censor:setRot(client:getCameraRot() * vectors:vec3(1, -1, 1))
end)