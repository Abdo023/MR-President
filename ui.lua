
-- Responsible for creating UI elements in the entire game

local UI = {}
local widget = require( "widget" )

-- To hold building btns
function UI.scroll(  )
	local scrl = widget.newScrollView( {
		--backgroundColor = { 34 /255, 49 /255, 63 /255 },
        backgroundColor = { 1,1,1 },
        width = U.sW,
        height = U.sH-100 ,
        --scrollWidth = u.sceneW/4,
        horizontalScrollDisabled = true,
        --leftPadding = 0,
        --topPadding = 2
	} )
	return scrl
end

function UI.normalTxt( parent, txt, fontSize )
    local textOptions = {
        parent = parent,
        text = txt,    
        width = U.sW-100,
        font = native.systemFont,   
        fontSize = fontSize,
        align = "center"
    }
    local txt = display.newText( textOptions )
    txt:setFillColor( 0, 0, 0 )
    return txt
end

function UI.normalBtn( width,height,txt,func )
	local btn = widget.newButton( {
        shape = "roundedRect",
        width = width,
        height = height,
        label = txt,
        labelAlign = "center",
        font = native.systemFont,
        labelColor = { default={ 0,0,0 }, over={ 0, 0, 0, 0.5 } },
        fontSize = 25,
        strokeColor = { default={211 /255, 84 /255, 0 /255}, over={0.2,0.2,1,1} },
        strokeWidth = 2,
        fillColor = { default={211 /255, 84 /255, 0 /255, 0.1}, over={1,1,1,0.3} },
        --emboss = true,
        onRelease = func
	} )
	return btn
end

-- The building generatig bar
function UI.bar( x, y, width )
    local group = display.newGroup( )
    local height = 10
    local frame = display.newRect(group, x, y, width, height)
    frame:setFillColor( 0,0,0 )
    frame.anchorX = 0
    --frame.x = x
    frame.strokeWidth = 2

    local bar = display.newRect( group, frame.x, frame.y, width*0.5, height )
    bar:setFillColor( 0,1,0 )
    bar.anchorX = 0
    bar.oWidth = frame.width
    bar.mV = 100
    bar.frame = frame

    group.bar = bar
    group.frame = frame

    return group
end

function UI.vBar( x, y, height )
    local group = display.newGroup( )
    local width = 50
    local frame = display.newRect(group, x, y, width, height)
    frame:setFillColor( 1,1,1 )
    frame.anchorY = 1
    --frame.x = x
    frame.strokeWidth = 2

    local bar = display.newRect( group, frame.x, frame.y, width, height*0.5 )
    bar:setFillColor( 0,1,0 )
    bar.anchorY = 1
    bar.oHeight = frame.height
    bar.frame = frame

    bar.cV = 0

    group.bar = bar
    group.frame = frame

    return group
end

function UI.checkvBarValue( bar )
    if (bar.height >= bar.oHeight) then
        bar.height = bar.oHeight
        bar.cV = 0
        return true
    else
        return false
    end
end

function UI.editBar( bar, value )
    if (bar == nil) then
        return
    end
	bar.cV = value
	bar.width = (bar.cV / bar.mV) * bar.oWidth
    --print("mV: "..bar.mV)
end

function UI.editVBar( bar, value )
    bar.cV = bar.cV + value
    bar.height = (bar.cV / bar.mV) * bar.oHeight
    --UI.checkvBarValue(bar)
    --print( "O Height: "..bar.oHeight )
    --print( "Bar: "..bar.height )
end



-- Money, Tech, Army top labels
function UI.statLabel( txt )
	local textOptions = {
        --parent = sceneGroup,
        text = txt..": 0",     
        width = 200,
        font = native.systemFont,   
        fontSize = 30,
        align = "center"
    }
    local label = display.newText( textOptions )
    label:setFillColor( 0,0,0 )
    return label
end

function UI.tabBar( func )
    local width = U.sW/4
	local tabButtons = {
    {
        label = "Office",
        id = "officeScene",
        width = width, 
        height = 120,
        size = 30,
        selected = true,
        onPress = func
    },
    {
        label = "Taxes",
        id = "taxScene",
        width = width, 
        height = 120,
        size = 30,
        onPress = func
    },
    {
        label = "Policies",
        id = "policyScene",
        width = width, 
        height = 120,
        size = 30,
        onPress = func
    },
    --[[
    {
        label = "Economy",
        id = "economyScene",
        width = width, 
        height = 120,
        size = 30,
        onPress = func
    }
    ]]
    }
    
    local tabBar = widget.newTabBar( {
        top = U.sH - 100,
        width = U.sW,
        height = 100,
        buttons = tabButtons
    } )
    return tabBar
end

-- Collection View
function UI.collectionBtn( width,height,txt,func )
    local btn = Widget.newButton( {
        shape = "roundedRect",
        width = width,
        height = height,
        label = txt,
        labelAlign = "center",
        labelYOffset = -50,
        font = native.systemFont,
        labelColor = { default={ 255 /255, 255 /255, 255 /255 }, over={ 0, 0, 0, 0.5 } },
        fontSize = 32,
        strokeColor = { default={211 /255, 84 /255, 0 /255}, over={0.2,0.2,1,1} },
        strokeWidth = 2,
        fillColor = { default={211 /255, 84 /255, 0 /255, 0.1}, over={1,1,1,0.3} },
        --emboss = true,
        onRelease = func
    } )

    local txtOptions = {
        parent = btn,
        text = "",     
        width = 150,
        font = native.systemFont,   
        fontSize = 20,
        align = "left"
    }
    local leftTxt = display.newText( txtOptions)
    leftTxt.x = leftTxt.width
    leftTxt.y = btn.height - leftTxt.height - 50
    btn.leftTxt = leftTxt

    local rightTxt = display.newText( txtOptions)
    rightTxt.x = btn.width*0.5 + (rightTxt.width*0.5)
    rightTxt.y = btn.height - rightTxt.height - 50
    btn.rightTxt = rightTxt

    return btn
end

function UI.collection( parent, columns )
    local scroll = UI.scroll()
    parent:insert( scroll)
    local width = 0
    if (columns>2) then
        width = U.sW/3 - 20
    else
        width = U.sW/2 - 20
    end
    scroll.btns = {}

    function scroll.addItems( t, actions, func )
        local newX = width+20
        local yOffset = 100
        local newY = yOffset
        local btnHeight = width*0.5
        local rows =  math.ceil( #t/2 ) 
        local columns = columns
        local id = 1

        local function createRow(  )
            for i=1,columns do
                if (t[id] == nil) then
                    return
                end
                local btn = UI.collectionBtn(width, btnHeight, "", func)
                btn.x = (newX*i) - (newX/2)  
                btn.y = newY
                btn.id = id      
                btn:setLabel( t[id] )
                btn.action = actions[id] 
                scroll.btns[#scroll.btns+1] = btn       
                scroll:insert( btn )
                id = id + 1
            end
        end

        for i=1,rows do
            createRow()
            newY = newY + btnHeight + yOffset
        end
    end

    function scroll.setTxt( t  )
        for i=1,#scroll.btns do
            if (t.title ~= nil) then
                scroll.btns[i]:setLabel(t.title[i] or "")
            end
            scroll.btns[i].leftTxt = "" or t.leftTxt[i] 
            scroll.btns[i].rightTxt = "" or t.rightTxt[i]
        end
    end

    function scroll.disable(  )
        for i=1,#scroll.btns do
            scroll.btns[i]:setEnabled (false)
        end
    end
    function scroll.enable(  )
        for i=1,#scroll.btns do
            scroll.btns[i]:setEnabled (true)
        end
    end

    return scroll
end




return UI