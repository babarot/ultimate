autoload -U colors && colors
setopt prompt_subst

PROMPT=""
RPROMPT=""
PROMPT_CHAR="❯"

ON_COLOR="%{$fg[green]%}"
OFF_COLOR="%{$reset_color%}"
ERR_COLOR="%{$fg[red]%}"

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

function zle-line-init zle-line-finish zle-keymap-select {
    zle reset-prompt
    zle -R
}

TMOUT=1

TRAPALRM() {
    #local -a colors
    #colors=(
    #"$fg[red]"
    #"$fg[green]"
    #"$fg[yellow]"
    #"$fg[white]"
    #"$fg[black]"
    #"$fg[grey]"
    #)
    #ultimate_random="%{$colors[$(( $RANDOM % $#colors + 1 ))]%}$PROMPT_CHAR%{$reset_color%}"
    let ++count
    if (( count > 5 )); then
        count=1
    fi

    zle reset-prompt
}

__ultimate::prompt::random()
{
    local on off
    on="$ON_COLOR$PROMPT_CHAR$OFF_COLOR"
    off="$OFF_COLOR$PROMPT_CHAR$OFF_COLOR"
    local -a arr
    arr=(
    $off$off$off$off
    $on$off$off$off
    $on$on$off$off
    $on$on$on$off
    $on$on$on$on
    )

    echo $arr[${count:-1}]
}
