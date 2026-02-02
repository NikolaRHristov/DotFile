-- ~/.wezterm.lua
--
-- A feature-rich, developer-centric WezTerm configuration built from the
-- ground up using the latest official documentation and corrected with user feedback.

local wezterm = require 'wezterm'
local config = {}

-- Boilerplate for the config builder
if wezterm.config_builder then
	config = wezterm.config_builder()
end

--==============================================================================
-- NEW: HELPER FUNCTIONS
--==============================================================================

-- This function reads and parses a shell environment file (.envsh).
local function load_env_file(file_path)
	local env = {}
	local file = io.open(file_path, "r")
	if not file then
		return env
	end

	for line in file:lines() do
		local key, value = line:match("^%s*export%s+([%w_]+)=(.*)$")
		if key and value then
			value = value:match("^%s*(.-)%s*$")
			if (value:sub(1, 1) == '"' and value:sub(-1) == '"') or (value:sub(1, 1) == "'" and value:sub(-1) == "'") then
				value = value:sub(2, -2)
			end
			env[key] = value
		end
	end

	file:close()
	return env
end

-- This function searches for an executable in a list of predefined paths.
local function find_executable(name, search_paths)
	for _, path in ipairs(search_paths) do
		local full_path = path .. "/" .. name
		local f = io.open(full_path, "r")
		if f then
			f:close()
			return full_path
		end
	end
	return nil
end

--==============================================================================
-- DEBUGGING LOGGER
--==============================================================================
local function log_debug(msg)
	local log_path = os.getenv("HOME") .. "/.wezterm.log"
	local f = io.open(log_path, "a")
	if f then
		f:write(os.date("%Y-%m-%d %H:%M:%S") .. " | " .. tostring(msg) .. "\n")
		f:close()
	end
end

log_debug("=========================================")
log_debug("Wezterm Config Loaded / Reloaded")

-- Load the custom environment variables at the very beginning.
local env_vars = load_env_file(os.getenv("HOME") .. "/.envsh")


--==============================================================================
-- SECTION 1: APPEARANCE & THEME
--==============================================================================

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Set initial static padding. These values will be used for top and sides,
-- while the bottom padding will be dynamically overridden.
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 75, -- Fallback value
}

--==============================================================================
-- SECTION 2: FONT CONFIGURATION
--==============================================================================

config.font = wezterm.font 'SauceCodePro Nerd Font'
config.font_size = 16.0
config.line_height = 1.2
config.font_rules = {
	{
		italic = true,
		font = wezterm.font { family = 'SauceCodePro Nerd Font', style = 'Italic' },
	},
	{
		intensity = 'Bold',
		font = wezterm.font { family = 'SauceCodePro Nerd Font', weight = 'Bold' },
	},
}

--==============================================================================
-- SECTION 3: CURSOR & SCROLLBAR
--==============================================================================

config.default_cursor_style = 'SteadyUnderline'
config.scrollback_lines = 3000
config.scroll_to_bottom_on_input = true
config.enable_scroll_bar = true
config.cursor_thickness = "6px"

--==============================================================================
-- SECTION 4: TAB BAR
--==============================================================================

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.tab_max_width = 250
config.show_close_tab_button_in_tabs = true
config.show_new_tab_button_in_tab_bar = true

--==============================================================================
-- SECTION 5: CORE BEHAVIOR
--==============================================================================

config.automatically_reload_config = true
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
	target = "BackgroundColor",
}
config.enable_kitty_keyboard = true

--==============================================================================
-- SECTION 6: STATUS BAR
--==============================================================================

config.status_update_interval = 1000

--==============================================================================
-- SECTION 7: KEYBINDINGS & ACTIONS
--==============================================================================

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
	{ key = 'p',          mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette },
	{ key = 'f',          mods = 'CMD|SHIFT', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
	{ key = '"',          mods = 'LEADER',    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
	{ key = '%',          mods = 'LEADER',    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
	{ key = 'h',          mods = 'LEADER',    action = wezterm.action.ActivatePaneDirection 'Left' },
	{ key = 'l',          mods = 'LEADER',    action = wezterm.action.ActivatePaneDirection 'Right' },
	{ key = 'LeftArrow',  mods = 'ALT',       action = wezterm.action.SendString '\x1bb' },
	{ key = 'RightArrow', mods = 'ALT',       action = wezterm.action.SendString '\x1bf' },
	{ key = 't',          mods = 'CMD',       action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
	{ key = 'w',          mods = 'CMD',       action = wezterm.action.CloseCurrentTab { confirm = true } },
	{ key = 'c',          mods = 'CMD',       action = wezterm.action.CopyTo 'Clipboard' },
	{ key = 'v',          mods = 'CMD',       action = wezterm.action.PasteFrom 'Clipboard' },
	{ key = 'n',          mods = 'CMD',       action = wezterm.action.SpawnWindow },
}

--==============================================================================
-- SECTION 8: MULTIPLEXING, WORKSPACES, AND DOMAINS
--==============================================================================

config.unix_domains = { { name = 'unix' } }
config.ssh_domains = {}
config.exit_behavior = 'Close'

--==============================================================================
-- SECTION 9: WINDOW MANAGEMENT
--==============================================================================

config.inactive_pane_hsb = { hue = 1.0, saturation = 0.9, brightness = 0.8 }

--==============================================================================
-- SECTION 10: MOUSE & SELECTION (EXPLICIT CHARACTER SETS FIX)
--==============================================================================
-- NOTE: We use explicit ranges [0-9] instead of shortcuts \d to ensure compatibility.


config.hyperlink_rules = {
	-- Match Rust compiler output with --> prefix
	{
		regex =
		'\\s*-->\\s+([A-Za-z0-9_./-]+\\.(?:rs|lua|js|ts|py|go|c|cpp|h|hpp|txt|md|toml|yaml|yml|json)):(\\d+):(\\d+)',
		format = 'wezterm-open-file://$1:$2:$3',
	},
	-- Match paths that may be truncated (e.g. "rate/" instead of "Crate/")
	{
		regex =
		'\\s*([A-Za-z]*[Rr]ate/[A-Za-z0-9_./-]+\\.(?:rs|lua|js|ts|py|go|c|cpp|h|hpp|txt|md|toml|yaml|yml|json)):(\\d+):(\\d+)',
		format = 'wezterm-open-file://$1:$2:$3',
	},
	-- Match file paths with line:column notation
	{
		regex = '\\s*([A-Za-z0-9_./-]+\\.(?:rs|lua|js|ts|py|go|c|cpp|h|hpp|txt|md|toml|yaml|yml|json)):(\\d+):(\\d+)',
		format = 'wezterm-open-file://$1:$2:$3',
	},
	-- Match file paths with just line notation
	{
		regex = '\\s*([A-Za-z0-9_./-]+\\.(?:rs|lua|js|ts|py|go|c|cpp|h|hpp|txt|md|toml|yaml|yml|json)):(\\d+)',
		format = 'wezterm-open-file://$1:$2',
	},
	-- Match file paths without line/column
	{
		regex = '\\s*([A-Za-z0-9_./-]+\\.(?:rs|lua|js|ts|py|go|c|cpp|h|hpp|txt|md|toml|yaml|yml|json))\\b',
		format = 'wezterm-open-file://$1',
	},
	-- Keep existing rules
	{ regex = "(\\b[\\w\\d\\\\\\/\\._-]{2,}\\.\\w{2,4})",                                                          format = 'file://$1' },
	{ regex = '\\b\\w+://(?:[\\d\\w]|:)+@?[\\w\\d\\.-]+\\.[\\w\\d\\.-]+(?::\\d+)?(?:/[\\w\\d\\./\\?\\+%&~=_-]*)?', format = '$0' },
}
config.selection_word_boundary = ":,`\"' {}[]()<>"
config.mouse_bindings = {}


--==============================================================================
-- SECTION 11: PANES & SPLITS
--==============================================================================
-- All behavior-related `split_*` settings are deprecated.

--==============================================================================
-- SECTION 12: LAUNCHER & COMMAND PALETTE
--==============================================================================

-- Dynamically determine the editor path.
local desired_editor = env_vars.EDITOR or "code-insiders"
local editor_path

if desired_editor == "code-insiders" then
	local search_paths = { "/opt/homebrew/bin", "/usr/local/bin" }
	editor_path = find_executable(desired_editor, search_paths)

	if not editor_path then
		wezterm.log_warn("Could not find 'code-insiders' in search paths, falling back to 'nano'.")
		editor_path = "nano"
	end
else
	editor_path = desired_editor
end

log_debug("Determined Editor Path: " .. tostring(editor_path))

config.launch_menu = {
	{ label = "Edit Bash Config",     args = { editor_path, os.getenv("HOME") .. "/.bashrc" } },
	{ label = "Edit Zsh Config",      args = { editor_path, os.getenv("HOME") .. "/.zshrc" } },
	{ label = "Edit WezTerm Config",  args = { editor_path, os.getenv("HOME") .. "/.wezterm.lua" } },
	{ label = "Top (process viewer)", args = { "htop" } },
}

--==============================================================================
-- SECTION 13: ADVANCED COLOR OVERRIDES
--==============================================================================

config.colors = {
	split = '#444444',
	scrollbar_thumb = '#222222',
	selection_bg = 'rgba(255, 255, 255, 0.94)',
	selection_fg = 'rgba(255, 0, 0, 0.94)',
	cursor_bg = '#000000',
	cursor_fg = '#000000',
	cursor_border = '#000000',
	tab_bar = {
		background = '#11111b',
		active_tab = { bg_color = '#89b4fa', fg_color = '#11111b', intensity = 'Bold' },
		inactive_tab = { bg_color = '#1e1d2f', fg_color = '#cdd6f4' },
		inactive_tab_hover = { bg_color = '#313244', fg_color = '#cdd6f4' },
		new_tab = { bg_color = '#1e1d2f', fg_color = '#cdd6f4' },
		new_tab_hover = { bg_color = '#313244', fg_color = '#cdd6f4', italic = true },
	},
}



--==============================================================================
-- SECTION 14: EVENTS & DYNAMIC BEHAVIOR (WITH LOGGING)
--==============================================================================

local function set_dynamic_padding(window, pane)
	local dims = window:get_dimensions()
	local overrides = window:get_config_overrides() or {}
	overrides.window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = dims.pixel_height * 0.05,
	}
	window:set_config_overrides(overrides)
end

wezterm.on('window-resized', set_dynamic_padding)
wezterm.on('window-config-reloaded', set_dynamic_padding)

local function resolve_project_path(cwd, file_path_param)
	log_debug("--- resolve_project_path START ---")
	log_debug("Input CWD: " .. tostring(cwd))
	log_debug("Input Path: " .. tostring(file_path_param))

	local original_path = file_path_param

	-- 0. Tilde handling
	if string.sub(original_path, 1, 1) == '~' then
		local home = os.getenv("HOME") or ""
		original_path = home .. string.sub(original_path, 2)
		log_debug("Tilde expanded to: " .. original_path)
	end

	-- 1. Absolute check
	if string.sub(original_path, 1, 1) == '/' then
		local f = io.open(original_path, "r")
		if f then
			f:close(); return original_path
		end
		return original_path
	end

	-- 2. Naive check (Fastest)
	-- Check against the Symlink path first
	local naive_path = cwd .. '/' .. original_path
	local f = io.open(naive_path, "r")
	if f then
		f:close(); return naive_path
	end

	-- 3. Resolve Real Path (Symlink handling)
	local realpath_pipe = io.popen('realpath "' .. cwd .. '"')
	local real_cwd = cwd
	if realpath_pipe then
		local resolved = realpath_pipe:read('*a'):match("^%s*(.-)%s*$")
		realpath_pipe:close()
		if resolved and resolved ~= "" then
			real_cwd = resolved
			log_debug("Resolved Real Path: " .. real_cwd)
		end
	end

	-- 4. Naive check on Real Path
	local naive_real_path = real_cwd .. '/' .. original_path
	f = io.open(naive_real_path, "r")
	if f then
		f:close(); return naive_real_path
	end

	-- 5. ANCHOR SEARCH (Fast & Robust)
	-- Strategy: Find the FIRST folder (e.g., "Element") within a depth limit.
	-- Then manually append the rest of the path.

	-- Split path: "Element/Air/Source/..." -> "Element" and "Air/Source/..."
	local first_folder = string.match(original_path, "^([^/]+)")
	local rest_of_path = string.sub(original_path, #first_folder + 2)

	log_debug("Anchor Folder: " .. first_folder)
	log_debug("Rest of Path: " .. rest_of_path)

	if first_folder then
		-- Construct find command to look ONLY for the directory name, with depth limit
		-- -maxdepth 7: Fast enough, deep enough for standard project nesting
		-- We keep pruning logic for speed
		local cmd = '/usr/bin/find "' ..
			real_cwd ..
			'" -maxdepth 7 -type d \\( -iname node_modules -o -iname vendor -o -iname dist -o -iname target -o -iname .git -o -iname .next -o -iname .venv \\) -prune -false -o -type d -name "' ..
			first_folder .. '"'

		log_debug("Executing Anchor Search: " .. cmd)
		local pipe = io.popen(cmd)
		if pipe then
			local output = pipe:read('*a')
			pipe:close()

			for found_dir in string.gmatch(output, "[^\r\n]+") do
				found_dir = found_dir:match("^%s*(.-)%s*$")
				-- Construct potential full path
				local potential_path = found_dir .. '/' .. rest_of_path

				log_debug("Checking Candidate: " .. potential_path)
				local f_check = io.open(potential_path, "r")
				if f_check then
					f_check:close()
					log_debug("SUCCESS: File exists at " .. potential_path)
					return potential_path
				end
			end
		end
	end

	-- 6. Fallback
	log_debug("Search failed. Returning Real Naive fallback.")
	return naive_real_path
end

-- Handle custom file opening
wezterm.on('open-uri', function(window, pane, uri)
	log_debug("=== OPEN URI EVENT TRIGGERED ===")
	log_debug("RAW URI RECEIVED: " .. uri) -- CRITICAL LOG: Check if this has $2 or numbers

	local prefix = 'wezterm-open-file://'

	if uri:sub(1, #prefix) == prefix then
		local file_info = uri:sub(#prefix + 1)
		log_debug("FILE INFO STRIPPED: " .. file_info)

		local parts = {}
		for part in string.gmatch(file_info, "[^:]+") do table.insert(parts, part) end

		log_debug("PARSED PARTS: " .. table.concat(parts, " | ")) -- Log the split result

		local file_path = parts[1]
		local line = parts[2]
		local column = parts[3]

		log_debug("Extracted -> Path: " ..
			tostring(file_path) .. ", Line: " .. tostring(line) .. ", Col: " .. tostring(column))

		if not file_path then return true end

		local cwd = pane:get_current_working_dir()
		if cwd then
			if type(cwd) == "userdata" then
				cwd = cwd.file_path and cwd.file_path or os.getenv("HOME")
			else
				cwd = tostring(cwd)
			end
		else
			cwd = os.getenv("HOME")
		end

		local resolved_path = resolve_project_path(cwd, file_path)
		log_debug("Final Resolved Path: " .. resolved_path)

		local file_arg
		if line and column then
			file_arg = string.format('%s:%s:%s', resolved_path, line, column)
		elseif line then
			file_arg = string.format('%s:%s', resolved_path, line)
		else
			file_arg = resolved_path
		end

		local command_str = string.format('"%s" --goto "%s"', editor_path, file_arg)
		log_debug("Executing: " .. command_str)

		os.execute(command_str .. " &")

		return false
	end

	return true
end)

--==============================================================================
-- SECTION 15: DEBUGGING & PERFORMANCE
--==============================================================================

config.front_end = 'WebGpu'
config.term = 'xterm-256color'
config.warn_about_missing_glyphs = true

--==============================================================================
-- SECTION 16: MISCELLANEOUS & ADVANCED
--==============================================================================

config.window_close_confirmation = 'AlwaysPrompt'
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400

--==============================================================================
-- SECTION 17: DYNAMIC FUNCTIONS & AUTOMATION
--==============================================================================

local function get_theme_info()
	local hour = tonumber(wezterm.strftime('%H'))
	if hour >= 7 and hour < 19 then
		return { scheme = 'Catppuccin Latte', mode = 'light' }
	end
	return { scheme = 'Catppuccin Mocha', mode = 'dark' }
end

local theme_info = get_theme_info()

config.color_scheme = theme_info.scheme

config.set_environment_variables = {
	WEZTERM_THEME = theme_info.mode
}

--==============================================================================
-- FINAL RETURN STATEMENT
--==============================================================================

return config
