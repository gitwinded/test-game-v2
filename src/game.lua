--game.lua

local Game = class('Game'):include(Stateful)

function Game:initialize()
	self:gotoState('MainMenu')
end

--Include the methods available in all states here

--print ouput in the console

function Game:log(...)
	print(...)
end

function Game:exit()
	self:log('Goodbye!')
	love.event.quit()
end

function Game:update(dt)
end

--by default, exit when escape is pressed. This can be overwritten by other methods

function Game:keypressed(key)
end

return Game
