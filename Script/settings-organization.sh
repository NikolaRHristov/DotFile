#!/bin/bash

mapfile -t Organization < <(printf "%s" "$(\gh api users/NikolaRHristov/orgs | \jq -r '.[].login')" | tr -d '\r')

for Organization in "${Organization[@]}"; do
	Billing="hello@playform.cloud"
	Email="hello@playform.cloud"
	Twitter="PlayformCloud"

	case "$Organization" in
		"Playform")
			Billing="hello@playform.cloud"
			Email="hello@playform.cloud"
			Twitter="PlayformCloud"
			;;
		"windowsdock")
			Billing="hello@windowsdock.app"
			Email="hello@windowsdock.app"
			Twitter="windowsdock"
			;;
		"NastyApplication")
			Billing="nasty@playform.cloud"
			Email="nasty@playform.cloud"
			Twitter="NastyApplication"
			;;
		"RoundWindows")
			Billing="hello@roundedcorners.app"
			Email="hello@roundedcorners.app"
			Twitter="RCAppWindows"
			;;
		"BlackRainbowAI")
			Billing="hello@blackrainbow.media"
			Email="hello@blackrainbow.media"
			Twitter="BlackRainbowAI"
			;;
		"ImageWTF")
			Billing="hello@image.wtf"
			Email="hello@image.wtf"
			Twitter="ImageWTF"
			;;
		"ReturnThief")
			Billing="hello@returnthief.quest"
			Email="hello@returnthief.quest"
			;;
		"DoccerPage")
			Billing="hello@doccer.page"
			Email="hello@doccer.page"
			;;
		"HristovFoundation")
			Billing="hello@hristov.foundation"
			Email="hello@hristov.foundation"
			Twitter="NikolaRHristov"
			;;
		"MythemeCloud")
			Billing="hello@mytheme.cloud"
			Email="hello@mytheme.cloud"
			;;
		"NowPlayingCards")
			Billing="hello@now-playing.cards"
			Email="hello@now-playing.cards"
			Twitter="NowPlayingCard"
			;;
		"NeovimSpace")
			Billing="hello@neovim.space"
			Email="hello@neovim.space"
			Twitter="NeovimSpace"
			;;
		"HalleSoftware")
			Billing="hello@halle.software"
			Email="hello@halle.software"
			Twitter="HalleSoftware"
			;;
		"GrenadierJS")
			Billing="grenadier@playform.cloud"
			Email="grenadier@playform.cloud"
			Twitter="GrenadierJS"
			;;
		"SileaJS")
			Billing="silea@playform.cloud"
			Email="silea@playform.cloud"
			Twitter="SileaJS"
			;;
		"CrepesJS")
			Billing="crepes@playform.cloud"
			Email="crepes@playform.cloud"
			Twitter="CrepesJS"
			;;
		"SouqRs")
			Billing="souq@playform.cloud"
			Email="souq@playform.cloud"
			Twitter="SouqRs"
			;;
		"CodeEditorLand")
			Billing="land@playform.cloud"
			Email="land@playform.cloud"
			Twitter="CodeEditorLand"
			;;
		"SecretSignup")
			Billing="signup@playform.cloud"
			Email="signup@playform.cloud"
			Twitter="SecretSignup"
			;;
		"SecurityCodeEditorLand")
			Billing="Security.Land@playform.cloud"
			Email="Security.Land@playform.cloud"
			Twitter="SCodeEditorLand"
			;;
		"327b5")
			Billing="327b5@nikolahristov.tech"
			Email="327b5@nikolahristov.tech"
			Twitter=""
			;;
		"ae6a6")
			Billing="ae6a6@nikolahristov.tech"
			Email="ae6a6@nikolahristov.tech"
			Twitter=""
			;;
	esac

	\echo "Settings for $Organization"

	\gh api \
		--method PATCH \
		-H "Accept: application/vnd.github+json" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${Organization}" \
		-f location='Bulgaria' \
		-f company='Playform' \
		-f billing_email=${Billing} \
		-f email=${Email} \
		-f twitter_username=${Twitter} \
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
		-F secret_scanning_push_protection_custom_link='https://link.nikolahristov.tech/protection-push' \
		--silent
done
