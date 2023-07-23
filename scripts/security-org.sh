#!/bin/bash

mapfile -t array < <(printf "%s" "$(gh api -X GET user/orgs | jq -r '.[].login')" | tr -d '\r')

omit="astro-community"

orgs=()

for element in "${array[@]}"; do
	if [[ "$element" != "$omit" ]]; then
		orgs+=("$element")
	fi
done

for org in "${orgs[@]}"; do
	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${org}"/dependency_graph/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${org}"/dependabot_alerts/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${org}"/dependabot_security_updates/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${org}"/advanced_security/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${org}"/code_scanning_default_setup/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${org}"/secret_scanning/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${org}"/secret_scanning_push_protection/enable_all \
		-f query_suite='extended' \
		--silent
done
