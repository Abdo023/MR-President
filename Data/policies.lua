local P = {}


P.policies = {
	{name = "Free Education", money=-200000, safety=5, edu=8, wealth=2},
	{name = "Closed Borders", money=-50000, safety=5, edu=1, wealth=-1},
	{name = "Gun Control", money=-200000, safety=8, edu=0, wealth=1},
	{name = "Mandatory Recycling", money=-20000, safety=2, edu=1, wealth=0},
	{name = "Free  Public Transportation", money=-200000, safety=4, edu=1, wealth=1},
}

--[[
P.policies = {
	{name="Education Policy",o1="Free",o2="Moderate",o3="Private",
	e1={employment=50, edu=5, education=15, wealth=10, freedom = 50, budget=500},
	e2={employment=50, edu=0, education=15, wealth=10, freedom = 50, budget=500},
	e3={employment=50, edu=10, education=15, wealth=10, freedom = 50, budget=500}
	},
	{name="educare Policy",o1="Free",o2="Moderate",o3="Private",
	e1={employment=50, edu=10, education=15, wealth=10, freedom = 50, budget=500},
	e2={employment=50, edu=10, education=15, wealth=10, freedom = 50, budget=500},
	e3={employment=50, edu=10, education=15, wealth=10, freedom = 50, budget=500}
	},
}
]]
return P