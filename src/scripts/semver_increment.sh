#!/bin/bash

# shellcheck disable=SC2154,SC1090
# SC1090 justification: file should be created outside, path is not fixed, can't specify source.
# SC2154 justification: Variable assigned outside of script file(Depends on SC1090).

#######################################
# Increment given SemVer string with given level option
# ARGUMENTS:
#   SemVer string
#   Increase option F.E. M/m/p/Mm/mp/Mp/Mmp
# OUTPUTS:
#   Incremented SemVer string
# RETURN:
#   non-zero on error
#######################################
semver_increment() {
  [[ -z "${1}" ]] && exit 128
  [[ -z "${2}" ]] && exit 129

  while read -r -n1 op; do
    case $op in
    M) major=true ;;
    m) minor=true ;;
    p) patch=true ;;
    esac
  done < <(echo -n "$2")

  local a
  local vFlag

  # shellcheck disable=SC2206 # Justification: Need it to be splited to array
  a=(${1//./ })

  if [ "${a[0]:0:1}" == "v" ]; then
    a[0]="${a[0]:1}"
    vFlag="v"
  fi

  if [ -n "${major}" ]; then
    ((a[0] = a[0] + 1))
    a[1]=0
    a[2]=0
  fi

  if [ -n "${minor}" ]; then
    ((a[1] = a[1] + 1))
    a[2]=0
  fi

  if [ -n "${patch}" ]; then
    ((a[2] = a[2] + 1))
  fi

  local version
  version="${vFlag}${a[0]}.${a[1]}.${a[2]}"

  echo "${version}"

  return 0
}

# Will not run if sourced from another script.
# This is done so this script may be tested.
ORB_TEST_ENV="bats-core"
if [ "${0#*"$ORB_TEST_ENV"}" = "$0" ]; then
    # Import utils.
    eval "$SCRIPT_UTILS"
    SourceParameters "${cnfp}"

  # Add default values
  [[ -z "${version}" ]] && version="v0.0.0"
  [[ -z "${option}" ]] && option="p"
  [[ -z "${answer}" ]] && answer="VERSION"

  CreateAnswer "${answer}" "$(semver_increment "${version}" "${option}")"
fi
