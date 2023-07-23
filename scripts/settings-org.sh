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
	billing_email="hello@lightrix.help"
	email="hello@lightrix.help"

	case "$org" in
	"Playform")
		billing_email="hello@playform.cloud"
		email="hello@playform.cloud"
		;;
	"windowsdock")
		billing_email="hello@windowsdock.app"
		email="hello@windowsdock.app"
		;;
	"RoundedCorners")
		billing_email="hello@roundedcorners.app"
		email="hello@roundedcorners.app"
		;;
	"BlackRainbowAI")
		billing_email="hello@blackrainbow.media"
		email="hello@blackrainbow.media"
		;;
	"imagewtf")
		billing_email="hello@image.wtf"
		email="hello@image.wtf"
		;;
	"returnthief")
		billing_email="hello@returnthief.quest"
		email="hello@returnthief.quest"
		;;
	"Doccer-Page")
		billing_email="hello@doccer.page"
		email="hello@doccer.page"
		;;
	"hristov-foundation")
		billing_email="hello@hristov.foundation"
		email="hello@hristov.foundation"
		;;
	"mytheme-cloud")
		billing_email="hello@mytheme.cloud"
		email="hello@mytheme.cloud"
		;;
	"NowPlayingCards")
		billing_email="hello@nowplaying.cards"
		email="hello@nowplaying.cards"
		;;
	"NeovimSpace")
		billing_email="hello@neovim.space"
		email="hello@neovim.space"
		;;
	"HalleSoftware")
		billing_email="hello@halle.software"
		email="hello@halle.software"
		;;
	esac

	gh api \
		--method PATCH \
		-H "Accept: application/vnd.github+json" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${org}" \
		-f location='Bulgaria' \
		-f company='Lightrix' \
		-f billing_email=${billing_email} \
		-f email=${email} \
		-F has_organization_projects=false \
		-F has_repository_projects=false \
		-f default_repository_permission='none' \
		-F members_can_create_repositories=false \
		-F members_can_create_private_repositories=false \
		-F members_can_create_public_repositories=false \
		-f members_allowed_repository_creation_type='none' \
		-F members_can_create_pages=false \
		-F members_can_create_public_pages=false \
		-F members_can_create_private_pages=false \
		-F members_can_fork_private_repositories=false \
		-F advanced_security_enabled_for_new_repositories=true \
		-F dependabot_alerts_enabled_for_new_repositories=true \
		-F dependabot_security_updates_enabled_for_new_repositories=true \
		-F dependency_graph_enabled_for_new_repositories=true \
		-F secret_scanning_enabled_for_new_repositories=true \
		-F secret_scanning_push_protection_enabled_for_new_repositories=true \
		-F secret_scanning_push_protection_custom_link_enabled=true \
		-F secret_scanning_push_protection_custom_link='https://link.lightrix.help/protection-push' \
		--silent
done
