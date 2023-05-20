return function()
	local iron = require("iron.core")
	local view = require("iron.view")
	iron.setup({
		config = {
			repl_definition = {
				python = {
					command = function(meta)
						if vim.g.python_repl_cmd ~= nil then
							return vim.g.python_repl_cmd
						else
							return require("iron.fts.python").ipython.command
						end
					end,
					format = require("iron.fts.python").ipython.format,
				},
			},
			repl_open_cmd = function(bufnr)
				vim.g.is_iron_open = 1
				-- return view.right("30%")(bufnr)
				return view.split.vertical.botright(0.4)(bufnr)
			end,
			-- repl_open_cmd = view.split.vertical.botright(0.4)
		},
		-- Iron doesn't set keymaps by default anymore.
		-- You can set them here or manually add keymaps to the functions in iron.core

		highlight = {
			italic = true,
		},
		ignore_blank_lines = false, -- ignore blank lines when sending visual select lines
	})

	-- iron also has a list of commands, see :h iron-commands for all available commands
end
