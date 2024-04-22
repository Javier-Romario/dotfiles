return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = function(_, opts)
      local ensure_installed = {
        "vue-language-server",
      }
      opts.ensure_installed = opts.ensure_installed or {}
      for _,v in ipairs(ensure_installed) do
        table.insert(opts.ensure_installed, v)
      end
      return opts
    end,
    -- config = function(_, opts)
    --   require("mason").setup(opts)
    --
    --   print('mason ran')
    -- end
  }
  -- "williamboman/mason.nvim",
  -- dependencies = {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  -- },
  -- opts = {
  --   ensure_installed = {
  --     "lua-language-server",
  --     "typescript-language-server",
  --     "stylua",
  --     "prettierd",
  --     "stylelint",
  --     "eslint_d",
  --     "eslint-lsp",
  --     "vue-language-server",
  --   },
  -- },
  -- config = function(_, opts)
  --   local mason = require("mason")
  --
  --   local mason_tool_installer = require("mason-tool-installer")
  --   -- enable mason and configure icons
  --   mason.setup({
  --     ui = {
  --       icons = {
  --         package_installed = "✓",
  --         package_pending = "➜",
  --         package_uninstalled = "✗",
  --       },
  --     },
  --   })
  --
  --   mason_tool_installer.setup({
  --     ensure_installed = {
  --       "prettier", -- prettier formatter
  --       "stylua", -- lua formatter
  --       "isort", -- python formatter
  --       "black", -- python formatter
  --       "pylint", -- python linter
  --       "eslint_d", -- js linter
  --     },
  --   })
  -- end,
}
