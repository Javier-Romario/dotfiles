        -- colors = function(colors) end,
        on_highlights = function(hl, c)
          local prompt = "#2d3149"
          local cyberPink = "#ee2082"
          -- local lightPink = "#DBB2E5"
          local teal = "#08d1c0"
          -- local purp = "#bca9e1"
          -- local orange = "#ff757f"
          local cyberOrange = "#fd8090"
          local cyberGreen = "#65dc98"
          local lightBlue = "#c4ffff"

          -- hl["@parameter"] = {
          --   fg = orange,
          --   bg = "",
          -- }
          --
          -- hl["@field"] = {
          --   fg = cyberRed,
          --   bg = prompt,
          -- }
          --
          -- hl["@function"] = {
          --   fg = cyberRed,
          --   bg = "",
          -- }
          --
          hl["Function"] = {
            fg = cyberPink,
            bg = "",
          }
          --
          hl["@function.call"] = {
            fg = cyberPink,
            bg = "",
          }
          --
          hl["@function.method"] = {
            fg = cyberPink,
            bg = prompt,
          }

          hl["@tag"] = {
            fg = lightBlue,
          }

          hl["Tag"] = {
            fg = lightBlue,
          }

          hl["@type"] = {
            fg = cyberOrange,
            bg = "",
          }

          hl["@type.tsx"] = {
            fg = cyberOrange,
            bg = "",
          }

          hl["Type"] = {
            fg = cyberOrange,
            bg = "",
          }

          hl["@constructor"] = {
            fg = cyberGreen,
          }
          -- hl["@function.builtin"] = {
          --   fg = cyberRed,
          --   bg = "",
          -- }
          -- hl["@constant.builtin"] = {
          --   fg = teal,
          --   bg = "",
          -- }
          --
          -- hl["@property"] = {
          --   fg = cyberRed,
          --   bg = "",
          -- }
          --
          hl["@variable"] = {
            fg = teal,
            bg = prompt,
          }

          hl["@lsp.type.variable"] = {
            fg = teal,
            bg = prompt,
          }
          --
          -- hl["@method"] = {
          --   fg = cyberRed,
          --   bg = "",
          -- }
          --
          -- hl["@method.call"] = {
          --   fg = teal,
          --   bg = "",
          -- }
          --
          -- hl["@lsp.type.method"] = {
          --   fg = cyberRed,
          --   bg = prompt,
          -- }
          --
          hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopePromptNormal = {
            bg = prompt,
          }
          hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end,
