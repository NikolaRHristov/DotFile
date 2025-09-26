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
        wezterm.log_warn("Environment file not found: " .. file_path)
        return env
    end

    for line in file:lines() do
        -- Match lines in the format `export KEY=VALUE` or `export KEY="VALUE"`
        local key, value = line:match("^%s*export%s+([%w_]+)=(.*)$")
        if key and value then
            -- Trim whitespace from the value
            value = value:match("^%s*(.-)%s*$")
            -- Remove surrounding quotes (single or double)
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
        local file = io.open(full_path, "r")
        if file then
            file:close()
            return full_path -- Return the full path if found
        end
    end
    return nil -- Return nil if not found
end

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
    left = 0,
    right = 0,
    top = 0,
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

config.default_cursor_style = 'BlinkingBar'
config.scrollback_lines = 3000
config.scroll_to_bottom_on_input = true
config.enable_scroll_bar = true

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
-- SECTION 10: MOUSE & SELECTION
--==============================================================================

config.hyperlink_rules = {
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
    -- Define common Homebrew paths to search for the executable.
    local search_paths = { "/opt/homebrew/bin", "/usr/local/bin" }
    editor_path = find_executable(desired_editor, search_paths)

    -- If not found after searching, fall back to nano.
    if not editor_path then
        wezterm.log_warn("Could not find 'code-insiders' in search paths, falling back to 'nano'.")
        editor_path = "nano"
    end
else
    -- If the desired editor isn't code-insiders, assume it's in the default path.
    editor_path = desired_editor
end

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
    selection_bg = 'rgba(255, 255, 255, 0.2)',
    selection_fg = 'none',
    cursor_bg = '#f5e0dc',
    cursor_fg = '#1e1d2f',
    cursor_border = '#f5e0dc',
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
-- SECTION 14: EVENTS & DYNAMIC BEHAVIOR
--==============================================================================

local function set_dynamic_padding(window, pane)
    local dims = window:get_dimensions()
    local overrides = window:get_config_overrides() or {}
    overrides.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = dims.pixel_height * 0.05,
    }
    window:set_config_overrides(overrides)
end

wezterm.on('window-resized', set_dynamic_padding)
wezterm.on('window-config-reloaded', set_dynamic_padding)

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
