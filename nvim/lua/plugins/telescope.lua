return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",            -- Required dependency
    "nvim-telescope/telescope-fzy-native.nvim", -- Optional: FZY sorter for better performance
    "nvim-telescope/telescope-ui-select.nvim",  -- Optional: Improves UI for `vim.ui.select`
  },
  cmd = "Telescope", -- Lazy load on `:Telescope`
  config = function()
    -- Setup Telescope with dynamic vimgrep_arguments
    require("telescope").setup({
      defaults = {
        prompt_prefix = "> ", -- Icon for search prompt
        selection_caret = "➜ ", -- Icon for selection
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "bottom",
          horizontal = { preview_width = 0.6 }, -- Only apply preview_width here
          vertical = { width = 0.8 },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        },
        file_ignore_patterns = { "node_modules", "%.git/", "%.cache" }, -- Ignore unnecessary files
        mappings = {
          i = { -- Insert mode mappings
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-q>"] = "send_to_qflist",
            ["<CR>"] = "select_default",
          },
        },
      },
      pickers = { -- Customize default pickers
        find_files = {
          hidden = true, -- Include hidden files
        },
        live_grep = {
          only_sort_text = true,
        },
      },
      extensions = { -- Load extensions
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Load Telescope extensions
    require("telescope").load_extension("fzy_native")  -- enhances sorting performance in Telescope
    require("telescope").load_extension("ui-select")   -- replaces vim.ui.select with a Telescope-powered dropdown picker
  end,
}

