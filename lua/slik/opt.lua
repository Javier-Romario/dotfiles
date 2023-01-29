vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.cursorline = true
vim.opt.laststatus = 3

-- Configure the appearance
-- -- vim.g.mellow_italic_functions = true
vim.g.mellow_bold_functions = true
vim.g.mellow_italic_variables = true


vim.diagnostic.config({
  virtual_text = {
    source = 'always',
    prefix = '■',
    -- Only show virtual text matching the given severity
    severity = {
      -- Specify a range of severities
      min = vim.diagnostic.severity.ERROR,
    },
  },
  float = {
    source = 'always',
    border = 'rounded',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})



local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  wildignorecase = true,
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  swapfile = false, -- creates a swapfile
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  laststatus = 3,
  showcmd = false,
  ruler = false,
  expandtab = true, -- convert tabs to spaces
}
for k, v in pairs(options) do
  vim.opt[k] = v
end
