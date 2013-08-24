--[[----------------------------------------------------------------------------

    Copyright (C) 2013 by Cole Bambrick
    cole.bambrick@gmail.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/.
    
    For documentation, see
    https://github.com/ecbambrick/SimpleEntityComponentSystem/wiki

--]]----------------------------------------------------------------------------

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
	for i,e in ipairs(spriteEntities) do
		if e.color then love.graphics.setColor(e.color.rgb) end
		e.sprite.sprite:draw(e.pos.x, e.pos.y, e.pos.dx)
		if e.color then love.graphics.setColor(255,255,255,255) end
	end
	drawMap(Map)
	if Group then
		local x, y = WINDOW_WIDTH - 20 * #Group.group, WINDOW_HEIGHT - 24
		for i, class in ipairs(Group.group) do
			if class == "fighter" then Sprites.fighter:draw(x+20*(i-1)+4, y) end
			if class == "theif"   then Sprites.theif:draw(x+20*(i-1)+4, y)   end
			if class == "wizard"  then Sprites.wizard:draw(x+20*(i-1)+4, y)  end
		end
	end
	
	-- unset camera
	love.graphics.pop()
	
end)

function drawBackground(map)
	if map and map.stage and map.stage.map then
		if map.stage.background then
			love.graphics.draw(map.stage.background)
		end
	end
end

function drawMap(map)
	if map and map.stage and map.stage.map then
		map.stage.map:draw()
	end
end