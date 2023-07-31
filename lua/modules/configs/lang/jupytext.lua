return function()
	vim.g.jupytext_fmt = "py:percent"
	vim.g.jupytext_to_ipynb_opts = "--to=ipynb --from " .. vim.g.jupytext_fmt .. " --update"
	vim.g.jupytext_filetype_map = { "python" }
	vim.g.jupytext_print_debug_msgs = 0
end
