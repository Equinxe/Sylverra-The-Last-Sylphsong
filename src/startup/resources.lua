sprites = {}
sprites.playerSheet = love.graphics.newImage('sprites/player/character.png')
sprites.playerShadow = love.graphics.newImage('sprites/player/playerShadow.png')







sprites.environment = {}
sprites.environment.breakableRock = love.graphics.newImage('sprites/environment/breakableRock.png') 
sprites.environment.breakableWall = love.graphics.newImage('sprites/environment/breakableWall.png')
sprites.environment.lockedDoor = love.graphics.newImage('sprites/environment/lockedDoor.png')




sprites.ui = {}
sprites.ui.startScreen = love.graphics.newImage('sprites/ui/Sylverra-no-menu.png')

function initFonts()
    fonts = {}
    fonts.pause1 = love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 12*scale)
end
initFonts()