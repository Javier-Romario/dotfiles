require("toggleterm").setup({
  direction = 'vertical',
  winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
})
