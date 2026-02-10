note
	description: "Example to show how to do a drag and drop mecanism."
	author: "Louis M"
	date: "Thu, 04 Dec 2025 23:54:09 +0000"
	revision: "0.1"

class
	ENGINE

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialisation

	make
			-- Initialisation of `Current'
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
		do
			create l_window_builder
			l_window_builder.set_dimension (600, 600)
			window := l_window_builder.generate_window
			create {ARRAYED_LIST[RECTANGLE]}rectangles.make (25)
			across 1 |..| 5 as la_index1 loop
				across 1 |..| 5 as la_index2 loop
					rectangles.extend (create {RECTANGLE}.make (la_index1.item*100 - 25, la_index2.item*100 - 25, 50, 50))
				end
			end
			create background_color.make_rgb (0, 0, 0)
			create foreground_color.make_rgb (255, 255, 255)
			dragged_rectangle := Void
		end


feature -- Access

	run
			-- Launch the execution of `Current'
		do
			game_library.quit_signal_actions.extend (agent on_quit)
			game_library.iteration_actions.extend (agent on_iteration)
			window.mouse_button_pressed_actions.extend (agent on_mouse_button_pressed)
			window.mouse_button_released_actions.extend (agent on_mouse_button_released)
			window.mouse_motion_actions.extend (agent on_mouse_motion)
			game_library.launch
		end

	rectangles:LIST[RECTANGLE]
			-- The object to drag and drop

	background_color:GAME_COLOR_READABLE
			-- The color of the background

	foreground_color:GAME_COLOR_READABLE
			-- The color of the `rectangles'

	dragged_rectangle:detachable RECTANGLE
			-- The {RECTANGLE} that is being dragged


feature {NONE} -- Implementatin

	window:GAME_WINDOW_RENDERED
			-- Where to draw the scene

	on_iteration(a_timestamp:NATURAL)
			-- At each game loop iteration
		do
			window.renderer.set_drawing_color (background_color)
			window.renderer.clear
			window.renderer.set_drawing_color (foreground_color)
			across rectangles as la_rectangles loop
				window.renderer.draw_filled_rectangle (la_rectangles.item.x, la_rectangles.item.y, la_rectangles.item.width, la_rectangles.item.height)
			end
			window.update
		end

	on_mouse_button_pressed(a_timestamp:NATURAL_32; a_mouse_state:GAME_MOUSE_BUTTON_PRESS_EVENT; a_click_count:NATURAL_8)
			-- When the user click on the `window'
		do
			across rectangles as la_rectangle loop
				if
					a_mouse_state.x > la_rectangle.item.x and a_mouse_state.x < la_rectangle.item.x + la_rectangle.item.width and
					a_mouse_state.y > la_rectangle.item.y and a_mouse_state.y < la_rectangle.item.y + la_rectangle.item.height
				then
					dragged_rectangle := la_rectangle.item
				end
			end
		end

	on_mouse_button_released(a_timestamp:NATURAL_32; a_mouse_state:GAME_MOUSE_BUTTON_RELEASE_EVENT; a_click_count:NATURAL_8)
			-- When the user release the click on the `window'
		do
			dragged_rectangle := Void
		end

	on_mouse_motion(a_timestamp:NATURAL_32; a_mouse_state:GAME_MOUSE_MOTION_EVENT; a_delta_x, a_delta_y:INTEGER_32)
			-- When the user move the mouse
		do
			if attached dragged_rectangle as la_rectangle then
				la_rectangle.x := la_rectangle.x + a_delta_x
				la_rectangle.y := la_rectangle.y + a_delta_y
			end
		end

	on_quit(a_timestamp:NATURAL)
			-- When the user quit the program
		do
			game_library.stop
		end

end
