---@module 'lazy'
---@type LazySpec
return {
	'rose-pine/neovim',
	name = 'rose-pine',
	priority = 1000,
	lazy = false,
	config = function()
		require('yaysaconfig.adhd_theme').apply()

		vim.keymap.set('n', '<leader>tf', function()
			local bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
			require('yaysaconfig.adhd_theme').focus_bg(bg == nil)
		end, { desc = '[T]oggle [F]ocus background' })
	end,
}
