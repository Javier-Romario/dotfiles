local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
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
    {
      dir = "~/Programming/velocity.nvim",
    },
    -- {
    --   dir = "~/Programming/.nvim"
    -- },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.ui.edgy" },
    { import = "lazyvim.plugins.extras.coding.codeium" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    -- { import = "lazyvim.plugins.extras.editor.aerial" },
    -- { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.vscode" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lsp.none-ls" },
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "plugins" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
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
          glow = false,
          theme = "fluoromachine",
          -- transparent = "full",
          transparent = true,
        })
        vim.cmd.colorscheme 'fluoromachine'
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
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
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
