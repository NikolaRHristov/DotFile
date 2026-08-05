#!/usr/bin/env bash
# ==============================================================================
#  disable-apple-ai-assistance.sh
#  Permanently disable Apple Intelligence, Siri, on-device generative AI,
#  knowledge/suggestion engines, and related telemetry on macOS.
#
#  Style: mirrors privacy.sexy (privacy-script-macos.sh) - section headers,
#  per-step echo, explicit targets. Correctness fix vs. that script: user-domain
#  `defaults`/`launchctl` are always scoped to the real GUI (console) user even
#  when the script is launched through `sudo`, so preferences land in YOUR
#  home, not /var/root.
#
#  IMPORTANT - what "permanent" means here:
#   * These frameworks live on the SIP-sealed system volume. They CANNOT be
#     deleted without disabling System Integrity Protection (which breaks OS
#     security and is undone by the next update). This script DISABLES them:
#     they will not launch, will not run, will not listen, and the disable
#     state survives a normal reboot.
#   * A macOS *update* can rewrite the launch databases and re-enable agents.
#     Re-run this script after any system update.
#   * A few of these (knowledge-agent, suggestd, IntelligencePlatformComputeService,
#     spotlightknowledged.updater) are XPC services that launchd can still spawn
#     *on demand* when an app or Spotlight explicitly requests them, even after
#     `launchctl disable`. With Siri/Intelligence preferences off they have no
#     work to do and stay idle. They will not auto-launch at login.
#
#  Usage:
#     ./disable-apple-ai-assistance.sh            # disable everything (default)
#     ./disable-apple-ai-assistance.sh verify    # only report current state
#     ./disable-apple-ai-assistance.sh revert     # re-enable everything
#
#  Run as your normal admin user (it will elevate with sudo where needed).
# ==============================================================================

set -uo pipefail

MODE="${1:-disable}"

# ------------------------------------------------------------------------------
# Resolve the real console (GUI) user - the person who owns the login session.
# All per-user preferences and user-launch agents are written against THIS user,
# regardless of whether the script itself is running as root via sudo.
# ------------------------------------------------------------------------------
if [ -n "${SUDO_USER:-}" ] && [ "$SUDO_USER" != "root" ]; then
	REALUSER="$SUDO_USER"
elif [ "$(stat -f '%u' /dev/console 2>/dev/null || echo 0)" != "0" ]; then
	REALUSER="$(stat -f '%Su' /dev/console)"
else
	REALUSER="$(whoami)"
fi
REALUID="$(id -u "$REALUSER" 2>/dev/null || echo 501)"
REALHOME="$(dscl . -read "/Users/$REALUSER" NFSHomeDirectory 2>/dev/null | awk 'NR==1{print $2}')"
[ -z "$REALHOME" ] && REALHOME="/Users/$REALUSER"

# Re-exec as root if we are not already, so we can manage daemons + system prefs.
# REALUSER is passed through so user-scoped operations still target the right home.
if [ "$(id -u)" -ne 0 ]; then
	exec sudo --preserve-env=REALUSER REALUID REALHOME "$0" "$@"
fi

# --- helpers ----------------------------------------------------------------

# Write a per-USER preference (always as the console user, never as root).
udefaults() {
	# usage: udefaults <domain> <key> <type> <value>
	sudo -u "$REALUSER" defaults write "$@" 2>/dev/null || true
}

# Write a SYSTEM-domain preference (under /Library/Preferences).
sdefaults() {
	# usage: sdefaults <domain> <key> <type> <value>
	sudo defaults write "/Library/Preferences/$1" "$2" "$3" "$4" 2>/dev/null || true
}

# Disable + boot-out a user-launch agent (reboot-persistent via `launchctl disable`).
disable_user_agent() {
	local svc="$1"
	sudo -u "$REALUSER" launchctl disable "gui/$REALUID/$svc" 2>/dev/null || true
	sudo -u "$REALUSER" launchctl bootout "gui/$REALUID/$svc" 2>/dev/null || true
}

# Disable + boot-out a system-launch agent/daemon (best effort; ignored if absent).
disable_system_agent() {
	local svc="$1"
	launchctl disable "system/$svc" 2>/dev/null || true
	launchctl bootout "system/$svc" 2>/dev/null || true
}

# Re-enable a user-launch agent (used by `revert`).
enable_user_agent() {
	local svc="$1"
	sudo -u "$REALUSER" launchctl enable "gui/$REALUID/$svc" 2>/dev/null || true
	sudo -u "$REALUSER" launchctl kickstart "gui/$REALUID/$svc" 2>/dev/null || true
}

# Kill any still-running process (only the console user's own) matching a pattern.
kill_user_proc() {
	local pat="$1"
	pkill -9 -u "$REALUID" -f "$pat" 2>/dev/null || true
}

# ------------------------------------------------------------------------------
# Service lists (verified present on macOS 26.x; harmless if absent on other versions)
# ------------------------------------------------------------------------------
SIRI_AGENTS=(
	com.apple.assistantd
	com.apple.assistant_service
	com.apple.assistant_cdmd
	com.apple.siri.context.service
	com.apple.Siri.agent
	com.apple.SiriTTSTrainingAgent
	com.apple.AddressBook.AssistantService
	com.apple.siriactionsd
	com.apple.voiceshortcuts
)
INTEL_AGENTS=(
	com.apple.intelligenceplatformd
	com.apple.intelligencecontextd
	com.apple.intelligenceflowd
	com.apple.intelligencetasksd
	com.apple.generativeexperiencesd
	com.apple.parsecd
	com.apple.parsec-fbf
	com.apple.callintelligenced
	com.apple.knowledge-agent
	com.apple.knowledgeconstructiond
	com.apple.spotlightknowledged
	com.apple.spotlightknowledged.updater
	com.apple.spotlightknowledged.importer
	com.apple.suggestd
)
# Process name fragments used to kill anything still running after boot-out.
PROC_PATTERNS=(
	"assistantd"
	"assistant_service"
	"assistant_cdmd"
	"siri.context.service"
	"siriknowledged"
	"siriinferenced"
	"sirittsd"
	"intelligenceplatformd"
	"intelligencecontextd"
	"intelligenceflowd"
	"intelligencetasksd"
	"generativeexperiencesd"
	"parsecd"
	"parsec-fbf"
	"callintelligenced"
	"knowledge-agent"
	"knowledgeconstructiond"
	"spotlightknowledged"
	"suggestd"
	"siriactionsd"
	"IntelligencePlatformComputeService"
	"SiriUISetupXPC"
	"com.apple.siri.embeddedspeech"
	"media-indexer"
)

# ------------------------------------------------------------------------------
# -------------------------  REVERT MODE  --------------------------------------
# ------------------------------------------------------------------------------
if [ "$MODE" = "revert" ]; then
	echo '=== REVERT: re-enabling Apple Intelligence / Siri / suggestions ==='
	for s in "${SIRI_AGENTS[@]}" "${INTEL_AGENTS[@]}"; do
		enable_user_agent "$s"
	done
	udefaults com.apple.Siri AssistantEnabled -bool true
	udefaults com.apple.Siri StatusMenuVisible -bool true
	udefaults com.apple.Siri VoiceTriggerUserEnabled -bool true
	udefaults com.apple.assistant SiriEnabled -bool true
	udefaults com.apple.voiceshortcuts SiriShortcutsEnabled -bool true
	sdefaults com.apple.Siri StatusMenuVisible -bool true
	sdefaults com.apple.Siri VoiceTriggerUserEnabled -bool true
	echo 'Revert complete. A logout/restart is recommended.'
	exit 0
fi

# ------------------------------------------------------------------------------
# -------------------------  VERIFY MODE  --------------------------------------
# ------------------------------------------------------------------------------
if [ "$MODE" = "verify" ]; then
	echo "=== Disabled user-launch agents (target user: $REALUSER / uid $REALUID) ==="
	for s in "${SIRI_AGENTS[@]}" "${INTEL_AGENTS[@]}"; do
		if sudo -u "$REALUSER" launchctl print-disabled "gui/$REALUID" 2>/dev/null | grep -q "\"$s\" => disabled"; then
			echo "  [DISABLED] $s"
		else
			echo "  [ACTIVE  ] $s"
		fi
	done
	echo
	echo "=== Running AI/Siri/Assistant processes (should be none) ==="
	ps aux | grep -iE "intelligence|parsec|generative|callintelligence|knowledge|suggest|siri|assistant|voiceshortcuts" |
		grep -v grep |
		grep -ivE "cmiodalassistants|videodriver|cameracaptured|containermanagerd|trustd|secinitd|cfprefsd|distnoted|registerassistantservice|UVCAssistant" |
		awk '{print "  "$1, $2, $11}' || true
	COUNT=$(ps aux | grep -iE "intelligence|parsec|generative|callintelligence|knowledge|suggest|siri|assistant|voiceshortcuts" |
		grep -v grep |
		grep -ivE "cmiodalassistants|videodriver|cameracaptured|containermanagerd|trustd|secinitd|cfprefsd|distnoted|registerassistantservice|UVCAssistant" |
		wc -l | tr -d ' ')
	echo "  Remaining AI/Siri/Assistant processes: $COUNT"
	exit 0
fi

# ==============================================================================
# ============================  DISABLE  =======================================
# ==============================================================================

# ----------------------------------------------------------
# -------------------- 1. Disable Siri ---------------------
# ----------------------------------------------------------
echo '--- Disable Siri (preferences)'
udefaults com.apple.Siri AssistantEnabled -bool false
udefaults com.apple.Siri StatusMenuVisible -bool false
udefaults com.apple.Siri VoiceTriggerUserEnabled -bool false
udefaults com.apple.Siri UserHasTriggeredSiri -bool false
udefaults com.apple.Siri ListeningForSir -bool false
udefaults com.apple.assistant SiriEnabled -bool false
udefaults com.apple.assistant launchToAgent -bool false
udefaults com.apple.voiceshortcuts SiriShortcutsEnabled -bool false
# System-domain mirror so Settings / other accounts cannot silently re-enable
sdefaults com.apple.Siri StatusMenuVisible -bool false
sdefaults com.apple.Siri VoiceTriggerUserEnabled -bool false
# ----------------------------------------------------------

# ----------------------------------------------------------
# ----------- 2. Disable the Siri / Assistant agents --------
# ----------------------------------------------------------
echo '--- Disable Siri / Assistant launch agents'
for s in "${SIRI_AGENTS[@]}"; do
	disable_user_agent "$s"
	disable_system_agent "$s"
done
# ----------------------------------------------------------

# ----------------------------------------------------------
# -------- 3. Disable Apple Intelligence platform ------------
# ----------------------------------------------------------
echo '--- Disable Apple Intelligence platform'
udefaults com.apple.assistant IntelligencePlatformEnabled -bool false # best-effort key
for s in "${INTEL_AGENTS[@]}"; do
	disable_user_agent "$s"
	disable_system_agent "$s"
done
# ----------------------------------------------------------

# ----------------------------------------------------------
# ---- 4. Disable Spotlight "Siri Suggestions" + web --------
# ----------------------------------------------------------
echo '--- Disable Spotlight Siri Suggestions / Bing web results'
udefaults com.apple.Spotlight SiriSuggestionsEnabled -bool false
udefaults com.apple.Spotlight BingResults -bool false
udefaults com.apple.Spotlight SuggestionsDisabled -bool true
# ----------------------------------------------------------

# ----------------------------------------------------------
# ---- 5. Disable Safari search / Siri suggestions -----------
# ----------------------------------------------------------
echo '--- Disable Safari search & Siri suggestions'
udefaults com.apple.Safari UniversalSearchEnabled -bool false
udefaults com.apple.Safari SuppressSearchSuggestions -bool true
udefaults com.apple.Safari DidOpenSafari10Welcome -bool true
# ----------------------------------------------------------

# ----------------------------------------------------------
# ---- 6. Disable "Look Up" Siri knowledge popovers ----------
# ----------------------------------------------------------
echo '--- Disable Look Up Siri-suggested knowledge'
udefaults com.apple.LookupView DisableSiriSuggestions -bool true # best-effort key
udefaults com.apple.LookupView DefaultTab -int 0                 # 0 = Dictionary, not Siri
# ----------------------------------------------------------

# ----------------------------------------------------------
# ---- 7. Disable analytics & diagnostic submission ----------
# ----------------------------------------------------------
echo '--- Disable analytics / diagnostic submission to Apple'
udefaults com.apple.applicationaccess AllowDiagnosticSubmission -bool false
udefaults com.apple.applicationaccess AllowCrashReporting -bool false
udefaults com.apple.crashreporter DialogType -string "none"
sdefaults com.apple.applicationaccess AllowDiagnosticSubmission -bool false
sdefaults com.apple.applicationaccess AllowCrashReporting -bool false
sdefaults com.apple.analytics ServicesOptIn -bool false
# ----------------------------------------------------------

# ----------------------------------------------------------
# ---- 8. Kill anything still running (user-owned only) ------
# ----------------------------------------------------------
echo '--- Terminate running AI/Siri/Assistant processes'
for p in "${PROC_PATTERNS[@]}"; do
	kill_user_proc "$p"
done
# ----------------------------------------------------------

# ------------------------------------------------------------------------------
# -------------------------  VERIFY RESULT  ------------------------------------
# ------------------------------------------------------------------------------
sleep 2
echo
echo '=== RESULT: remaining Apple AI/Siri/Assistant processes ==='
COUNT=$(ps aux | grep -iE "intelligence|parsec|generative|callintelligence|knowledge|suggest|siri|assistant|voiceshortcuts" |
	grep -v grep |
	grep -ivE "cmiodalassistants|videodriver|cameracaptured|containermanagerd|trustd|secinitd|cfprefsd|distnoted|registerassistantservice|UVCAssistant" |
	wc -l | tr -d ' ')
echo "  Remaining: $COUNT"
if [ "$COUNT" = "0" ]; then
	echo '  -> CLEAN. Apple Intelligence / Siri / suggestions are stopped.'
else
	echo '  -> Some processes remain (may be camera/AV helpers - verify the list above).'
fi
echo
echo '=== Disabled launch agents (reboot-persistent) ==='
sudo -u "$REALUSER" launchctl print-disabled "gui/$REALUID" 2>/dev/null |
	grep -iE "intelligence|parsec|generative|callintelligence|knowledge|suggest|siri|assistant|voiceshortcuts" |
	sed 's/^/  /'
echo
echo 'Done. State survives a normal reboot. Re-run after any macOS update.'
echo 'Verify anytime with:  ./disable-apple-ai-assistance.sh verify'
echo 'Undo with:            ./disable-apple-ai-assistance.sh revert'
