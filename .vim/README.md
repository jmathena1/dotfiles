I'm currently using Vim's native package manager that's been available since Vim 8.
Previous commits to these repo used Vundle. I liked Vundle, I just don't have that many plugins and am trying to take more advantage of Vim's built-ins.

Anywho, my `.vim/pack` directory is currently organized into these folders:
- `airline/`
- `colors/`
- `plugins/`

You can see which plugins I'm using by looking in the `.gitmodules` file at the root of this repo.

I'm using submodules to copy my Vim setup across machines and found this [gist](https://gist.github.com/manasthakur/d4dc9a610884c60d944a4dd97f0b3560) helpful in setting this flow up.

## New machine setup

### Prequisites
- some type of terminal emulator (I like Ghostty, but use what you want)
- Vim
- git

- Clone this repo onto your machine
- Pull down all the submodules containing Vim plugins
    - example command: `git submodule update --init --recursive`
- Copy the `.vim/pack` path into your home directory
    - example command: `cp -r ./.vim ~/.vim`
- Copy the `vimrc` file from the project root to your home directory. 
    - example command: `cp ./vimrc ~/.vimrc`
- Symlink the vim files to your home directory
    - example command: `ln -sf dotfiles ~/.vim && ln -sf dotfiles/vimrc ~/.vimrc`

