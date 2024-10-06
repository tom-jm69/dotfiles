# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tom/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tom/.fzf/bin"
fi

source <(fzf --zsh)
