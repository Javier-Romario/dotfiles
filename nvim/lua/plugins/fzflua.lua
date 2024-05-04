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
      require("fzf-lua").setup({})
    end
  }
}
