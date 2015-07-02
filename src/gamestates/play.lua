--play.lua

Map = require 'map-functions'
Character = require 'char-functions'

local Game = require 'game'

local Play = Game:addState('Play')

function Play:enteredState()
	self:log('Playing the Game!')
	timer = 0
	Map:load('maps/ff-farmhouse.lua')
	self:log('Loading grassMap')
	Character:load('chars/hero.lua')
	Character:loadIterations()
end

function Play:exitedState()
	grassMap = nil
	self:log('Trashing grassMap')
	self:log('Exiting the Game!')
end

function Play:update(dt)
	Character:move()
	Character:update(dt)
end

function Play:draw()
	love.graphics.scale(2,2)
	grassMap.draw()
	Character:draw()
	love.graphics.print(charPosMessage, 150, 0)
end

function Play:keypressed(key)
	if key == 'escape' then
		self:gotoState('MainMenu')
	elseif key == 'return' then
		self:pushState('Pause')
	else Character.keypressed(key)
	end
end

return Play
