Thy roblox model - [https://create.roblox.com/store/asset/82194195753457] </br>
This is incredible.

Main gimmick is an easy story writer - luau table, thats all. 
Average StoryObject should look something like:

``` luau
local StoryObject = {
  {Name = "<user>"}, -- all strings are parsed with keywords. No text or options = skips callback function.
  {Text = "Hey! This is example text!"}, -- Remembers last used Name
  {Text = "I have a different name.", Name = "<unknown>"}, -- Rewrites Name.

  {Options = {["Choose option One"] = "COO", ["Choose option Two"] = "COT"}}, -- EZ type of option, look through examples for advanced one.
  {RequiredOptions = {"COO"}}, -- Option ID
  {Name = "<user>"}, -- Remembers last RequiredOptions
  {Text = "I chose option one"}, -- Remembers last RequiredOptions

  {RequiredOptions = {"COT"}}, -- Option ID
  {Name = "<user>"},
  {Text = "I chose option two"},
} :: Types.StoryObject -- adds autocomplete stuff.
```

Running StoryObject is like this: 

``` luau
local StoryModule = require(index.to.story)
local StoryObject = require(index.to.object)

StoryModule.IterateStoryline(StoryObject, iteratorFunction) -- Iterator functions receives parameters, which are: Name:string, Text:string, Options:{{RefId:any, Text:string}}, Color:Color3?, Event:string?, Tags: {[string]: boolean}

-- Example of iterator function:
Story.IterateStoryline(StoryObject, function(Name, Text, Options, Color) -- You just receive overall parameters, StoryMaker doesnt make UI for you.
		NameLabel.Text = Name
		_TextLabel.Text = Text
		_TextLabel.TextColor3 = Color or Color3.new(0,0,0)
		
		for i,v in pairs(OptionsFrame.Options:GetChildren()) do
			if v:IsA("TextButton") then
				v:Destroy()
			end
		end
		
		if Options and Options ~= {} then
			local Conns = {}
			local Clicked = false
			local Chosen = nil
			
			for i,Option in Options do
				local OptionButton = _ExampleOption:Clone()
				OptionButton.Text = Option.Text
				OptionButton.Name = "Option"
				OptionButton.Visible = true
				OptionButton.Parent = OptionsFrame.Options

				Conns[#Conns + 1] = OptionButton.MouseButton1Up:Once(function()
					Clicked = true
					Chosen = Option.RefId

					for i,v in pairs(Conns) do
						v:Disconnect()
					end
				end)
			end
			
			repeat
				task.wait()
			until Clicked
			
			return Chosen -- MUST return chosen option's id.
		else
			Mouse.Button1Down:Wait()
		end
	end)
```

Notice that looking into core script's types is extremely helpful for overall understanding of how to work with it. Better stuff in the examples.
