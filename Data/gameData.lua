local D = {}

D.month = 0
D.totalMonth = 12
D.money = 1000000
D.monthTaxMoney = 0
D.monthPolicyMoney =0

D.pop = 0
D.monthPop = 0
D.monthTaxPop = 0
D.monthPolicyPop = 0

D.safety = 50
D.edu = 50
D.wealth = 50

D.monthSafety = 0
D.monthEdu = 0
D.monthWealth = 0

D.action = 0

--D.factions = {cap = 50, env = 50, soc = 50, lib = 50, con = 50, fem=50}
D.stats = {employment=50, health=10, education=15, wealth=10, freedom = 50}

D.getPopularity = function (  )
	local avrg
	local sum = 0
	local num = 0
	
	for k,v in pairs(D.stats) do
		sum = sum + v
		num = num + 1
	end
	avrg = sum / num

	return avrg
end


return D