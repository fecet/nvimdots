return function()
	require("zone").setup({
		style = "matrix",
		after = 30000, -- Idle timeout
		exclude_filetypes = {
			"TelescopePrompt",
			"NvimTree",
			"dashboard",
			"lir",
			"neo-tree",
			"help",
		},
		exclude_buftypes = { "terminal" },

		treadmill = {
			direction = "left", -- a lil buggy for `right`
			tick_time = 30, -- TODO: make it configurable inside helper.lua
			headache = false,
		},

		matrix = {
			tick_time = 50,
			headache = false,
		},

		epilepsy = {
			stage = "aura",
			tick_time = 100,
			headache = false,
		},

		dvd = {
			text = {
				[[⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡀]],
				[[⠀⢠⣿⣿⡿⠀⠀⠈⢹⣿⣿⡿⣿⣿⣇⠀⣠⣿⣿⠟⣽⣿⣿⠇⠀⠀⢹⣿⣿⣿]],
				[[⠀⢸⣿⣿⡇⠀⢀⣠⣾⣿⡿⠃⢹⣿⣿⣶⣿⡿⠋⢰⣿⣿⡿⠀⠀⣠⣼⣿⣿⠏]],
				[[⠀⣿⣿⣿⣿⣿⣿⠿⠟⠋⠁⠀⠀⢿⣿⣿⠏⠀⠀⢸⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣸⣟⣁⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⣠⣴⣶⣾⣿⣿⣻⡟⣻⣿⢻⣿⡟⣛⢻⣿⡟⣛⣿⡿⣛⣛⢻⣿⣿⣶⣦⣄⡀⠀]],
				[[⠉⠛⠻⠿⠿⠿⠷⣼⣿⣿⣼⣿⣧⣭⣼⣿⣧⣭⣿⣿⣬⡭⠾⠿⠿⠿⠛⠉⠀ ]],
				[[                              ]],
			},
		},

		vanish = {
			tick_time = 50,
			headache = false,
		},
	})
end
