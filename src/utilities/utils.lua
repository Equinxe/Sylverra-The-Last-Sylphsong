function setWhite()
    love.graphics.setColor(1, 1, 1, 1)
end




string.startswith = function(self, str) 
    return self:find('^' .. str) ~= nil
end




function formatPlayTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local remainingSeconds = math.floor(seconds % 60)
    
    return string.format("%02d:%02d:%02d", hours, minutes, remainingSeconds)
end



function tableToString(tbl)
    local result = "return {"
    
    for k, v in pairs(tbl) do
        if type(k) == "string" then
            result = result .. '["' .. k .. '"]='
        else
            result = result .. "[" .. k .. "]="
        end
        
        if type(v) == "table" then
            result = result .. tableToString(v)
        elseif type(v) == "string" then
            result = result .. '"' .. v .. '"'
        elseif type(v) == "number" or type(v) == "boolean" then
            result = result .. tostring(v)
        end
        
        result = result .. ","
    end
    
    result = result .. "}"
    return result
end



function stringToTable(str)
    local func = loadstring(str)
    if func then
        return func()
    end
    return nil
end