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
			'clangd',
			'rust_analyzer',
			'vtsls',
			'pyright',
			'emmylua_ls',
			'cssls',
			'tailwindcss',
			'html',
			'emmet_ls',
			'marksman',
			'yamlls',
		}

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('yaysa-lsp-attach', { clear = true }),
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

				if client:supports_method('textDocument/inlayHint', event.buf) then
					map('<leader>th', function()
						local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
						vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
					end, '[T]oggle Inlay [H]ints')
				end
			end,
		})

		vim.lsp.config('*', {
			capabilities = require('blink.cmp').get_lsp_capabilities(),
		})

		require('mason-tool-installer').setup {
			ensure_installed = {
				'stylua',
				'luacheck',
				'htmlhint',
				'clang-format',
				'cpplint',
				'codelldb',
				'eslint_d',
				'biome',
				'ruff',
				'black',
				'isort',
				'stylelint',
				'prettierd',
				'markdownlint',
				'mdx-analyzer',
				'yamlfmt',
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
