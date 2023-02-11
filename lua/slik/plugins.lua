lvim.plugins = {
  { 'mbbill/undotree' },
  { 'kaputi/e-kaput.nvim' },
  { 'ldelossa/buffertag' },
  { 'yonlu/omni.vim' },
  { 'iamcco/markdown-preview.nvim', run = "cd app && yarn" },
  { 'simrat39/symbols-outline.nvim' },
  { "rebelot/kanagawa.nvim" },
  { 'wellle/targets.vim' },
  { 'gelguy/wilder.nvim' },
  { 'jwalton512/vim-blade' },
  { 'metakirby5/codi.vim' },
  { "tpope/vim-surround", ['keys'] = { "c", "d", "y" } },
  { 'mattn/emmet-vim' },
  { 'junegunn/fzf' },
  { 'junegunn/fzf.vim' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'folke/twilight.nvim' },
  { "marko-cerovac/material.nvim", config = function()
    vim.g.material_style = "deep ocean"
  end },
  { "stevearc/aerial.nvim", config = function()
  end },
  { "rafamadriz/neon", config = function()
    vim.g.neon_style = "doom"
    vim.g.neon_italic_keyword = true
    vim.g.neon_italic_function = true
    vim.g.neon_transparent = true

    -- -- vim.cmd [[colorscheme neon]]
  end },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").on_attach() end,
  },
  { 'simrat39/rust-tools.nvim' },
  { 'kvrohit/mellow.nvim' },
  { 'terryma/vim-multiple-cursors' },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "jackMort/ChatGPT.nvim" },
  "nacro90/numb.nvim",
  "kevinhwang91/nvim-bqf",
  "lvimuser/lsp-inlayhints.nvim",
  "lunarvim/synthwave84.nvim",
  "norcalli/nvim-colorizer.lua",
  "nyoom-engineering/oxocarbon.nvim"
}
