-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  --   { command = "black", filetypes = { "python" } },
  -- { command = "isort", filetypes = { "python" } }, {
  -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  command = "prettier",
  ---@usage arguments to pass to the formatter
  -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  extra_args = { "--print-with", "100", '--config-precedence', 'prefer-file' },
  ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css" },
}


-- local capabilities = require("lvim.lsp").common_capabilities()

-- require("typescript").setup {
--   -- disable_commands = false, -- prevent the plugin from creating Vim commands
--   debug = true, -- enable debug logging for commands
--   go_to_source_definition = {
--     fallback = true, -- fall back to standard LSP definition on failure
--   },
--   server = { -- pass options to lspconfig's setup method
--     on_attach = require("lvim.lsp").common_on_attach,
--     on_init = require("lvim.lsp").common_on_init,
--     capabilities = capabilities,
--     settings = {
--       typescript = {
--         inlayHints = {
--           includeInlayEnumMemberValueHints = true,
--           includeInlayFunctionLikeReturnTypeHints = true,
--           includeInlayFunctionParameterTypeHints = false,
--           includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--           includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--           includeInlayPropertyDeclarationTypeHints = true,
--           includeInlayVariableTypeHints = true,
--         },
--       },
--     },
--   },
-- }

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
require("dap-vscode-js").setup {
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = mason_path .. "packages/js-debug-adapter", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
}

for _, language in ipairs { "typescript", "javascript" } do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end

require 'lspconfig'.tsserver.setup {
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = require 'lsp'.tsserver_on_attach,
  -- This makes sure tsserver is not used for formatting (I prefer prettier)
  -- on_attach = require'lsp'.common_on_attach,
  settings = { documentFormatting = false }
}
