local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local core_map = {
	-- Suckless
	["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent():with_desc("editn: Toggle code fold"),
	["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("editn: Save file"),
	-- ["n|<C-a>"] = map_cmd("ggVG"):with_noremap():with_silent():with_desc("editn: select all"),
	["n|Y"] = map_cmd("y$"):with_desc("editn: Yank text to EOL"),
	-- ["n|D"] = map_cmd("d$"):with_desc("editn: Delete text to EOL"),
	["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("editn: Next search result"),
	["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("editn: Prev search result"),
	-- ["n|J"] = map_cmd("mzJ`z"):with_noremap():with_desc("editn: Join next line"),
	["n|<A-[>"] = map_cr("vertical resize -5"):with_silent():with_desc("window: Resize -5 vertically"),
	["n|<A-]>"] = map_cr("vertical resize +5"):with_silent():with_desc("window: Resize +5 vertically"),
	["n|<A-;>"] = map_cr("resize -2"):with_silent():with_desc("window: Resize -2 horizontally"),
	["n|<A-'>"] = map_cr("resize +2"):with_silent():with_desc("window: Resize +2 horizontally"),
	-- ["n|<C-q>"] = map_cmd(":wq<CR>"):with_desc("editn: Save file and quit"),
	["n|<A-S-q>"] = map_cmd(":q!<CR>"):with_desc("editn: Force quit"),
	["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("editn: Toggle spell check"),
	-- Insert mode
	["i|<C-u>"] = map_cr("<C-G>u<C-U>"):with_noremap():with_desc("editi: Delete previous block"),
	-- ["i|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("editi: Move cursor to left"),
	-- ["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap():with_desc("editi: Move cursor to line start"),
	-- ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("editi: Save file"),
	["i|<C-r>"] = map_cmd("<C-o>u"):with_desc("editi: undo"),
	-- ["i|<C-w>"] = map_cmd("<Esc>:set iskeyword=@,48-57,192-255<CR>a<C-G>u<C-W><ESC>:set iskeyword=@,48-57,_,192-255<CR>a"):with_desc("editi: delete previous word"),
	["i|<C-w>"] = map_cmd("<Esc>:set iskeyword=@,48-57,192-255<CR>a<C-G>u<C-W><Esc>:set iskeyword=@,48-57,_,192-255<CR>a")
        :with_silent()
		:with_noremap()
		:with_desc("editi: delete previous word"),
	-- ["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"):with_desc("editi: Save file and quit"),
	-- Visual mode
	-- ["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("editv: Move this line down"),
	-- ["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("editv: Move this line up"),
	-- ["nv|<"] = map_cmd("<<"):with_desc("editv: Decrease indent"),
	-- ["nv|>"] = map_cmd(">>"):with_desc("editv: Increase indent"),
	["nvo|Q"] = map_cr(":q"):with_silent():with_noremap():with_desc("quit"),
	["nvo|K"] = map_cmd("<C-u>"):with_silent():with_desc("long k"),
	["nvo|J"] = map_cmd("<C-d>"):with_silent():with_desc("long j"),
	["nvo|H"] = map_cmd("^"):with_silent():with_noremap():with_desc("long h"),
	["nvo|L"] = map_cmd("$"):with_silent():with_noremap():with_desc("long l"),
}

bind.nvim_load_mapping(core_map)
