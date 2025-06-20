return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    ft = { 'rust' },
    lazy = true,
    enabled = true,
  },
  -- {
  --   "cordx56/rustowl",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --   },
  --   config = function()
  --     local lspconfig = require("lspconfig")
  --     lspconfig.rustowlsp.setup({
  --       trigger = {
  --         hover = false,
  --       },
  --     })
  --   end,
  -- }
}
