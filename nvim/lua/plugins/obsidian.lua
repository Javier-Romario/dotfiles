return {
  {
    "epwalsh/obsidian.nvim",
    -- lazy = true,
    -- ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "obsidianv",
          path = "~/Notes",
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Day Notes/",
        date_format = "%d-%m-%Y",
      },
      templates = {
        subdir = "Templates",
        date_format = "%d-%m-%Y",
      },
    }
  },
}
