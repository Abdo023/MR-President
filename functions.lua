local F = {}

function F.addValue( v, amount )
    Data[v] = Data[v] + amount
end

function F.addValues( kind,money,safety,edu,wealth )
	if (kind == "tax") then
		F.addValue("monthTaxMoney", money)
	else
		F.addValue("monthPolicyMoney", money)
	end
	
    F.addValue("monthSafety", safety)
    F.addValue("monthEdu", edu)
    F.addValue("monthWealth", wealth)
end

function F.deductValue( v, amount )
    if (Data[v] < amount) then
    	print( "Not enough: "..v )
        return
    end
    Data[v] = Data[v] - amount
end

function F.deductValues( kind,money,safety,edu,wealth )
	if (kind == "tax") then
		F.deductValue("monthTaxMoney", money)
	else
		F.deductValue("monthPolicyMoney", money)
	end
    F.deductValue("monthSafety", safety)
    F.deductValue("monthEdu", edu)
    F.deductValue("monthWealth", wealth)
end

function F.compareValues( v,amount )
	if (Data[v] >= amount) then
		return true
	else
		return false
	end
end

function F.checkValue( v )
	if (Data[v] > 0) then
		return true
	else
		return false
	end
end

function F.activateTax( id )
	Taxes.activated[#Taxes.activated+1] = Taxes.taxes[id]
	--table.remove( Taxes.taxes[id] )
	print( "Activated "..Taxes.activated[1].name )
end

function F.randomiseStats(  )
	Data.safety = U.mRand(20, 80)
	Data.edu = U.mRand(20, 80)
	Data.wealth = U.mRand(20, 80)
	print( "Safety: "..Data.safety )
	print( "Edu: "..Data.edu )
	print( "Wealth: "..Data.wealth )
end

function F.setPopAvrg(  )
    local sum = Data.safety + Data.edu + Data.wealth
    local num = 3
    local avrg = sum / num

    --F.addValue("pop", avrg) 
    Data.pop = Data.monthPop + avrg
end

function F.checkStats(  )
	if(Data.safety > 100) then Data.safety=100 end
	if(Data.edu > 100) then Data.edu=100 end
	if(Data.wealth > 100) then Data.wealth=100 end
end

function F.nextMonth(  )
	Data.month = Data.month + 1
	Data.money = Data.money + Data.monthTaxMoney + Data.monthPolicyMoney
	--Data.pop = Data.pop + Data.monthTaxPop + Data.monthPolicyPop
	F.addValue("safety", Data.monthSafety)
	F.addValue("edu", Data.monthEdu)
	F.addValue("wealth", Data.monthWealth)
	Data.action = 1
	F.checkStats()
	F.setPopAvrg()
	print("Pop: "..Data.pop)
end

--UI

function F.updateLabels( safetyBar,eduBar,wealthBar )
	local stage = display.getCurrentStage( )
	local labels = stage.valuesLabels
	local bar = labels.popBar
	labels.setTxt(Data.money, Data.month, U.mRound(Data.pop) )
	UI.editBar(bar, Data.pop)
	UI.editBar(safetyBar, Data.safety)
	UI.editBar(eduBar, Data.edu)
	UI.editBar(wealthBar, Data.wealth)
end








return F