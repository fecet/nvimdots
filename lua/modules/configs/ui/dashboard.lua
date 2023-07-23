return function()
	local function header_hl_today()
		local wday = os.date("*t").wday
		local colors = { "Keyword", "Constant", "Number", "Type", "String", "Special", "Function" }
		return colors[wday]
	end
	vim.cmd("highlight link DashboardHeader " .. header_hl_today())

	local function header()
		local str = "   Have Fun with neovim"
			.. "   v"
			.. vim.version().major
			.. "."
			.. vim.version().minor
			.. "."
			.. vim.version().patch
		return str
	end

	local function footer()
		local stats = require("lazy").stats()
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
		local str = "   " .. stats.count .. " plugins in " .. ms .. "ms"
		return vim.list_extend({ "", str, "" }, require("fortune").fortune(true))
	end
	local function project_action(path)
		-- return require("telescope.builtin").find_files({ cwd = path })
        vim.api.nvim_set_current_dir(path)
		return require("persisted").load()
	end
	require("dashboard").setup({
		theme = "hyper",
		config = {
			week_header = {
				enable = true,
				concat = header(),
			},
			shortcut = {
				{ desc = " Update", group = "@property", action = "Lazy update", key = "u" },
				{
					desc = " Files",
					-- group = "Label",
					action = "Telescope find_files",
					key = "f",
				},
				{
					desc = " Apps",
					group = "DiagnosticHint",
					action = "Telescope app",
					key = "a",
				},
				{
					desc = " dotfiles",
					group = "Number",
					action = "Telescope live_grep cwd=~/.config/nvim",
					key = "d",
				},
			},
			hide = {
				tabline = false,
			},
			packages = { enable = false }, -- show how many plugins neovim loaded
			-- limit how many projects list, action when you press key or enter it will run this action.
			-- action can be a functino type, e.g.
			-- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
			-- project = { enable = true, limit = 8, label = "Recent Projects", action = "Telescope find_files cwd=" },
			-- project = { enable = true, limit = 8, label = "Recent Projects", action = "Telescope find_files cwd=" },
			project = { enable = true, limit = 5, label = "Recent Projects", action = project_action },
			mru = { limit = 8, label = "Most Recent Files" },
			footer = footer, -- footer,
		},
		-- preview = {
		-- 	command = "cat",
		-- 	file_path = vim.fn.stdpath("config") .. "/nvchad.cat",
		-- 	file_height = 8,
		-- 	file_width = 80,
		-- },
	})
end
