local Types = require(script.Parent.Types)

local SubStories = {
	WhoAreYou = {
		{Name = "<user>"},
		{Text = "Who are you..?"}, -- Remembers last Name

		{Name = "Bob"},
		{Text = "Im Bob."},

		{Tag = {Require = {["KnownBob"] = nil}}}, -- Checks if there is no specified tag('s)
		{Text = "Do you not know me?"},

		{Tag = {Require = {["KnownBob"] = true}}}, -- If there is.
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
		{Event = "Death"}, -- Fires event in the main script.
		{Break = true}, -- Breaks the story, which basically means it wont read any further lines. Wont affect the story calling it.
		{Text = "This wont run."},
	} :: Types.StoryObject,
}


return {
	{Name = "<unknown>"},
	{Text = "Hey you."},

	{Name = "<user>"},
	{Text = "Huh? What's going on?"},
	{
		Options = {
			{Story = SubStories.WhoAreYou, Id = "WhoAreYou", Text = "Who are you?"}, -- "Story" is basically the table we are referencing, it will run as usual, it will not override any local variables (E.g. Name or RequiredOptions etc.) 
			{Story = SubStories.GetOut, Id = "GetOut", Text = "Get him out."},
		}, 
		Text = "..."
	}, 
    {Text = "This will run anyway."} -- Returns to the main story if options' ones end.
} :: Types.StoryObject
