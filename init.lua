require('vim._core.ui2').enable({
    enable = true,
    msg = {
        target = "cmd", -- options: cmd(classic), msg(similar to noice)
        pager = { height = 1 },
        msg   = { height = 0.5, timeout = 4500 },
        dialog = { height = 0.5 },
        cmd    = { height = 0.5 },
    },
})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require("yaysa.core")
require("yaysa.lazy")
require("current-theme")
