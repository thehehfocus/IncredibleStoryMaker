local this = {}

local Types = require(script.Types)
local Keywords = require(script.Keywords)
local Signal = require(script.Signal)

local function TextFormatter(Text: string)
	return Text:gsub(Keywords.KeyStart.."(.-)"..Keywords.KeyEnd, function(Key)
		return Keywords.Get(Key)
	end)
end

this.OnChosen = Signal() :: Signal.Signal<string>
this.OnShownEventId = Signal() :: Signal.Signal<string>

function this.IterateStoryline(
	Storyline: Types.StoryObject, 
	Callback: ((Name:string, Text:string, Options:{{RefId:any, Text:string}}, Color:Color3?, Event:string?, Tags: {[string]: boolean}) -> ()),
	Tags: {[string]:boolean}
)
	local LastConfig = {}
	local ChosenOptions = {}
	local Tags = Tags or {}
	
	for i,v in pairs(Storyline) do
		if v.Break then
			break
		end
		
		local HasRequired = true
		if v.RequiredOptions or LastConfig.RequiredOptions then
			local UsingOptions = v.RequiredOptions or LastConfig.RequiredOptions
			for i,Option in pairs(UsingOptions) do
				if not ChosenOptions[Option] then
					HasRequired = false
					break
				end
			end
			LastConfig.RequiredOptions = UsingOptions
		end
		
		if HasRequired then
			local _UsingTagRequire
			if v.Tag then
				_UsingTagRequire = v.Tag.Require
				if v.Tag.Set then
					Tags[v.Tag.Set] = true
				end
				if v.Tag.Remove then
					Tags[v.Tag.Remove] = nil
				end
				
				if _UsingTagRequire then
					LastConfig.RequiredTags = v.Tag.Require
				end
			end
			if (_UsingTagRequire or LastConfig.RequiredTags) then
				if not _UsingTagRequire then
					_UsingTagRequire = LastConfig.RequiredTags
				end
				
				for Tag, Value in pairs(_UsingTagRequire) do
					if Tags[Tag] ~= Value then
						HasRequired = false
						break
					end
				end
			end
		end
		
		if not HasRequired then
			continue
		end
		
		if v.Event then
			this.OnShownEventId:Fire(v.Event)
		end
		
		local Name = ""
		local Text = ""
		local OptionsText = {}
		local Color = nil
		
		if v.Name then
			Name = TextFormatter(v.Name)
			LastConfig.Name = v.Name
		else
			Name = TextFormatter(LastConfig.Name)
		end
		
		if v.Color then
			Color = v.Color
			LastConfig.Color = v.Color
		else
			Color = LastConfig.Color
		end
		
		if v.Text then
			Text = TextFormatter(v.Text)
		end
		
		if v.Options then
			for Option, id in pairs(v.Options) do
				if typeof(id) == "table" then
					Option = id.Text or Option
				end
				OptionsText[Option] = {Text = TextFormatter(Option), RefId = id}
			end
		elseif not v.Text then
			continue
		else
			OptionsText = nil
		end
		
		local ChosenOption = Callback(Name, Text, OptionsText, Color, v.Event, v.Tag) :: typeof(v.Options.any)
		
		if ChosenOption then
			local Id = nil
			
			if typeof(ChosenOption) == "table" then
				if ChosenOption.Story then
					this.IterateStoryline(ChosenOption.Story, Callback, Tags)
				else
					this.IterateStoryline(ChosenOption, Callback, Tags)
				end
				
				if ChosenOption.Id then
					Id = ChosenOption.Id
				else
					Id = ChosenOption
				end
			else
				Id = ChosenOption
			end
			
			ChosenOptions[Id] = true
			this.OnChosen:Fire(Id)
		end
	end
end

return this
