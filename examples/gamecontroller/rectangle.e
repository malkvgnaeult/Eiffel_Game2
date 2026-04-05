note
	description: "Summary description for {RECTANGLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RECTANGLE

inherit
	IMAGE

create
	make

feature {NONE} -- Initialization

	make(a_renderer:GAME_RENDERER)
			-- Initialization of `Current' for used with `a_renderer'
		do
			make_from_file(a_renderer,"rectangle.png")

			initialize_coordinate
		end

	initialize_coordinate
			-- Create the `animation_coordinates'
		do

			sub_image_height := texture.height
			sub_image_width := texture.width

			sub_image_x := 0
			sub_image_y := 0

			x_rotation_center := texture.width//2
			y_rotation_center := texture.height//2
		end

feature -- Access

	update(a_timestamp:NATURAL_32)
			-- Update the surface depending on the present `a_timestamp'.
			-- Each 100 ms, the image change; each 10ms `Current' is moving
		local
			l_coordinate:TUPLE[x,y:INTEGER]
			l_delta_time:NATURAL_32
		do
				l_delta_time := a_timestamp - old_timestamp
				if l_delta_time // movement_delta > 0 then

						if going_horizontal then
							x := x + (x_motion_value.as_integer_32//10000)
						end
						if going_vertical then
							y := y + (y_motion_value.as_integer_32//10000)
						end

					if rotating then
						if rotating_right then
							angle := angle + (l_delta_time // movement_delta).to_real_64
						elseif rotating_left then
							angle := angle - (l_delta_time // movement_delta).to_real_64
						end

					end
					old_timestamp := old_timestamp + (l_delta_time // movement_delta) * movement_delta
				end

		end

	x_motion_value:INTEGER_16

	go_horizontal(a_timestamp:NATURAL_32;a_value:INTEGER_16)
			-- Make `Current' starting to move left
		do
			old_timestamp := a_timestamp
			going_horizontal := true

			x_motion_value := a_value
		end

--	go_right(a_timestamp:NATURAL_32;a_value:INTEGER_16)
--			-- Make `Current' starting to move right
--		do
--			old_timestamp := a_timestamp
--			going_right := True

--			x_motion_value := a_value
--		end

	y_motion_value:INTEGER_16

	go_vertical(a_timestamp:NATURAL_32;a_value:INTEGER_16)
			-- Make `Current' starting to move vertically
		do
			old_timestamp := a_timestamp
			going_vertical := true

			y_motion_value := a_value
		end

	rotate_right(a_timestamp:NATURAL_32)
			-- Make `Current' starting to rotate right
		do
			old_timestamp := a_timestamp
			rotating_right := True
			rotating := true
		end

	rotate_left(a_timestamp:NATURAL_32)
			-- Make `Current' starting to rotate left
		do
			old_timestamp := a_timestamp
			rotating_left := True
			rotating := true
		end

	stop_rotation
			-- Make `Current' stop rotating
		do
			rotating := false
			rotating_right := false
			rotating_left := false
		end

	stop_left_x_axis
		do
			going_horizontal := false
		end

	stop_left_y_axis
		do
			going_vertical := false
		end

	rotating:BOOLEAN
		-- Is 'Current' rotation

	going_horizontal:BOOLEAN
			-- Is `Current' moving horizontally

	going_vertical:BOOLEAN
			-- Is `Current' moving vertically

	rotating_right:BOOLEAN
		-- Is 'Current' rotating right

	rotating_left:BOOLEAN
		-- Is 'Current' rotating left

	x:INTEGER assign set_x
			-- Horizontal position of `Current'

	y:INTEGER assign set_y
			-- Vertical position of `Current'

	angle:REAL_64 assign set_angle

	set_x(a_x:INTEGER)
			-- Assign the value of `x' with `a_x'
		do
			x := a_x
		ensure
			Is_Assign: x = a_x
		end

	set_y(a_y:INTEGER)
			-- Assign the value of `y' with `a_y'
		do
			y := a_y
		ensure
			Is_Assign: y = a_y
		end

	set_angle(a_angle:REAL_64)
			-- Assign the value of `angle' with `a_angle'
		do
			angle := a_angle
		ensure
			Is_Assign: angle = a_angle
		end

	sub_image_x, sub_image_y:INTEGER
			-- Position of the portion of image to show inside `surface'

	sub_image_width, sub_image_height:INTEGER
			-- Dimension of the portion of image to show inside `surface'

	x_rotation_center:INTEGER

	y_rotation_center:INTEGER

feature {NONE} -- implementation


	old_timestamp:NATURAL_32
			-- When appen the last movement (considering `movement_delta')

feature {NONE} -- constants

	movement_delta:NATURAL_32 = 10
			-- The delta time between each movement of `Current'

	animation_delta:NATURAL_32 = 100
			-- The delta time between each animation of `Current'


end

