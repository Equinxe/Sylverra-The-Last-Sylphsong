transitions = {}

function spawnTransition(x, y, width, height, id, destX, destY, transitionType)
    
    local transition = world:newRectangleCollider(x,y ,width, height, {collision_class = "Transition"})
    transition:setType('static')

    transition.id = id
    transition.destX = destX
    transition.destY = destY
    transition.type = 'standard'

    if transitionType then transition.type = transitionType end

    table.insert(transitions, transition)
end

function triggerTransition(id, destX, destY)
    local newMap = "Test01"

    if id == "ToTest01" then
        newMap = "Test01"
    elseif id == "ToTest02" then
        newMap = "Test02"
    elseif id == "ToCave1" then
        newMap = "Cave1"
    elseif id == "ToDungeon1" then
        newMap = "Dungeon1"
    elseif id == "ToMarket1" then 
        newMap = "Market1"
    else 
        newMap = id
    end

    gamestate = 1 
    player:setPosition(destX, destY)

    loadMap(newMap)
end




