#!/usr/bin/env bash
#
# Bootstraps a new machine with this dotfiles repo's Neovim configuration.
#
# - clones this repo (or reuses an existing local clone)
# - initializes/updates the git submodules (Neovim plugins under .config/nvim/pack)
# - symlinks .config/nvim into place at ~/.config/nvim
#
# Prerequisites: nvim (0.10+, for native LSP and tree-sitter features) and git.
#
# Usage: ./nvim_setup.sh
#        REPO_DIR=~/somewhere/dotfiles ./nvim_setup.sh

set -euo pipefail

REPO_URL="git@github.com:jmathena/dotfiles.git" # replace with HTTPS if needed
REPO_DIR="${REPO_DIR:-$HOME/repos/dotfiles}"

log() { printf '==> %s\n' "$1"; }
die() { printf 'error: %s\n' "$1" >&2; exit 1; }

check_prereqs() {
  [ -n "${HOME:-}" ] || die "HOME is not set; refusing to touch the filesystem."

  for cmd in nvim git; do
    command -v "$cmd" >/dev/null 2>&1 ||
      die "$cmd is required but not installed. Install it and re-run this script."
  done
}

abspath() { printf '%s\n' "$(cd "$(dirname "$1")" && pwd -P)/$(basename "$1")"; }

link() {
  local src="$1" dest="$2"

  [ -e "$src" ] || die "expected $src to exist in the repo."

  if [ "$(abspath "$src")" = "$(abspath "$dest" 2>/dev/null || echo "$dest")" ]; then
    log "Skipping $dest (already the repo directory itself)"
    return
  fi

  if [ "$(readlink "$dest" 2>/dev/null)" = "$src" ]; then
    log "$dest already links to $src"
    return
  fi

  if [ -d "$dest" ] && [ ! -L "$dest" ]; then
    die "$dest is a real directory. Move or remove it yourself, then re-run."
  fi

  log "Symlinking $dest -> $src"
  ln -sfn "$src" "$dest"
}

clone_repo() {
  if [ -d "$REPO_DIR/.git" ]; then
    log "Repo already cloned at $REPO_DIR"
    return
  fi

  [ -e "$REPO_DIR" ] &&
    die "$REPO_DIR exists but is not a git clone. Move it aside or set REPO_DIR."

  log "Cloning $REPO_URL into $REPO_DIR"
  mkdir -p "$(dirname "$REPO_DIR")"
  git clone "$REPO_URL" "$REPO_DIR"
}

update_submodules() {
  log "Fetching Neovim plugin submodules"
  git -C "$REPO_DIR" submodule update --init --recursive
}

link_nvim_files() {
  local nvim_src="$REPO_DIR/.config/nvim"
  local nvim_dest="$HOME/.config/nvim"

  mkdir -p "$HOME/.config"

  link "$nvim_src" "$nvim_dest"

  # general.lua points swap files at ~/tmp
  mkdir -p "$HOME/tmp"
}

check_prereqs
clone_repo
update_submodules
link_nvim_files

log "Done. Open nvim to confirm the setup works."
