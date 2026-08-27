-- ~/.config/nvim/lua/mappings.lua

-- Center screen on vertical page movements
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Split navigation (Ctrl + h/j/k/l)
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')

-- Resize split windows using Ctrl + Shift + Arrow keys
vim.keymap.set('n', '<C-S-Up>', '<C-w>+')
vim.keymap.set('n', '<C-S-Down>', '<C-w>-')
vim.keymap.set('n', '<C-S-Left>', '<C-w>>')
vim.keymap.set('n', '<C-S-Right>', '<C-w><')

-- Press \\ (Leader + Backslash) to jump back to the last cursor position
vim.keymap.set('n', '<leader>\\', '``')

-- Exit insert mode quickly by typing jj
vim.keymap.set('i', 'jj', '<Esc>')

-- Open a new line below/above without entering insert mode
vim.keymap.set('n', '<leader>o', 'o<Esc>', { desc = 'Insert blank line below' })
vim.keymap.set('n', '<leader>O', 'O<Esc>', { desc = 'Insert blank line above' })

-- Center search results vertically
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- Smart Tab completion: complete if after word, otherwise insert regular tab
local function check_backspace()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

vim.keymap.set('i', '<Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  elseif not check_backspace() then
    return '<C-x><C-o>'
  else
    return '<Tab>'
  end
end, { expr = true, desc = 'Autocomplete or insert Tab' })

vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true, desc = 'Cycle completion list backward' })

vim.keymap.set('i', '<CR>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true, desc = 'Accept completion item' })

vim.keymap.set('i', '<Esc>', function()
  return vim.fn.pumvisible() == 1 and '<C-e>' or '<Esc>'
end, { expr = true, desc = 'Cancel completion popup' })

