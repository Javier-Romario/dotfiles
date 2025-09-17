return {
  -- {
  --   "ecthelionvi/NeoComposer.nvim",
  --   dependencies = { "kkharji/sqlite.lua" },
  --   opts = {
  --     keymaps = {
  --       play_macro = "<ctrl-R>",
  --       yank_macro = "yq",
  --       stop_macro = "cq",
  --       toggle_record = "q",
  --       cycle_next = "<c-n>",
  --       cycle_prev = "<c-p>",
  --       toggle_macro_menu = "<m-q>",
  --     }
  --   }
  -- },
  -- lazy.nvim
  {
    "chrisgrieser/nvim-recorder",
    enabled = false,
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        switchSlot = "<C-q>",
        editMacro = "cq",
        deleteAllMacros = "dq",
        yankMacro = "yq",
        -- ⚠️ this should be a string you don't use in insert mode during a macro
        addBreakPoint = "##",
      },
    }, -- required even with default settings, since it calls `setup()`
  },
}
