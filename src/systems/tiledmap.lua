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

local AdvancedTiledLoader = require("lib.AdvTiledLoader.loader")
local loadTiledMap, loadEntities, unloadTiledMap, unloadEntities

--[[
Load and unload tiled maps with AdvancedTiledLoader
--]]
secs.updatesystem("tiledmap", 50, function(dt)
	local e = Map
	if e.stage.unload and e.stage.map then
		unloadTiledMap(e.stage)
	end
	if e.stage.load and not e.stage.map then
		loadTiledMap(e.stage)
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
		camera.camera.x2 = stage.map.width
		camera.camera.y2 = stage.map.height
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
function loadEntities(room, stage)
	for i,entity in ipairs(stage.map("entities").objects) do
		-- ...
	end
end

-- destroy each entity created by the map
function unloadEntities(stage)
	for e in pairs(secs.query("actors")) do
		secs.delete(e)
	end
end
