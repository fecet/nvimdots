return function()
	require("autoclose").setup({
		keys = {
			["("] = { escape = false, close = true, pair = "()" },
			["["] = { escape = false, close = true, pair = "[]" },
			["{"] = { escape = false, close = true, pair = "{}" },

			[">"] = { escape = true, close = false, pair = "<>" },
			[")"] = { escape = true, close = false, pair = "()" },
			["]"] = { escape = true, close = false, pair = "[]" },
			["}"] = { escape = true, close = false, pair = "{}" },

			['"'] = { escape = true, close = true, pair = '""' },
			["`"] = { escape = true, close = true, pair = "``" },
			["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { "rust" } },
		},
		options = {
			disabled_filetypes = { "big_file_disabled_ft" },
			disable_when_touch = false,
		},
	})

	local bind = require("keymap.bind")
	bind.nvim_load_mapping({
		["i|<C-w>"] = bind.map_cmd(
			"<Esc>:set iskeyword=@,48-57,192-255<CR>a<C-G>u<C-W><Esc>:set iskeyword=@,48-57,_,192-255<CR>a"
		)
			:with_silent()
			:with_noremap()
			:with_desc("editi: delete previous word"),
	})
end
