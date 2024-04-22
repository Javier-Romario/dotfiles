-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/volar.lua
-- /Users/javierharford/.volta/tools/shared/typescript/lib
-- If you are using mason.nvim, you can get the ts_plugin_path like this

--[[
-- local mason_registry = require('mason-registry')
-- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

local vue_language_server_path = '/path/to/@vue/language-server'

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

-- No need to set `hybridMode` to `true` as it's the default value
lspconfig.volar.setup {}
]]--

-- local util = require 'lspconfig.util'

-- local function get_typescript_server_path(root_dir)
--   local project_root = util.find_node_modules_ancestor(root_dir)
--   return project_root and (util.path.join(project_root, 'node_modules', 'typescript', 'lib')) or ''
-- end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function(_, opts)
      local mason_registry = require('mason-registry')
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
      -- https://github.com/johnsoncodehk/volar/blob/20d713b/packages/shared/src/types.ts
      local volar_init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },

        typescript = {
          tsdk = '/Users/javierbsg/.volta/tools/shared/typescript/lib',
        },
      }
      local volar = require("lspconfig").volar

      volar.setup({
        ---@diagnostic disable-next-line: unused-local
        on_new_config = function(new_config, new_root_dir)
          new_config.init_options = volar_init_options
          new_config.typescript.tsdk = '/Users/javierbsg/.volta/tools/shared/typescript/lib'
        end,
        init_options = volar_init_options,
        settings = opts.settings
      })

      require('lspconfig').tsserver.setup({})
      require('lspconfig').eslint.setup({
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end
      })
    end,
    opts = {
    -- make sure mason installs the server
      servers = {
        ---@type lspconfig.options.tsserver
        tsserver = {},
        volar = {},
      }
    }
  }
}
