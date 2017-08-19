local E = {}


E.events = {
	{title="Event", id=1, desc="A hurricane is approaching one of our major cities, there is a 50-50 chance it might hit it. Should we pay 200,000$ to take precautions?", 
	action1={text="Ignore", money=0, pop=-5}, 
	action2={text="Pay", money=-200000, pop=5}},

	{title="Event", desc="A neighbour country accidentally killed one of our soldiers at the border in a training mission.\nWould you like to spend 350,000$ in a retaliation response, or use diplomatic solutions? ", 
	action1={text="Diplomacy", money=0, pop=-5}, 
	action2={text="Retaliate", money=-350000, pop=5}},

	{title="Event", id=2, desc="We have a large piece of land that is currently unused. A foreign country is offering to buy it in order to use it as a nuclear waste for 500000$ \nWhat should we do?", 
	action1={text="Sell", money=500000, pop=-10}, 
	action2={text="Decline", money=0, pop=10}},

	{title="Event", id=3, desc="A lot of taxi and bus drivers have gone on strike. They demand better work conditions and benefits", 
	action1={text="Accept", money=-500000, pop=5}, 
	action2={text="Decline", money=0, pop=-5}},

	{title="Event", id=4, desc="Our nation is years behind the competition whent it comes to scientific achievements. \n Your advisors suggest that we start a nation-wide contest for the best invetion based on science.", 
	action1={text="Accept", money=-200000, pop=5}, 
	action2={text="Decline", money=0, pop=-5}},

	{title="Event", id=5, desc="A group of immegrants have arrived at our shores. They are seeking political asylum. \nWhat would you like to do?", 
	action1={text="Grant", money=-200000, pop=5}, 
	action2={text="Refuse", money=0, pop=-5}},
}

E.completedEvents = {}

--[[
E.events = {
	{title="Title", desc="A hurricane is approaching one of our major cities, there is a 50-50 chance it might hit it. Should we pay 200,000$ to take precautions?", 
	action1={text="Ignore", employment=10,health=-10,education=0,wealth=5,freedom=10, budget=0}, action2={text="Pay", employment=10,health=-10,education=0,wealth=-5,freedom=10, budget=-200000}}
	,

	{title="Title", desc="A neighbour country accidentally killed one of our soldiers at the border in a training mission.\nWould you like to spend 350,000$ in a retaliation response, or use diplomatic solutions? ", 
	action1={text="Diplomacy",employment=10,health=-10,education=0,wealth=-5,freedom=10, budget=0}, action2={text="Retaliate",employment=10,health=-10,education=0,wealth=-5,freedom=10, budget=-350000}}
	,

	{title="Title", desc="We have a large piece of land that is currently unused, some people are proposing that we sell it to other countries to use it as a nuclear waste for 500M$ \nWhat should we do?, ", 
	action1={text="Sell",employment=10,health=-10,education=0,wealth=-5,freedom=10, budget=500000}, action2={text="Do nothing",employment=10,health=-10,education=0,wealth=-5,freedom=10, budget=0}}
}
]]
return E