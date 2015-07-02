-- main.lua

require 'map-functions'
require 'char-functions'

function love.load()
	loadMap('maps/ff-farmhouse.lua')
	loadChar('chars/hero.lua')
	loadIterations()
end

function love.update(dt)
	moveChar()
	updateCharPos(dt)
end

function love.draw()
	love.graphics.scale(2, 2)
	love.window.setTitle("Rogers' Test Game!")
	drawMap()
	drawChar()
	love.graphics.print(charPosMessage, 240, 0)
end
