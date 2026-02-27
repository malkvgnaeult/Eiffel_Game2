note
	description: "Summary description for {GAMEPAD_BUTTONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAMEPAD_BUTTONS
create
	make
feature -- Access

	make
		do
			south_button:=0

			east_button:=1

			west_button:=2

			north_button:=3

			back_button:=4

			guide_button:=5

			start_button:=6

			left_stick_button:=7

			right_stick_button:=8

			left_shoulder_button:=9

			right_shoulder_button:=10

			dpad_up_button:=11

			dpad_down_button:=12

			dpad_left_button:=13

			dpad_right_button:=14
		end

	south_button:NATURAL_8

	east_button:NATURAL_8

	west_button:NATURAL_8

	north_button:NATURAL_8

	back_button:NATURAL_8

	guide_button:NATURAL_8

	start_button:NATURAL_8

	left_stick_button:NATURAL_8

	right_stick_button:NATURAL_8

	left_shoulder_button:NATURAL_8

	right_shoulder_button:NATURAL_8

	dpad_up_button:NATURAL_8

	dpad_down_button:NATURAL_8

	dpad_left_button:NATURAL_8

	dpad_right_button:NATURAL_8


end
