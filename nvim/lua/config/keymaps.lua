-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- inc and dec numbers
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)

-- Deleting default keymaps
-- windows
vim.keymap.del("n", "<leader>ww")
vim.keymap.del("n", "<leader>wd")
vim.keymap.del("n", "<leader>w-")
vim.keymap.del("n", "<leader>w|")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")
--

-- SAVE!
local saveOpts = { noremap = true, silent = true, desc = "+Save" }
keymap.set({ "n" }, "<leader>w", ":w<CR>", saveOpts)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- CMD magic
keymap.set("n", "Q", "!!sh<CR>", opts)

keymap.set("n", "<leader>R", ":lua vim.lsp.codelens.run()<CR>", {})

keymap.set("n", "<leader>e", ":Oil --float<CR>", {})
