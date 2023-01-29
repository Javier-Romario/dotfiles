-- DEBUGGING
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/Programming/vscode-node-debug2/out/src/nodeDebug.js' },
  }
  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/Programming/vscode-chrome-debug/out/src/chromeDebug.js" }
  }

  dap.configurations.javascript = { -- change this to javascript if needed
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require 'dap.utils'.pick_process,
    },
    -- {
    --     type = "chrome",
    --     request = "attach",
    --     program = "${file}",
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = "inspector",
    --     port = 9229,
    --     webRoot = "${workspaceFolder}"
    -- }
  }
  dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }

  dap.configurations.typescriptreact = { -- change to typescript if needed
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }
  dap.configurations.typescript = { -- change to typescript if needed
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }

  -- Dap virtual text
  vim.cmd [[let g:dap_virtual_text = v:true]]
  -- Dap UI
  -- require('dapui').setup({
  --   layouts = {
  --     {
  --       elements = {
  --         -- Elements can be strings or table with id and size keys.
  --         { id = "scopes", size = 0.25 },
  --         "breakpoints",
  --         "stacks",
  --         "watches",
  --       },
  --       size = 40, -- 40 columns
  --       position = "right",
  --     },
  --     {
  --       elements = {
  --         "repl",
  --         "console",
  --       },
  --       size = 0.25, -- 25% of total lines
  --       position = "bottom",
  --     },
  --   }
  -- })
end
