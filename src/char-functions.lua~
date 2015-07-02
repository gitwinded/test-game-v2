-- char-functions.lua
-- defines moving and drawing the character in exploration view

require 'map-functions'

local Character = class('Character')

Character.moveSpeed = 3
Character.moving = false
Character.timer = 0
Character.iterator = 1
Character.maxIterations = 1
Character.iterations = {}

charPosMessage = 'Example'
buttonMessage = ''

function Character:load(path)
	love.filesystem.load(path)()
end

function round(num) return math.floor(num+.5) end

function Character:create(tileWidth, tileHeight, tilesetPath, quadInfo)

	--initialization:
	self.gridX, self.gridY = 2, 2
	self.dirX, self.dirY = 0,0
	self.actX, self.actY = 200, 200
	self.facing = 'down'

	--from inputs
	self.tileW = tileWidth
	self.tileH = tileHeight
	self.quadInfo = quadInfo
	self.tileset = love.graphics.newImage(tilesetPath)
	self.tileset:setFilter('nearest','nearest')
	self.maxIterations = #self.quadInfo['left']

	local tilesetW, tilesetH = self.tileset:getWidth(), self.tileset:getHeight()

	self.quads = {}

	for name,quadTables in pairs(self.quadInfo) do
		self.quads[name] = {}
		for steps,info in ipairs(quadTables) do
			self.quads[name][steps] = love.graphics.newQuad(info[2], info[3], self.tileW, self.tileH, tilesetW, tilesetH)
		end
	end
end

function Character:move()
	
	local function atNextTile()
		if round(self.actX) == self.gridX * self.tileW then
			if round(self.actY) == self.gridY * self.tileH then
				return true
			end
		end
	end

	love.keyboard.setKeyRepeat(true)
	function self.keypressed(key, isrepeat)
		if atNextTile() and key == 'down' then
			if canMove(self.gridX, self.gridY, key) then
				self.moving = true
				self.dirY = 1
			end
			self.facing = key
		elseif atNextTile() and key == 'up' then
			if canMove(self.gridX, self.gridY, key) then
				self.moving = true
				self.dirY = -1
			end
			self.facing = key
		elseif atNextTile() and key == 'left' then
			if canMove(self.gridX, self.gridY, key) then
				self.moving = true
				self.dirX = -1
			end
			self.facing = key
		elseif atNextTile() and key == 'right' then
			if canMove(self.gridX, self.gridY, key) then
				self.moving = true
				self.dirX = 1
			end
			self.facing = key
		elseif key == 'a' then self.keypressed('left')
		elseif key == 'd' then self.keypressed('right')
		elseif key == 'w' then self.keypressed('up')
		elseif key == 's' then self.keypressed('down')
		end
	end
	charPosMessage = 'x: '..Character.gridX..', y: '..Character.gridY..'\nactX: '..round(Character.actX)..', actY: '..round(Character.actY)..'\nCharacter.gridX: '..Character.gridX..' Character.gridY: '..Character.gridY..'\nCharacter.dirX: '..Character.dirX..' Character.dirY: '..Character.dirY..' Character.timer: '..Character.timer..'\nCharacter.maxIterations: '..Character.maxIterations..'\nCharacter.iterator: '..Character.iterator
end

function Character:loadIterations()
	for i=1, self.maxIterations do
		self.iterations[i] = i / self.maxIterations
	end
end

function Character:update(dt)
	
	self.actX = (self.gridX + self.dirX * self.timer) * self.tileW
	self.actY = (self.gridY + self.dirY * self.timer) * self.tileH

	if self.moving then
		self.timer = self.timer + dt * self.moveSpeed
		if self.timer > 1 then
			self.timer = 0
			self.gridX = self.gridX + self.dirX
			self.gridY = self.gridY + self.dirY
			self.dirX = 0
			self.dirY = 0
			self.moving = false
		end
		for i=1, self.maxIterations do
			if self.timer<self.iterations[i] then self.iterator = i break
			end
		end
	else self.iterator = 1
	end
end

function Character:draw() -- the locals below are only used to clean up the draw() command. They add nothing to the actual block.
	local posX = self.actX+(self.quadInfo[self.facing][1][4])*self.tileW
	local posY = self.actY+(self.quadInfo[self.facing][1][5])*self.tileH
	local scaleX = self.quadInfo[self.facing][1][6]
	local scaleY = self.quadInfo[self.facing][1][7]
	love.graphics.draw(self.tileset, self.quads[self.facing][self.iterator], posX, posY, 0, scaleX, scaleY)
end

return Character
