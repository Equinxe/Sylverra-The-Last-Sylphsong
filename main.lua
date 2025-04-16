--Load default values
function love.load()
    math.randomseed(os.time())

    d1=0
    d2=0
    colliderToggle = false

    require("src/startup/gameStart")
    gameStart()

    createNewSave()

    loadMap("menu")
   
end 

--update load values
function love.update(dt)
    updateAll(dt)
end

--draw with default values
function love.draw()
    drawBeforeCamera()

    cam:attach()
        drawCamera()
        if colliderToggle then
         world:draw()
        end
    cam:detach()

    drawAfterCamera()
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
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
    end

    menu:select(key)
    
end 


function love.mousepressed(x,y,button)
    menu:mousepressed(x,y,button)
end