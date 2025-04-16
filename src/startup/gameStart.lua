function gameStart()

    math.randomseed(os.time())
    love.graphics.setBackgroundColor(26/255,26/255,26/255)

    initGlobals()

    love.graphics.setDefaultFilter("nearest", "nearest")

    ---fullscreen----
    fullscreen = true
    test_Window = false
    vertical = false
    setWindowSize(fullscreen,1920,1080)

    if vertical then
        fullscreen = false
        test_Window = true
        setWindowSize(fullscreen, 1360,1920)
    end

    setScale()

--Import--
    --collision--
    vector = require "libraries/hump/vector"
    flux = require "libraries/flux/flux"
    require "libraries/tesound"
    require ("libraries/show")

     --Anime asprite/tileMap--
    anim8 = require('libraries/anim8/anim8')
    sti = require('libraries/Simple-Tiled-Implementation/sti')

    local windfield = require("libraries/windfield")
    world = windfield.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)

   -- particle_World = windfield.newWorld(0,250,false)
    --particle_World.setQueryDebugDrawing(true)

    require("src/startup/require")
    requireAll()
end


function setWindowSize(full, width, height)
    if full then
        fullscreen = true 
        love.window.setFullscreen(true)
        window_Width = love.graphics.getWidth()
        window_Height = love.graphics.getHeight()
    else
        fullscreen = false
        if width == nil or height == nil then
            window_Width = 1920
            window_Height = 1080
        else
            window_Width = width
            window_Height = height
        end
        love.window.setMode( window_Width, window_Height, {resizable = not test_Window} )
    end
end

function initGlobals()
    data = {}

    gamestate = 0
    globalStun = 0 
end

function setScale(input)
    scale = (7.3 / 1200) * window_Height

    if vertical then 
        scale = (7 / 1200) * window_Height
    end

    if cam then
        cam:zoomTo(scale)
    end
end
  
function checkWindowSize()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    if width ~= window_Width or height ~= window_Height then
        reinitSize()
    end
end

function reinitSize()
    window_Width = love.graphics.getWidth()
    window_Height = love.graphics.getHeight()
    setScale()
    --pause:init()
    initFonts()

end
    
   





