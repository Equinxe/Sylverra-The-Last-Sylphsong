function loadMap(mapName, destX, destY)

    if destX and destY then 
        player:setPosition(destX,destY)
    end

    loadedMap = mapName
    gameMap = sti("maps/" .. mapName .. ".lua")

    if gameMap.layers["Walls"] then
        for i, obj in pairs(gameMap.layers["Walls"].objects) do
            spawnWall(obj.x, obj.y, obj.width, obj.height, obj.name, obj.type)
        end
    end

    if gameMap.layers["Transitions"] then
        for i, obj in pairs(gameMap.layers["Transitions"].objects) do
            spawnTransition(obj.x,obj.y, obj.width, obj.height, obj.name, obj.properties.destX, obj.properties.destY, obj.type)
        end
    end

    if gameMap.layers["Water"] then
        for i, obj in pairs(gameMap.layers["Water"].objects) do 
            spawnWater(obj.x,obj.y,obj.width,obj.height)
        end
    end
end