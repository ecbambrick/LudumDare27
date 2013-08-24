function love.load()

	require "lib.math"

	secs = require "lib.secs"
		   require "systems.tiledmap"
		   require "systems.input"
		   require "systems.physics"
		   require "systems.rendering"
		   require "components"
		   require "entities"
		   
	Player = secs.entity.player(10, 10)
	Map = secs.entity.stage("assets/test.tmx", true)
	
end

--------------------------------------------------------------------------------

function love.update(dt)
	secs.update(dt)
end

function love.draw()
	secs.draw()
end