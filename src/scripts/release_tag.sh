#!/bin/bash
# shellcheck disable=SC2154
# SC2154 justification: Variable assigned outside of script file.
# shellcheck disable=all

[[ -f $cnfp ]] && source $cnfp

# Add default values
[[ -z $username ]] && username="${CIRCLE_PROJECT_USERNAME}"
[[ -z $repository ]] && repo="${CIRCLE_PROJECT_REPONAME}"
[[ -z $token ]] && token="${GITHUB_TOKEN}"
[[ -z $answer ]] && answer="TAG"

tag=`curl https://api.github.com/repos/${username}/${repository}/releases/latest -s  --header \"Authorization\" $token"| jq .name -r`
echo "export ${answer}=${tag}" >> "$BASH_ENV"
