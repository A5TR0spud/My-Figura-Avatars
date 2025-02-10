--Silver Engine
--by A5TR0spud
-- designed for figura 0.1.5 rc 6 fabric 1.21.4, accomodating the bugs, but should work for older/other versions

vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

local smogParticle = "minecraft:campfire_cosy_smoke"

local t = 0
local st = 0
local PUFF_TIME = 20
local flywheel = 0
local flywheelSpeed = -1
local plrSpd = 0
local showingTank = true
local makeSnow = false

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

local smokeEnabled = true

function pings.TankScarfToggle(x)
  showingTank = not x
  models.model.root.Body.Tank:setVisible(not x)
  models.model.root.Cape:setVisible(x)
  if x then
    models.model.root.Body:setPrimaryTexture("CUSTOM", textures:getTextures()[2])
  else
    models.model.root.Body:setPrimaryTexture("CUSTOM", textures:getTextures()[3])
  end
end

function pings.SmokeToggle(x)
  smokeEnabled = x
end

function pings.SnowToggle(x)
  makeSnow = x
end

local action_TankScarfToggle = mainPage:newAction()
  :title("Showing Tank")
  :item("minecraft:cauldron")
  :setToggleItem("minecraft:red_carpet")
  :setToggleTitle("Showing Scarf")
  :onToggle(pings.TankScarfToggle)
  :hoverColor(0.8, 0.8, 0.8)
  :setToggleColor(0,0,0)
--

local action_SmokeToggle = mainPage:newAction()
  :title("Smokestack Disabled")
  :item("minecraft:flint_and_steel")
  :setToggleItem("minecraft:campfire")
  :setToggleTitle("Smokestack Enabled")
  :onToggle(pings.SmokeToggle)
  :hoverColor(0.8, 0.8, 0.8)
  :setToggled(smokeEnabled)
--

local action_SnowToggle = mainPage:newAction()
  :title("Snowfall Disabled")
  :item("minecraft:water_bucket")
  :setToggleItem("minecraft:snow_block")
  :setToggleTitle("Snowfall Enabled")
  :onToggle(pings.SnowToggle)
  :hoverColor(0.8, 0.8, 0.8)
  :setToggled(makeSnow)
--

function pings.SetTankFill(x)
  models.model.root.Body.Tank.Fill:setUV(0, (x / 20.0) * 11/64)
end

local food = -1

function events.tick()
  plrSpd = (player:getVelocity() * vectors:vec3(1, 0, 1)):length()

  if t > PUFF_TIME and smokeEnabled then
    t = 0
    local smokeEmitPos = models.model.root.Head.Stack.SmokeEmitter:partToWorldMatrix():apply()
    particles:newParticle(smogParticle, smokeEmitPos, 0, 0.05, 0)
    animations.model.puff:stop()
    animations.model.puff:play()
  end
  flywheelSpeed = plrSpd * -45.0 - 15.0
  flywheel = flywheel + flywheelSpeed
  if host:isHost() and player:getFood() ~= food and showingTank then
    food = player:getFood()
    pings.SetTankFill(food)
  end
  -- world:getBiome does not seem to work
  --local pos = player:getPos()
  --local bio = world:getBiome(pos)
  --local wat = bio:getWaterColor()
  models.model.root.Body.Tank.Fill:setColor(0.247, 0.463, 0.894)
  t = t + 1 + plrSpd * 10.0

  if makeSnow and st > 4 then
    local snwPos = player:getPos()
    local box = player:getBoundingBox()
    local offsetX = math.random() * box.x - box.x * 0.5
    local offsetY = math.random() * box.y + box.y * 0.25 + 0.5
    local offsetZ = math.random() * box.z - box.z * 0.5
    local offset = vectors:vec3(offsetX, offsetY, offsetZ)
    particles:newParticle("minecraft:snowflake", snwPos + offset)
    st = 0
  end

  st = st + 0.5 + math.random()
end

--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
  models.model.root.Head.Flywheel:setRot(flywheel + flywheelSpeed * delta, 0, 0)
end
