-- file: /maps/grass.lua

--local tileString = randomTable(15,18,1,9)

local tileStringSimple = [[
---------
|       /
|       /
|       /
|       /
|       /
|    *  /
|       /
|       /
|       /
|       /
|       /
[-------]
]]


local tileString = randomizeSpaces(tileStringSimple)

local quadInfo = {
--	{symbol,coll,	xcoor,	ycoord	},
	{'1',	false,	0,	32	},
	{'2',	false,	16,	32	},
	{'3',	false,	32,	32	},
	{'4',	false,	0, 	48	},
	{'5',	false,	16,	48	},
	{'6',	false,	32,	48	},
	{'7',	false,	0, 	64	},
	{'8',	false,	16,	64	},
	{'9',	false,	32,	64	},
	{'-',	true,	16,	16	},
	{'|',	true,	0,	0	},
	{'/',	true,	32,	0	},
	{'[',	true,	0,	16	},
	{']',	true,	32,	16	},
	{' ',	false,	0,	32	},
	{'*',	false,	32,	80	}
}

local entityInfo = {
--	{entName,	xcoor,	ycoor	},
	{'fenceVert',	0,	0	},
	{'fenceBLcor',	0,	16	},
	{'fenceBRcor',	48,	16	},
	{'fenceHorz',	16,	16	}
}

local entities = {
--	{entName,	coll	xGridC	yGridC	},
--	{'fenceVert',	true,	1,	1	},
--	{'fenceVert',	true,	1,	2	},
--	{'fenceHorz',	true,	2,	1	}
}

newMap(16,16,'img/tiles-map.png', tileString, quadInfo, entityInfo, entities)
