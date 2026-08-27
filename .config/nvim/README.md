I'm currently using Neovim's native package manager (`pack/plugins/start`).

My Neovim configuration is written entirely in Lua and organized into modular files:
- `init.lua`
- `lua/general.lua`
- `lua/mappings.lua`
- `lua/plugins.lua`
- `lua/lsp.lua`
- `lsp/`

You can see which plugins I'm using by looking in the `.gitmodules` file at the root of this repo.

## New machine setup

### Prerequisites
- some type of terminal emulator (I like Ghostty, but use what you want)
- Neovim (0.10+ recommended for native LSP and Tree-sitter support)
- git
- a patched Nerd Font (for file icons in `neo-tree` and `lualine`)
- language servers (e.g. `lua-language-server`, `typescript-language-server`) or just get rid of the lsp stuff

### Instructions

You can run `scripts/nvim_setup.sh` in the `scripts` directory if you don't want to follow the manual steps below.

- Clone this repo onto your machine:
  - `git clone git@github.com:jmathena/dotfiles.git ~/repos/dotfiles`
- Pull down all the submodules containing Neovim plugins:
  - `git submodule update --init --recursive`
- Symlink the `.config/nvim` directory into your `~/.config` directory:
  - `mkdir -p ~/.config`
  - `ln -s ~/repos/dotfiles/.config/nvim ~/.config/nvim`
- Make a `tmp` folder in your home directory:
  - `mkdir -p ~/tmp` (used for swap files)
- Undo history is automatically managed by Neovim in its standard state directory (`~/.local/state/nvim/undo`)
