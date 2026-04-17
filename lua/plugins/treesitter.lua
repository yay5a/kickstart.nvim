---@module 'lazy'
---@type LazySpec
return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	branch = 'main',
	config = function()
		local ts = require 'nvim-treesitter'

		ts.setup {
			install_dir = vim.fn.stdpath 'data' .. '/site',
		}

		vim.treesitter.language.register('javascript', 'javascriptreact')
		vim.treesitter.language.register('tsx', 'typescriptreact')

		local parsers = {
			'bash',
			'c',
			'diff',
			'html',
			'lua',
			'luadoc',
			'markdown',
			'markdown_inline',
			'query',
			'vim',
			'vimdoc',
			'javascript',
			'typescript',
			'tsx',
			'json',
		}

		ts.install(parsers)

		local available = ts.get_available()

		local function try_attach(buf, lang)
			if not vim.treesitter.language.add(lang) then
				return
			end

			vim.treesitter.start(buf, lang)

			if vim.treesitter.query.get(lang, 'indents') ~= nil then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		vim.api.nvim_create_autocmd('FileType', {
			callback = function(args)
				local buf = args.buf
				local filetype = args.match
				local lang = vim.treesitter.language.get_lang(filetype)

				if not lang then
					return
				end

				local installed = ts.get_installed 'parsers'

				if vim.tbl_contains(installed, lang) then
					try_attach(buf, lang)
				elseif vim.tbl_contains(available, lang) then
					ts.install(lang):await(function()
						try_attach(buf, lang)
					end)
				else
					try_attach(buf, lang)
				end
			end,
		})
	end,
}
