-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.swapfile = false
vim.opt.relativenumber = false
vim.opt.conceallevel = 2
-- Enable LazyVim auto format
vim.g.autoformat = false

local opt = vim.opt

if not vim.env.SSH_TTY then
  -- only set clipboard if not in ssh, to make sure the OSC 52
  -- integration works automatically. Requires Neovim >= 0.10.0
  opt.clipboard = "unnamedplus" -- Sync with system clipboard
end

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

if not vim.g.vscode then
  opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
end
opt.wildmode = "longest:full,full" -- Command-line completion mode

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- vim.cmd([[
--   nnoremap : q:i
-- ]])

--
-- vim.cmd("hi! link MiniIndentscopeSymbol field")

