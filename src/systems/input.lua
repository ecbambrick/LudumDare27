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
		e.input.timer = e.input.timer < e.input.limit and e.input.timer + dt or e.input.timer
		if love.keyboard.isDown("up") then
			if e.physics and e.physics.onGround then
				e.vel.y = -1000
			end
		elseif e.vel.y < -50 then
			e.vel.y = -50
		end
		if love.keyboard.isDown("left")  then e.vel.x = -1000 e.pos.dx = -1 end
		if love.keyboard.isDown("right") then e.vel.x = 1000  e.pos.dx =  1 end
		if love.keyboard.isDown("escape") and Timer then Timer.count = 0 end
		if love.keyboard.isDown(" ") and e.input.timer > e.input.limit
		and e.class and e.class.class[2] == "wizard" then
			secs.entity.projectile(e.pos.x,e.pos.y,e.pos.dx)
			e.input.timer = 0
		end
	end
	
	-- selector input
	if Selector and Group then
		local e = Selector
		e.selector.count = e.selector.count - dt
		if e.selector.count <= 0 then
			if e.selector.count <= 0 then e.selector.count = 0 end
			if love.keyboard.isDown("left") then
				e.selector.index = e.selector.index == 1 and #Group.group or e.selector.index - 1
				e.selector.count = e.selector.limit
			end
			if love.keyboard.isDown("right") then
				e.selector.index = e.selector.index % #Group.group + 1
				e.selector.count = e.selector.limit
			end
			if love.keyboard.isDown("up") then
				local class = Group.group[e.selector.index]
				class[1] = class[1] % #Classes + 1
				class[2] = Classes[class[1]]
				e.selector.count = e.selector.limit
			end
			if love.keyboard.isDown("down") then
				local class = Group.group[e.selector.index]
				class[1] = class[1] == 1 and #Classes or class[1] - 1
				class[2] = Classes[class[1]]
				e.selector.count = e.selector.limit
			end
			if love.keyboard.isDown("return") then
				Selector = nil
				Timer = { count = 10, active = true }
				Player = secs.entity.player(16*7.5, 16*-1, table.remove(Group.group, 1))
				Camera = secs.entity.camera(Player.pos)
				Camera.camera.x2 = Map.stage.map.tileWidth * Map.stage.map.width
				Camera.camera.y2 = Map.stage.map.tileHeight * Map.stage.map.height
			end
		end
	end
	
	-- system input
	if  love.keyboard.isDown("lalt") and love.keyboard.isDown("f4") then
		love.event.quit()
	end
	
end)
