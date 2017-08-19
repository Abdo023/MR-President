local composer = require( "composer" )

local scene = composer.newScene()
local u = require( "utils" )
local widget = require( "widget" )
local b = require( "button" )
local e = require( "events")
local d = require( "gameData" )
local ui = require( "ui" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local worldGroup, taxBtn, policyBtn, nextTurnBtn, actionBtn1, actionBtn2, confirmBtn, budgetTxt, budgetEffect, capEffect, socEffect, conEffect, libEffect, titleText, descText, popTxt, capTxt, envTxt, socTxt, conTxt, libTxt, foodBar, healthBar, foodTxt, employmentTxt, healthTxt, educationTxt, wealthTxt, freedomTxt, foodEffect, employmentEffect, healthEffect, educationEffect, wealthEffect, freedomEffect, educationBar, wealthBar, freedomBar, popularityBar, endScreen
local usedEvents, currentEvent, tempChanges, allowTurn, mRand
local setup, createNavButton, addNextTurnButton, addNavButtons, createActionButton, addActionButtons, addDescText, addStatsText, createEffectText, addEffectText, newTurn, onNavButton, onActionButton, changeScene, showEffect, clearEffect, applyDesicion, createBar, addBars, addEndScreen

setup = function (  )
    currentEvent = {}
    usedEvents = {}
    tempChanges = {employment=0,health=0,education=0,wealth=0,freedom=0, budget=0}
    allowTurn = false
    mRand = math.random
end

changeScene = function ( scene, effect )
    composer.gotoScene( scene, {effect=effect , time=800} )
end

addNavButtons = function ( group )
    taxBtn = b.navButton("Tax", onNavButton)
    taxBtn.x = u.left + taxBtn.width/2
    taxBtn.y = u.centerY
    taxBtn.id = "taxBtn"

    policyBtn = b.navButton("Policy", onNavButton)
    policyBtn.x = u.right - policyBtn.width/2
    policyBtn.y = u.centerY
    policyBtn.id = "policyBtn"

    group:insert( taxBtn )
    group:insert( policyBtn )
end

addNextTurnButton = function (  )
    nextTurnBtn = b.normal(200, 30, "Next Turn", onActionButton)
    nextTurnBtn.x = u.centerX
    nextTurnBtn.y = u.bottom - 100
    nextTurnBtn.id = "next"

    worldGroup:insert( nextTurnBtn )
end

createActionButton = function ( x,y,id )
    local btn = b.normal(60,20,"",onActionButton)
    btn.x = x
    btn.y = y
    btn.id = id
    btn.press = true
    return btn
end

addActionButtons = function (  )
    actionBtn1 = createActionButton(u.centerX-60, u.centerY+100,"action1")
    actionBtn2 = createActionButton(u.centerX+60, u.centerY+100,"action2")
    confirmBtn = createActionButton(u.centerX,  actionBtn1.y + 40,"confirm")
    confirmBtn.width = 120
    confirmBtn:setLabel( "Confirm" ) 

    worldGroup:insert( actionBtn1 )
    worldGroup:insert( actionBtn2 )
    worldGroup:insert( confirmBtn )
end

addDescText = function (  )
    titleText = b.factionText(worldGroup)
    titleText.anchorY = 0
    titleText.x = u.centerX 
    titleText.y = popTxt.y + 20
    titleText.text = "Event"
    titleText:setFillColor( 0,0,1 )

    descText = b.descText(worldGroup, u.sceneW-100, 200)
    descText.anchorY = 0
    descText.x = u.centerX
    descText.y = titleText.y + 20
end

createBar = function ( x,y )
    local bar, frame = ui.bar(worldGroup)
    bar.x = x
    bar.y = y
    frame.x = x
    frame.y = y
    bar.cV = 50
    bar.mV = 100
    return bar
end

addBars = function (  )
    employmentBar = createBar(u.centerX, u.top + 60)
    healthBar = createBar(u.centerX, employmentBar.y + 20)
    ui.editBar(healthBar, -10)
    educationBar = createBar(u.centerX , healthBar.y + 20)
    wealthBar = createBar(u.centerX, educationBar.y + 20)
    freedomBar = createBar(u.centerX , wealthBar.y + 20)
    popularityBar = createBar(u.centerX , freedomBar.y + 20)
        popularityBar.width = 100
        popularityBar.frame.width = 100
        popularityBar.oWidth = 100

    ui.editBar(employmentBar, d.stats.employment)
    ui.editBar(healthBar, d.stats.health)
    ui.editBar(educationBar, d.stats.education)
    ui.editBar(wealthBar, d.stats.wealth)
    ui.editBar(freedomBar, d.stats.freedom)
    ui.editBar(popularityBar, d.getPopularity())
end

addStatsText = function (  )
    budgetTxt = b.factionText(worldGroup)
    budgetTxt.text = "Budget: "..d.budget
    budgetTxt.x = u.centerX
    budgetTxt.y = u.top + 30

    employmentTxt = b.factionText(worldGroup)
    employmentTxt.text = "Employment: "
    employmentTxt.x = taxBtn.width + 10 + employmentTxt.width/2
    employmentTxt.y = budgetTxt.y + 30

    healthTxt = b.factionText(worldGroup)
    healthTxt.text = "Health: "
    healthTxt.x = taxBtn.width + 10 + healthTxt.width/2
    healthTxt.y = employmentTxt.y + 20

    educationTxt = b.factionText(worldGroup)
    educationTxt.text = "Education: "
    educationTxt.x = taxBtn.width + 10 + educationTxt.width/2
    educationTxt.y = healthTxt.y + 20

    wealthTxt = b.factionText(worldGroup)
    wealthTxt.text = "Wealth: "
    wealthTxt.x = taxBtn.width + 10 + wealthTxt.width/2
    wealthTxt.y = educationTxt.y + 20

    freedomTxt = b.factionText(worldGroup)
    freedomTxt.text = "Freedom: "
    freedomTxt.x = taxBtn.width + 10 + freedomTxt.width/2
    freedomTxt.y = wealthTxt.y + 20

    popTxt = b.factionText(worldGroup)
    popTxt.text = "Popularity: "
    popTxt.x = taxBtn.width + 10 + popTxt.width/2
    popTxt.y = freedomTxt.y + 20
end

--[[
addStatsText = function (  )
    budgetTxt = b.factionText(worldGroup)
    budgetTxt.text = "Budget: "..d.budget
    budgetTxt.x = u.centerX
    budgetTxt.y = u.top + 30

    capTxt = b.factionText(worldGroup)
    capTxt.text = "Capitalists: "..d.factions.cap
    capTxt.x = taxBtn.width + 10 + capTxt.width/2
    capTxt.y = budgetTxt.y + 30

    conTxt = b.factionText(worldGroup)
    conTxt.text = "Conservatives: "..d.factions.con
    conTxt.x = taxBtn.width + 10 + conTxt.width/2
    conTxt.y = capTxt.y + 20

    socTxt = b.factionText(worldGroup)
    socTxt.text = "Socialists: "..d.factions.soc
    socTxt.x = policyBtn.x - (policyBtn.width/2) - 10 - socTxt.width/2
    socTxt.y = budgetTxt.y + 30

    libTxt = b.factionText(worldGroup)
    libTxt.text = "Librals: "..d.factions.lib
    libTxt.x = policyBtn.x - (policyBtn.width/2) - 10 - libTxt.width/2
    libTxt.y = socTxt.y + 20
end
]]
--[[
addEffectText = function (  )
    budgetEffect = b.factionText(worldGroup)
    budgetEffect.text = ""
    budgetEffect.x = u.centerX
    budgetEffect.y = actionBtn1.y - 30

    capEffect = b.factionText(worldGroup)
    capEffect.text = ""
    capEffect.x = taxBtn.width + 30
    capEffect.y = descText.y + 20

    socEffect = b.factionText(worldGroup)
    socEffect.text = ""
    socEffect.x = u.right -  policyBtn.width - 30
    socEffect.y = descText.y + 20

    conEffect = b.factionText(worldGroup)
    conEffect.text = ""
    conEffect.x = taxBtn.width + 30
    conEffect.y = capEffect.y + 20

    libEffect = b.factionText(worldGroup)
    libEffect.text = ""
    libEffect.x = u.right -  policyBtn.width - 30
    libEffect.y = socEffect.y + 20
end
]]

createEffectText = function ( x,y )
    local txt = b.factionText(worldGroup)
    txt.text = ""
    txt.x = x
    txt.y = y
    return txt
end

addEffectText = function (  )
    budgetEffect = createEffectText(u.centerX, actionBtn1.y - 20)
    employmentEffect = createEffectText(taxBtn.width + 40, descText.y + descText.height/2 + 5)
    healthEffect = createEffectText(u.right -  policyBtn.width - 40, descText.y + descText.height/2 + 5)
    educationEffect = createEffectText(taxBtn.width + 40, healthEffect.y + 20)
    wealthEffect = createEffectText(u.right -  policyBtn.width - 40, healthEffect.y + 20)
    freedomEffect = createEffectText(u.centerX, wealthEffect.y + 20)
end
--[[
clearEffect = function (  )
    budgetEffect.text = ""
    capEffect.text = ""
    socEffect.text = ""
    conEffect.text = ""
    libEffect.text = ""
end
]]

clearEffect = function (  )
    budgetEffect.text = ""
    employmentEffect.text = ""
    healthEffect.text = ""
    educationEffect.text = ""
    wealthEffect.text = ""
    freedomEffect.text = ""
end

showEffect = function ( budget, food, health, education, wealth, freedom )
    budgetEffect.text = "Budget: "..budget
    employmentEffect.text = "Employment: "..food
    healthEffect.text = "Health: "..health
    educationEffect.text = "Education: "..education
    wealthEffect.text = "Wealth: "..wealth
    freedomEffect.text = "Freedom: "..freedom
end

addEndScreen = function (  )
    endScreen = display.newRect( worldGroup, 0, 0, u.sceneW/1.2, u.sceneH/1.2 )
    endScreen.x = u.centerX
    endScreen.y = u.centerY
    endScreen:setFillColor( 44 /255, 62 /255, 80 /255 )

    local txt = b.factionText(worldGroup)
    txt.x = u.centerX
    txt.y = u.centerY
    txt.text = "Thanks for playing :)"
end

applyDesicion = function (  )
    actionBtn1.press = false
    actionBtn2.press = false
    confirmBtn.press = false
    d.budget = d.budget + tempChanges.budget
    budgetTxt.text = "Budget: "..d.budget

    d.stats.employment = d.stats.employment + tempChanges.employment
    ui.editBar(employmentBar, d.stats.employment)
    d.stats.health =  d.stats.health + tempChanges.health
    ui.editBar(healthBar, d.stats.health)
    d.stats.education = d.stats.education + tempChanges.education
    ui.editBar(educationBar, d.stats.education)
    d.stats.wealth = d.stats.wealth + tempChanges.wealth
    d.stats.freedom = d.stats.freedom + tempChanges.freedom
    ui.editBar(wealthBar, d.stats.wealth)
    ui.editBar(popularityBar, d.getPopularity())
    allowTurn = true
end

newTurn = function (  )
    if (d.turns == 3) then
        addEndScreen()
        return
    end
    local random = mRand(#e.events)
    currentEvent = e.events[random]
    usedEvents[#usedEvents+1] = currentEvent
    table.remove( e.events, random )
    d.turns = d.turns + 1
    descText.text = currentEvent.desc
    local lbl1 = currentEvent.action1.text
    local lbl2 = currentEvent.action2.text
    actionBtn1:setLabel( lbl1 )
    actionBtn2:setLabel( lbl2 )
    actionBtn1.press = true
    actionBtn2.press = true
    confirmBtn.press = true
    allowTurn = false
    clearEffect()
    d.budget = d.budget + d.turnBudget
    budgetTxt.text = "Budget: "..d.budget
end

editTempChanges = function ( t )
    tempChanges.budget = currentEvent[t].budget
    tempChanges.employment = currentEvent[t].employment
    tempChanges.health = currentEvent[t].health
    tempChanges.education = currentEvent[t].education
    tempChanges.wealth = currentEvent[t].wealth
    tempChanges.freedom = currentEvent[t].freedom
end

onNavButton = function ( event )
    local btn = event.target
    if (event.phase == "began") then
        if (btn.id == "taxBtn") then
            changeScene("taxScene", "slideRight")
        elseif (btn.id == "policyBtn") then
            changeScene("policyScene", "slideLeft")
        end
    end
end


onActionButton = function ( event )
    local btn = event.target
    if (event.phase == "began") then
        if (btn.id == "action1" and btn.press == true) then
            editTempChanges("action1")
            showEffect(tempChanges.budget, tempChanges.employment, tempChanges.health, tempChanges.education, tempChanges.wealth, tempChanges.freedom)
        elseif (btn.id == "action2" and btn.press == true) then
            editTempChanges("action2")
            showEffect(tempChanges.budget, tempChanges.employment, tempChanges.health, tempChanges.education, tempChanges.wealth, tempChanges.freedom)
        elseif (btn.id == "confirm" and btn.press == true) then
            applyDesicion()
        elseif (btn.id == "next" and allowTurn) then
            newTurn()
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
    addNavButtons(worldGroup)
    addActionButtons()
    addNextTurnButton()
    addStatsText()
    addDescText()
    addEffectText()
    addBars()

    newTurn()

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        --print( "events: "..#e.events )
        print( "turnBudget Main: "..d.turnBudget )
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