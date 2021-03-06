--mainmenu.lua

local Game = require 'game'

local MainMenu = Game:addState('MainMenu')

function MainMenu:enteredState()
	self:log('Entered Main Menu')
end

function MainMenu:exitedState()
	self:log('Exited Main Menu')
end

function MainMenu:draw()
	love.graphics.print('Main Menu\nPress p to play the game!')
end

function MainMenu:keypressed(key)
	if key == 'p' then
		self:gotoState('Play')
	end
	if key == 'escape' then
		self:exit()
	end
end

return MainMenu
