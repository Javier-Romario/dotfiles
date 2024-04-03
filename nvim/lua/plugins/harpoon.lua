return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})

      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end
    end,
    keys = {
      -- { '<Leader>ua', 'ga', desc = 'Show character under cursor' },
      {
        "<leader>ha",
        function()
          require("harpoon"):list():append()
        end,
        desc = "Add location",
      },
      {
        "<leader>hn",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Next location",
      },
      {
        "<leader>hp",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Previous location",
      },
      {
        "<leader>hr",
        function()
          require("harpoon"):list():remove()
        end,
        desc = "Remove location",
      },
      {
        "<leader>h1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon select 1",
      },
      {
        "<leader>h2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon select 2",
      },
      {
        "<leader>h3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon select 3",
      },
      {
        "<leader>h4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon select 4",
      },
      {
        "<leader>hl",
        function()
          local harpoon = require("harpoon")
          if not LazyVim.has("telescope.nvim") then
            harpoon.ui:toggle_quick_menu(harpoon:list())
            return
          end
          return require("telescope._extensions.marks")()
        end,
        desc = "Harpoon locations",
      },
    },
    opt = {},
  },
}
