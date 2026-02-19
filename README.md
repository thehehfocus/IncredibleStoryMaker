Thy roblox model - [https://create.roblox.com/store/asset/82194195753457] </br>
This is incredible.

Main gimmick is an easy story writer - luau table, thats all. \
This supports:
- Runtime Tags
- Branching
- Text formatting
- Event triggers </br>

While being able to be read easily. 

Average StoryObject would look something like:
``` luau
local StoryObject = {
  {Name = "<user>"}, -- Setting name
  {Text = "Hey! This is example text!"}, 						--] -- Some story stuff
  {Text = "I have a different name.", Name = "<unknown>"},		--]

  {Options = {["Choose option One"] = "COO", ["Choose option Two"] = "COT"}}, -- Wow! Branching options!

  {RequiredOptions = {"COO"}},              --]
  {Name = "<user>"},                        --] -- Runs if chose option one
  {Text = "I chose option one"},            --]

  {RequiredOptions = {"COT"}}, 				--]
  {Name = "<user>"},						--] -- Runs if chose option two
  {Text = "I chose option two"},			--]
} :: Types.StoryObject -- adds autocomplete stuff.
```
Look at "Examples" for explanations and advanced comments!

Running StoryObject is like this: 
``` luau
local StoryModule = require(index.to.story)
local StoryObject = require(index.to.object)

StoryModule.IterateStoryline(StoryObject, iteratorFunction)

-- Example of iterator function:
Story.IterateStoryline(StoryObject, function(Name, Text, Options, Color) -- You just receive overall parameters of each step, StoryMaker doesnt make UI for you.
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
			
			return Chosen
		else
			Mouse.Button1Down:Wait()
		end
	end)
```

Notice that looking into core script's types is extremely helpful for overall understanding of how to work with it. Better stuff in the examples.
