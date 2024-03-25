#!/bin/bash

mapfile -t Organization < <(printf "%s" "$(\gh api -X GET user/orgs | \jq -r '.[].login')" | tr -d '\r')

for Organization in "${Organization[@]}"; do
	Billing="Hello@Playform.Cloud"
	Email="Hello@Playform.Cloud"
	Twitter="PlayformCloud"

	case "$ORG" in
	"Playform")
		Billing="Hello@Playform.Cloud"
		Email="Hello@Playform.Cloud"
		Twitter="PlayformCloud"
		;;
	"windowsdock")
		Billing="hello@Windowsdock.App"
		Email="hello@Windowsdock.App"
		Twitter="windowsdock"
		;;
	"NastyApplication")
		Billing="nasty@Playform.Cloud"
		Email="nasty@Playform.Cloud"
		Twitter="NastyApplication"
		;;
	"RoundWindows")
		Billing="hello@Roundedcorners.App"
		Email="hello@Roundedcorners.App"
		Twitter="RCAppWindows"
		;;
	"BlackRainbowAI")
		Billing="hello@Blackrainbow.Media"
		Email="hello@Blackrainbow.Media"
		Twitter="BlackRainbowAI"
		;;
	"ImageWTF")
		Billing="hello@Image.Wtf"
		Email="hello@Image.Wtf"
		Twitter="ImageWTF"
		;;
	"ReturnThief")
		Billing="hello@Returnthief.Quest"
		Email="hello@Returnthief.Quest"
		;;
	"DoccerPage")
		Billing="hello@Doccer.Page"
		Email="hello@Doccer.Page"
		;;
	"HristovFoundation")
		Billing="hello@Hristov.Foundation"
		Email="hello@Hristov.Foundation"
		Twitter="NikolaRHristov"
		;;
	"MythemeCloud")
		Billing="hello@Mytheme.Cloud"
		Email="hello@Mytheme.Cloud"
		;;
	"NowPlayingCards")
		Billing="hello@Now-Playing.Cards"
		Email="hello@Now-Playing.Cards"
		Twitter="NowPlayingCard"
		;;
	"NeovimSpace")
		Billing="hello@Neovim.Space"
		Email="hello@Neovim.Space"
		Twitter="NeovimSpace"
		;;
	"HalleSoftware")
		Billing="hello@Halle.Software"
		Email="hello@Halle.Software"
		Twitter="HalleSoftware"
		;;
	"GrenadierJS")
		Billing="grenadier@Playform.Cloud"
		Email="grenadier@Playform.Cloud"
		Twitter="GrenadierJS"
		;;
	"SileaJS")
		Billing="silea@Playform.Cloud"
		Email="silea@Playform.Cloud"
		Twitter="SileaJS"
		;;
	"CrepesJS")
		Billing="crepes@Playform.Cloud"
		Email="crepes@Playform.Cloud"
		Twitter="CrepesJS"
		;;
	"SouqRs")
		Billing="souq@Playform.Cloud"
		Email="souq@Playform.Cloud"
		Twitter="SouqRs"
		;;
	"CodeEditorLand")
		Billing="land@Playform.Cloud"
		Email="land@Playform.Cloud"
		Twitter="CodeEditorLand"
		;;
	"SecretSignup")
		Billing="signup@Playform.Cloud"
		Email="signup@Playform.Cloud"
		Twitter="SecretSignup"
		;;
	"SecurityCodeEditorLand")
		Billing="Security.Land@Playform.Cloud"
		Email="Security.Land@Playform.Cloud"
		Twitter="SCodeEditorLand"
		;;
	"327b5")
		Billing="327b5@NikolaHristov.Tech"
		Email="327b5@NikolaHristov.Tech"
		Twitter=""
		;;
	"ae6a6")
		Billing="ae6a6@NikolaHristov.Tech"
		Email="ae6a6@NikolaHristov.Tech"
		Twitter=""
		;;
	esac

	echo "Settings for $ORG"

	gh api \
		--method PATCH \
		-H "Accept: application/vnd.github+json" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		orgs/"${ORG}" \
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
