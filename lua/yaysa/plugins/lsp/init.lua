return {
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
		local server_names = {
			'bashls',
			'clangd',
			'cssls',
			'docker_language_server',
			'emmet_language_server',
			'graphql',
			'html',
			'jsonls',
			'lua_ls',
			'marksman',
			'mdx_analyzer',
			'neocmake',
			'pyright',
			'rust_analyzer',
			'sqlls',
			'tailwindcss',
			'taplo',
			'ts_query_ls',
			'ts_ls',
			'vimls',
			'yamlls',
		}

		local lsp_attach_augroup = vim.api.nvim_create_augroup('yaysa-lsp-attach', { clear = true })
		local lsp_detach_augroup = vim.api.nvim_create_augroup('yaysa-lsp-detach', { clear = true })
		local highlight_augroup = vim.api.nvim_create_augroup('yaysa-lsp-highlight', { clear = true })

		vim.api.nvim_create_autocmd('LspAttach', {
			group = lsp_attach_augroup,
			callback = function(event)
				local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
				map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
				map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				if client:supports_method('textDocument/documentHighlight', event.buf) then
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
						group = lsp_detach_augroup,
						buffer = event.buf,
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = event2.buf }
						end,
					})
				end

				if client:supports_method('textDocument/inlayHint', event.buf) then
					map('<leader>th', function()
						local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
						vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
					end, '[T]oggle Inlay [H]ints')
				end
			end,
		})

		vim.diagnostic.config {
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = 'E ',
					[vim.diagnostic.severity.WARN] = 'W ',
					[vim.diagnostic.severity.HINT] = 'H ',
					[vim.diagnostic.severity.INFO] = 'I ',
				},
			},
			virtual_text = true,
			underline = true,
			update_in_insert = false,
			float = {
				border = 'rounded',
				focusable = false,
				source = true,
			},
		}

		vim.lsp.config('*', {
			capabilities = require('blink.cmp').get_lsp_capabilities(),
		})

		require('mason-tool-installer').setup {
			ensure_installed = {
				'stylua',
				'biome',
				'cmakelang',
				'cmakelint',
				'luacheck',
				'htmlbeautifier',
				'htmlhint',
				'clang-format',
				'cpplint',
				'codelldb',
				'eslint_d',
				'dotenv-linter',
				'jq',
				'jsonlint',
				'ruff',
				'black',
				'isort',
				'mdsf',
				'prettier',
				'shellcheck',
				'shfmt',
				'stylelint',
				'superhtml',
				'taplo',
				'typos',
				'prettierd',
				'markdownlint',
				'mdx-analyzer',
				'pyink',
				'yamlfmt',
				'yamllint',
			},
		}

		require('mason-lspconfig').setup {
			ensure_installed = server_names,
			automatic_enable = false,
		}

		vim.lsp.enable(server_names)

		vim.api.nvim_create_autocmd('VimEnter', {
			group = vim.api.nvim_create_augroup('yaysa-lsp-enable-existing-buffers', { clear = true }),
			once = true,
			callback = function()
				vim.cmd.doautoall 'nvim.lsp.enable FileType'
			end,
		})
	end,
}
