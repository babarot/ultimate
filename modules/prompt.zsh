PROMPT=""
RPROMPT=""
SPROMPT=""
PROMPT_CHAR="❯"

#TMOUT=1
#
#TRAPALRM() {
#    zle reset-prompt
#}

autoload -Uz add-zsh-hook

setopt prompt_subst
setopt transient_rprompt

function zle-line-init zle-line-finish zle-keymap-select {
    zle reset-prompt
    zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

__ultimate::prompt::user()
{
    echo "%(!.$ON_COLOR.$OFF_COLOR)$PROMPT_CHAR%{$reset_color%}"
}

__ultimate::prompt::job()
{
    echo "%(1j.$ON_COLOR.$OFF_COLOR)$PROMPT_CHAR%{$reset_color%}"
}

__ultimate::prompt::status()
{
    echo "%(0?.$ON_COLOR.$ERR_COLOR)$PROMPT_CHAR%{$reset_color%}"
}

__ultimate::prompt::path()
{
    local path_color="%{[38;5;244m%}%}"
    local rsc="%{$reset_color%}"
    local sep="$rsc/$path_color"
    local mode

    zstyle -s ':ultimate:prompt:path' mode mode
    case "$mode" in
        "fullpath")
            _path_="$(print -D "$PWD")"
            ;;
        "shortpath")
            _path_="$(__ultimate::misc::pathshorten "${PWD/$HOME/~}")"
            ;;
        *)
            _path_="$(print -P %2~ | sed s_/_${sep}_g)"
            ;;
    esac
    echo "$path_color$_path_$rsc"
}

__ultimate::prompt::git()
{
    local bname="$(__ultimate::git::branch)"

    if __ultimate::misc::has '__git_ps1'; then
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWSTASHSTATE=1
        export GIT_PS1_SHOWUNTRACKEDFILES=1
        export GIT_PS1_SHOWUPSTREAM="auto"
        export GIT_PS1_DESCRIBE_STYLE="branch"
        export GIT_PS1_SHOWCOLORHINTS=0
        bname="$(__git_ps1 "(%s)")"
    fi

    if [[ -n $bname ]]; then
        local infos="$(__ultimate::git::repo_stat)$bname%{$reset_color%}"
        echo " $infos"
    fi
}

__ultimate::prompt::vimode()
{
    local ret=""

    case "$KEYMAP" in
        main|viins)
            ret+="$ON_COLOR"
            ;;
        vicmd)
            ret+="$OFF_COLOR"
            ;;
    esac
    ret+="$PROMPT_CHAR%{$reset_color%}"

    echo "$ret"
}

__ultimate::prompt::hostname()
{
    if [[ -n $SSH_CLIENT ]] || [[ -n $SSH_TTY ]]; then
        echo "$(hostname -s):"
    fi
}

__ultimate::prompt::exit_code()
{
    echo "%(?..$ERR_COLOR%? ⏎  ) "
}

__ultimate::prompt::correct()
{
    echo "%{${fg[red]}%}Did you mean?: %R -> %r [nyae]? %{${reset_color}%}"
}
