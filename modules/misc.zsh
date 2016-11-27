__ultimate::misc::pathshorten()
{
    setopt localoptions noksharrays extendedglob
    local MATCH MBEGIN MEND
    local -a match mbegin mend
    "${2:-echo}" "${1//(#m)[^\/]##\//${MATCH/(#b)([^.])*/$match[1]}/}"
}

__ultimate::misc::has()
{
    type "${1:?}" &>/dev/null
    return $status
}
