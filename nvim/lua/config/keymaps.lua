-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- inc and dec numbers
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)

-- SAVE!
local saveOpts = { noremap = true, silent = true, desc = "+Save" }
keymap.set({ "n" }, "<leader>w", ":w<CR>", saveOpts)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- CMD magic
keymap.set("n", "Q", "!!sh<CR>", opts)

keymap.set("n", "<leader>R", ":lua vim.lsp.codelens.run()<CR>", { desc = "Open yazi nvim"})

-- keymap.set("n", "<leader>e", "<cmd>Oil --float<CR>", {})
keymap.set("n", "<leader>e", function() require("yazi").yazi() end, {})

keymap.set(
  {"n","v"},
  "<leader>a",
  ":'<,'>!xargs -I {} rg -n {}<CR>",
  opts
)


keymap.set(
  {"n","v"},
  "<leader>A",
  function()
    -- Yank the word
    vim.cmd('normal! yw')
    -- Open a new line below and paste
    vim.cmd('normal! o')
    vim.cmd('normal! p')
    vim.cmd('normal! _')
    -- Visually select the word
    vim.cmd('normal! V')
    -- vim.cmd('vi <leader>a<CR>')
    -- Run the rg command on the selected text
    -- local selected_text = vim.fn.getreg('"')
    -- vim.cmd('!' .. 'rg -n ' .. vim.fn.shellescape(selected_text))
  end,
  --  "ywop_vw<Esc><cmd>'<,'>!xargs -I {} rg -n {}<CR>",
  {noremap = false, silent = true}
)


keymap.set({"n", "v"}, "<S-h>", "<cmd>FzfLua buffers<CR>")
keymap.set({"n", "v"}, "<S-l>", "<cmd>FzfLua buffers<CR>")


keymap.set({"n","v"}, "<C-M-/>", function()
  Snacks.terminal(nil, { win = { position = "float" } })
end)

-- keymap(
--     "n",
--     "<c-o>",
--     require("rustowl").rustowl_cursor,
--     { noremap = true, silent = true }
-- )
