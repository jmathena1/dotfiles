return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                -- Resolve require('general') etc. the way Neovim does
                path = { "lua/?.lua", "lua/?/init.lua" },
            },
            diagnostics = { globals = { "vim" } },
            workspace = {
                checkThirdParty = false,
                -- Without this, editing this config gets no completion or
                -- signature help for the vim.* API.
                library = { vim.env.VIMRUNTIME },
            },
        },
    },
}
