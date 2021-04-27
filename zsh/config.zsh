export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

fpath=($DOTFILES/functions $fpath)

autoload -U $DOTFILES/functions/*(:t)

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_SPACE # Don't write commands that begin with a space to history
setopt APPEND_HISTORY # Don't overwrite history file
# setopt INC_APPEND_HISTORY # Adds history incrementally
setopt SHARE_HISTORY # Share history across sessions
setopt HIST_IGNORE_ALL_DUPS  # Don't record dupes in history
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from each command line
setopt EXTENDED_HISTORY # Add timestamps to history
setopt HIST_SAVE_NO_DUPS # Older duplicate commands are omitted
# setopt HIST_VERIFY # Show command with history expansion to user before running it

# Other options
setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
# setopt IGNORE_EOF # logoff with CTRL+D

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
# setopt complete_aliases # This breaks git autocomplete for aliases

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
