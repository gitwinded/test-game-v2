-- char-functions.lua
-- defines moving and drawing the character in exploration view

require 'map-functions'
--require 'input'

local tileW, tileH, charTileset, charQuads, charQuadInfo
local charGridX, charGridY = 2, 2
local dirX, dirY = 0,0
local charActX, charActY = 200, 200
local charFacing = 'forward'
local charMoveSpeed = 3
local moving = false
local timer = 0
local iterator = 1
local maxIterations = 1
local iterationsTable = {}

charPosMessage = 'Example'
buttonMessage = ''

function loadChar(path)
	love.filesystem.load(path)()
end

function round(num) return math.floor(num+.5) end

function newChar(tileWidth, tileHeight, tilesetPath, charQuadInfoIn)

	tileW = tileWidth
	tileH = tileHeight
	charQuadInfo = charQuadInfoIn
	tileset = love.graphics.newImage(tilesetPath)
	tileset:setFilter('nearest','nearest')
	maxIterations = #charQuadInfo['left']

	local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()

	charQuads = {}

	for name,quadTables in pairs(charQuadInfoIn) do
		charQuads[name] = {}
		for steps,info in ipairs(quadTables) do
			charQuads[name][steps] = love.graphics.newQuad(info[2], info[3], tileW, tileH, tilesetW, tilesetH)
		end
	end
end

function moveChar()
	love.keyboard.setKeyRepeat(true)
	function love.keypressed(key, isrepeat)
		if key == 'escape' then
			love.event.quit()
		elseif key == 's' and atNextTile() then
			if canMove(charGridX, charGridY, 'down') then
				moving = true
				dirY = 1
			end
			charFacing = 'forward'
		elseif key == 'w' and atNextTile() then
			if canMove(charGridX, charGridY, 'up') then
				moving = true
				dirY = -1
			end
			charFacing = 'backward'
		elseif key == 'a' and atNextTile() then
			if canMove(charGridX, charGridY, 'left') then
				moving = true
				dirX = -1
			end
			charFacing = 'left'
		elseif key == 'd' and atNextTile() then
			if canMove(charGridX, charGridY, 'right') then
				moving = true
				dirX = 1
			end
			charFacing = 'right'
		end
	end
	charPosMessage = 'x: '..charGridX..', y: '..charGridY..'\nactX: '..round(charActX)..', actY: '..round(charActY)..'\ncharGridX: '..charGridX..' charGridY: '..charGridY..'\ndirX: '..dirX..' dirY: '..dirY..' timer: '..timer..'\nmaxIterations: '..maxIterations..'\niterator: '..iterator
end

function loadIterations()
	for i=1, maxIterations do
		iterationsTable[i] = i / maxIterations
	end
end

function updateCharPos(timeInt)
	charActX = (charGridX + dirX * timer) * tileW
	charActY = (charGridY + dirY * timer) * tileH

	if moving then
		timer = timer + timeInt * charMoveSpeed
		if timer > 1 then
			timer = 0
			charGridX = charGridX + dirX
			charGridY = charGridY + dirY
			dirX = 0
			dirY = 0
			moving = false
		end
		for i=1, maxIterations do
			if timer<iterationsTable[i] then iterator = i break
			end
		end
	else iterator = 1
	end
end

function drawChar() -- the locals below are only used to clean up the draw() command. They add nothing to the actual block.
	local drawPosX = charActX+(charQuadInfo[charFacing][1][4])*tileW
	local drawPosY = charActY+(charQuadInfo[charFacing][1][5])*tileH
	local drawScaleX = charQuadInfo[charFacing][1][6]
	local drawScaleY = charQuadInfo[charFacing][1][7]
	love.graphics.draw(tileset, charQuads[charFacing][iterator], drawPosX, drawPosY, 0, drawScaleX, drawScaleY)
end

function atNextTile()
	if round(charActX) == charGridX * tileW then
		if round(charActY) == charGridY * tileH then
			return true
		end
	end
end
