require "luasnip/loaders/from_vscode".load { paths = { "~/.config/lvim/snippets/vscode-es7-javascript-react-snippets" } }
require "luasnip/loaders/from_vscode".load { paths = { "~/.config/lvim/snippets/mySnippets" } }


-- Setup to html works on jsx, tsx files
require('luasnip').filetype_extend("javascriptreact", { "html" })
require('luasnip').filetype_extend("typescriptreact", { "html" })
