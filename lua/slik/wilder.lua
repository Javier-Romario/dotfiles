local wilder = require("wilder")
wilder.setup({ modes = { ':', '/', '?' } })
wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer({
    -- highlighter = wilder.lua_fzy_highlighter(),
    --     highlighter = wilder.basic_highlighter(),
    -- pumblend = 20,
    left = {
      ' ',
      wilder.popupmenu_devicons()
    },
    right = {
      ' ',
      wilder.popupmenu_scrollbar()
    },
  }),
  ['/'] = wilder.wildmenu_renderer({
    highlighter = wilder.basic_highlighter(),
  }),
}))
