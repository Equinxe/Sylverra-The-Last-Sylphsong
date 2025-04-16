-- adding all function here

function requireAll()

    require("src/startup/collisionClasses")
    createCollisionClasses()

    require("src/startup/resources")
    require("src/startup/data")

    require("src/utilities/cam")
    require("src/utilities/misc")
    require("src/utilities/utils")

    require("src/player")
    require("src/update")
    require("src/draw")

    require("src/environment/water")

    require("src/levels/loadMap")
    require("src/levels/transition")
    require("src/levels/wall")


    require("src/ui/menu")
end
