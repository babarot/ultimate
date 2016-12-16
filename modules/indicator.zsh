autoload -Uz add-zsh-hook

__ultimate::indicator::vim_mode()
{
    local myprompt="$1"

    terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
    left_down_prompt_preexec() {
        print -rn -- $terminfo[el]
    }
    add-zsh-hook preexec left_down_prompt_preexec
    function zle-keymap-select zle-line-init zle-line-finish {
        case $KEYMAP in
            main|viins)
                PROMPT_2="$fg[black]-- INSERT --$reset_color"
                ;;
            vicmd)
                PROMPT_2="$fg[white]-- NORMAL --$reset_color"
                ;;
            vivis|vivli)
                PROMPT_2="$fg[yellow]-- VISUAL --$reset_color"
                ;;
            virep)
                PROMPT_2="$fg[red]-- REPLACE --$reset_color"
                ;;
        esac
        PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}$myprompt"
        zle reset-prompt
    }
    zle -N zle-line-init
    zle -N zle-line-finish
    zle -N zle-keymap-select
    zle -N edit-command-line

    PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}$myprompt"
}
