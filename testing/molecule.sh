#!/usr/bin/env bash

if [ ! -d .venv ]
then
  python3 -m venv .venv
  source .venv/bin/activate
  python3 -m pip install --upgrade pip
  python3 -m pip install -r requirements.txt
  ansible-galaxy install -r requirements.yml
elif [ -z "$VIRTUAL_ENV" ]
then
  source .venv/bin/activate
fi

directory=`pwd`

readonly CWD=$directory

run_molecule() {
    cwd=$1
    uniq_path=$2

    cd $cwd
    cd $uniq_path/../..
    molecule test
    EXITCODE=$?;
    if [ $EXITCODE -gt 0 ]; then
        exit 1
    fi
}

export -f run_molecule

declare -a PATHS

# Get list of files
commit=$(git status -s)

# Loop through files changed in commit
while read fname; do

    # Check if files changed is in the roles directory
    isrole=$(echo $fname | sed 's/^M //' | grep -q "^roles/"; echo $?)
    # Is in a role? Get path and dissect it. Any path that has molecule.yml, add to list
    if [ $isrole == 0 ]; then
        fullpath=$(echo $fname | sed 's/^M //' | awk -F"/" '{print $1"/"$2}')
        matches=$(find "$fullpath" -type f -name "molecule.yml")
        while read rname; do
          thispath=$(dirname $rname)
          PATHS+=($thispath)
        done <<< "$matches"
    fi
done <<< "$commit"

# De-dupe list of paths
UNIQ_PATHS=($(printf "%s\n" "${PATHS[@]}" | sort -u))

# Run
for uniq_path in "${UNIQ_PATHS[@]}"
do
  run_molecule $CWD $uniq_path;
done
