local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

local plug_map = {
	-- Plugin: accelerate-jk
	-- ["n|j"] = map_callback(function()
	-- 		return et("<Plug>(accelerated_jk_gj)")
	-- 	end)
	-- 	:with_expr()
	-- 	:with_noremap(),
	-- ["n|k"] = map_callback(function()
	-- 		return et("<Plug>(accelerated_jk_gk)")
	-- 	end)
	-- 	:with_expr()
	-- 	:with_noremap(),
	-- Plugin persisted.nvim
	["n|<leader>ss"] = map_cu("SessionStart"):with_noremap():with_silent():with_desc("session: Start"),
	["n|<leader>sl"] = map_cu("SessionLoad"):with_noremap():with_silent():with_desc("session: Load current"),
	["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("session: Delete"),

	-- Plugin: nvim-bufdel
	["n|<A-q>"] = map_cr("BufDel"):with_noremap():with_silent():with_desc("buffer: Close current"),

	-- Plugin: clever-f
	["n|;"] = map_callback(function()
		return et("<Plug>(clever-f-repeat-forward)")
	end):with_expr(),
	["n|,"] = map_callback(function()
		return et("<Plug>(clever-f-repeat-back)")
	end):with_expr(),

	-- Plugin: comment.nvim
	["n|gcc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
				or et("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for line"),
	["n|gbc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with operator"),
	["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with operator"),
	["x|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["x|gb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

	-- Plugin: diffview
	["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

	-- Plugin: vim-easy-align
	-- ["nx|gea"] = map_cr("EasyAlign"):with_desc("edit: Align with delimiter"),

	-- Plugin: hop
	["nv|<leader>w"] = map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("jump: Goto word"),
	["nv|F"] = map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("jump: Goto word"),
	["nv|<leader>l"] = map_cmd("<Cmd>HopLineStartMW<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|f"] = map_cmd("<Cmd>HopAnywhereCurrentLine<CR>"):with_noremap():with_desc("jump: Goto line"),
	-- ["nv|<leader>c"] = map_cmd("<Cmd>HopChar1MW<CR>"):with_noremap():with_desc("jump: Goto one char"),
	-- ["nv|<leader>cc"] = map_cmd("<Cmd>HopChar2MW<CR>"):with_noremap():with_desc("jump: Goto two chars"),

	-- Plugin: treehopper
	["xo|m"] = map_cu("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),

	-- Plugin: tabout
	["i|<tab>"] = map_cmd("<Plug>(TaboutMulti)"):with_silent():with_noremap():with_desc("edit: Goto end of pair"),
	["i|<s-tab>"] = map_cmd("<Plug>(TaboutBackMulti)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Goto begin of pair"),
	-- ["n|<CR>"] = map_cmd(":lua require'wildfire'.init_selection()<CR>"):with_silent(),
	["n|<leader>a"] = map_cmd(":lua require'wildfire'.init_selection()<CR>:lua require('tsht').nodes()<CR>"):with_silent(),
	-- ["x|<CR>"] = map_cmd(":lua require'nvim-treesitter.incremental_selection'.node_incremental()<CR>"),
	-- ["x|<CR>"] = map_cmd(":lua require'wildfire'.node_incremental()<CR>"),
	["x|-"] = map_cr(":lua require'wildfire'.visual_inner()"):with_silent(),
	["x|nn"] = map_cr(":lua require'nag'.vsplit()"):with_silent(),
	["n|<leader>sw"] = map_cr(":ISwapNodeWith"):with_silent(),
}

bind.nvim_load_mapping(plug_map)
