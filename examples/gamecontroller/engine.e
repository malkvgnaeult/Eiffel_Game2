note
	description: "Summary description for {ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENGINE

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization of `Current'
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
		do
			create l_window_builder
			l_window_builder.set_dimension (1024, 512)
			l_window_builder.set_title ("Example Controller")
			l_window_builder.enable_must_renderer_synchronize_update	-- Ask to the video card to manage the frame synchronisation (FPS)
			window := l_window_builder.generate_window
			create rectangle.make (window.renderer)
			create controllers.make (1)
		end

feature -- Access

	run
			-- Launch the game.

		require
			No_Error: not has_error
		do
			window.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 0, 0))
			window.renderer.clear
			window.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 128, 255))
			rectangle.y := 300
			rectangle.x := 200
			game_library.quit_signal_actions.extend (agent on_quit)

			game_library.controller_found_actions.extend (agent on_controller_found)
			game_library.controller_remove_actions.extend (agent on_controller_removed)
			game_library.iteration_actions.extend (agent on_iteration)
			if window.renderer.driver.is_present_synchronized_supported then	-- If the Video card accepted the frame synchronisation (FPS)
				game_library.launch_no_delay									-- Don't let the library managed the frame synchronisation
			else
				game_library.launch
			end

		end


	has_error:BOOLEAN
			-- `True' if an error occured during the creation of `Current'

	window:GAME_WINDOW_RENDERED
			-- The window to draw the scene

	rectangle:RECTANGLE
			-- The main rectangle of the game
	controllers: ARRAYED_LIST[GAME_CONTROLLER]

feature {NONE} -- Implementation

	on_controller_found(timestamp:NATURAL_32; controller:GAME_CONTROLLER)
		do
			controller.open
			controller.button_pressed_actions.extend (agent on_button_pressed)
			controller.button_released_actions.extend (agent on_button_released)
			controller.axis_motion_actions.extend (agent on_axis_motion)
			controllers.extend (controller)
		end

	on_controller_removed(timestamp:NATURAL_32; controller:GAME_CONTROLLER)
		do
			controllers.remove
		end

	on_iteration(a_timestamp:NATURAL_32)
			-- Event that is launch at each iteration.
			local
				points:ARRAYED_LIST[TUPLE[x,y:INTEGER]]
		do
			rectangle.update (a_timestamp)
			-- Draw the scene
			window.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (255, 255, 255))	-- Redraw the white background
			window.renderer.clear
			window.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 0, 0))	-- Redraw the black thing
			window.renderer.draw_sub_texture_with_rotation (rectangle.texture, rectangle.sub_image_x, rectangle.sub_image_y, rectangle.sub_image_width, rectangle.sub_image_height, rectangle.x, rectangle.y, rectangle.x_rotation_center, rectangle.y_rotation_center, rectangle.angle)
			window.renderer.draw_filled_rectangle (rectangle.x + rectangle.texture.width//4, rectangle.y + rectangle.texture.height//3 + 7, rectangle.texture.width//2, rectangle.texture.width//2)
			create points.make(10)
			points.extend ([300,200])
			points.extend ([100,50])
			points.extend ([10,500])
			points.extend ([100,500])
			points.extend ([1,5])
			points.extend ([70,70])
			window.renderer.draw_connected_lines (points)

			window.renderer.present		-- Update modification in the screen
		end

	on_axis_motion(a_timestamp:NATURAL_32;a_axis_id:NATURAL_8;a_value:INTEGER_16)
		do
			across controllers as controller loop
				if (controller.item.axis.left_x = a_axis_id) then
					if a_value < 0 then
						rectangle.go_left (a_timestamp)
					elseif a_value > 0 then
						rectangle.go_right (a_timestamp)
					end
				end

				if (controller.item.axis.left_y = a_axis_id) then
					if a_value < 0 then
						rectangle.go_up (a_timestamp)
					elseif a_value > 0 then
						rectangle.go_down (a_timestamp)
					end
				end

				if controller.item.axis.trigger_left = a_axis_id then
					rectangle.rotate_left (a_timestamp)
				end

				if controller.item.axis.trigger_right = a_axis_id then
					rectangle.rotate_right (a_timestamp)
				end

				if a_value = 0 then
					rectangle.stop
				end
			end

		end

	on_button_pressed(a_timestamp:NATURAL_32; a_button_id:NATURAL_8)
		do
				--	rectangle.go_right(a_timestamp)
		end

	on_button_released(a_timestamp:NATURAL_32; a_button_id:NATURAL_8)
		do
				--	rectangle.stop_right
				--	io.put_string (a_button_id.out)
		end

	on_quit(a_timestamp: NATURAL_32)
			-- This method is called when the quit signal is send to the application (ex: window X button pressed).
		do
			game_library.stop  -- Stop the controller loop (allow game_library.launch to return)
		end

end
