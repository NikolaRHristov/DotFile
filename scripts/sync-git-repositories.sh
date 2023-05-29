#!/bin/bash

DEVDIR="/f/Developer/app"

USERS=(
	"NicholasJoyChrist"
)

for USER in "${USERS[@]}"; do
	USER=$(echo "$USER" | tr -d '\"')
	readarray -t REPOS < <(gh api users/"$USER"/repos | jq .[].ssh_url)
	readarray -t ORGS < <(gh api users/"$USER"/orgs | jq .[].login)

	echo "Cloning all for user: $USER"
	mkdir -p $DEVDIR/"$USER"
	cd $DEVDIR/"$USER" || exit

	for REPO in "${REPOS[@]}"; do
		REPO=$(echo "$REPO" | sed "s/git@github\.com\:/ssh\:\/\/git\@github\.com\//" | tr -d '\"')

		git clone --recurse-submodules "$REPO"
	done

	cd - || exit

	for ORG in "${ORGS[@]}"; do
		ORG=$(echo "$ORG" | tr -d '\"')
		readarray -t REPOS < <(gh api orgs/"$ORG"/repos | jq .[].ssh_url)

		echo "Cloning all for org: $ORG"
		mkdir -p $DEVDIR/"$ORG"
		cd $DEVDIR/"$ORG" || exit

		for REPO in "${REPOS[@]}"; do
			REPO=$(echo "$REPO" | sed "s/git@github\.com\:/ssh\:\/\/git\@github\.com\//" | tr -d '\"')

			if [[ "$ORG" == "astro-community" ]]; then
				if [[ "$REPO" =~ .*astro-critters.* ]] || [[ "$REPO" =~ .*astro-compress.* ]] || [[ "$REPO" =~ .*github-actions-runner.* ]] || [[ "$REPO" =~ .*astro-rome.* ]]; then
					git clone --recurse-submodules "$REPO"
				fi
			else
				if [[ "$ORG" == "playform" ]]; then
					if ! [[ "$REPO" =~ .*aws.* ]] && ! [[ "$REPO" =~ .*ec2.* ]]; then
						git clone --recurse-submodules "$REPO"
					fi
				else
					git clone --recurse-submodules "$REPO"
				fi
			fi
		done

		cd - || exit
	done
done
