-- ~/.config/nvim/lua/plugins.lua

-- =============================================================================
-- Modern Neovim Lua Plugins (Using Native Package System)
-- =============================================================================

-- 1. FZF-Lua --- {{{
local fzf_ok, fzf = pcall(require, 'fzf-lua')
if fzf_ok then
  fzf.setup('fzf-vim')
  vim.keymap.set('n', '<leader>fzf', '<cmd>FzfLua<CR>', { desc = 'FzfLua home' })
  vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<CR>', { desc = 'FzfLua find files' })
  vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<CR>', { desc = 'FzfLua buffers' })
  vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua live_grep<CR>', { desc = 'FzfLua live grep' })
end
-- }}}

-- 2. Initialize lualine safely --- {{{
local lualine_ok, lualine = pcall(require, 'lualine')
if lualine_ok then
  lualine.setup({
    options = {
      theme = 'PaperColor',
      icons_enabled = true,
      globalstatus = true,
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          mode = 4,              -- 0: name, 1: index, 2: name+index, 3: number, 4: name+number
          show_filename_only = true,
          show_modified_status = true,
        }
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        {
          function()
            local current_line = vim.fn.line('.')
            local total_lines = vim.fn.line('$')
            return string.format(' %d/%d', current_line, total_lines)
          end
        }
      }
    }
  })
end
-- }}}

-- 3. Initialize neo-tree safely --- {{{
local neotree_ok, neotree = pcall(require, 'neo-tree')
if neotree_ok then
  neotree.setup({
    close_if_last_window = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      }
    },
    window = {
      position = "left",
      width = 30,
    }
  })
  vim.keymap.set('n', '<leader>t', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })
  vim.keymap.set('n', '<leader>f', '<cmd>Neotree reveal<CR>', { desc = 'Find current file in Neo-tree' })
end
-- }}}

