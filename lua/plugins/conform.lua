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
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			end

			return {
				timeout_ms = 500,
				lsp_format = 'fallback',
			}
		end,
		formatters_by_ft = {
			c = { 'clang-format' },
			cpp = { 'clang-format' },
			rust = { 'rustfmt' },
			javascript = { 'prettierd' },
			typescript = { 'prettierd' },
			javascriptreact = { 'prettierd' },
			typescriptreact = { 'prettierd' },
			python = function(bufnr)
				if require('conform').get_formatter_info('ruff_format', bufnr).available then
					return { 'ruff_format' }
				end

				return { 'isort', 'black' }
			end,
			lua = { 'stylua' },
			css = { 'prettierd' },
			scss = { 'prettierd' },
			html = { 'prettierd' },
			markdown = { 'mdformat', 'mdsf' },
			json = { 'biome' },
			yaml = { 'yamlfmt' },
		},
	},
}
