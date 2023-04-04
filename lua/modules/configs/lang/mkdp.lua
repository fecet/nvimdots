return function()
	-- mkdp
	vim.g.mkdp_preview_options = {
		mkit = {},
		katex = {},
		uml = {},
		maid = {},
		disable_sync_scroll = 0,
		sync_scroll_type = "middle",
		hide_yaml_meta = 1,
		sequence_diagrams = {},
		flowchart_diagrams = {},
		content_editable = false,
		disable_filename = 0,
	}

	-- vim.g.mkdp_browser = 'microsoft-edge-beta'
	vim.g.mkdp_browser = "firefox"
	-- vim.g.mkdp_filetypes = { "markdown", "rmd", "qmd" }
	vim.g.mkdp_command_for_global = 1
	vim.g.mkdp_echo_preview_url = 1
	vim.g.mkdp_open_to_the_world = 1
	-- vim.g.mkdp_port = '8296'
	vim.g.mkdp_page_title = "MarkdownPreview「${name}」"
	vim.g.mkdp_open_ip = ""

	-- Use a custom port to start server or random for empty
	vim.g.mkdp_port = ""
	vim.g.mkdp_auto_start = false
	vim.g.mkdp_auto_close = false
end
