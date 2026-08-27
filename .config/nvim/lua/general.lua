-- ~/.config/nvim/lua/general.lua

-- Define an autocommand group to prevent duplicate registration if the config is reloaded
local general_group = vim.api.nvim_create_augroup('GeneralSettings', { clear = true })

-- =============================================================================
-- 1. Autocommands & Filetype Settings
-- =============================================================================

-- Highlight bad whitespace in Python and C files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = general_group,
  pattern = { '*.py', '*.pyw', '*.c', '*.h' },
  command = 'match BadWhitespace /\\s\\+$/',
})

-- Indentation rules for Makefiles (must use tabs)
vim.api.nvim_create_autocmd('FileType', {
  group = general_group,
  pattern = 'make',
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- Indentation adjustments for web assets
vim.api.nvim_create_autocmd('FileType', {
  group = general_group,
  pattern = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'scss', 'json', 'yaml' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Indentation/formatting defaults for Python
vim.api.nvim_create_autocmd('FileType', {
  group = general_group,
  pattern = 'python',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.textwidth = 79
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.fileformat = 'unix'
  end,
})

-- Enable native Tree-sitter folding for supported filetypes
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'FileType' }, {
  group = general_group,
  pattern = '*',
  callback = function()
    local ok, parser = pcall(vim.treesitter.get_parser)
    if ok and parser then
      vim.opt_local.foldmethod = 'expr'
      vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  end,
})

-- Use marker-based folding for Vimscript and Lua files (enables folding of {{{ ... }}} blocks)
vim.api.nvim_create_autocmd('FileType', {
  group = general_group,
  pattern = { 'vim', 'lua' },
  callback = function()
    vim.opt_local.foldmethod = 'marker'
  end,
})

-- Toggle cursorline & cursorcolumn in active vs inactive windows
local cursor_off_group = vim.api.nvim_create_augroup('cursor_off', { clear = true })

vim.api.nvim_create_autocmd('WinLeave', {
  group = cursor_off_group,
  pattern = '*',
  callback = function()
    vim.opt_local.cursorline = false
    vim.opt_local.cursorcolumn = false
  end,
})

vim.api.nvim_create_autocmd('WinEnter', {
  group = cursor_off_group,
  pattern = '*',
  callback = function()
    vim.opt_local.cursorline = true
    vim.opt_local.cursorcolumn = true
  end,
})

-- =============================================================================
-- 2. Highlight Configurations & Variables
-- =============================================================================

-- Define the BadWhitespace highlight group
vim.api.nvim_set_hl(0, 'BadWhitespace', { ctermbg = 'red', bg = 'red' })

-- Define the Folded highlight group (highlights folded text black)
vim.api.nvim_set_hl(0, 'Folded', { ctermfg = 'black', fg = 'black' })

-- Python highlight variable
vim.g.python_highlight_all = 1

-- =============================================================================
-- 3. Global Editor Options (vim.opt)
-- =============================================================================

-- Indentation defaults (Tabs to 4 spaces)
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Clipboard: Allows access to system clipboard
vim.opt.clipboard = 'unnamed,unnamedplus'

-- Highlight cursor line & column
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Swap/Backup Directory
vim.opt.directory = vim.fn.expand('~/tmp//')

-- Encoding
vim.opt.encoding = 'utf-8'

-- Code Folding
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99

-- Search Settings
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Display Options
vim.opt.wrap = false           -- nowrap
vim.opt.scrolloff = 10         -- Keep at least 10 lines visible above/below cursor
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = true

-- Hybrid relative line numbering
vim.opt.number = true
vim.opt.relativenumber = true  -- rnu

-- Command-line Completion Options (wildmenu/wildmode)
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest'

-- Undo persistence
vim.opt.undodir = vim.fn.stdpath('state') .. '/undo'
vim.opt.undofile = true
vim.opt.undoreload = 10000

