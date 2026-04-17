local km = vim.keymap.set

km('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list ' })
km('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

km('v', 'J', ":m '>+1<CR>gv=gv")
km('v', 'K', ":m '<-2<CR>gv=gv")

km('n', '<C-d>', '<C-d>zz')
km('n', '<C-u>', '<C-u>zz')
