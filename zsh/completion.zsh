# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

###
# Hostname completion for ssh commands
$hosts=()

# Compltion from history
h=($(echo $(history | awk '{print $2 " " $3}' | grep 'ssh ' | awk '{print $2}' | sort -u)))

# Completion from custom_hosts list: "$HOME/.ssh/custom_hosts"
[[ -r $HOME/.ssh/custom_hosts ]] && hosts=($hosts $(cat $HOME/.ssh/custom_hosts))

if [[ $#hosts -gt 0 ]]; then
  # This forces host completion to read from variable $hosts
  zstyle -e ':completion:*' hosts 'reply=($hosts)'
  # zstyle ':completion:*:(ssh|scp|sftp):*' hosts $hosts
fi

###
# git
# compdef '_dispatch git git' g
