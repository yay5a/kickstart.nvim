---@module 'lazy'
---@type LazySpec
return {
	'stevearc/oil.nvim',
	lazy = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	keys = {
		{ '-', '<cmd>Oil<CR>', desc = 'Open parent directory' },
		{ '<leader>po', '<cmd>Oil<CR>', desc = 'Open parent directory' },
	},
}
