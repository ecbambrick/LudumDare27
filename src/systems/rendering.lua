local drawBackground, drawMap

secs.rendersystem("render", 100, function()

	-- set camera
	love.graphics.push()
	love.graphics.scale(WINDOW_SCALE)
	
	local spriteEntities = {}
	for e in pairs(secs.query("sprites")) do
		table.insert(spriteEntities, e)
	end
	table.sort(spriteEntities, function(a,b) return a.pos.z < b.pos.z end)
	
	drawBackground(Map)
	love.graphics.push()
	if Camera then
		love.graphics.translate(-Camera.pos.x, -Camera.pos.y)
	end
	for i,e in ipairs(spriteEntities) do
		if ( e.wall and e.wall.active ) or not e.wall then
			if e.color then love.graphics.setColor(e.color.rgb) end
			e.sprite.sprite:draw(e.pos.x, e.pos.y, e.pos.dx)
			if e.color then love.graphics.setColor(255,255,255,255) end
		end
	end
	drawMap(Map)
	love.graphics.pop()
	if Group and Player then
		local x, y = WINDOW_WIDTH - 20 * #Group.group, WINDOW_HEIGHT - 24
		for i, class in ipairs(Group.group) do
			Sprites[class[2]]:draw(x+20*(i-1)+4, y)
		end
	end
	if Selector then
		love.graphics.setColor(0,0,0,128)
		love.graphics.rectangle("fill",0,0,WINDOW_WIDTH, WINDOW_HEIGHT)
		love.graphics.setColor(255,255,255,255)
		local x, y = WINDOW_WIDTH/2 - 10 * #Group.group, WINDOW_HEIGHT/2 - 10
		for i, class in ipairs(Group.group) do
			if i == Selector.selector.index then love.graphics.setColor(255,255,255,255)
			else love.graphics.setColor(255,255,255,128) end
			Sprites[class[2]]:draw(x+20*(i-1)+4, y)
		end
		love.graphics.setColor(255,255,255,255)
	end
	for e in pairs(secs.query("images")) do
		love.graphics.draw(e.image.image, e.pos.x, e.pos.y)
	end
	
	love.graphics.pop()
	
	for e in pairs(secs.query("text")) do
		love.graphics.print(e.text.text, e.pos.x, e.pos.y)
	end
	
	-- draw timer
	if Timer then
		love.graphics.print(math.floor(Timer.count), WINDOW_WIDTH*WINDOW_SCALE/2 - 16, 0)
	end
	for e in pairs(secs.query("rectangles")) do
		love.graphics.setColor(e.color.rgb)
		love.graphics.rectangle("fill", e.pos.x, e.pos.y, e.pos.w*2, e.pos.h*2)
		love.graphics.setColor(255,255,255,255)
	end
	
end)

function drawBackground(map)
	if map and map.stage and map.stage.map then
		love.graphics.draw(Images.background1)
	end
end

function drawMap(map)
	if map and map.stage and map.stage.map then
		map.stage.map:draw()
	end
end
