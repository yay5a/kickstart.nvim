return {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = { 'lua/?.lua', 'lua/?/init.lua' },
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.fn.stdpath 'config' .. '/lua',
					vim.env.VIMRUNTIME .. '/lua',
				},
			},
			completion = {
				callSnippet = 'Replace',
			},
		},
	},
}
