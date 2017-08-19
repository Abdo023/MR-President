local T = {}

T.taxes = {
	{name = "Gas Tax", money=10000, safety=5, edu=0, wealth=-5},
	{name = "Income Tax", money=30000, safety=0, edu=-1, wealth=-10},
	{name = "Property Tax", money=15000, safety=0, edu=0, wealth=-2},
	{name = "Sales Tax", money=10000, safety=0, edu=-1, wealth=-2},
	{name = "Soda Tax", money=10000, safety=3, edu=0, wealth=-1},
	{name = "Capital Gain Tax", money=10000, safety=0, edu=0, wealth=-1},
	{name = "Estate Tax", money=5000, safety=5, edu=0, wealth=-1},
}

T.activated = {}
--[[
T.taxes = {
	{Title = "Gas Tax", cap=10,soc=-10,con=0,lib=-5, budget = 1000},
	{Title = "Income Tax", cap=10,soc=-10,con=0,lib=-5, budget = 3000},
	{Title = "Property Tax", cap=10,soc=-10,con=0,lib=-5, budget = 5000},
	{Title = "Sales Tax", cap=10,soc=-10,con=0,lib=-5, budget = 1000},
	{Title = "Soda Tax", cap=10,soc=-10,con=0,lib=-5, budget = 3000},
	{Title = "Capital Gain Tax", cap=10,soc=-10,con=0,lib=-5, budget = 5000},
	{Title = "Estate Tax", cap=10,soc=-10,con=0,lib=-5, budget = 3000},
	{Title = "Tobacco Tax", cap=10,soc=-10,con=0,lib=-5, budget = 3000}
}
]]
return T