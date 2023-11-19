require('codeium').setup({
  config = function()
    -- vim.g.codeium_no_map_tab = 1
    vim.g.codeium_disable_bindings = 1
    -- Keymaps in codeium buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  end
})



