return {
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
      -- views = {
      --   cmdline_popup = {
      --     border = {
      --       style = "none",
      --       padding = { 2, 3 },
      --     },
      --     filter_options = {},
      --     -- win_options = {
      --     --   winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      --     -- },
      --   },
      -- },
      -- presets = {
      --   command_palette = false,
      -- },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
