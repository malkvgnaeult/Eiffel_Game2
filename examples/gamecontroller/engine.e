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
			create desert.make (window.renderer)
			create maryo.make (window.renderer)
			has_error := desert.has_error

		end

feature -- Access

	run
			-- Launch the game.

		require
			No_Error: not has_error
		local
			l_controller: GAME_CONTROLLER
		do
			window.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 0, 0))
			window.renderer.clear
			window.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 128, 255))
			maryo.y := 375
			maryo.x := 200
			game_library.quit_signal_actions.extend (agent on_quit)
			window.key_pressed_actions.extend (agent on_key_pressed)
			window.key_released_actions.extend (agent on_key_released)

			game_library.controller_found_actions.extend (agent on_controller_found)

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

	maryo:MARYO
			-- The main character of the game

	desert:DESERT
			-- The background

feature {NONE} -- Implementation

	on_controller_found(timestamp:NATURAL_32; controller:GAME_CONTROLLER)
	local
		l_mappine_string:C_STRING
		l_check:INTEGER
		do
			controller.open
			controller.button_pressed_actions.extend (agent on_button_pressed)
			controller.button_released_actions.extend (agent on_button_released)
			controller.axis_motion_actions.extend (agent on_axis_motion)
			io.put_string (controller.guid.as_string_32 + "\\")
			io.put_string (controller.joystick.out)
	--		create l_mappine_string.make (controller.guid.as_string_32 + ","+controller.name+","+"a:b2,b:b1,y:b3,x:b0,start:b9,guide:b12,back:b8,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftshoulder:b4,rightshoulder:b5,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7")
		--	l_check := {GAME_SDL_EXTERNAL}.sdl_gamecontrolleraddmapping (l_mappine_string.item)
			io.put_integer_32 (l_check)
		end

	on_iteration(a_timestamp:NATURAL_32)
			-- Event that is launch at each iteration.
		do
			maryo.update (a_timestamp)	-- Update Maryo animation and coordinate

			if maryo.x < 0 then		-- Be sure that Maryo does not get out of the screen
				maryo.x := 0
			elseif maryo.x + maryo.sub_image_width > desert.texture.width then
				maryo.x := desert.texture.width - maryo.sub_image_width
			end

			-- Draw the scene
			window.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 128, 255))	-- Redraw the blue sky
			window.renderer.clear

			window.renderer.draw_texture (desert.texture, 0, 0)		-- Redraw the desert
			window.renderer.draw_sub_texture_with_mirror (		-- Redraw Maryo
									maryo.texture,  maryo.sub_image_x, maryo.sub_image_y, maryo.sub_image_width, maryo.sub_image_height,
									maryo.x, maryo.y, False, maryo.facing_left
								)

			window.renderer.present		-- Update modification in the screen
		end

	on_axis_motion(a_timestamp:NATURAL_32;a_axis_id:NATURAL_8;a_value:INTEGER_16)
		do
		across game_library.internal_controllers as l_controller loop
			if attached l_controller.item as la_controller then
				if (la_controller.axis.left_x = a_axis_id) then
					if a_value < 0 then
						maryo.go_left (a_timestamp)
					elseif a_value > 0 then
						maryo.go_right (a_timestamp)
					end
				end
				if a_value = 0 then
					if maryo.going_left then
						maryo.stop_left
					elseif maryo.going_right then
						maryo.stop_right
					end
				end
			end
		end
		end

	on_button_pressed(a_timestamp:NATURAL_32; a_button_id:NATURAL_8)
		do
					maryo.go_right(a_timestamp)
		end

	on_button_released(a_timestamp:NATURAL_32; a_button_id:NATURAL_8)
		do
					maryo.stop_right
					io.put_string (a_button_id.out)
		end

	on_quit(a_timestamp: NATURAL_32)
			-- This method is called when the quit signal is send to the application (ex: window X button pressed).
		do
			game_library.stop  -- Stop the controller loop (allow game_library.launch to return)
		end

end
