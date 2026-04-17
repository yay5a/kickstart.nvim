local km = vim.keymap.set
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

-- faster ui
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

km('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list ' })

-- Keymaps
km('n', '<leader>pv', vim.cmd.Ex)
-- If using oil.nvim:
-- km("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "[P]roject [V]iew (oil)" })
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

km('v', 'J', ":m '>+1<CR>gv=gv")
km('v', 'K', ":m '<-2<CR>gv=gv")

km('n', '<C-d>', '<C-d>zz')
km('n', '<C-u>', '<C-u>zz')
