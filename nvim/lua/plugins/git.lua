return {
  {
    'sindrets/diffview.nvim',
    -- lazy = true,
  },
  {
    'https://github.com/tpope/vim-fugitive',
    -- lazy = true
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.cmd [[ let g:lazygit_use_custom_config_file_path = 0 " config file path is evaluated if this value is 1 ]]

      vim.cmd[[ let g:lazygit_config_file_path = '~/.config/lazygit/config.yml' " custom config file path ]]
    end
  },
}
