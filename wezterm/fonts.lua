local wezterm = require('wezterm')
local M = {}

function M.apply_to_config(config)
  config.font = wezterm.font 'Berkeley Mono'
  config.line_height = 1.9
end

return M
