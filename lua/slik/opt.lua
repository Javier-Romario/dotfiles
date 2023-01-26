vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.wildignorecase = true
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
