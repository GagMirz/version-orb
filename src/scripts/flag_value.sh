#!/bin/bash
# shellcheck disable=SC2154,SC1090
# SC1090 justification: file should be created outside, path is not fixed, can't specify source.
# SC2154 justification: Variable assigned outside of script file(Depends on SC1090).

get_flag_value() {
    export PYTHONIOENCODING=utf8

    local flag_value
    flag_value=$(python3 -c "import re; \
    text = \"${1}\"; \
    matches = re.findall( \
        r'(?<=[-{1,2}|\/])(?P<name>[a-zA-Z0-9]*)[ |:|\\\"]*(?P<value>[\w]*)(?=[ |\\\"]|$)', \
        text); \
    matches = [argument for argument in matches if argument[0] == \"${2}\"]; \
    value = matches[0][1] if len(matches) else \"\"; \
    print(value);")

    echo "${flag_value}"
}

# shellcheck source=src/scripts/utils.sh
source src/scripts/utils.sh
SourceParameters required
echo "${answer}"

# Add default values
[[ -z ${text} ]] && exit 128
[[ -z ${flag} ]] && exit 128
[[ -z ${answer} ]] && answer=FLAG_VALUE

CreateAnswer "${answer}" "$(get_flag_value "${text}" "${flag}")"
