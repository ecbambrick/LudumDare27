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
secs.factory("stage", function(filePath, load)
    return secs.entity(
        { "stage", { 
            path = filePath,
            load = load or false
        }}
    )
end)

--[[
the player
--]]
secs.factory("player", function(x, y)
	return secs.entity(
		{ "pos", { x = 10, y = 10, w = 16, h = 16 }},
		{ "hitboxes", {{ type = "active", width = 16, height = 16, offsetX = 0, offsetY = 0 }}},
		{ "physics" },
		{ "input" },
		{ "rect" },
		{ "vel" }
	)
end)
