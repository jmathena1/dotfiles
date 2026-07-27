#!/usr/bin/env bash
#
# Bootstraps a new machine with this dotfiles repo's Vim configuration.
#
# - clones this repo (or reuses an existing local clone)
# - initializes/updates the git submodules (Vim plugins under .vim/pack)
# - copies the plugin directory into ~/.vim/pack
# - symlinks the vimrc and .vim/*.vim files into place
#
# Prerequisites: vim and git must already be installed.
#
# Usage: ./setup.sh
#        REPO_DIR=~/somewhere/dotfiles ./setup.sh

set -euo pipefail

REPO_URL="git@github.com:jmathena/dotfiles.git"
REPO_DIR="${REPO_DIR:-$HOME/repos/dotfiles}"

log() { printf '==> %s\n' "$1"; }

check_prereqs() {
  for cmd in vim git; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "$cmd is required but not installed. Install it and re-run this script." >&2
      exit 1
    fi
  done
}

clone_repo() {
  if [ -d "$REPO_DIR/.git" ]; then
    log "Repo already cloned at $REPO_DIR"
    return
  fi

  log "Cloning $REPO_URL into $REPO_DIR"
  mkdir -p "$(dirname "$REPO_DIR")"
  git clone "$REPO_URL" "$REPO_DIR"
}

update_submodules() {
  log "Fetching Vim plugin submodules"
  git -C "$REPO_DIR" submodule update --init --recursive
}

link_vim_files() {
  local vim_src="$REPO_DIR/.vim"
  local vim_dest="$HOME/.vim"

  mkdir -p "$vim_dest"

  # The pack/ directory holds plugin submodules; copy it rather than
  # symlinking so each plugin's nested .git file is left untouched.
  log "Copying $vim_src/pack -> $vim_dest/pack"
  rm -rf "$vim_dest/pack"
  cp -r "$vim_src/pack" "$vim_dest/pack"

  for f in general.vim mappings.vim plugins.vim; do
    log "Symlinking $vim_dest/$f -> $vim_src/$f"
    ln -sf "$vim_src/$f" "$vim_dest/$f"
  done

  log "Symlinking $HOME/.vimrc -> $REPO_DIR/vimrc"
  ln -sf "$REPO_DIR/vimrc" "$HOME/.vimrc"

  # general.vim points 'dir' (swap files) at ~/tmp and 'undodir' at ~/.vim/backup.
  mkdir -p "$HOME/tmp" "$vim_dest/backup"
}

check_prereqs
clone_repo
update_submodules
link_vim_files

log "Done. Open vim to confirm the setup works."
