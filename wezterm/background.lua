local wezterm = require "wezterm"
local M = {}

function M.apply_to_config(config)
  config.window_background_opacity = 0.95
end

return M
