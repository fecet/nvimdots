local completion = {}
local use_copilot = require("core.settings").use_copilot

completion["neovim/nvim-lspconfig"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("completion.lsp"),
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		-- {
		-- 	"SmiteshP/nvim-navbuddy",
		-- 	config = require("completion.nav"),
		-- 	dependencies = {
		-- 		{ "SmiteshP/nvim-navic" },
		-- 		"MunifTanjim/nui.nvim",
		-- 	},
		-- },
	},
}
completion["nvimdev/lspsaga.nvim"] = {
	lazy = true,
	-- dev = true,
	event = "LspAttach",
	config = require("completion.lspsaga"),
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
completion["dnlhc/glance.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.glance"),
}
completion["simrat39/symbols-outline.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.symbols-outline"),
}
completion["jose-elias-alvarez/null-ls.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("completion.null-ls"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
}
completion["hrsh7th/nvim-cmp"] = {
	lazy = true,
	event = { "InsertEnter", "CmdlineEnter" },
	config = require("completion.cmp"),
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			-- dependencies = { "rafamadriz/friendly-snippets" },
			dependencies = { "fecet/vim-snippets", dev = true },
			config = require("completion.luasnip"),
		},
		{
			"fecet/luasnips-mathtex-snippets",
			dependencies = {
				"preservim/vim-markdown",
				config = function()
					vim.o.conceallevel = 2
					vim.g.tex_conceal = "abdmgs"
					vim.g.tex_flavor = "latex"
					vim.g.vim_markdown_math = 1
					vim.g.vim_markdown_folding_disabled = 1
					vim.cmd("hi clear conceal")
				end,
			},
			config = function()
				require("luasnip-latex-snippets").setup({ use_treesitter = true })
			end,
			ft = require("modules.utils.constants").markdown_family,
			dev = true,
		},
		{ "onsails/lspkind.nvim" },
		{ "lukas-reineke/cmp-under-comparator" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "andersevenrud/cmp-tmux" },
		{ "hrsh7th/cmp-path" },
		{ "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-buffer" },
		{ "kdheepak/cmp-latex-symbols" },
		{ "ray-x/cmp-treesitter" },
		{ "hrsh7th/cmp-cmdline" },
		-- { "tzachar/cmp-tabnine", build = "./install.sh", config = require("completion.tabnine") },
		-- {
		-- 	"jcdickinson/codeium.nvim",
		-- 	dependencies = {
		-- 		"nvim-lua/plenary.nvim",
		-- 		"MunifTanjim/nui.nvim",
		-- 	},
		-- 	config = require("completion.codeium"),
		-- },
	},
}
if use_copilot then
	completion["zbirenbaum/copilot.lua"] = {
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = require("completion.copilot"),
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = require("completion.copilot-cmp"),
			},
		},
	}
end

return completion
