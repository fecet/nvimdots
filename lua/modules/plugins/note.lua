local note = {}

note["lukas-reineke/headlines.nvim"] = {
	lazy = true,
	ft = require("modules.utils.constants").markdown_family,
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = require("note.headline"),
}
note["nvim-neorg/neorg"] = {
	lazy = true,
	ft = "norg",
	-- event = { "CursorHold", "CursorHoldI" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-cmp",
		"nvim-lua/plenary.nvim",
		"nvim-neorg/neorg-telescope",
	},
	build = ":Neorg sync-parsers",
	config = require("note.neorg"),
	-- cmd = "Neorg",
}
note["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	-- ft = require("modules.utils.constants").markdown_family,
	cmd = "MarkdownPreviewToggle",
	-- build = ":call mkdp#util#install()",
	init = require("note.mkdp"),
	-- config = require("lang.mkdp"),
}

return note
