__ultimate::git::branch()
{
    local branch_name="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    [[ -n $branch_name ]] && echo "$branch_name"
}

__ultimate::git::repo_stat()
{
    local rs="$(git status --porcelain -b)"

    if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
        echo "%{$fg[orange]%}"
    elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
        echo "%{$fg[orange]%}"
    elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
        echo "%{[38;5;011m%}%}"
    elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
        echo "%{$reset_color%}"
    else # is clean
        echo "%{$fg[green]%}"
    fi
}
