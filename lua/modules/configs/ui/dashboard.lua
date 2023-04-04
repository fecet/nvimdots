return function()
	local function header_hl_today()
		local wday = os.date("*t").wday
		local colors = { "Keyword", "Constant", "Number", "Type", "String", "Special", "Function" }
		return colors[wday]
	end
	vim.cmd("highlight link DashboardHeader " .. header_hl_today())
	vim.cmd("highlight link DashboardFooter " .. "Function")
	vim.cmd("highlight link DashboardMruTitle " .. "Error")
	vim.cmd("highlight link DashboardProjectTitle " .. "Error")
	vim.cmd("highlight link DashboardFiles " .. "String")

	local function remove_bom(content)
		if content:sub(1, 3) == "\239\187\191" then
			return content:sub(4)
		end
		return content
	end
	local function read_json_file(file_path)
		local file = io.open(file_path, "r")
		local content = file:read("*all")
		content = remove_bom(content)
		file:close()
		local json = vim.json
		quotes = json.decode(content)
		return quotes
	end

	local function get_random_quote(quotes)
		local num_quotes = #quotes
		local math = require("math")
		math.randomseed(os.time())
		local random_index = math.random(num_quotes)
		return quotes[random_index]
	end

	local quotes = read_json_file(vim.fn.stdpath("config") .. "/data.json")
	local random_quote = get_random_quote(quotes)
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
	local function split_string(long_string)
		local max_length = 80
		local num_parts = math.ceil(#long_string / max_length)
		local part_length = math.ceil(#long_string / num_parts)

		local parts = {}
		local start_pos = 1
		for i = 1, num_parts do
			local part_end_pos = math.min(start_pos + part_length - 1, #long_string)
			local part = long_string:sub(start_pos, part_end_pos)
			table.insert(parts, part)
			start_pos = part_end_pos + 1
		end
		return parts
	end

	local function footer()
		local stats = require("lazy").stats()
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
		local str = "   " .. stats.count .. " plugins in " .. ms .. "ms"
		local quote = '"' .. random_quote.text .. '" - ' .. random_quote.from
		return vim.list_extend({ "", str, "" }, split_string(quote))
	end
	local function project_action(path)
		return require("telescope.builtin").find_files({ cwd = path })
	end
	require("dashboard").setup({
		theme = "hyper",
		-- header = { "It's my duty", "ss" },
		config = {
			-- header = { "It's my duty", "ss" },
			week_header = {
				enable = true,
				concat = header(),
			},
			shortcut = {
				{ desc = " Update", group = "@property", action = "Lazy update", key = "u" },
				{
					desc = " Files",
					group = "Label",
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
					action = "Telescope find_files cwd=~/.config/nvim",
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
