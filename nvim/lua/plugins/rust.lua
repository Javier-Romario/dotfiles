return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'rust-analyzer'
      }
    }
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
  }
}
