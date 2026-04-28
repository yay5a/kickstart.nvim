---@module 'lazy'
---@type LazySpec
return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>f',
			function()
				require('conform').format { async = true, lsp_format = 'fallback' }
			end,
			mode = '',
			desc = '[F]ormat buffer',
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function()
			return {
				timeout_ms = 500,
				lsp_format = 'fallback',
			}
		end,
		formatters_by_ft = {
			c = { 'clang-format' },
			cmake = { 'cmake_format' },
			cpp = { 'clang-format' },
			css = { 'prettier' },
			html = { 'prettier' },
			javascript = { 'prettier' },
			javascriptreact = { 'prettier' },
			json = { 'jq' },
			jsonc = { 'prettier' },
			lua = { 'stylua' },
			markdown = { 'prettier' },
			mdx = { 'prettier' },
			python = { 'isort', 'black' },
			scss = { 'prettier' },
			sh = { 'shfmt' },
			toml = { 'taplo' },
			typescript = { 'prettier' },
			typescriptreact = { 'prettier' },
			yaml = { 'yamlfmt' },
			zsh = { 'shfmt' },
		},
	},
}
