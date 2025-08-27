-- lua/yaysaconfig/adhd_theme.lua
local M = {}

local SOLID = '#0e1013'

function M.apply()
  require('rose-pine').setup {
    variant = 'moon',
    disable_background = true,
    dim_inactive_windows = true,
    extend_background_behind_borders = true,

    enable = {
      terminal = true,
      legacy_hlghlights = true,
      migrations = true,
    },

    styles = {
      bold = true,
      italic = true,
      transparency = true,
    },

    groups = {
      border = 'muted',
      link = 'iris',
      panel = 'surface',
      error = 'love',
      hint = 'iris',
      info = 'foam',
      note = 'pine',
      todo = 'rose',
      warn = 'gold',

      git_add = 'foam',
      git_change = 'rose',
      git_delete = 'love',
      git_dirty = 'rose',
      git_ignore = 'muted',
      git_merge = 'iris',
      git_rename = 'pine',
      git_stage = 'iris',
      git_text = 'rose',
      git_untracked = 'subtle',

      h1 = 'iris',
      h2 = 'foam',
      h3 = 'rose',
      h4 = 'gold',
      h5 = 'pine',
      h6 = 'foam',
    },
  }

  vim.cmd.colorscheme 'rose-pine'
  vim.diagnostic.config { virtual_text = false, severity_sort = true }

  local C = {
    yellow = '#FFDA63',
    orange = '#FFA500',
    cyan = '#46D2E8',
    blue = '#1E90FF',
    royal = '#7B68EE',
    plum = '#DA70D6',
    red = '#DC143C',
    burgundy = '#8B0000',
    text = '#F5F5F5',
    muted = '#A9A9A9',
    sel = '#2F4F4F',
  }

  local hi = vim.api.nvim_set_hl

  -- ===== Core editor =====
  hi(0, 'Normal', { fg = C.text })
  hi(0, 'Comment', { fg = C.muted, italic = true })
  hi(0, 'CursorLine', { bg = C.sel })
  hi(0, 'Visual', { bg = C.sel, bold = true })
  hi(0, 'LineNr', { fg = '#525a6a' })
  hi(0, 'CursorLineNr', { fg = C.yellow, bold = true })
  hi(0, 'Search', { fg = SOLID, bg = C.yellow, bold = true })
  hi(0, 'IncSearch', { fg = SOLID, bg = C.orange, bold = true })
  hi(0, 'MatchParen', { fg = C.cyan, bold = true })
  hi(0, 'Pmenu', { fg = C.text, bg = C.panel })
  hi(0, 'PmenuSel', { fg = C.text, bg = C.sel, bold = true })
  hi(0, 'Whitespace', { fg = '#3a4355' })

  -- ===== Classic syntax =====
  hi(0, 'Keyword', { fg = C.plum, bold = true })
  hi(0, 'Conditional', { fg = C.plum, bold = true })
  hi(0, 'Repeat', { fg = C.plum })
  hi(0, 'Operator', { fg = C.royal })
  hi(0, 'Function', { fg = C.cyan })
  hi(0, 'Identifier', { fg = C.text })
  hi(0, 'Type', { fg = C.blue, bold = true })
  hi(0, 'Constant', { fg = C.orange, bold = true })
  hi(0, 'String', { fg = C.magenta })
  hi(0, 'Character', { fg = C.magenta })
  hi(0, 'Number', { fg = C.yellow })
  hi(0, 'Boolean', { fg = C.yellow })
  hi(0, 'Special', { fg = C.orange })

  -- ===== Diagnostics =====
  hi(0, 'DiagnosticError', { fg = C.red })
  hi(0, 'DiagnosticWarn', { fg = C.orange })
  hi(0, 'DiagnosticInfo', { fg = C.cyan })
  hi(0, 'DiagnosticHint', { fg = C.blue })
  hi(0, 'DiagnosticUnderlineError', { sp = C.red, undercurl = true })
  hi(0, 'DiagnosticUnderlineWarn', { sp = C.orange, undercurl = true })
  hi(0, 'DiagnosticUnderlineInfo', { sp = C.cyan, undercurl = true })
  hi(0, 'DiagnosticUnderlineHint', { sp = C.blue, undercurl = true })

  -- ===== Treesitter + semantic highlighting =====
  local link = function(a, b)
    hi(0, a, { link = b })
  end

  link('@comment', 'Comment')
  link('@keyword', 'Keyword')
  link('@keyword.return', 'Keyword')
  link('@keyword.function', 'Keyword')
  link('@conditional', 'Conditional')
  link('@repeat', 'Repeat')
  link('@operator', 'Operator')
  link('@string', 'String')
  link('@character', 'Character')
  link('@boolean', 'Boolean')
  link('@number', 'Number')
  link('@constant', 'Constant')
  link('@constant.builtin', 'Constant')

  -- Function & Methods
  link('@function', 'Function')
  link('@function.call', 'Function')
  link('@method', 'Function')
  link('@method.call', 'Function')

  -- Types
  hi(0, '@type', { fg = C.blue, bold = true })
  hi(0, '@class', { fg = C.royal, bold = true })
  hi(0, '@interface', { fg = C.softviolet, italic = true })
  hi(0, '@namespace', { fg = C.text, italic = true })

  -- Variables
  hi(0, '@parameter', { fg = C.softcyan, italic = true })
  hi(0, '@property', { fg = C.orange }) -- JSX props
  hi(0, '@field', { fg = C.text })
  hi(0, '@variable.member', { fg = C.text })
  hi(0, '@punctuation', { fg = C.royal })

  -- JSX/HTML
  hi(0, '@tag', { fg = C.yellow, bold = true })
  hi(0, '@attribute', { fg = C.orange })

  -- Diff/Git
  hi(0, 'DiffAdd', { fg = C.cyan })
  hi(0, 'DiffChange', { fg = C.yellow })
  hi(0, 'DiffDelete', { fg = C.red })
  hi(0, 'DiffText', { fg = C.blue, bold = true })

  -- Telescope
  local BG_SOLID = SOLID
  hi(0, 'TelescopeNormal', { fg = C.text, bg = BG_SOLID })
  hi(0, 'TelescopeBorder', { fg = C.royal, bg = BG_SOLID })
  hi(0, 'TelescopePromptNormal', { fg = C.text, bg = BG_SOLID })
  hi(0, 'TelescopePromptBorder', { fg = C.blue, bg = BG_SOLID })
  hi(0, 'TelescopePromptPrefix', { fg = C.orange, bg = BG_SOLID })
  hi(0, 'TelescopeResultsNormal', { fg = C.text, bg = BG_SOLID })
  hi(0, 'TelescopeResultsBorder', { fg = C.royal, bg = BG_SOLID })
  hi(0, 'TelescopePreviewNormal', { fg = C.text, bg = BG_SOLID })
  hi(0, 'TelescopePreviewBorder', { fg = C.royal, bg = BG_SOLID })
  hi(0, 'TelescopeSelection', { fg = C.text, bg = C.sel, bold = true })
  hi(0, 'TelescopeSelectionCaret', { fg = C.orange, bg = C.sel })
  hi(0, 'TelescopeMatching', { fg = C.yellow, bold = true })

  -- Statusline
  hi(0, 'StatusLine', { fg = C.text, bg = BG_SOLID })
  hi(0, 'StatusLineNC', { fg = C.muted, bg = BG_SOLID })
  hi(0, 'MiniStatuslineModeNormal', { fg = BG_SOLID, bg = C.royal, bold = true })
  hi(0, 'MiniStatuslineModeInsert', { fg = BG_SOLID, bg = C.cyan, bold = true })
  hi(0, 'MiniStatuslineModeVisual', { fg = BG_SOLID, bg = C.plum, bold = true })
  hi(0, 'MiniStatuslineModeReplace', { fg = BG_SOLID, bg = C.red, bold = true })
  hi(0, 'MiniStatuslineModeCommand', { fg = BG_SOLID, bg = C.orange, bold = true })
  hi(0, 'MiniStatuslineFileinfo', { fg = C.yellow, bg = BG_SOLID })
  hi(0, 'MiniStatuslineDevinfo', { fg = C.blue, bg = BG_SOLID })

  hi(0, 'WinSeparator', { fg = '#1f2a3a', bg = 'NONE' })
  hi(0, 'Todo', { fg = C.yellow, bold = true })
end

function M.focus_bg(on)
  if on == nil then
    on = true
  end
  if on then
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#0e1013' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#0e1013' })
  else
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
  end
end

return M
