function IsFlipping()
    return animations.model.coin_heads:isPlaying() or animations.model.coin_tails:isPlaying()
end

require("script")

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)
local coinsPage = action_wheel:newPage()
local roulettePage = action_wheel:newPage()
local flipResultText = models.model.root.RightArm.TextAnchor:newText("flipResultText_")
local t = 0
local RESULT_TEXT_DURATION = 32
flipResultText:setAlignment("CENTER"):setOutline(true):setOutlineColor(0.149, 0.082, 0.18):setScale(0.3)

function CoinFlip(isHeads)
    if IsFlipping() then
        return
    end

    local i = math.random(2)
    local x1 = i == 1
    local x2 = i == (isHeads and 2 or 1)
    pings.CoinFlip(x1, x2)
end

local roulette_anim = nil

events.TICK:register(function ()
    t = t + 1
    models.model.root.RightArm.RightItemPivot:setVisible(IsFlipping())
    flipResultText:setVisible(t > -RESULT_TEXT_DURATION and t < 0)

    if roulette_anim == nil or roulette_anim:getTime() > 2.25 then
      models.model.root.LeftArm.RouletteIndicator:setVisible(false)
      models.model.root.RightArm.Roulette:setVisible(false)
    end
end)

function pings.CoinFlip(x1, x2)
    local head = x1 ~= x2
    models.model.root.RightArm.RightItemPivot.Coin:setVisible(true)
    if head then
        animations.model.coin_heads:play()
        flipResultText:setVisible(false)
        flipResultText:setText("Heads")
    else
        animations.model.coin_tails:play()
        flipResultText:setVisible(false)
        flipResultText:setText("Tails")
    end
    t = -20 - RESULT_TEXT_DURATION
end

local action_CoinFlipsPage = mainPage:newAction()
  :title("Coin Flips")
  :item("minecraft:sunflower")
  :onLeftClick( function ()
    action_wheel:setPage(coinsPage)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_CoinFlipHeads = coinsPage:newAction()
  :title("Flip a Coin (Heads)")
  :item("minecraft:player_head")
  :onLeftClick( function ()
    CoinFlip(true)
  end)
  :hoverColor(0.8, 0.8, 0.8)
  :setToggleColor(0,0,0)
--

local action_CoinFlipTails = coinsPage:newAction()
  :title("Flip a Coin (Tails)")
  :item("minecraft:lead")
  :onLeftClick( function ()
    CoinFlip(false)
  end)
  :hoverColor(0.8, 0.8, 0.8)
  :setToggleColor(0,0,0)
--

local action_CoinFlipRandom = coinsPage:newAction()
  :title("Flip a Coin (Random)")
  :item("minecraft:sunflower")
  :onLeftClick( function ()
    CoinFlip(math.random(2) == 1)
  end)
  :hoverColor(0.8, 0.8, 0.8)
  :setToggleColor(0,0,0)
--

local action_CoinBack = coinsPage:newAction()
  :title("Back")
  :item("minecraft:arrow")
  :onLeftClick( function ()
    action_wheel:setPage(mainPage)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_RoulettePage = mainPage:newAction()
  :title("Roulette Wheel")
  :item("minecraft:poppy")
  :onLeftClick( function ()
    action_wheel:setPage(roulettePage)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

function pings.WheelSpin(col, num)
  if 7 - col == 0 then
    col = "red"
  else
    col = "blk"
  end
  local r = "roulette_"..col.."_"..(7 - num)
  t = -48 - RESULT_TEXT_DURATION
  flipResultText:setVisible(false)
  flipResultText:setText((col == "red" and "Red " or "Black ")..(7-num))
  models.model.root.LeftArm.RouletteIndicator:setVisible(true)
  models.model.root.RightArm.Roulette:setVisible(true)
  roulette_anim = animations.model[r]:play()
end

local function Roulette(col, num)
  if roulette_anim ~= nil and roulette_anim:isPlaying() then
    do return end
  end
  pings.WheelSpin(7 - col, 7 - num)
end

local action_red_0 = roulettePage:newAction()
  :title("Red 0")
  :item("minecraft:poppy")
  :onLeftClick( function ()
    Roulette(0, 0)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_red_1 = roulettePage:newAction()
  :title("Red 1")
  :item("minecraft:poppy")
  :onLeftClick( function ()
    Roulette(0, 1)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_red_2 = roulettePage:newAction()
  :title("Red 2")
  :item("minecraft:poppy")
  :onLeftClick( function ()
    Roulette(0, 2)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_red_3 = roulettePage:newAction()
  :title("Red 3")
  :item("minecraft:poppy")
  :onLeftClick( function ()
    Roulette(0, 3)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_black_0 = roulettePage:newAction()
  :title("Black 0")
  :item("minecraft:wither_rose")
  :onLeftClick( function ()
    Roulette(1, 0)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_black_1 = roulettePage:newAction()
  :title("Black 1")
  :item("minecraft:wither_rose")
  :onLeftClick( function ()
    Roulette(1, 1)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_black_2 = roulettePage:newAction()
  :title("Black 2")
  :item("minecraft:wither_rose")
  :onLeftClick( function ()
    Roulette(1, 2)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_black_3 = roulettePage:newAction()
  :title("Black 3")
  :item("minecraft:wither_rose")
  :onLeftClick( function ()
    Roulette(1, 3)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_roulette_random = roulettePage:newAction()
  :title("Random")
  :item("minecraft:emerald")
  :onLeftClick( function ()
    Roulette(math.random(0, 1), math.random(0, 3))
  end)
  :hoverColor(0.8, 0.8, 0.8)
--

local action_RouletteBack = roulettePage:newAction()
  :title("Back")
  :item("minecraft:arrow")
  :onLeftClick( function ()
    action_wheel:setPage(mainPage)
  end)
  :hoverColor(0.8, 0.8, 0.8)
--