-- char/hero.lua

local imgPath = 'img/ff/hero.png'

local charQuadInfo = {

	left = {
	--	{facing dir	XCoord	YCoord	XPos	YPos	XScale	YScale
		{'left',	16,	0,	-1,	-1,	1,	1	}, -- facing left
		{'left1',	0,	0,	-1,	-1,	1,	1	}, -- walking left step 1
		{'left',	16,	0,	-1,	-1,	1,	1	}, -- facing left
		{'left2',	32,	0,	-1,	-1,	1,	1	}} -- walking left step 2
	,
	right = {
		{'right',	16,	0,	0,	-1,	-1,	1	}, -- facing right
		{'right1',	32,	0,	0,	-1,	-1,	1	}, -- walking right step 1
		{'right',	16,	0,	0,	-1,	-1,	1	}, -- facing right
		{'right2',	0,	0,	0,	-1,	-1,	1	}} -- walking right step 2
	,
	forward = {
		{'forward',	16,	32,	-1,	-1,	1,	1	}, -- facing forward
		{'forward1',	32,	32,	-1,	-1,	1,	1	}, -- walking forward step 1
		{'forward',	16,	32,	-1,	-1,	1,	1	}, -- facing forward
		{'forward2',	0,	32,	-1,	-1,	1,	1	}} -- walking forward step 2
	,
	backward = {
		{'backward',	16,	16,	-1,	-1,	1,	1	}, -- facing backward
		{'backward1',	0,	16,	-1,	-1,	1,	1	}, -- walking backward step 1
		{'backward',	16,	16,	-1,	-1,	1,	1	}, -- facing backward
		{'backward2',	32,	16,	-1,	-1,	1,	1	}} -- walking backward step 2
	,
	status = {
		{'dead',	0,	48,	-1,	-1,	1,	1	}, -- facing forward
		{'surprised',	16,	48,	-1,	-1,	1,	1	}, -- walking forward step 1
		{'tired',	32,	48,	-1,	-1,	1,	1	}} -- walking forward step 2
	}
newChar(16, 16, imgPath, charQuadInfo)
