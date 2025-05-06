test ! -e "$HOME/.x-cmd.root/local/data/fish/rc.fish" || source "$HOME/.x-cmd.root/local/data/fish/rc.fish" # boot up x-cmd.
alias bt="bat"

abbr --add clearar clear
abbr --add gP "git push"
abbr -a --set-cursor=! -- fff fd\ !\ \|\ fzf \ -m \| \ xargs\ lvim\ -o
abbr -a llama --position anywhere --set-cursor "ollama run llama2 \"%\""
abbr -a codellama --position anywhere --set-cursor "ollama run codellama \"%\""
abbr -a odcf "z odc-front"
abbr -a odcb "z odc-back"

abbr -a nvst --position anywhere --set-cursor "nv (rg -l '%')"
abbr -a nvmst --position anywhere --set-cursor "nv -o (rg -l '%')"
abbr -a nvmp --position anywhere --set-cursor "nv -p (rg -l '%')"


# specific for SPR app that im developing IN RUST BTW
abbr -a killSPR 'kill -9 (procs --no-header spr | awk \'{print $1}\')'

abbr !! --position anywhere --function last_history_item

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

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish


# Added by Windsurf
fish_add_path /Users/javierbsg/.codeium/windsurf/bin
