local undodir = vim.fs.joinpath(vim.fn.stdpath 'state', 'undo')

if vim.fn.has 'wsl' == 1 then
	vim.g.clipboard = {
		name = 'win32yank-wsl',
		copy = {
			['+'] = { 'win32yank.exe', '-i', '--crlf' },
			['*'] = { 'win32yank.exe', '-i', '--crlf' },
		},
		paste = {
			['+'] = { 'win32yank.exe', '-o', '--lf' },
			['*'] = { 'win32yank.exe', '-o', '--lf' },
		},
		cache_enabled = 0,
	}
end

vim.opt.clipboard = 'unnamedplus'
vim.opt.timeoutlen = 300
vim.opt.updatetime = 200

if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, 'p')
end

vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.guicursor = ''
vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.confirm = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'

vim.diagnostic.config {
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_lines = false,
	jump = { float = true },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = '󰅚 ',
			[vim.diagnostic.severity.WARN] = '󰀪 ',
			[vim.diagnostic.severity.INFO] = '󰋽 ',
			[vim.diagnostic.severity.HINT] = '󰌶 ',
		},
	} or {},
	virtual_text = {
		source = 'if_many',
		spacing = 1,
		format = function(diagnostic)
			local messages = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}

			return messages[diagnostic.severity]
		end,
	},
}
