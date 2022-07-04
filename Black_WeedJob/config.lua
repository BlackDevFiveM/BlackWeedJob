-- By Black
-- Discord : https://discord.gg/mPqYzkem75
---@author Black.
---@version 1.0

weedshop            = {}

--marker
weedshop.DrawDistance = 100
weedshop.Size         = {x = 0.5, y = 0.5, z = 0.5} 
weedshop.Color        = {r = 251, g = 255, b = 0}
weedshop.Type         = 22


--les items au frigo
weedshop.fridgeitem = {
        {nom = "Weed", prix = 1, item = "weed"},
        {nom = "Pochon de Weed", prix = 1, item = "weed_pooch"},
        {nom = "Splif", prix = 1, item = "splif"}
}

--position des menus et marker
weedshop.pos = {
	vestiaire = {
		position = {x = 378.58, y = -819.36, z = 29.30}
	},

	coffre = {
		position = {x = 376.80, y = -823.84, z = 29.30}
	},

	fridge = {
		position = {x = 380.29, y = -814.75, z = 29.30}
	},

	garage = {
		position = {x = 379.54, y = -834.44, z = 29.29}
	},

	spawnvoiture = {
		position = {x = 378.64, y = -841.61, z = 29.16}
	},

	boss = {
		position = {x = 376.28, y = -826.62, z = 29.30}
	}

}
