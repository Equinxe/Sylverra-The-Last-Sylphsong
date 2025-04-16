function createNewSave(fileNumber)

    data = {}
    data.saveCount = 0
    data.progress = 0
    data.playerX = 0 
    data.playerY = 0 
    data.maxHealth = 4 
    data.money = 0
    data.keys = 0
    data.map = ""

    if fileNumber == nil then fileNumber = 1 end
    data.fileNumber = fileNumber

    data.breakables = {}

    data.chests = {}

end

function saveGame()

    data.saveCount = data.saveCount + 1 
    data.playerX = player:getX()
    data.playerY = player:getY()
    data.map = loadedMap

    if data.fileNumber == 1 then
        love.filesystem.write("file1.lua", table.show(data,"data"))
    elseif data.fileNumber == 2 then
        love.filesystem.write("file2.lua", table.show(data,"data"))
    elseif data.fileNumber == 3 then
        love.filesystem.write("file3.lua", table.show(data,"data"))
    end
end

function loadGame(fileNumber)
    if fileNumber == 1 then
        if love.filesystem.getInfo("file1.lua") ~= nil then
            local data = love.filesystem.load("file1.lua")
            data()
        else
            startFresh(1)
            return "No data found for this Save 1"
        end
    elseif fileNumber == 2 then
        if love.filesystem.getInfo("file2.lua") ~= nil then
            local data = love.filesystem.load("file2.lua")
            data()
        else
            startFresh(2)
            return "No data found for this Save 2"
        end
    elseif fileNumber == 3 then
        if love.filesystem.getInfo("file3.lua") ~= nil then
            local data = love.filesystem.load("file3.lua")
            data()
        else
            startFresh(3)
            return "No data found for this Save 3"
        end
    end
    player.direction = "down"
end

function startFresh(fileNumber)
    createNewSave(fileNumber)
    data.map = "Test01"
    data.playerX = 329
    data.playerY = 239
    player.state = 0 
end