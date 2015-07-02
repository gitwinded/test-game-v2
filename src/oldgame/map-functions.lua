--map-functions.lua
--defines creating the map, drawing the map, and feeding to char-functions.lua if a tile has a collision

local tileW, tileH, tileset, quads, tileTable, entityInfo, entities, quadMapInfo

function loadMap(path)
	love.filesystem.load(path)()
	-- attention! extra parentheses! check the love.filesystem.load documenataion for why
end

function randomTable(tableW, tableH, startNum, endNum) 
	--[[created to generate random tileStrings of 1-9 grass tiles.
	--When using it, you can't use the visual aspect of generating a tileString.
	--Therefore, went to randomizeSpaces() function instead.]]
	local t = {}
	startNum = startNum or 1
	endNum = endNum or 9
	for y=1, tableH do
		t[y] = {}
		for x=1, tableW do
			t[y][x] = love.math.random(startNum, endNum)
		end
	end
	local result = table.concat(t[1])
	for y=2, tableH do
		result = result..'\n'..table.concat(t[y])
	end
	return result
end

function randomizeSpaces(inputString,startNum,endNum)
	--[[this function is used so that tileString in the map file
	--can be created visually with spaces, and you can randomize
	--grass tiles while still using the map]]
	startNum = startNum or 1
	endNum = endNum or 9
	local randomizedString = inputString
	for i=1, #inputString do
		if randomizedString:sub(i,i) == ' ' then
			before = randomizedString:sub(0,i-1)
			after = randomizedString:sub(i+1)
			newI = love.math.random(startNum, endNum)
			randomizedString = before..newI..after
		end
	end
	return randomizedString
end

function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo, entInfo, entList)
	tileW = tileWidth
	tileH = tileHeight
	tileset = love.graphics.newImage(tilesetPath)
	tileset:setFilter('nearest','nearest')
	entityInfo = entInfo
	entities = entList
	quadMapInfo = quadInfo

	local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()

	quads = {}

	for _,info in ipairs(quadInfo) do
		--info[1] = character, info[2] = collidable, info[3] = x, info[4] = y
		quads[info[1]] = love.graphics.newQuad(info[3], info[4], tileW, tileH, tilesetW, tilesetH)
	end

	for _,info in ipairs(entityInfo) do
		--info[1] = character, info[2] = x, info[3] = y
		quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileW, tileH, tilesetW, tilesetH)
	end

	tileTable = {}

	local width = #(tileString:match("[^\n]+"))

	for x=1,width do tileTable[x] = {} end

	local rowIndex,columnIndex = 1,1
	for row in tileString:gmatch("[^\n]+") do
		assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
		columnIndex = 1
		for character in row:gmatch(".") do
			tileTable[columnIndex][rowIndex] = character
			columnIndex = columnIndex + 1
		end
		rowIndex=rowIndex+1
	end
end

function map2world(mx, my)
	return (mx-1)*tileW, (my-1)*tileH
end

function drawMap()
	for columnIndex,column in ipairs(tileTable) do
		for rowIndex,char in ipairs(column) do
			local x,y = (columnIndex-1)*tileW, (rowIndex-1)*tileH
			love.graphics.draw(tileset, quads[char], x, y)
		end
	end

	for i,entity in ipairs(entities) do
		local name, x, y = entity[1], map2world(entity[3], entity[4])
		love.graphics.draw(tileset, quads[name], x, y)
	end
end

function isMapCollidable(x, y)
	local coll = false
	for i=1,#quadMapInfo do
		if quadMapInfo[i][1] == tileTable [x][y] then
			coll = quadMapInfo[i][2]
		end
	end
	return(coll)
end

function isEntCollidable(x, y)
	local coll = false
	for i=1,#entities do
		if entities[i][3] == x and entities[i][4] == y then
			coll = entities[i][2]
		end
	end
	return(coll)
end

function canMove(x, y, dir)
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

--function onButton(x, y)
--	if tileTable[x][y] == '*' then
--		return true
--	else return false
--	end
--end
