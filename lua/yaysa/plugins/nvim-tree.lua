---@module 'lazy'
---@type LazySpec
return {
	'nvim-tree/nvim-tree.lua',
	cmd = {
		'NvimTreeToggle',
		'NvimTreeFindFileToggle',
		'NvimTreeCollapse',
		'NvimTreeRefresh',
	},
	dependencies = {
		{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	keys = {
		{ '<leader>ee', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
		{ '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'Find current file in explorer' },
		{ '<leader>ec', '<cmd>NvimTreeCollapse<CR>', desc = 'Collapse file explorer' },
		{ '<leader>er', '<cmd>NvimTreeRefresh<CR>', desc = 'Refresh file explorer' },
	},
	---@module 'nvim-tree'
	---@type nvim_tree.config
	opts = {
		hijack_directories = {
			enable = false,
			auto_open = false,
		},
		view = {
			side = 'right',
			width = 35,
			relativenumber = true,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				glyphs = {
					folder = {
						arrow_closed = '',
						arrow_open = '',
					},
				},
			},
		},
		actions = {
			open_file = {
				window_picker = {
					enable = false,
				},
			},
		},
		filters = {
			custom = { '.DS_Store' },
		},
		git = {
			ignore = false,
		},
	},
}
