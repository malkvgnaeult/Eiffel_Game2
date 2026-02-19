note
	description: "Summary description for {GAME_GAMEPAD_EVENTS}."
	author: "Malyk Vigneault"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GAME_GAMEPAD_EVENTS

inherit
	GAME_EVENTS
		redefine
			make
		end

feature {NONE} -- Initialisation

	make
			-- initialization of 'Current'
		do
			--crée avec agent les events
		end

feature -- Access

	stop
		-- <Precursor>
		do
			is_running := False
			events_controller
		end

	run
			-- <Precursor>
		do

		end

	clear
			-- <Precursor>
		local
			l_was_running: BOOLEAN
		do
			l_was_running := is_running
			if is_running then
				stop
			end
			button_pressed_actions_internal := Void
			button_released_actions_internal := Void
			removed_actions_internal := Void
			if l_was_running then
				run
			end
		end

feature {NONE} -- Implementation

	button_pressed_actions_internal: detachable ACTION_SEQUENCE[TUPLE[timestamp:NATURAL_32;button_id:NATURAL_8]]
			-- Internal value of the `button_pressed_actions' lazy evaluated attribute

	button_pressed_events_callback: PROCEDURE [ANY, TUPLE [timestamp: NATURAL_32; gamepad_id: INTEGER_32; button_id:NATURAL_8]]
			-- Callback used to register `Current' in the `events_controller' for the
			-- `button_pressed_actions' {ACTION_SEQUENCE}

	button_pressed_events_dispatcher (a_timestamp: NATURAL_32; a_gamepad_id:INTEGER; a_button_id:NATURAL_8)
			-- The dispatcher receiving event from the `button_pressed_events_callback' and dispatch them to
			-- the `button_pressed_actions' {ACTION_SEQUENCE}
		do
			if
				a_gamepad_id = id and then
				attached button_pressed_actions_internal as la_actions
			then
				la_actions.call (a_timestamp, a_button_id)
			end
		end

	button_released_actions_internal: detachable ACTION_SEQUENCE[TUPLE[timestamp:NATURAL_32;button_id:NATURAL_8]]
			-- Internal value of the `button_released_actions' lazy evaluated attribute

	button_released_events_callback: PROCEDURE [ANY, TUPLE [timestamp: NATURAL_32; gamepad_id: INTEGER_32; button_id:NATURAL_8]]
			-- Callback used to register `Current' in the `events_controller' for the
			-- `button_released_actions' {ACTION_SEQUENCE}

	button_released_events_dispatcher (a_timestamp: NATURAL_32; a_gamepad_id:READABLE_STRING_GENERAL; a_button_id:NATURAL_8)
			-- The dispatcher receiving event from the `button_released_events_callback' and dispatch them to
			-- the `button_released_actions' {ACTION_SEQUENCE}
		do
			if
				a_gamepad_id = id and then
				attached button_released_actions_internal as la_actions
			then
				la_actions.call (a_timestamp, a_button_id)
			end
		end

	removed_events_dispatcher (a_timestamp: NATURAL_32; a_gamepad_id:INTEGER)
			-- The dispatcher receiving event from the `removed_events_callback' and dispatch them to
			-- the `removed_actions' {ACTION_SEQUENCE}
		do
			if
				a_gamepad_id = id and then
				attached removed_actions_internal as la_actions
			then
				la_actions.call (a_timestamp)
			end
		end

	id: READABLE_STRING_GENERAL
			-- Internal event identifier of `Current'
		deferred
		end

feature {GAME_LIBRARY_CONTROLLER} -- Implementation

	removed_actions_internal: detachable ACTION_SEQUENCE[TUPLE[timestamp:NATURAL_32]]
		-- Internal value of the `removed_actions' lazy evaluated attribute

end
