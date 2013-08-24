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
		characters = love.graphics.newImage("assets/characters.gif"),
		particle = love.graphics.newImage("assets/particle.gif"),
	}
	Sprites = {
		crate = newSprite(Images.objects, 0, 0, 16, 16),
		treasure = newSprite(Images.objects, 16, 0, 16, 16),
		treasureActive = newSprite(Images.objects, 32, 16, 16, 16),
		grave = newSprite(Images.objects, 32, 0, 16, 16),
		getMessage = newSprite(Images.objects, 0, 16, 32, 16),
		someguy = newSprite(Images.characters, 0, 0, 15, 19),
		fighter = newSprite(Images.characters, 0, 0, 15, 19),
		theif = newSprite(Images.characters, 15, 0, 15, 19),
		wizard = newSprite(Images.characters, 30, 0, 15, 19),
	}
	
	Timer = 10
	Group = secs.entity.group("fighter", "wizard", "theif")
	Player = secs.entity.player(16*7.5, 16*-1, table.remove(Group.group, 1))
	Space = secs.entity.spatialmap(64)
	Map = secs.entity.stage("assets/test.tmx", Images.background1, true)
	
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
	local width = Timer >= 10 and 40 or 16
	love.graphics.print(math.floor(Timer), WINDOW_WIDTH - width, 0)
end