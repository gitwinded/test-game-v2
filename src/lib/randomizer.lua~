--lib/randomizer.lua

Random = class('Randomizer')

function Random:randomizeTable(tableW, tableH, startNum, endNum) 
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

function Random:randomizeSpaces(inputString,startNum,endNum)
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

return Random
