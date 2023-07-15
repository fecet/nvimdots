local py = require("modules.configs.completion.python.utils.python_help")
local path = require("mason-core.path")

return {
	-- on_attach = function(client, bufnr)
	-- 	-- client.server_capabilities.semanticTokensProvider = nil
	-- 	-- client.server_capabilities.callHierarchyProvider = nil
	-- 	-- client.server_capabilities.codeActionProvider = nil
	-- 	-- client.server_capabilities.completionProvider = nil
	-- 	-- client.server_capabilities.declarationProvider = nil
	-- 	-- client.server_capabilities.definitionProvider = nil
	-- 	-- client.server_capabilities.documentHighlightProvider = nil
	-- 	-- client.server_capabilities.documentOnTypeFormattingProvider = nil
	-- 	-- client.server_capabilities.documentSymbolProvider = nil
	-- 	-- client.server_capabilities.executeCommandProvider = nil
	-- 	-- client.server_capabilities.foldingRangeProvider = nil
	-- 	-- client.server_capabilities.hoverProvider = nil
	-- 	-- client.server_capabilities.inlayHintProvider = nil
	-- 	-- client.server_capabilities.referencesProvider = nil
	-- 	-- client.server_capabilities.renameProvider = nil
	-- 	-- client.server_capabilities.selectionRangeProvider = nil
	-- 	-- client.server_capabilities.signatureHelpProvider = nil
	-- 	-- client.server_capabilities.typeDefinitionProvider = nil
	-- 	-- client.server_capabilities.workspaceSymbolProvider = nil
	-- end,
	on_init = function(client)
		local pyp = (function(workspace)
			if vim.env.VIRTUAL_ENV then
				print(vim.env.VIRTUAL_ENV)
				p = path.join(vim.env.VIRTUAL_ENV, "bin", "python")
				print(p)
				return p
			end
			-- if vim.fn.filereadable(path.concat({ workspace, "poetry.lock" })) then
			--              print("poetry.lock")
			-- 	local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
			-- 	p = path.concat({ venv, "bin", "python" })
			-- 	print(p)
			-- 	return p
			-- end
			p = vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
			print(p)
			return p
		end)(client.config.root_dir)
		print(pyp)
		client.config.settings.python.pythonPath = pyp
	end,
	before_init = function(_, config)
		-- config.settings.python.analysis.stubPath = require("lspconfig/util").path.join(
		-- 	vim.fn.stdpath("data"),
		-- 	"site",
		-- 	"lazy",
		-- 	"packer",
		-- 	"typings",
		-- 	"opt",
		-- 	"python-type-stubs"
		-- )
	end,

	on_new_config = function(new_config, new_root_dir)
		new_config.settings.python.pythonPath = vim.fn.exepath("python") or vim.fn.exepath("python3") or "python"
		new_config.cmd_env.PATH = py.env(new_root_dir) .. new_config.cmd_env.PATH

		local pep582 = py.pep582(new_root_dir)
		if pep582 ~= nil then
			new_config.settings.python.analysis.extraPaths = { pep582 }
		end
	end,
	-- cmd = { "pylance", "--cancellationReceive", "96c34", "--stdio" },
	-- cmd = { "pylance", "--stdio" },
	settings = {
		python = {
			analysis = {
				loglevel = "trace",
				typeCheckingMode = "off",
				completeFunctionParens = false,
				autoImportCompletions = true,
				autoFormatStrings = false,
				indexing = true,
				packageIndexDepths = {
					{ name = "vectorbtpro", depth = 10, includeAllSymbols = true },
					{ name = "torch", depth = 10, includeAllSymbols = true },
				},
				inlayHints = {
					variableTypes = true,
					functionReturnTypes = true,
					callArgumentNames = true,
					pytestParameters = true,
				},
				-- diagnosticSeverityOverrides = { reportGeneralTypeIssues = "warning" },
			},
		},
	},
}
