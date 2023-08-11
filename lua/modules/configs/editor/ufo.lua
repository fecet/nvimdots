return function()
	local ufo = require("ufo")
	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
	vim.o.foldcolumn = "1" -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
	-- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ("  %d "):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end

	local function get_cell_folds(bufnr)
		local function handleFallbackException(err, providerName)
			if type(err) == "string" and err:match("UfoFallbackException") then
				return ufo.getFolds(bufnr, providerName)
			else
				return require("promise").reject(err)
			end
		end
		return ufo.getFolds(bufnr, "lsp")
			:catch(function(err)
				return handleFallbackException(err, "treesitter")
			end)
			:catch(function(err)
				return handleFallbackException(err, "indent")
			end)
			:thenCall(function(ufo_folds)
				local ok, jupynium = pcall(require, "jupynium")
				if ok then
					for _, fold in ipairs(jupynium.get_folds()) do
						table.insert(ufo_folds, fold)
					end
				end
                print(vim.inspect(ufo_folds))
				return ufo_folds
			end)
	end

	local ftMap = {
		-- python = get_cell_folds,
	}

	-- buffer scope handler
	-- will override global handler if it is existed
	-- local bufnr = vim.api.nvim_get_current_buf()
	-- require('ufo').setFoldVirtTextHandler(bufnr, handler)
	ufo.setup({
		fold_virt_text_handler = handler,
		open_fold_hl_timeout = 0,
		close_fold_kinds = { "comment" },
		preview = {
			win_config = {
				-- border = { "", "─", "", "", "", "─", "", "" },
				winhighlight = "Normal:Normal",
				-- winblend = 0,
			},
		},
		provider_selector = function(bufnr, filetype, buftype)
			return ftMap[filetype]
		end,
	})
	--

	-- Option 3: treesitter as a main provider instead
	-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
	-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
end
