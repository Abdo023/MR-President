local A = {}


function A.scaleUp( obj, time )
	local oSize = obj.size
	local function scaleD(  )
		transition.to( obj, {xScale=1, yScale=1, time=time} )
	end

	local function scaleU(  )
		transition.to( obj, {xScale=2, yScale=2, time=time, onComplete=scaleD} )
	end
	scaleU()
end

function A.scaleDown( obj, time )
	local oSize = obj.size

	local function scaleU(  )
		transition.to( obj, {xScale=1, yScale=1, time=time} )
	end

	local function scaleD(  )
		transition.to( obj, {xScale=0.5, yScale=0.5, time=time, onComplete=scaleU} )
	end

	scaleD()
end

function A.shakeRight( obj, time )
	local oX = obj.x

	local function shakeBack(  )
		transition.to(obj, {x=oX, rotation=0, time=time})
	end

	local function shake(  )
		transition.to(obj, {x=obj.x + 100, rotation=45, time=time, onComplete=shakeBack})
	end
	shake()
end

function A.dragUp( obj, y, time )
	local options = {
		y=y,
		time=time
	}
 	transition.to( obj, options )
 end 


function A.slideAnim( obj, dir, time )
	
	function left( ... )
		local x
		if (obj.x > 0) then
			x = 0
		else
			x= -u.sW
		end

		local options = {
		
			x=x,
			time= time,
		}
		transition.to (obj, options)
	end

	function right(  )
		local x
		if (obj.x < 0) then
			x = 0
		else
			x= u.sW 
		end

		local options = {
			x= x,
			time= time,
		}
		transition.to (obj, options)
	end

	if (dir == "right") then
		right()
	else
		left()
	end
end

return A