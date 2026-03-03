note
	description: "Summary description for {DESERT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DESERT

inherit
	IMAGE

create
	make

feature {NONE} -- Initialization

	make(a_renderer:GAME_RENDERER)
			-- Initialization of `Current' for used with `a_renderer'
		do
			make_from_file(a_renderer,"desert.png")
		end


end
