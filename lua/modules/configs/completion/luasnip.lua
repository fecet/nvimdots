return function()
	local luasnip = require("luasnip")

	local snippet_path = vim.fn.stdpath("config") .. "/snips/"
	if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
		vim.opt.rtp:append(snippet_path)
	end

	luasnip.config.set_config({
		history = true,
		update_events = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged,InsertLeave",
		enable_autosnippets = true,
		store_selection_keys = "<tab>",
	})
	require("luasnip.loaders.from_lua").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load()

	local markdown_family = require("modules.utils.constants").markdown_family

	for i = 2, #markdown_family do
		local ft = markdown_family[i]
		luasnip.filetype_extend(ft, { "markdown" })
	end
end
