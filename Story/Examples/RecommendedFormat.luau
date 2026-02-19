local Types = require(script.Parent.Types)

local SubStories = {
	WhoAreYou = {
		{Name = "<user>"},
		{Text = "Who are you..?"}, 

		{Name = "Bob"},
		{Text = "Im Bob."},
		
		{Tag = {Require = {["KnownBob"] = nil}}},
		{Text = "Do you not know me?"},
		
		{Tag = {Require = {["KnownBob"] = true}}},
		{Name = "<user>"},
		{Text = "BOB?!"},
		{Text = "You've changed a lot since our last meeting.."},
	} :: Types.StoryObject,

	GetOut = {
		{Name = "<user>"},
		{Text = "Get out of here."},

		{Name = "<unknown>"},
		{Text = "How dare you say that?! Unworthy <user>!!"},
		{Text = "*You got sliced in half, loser.*"},
		{Event = "Death"},
		{Break = true}
	} :: Types.StoryObject,
}


return {
	{Name = "<unknown>"},
	{Text = "Hey you."},

	{Name = "<user>"},
	{Text = "Huh? What's going on?"},
	{
		Options = {
			{Story = SubStories.WhoAreYou, Id = "WhoAreYou", Text = "Who are you?"}, -- "Story" is basically the table we are referencing, it will run as usual, it will not override any local variables (E.g. Name or RequiredOptions) 
			{Story = SubStories.GetOut, Id = "GetOut", Text = "Get him out."},
		}, 
		Text = "..."
	}, 
} :: Types.StoryObject
