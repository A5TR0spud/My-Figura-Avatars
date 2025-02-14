function IsFlipping()
    return animations.model.coin_heads:isPlaying() or animations.model.coin_tails:isPlaying()
end

require("script")

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)
local coinsPage = action_wheel:newPage()
local flipResultText = models.model.root.RightArm.TextAnchor:newText("flipResultText_")
local t = 0
local RESULT_TEXT_DURATION = 25
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

events.TICK:register(function ()
    t = t + 1
    models.model.root.RightArm.RightItemPivot:setVisible(IsFlipping())
    flipResultText:setVisible(t > -RESULT_TEXT_DURATION and t < 0)
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
