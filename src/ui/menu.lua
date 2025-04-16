menu = {}
menu.options = {
    newGame = {text = "Nouvelle partie", x = 850 , y = 320 , width = 200, height = 30},
    continue = {text = "Continuer", x = 850, y = 360 , width = 200 , height = 30},
    options = {text = "Options", x = 850 , y = 400 , width = 200, height = 30},
    quit = {text = "Quitter" , x = 850, y = 440, width = 200, height = 30}
}

menu.selectedOption = "newGame"

function menu:draw()
    if gamestate == 0 then 
        -- draw image
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(sprites.ui.startScreen, 0, 0, 0,
                        love.graphics.getWidth() / sprites.ui.startScreen:getWidth(),
                        love.graphics.getHeight() / sprites.ui.startScreen:getHeight())

        local selected = menu.options[menu.selectedOption]
        if selected then
            love.graphics.setColor(1, 1, 0, 0.3)
            love.graphics.rectangle("fill", selected.x, selected.y, selected.width, selected.height)
        end
    end
end

function menu:select(key)
    if gamestate == 0 then
        if key == "up" or key == "z" then
            --Up
            if menu.selectedOption == "newGame" then
                menu.selectedOption = "quit"       
            elseif menu.selectedOption == "continue" then
                menu.selectedOption = "newGame"
            elseif menu.selectedOption == "options" then
                menu.selectedOption = "continue"
            elseif menu.selectedOption == "quit" then
                menu.selectedOption = "options"            
            end
        elseif key == "down" or key == "s" then
            if menu.selectedOption == "newGame" then
                menu.selectedOption = "continue"
            elseif menu.selectedOption == "continue" then
                menu.selectedOption = "options"
            elseif menu.selectedOption == "options" then
                menu.selectedOption = "quit"
            elseif menu.selectedOption == "quit" then
                menu.selectedOption = "newGame"
            end
        elseif key == "enter" or key == "space" then 
            if menu.selectedOption == "newGame" then
                startFresh(1)
                loadMap("Test01", 329,239)
                gamestate = 1 
            elseif menu.selectedOption == "continue" then
                loadGame(1)
                if data.map and string.len(data.map) > 0 then 
                    loadMap(data.map, data.playerX, data.playerY)
                    gamestate = 1 
                end
            elseif menu.selectedOption == "options" then
                print("Options selected")
            elseif menu.selectedOption == "quit" then
                love.event.quit()
            end
        end
    end
end


--Gestion souris 
function menu:mousepressed(x,y,button)
    if gamestate == 0 and button == 1 then
        for option,data in pairs(menu.options) do
            if x >= data.x and x <= data.x + data.width and
               y >= data.y and y <= data.y + data.height then
                menu.selectedOption = option
                menu:select("return")
                break
            end
        end
    end
end




