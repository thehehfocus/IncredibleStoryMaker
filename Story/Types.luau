export type StoryObject = {
	{
		Name: string?, 
		Text: string?,
		Options: {
			[number|string]: {Story: StoryObject, Id: string, Text: string?}
			|string
		}?,
		Color: Color3?,
		RequiredOptions: {string}?,
		Event: string?,
		Break: boolean?,
		Tag: {Set: string?, Remove: string?, Require: {[string]: boolean?}?},
	}
}

return nil
