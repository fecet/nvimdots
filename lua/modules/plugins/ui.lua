local ui = {}

-- ui["goolord/alpha-nvim"] = {
-- 	lazy = true,
-- 	event = "BufWinEnter",
-- 	config = require("ui.alphas"),
-- }
ui["glepnir/dashboard-nvim"] = {
	lazy = true,
	event = "VimEnter",
	config = require("ui.dashboard"),
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}

ui["akinsho/bufferline.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.bufferline"),
}
ui["catppuccin/nvim"] = {
	lazy = false,
	dev = true,
	-- branch = "refactor/syntax-highlighting",
	name = "catppuccin",
	config = require("ui.catppuccin"),
}
-- ui["folke/tokyonight.nvim"] = {
-- 	lazy = false,
-- }
ui["sainnhe/edge"] = {
	lazy = true,
	config = require("ui.edge"),
}
ui["j-hui/fidget.nvim"] = {
	lazy = true,
	branch = "legacy",
	event = "LspAttach",
	config = require("ui.fidget"),
}
ui["lewis6991/gitsigns.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.gitsigns"),
}
ui["lukas-reineke/indent-blankline.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("ui.indent-blankline"),
}
ui["nvim-lualine/lualine.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.lualine"),
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"meuter/lualine-so-fancy.nvim",
	},
}
ui["zbirenbaum/neodim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("ui.neodim"),
}
-- ui["karb94/neoscroll.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	config = require("ui.neoscroll"),
-- }
ui["shaunsingh/nord.nvim"] = {
	lazy = true,
	config = require("ui.nord"),
}
ui["rcarriga/nvim-notify"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}
-- ui["folke/paint.nvim"] = {
-- 	lazy = true,
-- 	event = { "CursorHold", "CursorHoldI" },
-- 	config = require("ui.paint"),
-- }
-- ui["dstein64/nvim-scrollview"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	config = require("ui.scrollview"),
-- }
-- ui["edluffy/specs.nvim"] = {
-- 	lazy = true,
-- 	event = "CursorMoved",
-- 	config = require("ui.specs"),
-- }
ui["fecet/fortune.nvim"] = {
	lazy = true,
	dev = true,
}
ui["folke/edgy.nvim"] = {
	event = "VeryLazy",
	-- opt = {},
	config = require("ui.edgy"),
}
ui["HampusHauffman/block.nvim"] = {
	lazy = true,
	-- event = { "CursorHold", "CursorHoldI" },
	cmd = { "Block" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
ui["letieu/hacker.nvim"] = {
	dev = true,
	lazy = true,
	cmd = { "HackAuto", "HackFollowAuto" },
	config = function()
		require("hacker").setup({ is_popup = true })
	end,
}

return ui
