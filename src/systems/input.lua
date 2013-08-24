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

secs.updatesystem("playerInput", 100, function(dt)

	-- player input
	for e in pairs(secs.query("controllable")) do
	
		if love.keyboard.isDown("left")  then e.vel.x = -100*dt end
		if love.keyboard.isDown("right") then e.vel.x = 100*dt  end
	
	end
	
	-- system input
	if  love.keyboard.isDown("escape") then
		love.event.quit()
	end
	
end)
