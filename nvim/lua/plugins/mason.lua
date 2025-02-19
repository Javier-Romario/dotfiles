return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    build = ":MasonUpdate",
    config = function()

      local mason = require("mason")
      -- import mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")

      local mason_tool_installer = require("mason-tool-installer")
      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        -- list of servers for mason to install
        ensure_installed = {
          "volar",
          "eslint",
          "ts_ls",
          "html",
          "htmx",
          "cssls",
          "tailwindcss",
          "svelte",
          "lua_ls",
          "graphql",
          "emmet_ls",
          "prismals",
          "pyright",
          "gopls",
          "bashls",
          "yamlls",
          "matlab_ls",
          "vtsls",
          "stylelint_lsp",
          -- "sonarlint",
          -- "markdown",
          -- "markdown-oxide",
          "marksman",
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = {}, -- not the same as ensure_installed
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier", -- prettier formatter
          "stylua", -- lua formatter
          "isort", -- python formatter
          "black", -- python formatter
          -- "pylint", -- python linter
          -- "eslint_d", -- js linter
        },
      })

    end
  }
}
