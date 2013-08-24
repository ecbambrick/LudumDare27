local newSpatialMap = require "lib.spatialmap"

--[[
a spatial hash map for organizing physical entities
--]]
secs.factory("spatialmap", function(size)
    return secs.entity(
        { "spatialhash", {
            map = newSpatialMap(size)
        }}
    )
end)

--[[
targets the position component of another entity and takes a set of
x,y coordinates as boundary limits to the camera's movement
--]]
secs.factory("camera", function(target, x1, y1, x2, y2)
    return secs.entity(
        { "pos" },
        { "camera", {
            target = target,
            x1 = x1 or 0,
            y1 = y1 or 0,
            x2 = x2 or WINDOW_WIDTH,
            y2 = y2 or WINDOW_HEIGHT,
        }}
    )
end)

--[[
the map for an area
room is the name of the map room the game is currently focused on
load determines whether or not to load the map on the next frame
--]]
secs.factory("stage", function(filePath, bg, load)
    return secs.entity(
        { "stage", { 
            path = filePath,
            load = load or false,
			background = bg,
        }}
    )
end)

--[[
group
--]]
secs.factory("group", function(...)
	local e = secs.entity({ "group" })
	for i,v in ipairs(arg) do
		table.insert(e.group, v)
	end
	return e
end)


--[[
the player
--]]
secs.factory("player", function(x, y, class)
	local sprite
	if class == "fighter" then sprite = Sprites.fighter
	elseif class == "theif" then sprite = Sprites.theif
	elseif class == "wizard" then sprite = Sprites.wizard
	end
	return secs.entity(
		{ "class", { class = class }},
		{ "pos", { x = x, y = y, w = sprite.w, h = sprite.h }},
		{ "vel", { maxY = 360, maxX = 80 }},
		{ "hitboxes", {{ type = "active", width = sprite.w, height = 16, offsetX = 0, offsetY = sprite.h - 16 }}},
		{ "sprite", { sprite = sprite }},
		{ "physics" },
		{ "input" }
	)
end)

--[[
a crate
--]]
secs.factory("crate", function(x, y)
	return secs.entity(
		{ "pos", { x = x, y = y, w = 16, h = 16 }},
		{ "vel", { maxY = 350 }},
		{ "hitboxes", {{ type = "active", width = 16, height = 16, offsetX = 0, offsetY = 0 }}},
		{ "sprite", { sprite = Sprites.crate }},
		{ "physics" },
		{ "crate" }
	)
end)

--[[
a grave
--]]
secs.factory("grave", function(x, y)
	return secs.entity(
		{ "pos", { x = x, y = y, w = 16, h = 16 }},
		{ "vel", { y = -200 }},
		{ "hitboxes", {{ type = "active", width = 16, height = 16, offsetX = 0, offsetY = 0 }}},
		{ "sprite", { sprite = Sprites.grave }},
		{ "physics" }
	)
end)


--[[
treasure
--]]
secs.factory("treasure", function(x, y)
	return secs.entity(
		{ "pos", { x = x, y = y, w = 16, h = 16 }},
		{ "hitboxes", {{ type = "active", width = 16, height = 16, offsetX = 0, offsetY = 0 }}},
		{ "sprite", { sprite = Sprites.treasure }},
		{ "treasure" },
		{ "physics" },
		{ "vel" }
	)
end)