lvim.builtin.alpha.dashboard.section.header.val = {
  "                         _/  _/  _/                  _/                  _/  _/   ",
  "                _/_/_/  _/      _/  _/      _/_/_/  _/_/_/      _/_/    _/  _/    ",
  "             _/_/      _/  _/  _/_/      _/_/      _/    _/  _/_/_/_/  _/  _/     ",
  "                _/_/  _/  _/  _/  _/        _/_/  _/    _/  _/        _/  _/      ",
  "           _/_/_/    _/  _/  _/    _/  _/_/_/    _/    _/    _/_/_/  _/  _/       ",
}

lvim.log.level = "warn"
lvim.format_on_save = {
  pattern = { "*.php" }
}
lvim.colorscheme = "tokyonight-moon"
lvim.builtin.dap.active = true
lvim.transparent_window = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.autopairs.active = true
lvim.reload_config_on_save = true
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

-- lvim.builtin.nvimtree.setup.view.side = "float"


local gheight = vim.api.nvim_list_uis()[1].height
local gwidth = vim.api.nvim_list_uis()[1].width
local width = 70
local height = 30

-- lvim.builtin.nvimtree.setup.view.float
lvim.builtin.nvimtree.setup.view.float = {
  enable = true,
  open_win_config = {
    relative = "editor",
    width = width,
    height = height,
    row = (gheight - height) * 0.5,
    col = (gwidth - width) * 0.5
  },
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


lvim.builtin.theme.tokyonight.options.on_highlights = function(hl, c)
  local prompt = "#2d3149"
  hl.TelescopeNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
  }
  hl.TelescopeBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.DiagnosticUnderlineHint = {
    guisp = '#445500',
    sp = '#445500'
  }
end

-- toggleterm
lvim.builtin.terminal.direction = 'horizontal'

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
