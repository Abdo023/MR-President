local composer = require( "composer" )

local scene = composer.newScene()

local events = require("Data.events")
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- Variables
local currentEvent 
local randomEvent
local eventGroup
local action
local isNewEvent = true -- in order to show/not hsow confirm btn if action already been taken

local stats

local nextBtn

local endBanner

--Functions

local function endGame( condition )
    print( "Game Ended" )
    local txt
    if (condition == "pop") then
        if( F.compareValues("pop", 51) ) then
            print( "Game Won" )
            txt = "Congratulations!\nYou have managed to gain "..U.mRound(Data.pop).."% popularity\nYou can now retire with pride."
        else
            print( "Game Lost" )
            txt = "Unfortunately you haven't managed to gain enough popularity in your term.\n your overall popularity was "..U.mRound(Data.pop).."% Better luck next time."
        end    
    elseif(condition == "money") then
        txt = "You ran out of money!\nYou have been kicked out of office"
    end

    endBanner.txt.text = txt
    endBanner.isVisible = true
    eventGroup.isVisible = false
end
--Called in create & nextBtn
local function chooseEvent(  )
    --Add the currentEvent to the completedEvents table and remove it from the current table
    if (currentEvent ~= nil) then
        events.completedEvents[#events.completedEvents+1] = currentEvent
        print( #events.completedEvents )
        --table.remove( events.events, randomEvent )
        print( #events.events )
    end
    --Show event
    randomEvent = U.mRand(#events.events)
    currentEvent = events.events[randomEvent]
    isNewEvent = true
    eventGroup.setTxt(currentEvent.title, currentEvent.desc, currentEvent.action1.text, currentEvent.action2.text)
end

local function nextMonth(  )
    if (Data.month == Data.totalMonth) then
        endGame("pop")
        return
    end
    if (not F.checkValue("money")) then
        print( "Not enough money" )
        endGame("money")
        return
    end
    eventGroup.moneyEffectTxt.text = ""
    eventGroup.popEffectTxt.text = ""
    chooseEvent()
    F.nextMonth()
    F.updateLabels(stats.safetyBar, stats.eduBar, stats.wealthBar)
end

local function applyEffect( action )
    print( currentEvent[action].money )
    Data.money = Data.money + currentEvent[action].money
    Data.monthPop = currentEvent[action].pop
    Data.pop = Data.pop + Data.monthPop
    F.updateLabels()
end

local function showEffects( btn )
    local action
    if (btn == "btn1") then
        action = currentEvent.action1
        eventGroup.setEffectTxt(action.money, action.pop)
    else
        action = currentEvent.action2
        eventGroup.setEffectTxt(action.money, action.pop)
    end
end

local function handleEventBtn( event )
    local id = event.target.id
    if (id == "btn1" and isNewEvent) then
        action = "action1"
        showEffects(id)
        eventGroup.confirmBtn.isVisible = true
    elseif (id == "btn2" and isNewEvent) then
        action = "action2"
        showEffects(id)
        eventGroup.confirmBtn.isVisible = true
    elseif (id == "confirmBtn") then
        applyEffect(action)
        isNewEvent = false
        event.target.isVisible = false
        nextBtn.isVisible = true
    end
end

local function handleNextBtn( event )
    local btn = event.target
    nextMonth()
    nextBtn.isVisible = false
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    eventGroup = SB.eventGroup(sceneGroup, handleEventBtn)
    

    nextBtn = UI.normalBtn(400, 100, "Next Month", handleNextBtn)
    nextBtn.x = U.cX
    nextBtn.y = U.cY+500
    nextBtn.isVisible = false
    sceneGroup:insert( nextBtn )

    stats = SB.statGroup(sceneGroup)

    endBanner = SB.tutorial(sceneGroup, "")
    endBanner.isVisible = false

    local txt = "Your goal is to have 50+% popularity after 12 months in order to get re-elected. \n\nIn this screen you you can respond to events, check your stats and advance to the next month. \nYou can only progress to the next month after you respond to the presented event."
    local tutorial = SB.tutorial(sceneGroup, txt)

    --Functions
    --chooseEvent()
    nextMonth()

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