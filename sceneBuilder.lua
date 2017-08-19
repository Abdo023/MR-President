local S = {}

function S.collection( parent, columns )
    local scroll = UI.scroll()
    local width = 0
    if (columns>2) then
        width = U.sW/3 - 20
    else
        width = U.sW/2 - 20
    end
    scroll.btns = {}
    local newX = width+20
    function scroll.addItems( t, func )
        for i=1,#t do
            for x=1,columns do -- x pos based on columns
                local btn = UI.normalBtn(width, width*0.5, t[i], func)
                btn.x = (newX*x) - (newX/2)
                btn.y = btn.height * i
                btn.id = t.id
                parent:insert( btn )
                scroll.btns[#scroll.btns+1] = btn
            end
        end
    end

    return scroll
end

function S.tutorial( parent, txt )
    local group = display.newGroup( )
    parent:insert(group)
    local rect = display.newRect( group, U.cX, U.cY, U.sW - 100, U.sH*0.5 )
    rect.strokeWidth = 3
    rect:setFillColor( 0,0,0 )
    local txtOptions = {
        parent = group,
        text = txt,   
        width = 600,
        height = 500,
        font = native.systemFont,   
        fontSize = 30,
        align = "left"
    }

    local txt = display.newText( txtOptions )
    txt.x = U.cX
    txt.y = U.cY
    group.txt = txt
    local btn = UI.normalBtn(100, 50, "OK", function() group.isVisible=false end)
    btn.x = U.cX
    btn.y = txt.y + txt.height*0.5 + 50
    btn:setFillColor(1,1,1)
    group:insert( btn )
    
    return group
end

function S.popUp( parent, txt, func )
    local group = display.newGroup( )
    parent:insert(group)

    local rect = display.newRect( group, U.cX, U.cY, 300, 300 )
    rect:setFillColor(0,0,0)
    rect.strokeWidth = 2

    local txt = UI.normalTxt(group, txt, 30)
    txt.x = U.cX
    txt.y = U.cY

    local btn = UI.normalBtn(100, 25, "Next Job", func)
    btn.x = U.cX
    btn.y = rect.y + rect.height*0.5 - btn.height
    group:insert(btn)

    return group
end

function S.backBtn( txt, scene )
    local composer = require( "composer")
    local function gotoScene(  )
        composer.gotoScene( scene , "slideRight" )
    end

    local btn = UI.normalBtn(310, 100, txt, gotoScene)
    --btn._view._label.size = 20  -- None documented property
    return btn
end

function S.statLabel( parent,lTxt,rTxt )
    local group = display.newGroup( )
    parent:insert(group)

    local barGroup = UI.bar(0,0,400)
    barGroup.x = U.cX - barGroup.frame.width*0.5
    group.bar = barGroup.bar
    group:insert( barGroup )

    local txtOptions = {
        parent = group,
        text = "",
        --width = 100,
        --height = 300,
        font = native.systemFont,   
        fontSize = 25,
        align = "center"
    }
    local xOffset = 100
    local leftTxt = display.newText( txtOptions )
    leftTxt:setFillColor( 0, 0, 0 )
    leftTxt.text = lTxt
    leftTxt.x = U.cX - barGroup.frame.width*0.5 - xOffset
    --leftTxt.y = 200
    group.leftTxt = leftTxt
    group:insert( leftTxt )

    local rightTxt = display.newText( txtOptions )
    rightTxt:setFillColor( 0, 0, 0 )
    rightTxt.text = rTxt
    rightTxt.x = U.cX + barGroup.frame.width*0.5 + xOffset
    group.rightTxt = rightTxt
    group:insert( rightTxt )

    return group
end

function S.statGroup( parent )
    local group = display.newGroup( )
    parent:insert( group )

    local yOffset = 100
    --local safetyGroup = S.statLabel(group, "Crime", "Safety")
    local safetyGroup = S.statLabel(group, "Safety", "")
    safetyGroup.y = U.cY + yOffset
    group.safetyBar = safetyGroup.bar

    --local eduGroup = S.statLabel(group, "Ignorance", "Education")
    local eduGroup = S.statLabel(group, "Education", "")
    eduGroup.y = safetyGroup.y + yOffset
    group.eduBar = eduGroup.bar

    --local wealthGroup = S.statLabel(group, "Poverty", "Wealth")
    local wealthGroup = S.statLabel(group, "Wealth", "")
    wealthGroup.y = eduGroup.y + yOffset
    group.wealthGroup = wealthGroup.bar

    return group    
end

function S.eventGroup( parent, func )
    local group = display.newGroup( )
    parent:insert( group )

    local xOffset = 150
    local yOffset = 50

    local titleTxt = UI.normalTxt(group, "txt", 30)
    titleTxt.x = U.cX
    titleTxt.y = titleTxt.height + yOffset + 100
    group.titleTxt = titleTxt

    local eventTxt = UI.normalTxt(group, "txt", 30)
    eventTxt.x = U.cX
    eventTxt.y = titleTxt.y + eventTxt.height + yOffset + 50
    group.eventTxt = eventTxt

    local btn1 = UI.normalBtn(150, 50, "txt", func)
    btn1.x = U.cX - xOffset
    btn1.y = eventTxt.y + btn1.height + yOffset
    btn1.id = "btn1"
    group.btn1 = btn1
    group:insert( btn1 )

    local btn2 = UI.normalBtn(150, 50, "txt", func)
    btn2.x = U.cX + xOffset
    btn2.y = eventTxt.y + btn2.height + yOffset
    btn2.id = "btn2"
    group.btn2 = btn2
    group:insert( btn2 )

    local moneyEffectTxt = UI.normalTxt(group, "txt", 30)
    moneyEffectTxt.x = U.cX
    moneyEffectTxt.y = btn1.y + moneyEffectTxt.height + yOffset
    moneyEffectTxt.isVisible = false
    group.moneyEffectTxt = moneyEffectTxt

    local popEffectTxt = UI.normalTxt(group, "txt", 30)
    popEffectTxt.x = U.cX
    popEffectTxt.y = moneyEffectTxt.y + popEffectTxt.height + yOffset
    popEffectTxt.isVisible = false
    group.popEffectTxt = popEffectTxt

    local safetyEffectTxt = UI.normalTxt(group, "txt", 30)
    safetyEffectTxt.x = U.cX
    safetyEffectTxt.y = moneyEffectTxt.y + popEffectTxt.height + yOffset
    safetyEffectTxt.isVisible = false
    group.safetyEffectTxt = safetyEffectTxt

    local healthEffectTxt = UI.normalTxt(group, "txt", 30)
    healthEffectTxt.x = U.cX
    healthEffectTxt.y = moneyEffectTxt.y + popEffectTxt.height + yOffset
    healthEffectTxt.isVisible = false
    group.healthEffectTxt = healthEffectTxt

    local popEffectTxt = UI.normalTxt(group, "txt", 30)
    popEffectTxt.x = U.cX
    popEffectTxt.y = moneyEffectTxt.y + popEffectTxt.height + yOffset
    popEffectTxt.isVisible = false
    group.popEffectTxt = popEffectTxt

    local confirmBtn = UI.normalBtn(200, 50, "Confirm", func)
    confirmBtn.x = U.cX 
    confirmBtn.y = popEffectTxt.y + confirmBtn.height + yOffset
    confirmBtn.id = "confirmBtn"
    group.confirmBtn = confirmBtn
    confirmBtn.isVisible = false
    group:insert( confirmBtn )

    function group.setTxt( title,event,b1,b2 )
        titleTxt.text = title
        eventTxt.text = event
        btn1:setLabel( b1 )
        btn2:setLabel( b2 )
    end

    function group.setEffectTxt( money,pop )
        moneyEffectTxt.text = "Money: "..money
        popEffectTxt.text = "Popularity: "..pop
        moneyEffectTxt.isVisible = true
        popEffectTxt.isVisible = true
        --confirmBtn.isVisible = true  -- handled in scene itself
    end

    return group

end

function S.valuesGroup( parent, height )
    local group = display.newGroup( )
    --container.anchorChildren = false   -- Default is false
    parent:insert( group )

    group.values = {}  -- in order to add building values each day, accessed from buildingScene

    -- Rect is for positioning purposes
    local rect = display.newRect( group, U.cX, group.height*.5, U.sW, height )
    rect:setFillColor( 0,0,1,1 )
    group.rect = rect

    local txtOptions = {
        parent = group,
        text = "Txt: ",     
        --width = 200,
        --height = 50,
        font = native.systemFont,   
        fontSize = 30,
        align = "left"
    }


    --container:insert( img )
    local offset = 100

    local moneyTxt = display.newText( txtOptions)
    moneyTxt.x = moneyTxt.width + offset
    moneyTxt.y = moneyTxt.height*0.5
    --moneyTxt:setFillColor( 1, 0, 0 )
    group.moneyTxt = moneyTxt

    local monthTxt = display.newText( txtOptions)
    monthTxt.x = U.sW - monthTxt.width - offset 
    monthTxt.y = monthTxt.height*0.5
    --moneyTxt:setFillColor( 1, 0, 0 )
    group.monthTxt = monthTxt

    local popTxt = display.newText( txtOptions)
    popTxt.x = popTxt.width + offset 
    popTxt.y = moneyTxt.height + popTxt.height
    popTxt.text = "Popularity:"
    --moneyTxt:setFillColor( 1, 0, 0 )
    group.popTxt = popTxt

    local popGroup = UI.bar(popTxt.width*2 - 40, popTxt.y, U.sW*0.5)
    popGroup.bar.width = 0
    group.popBar = popGroup.bar
    group.popBar.mV = 100
    group:insert (popGroup)

    local popValueTxt = display.newText( txtOptions)
    popValueTxt.x = U.sW - popValueTxt.width
    popValueTxt.y = moneyTxt.height + popValueTxt.height
    popValueTxt.text = "50%"
    --moneyTxt:setFillColor( 1, 0, 0 )
    group.popValueTxt = popValueTxt

    --Access from masterScene & Functions
    function group.setTxt( money,month,pop )
        moneyTxt.text = "Money: "..money
        monthTxt.text = "Month: "..month
        popValueTxt.text = pop.."%"
    end

    return group
end




return S