local wezterm = require "wezterm"

local M = {}

function M.apply_to_config(config)
  config.hide_tab_bar_if_only_one_tab = true
end

return M
