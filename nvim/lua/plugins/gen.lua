return {
  {
    "David-Kunz/gen.nvim",
    keys = {
      { "<leader>ga", ":Gen<CR>", desc = "Ollama Generate", mode = { "n", "v" } }, -- This Works
      -- { "<leader>ga", "<cmd>Gen<CR>", desc = "Ollama Generate", mode = { "n", "v" } }, -- This does NOT Work
      -- { "<leader>ga", "Gen<CR>", desc = "Ollama Generate", mode = { "n", "v" } }, -- This does NOT Work
    },
    config = function(_, _)
      -- vim.keymap.set("n", "<leader>ga", ":Gen<CR>", { silent = true }) -- This Works
      -- vim.keymap.set("v", "<leader>ga", ":Gen<CR>", { silent = true }) -- This Works
      require("gen").model = "dolphin-mistral"
    end,
  },

}
