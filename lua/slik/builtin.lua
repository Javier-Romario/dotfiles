lvim.builtin.alpha.dashboard.section.header.val = {
  "                         _/  _/  _/                  _/                  _/  _/   ",
  "                _/_/_/  _/      _/  _/      _/_/_/  _/_/_/      _/_/    _/  _/    ",
  "             _/_/      _/  _/  _/_/      _/_/      _/    _/  _/_/_/_/  _/  _/     ",
  "                _/_/  _/  _/  _/  _/        _/_/  _/    _/  _/        _/  _/      ",
  "           _/_/_/    _/  _/  _/    _/  _/_/_/    _/    _/    _/_/_/  _/  _/       ",
}

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight-moon"
lvim.builtin.dap.active = true
lvim.transparent_window = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.lsp.diagnostics.float.focusable = true
lvim.builtin.autopairs.active = true
lvim.reload_config_on_save = false
lvim.builtin.terminal.active = true
lvim.builtin.breadcrumbs.active = true
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.alpha.dashboard.section.header.opts.hl = PickColor()
lvim.builtin.alpha.dashboard.section.footer.opts.hl = PickColor()

lvim.builtin.alpha.dashboard.section.footer.val = Footer()

lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
lvim.builtin.lualine.extensions = { 'quickfix', 'fzf', 'nvim-dap-ui', 'nvim-tree' }
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_x = { "location" }
lvim.builtin.lualine.sections.lualine_y = { "diff", "filesize" }
lvim.builtin.lualine.options.theme = 'material'
lvim.builtin.lualine.sections.lualine_c = { "breadcrumbs" }
lvim.builtin.lualine.options.globalstatus = true

-- lvim.builtin.treesitter.rainbow = {
--   enable = true,
--   extended_mode = true,
--   max_file_lines = 1000,
--   colors = {
--     "#f7768e",
--     "#9ece6a",
--     "#e0af68",
--     "#7aa2f7",
--     "#bb9af7",
--     "#7dcfff",
--   },
-- }
--

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"


local gheight = vim.api.nvim_list_uis()[1].height
local gwidth = vim.api.nvim_list_uis()[1].width
local width = 70
local height = 50

lvim.builtin.nvimtree.setup.view.float = {
  enable = true,
  open_win_config = {
    relative = "editor",
    width = width,
    height = height,
    row = (gheight - height) * 0.5,
    col = (gwidth - width) * 0.5
  }
}

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
