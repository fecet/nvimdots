return function()
	require("lean").setup({
		lsp = { enable = false },
		lsp3 = {
			cmd = { "lean-language-server", "--stdio", "--", "-M", "16384", "-T", "100000" },
			filetypes = { "lean", "lean3" },
		},
		mappings = true,
		-- ft = { default = "lean3" },
		progress_bars = {
			-- Enable the progress bars?
			enable = true,
			-- Use a different priority for the signs
			priority = 10,
		},
	})
end
