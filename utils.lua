-----------------------------------------------------------------------------------------
--
-- utils.lua
--
-----------------------------------------------------------------------------------------
local U = {}

U.mSqrt = math.sqrt
U.mRand = math.random
U.mRound = math.round

 U.cX  = display.contentCenterX
 U.cY  = display.contentCenterY

 U.sW   = display.actualContentWidth
 U.sH    = display.actualContentHeight
 U.left     = U.cX - U.sW * 0.5
 U.right    = U.cX + U.sW * 0.5
 U.top      = U.cY - U.sH * 0.5
 U.bottom   = U.cY + U.sH * 0.5

U.getDistance = function ( obj1, obj2 )
	local factor = {
		x = obj2.x - obj1.x,
		y = obj2.y - obj1.y
	}
	return mSqrt((factor.x * factor.x) + (factor.y * factor.y))
end

U.getYDistance = function ( y1, y2 )
	local factor = {
		y = y2 - y1
	}
	return mSqrt(factor.y * factor.y)
end

function U.checkIntersection(obj1, obj2)
    if obj1 == nil then
    	print( "Obj1 = nil" )
        return false
    end
    if obj2 == nil then
    	print( "Obj2 = nil" )
        return false
    end
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax 
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax 
    return (left or right) and (up or down) 
end 

function U.checkIntersectionCircle( obj1, obj2 )
    if ( obj1 == nil ) then  -- Make sure the first object exists
    	print( "Obj1 = nil" )
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
    	print( "Obj2 = nil" )
        return false
    end

    local dx = obj1.x - obj2.x
    local dy = obj1.y - obj2.y

    local distance = U.mSqrt( dx*dx + dy*dy )
    local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)

    if ( distance < objectSize ) then
        return true
    end
    return false
end

U.getRandom = function ( x, y )			
	local v1, v2 = x, y
	local r = mRand(0, 1)
	if (r == 1) then
		return v1
	else
		return v2
	end
end

return U