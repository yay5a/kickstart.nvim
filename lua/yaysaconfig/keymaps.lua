local km = vim.keymap.set
local undodir = vim.fs.joinpath(vim.fn.stdpath 'state', 'undo')

-- faster ui
vim.opt.timeoutlen = 300
vim.opt.updatetime = 200

if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end

vim.opt.undofile = true
vim.opt.undodir = undodir

vim.opt.guicursor = ''

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'

-- Keymaps
km('n', '<leader>pv', vim.cmd.Ex)
-- If using oil.nvim:
-- km("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "[P]roject [V]iew (oil)" })

km('v', 'J', ":m '>+1<CR>gv=gv")
km('v', 'K', ":m '<-2<CR>gv=gv")

km('n', '<C-d>', '<C-d>zz')
km('n', '<C-u>', '<C-u>zz')

-- Telescope core
km('n', '<leader>ff', '<cmd>Telescope find_files<CR>',   { desc = '[F]ind [F]iles' })
km('n', '<leader>fg', '<cmd>Telescope live_grep<CR>',    { desc = '[F]ind by [G]rep' })
km('n', '<leader>fb', '<cmd>Telescope buffers<CR>',      { desc = '[F]ind [B]uffers' })
km('n', '<leader>fh', '<cmd>Telescope help_tags<CR>',    { desc = '[F]ind [H]elp' })
km('n', '<leader>fr', '<cmd>Telescope resume<CR>',       { desc = '[F]ind [R]esume' })
km('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>',     { desc = '[F]ind [O]ldfiles' })
km('n', '<leader>fk', '<cmd>Telescope keymaps<CR>',      { desc = '[F]ind [K]eymaps' })
km('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>',  { desc = '[F]ind [D]iagnostics' })
km('n', '<leader>fw', '<cmd>Telescope grep_string<CR>',  { desc = '[F]ind current [W]ord' })

-- Fuzzy search in current buffer
km('n', '<leader>/',  function()
  require('telescope.builtin').current_buffer_fuzzy_find(
    require('telescope.themes').get_dropdown { winblend = 10, previewer = false }
  )
end, { desc = '[/] Fuzzy search buffer' })

-- Search Neovim config
km('n', '<leader>fc', function()
  builtin.find_files { cwd = vim.fn.stdpath('config') }
end, { desc = '[F]ind [C]onfig files' })

-- Formatting
km('n', '<leader>F', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })
