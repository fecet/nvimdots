local tool = {}

-- tool["tpope/vim-fugitive"] = {
-- 	lazy = true,
-- 	cmd = { "Git", "G" },
-- }
-- only for fcitx5 user who uses non-English language during coding
-- tool["pysan3/fcitx5.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	cond = vim.fn.executable("fcitx5-remote") == 1,
-- 	config = require("tool.fcitx5"),
-- }
tool["kevinhwang91/rnvimr"] = {
	lazy = true,
	cmd = "RnvimrToggle",
	config = require("tool.rnvimr"),
}

-- tool["nvim-tree/nvim-tree.lua"] = {
-- 	lazy = true,
-- 	cmd = {
-- 		"NvimTreeToggle",
-- 		"NvimTreeOpen",
-- 		"NvimTreeFindFile",
-- 		"NvimTreeFindFileToggle",
-- 		"NvimTreeRefresh",
-- 	},
-- 	config = require("tool.nvim-tree"),
-- }
tool["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("tool.smartyank"),
}
tool["michaelb/sniprun"] = {
	lazy = true,
	-- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
	-- if you encountered error about no executable sniprun found.
	build = "bash ./install.sh",
	cmd = "SnipRun",
	config = require("tool.sniprun"),
}
tool["akinsho/toggleterm.nvim"] = {
	lazy = true,
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendVisualLines",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualSelection",
	},
	config = require("tool.toggleterm"),
}
tool["folke/trouble.nvim"] = {
	lazy = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = require("tool.trouble"),
}
tool["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("tool.which-key"),
}
-- tool["gelguy/wilder.nvim"] = {
-- 	lazy = true,
-- 	event = "CmdlineEnter",
-- 	config = require("tool.wilder"),
-- 	dependencies = { "romgrk/fzy-lua-native" },
-- }

tool["ecthelionvi/NeoComposer.nvim"] = {
	lazy = true,
	dependencies = {
		{ "kkharji/sqlite.lua" },
	},
	opts = {
		keymaps = {
			play_macro = "<leader>qp",
			-- yank_macro = "yq",
			-- stop_macro = "cq",
			toggle_record = "<leader>qr",
			cycle_next = "<F23>",
			cycle_prev = "<F22>",
			toggle_macro_menu = "<F24>",
		},
	},
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = "Telescope",
	config = require("tool.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{
			"ahmedkhalf/project.nvim",
			event = { "CursorHold", "CursorHoldI" },
			config = require("tool.project"),
		},
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-frecency.nvim", dependencies = {
			{ "kkharji/sqlite.lua" },
		} },
		{ "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-symbols.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
	},
}

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------
tool["mfussenegger/nvim-dap"] = {
	lazy = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	config = require("tool.dap"),
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = require("tool.dap.dapui"),
		},
		{ "jay-babu/mason-nvim-dap.nvim" },
	},
}
tool["stevearc/oil.nvim"] = {
	lazy = true,
	-- ft = "oil",
	event = "Syntax",
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = require("tool.oil"),
}
tool["AndrewRadev/bufferize.vim"] = {
	lazy = true,
	cmd = "Bufferize",
}

return tool
