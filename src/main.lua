WINDOW_SCALE = 2
WINDOW_WIDTH = love.graphics.getWidth() / WINDOW_SCALE
WINDOW_HEIGHT = love.graphics.getHeight() / WINDOW_SCALE

function love.load()

	-- love.graphics.setBackgroundColor(160,204,230,255)
    love.graphics.setDefaultImageFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")

	require "lib.math"
	require "lib.coroutines"
	newSprite = require "lib.sprite"
	secs = require "lib.secs"
		   require "systems.tiledmap"
		   require "systems.input"
		   require "systems.physics"
		   require "systems.collision"
		   require "systems.rules"
		   require "systems.camera"
		   require "systems.rendering"
		   require "components"
		   require "entities"

	Font = love.graphics.newImageFont("assets/font.png",
		" abcdefghijklmnopqrstuvwxyz" ..
		"ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
		"123456789.,!?-+/():;%&`'*#=[]\""
	)
	love.graphics.setFont(Font)
	Images = {
		background1 = love.graphics.newImage("assets/bg1.png"),
		objects = love.graphics.newImage("assets/objects.gif"),
		tiles = love.graphics.newImage("assets/tiles.gif"),
		characters = love.graphics.newImage("assets/characters.gif"),
		title = love.graphics.newImage("assets/title.png"),
		descriptions = love.graphics.newImage("assets/descriptions.png"),
		instructions = love.graphics.newImage("assets/instructions.png"),
	}
	Sprites = {
		switch = newSprite(Images.objects, 32, 32, 16, 16),
		projectile = newSprite(Images.objects, 16, 32, 16, 16),
		wall = newSprite(Images.objects, 0, 32, 16, 16),
		crate = newSprite(Images.objects, 0, 0, 16, 16),
		treasure = newSprite(Images.objects, 16, 0, 16, 16),
		treasureActive = newSprite(Images.objects, 32, 16, 16, 16),
		grave = newSprite(Images.objects, 32, 0, 16, 16),
		getMessage = newSprite(Images.objects, 0, 16, 32, 16),
		someguy = newSprite(Images.characters, 0, 0, 15, 19),
		fighter = newSprite(Images.characters, 0, 0, 15, 19),
		theif = newSprite(Images.characters, 15, 0, 15, 19),
		wizard = newSprite(Images.characters, 45, 0, 15, 19),
	}
	Classes = { "fighter", "wizard", "theif" }
	Music = love.audio.newSource("assets/music.ogg")
	
    Music:setLooping(true)
    Music:setVolume(0.5)
    love.audio.play(Music)
	
	secs.entity.title()
	secs.entity.image(Images.instructions, 0, 0)
	secs.entity.image(Images.title, 0, 0)
	
end

--------------------------------------------------------------------------------

count = 0
countMax = 1/60
function love.update(dt)
	-- count = count + dt
	-- dt = countMax
	-- if count >= countMax then
		wakeUpWaitingThreads(dt)
		secs.update(dt)
		-- count = 0
	-- end
end

function love.draw()
	secs.draw()
end