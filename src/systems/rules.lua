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

local resetPlayer, gameOver, nextStage, empty, fadeOut

secs.updatesystem("playerInput", 500, function(dt)
	if Timer and Player and Player.pos and Player.pos.y + Player.pos.h < 0
	and empty(secs.query("treasure")) then
		fadeOut(function()
			local current, new = Map.stage.path
			if current == "assets/stage1.tmx" then new = { "assets/stage2.tmx", {1,1,1} } end
			if current == "assets/stage0.tmx" then new = { "assets/stage2.tmx", {1,1,1} } end
			if current == "assets/stage2.tmx" then new = { "assets/stage3.tmx", {1,1,1} } end
			if current == "assets/stage3.tmx" then new = { "assets/stage4.tmx", {1,1,1} } end
			secs.delete(Map)
			for e in pairs(secs.query("actors")) do
				secs.delete(e)
			end
			if current == "assets/stage4.tmx" then
				secs.delete(Timer)
				secs.delete(Player)
				Map = nil
				Timer = nil
				Player = nil
				secs.entity.title()
				secs.entity.image(Images.instructions, 0, 0)
				secs.entity.image(Images.title, 0, 0)
			else
				Map = secs.entity.stage(new[1], new[2], true)
			end
		end)
	end
	if Timer and Timer.active then
		Timer.count = Timer.count - dt
		if Timer.count < 0 then
			Timer.count = 9.99
			local livesRemaining = resetPlayer(Player, Group.group)
			if livesRemaining < 0 and Player.pos then
				fadeOut(function()
					Map.stage.unload = true
					Map.stage.load = true
				end)
			end
		end
	end
end)

-------------------------------------------------------------- HELPER FUNCTIONS

function resetPlayer(player, group)
	if not ( player.pos and player.sprite and player.class ) then return -1 end
	secs.entity.grave(player.pos.x, player.pos.y)
	if player.rich then
		local t = secs.entity.treasure(player.pos.x, player.pos.y - 16 + player.pos.h)
		secs.attach(t, "actor")
		t.pos.z = 10
	end
	if #group > 0 then
		local class = table.remove(group, 1)
		player.pos.y = 16*-2
		player.pos.x = 16*7.5
		player.sprite.sprite = Sprites[class[2]]
		player.class.class = class
		if player.class.class[2] == "theif" then player.vel.maxX = 150
		else player.vel.maxX = 80 end
		coroutine.resume(coroutine.create(function(e,vel)
			Timer.active = false
			vel = secs.detach(player, "vel")[1]
			wait(1)
			Timer.active = true
			secs.attach(e, "vel", vel)
			Timer.count = 9.999
		end), player, vel)
		return #group
	else
		return -1
	end
end

function fadeOut(callback)
	Timer.active = false
	Timer.count = 0
	secs.delete(Player)
	coroutine.resume(coroutine.create(function()
		local e = secs.entity(
			{ "pos", { x = 0, y = 0, w = WINDOW_WIDTH, h = WINDOW_HEIGHT }},
			{ "color", { rgb = { 0,0,0,0 }}},
			{ "rect", {}}
		)
		local count, limit = 1, 60
		while count < limit do
			count = count + 1
			e.color.rgb[4] = e.color.rgb[4] + 255/limit
			wait(1/limit)
		end
		e.color.rgb[4] = 255
		secs.delete(Player)
		secs.delete(Group)
		secs.delete(Camera)
		callback()
		Group = nil
		Player = nil
		Timer = nil
		Camera = nil
		count, limit = 0, 30
		while count < limit do
			count = count + 1
			e.color.rgb[4] = e.color.rgb[4] - 128/limit
			wait(1/limit)
		end
		secs.delete(e)
		Camera = secs.entity.camera()
		Camera.camera.x2 = Map.stage.map.tileWidth * Map.stage.map.width
		Camera.camera.y2 = Map.stage.map.tileHeight * Map.stage.map.height
		Group = secs.entity.group(unpack(Map.stage.default))
		Selector = secs.entity.selector(Group.group, 2)
	end))
end

function empty(t)
	local i = 0
	for v in pairs(t) do
		i = i + 1
	end
	if i == 0 then return true else return false end
end
