local Types = require(script.Parent.Types)

-- Notice that Story is completely linear, which means it doesnt "jump" through steps, just iterates through all of them and checks their requirements.
-- And yes, each member of "StoryObject" will be referenced as "step".

return {
	{Name = "<unknown>",Text = "Hey you."}, 
	
	{Name = "<user>"}, -- all strings are parsed with keywords. No text and no options = skips callback function but runs if requirements met.
	{Text = "Huh? What's going on?"}, -- Remembers last used Name
	{Options = {["Get out of here"] = "GetOut", ["Who are you..?"] = "WhoAreYou"}, Text = "..."},  -- EZ type of option, look through examples for advanced one.
	----------------------------------
	{RequiredOptions = {"GetOut"}},	 -- Option ID												--]
	{Name = "<user>", Text = "Get out of here."},	 -- Remembers last RequiredOptions			--]
	{Name = "<unknown>"}, -- Rewrites Name. 													--] -- Completely skips if required option wasnt chosen
	{Text = "How dare you say that?! Unworthy <user>!!"},										--]
	{Text = "*You got sliced in half.*"},														--]
	{Event = "Death"},				  -- Remembers last RequiredOptions							--]
	----------------------------------
	{RequiredOptions = {"WhoAreYou"}}, -- Option ID, Overrides last RequiredOptions.
	{Name = "<user>",Text = "Who are you..?"},
	{Name = "Bob"},
	{Text = "Im Bob."},
	{Text = "Do you not know me?"},
} :: Types.StoryObject -- adds autocomplete stuff.
