local function pick_color()
  local colors = { "String", "Identifier", "Keyword", "Number" }
  return colors[math.random(#colors)]
end

-- Yay I made my first Lua function!
local function footer()
  local handle = io.popen('date +%U')
  local result = handle:read("*a")
  handle:close()
  return 'It is week ' .. result .. 'of 52'
end

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
lvim.builtin.dap.active = true
lvim.transparent_window = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.autopairs.active = false
-- lvim.builtin.treesitter.rainbow.enable = true

-- lvim.builtin.autopairs.disable_filetype = {
--   "*"
-- }


lvim.builtin.alpha.dashboard.section.header.val = {
  "                         _/  _/  _/                  _/                  _/  _/   ",
  "                _/_/_/  _/      _/  _/      _/_/_/  _/_/_/      _/_/    _/  _/    ",
  "             _/_/      _/  _/  _/_/      _/_/      _/    _/  _/_/_/_/  _/  _/     ",
  "                _/_/  _/  _/  _/  _/        _/_/  _/    _/  _/        _/  _/      ",
  "           _/_/_/    _/  _/  _/    _/  _/_/_/    _/    _/    _/_/_/  _/  _/       ",
}
lvim.builtin.alpha.dashboard.section.header.opts.hl = pick_color()
lvim.builtin.alpha.dashboard.section.footer.val = footer()


lvim.builtin.treesitter.rainbow = {
  enable = true,
  extended_mode = true,
  max_file_lines = 1000,
  colors = {
    "#f7768e",
    "#9ece6a",
    "#e0af68",
    "#7aa2f7",
    "#bb9af7",
    "#7dcfff",
  },
}

vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.wildignorecase = true
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.cursorline = true
vim.opt.laststatus = 3
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
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

lvim.keys.normal_mode["Q"] = "!!sh<CR>"
lvim.builtin.which_key.mappings['r'] = {
  name = "+Floaterm",
  [";"] = { ":FloatermToggle --height=8<CR>", "Terminal" },
  n = { ":FloatermNew node<CR>", "Node" },
  f = { ":FloatermNew bpython<CR>", "bpython" },
  t = { ":FloatermToggle<CR>", "Toggle" },
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
lvim.builtin.which_key.mappings['dT'] = {
  -- Dap UI
  ":lua require('dapui').toggle()<CR>", "UI Toggle"
}

lvim.builtin.which_key.mappings['F'] = {
  name = '+fzf',
  f = { ':Rg<CR>', "Find word" }
}

local gheight = vim.api.nvim_list_uis()[1].height
local gwidth = vim.api.nvim_list_uis()[1].width
local width = 70
local height = 50
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.float = {
  enable = true,
  open_win_config = {
    relative = "editor",
    width = width,
    height = height,
    row = (gheight - height) * 0.5,
    col = (gwidth - width) * 0.5
  }
}

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  --   { command = "black", filetypes = { "python" } },
  --   { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100", '--config-precedence', 'prefer-file' },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
}

lvim.plugins = {
  -- Requires Nvim 0.7
  -- { 'bennypowers/nvim-regexplainer',
  --     config = function() require'regexplainer'.setup() end,
  --     requires = {
  --       'nvim-treesitter/nvim-treesitter',
  --       'MunifTanjim/nui.nvim',
  --     } },
  { 'mbbill/undotree' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'kaputi/e-kaput.nvim' },
  { 'ldelossa/buffertag' },
  { 'yonlu/omni.vim' },
  { 'iamcco/markdown-preview.nvim', run = "cd app && yarn" },
  { 'unblevable/quick-scope', config = function()
    vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
  end },
  { 'simrat39/symbols-outline.nvim' },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },
  { 'wellle/targets.vim' },
  { 'luochen1990/rainbow', config = function()
    vim.g.rainbow_active = 1
  end },
  { 'gelguy/wilder.nvim', config = function()
    -- vim.cmd[[call wilder#setup({'modes': [':', '/', '?']})]]
  end },
  { 'jwalton512/vim-blade' },
  { 'voldikss/vim-floaterm', config = function()
  end, setup = {
    vim.cmd("let g:floaterm_wintype = 'split'")
  } },
  { 'metakirby5/codi.vim' },
  { "tpope/vim-surround", ['keys'] = { "c", "d", "y" } },
  { 'mattn/emmet-vim' },
  { 'junegunn/fzf', config = function()
    local fz = {}
    fz['ctrl-t'] = 'tab split'
    fz['ctrl-x'] = 'split'
    fz['ctrl-v'] = 'vsplit'
    vim.g.fzf_action = fz

    local fzLay = {}
    fzLay['up'] = '~100%'
    local window = {}
    window['width'] = 0.8
    window['height'] = 0.8
    window['yoffset'] = 0.5
    window['xoffset'] = 0.5
    window['border'] = 'sharp'
    fzLay['window'] = window
    vim.g.fzf_layout = fzLay
    vim.g.fzf_tags_command = 'ctags -R'
    -- let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"
    -- vim.cmd"command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)"
    -- vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden -g {!.git/**,!build/**,!.dart_tool/**,!.idea}"
  end, setup = {} },
  { 'junegunn/fzf.vim' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'rcarriga/nvim-dap-ui' },
  { 'folke/twilight.nvim', config = function()
    require("twilight").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end },
  { "marko-cerovac/material.nvim", config = function()
    vim.g.material_style = "deep ocean"
  end },
  { "stevearc/aerial.nvim", config = function()
  end },
  { "rafamadriz/neon", config = function()
    vim.g.neon_style = "doom"
    vim.g.neon_italic_keyword = true
    vim.g.neon_italic_function = true
    vim.g.neon_transparent = true

    -- -- vim.cmd [[colorscheme neon]]
  end },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  { 'simrat39/rust-tools.nvim' },
  { 'kvrohit/mellow.nvim' },
  { 'terryma/vim-multiple-cursors' }
}

vim.cmd [[
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -g "!*.lock" -g "!.git/**" -g "!node_modules" -g "!build/**" -g "!plugins/**"  -g "!deploy/**" -g "!mu-plugins/**" -- %s || true'
  let initial_command = printf(command_fmt, a:query)
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--delimiter', '/', '--with-nth', '-1','--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]]

require("luasnip.loaders.from_vscode").load()

lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_x = { "location" }
lvim.builtin.lualine.sections.lualine_y = { "diff", "filesize" }
lvim.builtin.lualine.options.theme = 'material'
lvim.builtin.lualine.options.globalstatus = true


vim.cmd [[
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
  inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
]]

-- DEBUGGING
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/Programming/vscode-node-debug2/out/src/nodeDebug.js' },
  }
  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/Programming/vscode-chrome-debug/out/src/chromeDebug.js" }
  }

  dap.configurations.javascript = { -- change this to javascript if needed
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require 'dap.utils'.pick_process,
    },
    -- {
    --     type = "chrome",
    --     request = "attach",
    --     program = "${file}",
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = "inspector",
    --     port = 9229,
    --     webRoot = "${workspaceFolder}"
    -- }
  }
  dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }

  dap.configurations.typescriptreact = { -- change to typescript if needed
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }
  dap.configurations.typescript = { -- change to typescript if needed
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }

  -- Dap virtual text
  vim.cmd [[let g:dap_virtual_text = v:true]]
  -- Dap UI
  require('dapui').setup({
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40, -- 40 columns
        position = "right",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    }
  })
end

require('material').setup({
  lualine_style = 'stealth', -- the stealth style
  -- bufferline_style = 'stealth'
})

require('aerial').setup({})

local wilder = require("wilder")
wilder.setup({ modes = { ':', '/', '?' } })
wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer({
    -- highlighter = wilder.lua_fzy_highlighter(),
    highlighter = wilder.basic_highlighter(),
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

vim.g.material_style = "oceanic"

require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/snippets/vscode-es7-javascript-react-snippets" } }
require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/snippets/mySnippets" } }

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

require('e-kaput').setup({})

vim.api.nvim_set_option("foldmethod", "expr")
vim.api.nvim_set_option("foldexpr", "nvim_treesitter#foldexpr()")

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- Configure the appearance
-- vim.g.mellow_italic_functions = true
vim.g.mellow_bold_functions = true
vim.g.mellow_italic_variables = true

require('tokyonight').setup({
  style = 'night',
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = false, standout = false, bold = true },
    variables = { italic = true, standout = false },
    floats = "dark",
  },
  lualine_bold = true,
})
