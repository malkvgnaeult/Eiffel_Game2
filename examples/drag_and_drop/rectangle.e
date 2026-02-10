note
	description: "A rectangle that have a position and a dimension"
	author: "Louis M"
	date: "Thu, 04 Dec 2025 23:54:09 +0000"
	revision: "0.1"

class
	RECTANGLE

create
	make

feature {NONE} -- Initialisation

	make(a_x, a_y, a_width, a_height:INTEGER)
			-- Initialisation of `Current' using `a_x' as `x', `a_y' as `y', `a_width' as `width' and `a_height' as `height'
		do
			set_x(a_x)
			set_y(a_y)
			set_width(a_width)
			set_height(a_height)
		ensure
			Is_X_Assign: x = a_x
			Is_Y_Assign: y = a_y
			Is_Width_Assign: width = a_width
			Is_Height_Assign: height = a_height
		end

feature -- Access

	x:INTEGER assign set_x
			-- Horizontal position of `Current'.

	y:INTEGER assign set_y
			-- Vertical position of `Current'.

	set_x(a_x:INTEGER)
			-- Assign `x` with the value of `a_x'
		do
			x := a_x
		ensure
			Is_Assign: x = a_x
		end

	set_y(a_y:INTEGER)
			-- Assign `y` with the value of `a_y'
		do
			y := a_y
		ensure
			Is_Assign: y = a_y
		end

	width:INTEGER assign set_width
			-- Horizontal dimension of `Current'.

	height:INTEGER assign set_height
			-- Vertical dimension of `Current'

	set_width(a_width:INTEGER)
			-- Assign `width` with the value of `a_width'
		do
			width := a_width
		ensure
			Is_Assign: width = a_width
		end

	set_height(a_height:INTEGER)
			-- Assign `height` with the value of `a_height'
		do
			height := a_height
		ensure
			Is_Assign: height = a_height
		end




end
