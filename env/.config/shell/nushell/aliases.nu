# Nushell aliases

# Navigation
alias .. cd ..
alias ... cd ../..
alias .3 cd ../../..
alias .4 cd ../../../..
alias .5 cd ../../../../..

# Vim
alias nv nvim
alias vim nvim

# Package managers
alias p pnpm

# eza - modern ls
alias ls eza -al --color=always --group-directories-first
alias la eza -a --color=always --group-directories-first
alias ll eza -l --color=always --group-directories-first
alias lt eza -aT --color=always --group-directories-first
alias l. eza -al --color=always --group-directories-first ..
alias l.. eza -al --color=always --group-directories-first ../..
alias l... eza -al --color=always --group-directories-first ../../..

# Tmux
alias tn 'tmux new -d -s'
alias tt tmux ls
alias ta 'tmux a -t'
alias ts 'tmux switch -t'
alias tk 'tmux kill-session -a'
alias tka 'tmux kill-session -t'

# Git
alias g git
alias ga git add
alias gaa 'git add .'
alias gb git branch
alias gc 'git commit -m'
alias gco git checkout
alias gd git diff
alias gf git fetch
alias gl git log
alias gp 'git push origin'
alias gpl 'git pull origin'
alias gs git status
alias gst git status

# System
alias df 'df -h'
alias free 'free -m'

# Change shell
alias tobash 'sudo chsh $USER -s /bin/bash && echo "Log out and log back in for change to take effect."'
alias tozsh 'sudo chsh $USER -s /bin/zsh && echo "Log out and log back in for change to take effect."'
alias tofish 'sudo chsh $USER -s /bin/fish && echo "Log out and log back in for change to take effect."'
alias tonu 'sudo chsh $USER -s /bin/nu && echo "Log out and log back in for change to take effect."'

# Bare git repo for dotfiles
alias config '/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
