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

    case "$ZSH_ULTIMATE_PATHTYPE" in
        "fullpath")
            _path_="$(print -D "$PWD")"
            ;;
        "shortpath")
            if type pathshorten &>/dev/null; then
                _path_="$(pathshorten "${PWD/$HOME/~}")"
            else
                _path_="$PWD"
            fi
            ;;
        *)
            _path_="$(print -P %2~ | sed s_/_${sep}_g)"
            ;;
    esac
    echo "$path_color$_path_$rsc"
}

__ultimate::prompt::git()
{
    local bname=$(git_branch_name)

    if type '__git_ps1' &>/dev/null; then
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWSTASHSTATE=1
        export GIT_PS1_SHOWUNTRACKEDFILES=1
        export GIT_PS1_SHOWUPSTREAM="auto"
        export GIT_PS1_DESCRIBE_STYLE="branch"
        export GIT_PS1_SHOWCOLORHINTS=0
        bname=$(__git_ps1 "(%s)")
    fi

    if [[ -n $bname ]]; then
        local infos="$(git_repo_status)$bname%{$reset_color%}"
        echo " $infos"
    fi
}

__ultimate::prompt::vimode()
{
    local ret=""

    case $KEYMAP in
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
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo "$(hostname -s):"
    fi
}

__ultimate::prompt::exit_code()
{
    echo "%(?..$ERR_COLOR%? ⏎  ) "
}
