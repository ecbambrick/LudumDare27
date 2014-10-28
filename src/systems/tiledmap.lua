local AdvancedTiledLoader = require("lib.AdvTiledLoader.loader")
local loadTiledMap, loadEntities, unloadTiledMap, unloadEntities

--[[
Load and unload tiled maps with AdvancedTiledLoader
--]]
secs.updatesystem("tiledmap", 50, function(dt)
	local e = Map
	if e then
		if e.stage.unload and e.stage.map then
			unloadTiledMap(e.stage)
		end
		if e.stage.load and not e.stage.map then
			loadTiledMap(e.stage)
			loadEntities(e.stage)
		end
	end
end)

---------------------------------------------------------- TILED MAP MANAGEMENT

-- load tiled map file and entities
function loadTiledMap(stage)
    stage.map = AdvancedTiledLoader.load(stage.path)
    stage.map.drawObjects = false
    stage.load = false
	
	local camera = Camera
	if camera then
		camera.camera.x2 = stage.map.width * stage.map.tileWidth
		camera.camera.y2 = stage.map.height * stage.map.tileHeight
	end
end

-- unload tiled map and destroy map entities
function unloadTiledMap(stage)
	stage.unload = false
	stage.map = nil
	unloadEntities(stage)
end

------------------------------------------------------------- ENTITY MANAGEMENT

-- create an entity for each entity-layer object in the map
function loadEntities(stage)
	for i,entity in ipairs(stage.map("entities").objects) do
		if entity.type then
			local e = secs.entity[entity.type](entity.x, entity.y)
			secs.attach(e, "actor")
		end
	end
end

-- destroy each entity created by the map
function unloadEntities(stage)
	for e in pairs(secs.query("actors")) do
		secs.delete(e)
	end
end
