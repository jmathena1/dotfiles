-- ~/.config/nvim/init.lua

-- 1. Set the mapleader key first (crucial to set before mappings are loaded)
vim.g.mapleader = '\\'

-- 2. Load colorscheme package immediately and apply
pcall(vim.cmd.packadd, 'mustang-vim')
pcall(vim.cmd.colorscheme, 'mustang')

-- 3. Load separate configuration modules
require('general')
require('mappings')
require('plugins')
require('lsp')
