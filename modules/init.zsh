PROMPT=""
RPROMPT=""
PROMPT_CHAR="❯"

ON_COLOR="%{$fg[green]%}"
OFF_COLOR="%{$reset_color%}"
ERR_COLOR="%{$fg[red]%}"

#TMOUT=1
#
#TRAPALRM() {
#    zle reset-prompt
#}

autoload -U colors && colors
setopt prompt_subst

function zle-line-init zle-line-finish zle-keymap-select {
    zle reset-prompt
    zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish
