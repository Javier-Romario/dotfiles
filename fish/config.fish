alias bt="bat"

abbr --add clearar clear
abbr --add gP "git push"
abbr -a --set-cursor=! -- fff fd\ !\ \|\ fzf \ -m \| \ xargs\ lvim\ -o
abbr -a llama --position anywhere --set-cursor "ollama run llama2 \"%\""
abbr -a codellama --position anywhere --set-cursor "ollama run codellama \"%\""
abbr -a odcf "z odc-front"
abbr -a odcb "z odc-back"


# completions for brew
if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end
# end completions for brew

atuin init fish | source
zoxide init fish --cmd z | source
starship init fish | source
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx PATH "$HOME/.nvm" $PATH
