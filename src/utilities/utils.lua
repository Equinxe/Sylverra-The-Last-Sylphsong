function setWhite()
    love.graphics.setColor(1, 1, 1, 1)
end




string.startswith = function(self, str) 
    return self:find('^' .. str) ~= nil
end