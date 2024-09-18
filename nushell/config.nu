let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # carapace completions are incorrect for nu
        nu => $fish_completer
        # fish completes commits and branch names in a nicer way
        git => $fish_completer
        # carapace doesn't have completions for asdf
        asdf => $fish_completer
        # use zoxide completions for zoxide commands
        __zoxide_z => $zoxide_completer
        __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
  edit_mode: vi,
  show_banner: false # true or false to enable or disable the welcome banner at startup

  rm: {
    always_trash: false # always act as if -t was given. Can be overridden with -p
  }

  cursor_shape: {
    emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
    vi_insert: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
    vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
  }

  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true    # set this to false to prevent auto-selecting completions when only one remains
    partial: true    # set this to false to prevent partial filling of the prompt
    algorithm: "fuzzy"    # prefix or fuzzy
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: $external_completer # check 'carapace_completer' above as an example
    }
  }

  use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this

  menus: [
    # Configuration for default nushell menus
    # Note the lack of source parameter
    {
      name: completion_menu
      only_buffer_difference: false
      marker: "| "
      type: {
        layout: columnar
        columns: 4
        col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2
      }
      style: {
        text: { fg: "#00F8BE" } #green
        selected_text: { fg: "#202020"   bg: "#00F8BE" attribute: b }
        description_text: yellow
      }
    }
    {
      name: history_menu
      only_buffer_difference: true
      marker: "? "
      type: {
        layout: list
        page_size: 10
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
    {
      name: help_menu
      only_buffer_difference: true
      marker: "? "
      type: {
        layout: description
        columns: 4
        col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2
        selection_rows: 4
        description_rows: 10
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
  ]
  keybindings: [
    {
      name: fuzzy_file
      modifier: alt
      keycode: char_t
      mode: [vi_insert vi_normal]
      event: {
        send: executehostcommand
        cmd: "commandline edit --insert (fzf --layout=reverse)"
      }
    }
  ]
}

$env.FZF_DEFAULT_OPTS = "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

source ~/.config/nushell/extend.nu
