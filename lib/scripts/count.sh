#!/bin/bash

function count() {
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		echo "Error: Not in a Git repository"
		return 1
	fi

	git fetch --tags

	latest_tag=$(git describe --tags "$(git rev-list --tags --max-count=1)")

	pwd

	echo "Number of commits since the latest tag: $(git rev-list --count "${latest_tag}"..HEAD)"
}

count
