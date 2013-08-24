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

local resetPlayer, resetStage, nextStage

secs.updatesystem("playerInput", 500, function(dt)
	Timer = Timer - dt
	if Timer < 0 then
		Timer = 10.99
		local livesRemaining = resetPlayer(Player, Group.group)
		if livesRemaining < 0 and Player.pos then
			secs.detach(Player, "pos")
		end
	end
end)

-------------------------------------------------------------- HELPER FUNCTIONS

function resetPlayer(player, group)
	if not ( player.pos and player.sprite and player.class ) then return -1 end
	secs.entity.grave(player.pos.x, player.pos.y)
	if player.rich then
		local t = secs.entity.treasure(player.pos.x, player.pos.y - 16 + player.pos.h)
		t.pos.z = 10
	end
	if #group > 0 then
		local class = table.remove(group, 1)
		player.pos.y = 16*-2
		player.pos.x = 16*7.5
		player.sprite.sprite = Sprites[class]
		player.class.type = class
		coroutine.resume(coroutine.create(function(e,vel)
			vel = secs.detach(player, "vel")[1]
			wait(1)
			secs.attach(e, "vel", vel)
			Timer = 9.999
		end), player, vel)
		return #group
	else
		return -1
	end
end

function resetStage() end

function nextStage() end