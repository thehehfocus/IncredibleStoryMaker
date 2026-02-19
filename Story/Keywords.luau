local _Keywords = {
	user = function()
		return game.Players.LocalPlayer.DisplayName
	end,
	unknown = function()
		return "???"
	end,
	-- Add more keywords as needed
}

return {
	Get = function(key: string)
		if _Keywords[key] then
			return _Keywords[key]()
		end
		return key
	end,
	KeyStart = "<", -- Start of keyword
	KeyEnd = ">", -- End of keyword
}
