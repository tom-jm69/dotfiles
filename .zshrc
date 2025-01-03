# If you come from bash you might have to change your $PATH.

# Set environment
export ZSH="$HOME/.oh-my-zsh"
export VISUAL="nvim"
export EDITOR="nvim"
export TERM=xterm-256color
export PATH="$PATH:$HOME/.cargo/bin"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/opt/resolve/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/home/tom/.spicetify
export PATH=$PATH:~/.local/share/ltex-ls-16.0.0/bin
. "$HOME/.cargo/env"
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
export MODULAR_HOME="/home/tom/.modular"
export PATH="/home/tom/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
export GOPATH=$HOME/go
export SUDO_EDITOR="nvim"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PASSWORD_STORE_ENABLE_EXTENSIONS=true pass fzf
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$PATH:$HOME/.config/dunst/scripts
export JAVA_HOME=/usr/lib/jvm/java-23-openjdk
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Path to your oh-my-zsh installation.
bindkey "^R" history-incremental-search-backward

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias ssh="TERM=xterm-256color $(which ssh)"
alias vim="nvim"
alias q="exit"
alias lg="lazygit"
alias sshs='~/script/search-hosts.sh'
alias hosts='cat /etc/hosts | tr " " "\n" | fzf'
alias ls='eza --group-directories-first --icons'
alias r='fc -s'
alias act='source env/bin/activate'

rm() {
  echo "Are you sure you want to delete the following file(s)?"
  echo "$@"
  echo -n "Type 'yes' to confirm: "
  read confirmation
  if [[ $confirmation == "yes" ]]; then
    /bin/rm "$@"
  else
    echo "Aborted!"
  fi
}
# Print all 256 colors
colors() {
	local i
	for i in {0..255}; do
		printf "\x1b[38;5;${i}mcolor %d\n" "$i"
	done
	tput sgr0
}
alias p='pass fzf'
alias pws='pass fzf -s'
alias pw='~/.config/i3/scripts/create_pass_entry.sh'
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
