return {
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('poimandres').setup {
        bold_vert_split = false, -- use bold vertical separators
        dim_nc_background = true, -- dim 'non-current' window backgrounds
        disable_background = true, -- disable background
        disable_float_background = false, -- disable background for floats
        disable_italics = false, -- disable italics
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      }
      -- vim.cmd("colorscheme poimandres")
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
      -- print('this happended')
      -- vim.cmd("colorscheme poimandres")
    end
  },
  { "shmerl/neogotham" },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      return opts
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
                        _/  _/  _/                  _/                  _/  _/
               _/_/_/  _/      _/  _/      _/_/_/  _/_/_/      _/_/    _/  _/
            _/_/      _/  _/  _/_/      _/_/      _/    _/  _/_/_/_/  _/  _/
               _/_/  _/  _/  _/  _/        _/_/  _/    _/  _/        _/  _/
          _/_/_/    _/  _/  _/    _/  _/_/_/    _/    _/    _/_/_/  _/  _/
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      opts.theme = "hyper"
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
      },
      notify = {
        enabled = true,
      },
      views = {
        cmdline_popup = {
          border = {
            style = "rounded",
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
      presets = {
        command_palette = false,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      -- window = {
      --   position = "float",
      -- },
      follow_current_file = {
        enabled = true,
      },
      -- hijack_netrw_behavior = "disabled",
    },
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
  },
  -- {
  --   "xiyaowong/transparent.nvim",
  --   opts = {
  --     extra_groups = {
  --       "NeoTreeNormal",
  --       "NeoTreeNormalNC",
  --       "NormalFloat",
  --     },
  --   }
  -- }
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("flow").setup {
        transparent = true, -- Set transparent background.
        fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
        mode = "normal", -- Intensity of the palette: normal, dark, or bright. Notice that dark is ugly!
        aggressive_spell = false, -- Display colors for spell check.
      }

      -- vim.cmd "colorscheme flow"
    end
  },
  -- {
  --   "shellRaining/hlchunk.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     require("hlchunk").setup({
  --       chunk = {
  --         enable = false,
  --         chars = {
  --           horizontal_line = "─",
  --           vertical_line = "│",
  --           left_top = "╭",
  --           left_bottom = "╰",
  --           right_arrow = ">",
  --         },
  --         textobject = "ic",
  --         style = "#00F8BE",
  --       },
  --       indent = {
  --         enable = true,
  --         chars = {
  --           "․",
  --           "⁚",
  --           "⁖",
  --           "⁘",
  --           "⁙",
  --         },
  --         style = {
  --           "#666666",
  --           "#555555",
  --           "#444444",
  --         },
  --       },
  --       blank = {
  --         enable = true,
  --         chars = {
  --           " ",
  --         },
  --         style = {
  --           { bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("cursorline")), "bg", "gui") },
  --           { bg = "", fg = "" },
  --         },
  --       }
  --       -- blank = {
  --       --   enable = true
  --       -- },
  --     })
  --   end
  -- },
  {
    "water-sucks/darkrose.nvim",
    lazy = false,
    priority = 1000,
  },
}
