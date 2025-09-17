return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function(_, _)
      local vue_ls_config = {
        on_init = function(client)
          client.handlers['tsserver/request'] = function(_, result, context)
            local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
            local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
            local clients = {}

            vim.list_extend(clients, ts_clients)
            vim.list_extend(clients, vtsls_clients)

            if #clients == 0 then
              vim.notify('Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.', vim.log.levels.ERROR)
              return
            end
            local ts_client = clients[1]

            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
              title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
              command = 'typescript.tsserverRequest',
              arguments = {
                command,
                payload,
              },
            }, { bufnr = context.bufnr }, function(_, r)
              local response = r and r.body
              -- TODO: handle error or response nil here, e.g. logging
              -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
              local response_data = { { id, response } }

              ---@diagnostic disable-next-line: param-type-mismatch
              client:notify('tsserver/response', response_data)
            end)
          end
        end,
      }
      local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }
      local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
      local vtsls_config = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },
        filetypes = tsserver_filetypes,
      }
      local ts_ls_config = {
        init_options = {
          plugins = {
            vue_plugin,
          },
        },
        filetypes = tsserver_filetypes,
      }


      -- ===============================================
      -- 🛠️  BASIC SETUP
      -- ===============================================
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Enhanced capabilities for autocompletion
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- ===============================================
      -- ⌨️  KEYBIND CONFIGURATION
      -- ===============================================
      local keymap = vim.keymap
      local opts = { noremap = true, silent = true }

      local on_attach = function(client, bufnr)
        opts.buffer = bufnr

        -- Navigation keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration" 
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Go to definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- Actions keybinds
        opts.desc = "Show available code actions"
        keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        opts.desc = "Show documentation for what's under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end

      -- ===============================================
      -- 🎨 HTML & CSS SERVERS
      -- ===============================================
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "vue", "html", "typescriptreact", "javascriptreact",
          "css", "sass", "scss", "less", "svelte"
        },
      })

      -- ===============================================
      -- 🐹 GO LANGUAGE SERVER
      -- ===============================================
      lspconfig.gopls.setup({
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

      -- ===============================================
      -- 🌙 LUA LANGUAGE SERVER  
      -- ===============================================
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            -- Make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- Make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      -- ===============================================
      -- ⚡ VTSLS - FASTEST TYPESCRIPT SERVER! 
      -- ===============================================
      lspconfig.vtsls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "typescript",
          "javascript",
          "javascriptreact",
          "typescriptreact",
          "vue" -- 🔥 KEY: Add Vue support here!
        },
        settings = {
          vtsls = {
            -- 🚀 Performance optimizations
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
            -- 🎯 TypeScript settings
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            -- 🎯 JavaScript settings  
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
            },
          },
        },
      })

      -- ===============================================
      -- 💚 VUE LANGUAGE SERVER (VOLAR) - HYBRID MODE!
      -- ===============================================
      lspconfig.volar.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- 🔥 IMPORTANT: Disable volar's TypeScript to let vtsls handle it
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Use the standard on_attach for keybinds
          on_attach(client, bufnr)
        end,
        filetypes = { "vue" },
        init_options = {
          vue = {
            -- 🚀 KEY: Enable hybrid mode - let vtsls handle TS/JS
            hybridMode = true,
          },
        },
        settings = {
          vue = {
            server = {
              maxProjectRootDistance = 30,
            },
          },
        },
      })

      -- ===============================================
      -- 🔍 LINTING & FORMATTING
      -- ===============================================
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "javascript",
          "javascriptreact", 
          "typescript",
          "typescriptreact",
          "vue"
        },
      })

      lspconfig.biome.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- ===============================================
      -- 🎯 DIAGNOSTIC CONFIGURATION
      -- ===============================================
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- Could be '■', '▎', 'x', '●'
        },
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
          header = "",
          prefix = "",
        },
      })
      -- nvim below 0.11
      local lspconfig = require('lspconfig')

      -- If using ts_ls
      lspconfig.ts_ls.setup(ts_ls_config)
      lspconfig.vue_ls.setup(vue_ls_config)

      -- nvim 0.11 or above
      vim.lsp.config('vtsls', vtsls_config)
      vim.lsp.config('vue_ls', vue_ls_config)
      vim.lsp.config('ts_ls', ts_ls_config)
      vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`



    end,
  },
}



