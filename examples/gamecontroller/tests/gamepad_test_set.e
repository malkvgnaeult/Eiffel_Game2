note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	GAMEPAD_TEST_SET

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end
	GAME_LIBRARY_SHARED
		undefine
			default_create
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
			l_engine:ENGINE_TESTABLE
			l_controller:GAME_GAMEPAD
		do
			game_library.enable_video
			create l_engine.make
			engine := l_engine
			window := engine.window
			create l_controller.make(1)
			engine.controllers.extend (l_controller)
			controllers := engine.controllers
		end


	on_clean
			-- <Precursor>
		do
		game_library.clear_all_events
		game_library.quit_library
		end

feature -- Test routines

	buttons_valides_test
			-- test les boutons aux positions de y,x,b,a sur manette xbox
		local
			l_bouton_north:NATURAL_8
			l_bouton_west:NATURAL_8
			l_bouton_east:NATURAL_8
			l_bouton_south:NATURAL_8
		do
			l_bouton_north := controllers.first.buttons.north
			l_bouton_west := controllers.first.buttons.west
			l_bouton_east := controllers.first.buttons.east
			l_bouton_south := controllers.first.buttons.south
			-- Déclenche l'événement comme si SDL l'avait envoyé
			--orange
       	 engine.simuler_bouton_presse (5,l_bouton_north)
       	 assert ("valeur du rouge dans la couleur orange", engine.red = 255)
       	 assert ("valeur du vert dans la couleur orange", engine.green = 165)
       	 assert ("valeur du bleu dans la couleur orange", engine.blue = 50)
       	 --bleu
       	 engine.simuler_bouton_presse (10, l_bouton_west)
       	 assert ("valeur du rouge dans la couleur bleu", engine.red = 0)
       	 assert ("valeur du vert dans la couleur bleu", engine.green = 0)
       	 assert ("valeur du bleu dans la couleur bleu", engine.blue = 255)
       	  --rouge
       	 engine.simuler_bouton_presse (15, l_bouton_east)
       	 assert ("valeur du rouge dans la couleur rouge", engine.red = 255)
       	 assert ("valeur du vert dans la couleur rouge", engine.green = 0)
       	 assert ("valeur du bleu dans la couleur rouge", engine.blue = 0)
       	 --vert
       	  engine.simuler_bouton_presse (20, l_bouton_south)
       	 assert ("valeur du rouge dans la couleur vert", engine.red = 35)
       	 assert ("valeur du vert dans la couleur vert", engine.green = 170)
       	 assert ("valeur du bleu dans la couleur vert", engine.blue = 35)
		end

	axis_valide_joystick_gauche_test
	--test les actions du joystick gauche
		local
			l_left_joystick_x:INTEGER_16
			l_left_joystick_y:INTEGER_16
			l_position_inchange:INTEGER
			l_value:INTEGER_16
		do
			l_left_joystick_x:=controllers.first.axis.left_x
			l_left_joystick_y:=controllers.first.axis.left_y
			--à cause de la façon dont la deadzone circulaire est calculé, la 'véritable' ressemble plutôt
			--à la variable+4954.
			l_value:=(engine.rectangle.mouvement_deadzone+5000).truncated_to_integer.as_integer_16
			assert("position x de départ du rectangle",engine.rectangle.x = 0)
			assert("position y de départ du rectangle",engine.rectangle.y = 0)

			--déplacment horizontal
			l_position_inchange:=engine.rectangle.y
			engine.simuler_axe (50, l_left_joystick_x.as_natural_8, l_value)
			engine.rectangle.update (55)
			assert("position x de déplacement horizontal du rectangle",engine.rectangle.x > 0)
			assert("position y de déplacement horizontal du rectangle",engine.rectangle.y = l_position_inchange)

			--déplacement vertical
			engine.rectangle.stop_left_x_axis
			l_position_inchange:=engine.rectangle.x
			engine.simuler_axe (100, l_left_joystick_y.as_natural_8, l_value)
			engine.rectangle.update (105)
			assert("position x de déplacement vertical du rectangle",engine.rectangle.x = l_position_inchange)
			assert("position y de déplacement vertical du rectangle",engine.rectangle.y > 0)
		end

	axis_valide_trigger__test
		local
			l_trigger_left:INTEGER_16
			l_trigger_right:INTEGER_16
			l_angle_depart:REAL_64
			l_value:NATURAL_8
		do
			l_value:=200
			l_trigger_left:=controllers.first.axis.trigger_left
			l_trigger_right:=controllers.first.axis.trigger_right
			l_angle_depart:=engine.rectangle.angle
			assert("angle de départ",l_angle_depart = engine.rectangle.angle)

			--rotation à droite
			engine.simuler_axe (50, l_trigger_right.to_natural_8, l_value)
			engine.rectangle.update (60)
			assert("rotation vers la droite",engine.rectangle.angle > l_angle_depart)
			assert("aucune rotation", engine.rectangle.rotating_right)
			--rotation à gauche
			l_angle_depart := engine.rectangle.angle
			engine.rectangle.stop_rotation
			engine.simuler_axe (70, l_trigger_left.to_natural_8, l_value)
			engine.rectangle.update (80)
			assert("rotation vers la gauche",engine.rectangle.angle < l_angle_depart)
			assert("aucune rotation", engine.rectangle.rotating_left)
		end

		axis_trigger_deadzone_test
		-- test la deadzone des triggers
		local
				l_trigger_left:INTEGER_16
				l_trigger_right:INTEGER_16
				l_angle_depart:REAL_64
				l_value:NATURAL_8
			do
				l_value:=19
				l_trigger_left:=controllers.first.axis.trigger_left
				l_trigger_right:=controllers.first.axis.trigger_right
				l_angle_depart:=engine.rectangle.angle
				assert("angle de départ",l_angle_depart = engine.rectangle.angle)
				assert("l_value doit être inférieur à la deadzone",l_value<engine.rectangle.rotation_deadzone)
				--pas de rotation à droite
				engine.simuler_axe (50, l_trigger_right.to_natural_8, l_value)
				engine.rectangle.update (60)
				assert("rotation vers la droite",engine.rectangle.angle = l_angle_depart)
				assert("aucune rotation", not engine.rectangle.rotating_right)

				--pas de rotation à gauche
				l_angle_depart := engine.rectangle.angle
				engine.simuler_axe (70, l_trigger_left.to_natural_8, l_value)
				engine.rectangle.update (80)
				assert("rotation vers la gauche",engine.rectangle.angle = l_angle_depart)
				assert("aucune rotation", not engine.rectangle.rotating_left)
			end

		bouton_invalide_test
		--test le comportement lors de l'appui d'un bouton invalide
		local
			l_bouton_north:NATURAL_8
			l_bouton_invalide:NATURAL_8
		do
			l_bouton_north := controllers.first.buttons.north
			l_bouton_invalide := 50

       		 engine.simuler_bouton_presse (5,l_bouton_north)
       		 assert ("valeur du rouge dans la couleur orange", engine.red = 255)
       		 assert ("valeur du vert dans la couleur orange", engine.green = 165)
       		 assert ("valeur du bleu dans la couleur orange", engine.blue = 50)

       		  engine.simuler_bouton_presse (5,l_bouton_invalide)
       		 assert ("valeur du rouge dans la couleur orange", engine.red = 255)
       		 assert ("valeur du vert dans la couleur orange", engine.green = 165)
       		 assert ("valeur du bleu dans la couleur orange", engine.blue = 50)
       	 end

		axis_joystick_deadzone_test
	--test les actions du joystick gauche
		local
			l_left_joystick_x:INTEGER_16
			l_left_joystick_y:INTEGER_16
			l_position_depart_x:INTEGER
			l_position_depart_y:INTEGER_16
			l_value:INTEGER_16
		do
			l_left_joystick_x:=controllers.first.axis.left_x
			l_left_joystick_y:=controllers.first.axis.left_y
			l_position_depart_x:=engine.rectangle.x
			l_position_depart_x:=engine.rectangle.y
			l_value:=(engine.rectangle.mouvement_deadzone).truncated_to_integer.as_integer_16
			assert("position x de départ du rectangle",engine.rectangle.x = l_position_depart_x)
			assert("position y de départ du rectangle",engine.rectangle.y = l_position_depart_y)

			--aucun déplacement

			engine.simuler_axe (50, l_left_joystick_x.as_natural_8, l_value)
			engine.rectangle.update (55)
			engine.simuler_axe (60, l_left_joystick_y.as_natural_8, l_value)
			engine.rectangle.update (65)
			assert("position x de déplacement du rectangle",engine.rectangle.x = l_position_depart_x)
			assert("position y de déplacement du rectangle",engine.rectangle.y = l_position_depart_y)
		end

feature {NONE}--access

	window:GAME_WINDOW_RENDERED
	controllers: ARRAYED_LIST[GAME_GAMEPAD]
	engine:ENGINE_TESTABLE
end


