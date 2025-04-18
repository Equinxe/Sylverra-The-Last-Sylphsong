menu = {}
menu.selection = 1 
menu.activeMenu = "main"
menu.options = {
    main = {"New Game", "Continue", "Options", "Quit"},
    new_game = {"File 1", "File 2", "File 3", "Back"},
    continue = {"File 1", "File 2", "File 3", "Back"},
    options = {"Sounds: ON", "Music: ON", "Fullscreen: ON", "Back"}
}

menu.clickTime = 0 
menu.lastClickOption = nil 
menu.doubleClickDelay = 0.3 
menu.pulseTimer = 0 


menu.buttonPositions = {
    main = {
        {x = window_Width * 0.85, y = window_Height * 0.35, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.45, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.55, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.65, width = 400, height = 40}
    }
}


function menu:load()
    menu.background = love.graphics.newImage('sprites/ui/menu_background.png') -- Chemin de votre image sans texte
    
    local baseY = window_Height * 0.25
    local spacing = 60 * scale
    
    menu.buttonPositions.new_game = {}
    menu.buttonPositions.continue = {}
    menu.buttonPositions.options = {}
    
    for i = 1, 4 do
        menu.buttonPositions.new_game[i] = {
            x = window_Width / 2, 
            y = baseY + (i-1) * spacing, 
            width = 300, 
            height = 40
        }
        menu.buttonPositions.continue[i] = {
            x = window_Width / 2, 
            y = baseY + (i-1) * spacing, 
            width = 300, 
            height = 40
        }
        menu.buttonPositions.options[i] = {
            x = window_Width / 2, 
            y = baseY + (i-1) * spacing, 
            width = 300, 
            height = 40
        }
    end
end

function menu:draw()
    if gamestate == 0 then 
        -- draw image
        local bgScale = math.max(window_Width / menu.background:getWidth(), 
                                window_Height / menu.background:getHeight())
        love.graphics.draw(menu.background, 
                            window_Width/2, window_Height/2, 
                            0, bgScale, bgScale, 
                            menu.background:getWidth()/2, 
                            menu.background:getHeight()/2)

        love.graphics.setFont(fonts.title)
        love.graphics.setColor(1, 0.9, 0.5, 1)
    
        if menu.activeMenu ~= "main" then
            local title = string.upper(menu.activeMenu)
            love.graphics.printf(title, 0, window_Height * 0.1 , window_Width, "center")
        end

        love.graphics.setFont(fonts.menu)

        for i, option in ipairs(menu.options[menu.activeMenu]) do 
           local r,g,b,a = 0.8, 0.8, 0.8, 1
           if i == menu.selection then
            local pulse = 0.3 + 0.7 * math.abs(math.sin(menu.pulseTimer))
            r,g,b = 1 * pulse, 0.9 * pulse, 0.5 * pulse
            end

            love.graphics.setColor(r,g,b,a)


            local pos = menu.buttonPositions[menu.activeMenu][i]
            love.graphics.printf(option, pos.x - pos.width / 2 , pos.y - pos.height / 2 , pos.width, "center")

            --if i == menu.selection then 
               -- love.graphics.setLineWidth(2)
                --love.graphics.rectangle("line", pos.x - pos.width / 2 - 10 , pos.y - pos.height / 2 - 5 ,
                                        --pos.width + 20 , pos.height + 10)
            --end
        end

        love.graphics.setFont(fonts.small)
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.printf("Utilisez ZQSD ou les flèches pour naviguer",
                            0, window_Height - 10 * scale, window_Width, "center" )
        love.graphics.printf("Appuyez sur Espace ou Entrée pour sélectionner",
                            0, window_Height - 20 * scale, window_Width, "center")
    end
end

function menu:update(dt)
    if gamestate == 0 and menu.clickTime > 0 then
        menu.clickTime = menu.clickTime - dt
        if menu.clickTime < 0 then
            menu.clickTime = 0 
            menu.lastClickOption = nil
        end
    end
    menu.pulseTimer = (menu.pulseTimer + dt * 2) % (2 * math.pi)
end


function menu:select(key)
    if gamestate ~= 0 then return end 
    
    if key == "up" or key == "z" then
        --Navigate
        menu.selection = menu.selection - 1 
        if menu.selection < 1 then menu.selection = #menu.options[menu.activeMenu] end 
        -- adding sound

    elseif key == "s" or key == "down" then 
         menu.selection = menu.selection + 1 
        if menu.selection > #menu.options[menu.activeMenu] then menu.selection = 1 end
        -- adding sound

    elseif key == "return" or key == "space" then
        self:executeSelection()
        --adding sound
    end
end


function menu:executeSelection()
    if menu.activeMenu == "main" then
        if menu.selection == 1 then
            menu.activeMenu = "new_game"
            menu.selection =  1 
        elseif menu.selection == 2 then 
            menu.activeMenu = "continue"
            menu.selection = 1 
        elseif menu.selection == 3 then
            menu.activeMenu = "options"
            menu.selection = 1 
        elseif menu.selection == 4 then
            love.event.quit()
        end
    elseif menu.activeMenu == "new_game" then 
        if menu.selection == 4 then
            menu.activeMenu = "main"
            menu.selection = 1 
        else
            startFresh(menu.selection)
            if data.map and string.len(data.map) > 0 then 
                loadMap(data.map, data.playerX, data.playerY)
                gamestate = 1 
            end
        end
    elseif menu.activeMenu == "continue" then 
        if menu.selection == 4 then 
            menu.activeMenu = "main"
            menu.selection = 1 
        else
            local message = loadGame(menu.selection)
            if message then 
                print(message)
            else
                if data.map and string.len(data.map) > 0 then
                    loadMap(data.map, data.playerX, data.playerY)
                    gamestate = 1 
                end
            end
        end
    elseif menu.activeMenu == "options" then 
        if menu.selection == 4  then
            menu.activeMenu = "main"
            menu.selection = 1 
        elseif menu.selection == 1 then -- sound
            --sound and data
            menu.options.options[1] = "Sound: " .. (data.sound and "ON" or "OFF")
        elseif menu.selection == 2 then -- music
            --toggle music
            --data.music = not data.music
            menu.options.options[2] = "Music: " .. (data.music and "ON" or "OFF")
        elseif menu.selection == 3 then -- fullscreen
            if fullscreen then 
                local new_Width = 1920 
                local new_Height = 1080
                local fractionW = love.graphics.getWidth() * 0.9
                local fractionH = love.graphics.getHeight() * 0.9

                if fractionW < new_Width then
                    new_Width = fractionW
                end
                if fractionH < new_Height then
                    new_Height = fractionH
                end

                setWindowSize(false, new_Width, new_Height)
            else 
                setWindowSize(true)
            end
            reinitSize()
            menu:load()
            menu.options.options[3] = "Fullscreen: " .. (fullscreen and "ON" or "OFF")
        end
    end
end

--Gestion souris 
function menu:mousepressed(x,y,button)
   if gamestate ~= 0 or button ~= 1 then return end

   for i, pos in ipairs(menu.buttonPositions[menu.activeMenu]) do 
        if x >= pos.x - pos.width / 2 and x <= pos.x + pos.width / 2 and
           y >= pos.y - pos.height / 2 and y <= pos.y + pos.height / 2 then

             --double click
            if menu.lastClickOption == i and menu.clickTime > 0 then 
                menu.selection = i
                self:executeSelection()
                menu.clickTime = 0 
                menu.lastClickOption = nil 
                 -- sound TEsound.play("s , "sfx")
            else
                menu.selection = i 
                menu.clickTime = menu.doubleClickDelay
                menu.lastClickOption = i 
                -- sound TEsound
            end

            return
        end
    end
end

menu:load()





