return function()
	require("auto-save").setup({
		enabled = true,
		execution_message = {
			message = function()
				-- vim.notify=require("notify")
				-- vim.notify(" AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
				return " AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")
			end,
			dim = 0.18,
			cleaning_interval = 1250,
		},
		trigger_events = { "InsertLeave", "TextChanged" },
		conditions = {
			exists = true,
			filetype_is_not = {},
			modifiable = true,
		},
		write_all_buffers = false,
		on_off_commands = true,
		clean_command_line_interval = 0,
		debounce_delay = 135,
	})
end
