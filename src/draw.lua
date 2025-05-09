function drawBeforeCamera()
    if gamestate == 0 then 
        if menu.activeMenu == "main" then 
            menu:draw()
        elseif (menu.activeMenu == "new_game" or menu.activeMenu == "continue" ) and menuSave.options[menuSave.activeMenu] then
            menuSave:draw()
        end
    end
end


function drawCamera()

    if gamestate == 0 then return end
    setWhite()

    if gameMap.layers["Background"] then
        gameMap:drawLayer(gameMap.layers["Background"])
    end

    if gameMap.layers["Base"] then
       gameMap:drawLayer(gameMap.layers["Base"]) 
    end

    if gameMap.layers["Objects"] then
        gameMap:drawLayer(gameMap.layers["Objects"])
    end

    if gameMap.layers["Objects2"] then
        gameMap:drawLayer(gameMap.layers["Objects2"])
    end

    if gameMap.layers["Test"] then
        --gameMap:drawLayer(gameMap.layers["Test"])
    end

    walls:draw()
    player:draw()
end

function drawAfterCamera()
    
end