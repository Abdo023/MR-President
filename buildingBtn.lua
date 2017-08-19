local B = {}

function B.btn( width,height,func )
	local btn = Widget.newButton( {
        shape = "roundedRect",
        width = width,
        height = height,
        label = txt,
        labelAlign = "left",
        font = native.systemFont,
        labelColor = { default={ 255 /255, 255 /255, 255 /255 }, over={ 0, 0, 0, 0.5 } },
        fontSize = 32,
        strokeColor = { default={211 /255, 84 /255, 0 /255}, over={0.2,0.2,1,1} },
        strokeWidth = 2,
        --fillColor = { default={211 /255, 84 /255, 0 /255, 0.1}, over={1,1,1,0.3} },
        --emboss = true,
        onEvent = func
	} )
	return btn
end

function B.createBuildingBtn( parent, func )
	local width = U.sW/3
	local btn = B.btn (U.sW-40, 250, func)
	btn.id = 1
	btn.activated = false  -- In order to start generating
	local barGroup = UI.bar(10, btn.height - 20, btn.width - 20)

	btn.barGroup = barGroup
	btn.bar = barGroup.bar
	btn:insert( barGroup )

	local textOptions = {
        parent = btn,
        text = "txt: ",     
        --width = 300,
        font = native.systemFont,   
        fontSize = 20,
        align = "center"
    }
    local xOffset = 40
    local yOffset = 50

	local nameTxt = display.newText( textOptions )
	nameTxt.x = btn.width*0.5 
	nameTxt.y = yOffset
    nameTxt:setFillColor( 0, 0, 0 )
    nameTxt.size = 45
	btn.nameTxt = nameTxt

	local moneyTxt = display.newText( textOptions )
	moneyTxt.x = btn.width*0.5
	moneyTxt.y = nameTxt.y + moneyTxt.height + yOffset
    moneyTxt:setFillColor( 0, 0, 0 )
	btn.moneyTxt = moneyTxt

    local safetyTxt = display.newText( textOptions )
    safetyTxt.x = safetyTxt.width + xOffset
    safetyTxt.y = moneyTxt.y + safetyTxt.height + yOffset
    safetyTxt:setFillColor( 0, 0, 0 )
    btn.safetyTxt = safetyTxt

    local eduTxt = display.newText( textOptions )
    eduTxt.x = U.cX
    eduTxt.y = moneyTxt.y + eduTxt.height + yOffset
    eduTxt:setFillColor( 0, 0, 0 )
    btn.eduTxt = eduTxt

    local wealthTxt = display.newText( textOptions )
    wealthTxt.x = btn.width - wealthTxt.width - xOffset - 30
    wealthTxt.y = moneyTxt.y + wealthTxt.height + yOffset
    wealthTxt:setFillColor( 0, 0, 0 )
    btn.wealthTxt = wealthTxt

    function btn.setTxt( name,money,safety,edu,wealth )
        nameTxt.text =  name
        moneyTxt.text =  "Money: "..money.."/month"
        safetyTxt.text = "Safety: "..safety.."/month"
        eduTxt.text = "Education: "..edu.."/month"
        wealthTxt.text = "Wealth: "..wealth.."/month"
    end

	function btn.reset(  )
		btn.bar.width = 0
	end

	return btn
end

function B.btnsScroll ( dataTable, func )
    local scroll = UI.scroll()
    tempTable = dataTable
    local createdBtns = {}  -- Returns the created btns
    scroll.btns = createdBtns
    local x = U.cX
    local offset = 10
    
    for i=1, #tempTable do
        local btn = B.createBuildingBtn (scroll, func)
        btn.setTxt(tempTable[i].name, tempTable[i].money, tempTable[i].safety, tempTable[i].edu, tempTable[i].wealth)
        btn.id = i -- for accessing the data table later

        btn.x = U.cX
        btn.y = i * btn.height + offset
        btn:setFillColor( 211 /255, 84 /255, 0 /255, 0.1 )
        btn.bar.width = 0
        -- Starting them not shown until player unlocks the btn
        --btn.barGroup.isVisible = false

        scroll:insert( btn )
        offset = offset + 20

        createdBtns[#createdBtns+1] = btn

        
    end



    return scroll
end


return B