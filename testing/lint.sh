#!/usr/bin/env bash

# if [ "$(which git)" != "/usr/bin/git" ]
# then
#   echo "Missing Git, installing now"
#   apt -qq update;
#   apt -qq -y install git;
#   echo "Install of Git complete"
# fi

reldir=`dirname $0`
cd $reldir
cd ../
directory=`pwd`

readonly CWD=$directory

run_molecule() {
    cwd=$1
    uniq_path=$2

    cd $cwd
    echo "RUNNING: $uniq_path"
    cd $uniq_path/../..

    ansible-lint .

    EXITCODE=$?;
    echo  "EXIT CODE: $EXITCODE"

    if [ $EXITCODE -gt 0 ]; then
        exit 1
    fi
}

export -f run_molecule

# Find current git branch
if [[ $DRONE_BRANCH != '' ]]; then
  BRANCH=$DRONE_BRANCH
else
  BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
fi

echo "Current branch: $BRANCH"

if [[ $BRANCH == "master" ]] && [[ $DRONE_PULL_REQUEST == "" ]]; then
    echo "On master, running all the things"

    # Find all molecule yml files, ordered by date modified descending
    find roles -type f -name "molecule.yml" | grep -v "0archive" | xargs ls -1tc | sort | \
    while read fname; do
        thispath=$(dirname $fname)

        cd ${thispath}/../..
        echo -e "Working on \x1b[0;35m${PWD##*/}\x1b[0m"
        ansible-lint .
        EXITCODE=$?
        cd $CWD

        echo  "EXIT CODE: $EXITCODE"

        if [ $EXITCODE -gt 0 ]; then
            exit 1
        fi
    done
else
    echo "On branch $BRANCH, running changed roles"

    declare -a PATHS

    # Get list of files from last commit
    commit=$(git diff-tree --no-commit-id --name-only -r HEAD)

    # Loop through files changed in commit
    while read fname; do

        # Check if files changed is in the roles directory
        isrole=$(echo $fname | grep -q "^roles/"; echo $?)

        # Is in a role? Get path and dissect it. Any path that has molecule.yml, add to list
        if [ $isrole == 0 ]; then

            fullpath=$(echo $fname | awk -F"/" '{print $1"/"$2}')

            matches=$(find "$fullpath" -type f -name "molecule.yml")

            while read rname; do

              thispath=$(dirname $rname)

              PATHS+=($thispath)
            done <<< "$matches"
        fi
    done <<< "$commit"

    # De-dupe list of paths
    UNIQ_PATHS=($(printf "%s\n" "${PATHS[@]}" | sort -u))

    # Spit out list to screen
    echo ""
    echo "MOLECULES:"
    for uniq_path in "${UNIQ_PATHS[@]}"
    do
        echo $uniq_path;
    done
    echo ""

    # Run
    for uniq_path in "${UNIQ_PATHS[@]}"
    do
      run_molecule $CWD $uniq_path;
    done
fi
