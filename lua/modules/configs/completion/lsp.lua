return function()
	local diagnostics_virtual_text = require("core.settings").diagnostics_virtual_text
	local diagnostics_level = require("core.settings").diagnostics_level
	local is_windows = require("core.global").is_windows

	local nvim_lsp = require("lspconfig")
	local mason = require("mason")
	local mason_registry = require("mason-registry")
	local mason_lspconfig = require("mason-lspconfig")
	local sources = require("mason-registry.sources")
	require("completion.providers.python")

	sources.set_registries({ "lua:mason-registry.index" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	local icons = {
		ui = require("modules.utils.icons").get("ui", true),
		misc = require("modules.utils.icons").get("misc", true),
	}

	mason.setup({
		ui = {
			border = "single",
			icons = {
				package_pending = icons.ui.Modified_alt,
				package_installed = icons.ui.Check,
				package_uninstalled = icons.misc.Ghost,
			},
			keymaps = {
				toggle_server_expand = "<CR>",
				install_server = "i",
				update_server = "u",
				check_server_version = "c",
				update_all_servers = "U",
				check_outdated_servers = "C",
				uninstall_server = "X",
				cancel_installation = "<C-c>",
			},
		},
	})

	-- Additional plugins for pylsp
	mason_registry:on(
		"package:install:success",
		vim.schedule_wrap(function(pkg)
			if pkg.name ~= "python-lsp-server" then
				return
			end

			local venv = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server/venv"
			local python = is_windows and venv .. "/Scripts/python.exe" or venv .. "/bin/python"
			local black = is_windows and venv .. "/Scripts/black.exe" or venv .. "/bin/black"
			local ruff = is_windows and venv .. "/Scripts/ruff.exe" or venv .. "/bin/ruff"

			require("plenary.job")
				:new({
					command = python,
					args = {
						"-m",
						"pip",
						"install",
						"-U",
						"--disable-pip-version-check",
						"python-lsp-black",
						"python-lsp-ruff",
						"pylsp-rope",
					},
					cwd = venv,
					env = { VIRTUAL_ENV = venv },
					on_exit = function()
						if vim.fn.executable(black) == 1 and vim.fn.executable(ruff) == 1 then
							vim.notify(
								"Finished installing pylsp plugins",
								vim.log.levels.INFO,
								{ title = "[lsp] Install Status" }
							)
						else
							vim.notify(
								"Failed to install pylsp plugins. [Executable not found]",
								vim.log.levels.ERROR,
								{ title = "[lsp] Install Failure" }
							)
						end
					end,
					on_start = function()
						vim.notify(
							"Now installing pylsp plugins...",
							vim.log.levels.INFO,
							{ title = "[lsp] Install Status", timeout = 6000 }
						)
					end,
					on_stderr = function(_, msg_stream)
						vim.notify(msg_stream, vim.log.levels.ERROR, { title = "[lsp] Install Failure" })
					end,
				})
				:start()
		end)
	)

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = true,
		underline = true,
		virtual_text = diagnostics_virtual_text and {
			severity_limit = diagnostics_level,
		} or false,
		-- set update_in_insert to false bacause it was enabled by lspsaga
		update_in_insert = false,
	})

	local opts = {
		capabilities = capabilities,
	}
	local lsp_deps = require("core.settings").lsp_deps
	-- local index_to_remove
	-- for i, value in ipairs(lsp_deps) do
	-- 	if value == "pylance" then
	-- 		-- nvim_lsp.pylance.setup(vim.tbl_deep_extend("force", opts, require("completion.python.pylance")))
	-- 		index_to_remove = i
	-- 		break
	-- 	end
	-- end
	-- if index_to_remove then
	-- 	table.remove(lsp_deps, index_to_remove)
	-- end

	mason_lspconfig.setup({
		ensure_installed = vim.tbl_filter(function(lsp_name)
			return lsp_name ~= "pylance"
		end, lsp_deps),
	})

	if vim.tbl_contains(lsp_deps, "pylance") then
		nvim_lsp.pylance.setup(vim.tbl_deep_extend("force", opts, require("completion.servers.pylance")))
	end

	---A handler to setup all servers defined under `completion/servers/*.lua`
	---@param lsp_name string
	local function mason_lsp_handler(lsp_name)
		if vim.tbl_contains(lsp_deps, lsp_name) then
			local ok, custom_handler = pcall(require, "completion.servers." .. lsp_name)
			if not ok then
				-- Default to use factory config for server(s) that doesn't include a spec
				nvim_lsp[lsp_name].setup(opts)
				return
			elseif type(custom_handler) == "function" then
				--- Case where language server requires its own setup
				--- Make sure to call require("lspconfig")[lsp_name].setup() in the function
				--- See `clangd.lua` for example.
				custom_handler(opts)
			elseif type(custom_handler) == "table" then
				nvim_lsp[lsp_name].setup(vim.tbl_deep_extend("force", opts, custom_handler))
			else
				vim.notify(
					string.format(
						"Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
						lsp_name,
						type(custom_handler)
					),
					vim.log.levels.ERROR,
					{ title = "nvim-lspconfig" }
				)
			end
		end
	end

	mason_lspconfig.setup_handlers({ mason_lsp_handler })

	-- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
	if vim.fn.executable("dart") == 1 then
		local _opts = require("completion.servers.dartls")
		local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
		nvim_lsp.dartls.setup(final_opts)
	end

	vim.api.nvim_command([[LspStart]]) -- Start LSPs
end
