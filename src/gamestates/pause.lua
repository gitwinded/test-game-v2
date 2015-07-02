--pause.lua

local Game = require 'game'

local Pause = Game:addState('Pause')

function Pause:enteredState()
	self:log('Game Paused')
end

function Pause:exitedState()
	self:log('Game Unpaused')
end

function Pause:update(dt)
end

function Pause:draw()
	love.graphics.print('The game is paused!')
end

function Pause:keypressed(key)
	if key == 'return' then
		self:popState('Pause')
	end
end

return Pause
