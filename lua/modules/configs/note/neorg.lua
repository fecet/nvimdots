return function()
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
			["core.integrations.nvim-cmp"] = {},
			["core.integrations.telescope"] = {},
			["core.concealer"] = {
				config = {
					icon_preset = "basic",
					icons = {
						list = {
							-- level_1 = { icon = "•" },
							-- level_2 = { icon = "•" },
						},
						todo = {
							-- done={icon}
							on_hold = { icon = "󰏤" },
							pending = { icon = "󰚭" },
							uncertain = { icon = "" },
							-- urgent = { icon = "🚨" },
							urgent = { icon = "" },
						},
					},
				},
			},
			-- ["core.concealer"] = {},
			["core.export"] = {},
			["core.export.markdown"] = {},
			-- ["core.ui.calendar"] = {},
			["core.keybinds"] = {
				-- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
				config = {
					default_keybinds = true,
					neorg_leader = "<Leader><Leader>",
					hook = function(keybinds)
						local leader = keybinds.leader
						-- Unmaps any Neorg key from the `norg` mode
						keybinds.unmap("norg", "n", "<CR>")
						-- keybinds.unmap("norg", "i", "<M-CR>")
						-- -- Binds the `gtd` key in `norg` mode to execute `:echo 'Hello'`
						-- keybinds.map("norg", "i", "<C-CR>", "core.itero.next-iteration")

						-- Remap unbinds the current key then rebinds it to have a different action
						-- associated with it.
						-- The following is the equivalent of the `unmap` and `map` calls you saw above:
						keybinds.remap("norg", "n", leader .. "th", "core.qol.todo_items.todo.task_need_input")

						-- Sometimes you may simply want to rebind the Neorg action something is bound to
						-- versus remapping the entire keybind. This remap is essentially the same as if you
						-- did `keybinds.remap("norg", "n", "<C-Space>, "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>")
						-- keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_done")

						-- -- Want to move one keybind into the other? `remap_key` moves the data of the
						-- -- first keybind to the second keybind, then unbinds the first keybind.
						keybinds.remap_key("norg", "i", "<M-CR>", "<C-CR>")
					end,
				},
			},
		},
	})
end
