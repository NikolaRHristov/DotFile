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
	EMAIL_BILLING="hello@lightrix.help"
	EMAIL="hello@lightrix.help"
	TWITTER="LGHTRX"

	case "$ORG" in
		"Playform")
			EMAIL_BILLING="hello@playform.cloud"
			EMAIL="hello@playform.cloud"
			TWITTER="LGHTRX"
			;;
		"windowsdock")
			EMAIL_BILLING="hello@windowsdock.app"
			EMAIL="hello@windowsdock.app"
			TWITTER="windowsdock"
			;;
		"NastyApplication")
			EMAIL_BILLING="nasty@lightrix.help"
			EMAIL="nasty@lightrix.help"
			TWITTER="NastyApplication"
			;;
		"RoundedCorners")
			EMAIL_BILLING="hello@roundedcorners.app"
			EMAIL="hello@roundedcorners.app"
			TWITTER="RCAppWindows"
			;;
		"BlackRainbowAI")
			EMAIL_BILLING="hello@blackrainbow.media"
			EMAIL="hello@blackrainbow.media"
			TWITTER="BlackRainbowAI"
			;;
		"ImageWTF")
			EMAIL_BILLING="hello@image.wtf"
			EMAIL="hello@image.wtf"
			TWITTER="ImageWTF"
			;;
		"ReturnThief")
			EMAIL_BILLING="hello@returnthief.quest"
			EMAIL="hello@returnthief.quest"
			;;
		"DoccerPage")
			EMAIL_BILLING="hello@doccer.page"
			EMAIL="hello@doccer.page"
			;;
		"HristovFoundation")
			EMAIL_BILLING="hello@hristov.foundation"
			EMAIL="hello@hristov.foundation"
			TWITTER="NikolaRHristov"
			;;
		"MythemeCloud")
			EMAIL_BILLING="hello@mytheme.cloud"
			EMAIL="hello@mytheme.cloud"
			;;
		"NowPlayingCards")
			EMAIL_BILLING="hello@now-playing.cards"
			EMAIL="hello@now-playing.cards"
			TWITTER="NowPlayingCards"
			;;
		"NeovimSpace")
			EMAIL_BILLING="hello@neovim.space"
			EMAIL="hello@neovim.space"
			TWITTER="NeovimSpace"
			;;
		"HalleSoftware")
			EMAIL_BILLING="hello@halle.software"
			EMAIL="hello@halle.software"
			TWITTER="HalleSoftware"
			;;
		"GrenadierJS")
			EMAIL_BILLING="grenadier@lightrix.help"
			EMAIL="grenadier@lightrix.help"
			TWITTER="GrenadierJS"
			;;
		"SileaJS")
			EMAIL_BILLING="silea@lightrix.help"
			EMAIL="silea@lightrix.help"
			TWITTER="SileaJS"
			;;
		"CrepesJS")
			EMAIL_BILLING="crepes@lightrix.help"
			EMAIL="crepes@lightrix.help"
			TWITTER="CrepesJS"
			;;
		"SouqRs")
			EMAIL_BILLING="souq@lightrix.help"
			EMAIL="souq@lightrix.help"
			TWITTER="SouqRs"
			;;
	esac

	gh api \
		--method PATCH \
		-H "Accept: application/vnd.github+json" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}" \
		-f location='Bulgaria' \
		-f company='Lightrix' \
		-f billing_email=${EMAIL_BILLING} \
		-f email=${EMAIL} \
		-f twitter_username=${TWITTER} \
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
