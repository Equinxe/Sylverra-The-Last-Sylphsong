sprites = {}
sprites.playerSheet = love.graphics.newImage('sprites/player/character.png')







sprites.environment = {}
sprites.environment.breakableRock = love.graphics.newImage('sprites/environment/breakableRock.png') 
sprites.environment.breakableWall = love.graphics.newImage('sprites/environment/breakableWall.png')
sprites.environment.lockedDoor = love.graphics.newImage('sprites/environment/lockedDoor.png')




sprites.ui = {}
sprites.ui.menuBackground = love.graphics.newImage('sprites/ui/Sylverra-no-menu.png')
sprites.ui.menuSave = love.graphics.newImage('sprites/ui/Save-no-text.png')

function initFonts()
    fonts = {}
    
    -- Fonts existantes
    fonts.pause1 = love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 12*scale)
    
    -- Nouvelles fonts pour le menu
    fonts.title = love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 18*scale)
    fonts.menu = love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 12*scale)
    fonts.small = love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 5*scale)
    fonts.runes = love.graphics.newFont("fonts/tengwar_annatar/tngan.ttf" , 12*scale)
end
initFonts() 