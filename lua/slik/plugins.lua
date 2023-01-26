lvim.plugins = {
  -- Requires Nvim 0.7
  -- { 'bennypowers/nvim-regexplainer',
  --     config = function() require'regexplainer'.setup() end,
  --     requires = {
  --       'nvim-treesitter/nvim-treesitter',
  --       'MunifTanjim/nui.nvim',
  --     } },
  { 'mbbill/undotree' },
  { 'kaputi/e-kaput.nvim' },
  { 'ldelossa/buffertag' },
  { 'yonlu/omni.vim' },
  { 'iamcco/markdown-preview.nvim', run = "cd app && yarn" },
  { 'unblevable/quick-scope', config = function()
    vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
  end },
  { 'simrat39/symbols-outline.nvim' },
  { "rebelot/kanagawa.nvim" },
  { 'wellle/targets.vim' },
  -- { 'luochen1990/rainbow', config = function()
  --   vim.g.rainbow_active = 1
  -- end },
  { 'gelguy/wilder.nvim', config = function()
    -- vim.cmd[[call wilder#setup({'modes': [':', '/', '?']})]]
  end },
  { 'jwalton512/vim-blade' },
  { 'voldikss/vim-floaterm', config = function()
  end, setup = {
    vim.cmd("let g:floaterm_wintype = 'split'")
  } },
  { 'metakirby5/codi.vim' },
  { "tpope/vim-surround", ['keys'] = { "c", "d", "y" } },
  { 'mattn/emmet-vim' },
  { 'junegunn/fzf', config = function()
    local fz = {}
    fz['ctrl-t'] = 'tab split'
    fz['ctrl-x'] = 'split'
    fz['ctrl-v'] = 'vsplit'
    vim.g.fzf_action = fz

    local fzLay = {}
    fzLay['up'] = '~100%'
    local window = {}
    window['width'] = 0.8
    window['height'] = 0.8
    window['yoffset'] = 0.5
    window['xoffset'] = 0.5
    window['border'] = 'sharp'
    fzLay['window'] = window
    vim.g.fzf_layout = fzLay
    vim.g.fzf_tags_command = 'ctags -R'
    -- let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"
    -- vim.cmd"command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)"
    -- vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden -g {!.git/**,!build/**,!.dart_tool/**,!.idea}"
  end, setup = {} },
  { 'junegunn/fzf.vim' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'folke/twilight.nvim', config = function()
    require("twilight").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end },
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
    config = function() require "lsp_signature".on_attach() end,
  },
  { 'simrat39/rust-tools.nvim' },
  { 'kvrohit/mellow.nvim' },
  { 'terryma/vim-multiple-cursors' }
}
