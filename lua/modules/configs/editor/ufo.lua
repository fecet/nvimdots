return function()
	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
	vim.o.foldcolumn = "1" -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
	-- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

	require("ufo").setup({
		open_fold_hl_timeout = 0,
		close_fold_kinds = { "comment" },
		preview = {
			win_config = {
				-- border = { "", "─", "", "", "", "─", "", "" },
				winhighlight = "Normal:Normal",
				-- winblend = 0,
			},
		},
		-- provider_selector = function(bufnr, filetype, buftype)
		-- 	-- return a table with string elements: 1st is name of main provider, 2nd is fallback
		-- 	-- return a string type: use ufo inner providers
		-- 	-- return a string in a table: like a string type above
		-- 	-- return empty string '': disable any providers
		-- 	-- return `nil`: use default value {'lsp', 'indent'}
		-- 	-- return a function: it will be involved and expected return `UfoFoldingRange[]|Promise`

		-- 	-- if you prefer treesitter provider rather than lsp,
		-- 	-- return ftMap[filetype] or {'treesitter', 'indent'}
		-- 	return ftMap[filetype]
		-- end,
	})
	--

	-- Option 3: treesitter as a main provider instead
	-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
	-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
end
