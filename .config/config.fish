if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx EDITOR vim
uv generate-shell-completion fish | source
