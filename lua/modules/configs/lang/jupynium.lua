return function()
	require("jupynium").setup({
		-- Conda users:
		python_host = "/opt/mambaforge/bin/python",
		-- python_host = vim.g.python3_host_prog or "python3",

		default_notebook_URL = "localhost:8888",

		firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
		-- firefox_profiles_ini_path = vim.fn.isdirectory(vim.fn.expand("~/snap/firefox/common/.mozilla/firefox"))
		-- 		and "~/snap/firefox/common/.mozilla/firefox/profiles.ini"
		-- 	or "~/.mozilla/firefox/profiles.ini",
		firefox_profile_name = nil,

		-- Open the Jupynium server if it is not already running
		-- which means that it will open the Selenium browser when you open this file.
		-- Related command :JupyniumStartAndAttachToServer
		auto_start_server = {
			enable = false,
			file_pattern = { "*.ju.*" },
		},

		-- Attach current nvim to the Jupynium server
		-- Without this step, you can't use :JupyniumStartSync
		-- Related command :JupyniumAttachToServer
		auto_attach_to_server = {
			enable = true,
			file_pattern = { "*.ju.*" },
		},

		-- Automatically open an Untitled.ipynb file on Notebook
		-- when you open a .ju.py file on nvim.
		-- Related command :JupyniumStartSync
		auto_start_sync = {
			enable = false,
			file_pattern = { "*.ju.*" },
		},

		-- Automatically keep filename.ipynb copy of filename.ju.py
		-- by downloading from the Jupyter Notebook server.
		-- WARNING: this will overwrite the file without asking
		-- Related command :JupyniumDownloadIpynb
		auto_download_ipynb = false,

		-- Always scroll to the current cell.
		-- Related command :JupyniumScrollToCell
		autoscroll = {
			enable = true,
			mode = "always", -- "always" or "invisible"
			cell = {
				top_margin_percent = 20,
			},
		},

		scroll = {
			page = { step = 0.5 },
			cell = {
				top_margin_percent = 20,
			},
		},

		use_default_keybindings = false,
		textobjects = {
			use_default_keybindings = false,
		},

		-- Dim all cells except the current one
		-- Related command :JupyniumShortsightedToggle
		shortsighted = false,
		auto_close_tab = false,
	})
	local select_current_cell = function()
		local cells = require("jupynium.cells")
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local current_separator_row = cells.current_cell_separator(row)
		if current_separator_row == nil then
			return
		end
		local start_row = current_separator_row + 1
		local next_row = cells.next_cell_separator(row)
		local end_row = nil
		if next_row == nil then
			end_row = vim.api.nvim_buf_line_count(0)
		else
			end_row = next_row - 1
		end
		local lines = vim.fn.getline(start_row, end_row)
		-- return table.concat(lines, "\n")
		return lines
	end
	local execute_current_cell = function()
		if vim.g.is_iron_open == 1 then
			local content = select_current_cell()
			require("iron.core").send(nil, content)
		else
			vim.cmd("JupyniumExecuteSelectedCells")
		end
	end

	local start_repl_cmd = function(args)
		local hostname = args.args
		local buf = vim.api.nvim_get_current_buf()
		if Jupynium_get_kernel_connect_shcmd ~= nil then
			vim.g.python_repl_cmd = Jupynium_get_kernel_connect_shcmd(buf, hostname)
		end
		require("iron").core.repl_for("python")
	end

	vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
		pattern = "*.ju.*",
		callback = function()
			local buf_id = vim.api.nvim_get_current_buf()
			vim.keymap.set({ "n", "x" }, "<space><CR>", execute_current_cell, { buffer = buf_id })
			vim.keymap.set({ "i", "n", "x" }, "<C-CR>", execute_current_cell, { buffer = buf_id })
			vim.api.nvim_create_user_command("JupyniumRepl", start_repl_cmd, { nargs = "?" })
		end,
	})

	vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
		pattern = "*.sync.*",
		callback = function()
			local buf_id = vim.api.nvim_get_current_buf()
			vim.keymap.set(
				{ "n", "x" },
				"<space><CR>",
				"<cmd>call jupyter_ascending#execute()<CR>",
				{ buffer = buf_id }
			)
		end,
	})

	vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
		pattern = "*.ju.*,*.sync.*",
		callback = function()
			local buf_id = vim.api.nvim_get_current_buf()
			-- vim.keymap.set({ "n", "x" }, "<space>cc", "<cmd>JupyniumClearSelectedCellsOutputs<CR>", { buffer = buf_id })
			-- vim.keymap.set({ "n", "x" }, "<space>S", "<cmd>JupyniumScrollToCell<cr>", { buffer = buf_id })
			vim.keymap.set(
				{ "n", "x" },
				"<space>T",
				"<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>",
				{ buffer = buf_id }
			)
			vim.keymap.set(
				{ "n" },
				"gj",
				"<cmd>JupyniumKernelHover<cr>",
				{ buffer = buf_id, desc = "Jupynium hover (inspect a variable)" }
			)
			vim.keymap.set("", "<PageUp>", "<cmd>JupyniumScrollUp<cr>", { buffer = buf_id })
			vim.keymap.set("", "<PageDown>", "<cmd>JupyniumScrollDown<cr>", { buffer = buf_id })
			vim.keymap.set(
				{ "n", "x", "o" },
				"<C-b>",
				"<cmd>lua require'jupynium.textobj'.goto_previous_cell_separator()<cr>",
				{ buffer = buf_id }
			)
			vim.keymap.set(
				{ "n", "x", "o" },
				"<C-f>",
				"<cmd>lua require'jupynium.textobj'.goto_next_cell_separator()<cr>",
				{ buffer = buf_id }
			)
			vim.keymap.set(
				{ "n", "x", "o" },
				"<space>j",
				"<cmd>lua require'jupynium.textobj'.goto_current_cell_separator()<cr>",
				{ buffer = buf_id }
			)
			vim.keymap.set(
				{ "x", "o" },
				"aj",
				"<cmd>lua require'jupynium.textobj'.select_cell(true, false)<cr>",
				{ buffer = buf_id }
			)
			vim.keymap.set(
				{ "x", "o" },
				"ij",
				"<cmd>lua require'jupynium.textobj'.select_cell(false, false)<cr>",
				{ buffer = buf_id }
			)
			vim.keymap.set(
				{ "x", "o" },
				"aJ",
				"<cmd>lua require'jupynium.textobj'.select_cell(true, true)<cr>",
				{ buffer = buf_id }
			)
			vim.keymap.set(
				{ "x", "o" },
				"iJ",
				"<cmd>lua require'jupynium.textobj'.select_cell(false, true)<cr>",
				{ buffer = buf_id }
			)
		end,
	})
end
