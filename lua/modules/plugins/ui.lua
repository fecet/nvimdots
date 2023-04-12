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
	event = "BufReadPost",
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
ui["folke/paint.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.paint"),
}
-- ui["dstein64/nvim-scrollview"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	config = require("ui.scrollview"),
-- }
ui["edluffy/specs.nvim"] = {
	lazy = true,
	event = "CursorMoved",
	config = require("ui.specs"),
}
ui["eandrju/cellular-automaton.nvim"] = {
	lazy = true,
	cmd = "CellularAutomaton",
}
ui["tamton-aquib/zone.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.zone"),
}
ui["letieu/hacker.nvim"] = {
	lazy = true,
    cmd={"Hack","HackFollow"},
	config = require("ui.hack"),
}

return ui
