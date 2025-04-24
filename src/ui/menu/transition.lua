transition = {}
transition.active = false
transition.timer = 0
transition.maxTime = 1.2
transition.text = ""
transition.nextMenu = nil
transition.midReached = false

function transition:start(text, nextMenu)
    self.active = true
    self.timer = 0
    self.text = text
    self.nextMenu = nextMenu
    self.midReached = false
end

function transition:update(dt)
    if self.active then
        self.timer = self.timer + dt
        local half = self.maxTime / 2

        if not self.midReached and self.timer >= half then
            -- Changement de menu à mi-transition
            menuSave.activeMenu = self.nextMenu
            menuSave.selection = 1
            self.midReached = true
        end

        if self.timer >= self.maxTime then
            self.active = false
            gamestate = 2 -- nouvel état pour menu_save actif
        end
    end
end

function transition:draw()
    if not self.active then return end

    local alpha = 0
    local half = self.maxTime / 2

    if self.timer <= half then
        alpha = self.timer / half
    else
        alpha = 1 - ((self.timer - half) / half)
    end

    love.graphics.setColor(0, 0, 0, alpha)
    love.graphics.rectangle("fill", 0, 0, window_Width, window_Height)

    if self.text and self.text ~= "" then
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.setFont(fonts.title)
        love.graphics.printf(self.text, 0, window_Height / 2 - 20, window_Width, "center")
    end
end