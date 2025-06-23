-- Load default values
function love.load()
    math.randomseed(os.time())

    d1 = 0
    d2 = 0
    colliderToggle = false

    require("src/startup/gameStart")
    gameStart()
    require("src/ui/menu/transition")

    createNewSave()

    loadMap("menu")
end

-- Update load values
function love.update(dt)
    if not transition.active then
        updateAll(dt)
    end
end

-- Draw with default values
function love.draw()
    drawBeforeCamera()
    transition:draw()

    if gamestate > 0 then
        cam:attach()
            drawCamera()
            if colliderToggle then
                world:draw()
            end
        cam:detach()
    end

    drawAfterCamera()
end

function love.keypressed(key)
    if key == 'escape' then
        if gamestate > 0 then
            gamestate = 0
            menu.activeMenu = "main"
            menu.selection = 1
        elseif menu.activeMenu ~= "main" then
            menu.activeMenu = "main"
            menu.selection = 1 
        else
            love.event.quit()
        end
        return
    end

    if key == 'f11' then
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
    end

    if gamestate == 0 then
        if key == "z" or key == "up" or key == "s" or key == "down" or key == "q" or key == "left" or key == "d" or key == "right" or key == "return" or key == "space"  then
            if menu.activeMenu == "main" and not transition.active then
                menu:select(key)
            elseif menu.activeMenu == "new_game" or menu.activeMenu == "continue" then
                menuSave:select(key)
            end
        end
    end
end

function love.mousepressed(x, y, button)
    if gamestate == 0 then
        if menu.activeMenu == "main" then
            menu:mousepressed(x, y, button)
        elseif menu.activeMenu == "new_game" or menu.activeMenu == "continue" then
            menuSave:mousepressed(x,y,button)
        end
    end
end