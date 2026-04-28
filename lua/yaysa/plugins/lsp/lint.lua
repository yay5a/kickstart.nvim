---@module 'lazy'
---@type LazySpec
return {
	'mfussenegger/nvim-lint',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local lint = require 'lint'
		local luacheck = lint.linters.luacheck
		local markdownlint = lint.linters.markdownlint

		if luacheck then
			local function bufname()
				return vim.api.nvim_buf_get_name(0)
			end

			luacheck.args = {
				'--formatter',
				'plain',
				'--codes',
				'--ranges',
				'--globals',
				'vim',
				'--filename',
				bufname,
				'--config',
				function()
					return vim.fn.stdpath 'config' .. '/.luacheckrc'
				end,
				'-',
			}
		end

		if markdownlint then
			markdownlint.args = {
				'--stdin',
				'--config',
				function()
					return vim.fn.stdpath 'config' .. '/.markdownlint.jsonc'
				end,
			}
		end

		lint.linters_by_ft = {
			bash = { 'shellcheck' },
			c = { 'cpplint' },
			cmake = { 'cmake_lint' },
			cpp = { 'cpplint' },
			css = { 'stylelint' },
			dotenv = { 'dotenv_linter' },
			html = { 'htmlhint' },
			javascript = { 'eslint_d' },
			javascriptreact = { 'eslint_d' },
			json = { 'jsonlint' },
			lua = { 'luacheck' },
			markdown = { 'markdownlint' },
			python = { 'ruff' },
			scss = { 'stylelint' },
			sh = { 'shellcheck' },
			typescript = { 'eslint_d' },
			typescriptreact = { 'eslint_d' },
			yaml = { 'yamllint' },
			zsh = { 'shellcheck' },
		}

		local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
		vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
			group = lint_augroup,
			callback = function(event)
				if vim.bo[event.buf].modifiable and vim.bo[event.buf].buftype == '' then
					lint.try_lint(nil, { ignore_errors = true })

					if event.event == 'BufWritePost' then
						lint.try_lint('typos', { ignore_errors = true })
					end
				end
			end,
		})
	end,
}
