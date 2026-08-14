#!/usr/bin/env bash
#
# Bootstraps a new machine with this dotfiles repo's Vim configuration.
#
# - clones this repo (or reuses an existing local clone)
# - initializes/updates the git submodules (Vim plugins under .vim/pack)
# - symlinks .vim/pack, the .vim/*.vim files, and the vimrc into place
#
# WARNING: this replaces ~/.vimrc and ~/.vim/{pack,general.vim,mappings.vim,
# plugins.vim} with symlinks into this repo. Any existing versions of those are
# lost -- back them up first if you care about them. Everything else in ~/.vim
# is left alone, and the script never deletes anything recursively: if a real
# directory is in the way it stops and tells you rather than removing it.
#
# Prerequisites: vim (8.0+, for native package support) and git.
#
# Usage: ./vim_setup.sh
#        REPO_DIR=~/somewhere/dotfiles ./vim_setup.sh

set -euo pipefail

REPO_URL="git@github.com:jmathena/dotfiles.git" # replace with HTTPS if needed
REPO_DIR="${REPO_DIR:-$HOME/repos/dotfiles}"

log() { printf '==> %s\n' "$1"; }
die() { printf 'error: %s\n' "$1" >&2; exit 1; }

check_prereqs() {
  [ -n "${HOME:-}" ] || die "HOME is not set; refusing to touch the filesystem."

  for cmd in vim git; do
    command -v "$cmd" >/dev/null 2>&1 ||
      die "$cmd is required but not installed. Install it and re-run this script."
  done

  if ! vim --clean -es -c 'if !has("packages") | cquit | endif' -c 'qa!' </dev/null; then
    die "This vim was built without +packages (needs vim 8.0+); .vim/pack won't load."
  fi
}

abspath() { printf '%s\n' "$(cd "$(dirname "$1")" && pwd -P)/$(basename "$1")"; }

link() {
  local src="$1" dest="$2"

  [ -e "$src" ] || die "expected $src to exist in the repo."

  # If ~/.vim already resolves into the repo, src and dest are the same file.
  # 'ln -sf' would replace it with a self-referencing broken symlink and destroy
  # the repo's own copy, so leave it alone instead.
  if [ "$(abspath "$src")" = "$(abspath "$dest")" ]; then
    log "Skipping $dest (already the repo file itself)"
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
  log "Fetching Vim plugin submodules"
  git -C "$REPO_DIR" submodule update --init --recursive
}

link_vim_files() {
  local vim_src="$REPO_DIR/.vim"
  local vim_dest="$HOME/.vim"

  mkdir -p "$vim_dest"

  link "$vim_src/pack" "$vim_dest/pack"

  for f in general.vim mappings.vim plugins.vim; do
    link "$vim_src/$f" "$vim_dest/$f"
  done

  link "$REPO_DIR/vimrc" "$HOME/.vimrc"

  # general.vim points 'dir' (swap files) at ~/tmp and 'undodir' at ~/.vim/backup.
  mkdir -p "$HOME/tmp" "$vim_dest/backup"
}

check_prereqs
clone_repo
update_submodules
link_vim_files

log "Done. Open vim to confirm the setup works."
