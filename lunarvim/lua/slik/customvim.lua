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


vim.cmd [[
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
  inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
]]

