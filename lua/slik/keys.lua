-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":RG<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader>y"] = "\"+y"

-- unmap a default keymapping
lvim.keys.normal_mode["y"] = false
lvim.keys.normal_mode["d"] = false
lvim.builtin.which_key.mappings["t"] = {
  name = "+Floaterm",
  [";"] = { ":FloatermToggle --height=8<CR>", "Terminal" },
  n = { ":FloatermNew node<CR>", "Node" },
  f = { ":FloatermNew bpython<CR>", "bpython" },
  t = { ":FloatermToggle<CR>", "Toggle" },
}

lvim.keys.normal_mode["Q"] = "!!sh<CR>"
lvim.builtin.which_key.mappings['r'] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },

}
lvim.builtin.which_key.mappings['n'] = {
  name = '+symbols-outline',
  o = { ":SymbolsOutlineOpen<CR>", "SymbolsOutlineOpen" },
  c = { ":SymbolsOutlineClose<CR>" },
}

lvim.builtin.which_key.mappings["dS"] = {
  ":lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", "scopes"
}
lvim.builtin.which_key.mappings["dU"] = {
  ":lua require'dap'.up()<CR>", "Up"
}
lvim.builtin.which_key.mappings["dD"] = {
  ":lua require'dap'.down()<CR>", "Down"
}
lvim.builtin.which_key.mappings['dT'] = { -- Dap UI
  ":lua require('dapui').toggle()<CR>", "UI Toggle"
}

lvim.builtin.which_key.mappings['F'] = {
  name = '+fzf',
  f = { ':Rg<CR>', "Find word" }
}
