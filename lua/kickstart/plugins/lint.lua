return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    -- Make luacheck see the buffer path and your .luacheckrc
    local luacheck = lint.linters.luacheck
    if luacheck then
      -- run from the file's directory so upward search finds ~/.config/nvim/.luacheckrc
      local function bufname()
        return vim.api.nvim_buf_get_name(0)
      end
      -- include filename and a fallback 'vim' global in case cwd detection fails
      luacheck.args = {
        '--formatter',
        'plain',
        '--codes',
        '--ranges',
        '--globals',
        'vim',
        '--filename',
        bufname,
        '--config',
        function()
          return vim.fn.stdpath 'config' .. '/.luacheckrc'
        end,
        '-',
      }
    end

    -- choose your linters per filetype
    lint.linters_by_ft = {
      lua = { 'luacheck' },
      python = { 'ruff' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      css = { 'stylelint' },
      scss = { 'stylelint' },
      html = { 'htmlhint' },
      markdown = { 'markdownlint' },
      c = (vim.fn.executable 'clang-tidy' == 1) and { 'clangtidy' } or (vim.fn.executable 'cpplint' == 1 and { 'cpplint' } or {}),
      cpp = (vim.fn.executable 'clang-tidy' == 1) and { 'clangtidy' } or (vim.fn.executable 'cpplint' == 1 and { 'cpplint' } or {}),
      rust = { 'clippy' },
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
}
