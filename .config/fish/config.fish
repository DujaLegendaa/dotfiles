source ~/.asdf/asdf.fish
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -x XLA_TARGET cuda111

