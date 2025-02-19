return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        enabled = true,
        sign = true,
        signs = { '󰫎 ' },
        width = 'full',
                -- Highlight for the heading icon and extends through the entire line
        backgrounds = {
            'RenderMarkdownH1Bg',
            'RenderMarkdownH2Bg',
            'RenderMarkdownH3Bg',
            'RenderMarkdownH4Bg',
            'RenderMarkdownH5Bg',
            'RenderMarkdownH6Bg',
        },
        -- The 'level' is used to index into the list using a clamp
        -- Highlight for the heading and sign icons
        foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
        },
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      -- local snacks = require "snacks"
      -- snacks.toggle.map("<leader>um", {
      --   name = "Render Markdown",
      --   get = function()
      --     return require("render-markdown.state").enabled
      --   end,
      --   set = function(enabled)
      --     local m = require("render-markdown")
      --     if enabled then
      --       m.enable()
      --     else
      --       m.disable()
      --     end
      --   end,
      -- })
    end,
  }
}
