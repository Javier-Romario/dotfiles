return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function(_, _) -- lazy, opts
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local opts = { noremap = true, silent = true }

      local keymap = vim.keymap -- for conciseness

      local on_attach = function(_, bufnr) -- client, bufnr
        opts.buffer = bufnr
        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()", opts) -- go to declaration

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementations()<CR>", opts) -- show lsp implementations
        --
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>lua vim.lsp.lsp_type_definitions()<CR>", opts) -- show lsp type definitions
        --
        -- opts.desc = "Show buffer diagnostics"
        -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      lspconfig["html"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure golang server
      lspconfig["gopls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })

      -- configure css server
      lspconfig["cssls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure emmet language server
      lspconfig["emmet_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "vue", "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      })

      -- configure lua server (with special settings)
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      local mason_registry = require('mason-registry')
      local vue_ls = mason_registry.get_package('vue-language-server')
      local got
      -- vim.inspect(mason_registry)
      -- print(vue_ls) -- Debug output
      if vue_ls then
          got = vue_ls:get_install_path() .. '/node_modules/@vue/language-server'
          print('got it', type(got))
          print('got it', got)
      else
          print("Vue Language Server not found in Mason registry.")
      end

      lspconfig.ts_ls.setup {
        -- Initial options for the TypeScript language server
        init_options = {
          plugins = {
            {
              -- Name of the TypeScript plugin for Vue
              name = '@vue/typescript-plugin',
              location = got,
              -- location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
              languages = { 'vue' },
            }
          },
        },

        -- Specify the file types that will trigger the TypeScript language server
        filetypes = {
          'typescript',          -- TypeScript files (.ts)
          'javascript',          -- JavaScript files (.js)
          'javascriptreact',     -- React files with JavaScript (.jsx)
          'typescriptreact',     -- React files with TypeScript (.tsx)
          'vue'                  -- Vue.js single-file components (.vue)
        },
      }

      lspconfig.volar.setup {
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
        settings = {
          -- typescript = {
          --   inlayHints = {
          --     enumMemberValues = {
          --       enabled = true,
          --     },
          --     functionLikeReturnTypes = {
          --       enabled = true,
          --     },
          --     propertyDeclarationTypes = {
          --       enabled = true,
          --     },
          --     parameterTypes = {
          --       enabled = true,
          --       suppressWhenArgumentMatchesName = true,
          --     },
          --     variableTypes = {
          --       enabled = true,
          --     },
          --   },
          -- },
        },
        -- cmd = {
        --   "npm",
        --   "vue-language-server",
        --   "--stdio",
        -- },
      }

      lspconfig.eslint.setup {}
      lspconfig.biome.setup {}

      -- lspconfig.rustowl.setup {
      --   trigger = {
      --     hover = false,
      --   },
      -- }
    end,
  },
}
