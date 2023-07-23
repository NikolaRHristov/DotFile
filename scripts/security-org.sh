#!/bin/bash

mapfile -t array < <(printf "%s" "$(gh api -X GET user/orgs | jq -r '.[].login')" | tr -d '\r')

omit="astro-community"

ORGS=()

for element in "${array[@]}"; do
	if [[ "$element" != "$omit" ]]; then
		ORGS+=("$element")
	fi
done

for ORG in "${ORGS[@]}"; do
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
