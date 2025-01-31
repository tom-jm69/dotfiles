# If you come from bash you might have to change your $PATH.

# Set environment
export ZSH="$HOME/.oh-my-zsh"
export VISUAL="nvim"
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERM=xterm-256color
export PATH=$PATH:/opt/resolve/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/home/tom/.spicetify
export PASSWORD_STORE_ENABLE_EXTENSIONS=true pass fzf
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$PATH:$HOME/.config/dunst/scripts
export JAVA_HOME=/usr/lib/jvm/java-23-openjdk

# go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

# cargo/rust
. "$HOME/.cargo/env"
export PATH="$PATH:$HOME/.cargo/bin"

# mojo
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
export PATH="/home/tom/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

# Support colors in less
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

ZSH_THEME="robbyrussell"
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
#plug "zettlrobert/simple-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/vim"
plug "zsh-history-substring-search"
plug "ap-zsh/supercharge"
plug "zap-zsh/exa"
#plug "romkatv/powerlevel10k"
plug "kutsan/zsh-system-clipboard"

# Example sourcing of local files
#plug "$HOME/.config/zsh/aliases.zsh"
#plug "$HOME/.config/zsh/exports.zsh"

# Load and initialise completion system
# autoload -Uz compinit
# compinit

eval "$(zoxide init --cmd cd  zsh)"

bindkey "^R" history-incremental-search-backward

ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh
alias vim="nvim"
alias q="exit"
alias lg="lazygit"
alias sshs='~/script/search-hosts.sh'
alias hosts='cat /etc/hosts | tr " " "\n" | fzf'
alias ls='eza --group-directories-first --icons'
alias r='fc -s'
alias act='source env/bin/activate'


source ~/.sources/*

#zprof debug timing
#eval "$(starship init zsh)"
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!{.git,node_modules}/*"'
export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_COMMAND='rg --files --hidden --glob "!{.git,node_modules}/*"'
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border
    --margin=1 --padding=1 --multi --preview '[[ -f {} ]] && bat --color=always {}' --no-mouse \
    --color=fg:-1,bg:-1,hl:#b6d5f5 \
    --color=fg+:#ffffff,bg+:#0a0909,hl+:#99d94c \
    --color=info:#e3ba62,prompt:#b6d5f5,pointer:#ff0000 \
    --color=marker:#ffffff,spinner:#ffe100,header:#ffe100 \
    --border=double
      "

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
