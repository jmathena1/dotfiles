I'm currently using Vim's native package manager that's been available since Vim 8.
Previous commits to these repo used Vundle. I liked Vundle, I just don't have that many plugins and am trying to take more advantage of Vim's built-ins.

Anywho, my `.vim/pack` directory is currently organized into these folders:
- `airline/`
- `colors/`
- `plugins/`

You can see which plugins I'm using by looking in the `.gitmodules` file at the root of this repo.

I'm using submodules to copy my Vim setup across machines and found this [gist](https://gist.github.com/manasthakur/d4dc9a610884c60d944a4dd97f0b3560) helpful in setting this flow up.
