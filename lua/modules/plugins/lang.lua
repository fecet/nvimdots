local lang = {}

lang["fatih/vim-go"] = {
	lazy = true,
	ft = "go",
	build = ":GoInstallBinaries",
	config = require("lang.vim-go"),
}
lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
-- lang["preservim/vim-markdown"] = {
-- 	lazy = true,
-- 	ft = { "tex", "markdown", "rmd", "qmd", "quarto" },
-- }
lang["kiyoon/jupynium.nvim"] = {
	lazy = true,
	ft = { "python", "r" },
	config = require("lang.jupynium"),
	dev = true,
}
-- lang["untitled-ai/jupyter_ascending.vim"] = {
-- 	lazy = true,
-- 	ft = { "python" },
-- }
lang["hkupty/iron.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	-- ft = { "python" },
	config = require("lang.iron"),
}
lang["Julian/lean.nvim"] = {
	lazy = true,
	ft = { "lean", "lean3" },
	config = require("lang.lean"),
}

-- lang["goerz/jupytext.vim"] = {
-- 	-- event = "BufAdd *.ipynb",
-- 	config = function()
-- 		vim.g.jupytext_fmt = "py"
-- 	end,
-- }
return lang
