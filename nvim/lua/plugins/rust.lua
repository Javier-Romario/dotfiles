return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    ft = { 'rust' },
    lazy = true,
    enabled = true,
  },
  { "cordx56/rustowl", dependencies = { "neovim/nvim-lspconfig" } }
}
