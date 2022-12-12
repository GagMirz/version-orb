#!/bin/bash

# shellcheck disable=SC2154,SC2206,SC2236
# SC2154 justification: Variable assigned outside of script file. 
# SC2206,SC2236 justification: Meaningless warning/error. 

while read -r -n1 op; do
  case $op in
    M ) major=true;;
    m ) minor=true;;
    p ) patch=true;;
  esac
done < <(echo -n "$option")

a=( ${version//./ } )

if [ "${a[0]:0:1}" == "v" ]; then
  a[0]=${a[0]:1}
  vFlag="v"
fi

if [ ! -z $major ]; then
  ((a[0]=a[0]+1))
  a[1]=0
  a[2]=0
fi

if [ ! -z $minor ]; then
  ((a[1]=a[1]+1))
  a[2]=0
fi

if [ ! -z $patch ]; then
  ((a[2]=a[2]+1))
fi

version="${vFlag}${a[0]}.${a[1]}.${a[2]}"
echo "export ${answer}=${version}" >> "$BASH_ENV"
