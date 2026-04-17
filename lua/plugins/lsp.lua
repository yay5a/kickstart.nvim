local lazydev = {
	'folke/lazydev.nvim',
	ft = 'lua',
	opts = {
		library = {
			{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
		},
	},
}

local lspconfig = {
	'neovim/nvim-lspconfig',
	dependencies = {
		{
			'mason-org/mason.nvim',
			opts = {},
		},
		'mason-org/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		{ 'j-hui/fidget.nvim', opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('yaysa-lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
				map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
				map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method('textDocument/documentHighlight', event.buf) then
					local highlight_augroup = vim.api.nvim_create_augroup('yaysa-lsp-highlight', { clear = false })
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd('LspDetach', {
						group = vim.api.nvim_create_augroup('yaysa-lsp-detach', { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds { group = 'yaysa-lsp-highlight', buffer = event2.buf }
						end,
					})
				end

				if client and client:supports_method('textDocument/inlayHint', event.buf) then
					map('<leader>th', function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
					end, '[T]oggle Inlay [H]ints')
				end
			end,
		})

		local capabilities = require('blink.cmp').get_lsp_capabilities()

		---@type table<string, vim.lsp.Config>
		local servers = {
			clangd = {
				cmd = vim.fn.executable 'clang-tidy' == 1 and { 'clangd', '--clang-tidy', '--background-index', '--fallback-style=llvm' }
					or { 'clangd', '--background-index', '--fallback-style=llvm' },
			},
			rust_analyzer = {},
			vtsls = {},
			pyright = {},
			stylua = {},
			lua_ls = {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
							return
						end
					end

					client.config.settings = client.config.settings or {}

					local lua_settings = client.config.settings.Lua
					if type(lua_settings) ~= 'table' then
						lua_settings = {}
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', lua_settings, {
						runtime = {
							version = 'LuaJIT',
							path = { 'lua/?.lua', 'lua/?/init.lua' },
						},
						workspace = {
							checkThirdParty = false,
						},
					})
				end,
				settings = {
					Lua = {
						diagnostics = { globals = { 'vim' } },
						completion = { callSnippet = 'Replace' },
					},
				},
			},
			cssls = {},
			tailwindcss = {},
			html = {},
			emmet_ls = {},
			marksman = {},
			yamlls = {
				settings = {
					redhat = {
						telemetry = {
							enabled = false,
						},
					},
					yaml = {
						validate = true,
						completion = true,
						hover = true,
						format = {
							enable = false,
						},
						schemaStore = {
							enable = true,
						},
						schemas = {
							['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
							['https://json.schemastore.org/github-action.json'] = '/action.yml',
							['https://json.schemastore.org/docker-compose.json'] = 'docker-compose*.yml',
							kubernetes = 'k8s/**/*.yaml',
						},
						customTags = {},
					},
				},
			},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			'stylua',
			'lua-language-server',
			'luacheck',
			'html-lsp',
			'htmlhint',
			'emmet-ls',
			'clangd',
			'clang-format',
			'cpplint',
			'rust-analyzer',
			'codelldb',
			'vtsls',
			'eslint_d',
			'biome',
			'pyright',
			'ruff',
			'black',
			'isort',
			'css-lsp',
			'tailwindcss-language-server',
			'stylelint',
			'prettierd',
			'markdownlint',
			'marksman',
		})

		require('mason-tool-installer').setup { ensure_installed = ensure_installed }

		require('mason-lspconfig').setup {
			ensure_installed = {},
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
					require('lspconfig')[server_name].setup(server)
				end,
			},
		}
	end,
}

return {
	lazydev,
	lspconfig,
}
