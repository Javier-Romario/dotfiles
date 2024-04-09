function ls --wraps='exa -G' --wraps='exa -Ga' --description 'alias ls=exa -G'
    eza -Ga --group-directories-first --icons $argv
end
