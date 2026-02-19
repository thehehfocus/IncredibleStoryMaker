export type StoryObject = {
	{
		Name: string?, -- What returns to callback function as "Name".
		Text: string?, -- What returns to callback function as "Text".
		Options: {
			[number]: {Story: StoryObject, Id: string, Text: string?} -- Technically Advanced and Recommended option 
			-- [string]: string -- EZ option, where [string] is the text showed, and string is its id.
		}?,
		Color: Color3?, -- What returns to callback function as "Color".
		RequiredOptions: {string}?, -- What requires to run, skips if isnt met.
		Event: string?, -- Event's identifier that fires while iterating the story.
		Break: boolean?, -- Simply breaks the story from running along with iteratorFunction.
		Tag: {Set: string?, Remove: string?, Require: {[string]: boolean?}?}, -- SET/REMOVE/REQUIRE local story tags.
	}
}

return nil
