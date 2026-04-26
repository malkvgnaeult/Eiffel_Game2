class ENGINE_TESTABLE
inherit
    ENGINE

create
	make

feature -- Exposition pour les tests


    simuler_bouton_presse (a_timestamp: NATURAL_32; a_button_id: NATURAL_8)
        do
            on_button_pressed (a_timestamp, a_button_id)
        end

    simuler_axe (a_timestamp: NATURAL_32; a_axis_id: NATURAL_8; a_value: INTEGER_16)
        do
            on_axis_motion (a_timestamp, a_axis_id, a_value)
        end

       simuler_iteration(a_timestamp:NATURAL_32)
       do
       	on_iteration(a_timestamp)
       end
end
