return {
  {
    'Vigemus/iron.nvim',
    opts = function(_, _)
      local iron = require("iron.core")

      iron.setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" }
            }
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').bottom(40),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_until_cursor = "<space>su",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      -- iron also has a list of commands, see :h iron-commands for all available commands
    end,
    keys = {
      { mode = { "n" }, '<space>rs', ':IronRepl<cr>',    desc = 'Start repl' },
      { mode = { 'n' }, '<space>rr', ':IronRestart<cr>', desc = 'Restart repl' },
      { mode = { 'n' }, '<space>rf', ':IronFocus<cr>',   desc = 'Focus' },
      { mode = { 'n' }, '<space>rh', ':IronHide<cr>',    desc = 'hide' },
    },
  }
}
