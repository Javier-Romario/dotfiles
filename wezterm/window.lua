local wezterm = require("wezterm")
local M = {}

function M.apply_to_config(config)
  config.window_decorations = "RESIZE"
  config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  }
end

return M
