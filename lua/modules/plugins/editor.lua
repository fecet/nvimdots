local editor = {}

editor["Pocco81/auto-save.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("editor.autosave"),
}

-- editor["ur4ltz/surround.nvim"] = {
-- 	lazy = true,
-- 	event = "VeryLazy",
-- 	config = require("editor.surround"),
-- }
editor["kylechui/nvim-surround"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("editor.surround"),
}

-- editor["rainbowhxch/accelerated-jk.nvim"] = {
-- 	lazy = true,
-- 	event = "VeryLazy",
-- 	config = require("editor.accelerated-jk"),
-- }
editor["olimorris/persisted.nvim"] = {
	lazy = true,
	cmd = {
		"SessionToggle",
		"SessionStart",
		"SessionStop",
		"SessionSave",
		"SessionLoad",
		"SessionLoadLast",
		"SessionLoadFromFile",
		"SessionDelete",
	},
	config = require("editor.persisted"),
}
editor["m4xshen/autoclose.nvim"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("editor.autoclose"),
}
-- editor["max397574/better-escape.nvim"] = {
-- 	lazy = true,
-- 	event = { "CursorHold", "CursorHoldI" },
-- 	config = require("editor.better-escape"),
-- }
editor["LunarVim/bigfile.nvim"] = {
	lazy = false,
	config = require("editor.bigfile"),
	cond = require("core.settings").load_big_files_faster,
}
editor["ojroques/nvim-bufdel"] = {
	lazy = true,
	cmd = { "BufDel", "BufDelAll", "BufDelOthers" },
}
-- editor["rhysd/clever-f.vim"] = {
-- 	lazy = true,
-- 	event = { "CursorHold", "CursorHoldI" },
-- 	config = require("editor.cleverf"),
-- }
editor["numToStr/Comment.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.comment"),
}
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
}
-- editor["junegunn/vim-easy-align"] = {
-- 	lazy = true,
-- 	cmd = "EasyAlign",
-- }
editor["smoka7/hop.nvim"] = {
	lazy = true,
	version = "*",
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.hop"),
}
editor["RRethy/vim-illuminate"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.vim-illuminate"),
}
editor["romainl/vim-cool"] = {
	lazy = true,
	event = { "CursorMoved", "InsertEnter" },
}
editor["lambdalisue/suda.vim"] = {
	lazy = true,
	cmd = { "SudaRead", "SudaWrite" },
	config = require("editor.suda"),
}
editor["tzachar/highlight-undo.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = function()
		require("highlight-undo").setup({
			hlgroup = "HighlightUndo",
			duration = 300,
			keymaps = {
				{ "n", "u", "undo", {} },
				{ "n", "<C-r>", "redo", {} },
			},
		})
	end,
}

editor["kevinhwang91/nvim-ufo"] = {
	lazy = true,
	event = { "BufReadPost" },
	config = require("editor.ufo"),
	keys = {
		{
			"<leader>zo",
			function()
				require("ufo").openAllFolds()
			end,
		},
		{
			"<leader>zc",
			function()
				require("ufo").closeAllFolds()
			end,
		},
	},
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
					-- foldfunc = "builtin",
					-- setopt = true,
					relculright = true,
					segments = {
						{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					},
				})
			end,
		},
		{ "chrisgrieser/nvim-origami", opts = true, lazy = true },
	},
}
----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["nvim-treesitter/nvim-treesitter"] = {
	-- lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command("TSUpdate")
		end
	end,
	-- event = "BufReadPost",
	config = require("editor.treesitter"),
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "mfussenegger/nvim-treehopper" },
		{ "andymass/vim-matchup" },
		{
			"hiphish/rainbow-delimiters.nvim",
			config = require("editor.rainbow_delims"),
		},
		-- {
		-- 	"nvim-treesitter/nvim-treesitter-context",
		-- 	config = require("editor.ts-context"),
		-- },
		{
			"windwp/nvim-ts-autotag",
			config = require("editor.autotag"),
		},
		{
			"NvChad/nvim-colorizer.lua",
			config = require("editor.colorizer"),
		},
		{
			"abecodes/tabout.nvim",
			config = require("editor.tabout"),
		},
		{
			"nvim-treesitter/playground",
		},
		{ "sustech-data/wildfire.nvim", dev = true, lazy = true },
		{ "ziontee113/syntax-tree-surfer", config = require("editor.surfer") },
		{
			"lukas-reineke/headlines.nvim",
			lazy = true,
			ft = require("modules.utils.constants").markdown_family,
			config = require("note.headline"),
		},
		{ "filNaj/tree-setter" },
	},
}

return editor
