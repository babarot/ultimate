# vim: ft=zsh

() {
local f
for f in "${${(%):-%N}:A:h}"/modules/*.zsh
do
    source "$f"
done
}

PROMPT+='$(__ultimate::prompt::hostname)'
PROMPT+='$(__ultimate::prompt::user)'
PROMPT+='$(__ultimate::prompt::job)'
PROMPT+='$(__ultimate::prompt::vimode)'
PROMPT+='$(__ultimate::prompt::status)'
PROMPT+=' '

RPROMPT+='$(__ultimate::prompt::exit_code)'
RPROMPT+='$(__ultimate::prompt::path)'
RPROMPT+='$(__ultimate::prompt::git)'
