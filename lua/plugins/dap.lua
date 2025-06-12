


require("dapui").setup({
	layouts = {
		{
			elements = {

				{ id = "stacks", size = 0.1 },
				-- { id = "watches", size = 0.0 }
				{ id = "breakpoints", size = 0.1 },

				{ id = "scopes", size = 0.8 }, -- 25% ширины
        -- прогружаются объекты сверху вниз, то есть scopes будут сверху, а стеки снизу
			},
			position = "right", -- Слева
			size = 70, -- Ширина 40 колонок
		},
		{
			elements = {
				{ id = "repl", size = 0.5 }, -- REPL (терминал) займёт 90% высоты
				{ id = "console", size = 0.5 }, -- Консоль — 10%
			},
			position = "bottom", -- Внизу
			size = 12, -- Высота 20 строк
		},
	},
  automatic_close = true
})
