return function()
	vim.g["semshi#error_sign"] = false
	vim.g["semshi#simplify_markup"] = false
	vim.g["semshi#mark_selected_nodes"] = false
	vim.g["semshi#update_delay_factor"] = 0.001
	vim.g["semshi#excluded_hl_groups"] = { "global", "local" }
	vim.cmd([[
            " highlight! semshiGlobal @lsp
            highlight! link semshiImported @namespace
            highlight! link semshiParameter @lsp.type.parameter
            highlight! link semshiParameterUnused DiagnosticUnnecessary
            highlight! link semshiBuiltin @function.builtin
            highlight! link semshiAttribute @attribute
            highlight! link semshiSelf @lsp.type.selfKeyword
            highlight! link semshiUnresolved @lsp.type.unresolvedReference
    ]])
end
