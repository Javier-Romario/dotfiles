return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function(_, opts)
      local mason_registry = require("mason-registry")
      local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"
      -- https://github.com/johnsoncodehk/volar/blob/20d713b/packages/shared/src/types.ts
      local volar_init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
          },
        },
        -- typescript = {
        --   tsdk = "/Users/javierbsg/.volta/tools/shared/typescript/lib",
        -- },
      }
      local volar = require("lspconfig").volar

      volar.setup({
        -- ---@diagnostic disable-next-line: unused-local
        -- on_new_config = function(new_config, new_root_dir)
        --   new_config.init_options = volar_init_options
        --   new_config.typescript.tsdk = "/Users/javierbsg/.volta/tools/shared/typescript/lib"
        -- end,
        -- init_options = volar_init_options,
        -- settings = opts.settings,
        -- root_dir = opts.root_dir,
        init_options = {
          vue = {
            hybridMode = false,
          },
          typescript = {
            tsdk = "/Users/javierbsg/.volta/tools/shared/typescript/lib",
          },
        },
      })

      require("lspconfig").tsserver.setup({
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "vue" },
            },
          },
        },
      })

      require("lspconfig").eslint.setup({
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      require("lspconfig").stylelint_lsp.setup({
        settings = {
          filetypes = { "css", "scss" },
          stylelintplus = {
            -- see available options in stylelint-lsp documentation
          },
          root_dir = [[ root_pattern('.stylelintrc', 'package.json') ]],
        },
      })

      -- require("lspconfig").stylelint_lsp.setup({
      --   filetypes = { "css", "scss" },
      --   root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
      --   settings = {
      --     stylelintplus = {
      --       -- see available options in stylelint-lsp documentation
      --     },
      --   },
      --   on_attach = function(client)
      --     client.server_capabilities.document_formatting = false
      --   end,
      -- })
    end,
    opts = {
      -- make sure mason installs the server
      servers = {
        ---@type lspconfig.options.tsserver
        tsserver = {},
        volar = {},
        stylelint = {},
      },
    },
  },
}
