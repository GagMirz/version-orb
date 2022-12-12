#!/bin/bash
# shellcheck disable=SC2154
# SC2154 justification: Variable assigned outside of script file.

export PYTHONIOENCODING=utf8

PULL_REQUEST_BASE_REF=$(python3 -c "import sys, json, re; \
text=\"${text}\"; \
matches=re.findall( \
r'(?<=[-{1,2}|\/])(?P<name>[a-zA-Z0-9]*)[ |:|\\\"]*(?P<value>[\w]*)(?=[ |\\\"]|$)', \
text); \
value=[argument for argument in matches if argument[0] == \"${flag}\"][0][1]; \
print(value)")

echo "export ${answer}=${PULL_REQUEST_BASE_REF}" >> "$BASH_ENV"
