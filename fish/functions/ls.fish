function ls --wraps='eza -G' --wraps='eza -Ga' --description 'alias ls=eza -G'
    eza -1xa --group-directories-first --icons --follow-symlinks $argv
end
