local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
--Variables
local btnsGroup
local currentTax

local msg

--Functions
local function activateTax( btn )
    if (btn.activated) then
        return
    end
    btn:setFillColor( 0,1,0 )
    btn.activated = true
    --F.activateTax(btn.id)
    F.addValues("tax",currentTax.money, currentTax.safety, currentTax.edu, currentTax.wealth)
end

local function deactivateTax( btn )
    btn:setFillColor( 211 /255, 84 /255, 0 /255, 0.1 )
    btn.activated = false

    F.deductValues("tax",currentTax.money, currentTax.safety, currentTax.edu, currentTax.wealth)

    print( "Month Tax Money: "..Data.monthTaxMoney )
end

local function selectRandomTax(  )
    for i=1,3 do
        local rand = U.mRand(#Taxes.taxes)
        currentTax = Taxes.taxes[rand]
        activateTax(btnsGroup.btns[rand])
        print( "Rand: "..rand )
    end
end

local function btnPressed( event )
    local btn = event.target
    local phase = event.phase

    if (phase == "moved") then
        local dy = math.abs( ( event.y - event.yStart ) )
        -- If the touch on the button has moved more than 10 pixels,
        -- pass focus back to the scroll view so it can continue scrolling
        if ( dy > 10 ) then
            btnsGroup:takeFocus( event )
        end
    elseif (phase == "ended") then
        if (F.checkValue("action", 1)) then
            F.deductValue("action", 1)  -- decrease action points
            currentTax = Taxes.taxes[btn.id] -- assign current tax
            if (btn.activated == false) then
                activateTax(btn)   
            else
                deactivateTax(btn)
            end
        else
            print( "Not enouch action" )  -- show message
            local txt = "You cannot take any more actions this month"
            msg.txt.text = txt
            msg.isVisible = true
        end
    end


end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    btnsGroup = BB.btnsScroll(Taxes.taxes, btnPressed)
    btnsGroup.y = U.cY - 50
    btnsGroup:toBack()
    sceneGroup:insert( btnsGroup )

    local txt = "Here you can impose/remove taxes.\nTaxes affects the 3 main aspects of any society (Safety-Education-Wealth) and they also generate monthly revenue. But keep in mind that those 3 main aspects affect your overall popularity.\n\nSo, be careful not to get your citizens overwhelmed with taxation or you will not stay in office for too long."
    local tutorial = SB.tutorial(sceneGroup, txt)

    msg = SB.tutorial(sceneGroup, "")
    msg.isVisible = false


    selectRandomTax()
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene