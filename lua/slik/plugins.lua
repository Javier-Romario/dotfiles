lvim.plugins = {
  { 'mbbill/undotree' },
  { 'kaputi/e-kaput.nvim' },
  { 'ldelossa/buffertag' },
  { 'yonlu/omni.vim' },
  { 'iamcco/markdown-preview.nvim', build = "cd app && yarn" },
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
  { 'ray-x/aurora' },
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
      require "nvim-ts-autotag".setup()
    end,
  },
  {
    "nvim-treesitter/playground",
    -- event = "BufRead",
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
    config = function() require "lsp_signature" .on_attach() end,
  },
  { 'simrat39/rust-tools.nvim' },
  { 'kvrohit/mellow.nvim' },
  { 'terryma/vim-multiple-cursors' },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "jackMort/ChatGPT.nvim", dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  } },
  "nacro90/numb.nvim",
  "kevinhwang91/nvim-bqf",
  "lvimuser/lsp-inlayhints.nvim",
  "lunarvim/synthwave84.nvim",
  "norcalli/nvim-colorizer.lua",
  "nyoom-engineering/oxocarbon.nvim",
  "jose-elias-alvarez/typescript.nvim",
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  { 'edluffy/hologram.nvim', config = true, lazy = { auto_display = true } },
  { 'editorconfig/editorconfig-vim' },
  { 'michaelb/sniprun', build = "./install.sh 1" },
  'ThePrimeagen/harpoon',
  -- "github/copilot.vim",
  {'akinsho/git-conflict.nvim', version = "*"},
  -- {"ecthelionvi/NeoComposer.nvim"}
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim", -- Optional
      opts = { lsp = { auto_attach = true } }
    }
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- -@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
      },
    },
  },
  { "andrewradev/splitjoin.vim" },
  {  'Exafunction/codeium.vim',
  event = 'BufEnter'},
  -- Go stuff
  "olexsmir/gopher.nvim",
  "leoluz/nvim-dap-go",
  
  {
    "aMOPel/nvim-treesitter-nim",
    -- install/update parsers
    build = {
      ':TSUpdate nim',
      ':TSUpdate nim_format_string',
    },
  }

}
