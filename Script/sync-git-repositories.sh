#!/usr/bin/env bash

<<<<<<< HEAD
<<<<<<< HEAD
DEVDIR="$HOME/Developer/app"
=======
DEVDIR="~/Developer/app"
>>>>>>> df8efd04ba696a59fd2b12ab29f76ecf64258306
=======
DEVDIR="~/Developer/app"
>>>>>>> df8efd04ba696a59fd2b12ab29f76ecf64258306

USERS=(
    "NikolaRHristov"
)

for USER in "${USERS[@]}"; do
    USER=$(echo "$USER" | tr -d '\"')
    readarray -t REPOS < <(gh api users/"$USER"/repos | jq .[].ssh_url)
    readarray -t ORGS < <(gh api users/"$USER"/orgs | jq .[].login)

    echo "Cloning all for user: $USER"
<<<<<<< HEAD
<<<<<<< HEAD
    mkdir -p "$DEVDIR"/"$USER"
    cd "$DEVDIR"/"$USER" || exit
=======
    mkdir -p $DEVDIR/"$USER"
    cd $DEVDIR/"$USER" || exit
>>>>>>> df8efd04ba696a59fd2b12ab29f76ecf64258306
=======
    mkdir -p $DEVDIR/"$USER"
    cd $DEVDIR/"$USER" || exit
>>>>>>> df8efd04ba696a59fd2b12ab29f76ecf64258306

    for REPO in "${REPOS[@]}"; do
        REPO=$(echo "$REPO" | sed "s/git@github\.com\:/ssh\:\/\/git\@github\.com\//" | tr -d '\"')

        git clone --recurse-submodules "$REPO"
    done

    cd - || exit

    for ORG in "${ORGS[@]}"; do
        ORG=$(echo "$ORG" | tr -d '\"')
        readarray -t REPOS < <(gh api orgs/"$ORG"/repos | jq .[].ssh_url)

        echo "Cloning all for org: $ORG"
<<<<<<< HEAD
<<<<<<< HEAD
        mkdir -p "$DEVDIR"/"$ORG"
        cd "$DEVDIR"/"$ORG" || exit
=======
        mkdir -p $DEVDIR/"$ORG"
        cd $DEVDIR/"$ORG" || exit
>>>>>>> df8efd04ba696a59fd2b12ab29f76ecf64258306
=======
        mkdir -p $DEVDIR/"$ORG"
        cd $DEVDIR/"$ORG" || exit
>>>>>>> df8efd04ba696a59fd2b12ab29f76ecf64258306

        for REPO in "${REPOS[@]}"; do
            REPO=$(echo "$REPO" | sed "s/git@github\.com\:/ssh\:\/\/git\@github\.com\//" | tr -d '\"')

            if [[ "$ORG" == "astro-community" ]]; then
                if [[ "$REPO" =~ .*@playform/inline.* ]] || [[ "$REPO" =~ .*@playform/compress.* ]] || [[ "$REPO" =~ .*github-actions-runner.* ]]; then
                    git clone --recurse-submodules "$REPO"
                fi
            else
                git clone --recurse-submodules "$REPO"
            fi
        done

        cd - || exit
    done
done
