function updateAll(dt)
    menu:update(dt)

    if menuSave then 
        menuSave:update(dt)
    end
    
    updateGame(dt)

    if gameMap then 
        gameMap:update(dt)
    end

    if gamestate == 1 and data and data.lastSaveTime then 
        data.playTime = data.playTime + dt 
    end
    
    checkWindowSize()
end 


function updateGame(dt)
    miscUpdate(dt)
    if globalStun > 0 then return end 

    flux.update(dt)
    --menu:update(dt)

    player:update(dt)
    world:update(dt)
    walls:update(dt)
    waters:update(dt)
    --etc


    --utilities
    cam:update(dt)

end