local M = {}

function M.apply()
	require("yaysa.theme").apply()

	vim.keymap.set("n", "<leader>tf", function()
		local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
		require("yaysa.theme").focus_bg(bg == nil)
	end, { desc = "[T]oggle [F]ocus background" })
end

M.apply()

return M
