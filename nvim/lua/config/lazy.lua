local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      opts = {
        -- colorscheme = "duskfox",
      },
      import = "lazyvim.plugins",
    },
    -- local plugins need to be explicitly configured with dir
    -- {
    --   dir = "~/Programming/velocity.nvim",
    -- },
    -- {
    --   dir = "~/Programming/.nvim"
    -- },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.rust" },
    -- { import = "lazyvim.plugins.extras.ui.edgy" },
    -- { import = "lazyvim.plugins.extras.coding.codeium" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.editor.aerial" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    -- { import = "lazyvim.plugins.extras.vscode" },
    -- { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lsp.none-ls" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.lang.nushell" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "plugins" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- import/override with your plugins
    -- {
    --   "folke/tokyonight.nvim",
    --   opts = {
    --     transparent = true,
    --     styles = {
    --       sidebars = "transparent",
    --       floats = "transparent",
    --     },
    --   },
    -- },
    {
      "EdenEast/nightfox.nvim",
      opts = {
        options = {
          transparent = true,
          dim_inactive = true,
        },
      },
      config = function(_, opts)
        require("nightfox").setup(opts)
        -- vim.cmd("colorscheme nightfox")
      end,
    },
    {
      "maxmx03/fluoromachine.nvim",
      config = function()
        local fm = require("fluoromachine")
        function colors(_, color)
          return {
            bg = "#232931",
            bgdark = color.darken("#232931", 20),
            alt_bg = color.darken("#232931", 20),
            cyan = "#08d1c0",
            -- cyan = '#00F8BE',
            yellow = "#E0AF68",
            orange = "#fa815c",
            red = "#f7768e",
          }
        end

        function overrides(c)
          return {
            TelescopeResultsBorder = { fg = c.alt_bg, bg = c.alt_bg },
            TelescopeResultsNormal = { bg = c.alt_bg },
            TelescopePreviewNormal = { bg = c.bg },
            TelescopePromptBorder = { fg = c.alt_bg, bg = c.alt_bg },
            TelescopeTitle = { fg = c.fg, bg = c.comment },
            TelescopePromptPrefix = { fg = c.purple },
          }
        end

        fm.setup({
          overrides = overrides,
          colors = colors,
          glow = true,
          theme = "fluoromachine",
          -- transparent = "full",
          transparent = true,
        })
        -- vim.cmd.colorscheme 'fluoromachine'
      end,
    },
    {
      "catppuccin/nvim",
      config = function(_)
        require("catppuccin").setup({
          flavour = "mocha",
          transparent_background = true,
          term_colors = true,
        })
        -- vim.cmd.colorscheme 'catppuccin'
      end,
      priority = 1000,
    },
    {
      "eldritch-theme/eldritch.nvim",
      lazy = false,
      priority = 1000,
      opts = {

      },
      config = function()
        require("eldritch").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          transparent = true, -- Enable this to disable setting the background color
          terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
          styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = "dark", -- style for sidebars, see below
            floats = "dark", -- style for floating windows
          },
          sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
          hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
          dim_inactive = false, -- dims inactive windows, transparent must be false for this to work
          lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

          --- You can override specific color groups to use other groups or a hex color
          --- function will be called with a ColorScheme table
          ---@param colors ColorScheme
          on_colors = function(colors) end,

          --- You can override specific highlights to use other groups or a hex color
          --- function will be called with a Highlights and ColorScheme table
          ---@param highlights Highlights
          ---@param colors ColorScheme
          on_highlights = function(highlights, colors) end,
        })
        -- load the colorscheme here
        -- vim.cmd([[colorscheme eldritch]])
      end,
    },
    {
      "idr4n/github-monochrome.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    {
      "metalelf0/black-metal-theme-neovim",
      lazy = false,
      priority = 1000,
      config = function()
        require("black-metal").setup({
          -- optional configuration here
          theme = "Marduk",
          -- Don't set background
          transparent = false,
        })
        -- require("black-metal").load()
      end,
    },
    {
      "alexxGmZ/e-ink.nvim",
      priority = 1000,
      config = function ()
        require("e-ink").setup()
        vim.cmd.colorscheme "e-ink"

        -- choose light mode or dark mode
        -- vim.opt.background = "dark"
        -- vim.opt.background = "light"
        --
        -- or do
        -- :set background=dark
        -- :set background=light

        -- set Transparent
        local set_hl = vim.api.nvim_set_hl
        local mono = require("e-ink.palette").mono()

        set_hl(0, "Normal", { fg = mono[12], bg = "NONE" })
      end
    }
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    -- version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "maxmx03/fluoromachine.nvim" }},
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
