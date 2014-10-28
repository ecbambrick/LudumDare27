local resolveCollision, updateHitboxCoordinates

---------------------------------------------------------- MAIN UPDATE FUNCTION

--[[
asdasdsad
--]]
secs.updatesystem("collision", 400, function(dt)

	local collidableEntities = secs.query("collidable")
	if Space and Space.spatialhash then
		local space = Space.spatialhash.map
	
		-- update spatial map and hitboxes
		space:clear()
		for e in pairs(collidableEntities) do
			for j,h in ipairs(e.hitboxes) do
				updateHitboxCoordinates(e, h)
				space:insert(h, e, h.x1, h.y1, h.x2, h.y2)
			end
		end
		
		-- check for collisions
		for a in pairs(collidableEntities) do
			for j,h1 in ipairs(a.hitboxes) do
				for h2,b in pairs(space:getNearby(h1.x1, h1.y1, h1.x2, h1.y2)) do	
					if a ~= b
					and h1.x1 < h2.x2 and h1.x2 > h2.x1 
					and h1.y1 < h2.y2 and h1.y2 > h2.y1 then
						resolveCollision(a, b, h1.type, h2.type, dt)
					end
				end
			end
		end
		
		-- update hitboxes
		for e in ipairs(collidableEntities) do
			for j,h in ipairs(e.hitboxes) do
				updateHitboxCoordinates(e, h)
			end
		end
	end
	
end)

-------------------------------------------------------------- HELPER FUNCTIONS

function updateHitboxCoordinates(e, hitbox)
	if e.pos.dx >= 0 then
		hitbox.x1 = e.pos.x + hitbox.offsetX
	else
		hitbox.x1 = e.pos.x - hitbox.offsetX - hitbox.width + e.pos.w
	end
	if e.pos.dy >= 0 then
		hitbox.y1 = e.pos.y + hitbox.offsetY
	else
		hitbox.y1 = e.pos.y - hitbox.offsetY - hitbox.height + e.pos.h
	end
	hitbox.x2 = hitbox.x1 + hitbox.width
	hitbox.y2 = hitbox.y1 + hitbox.height
end

--------------------------------------------------- RESOLUTION HELPER FUNCTIONS

---------------------------------------------------------- COLLISION RESOLUTION

function resolveCollision(a, b, aType, bType, dt)

	if a.input and b.switch and a.input.timer > a.input.limit
	and a.pos.x >= b.pos.x then
		for e in pairs(secs.query("walls")) do
			e.wall.active = not e.wall.active
		end
		a.input.timer = 0
		return
	end

	if a.projectile and b.switch then
		for e in pairs(secs.query("walls")) do
			e.wall.active = not e.wall.active
		end
		secs.delete(a)
		return
	end
	
	if a.projectile and b.crate then
		b.vel.x = (1000 * a.pos.dx)/dt
		secs.delete(a)
		return
	end

	if a.input and b.wall and b.wall.active then
		if not a.physics.onGround
		and a.pos.y + a.pos.h < b.pos.y + 5 and a.vel.y > 0 then
			a.pos.y = b.pos.y - a.pos.h
			a.physics.onGround = true
			a.vel.y = 0
		end
		if a.vel.y < 0 and a.pos.y > b.pos.y then
			a.pos.y = b.pos.y + b.pos.h
			a.vel.y = 0
			return
		end
		if a.pos.x < b.pos.x and a.pos.y + a.pos.h ~= b.pos.y then
			a.pos.x = b.pos.x - a.pos.w
		end 
		if a.pos.x > b.pos.x and a.pos.y + a.pos.h ~= b.pos.y then
			a.pos.x = b.pos.x + b.pos.w
		end
	end

	if a.input and b.crate then
		if not a.physics.onGround
		and a.pos.y + a.pos.h < b.pos.y + 5 and a.vel.y > 0 then
			a.pos.y = b.pos.y - a.pos.h
			a.physics.onGround = true
			a.vel.y = 0
		elseif a.pos.x < b.pos.x then
			a.pos.x = b.pos.x - a.pos.w
			if a.physics.onGround and a.class and a.class.class[1] == 1
			and a.pos.y + a.pos.h == b.pos.y + b.pos.h then
				b.vel.x = (a.pos.x + a.pos.w - b.pos.x + 16*dt)/dt
			end
		elseif a.pos.x > b.pos.x then
			a.pos.x = b.pos.x + b.pos.w
			if a.physics.onGround and a.class and a.class.class[1] == 1
			and a.pos.y + a.pos.h == b.pos.y + b.pos.h then
				b.vel.x = -(a.pos.x - b.pos.x - b.pos.w + 16*dt)/dt
			end
		end
	end
	
	if a.input and b.treasure then
		secs.attach(a, "rich")
		coroutine.resume(coroutine.create(function(b, dt)
			local timer = 0
			get = secs.entity(
				{ "pos", { x = b.pos.x - 8, y = b.pos.y }},
				{ "color", { rgb = { 255,255,255,255 }}},
				{ "sprite", { sprite = Sprites.getMessage }}
			)
			b.sprite.sprite = Sprites.treasureActive
			secs.detach(b, "hitboxes", "vel")
			while timer < 40 do
				if timer == 5 then
					secs.delete(b)
				end
				get.color.rgb[4] = get.color.rgb[4] - 255/40
				get.pos.y = get.pos.y - 0.4 / (timer+1)*15
				timer = timer + 1
				wait(1/40)
			end
			secs.delete(get)
		end), b, dt)
	end

end