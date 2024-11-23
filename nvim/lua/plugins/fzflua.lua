return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>fx", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Fzflua Files" },
      { "<leader>fl", "<cmd>lua require('fzf-lua').lines()<CR>", desc = "Fzflua Lines" },
      { "<leader>flg", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "Fzflua Grep" },
    },
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        defaults = { formatter = "path.filename_first" },
        winopts = {
          preview = {
            vertical       = 'down:55%',
            wrap           = 'wrap',
            layout         = 'vertical',
          },
        },
        grep = {
          rg_glob = true,        -- enable glob parsing by default to all
          -- grep providers? (default:false)
          glob_flag = "--iglob",  -- for case sensitive globs use '--glob'
          glob_separator  = "%s%-%-",    -- query separator pattern (lua): ' --'
          resume = true,
        },
        files = {
          -- path_shorten = 10,
          find_opts         = [[--color=always -type d -type f -not -path '*/\.git/*' -printf '%P\n']],
          rg_opts           = [[--files --hidden --follow -g "!.git"]],
          formatter="path.filename_first",
          -- fd_opts = [[fd --color=never --type f --hidden --follow --exclude .git -x printf "{/} %s {}\n"]],
        },
      })
    end
  }
}
