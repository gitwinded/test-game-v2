--main.lua
--
--require libs

class		= require 'lib.middleclass'
Stateful	= require 'lib.stateful'

--game and gamestate requires

local Game = require 'game'
require 'gamestates.play'
require 'gamestates.mainmenu'
require 'gamestates.pause'

local game

function love.load()
	game = Game:new()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end

function love.keypressed(key)
	game:keypressed(key)
end
