--map-functions.lua
--defines creating the map, drawing the map, and feeding to char-functions.lua if a tile has a collision

local Map = class('Map')

function Map:load(path)
	love.filesystem.load(path)()
	-- attention! extra parentheses! check the love.filesystem.load documenataion for why
end

function Map:initialize(tileW, tileH, tilesetPath, tileString, quadInfo, entityInfo, entities)
	Map.tileW = tileW
	Map.tileH = tileH
	Map.tileset = love.graphics.newImage(tilesetPath)
	Map.tileset:setFilter('nearest','nearest')
	Map.entityInfo = entityInfo
	Map.entities = entities
	Map.quadMapInfo = quadInfo

	local tilesetW, tilesetH = self.tileset:getWidth(), self.tileset:getHeight()

	Map.quads = {}

	for _,info in ipairs(Map.quadMapInfo) do
		--info[1] = character, info[2] = collidable, info[3] = x, info[4] = y
		Map.quads[info[1]] = love.graphics.newQuad(info[3], info[4], self.tileW, self.tileH, tilesetW, tilesetH)
	end

	for _,info in ipairs(Map.entityInfo) do
		--info[1] = character, info[2] = x, info[3] = y
		Map.quads[info[1]] = love.graphics.newQuad(info[2], info[3], self.tileW, self.tileH, tilesetW, tilesetH)
	end

	Map.tileTable = {}

	local width = #(tileString:match("[^\n]+"))

	for x=1,width do Map.tileTable[x] = {} end

	local rowIndex,columnIndex = 1,1
	for row in tileString:gmatch("[^\n]+") do
		assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
		columnIndex = 1
		for character in row:gmatch(".") do
			Map.tileTable[columnIndex][rowIndex] = character
			columnIndex = columnIndex + 1
		end
		rowIndex=rowIndex+1
	end
end

function Map:draw()

	for columnIndex,column in ipairs(Map.tileTable) do
		for rowIndex,char in ipairs(column) do
			local x,y = (columnIndex-1)*Map.tileW, (rowIndex-1)*Map.tileH
			love.graphics.draw(Map.tileset, Map.quads[char], x, y)
		end
	end

	for i,entity in ipairs(Map.entities) do
		local name, x, y = entity[1], gridToPixel(entity[3], entity[4])
		love.graphics.draw(Map.tileset, Map.quads[name], x, y)
	end
	local function gridToPixel(mx, my)
		return (mx-1)*Map.tileW, (my-1)*Map.tileH
	end

end

function canMove(x, y, dir)

	local function isMapCollidable(x, y)
		local coll = false
		for i=1,#(Map.quadMapInfo) do
			if Map.quadMapInfo[i][1] == Map.tileTable [x][y] then
				coll = Map.quadMapInfo[i][2]
			end
		end
		return(coll)
	end
	
	local function isEntCollidable(x, y)
		local coll = false
		for i=1,#(Map.entities) do
			if Map.entities[i][3] == x and Map.entities[i][4] == y then
				coll = Map.entities[i][2]
			end
		end
		return(coll)
	end

	local canMove = true

	if dir == 'down' then
		if isMapCollidable(x, y+1) or isEntCollidable(x, y+1) then
				canMove = false end end
	if dir == 'up' then
		if isMapCollidable(x, y-1) or isEntCollidable(x, y-1) then
				canMove = false end end
	if dir == 'left' then
		if isMapCollidable(x-1, y) or isEntCollidable(x-1, y) then
				canMove = false end end
	if dir == 'right' then
		if isMapCollidable(x+1, y) or isEntCollidable(x+1, y) then 
				canMove = false end end
	return(canMove)
end

function onButton(x, y)
	if Map.tileTable[x][y] == '*' then
		return true
	else return false
	end
end

return Map
