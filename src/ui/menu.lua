menu = {}

function menu:draw()
    if gamestate == 0 then 
        love.graphics.setFont(fonts.pause1)
        love.graphics.setColor(1,1,1,1)
       

        love.graphics.printf("Utilse F12 pour le toggle fullscreen.", love.graphics.getWidth()/2 - 4000, 10 * scale, 8000, "center")
        love.graphics.printf("Utilise Echap pour fermer le menu.", love.graphics.getWidth()/2 - 4000, 22 * scale, 8000, "center")
        love.graphics.printf("Utilise ZQSD pour te deplacer.", love.graphics.getWidth()/2 - 4000, 47 * scale, 8000, "center")
        --love.graphics.printf("Press the Spacebar to roll.", love.graphics.getWidth()/2 - 4000, 59 * scale, 8000, "center")
        love.graphics.printf("Press the Spacebar to start!", love.graphics.getWidth()/2 - 4000, 59 * scale, 8000, "center")
        love.graphics.printf("1.  File #1", love.graphics.getWidth()/2 - 4500, 85 * scale, 8000, "center")
        love.graphics.printf("2.  File #2", love.graphics.getWidth()/2 - 4500, 105 * scale, 8000, "center")
        love.graphics.printf("3.  File #3", love.graphics.getWidth()/2 - 4500, 125* scale, 8000, "center")

        
    end
end

function menu:select(key)
    if gamestate == 0 then
        if key ~= "space" then return end

        startFresh(1)

        if data.map and string.len(data.map) > 0 then 
            loadMap(data.map, data.playerX, data.playerY)
            gamestate =  1
        end

        return
    end
end


