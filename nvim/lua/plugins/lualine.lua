-- the opts function can also be used to change the default opts:
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "marko-cerovac/material.nvim",
    },
    opts = function(_, opts)
      -- table.insert(opts.sections.lualine_x, "😄")
      -- table.insert(opts.sections.lualine_a, { "filename", "branch" })
      -- table.insert(opts.sections.lualine_x, { "location" })
      -- table.insert(opts.sections.lualine_y, { "diff", "filesize" })
      opts.extensions = {
        "quickfix",
        "fzf",
        "nvim-tree",
        "aerial",
        "symbols-outline",
        "trouble",
        "fzf",
      }


      opts.options.theme = "iceberg_dark"
      -- opts.options.theme = "horizon"
      -- opts.options.theme = "material-stealth"
      -- opts.options.theme = "poimandres"
      -- opts.options.theme = "fluoromachine"
    end,
  },
}

--[[
lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
lvim.builtin.lualine.extensions = { 'quickfix', 'fzf', 'nvim-dap-ui', 'nvim-tree' }
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_x = { "location" }
lvim.builtin.lualine.sections.lualine_y = { "diff", "filesize" }
lvim.builtin.lualine.options.theme = 'material'
lvim.builtin.lualine.sections.lualine_c = { "breadcrumbs" }
lvim.builtin.lualine.options.globalstatus = true
]]
--
