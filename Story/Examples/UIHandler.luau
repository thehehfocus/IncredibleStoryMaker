local this = {}

local Story = require(script.Parent.Story)

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local TextUI = Player.PlayerGui:WaitForChild("TextGUI") :: typeof(game.StarterGui.TextGUI)
local MainFrame = TextUI.StoryFrame :: Frame
local TextFrame = MainFrame.MainTextFrame :: Frame
local _TextLabel = TextFrame.Text :: TextLabel
local OptionsFrame = MainFrame.OptionsFrame :: Frame
local _ExampleOption = OptionsFrame.OptionExample :: TextButton
local NameLabel = MainFrame.NameLabel :: TextLabel

local function RunStory()
	Story.OnShownEventId:Connect(function(id)
		if id == "Death" then
			Player.Character.Humanoid.Health = 0
			return
		end
	end)

	local IterationFunction = function(Name, Text, Options, Color) -- You just receive overall parameters of each step, StoryMaker doesnt make UI for you. If step itself doesnt have text or options this wont be called.
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
				
				return Chosen -- MUST return chosen option's RefId if chosen.
			else
				Mouse.Button1Down:Wait()
			end
		end)
		
		MainFrame.Visible = false
	end)
	
	Story.IterateStoryline(require(script.Parent.Story.Storyline), IterationFunction) -- Iterator functions receive parameters, which are: Name:string, Text:string, Options:{{RefId:any, Text:string}}, Color:Color3?, Event:string?, Tags: {[string]: boolean}
end

RunStory()

return this
