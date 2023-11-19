-- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
-- would overwrite `ensure_installed` with the new value.
-- If you'd rather extend the default config, use the code below instead:
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    -- opts = function(_, opts)
    --   opts.playground = {
    --     enable = true,
    --     disable = {},
    --     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    --     keybindings = {
    --       toggle_query_editor = "o",
    --       toggle_hl_groups = "i",
    --       toggle_injected_languages = "t",
    --       toggle_anonymous_nodes = "a",
    --       toggle_language_display = "I",
    --       focus_language = "f",
    --       unfocus_language = "F",
    --       update = "R",
    --       goto_node = "<cr>",
    --       show_help = "?",
    --     },
    --   }
    --   return opts
    -- end,
  },
}
