local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
--Variables
local valuesLabels
local popBar



-- Functions
local function tabPressed( event )
    local btn = event.target
    composer.gotoScene( "Scenes."..btn.id)
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local tabBar = UI.tabBar( tabPressed )
    
    valuesLabels = SB.valuesGroup(sceneGroup, 200)
    valuesLabels.setTxt(Data.money, Data.month, Data.pop)
    
    --valuesLabels.dayTxt.text = "Day: "..Data.values.day

    

    --countDays(valuesLabels.dayBar)
    
    -- Here we add the tabBar&labels to the stage so we can reference it in other scenes
    local stage = display.getCurrentStage( )
    stage:insert( composer.stage )
    stage:insert( tabBar )
    stage:insert( valuesLabels )
    stage.tabBar = tabBar
    stage.valuesLabels = valuesLabels

    --F.updateLabels()
    F.randomiseStats()
    --composer.gotoScene( "Scenes.policyScene" )
    composer.gotoScene( "Scenes.officeScene" )
    --composer.gotoScene( "Scenes.taxScene" )
    
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