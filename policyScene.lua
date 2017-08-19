local composer = require( "composer" )

local scene = composer.newScene()
local widget = require( "widget" )
local u = require( "utils" )
local b = require( "button" )
local p = require( "policies" )
local d = require( "gameData" )
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local worldGroup, scroll, pTable, backBtn
local foodSegment, policies, currentPolicy, currentBox, boxGroup, policyBtns, currentBtns
local setup, changeScene, createScroll, createTable, createConfirmBox, removeConfirmBox, createSlider, addSliders, createSegment, createPolicyBtn, createPolicyText, addSegments, addNavButton, addPolicy, onNavButton, onPolicyBtn, onRowRender, onConfirm, onSlider, onSegment


changeScene = function ( scene, effect )
    composer.gotoScene( scene, {effect=effect , time=800} )
end

setup = function (  )
    policies = p.policies
    --currentPolicy = {}
    policyBtns = {}
end

createScroll = function (  )
    scroll = b.scroll()
    scroll.x = u.right - scroll.width/2
    scroll.y = u.centerY
    scroll.leftPadding = 40

    worldGroup:insert( scroll )
end

addNavButton = function (  )
    backBtn = b.navButton("Back", onNavButton)
    backBtn.x = u.left + backBtn.width/2
    backBtn.y = u.centerY
    backBtn.id = "back"

    worldGroup:insert( backBtn )
end

createTable = function (  )
    pTable = widget.newTableView( {
        x = u.centerX + backBtn.width*0.6,
        y = u.centerY,
        width = u.sceneW - backBtn.width, 
        height = u.sceneH,
        backgroundColor = { 0.8, 0.8, 0.8 },
        onRowRender = onRowRender
    } )
    for i=1,#policies do
        pTable:insertRow{rowHeight = 120}
    end
    worldGroup:insert(pTable)
end

createConfirmBox = function ( row )
    currentBox = b.confirmBox(row)
    currentBox.width = u.sceneW - backBtn.width*2.2
    currentBox.x = pTable.width/2
    currentBox.y = 120 + currentBox.height
    currentBox.newH = 40
    currentBox:toFront( )

    local confirmBtn = b.normal(40,20,"Confirm",onConfirm)
    confirmBtn.x = confirmBtn.width
    confirmBtn.y = 0
    confirmBtn.id = "confirm"
    confirmBtn:toFront( )

    local cancelBtn = b.normal(40,20,"Cancel",onConfirm)
    cancelBtn.x = -cancelBtn.width
    cancelBtn.y = 0
    cancelBtn.id = "cancel"
    cancelBtn:toFront( )

    currentBox:insert( confirmBtn )
    currentBox:insert( cancelBtn )
end

removeConfirmBox = function (  )
    local box = currentBox
    function remove(  )
        if (box ~= nil) then
            box:removeSelf( )
        end
    end
    local close = transition.to( box, {time=200, height=1, onComplete = remove} )
end

createSlider = function ( x,y,id )
    local sldr = b.slider(u.sceneW - 100, 20, id, onSlider)
    sldr.x = x
    sldr.y = y
    worldGroup:insert(sldr)
    return sldr
end

onNavButton = function ( event )
    local btn = event.target
    if (event.phase == "began") then
        if (btn.id == "back") then
            changeScene("mainScene", "slideRight")    
        end
    end
end

createPolicyBtn = function ( txt )
    local btn = b.policyBtn(txt, onPolicyBtn)
    return btn
end

createPolicyText = function ( txt )
    local txt = display.newText({
        text = txt,
        font = native.systemFont,
        fontSize = 10,
        align = "center",
        })
    txt:setFillColor( 245 /255, 215 /255, 110 /255 )
    return txt
end

onRowRender = function ( event )
    local row = event.row
    row:toBack( )
    --local rowHeight = 200
    local rowWidth = pTable.width

    local rowTitle = display.newText( row, policies[row.index].name, 0, 0, nil, 14 )
    rowTitle.x = rowWidth / 2
    rowTitle.y = 15
    rowTitle:setFillColor( 0 )
    
    local rowThird = row.width/3
    local currentBtns = {}
    for i=1,3 do
        local btn = createPolicyBtn("test "..i)
        btn.x = rowThird * i - (rowThird/2)
        btn.y = row.height - 60
        btn.num = i
        btn.index = row.index
        btn.row = row
        row:insert(btn)
        currentBtns[i] = btn

        local txt = createPolicyText(policies[row.index]["o"..i])
        txt.x = btn.x
        txt.y = btn.y + 20
        row:insert( txt )
    end
    policyBtns[row.index] = currentBtns
end

addPolicy = function (  )
    print( "Policy: "..currentPolicy.name )
    local effect = "e"..currentPolicy.effect
    print( currentPolicy[effect].health )
    d.turnPolicies[#d.turnPolicies + 1] = currentPolicy
    d.turnBudget = d.turnBudget + currentPolicy[effect].budget
    print( "Budget: "..d.turnBudget )
    print( "Policies: "..#d.turnPolicies )
end

onPolicyBtn = function ( event )
    local btn = event.target
    local t = policyBtns[btn.index]
    if (event.phase == "began") then
        for i=1,#policyBtns[btn.index] do    
            for j=1,#t do
                t[j]:setFillColor( 1,0,0,0.1 )
            end
        end
        removeConfirmBox()
    elseif (event.phase == "ended") then  
        currentPolicy = policies[btn.index]
        currentPolicy.effect = btn.num
        btn:setFillColor( 0,1,0 )
        createConfirmBox(btn.row)
    end
end

onConfirm = function ( event )
    local btn = event.target
    if (event.phase == "began") then
        if (btn.id == "confirm") then
            addPolicy()
            removeConfirmBox()
            currentBox = nil
        else
            removeConfirmBox()
            currentBox = nil
        end
    end
end
function deepPrint (e)
    -- if e is a table, we should iterate over its elements
    if type(e) == "table" then
        for k,v in pairs(e) do -- for every element in the table
            print(k)
            deepPrint(v)       -- recursively repeat the same procedure
        end
    else -- if not, we can just print it
        print(e)
    end
end
onSegment = function ( event )
    local sgmnt = event.target
    if (sgmnt.segmentNumber == 1) then
        
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
    boxGroup = display.newGroup( )
    -- Code here runs when the scene is first created but has not yet appeared on screen
    setup()
    addNavButton()
    createTable()
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