local composer = require( "composer" )

local scene = composer.newScene()
local u = require( "utils" )
local b = require( "button" )
local e = require( "events" )
local t = require( "taxes" )
local d = require( "gameData" )
local a = require( "animations" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local worldGroup, scroll, backBtn, descTxt, confirmBtn, tempChanges
local taxes, activeTaxes, currentTax, currentBtn, budgetEffect, capEffect, socEffect, conEffect, libEffect
local setup, createScroll, changeScene,  addNavButton, addConfirmButton, populateNav, createTaxButton, addTaxButtons, addEffectText, showEffect, clearEffect, addDescTxt, editTempChanges, applyDesicion, onNavButton, onTaxButton, onConfirmButton

setup = function (  )
    taxes = {}
    activeTaxes = {}
    tempChanges = {cap=0,soc=0,con=0,lib=0, budget=0}
    currentBtn = {}
end

changeScene = function ( scene, effect )
    composer.gotoScene( scene, {effect=effect , time=800} )
end

createScroll = function (  )
    scroll = b.scroll()
    scroll.x = u.left + scroll.width/2
    scroll.y = u.centerY
    --scroll.leftPadding = 40
    worldGroup:insert( scroll )
    --print( "scroll create: "..scroll. )
end

addNavButton = function (  )
    backBtn = b.navButton("Back", onNavButton)
    backBtn.x = u.right - backBtn.width/2
    backBtn.y = u.centerY
    backBtn.id = "back"

    worldGroup:insert( backBtn )
end

createTaxButton = function ( name, id, num )
    local btn = b.circleButton(name, onTaxButton)
    btn.id = id
    btn.num = num
    btn.active = false
    taxes[#taxes+1] = btn
    return btn
end

addTaxButtons = function (  )
    local gas = createTaxButton("Gas Tax", "gas", 1)
    local income = createTaxButton("Income Tax", "income", 2)
    local property = createTaxButton("Propert Tax", "property", 3)
    local sales = createTaxButton("Sales Tax", "sales", 4)
    local soda = createTaxButton("Soda Tax", "soda", 5)
    local capitalGain = createTaxButton("Capital Gain Tax", "capitalGain", 6)
    local estate = createTaxButton("Estate Tax", "estate", 7)
    local tobacco = createTaxButton("Tobacco Tax", "tobacco", 8)
end

addDescTxt = function (  )
    descTxt = b.descText(worldGroup, u.sceneW-200, 200)
    descTxt.x = u.centerX
    descTxt.y = u.centerY
    descTxt.text = ""
end

addConfirmButton = function (  )
    confirmBtn = b.normal(120, 20, "", onConfirmButton)
    confirmBtn.x = u.centerX 
    confirmBtn.y = budgetEffect.y + 40
    confirmBtn.id = "confirm"
    confirmBtn.press = true
    confirmBtn.alpha = 0
    worldGroup:insert( confirmBtn )
end

addEffectText = function (  )
    budgetEffect = b.factionText(worldGroup)
    budgetEffect.text = ""
    budgetEffect.x = u.centerX
    budgetEffect.y = u.centerY + 20

    capEffect = b.factionText(worldGroup)
    capEffect.text = ""
    capEffect.x = scroll.width + 30
    capEffect.y = u.centerY - 20

    socEffect = b.factionText(worldGroup)
    socEffect.text = ""
    socEffect.x = u.right -  backBtn.width - 30
    socEffect.y = u.centerY - 20

    conEffect = b.factionText(worldGroup)
    conEffect.text = ""
    conEffect.x = scroll.width + 30
    conEffect.y = capEffect.y + 20

    libEffect = b.factionText(worldGroup)
    libEffect.text = ""
    libEffect.x = u.right -  backBtn.width - 30
    libEffect.y = socEffect.y + 20
end

showEffect = function ( budget, cap, soc, con, lib )
    budgetEffect.text = "Budget: "..budget
    capEffect.text = "cap: "..cap
    socEffect.text = "soc: "..soc
    conEffect.text = "con: "..con
    libEffect.text = "lib: "..lib
end

clearEffect = function (  )
    budgetEffect.text = ""
    capEffect.text = ""
    socEffect.text = ""
    conEffect.text = ""
    libEffect.text = ""
end

sortScroll = function ( btn )
    local btn = btn
    
end

populateNav = function (  )
    for i=1, #taxes do
        taxes[i].y = 60 * i
        taxes[i].x = scroll.width/2 
        scroll:insert(taxes[i])
    end
end

editTempChanges = function ( t )
    tempChanges.budget = t.budget
    tempChanges.cap = t.cap
    tempChanges.soc = t.soc
    tempChanges.con = t.con
    tempChanges.lib = t.lib
end

applyDesicion = function ( btn )
    if (btn.active == true) then
        a.activeAnimation(btn, scroll.width/2 , btn.originY + 50, btn.originY, 800)
        btn.active = false
        confirmBtn.alpha = 0
        d.turnBudget = d.turnBudget - t.taxes[btn.num].budget
        activeTaxes[btn.id] = nil
        local add = timer.performWithDelay( 810, function() scroll:insert( btn ) end )
    else
        btn.originY = btn.y -- for animation purposes
        scroll:remove( btn )
        worldGroup:insert( btn)
        a.activeAnimation(btn, u.centerX, btn.y+50, u.top+100, 800)
        btn.active = true
        confirmBtn.alpha = 0
        d.turnBudget = d.turnBudget + t.taxes[btn.num].budget
        activeTaxes[btn.id] = t.taxes[btn.num]     
    end

end

onTaxButton = function ( event )
    local btn = event.target
    local budget
    if (event.phase == "began" and btn.active ~= true) then
        confirmBtn.alpha = 1
        confirmBtn:setLabel( "Issue" )
        editTempChanges(t.taxes[btn.num])
        showEffect(tempChanges.budget, tempChanges.cap, tempChanges.soc, tempChanges.con, tempChanges.lib)
        currentBtn = btn
    end

    if (event.phase == "began" and btn.active == true) then
        confirmBtn.alpha = 1
        confirmBtn:setLabel( "Cut" )
        editTempChanges(t.taxes[btn.num])
        showEffect("-"..tempChanges.budget, "-"..tempChanges.cap, "-"..tempChanges.soc, "-"..tempChanges.con, "-"..tempChanges.lib)
        currentBtn = btn
    end
end

onConfirmButton = function ( event )
    local btn = event.target
    if (event.phase == "began") then
        applyDesicion(currentBtn)
        clearEffect()
    end
end

onNavButton = function ( event )
    local btn = event.target
    if (event.phase == "began") then
        if (btn.id == "back") then
            changeScene("mainScene", "slideLeft")    
        end
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    worldGroup = display.newGroup( )
    sceneGroup:insert( worldGroup )
    -- Code here runs when the scene is first created but has not yet appeared on screen
    setup()
    addNavButton()
    createScroll()
    addTaxButtons()
    addDescTxt()
    addEffectText()
    addConfirmButton()
    populateNav()

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