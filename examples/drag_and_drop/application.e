note
    description : "A game created in Eiffel."
    author      : "Louis M"
    generator   : "Eiffel Game2 Project Wizard"
    date        : "2025-12-04 10:59:29.962 +0000"
    revision    : "0.1"

class
    APPLICATION

inherit
	GAME_LIBRARY_SHARED

create
    make

feature {NONE} -- Initialization

    make
            -- Running the game.
        local
        	l_engine:ENGINE
        do
            game_library.enable_video
            create l_engine.make
            l_engine.run
        end

end
