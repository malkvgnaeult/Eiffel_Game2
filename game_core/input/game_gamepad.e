note
	description: "Summary description for {GAME_GAMEPAD}."
	author: "Malyk Vigneault"
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_GAMEPAD
inherit
	DISPOSABLE
	GAME_LIBRARY_SHARED

create {GAME_LIBRARY_CONTROLLER}
	make

feature {NONE} -- Initialization

	make(a_joystick:GAME_JOYSTICK)
			-- Initialization for `Current' using `a_open_index' when `open'.
		do
			joystick := a_joystick
			events_controller := game_library.events_controller
			--make_events
		end
feature -- Access

	open
			-- Open `Current' (Allocate internal structure).
		require
			Open_Gamepad_Not_Open:not is_open
		do
		--	clear_error va arriver avec le game_gamepad_events
			item := {GAME_SDL_EXTERNAL}.sdl_opengamepad(joystick.index)
		--	manage_error_pointer(item, "Error while opening the Gamepad.") comme clear_error
	--	ensure
		--	Is_Open_Or_Error: not has_error implies is_open
		end

	close
			-- Close `Current' (Free internal structure).
		require
			Close_Is_Open: is_open
		do
			{GAME_SDL_EXTERNAL}.sdl_closegamepad (item)
		end

	is_open:BOOLEAN
			-- True if the joystick has been opened.
		do
			Result := (not item.is_default_pointer) and then {GAME_SDL_EXTERNAL}.sdl_gamepadconnected (item)
		end

	events_controller:GAME_EVENTS_CONTROLLER
			-- Used main event manager

	is_connected: BOOLEAN
		-- Check if the gamepad is connected
		do
			Result := {GAME_SDL_EXTERNAL}.sdl_gamepadconnected (item)
		end

feature  {NONE} -- Implementation
	dispose
			-- <Pecursor>
	do
		if not item.is_default_pointer then
			{GAME_SDL_EXTERNAL}.sdl_closegamepad (item)
		end
	end

feature {GAME_SDL_ANY} -- Implementation

	item:POINTER
			-- Point to the internal C structure of `Current'

	joystick: GAME_JOYSTICK
			-- joysticks of the gamepad

end
