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
    { "LazyVim/LazyVim", opts = { colorscheme = "duskfox" }, import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.ui.edgy" },
    { import = "lazyvim.plugins.extras.coding.codeium" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.editor.aerial" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.vscode" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },

    {
      "folke/tokyonight.nvim",
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "dark",
        },
        -- colors = function(colors) end,
        on_highlights = function(hl, c)
          local prompt = "#2d3149"
          local cyberPink = "#ee2082"
          -- local lightPink = "#DBB2E5"
          local teal = "#08d1c0"
          -- local purp = "#bca9e1"
          -- local orange = "#ff757f"
          local cyberOrange = "#fd8090"
          local cyberGreen = "#65dc98"
          local lightBlue = "#c4ffff"

          -- hl["@parameter"] = {
          --   fg = orange,
          --   bg = "",
          -- }
          --
          -- hl["@field"] = {
          --   fg = cyberRed,
          --   bg = prompt,
          -- }
          --
          -- hl["@function"] = {
          --   fg = cyberRed,
          --   bg = "",
          -- }
          --
          hl["Function"] = {
            fg = cyberPink,
            bg = "",
          }
          --
          hl["@function.call"] = {
            fg = cyberPink,
            bg = "",
          }
          --
          hl["@function.method"] = {
            fg = cyberPink,
            bg = prompt,
          }

          hl["@tag"] = {
            fg = lightBlue,
          }

          hl["Tag"] = {
            fg = lightBlue,
          }

          hl["@type"] = {
            fg = cyberOrange,
            bg = "",
          }

          hl["@type.tsx"] = {
            fg = cyberOrange,
            bg = "",
          }

          hl["Type"] = {
            fg = cyberOrange,
            bg = "",
          }

          hl["@constructor"] = {
            fg = cyberGreen,
          }
          -- hl["@function.builtin"] = {
          --   fg = cyberRed,
          --   bg = "",
          -- }
          -- hl["@constant.builtin"] = {
          --   fg = teal,
          --   bg = "",
          -- }
          --
          -- hl["@property"] = {
          --   fg = cyberRed,
          --   bg = "",
          -- }
          --
          hl["@variable"] = {
            fg = teal,
            bg = prompt,
          }

          hl["@lsp.type.variable"] = {
            fg = teal,
            bg = prompt,
          }
          --
          -- hl["@method"] = {
          --   fg = cyberRed,
          --   bg = "",
          -- }
          --
          -- hl["@method.call"] = {
          --   fg = teal,
          --   bg = "",
          -- }
          --
          -- hl["@lsp.type.method"] = {
          --   fg = cyberRed,
          --   bg = prompt,
          -- }
          --
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
        end,
      },
    },
    {
      "EdenEast/nightfox.nvim",
      opts = {
        options = {
          transparent = true,
          dim_inactive = true,
        },
      },
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
  install = { colorscheme = { "tokyonight", "habamax" } },
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
