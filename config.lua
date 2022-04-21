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

--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "material"
lvim.builtin.dap.active = true
lvim.transparent_window = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

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
-- vim.opt.cursorline = true
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":RG<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }
lvim.keys.normal_mode["Q"] = "!!sh<CR>"
lvim.builtin.which_key.mappings['r'] = {
   name = "+Floaterm",
   [";"] = {":FloatermToggle --height=8<CR>", "Terminal"},
   n = {":FloatermNew node<CR>", "Node"},
   f = {":FloatermNew bpython<CR>", "bpython"},
   t = {":FloatermToggle<CR>", "Toggle"},
}
lvim.builtin.which_key.mappings['n'] = {
  name = '+symbols-outline',
  o = {":SymbolsOutlineOpen<CR>", "SymbolsOutlineOpen"},
  c = {":SymbolsOutlineClose<CR>"},
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
  f = {':Rg<CR>', "Find word"}
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
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

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }
lvim.plugins = {
  {'iamcco/markdown-preview.nvim', run = "cd app && yarn"},
  {'unblevable/quick-scope', config = function()
    vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
    vim.cmd[[
      highlight QuickScopePrimary guifg=#ABFAD7 guibg=NONE gui=underline ctermbg=155 cterm=underline
      highlight QuickScopeSecondary guifg=#ABFAFA guibg=NONE gui=underline ctermbg=133 cterm=underline
    ]]
  end},
    {'simrat39/symbols-outline.nvim'},
    {"folke/tokyonight.nvim"},
    {'wellle/targets.vim'},
    {'luochen1990/rainbow', config = function ()
      vim.g.rainbow_active = 1
    end},
    {'gelguy/wilder.nvim', config = function()
        -- vim.cmd[[call wilder#setup({'modes': [':', '/', '?']})]]
    end},
    {'jwalton512/vim-blade'},
    -- {'hzchirs/vim-material', config = function ()
    --   vim.g.material_style = 'dark'
    -- end},
    {'voldikss/vim-floaterm', config = function ()
    end, setup = {
      vim.cmd("let g:floaterm_wintype = 'split'")
    }},
    {'metakirby5/codi.vim'},
   { "tpope/vim-surround", ['keys'] = {"c", "d", "y"} },
  {'mattn/emmet-vim'},

    {'junegunn/fzf', config = function()
      local fz = {}
      fz['ctrl-t'] = 'tab split'
      fz['ctrl-x'] = 'split'
      fz['ctrl-v'] = 'vsplit'
      vim.g.fzf_action = fz

      local fzLay = {}
      fzLay['up']= '~100%'
      local window = {}
      window['width'] = 0.8
      window['height'] = 0.8
      window['yoffset'] = 0.5
      window['xoffset']= 0.5
      window['border'] = 'sharp'
      fzLay['window'] = window
      vim.g.fzf_layout = fzLay
      vim.g.fzf_tags_command = 'ctags -R'
      -- let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"
      -- vim.cmd"command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)"
      -- vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden -g {!.git/**,!build/**,!.dart_tool/**,!.idea}"
  end, setup = {}},
    {'junegunn/fzf.vim'},
  {'theHamsta/nvim-dap-virtual-text'},
  {'rcarriga/nvim-dap-ui'},
  {'folke/twilight.nvim', config = function()
    require("twilight").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end},
  { "marko-cerovac/material.nvim", config = function() 
    vim.g.material_style = "darker"
  end },
  {"stevearc/aerial.nvim", config = function()
  end}
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }


--FZF
-- vim.g.fzf_preview_window = {"down:65%", "ctrl-/",}
-- RG
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

lvim.builtin.dashboard.custom_header = {
}

require("luasnip.loaders.from_vscode").load()

lvim.builtin.lualine.options.component_separators = { left = "", right = ""}
lvim.builtin.lualine.options.section_separators = { left = "", right = ""}
lvim.builtin.lualine.sections.lualine_a = {"mode"}
lvim.builtin.lualine.sections.lualine_x = {"location"}
lvim.builtin.lualine.sections.lualine_y = {"diff", "buffers", "filesize"}
vim.cmd[[
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
  inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
]]

-- DEBUGGING
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/Programming/vscode-node-debug2/out/src/nodeDebug.js'},
  }
  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/Programming/vscode-chrome-debug/out/src/chromeDebug.js"}
  }

  dap.configurations.javascript = { -- change this to javascript if needed
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
  vim.fn.sign_define('DapBreakpoint', {text='🕷' , texthl='' , linehl='', numhl=''})

  -- Dap virtual text
  vim.cmd[[let g:dap_virtual_text = v:true]]
  -- Dap UI
  require('dapui').setup()
end

require('material').setup({
	lualine_style = 'stealth' -- the stealth style
})
require('aerial').setup({})

local wilder = require("wilder")
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer({
    -- highlighter = wilder.lua_fzy_highlighter(),
    highlighter = wilder.basic_highlighter(),
    pumblend = 20,
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

