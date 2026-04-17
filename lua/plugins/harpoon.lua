---@module 'lazy'
---@type LazySpec
return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('harpoon'):setup()
		pcall(function()
			require('telescope').load_extension 'harpoon'
		end)
	end,
	keys = {
		{
			'<leader>ha',
			function()
				require('harpoon'):list():add()
			end,
			desc = 'Harpoon: Add file',
		},
		{
			'<leader>hm',
			function()
				require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
			end,
			desc = 'Harpoon: Menu',
		},
		{
			'<leader>1',
			function()
				require('harpoon'):list():select(1)
			end,
			desc = 'Harpoon: File 1',
		},
		{
			'<leader>2',
			function()
				require('harpoon'):list():select(2)
			end,
			desc = 'Harpoon: File 2',
		},
		{
			'<leader>3',
			function()
				require('harpoon'):list():select(3)
			end,
			desc = 'Harpoon: File 3',
		},
		{
			'<leader>4',
			function()
				require('harpoon'):list():select(4)
			end,
			desc = 'Harpoon: File 4',
		},
		{
			']h',
			function()
				require('harpoon'):list():next()
			end,
			desc = 'Harpoon: Next',
		},
		{
			'[h',
			function()
				require('harpoon'):list():prev()
			end,
			desc = 'Harpoon: Prev',
		},
		{
			'<leader>hh',
			function()
				local ok_t, telescope = pcall(require, 'telescope')
				if ok_t then
					if not (telescope.extensions and telescope.extensions.harpoon) then
						pcall(telescope.load_extension, 'harpoon')
					end

					if telescope.extensions and telescope.extensions.harpoon then
						telescope.extensions.harpoon.marks()
						return
					end
				end

				local ok_h, harpoon = pcall(require, 'harpoon')
				if ok_h and harpoon.ui and harpoon.list then
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end
			end,
			desc = 'Harpoon: marks (Telescope if available)',
		},
	},
}
