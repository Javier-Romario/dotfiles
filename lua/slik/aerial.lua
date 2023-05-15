require('aerial').setup({
  backends = { "treesitter", "lsp", "markdown", "man" },
  layout = {
    default_direction = "float",
    max_width = { 80, 0.8 },
    min_width = 0.5,
  },
  float = {
    border = "rounded",
    relative = "cursor",
    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },
  },
  attach_mode = "window",
  -- direction = float
})
