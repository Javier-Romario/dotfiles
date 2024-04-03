return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_restore_session = false,
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    })
  end,
  keys = {
    { "<leader>Sr", "<cmd>SessionRestore<cr>", desc = "Restore Session" },
    { "<leader>Sl", "<cmd>SessionLast<cr>", desc = "Restore Last Session" },
    { "<leader>Ss", "<cmd>SessionSave<cr>", desc = "Save Session" },
  },
}
