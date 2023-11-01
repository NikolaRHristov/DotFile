#!/bin/bash

mapfile -t array < <(printf "%s" "$(gh api -X GET user/orgs | jq -r '.[].login')" | tr -d '\r')

OMIT="astro-community"

ORGS=()

for E in "${array[@]}"; do
	if [[ "$E" != "$OMIT" ]]; then
		ORGS+=("$E")
	fi
done

for ORG in "${ORGS[@]}"; do
	echo "Security for $ORG"

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}"/dependency_graph/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}"/dependabot_alerts/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}"/dependabot_security_updates/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}"/advanced_security/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}"/code_scanning_default_setup/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}"/secret_scanning/enable_all \
		-f query_suite='extended' \
		--silent

	gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}"/secret_scanning_push_protection/enable_all \
		-f query_suite='extended' \
		--silent
done
