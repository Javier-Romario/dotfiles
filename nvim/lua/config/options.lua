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

vim.cmd("set foldmethod=manual")

vim.cmd[[ set wrap ]]
vim.cmd [[ set cc=80 ]]


-- vim.cmd [[highlight WinBar1 guifg=#00F8BE guibg=NONE]]
-- vim.cmd [[highlight WinBar2 guifg=#00F8BE guibg=NONE]]
-- Function to get the full path and replace the home directory with ~
-- local function get_winbar_path()
--   local full_path = vim.fn.expand("%:p")
--   return full_path:gsub(vim.fn.expand("$HOME"), "~")
-- end

-- Function to get the number of open buffers using the :ls command
-- local function get_buffer_count()
--   local buffers = vim.fn.execute("ls")
--   local count = 0
--   -- Match only lines that represent buffers, typically starting with a number followed by a space
--   for line in string.gmatch(buffers, "[^\r\n]+") do
--     if string.match(line, "^%s*%d+") then
--       count = count + 1
--     end
--   end
--   return count
-- end
-- -- Function to update the winbar
-- local function update_winbar()
--   local home_replaced = get_winbar_path()
--   local buffer_count = get_buffer_count()
--   vim.opt.winbar = "%#WinBar1#%m"
--     -- .. "%#WinBar2#("
--     .. buffer_count
--     -- .. ") "
--     -- .. "%#WinBar1#"
--     -- .. home_replaced
--     -- .. "%*%=%#WinBar2#"
--     -- .. vim.fn.systemlist("hostname")[1]
-- end
-- -- Autocmd to update the winbar on BufEnter and WinEnter events
-- vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
--   callback = update_winbar,
-- })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true }, })


vim.keymap.set("v", "<leader>e", function()
    -- Save current register and mode
  local original_reg = vim.fn.getreg('"')
  local original_mode = vim.fn.mode()

  -- Yank the selection into the default register (")
  vim.cmd('normal! ""y')

  -- Get the selected text
  local selected = vim.fn.getreg('"')

  -- Restore original register
  vim.fn.setreg('"', original_reg)

  ---@module 'snacks'
  Snacks.terminal('ig ' .. selected:gsub("\n", "\\n"))

  -- You can now do anything with selected_text
end, { desc = "Use visual selection", silent = true })


-- vimdiff fixes
vim.cmd([[
  augroup diffcolors
      autocmd!
      autocmd Colorscheme * call s:SetDiffHighlights()
  augroup END

  function! s:SetDiffHighlights()
      if &background == "dark"
          highlight DiffAdd gui=bold guifg=none guibg=#2e4b2e
          highlight DiffDelete gui=bold guifg=none guibg=#4c1e15
          highlight DiffChange gui=bold guifg=none guibg=#45565c
          highlight DiffText gui=bold guifg=none guibg=#996d74
      else
          highlight DiffAdd gui=bold guifg=none guibg=palegreen
          highlight DiffDelete gui=bold guifg=none guibg=tomato
          highlight DiffChange gui=bold guifg=none guibg=lightblue
          highlight DiffText gui=bold guifg=none guibg=lightpink
      endif
  endfunction
]])
