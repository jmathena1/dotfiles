-- ~/.config/nvim/lua/lsp.lua

-- 1. Create a global attachment callback for all LSP servers
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Set omnifunc for LSP completion
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

    local opts = { buffer = bufnr, remap = false, silent = true }

    -- Standard Navigation and Information Mappings
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'LSP: Declaration' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'LSP: Definition' }))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'LSP: Hover info' }))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'LSP: Implementation' }))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'LSP: References' }))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'LSP: Signature help' }))

    -- Code Actions & Rename
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'LSP: Type definition' }))
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'LSP: Rename' }))
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'LSP: Code action' }))

    -- Diagnostics
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'LSP: Line diagnostics' }))
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = 'LSP: Location list' }))

    -- Formatting mapping
    if client and client.server_capabilities.documentFormattingProvider then
      vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format({ async = true })
      end, vim.tbl_extend('force', opts, { desc = 'LSP: Format buffer' }))
    end

    -- Document Highlight handling with clean native autocommands
    if client and client.server_capabilities.documentHighlightProvider then
      vim.cmd([[
        hi! link LspReferenceRead Visual
        hi! link LspReferenceText Visual
        hi! link LspReferenceWrite Visual
      ]])

      local gid = vim.api.nvim_create_augroup('lsp_document_highlight_' .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd('CursorHold', {
        group = gid,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = gid,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- 2. Activate desired language servers natively
vim.lsp.enable({
  'lua-language-server',
  'ruby-lsp',
  'solargraph',
  'ts_ls'
})

-- 3. Automatically format code on file save
local fmt_group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = fmt_group,
  pattern = { '*.rb', '*.lua', '*.ts', '*.tsx' },
  callback = function()
    vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
  end,
})
