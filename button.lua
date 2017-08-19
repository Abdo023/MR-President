local B = {}
local widget = require( "widget" )
local u = require( "utils" )

function B.circleButton( txt, func )
	local btn = widget.newButton( {
		shape = "circle",
        radius = "22",
        label = txt,
        labelColor = { default={ 229 /255, 8 /255, 8 /255 }, over={ 0, 0, 0, 0.5 } },
        fontSize = 12,
        strokeColor = { default={1,0.4,0,1}, over={0.2,0.2,1,1} },
        strokeWidth = 2,
        fillColor = { default={1,0,0,0.1}, over={1,1,1,0.3} },
        onPress = func
	} )
	return btn
end

function B.navButton( txt, func )
	 local btn = widget.newButton( {
        shape = "rect",
        width = 40,
        height = u.sceneH,
        label = txt,
        labelColor = { default={ 229 /255, 8 /255, 8 /255 }, over={ 0, 0, 0, 0.5 } },
        fontSize = 15,
        strokeColor = { default={65 /255, 131 /255, 215 /255}, over={0.2,0.2,1,1} },
        strokeWidth = 2,
        fillColor = { default={89 /255, 171 /255, 227 /255}, over={1,1,1,0.3} },
        onPress = func
    } )
    return btn
end

function B.scroll(  )
	local scrl = widget.newScrollView( {
		backgroundColor = { 34 /255, 49 /255, 63 /255 },
        width = u.sceneW/4,
        height = u.sceneH,
        scrollWidth = u.sceneW/4,
        horizontalScrollDisabled = true,
        leftPadding = 50,
        topPadding = 2
	} )
	return scrl	
end

function B.normal( width,height,txt,func )
	local nrml = widget.newButton( {
        shape = "roundedRect",
        width = width,
        height = height,
        label = txt,
        font = native.systemFont,
        labelColor = { default={ 255 /255, 255 /255, 255 /255 }, over={ 0, 0, 0, 0.5 } },
        fontSize = 12,
        strokeColor = { default={211 /255, 84 /255, 0 /255}, over={0.2,0.2,1,1} },
        strokeWidth = 1,
        fillColor = { default={211 /255, 84 /255, 0 /255, 0.1}, over={1,1,1,0.3} },
        --emboss = true,
        onPress = func
	} )
	return nrml
end

function B.descText( group, width, height )
 	local txt = display.newText({  
 		parent = group,
	 	text = "test",     
	    x = 0,
	    y = 0,
	    width = width,
	    height = height,
	    font = native.systemFontBold,   
	    fontSize = 12,
	    align = "left" 
    }) 
    txt:setFillColor( 1,1,1 )
 	return txt
 end 

 function B.factionText( group )
 	local txt = display.newText({  
 		parent = group,
	 	text = "test",     
	    x = 0,
	    y = 0,
	    font = native.systemFont,   
	    fontSize = 14,
	    align = "left" 
    }) 
    txt:setFillColor( 245 /255, 215 /255, 110 /255 )
 	return txt
 end

function B.policyBtn( txt,func )
    local btn = widget.newButton( {
        shape = "circle",
        radius = "12",
        labelColor = { default={ 229 /255, 8 /255, 8 /255 }, over={ 0, 1, 0, 1 } },
        strokeColor = { default={0,1,0,1}, over={0,1,0,1} },
        --strokeWidth = 1,
        fillColor = { default={1,0,0,0.1}, over={0,1,0,1} },
        onEvent = func
    } )
    return btn
end

function B.confirmBox( parent )
    local box1 = display.newRoundedRect( parent, 0, 0, 200, 50, 5 )
    local box = display.newContainer( parent, 0, 0 )
    box1:setFillColor( 129 /255, 207 /255, 224 /255 )
    box.anchorY = 0
    --box.anchorChildren = false
    box.newH = 40
    box:insert( box1 )
    local open = transition.to( box, {time=500,height = box.newH} )
    return box
end

 function B.segment( id,t,func )
     local sgmnt = widget.newSegmentedControl( {
        width = u.sceneW - 100,
        height = 20,
        id = id,
        segmentWidth = 70,
        segments = t,
        onPress = func
    } )
     return sgmnt
 end

 function B.slider( width,height,id,value,func )
    local sldr = widget.newSlider( {
        width = width,
        height = height,
        id = id,
        value = value,
        listener = func
    } )     
    return sldr
 end





return B