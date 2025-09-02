return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      local has = function(bin)
        return vim.fn.executable(bin) == 1
      end

      -- prefer clang-tidy if installed (system), else cpplint (from Mason)
      local c_linters = has 'clang-tidy' and { 'clangtidy' } or has 'cpplint' and { 'cpplint' } or {}

      lint.linters_by_ft = {
        c = c_linters,
        cpp = c_linters,

        rust = { 'clippy' }, -- requires `rustup component add clippy`
        python = { 'ruff' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        lua = { 'luacheck' },
        css = { 'stylelint' },
        html = { 'htmlhint' }, -- or { 'tidy' } if you prefer HTML Tidy (system pkg)
        scss = { 'stylelint' },
        markdown = { 'markdownlint' },
      }

      local grp = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = grp,
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
