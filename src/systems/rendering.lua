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

secs.rendersystem("render", 100, function()

	-- set camera
	love.graphics.push()
	love.graphics.scale(2)
	
	-- draw each type of entity
	for e in pairs(secs.query("rectangles")) do
		love.graphics.rectangle(e.rect.style, e.pos.x, e.pos.y, e.pos.w, e.pos.h)
	end
	
	-- unset camera
	love.graphics.pop()
	
end)
