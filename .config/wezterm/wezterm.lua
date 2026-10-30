local wezterm = require("wezterm")
local theme = require("lua.theme")
local keys = require("lua.keys")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

theme.apply(config)
keys.apply(config)

config.enable_kitty_graphics = true
-- use macOS launchd ssh-agent directly; wezterm proxy socket dies on restart and breaks herdr panes
config.mux_enable_ssh_agent = false

return config
