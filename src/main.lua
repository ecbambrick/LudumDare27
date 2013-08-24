function love.load()

	secs = require "secs"
	
	secs.component("input", {})
	secs.component("physical", {})
	secs.component("rect", { style = "fill", rgb = { 255,255,255,255 }})
	secs.component("pos",  { x = 0, y = 0, z = 0, w = 0, h = 0, dx = 0 })
	secs.component("vel",  { x = 0, y = 0, maxX = 100, maxY = 250 })
	
	secs.type("controllable", "input", "vel")
	secs.type("rectangles", "rect", "pos")
	secs.type("movable", "pos", "vel")
	
	secs.entity(
		{ "pos", { x = 10, y = 10 }},
		{ "physical" },
		{ "input" },
		{ "vel" }
	)
	
end

--------------------------------------------------------------------------------

function love.update(dt)
	secs.update(dt)
end

function love.draw()
	secs.draw()
end