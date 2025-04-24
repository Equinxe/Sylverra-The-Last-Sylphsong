menu = {}
menu.selection = 1
menu.activeMenu = "main"
menu.options = {
    main = {"New Game", "Continue", "Options", "Quit"},
    new_game = {"File 1", "File 2", "File 3", "Back"},
    continue = {"File 1", "File 2", "File 3", "Back"}
}

menu.buttonPositions = {
    main = {
        {x = window_Width * 0.85, y = window_Height * 0.35, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.45, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.55, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.65, width = 400, height = 40}
    },
    new_game = {
        {x = window_Width * 0.85, y = window_Height * 0.35, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.45, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.55, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.65, width = 400, height = 40}
    },
    continue = {
        {x = window_Width * 0.85, y = window_Height * 0.35, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.45, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.55, width = 400, height = 40},
        {x = window_Width * 0.85, y = window_Height * 0.65, width = 400, height = 40}
    }
}

function menu:load()
    menu.background = love.graphics.newImage('sprites/ui/Sylverra-no-menu.png')
    menu.pulseTimer = 0 
end

function menu:draw()
    local currentMenu = menu.activeMenu
    
    love.graphics.setColor(1, 1, 1, 1)

    local bgImage = currentMenu == "main" and menu.background or menu.saveBackground
    local bgScale = math.max(window_Width / bgImage:getWidth(), window_Height / bgImage:getHeight())
    
    love.graphics.draw(bgImage, window_Width / 2, window_Height / 2, 0, bgScale, bgScale, bgImage:getWidth() / 2, bgImage:getHeight() / 2)

    love.graphics.setFont(fonts.title)
    
    local title = currentMenu ~= "main" and string.upper(currentMenu) or ""
    love.graphics.printf(title, 0, window_Height * 0.1, window_Width, "center")

    love.graphics.setFont(fonts.menu)
    for i, option in ipairs(menu.options[currentMenu]) do
        local r, g, b, a = 0.8, 0.8, 0.8, 1
        if i == menu.selection then
            local pulse = 0.3 + 0.7 * math.abs(math.sin(menu.pulseTimer))
            r, g, b = 1 * pulse, 0.9 * pulse, 0.5 * pulse
        end

        love.graphics.setColor(r, g, b, a)
        local pos = menu.buttonPositions[currentMenu][i]
        love.graphics.printf(option, pos.x - pos.width / 2, pos.y - pos.height / 2, pos.width, "center")
    end
end

function menu:update(dt)
    if gamestate == 0 then 
        menu.pulseTimer = menu.pulseTimer + dt * 3
    end
end

function menu:select(key)
    if gamestate ~= 0 then return end

    if key == "up" or key == "z" then
        menu.selection = menu.selection - 1
        if menu.selection < 1 then menu.selection = #menu.options[menu.activeMenu] end
    elseif key == "s" or key == "down" then
        menu.selection = menu.selection + 1
        if menu.selection > #menu.options[menu.activeMenu] then menu.selection = 1 end
    elseif key == "return" or key == "space" then
        self:executeSelection()
    end
end

function menu:executeSelection()
    if menu.activeMenu == "main" then
        if menu.selection == 1 then
            menu.activeMenu = "new_game"
            menu.selection = 1
        elseif menu.selection == 2 then
            menu.activeMenu = "continue"
            menu.selection = 1
        elseif menu.selection == 3 then
            menu.activeMenu = "options"
            menu.selection = 1
        elseif menu.selection == 4 then
            love.event.quit()
        end
    elseif menu.activeMenu == "new_game" or menu.activeMenu == "continue" then
        if menu.selection == 4 then
            menu.activeMenu = "main"
            menu.selection = 1
        else
            startGameOrLoad(menu.selection)
        end
    end
end

function startGameOrLoad(fileIndex)
    -- Charge ou démarre le jeu en fonction de l'index du fichier
    if menu.activeMenu == "new_game" then
        startFresh(fileIndex)
    elseif menu.activeMenu == "continue" then
        loadGame(fileIndex)
    end
    gamestate = 1
end

function menu:mousepressed(x, y, button)
    if gamestate ~= 0 or button ~= 1 then return end

    for i, pos in ipairs(menu.buttonPositions[menu.activeMenu]) do
        if x >= pos.x - pos.width / 2 and x <= pos.x + pos.width / 2 and y >= pos.y - pos.height / 2 and y <= pos.y + pos.height / 2 then
            menu.selection = i
            self:executeSelection()
            return
        end
    end
end

menu:load()