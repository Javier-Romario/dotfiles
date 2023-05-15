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
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Terminal",
-- [";"] = { ":ToggleTerm --height=8<CR>", "Terminal" },
-- n = { ":TermExec cmd='node<CR>'", "Node" },
-- f = { ":ToggleTerm bpython<CR>", "bpython" },
-- t = { ":ToggleTerm<CR>", "Toggle" },
-- }

lvim.builtin.which_key.mappings["gB"] = {
  "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle Git Blame"
}

lvim.builtin.which_key.mappings['B'] = {
  name = '+Aerial',
  t = {'<cmd>AerialToggle<CR>', '+AerialToggle'}
}
lvim.builtin.which_key.mappings['U'] = {
  name = "+UndoTree",
  t = {"<cmd>UndotreeToggle<CR>", "+UndoTree Toggle"}
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

lvim.builtin.which_key.mappings['ld'] = {
  "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy layout_strategy=vertical<cr>",
  "Buffer Diagnostics"
}

-- lvim.builtin.which_key.mappings['F'] = {
--   name = '+fzf',
--   f = { ':Rg<CR>', "Find word" }
-- }

-- Normal --
-- Better window navigation
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)

function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
