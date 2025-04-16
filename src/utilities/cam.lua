Camera = require "libraries/hump/camera"
cam = Camera(0,0, scale)

function cam:update(dt)

    local camX, camY = player:getPosition()

    local w = love.graphics.getWidth() / scale
    local h = love.graphics.getHeight() / scale

    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight

    --left
    if camX < w/2 then
        camX = w/2
    end

     --right
     if camY < h/2 then
        camY = h/2
    end

     --top
     if camX > (mapW - w/2) then
        camX = (mapW - w/2)
    end

     --bot
     if camY > (mapH - h/2) then
        camY = (mapH - h/2)
    end
    
    cam:lockPosition(camX, camY)

    cam.x, cam.y = cam:position()

end