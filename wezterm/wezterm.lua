local wezterm = require('wezterm')
local fonts = require('fonts')
local background = require("background")
local theme = require "theme"
local tabs = require "tabs"
local window = require "window"

local config = {}

fonts.apply_to_config(config)
background.apply_to_config(config)
theme.apply_to_config(config)
tabs.apply_to_config(config)
window.apply_to_config(config)

return config
