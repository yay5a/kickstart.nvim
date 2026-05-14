---@module 'lazy'
---@type LazySpec
return {
	'stevearc/oil.nvim',
	lazy = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,
		columns = {},
		keymaps = {
			['<C-h>'] = false,
			['<C-l>'] = false,
			['<C-c>'] = false,
			['<C-r>'] = 'actions.refresh',
			['<M-h>'] = { 'actions.select', opts = { horizontal = true } },
			q = 'actions.close',
		},
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
		},
	},
	keys = {
		{ '-', '<cmd>Oil<CR>', desc = 'Open parent directory' },
		{
			'<leader>-',
			function()
				require('oil').toggle_float()
			end,
			desc = 'Toggle Oil float',
		},
		{ '<leader>pv', '<cmd>Oil<CR>', desc = 'Open parent directory' },
	},
}
