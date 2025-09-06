-- ~/.wezterm.lua
--
-- A feature-rich, developer-centric WezTerm configuration for macOS.
-- This version is based on the official documentation and provides the
-- definitive fix for the Option/Alt key behavior.

local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

--==============================================================================
-- SECTION 1: CORE VISUALS & BEHAVIOR
--==============================================================================

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'SauceCodePro Nerd Font'
config.font_size = 14.0
config.line_height = 1.2
config.window_decorations = "RESIZE"

-- THE DEFINITIVE FIX FOR ALT/OPTION KEY (Based on Official Docs)
-- This setting tells WezTerm how to treat the macOS Option key.
-- Setting it to 'Alt' or 'Meta' makes it behave like a standard Alt key,
-- which is what shells and terminal applications expect for shortcuts
-- like word-wise navigation. This is the correct modern setting.
-- config.option_as = 'Alt'

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

config.window_padding = { left = 20, right = 20, top = 20, bottom = 10 }
config.window_background_opacity = 0.9
config.macos_window_background_blur = 15
config.text_background_opacity = 1.0

config.default_cursor_style = 'BlinkingBar'
config.enable_scroll_bar = true
config.audible_bell = "Disabled"
config.automatically_reload_config = true

--==============================================================================
-- SECTION 2: DYNAMIC & INFORMATIVE STATUS BAR
--==============================================================================

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.tab_max_width = 30

wezterm.on('update-right-status', function(window, pane)
  local parts = {}
  local workspace = window:active_workspace()
  table.insert(parts, ' ' .. wezterm.nerdfonts.md_desktop_mac .. ' ' .. workspace .. ' ')
  local process_name = pane:get_foreground_process_name():match("[^/\\]+$")
  if not string.find(process_name, "zsh") and not string.find(process_name, "bash") then
    table.insert(parts, ' | ' .. wezterm.nerdfonts.fa_cogs .. ' ' .. process_name .. ' ')
  end
  local git_branch = pane:get_title()
  if git_branch and git_branch ~= '' and git_branch ~= 'zsh' then
    table.insert(parts, ' | ' .. wezterm.nerdfonts.md_git .. ' ' .. git_branch .. ' ')
  end
  table.insert(parts, ' | ' .. wezterm.nerdfonts.md_clock .. ' ' .. wezterm.strftime '%H:%M ')
  window:set_right_status(wezterm.format(parts))
end)

--==============================================================================
-- SECTION 3: KEYBINDINGS FOR A VS CODE-LIKE EXPERIENCE
--==============================================================================

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- VS CODE FEATURE: Command Palette & Search
  { key = 'p',          mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette },
  { key = 'f',          mods = 'CMD|SHIFT', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },

  -- Pane Management
  { key = '"',          mods = 'LEADER',    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '%',          mods = 'LEADER',    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'h',          mods = 'LEADER',    action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l',          mods = 'LEADER',    action = wezterm.action.ActivatePaneDirection 'Right' },

  -- Word-wise Navigation for CTRL key.
  -- The Option/Alt key is now handled globally and correctly by `option_as = 'Alt'`.
  -- { key = 'LeftArrow',  mods = 'CTRL',      action = wezterm.action.SendString '\x1bb' },
  -- { key = 'RightArrow', mods = 'CTRL',      action = wezterm.action.SendString '\x1bf' },

  -- Tab Management and Standard Controls
  { key = 't',          mods = 'CMD',       action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w',          mods = 'CMD',       action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = 'c',          mods = 'CMD',       action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v',          mods = 'CMD',       action = wezterm.action.PasteFrom 'Clipboard' },
}

--==============================================================================
-- SECTION 4: MULTIPLEXING, WORKSPACES, AND SSH
--==============================================================================

config.unix_domains = { { name = 'unix' } }

config.ssh_domains = {
  {
    name = 'my-remote-server',
    remote_address = 'user@your-server.com',
  },
}

return config
