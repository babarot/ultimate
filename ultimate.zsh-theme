# vim: ft=zsh

for f in "${${(%):-%N}:A:h}"/**/*.(|z)sh(N-.)
do
    source "$f"
done
unset f

myprompt+='$(__ultimate::prompt::hostname)'
myprompt+='$(__ultimate::prompt::user)'
myprompt+='$(__ultimate::prompt::job)'
myprompt+='$(__ultimate::prompt::vimode)'
myprompt+='$(__ultimate::prompt::status)'
myprompt+=' '
__ultimate::indicator::vim_mode "$myprompt"

RPROMPT+='$(__ultimate::prompt::exit_code)'
RPROMPT+='$(__ultimate::prompt::path)'
RPROMPT+='$(__ultimate::prompt::git)'

SPROMPT+='$(__ultimate::prompt::correct)'
