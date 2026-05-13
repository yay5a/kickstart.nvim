---@module 'lazy'
---@type LazySpec
return {
	'stevearc/oil.nvim',
	lazy = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		view_options = {
			show_hidden = true,
		},
	},
	keys = {
		{ '-', '<cmd>Oil<CR>', desc = 'Open parent directory' },
		{ '<leader>pv', '<cmd>Oil<CR>', desc = 'Open parent directory' },
	},
}
